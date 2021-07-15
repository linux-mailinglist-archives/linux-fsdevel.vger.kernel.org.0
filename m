Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781D43C9757
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbhGOE3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhGOE3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:29:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19299C06175F;
        Wed, 14 Jul 2021 21:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ChYVUbanl1dWdHHSfuu2vnPL84wRuFBuMaPbMkia3DU=; b=TQ/19MT57558LuafMWbRXyWSjH
        Bz/42v2uINvTGTk7cQiM8wncugt6XzyCnV1yJ0jc9djX8ZubB5OzTOVxrD4sg1Od0h0rYLIJGhXwQ
        iO7zspuRMU6rFwe56wfQfyRhtTEFp1wsA+r/g90cIyjs2GDDoNmXiaLHPA7ILTjQ8NF1D+Sg4H3dr
        4Vfhv192jznWAIeTpElFvvlvHV6lKJEpxfeLua1XaiE3hPv3ut1DCIB74+rsFVB+FNfOnkdiIAx00
        t786eC/9sulX+1TTZHbkoJjfKbIrkBP6DOUVwivp7LAB/KshIiTMjqHLpUXDYFYL6KLw6A0aooND4
        96xPaclQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sw3-002xE7-0e; Thu, 15 Jul 2021 04:25:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 060/138] mm/migrate: Add folio_migrate_mapping()
Date:   Thu, 15 Jul 2021 04:35:46 +0100
Message-Id: <20210715033704.692967-61-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement migrate_page_move_mapping() as a wrapper around
folio_migrate_mapping().  Saves 193 bytes of kernel text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/migrate.h |  2 +
 mm/folio-compat.c       | 11 ++++++
 mm/migrate.c            | 85 +++++++++++++++++++++--------------------
 3 files changed, 57 insertions(+), 41 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 23dadf7aeba8..eb14495a1f46 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -51,6 +51,8 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 				  struct page *newpage, struct page *page);
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, int extra_count);
+int folio_migrate_mapping(struct address_space *mapping,
+		struct folio *newfolio, struct folio *folio, int extra_count);
 #else
 
 static inline void putback_movable_pages(struct list_head *l) {}
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index a374747ae1c6..d883d964fd52 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -4,6 +4,7 @@
  * eventually.
  */
 
+#include <linux/migrate.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 
@@ -48,3 +49,13 @@ void mark_page_accessed(struct page *page)
 	folio_mark_accessed(page_folio(page));
 }
 EXPORT_SYMBOL(mark_page_accessed);
+
+#ifdef CONFIG_MIGRATION
+int migrate_page_move_mapping(struct address_space *mapping,
+		struct page *newpage, struct page *page, int extra_count)
+{
+	return folio_migrate_mapping(mapping, page_folio(newpage),
+					page_folio(page), extra_count);
+}
+EXPORT_SYMBOL(migrate_page_move_mapping);
+#endif
diff --git a/mm/migrate.c b/mm/migrate.c
index 910552318df3..aa4f2310c5bb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -363,7 +363,7 @@ static int expected_page_refs(struct address_space *mapping, struct page *page)
 	 */
 	expected_count += is_device_private_page(page);
 	if (mapping)
-		expected_count += thp_nr_pages(page) + page_has_private(page);
+		expected_count += compound_nr(page) + page_has_private(page);
 
 	return expected_count;
 }
@@ -376,74 +376,75 @@ static int expected_page_refs(struct address_space *mapping, struct page *page)
  * 2 for pages with a mapping
  * 3 for pages with a mapping and PagePrivate/PagePrivate2 set.
  */
