Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A035B6F6E2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 16:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjEDOwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 10:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjEDOwb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 10:52:31 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F8340CB;
        Thu,  4 May 2023 07:51:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-643557840e4so765624b3a.2;
        Thu, 04 May 2023 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683211891; x=1685803891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL0PEW+zKTMCWjI+Tq65B4wPII54eQtyTfrfjmPEOyE=;
        b=VaWqge1NUmCC7uAhsqpE4MpdAYWUzljnX3w3Y1BgokMvz02Z4cGr3bIf6DI3Nkt5LP
         QJgg7ZlE+/uKN7bT8+ao7m9Q0ZBHU5HXGqOIxnFdXCdlkBkGmKXNGC3o0SmE1CwljsgP
         Z+CF/50dWv8nn5Fkm2ZpCQhGCINaf0sATetpJ0yYl99msSn1Uglg7ZAZNrn/i/FW8kpJ
         I2sotZVnJkchHE5C8mzMBTtqaZt2viaI2XQW4nFGuusa4fVorAOlqzWueojQxnjyM9LY
         9cXYcovjogbwPG4BsUU7kWK8nC/PvIZ1A9ECASeHbTadKaz3GaE7n6tmbjkWlqE9HmMp
         k3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683211891; x=1685803891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hL0PEW+zKTMCWjI+Tq65B4wPII54eQtyTfrfjmPEOyE=;
        b=O4ObCQHdIbi/tSr+fFhrsCEKslMZ6MlgDw8/6R2NhmbDDoRIt5PcWLssvcP3Pspyce
         BPgZ6ubMbCx4oYmlqr+JkSnF32tS/Zk0zxFmdrY0aCGsm352BzvdMWti9LyXt7RQVDkJ
         6aITB8TsOgsUcPGJ7o85mHwRRUNaLMMcs5lAmZpO//NicJFXtOH9BYdMSr4yq5MMFruH
         sZxKEuh8yxA3H8iKIjpp8XGE0GZG/RrOV0Bo+roxP60KszIGP9axO28FX4cgeMkVeq3Q
         aCjOX8Ug2ZapyDZG7RidEGt8j3vGRuKMwUo/FW6sw1e7bkfZ3cHxMiLNRTFPnfXKwKaJ
         EEEw==
X-Gm-Message-State: AC+VfDxhb9Oh2uMS+Bj539sjThmOt8E7ymJWOLdiagTKWDKKhFQuqzdy
        9hFNsJWn9e2rLC+oEF2YFqkHlmo5vKo=
X-Google-Smtp-Source: ACHHUZ6ficwKH2Pph2o8fcdzP3WPE4E++hbBqMa1lX2hi5Zkju9TgSg4zH+rfkqhh+EeIoU0FJiDSw==
X-Received: by 2002:a05:6a00:10c3:b0:643:4d69:efb8 with SMTP id d3-20020a056a0010c300b006434d69efb8mr2869144pfu.6.1683211891506;
        Thu, 04 May 2023 07:51:31 -0700 (PDT)
Received: from rh-tp.ibmuc.com ([2406:7400:63:80ba:df67:5773:54c8:514f])
        by smtp.gmail.com with ESMTPSA id z192-20020a6333c9000000b0052c53577756sm3107503pgz.64.2023.05.04.07.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 07:51:31 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: [RFCv4 3/3] iomap: Support subpage size dirty tracking to improve write performance
Date:   Thu,  4 May 2023 20:21:09 +0530
Message-Id: <377c30e7b5f2783dd5be12c59ea703d7c72ba004.1683208091.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1683208091.git.ritesh.list@gmail.com>
References: <cover.1683208091.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On a 64k pagesize platforms (specially Power and/or aarch64) with 4k
filesystem blocksize, this patch should improve the performance by doing
only the subpage dirty data write.

This should also reduce the write amplification since we can now track
subpage dirty status within state bitmaps. Earlier we had to
write the entire 64k page even if only a part of it (e.g. 4k) was
updated.

Performance testing of below fio workload reveals ~16x performance
improvement on nvme with XFS (4k blocksize) on Power (64K pagesize)
FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.

1. <test_randwrite.fio>
[global]
	ioengine=psync
	rw=randwrite
	overwrite=1
	pre_read=1
	direct=0
	bs=4k
	size=1G
	dir=./
	numjobs=8
	fdatasync=1
	runtime=60
	iodepth=64
	group_reporting=1

[fio-run]

