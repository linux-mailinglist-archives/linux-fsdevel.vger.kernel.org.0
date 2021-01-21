Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8BD2FE0A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 05:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbhAUE2r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 23:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbhAUEUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:20:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83966C0613CF
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 20:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=L98AvtRRfMSZtNPTvzBpgz3ODjvoUy+Vto4L3TpgwO8=; b=MVZriXLyKf0fin9blkD1JfCQTt
        ySnA5PbixSpaxKT/Tsu+TOv1b5Rl3/q5CPvEibWrMw1OuA2/qEnpw8txCZWADSUVVomR+RN5/ZVMq
        48Dv6Bz+b+kY7emV2pGkgyLqHZj3qDDmYgJblv8fwjMOvjReH6XPweoItlZY+Nz0giJ4LubAjgJpI
        o/VYzscw4hVonHpd8UmWW9qr/144nIl+U9njeNwxJOM1gUcKsNycIsbYokxmlrmOgBqscULLYRzV7
        t1X76moCTNHOcKsZtI1kfiHe6a6Z2ZpekXk+5nX/JvgqOzH+/4FyS6sfhYF+x/pVbmxWM8JCl9I0g
        yfbSGp+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2RQv-00GbFC-3P; Thu, 21 Jan 2021 04:19:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v4 04/18] mm/filemap: Use head pages in generic_file_buffered_read
Date:   Thu, 21 Jan 2021 04:16:02 +0000
Message-Id: <20210121041616.3955703-5-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121041616.3955703-1-willy@infradead.org>
References: <20210121041616.3955703-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add filemap_get_read_batch() which returns the head pages which represent
a contiguous array of bytes in the file.  It also stops when encountering
a page marked as Readahead or !Uptodate (but does return that page)
so it can be handled appropriately by filemap_get_pages().  That lets
us remove the loop in filemap_get_pages() and check only the last page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 122 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 85 insertions(+), 37 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9e1e2bbac8fc9..3e6fae3208906 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2168,6 +2168,51 @@ static int lock_page_for_iocb(struct kiocb *iocb, struct page *page)
 		return lock_page_killable(page);
 }
 
