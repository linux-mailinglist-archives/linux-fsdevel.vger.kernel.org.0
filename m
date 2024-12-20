Return-Path: <linux-fsdevel+bounces-37978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F769F99A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 19:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C07F7A1CFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 18:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C22E21D591;
	Fri, 20 Dec 2024 18:39:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-01.prod.sxb1.secureserver.net (sxb1plsmtpa01-01.prod.sxb1.secureserver.net [188.121.53.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF6D218EB9
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734719952; cv=none; b=I9LoLeZMNc8bjolFMZ8LGqpb5zCo3o/ofMP+unTu49Uy0hjXvROVcu8KaK6iEUD8xq3/totJTMHDMuSVi9hKTcXb7mtNrqlI/yocWyQ5Bq5mZEQ6udvs8uj0YZwA8+I3wCD9MVN+A8mDznzl09myfB/QiWZmOcnaRh0r6CSddPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734719952; c=relaxed/simple;
	bh=1PZnvdSfbK3qZVotvMrpIpsJI1nYf6dhrF35iffFT7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3uGnYwJSW2oZNsAqJRNYObN2Y4LU/YfeB162n3EkPxLQWpRwgAXz0OpahnY29JMGEJswUzpu//zJrfoGF+Ar6zkKyYsFW/Iqo0+wnxPfEw7uwcI9mUi/6drYbNdT0Tqm1cIhheIFbUcsqDyiB4BAOEzJB3GaI8MTwd+X42Gj8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id OhbQtcQ8mRnsQOhbStWBJE; Fri, 20 Dec 2024 11:19:58 -0700
X-CMAE-Analysis: v=2.4 cv=f5ayBPyM c=1 sm=1 tr=0 ts=6765b54f
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=JfrnYn6hAAAA:8 a=DKPZApLZDqOHnsDQJW4A:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <ac706104-4d78-4534-8542-706f88caa4b7@squashfs.org.uk>
Date: Fri, 20 Dec 2024 18:19:35 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] squashfs: Convert squashfs_fill_page() to take a
 folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
References: <20241216162701.57549-1-willy@infradead.org>
 <20241216162701.57549-5-willy@infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20241216162701.57549-5-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNcTyf8jYKeBCxLcKTab7DU7PTDVVyavpUOle166XJDcAICd1iTUBp5ga9xWuct18WvhCq4qBEu3T08dPQhVTIaXp3dkxCyCsN2/MTe7aaKGrvGOwkqN
 fZNkrtJwnR83/31AV3OOa6EVTbmAVD0VGVchVWTY9i930jSPV4whyf+CgNesyPFNN/24jBPB/vSpkFjaHmrtX8xMPzoJe9qnamgN+yRZr8YBYlvUUQDgTbxe
 1t3wscAX7GgjXaxaSsN0D6uBGURgU2uyhZphl01QyDyKNaKlf5ZWJFZgGEwN37kQF3YPGDv5wE0uBkxD+hiKpOfwFph76MqaOBZbVpe0mQ2WnunITS8ZtKr+
 l+gWTV9q



On 16/12/2024 16:26, Matthew Wilcox (Oracle) wrote:
> squashfs_fill_page is only used in this file, so make it static.
> Use kmap_local instead of kmap_atomic, and return a bool so that
> the caller can use folio_end_read() which saves an atomic operation
> over calling folio_mark_uptodate() followed by folio_unlock().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Hi Matthew,

Once the first oops is fixed, a second oops (VM_BUG_ON_FOLIO) will
occasionally occur.  The cause and oops follows:

> ---
>   fs/squashfs/file.c     | 21 ++++++++++++---------
>   fs/squashfs/squashfs.h |  1 -
>   2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index 1f27e8161319..d363fb26c2c8 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -362,19 +362,21 @@ static int read_blocklist(struct inode *inode, int index, u64 *block)
>   	return squashfs_block_size(size);
>   }
>   
> -void squashfs_fill_page(struct page *page, struct squashfs_cache_entry *buffer, int offset, int avail)
> +static bool squashfs_fill_page(struct folio *folio,
> +		struct squashfs_cache_entry *buffer, size_t offset,
> +		size_t avail)
>   {
> -	int copied;
> +	size_t copied;
>   	void *pageaddr;
>   
> -	pageaddr = kmap_atomic(page);
> +	pageaddr = kmap_local_folio(folio, 0);
>   	copied = squashfs_copy_data(pageaddr, buffer, offset, avail);
>   	memset(pageaddr + copied, 0, PAGE_SIZE - copied);
> -	kunmap_atomic(pageaddr);
> +	kunmap_local(pageaddr);
>   
> -	flush_dcache_page(page);
> -	if (copied == avail)
> -		SetPageUptodate(page);
> +	flush_dcache_folio(folio);
> +
> +	return copied == avail;
>   }
>   
>   /* Copy data into page cache  */
> @@ -398,6 +400,7 @@ void squashfs_copy_cache(struct folio *folio,
>   			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
>   		struct folio *push_folio;
>   		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
> +		bool filled = false;
>   
>   		TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
>   
> @@ -412,9 +415,9 @@ void squashfs_copy_cache(struct folio *folio,
>   		if (folio_test_uptodate(push_folio))
>   			goto skip_folio;

If the folio is uptodate the code jumps to skip_folio, where folio_end_read() is called

>   
> -		squashfs_fill_page(&push_folio->page, buffer, offset, avail);
> +		filled = squashfs_fill_page(push_folio, buffer, offset, avail);
>   skip_folio:
> -		folio_unlock(push_folio);
> +		folio_end_read(push_folio, filled);

This triggers the following oops

[  446.179884][ T7451] page: refcount:2 mapcount:0 mapping:ffff888000841218 ind8
[  446.180418][ T7451] memcg:ffff8880162c4000
[  446.180648][ T7451] aops:squashfs_aops ino:1f dentry name(?):".tmp_vmlinux2"
[  446.181006][ T7451] flags: 0x200000000000012d(locked|referenced|uptodate|lru)
[  446.181420][ T7451] raw: 200000000000012d ffffea0000afebc8 ffffea0000a870c8 8
[  446.181839][ T7451] raw: 0000000000000101 0000000000000000 00000002ffffffff 0
[  446.182261][ T7451] page dumped because: VM_BUG_ON_FOLIO(folio_test_uptodate)
[  446.182639][ T7451] page_owner tracks the page as allocated
[  446.182943][ T7451] page last allocated via order 0, migratetype Movable, gf6
[  446.183886][ T7451]  post_alloc_hook+0x2d0/0x350
[  446.184126][ T7451]  get_page_from_freelist+0xb39/0x22a0
[  446.184395][ T7451]  __alloc_pages_noprof+0x1bc/0x480
[  446.184651][ T7451]  __folio_alloc_noprof+0x11/0x90
[  446.184898][ T7451]  __filemap_get_folio+0x55a/0xb00
[  446.185150][ T7451]  squashfs_copy_cache+0x35d/0x540
[  446.185402][ T7451]  squashfs_read_folio+0xa13/0xc00
[  446.185695][ T7451]  filemap_read_folio+0xc0/0x2a0
[  446.185941][ T7451]  filemap_get_pages+0x155c/0x1bd0
[  446.186195][ T7451]  filemap_read+0x3b6/0xd50
[  446.186428][ T7451]  generic_file_read_iter+0x344/0x450
[  446.186690][ T7451]  __kernel_read+0x3b5/0xb10
[  446.186928][ T7451]  integrity_kernel_read+0x7f/0xb0
[  446.187328][ T7451]  ima_calc_file_hash_tfm+0x2bc/0x3d0
[  446.187716][ T7451]  ima_calc_file_hash+0x1ba/0x490
[  446.188078][ T7451]  ima_collect_measurement+0x848/0x9d0
[  446.188364][ T7451] page last free pid 7451 tgid 7451 stack trace:
[  446.188711][ T7451]  free_unref_folios+0x8ea/0x13e0
[  446.189002][ T7451]  shrink_folio_list+0xcff/0x4070
[  446.189295][ T7451]  shrink_lruvec+0xe94/0x29f0
[  446.189586][ T7451]  shrink_node+0xa74/0x2730
[  446.189823][ T7451]  do_try_to_free_pages+0x363/0x1860
[  446.190101][ T7451]  try_to_free_pages+0x2bf/0x790
[  446.190428][ T7451]  __alloc_pages_slowpath.constprop.0+0x7bc/0x2650
[  446.190810][ T7451]  __alloc_pages_noprof+0x3e6/0x480
[  446.191134][ T7451]  squashfs_bio_read+0x4af/0xf50
[  446.191408][ T7451]  squashfs_read_data+0x208/0xf10
[  446.191723][ T7451]  squashfs_readahead+0x1502/0x21e0
[  446.192034][ T7451]  read_pages+0x19f/0xdb0
[  446.192298][ T7451]  page_cache_ra_unbounded+0x3e0/0x750
[  446.192646][ T7451]  page_cache_ra_order+0x8ef/0xc30
[  446.192958][ T7451]  page_cache_async_ra+0x5cb/0x820
[  446.193269][ T7451]  filemap_get_pages+0x105b/0x1bd0
[  446.193563][ T7451] ------------[ cut here ]------------
[  446.193848][ T7451] kernel BUG at mm/filemap.c:1535!
[  446.194121][ T7451] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
[  446.194503][ T7451] CPU: 4 UID: 0 PID: 7451 Comm: cat Not tainted 6.13.0-rc20
[  446.195006][ T7451] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS4
[  446.195523][ T7451] RIP: 0010:folio_end_read+0x17b/0x1a0
[  446.195812][ T7451] Code: e8 1a 62 ca ff 48 c7 c6 a0 17 d8 8a 48 89 ef e8 2b8
[  446.196797][ T7451] RSP: 0018:ffffc900002e7710 EFLAGS: 00010293
[  446.197114][ T7451] RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc908
[  446.197522][ T7451] RDX: ffff88801befd880 RSI: ffffffff81cd65bb RDI: ffff8884
[  446.197930][ T7451] RBP: ffffea0000a93200 R08: 0000000000000000 R09: fffffbfa
[  446.198353][ T7451] R10: ffffffff8f7d79d7 R11: 0000000000000001 R12: 00000000
[  446.198765][ T7451] R13: 0000000000000000 R14: 0000000000000001 R15: ffffea00
[  446.199174][ T7451] FS:  00007f92f7c65700(0000) GS:ffff88802da00000(0000) kn0
[  446.199633][ T7451] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  446.199975][ T7451] CR2: 00007ff2432219d8 CR3: 0000000011268000 CR4: 00000000
[  446.200385][ T7451] Call Trace:
[  446.200559][ T7451]  <TASK>
[  446.200715][ T7451]  ? die+0x31/0x80
[  446.200918][ T7451]  ? do_trap+0x232/0x430
[  446.201142][ T7451]  ? folio_end_read+0x17b/0x1a0
[  446.201401][ T7451]  ? folio_end_read+0x17b/0x1a0
[  446.201658][ T7451]  ? do_error_trap+0xf4/0x230
[  446.201905][ T7451]  ? folio_end_read+0x17b/0x1a0
[  446.202167][ T7451]  ? handle_invalid_op+0x34/0x40
[  446.202434][ T7451]  ? folio_end_read+0x17b/0x1a0
[  446.202694][ T7451]  ? exc_invalid_op+0x2d/0x40
[  446.202947][ T7451]  ? asm_exc_invalid_op+0x1a/0x20
[  446.203216][ T7451]  ? folio_end_read+0x17b/0x1a0
[  446.203475][ T7451]  ? folio_end_read+0x17b/0x1a0
[  446.203735][ T7451]  squashfs_copy_cache+0x1d4/0x540
[  446.204005][ T7451]  squashfs_read_folio+0xa13/0xc00
[  446.204274][ T7451]  ? __pfx_squashfs_read_folio+0x10/0x10
[  446.204571][ T7451]  ? __pfx_squashfs_read_folio+0x10/0x10
[  446.204867][ T7451]  filemap_read_folio+0xc0/0x2a0
[  446.205128][ T7451]  ? __pfx_filemap_read_folio+0x10/0x10
[  446.205419][ T7451]  ? page_cache_async_ra+0x5cb/0x820
[  446.205703][ T7451]  filemap_get_pages+0x155c/0x1bd0
[  446.205972][ T7451]  ? current_time+0x79/0x380
[  446.206219][ T7451]  ? __pfx_filemap_get_pages+0x10/0x10
[  446.206520][ T7451]  filemap_read+0x3b6/0xd50
[  446.206771][ T7451]  ? find_held_lock+0x2d/0x110
[  446.207032][ T7451]  ? vfs_write+0x57e/0x1190
[  446.207279][ T7451]  ? __pfx_filemap_read+0x10/0x10
[  446.207554][ T7451]  ? pipe_write+0xf9f/0x1ae0
[  446.207828][ T7451]  ? __pfx_pipe_write+0x10/0x10
[  446.208135][ T7451]  ? lock_acquire+0x1b1/0x550
[  446.208435][ T7451]  ? __pfx_autoremove_wake_function+0x10/0x10
[  446.208810][ T7451]  generic_file_read_iter+0x344/0x450
[  446.209151][ T7451]  ? rw_verify_area+0xd0/0x700
[  446.209440][ T7451]  vfs_read+0x83e/0xba0
[  446.209672][ T7451]  ? __pfx_vfs_read+0x10/0x10
[  446.209920][ T7451]  ? __pfx_generic_fadvise+0x10/0x10
[  446.210203][ T7451]  ksys_read+0x122/0x240
[  446.210435][ T7451]  ? __pfx_ksys_read+0x10/0x10
[  446.210691][ T7451]  do_syscall_64+0x74/0x1c0
[  446.210932][ T7451]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  446.211243][ T7451] RIP: 0033:0x7f92f76dbba0
[  446.211480][ T7451] Code: 0b 31 c0 48 83 c4 08 e9 be fe ff ff 48 8d 3d 3f f04
[  446.212458][ T7451] RSP: 002b:00007fff1ae88768 EFLAGS: 00000246 ORIG_RAX: 000
[  446.212887][ T7451] RAX: ffffffffffffffda RBX: 0000000000008000 RCX: 00007f90
[  446.213292][ T7451] RDX: 0000000000008000 RSI: 000000003e0a0000 RDI: 00000003
[  446.213700][ T7451] RBP: 0000000000008000 R08: 0000000000000003 R09: 00007f90
[  446.214107][ T7451] R10: 0000000000000002 R11: 0000000000000246 R12: 00000000
[  446.214518][ T7451] R13: 0000000000000003 R14: 0000000000000000 R15: 00000000
[  446.214925][ T7451]  </TASK>
[  446.215086][ T7451] Modules linked in:
[  446.215317][ T7451] ---[ end trace 0000000000000000 ]---
[  446.215609][ T7451] RIP: 0010:folio_end_read+0x17b/0x1a0
[  446.215906][ T7451] Code: e8 1a 62 ca ff 48 c7 c6 a0 17 d8 8a 48 89 ef e8 2b8
[  446.216889][ T7451] RSP: 0018:ffffc900002e7710 EFLAGS: 00010293
[  446.217204][ T7451] RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc908
[  446.217609][ T7451] RDX: ffff88801befd880 RSI: ffffffff81cd65bb RDI: ffff8884
[  446.218015][ T7451] RBP: ffffea0000a93200 R08: 0000000000000000 R09: fffffbfa
[  446.218459][ T7451] R10: ffffffff8f7d79d7 R11: 0000000000000001 R12: 00000000
[  446.218878][ T7451] R13: 0000000000000000 R14: 0000000000000001 R15: ffffea00
[  446.219287][ T7451] FS:  00007f92f7c65700(0000) GS:ffff88802da00000(0000) kn0
[  446.219746][ T7451] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  446.220089][ T7451] CR2: 00007ff2432219d8 CR3: 0000000011268000 CR4: 00000000
[  446.220498][ T7451] Kernel panic - not syncing: Fatal exception
[  446.221221][ T7451] Kernel Offset: disabled
[  446.221468][ T7451] Rebooting in 86400 seconds..