2. Also our internal performance team reported that this patch improves
   there database workload performance by around ~83% (with XFS on Power)

Reported-by: Aravinda Herle <araherle@in.ibm.com>
Reported-by: Brian Foster <bfoster@redhat.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/gfs2/aops.c         |   2 +-
 fs/iomap/buffered-io.c | 175 ++++++++++++++++++++++++++++++++++-------
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/file.c       |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 149 insertions(+), 33 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index a5f4be6b9213..75efec3c3b71 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -746,7 +746,7 @@ static const struct address_space_operations gfs2_aops = {
 	.writepages = gfs2_writepages,
 	.read_folio = gfs2_read_folio,
 	.readahead = gfs2_readahead,
-	.dirty_folio = filemap_dirty_folio,
+	.dirty_folio = iomap_dirty_folio,
 	.release_folio = iomap_release_folio,
 	.invalidate_folio = iomap_invalidate_folio,
 	.bmap = gfs2_bmap,
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b8b23c859ecf..52c9703ff262 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -34,6 +34,11 @@ struct iomap_page {
 	unsigned long		state[];
 };

+enum iop_state {
+	IOP_STATE_UPDATE = 0,
+	IOP_STATE_DIRTY = 1
+};
+
 static inline struct iomap_page *to_iomap_page(struct folio *folio)
 {
 	if (folio_test_private(folio))
@@ -44,8 +49,8 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
 static struct bio_set iomap_ioend_bioset;

 /*
- * Accessor functions for setting/clearing/checking uptodate bits in
- * iop->state bitmap.
+ * Accessor functions for setting/clearing/checking uptodate and
+ * dirty bits in iop->state bitmap.
  * nrblocks is i_blocks_per_folio() which is passed in every
  * function as the last argument for API consistency.
  */
@@ -75,8 +80,29 @@ static inline bool iop_uptodate_full(struct iomap_page *iop,
 	return bitmap_full(iop->state, nrblocks);
 }

+static inline void iop_set_range_dirty(struct iomap_page *iop,
+				unsigned int start, unsigned int len,
+				unsigned int nrblocks)
+{
+	bitmap_set(iop->state, start + nrblocks, len);
+}
+
+static inline void iop_clear_range_dirty(struct iomap_page *iop,
+				unsigned int start, unsigned int len,
+				unsigned int nrblocks)
+{
+	bitmap_clear(iop->state, start + nrblocks, len);
+}
+
+static inline bool iop_test_dirty(struct iomap_page *iop, unsigned int block,
+			     unsigned int nrblocks)
+{
+	return test_bit(block + nrblocks, iop->state);
+}
+
 static struct iomap_page *
-iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
+iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags,
+		  bool is_dirty)
 {
 	struct iomap_page *iop = to_iomap_page(folio);
 	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
@@ -90,12 +116,21 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
 	else
 		gfp = GFP_NOFS | __GFP_NOFAIL;

-	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
+	/*
+	 * iop->state tracks two sets of state flags when the
+	 * filesystem block size is smaller than the folio size.
+	 * The first state tracks per-filesystem block uptodate
+	 * and the second tracks per-filesystem block dirty
+	 * state.
+	 */
+	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(2 * nr_blocks)),
 		      gfp);
 	if (iop) {
 		spin_lock_init(&iop->state_lock);
 		if (folio_test_uptodate(folio))
 			iop_set_range_uptodate(iop, 0, nr_blocks, nr_blocks);
+		if (is_dirty)
+			iop_set_range_dirty(iop, 0, nr_blocks, nr_blocks);
 		folio_attach_private(folio, iop);
 	}
 	return iop;
@@ -177,29 +212,62 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	*lenp = plen;
 }

-static void iomap_iop_set_range_uptodate(struct folio *folio,
-		struct iomap_page *iop, size_t off, size_t len)
+static void iomap_iop_set_range(struct folio *folio, struct iomap_page *iop,
+		size_t off, size_t len, enum iop_state state)
 {
 	struct inode *inode = folio->mapping->host;
-	unsigned first = off >> inode->i_blkbits;
-	unsigned last = (off + len - 1) >> inode->i_blkbits;
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+	unsigned int first_blk = (off >> inode->i_blkbits);
+	unsigned int last_blk = ((off + len - 1) >> inode->i_blkbits);
+	unsigned int nr_blks = last_blk - first_blk + 1;
 	unsigned long flags;
-	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);

