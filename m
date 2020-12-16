Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D0D2DC648
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgLPSZK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbgLPSY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:24:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEE2C0611CB;
        Wed, 16 Dec 2020 10:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Spon3JEb1D1RuzZnZpxTX7O/sZzaMaaaECrdSMcxU9w=; b=necVxVlwE3qTytbC6OaXkkAA+H
        qGHvt80/900xFDhvsz9PEPHSi97BiHGUyVKZCghbNt9RQBZMokv7KlJ+X0lkRXokLcuhSZxgHVeqa
        H9C44yCTzG7Xc3jpfD5CL3thPr675NRJZgH4fe0qr1bDxGEbKKzereH64a2d5it6tC4ToVk3XYWXj
        FTEofSFaVscj0Iv1dEYi+pzLx6H8Ha2NDtMXyZgBqriXPW0iFpSoDsM/R/OAzi/OEuKzUHTv1PZyL
        xcyv3nzGK+7XT2i0an914uB77obz+BjSfcb1S9kxnJHufGX83qBtC5QNhLt7YrVw2olJru32iITLi
        g8tXnt6w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSe-00077A-L4; Wed, 16 Dec 2020 18:23:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/25] mm: Add mark_folio_accessed
Date:   Wed, 16 Dec 2020 18:23:22 +0000
Message-Id: <20201216182335.27227-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This already operated on the entire compound page, but now we can avoid
calling compound_head quite so many times.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/swap.h |  8 ++++++--
 mm/swap.c            | 28 +++++++++++++---------------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 5bba15ac5a2e..c097bc9cedd9 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -338,7 +338,7 @@ extern void lru_note_cost(struct lruvec *lruvec, bool file,
 			  unsigned int nr_pages);
 extern void lru_note_cost_page(struct page *);
 extern void lru_cache_add(struct page *);
-extern void mark_page_accessed(struct page *);
+void mark_folio_accessed(struct folio *);
 extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
@@ -348,10 +348,14 @@ extern void deactivate_file_page(struct page *page);
 extern void deactivate_page(struct page *page);
 extern void mark_page_lazyfree(struct page *page);
 extern void swap_setup(void);
-
 extern void lru_cache_add_inactive_or_unevictable(struct page *page,
 						struct vm_area_struct *vma);
 
+static inline void mark_page_accessed(struct page *page)
+{
+	mark_folio_accessed(page_folio(page));
+}
+
 /* linux/mm/vmscan.c */
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
 extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
diff --git a/mm/swap.c b/mm/swap.c
index 490553f3f9ef..c3638a13987f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -411,36 +411,34 @@ static void __lru_cache_activate_page(struct page *page)
  * When a newly allocated page is not yet visible, so safe for non-atomic ops,
  * __SetPageReferenced(page) may be substituted for mark_page_accessed(page).
  */
-void mark_page_accessed(struct page *page)
+void mark_folio_accessed(struct folio *folio)
 {
-	page = compound_head(page);
-
-	if (!PageReferenced(page)) {
-		SetPageReferenced(page);
-	} else if (PageUnevictable(page)) {
+	if (!FolioReferenced(folio)) {
+		SetFolioReferenced(folio);
+	} else if (FolioUnevictable(folio)) {
 		/*
 		 * Unevictable pages are on the "LRU_UNEVICTABLE" list. But,
 		 * this list is never rotated or maintained, so marking an
 		 * evictable page accessed has no effect.
 		 */
-	} else if (!PageActive(page)) {
+	} else if (!FolioActive(folio)) {
 		/*
 		 * If the page is on the LRU, queue it for activation via
 		 * lru_pvecs.activate_page. Otherwise, assume the page is on a
 		 * pagevec, mark it active and it'll be moved to the active
 		 * LRU on the next drain.
 		 */
-		if (PageLRU(page))
-			activate_page(page);
+		if (FolioLRU(folio))
+			activate_page(&folio->page);
 		else
-			__lru_cache_activate_page(page);
-		ClearPageReferenced(page);
-		workingset_activation(page);
+			__lru_cache_activate_page(&folio->page);
+		ClearFolioReferenced(folio);
+		workingset_activation(&folio->page);
 	}
-	if (page_is_idle(page))
-		clear_page_idle(page);
+	if (page_is_idle(&folio->page))
+		clear_page_idle(&folio->page);
 }
-EXPORT_SYMBOL(mark_page_accessed);
+EXPORT_SYMBOL(mark_folio_accessed);
 
 /**
  * lru_cache_add - add a page to a page list
-- 
2.29.2

