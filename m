Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A2E46CC63
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbhLHE1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbhLHE0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABABBC0698C8
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nGTKE0UdgttmA0mxrDkUyEEjWKbpIL8TqlNy2EdTN2Y=; b=hEyn3n48W+l3guJA++IEkfiI2Y
        iVK8k6jmg2oUNQJsrPCxZCXIFnEiRv0CvrbSKoQOTQ1Xzxl1zuuJvkBr/pFI9NBzSmImLbNBvX4jh
        FkLqKZCUbOFs5yXczMbrngvy58n+qVdR9QFCtsSQAlWxVEpfOkLs/mbapiEAg8eyFRVd+n+5p5thL
        sLDn84latXJS+Zq/jAnVfKaIM24ydC9Nh7dMCTgT9/hutecPX6bJQ9z2Z8sOVrXvinGWVq7JtsaWM
        pBva4x6KNMs2AyL+PabPq9CYw2sw1JnkfSJxxET6BBnwm0oJ6VorQEdxwVPjVHsLIMAbF0yqhp6YI
        AtjYuVbg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU4-0084ZB-P9; Wed, 08 Dec 2021 04:23:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 26/48] filemap: Convert filemap_get_pages to use folios
Date:   Wed,  8 Dec 2021 04:22:34 +0000
Message-Id: <20211208042256.1923824-27-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This saves a few calls to compound_head(), including one in
filemap_update_page().  Shrinks the kernel by 78 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f34dda0a7627..d191a4fd758a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2422,9 +2422,8 @@ static bool filemap_range_uptodate(struct address_space *mapping,
 
 static int filemap_update_page(struct kiocb *iocb,
 		struct address_space *mapping, struct iov_iter *iter,
-		struct page *page)
+		struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	int error;
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
@@ -2521,13 +2520,14 @@ static int filemap_create_folio(struct file *file,
 }
 
 static int filemap_readahead(struct kiocb *iocb, struct file *file,
-		struct address_space *mapping, struct page *page,
+		struct address_space *mapping, struct folio *folio,
 		pgoff_t last_index)
 {
+	DEFINE_READAHEAD(ractl, file, &file->f_ra, mapping, folio->index);
+
 	if (iocb->ki_flags & IOCB_NOIO)
 		return -EAGAIN;
-	page_cache_async_readahead(mapping, &file->f_ra, file, page,
-			page->index, last_index - page->index);
+	page_cache_async_ra(&ractl, folio, last_index - folio->index);
 	return 0;
 }
 
@@ -2539,7 +2539,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index;
-	struct page *page;
+	struct folio *folio;
 	int err = 0;
 
 	last_index = DIV_ROUND_UP(iocb->ki_pos + iter->count, PAGE_SIZE);
@@ -2565,16 +2565,16 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 		return err;
 	}
 
-	page = pvec->pages[pagevec_count(pvec) - 1];
-	if (PageReadahead(page)) {
-		err = filemap_readahead(iocb, filp, mapping, page, last_index);
+	folio = page_folio(pvec->pages[pagevec_count(pvec) - 1]);
+	if (folio_test_readahead(folio)) {
+		err = filemap_readahead(iocb, filp, mapping, folio, last_index);
 		if (err)
 			goto err;
 	}
-	if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
 		if ((iocb->ki_flags & IOCB_WAITQ) && pagevec_count(pvec) > 1)
 			iocb->ki_flags |= IOCB_NOWAIT;
-		err = filemap_update_page(iocb, mapping, iter, page);
+		err = filemap_update_page(iocb, mapping, iter, folio);
 		if (err)
 			goto err;
 	}
@@ -2582,7 +2582,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	return 0;
 err:
 	if (err < 0)
-		put_page(page);
+		folio_put(folio);
 	if (likely(--pvec->nr))
 		return 0;
 	if (err == AOP_TRUNCATED_PAGE)
-- 
2.33.0

