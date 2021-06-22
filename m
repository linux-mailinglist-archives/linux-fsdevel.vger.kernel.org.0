Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD0A3B0440
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhFVMZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhFVMZi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:25:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A44FC061766;
        Tue, 22 Jun 2021 05:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=scH6wTfS9CaKWyWmjYeKOa5eyuSdi7VD1PUD3aE+XbY=; b=av/rxiDFRzOPEd1eqxf41eEiwr
        2Jm0HWARla6ANY0yOqMhuHYwDWSDfj8jyOuarJTk9P/SKkCeR07c4T2DkuxIebPQ0edyu6k3Cq8J7
        sr2pgKpUmGhBuQcZaPUL/rgOtkKiBFXHOR0Xyg0+pLmg3UJu/89/VmD4m61yGj+kk1VuQtpDJB5fO
        jKLSneBZenzEp5A8A8KtNIxoJok0NrW8CofoDcDNoOldYOYvIlaEsG7U805tErOqjRrJweq98ipea
        1Qt771mEJHSCsYbQwcvGP1JO+xWS75czRAjkn9agLRXK64K9Aig3GHIp19F+IwDovSKcCNKVD+A1i
        Dm/8+ypA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfQF-00EGfr-88; Tue, 22 Jun 2021 12:22:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/46] mm/swap: Add folio_activate()
Date:   Tue, 22 Jun 2021 13:15:13 +0100
Message-Id: <20210622121551.3398730-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This replaces activate_page() and eliminates lots of calls to
compound_head().  Saves net 118 bytes of kernel text.  There are still
some redundant calls to page_folio() here which will be removed when
pagevec_lru_move_fn() is converted to use folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/swap.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 00d1d781c1c3..1d528c8f1cf4 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -319,15 +319,15 @@ void lru_note_cost_page(struct page *page)
 		      page_is_file_lru(page), thp_nr_pages(page));
 }
 
-static void __activate_page(struct page *page, struct lruvec *lruvec)
+static void __folio_activate(struct folio *folio, struct lruvec *lruvec)
 {
-	if (!PageActive(page) && !PageUnevictable(page)) {
-		int nr_pages = thp_nr_pages(page);
+	if (!folio_active(folio) && !folio_unevictable(folio)) {
+		int nr_pages = folio_nr_pages(folio);
 
-		del_page_from_lru_list(page, lruvec);
-		SetPageActive(page);
-		add_page_to_lru_list(page, lruvec);
-		trace_mm_lru_activate(page);
+		folio_del_from_lru_list(folio, lruvec);
+		folio_set_active_flag(folio);
+		folio_add_to_lru_list(folio, lruvec);
+		trace_mm_lru_activate(&folio->page);
 
 		__count_vm_events(PGACTIVATE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGACTIVATE,
@@ -336,6 +336,11 @@ static void __activate_page(struct page *page, struct lruvec *lruvec)
 }
 
 #ifdef CONFIG_SMP
+static void __activate_page(struct page *page, struct lruvec *lruvec)
+{
+	return __folio_activate(page_folio(page), lruvec);
+}
+
 static void activate_page_drain(int cpu)
 {
 	struct pagevec *pvec = &per_cpu(lru_pvecs.activate_page, cpu);
@@ -349,16 +354,16 @@ static bool need_activate_page_drain(int cpu)
 	return pagevec_count(&per_cpu(lru_pvecs.activate_page, cpu)) != 0;
 }
 
-static void activate_page(struct page *page)
+static void folio_activate(struct folio *folio)
 {
-	page = compound_head(page);
-	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
+	if (folio_lru(folio) && !folio_active(folio) &&
+	    !folio_unevictable(folio)) {
 		struct pagevec *pvec;
 
+		folio_get(folio);
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.activate_page);
-		get_page(page);
-		if (pagevec_add_and_need_flush(pvec, page))
+		if (pagevec_add_and_need_flush(pvec, &folio->page))
 			pagevec_lru_move_fn(pvec, __activate_page);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -369,16 +374,15 @@ static inline void activate_page_drain(int cpu)
 {
 }
 
-static void activate_page(struct page *page)
+static void folio_activate(struct folio *folio)
 {
 	struct lruvec *lruvec;
 
-	page = compound_head(page);
-	if (TestClearPageLRU(page)) {
-		lruvec = lock_page_lruvec_irq(page);
-		__activate_page(page, lruvec);
+	if (folio_test_clear_lru_flag(folio)) {
+		lruvec = folio_lock_lruvec_irq(folio);
+		__folio_activate(folio, lruvec);
 		unlock_page_lruvec_irq(lruvec);
-		SetPageLRU(page);
+		folio_set_lru_flag(folio);
 	}
 }
 #endif
@@ -443,7 +447,7 @@ void mark_page_accessed(struct page *page)
 		 * LRU on the next drain.
 		 */
 		if (PageLRU(page))
-			activate_page(page);
+			folio_activate(page_folio(page));
 		else
 			__lru_cache_activate_page(page);
 		ClearPageReferenced(page);
-- 
2.30.2

