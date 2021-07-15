Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82AF3CADA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344110AbhGOUNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245723AbhGOUMy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:12:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DC8C061764
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 13:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=InONYvAMt7FtRQ5+AzVzta7XRdKuWUeYcNdU4eMCT0w=; b=jjYfK4g5aV5nbGNkuul8EM0z+k
        CgAG+ln7VHoZvdZJksil5ts7jYs1wlYAkek6yVQVvgF+4CqbUy/IvWd49V9TRjLm0eT9P24bxZedn
        M2z4I2txI1wyN2f4Zd7+kd3vHgfxBQeOICK7yZtq9pGA7QC/Qh3Gg8WV81uV0fsOOkMjfy/MHRL64
        DN90i5MaMJyMAfb7tcRpYh8VLoeAGCreGUazFNCdBdWY4Sh5po652Tia4/EtImmS7h4TAwIJ3SpSS
        w5dV6KGy6Ln2GT/BqeOU17AucQVXmIxCuOLIp0yz6wGaOqJgnQOE4zWMjLFHHxCbSv75mQrnjZAY9
        wuc9HmDg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m47f3-003nER-90; Thu, 15 Jul 2021 20:09:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v14 08/39] mm/swap: Add folio_mark_accessed()
Date:   Thu, 15 Jul 2021 20:59:59 +0100
Message-Id: <20210715200030.899216-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715200030.899216-1-willy@infradead.org>
References: <20210715200030.899216-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert mark_page_accessed() to folio_mark_accessed().  It already
operated on the entire compound page, but now we can avoid calling
compound_head quite so many times.  Shrinks the function from 424 bytes
to 295 bytes (shrinking by 129 bytes).  The compatibility wrapper is 30
bytes, plus the 8 bytes for the exported symbol means the kernel shrinks
by 91 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/swap.h |  3 ++-
 mm/folio-compat.c    |  7 +++++++
 mm/swap.c            | 34 ++++++++++++++++------------------
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 989d8f78c256..c7a4c0a5863d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -352,7 +352,8 @@ extern void lru_note_cost(struct lruvec *lruvec, bool file,
 			  unsigned int nr_pages);
 extern void lru_note_cost_page(struct page *);
 extern void lru_cache_add(struct page *);
-extern void mark_page_accessed(struct page *);
+void mark_page_accessed(struct page *);
+void folio_mark_accessed(struct folio *);
 
 extern atomic_t lru_disable_count;
 
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 7044fcc8a8aa..a374747ae1c6 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/pagemap.h>
+#include <linux/swap.h>
 
 struct address_space *page_mapping(struct page *page)
 {
@@ -41,3 +42,9 @@ bool page_mapped(struct page *page)
 	return folio_mapped(page_folio(page));
 }
 EXPORT_SYMBOL(page_mapped);
+
+void mark_page_accessed(struct page *page)
+{
+	folio_mark_accessed(page_folio(page));
+}
+EXPORT_SYMBOL(mark_page_accessed);
diff --git a/mm/swap.c b/mm/swap.c
index c3137e4e1cd8..d32007fe23b3 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -390,7 +390,7 @@ static void folio_activate(struct folio *folio)
 }
 #endif
 
-static void __lru_cache_activate_page(struct page *page)
+static void __lru_cache_activate_folio(struct folio *folio)
 {
 	struct pagevec *pvec;
 	int i;
@@ -411,8 +411,8 @@ static void __lru_cache_activate_page(struct page *page)
 	for (i = pagevec_count(pvec) - 1; i >= 0; i--) {
 		struct page *pagevec_page = pvec->pages[i];
 
-		if (pagevec_page == page) {
-			SetPageActive(page);
+		if (pagevec_page == &folio->page) {
+			folio_set_active(folio);
 			break;
 		}
 	}
@@ -430,36 +430,34 @@ static void __lru_cache_activate_page(struct page *page)
  * When a newly allocated page is not yet visible, so safe for non-atomic ops,
  * __SetPageReferenced(page) may be substituted for mark_page_accessed(page).
  */
-void mark_page_accessed(struct page *page)
+void folio_mark_accessed(struct folio *folio)
 {
-	page = compound_head(page);
-
-	if (!PageReferenced(page)) {
-		SetPageReferenced(page);
-	} else if (PageUnevictable(page)) {
+	if (!folio_test_referenced(folio)) {
+		folio_set_referenced(folio);
+	} else if (folio_test_unevictable(folio)) {
 		/*
 		 * Unevictable pages are on the "LRU_UNEVICTABLE" list. But,
 		 * this list is never rotated or maintained, so marking an
 		 * evictable page accessed has no effect.
 		 */
-	} else if (!PageActive(page)) {
+	} else if (!folio_test_active(folio)) {
 		/*
 		 * If the page is on the LRU, queue it for activation via
 		 * lru_pvecs.activate_page. Otherwise, assume the page is on a
 		 * pagevec, mark it active and it'll be moved to the active
 		 * LRU on the next drain.
 		 */
-		if (PageLRU(page))
-			folio_activate(page_folio(page));
+		if (folio_test_lru(folio))
+			folio_activate(folio);
 		else
-			__lru_cache_activate_page(page);
-		ClearPageReferenced(page);
-		workingset_activation(page_folio(page));
+			__lru_cache_activate_folio(folio);
+		folio_clear_referenced(folio);
+		workingset_activation(folio);
 	}
-	if (page_is_idle(page))
-		clear_page_idle(page);
+	if (folio_test_idle(folio))
+		folio_clear_idle(folio);
 }
-EXPORT_SYMBOL(mark_page_accessed);
+EXPORT_SYMBOL(folio_mark_accessed);
 
 /**
  * lru_cache_add - add a page to a page list
-- 
2.30.2

