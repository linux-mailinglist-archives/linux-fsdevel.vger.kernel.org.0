Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322F52A332B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgKBSnV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgKBSnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:43:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0283C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5UKc/Mp3kM/zU/rfSseS3aHyFa9ZSPW/UoKsd9ADFZo=; b=feTu5T5feJ6zWA/qLVIF/Oky/w
        Vw73MyXMDSRqiFT0dZ8OsEhC6QPAguPa6ENwq9UwGL6ktPpxs97kxG+TXQQvrtRK/tt2bZ0A+U4dD
        QtklTvGihf5gEzdukR6R4zA7AAz8jAna/VizB74sImnXFbYD8Il92xNX+O7ETFy7L2pLDTd7MTaoF
        bPITaSSP++gdoSio8+4hir/DP8hql42Eg2wrVEiaYHobVP9r8Cs0yjUdVYixIap95y4eHiplBCS8d
        BDlrNX6nh7b6EfTnWPWeQSGXOSXLWI0+pHjKfkbyKh6BR3oxdpP/LXLXk30HoEcVd2YOuTeQsIxLq
        iKutK6HA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZenU-0006ls-2G; Mon, 02 Nov 2020 18:43:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH 02/17] mm/filemap: Use THPs in generic_file_buffered_read
Date:   Mon,  2 Nov 2020 18:42:57 +0000
Message-Id: <20201102184312.25926-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201102184312.25926-1-willy@infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add mapping_get_read_thps() which returns the THPs which represent a
contiguous array of bytes in the file.  It also stops when encountering
a page marked as Readahead or !Uptodate (but does return that page)
so it can be handled appropriately by filemap_get_pages().  That lets us
remove the loop in filemap_get_pages() and check only the last page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 96 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 26 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 23e3781b3aef..d9636ccf87ff 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2176,6 +2176,48 @@ static int lock_page_for_iocb(struct kiocb *iocb, struct page *page)
 		return lock_page_killable(page);
 }
 
+static unsigned mapping_get_read_thps(struct address_space *mapping,
+		pgoff_t index, unsigned int nr_pages, struct page **pages)
+{
+	XA_STATE(xas, &mapping->i_pages, index);
+	struct page *head;
+	unsigned int ret = 0;
+
+	if (unlikely(!nr_pages))
+		return 0;
+
+	rcu_read_lock();
+	for (head = xas_load(&xas); head; head = xas_next(&xas)) {
+		if (xas_retry(&xas, head))
+			continue;
+		if (xa_is_value(head))
+			break;
+		if (!page_cache_get_speculative(head))
+			goto retry;
+
+		/* Has the page moved or been split? */
+		if (unlikely(head != xas_reload(&xas)))
+			goto put_page;
+
+		pages[ret++] = head;
+		if (ret == nr_pages)
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
+	return ret;
+}
+
 static struct page *filemap_read_page(struct kiocb *iocb, struct file *filp,
 		struct address_space *mapping, struct page *page)
 {
@@ -2330,14 +2372,14 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
-	int i, j, nr_got, err = 0;
+	int nr_got, err = 0;
 
 	nr = min_t(unsigned long, last_index - index, nr);
 find_page:
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
-	nr_got = find_get_pages_contig(mapping, index, nr, pages);
+	nr_got = mapping_get_read_thps(mapping, index, nr, pages);
 	if (nr_got)
 		goto got_pages;
 
@@ -2346,7 +2388,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 
 	page_cache_sync_readahead(mapping, ra, filp, index, last_index - index);
 
-	nr_got = find_get_pages_contig(mapping, index, nr, pages);
+	nr_got = mapping_get_read_thps(mapping, index, nr, pages);
 	if (nr_got)
 		goto got_pages;
 
@@ -2355,20 +2397,19 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	if (!IS_ERR_OR_NULL(pages[0]))
 		nr_got = 1;
 got_pages:
-	for (i = 0; i < nr_got; i++) {
-		struct page *page = pages[i];
-		pgoff_t pg_index = index + i;
+	if (nr_got > 0) {
+		struct page *page = pages[nr_got - 1];
+		pgoff_t pg_index = page->index;
 		loff_t pg_pos = max(iocb->ki_pos,
 				    (loff_t) pg_index << PAGE_SHIFT);
 		loff_t pg_count = iocb->ki_pos + iter->count - pg_pos;
 
 		if (PageReadahead(page)) {
 			if (iocb->ki_flags & IOCB_NOIO) {
-				for (j = i; j < nr_got; j++)
-					put_page(pages[j]);
-				nr_got = i;
+				put_page(page);
+				nr_got--;
 				err = -EAGAIN;
-				break;
+				goto err;
 			}
 			page_cache_async_readahead(mapping, ra, filp, page,
 					pg_index, last_index - pg_index);
@@ -2376,26 +2417,23 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 
 		if (!PageUptodate(page)) {
 			if ((iocb->ki_flags & IOCB_NOWAIT) ||
-			    ((iocb->ki_flags & IOCB_WAITQ) && i)) {
-				for (j = i; j < nr_got; j++)
-					put_page(pages[j]);
-				nr_got = i;
+			    ((iocb->ki_flags & IOCB_WAITQ) && nr_got > 1)) {
+				put_page(page);
+				nr_got--;
 				err = -EAGAIN;
-				break;
+				goto err;
 			}
 
 			page = filemap_update_page(iocb, filp, iter, page,
 					pg_pos, pg_count);
 			if (IS_ERR_OR_NULL(page)) {
-				for (j = i + 1; j < nr_got; j++)
-					put_page(pages[j]);
-				nr_got = i;
+				nr_got--;
 				err = PTR_ERR_OR_ZERO(page);
-				break;
 			}
 		}
 	}
 
+err:
 	if (likely(nr_got))
 		return nr_got;
 	if (err)
@@ -2502,20 +2540,26 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			mark_page_accessed(pages[i]);
 
 		for (i = 0; i < pg_nr; i++) {
-			unsigned int offset = iocb->ki_pos & ~PAGE_MASK;
-			unsigned int bytes = min_t(loff_t, end_offset - iocb->ki_pos,
-						   PAGE_SIZE - offset);
-			unsigned int copied;
+			struct page *page = pages[i];
+			size_t page_size = thp_size(page);
+			size_t offset = iocb->ki_pos & (page_size - 1);
+			size_t bytes = min_t(loff_t, end_offset - iocb->ki_pos,
+					     page_size - offset);
+			size_t copied;
 
 			/*
 			 * If users can be writing to this page using arbitrary
 			 * virtual addresses, take care about potential aliasing
 			 * before reading the page on the kernel side.
 			 */
-			if (writably_mapped)
-				flush_dcache_page(pages[i]);
+			if (writably_mapped) {
+				int j;
+
+				for (j = 0; j < thp_nr_pages(page); j++)
+					flush_dcache_page(page + j);
+			}
 
-			copied = copy_page_to_iter(pages[i], offset, bytes, iter);
+			copied = copy_page_to_iter(page, offset, bytes, iter);
 
 			written += copied;
 			iocb->ki_pos += copied;
-- 
2.28.0

