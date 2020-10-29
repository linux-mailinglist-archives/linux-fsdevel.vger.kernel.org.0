Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D3B29F557
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgJ2TeN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgJ2TeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DFFC0613D4
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dlYJ9D+4FGM52whGaN4YYn56NteR9ZTeFStm51rap7s=; b=ZQaQfChyypFbOCaeq1kooxG0AK
        GZwqatG8XukWqu+4VmwtRNtkd/wsOnJ7vSQB03Bo7a2pHeHYRAxsDgg0NWXQgoQ3d+A9B+1vN2l1F
        iPnHFN7a/OLWIEdJkanthQ2s0ZJW9v3GWVK5gnSQgN59fYlgJqVAsFT8g2tf4OUI2ReSunW5idUZX
        v3egWpe35i58nEvsIkgXdtoQoQDqu0PuJGGVU8fEqWKhhyx0AS6e3oTM9wkppsGdhbO00ew1nettS
        IIC2YsjcFrfRlOhhGHdr3CWG3qlb0i52R1FKyWYclfhLfvK8LwH+tby4DOuUiQU7Pp9DFLdoZqFr3
        2bI0gTrg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDgW-0007bY-O2; Thu, 29 Oct 2020 19:34:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 05/19] mm/filemap: Rename generic_file_buffered_read subfunctions
Date:   Thu, 29 Oct 2020 19:33:51 +0000
Message-Id: <20201029193405.29125-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The recent split of generic_file_buffered_read() created some very
long function names which are hard to distinguish from each other.
Rename as follows:

generic_file_buffered_read_readpage -> gfbr_read_page
generic_file_buffered_read_pagenotuptodate -> gfbr_update_page
generic_file_buffered_read_no_cached_page -> gfbr_create_page
generic_file_buffered_read_get_pages -> gfbr_get_pages

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 43 ++++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a68516ddeddc..7bc791b47a68 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2176,11 +2176,8 @@ static int lock_page_for_iocb(struct kiocb *iocb, struct page *page)
 		return lock_page_killable(page);
 }
 
-static struct page *
-generic_file_buffered_read_readpage(struct kiocb *iocb,
-				    struct file *filp,
-				    struct address_space *mapping,
-				    struct page *page)
+static struct page *gfbr_read_page(struct kiocb *iocb, struct file *filp,
+		struct address_space *mapping, struct page *page)
 {
 	struct file_ra_state *ra = &filp->f_ra;
 	int error;
@@ -2231,12 +2228,9 @@ generic_file_buffered_read_readpage(struct kiocb *iocb,
 	return page;
 }
 
-static struct page *
-generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
-					   struct file *filp,
-					   struct iov_iter *iter,
-					   struct page *page,
-					   loff_t pos, loff_t count)
+static struct page *gfbr_update_page(struct kiocb *iocb, struct file *filp,
+		struct iov_iter *iter, struct page *page, loff_t pos,
+		loff_t count)
 {
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
@@ -2299,12 +2293,10 @@ generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
 		return page;
 	}
 
-	return generic_file_buffered_read_readpage(iocb, filp, mapping, page);
+	return gfbr_read_page(iocb, filp, mapping, page);
 }
 
-static struct page *
-generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
-					  struct iov_iter *iter)
+static struct page *gfbr_create_page(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
@@ -2315,10 +2307,6 @@ generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
 	if (iocb->ki_flags & IOCB_NOIO)
 		return ERR_PTR(-EAGAIN);
 
-	/*
-	 * Ok, it wasn't cached, so we need to create a new
-	 * page..
-	 */
 	page = page_cache_alloc(mapping);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
@@ -2330,13 +2318,11 @@ generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
 		return error != -EEXIST ? ERR_PTR(error) : NULL;
 	}
 
-	return generic_file_buffered_read_readpage(iocb, filp, mapping, page);
+	return gfbr_read_page(iocb, filp, mapping, page);
 }
 
-static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
-						struct iov_iter *iter,
-						struct page **pages,
-						unsigned int nr)
+static int gfbr_get_pages(struct kiocb *iocb, struct iov_iter *iter,
+		struct page **pages, unsigned int nr)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
@@ -2363,7 +2349,7 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 	if (nr_got)
 		goto got_pages;
 
-	pages[0] = generic_file_buffered_read_no_cached_page(iocb, iter);
+	pages[0] = gfbr_create_page(iocb, iter);
 	err = PTR_ERR_OR_ZERO(pages[0]);
 	if (!IS_ERR_OR_NULL(pages[0]))
 		nr_got = 1;
@@ -2397,8 +2383,8 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 				break;
 			}
 
-			page = generic_file_buffered_read_pagenotuptodate(iocb,
-					filp, iter, page, pg_pos, pg_count);
+			page = gfbr_update_page(iocb, filp, iter, page,
+					pg_pos, pg_count);
 			if (IS_ERR_OR_NULL(page)) {
 				for (j = i + 1; j < nr_got; j++)
 					put_page(pages[j]);
@@ -2474,8 +2460,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			iocb->ki_flags |= IOCB_NOWAIT;
 
 		i = 0;
-		pg_nr = generic_file_buffered_read_get_pages(iocb, iter,
-							     pages, nr_pages);
+		pg_nr = gfbr_get_pages(iocb, iter, pages, nr_pages);
 		if (pg_nr < 0) {
 			error = pg_nr;
 			break;
-- 
2.28.0