-int migrate_page_move_mapping(struct address_space *mapping,
-		struct page *newpage, struct page *page, int extra_count)
+int folio_migrate_mapping(struct address_space *mapping,
+		struct folio *newfolio, struct folio *folio, int extra_count)
 {
-	XA_STATE(xas, &mapping->i_pages, page_index(page));
+	XA_STATE(xas, &mapping->i_pages, folio_index(folio));
 	struct zone *oldzone, *newzone;
 	int dirty;
-	int expected_count = expected_page_refs(mapping, page) + extra_count;
-	int nr = thp_nr_pages(page);
+	int expected_count = expected_page_refs(mapping, &folio->page) + extra_count;
+	int nr = folio_nr_pages(folio);
 
 	if (!mapping) {
 		/* Anonymous page without mapping */
-		if (page_count(page) != expected_count)
+		if (folio_ref_count(folio) != expected_count)
 			return -EAGAIN;
 
 		/* No turning back from here */
-		newpage->index = page->index;
-		newpage->mapping = page->mapping;
-		if (PageSwapBacked(page))
-			__SetPageSwapBacked(newpage);
+		newfolio->index = folio->index;
+		newfolio->mapping = folio->mapping;
+		if (folio_test_swapbacked(folio))
+			__folio_set_swapbacked(newfolio);
 
 		return MIGRATEPAGE_SUCCESS;
 	}
 
-	oldzone = page_zone(page);
-	newzone = page_zone(newpage);
+	oldzone = folio_zone(folio);
+	newzone = folio_zone(newfolio);
 
 	xas_lock_irq(&xas);
-	if (page_count(page) != expected_count || xas_load(&xas) != page) {
+	if (folio_ref_count(folio) != expected_count ||
+	    xas_load(&xas) != folio) {
 		xas_unlock_irq(&xas);
 		return -EAGAIN;
 	}
 
-	if (!page_ref_freeze(page, expected_count)) {
+	if (!folio_ref_freeze(folio, expected_count)) {
 		xas_unlock_irq(&xas);
 		return -EAGAIN;
 	}
 
 	/*
-	 * Now we know that no one else is looking at the page:
+	 * Now we know that no one else is looking at the folio:
 	 * no turning back from here.
 	 */
-	newpage->index = page->index;
-	newpage->mapping = page->mapping;
-	page_ref_add(newpage, nr); /* add cache reference */
-	if (PageSwapBacked(page)) {
-		__SetPageSwapBacked(newpage);
-		if (PageSwapCache(page)) {
-			SetPageSwapCache(newpage);
-			set_page_private(newpage, page_private(page));
+	newfolio->index = folio->index;
+	newfolio->mapping = folio->mapping;
+	folio_ref_add(newfolio, nr); /* add cache reference */
+	if (folio_test_swapbacked(folio)) {
+		__folio_set_swapbacked(newfolio);
+		if (folio_test_swapcache(folio)) {
+			folio_set_swapcache(newfolio);
+			newfolio->private = folio_get_private(folio);
 		}
 	} else {
-		VM_BUG_ON_PAGE(PageSwapCache(page), page);
+		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
 	}
 
 	/* Move dirty while page refs frozen and newpage not yet exposed */
-	dirty = PageDirty(page);
+	dirty = folio_test_dirty(folio);
 	if (dirty) {
-		ClearPageDirty(page);
-		SetPageDirty(newpage);
+		folio_clear_dirty(folio);
+		folio_set_dirty(newfolio);
 	}
 
-	xas_store(&xas, newpage);
-	if (PageTransHuge(page)) {
+	xas_store(&xas, newfolio);
+	if (nr > 1) {
 		int i;
 
 		for (i = 1; i < nr; i++) {
 			xas_next(&xas);
-			xas_store(&xas, newpage);
+			xas_store(&xas, newfolio);
 		}
 	}
 
@@ -452,7 +453,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	 * to one less reference.
 	 * We know this isn't the last reference.
 	 */
-	page_ref_unfreeze(page, expected_count - nr);
+	folio_ref_unfreeze(folio, expected_count - nr);
 
 	xas_unlock(&xas);
 	/* Leave irq disabled to prevent preemption while updating stats */
@@ -471,18 +472,18 @@ int migrate_page_move_mapping(struct address_space *mapping,
 		struct lruvec *old_lruvec, *new_lruvec;
 		struct mem_cgroup *memcg;
 
-		memcg = page_memcg(page);
+		memcg = folio_memcg(folio);
 		old_lruvec = mem_cgroup_lruvec(memcg, oldzone->zone_pgdat);
 		new_lruvec = mem_cgroup_lruvec(memcg, newzone->zone_pgdat);
 
 		__mod_lruvec_state(old_lruvec, NR_FILE_PAGES, -nr);
 		__mod_lruvec_state(new_lruvec, NR_FILE_PAGES, nr);
-		if (PageSwapBacked(page) && !PageSwapCache(page)) {
+		if (folio_test_swapbacked(folio) && !folio_test_swapcache(folio)) {
 			__mod_lruvec_state(old_lruvec, NR_SHMEM, -nr);
 			__mod_lruvec_state(new_lruvec, NR_SHMEM, nr);
 		}
 #ifdef CONFIG_SWAP
-		if (PageSwapCache(page)) {
+		if (folio_test_swapcache(folio)) {
 			__mod_lruvec_state(old_lruvec, NR_SWAPCACHE, -nr);
 			__mod_lruvec_state(new_lruvec, NR_SWAPCACHE, nr);
 		}
@@ -498,11 +499,11 @@ int migrate_page_move_mapping(struct address_space *mapping,
 
 	return MIGRATEPAGE_SUCCESS;
 }
-EXPORT_SYMBOL(migrate_page_move_mapping);
+EXPORT_SYMBOL(folio_migrate_mapping);
 
 /*
  * The expected number of remaining references is the same as that
- * of migrate_page_move_mapping().
+ * of folio_migrate_mapping().
  */
 int migrate_huge_page_move_mapping(struct address_space *mapping,
 				   struct page *newpage, struct page *page)
@@ -563,7 +564,7 @@ void migrate_page_states(struct page *newpage, struct page *page)
 	if (PageMappedToDisk(page))
 		SetPageMappedToDisk(newpage);
 
-	/* Move dirty on pages not done by migrate_page_move_mapping() */
+	/* Move dirty on pages not done by folio_migrate_mapping() */
 	if (PageDirty(page))
 		SetPageDirty(newpage);
 
@@ -639,11 +640,13 @@ int migrate_page(struct address_space *mapping,
 		struct page *newpage, struct page *page,
 		enum migrate_mode mode)
 {
+	struct folio *newfolio = page_folio(newpage);
+	struct folio *folio = page_folio(page);
 	int rc;
 
-	BUG_ON(PageWriteback(page));	/* Writeback must be complete */
+	BUG_ON(folio_test_writeback(folio));	/* Writeback must be complete */
 
-	rc = migrate_page_move_mapping(mapping, newpage, page, 0);
+	rc = folio_migrate_mapping(mapping, newfolio, folio, 0);
 
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
@@ -2387,7 +2390,7 @@ static void migrate_vma_collect(struct migrate_vma *migrate)
  * @page: struct page to check
  *
  * Pinned pages cannot be migrated. This is the same test as in
- * migrate_page_move_mapping(), except that here we allow migration of a
+ * folio_migrate_mapping(), except that here we allow migration of a
  * ZONE_DEVICE page.
  */
 static bool migrate_vma_check_page(struct page *page)
-- 
2.30.2

