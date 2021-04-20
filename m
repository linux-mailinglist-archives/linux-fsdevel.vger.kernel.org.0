Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92503660AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 22:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhDTUNb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 16:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233619AbhDTUNb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:13:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FB8761029;
        Tue, 20 Apr 2021 20:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618949579;
        bh=+BUFCTXBAH0+tkzh9tCwvWGz1Hm44o2xsVlsE4x4Vzc=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=r8SUrLY4IMZG3yYUOGcqFlr8Uumysdb5B0I0dKQOZgxLAgSrPRVrAPeamIsy20cG/
         3Rq5+ljybjByJHjdIBcMg+gz1Qk3bzBmsX7DmqoF5uO6Sd0NJ+og31XXke93/2P7xJ
         r3jemLFBH8B3LzWtGIXST0WvvjCAcMiqMqG/bdZM/9v/05ibKjWubg5rndFl6m1FSh
         7iSFz36qUk+5Nw3zPcZ17U+Y8LTPBS0MsR8+SMPGau6d3tVEfcvAhSAgTk5Vn1xdqE
         kYMKzQFt0j6qE8xbg3qm7VQOyoNcz/2165Hmk4AQMCDfAqBVjU47hJ33wmyY5HEADD
         kyju2zKTs6Dqw==
Message-ID: <3675c1d23577dded6ca97e0be78c153ce3401e10.camel@kernel.org>
Subject: Re: [PATCH] mm/readahead: Handle ractl nr_pages being modified
From:   Jeff Layton <jlayton@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 20 Apr 2021 16:12:57 -0400
In-Reply-To: <20210420200116.3715790-1-willy@infradead.org>
References: <20210420200116.3715790-1-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-04-20 at 21:01 +0100, Matthew Wilcox (Oracle) wrote:
> The BUG_ON that checks whether the ractl is still in sync with the
> local variables can trigger under some fairly unusual circumstances.
> Remove the BUG_ON and resync the loop counter after every call to
> read_pages().
> 
> One way I've seen to trigger it is:
> 
>  - Start out with a partially populated range in the page cache
>  - Allocate some pages and run into an existing page
>  - Send the read request off to the filesystem
>  - The page we ran into is removed from the page cache
>  - readahead_expand() succeeds in expanding upwards
>  - Return to page_cache_ra_unbounded() and we hit the BUG_ON, as nr_pages
>    has been adjusted upwards.
> 
> Reported-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/readahead.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index f02dbebf1cef..989a8e710100 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -198,8 +198,6 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  	for (i = 0; i < nr_to_read; i++) {
>  		struct page *page = xa_load(&mapping->i_pages, index + i);
>  
> 
> 
> 
> -		BUG_ON(index + i != ractl->_index + ractl->_nr_pages);
> -
>  		if (page && !xa_is_value(page)) {
>  			/*
>  			 * Page already present?  Kick off the current batch
> @@ -210,6 +208,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  			 * not worth getting one just for that.
>  			 */
>  			read_pages(ractl, &page_pool, true);
> +			i = ractl->_index + ractl->_nr_pages - index;
>  			continue;
>  		}
>  
> 
> 
> 
> @@ -223,6 +222,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  					gfp_mask) < 0) {
>  			put_page(page);
>  			read_pages(ractl, &page_pool, true);
> +			i = ractl->_index + ractl->_nr_pages - index;
>  			continue;
>  		}
>  		if (i == nr_to_read - lookahead_size)

Thanks Willy, but I think this may not be quite right. A kernel with
this patch failed to boot for me:

