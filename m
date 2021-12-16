Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F75477E4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241796AbhLPVHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241564AbhLPVHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7884C061746;
        Thu, 16 Dec 2021 13:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=brFu0TnND3ObB8135/CA0Jr2diuWF9QZkemiu9T/Pbc=; b=OeF9rxtDp6pyNC/mhfnEC6yh/L
        gLaCWQSeYhhFyvz5mPHkqBaMAIL4pAcxBdYtDZlm6MYGgwyW0YfDc66Wg8GUOjqt99bCA+Ew5/c+J
        v2cLsmHWmAR9xxTTcjxZ/8arSqZ1zA6B0cSDX2anPk5EkyeG2rMV4FnVi4CSIc/gncamfPrVFHgKh
        R0KDB6IfEP8JoQqRTfLF13kus6sp3fX/98X65JeXtLScyhWf5IWg47vO2qET16lcf1QFbZFI5Sz9u
        istS5zp+usjlVHoXTT7v4guDKsDSOmBzMXwmG+pvE6OGA5qiTE3X3/7TCAXfJg8d1MHBrDM2yfUeD
        tOwNbG+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyC-00Fx3y-4h; Thu, 16 Dec 2021 21:07:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 11/25] iomap: Use folio offsets instead of page offsets
Date:   Thu, 16 Dec 2021 21:07:01 +0000
Message-Id: <20211216210715.3801857-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass a folio around instead of the page, and make sure the offset
is relative to the start of the folio instead of the start of a page.
Also use size_t for offset & length to make it clear that these are byte
counts, and to support >2GB folios in the future.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 78 ++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5730a3317407..06ff80c05340 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -75,18 +75,18 @@ static void iomap_page_release(struct folio *folio)
 }
 
 /*
- * Calculate the range inside the page that we actually need to read.
+ * Calculate the range inside the folio that we actually need to read.
  */
-static void
-iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
-		loff_t *pos, loff_t length, unsigned *offp, unsigned *lenp)
+static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
+		loff_t *pos, loff_t length, size_t *offp, size_t *lenp)
 {
+	struct iomap_page *iop = to_iomap_page(folio);
 	loff_t orig_pos = *pos;
 	loff_t isize = i_size_read(inode);
 	unsigned block_bits = inode->i_blkbits;
 	unsigned block_size = (1 << block_bits);
-	unsigned poff = offset_in_page(*pos);
-	unsigned plen = min_t(loff_t, PAGE_SIZE - poff, length);
+	size_t poff = offset_in_folio(folio, *pos);
+	size_t plen = min_t(loff_t, folio_size(folio) - poff, length);
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
 
@@ -124,7 +124,7 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	 * page cache for blocks that are entirely outside of i_size.
 	 */
 	if (orig_pos <= isize && orig_pos + length > isize) {
-		unsigned end = offset_in_page(isize - 1) >> block_bits;
+		unsigned end = offset_in_folio(folio, isize - 1) >> block_bits;
 
 		if (first <= end && last > end)
 			plen -= (last - end) * block_size;
@@ -134,31 +134,31 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	*lenp = plen;
 }
 
-static void iomap_iop_set_range_uptodate(struct page *page,
-		struct iomap_page *iop, unsigned off, unsigned len)
+static void iomap_iop_set_range_uptodate(struct folio *folio,
+		struct iomap_page *iop, size_t off, size_t len)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	unsigned first = off >> inode->i_blkbits;
 	unsigned last = (off + len - 1) >> inode->i_blkbits;
 	unsigned long flags;
 
 	spin_lock_irqsave(&iop->uptodate_lock, flags);
 	bitmap_set(iop->uptodate, first, last - first + 1);
-	if (bitmap_full(iop->uptodate, i_blocks_per_page(inode, page)))
-		SetPageUptodate(page);
+	if (bitmap_full(iop->uptodate, i_blocks_per_folio(inode, folio)))
+		folio_mark_uptodate(folio);
 	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
 }
 
-static void iomap_set_range_uptodate(struct page *page,
-		struct iomap_page *iop, unsigned off, unsigned len)
+static void iomap_set_range_uptodate(struct folio *folio,
+		struct iomap_page *iop, size_t off, size_t len)
 {
-	if (PageError(page))
+	if (folio_test_error(folio))
 		return;
 
 	if (iop)
-		iomap_iop_set_range_uptodate(page, iop, off, len);
+		iomap_iop_set_range_uptodate(folio, iop, off, len);
 	else
-		SetPageUptodate(page);
+		folio_mark_uptodate(folio);
 }
 
 static void iomap_finish_folio_read(struct folio *folio, size_t offset,
@@ -170,7 +170,7 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		folio_clear_uptodate(folio);
 		folio_set_error(folio);
 	} else {
-		iomap_set_range_uptodate(&folio->page, iop, offset, len);
+		iomap_set_range_uptodate(folio, iop, offset, len);
 	}
 
 	if (!iop || atomic_sub_and_test(len, &iop->read_bytes_pending))
