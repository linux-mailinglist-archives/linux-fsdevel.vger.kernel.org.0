Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAF42A148B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 10:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgJaJNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 05:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgJaJNP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:13:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0009CC0613D5
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 02:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7D2NpM41epKpom692Wn+SfTL8DLMRgNwbln8pAHhUis=; b=c5X+sjhI68xlbZ1w7KORhijPsf
        jnC2yfRf5D+ZUxC1O/ezGE3NhlmevxUfgQqVlay+zN3Y4cv47JpomS28Ex7PLuUcBAOjqCro48sgv
        U6laupoVWz/V6D7jyV97uZTMeGrqP4R1I/i2Hd0BsjbrsFrxUGLDTxzF6mS7sNrevGIraFHa9x7vJ
        IK2ek5hxZcCk19ILMoXQhJU5rVxCtk/SLfkacMh1OJ836UglD7AyHFJqDoak9sfgFKDhP1Xws01S1
        fEI+Hs+A/s2M6vZt8eUPBC+e52j2tefcdFBcpSevRAK8/96MlvSJIg9WmWVTTnGpJzpWyVRSxWmdZ
        B+rX4DIg==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYmwh-0007jC-Vm; Sat, 31 Oct 2020 09:13:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/13] mm: simplify generic_file_buffered_read_no_cached_page
Date:   Sat, 31 Oct 2020 09:59:56 +0100
Message-Id: <20201031090004.452516-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031090004.452516-1-hch@lst.de>
References: <20201031090004.452516-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Return an errno and add a new by reference argument for the allocated
page, which allows to cleanup the error unwindining in the function
and the caller.  Also rename the function to filemap_new_page which is
both shorter and more descriptive.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 53 ++++++++++++++++------------------------------------
 1 file changed, 16 insertions(+), 37 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5cdf8090d4e12c..9e1cc18afe1134 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2300,41 +2300,27 @@ static int filemap_make_page_uptodate(struct kiocb *iocb, struct iov_iter *iter,
 	return error;
 }
 
-static struct page *
-generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
-					  struct iov_iter *iter)
+static int filemap_new_page(struct kiocb *iocb, struct iov_iter *iter,
+		struct page **page)
 {
-	struct file *filp = iocb->ki_filp;
-	struct address_space *mapping = filp->f_mapping;
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	gfp_t gfp = mapping_gfp_constraint(mapping, GFP_KERNEL);
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
-	struct page *page;
 	int error;
 
 	if (iocb->ki_flags & IOCB_NOIO)
-		return ERR_PTR(-EAGAIN);
+		return -EAGAIN;
 
-	/*
-	 * Ok, it wasn't cached, so we need to create a new
-	 * page..
-	 */
-	page = page_cache_alloc(mapping);
+	*page = page_cache_alloc(mapping);
 	if (!page)
-		return ERR_PTR(-ENOMEM);
-
-	error = add_to_page_cache_lru(page, mapping, index,
-				      mapping_gfp_constraint(mapping, GFP_KERNEL));
+		return -ENOMEM;
+	error = add_to_page_cache_lru(*page, mapping, index, gfp);
 	if (error) {
-		put_page(page);
-		return error != -EEXIST ? ERR_PTR(error) : NULL;
+		put_page(*page);
+		return error;
 	}
 
-	error = filemap_readpage(iocb, page);
-	if (error) {
-		if (error == AOP_TRUNCATED_PAGE)
-			return NULL;
-		return ERR_PTR(error);
-	}
-	return page;
+	return filemap_readpage(iocb, *page);
 }
 
 static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
@@ -2366,18 +2352,14 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 	nr_got = find_get_pages_contig(mapping, index, nr, pages);
 	if (nr_got)
 		goto got_pages;
-
-	pages[0] = generic_file_buffered_read_no_cached_page(iocb, iter);
-	err = PTR_ERR_OR_ZERO(pages[0]);
-	if (!IS_ERR_OR_NULL(pages[0]))
+	err = filemap_new_page(iocb, iter, &pages[0]);
+	if (!err)
 		nr_got = 1;
 got_pages:
 	for (i = 0; i < nr_got; i++) {
 		err = filemap_make_page_uptodate(iocb, iter, pages[i],
 				index + i, i == 0);
 		if (err) {
-			if (err == AOP_TRUNCATED_PAGE)
-				err = 0;
 			for (j = i + 1; j < nr_got; j++)
 				put_page(pages[j]);
 			nr_got = i;
@@ -2387,12 +2369,9 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 
 	if (likely(nr_got))
 		return nr_got;
-	if (err)
-		return err;
-	/*
-	 * No pages and no error means we raced and should retry:
-	 */
-	goto find_page;
+	if (err == -EEXIST || err == AOP_TRUNCATED_PAGE)
+		goto find_page;
+	return err;
 }
 
 /**
-- 
2.28.0

