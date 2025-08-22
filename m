Return-Path: <linux-fsdevel+bounces-58860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B378BB324B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 23:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD62624567
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 21:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9EA23BCF5;
	Fri, 22 Aug 2025 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OmVyCrAa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2FF1FDE22
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 21:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755899283; cv=none; b=cvAfTXKsyGbvE4WY8MCaAbsO6nEqMe1oHm61ScMYelR7RYdKxUEDtn0HihBO0ETWY71hwl9ncmYCJWT6TrLU5uRnlT91Dc23RUtruR+d7HbH7ETGJbGoFPDiFXmLE98H2tgWslmau+bH8pYp9lN9mpk38dVT33v/aho4rbWu6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755899283; c=relaxed/simple;
	bh=NFAfw3HvdFfVEQ6P/Mx+letdPkIZAJvDqMHRtbYK9LE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=AHG8hsPF+XXb1xOdEDaSC1geRf2Iz+CWDGAN2A1d8wNgC+tKLJAPBtsImZKEI0Mnio3xLMtEYDYjHgDik+k/SB9nu5jiomLw8cRIn1Eh780+NNQRwBKsKqA7ZJR8vh2g9/LLY3PiW4MwCODSTwLlUzcHDZ4mvRHA8w2TugdTKQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OmVyCrAa; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250822214238euoutp01051eda605c70e620dc5ece4907bf8e11~eNMzIE22J3259232592euoutp012
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 21:42:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250822214238euoutp01051eda605c70e620dc5ece4907bf8e11~eNMzIE22J3259232592euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755898958;
	bh=Dx0ZmPP36PUthq9WgX18jt0ATxpXQol7Z82Al7MjsWY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OmVyCrAaFVEznrRnFPcMsVHGsbytQF4Kc6TLjJ5mxoOyng4aiNF9TvUSj4XO8+UQ0
	 AN/5h51AVJxBHQ2v0PjMnLbEDsN+xpWk4RoMSPYyS1LBNXN9HRT2RWxsVKjxn/FKnR
	 xe5+LOZv9Lbxmvt2g2/bwAUXByisnZg9sLi6pAHM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250822214238eucas1p16934a3c0a9575e6044b61e11f3635af0~eNMyasDET1601216012eucas1p1T;
	Fri, 22 Aug 2025 21:42:38 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250822214237eusmtip1fb955c175b6ebe784beb9e12ceb3ed1e~eNMxoaVER0144901449eusmtip1R;
	Fri, 22 Aug 2025 21:42:37 +0000 (GMT)
Message-ID: <2acaa457-2c9f-4285-8403-2896a152f929@samsung.com>
Date: Fri, 22 Aug 2025 23:42:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 2/2] mm: remove BDI_CAP_WRITEBACK_ACCT
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, david@redhat.com, willy@infradead.org,
	linux-mm@kvack.org
Content-Language: en-US
In-Reply-To: <a91010a8-e715-4f3d-9e22-e4c34efc0408@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250822214238eucas1p16934a3c0a9575e6044b61e11f3635af0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250822214238eucas1p16934a3c0a9575e6044b61e11f3635af0
X-EPHeader: CA
X-CMS-RootMailID: 20250822214238eucas1p16934a3c0a9575e6044b61e11f3635af0
References: <20250707234606.2300149-1-joannelkoong@gmail.com>
	<20250707234606.2300149-3-joannelkoong@gmail.com>
	<a91010a8-e715-4f3d-9e22-e4c34efc0408@samsung.com>
	<CGME20250822214238eucas1p16934a3c0a9575e6044b61e11f3635af0@eucas1p1.samsung.com>