@@ -211,6 +211,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
 	size_t poff = offset_in_page(iomap->offset);
+	size_t offset = offset_in_folio(folio, iomap->offset);
 	void *addr;
 
 	if (PageUptodate(page))
@@ -223,7 +224,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 		return -EIO;
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
-	if (poff > 0)
+	if (offset > 0)
 		iop = iomap_page_create(iter->inode, folio);
 	else
 		iop = to_iomap_page(folio);
@@ -232,7 +233,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_local(addr);
-	iomap_set_range_uptodate(page, iop, poff, PAGE_SIZE - poff);
+	iomap_set_range_uptodate(folio, iop, offset, PAGE_SIZE - poff);
 	return 0;
 }
 
@@ -256,7 +257,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	struct folio *folio = page_folio(page);
 	struct iomap_page *iop;
 	loff_t orig_pos = pos;
-	unsigned poff, plen;
+	size_t poff, plen;
 	sector_t sector;
 
 	if (iomap->type == IOMAP_INLINE)
@@ -264,13 +265,13 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 	/* zero post-eof blocks as the page may be mapped */
 	iop = iomap_page_create(iter->inode, folio);
-	iomap_adjust_read_range(iter->inode, iop, &pos, length, &poff, &plen);
+	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
 
 	if (iomap_block_needs_zeroing(iter, pos)) {
-		zero_user(page, poff, plen);
-		iomap_set_range_uptodate(page, iop, poff, plen);
+		folio_zero_range(folio, poff, plen);
+		iomap_set_range_uptodate(folio, iop, poff, plen);
 		goto done;
 	}
 
@@ -281,7 +282,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	sector = iomap_sector(iomap, pos);
 	if (!ctx->bio ||
 	    bio_end_sector(ctx->bio) != sector ||
-	    bio_add_page(ctx->bio, page, plen, poff) != plen) {
+	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
 		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
@@ -305,8 +306,9 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		ctx->bio->bi_iter.bi_sector = sector;
 		bio_set_dev(ctx->bio, iomap->bdev);
 		ctx->bio->bi_end_io = iomap_read_end_io;
-		__bio_add_page(ctx->bio, page, plen, poff);
+		bio_add_folio(ctx->bio, folio, plen, poff);
 	}
+
 done:
 	/*
 	 * Move the caller beyond our range so that it keeps making progress.
@@ -535,9 +537,8 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 		truncate_pagecache_range(inode, max(pos, i_size), pos + len);
 }
 
-static int
-iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
-		unsigned plen, const struct iomap *iomap)
+static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
+		size_t poff, size_t plen, const struct iomap *iomap)
 {
 	struct bio_vec bvec;
 	struct bio bio;
@@ -546,7 +547,7 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
 	bio.bi_opf = REQ_OP_READ;
 	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
 	bio_set_dev(&bio, iomap->bdev);
-	__bio_add_page(&bio, page, plen, poff);
+	bio_add_folio(&bio, folio, plen, poff);
 	return submit_bio_wait(&bio);
 }
 
@@ -559,14 +560,15 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	loff_t block_size = i_blocksize(iter->inode);
 	loff_t block_start = round_down(pos, block_size);
 	loff_t block_end = round_up(pos + len, block_size);
-	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
+	size_t from = offset_in_folio(folio, pos), to = from + len;
+	size_t poff, plen;
 
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		return 0;
-	ClearPageError(page);
+	folio_clear_error(folio);
 
 	do {
-		iomap_adjust_read_range(iter->inode, iop, &block_start,
+		iomap_adjust_read_range(iter->inode, folio, &block_start,
 				block_end - block_start, &poff, &plen);
 		if (plen == 0)
 			break;
@@ -579,14 +581,14 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		if (iomap_block_needs_zeroing(iter, block_start)) {
 			if (WARN_ON_ONCE(iter->flags & IOMAP_UNSHARE))
 				return -EIO;
-			zero_user_segments(page, poff, from, to, poff + plen);
+			folio_zero_segments(folio, poff, from, to, poff + plen);
 		} else {
-			int status = iomap_read_page_sync(block_start, page,
+			int status = iomap_read_folio_sync(block_start, folio,
 					poff, plen, srcmap);
 			if (status)
 				return status;
 		}
-		iomap_set_range_uptodate(page, iop, poff, plen);
+		iomap_set_range_uptodate(folio, iop, poff, plen);
 	} while ((block_start += plen) < block_end);
 
 	return 0;
@@ -675,7 +677,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 */
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
-	iomap_set_range_uptodate(page, iop, offset_in_page(pos), len);
+	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
 	__set_page_dirty_nobuffers(page);
 	return copied;
 }
-- 
2.33.0

