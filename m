Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DFC3C4277
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhGLEBu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhGLEBt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:01:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462B5C0613DD;
        Sun, 11 Jul 2021 20:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ea/QIlxXw9uUW6cCIw/qOOsVoSYB6cWoOzFrY4etEI0=; b=gMPVJBlKxovOGa0WiKl4XNVnJK
        z+FblfpOsOPMIeFjt+J82ISw12v6aKoRukHPFn4ukPrA/o0SMQQAATIQIJooqEwqmbOs7MR7zuLVe
        5uKhbTsdMjeeMd8cBrWYWMoZMlJc1+2oo5xrIs+De5l8vUCoKZ/7aUB7Tlj/5KeHMRWVuAhY2A7/t
        L7dQsKStfrjK0Vww7IW7nzv1LkkEKDUIQg9oKyzIUS8aQ3NHZmkUmor/Mko+a7lfjrO/werIGfHRW
        e1ngtIdeLyD92+cqQ7C0TO7Fi9kJswdqt677kwW/5YJ6v8MI12X/KSSQvmna0Hw8tSbiwEuixBZpb
        WD+P4slw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2n4q-00GqNc-0j; Mon, 12 Jul 2021 03:57:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 097/137] iomap: Use folio offsets instead of page offsets
Date:   Mon, 12 Jul 2021 04:06:21 +0100
Message-Id: <20210712030701.4000097-98-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
---
 fs/iomap/buffered-io.c | 85 ++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c5bdd1c0d480..3a0572ee10dc 100644
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
+	if (folio_error(folio))
 		return;
 
 	if (iop)
-		iomap_iop_set_range_uptodate(page, iop, off, len);
+		iomap_iop_set_range_uptodate(folio, iop, off, len);
 	else
-		SetPageUptodate(page);
+		folio_mark_uptodate(folio);
 }
 
 static void
@@ -169,15 +169,17 @@ iomap_read_page_end_io(struct bio_vec *bvec, int error)
 	struct iomap_page *iop = to_iomap_page(folio);
 
 	if (unlikely(error)) {
-		ClearPageUptodate(page);
-		SetPageError(page);
+		folio_clear_uptodate_flag(folio);
+		folio_set_error_flag(folio);
 	} else {
-		iomap_set_range_uptodate(page, iop, bvec->bv_offset,
-						bvec->bv_len);
+		size_t off = (page - &folio->page) * PAGE_SIZE +
+				bvec->bv_offset;
+
+		iomap_set_range_uptodate(folio, iop, off, bvec->bv_len);
 	}
 
 	if (!iop || atomic_sub_and_test(bvec->bv_len, &iop->read_bytes_pending))
-		unlock_page(page);
+		folio_unlock(folio);
 }
 
 static void
@@ -237,7 +239,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	struct iomap_page *iop = iomap_page_create(inode, folio);
 	bool same_page = false, is_contig = false;
 	loff_t orig_pos = pos;
-	unsigned poff, plen;
+	size_t poff, plen;
 	sector_t sector;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -246,14 +248,14 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		return PAGE_SIZE;
 	}
 
-	/* zero post-eof blocks as the page may be mapped */
-	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
+	/* zero post-eof blocks as the folio may be mapped */
+	iomap_adjust_read_range(inode, folio, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
 
 	if (iomap_block_needs_zeroing(inode, iomap, pos)) {
-		zero_user(page, poff, plen);
-		iomap_set_range_uptodate(page, iop, poff, plen);
+		zero_user(&folio->page, poff, plen);
+		iomap_set_range_uptodate(folio, iop, poff, plen);
 		goto done;
 	}
 
@@ -264,7 +266,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	/* Try to merge into a previous segment if we can */
 	sector = iomap_sector(iomap, pos);
 	if (ctx->bio && bio_end_sector(ctx->bio) == sector) {
-		if (__bio_try_merge_page(ctx->bio, page, plen, poff,
+		if (__bio_try_merge_page(ctx->bio, &folio->page, plen, poff,
 				&same_page))
 			goto done;
 		is_contig = true;
@@ -296,7 +298,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		ctx->bio->bi_end_io = iomap_read_end_io;
 	}
 
-	bio_add_page(ctx->bio, page, plen, poff);
+	bio_add_folio(ctx->bio, folio, plen, poff);
 done:
 	/*
 	 * Move the caller beyond our range so that it keeps making progress.
@@ -531,9 +533,8 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 		truncate_pagecache_range(inode, max(pos, i_size), pos + len);
 }
 
-static int
-iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
-		unsigned plen, struct iomap *iomap)
+static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
+		size_t poff, size_t plen, struct iomap *iomap)
 {
 	struct bio_vec bvec;
 	struct bio bio;
@@ -542,7 +543,7 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
 	bio.bi_opf = REQ_OP_READ;
 	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
 	bio_set_dev(&bio, iomap->bdev);
-	__bio_add_page(&bio, page, plen, poff);
+	bio_add_folio(&bio, folio, plen, poff);
 	return submit_bio_wait(&bio);
 }
 
@@ -555,14 +556,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 	loff_t block_size = i_blocksize(inode);
 	loff_t block_start = round_down(pos, block_size);
 	loff_t block_end = round_up(pos + len, block_size);
-	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
+	size_t from = offset_in_folio(folio, pos), to = from + len;
+	size_t poff, plen;
 
-	if (PageUptodate(page))
+	if (folio_uptodate(folio))
 		return 0;
-	ClearPageError(page);
+	folio_clear_error_flag(folio);
 
 	do {
-		iomap_adjust_read_range(inode, iop, &block_start,
+		iomap_adjust_read_range(inode, folio, &block_start,
 				block_end - block_start, &poff, &plen);
 		if (plen == 0)
 			break;
@@ -575,14 +577,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 		if (iomap_block_needs_zeroing(inode, srcmap, block_start)) {
 			if (WARN_ON_ONCE(flags & IOMAP_WRITE_F_UNSHARE))
 				return -EIO;
-			zero_user_segments(page, poff, from, to, poff + plen);
+			zero_user_segments(&folio->page, poff, from, to,
+						poff + plen);
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
@@ -661,7 +664,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 */
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
-	iomap_set_range_uptodate(page, iop, offset_in_page(pos), len);
+	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
 	__set_page_dirty_nobuffers(page);
 	return copied;
 }
-- 
2.30.2

