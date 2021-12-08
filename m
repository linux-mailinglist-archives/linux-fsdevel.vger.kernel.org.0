Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC80546CC6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbhLHE1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244183AbhLHE0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22554C0617A1
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gaCPSqljRYIcG8B5kqR4NUVjXXOP3yiRv/GkZidMzj4=; b=S5ZLi4rSMuQa9yPXFQS4hNHrCv
        4ViEp2NFC2FO7kcsVp72QAHCUhSUFasNqc+cD4nw6Xu22PvDhg9oIQ/f4tY5HKwzVqj4u3sGmirEn
        mx3R/o12jzsmFAORORDzUQ8w1PhePn72F2VMVXXotSN68WWLb6cQIWfPPi96mAZSgnqduPpLMbc6+
        ksnM1SelAri6bEB9c3YBESfyp8C8Lv+8WGOW0ZcGngZFBZ4Pl8E4JiC4Q4eAQh4WWmy5uDEt9MRSS
        /i2RMwSdzo/Vo6l8YMMpUjBEoC8Pwe16IY8dLFR5WHCCJfDpYbgT/fqSnh2KbV3iTXgFU/5gpCVQq
        CzmgjyOw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU7-0084cX-6x; Wed, 08 Dec 2021 04:23:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 40/48] filemap: Convert filemap_get_read_batch() to use a folio_batch
