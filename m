Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FD3373F19
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhEEQBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbhEEQBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:01:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FC8C061574;
        Wed,  5 May 2021 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=np2s/mYIo9fxMLzkLt3OOB8qso9UmRGUQHMLncxaoj0=; b=ptWb/N1RVFf9eAnhGAMQez4ltm
        vzNHQ+/hN2tnbmR6+f4L7EsCcaxMH80tc1gvFLM2tFQuefIieAAFUNLaYLemRpLarcYCswXzeGiQZ
        oP/tD+7fmAvcuHFKRg/SgBYSNau7ktyVF7XZsFUH4jzHdnEgPj/xQNSJ5KtyucbIaR4eSRsjWCYEj
        FCnHBou23umJPNgkpS7FYKhAi5v0HBbdZUKf0C/7f4EJeMSPf4ITpjxbVydBZ7Y0Q4PGn0NVDGTrk
        NLYhiYyP+57mOEj5qfCuQsuETrKdUH74AewP5jYbCU2iprbo6U0Byg2euGFWJwWZR4rL6+t82RS1q
        Wepx7PZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJuX-000XVr-2H; Wed, 05 May 2021 15:58:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 41/96] mm/workingset: Convert workingset_activation to take a folio
Date:   Wed,  5 May 2021 16:05:33 +0100
Message-Id: <20210505150628.111735-42-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
index 6caca11cd2ec..828889349b0b 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -445,7 +445,7 @@ void mark_page_accessed(struct page *page)
 		else
 			__lru_cache_activate_page(page);
 		ClearPageReferenced(page);
-		workingset_activation(page);
+		workingset_activation(page_folio(page));
 	}
 	if (page_is_idle(page))
 		clear_page_idle(page);
diff --git a/mm/workingset.c b/mm/workingset.c
index b7cdeca5a76d..d969403f2b2a 100644
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
+	lruvec = mem_cgroup_folio_lruvec(folio, folio_pgdat(folio));
+	workingset_age_nonresident(lruvec, folio_nr_pages(folio));
 out:
 	rcu_read_unlock();
 }
-- 
2.30.2

