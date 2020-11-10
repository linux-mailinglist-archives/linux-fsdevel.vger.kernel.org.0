Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5472ACBF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 04:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbgKJDhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 22:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731351AbgKJDhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:37:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED28C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 19:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=p6/FzLUqNq8Oj1Kl3pi7IxuekojVQysmc5spzhprX8U=; b=TBn40tnSi2ETC0F7AosdAOQRi9
        faNmhZ+q7JZoa82e0F0uitcfAeq3iAcQBcE7pOUYlYGRK5QkVQkgYlTz+LsUD5u8moKyTZPjKMe98
        CGD0vzgCt+LUU5cmDOhKUOCxqz0I+m2XqwySD2WgP7IDTSX50uFcEr5ehTnmIYx7Wh6LNuTN0Owka
        ZU8VIEgi/JcJ/MgvVrA6rAmjcRdWVbez9dzMe1Ypv4rZfACZWQNU2rChyn74ffTuUHdxu5ZOq7z7C
        HT4r/3WKmU/dapvJFtHjLCHEh2aZNNBuuKVuhBUdYKaTMu/r7VlRobfAKUxIwUWd94gY8oI4ZmeUa
        JjV022Cg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcKT4-00066k-Kb; Tue, 10 Nov 2020 03:37:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v3 13/18] mm/filemap: Add filemap_range_uptodate
Date:   Tue, 10 Nov 2020 03:36:58 +0000
Message-Id: <20201110033703.23261-14-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201110033703.23261-1-willy@infradead.org>
References: <20201110033703.23261-1-willy@infradead.org>
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
 mm/filemap.c | 71 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 2218fe610c42..1cacadef0ded 100644
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
 	int error;
 
 	if (!trylock_page(page)) {
@@ -2252,34 +2280,25 @@ static int filemap_update_page(struct kiocb *iocb,
 
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
+	if (filemap_range_uptodate(iocb, mapping, iter, page))
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
@@ -2349,9 +2368,6 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	{
 		struct page *page = pvec->pages[pvec->nr - 1];
 		pgoff_t pg_index = page->index;
-		loff_t pg_pos = max(iocb->ki_pos,
-				    (loff_t) pg_index << PAGE_SHIFT);
-		loff_t pg_count = iocb->ki_pos + iter->count - pg_pos;
 
 		if (PageReadahead(page)) {
 			if (iocb->ki_flags & IOCB_NOIO) {
@@ -2368,8 +2384,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
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
2.28.0

