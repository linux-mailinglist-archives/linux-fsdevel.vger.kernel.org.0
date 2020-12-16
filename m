Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC2A2DC66A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgLPSZj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbgLPSZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:25:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37E0C0611CF;
        Wed, 16 Dec 2020 10:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zlo5KayZktdXY3pBXFt2EmyX7rZ4LXownyDR/ZbDnaA=; b=iRbUN8k+9UBv7Xu9/5ICwQr6bC
        X6J4YHKFXRoX56HjMweOfUtmoTvKfmw95OxfHWactzUFbLbY7mr3BorjDyyQNkFVGXqJvBWtrnFPD
        bU9dN/BNsmUZSGN+UaFOp0K80fX9dc/qpEqCnWz0ZnqS5NCySUBoORF7VndzMkSkT7m+JQZ/8bBlD
        j7Slv1IFBizzpqTup7xrKwx2R0Th837wxXlwY96x1Dr9lcbgoGq/Y+aKUvGAQAfDeNS/ifTM6TnP7
        XcYL6eTd4Si+x1SxBM0qa6PAb6LTifPSkdM698d8j2FE9aYb5fxDstjdStuJg+vfFFPvb1TBfs81I
        vpPdysDA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSg-00077r-0Z; Wed, 16 Dec 2020 18:23:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/25] mm: Add folio_mapping
Date:   Wed, 16 Dec 2020 18:23:26 +0000
Message-Id: <20201216182335.27227-17-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the folio equivalent of page_mapping().  Adjust
page_file_mapping() and page_mapping_file() to use folios internally.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 16 ++++++++++------
 mm/swapfile.c      |  6 +++---
 mm/util.c          | 20 ++++++++++----------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 02ccb7a09190..8bc28b4aa933 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1559,17 +1559,22 @@ void page_address_init(void);
 
 extern void *page_rmapping(struct page *page);
 extern struct anon_vma *page_anon_vma(struct page *page);
-extern struct address_space *page_mapping(struct page *page);
+struct address_space *folio_mapping(struct folio *);
+struct address_space *__folio_file_mapping(struct folio *);
 
-extern struct address_space *__page_file_mapping(struct page *);
+static inline struct address_space *page_mapping(struct page *page)
+{
+	return folio_mapping(page_folio(page));
+}
 
 static inline
 struct address_space *page_file_mapping(struct page *page)
 {
-	if (unlikely(PageSwapCache(page)))
-		return __page_file_mapping(page);
+	struct folio *folio = page_folio(page);
+	if (unlikely(FolioSwapCache(folio)))
+		return __folio_file_mapping(folio);
 
-	return page->mapping;
+	return folio->page.mapping;
 }
 
 extern pgoff_t __page_file_index(struct page *page);
@@ -1586,7 +1591,6 @@ static inline pgoff_t page_index(struct page *page)
 }
 
 bool page_mapped(struct page *page);
-struct address_space *page_mapping(struct page *page);
 struct address_space *page_mapping_file(struct page *page);
 
 /*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1c0a829f7311..9bf2f8daaa79 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3550,11 +3550,11 @@ struct swap_info_struct *page_swap_info(struct page *page)
 /*
  * out-of-line __page_file_ methods to avoid include hell.
  */
-struct address_space *__page_file_mapping(struct page *page)
+struct address_space *__folio_file_mapping(struct folio *folio)
 {
-	return page_swap_info(page)->swap_file->f_mapping;
+	return page_swap_info(&folio->page)->swap_file->f_mapping;
 }
-EXPORT_SYMBOL_GPL(__page_file_mapping);
+EXPORT_SYMBOL_GPL(__folio_file_mapping);
 
 pgoff_t __page_file_index(struct page *page)
 {
diff --git a/mm/util.c b/mm/util.c
index 8c9b7d1e7c49..7e9fc89c883a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -686,39 +686,39 @@ struct anon_vma *page_anon_vma(struct page *page)
 	return __page_rmapping(page);
 }
 
-struct address_space *page_mapping(struct page *page)
+struct address_space *folio_mapping(struct folio *folio)
 {
 	struct address_space *mapping;
 
-	page = compound_head(page);
-
 	/* This happens if someone calls flush_dcache_page on slab page */
-	if (unlikely(PageSlab(page)))
+	if (unlikely(FolioSlab(folio)))
 		return NULL;
 
-	if (unlikely(PageSwapCache(page))) {
+	if (unlikely(FolioSwapCache(folio))) {
 		swp_entry_t entry;
 
-		entry.val = page_private(page);
+		entry.val = page_private(&folio->page);
 		return swap_address_space(entry);
 	}
 
-	mapping = page->mapping;
+	mapping = folio->page.mapping;
 	if ((unsigned long)mapping & PAGE_MAPPING_ANON)
 		return NULL;
 
 	return (void *)((unsigned long)mapping & ~PAGE_MAPPING_FLAGS);
 }
-EXPORT_SYMBOL(page_mapping);
+EXPORT_SYMBOL(folio_mapping);
 
 /*
  * For file cache pages, return the address_space, otherwise return NULL
  */
 struct address_space *page_mapping_file(struct page *page)
 {
-	if (unlikely(PageSwapCache(page)))
+	struct folio *folio = page_folio(page);
+
+	if (unlikely(FolioSwapCache(folio)))
 		return NULL;
-	return page_mapping(page);
+	return folio_mapping(folio);
 }
 
 /* Slow path of page_mapcount() for compound pages */
-- 
2.29.2

