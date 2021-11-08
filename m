Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA944799C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbhKHE75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbhKHE75 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:59:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFA4C061570;
        Sun,  7 Nov 2021 20:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EmdbHROb+rTV1VQnL+JR0UeUpFTLI1y3vQA3Rgu/pOc=; b=F9dVP7y8zWosBH3zJxH8nAgUvQ
        xs/P+Y9uxofqS/yi+WMr6/Fl5bx5gC2umnvtP8I8lWTYyw0Zf6wLs9s8ZCChz4Tm8Q38NRD7TU19T
        //PG7IIkFgfBUK20t8LaWI6GdndsiuCOBXRQXlup6b+lo1RxcOon1d0poT0E7KIW6n+fY/Wer8hcD
        FPZLQHKH9NJh+lQmXo2by9Dhy2rOVvb6et6of50DLgapHtQiVhOsBNhuwE7nawSY8z6RiHi6M2F1b
        hJQOyqsc2yklUH7H9V83b1Zf7ytcYKR4yBs8YPPUgTvHk8pn0K061SnDmopuw9BiwKqxDeE39VKoA
        MVS45SXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwdX-008AWq-D1; Mon, 08 Nov 2021 04:52:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 20/28] iomap: Convert iomap_write_begin() and iomap_write_end() to folios
Date:   Mon,  8 Nov 2021 04:05:43 +0000
Message-Id: <20211108040551.1942823-21-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These functions still only work in PAGE_SIZE chunks, but there are
fewer conversions from tail to head pages as a result of this patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 66 ++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9c61d12028ca..f4ae200adc4c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -539,9 +539,8 @@ static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
 }
 
 static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
-		unsigned len, struct page *page)
+		size_t len, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct iomap_page *iop = iomap_page_create(iter->inode, folio);
 	loff_t block_size = i_blocksize(iter->inode);
@@ -582,9 +581,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 }
 
 static int iomap_write_begin_inline(const struct iomap_iter *iter,
-		struct page *page)
+		struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	int ret;
 
 	/* needs more work for the tailpacking case; disable for now */
@@ -597,12 +595,12 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
 }
 
 static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
-		unsigned len, struct page **pagep)
+		size_t len, struct folio **foliop)
 {
 	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	struct page *page;
 	struct folio *folio;
+	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
 	int status = 0;
 
 	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
@@ -618,30 +616,29 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 			return status;
 	}
 
-	page = grab_cache_page_write_begin(iter->inode->i_mapping,
-				pos >> PAGE_SHIFT, AOP_FLAG_NOFS);
-	if (!page) {
+	folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
+			fgp, mapping_gfp_mask(iter->inode->i_mapping));
+	if (!folio) {
 		status = -ENOMEM;
 		goto out_no_page;
 	}
-	folio = page_folio(page);
 
 	if (srcmap->type == IOMAP_INLINE)
-		status = iomap_write_begin_inline(iter, page);
+		status = iomap_write_begin_inline(iter, folio);
 	else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(folio, pos, len, NULL, srcmap);
 	else
-		status = __iomap_write_begin(iter, pos, len, page);
+		status = __iomap_write_begin(iter, pos, len, folio);
 
 	if (unlikely(status))
 		goto out_unlock;
 
-	*pagep = page;
+	*foliop = folio;
 	return 0;
 
 out_unlock:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	iomap_write_failed(iter->inode, pos, len);
 
 out_no_page:
@@ -651,11 +648,10 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 }
 
 static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
-		size_t copied, struct page *page)
+		size_t copied, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct iomap_page *iop = to_iomap_page(folio);
-	flush_dcache_page(page);
+	flush_dcache_folio(folio);
 
 	/*
 	 * The blocks that were entirely written will now be uptodate, so we
@@ -668,10 +664,10 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 * non-uptodate page as a zero-length write, and force the caller to
 	 * redo the whole thing.
 	 */
-	if (unlikely(copied < len && !PageUptodate(page)))
+	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return 0;
 	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
-	__set_page_dirty_nobuffers(page);
+	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
 }
 
@@ -695,7 +691,7 @@ static size_t iomap_write_end_inline(const struct iomap_iter *iter,
 
 /* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
 static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
-		size_t copied, struct page *page)
+		size_t copied, struct folio *folio)
 {
 	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -706,9 +702,9 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		ret = iomap_write_end_inline(iter, page, pos, copied);
 	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
 		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
-				copied, page, NULL);
+				copied, &folio->page, NULL);
 	} else {
-		ret = __iomap_write_end(iter->inode, pos, len, copied, page);
+		ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
 	}
 
 	/*
@@ -720,13 +716,13 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		i_size_write(iter->inode, pos + ret);
 		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
 	}
-	unlock_page(page);
+	folio_unlock(folio);
 
 	if (old_size < pos)
 		pagecache_isize_extended(iter->inode, old_size, pos);
 	if (page_ops && page_ops->page_done)
-		page_ops->page_done(iter->inode, pos, ret, page);
-	put_page(page);
+		page_ops->page_done(iter->inode, pos, ret, &folio->page);
+	folio_put(folio);
 
 	if (ret < len)
 		iomap_write_failed(iter->inode, pos, len);
@@ -741,6 +737,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 	long status = 0;
 
 	do {
+		struct folio *folio;
 		struct page *page;
 		unsigned long offset;	/* Offset into pagecache page */
 		unsigned long bytes;	/* Bytes to write to page */
@@ -764,16 +761,17 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			break;
 		}
 
-		status = iomap_write_begin(iter, pos, bytes, &page);
+		status = iomap_write_begin(iter, pos, bytes, &folio);
 		if (unlikely(status))
 			break;
 
+		page = folio_file_page(folio, pos >> PAGE_SHIFT);
 		if (mapping_writably_mapped(iter->inode->i_mapping))
 			flush_dcache_page(page);
 
 		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
 
-		status = iomap_write_end(iter, pos, bytes, copied, page);
+		status = iomap_write_end(iter, pos, bytes, copied, folio);
 
 		if (unlikely(copied != status))
 			iov_iter_revert(i, copied - status);
@@ -839,13 +837,13 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 	do {
 		unsigned long offset = offset_in_page(pos);
 		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
-		struct page *page;
+		struct folio *folio;
 
-		status = iomap_write_begin(iter, pos, bytes, &page);
+		status = iomap_write_begin(iter, pos, bytes, &folio);
 		if (unlikely(status))
 			return status;
 
-		status = iomap_write_end(iter, pos, bytes, bytes, page);
+		status = iomap_write_end(iter, pos, bytes, bytes, folio);
 		if (WARN_ON_ONCE(status == 0))
 			return -EIO;
 
@@ -882,21 +880,19 @@ EXPORT_SYMBOL_GPL(iomap_file_unshare);
 static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
 {
 	struct folio *folio;
-	struct page *page;
 	int status;
 	size_t offset, bytes;
 
-	status = iomap_write_begin(iter, pos, length, &page);
+	status = iomap_write_begin(iter, pos, length, &folio);
 	if (status)
 		return status;
-	folio = page_folio(page);
 
 	offset = offset_in_folio(folio, pos);
 	bytes = min_t(u64, folio_size(folio) - offset, length);
 	folio_zero_range(folio, offset, bytes);
 	folio_mark_accessed(folio);
 
-	return iomap_write_end(iter, pos, bytes, bytes, page);
+	return iomap_write_end(iter, pos, bytes, bytes, folio);
 }
 
 static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
-- 
2.33.0

