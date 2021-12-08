Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341E346CC73
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbhLHE1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244194AbhLHE0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D3EC061756
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LzRPcOvyDDpS1jsrCMbiNg3YzKKOXZo0QJAK9qeJoI8=; b=BdwPdLA/HMldvSRT7Ya8AkcgLW
        aG/1slEVWDDVmq+ciFHkcc+WZ0E1qyTn5S43Lkd7avC/VcRd/nEEaN447f96TlJyZZltXmrFC4q9T
        G1cumgdT4paszQFwEtrriIxqOs2JyITXvPAQ36/fILd4lV4ue2rLGiHexGqYS33xio9wbH4Ids2QF
        c2bJrOrg9pETbshjNAzd946pHG7PADgnrR31SwP31/8dmMMIB3uYP11sEsgre0zTFTgqsQsAJ+ekm
        gJgFUPuFL8gV2wOi4bUvZ5blEx1bTfAMW98xtHN2kpCaSy/9/3anEfmc5darWzJ8qloKW36ziopRm
        tSlrpJqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU7-0084dN-PX; Wed, 08 Dec 2021 04:23:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 43/48] mm: Remove pagevec_remove_exceptionals()
Date:   Wed,  8 Dec 2021 04:22:51 +0000
Message-Id: <20211208042256.1923824-44-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All of its callers now call folio_batch_remove_exceptionals().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagevec.h |  6 +-----
 mm/swap.c               | 26 +++++++++++++-------------
 mm/truncate.c           |  2 +-
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 4483e6ad7607..7d3494f7fb70 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -26,7 +26,6 @@ struct pagevec {
 
 void __pagevec_release(struct pagevec *pvec);
 void __pagevec_lru_add(struct pagevec *pvec);
-void pagevec_remove_exceptionals(struct pagevec *pvec);
 unsigned pagevec_lookup_range(struct pagevec *pvec,
 			      struct address_space *mapping,
 			      pgoff_t *start, pgoff_t end);
@@ -140,8 +139,5 @@ static inline void folio_batch_release(struct folio_batch *fbatch)
 	pagevec_release((struct pagevec *)fbatch);
 }
 
-static inline void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
-{
-	pagevec_remove_exceptionals((struct pagevec *)fbatch);
-}
+void folio_batch_remove_exceptionals(struct folio_batch *fbatch);
 #endif /* _LINUX_PAGEVEC_H */
diff --git a/mm/swap.c b/mm/swap.c
index e8c9dc6d0377..74f6b311d7ee 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1077,24 +1077,24 @@ void __pagevec_lru_add(struct pagevec *pvec)
 }
 
 /**
- * pagevec_remove_exceptionals - pagevec exceptionals pruning
- * @pvec:	The pagevec to prune
+ * folio_batch_remove_exceptionals() - Prune non-folios from a batch.
+ * @fbatch: The batch to prune
  *
- * find_get_entries() fills both pages and XArray value entries (aka
- * exceptional entries) into the pagevec.  This function prunes all
- * exceptionals from @pvec without leaving holes, so that it can be
- * passed on to page-only pagevec operations.
+ * find_get_entries() fills a batch with both folios and shadow/swap/DAX
+ * entries.  This function prunes all the non-folio entries from @fbatch
+ * without leaving holes, so that it can be passed on to folio-only batch
+ * operations.
  */
-void pagevec_remove_exceptionals(struct pagevec *pvec)
+void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
 {
-	int i, j;
+	unsigned int i, j;
 
-	for (i = 0, j = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
-		if (!xa_is_value(page))
-			pvec->pages[j++] = page;
+	for (i = 0, j = 0; i < folio_batch_count(fbatch); i++) {
+		struct folio *folio = fbatch->folios[i];
+		if (!xa_is_value(folio))
+			fbatch->folios[j++] = folio;
 	}
-	pvec->nr = j;
+	fbatch->nr = j;
 }
 
 /**
diff --git a/mm/truncate.c b/mm/truncate.c
index e7f5762c43d3..a1113b0abb30 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -57,7 +57,7 @@ static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
 /*
  * Unconditionally remove exceptional entries. Usually called from truncate
  * path. Note that the folio_batch may be altered by this function by removing
- * exceptional entries similar to what pagevec_remove_exceptionals does.
+ * exceptional entries similar to what folio_batch_remove_exceptionals() does.
  */
 static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 				struct folio_batch *fbatch, pgoff_t *indices)
-- 
2.33.0

