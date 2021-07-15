Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BCE3C9708
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhGOET0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhGOET0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:19:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B0FC06175F;
        Wed, 14 Jul 2021 21:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uUR18RhmJaxye44Jc3cuyF0IusRkdQv8pQzStDPWSSc=; b=SsjzMEhsSUfNPMdPdVr1Rv00WL
        iblExqXCV2471LMCh3TsJF9Jvb9IyROFwL8b112MdO4Usn2MxF6ank0hRqvbejBBNiU8+U09OXzcV
        V61YzM7nbqlHIJS3QganRgrwohtxTcYS4PkvbYoyuOay3KW2jYF7dqW5J1eVxKKGYouBcpxQSVGtN
        p6dqBucHiHHWpHvdYh1JlZv49jDqw6hnzR3KZ+SjFG7esiW1e500Mh42F+hktx15bBxeY1/GlldC7
        +kIRb1mhD0tbUE+3FJ7E3LgeDjmAcKlqqQGkZ97IIpn1YoZt/zB6p52fVBheKvAlY6VtlzZEWUSey
        vzEpOIsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3slN-002wVE-TY; Thu, 15 Jul 2021 04:14:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 047/138] mm/memcg: Add folio_lruvec()
Date:   Thu, 15 Jul 2021 04:35:33 +0100
Message-Id: <20210715033704.692967-48-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This replaces mem_cgroup_page_lruvec().  All callers converted.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/memcontrol.h | 20 +++++++++-----------
 mm/compaction.c            |  2 +-
 mm/memcontrol.c            |  9 ++++++---
 mm/swap.c                  |  3 ++-
 mm/workingset.c            |  3 ++-
 5 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4b79dd6b3a9c..4eb329b5d183 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -751,18 +751,17 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 }
 
 /**
- * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
- * @page: the page
+ * folio_lruvec - return lruvec for isolating/putting an LRU folio
+ * @folio: Pointer to the folio.
  *
- * This function relies on page->mem_cgroup being stable.
+ * This function relies on folio->mem_cgroup being stable.
  */
-static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
+static inline struct lruvec *folio_lruvec(struct folio *folio)
 {
-	pg_data_t *pgdat = page_pgdat(page);
-	struct mem_cgroup *memcg = page_memcg(page);
+	struct mem_cgroup *memcg = folio_memcg(folio);
 
-	VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled(), page);
-	return mem_cgroup_lruvec(memcg, pgdat);
+	VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled(), folio);
+	return mem_cgroup_lruvec(memcg, folio_pgdat(folio));
 }
 
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
@@ -1226,10 +1225,9 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 	return &pgdat->__lruvec;
 }
 
-static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
+static inline struct lruvec *folio_lruvec(struct folio *folio)
 {
-	pg_data_t *pgdat = page_pgdat(page);
-
+	struct pglist_data *pgdat = folio_pgdat(folio);
 	return &pgdat->__lruvec;
 }
 
diff --git a/mm/compaction.c b/mm/compaction.c
index 621508e0ecd5..a88f7b893f80 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1028,7 +1028,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (!TestClearPageLRU(page))
 			goto isolate_fail_put;
 
-		lruvec = mem_cgroup_page_lruvec(page);
+		lruvec = folio_lruvec(page_folio(page));
 
 		/* If we already hold the lock, we can skip some rechecking */
 		if (lruvec != locked) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 96d6e6c0a65d..fd578d70b579 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1186,9 +1186,10 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
  */
 struct lruvec *lock_page_lruvec(struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	struct lruvec *lruvec;
 
-	lruvec = mem_cgroup_page_lruvec(page);
+	lruvec = folio_lruvec(folio);
 	spin_lock(&lruvec->lru_lock);
 
 	lruvec_memcg_debug(lruvec, page);
@@ -1198,9 +1199,10 @@ struct lruvec *lock_page_lruvec(struct page *page)
 
 struct lruvec *lock_page_lruvec_irq(struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	struct lruvec *lruvec;
 
-	lruvec = mem_cgroup_page_lruvec(page);
+	lruvec = folio_lruvec(folio);
 	spin_lock_irq(&lruvec->lru_lock);
 
 	lruvec_memcg_debug(lruvec, page);
@@ -1210,9 +1212,10 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
 
 struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
 {
+	struct folio *folio = page_folio(page);
 	struct lruvec *lruvec;
 
-	lruvec = mem_cgroup_page_lruvec(page);
+	lruvec = folio_lruvec(folio);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 
 	lruvec_memcg_debug(lruvec, page);
diff --git a/mm/swap.c b/mm/swap.c
index 11ff40104a2c..4ba77fc8da4f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -315,7 +315,8 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 
 void lru_note_cost_page(struct page *page)
 {
-	lru_note_cost(mem_cgroup_page_lruvec(page),
+	struct folio *folio = page_folio(page);
+	lru_note_cost(folio_lruvec(folio),
 		      page_is_file_lru(page), thp_nr_pages(page));
 }
 
diff --git a/mm/workingset.c b/mm/workingset.c
index 5ba3e42446fa..e62c0f2084a2 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -396,6 +396,7 @@ void workingset_refault(struct page *page, void *shadow)
  */
 void workingset_activation(struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
@@ -410,7 +411,7 @@ void workingset_activation(struct page *page)
 	memcg = page_memcg_rcu(page);
 	if (!mem_cgroup_disabled() && !memcg)
 		goto out;
-	lruvec = mem_cgroup_page_lruvec(page);
+	lruvec = folio_lruvec(folio);
 	workingset_age_nonresident(lruvec, thp_nr_pages(page));
 out:
 	rcu_read_unlock();
-- 
2.30.2

