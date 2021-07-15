Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921B63C9698
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 05:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhGODtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 23:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhGODtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:49:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624FCC06175F;
        Wed, 14 Jul 2021 20:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YOwUI2qAcdszbkKuR5ckiu9qObMI6+1n7AV5Fnqf7Ss=; b=ajidZu6ue4C4aWSfTwccXKaMm6
        EYd43L44kymkkrz0PQugRKDWMcs8VM9/AuIRUooy2HaM7n1XDztksFWNrIsJA8qnPtIRQTSYmeEI/
        ftiTujTzvrFwBmtUONIjrk4ASJDitji7QbglQoEnbS6uh9wf5tLh6Wpzs7LB7xu+FUeCs752jlXUe
        5jurBZ4PPdryy9rP8HewfS6i6WRaCfaeukZPx6YHoYKWatq2qjDk9XPuqneG0lqUZZa+N1FYPNGXb
        E5V11lVrhLRHWJkFCjl0SUR6ur+glMLM1v0hoFtUN3iPw2CwshLZGkuDDhYt8b2AfvKV+doV6Q4La
        X4xxoGQA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sIg-002uiH-Ox; Thu, 15 Jul 2021 03:45:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v14 011/138] mm/lru: Add folio LRU functions
Date:   Thu, 15 Jul 2021 04:34:57 +0100
Message-Id: <20210715033704.692967-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Handle arbitrary-order folios being added to the LRU.  By definition,
all pages being added to the LRU were already head or base pages, but
call page_folio() on them anyway to get the type right and avoid the
buried calls to compound_head().

Saves 783 bytes of kernel text; no functions grow.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Howells <dhowells@redhat.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/mm_inline.h      | 98 ++++++++++++++++++++++------------
 include/trace/events/pagemap.h |  2 +-
 2 files changed, 65 insertions(+), 35 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 355ea1ee32bd..ee155d19885e 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -6,22 +6,27 @@
 #include <linux/swap.h>
 
 /**
- * page_is_file_lru - should the page be on a file LRU or anon LRU?
- * @page: the page to test
+ * folio_is_file_lru - should the folio be on a file LRU or anon LRU?
+ * @folio: the folio to test
  *
- * Returns 1 if @page is a regular filesystem backed page cache page or a lazily
- * freed anonymous page (e.g. via MADV_FREE).  Returns 0 if @page is a normal
- * anonymous page, a tmpfs page or otherwise ram or swap backed page.  Used by
- * functions that manipulate the LRU lists, to sort a page onto the right LRU
- * list.
+ * Returns 1 if @folio is a regular filesystem backed page cache folio
+ * or a lazily freed anonymous folio (e.g. via MADV_FREE).  Returns 0 if
+ * @folio is a normal anonymous folio, a tmpfs folio or otherwise ram or
+ * swap backed folio.  Used by functions that manipulate the LRU lists,
+ * to sort a folio onto the right LRU list.
  *
  * We would like to get this info without a page flag, but the state
- * needs to survive until the page is last deleted from the LRU, which
+ * needs to survive until the folio is last deleted from the LRU, which
  * could be as far down as __page_cache_release.
  */
