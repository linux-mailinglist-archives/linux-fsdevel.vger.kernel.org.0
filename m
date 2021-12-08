Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CE946CC67
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244241AbhLHE1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbhLHE0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D82FC061D60
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0HiMfEBapSaJ76Nsadm/Hl6t4X5OTaxDIeW3md1qPS8=; b=F9HU2Jd0g8x9PI6I8QPzUDhc6q
        MFdRSl5wmj+dWbRQX83gKwBUJcqLj0+JbSjfqOyvaQYwso082bAt9wYOObgr6fUk7E7XDcg8rSLrP
        /qGpTchwgqAl2ozG4ogVUAApd8Sochh7JYtfh/F/eh/cWWa4uAZeGfmDJgUAwlbQTDbvsme77Th6y
        fRUKi/nsWA0FoqAljbhP63J/F5jz3mm5WAJAMa40UCRQhdMzxqPjGZGfkSds7em4kQjWjOFaR4fW0
        jSO9YNOcc5HFxf5vdt4toY1onIICo1bNUNe5GxaAknlAs65hYEp8x3891te/f2RTSG4J9Z8eifbDS
        tQC1gR9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU3-0084YJ-O1; Wed, 08 Dec 2021 04:23:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 19/48] filemap: Convert filemap_create_page to folio
Date:   Wed,  8 Dec 2021 04:22:27 +0000
Message-Id: <20211208042256.1923824-20-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is all internal to filemap and saves 100 bytes of text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 581f9fdb3406..b044afef78ef 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2475,47 +2475,48 @@ static int filemap_update_page(struct kiocb *iocb,
 	return error;
 }
 
-static int filemap_create_page(struct file *file,
+static int filemap_create_folio(struct file *file,
 		struct address_space *mapping, pgoff_t index,
 		struct pagevec *pvec)
 {
-	struct page *page;
+	struct folio *folio;
 	int error;
 
-	page = page_cache_alloc(mapping);
-	if (!page)
+	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
+	if (!folio)
 		return -ENOMEM;
 
 	/*
-	 * Protect against truncate / hole punch. Grabbing invalidate_lock here
-	 * assures we cannot instantiate and bring uptodate new pagecache pages
-	 * after evicting page cache during truncate and before actually
-	 * freeing blocks.  Note that we could release invalidate_lock after
-	 * inserting the page into page cache as the locked page would then be
-	 * enough to synchronize with hole punching. But there are code paths
-	 * such as filemap_update_page() filling in partially uptodate pages or
-	 * ->readpages() that need to hold invalidate_lock while mapping blocks
-	 * for IO so let's hold the lock here as well to keep locking rules
-	 * simple.
+	 * Protect against truncate / hole punch. Grabbing invalidate_lock
+	 * here assures we cannot instantiate and bring uptodate new
+	 * pagecache folios after evicting page cache during truncate
+	 * and before actually freeing blocks.	Note that we could
+	 * release invalidate_lock after inserting the folio into
+	 * the page cache as the locked folio would then be enough to
+	 * synchronize with hole punching. But there are code paths
+	 * such as filemap_update_page() filling in partially uptodate
+	 * pages or ->readpages() that need to hold invalidate_lock
+	 * while mapping blocks for IO so let's hold the lock here as
+	 * well to keep locking rules simple.
 	 */
 	filemap_invalidate_lock_shared(mapping);
-	error = add_to_page_cache_lru(page, mapping, index,
+	error = filemap_add_folio(mapping, folio, index,
 			mapping_gfp_constraint(mapping, GFP_KERNEL));
 	if (error == -EEXIST)
 		error = AOP_TRUNCATED_PAGE;
 	if (error)
 		goto error;
 
-	error = filemap_read_folio(file, mapping, page_folio(page));
+	error = filemap_read_folio(file, mapping, folio);
 	if (error)
 		goto error;
 
 	filemap_invalidate_unlock_shared(mapping);
-	pagevec_add(pvec, page);
+	pagevec_add(pvec, &folio->page);
 	return 0;
 error:
 	filemap_invalidate_unlock_shared(mapping);
-	put_page(page);
+	folio_put(folio);
 	return error;
 }
 
@@ -2557,7 +2558,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	if (!pagevec_count(pvec)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
-		err = filemap_create_page(filp, mapping,
+		err = filemap_create_folio(filp, mapping,
 				iocb->ki_pos >> PAGE_SHIFT, pvec);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
-- 
2.33.0

