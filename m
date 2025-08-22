Return-Path: <linux-fsdevel+bounces-58770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DEAB31608
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6231D033DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 11:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4292E8B74;
	Fri, 22 Aug 2025 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XSvCLbN2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB3020330
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860500; cv=none; b=kZgYpDNIZ1ZRZqiSOntfgLPX657xLPKxhswUs86iuyq6mPbcFCpt7tZtYxyaOhqDnwDJyHILKPXMvO5FE2QCX7BQt/OncvihazWiOP5aOJWvCab04DUyVihd5mx9JCTVuwfHBSLJN/EspvmzNRLZiLODGLPVBj239KN3GypDCYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860500; c=relaxed/simple;
	bh=1IHNt0/1brQj47Ov/jVwg4jF3VQiol7BwP5Ik/r8oIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=WI4USGVEVo1ilck1nXSOn8oqCxv9PcqytbCoJMVbVTfPOFQc87QIxpbWIBce+gEJHkYamnT5yy0dcvNJMLdhtp6xOQGBBAC+ddcXl4jRswrLvO9679gN9MTZ69MU/i1EzZ2wzG6TaNwaXPRaSLVHoevsG74XCdEDWIeasNsPxh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XSvCLbN2; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250822110134euoutp0226767367fe220a54494875d8aae2f429~eEdENgxtT2616026160euoutp02a
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 11:01:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250822110134euoutp0226767367fe220a54494875d8aae2f429~eEdENgxtT2616026160euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755860494;
	bh=9KskoGBFOs28/Mda6h0wj3uBIF0p2biNPs4pw1Y7qMU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=XSvCLbN2gOkeveRq3jDm90QxT2zPFO5+lvs7w0yr7uj7WpxPNUUyYsfjHaA/3woux
	 HBFJ00BIOa1rK+QG+mG9I21NsJRWaflrG2me6uvYKGS7juZoBQ6yl0LO59N4e6VNjS
	 3p5s3hX41XzBjaYet9qwjS47J/cm7xwyQ0TXQuvc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250822110133eucas1p2378459d1e802c718ef6028efc06625dc~eEdD32zgD1178111781eucas1p2y;
	Fri, 22 Aug 2025 11:01:33 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250822110133eusmtip1965119ff684e33aef3b2ab78de9aa4f6~eEdDTj8sl1109711097eusmtip1t;
	Fri, 22 Aug 2025 11:01:33 +0000 (GMT)
Message-ID: <a91010a8-e715-4f3d-9e22-e4c34efc0408@samsung.com>
Date: Fri, 22 Aug 2025 13:01:32 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 2/2] mm: remove BDI_CAP_WRITEBACK_ACCT
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, david@redhat.com, willy@infradead.org,
	linux-mm@kvack.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250707234606.2300149-3-joannelkoong@gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250822110133eucas1p2378459d1e802c718ef6028efc06625dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250822110133eucas1p2378459d1e802c718ef6028efc06625dc
X-EPHeader: CA
X-CMS-RootMailID: 20250822110133eucas1p2378459d1e802c718ef6028efc06625dc
References: <20250707234606.2300149-1-joannelkoong@gmail.com>
	<20250707234606.2300149-3-joannelkoong@gmail.com>
	<CGME20250822110133eucas1p2378459d1e802c718ef6028efc06625dc@eucas1p2.samsung.com>

On 08.07.2025 01:46, Joanne Koong wrote:
> There are no users of BDI_CAP_WRITEBACK_ACCT now that fuse doesn't do
> its own writeback accounting. This commit removes
> BDI_CAP_WRITEBACK_ACCT.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Acked-by: David Hildenbrand <david@redhat.com>