+static inline int folio_is_file_lru(struct folio *folio)
+{
+	return !folio_test_swapbacked(folio);
+}
+
 static inline int page_is_file_lru(struct page *page)
 {
-	return !PageSwapBacked(page);
+	return folio_is_file_lru(page_folio(page));
 }
 
 static __always_inline void update_lru_size(struct lruvec *lruvec,
@@ -39,69 +44,94 @@ static __always_inline void update_lru_size(struct lruvec *lruvec,
 }
 
 /**
- * __clear_page_lru_flags - clear page lru flags before releasing a page
- * @page: the page that was on lru and now has a zero reference
+ * __folio_clear_lru_flags - clear page lru flags before releasing a page
+ * @folio: The folio that was on lru and now has a zero reference
  */
-static __always_inline void __clear_page_lru_flags(struct page *page)
+static __always_inline void __folio_clear_lru_flags(struct folio *folio)
 {
-	VM_BUG_ON_PAGE(!PageLRU(page), page);
+	VM_BUG_ON_FOLIO(!folio_test_lru(folio), folio);
 
-	__ClearPageLRU(page);
+	__folio_clear_lru(folio);
 
 	/* this shouldn't happen, so leave the flags to bad_page() */
-	if (PageActive(page) && PageUnevictable(page))
+	if (folio_test_active(folio) && folio_test_unevictable(folio))
 		return;
 
-	__ClearPageActive(page);
-	__ClearPageUnevictable(page);
+	__folio_clear_active(folio);
+	__folio_clear_unevictable(folio);
+}
+
+static __always_inline void __clear_page_lru_flags(struct page *page)
+{
+	__folio_clear_lru_flags(page_folio(page));
 }
 
 /**
- * page_lru - which LRU list should a page be on?
- * @page: the page to test
+ * folio_lru_list - which LRU list should a folio be on?
+ * @folio: the folio to test
  *
- * Returns the LRU list a page should be on, as an index
+ * Returns the LRU list a folio should be on, as an index
  * into the array of LRU lists.
  */
-static __always_inline enum lru_list page_lru(struct page *page)
+static __always_inline enum lru_list folio_lru_list(struct folio *folio)
 {
 	enum lru_list lru;
 
-	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
+	VM_BUG_ON_FOLIO(folio_test_active(folio) && folio_test_unevictable(folio), folio);
 
-	if (PageUnevictable(page))
+	if (folio_test_unevictable(folio))
 		return LRU_UNEVICTABLE;
 
-	lru = page_is_file_lru(page) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
-	if (PageActive(page))
+	lru = folio_is_file_lru(folio) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
+	if (folio_test_active(folio))
 		lru += LRU_ACTIVE;
 
 	return lru;
 }
 
+static __always_inline
+void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
+{
+	enum lru_list lru = folio_lru_list(folio);
+
+	update_lru_size(lruvec, lru, folio_zonenum(folio),
+			folio_nr_pages(folio));
+	list_add(&folio->lru, &lruvec->lists[lru]);
+}
+
 static __always_inline void add_page_to_lru_list(struct page *page,
 				struct lruvec *lruvec)
 {
-	enum lru_list lru = page_lru(page);
+	lruvec_add_folio(lruvec, page_folio(page));
+}
+
+static __always_inline
+void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
+{
+	enum lru_list lru = folio_lru_list(folio);
 
-	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
-	list_add(&page->lru, &lruvec->lists[lru]);
+	update_lru_size(lruvec, lru, folio_zonenum(folio),
+			folio_nr_pages(folio));
+	list_add_tail(&folio->lru, &lruvec->lists[lru]);
 }
 
 static __always_inline void add_page_to_lru_list_tail(struct page *page,
 				struct lruvec *lruvec)
 {
-	enum lru_list lru = page_lru(page);
+	lruvec_add_folio_tail(lruvec, page_folio(page));
+}
 
-	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
-	list_add_tail(&page->lru, &lruvec->lists[lru]);
+static __always_inline
+void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
+{
+	list_del(&folio->lru);
+	update_lru_size(lruvec, folio_lru_list(folio), folio_zonenum(folio),
+			-folio_nr_pages(folio));
 }
 
 static __always_inline void del_page_from_lru_list(struct page *page,
 				struct lruvec *lruvec)
 {
-	list_del(&page->lru);
-	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
-			-thp_nr_pages(page));
+	lruvec_del_folio(lruvec, page_folio(page));
 }
 #endif
diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
index 1d28431e85bd..92ad176210ff 100644
--- a/include/trace/events/pagemap.h
+++ b/include/trace/events/pagemap.h
@@ -41,7 +41,7 @@ TRACE_EVENT(mm_lru_insertion,
 	TP_fast_assign(
 		__entry->page	= page;
 		__entry->pfn	= page_to_pfn(page);
-		__entry->lru	= page_lru(page);
+		__entry->lru	= folio_lru_list(page_folio(page));
 		__entry->flags	= trace_pagemap_flags(page);
 	),
 
-- 
2.30.2

