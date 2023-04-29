Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F77C6F2182
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 02:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347133AbjD2AMI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 20:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjD2AMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 20:12:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E782422C;
        Fri, 28 Apr 2023 17:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SFptb4bxgIj4illZMUP0+LEQ5YHjcoe6ZdfH4QgLaE8=; b=DcPVwA/0w7w3ihDlMcami/XEWr
        na4uR2ZaEMVCEbed/HJorphO6NziasFTaQ/zYpNdLymwt359fTb4MF19qW/HlRtwr3sGpvxYpY3vn
        FNwF1Ud9N8hZiOmwnL8ihw9/GZF/Co33LwX7BxutpUaUuWy0QKSQNgpxztYInRxUVY4TwkdaivSsm
        TObjCzU3FiAg0zpoZslTlxk6Bulg0bgzssnJYmH3uGhGo83sh5uG/oGFSYkWww1qp7KHrBMglzvOu
        k9jRJfica0AfFGfpyfWeLMxApO8wY0Rp63A9R8CMDIuPAT0l/bpU0AL36zhkgs8xPCwcjTboLwdlp
        AfI1a4iw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1psYBx-00BykC-2P;
        Sat, 29 Apr 2023 00:11:57 +0000
Date:   Fri, 28 Apr 2023 17:11:57 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] fs: add CONFIG_BUFFER_HEAD
Message-ID: <ZExgzbBCbdC1y9Wk@bombadil.infradead.org>
References: <20230424054926.26927-1-hch@lst.de>
 <20230424054926.26927-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424054926.26927-18-hch@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 07:49:26AM +0200, Christoph Hellwig wrote:
> +const struct address_space_operations def_blk_aops = {
> +	.dirty_folio	= filemap_dirty_folio,
> +	.release_folio		= iomap_release_folio,
> +	.invalidate_folio	= iomap_invalidate_folio,
> +	.read_folio		= blkdev_read_folio,
> +	.readahead		= blkdev_readahead,
> +	.writepages		= blkdev_writepages,
> +	.is_partially_uptodate  = iomap_is_partially_uptodate,
> +	.error_remove_page	= generic_error_remove_page,
> +	.migrate_folio		= filemap_migrate_folio,
> +};
> +#endif /* CONFIG_BUFFER_HEAD */

We've tested this with bs > ps (LBS) devices and it would seem it crashes,
as Pankaj notes perhaps due to lack of higher order folio support yet
on this path, for the block cache. The same crash happens with NVMe
(using out-of-tree nvme_core.debug_large_lbas boot parameter to enable NVMe
LBS) or brd with LBS. To enable NVMe LBS or brd with LBS you need
out of tree patches though of course, so I've stashed these into
a branch, large-block-20230426 [0] so to help folks who may want
to experiment further.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=large-block-20230426

[   11.245248] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   11.254581] #PF: supervisor read access in kernel mode
[   11.257387] #PF: error_code(0x0000) - not-present page
[   11.260921] PGD 0 P4D 0
[   11.262600] Oops: 0000 [#1] PREEMPT SMP PTI
[   11.264993] CPU: 7 PID: 198 Comm: (udev-worker) Not tainted 6.3.0-large-block-20230426 #2
[   11.269385] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
[   11.275054] RIP: 0010:iomap_page_create.isra.0+0xc/0xd0
[   11.277924] Code: 41 5e 41 5f c3 cc cc cc cc 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 55 48 89 f5 53 <48> 8b 06 48 c1 e8 0d 89 c6 83 e6 01 0f 84 a1 00 00 00 4c 8b 65 28
[   11.287293] RSP: 0018:ffffb0f0805ef9d8 EFLAGS: 00010293
[   11.289964] RAX: ffff9de3c1fa8388 RBX: ffffb0f0805efa78 RCX: 000000037ffe0000
[   11.293212] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000d
[   11.296485] RBP: 0000000000000000 R08: 0000000000021000 R09: ffffffff9c733b20
[   11.299724] R10: 0000000000000001 R11: 000000000000c000 R12: 0000000000000000
[   11.302974] R13: ffffffff9be96260 R14: ffffb0f0805efa58 R15: 0000000000000000
[   11.306206] FS:  00007f03ea8368c0(0000) GS:ffff9de43bdc0000(0000) knlGS:0000000000000000
[   11.309949] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.312464] CR2: 0000000000000000 CR3: 0000000117ec6006 CR4: 0000000000770ee0
[   11.315442] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   11.318310] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   11.321010] PKRU: 55555554
[   11.322212] Call Trace:
[   11.323224]  <TASK>
[   11.324146]  iomap_readpage_iter+0x96/0x300
[   11.325694]  iomap_readahead+0x174/0x2d0
[   11.327129]  read_pages+0x69/0x1f0
[   11.328389]  ? folio_add_lru+0x7e/0xe0
[   11.329751]  page_cache_ra_unbounded+0x187/0x1d0
[   11.331301]  force_page_cache_ra+0x94/0xb0
[   11.332681]  filemap_get_pages+0x10e/0x650
[   11.334073]  ? _raw_spin_lock+0x13/0x40
[   11.335287]  filemap_read+0xbf/0x340
[   11.336430]  ? aa_file_perm+0x117/0x4b0
[   11.337646]  ? generic_fillattr+0x45/0xf0
[   11.338887]  ? _copy_to_user+0x22/0x30
[   11.340026]  ? cp_new_stat+0x150/0x180
[   11.341166]  blkdev_read_iter+0x5e/0x140
[   11.342357]  vfs_read+0x1f0/0x2c0
[   11.343354]  ksys_read+0x63/0xe0
[   11.344331]  do_syscall_64+0x37/0x90
[   11.345411]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   11.346760] RIP: 0033:0x7f03eaf3903d

(gdb) l *(iomap_readpage_iter+0x96)
0xffffffff814021b6 is in iomap_readpage_iter (fs/iomap/buffered-io.c:280).
275             if (iomap->type == IOMAP_INLINE)
276                     return iomap_read_inline_data(iter, folio);
277
278             /* zero post-eof blocks as the page may be mapped */
279             iop = iomap_page_create(iter->inode, folio, iter->flags);
280             iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
281             if (plen == 0)
282                     goto done;
283
284             if (iomap_block_needs_zeroing(iter, pos)) {
(gdb) l *(iomap_page_create+0xc)
0xffffffff81400cdc is in iomap_page_create (./arch/x86/include/asm/bitops.h:207).
202     }
203
204     static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
205     {
206             return ((1UL << (nr & (BITS_PER_LONG-1))) &
207                     (addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
208     }
209
210     static __always_inline bool constant_test_bit_acquire(long nr, const volatile unsigned long *addr)
211     {

To reproduce one would want a system with only say XFS as the root
image. I've enabled this on kdevops through "pure-iomap" option:

https://github.com/linux-kdevops/kdevops/blob/master/docs/lbs.md

  Luis