On 22.08.2025 13:01, Marek Szyprowski wrote:
> On 08.07.2025 01:46, Joanne Koong wrote:
>> There are no users of BDI_CAP_WRITEBACK_ACCT now that fuse doesn't do
>> its own writeback accounting. This commit removes
>> BDI_CAP_WRITEBACK_ACCT.
>>
>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>
> This patch landed recently in linux-next as commit 167f21a81a9c ("mm: 
> remove BDI_CAP_WRITEBACK_ACCT"). In my tests I found that it triggers 
> the ./include/linux/backing-dev.h:239 warning. Reverting $subject on 
> top of current linux-next fixes/hides this issue. Here is a detailed log:
>
> ------------[ cut here ]------------
> WARNING: ./include/linux/backing-dev.h:239 at 
> __folio_start_writeback+0x25a/0x26a, CPU#1: swapper/0/1
> Modules linked in:
> CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
> 6.17.0-rc2-next-20250822 #10852 NONE
> Hardware name: StarFive VisionFive 2 v1.2A (DT)
> epc : __folio_start_writeback+0x25a/0x26a
>  ra : __folio_start_writeback+0x258/0x26a
>
> [<ffffffff80202222>] __folio_start_writeback+0x25a/0x26a
> [<ffffffff802f3260>] __block_write_full_folio+0x124/0x39c
> [<ffffffff802f4b6e>] block_write_full_folio+0x8a/0xbc
> [<ffffffff804dbf42>] blkdev_writepages+0x3e/0x8a
> [<ffffffff802030fa>] do_writepages+0x78/0x11a
> [<ffffffff801f2e0e>] filemap_fdatawrite_wbc+0x4a/0x62
> [<ffffffff801f6d66>] __filemap_fdatawrite_range+0x52/0x78
> [<ffffffff801f6fdc>] filemap_write_and_wait_range+0x40/0x68
> [<ffffffff804dacae>] set_blocksize+0xd8/0x152
> [<ffffffff804dae18>] sb_min_blocksize+0x44/0xce
> [<ffffffff803a0c7a>] ext4_fill_super+0x182/0x2914
> [<ffffffff802a72e6>] get_tree_bdev_flags+0xf0/0x168
> [<ffffffff802a736c>] get_tree_bdev+0xe/0x16
> [<ffffffff8039a09e>] ext4_get_tree+0x14/0x1c
> [<ffffffff802a5062>] vfs_get_tree+0x1a/0xa4
> [<ffffffff802d17d4>] path_mount+0x23a/0x8ae
> [<ffffffff80c20cd4>] init_mount+0x4e/0x86
> [<ffffffff80c01622>] do_mount_root+0xe0/0x166
> [<ffffffff80c01814>] mount_root_generic+0x11e/0x2d6
> [<ffffffff80c02746>] initrd_load+0xf8/0x2b6
> [<ffffffff80c01d38>] prepare_namespace+0x150/0x258
> [<ffffffff80c01310>] kernel_init_freeable+0x2f2/0x316
> [<ffffffff80b6d896>] kernel_init+0x1e/0x13a
> [<ffffffff80012288>] ret_from_fork_kernel+0x14/0x208
> [<ffffffff80b79392>] ret_from_fork_kernel_asm+0x16/0x18
> irq event stamp: 159263
> hardirqs last  enabled at (159263): [<ffffffff805e7e4a>] 
> percpu_counter_add_batch+0xa6/0xda
> hardirqs last disabled at (159262): [<ffffffff805e7e40>] 
> percpu_counter_add_batch+0x9c/0xda
> softirqs last  enabled at (159248): [<ffffffff8002e972>] 
> handle_softirqs+0x3ca/0x462
> softirqs last disabled at (159241): [<ffffffff8002eb72>] 
> __irq_exit_rcu+0xe2/0x10c
> ---[ end trace 0000000000000000 ]---

I've played a bit with the code modified by the $subject patch and it 
looks that the following change fixes the issue, although I didn't 
analyze exactly where struct bdi_writeback is being modified:

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 99e80bdb3084..3887ac2e6475 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2984,7 +2984,7 @@ bool __folio_end_writeback(struct folio *folio)

         if (mapping && mapping_use_writeback_tags(mapping)) {
                 struct inode *inode = mapping->host;
-               struct bdi_writeback *wb = inode_to_wb(inode);
+               struct bdi_writeback *wb;
                 unsigned long flags;

                 xa_lock_irqsave(&mapping->i_pages, flags);
@@ -2992,6 +2992,7 @@ bool __folio_end_writeback(struct folio *folio)
                 __xa_clear_mark(&mapping->i_pages, folio_index(folio),
                                         PAGECACHE_TAG_WRITEBACK);

+               wb = inode_to_wb(inode);
                 wb_stat_mod(wb, WB_WRITEBACK, -nr);
                 __wb_writeout_add(wb, nr);
                 if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
@@ -3024,7 +3025,7 @@ void __folio_start_writeback(struct folio *folio, 
bool keep_write)
         if (mapping && mapping_use_writeback_tags(mapping)) {
                 XA_STATE(xas, &mapping->i_pages, folio_index(folio));
                 struct inode *inode = mapping->host;
-               struct bdi_writeback *wb = inode_to_wb(inode);
+               struct bdi_writeback *wb;
                 unsigned long flags;
                 bool on_wblist;

@@ -3035,6 +3036,7 @@ void __folio_start_writeback(struct folio *folio, 
bool keep_write)
                 on_wblist = mapping_tagged(mapping, 
PAGECACHE_TAG_WRITEBACK);

                 xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
+               wb = inode_to_wb(inode);
                 wb_stat_mod(wb, WB_WRITEBACK, nr);
                 if (!on_wblist) {
                         wb_inode_writeback_start(wb);


> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


