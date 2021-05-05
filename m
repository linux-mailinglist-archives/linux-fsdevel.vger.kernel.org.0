Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7F23746E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 19:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbhEERcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbhEERbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 13:31:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A92C061763;
        Wed,  5 May 2021 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JfxTEnUnK/tqXVO6gcU1EqjOhpXt/px5nX2CN/7O05U=; b=p6Iy84ja2OH/RhIoGqe9ou9le7
        blE8oGv+aDU53NzK/QlroDrycyBQS1i2/GzSH1bsGSE3QUIv0W8nWMU33gEYLE/kumRYyTFiRpnFh
        NayMgTr1+w05vorMl3CLaC0zs5cF30GRTF8gA7BmaZ1aHF+cVLOzmgPq8ryeYaLeHX8Omh4M5/PUF
        j7Z/1J0uOisJme10I87BoBcf+ULni//fwb4uPKOoVrJkjs3yTAwrXT0bp0hKbQYv4VvaoCUKTy9cy
        NR8imy86MV4ETVYo+ZjBJA55IH0u/pwXMQQ/g1yRwHqPDExuBkfOwg7Ue+bZU64+zmzQZw0p5zduk
        5bJaRQ8g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKgw-000bqO-MP; Wed, 05 May 2021 16:50:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 75/96] mm/lru: Add folio_add_lru
Date:   Wed,  5 May 2021 16:06:07 +0100
Message-Id: <20210505150628.111735-76-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement lru_cache_add() as a wrapper around folio_add_lru().
Saves 159 bytes of kernel text due to removing calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/swap.h |  1 +
 mm/folio-compat.c    |  6 ++++++
 mm/swap.c            | 22 +++++++++++-----------
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 35d3dba422a8..87bfabd69132 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -345,6 +345,7 @@ extern unsigned long nr_free_buffer_pages(void);
 extern void lru_note_cost(struct lruvec *lruvec, bool file,
 			  unsigned int nr_pages);
 extern void lru_note_cost_folio(struct folio *);
+extern void folio_add_lru(struct folio *);
 extern void lru_cache_add(struct page *);
 void mark_page_accessed(struct page *);
 void folio_mark_accessed(struct folio *);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index a57a1f53512c..7de3839ad072 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -79,3 +79,9 @@ bool redirty_page_for_writepage(struct writeback_control *wbc,
 	return folio_redirty_for_writepage(wbc, page_folio(page));
 }
 EXPORT_SYMBOL(redirty_page_for_writepage);
+
+void lru_cache_add(struct page *page)
+{
+	folio_add_lru(page_folio(page));
+}
+EXPORT_SYMBOL(lru_cache_add);
diff --git a/mm/swap.c b/mm/swap.c
index cd441cdb82fd..1cc6fb618cb5 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -450,29 +450,29 @@ void folio_mark_accessed(struct folio *folio)
 EXPORT_SYMBOL(folio_mark_accessed);
 
 /**
- * lru_cache_add - add a page to a page list
- * @page: the page to be added to the LRU.
+ * folio_add_lru - Add a folio to an LRU list.
+ * @folio: The folio to be added to the LRU.
  *
- * Queue the page for addition to the LRU via pagevec. The decision on whether
+ * Queue the folio for addition to the LRU. The decision on whether
  * to add the page to the [in]active [file|anon] list is deferred until the
- * pagevec is drained. This gives a chance for the caller of lru_cache_add()
- * have the page added to the active list using mark_page_accessed().
+ * pagevec is drained. This gives a chance for the caller of folio_add_lru()
+ * have the folio added to the active list using folio_mark_accessed().
  */
-void lru_cache_add(struct page *page)
+void folio_add_lru(struct folio *folio)
 {
 	struct pagevec *pvec;
 
-	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
-	VM_BUG_ON_PAGE(PageLRU(page), page);
+	VM_BUG_ON_FOLIO(folio_active(folio) && folio_unevictable(folio), folio);
+	VM_BUG_ON_FOLIO(folio_lru(folio), folio);
 
-	get_page(page);
+	folio_get(folio);
 	local_lock(&lru_pvecs.lock);
 	pvec = this_cpu_ptr(&lru_pvecs.lru_add);
-	if (pagevec_add_and_need_flush(pvec, page))
+	if (pagevec_add_and_need_flush(pvec, &folio->page))
 		__pagevec_lru_add(pvec);
 	local_unlock(&lru_pvecs.lock);
 }
-EXPORT_SYMBOL(lru_cache_add);
+EXPORT_SYMBOL(folio_add_lru);
 
 /**
  * lru_cache_add_inactive_or_unevictable
-- 
2.30.2