[  OK  ] Reached target Basic System.
[   17.431421] virtio_net virtio1 enp1s0: renamed from eth0
[   17.453001] page:00000000d076b336 refcount:2 mapcount:0 mapping:00000000fa98b961 index:0x4 pfn:0x100ff8
[   17.454762] memcg:ffff888115934000
[   17.455337] aops:def_blk_aops ino:fc00000
[   17.456163] flags: 0x17ffffc0020014(uptodate|lru|mappedtodisk)
[   17.457239] raw: 0017ffffc0020014 ffffea0004030048 ffffea0004045f08 ffff8881064d95a0
[   17.458628] raw: 0000000000000004 0000000000000000 00000002ffffffff ffff888115934000
[   17.460032] page dumped because: VM_BUG_ON_PAGE(!PageLocked(page))
[   17.461149] ------------[ cut here ]------------
[   17.462070] kernel BUG at include/linux/pagemap.h:912!
[   17.463027] invalid opcode: 0000 [#1] SMP KASAN NOPTI
[   17.463881] CPU: 15 PID: 491 Comm: systemd-udevd Tainted: G            E   T 5.12.0-rc4+ #96
[   17.465205] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2.fc34 04/01/2014
[   17.466549] RIP: 0010:mpage_readahead+0x39e/0x3e0
[   17.472766] Code: f6 fe ff ff a8 01 48 c7 c6 c0 cf b8 a9 4c 0f 45 e2 4c 89 e7 e8 a3 9f e7 ff 0f 0b 48 c7 c6 00 d1 b8 a9 4c 89 e7 e8 92 9f e7 ff <0f> 0b 48 c7 c6 20 cf b8 a9 4c 89 e7 e8 81 9f e7 ff 0f 0b 48 c7 c6
[   17.472772] RSP: 0018:ffff8881202c7718 EFLAGS: 00010292
[   17.472777] RAX: 0000000000000000 RBX: ffff8881202c7b50 RCX: 0000000000000000
[   17.472781] RDX: 1ffff110840bd851 RSI: 0000000000000008 RDI: ffffed1024058e80
[   17.472784] RBP: ffffea000403fe08 R08: 0000000000000036 R09: ffff8884205f57a7
[   17.472787] R10: ffffed10840beaf4 R11: 0000000000000001 R12: ffffea000403fe00
[   17.472790] R13: ffff8881202c7b70 R14: ffff8881202c7b74 R15: ffffea000403fe00
[   17.522835] FS:  00007f15cb4c2380(0000) GS:ffff888420400000(0000) knlGS:0000000000000000
[   17.522841] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.522845] CR2: 00007f15cb46e000 CR3: 00000001202e0000 CR4: 00000000003506e0
[   17.522850] Call Trace:
[   17.522856]  ? do_mpage_readpage+0xd80/0xd80
[   17.522873]  ? bdev_disk_changed+0x1d0/0x1d0
[   17.557948]  ? lock_release+0x1e1/0x6b0
[   17.557958]  ? lock_downgrade+0x360/0x360
[   17.557964]  read_pages+0x115/0x3e0
[   17.557972]  ? readahead_expand+0x3a0/0x3a0
[   17.557978]  ? __xa_clear_mark+0xc0/0xc0
[   17.557987]  page_cache_ra_unbounded+0x289/0x420
[   17.590717]  ? read_pages+0x3e0/0x3e0
[   17.590737]  force_page_cache_ra+0x1ae/0x230
[   17.590755]  filemap_get_pages+0x1bf/0xb20
[   17.606466]  ? copy_user_generic_string+0x2c/0x40
[   17.606476]  ? __lock_page_async+0x200/0x200
[   17.606480]  ? copyout+0x7e/0xa0
[   17.606489]  filemap_read+0x195/0x6d0
[   17.606497]  ? filemap_get_pages+0xb20/0xb20
[   17.631844]  ? kvm_sched_clock_read+0x14/0x30
[   17.631852]  ? sched_clock+0x5/0x10
[   17.631858]  ? sched_clock_cpu+0x18/0x110
[   17.631864]  ? __lock_acquire+0x88d/0x2cd0
[   17.631870]  ? generic_file_read_iter+0x3c/0x220
[   17.656724]  new_sync_read+0x257/0x360
[   17.661213]  ? __ia32_sys_llseek+0x1d0/0x1d0
[   17.665642]  ? __cond_resched+0x15/0x30
[   17.669896]  ? inode_security+0x6f/0x90
[   17.674187]  ? avc_policy_seqno+0x28/0x30
[   17.678458]  vfs_read+0x22b/0x290
[   17.682522]  ksys_read+0xb1/0x140



