Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32572FE084
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 05:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbhAUEUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 23:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732186AbhAUESZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:18:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FC7C061757
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 20:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rljNkcidArhcy4KzB5d6BViA2Ha9Hr9pGSFQAuwxe1o=; b=HhwxZnyJI5Md+3nUvf1MmEoxhw
        s08TiRM19oIuqW/uXtW/+BRAD2E0RcGNxmCa1w67V9aUSG+dFIfMO/0rviJw8UU6I/e5E4Pu/Afhy
        p8AdikO0q4TSmsYsVNkL8mPQC/YWYPcHDJZYphjmfFiWj8VdBdBOyLxifY5vUq1xYo3MC6jCQ/2xa
        3detjWle7HAYhBHsfGIk/JMtTNY6GaNEM5uBDWgs7t4RbNPf1Kg4CZb0fBIALdeAAcYsCraPTK63Q
        Kfm/ICu7MeXS9dRlxqTNaYCPj/SfxsAUoe8FUG20VuRgOwG21IBqfqS0RFtaM7K2rnGBZ0+jneR96
        Fq/oOd4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2ROn-00GbAv-0j; Thu, 21 Jan 2021 04:16:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v4 01/18] mm/filemap: Rename generic_file_buffered_read subfunctions
Date:   Thu, 21 Jan 2021 04:15:59 +0000
Message-Id: <20210121041616.3955703-2-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121041616.3955703-1-willy@infradead.org>
References: <20210121041616.3955703-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The recent split of generic_file_buffered_read() created some very
long function names which are hard to distinguish from each other.
Rename as follows:

generic_file_buffered_read_readpage -> filemap_read_page
generic_file_buffered_read_pagenotuptodate -> filemap_update_page
generic_file_buffered_read_no_cached_page -> filemap_create_page
generic_file_buffered_read_get_pages -> filemap_get_pages

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/filemap.c | 44 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d90614f501daa..934e04f1760ef 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2168,11 +2168,8 @@ static int lock_page_for_iocb(struct kiocb *iocb, struct page *page)
 		return lock_page_killable(page);
 }
 
-static struct page *
-generic_file_buffered_read_readpage(struct kiocb *iocb,
-				    struct file *filp,
-				    struct address_space *mapping,
-				    struct page *page)
+static struct page *filemap_read_page(struct kiocb *iocb, struct file *filp,
+		struct address_space *mapping, struct page *page)
 {
 	struct file_ra_state *ra = &filp->f_ra;
 	int error;
@@ -2223,12 +2220,9 @@ generic_file_buffered_read_readpage(struct kiocb *iocb,
 	return page;
 }
 
-static struct page *
-generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
-					   struct file *filp,
-					   struct iov_iter *iter,
-					   struct page *page,
-					   loff_t pos, loff_t count)
+static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
+		struct iov_iter *iter, struct page *page, loff_t pos,
+		loff_t count)
 {
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
@@ -2291,12 +2285,11 @@ generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
 		return page;
 	}
 
-	return generic_file_buffered_read_readpage(iocb, filp, mapping, page);
+	return filemap_read_page(iocb, filp, mapping, page);
 }
 
-static struct page *
-generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
-					  struct iov_iter *iter)
+static struct page *filemap_create_page(struct kiocb *iocb,
+		struct iov_iter *iter)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
@@ -2307,10 +2300,6 @@ generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
 	if (iocb->ki_flags & IOCB_NOIO)
 		return ERR_PTR(-EAGAIN);
 
-	/*
-	 * Ok, it wasn't cached, so we need to create a new
-	 * page..
-	 */
 	page = page_cache_alloc(mapping);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
@@ -2322,13 +2311,11 @@ generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
 		return error != -EEXIST ? ERR_PTR(error) : NULL;
 	}
 
-	return generic_file_buffered_read_readpage(iocb, filp, mapping, page);
+	return filemap_read_page(iocb, filp, mapping, page);
 }
 
-static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
-						struct iov_iter *iter,
-						struct page **pages,
-						unsigned int nr)
+static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
+		struct page **pages, unsigned int nr)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
@@ -2355,7 +2342,7 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 	if (nr_got)
 		goto got_pages;
 
-	pages[0] = generic_file_buffered_read_no_cached_page(iocb, iter);
+	pages[0] = filemap_create_page(iocb, iter);
 	err = PTR_ERR_OR_ZERO(pages[0]);
 	if (!IS_ERR_OR_NULL(pages[0]))
 		nr_got = 1;
@@ -2389,8 +2376,8 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 				break;
 			}
 
-			page = generic_file_buffered_read_pagenotuptodate(iocb,
-					filp, iter, page, pg_pos, pg_count);
+			page = filemap_update_page(iocb, filp, iter, page,
+					pg_pos, pg_count);
 			if (IS_ERR_OR_NULL(page)) {
 				for (j = i + 1; j < nr_got; j++)
 					put_page(pages[j]);
@@ -2466,8 +2453,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			iocb->ki_flags |= IOCB_NOWAIT;
 
 		i = 0;
-		pg_nr = generic_file_buffered_read_get_pages(iocb, iter,
-							     pages, nr_pages);
+		pg_nr = filemap_get_pages(iocb, iter, pages, nr_pages);
 		if (pg_nr < 0) {
 			error = pg_nr;
 			break;
-- 
2.29.2

