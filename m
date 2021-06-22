Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63113B053C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhFVMzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbhFVMzW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:55:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC65C061574;
        Tue, 22 Jun 2021 05:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nCxCFjysNyCh6RkGllc10Op/mtTwljwyRAAznyhTVaA=; b=Rtjyrsfx+tOJOGISb3F5TyKLJP
        A+Xf71u0Dz1LHvqfCOE6IDZ/77TDSXqT+DrdTWq/lBsM7Gwly4dptCCOUxWOpxCavwOBH5fp9dVuK
        GzsZVcCE3gTu8SNdZUH0SSH4C96yBlmORBnkbPxumYRIjAt8zaaQhlsfUW8YVQ18cU2NPWKvRQSPI
        eAaKiDHAdPVB+AzBSx4uAnCr3k6DTWBVBAYAissPFeI2+JtyJmNAREob8DPwtVPPi0Muakpjfu+4k
        lI4XNtvncvROnElcOBvK8X7zyNAXfYxsSVEHa0YNHlNBvFPTg48Ifg27oPhIBGPcxGM2oMxkPRLgH
        qQMhEVIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfsS-00EIvf-0s; Tue, 22 Jun 2021 12:51:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 40/46] mm/lru: Add folio_add_lru()
Date:   Tue, 22 Jun 2021 13:15:45 +0100
Message-Id: <20210622121551.3398730-41-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
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
index 8f35ff91ee15..0a8bdd3f8d91 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -108,3 +108,9 @@ bool redirty_page_for_writepage(struct writeback_control *wbc,
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
index f3f1ee9f8616..4dfc4bb6ba09 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -457,29 +457,29 @@ void folio_mark_accessed(struct folio *folio)
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

