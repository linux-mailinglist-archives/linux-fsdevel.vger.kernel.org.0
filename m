Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47D63C4215
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhGLDnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbhGLDnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:43:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0451AC0613DD;
        Sun, 11 Jul 2021 20:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/LpRxwI0a5JPsxL+ej+zucGBSZozcfCDVb/8ZTlMYvc=; b=HEhGcBeHi2zEt8PFXkZKEmakaQ
        GoVcp7LmWTEvDP9a9ZqfNZQJVTndBb3+sYd1w4K4w/Rlz/SSEw8rEwqDVjsMFO4o9OUh8PbqDoynF
        ljqqMGfMKBhDJ2AcesOWF+os/AT6kXge0sScaDUFBysQ3GTkhzV37WBHht4UoXXqOvtOZ9ffrM90N
        ow/lMs4zvy1BWmz/vHKWzHkVjhRFukRAHBbGFze/nC/qrLVC0ATi1dX9PVykXI98qthh/zd3jExwv
        RPNug96BiI1S/HCA7XfydbxsSFDQqRyUusisaOPZaNVnSl+bbtZKcy8eJHS8UUYFxZomNWRMMukEp
        iGsfP3CA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mnc-00Gp5p-KV; Mon, 12 Jul 2021 03:40:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 062/137] mm/migrate: Add folio_migrate_copy()
Date:   Mon, 12 Jul 2021 04:05:46 +0100
Message-Id: <20210712030701.4000097-63-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Combine the THP, hugetlb and base page routines together into a simple
loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/migrate.h |  1 +
 mm/folio-compat.c       |  6 ++++
 mm/migrate.c            | 67 +++++++----------------------------------
 3 files changed, 18 insertions(+), 56 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index b9cd88915c6b..e8db1d87f1f1 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -53,6 +53,7 @@ extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, int extra_count);
 extern void copy_huge_page(struct page *dst, struct page *src);
 void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
+void folio_migrate_copy(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int extra_count);
 #else
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 3f00ad92d1ff..2ccd8f213fc4 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -64,4 +64,10 @@ void migrate_page_states(struct page *newpage, struct page *page)
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
index c16923052e13..942a5ce11f39 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -537,54 +537,6 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
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
-void copy_huge_page(struct page *dst, struct page *src)
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
@@ -661,16 +613,19 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 }
 EXPORT_SYMBOL(folio_migrate_flags);
 
-void migrate_page_copy(struct page *newpage, struct page *page)
+void folio_migrate_copy(struct folio *newfolio, struct folio *folio)
 {
-	if (PageHuge(page) || PageTransHuge(page))
-		copy_huge_page(newpage, page);
-	else
-		copy_highpage(newpage, page);
+	unsigned int i, nr = folio_nr_pages(folio);
 
-	migrate_page_states(newpage, page);
+	for (i = 0; i < nr; i++) {
+		/* folio_page() handles discontinuities in memmap */
+		copy_highpage(folio_page(newfolio, i), folio_page(folio, i));
+		cond_resched();
+	}
+
+	folio_migrate_flags(newfolio, folio);
 }
-EXPORT_SYMBOL(migrate_page_copy);
+EXPORT_SYMBOL(folio_migrate_copy);
 
 /************************************************************
  *                    Migration functions
@@ -698,7 +653,7 @@ int migrate_page(struct address_space *mapping,
 		return rc;
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
-		migrate_page_copy(newpage, page);
+		folio_migrate_copy(newfolio, folio);
 	else
 		folio_migrate_flags(newfolio, folio);
 	return MIGRATEPAGE_SUCCESS;
-- 
2.30.2

