Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D562300AD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 19:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbhAVRWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 12:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729507AbhAVQFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:05:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D43C061793;
        Fri, 22 Jan 2021 08:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Xjym9lcL0CxKzUararhEBi3kSrlAKm+bXyK6l1ORLjE=; b=FGYXtlxIJvPCIiOqQR0M1ZHLC8
        5AzpbpS9EeuHIzh+NMA6ca8Q6lvkmyxYD76jR9JhhKm5iYY0T1e5RbDKFl0UqvrXsWOMQUgVB7S3Z
        BRFoqAtBnRs6K75+ZBBJgEGoPX6eGjXpmF0i8/ZvbMKyvn99zAFOIRmVilDrxZbU8EAl2K1wP8gTJ
        3gzvo8h/XWw5gjt7+CFvumE5tFhnm3qapaF3CnqoKwx/HBe/XL1oDtqDHx0Po1ye6pnQZdbTbGMrK
        jvilDFdzdxnVcMaiHS+1poRQ+fD7xjtEcUgX88MOUXO2Qr46Eh3YY0HI37gxNxGipmSlad74Z0AOT
        zpwbDhQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2yu8-000wCI-H1; Fri, 22 Jan 2021 16:03:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 03/18] mm/filemap: Convert filemap_get_pages to take a pagevec
Date:   Fri, 22 Jan 2021 16:01:25 +0000
Message-Id: <20210122160140.223228-4-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122160140.223228-1-willy@infradead.org>
References: <20210122160140.223228-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Using a pagevec lets us keep the pages and the number of pages together
which simplifies a lot of the calling conventions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 82 ++++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 44 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a5c4f7ddfc40c..ca4141dd63a4b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2338,22 +2338,22 @@ static struct page *filemap_create_page(struct kiocb *iocb,
 }
 
 static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
-		struct page **pages, unsigned int nr)
+		struct pagevec *pvec)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
 	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
-	int i, j, nr_got, err = 0;
+	unsigned int nr = min_t(unsigned long, last_index - index, PAGEVEC_SIZE);
+	int i, j, err = 0;
 
-	nr = min_t(unsigned long, last_index - index, nr);
 find_page:
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
-	nr_got = find_get_pages_contig(mapping, index, nr, pages);
-	if (nr_got)
+	pvec->nr = find_get_pages_contig(mapping, index, nr, pvec->pages);
+	if (pvec->nr)
 		goto got_pages;
 
 	if (iocb->ki_flags & IOCB_NOIO)
@@ -2361,17 +2361,17 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 
 	page_cache_sync_readahead(mapping, ra, filp, index, last_index - index);
 
-	nr_got = find_get_pages_contig(mapping, index, nr, pages);
-	if (nr_got)
+	pvec->nr = find_get_pages_contig(mapping, index, nr, pvec->pages);
+	if (pvec->nr)
 		goto got_pages;
 
-	pages[0] = filemap_create_page(iocb, iter);
-	err = PTR_ERR_OR_ZERO(pages[0]);
-	if (!IS_ERR_OR_NULL(pages[0]))
-		nr_got = 1;
+	pvec->pages[0] = filemap_create_page(iocb, iter);
+	err = PTR_ERR_OR_ZERO(pvec->pages[0]);
+	if (!IS_ERR_OR_NULL(pvec->pages[0]))
+		pvec->nr = 1;
 got_pages:
