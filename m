Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC273C9725
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbhGOE1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhGOE1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:27:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E69C06175F;
        Wed, 14 Jul 2021 21:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FsEzydEejG+qhxdXn0JDq99IGXxuSEgNM7cW1AjCAGU=; b=akCCiCCTGAKqrCD9A0Vfe63Ni/
        OKuFuIiFrW5HOM6Mghkqzoj8LITo7D96RBf3s/ipTx50kAfRhJhM5jOZXpaF1uh6HGJyibLCT1OwI
        dubiBX7ELbnTzyTxX3CPmttgHab9J02PuJcuDwRdKZ5c7q+zDPCTNvA+XffY0RT0lkiitS4RjV6Iq
        sf/Xg0hwo8/XWqSufa+xCxL1qL+IobX4qfTeYDUL5fSSoW6j+CdgpZapKNSnsWm+T33exfdRmTd+4
        0xqGTcRvZoEjzq1g+pzQm5U1ggsq2hgZ1TKam8mjt35EwlAdrSn/JzIxFLhj/9979Rp4/NChIr5IW
        lJTOnBqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3stl-002x6a-2Q; Thu, 15 Jul 2021 04:23:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 057/138] mm/swap: Add folio_activate()
Date:   Thu, 15 Jul 2021 04:35:43 +0100
Message-Id: <20210715033704.692967-58-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/trace/events/pagemap.h | 14 +++++-------
 mm/swap.c                      | 41 ++++++++++++++++++----------------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
index 92ad176210ff..1fd0185d66e8 100644
--- a/include/trace/events/pagemap.h
+++ b/include/trace/events/pagemap.h
@@ -60,23 +60,21 @@ TRACE_EVENT(mm_lru_insertion,
 
 TRACE_EVENT(mm_lru_activate,
 
-	TP_PROTO(struct page *page),
+	TP_PROTO(struct folio *folio),
 
-	TP_ARGS(page),
+	TP_ARGS(folio),
 
 	TP_STRUCT__entry(
-		__field(struct page *,	page	)
+		__field(struct folio *,	folio	)
 		__field(unsigned long,	pfn	)
 	),
 
 	TP_fast_assign(
-		__entry->page	= page;
-		__entry->pfn	= page_to_pfn(page);
+		__entry->folio	= folio;
+		__entry->pfn	= folio_pfn(folio);
 	),
 
-	/* Flag format is based on page-types.c formatting for pagemap */
-	TP_printk("page=%p pfn=0x%lx", __entry->page, __entry->pfn)
-
+	TP_printk("folio=%p pfn=0x%lx", __entry->folio, __entry->pfn)
 );
 
 #endif /* _TRACE_PAGEMAP_H */
diff --git a/mm/swap.c b/mm/swap.c
index 85969b36b636..c3137e4e1cd8 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -322,15 +322,15 @@ void lru_note_cost_page(struct page *page)
 		      page_is_file_lru(page), thp_nr_pages(page));
 }
 
-static void __activate_page(struct page *page, struct lruvec *lruvec)
+static void __folio_activate(struct folio *folio, struct lruvec *lruvec)
 {
-	if (!PageActive(page) && !PageUnevictable(page)) {
-		int nr_pages = thp_nr_pages(page);
+	if (!folio_test_active(folio) && !folio_test_unevictable(folio)) {
+		int nr_pages = folio_nr_pages(folio);
 
-		del_page_from_lru_list(page, lruvec);
-		SetPageActive(page);
-		add_page_to_lru_list(page, lruvec);
-		trace_mm_lru_activate(page);
+		lruvec_del_folio(lruvec, folio);
+		folio_set_active(folio);
+		lruvec_add_folio(lruvec, folio);
+		trace_mm_lru_activate(folio);
 
 		__count_vm_events(PGACTIVATE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGACTIVATE,
@@ -339,6 +339,11 @@ static void __activate_page(struct page *page, struct lruvec *lruvec)
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
@@ -352,16 +357,16 @@ static bool need_activate_page_drain(int cpu)
 	return pagevec_count(&per_cpu(lru_pvecs.activate_page, cpu)) != 0;
 }
 
-static void activate_page(struct page *page)
+static void folio_activate(struct folio *folio)
 {
-	page = compound_head(page);
-	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
+	if (folio_test_lru(folio) && !folio_test_active(folio) &&
+	    !folio_test_unevictable(folio)) {
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
@@ -372,17 +377,15 @@ static inline void activate_page_drain(int cpu)
 {
 }
 
-static void activate_page(struct page *page)
+static void folio_activate(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct lruvec *lruvec;
 
-	page = &folio->page;
-	if (TestClearPageLRU(page)) {
+	if (folio_test_clear_lru(folio)) {
 		lruvec = folio_lruvec_lock_irq(folio);
-		__activate_page(page, lruvec);
+		__folio_activate(folio, lruvec);
 		unlock_page_lruvec_irq(lruvec);
-		SetPageLRU(page);
+		folio_set_lru(folio);
 	}
 }
 #endif
@@ -447,7 +450,7 @@ void mark_page_accessed(struct page *page)
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

