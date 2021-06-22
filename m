Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A783B043C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhFVMZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhFVMZ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:25:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950B4C061574;
        Tue, 22 Jun 2021 05:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KXQr0EAW/6qWp7RwS3LzL0O1c0N0V+KkSoypTfpOEJk=; b=Nd27ewMZUH6hAeUH5oUcVoVF07
        XaOtNq/Tqdm213DT0dkiXcq0lSpcL/Hv6Dlg5/UoyG32BBDNAqOtxGfjULvZ9gWVmphaiCI7a+c+K
        b28CfeFpJeSGGFKZg6zvqRybWyZzPaxp8PeV3yHZRhIsTbKJkWThLbL17gW7yWFkbHxkrLTZiiZRz
        DLgStHgQn6+NHJgfYwAwuqzK/fmlnLfkzgHrmkHI0irrXDQBORZtsSpGIfp/usYuqNl7/gJMRyrZP
        LaSInss0kXykGs6C87pw7vduIVuBh5nyFGLwtqRwEFwUmMJmMMx/+Qowx6G2wfooURGjEkG75pU+J
        qi5SK74Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfPJ-00EGb6-87; Tue, 22 Jun 2021 12:22:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/46] mm/workingset: Convert workingset_activation to take a folio
Date:   Tue, 22 Jun 2021 13:15:12 +0100
Message-Id: <20210622121551.3398730-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function already assumed it was being passed a head page.  No real
change here, except that thp_nr_pages() compiles away on kernels with
THP compiled out while folio_nr_pages() is always present.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/swap.h |  2 +-
 mm/swap.c            |  2 +-
 mm/workingset.c      | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 76b2338ef24d..8e0118b25bdc 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -324,7 +324,7 @@ static inline swp_entry_t folio_swap_entry(struct folio *folio)
 void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
 void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg);
 void workingset_refault(struct page *page, void *shadow);
-void workingset_activation(struct page *page);
+void workingset_activation(struct folio *folio);
 
 /* Only track the nodes of mappings with shadow entries */
 void workingset_update_node(struct xa_node *node);
diff --git a/mm/swap.c b/mm/swap.c
index b01352821583..00d1d781c1c3 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -447,7 +447,7 @@ void mark_page_accessed(struct page *page)
 		else
 			__lru_cache_activate_page(page);
 		ClearPageReferenced(page);
-		workingset_activation(page);
+		workingset_activation(page_folio(page));
 	}
 	if (page_is_idle(page))
 		clear_page_idle(page);
diff --git a/mm/workingset.c b/mm/workingset.c
index b7cdeca5a76d..37cdcda96afd 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -390,9 +390,9 @@ void workingset_refault(struct page *page, void *shadow)
 
 /**
  * workingset_activation - note a page activation
- * @page: page that is being activated
+ * @folio: Folio that is being activated.
  */
-void workingset_activation(struct page *page)
+void workingset_activation(struct folio *folio)
 {
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
@@ -405,11 +405,11 @@ void workingset_activation(struct page *page)
 	 * XXX: See workingset_refault() - this should return
 	 * root_mem_cgroup even for !CONFIG_MEMCG.
 	 */
-	memcg = page_memcg_rcu(page);
+	memcg = page_memcg_rcu(&folio->page);
 	if (!mem_cgroup_disabled() && !memcg)
 		goto out;
-	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
-	workingset_age_nonresident(lruvec, thp_nr_pages(page));
+	lruvec = mem_cgroup_folio_lruvec(folio);
+	workingset_age_nonresident(lruvec, folio_nr_pages(folio));
 out:
 	rcu_read_unlock();
 }
-- 
2.30.2