This patch landed recently in linux-next as commit 167f21a81a9c ("mm: 
remove BDI_CAP_WRITEBACK_ACCT"). In my tests I found that it triggers 
the ./include/linux/backing-dev.h:239 warning. Reverting $subject on top 
of current linux-next fixes/hides this issue. Here is a detailed log:

------------[ cut here ]------------
WARNING: ./include/linux/backing-dev.h:239 at 
__folio_start_writeback+0x25a/0x26a, CPU#1: swapper/0/1
Modules linked in:
CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
6.17.0-rc2-next-20250822 #10852 NONE
Hardware name: StarFive VisionFive 2 v1.2A (DT)
epc : __folio_start_writeback+0x25a/0x26a
  ra : __folio_start_writeback+0x258/0x26a

[<ffffffff80202222>] __folio_start_writeback+0x25a/0x26a
[<ffffffff802f3260>] __block_write_full_folio+0x124/0x39c
[<ffffffff802f4b6e>] block_write_full_folio+0x8a/0xbc
[<ffffffff804dbf42>] blkdev_writepages+0x3e/0x8a
[<ffffffff802030fa>] do_writepages+0x78/0x11a
[<ffffffff801f2e0e>] filemap_fdatawrite_wbc+0x4a/0x62
[<ffffffff801f6d66>] __filemap_fdatawrite_range+0x52/0x78
[<ffffffff801f6fdc>] filemap_write_and_wait_range+0x40/0x68
[<ffffffff804dacae>] set_blocksize+0xd8/0x152
[<ffffffff804dae18>] sb_min_blocksize+0x44/0xce
[<ffffffff803a0c7a>] ext4_fill_super+0x182/0x2914
[<ffffffff802a72e6>] get_tree_bdev_flags+0xf0/0x168
[<ffffffff802a736c>] get_tree_bdev+0xe/0x16
[<ffffffff8039a09e>] ext4_get_tree+0x14/0x1c
[<ffffffff802a5062>] vfs_get_tree+0x1a/0xa4
[<ffffffff802d17d4>] path_mount+0x23a/0x8ae
[<ffffffff80c20cd4>] init_mount+0x4e/0x86
[<ffffffff80c01622>] do_mount_root+0xe0/0x166
[<ffffffff80c01814>] mount_root_generic+0x11e/0x2d6
[<ffffffff80c02746>] initrd_load+0xf8/0x2b6
[<ffffffff80c01d38>] prepare_namespace+0x150/0x258
[<ffffffff80c01310>] kernel_init_freeable+0x2f2/0x316
[<ffffffff80b6d896>] kernel_init+0x1e/0x13a
[<ffffffff80012288>] ret_from_fork_kernel+0x14/0x208
[<ffffffff80b79392>] ret_from_fork_kernel_asm+0x16/0x18
irq event stamp: 159263
hardirqs last  enabled at (159263): [<ffffffff805e7e4a>] 
percpu_counter_add_batch+0xa6/0xda
hardirqs last disabled at (159262): [<ffffffff805e7e40>] 
percpu_counter_add_batch+0x9c/0xda
softirqs last  enabled at (159248): [<ffffffff8002e972>] 
handle_softirqs+0x3ca/0x462
softirqs last disabled at (159241): [<ffffffff8002eb72>] 
__irq_exit_rcu+0xe2/0x10c
---[ end trace 0000000000000000 ]---


> ---
>   include/linux/backing-dev.h |  4 +---
>   mm/backing-dev.c            |  2 +-
>   mm/page-writeback.c         | 43 ++++++++++++++++---------------------
>   3 files changed, 20 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 9a1e895dd5df..3e64f14739dd 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -108,12 +108,10 @@ int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int strict_limit
>    *
>    * BDI_CAP_WRITEBACK:		Supports dirty page writeback, and dirty pages
>    *				should contribute to accounting
> - * BDI_CAP_WRITEBACK_ACCT:	Automatically account writeback pages
>    * BDI_CAP_STRICTLIMIT:		Keep number of dirty pages below bdi threshold
>    */
>   #define BDI_CAP_WRITEBACK		(1 << 0)
> -#define BDI_CAP_WRITEBACK_ACCT		(1 << 1)
> -#define BDI_CAP_STRICTLIMIT		(1 << 2)
> +#define BDI_CAP_STRICTLIMIT		(1 << 1)
>   
>   extern struct backing_dev_info noop_backing_dev_info;
>   
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 783904d8c5ef..35f11e75e30e 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -1026,7 +1026,7 @@ struct backing_dev_info *bdi_alloc(int node_id)
>   		kfree(bdi);
>   		return NULL;
>   	}
> -	bdi->capabilities = BDI_CAP_WRITEBACK | BDI_CAP_WRITEBACK_ACCT;
> +	bdi->capabilities = BDI_CAP_WRITEBACK;
>   	bdi->ra_pages = VM_READAHEAD_PAGES;
>   	bdi->io_pages = VM_READAHEAD_PAGES;
>   	timer_setup(&bdi->laptop_mode_wb_timer, laptop_mode_timer_fn, 0);
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 72b0ff0d4bae..11f9a909e8de 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -3016,26 +3016,22 @@ bool __folio_end_writeback(struct folio *folio)
>   
>   	if (mapping && mapping_use_writeback_tags(mapping)) {
>   		struct inode *inode = mapping->host;
> -		struct backing_dev_info *bdi = inode_to_bdi(inode);
> +		struct bdi_writeback *wb = inode_to_wb(inode);
>   		unsigned long flags;
>   
>   		xa_lock_irqsave(&mapping->i_pages, flags);
>   		ret = folio_xor_flags_has_waiters(folio, 1 << PG_writeback);
>   		__xa_clear_mark(&mapping->i_pages, folio_index(folio),
>   					PAGECACHE_TAG_WRITEBACK);
> -		if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
> -			struct bdi_writeback *wb = inode_to_wb(inode);
>   
> -			wb_stat_mod(wb, WB_WRITEBACK, -nr);
> -			__wb_writeout_add(wb, nr);
> -			if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> -				wb_inode_writeback_end(wb);
> +		wb_stat_mod(wb, WB_WRITEBACK, -nr);
> +		__wb_writeout_add(wb, nr);
> +		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
> +			wb_inode_writeback_end(wb);
> +			if (mapping->host)
> +				sb_clear_inode_writeback(mapping->host);
>   		}
>   
> -		if (mapping->host && !mapping_tagged(mapping,
> -						     PAGECACHE_TAG_WRITEBACK))
> -			sb_clear_inode_writeback(mapping->host);
> -
>   		xa_unlock_irqrestore(&mapping->i_pages, flags);
>   	} else {
>   		ret = folio_xor_flags_has_waiters(folio, 1 << PG_writeback);
> @@ -3060,7 +3056,7 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
>   	if (mapping && mapping_use_writeback_tags(mapping)) {
>   		XA_STATE(xas, &mapping->i_pages, folio_index(folio));
>   		struct inode *inode = mapping->host;
> -		struct backing_dev_info *bdi = inode_to_bdi(inode);
> +		struct bdi_writeback *wb = inode_to_wb(inode);
>   		unsigned long flags;
>   		bool on_wblist;
>   
> @@ -3071,21 +3067,18 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
>   		on_wblist = mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>   
>   		xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
> -		if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
> -			struct bdi_writeback *wb = inode_to_wb(inode);
> -
> -			wb_stat_mod(wb, WB_WRITEBACK, nr);
> -			if (!on_wblist)
> -				wb_inode_writeback_start(wb);
> +		wb_stat_mod(wb, WB_WRITEBACK, nr);
> +		if (!on_wblist) {
> +			wb_inode_writeback_start(wb);
> +			/*
> +			 * We can come through here when swapping anonymous
> +			 * folios, so we don't necessarily have an inode to
> +			 * track for sync.
> +			 */
> +			if (mapping->host)
> +				sb_mark_inode_writeback(mapping->host);
>   		}
>   
> -		/*
> -		 * We can come through here when swapping anonymous
> -		 * folios, so we don't necessarily have an inode to
> -		 * track for sync.
> -		 */
> -		if (mapping->host && !on_wblist)
> -			sb_mark_inode_writeback(mapping->host);
>   		if (!folio_test_dirty(folio))
>   			xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
>   		if (!keep_write)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