-	for (i = 0; i < nr_got; i++) {
-		struct page *page = pages[i];
+	for (i = 0; i < pvec->nr; i++) {
+		struct page *page = pvec->pages[i];
 		pgoff_t pg_index = index + i;
 		loff_t pg_pos = max(iocb->ki_pos,
 				    (loff_t) pg_index << PAGE_SHIFT);
@@ -2379,9 +2379,9 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 
 		if (PageReadahead(page)) {
 			if (iocb->ki_flags & IOCB_NOIO) {
-				for (j = i; j < nr_got; j++)
-					put_page(pages[j]);
-				nr_got = i;
+				for (j = i; j < pvec->nr; j++)
+					put_page(pvec->pages[j]);
+				pvec->nr = i;
 				err = -EAGAIN;
 				break;
 			}
@@ -2392,9 +2392,9 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 		if (!PageUptodate(page)) {
 			if ((iocb->ki_flags & IOCB_NOWAIT) ||
 			    ((iocb->ki_flags & IOCB_WAITQ) && i)) {
-				for (j = i; j < nr_got; j++)
-					put_page(pages[j]);
-				nr_got = i;
+				for (j = i; j < pvec->nr; j++)
+					put_page(pvec->pages[j]);
+				pvec->nr = i;
 				err = -EAGAIN;
 				break;
 			}
@@ -2402,17 +2402,17 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 			page = filemap_update_page(iocb, filp, iter, page,
 					pg_pos, pg_count);
 			if (IS_ERR_OR_NULL(page)) {
-				for (j = i + 1; j < nr_got; j++)
-					put_page(pages[j]);
-				nr_got = i;
+				for (j = i + 1; j < pvec->nr; j++)
+					put_page(pvec->pages[j]);
+				pvec->nr = i;
 				err = PTR_ERR_OR_ZERO(page);
 				break;
 			}
 		}
 	}
 
-	if (likely(nr_got))
-		return nr_got;
+	if (likely(pvec->nr))
+		return 0;
 	if (err)
 		return err;
 	/*
@@ -2444,11 +2444,8 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	struct file_ra_state *ra = &filp->f_ra;
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
-	struct page *pages[PAGEVEC_SIZE];
-	unsigned int nr_pages = min_t(unsigned int, PAGEVEC_SIZE,
-			((iocb->ki_pos + iter->count + PAGE_SIZE - 1) >> PAGE_SHIFT) -
-			(iocb->ki_pos >> PAGE_SHIFT));
-	int i, pg_nr, error = 0;
+	struct pagevec pvec;
+	int i, error = 0;
 	bool writably_mapped;
 	loff_t isize, end_offset;
 
@@ -2470,12 +2467,9 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		if ((iocb->ki_flags & IOCB_WAITQ) && written)
 			iocb->ki_flags |= IOCB_NOWAIT;
 
-		i = 0;
-		pg_nr = filemap_get_pages(iocb, iter, pages, nr_pages);
-		if (pg_nr < 0) {
-			error = pg_nr;
+		error = filemap_get_pages(iocb, iter, &pvec);
+		if (error < 0)
 			break;
-		}
 
 		/*
 		 * i_size must be checked after we know the pages are Uptodate.
@@ -2491,9 +2485,9 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
 
-		while ((iocb->ki_pos >> PAGE_SHIFT) + pg_nr >
+		while ((iocb->ki_pos >> PAGE_SHIFT) + pvec.nr >
 		       (end_offset + PAGE_SIZE - 1) >> PAGE_SHIFT)
-			put_page(pages[--pg_nr]);
+			put_page(pvec.pages[--pvec.nr]);
 
 		/*
 		 * Once we start copying data, we don't want to be touching any
@@ -2507,11 +2501,11 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		 */
 		if (iocb->ki_pos >> PAGE_SHIFT !=
 		    ra->prev_pos >> PAGE_SHIFT)
-			mark_page_accessed(pages[0]);
-		for (i = 1; i < pg_nr; i++)
-			mark_page_accessed(pages[i]);
+			mark_page_accessed(pvec.pages[0]);
+		for (i = 1; i < pagevec_count(&pvec); i++)
+			mark_page_accessed(pvec.pages[i]);
 
-		for (i = 0; i < pg_nr; i++) {
+		for (i = 0; i < pagevec_count(&pvec); i++) {
 			unsigned int offset = iocb->ki_pos & ~PAGE_MASK;
 			unsigned int bytes = min_t(loff_t, end_offset - iocb->ki_pos,
 						   PAGE_SIZE - offset);
@@ -2523,9 +2517,9 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			 * before reading the page on the kernel side.
 			 */
 			if (writably_mapped)
-				flush_dcache_page(pages[i]);
+				flush_dcache_page(pvec.pages[i]);
 
-			copied = copy_page_to_iter(pages[i], offset, bytes, iter);
+			copied = copy_page_to_iter(pvec.pages[i], offset, bytes, iter);
 
 			written += copied;
 			iocb->ki_pos += copied;
@@ -2537,8 +2531,8 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			}
 		}
 put_pages:
-		for (i = 0; i < pg_nr; i++)
-			put_page(pages[i]);
+		for (i = 0; i < pagevec_count(&pvec); i++)
+			put_page(pvec.pages[i]);
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
 	file_accessed(filp);
-- 
2.29.2

