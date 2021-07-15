Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA253C97A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbhGOErn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGOErm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:47:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3697EC06175F;
        Wed, 14 Jul 2021 21:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8eTHk8glw+F+ekL5Cv+Dll9+ELMBL3Xwu0ZsSBcDxyw=; b=XFayHgv6hXG/3Q/T74kaITkNiC
        grZ4R4wACJx5+dNn8E5Wl/Cvb6MJxkSOuFOFSzRQ/tF3hck7QK7LXNWoyzJ6cRdSMgir78+w2Snes
        uwjLVqhSo3wG+SkSkgW3BdkRx23YlXNeg/hdl97ccfkAiXvP0OXn7MUl6xT5MU7VaAkdO9x4xNR7O
        xF6zRCAOd/DeiYYVW78qbdRr+ImSCk8T53/JdZMMDbo1cV+Q+BJhCrAdV7elzzy8pB2WwSOGTRqhj
        dOdg0tXavHzTllRPWHAWvXSyfMHhioC8hZk5Q8TOOP58yaMp4myZCmfA1ekS5tlokSBTldZnHMBQP
        Q6jqTL3g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tDB-002yKj-Sa; Thu, 15 Jul 2021 04:43:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 082/138] mm/lru: Convert __pagevec_lru_add_fn to take a folio
Date:   Thu, 15 Jul 2021 04:36:08 +0100
Message-Id: <20210715033704.692967-83-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This saves five calls to compound_head(), totalling 60 bytes of text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/trace/events/pagemap.h | 32 ++++++++++++++++----------------
 mm/swap.c                      | 34 +++++++++++++++++-----------------
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
index 1fd0185d66e8..171524d3526d 100644
--- a/include/trace/events/pagemap.h
+++ b/include/trace/events/pagemap.h
@@ -16,38 +16,38 @@
 #define PAGEMAP_MAPPEDDISK	0x0020u
 #define PAGEMAP_BUFFERS		0x0040u
 
-#define trace_pagemap_flags(page) ( \
-	(PageAnon(page)		? PAGEMAP_ANONYMOUS  : PAGEMAP_FILE) | \
-	(page_mapped(page)	? PAGEMAP_MAPPED     : 0) | \
-	(PageSwapCache(page)	? PAGEMAP_SWAPCACHE  : 0) | \
-	(PageSwapBacked(page)	? PAGEMAP_SWAPBACKED : 0) | \
-	(PageMappedToDisk(page)	? PAGEMAP_MAPPEDDISK : 0) | \
-	(page_has_private(page) ? PAGEMAP_BUFFERS    : 0) \
+#define trace_pagemap_flags(folio) ( \
+	(folio_test_anon(folio)		? PAGEMAP_ANONYMOUS  : PAGEMAP_FILE) | \
+	(folio_mapped(folio)		? PAGEMAP_MAPPED     : 0) | \
+	(folio_test_swapcache(folio)	? PAGEMAP_SWAPCACHE  : 0) | \
+	(folio_test_swapbacked(folio)	? PAGEMAP_SWAPBACKED : 0) | \
+	(folio_test_mappedtodisk(folio)	? PAGEMAP_MAPPEDDISK : 0) | \
+	(folio_test_private(folio)	? PAGEMAP_BUFFERS    : 0) \
 	)
 
 TRACE_EVENT(mm_lru_insertion,
 
-	TP_PROTO(struct page *page),
+	TP_PROTO(struct folio *folio),
 
-	TP_ARGS(page),
+	TP_ARGS(folio),
 
 	TP_STRUCT__entry(
-		__field(struct page *,	page	)
+		__field(struct folio *,	folio	)
 		__field(unsigned long,	pfn	)
 		__field(enum lru_list,	lru	)
 		__field(unsigned long,	flags	)
 	),
 
 	TP_fast_assign(
-		__entry->page	= page;
-		__entry->pfn	= page_to_pfn(page);
-		__entry->lru	= folio_lru_list(page_folio(page));
-		__entry->flags	= trace_pagemap_flags(page);
+		__entry->folio	= folio;
+		__entry->pfn	= folio_pfn(folio);
+		__entry->lru	= folio_lru_list(folio);
+		__entry->flags	= trace_pagemap_flags(folio);
 	),
 
 	/* Flag format is based on page-types.c formatting for pagemap */
-	TP_printk("page=%p pfn=0x%lx lru=%d flags=%s%s%s%s%s%s",
-			__entry->page,
+	TP_printk("folio=%p pfn=0x%lx lru=%d flags=%s%s%s%s%s%s",
+			__entry->folio,
 			__entry->pfn,
 			__entry->lru,
 			__entry->flags & PAGEMAP_MAPPED		? "M" : " ",
diff --git a/mm/swap.c b/mm/swap.c
index 6e80f30d2e5e..89d4471ceb80 100644
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
+	int was_unevictable = folio_test_clear_unevictable(folio);
+	int nr_pages = folio_nr_pages(folio);
 
-	VM_BUG_ON_PAGE(PageLRU(page), page);
+	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
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
+	 * folio_set_lru()			folio_test_clear_mlocked()
 	 * smp_mb() // explicit ordering	// above provides strict
 	 *					// ordering
-	 * PageMlocked()			PageLRU()
+	 * folio_test_mlocked()			folio_test_lru()
 	 *
 	 *
 	 * if '#1' does not observe setting of PG_lru by '#0' and fails
@@ -1034,21 +1035,21 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
 	 * looking at the same page) and the evictable page will be stranded
 	 * in an unevictable LRU.
 	 */
-	SetPageLRU(page);
+	folio_set_lru(folio);
 	smp_mb__after_atomic();
 
-	if (page_evictable(page)) {
+	if (folio_evictable(folio)) {
 		if (was_unevictable)
 			__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
 	} else {
-		ClearPageActive(page);
-		SetPageUnevictable(page);
+		folio_clear_active(folio);
+		folio_set_unevictable(folio);
 		if (!was_unevictable)
 			__count_vm_events(UNEVICTABLE_PGCULLED, nr_pages);
 	}
 
-	add_page_to_lru_list(page, lruvec);
-	trace_mm_lru_insertion(page);
+	lruvec_add_folio(lruvec, folio);
+	trace_mm_lru_insertion(folio);
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

