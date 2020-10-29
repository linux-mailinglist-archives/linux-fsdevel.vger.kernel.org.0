Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F4E29F569
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgJ2Teb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgJ2TeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D176DC0613D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5Qi+fkVc5y2m3fg4x8n5YvSh2yc6fBKTXrBLflPtfFo=; b=cgdijzCxM0jsbGOUGge5xzXqxe
        pjiKNnaXc3NeGn6Y9ZsbMPzl3h6AUlFtKDhYbT9JE/1mw4hoEM1yCsMVuIomzvrFZULUGhCwGPmNV
        HQxBdil412iT477HB03yMlb+wSEuHSMTMiiKKCDai6JexnnPjf0x+pgsEXOtIA3srgZx1gEKOc6Yv
        xCc4+C3DJQ8MesMu6VHhTLTZ5eTGxroqTX8j3JPz8CHa2aBsSL93VpY7WEmAapLdQO/ilsSonqioq
        /TFR3xNUasJUuLriGHbkxPKD7ApX71/nzu3DmIIZU87H2xZCjcDti2ZkI7oOVmerilThG4K3G00HL
        TkNn+MnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDgX-0007bn-AZ; Thu, 29 Oct 2020 19:34:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 07/19] mm/filemap: Use head pages in generic_file_buffered_read
Date:   Thu, 29 Oct 2020 19:33:53 +0000
Message-Id: <20201029193405.29125-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add mapping_get_read_heads() which returns the head pages which
represent a contiguous array of bytes in the file.  It also stops
when encountering a page marked as Readahead or !Uptodate (but
does return that page) so it can be handled appropriately by
gfbr_get_pages().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 78 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 17 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1bfd87d85bfd..c0161f42f37d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2166,6 +2166,48 @@ static void shrink_readahead_size_eio(struct file_ra_state *ra)
 	ra->ra_pages /= 4;
 }
 
+static unsigned mapping_get_read_heads(struct address_space *mapping,
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
 static int lock_page_for_iocb(struct kiocb *iocb, struct page *page)
 {
 	if (iocb->ki_flags & IOCB_WAITQ)
@@ -2328,14 +2370,14 @@ static int gfbr_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
-	int i, j, nr_got, err = 0;
+	int i, nr_got, err = 0;
 
 	nr = min_t(unsigned long, last_index - index, nr);
 find_page:
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
-	nr_got = find_get_pages_contig(mapping, index, nr, pages);
+	nr_got = mapping_get_read_heads(mapping, index, nr, pages);
 	if (nr_got)
 		goto got_pages;
 
@@ -2344,7 +2386,7 @@ static int gfbr_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 
 	page_cache_sync_readahead(mapping, ra, filp, index, last_index - index);
 
-	nr_got = find_get_pages_contig(mapping, index, nr, pages);
+	nr_got = mapping_get_read_heads(mapping, index, nr, pages);
 	if (nr_got)
 		goto got_pages;
 
@@ -2355,15 +2397,14 @@ static int gfbr_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 got_pages:
 	for (i = 0; i < nr_got; i++) {
 		struct page *page = pages[i];
-		pgoff_t pg_index = index + i;
+		pgoff_t pg_index = page->index;
 		loff_t pg_pos = max(iocb->ki_pos,
 				    (loff_t) pg_index << PAGE_SHIFT);
 		loff_t pg_count = iocb->ki_pos + iter->count - pg_pos;
 
 		if (PageReadahead(page)) {
 			if (iocb->ki_flags & IOCB_NOIO) {
-				for (j = i; j < nr_got; j++)
-					put_page(pages[j]);
+				put_page(page);
 				nr_got = i;
 				err = -EAGAIN;
 				break;
@@ -2375,8 +2416,7 @@ static int gfbr_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 		if (!PageUptodate(page)) {
 			if ((iocb->ki_flags & IOCB_NOWAIT) ||
 			    ((iocb->ki_flags & IOCB_WAITQ) && i)) {
-				for (j = i; j < nr_got; j++)
-					put_page(pages[j]);
+				put_page(page);
 				nr_got = i;
 				err = -EAGAIN;
 				break;
@@ -2385,8 +2425,6 @@ static int gfbr_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 			page = gfbr_update_page(iocb, mapping, iter, page,
 					pg_pos, pg_count);
 			if (IS_ERR_OR_NULL(page)) {
-				for (j = i + 1; j < nr_got; j++)
-					put_page(pages[j]);
 				nr_got = i;
 				err = PTR_ERR_OR_ZERO(page);
 				break;
@@ -2500,20 +2538,26 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
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

