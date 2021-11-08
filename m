Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB23447983
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbhKHEtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbhKHEtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:49:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDCFC061570;
        Sun,  7 Nov 2021 20:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DVot1vNHwqZRyOoHJTft91VC0APAQNYG5u1luYiIyCU=; b=htpplDLgBSHm1pdtEG2o+HuGdt
        aOlebW6btE8FjZE/lDCWQcNqCrwepLEDre5hPxzLDUZmPhWLIAP2SaB6l5kjnlHdZCczCPVXGd1UR
        8C67cOrGY7IlxUn8xC17w7sj0417axXxp9jBSi8YegSuQoHNJgoQIr6SmxAHk9Rr0ovbTTU4s4Gll
        K5ik3DMGwUKxpjHK9QCv90MN27tOeAEyTmYV85jIofvXTxSIpXRrgYJXLVgaHfpaRSNiWQsAQTAWe
        mThT5lBjrbZADQdxmQmWmb8BM/b4OwwMDLHjF2dW8+TbedeEYbUG8dPSUu51UJyxant6/Fy2BCe3F
        xx6ru6EQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwTz-008AJC-Ho; Mon, 08 Nov 2021 04:42:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 15/28] iomap: Use folio offsets instead of page offsets
Date:   Mon,  8 Nov 2021 04:05:38 +0000
Message-Id: <20211108040551.1942823-16-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
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
index bbccb031815e..c7c4ae735620 100644
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
@@ -202,6 +202,7 @@ static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
 	size_t poff = offset_in_page(iomap->offset);
+	size_t offset = offset_in_folio(folio, iomap->offset);
 	void *addr;
 
 	if (PageUptodate(page))
@@ -214,7 +215,7 @@ static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
 		return -EIO;
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
-	if (poff > 0)
+	if (offset > 0)
 		iop = iomap_page_create(iter->inode, folio);
 	else
 		iop = to_iomap_page(folio);
@@ -223,7 +224,7 @@ static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_local(addr);
-	iomap_set_range_uptodate(page, iop, poff, PAGE_SIZE - poff);
+	iomap_set_range_uptodate(folio, iop, offset, PAGE_SIZE - poff);
 	return PAGE_SIZE - poff;
 }
 
@@ -247,7 +248,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	struct folio *folio = page_folio(page);
 	struct iomap_page *iop;
 	loff_t orig_pos = pos;
-	unsigned poff, plen;
+	size_t poff, plen;
 	sector_t sector;
 
 	if (iomap->type == IOMAP_INLINE)
@@ -255,13 +256,13 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
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
 
@@ -272,7 +273,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	sector = iomap_sector(iomap, pos);
 	if (!ctx->bio ||
 	    bio_end_sector(ctx->bio) != sector ||
-	    bio_add_page(ctx->bio, page, plen, poff) != plen) {
+	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
 		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
@@ -296,8 +297,9 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
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
@@ -524,9 +526,8 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
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
@@ -535,7 +536,7 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
 	bio.bi_opf = REQ_OP_READ;
 	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
 	bio_set_dev(&bio, iomap->bdev);
-	__bio_add_page(&bio, page, plen, poff);
+	bio_add_folio(&bio, folio, plen, poff);
 	return submit_bio_wait(&bio);
 }
 
@@ -548,14 +549,15 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
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
@@ -568,14 +570,14 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
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
@@ -669,7 +671,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
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