Date:   Wed,  8 Dec 2021 04:22:48 +0000
Message-Id: <20211208042256.1923824-41-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This change ripples all the way through the filemap_read() call chain and
removes a lot of messing about converting folios to pages and back again.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 65 ++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 91399027b349..38726ca96f0e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2325,16 +2325,16 @@ static void shrink_readahead_size_eio(struct file_ra_state *ra)
 }
 
 /*
- * filemap_get_read_batch - Get a batch of pages for read
+ * filemap_get_read_batch - Get a batch of folios for read
  *
- * Get a batch of pages which represent a contiguous range of bytes
- * in the file.  No tail pages will be returned.  If @index is in the
- * middle of a THP, the entire THP will be returned.  The last page in
- * the batch may have Readahead set or be not Uptodate so that the
- * caller can take the appropriate action.
+ * Get a batch of folios which represent a contiguous range of bytes in
+ * the file.  No exceptional entries will be returned.  If @index is in
+ * the middle of a folio, the entire folio will be returned.  The last
+ * folio in the batch may have the readahead flag set or the uptodate flag
+ * clear so that the caller can take the appropriate action.
  */
 static void filemap_get_read_batch(struct address_space *mapping,
-		pgoff_t index, pgoff_t max, struct pagevec *pvec)
+		pgoff_t index, pgoff_t max, struct folio_batch *fbatch)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	struct folio *folio;
@@ -2349,9 +2349,9 @@ static void filemap_get_read_batch(struct address_space *mapping,
 			goto retry;
 
 		if (unlikely(folio != xas_reload(&xas)))
-			goto put_page;
+			goto put_folio;
 
-		if (!pagevec_add(pvec, &folio->page))
+		if (!folio_batch_add(fbatch, folio))
 			break;
 		if (!folio_test_uptodate(folio))
 			break;
@@ -2360,7 +2360,7 @@ static void filemap_get_read_batch(struct address_space *mapping,
 		xas.xa_index = folio->index + folio_nr_pages(folio) - 1;
 		xas.xa_offset = (xas.xa_index >> xas.xa_shift) & XA_CHUNK_MASK;
 		continue;
-put_page:
+put_folio:
 		folio_put(folio);
 retry:
 		xas_reset(&xas);
@@ -2475,7 +2475,7 @@ static int filemap_update_page(struct kiocb *iocb,
 
 static int filemap_create_folio(struct file *file,
 		struct address_space *mapping, pgoff_t index,
-		struct pagevec *pvec)
+		struct folio_batch *fbatch)
 {
 	struct folio *folio;
 	int error;
@@ -2510,7 +2510,7 @@ static int filemap_create_folio(struct file *file,
 		goto error;
 
 	filemap_invalidate_unlock_shared(mapping);
-	pagevec_add(pvec, &folio->page);
+	folio_batch_add(fbatch, folio);
 	return 0;
 error:
 	filemap_invalidate_unlock_shared(mapping);
@@ -2531,7 +2531,7 @@ static int filemap_readahead(struct kiocb *iocb, struct file *file,
 }
 
 static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
-		struct pagevec *pvec)
+		struct folio_batch *fbatch)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
@@ -2546,32 +2546,33 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
-	filemap_get_read_batch(mapping, index, last_index, pvec);
-	if (!pagevec_count(pvec)) {
+	filemap_get_read_batch(mapping, index, last_index, fbatch);
+	if (!folio_batch_count(fbatch)) {
 		if (iocb->ki_flags & IOCB_NOIO)
 			return -EAGAIN;
 		page_cache_sync_readahead(mapping, ra, filp, index,
 				last_index - index);
-		filemap_get_read_batch(mapping, index, last_index, pvec);
+		filemap_get_read_batch(mapping, index, last_index, fbatch);
 	}
-	if (!pagevec_count(pvec)) {
+	if (!folio_batch_count(fbatch)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
 		err = filemap_create_folio(filp, mapping,
-				iocb->ki_pos >> PAGE_SHIFT, pvec);
+				iocb->ki_pos >> PAGE_SHIFT, fbatch);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;
 	}
 
-	folio = page_folio(pvec->pages[pagevec_count(pvec) - 1]);
+	folio = fbatch->folios[folio_batch_count(fbatch) - 1];
 	if (folio_test_readahead(folio)) {
 		err = filemap_readahead(iocb, filp, mapping, folio, last_index);
 		if (err)
 			goto err;
 	}
 	if (!folio_test_uptodate(folio)) {
-		if ((iocb->ki_flags & IOCB_WAITQ) && pagevec_count(pvec) > 1)
+		if ((iocb->ki_flags & IOCB_WAITQ) &&
+		    folio_batch_count(fbatch) > 1)
 			iocb->ki_flags |= IOCB_NOWAIT;
 		err = filemap_update_page(iocb, mapping, iter, folio);
 		if (err)
@@ -2582,7 +2583,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 err:
 	if (err < 0)
 		folio_put(folio);
-	if (likely(--pvec->nr))
+	if (likely(--fbatch->nr))
 		return 0;
 	if (err == AOP_TRUNCATED_PAGE)
 		goto retry;
@@ -2609,7 +2610,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	struct file_ra_state *ra = &filp->f_ra;
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	int i, error = 0;
 	bool writably_mapped;
 	loff_t isize, end_offset;
@@ -2620,7 +2621,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		return 0;
 
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
 	do {
 		cond_resched();
@@ -2636,7 +2637,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		if (unlikely(iocb->ki_pos >= i_size_read(inode)))
 			break;
 
-		error = filemap_get_pages(iocb, iter, &pvec);
+		error = filemap_get_pages(iocb, iter, &fbatch);
 		if (error < 0)
 			break;
 
@@ -2650,7 +2651,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		 */
 		isize = i_size_read(inode);
 		if (unlikely(iocb->ki_pos >= isize))
-			goto put_pages;
+			goto put_folios;
 		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
 
 		/*
@@ -2665,10 +2666,10 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		 */
 		if (iocb->ki_pos >> PAGE_SHIFT !=
 		    ra->prev_pos >> PAGE_SHIFT)
-			mark_page_accessed(pvec.pages[0]);
+			folio_mark_accessed(fbatch.folios[0]);
 
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct folio *folio = page_folio(pvec.pages[i]);
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			struct folio *folio = fbatch.folios[i];
 			size_t fsize = folio_size(folio);
 			size_t offset = iocb->ki_pos & (fsize - 1);
 			size_t bytes = min_t(loff_t, end_offset - iocb->ki_pos,
@@ -2698,10 +2699,10 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 				break;
 			}
 		}
-put_pages:
-		for (i = 0; i < pagevec_count(&pvec); i++)
-			put_page(pvec.pages[i]);
-		pagevec_reinit(&pvec);
+put_folios:
+		for (i = 0; i < folio_batch_count(&fbatch); i++)
+			folio_put(fbatch.folios[i]);
+		folio_batch_init(&fbatch);
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
 	file_accessed(filp);
-- 
2.33.0

