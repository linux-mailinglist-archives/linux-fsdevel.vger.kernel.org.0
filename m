Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E687D3B04A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhFVMgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhFVMgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:36:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5046C06175F;
        Tue, 22 Jun 2021 05:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=s+wI02aYL0DJcdDYh8vWqu1GBTzPDL99C2enVOf0Ha8=; b=K5blTSOWLqTPN3LJ/3QTycKQCH
        XDuZvwnkts8pV58FzvsWK16RkIlyiKqh3oOns6/ZULGOzlz1K0JjYWhot9nLUz/aEQNK59YJaFzrg
        FG+AYKvl4NGuG9X2h8w6KAktSzYp3eYQPjbmy3CAY8pwpePkKne4z0GqztIMioXgO7fn5U5Vmow5Y
        kxqQR4yPgx65xz3YbCUm478ek4mKAUHFT33sS++8jVDVmZM90sM4/LjRJIqREnOfwQJAoltk7/JNi
        e7WZ0MZvIRwwzioYnwf+lQbMmaLHMd33pluFLmv4eOigx7GwsfgoWrUOe4IdbTOArr0i0FuJPtFVM
        yq+DWn/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfZS-00EHMP-7U; Tue, 22 Jun 2021 12:32:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/46] mm/migrate: Add folio_migrate_copy()
Date:   Tue, 22 Jun 2021 13:15:25 +0100
Message-Id: <20210622121551.3398730-21-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Combine the THP, hugetlb and base page routines together into a simple
loop.  It does iterate the pages backwards, but real CPUs can prefetch
a backwards walk.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/migrate.h |  1 +
 mm/folio-compat.c       |  6 ++++
 mm/migrate.c            | 68 ++++++++---------------------------------
 3 files changed, 19 insertions(+), 56 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 7993faffa46d..cb67692e659a 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -52,6 +52,7 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, int extra_count);
 void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
+void folio_migrate_copy(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int extra_count);
 #else
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index f0ac904d396f..316c912e49e0 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -76,4 +76,10 @@ void migrate_page_states(struct page *newpage, struct page *page)
 	folio_migrate_flags(page_folio(newpage), page_folio(page));
 }
 EXPORT_SYMBOL(migrate_page_states);
+
+void migrate_page_copy(struct page *newpage, struct page *page)
+{
+	folio_migrate_copy(page_folio(newpage), page_folio(page));
+}
+EXPORT_SYMBOL(migrate_page_copy);
 #endif
diff --git a/mm/migrate.c b/mm/migrate.c
index 8b289156f4c6..bc1362f367ae 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -529,54 +529,6 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 	return MIGRATEPAGE_SUCCESS;
 }
 
-/*
- * Gigantic pages are so large that we do not guarantee that page++ pointer
- * arithmetic will work across the entire page.  We need something more
- * specialized.
- */
-static void __copy_gigantic_page(struct page *dst, struct page *src,
-				int nr_pages)
-{
-	int i;
-	struct page *dst_base = dst;
-	struct page *src_base = src;
-
-	for (i = 0; i < nr_pages; ) {
-		cond_resched();
-		copy_highpage(dst, src);
-
-		i++;
-		dst = mem_map_next(dst, dst_base, i);
-		src = mem_map_next(src, src_base, i);
-	}
-}
-
-static void copy_huge_page(struct page *dst, struct page *src)
-{
-	int i;
-	int nr_pages;
-
-	if (PageHuge(src)) {
-		/* hugetlbfs page */
-		struct hstate *h = page_hstate(src);
-		nr_pages = pages_per_huge_page(h);
-
-		if (unlikely(nr_pages > MAX_ORDER_NR_PAGES)) {
-			__copy_gigantic_page(dst, src, nr_pages);
-			return;
-		}
-	} else {
-		/* thp page */
-		BUG_ON(!PageTransHuge(src));
-		nr_pages = thp_nr_pages(src);
-	}
-
-	for (i = 0; i < nr_pages; i++) {
-		cond_resched();
-		copy_highpage(dst + i, src + i);
-	}
-}
-
 /*
  * Copy the flags and some other ancillary information
  */
@@ -653,16 +605,20 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 }
 EXPORT_SYMBOL(folio_migrate_flags);
 
-void migrate_page_copy(struct page *newpage, struct page *page)
+void folio_migrate_copy(struct folio *newfolio, struct folio *folio)
 {
-	if (PageHuge(page) || PageTransHuge(page))
-		copy_huge_page(newpage, page);
-	else
-		copy_highpage(newpage, page);
+	unsigned int i = folio_nr_pages(folio) - 1;
 
-	migrate_page_states(newpage, page);
+	copy_highpage(folio_page(newfolio, i), folio_page(folio, i));
+	while (i-- > 0) {
+		cond_resched();
+		/* folio_page() handles discontinuities in memmap */
+		copy_highpage(folio_page(newfolio, i), folio_page(folio, i));
+	}
+
+	folio_migrate_flags(newfolio, folio);
 }
-EXPORT_SYMBOL(migrate_page_copy);
+EXPORT_SYMBOL(folio_migrate_copy);
 
 /************************************************************
  *                    Migration functions
@@ -690,7 +646,7 @@ int migrate_page(struct address_space *mapping,
 		return rc;
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
-		migrate_page_copy(newpage, page);
+		folio_migrate_copy(newfolio, folio);
 	else
 		folio_migrate_flags(newfolio, folio);
 	return MIGRATEPAGE_SUCCESS;
-- 
2.30.2

