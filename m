Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B31637006A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 20:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhD3SYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 14:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3SYf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:24:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7306C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8aDuFQ1+AmBsOD6ccbEBe+psbFWwP4kzVzlllUFhuRk=; b=CZjmrgrUGlTG6G9ACzol551UnC
        vzbvkYHE2vKNxmIKDUBk9GcO3oe97HICRjqc3VPaiKd6QF4DM5yFSishmEEt1OZF98c++yTmT3a9j
        n1eVfYVTI0WgHqyut0THawXQA6pv1Fi0Dei6xaRGF4xL2XiTixogv+bO/SNO0HU2QuX7Pssqna9+O
        HwofK9iXAQgxM21tNWZzC5sKwuuYPQ0Va+xvq8vyurYWcLRCakaLyxsqlSa2unTzb5Qyv5ELu+4mf
        Y3izyFvT6xppAnSp9TafMdL90s2G6vgmsm8kJELwkBh4fJBlC31FFUw/tdkU+kyWVtTLTzkjW1XEv
        49uzyX1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcXmO-00BNEL-Es; Fri, 30 Apr 2021 18:22:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 16/31] mm/memcg: Add folio wrappers for various functions
Date:   Fri, 30 Apr 2021 19:07:25 +0100
Message-Id: <20210430180740.2707166-17-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430180740.2707166-1-willy@infradead.org>
References: <20210430180740.2707166-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add new wrapper functions folio_memcg(), lock_folio_memcg(),
unlock_folio_memcg(), mem_cgroup_folio_lruvec() and
count_memcg_folio_event()

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/memcontrol.h | 58 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c193be760709..b45b505be0ec 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -456,6 +456,11 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 		return __page_memcg(page);
 }
 
+static inline struct mem_cgroup *folio_memcg(struct folio *folio)
+{
+	return page_memcg(&folio->page);
+}
+
 /*
  * page_memcg_rcu - locklessly get the memory cgroup associated with a page
  * @page: a pointer to the page struct
@@ -1058,6 +1063,15 @@ static inline void count_memcg_page_event(struct page *page,
 		count_memcg_events(memcg, idx, 1);
 }
 
+static inline void count_memcg_folio_event(struct folio *folio,
+					  enum vm_event_item idx)
+{
+	struct mem_cgroup *memcg = folio_memcg(folio);
+
+	if (memcg)
+		count_memcg_events(memcg, idx, folio_nr_pages(folio));
+}
+
 static inline void count_memcg_event_mm(struct mm_struct *mm,
 					enum vm_event_item idx)
 {
@@ -1477,6 +1491,22 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 }
 #endif /* CONFIG_MEMCG */
 
+static inline void lock_folio_memcg(struct folio *folio)
+{
+	lock_page_memcg(&folio->page);
+}
+
+static inline void unlock_folio_memcg(struct folio *folio)
+{
+	unlock_page_memcg(&folio->page);
+}
+
+static inline struct lruvec *mem_cgroup_folio_lruvec(struct folio *folio,
+						    struct pglist_data *pgdat)
+{
+	return mem_cgroup_page_lruvec(&folio->page, pgdat);
+}
+
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
 {
 	__mod_lruvec_kmem_state(p, idx, 1);
@@ -1544,6 +1574,34 @@ static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
 	return lock_page_lruvec_irqsave(page, flags);
 }
 
+static inline struct lruvec *folio_lock_lruvec(struct folio *folio)
+{
+	return lock_page_lruvec(&folio->page);
+}
+
+static inline struct lruvec *folio_lock_lruvec_irq(struct folio *folio)
+{
+	return lock_page_lruvec_irq(&folio->page);
+}
+
+static inline struct lruvec *folio_lock_lruvec_irqsave(struct folio *folio,
+		unsigned long *flagsp)
+{
+	return lock_page_lruvec_irqsave(&folio->page, flagsp);
+}
+
+static inline struct lruvec *folio_relock_lruvec_irq(struct folio *folio,
+		struct lruvec *locked_lruvec)
+{
+	return relock_page_lruvec_irq(&folio->page, locked_lruvec);
+}
+
+static inline struct lruvec *folio_relock_lruvec_irqsave(struct folio *folio,
+		struct lruvec *locked_lruvec, unsigned long *flagsp)
+{
+	return relock_page_lruvec_irqsave(&folio->page, locked_lruvec, flagsp);
+}
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
-- 
2.30.2

