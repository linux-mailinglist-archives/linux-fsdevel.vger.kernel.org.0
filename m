Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B007D3C42A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhGLEMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhGLEMb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:12:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D9AC0613DD;
        Sun, 11 Jul 2021 21:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kSjC6Cn+PxZOxSNh1t+ubqHOFyIKP3gNah1X88Cb6b4=; b=uV+ZaakOe0qV+M3qV3a0z6OLbf
        yhF/4PslnurrCUhpQHAIKsyt3ErktwjxBHBEq6V7M5EWIZRdd11wUI/mk9bW/MdK8E8GGmQRBpqFh
        y3wd5VUSGp6rgLw3Vs6IEc7LCLnAPDIFkn5EUp4cucCIMZEnJhJHOjjm44h8bNFbJUcqS8ojGxjQx
        E/0t9JD/46EHeNhjcV68WAqO7Peut2DyVnd8RgbwWUl4c/sWVfS6jlqdmZS6Xlwkw64OCmYiiD7VM
        cQ9rj9QrZzmVN8Y0FwSed6bDxYK/JVSHDXl9bMH5QGgm0KPkHGeFr7zpFD3bc84Zm1pDSY8kjla6S
        FC2TVYKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nFS-00GrBB-QG; Mon, 12 Jul 2021 04:09:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 118/137] mm/filemap: Convert filemap_get_pages to use folios
Date:   Mon, 12 Jul 2021 04:06:42 +0100
Message-Id: <20210712030701.4000097-119-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
index b7fb0a4479ea..6700fbd9e8f6 100644
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
+	if (folio_readahead(folio)) {
+		err = filemap_readahead(iocb, filp, mapping, folio, last_index);
 		if (err)
 			goto err;
 	}
-	if (!PageUptodate(page)) {
+	if (!folio_uptodate(folio)) {
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

