Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70801300863
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 17:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbhAVQNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbhAVQNR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:13:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043E6C06174A;
        Fri, 22 Jan 2021 08:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=25Fu4UHrJmMz1eHRSy0HQHdJ9c5Kkv8Xt9zJLZGKkEs=; b=NY6Q/3yhi01TJK3WZKUdF13bp3
        YMnXRSKesbilGTBI+ZatfWHukw1mK7Mkj5gZlvQkHuLMyf5X9eUHnRukxvXeKMGmXkYDvODrFwjaG
        BMW1OgXFi8wmhIOCJo9hmWdqxRJk+1fgY4gfO3lmDTyUtIHRRvevwhP4sqTLp3ghtH8yOhDoNXpZq
        OW4NQjX8ZqcOIX8lDPjberoeszWDQHOYV7ieX/p6RDzGKbbm7NS36yD/BBqUAhsQApy8rYZapSAO0
        d0bazHvHkMu81GSA75oB6mL7P80GApWthu2MSl+rDFTJ/2QJiMUzUFzuoYk9jeXLPbDiq4dMx9EBO
        6pGYU9jQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2z1T-000wca-Mh; Fri, 22 Jan 2021 16:11:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 13/18] mm/filemap: Add filemap_range_uptodate
Date:   Fri, 22 Jan 2021 16:01:35 +0000
Message-Id: <20210122160140.223228-14-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122160140.223228-1-willy@infradead.org>
References: <20210122160140.223228-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the complicated condition and the calculations out of
filemap_update_page() into its own function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 68 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9fbfb27483147..a3ebc6082022e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2246,11 +2246,36 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
 	return error;
 }
 
+static bool filemap_range_uptodate(struct address_space *mapping,
+		loff_t pos, struct iov_iter *iter, struct page *page)
+{
+	int count;
+
+	if (PageUptodate(page))
+		return true;
+	/* pipes can't handle partially uptodate pages */
+	if (iov_iter_is_pipe(iter))
+		return false;
+	if (!mapping->a_ops->is_partially_uptodate)
+		return false;
+	if (mapping->host->i_blkbits >= (PAGE_SHIFT + thp_order(page)))
+		return false;
+
+	count = iter->count;
+	if (page_offset(page) > pos) {
+		count -= page_offset(page) - pos;
+		pos = 0;
+	} else {
+		pos -= page_offset(page);
+	}
+
+	return mapping->a_ops->is_partially_uptodate(page, pos, count);
+}
+
 static int filemap_update_page(struct kiocb *iocb,
 		struct address_space *mapping, struct iov_iter *iter,
-		struct page *page, loff_t pos, loff_t count)
+		struct page *page)
 {
-	struct inode *inode = mapping->host;
 	int error;
 
 	if (!trylock_page(page)) {
@@ -2267,34 +2292,25 @@ static int filemap_update_page(struct kiocb *iocb,
 
 	if (!page->mapping)
 		goto truncated;
-	if (PageUptodate(page))
-		goto uptodate;
-	if (inode->i_blkbits == PAGE_SHIFT ||
-			!mapping->a_ops->is_partially_uptodate)
-		goto readpage;
-	/* pipes can't handle partially uptodate pages */
-	if (unlikely(iov_iter_is_pipe(iter)))
-		goto readpage;
-	if (!mapping->a_ops->is_partially_uptodate(page,
-				pos & (thp_size(page) - 1), count))
-		goto readpage;
-uptodate:
-	unlock_page(page);
-	return 0;
 
-readpage:
-	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
-		unlock_page(page);
-		return -EAGAIN;
-	}
+	error = 0;
+	if (filemap_range_uptodate(mapping, iocb->ki_pos, iter, page))
+		goto unlock;
+
+	error = -EAGAIN;
+	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
+		goto unlock;
+
 	error = filemap_read_page(iocb->ki_filp, mapping, page);
 	if (error == AOP_TRUNCATED_PAGE)
 		put_page(page);
 	return error;
 truncated:
-	unlock_page(page);
+	error = AOP_TRUNCATED_PAGE;
 	put_page(page);
-	return AOP_TRUNCATED_PAGE;
+unlock:
+	unlock_page(page);
+	return error;
 }
 
 static int filemap_create_page(struct file *file,
@@ -2364,9 +2380,6 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	{
 		struct page *page = pvec->pages[pvec->nr - 1];
 		pgoff_t pg_index = page->index;
-		loff_t pg_pos = max(iocb->ki_pos,
-				    (loff_t) pg_index << PAGE_SHIFT);
-		loff_t pg_count = iocb->ki_pos + iter->count - pg_pos;
 
 		if (PageReadahead(page)) {
 			if (iocb->ki_flags & IOCB_NOIO) {
@@ -2383,8 +2396,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 			if ((iocb->ki_flags & IOCB_WAITQ) &&
 			    pagevec_count(pvec) > 1)
 				iocb->ki_flags |= IOCB_NOWAIT;
-			err = filemap_update_page(iocb, mapping, iter, page,
-					pg_pos, pg_count);
+			err = filemap_update_page(iocb, mapping, iter, page);
 			if (err) {
 				if (err < 0)
 					put_page(page);
-- 
2.29.2

