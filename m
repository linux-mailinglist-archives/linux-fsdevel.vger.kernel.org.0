Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9450E3C980E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbhGOFKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhGOFKg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:10:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3E0C06175F;
        Wed, 14 Jul 2021 22:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FGRQxEUJ6p7lAjmMrwkwbOhtlThDd4ZGqnuMn7lRPjw=; b=Twu+i2VIXdsztOcHuYD/zyamT+
        CG6mZCrrZ9MhOz+mP5Sh2denNSlnJdLuoMS6x6Baa52aeeCI6fyJ7kFJPM+zr0hfFGdLAy3sB+yB4
        P8w2gonxmwKk6hc22LQ9Qr2X0OkJ8vX3stalQTYZIWqJQiPBMXw3J//b+Wddd9NtrfJUlKDLe1FND
        HJrQGg+ynAC78GcRjg+UopPTP5cG791NI9GcT0E10Q/X3VxaNfQnoo/rVGmNayZgmEQfXzWI5ywgN
        MLQhA91Pq9pnF9YqNw8WrXqQiwah5fvFAhsPXJ9CTEuF/kw49V/m1kAUoakH5BWQPzOCrfBupbr3U
        MvBf3IBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3ta0-002zwc-VF; Thu, 15 Jul 2021 05:06:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 110/138] mm/filemap: Add filemap_remove_folio and __filemap_remove_folio
Date:   Thu, 15 Jul 2021 04:36:36 +0100
Message-Id: <20210715033704.692967-111-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement __delete_from_page_cache() as a wrapper around
__filemap_remove_folio() and delete_from_page_cache() as a wrapper
around filemap_remove_folio().  Remove the EXPORT_SYMBOL as
delete_from_page_cache() was not used by any in-tree modules.
Convert page_cache_free_page() into filemap_free_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  9 +++++++--
 mm/filemap.c            | 44 ++++++++++++++++++++---------------------
 mm/folio-compat.c       |  5 +++++
 3 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f6a2a2589009..245554ce6b12 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -877,8 +877,13 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 		pgoff_t index, gfp_t gfp);
 int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 		pgoff_t index, gfp_t gfp);
-extern void delete_from_page_cache(struct page *page);
-extern void __delete_from_page_cache(struct page *page, void *shadow);
+void filemap_remove_folio(struct folio *folio);
+void delete_from_page_cache(struct page *page);
+void __filemap_remove_folio(struct folio *folio, void *shadow);
+static inline void __delete_from_page_cache(struct page *page, void *shadow)
+{
+	__filemap_remove_folio(page_folio(page), shadow);
+}
 void replace_page_cache_page(struct page *old, struct page *new);
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct pagevec *pvec);
diff --git a/mm/filemap.c b/mm/filemap.c
index 6e8b195edf19..4a81eaff363e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -219,55 +219,53 @@ static void filemap_unaccount_folio(struct address_space *mapping,
  * sure the page is locked and that nobody else uses it - or that usage
  * is safe.  The caller must hold the i_pages lock.
  */
-void __delete_from_page_cache(struct page *page, void *shadow)
+void __filemap_remove_folio(struct folio *folio, void *shadow)
 {
-	struct folio *folio = page_folio(page);
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 
-	trace_mm_filemap_delete_from_page_cache(page);
+	trace_mm_filemap_delete_from_page_cache(&folio->page);
 
 	filemap_unaccount_folio(mapping, folio);
 	page_cache_delete(mapping, folio, shadow);
 }
 
-static void page_cache_free_page(struct address_space *mapping,
-				struct page *page)
+static void filemap_free_folio(struct address_space *mapping,
+				struct folio *folio)
 {
 	void (*freepage)(struct page *);
 
 	freepage = mapping->a_ops->freepage;
 	if (freepage)
-		freepage(page);
+		freepage(&folio->page);
 
-	if (PageTransHuge(page) && !PageHuge(page)) {
-		page_ref_sub(page, thp_nr_pages(page));
-		VM_BUG_ON_PAGE(page_count(page) <= 0, page);
+	if (folio_multi(folio) && !folio_test_hugetlb(folio)) {
+		folio_ref_sub(folio, folio_nr_pages(folio));
+		VM_BUG_ON_FOLIO(folio_ref_count(folio) <= 0, folio);
 	} else {
-		put_page(page);
+		folio_put(folio);
 	}
 }
 
 /**
- * delete_from_page_cache - delete page from page cache
- * @page: the page which the kernel is trying to remove from page cache
+ * filemap_remove_folio - Remove folio from page cache.
+ * @folio: The folio.
  *
- * This must be called only on pages that have been verified to be in the page
- * cache and locked.  It will never put the page into the free list, the caller
- * has a reference on the page.
+ * This must be called only on folios that are locked and have been
+ * verified to be in the page cache.  It will never put the folio into
+ * the free list because the caller has a reference on the page.
  */
-void delete_from_page_cache(struct page *page)
+void filemap_remove_folio(struct folio *folio)
 {
-	struct address_space *mapping = page_mapping(page);
+	struct address_space *mapping = folio->mapping;
 	unsigned long flags;
 
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 	xa_lock_irqsave(&mapping->i_pages, flags);
-	__delete_from_page_cache(page, NULL);
+	__filemap_remove_folio(folio, NULL);
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 
-	page_cache_free_page(mapping, page);
+	filemap_free_folio(mapping, folio);
 }
-EXPORT_SYMBOL(delete_from_page_cache);
 
 /*
  * page_cache_delete_batch - delete several pages from page cache
@@ -350,7 +348,7 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 
 	for (i = 0; i < pagevec_count(pvec); i++)
-		page_cache_free_page(mapping, pvec->pages[i]);
+		filemap_free_folio(mapping, page_folio(pvec->pages[i]));
 }
 
 int filemap_check_errors(struct address_space *mapping)
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 5b6ae1da314e..749a695b4217 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -140,3 +140,8 @@ struct page *grab_cache_page_write_begin(struct address_space *mapping,
 			mapping_gfp_mask(mapping));
 }
 EXPORT_SYMBOL(grab_cache_page_write_begin);
+
+void delete_from_page_cache(struct page *page)
+{
+	return filemap_remove_folio(page_folio(page));
+}
-- 
2.30.2

