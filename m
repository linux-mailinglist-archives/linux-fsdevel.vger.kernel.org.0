Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B57F3C424D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhGLDy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhGLDyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:54:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCA1C0613E9;
        Sun, 11 Jul 2021 20:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hCPsVqXxjm0N/FU0q9P/FrCS5OJdQGJhzhL+7mb+OQo=; b=Qth0IQe7Yh7frQmyKCuou98xqR
        LodHIIl2qD0cd46WhfEFDM5UJzkwJjCEfsYReT1BPXEkWPbsAKt9fnmYO1IN6U0SypihCMtTaMsDE
        Ynt3rUpo8uVkFf+GKxhFioPb3Q8sPgNb18cCDEkiBNyApoYhsvuLraXsoPAsUVSNN3zLbriQkLzQK
        eO62NVJ2KzDKt8iVTmuR6kwLLCkACn1Cz4ImY4yH39+ZssLNtA0wOsCbnGMwyaej/kUTucRvLyrOM
        hvETOgmcQ/Eo+iGZDwUQ67Iz2uTHH7LMTmAfhUuA4A9+paVZMD2rTjeHlgFPMWx5HGyBy83T01ruS
        u5tsb+Cg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mxl-00GpqW-Lo; Mon, 12 Jul 2021 03:50:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 081/137] mm/lru: Convert __pagevec_lru_add_fn to take a folio
Date:   Mon, 12 Jul 2021 04:06:05 +0100
Message-Id: <20210712030701.4000097-82-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This saves five calls to compound_head(), totalling 60 bytes of text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/swap.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index fe177a16de84..42851b9d6316 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1001,17 +1001,18 @@ void __pagevec_release(struct pagevec *pvec)
 }
 EXPORT_SYMBOL(__pagevec_release);
 
-static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
+static void __pagevec_lru_add_fn(struct folio *folio, struct lruvec *lruvec)
 {
-	int was_unevictable = TestClearPageUnevictable(page);
-	int nr_pages = thp_nr_pages(page);
+	int was_unevictable = folio_test_clear_unevictable_flag(folio);
+	int nr_pages = folio_nr_pages(folio);
 
-	VM_BUG_ON_PAGE(PageLRU(page), page);
+	VM_BUG_ON_FOLIO(folio_lru(folio), folio);
 
 	/*
-	 * Page becomes evictable in two ways:
+	 * Folio becomes evictable in two ways:
 	 * 1) Within LRU lock [munlock_vma_page() and __munlock_pagevec()].
-	 * 2) Before acquiring LRU lock to put the page to correct LRU and then
+	 * 2) Before acquiring LRU lock to put the folio on the correct LRU
+	 *    and then
 	 *   a) do PageLRU check with lock [check_move_unevictable_pages]
 	 *   b) do PageLRU check before lock [clear_page_mlock]
 	 *
@@ -1020,10 +1021,10 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
 	 *
 	 * #0: __pagevec_lru_add_fn		#1: clear_page_mlock
 	 *
-	 * SetPageLRU()				TestClearPageMlocked()
+	 * folio_set_lru_flag()			folio_test_clear_mlocked_flag()
 	 * smp_mb() // explicit ordering	// above provides strict
 	 *					// ordering
-	 * PageMlocked()			PageLRU()
+	 * folio_mlocked()			folio_lru()
 	 *
 	 *
 	 * if '#1' does not observe setting of PG_lru by '#0' and fails
@@ -1034,21 +1035,21 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
 	 * looking at the same page) and the evictable page will be stranded
 	 * in an unevictable LRU.
 	 */
-	SetPageLRU(page);
+	folio_set_lru_flag(folio);
 	smp_mb__after_atomic();
 
-	if (page_evictable(page)) {
+	if (folio_evictable(folio)) {
 		if (was_unevictable)
 			__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
 	} else {
-		ClearPageActive(page);
-		SetPageUnevictable(page);
+		folio_clear_active_flag(folio);
+		folio_set_unevictable_flag(folio);
 		if (!was_unevictable)
 			__count_vm_events(UNEVICTABLE_PGCULLED, nr_pages);
 	}
 
-	add_page_to_lru_list(page, lruvec);
-	trace_mm_lru_insertion(page);
+	folio_add_to_lru_list(folio, lruvec);
+	trace_mm_lru_insertion(&folio->page);
 }
 
 /*
@@ -1062,11 +1063,10 @@ void __pagevec_lru_add(struct pagevec *pvec)
 	unsigned long flags = 0;
 
 	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
-		struct folio *folio = page_folio(page);
+		struct folio *folio = page_folio(pvec->pages[i]);
 
 		lruvec = folio_lruvec_relock_irqsave(folio, lruvec, &flags);
-		__pagevec_lru_add_fn(page, lruvec);
+		__pagevec_lru_add_fn(folio, lruvec);
 	}
 	if (lruvec)
 		unlock_page_lruvec_irqrestore(lruvec, flags);
-- 
2.30.2

