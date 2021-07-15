Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97243C981B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbhGOFPC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhGOFPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:15:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18611C06175F;
        Wed, 14 Jul 2021 22:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9RHYJbjPvnqicnRJcqR3syd4A7W3DXyDdvohNQa07JI=; b=Zj8UrZa7kSb9ZwkzDckQztJeFe
        R4tDSJ8RkEAG1IPNgOo8dEsqucfYgosHHX6oGjHL2aHTMwidm6W6Habvk1966Gz3QJXSE+lNfFKDg
        wq7lMx/m8maoTG3TzNBAbEf1ooCAxFRk6BooKtLto9oqR/ppDlR8JRnPylYlwzV9xZQyHQzLpWoPp
        i/v87a/rqNdTD/TDp1QsJsXztDv88/I0NnpnKgX8wCNm77Xn0VQx3bsQ30LI6ghO53pNoGzUpmfRk
        +2RTV7VdZbJ6hx6ggCR4PT6RpXWff9FfYis4+Jr/2jXsePOfjkUtzSrrpx0VtUPFSScpHHZ4iPbtL
        Wdw2zBzg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tdc-0030Dm-Nl; Thu, 15 Jul 2021 05:10:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 115/138] mm/filemap: Convert filemap_create_page to folio
Date:   Thu, 15 Jul 2021 04:36:41 +0100
Message-Id: <20210715033704.692967-116-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is all internal to filemap and saves 100 bytes of text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5e2a2db1c715..7eda9afb0600 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2396,32 +2396,32 @@ static int filemap_update_page(struct kiocb *iocb,
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
 
-	pagevec_add(pvec, page);
+	pagevec_add(pvec, &folio->page);
 	return 0;
 error:
-	put_page(page);
+	folio_put(folio);
 	return error;
 }
 
@@ -2463,7 +2463,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	if (!pagevec_count(pvec)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
-		err = filemap_create_page(filp, mapping,
+		err = filemap_create_folio(filp, mapping,
 				iocb->ki_pos >> PAGE_SHIFT, pvec);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
-- 
2.30.2

