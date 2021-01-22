Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C81130099E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 18:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbhAVRX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 12:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbhAVQKA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:10:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2285EC06174A;
        Fri, 22 Jan 2021 08:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NgCVYx229NtKZXdmCxsIRHe+oOGX7Fnf1zniwjiydYo=; b=kNbOa25ba1q9ABDoUTkLwUX+5t
        XQLG827nMTfDlbb2ms7uhY1ZxYpWqq82kbmbUfRIrUSkzIpCmvMtFoGMNORJrnnFkylyyQZYao42k
        15aSYaedAUi0OXTkn690ljBpM/tfLKxwOQJvGFYL/SuaMwoxzFB0Tw5g7s/Kc7ga2scTxfEDLX9Wk
        g2FU0eaPWIESTxkm1aRSZ18UMv/dLyi04pzfTq85fPn5gzw/aGiQV8adr4/zSrrJCcmnOPTUQgEX5
        LK/JS0i0RuaZr94+wc8CrNGUNrKoQ2528YmPtOeYCYyDnCVllvarUFcuOyTeb+mbAt0ZCbEQnNG7h
        kygnAODQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2yyY-000wQm-2n; Fri, 22 Jan 2021 16:08:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 09/18] mm/filemap: Change filemap_read_page calling conventions
Date:   Fri, 22 Jan 2021 16:01:31 +0000
Message-Id: <20210122160140.223228-10-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122160140.223228-1-willy@infradead.org>
References: <20210122160140.223228-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make this function more generic by passing the file instead of the iocb.
Check in the callers whether we should call readpage or not.  Also make
it return an errno / 0 / AOP_TRUNCATED_PAGE, and make calling put_page()
the caller's responsibility.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 89 +++++++++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 47 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ee1255a88106f..ceb2931f5725f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2212,56 +2212,38 @@ static void filemap_get_read_batch(struct address_space *mapping,
 	rcu_read_unlock();
 }
 
-static struct page *filemap_read_page(struct kiocb *iocb, struct file *filp,
-		struct address_space *mapping, struct page *page)
+static int filemap_read_page(struct file *file, struct address_space *mapping,
+		struct page *page)
 {
-	struct file_ra_state *ra = &filp->f_ra;
 	int error;
 
-	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
-		unlock_page(page);
-		put_page(page);
-		return ERR_PTR(-EAGAIN);
-	}
-
 	/*
-	 * A previous I/O error may have been due to temporary
-	 * failures, eg. multipath errors.
-	 * PG_error will be set again if readpage fails.
+	 * A previous I/O error may have been due to temporary failures,
+	 * eg. multipath errors.  PG_error will be set again if readpage
+	 * fails.
 	 */
 	ClearPageError(page);
 	/* Start the actual read. The read will unlock the page. */
-	error = mapping->a_ops->readpage(filp, page);
-
-	if (unlikely(error)) {
-		put_page(page);
-		return error != AOP_TRUNCATED_PAGE ? ERR_PTR(error) : NULL;
-	}
+	error = mapping->a_ops->readpage(file, page);
+	if (error)
+		return error;
+	if (PageUptodate(page))
+		return 0;
 
+	error = lock_page_killable(page);
+	if (error)
+		return error;
 	if (!PageUptodate(page)) {
-		error = lock_page_killable(page);
-		if (unlikely(error)) {
-			put_page(page);
-			return ERR_PTR(error);
-		}
-		if (!PageUptodate(page)) {
-			if (page->mapping == NULL) {
-				/*
-				 * invalidate_mapping_pages got it
-				 */
-				unlock_page(page);
-				put_page(page);
-				return NULL;
-			}
-			unlock_page(page);
-			shrink_readahead_size_eio(ra);
-			put_page(page);
-			return ERR_PTR(-EIO);
+		if (page->mapping == NULL) {
+			/* page truncated */
+			error = AOP_TRUNCATED_PAGE;
+		} else {
+			shrink_readahead_size_eio(&file->f_ra);
+			error = -EIO;
 		}
-		unlock_page(page);
 	}
-
-	return page;
+	unlock_page(page);
+	return error;
 }
 
 static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
@@ -2303,7 +2285,18 @@ static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
 	return page;
 
 readpage:
-	return filemap_read_page(iocb, filp, mapping, page);
+	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
+		unlock_page(page);
+		put_page(page);
+		return ERR_PTR(-EAGAIN);
+	}
+	error = filemap_read_page(iocb->ki_filp, mapping, page);
+	if (!error)
+		return page;
+	put_page(page);
+	if (error == AOP_TRUNCATED_PAGE)
+		return NULL;
+	return ERR_PTR(error);
 truncated:
 	unlock_page(page);
 	put_page(page);
@@ -2319,7 +2312,7 @@ static struct page *filemap_create_page(struct kiocb *iocb,
 	struct page *page;
 	int error;
 
-	if (iocb->ki_flags & IOCB_NOIO)
+	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
 		return ERR_PTR(-EAGAIN);
 
 	page = page_cache_alloc(mapping);
@@ -2328,12 +2321,14 @@ static struct page *filemap_create_page(struct kiocb *iocb,
 
 	error = add_to_page_cache_lru(page, mapping, index,
 				      mapping_gfp_constraint(mapping, GFP_KERNEL));
-	if (error) {
-		put_page(page);
-		return error != -EEXIST ? ERR_PTR(error) : NULL;
-	}
-
-	return filemap_read_page(iocb, filp, mapping, page);
+	if (!error)
+		error = filemap_read_page(iocb->ki_filp, mapping, page);
+	if (!error)
+		return page;
+	put_page(page);
+	if (error == -EEXIST || error == AOP_TRUNCATED_PAGE)
+		return NULL;
+	return ERR_PTR(error);
 }
 
 static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.29.2

