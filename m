Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5CE2A6F10
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 21:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbgKDUmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 15:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732083AbgKDUm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:42:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D48C061A4D
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2020 12:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wZuYwxOpDaNwN62+yWqx9L6GKStO72TcNJvurdU40aM=; b=lvIt+pYOq0An9fz4WqPx05EZn3
        uN0PUS0ZM1/GBVFrIaSNvNS4IiiK1jgRfMCct+spcMVgr5c16HTp3ERZzI0qq4R1wSCnL18iYtDCt
        QNkV6J71ailMlGUQWmUANfnK+rW/fpnr4KvmrKzNn5EZbet5gXv02pCE87ZsVS+A84E+KSTWcRCVq
        iwyf1JKp6lZYtyET8OfXPbVehLSToD0m2BI7L+vH9by3GCfD+rkn+CS0YuuGJtm0cl+XkOGP4RvRZ
        F1ANuMdYcsFx1zxsfcrPIz0cIrE7k6KOazU75izmhuVcbfbvQ/mDLQFDmFN50HOKvkp+/iEQsGnHa
        nP0vH5bg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaPbt-0006EI-B2; Wed, 04 Nov 2020 20:42:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v2 13/18] mm/filemap: Add filemap_range_uptodate
Date:   Wed,  4 Nov 2020 20:42:14 +0000
Message-Id: <20201104204219.23810-14-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201104204219.23810-1-willy@infradead.org>
References: <20201104204219.23810-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the complicated condition and the calculations out of
filemap_update_page() into its own function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/filemap.c | 80 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9db94876122c..281538a05dc1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2231,11 +2231,39 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
 	return error;
 }
 
+static bool filemap_range_uptodate(struct kiocb *iocb,
+		struct address_space *mapping, struct iov_iter *iter,
+		struct page *page)
+{
+	loff_t pos;
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
+	pos = (loff_t) page->index << PAGE_SHIFT;
+	if (pos > iocb->ki_pos) {
+		count = iocb->ki_pos + iter->count - pos;
+		pos = 0;
+	} else {
+		count = iter->count;
+		pos = iocb->ki_pos & (thp_size(page) - 1);
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
 	int error = -EAGAIN;
 
 	if (!trylock_page(page)) {
@@ -2250,39 +2278,27 @@ static int filemap_update_page(struct kiocb *iocb,
 			goto error;
 	}
 
+	error = AOP_TRUNCATED_PAGE;
 	if (!page->mapping)
-		goto truncated;
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
-
-readpage:
-	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
+		goto unlock;
+	if (filemap_range_uptodate(iocb, mapping, iter, page)) {
 		unlock_page(page);
-		error = -EAGAIN;
-	} else {
-		error = filemap_read_page(iocb->ki_filp, mapping, page);
-		if (!error)
-			return 0;
+		return 0;
 	}
+
+	error = -EAGAIN;
+	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
+		goto unlock;
+
+	error = filemap_read_page(iocb->ki_filp, mapping, page);
+	if (error)
+		goto error;
+	return 0;
+unlock:
+	unlock_page(page);
 error:
 	put_page(page);
 	return error;
-truncated:
-	unlock_page(page);
-	put_page(page);
-	return AOP_TRUNCATED_PAGE;
 }
 
 static int filemap_create_page(struct file *file,
@@ -2353,9 +2369,6 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	{
 		struct page *page = pvec->pages[pvec->nr - 1];
 		pgoff_t pg_index = page->index;
-		loff_t pg_pos = max(iocb->ki_pos,
-				    (loff_t) pg_index << PAGE_SHIFT);
-		loff_t pg_count = iocb->ki_pos + iter->count - pg_pos;
 
 		if (PageReadahead(page)) {
 			if (iocb->ki_flags & IOCB_NOIO) {
@@ -2372,8 +2385,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 			if ((iocb->ki_flags & IOCB_WAITQ) &&
 			    pagevec_count(pvec) > 1)
 				iocb->ki_flags |= IOCB_NOWAIT;
-			err = filemap_update_page(iocb, mapping, iter, page,
-					pg_pos, pg_count);
+			err = filemap_update_page(iocb, mapping, iter, page);
 			if (err)
 				pvec->nr--;
 		}
-- 
2.28.0

