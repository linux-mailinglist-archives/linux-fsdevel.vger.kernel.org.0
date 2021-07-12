Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0ED53C6453
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbhGLT6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhGLT6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:58:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF025C0613DD;
        Mon, 12 Jul 2021 12:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=f1kL7tHacjw0givde1BnRTMMDsXMhuTsAIVPryc8kEo=; b=pjYyx6pu3IpmiWUquHFGq16EFi
        9b+1l+r37KyZTGzMSRWflQri2kbwe9qCNvFP/ahf6UtDJdRyqEA9R9KbC74YFJyfTXQ0E7ychh8pA
        UKSPemfRwmIrxSPK0i8+AvGvSxqVGVcHPaBSiv9b3zmybU9q2kWE02U86ALvyLi/CgoGZ9jPPzIs4
        YSfNb1HHXjxfcPJIfpEjY1ZkjBJpJM35JwZzv94lRWKWSNLBtE0/vjb3XEGETabM4KjDCbAWLyhyh
        Ch29Kl1ZLtUKvqBpplg4YvzzWi15pNledygu6co0H0uGcxByjltq9hkeA8O38bqGtZZkxP9E93xBu
        9Sh23Ecg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m320Z-000OZJ-7q; Mon, 12 Jul 2021 19:54:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v13 17/18] mm/memcg: Add folio_lruvec_relock_irq() and folio_lruvec_relock_irqsave()
Date:   Mon, 12 Jul 2021 20:45:50 +0100
Message-Id: <20210712194551.91920-18-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712194551.91920-1-willy@infradead.org>
References: <20210712194551.91920-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are the folio equivalents of relock_page_lruvec_irq() and
folio_lruvec_relock_irqsave().  Also convert page_matches_lruvec()
to folio_matches_lruvec().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h | 17 ++++++++---------
 mm/mlock.c                 |  3 ++-
 mm/swap.c                  | 11 +++++++----
 mm/vmscan.c                |  5 +++--
 4 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 57b1bf457f51..469e5473bdfb 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1529,19 +1529,19 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
 }
 
 /* Test requires a stable page->memcg binding, see page_memcg() */
-static inline bool page_matches_lruvec(struct page *page, struct lruvec *lruvec)
+static inline bool folio_matches_lruvec(struct folio *folio,
+		struct lruvec *lruvec)
 {
-	return lruvec_pgdat(lruvec) == page_pgdat(page) &&
-	       lruvec_memcg(lruvec) == page_memcg(page);
+	return lruvec_pgdat(lruvec) == folio_pgdat(folio) &&
+	       lruvec_memcg(lruvec) == folio_memcg(folio);
 }
 
 /* Don't lock again iff page's lruvec locked */
-static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
+static inline struct lruvec *folio_lruvec_relock_irq(struct folio *folio,
 		struct lruvec *locked_lruvec)
 {
-	struct folio *folio = page_folio(page);
 	if (locked_lruvec) {
-		if (page_matches_lruvec(page, locked_lruvec))
+		if (folio_matches_lruvec(folio, locked_lruvec))
 			return locked_lruvec;
 
 		unlock_page_lruvec_irq(locked_lruvec);
@@ -1551,12 +1551,11 @@ static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
 }
 
 /* Don't lock again iff page's lruvec locked */
-static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
+static inline struct lruvec *folio_lruvec_relock_irqsave(struct folio *folio,
 		struct lruvec *locked_lruvec, unsigned long *flags)
 {
-	struct folio *folio = page_folio(page);
 	if (locked_lruvec) {
-		if (page_matches_lruvec(page, locked_lruvec))
+		if (folio_matches_lruvec(folio, locked_lruvec))
 			return locked_lruvec;
 
 		unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
diff --git a/mm/mlock.c b/mm/mlock.c
index 16d2ee160d43..e263d62ae2d0 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -271,6 +271,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 	/* Phase 1: page isolation */
 	for (i = 0; i < nr; i++) {
 		struct page *page = pvec->pages[i];
+		struct folio *folio = page_folio(page);
 
 		if (TestClearPageMlocked(page)) {
 			/*
@@ -278,7 +279,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 			 * so we can spare the get_page() here.
 			 */
 			if (TestClearPageLRU(page)) {
-				lruvec = relock_page_lruvec_irq(page, lruvec);
+				lruvec = folio_lruvec_relock_irq(folio, lruvec);
 				del_page_from_lru_list(page, lruvec);
 				continue;
 			} else
diff --git a/mm/swap.c b/mm/swap.c
index a82812caf409..42222653e6ef 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -211,12 +211,13 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
+		struct folio *folio = page_folio(page);
 
 		/* block memcg migration during page moving between lru */
 		if (!TestClearPageLRU(page))
 			continue;
 
-		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
+		lruvec = folio_lruvec_relock_irqsave(folio, lruvec, &flags);
 		(*move_fn)(page, lruvec);
 
 		SetPageLRU(page);
@@ -907,6 +908,7 @@ void release_pages(struct page **pages, int nr)
 
 	for (i = 0; i < nr; i++) {
 		struct page *page = pages[i];
+		struct folio *folio = page_folio(page);
 
 		/*
 		 * Make sure the IRQ-safe lock-holding time does not get
@@ -918,7 +920,7 @@ void release_pages(struct page **pages, int nr)
 			lruvec = NULL;
 		}
 
-		page = compound_head(page);
+		page = &folio->page;
 		if (is_huge_zero_page(page))
 			continue;
 
@@ -957,7 +959,7 @@ void release_pages(struct page **pages, int nr)
 		if (PageLRU(page)) {
 			struct lruvec *prev_lruvec = lruvec;
 
-			lruvec = relock_page_lruvec_irqsave(page, lruvec,
+			lruvec = folio_lruvec_relock_irqsave(folio, lruvec,
 									&flags);
 			if (prev_lruvec != lruvec)
 				lock_batch = 0;
@@ -1061,8 +1063,9 @@ void __pagevec_lru_add(struct pagevec *pvec)
 
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
+		struct folio *folio = page_folio(page);
 
-		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
+		lruvec = folio_lruvec_relock_irqsave(folio, lruvec, &flags);
 		__pagevec_lru_add_fn(page, lruvec);
 	}
 	if (lruvec)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0d48306d37dc..7a2f25b904d9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2075,7 +2075,7 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
 		 * All pages were isolated from the same lruvec (and isolation
 		 * inhibits memcg migration).
 		 */
-		VM_BUG_ON_PAGE(!page_matches_lruvec(page, lruvec), page);
+		VM_BUG_ON_PAGE(!folio_matches_lruvec(page_folio(page), lruvec), page);
 		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
@@ -4514,6 +4514,7 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 
 	for (i = 0; i < pvec->nr; i++) {
 		struct page *page = pvec->pages[i];
+		struct folio *folio = page_folio(page);
 		int nr_pages;
 
 		if (PageTransTail(page))
@@ -4526,7 +4527,7 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 		if (!TestClearPageLRU(page))
 			continue;
 
-		lruvec = relock_page_lruvec_irq(page, lruvec);
+		lruvec = folio_lruvec_relock_irq(folio, lruvec);
 		if (page_evictable(page) && PageUnevictable(page)) {
 			del_page_from_lru_list(page, lruvec);
 			ClearPageUnevictable(page);
-- 
2.30.2

