Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F68437B134
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 00:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhEKWBb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 18:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEKWBb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 18:01:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614C0C061574;
        Tue, 11 May 2021 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mmbddohNEeRsDxRwAKXX/PXTh9KlAPs8HbwhV9igHZo=; b=Fq+HG68vLbqPw3VwBToQp47/fn
        5TwNY9VijbOu16Gr8Qs4RKreUe30XCpo3RxP7V1pug6vxTk21MfeTg+GHPNiLw+mmMfZOT2pP6hoO
        EbhgUhuikeNz450RHGrt2lP/8ZjtJ6doRH+728Jd+rQum+WIjkC3q15mFxXg9RpY1kneuQHuvzQ1w
        xzvTa44PCmy2Ad9DV7I7CAALSjSMDgVFAI6RDpQs6klUCCIZa7g880p+HMv/UWGWmoCDxC7QRhNHJ
        JCDP/ZyCWABkxIVbuCNVjsJsmytYwUfA5XwKpoDsoSPiViIuZjWucakNLNX/Zx/zTk/uyIRpc9Rxj
        6peJvZMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgaP6-007iH2-5t; Tue, 11 May 2021 21:59:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v10 17/33] mm/memcg: Add folio wrappers for various functions
Date:   Tue, 11 May 2021 22:47:19 +0100
Message-Id: <20210511214735.1836149-18-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511214735.1836149-1-willy@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
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
 include/linux/memcontrol.h | 63 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c193be760709..a3e627ea98e0 100644
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
@@ -1129,6 +1143,11 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 	return NULL;
 }
 
+static inline struct mem_cgroup *folio_memcg(struct folio *folio)
+{
+	return NULL;
+}
+
 static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
@@ -1477,6 +1496,22 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
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
@@ -1544,6 +1579,34 @@ static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
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

