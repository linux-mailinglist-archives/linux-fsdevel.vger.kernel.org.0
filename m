Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B073C9823
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238299AbhGOFRg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhGOFRg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:17:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E246C06175F;
        Wed, 14 Jul 2021 22:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bAkONPxu0GMkDX/bq8jjUzCHYId16qCP3W7dw8YcdLk=; b=e3R2OC2DPgMDiQEr6d/hGEsj4W
        xmiFus6JiAL76LeVgmLxEGbIJ8CMWzjtNFvKQZs1yInm4h2vD0tyrwUltaBIpQwHiei+E+D5msEcH
        oIqaDis7iPvmF9QroaXE7NZyTzBBmoZgSKWReuAL9o8W8UmYqS8AgaJ5lNoxsgIUnQKuadAQdA0Nd
        N1a8LT0Yp83WqUB7633Z1Je89wq0a2AupN1e8OxiJNdUI7rRQOnH/wMCUwqRHXHPiSgUUeICJhZPB
        RVvg4YF49djVQsk2sWiQhmr4Sx+Fql6P+IhTAJlki5jcZdrZ9Ws1DCEiUsvvFN6kGw1d8qIlLa8xg
        oiX4SrFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tgS-0030Ln-EX; Thu, 15 Jul 2021 05:13:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 119/138] mm/filemap: Convert filemap_get_pages to use folios
Date:   Thu, 15 Jul 2021 04:36:45 +0100
Message-Id: <20210715033704.692967-120-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This saves a few calls to compound_head(), including one in
filemap_update_page().  Shrinks the kernel by 78 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index dd54a52f8e84..18b21d16c9de 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2355,9 +2355,8 @@ static bool filemap_range_uptodate(struct address_space *mapping,
 
 static int filemap_update_page(struct kiocb *iocb,
 		struct address_space *mapping, struct iov_iter *iter,
-		struct page *page)
+		struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	int error;
 
 	if (!folio_trylock(folio)) {
@@ -2426,13 +2425,13 @@ static int filemap_create_folio(struct file *file,
 }
 
 static int filemap_readahead(struct kiocb *iocb, struct file *file,
-		struct address_space *mapping, struct page *page,
+		struct address_space *mapping, struct folio *folio,
 		pgoff_t last_index)
 {
 	if (iocb->ki_flags & IOCB_NOIO)
 		return -EAGAIN;
-	page_cache_async_readahead(mapping, &file->f_ra, file, page,
-			page->index, last_index - page->index);
+	page_cache_async_readahead(mapping, &file->f_ra, file, &folio->page,
+			folio->index, last_index - folio->index);
 	return 0;
 }
 
@@ -2444,7 +2443,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index;
-	struct page *page;
+	struct folio *folio;
 	int err = 0;
 
 	last_index = DIV_ROUND_UP(iocb->ki_pos + iter->count, PAGE_SIZE);
@@ -2470,16 +2469,16 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
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
@@ -2487,7 +2486,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	return 0;
 err:
 	if (err < 0)
-		put_page(page);
+		folio_put(folio);
 	if (likely(--pvec->nr))
 		return 0;
 	if (err == AOP_TRUNCATED_PAGE)
-- 
2.30.2

