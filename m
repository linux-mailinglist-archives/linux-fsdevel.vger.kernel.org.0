Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0BF2ACBF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 04:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbgKJDhS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 22:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbgKJDhO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:37:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F25AC0613D4
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 19:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=m0eXNuUXEXWU5JN/qKJgJTRZ3NVya1wJfACcs8w99Cc=; b=Wbs/sNmNnggnxfXcilWsf7H743
        7jEwOnD03obu5qVjlfrnpgS8XsFeNqxOgnKq/Og/NCPGllAGizz6LwYnEc1sT7ThykJiXKLbV904g
        xJeHKcVxr5LQXd3y7ETCYkYdQ1994T4ODuIA9pjov5SyG0l5YkgWl6cs6mRykHpDzPPIpSdZefD/X
        zCtLc02eG/3eHOlMg8Iv/vf4YU3GTKYPxwZu8P6KE9do0mg+6r/pJAOa2bj0a8LCyGEROZVmCVg0I
        KKJFqyV791OYpqL/jLQrbkpeE+GO3GC3GV3kF6WLeevpL/pmob3euFKaLFE1Wpb9tQKJ1gezno+zS
        UrsxPcIA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcKT1-00065j-FG; Tue, 10 Nov 2020 03:37:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v3 10/18] mm/filemap: Change filemap_create_page calling conventions
Date:   Tue, 10 Nov 2020 03:36:55 +0000
Message-Id: <20201110033703.23261-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201110033703.23261-1-willy@infradead.org>
References: <20201110033703.23261-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By moving the iocb flag checks to the caller, we can pass the
file and the page index instead of the iocb.  It never needed the iter.
By passing the pagevec, we can return an errno (or AOP_TRUNCATED_PAGE)
instead of an ERR_PTR.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 53 ++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 52d606916477..ddc881c9d253 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2288,32 +2288,33 @@ static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
 	return NULL;
 }
 
-static struct page *filemap_create_page(struct kiocb *iocb,
-		struct iov_iter *iter)
+static int filemap_create_page(struct file *file,
+		struct address_space *mapping, pgoff_t index,
+		struct pagevec *pvec)
 {
-	struct file *filp = iocb->ki_filp;
-	struct address_space *mapping = filp->f_mapping;
-	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	struct page *page;
 	int error;
 
-	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
-		return ERR_PTR(-EAGAIN);
-
 	page = page_cache_alloc(mapping);
 	if (!page)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	error = add_to_page_cache_lru(page, mapping, index,
-				      mapping_gfp_constraint(mapping, GFP_KERNEL));
-	if (!error)
-		error = filemap_read_page(iocb->ki_filp, mapping, page);
-	if (!error)
-		return page;
+			mapping_gfp_constraint(mapping, GFP_KERNEL));
+	if (error == -EEXIST)
+		error = AOP_TRUNCATED_PAGE;
+	if (error)
+		goto error;
+
+	error = filemap_read_page(file, mapping, page);
+	if (error)
+		goto error;
+
+	pagevec_add(pvec, page);
+	return 0;
+error:
 	put_page(page);
-	if (error == -EEXIST || error == AOP_TRUNCATED_PAGE)
-		return NULL;
-	return ERR_PTR(error);
+	return error;
 }
 
 static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
@@ -2341,15 +2342,15 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	page_cache_sync_readahead(mapping, ra, filp, index, last_index - index);
 
 	filemap_get_read_batch(mapping, index, last_index, pvec);
-	if (pvec->nr)
-		goto got_pages;
-
-	pvec->pages[0] = filemap_create_page(iocb, iter);
-	err = PTR_ERR_OR_ZERO(pvec->pages[0]);
-	if (IS_ERR_OR_NULL(pvec->pages[0]))
-		goto err;
-	pvec->nr = 1;
-	return 0;
+	if (!pagevec_count(pvec)) {
+		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
+			return -EAGAIN;
+		err = filemap_create_page(filp, mapping,
+				iocb->ki_pos >> PAGE_SHIFT, pvec);
+		if (err == AOP_TRUNCATED_PAGE)
+			goto find_page;
+		return err;
+	}
 got_pages:
 	{
 		struct page *page = pvec->pages[pvec->nr - 1];
-- 
2.28.0

