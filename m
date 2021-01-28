Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65BC307071
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhA1H5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhA1HFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:05:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB608C06178C;
        Wed, 27 Jan 2021 23:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=n97BXR9ReJR0JFPjaiqobj9UIWajfLaZjYyOGUOO1bs=; b=JFvDcKFejY9Ba0JUcf+zjFkX+f
        Yj626KR5hm04BkAaACmrHMk49sKp2DHP5Wne/Vf0qDK0Eah5D0BJTmpZ4lSSNLIcxERpmK3btHcbm
        C4d3GPHAZTUvIqebHU75xEFnElWBh/gkmf3dOCbkMZvhptJhy8Y9UaHSoOrbLrWmRSM7g8zDk2RW1
        x949hWRX/w3f4smBNZxZR85/JqZSTprHE+rcFNE8+78GudhWxP88E5lKPHTF3yop3Yt4igcozL7uy
        9Qy4rfkvhn532wHGOvXGNSKXRdD6hhjhCQ72az99lYyyayWpv5jLVuKDMXPBEXz9WVHdHnrnStVeN
        TCC8ieEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51Lq-00847Y-Tq; Thu, 28 Jan 2021 07:04:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/25] mm/util: Add folio_mapping and folio_file_mapping
Date:   Thu, 28 Jan 2021 07:03:49 +0000
Message-Id: <20210128070404.1922318-11-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are the folio equivalent of page_mapping() and page_file_mapping().
Adjust page_file_mapping() and page_mapping_file() to use folios
internally.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 23 +++++++++++++++--------
 mm/swapfile.c      |  6 +++---
 mm/util.c          | 20 ++++++++++----------
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d71c5776b571..c6b708007018 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1589,17 +1589,25 @@ void page_address_init(void);
 
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
 
-static inline
-struct address_space *page_file_mapping(struct page *page)
+static inline struct address_space *folio_file_mapping(struct folio *folio)
 {
-	if (unlikely(PageSwapCache(page)))
-		return __page_file_mapping(page);
+	if (unlikely(FolioSwapCache(folio)))
+		return __folio_file_mapping(folio);
 
-	return page->mapping;
+	return folio->page.mapping;
+}
+
+static inline struct address_space *page_file_mapping(struct page *page)
+{
+	return folio_file_mapping(page_folio(page));
 }
 
 extern pgoff_t __page_file_index(struct page *page);
@@ -1616,7 +1624,6 @@ static inline pgoff_t page_index(struct page *page)
 }
 
 bool page_mapped(struct page *page);
-struct address_space *page_mapping(struct page *page);
 struct address_space *page_mapping_file(struct page *page);
 
 /*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 12a18b896fce..b68e94d5b112 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3551,11 +3551,11 @@ struct swap_info_struct *page_swap_info(struct page *page)
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
index c37e24d5fa43..c052c39b9f1c 100644
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
+		entry.val = folio_private(folio);
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

