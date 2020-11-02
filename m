Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E90E2A3331
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgKBSnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgKBSnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:43:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55186C061A47
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZB3YT97pDvW/WHAiwrWuiAsryKmJBMD/HsAlKXX0sB0=; b=uOzVdl1m8+3mVmg/FNORt6+tfC
        wVbuVmGB+QLRKIZKCZ0Zs/1U+o8HhrYVopNoRix5pJF8GLAGv6a7pIvHuQK0veIV5QQDXe8KWibXM
        JiUCKx/q9N3vntkl8pkJ9UVF/xeFCo/usSnfm92Dleu8IJGL63rOvQFyY2ntibufaQ1rBBoW8kF+z
        l2qD5Ldh1fmU1UU9kXb4qK7VGAI8F0vmhIjPxMtEH/E3oqNryKO5CkMvLCHDV4ZqYarDki5HoKxTw
        lI5qXgfAs0AcNbEVYx7CJxNJugSz0l4Sof7Ez/5SOB8p9mwGe0dtO5dqgHUerq3XYHZ0jfcd1g7/j
        LMWR3Upw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZenZ-0006mx-6u; Mon, 02 Nov 2020 18:43:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH 07/17] mm/filemap: Change filemap_read_page calling conventions
Date:   Mon,  2 Nov 2020 18:43:02 +0000
Message-Id: <20201102184312.25926-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201102184312.25926-1-willy@infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
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
---
 mm/filemap.c | 89 +++++++++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 47 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5bafd2dc830c..171da5c592fa 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2194,56 +2194,38 @@ static unsigned mapping_get_read_thps(struct address_space *mapping,
 	return ret;
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
@@ -2285,7 +2267,18 @@ static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
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
@@ -2301,7 +2294,7 @@ static struct page *filemap_create_page(struct kiocb *iocb,
 	struct page *page;
 	int error;
 
-	if (iocb->ki_flags & IOCB_NOIO)
+	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
 		return ERR_PTR(-EAGAIN);
 
 	page = page_cache_alloc(mapping);
@@ -2310,12 +2303,14 @@ static struct page *filemap_create_page(struct kiocb *iocb,
 
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
2.28.0