-	spin_lock_irqsave(&iop->state_lock, flags);
-	iop_set_range_uptodate(iop, first, last - first + 1, nr_blocks);
-	if (iop_uptodate_full(iop, nr_blocks))
-		folio_mark_uptodate(folio);
-	spin_unlock_irqrestore(&iop->state_lock, flags);
+	switch (state) {
+	case IOP_STATE_UPDATE:
+		if (!iop) {
+			folio_mark_uptodate(folio);
+			return;
+		}
+		spin_lock_irqsave(&iop->state_lock, flags);
+		iop_set_range_uptodate(iop, first_blk, nr_blks, blks_per_folio);
+		if (iop_uptodate_full(iop, blks_per_folio))
+			folio_mark_uptodate(folio);
+		spin_unlock_irqrestore(&iop->state_lock, flags);
+		break;
+	case IOP_STATE_DIRTY:
+		if (!iop)
+			return;
+		spin_lock_irqsave(&iop->state_lock, flags);
+		iop_set_range_dirty(iop, first_blk, nr_blks, blks_per_folio);
+		spin_unlock_irqrestore(&iop->state_lock, flags);
+		break;
+	}
 }

-static void iomap_set_range_uptodate(struct folio *folio,
-		struct iomap_page *iop, size_t off, size_t len)
+static void iomap_iop_clear_range(struct folio *folio,
+		struct iomap_page *iop, size_t off, size_t len,
+		enum iop_state state)
 {
-	if (iop)
-		iomap_iop_set_range_uptodate(folio, iop, off, len);
-	else
-		folio_mark_uptodate(folio);
+	struct inode *inode = folio->mapping->host;
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+	unsigned int first_blk = (off >> inode->i_blkbits);
+	unsigned int last_blk = ((off + len - 1) >> inode->i_blkbits);
+	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned long flags;
+
+	switch (state) {
+	case IOP_STATE_UPDATE:
+		// Never gets called so not implemented
+		WARN_ON(1);
+		break;
+	case IOP_STATE_DIRTY:
+		if (!iop)
+			return;
+		spin_lock_irqsave(&iop->state_lock, flags);
+		iop_clear_range_dirty(iop, first_blk, nr_blks, blks_per_folio);
+		spin_unlock_irqrestore(&iop->state_lock, flags);
+		break;
+	}
 }

 static void iomap_finish_folio_read(struct folio *folio, size_t offset,
@@ -211,7 +279,7 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		folio_clear_uptodate(folio);
 		folio_set_error(folio);
 	} else {
-		iomap_set_range_uptodate(folio, iop, offset, len);
+		iomap_iop_set_range(folio, iop, offset, len, IOP_STATE_UPDATE);
 	}

 	if (!iop || atomic_sub_and_test(len, &iop->read_bytes_pending))
@@ -265,7 +333,8 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (offset > 0)
-		iop = iomap_page_create(iter->inode, folio, iter->flags);
+		iop = iomap_page_create(iter->inode, folio, iter->flags,
+					folio_test_dirty(folio));
 	else
 		iop = to_iomap_page(folio);

@@ -273,7 +342,8 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_local(addr);
-	iomap_set_range_uptodate(folio, iop, offset, PAGE_SIZE - poff);
+	iomap_iop_set_range(folio, iop, offset, PAGE_SIZE - poff,
+			    IOP_STATE_UPDATE);
 	return 0;
 }

@@ -303,14 +373,15 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		return iomap_read_inline_data(iter, folio);

 	/* zero post-eof blocks as the page may be mapped */
-	iop = iomap_page_create(iter->inode, folio, iter->flags);
+	iop = iomap_page_create(iter->inode, folio, iter->flags,
+				folio_test_dirty(folio));
 	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;

 	if (iomap_block_needs_zeroing(iter, pos)) {
 		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, iop, poff, plen);
+		iomap_iop_set_range(folio, iop, poff, plen, IOP_STATE_UPDATE);
 		goto done;
 	}

@@ -559,6 +630,18 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);

+bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
+{
+	unsigned int nr_blocks = i_blocks_per_folio(mapping->host, folio);
+	struct iomap_page *iop;
+
+	iop = iomap_page_create(mapping->host, folio, 0, false);
+	iomap_iop_set_range(folio, iop, 0,
+			nr_blocks << mapping->host->i_blkbits, IOP_STATE_DIRTY);
+	return filemap_dirty_folio(mapping, folio);
+}
+EXPORT_SYMBOL_GPL(iomap_dirty_folio);
+
 static void
 iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 {
@@ -607,7 +690,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	    pos + len >= folio_pos(folio) + folio_size(folio))
 		return 0;