+/*
+ * filemap_get_read_batch - Get a batch of pages for read
+ *
+ * Get a batch of pages which represent a contiguous range of bytes
+ * in the file.  No tail pages will be returned.  If @index is in the
+ * middle of a THP, the entire THP will be returned.  The last page in
+ * the batch may have Readahead set or be not Uptodate so that the
+ * caller can take the appropriate action.
+ */
+static void filemap_get_read_batch(struct address_space *mapping,
+		pgoff_t index, pgoff_t max, struct pagevec *pvec)
+{
+	XA_STATE(xas, &mapping->i_pages, index);
+	struct page *head;
+
+	rcu_read_lock();
+	for (head = xas_load(&xas); head; head = xas_next(&xas)) {
+		if (xas_retry(&xas, head))
+			continue;
+		if (xas.xa_index > max || xa_is_value(head))
+			break;
+		if (!page_cache_get_speculative(head))
+			goto retry;
+
+		/* Has the page moved or been split? */
+		if (unlikely(head != xas_reload(&xas)))
+			goto put_page;
+
+		if (!pagevec_add(pvec, head))
+			break;
+		if (!PageUptodate(head))
+			break;
+		if (PageReadahead(head))
+			break;
+		xas.xa_index = head->index + thp_nr_pages(head) - 1;
+		xas.xa_offset = (xas.xa_index >> xas.xa_shift) & XA_CHUNK_MASK;
+		continue;
+put_page:
+		put_page(head);
+retry:
+		xas_reset(&xas);
+	}
+	rcu_read_unlock();
+}
+
 static struct page *filemap_read_page(struct kiocb *iocb, struct file *filp,
 		struct address_space *mapping, struct page *page)
 {
@@ -2321,15 +2366,15 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	struct address_space *mapping = filp->f_mapping;
 	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
-	pgoff_t last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
-	unsigned int nr = min_t(unsigned long, last_index - index, PAGEVEC_SIZE);
-	int i, j, err = 0;
+	pgoff_t last_index;
+	int err = 0;
 
+	last_index = DIV_ROUND_UP(iocb->ki_pos + iter->count, PAGE_SIZE);
 find_page:
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
-	pvec->nr = find_get_pages_contig(mapping, index, nr, pvec->pages);
+	filemap_get_read_batch(mapping, index, last_index, pvec);
 	if (pvec->nr)
 		goto got_pages;
 
@@ -2338,29 +2383,30 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 
 	page_cache_sync_readahead(mapping, ra, filp, index, last_index - index);
 
-	pvec->nr = find_get_pages_contig(mapping, index, nr, pvec->pages);
+	filemap_get_read_batch(mapping, index, last_index, pvec);
 	if (pvec->nr)
 		goto got_pages;
 
 	pvec->pages[0] = filemap_create_page(iocb, iter);
 	err = PTR_ERR_OR_ZERO(pvec->pages[0]);
-	if (!IS_ERR_OR_NULL(pvec->pages[0]))
-		pvec->nr = 1;
+	if (IS_ERR_OR_NULL(pvec->pages[0]))
+		goto err;
+	pvec->nr = 1;
+	return 0;
 got_pages:
-	for (i = 0; i < pvec->nr; i++) {
-		struct page *page = pvec->pages[i];
-		pgoff_t pg_index = index + i;
+	{
+		struct page *page = pvec->pages[pvec->nr - 1];
+		pgoff_t pg_index = page->index;
 		loff_t pg_pos = max(iocb->ki_pos,
 				    (loff_t) pg_index << PAGE_SHIFT);
 		loff_t pg_count = iocb->ki_pos + iter->count - pg_pos;
 
 		if (PageReadahead(page)) {
 			if (iocb->ki_flags & IOCB_NOIO) {
-				for (j = i; j < pvec->nr; j++)
-					put_page(pvec->pages[j]);
-				pvec->nr = i;
+				put_page(page);
+				pvec->nr--;
 				err = -EAGAIN;
-				break;
+				goto err;
 			}
 			page_cache_async_readahead(mapping, ra, filp, page,
 					pg_index, last_index - pg_index);
@@ -2368,26 +2414,23 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 
 		if (!PageUptodate(page)) {
 			if ((iocb->ki_flags & IOCB_NOWAIT) ||
-			    ((iocb->ki_flags & IOCB_WAITQ) && i)) {
-				for (j = i; j < pvec->nr; j++)
-					put_page(pvec->pages[j]);
-				pvec->nr = i;
+			    ((iocb->ki_flags & IOCB_WAITQ) && pvec->nr > 1)) {
+				put_page(page);
+				pvec->nr--;
 				err = -EAGAIN;
-				break;
+				goto err;
 			}
 
 			page = filemap_update_page(iocb, filp, iter, page,
 					pg_pos, pg_count);
 			if (IS_ERR_OR_NULL(page)) {
-				for (j = i + 1; j < pvec->nr; j++)
-					put_page(pvec->pages[j]);
-				pvec->nr = i;
+				pvec->nr--;
 				err = PTR_ERR_OR_ZERO(page);
-				break;
 			}
 		}
 	}
 
+err:
 	if (likely(pvec->nr))
 		return 0;
 	if (err)
@@ -2429,6 +2472,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
 		return 0;
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
+	pagevec_init(&pvec);
 
 	do {
 		cond_resched();
@@ -2456,13 +2500,8 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		isize = i_size_read(inode);
 		if (unlikely(iocb->ki_pos >= isize))
 			goto put_pages;
-
 		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
 
-		while ((iocb->ki_pos >> PAGE_SHIFT) + pvec.nr >
-		       (end_offset + PAGE_SIZE - 1) >> PAGE_SHIFT)
-			put_page(pvec.pages[--pvec.nr]);
-
 		/*
 		 * Once we start copying data, we don't want to be touching any
 		 * cachelines that might be contended:
@@ -2476,24 +2515,32 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		if (iocb->ki_pos >> PAGE_SHIFT !=
 		    ra->prev_pos >> PAGE_SHIFT)
 			mark_page_accessed(pvec.pages[0]);
-		for (i = 1; i < pagevec_count(&pvec); i++)
-			mark_page_accessed(pvec.pages[i]);
 
 		for (i = 0; i < pagevec_count(&pvec); i++) {
-			unsigned int offset = iocb->ki_pos & ~PAGE_MASK;
-			unsigned int bytes = min_t(loff_t, end_offset - iocb->ki_pos,
-						   PAGE_SIZE - offset);
-			unsigned int copied;
+			struct page *page = pvec.pages[i];
+			size_t page_size = thp_size(page);
+			size_t offset = iocb->ki_pos & (page_size - 1);
+			size_t bytes = min_t(loff_t, end_offset - iocb->ki_pos,
+					     page_size - offset);
+			size_t copied;
 
+			if (end_offset < page_offset(page))
+				break;
+			if (i > 0)
+				mark_page_accessed(page);
 			/*
 			 * If users can be writing to this page using arbitrary
 			 * virtual addresses, take care about potential aliasing
 			 * before reading the page on the kernel side.
 			 */
-			if (writably_mapped)
-				flush_dcache_page(pvec.pages[i]);
+			if (writably_mapped) {
+				int j;
+
+				for (j = 0; j < thp_nr_pages(page); j++)
+					flush_dcache_page(page + j);
+			}
 
-			copied = copy_page_to_iter(pvec.pages[i], offset, bytes, iter);
+			copied = copy_page_to_iter(page, offset, bytes, iter);
 
 			written += copied;
 			iocb->ki_pos += copied;
@@ -2507,6 +2554,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 put_pages:
 		for (i = 0; i < pagevec_count(&pvec); i++)
 			put_page(pvec.pages[i]);
+		pagevec_reinit(&pvec);
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
 	file_accessed(filp);
-- 
2.29.2