-	iop = iomap_page_create(iter->inode, folio, iter->flags);
+	iop = iomap_page_create(iter->inode, folio, iter->flags,
+				folio_test_dirty(folio));

 	/*
 	 * If we don't have an iop and nr_blocks > 1 then return -EAGAIN here
@@ -648,7 +732,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 			if (status)
 				return status;
 		}
-		iomap_set_range_uptodate(folio, iop, poff, plen);
+		iomap_iop_set_range(folio, iop, poff, plen, IOP_STATE_UPDATE);
 	} while ((block_start += plen) < block_end);

 	return 0;
@@ -771,7 +855,10 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 */
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return 0;
-	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
+	iomap_iop_set_range(folio, iop, offset_in_folio(folio, pos), copied,
+			    IOP_STATE_UPDATE);
+	iomap_iop_set_range(folio, iop, offset_in_folio(folio, pos), copied,
+			    IOP_STATE_DIRTY);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
 }
@@ -959,6 +1046,12 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 {
 	while (start_byte < end_byte) {
 		struct folio	*folio;
+		size_t first, last;
+		loff_t end;
+		unsigned int i;
+		struct iomap_page *iop;
+		u8 blkbits = inode->i_blkbits;
+		unsigned int nr_blocks;

 		/* grab locked page */
 		folio = filemap_lock_folio(inode->i_mapping,
@@ -983,6 +1076,26 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 				}
 			}

+			/*
+			 * When we have subfolio dirty tracking, there can be
+			 * subblocks within a folio which are marked uptodate
+			 * but not dirty. In that case it is necessary to punch
+			 * out such blocks to avoid leaking delalloc blocks.
+			 */
+			iop = to_iomap_page(folio);
+			if (!iop)
+				goto skip_iop_punch;
+			end = min_t(loff_t, end_byte - 1,
+				(folio_next_index(folio) << PAGE_SHIFT) - 1);
+			first = offset_in_folio(folio, start_byte) >> blkbits;
+			last = offset_in_folio(folio, end) >> blkbits;
+			nr_blocks = i_blocks_per_folio(inode, folio);
+			for (i = first; i <= last; i++) {
+				if (!iop_test_dirty(iop, i, nr_blocks))
+					punch(inode, i << blkbits,
+							1 << blkbits);
+			}
+skip_iop_punch:
 			/*
 			 * Make sure the next punch start is correctly bound to
 			 * the end of this data range, not the end of the folio.
@@ -1671,7 +1784,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct folio *folio, u64 end_pos)
 {
-	struct iomap_page *iop = iomap_page_create(inode, folio, 0);
+	struct iomap_page *iop = iomap_page_create(inode, folio, 0, true);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	unsigned nblocks = i_blocks_per_folio(inode, folio);
@@ -1687,7 +1800,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (iop && !iop_test_uptodate(iop, i, nblocks))
+		if (iop && !iop_test_dirty(iop, i, nblocks))
 			continue;

 		error = wpc->ops->map_blocks(wpc, inode, pos);
@@ -1731,6 +1844,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		}
 	}

+	iomap_iop_clear_range(folio, iop, 0, end_pos - folio_pos(folio),
+			      IOP_STATE_DIRTY);
 	folio_start_writeback(folio);
 	folio_unlock(folio);

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 2ef78aa1d3f6..77c7332ae197 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -578,7 +578,7 @@ const struct address_space_operations xfs_address_space_operations = {
 	.read_folio		= xfs_vm_read_folio,
 	.readahead		= xfs_vm_readahead,
 	.writepages		= xfs_vm_writepages,
-	.dirty_folio		= filemap_dirty_folio,
+	.dirty_folio		= iomap_dirty_folio,
 	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.bmap			= xfs_vm_bmap,
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 132f01d3461f..e508c8e97372 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -175,7 +175,7 @@ const struct address_space_operations zonefs_file_aops = {
 	.read_folio		= zonefs_read_folio,
 	.readahead		= zonefs_readahead,
 	.writepages		= zonefs_writepages,
-	.dirty_folio		= filemap_dirty_folio,
+	.dirty_folio		= iomap_dirty_folio,
 	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.migrate_folio		= filemap_migrate_folio,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0f8123504e5e..0c2bee80565c 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -264,6 +264,7 @@ bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
+bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
--
2.39.2

