Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF4F3B0372
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 13:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhFVL7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 07:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhFVL7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:59:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63375C061574;
        Tue, 22 Jun 2021 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=i7Rps59lL3AnJw771Xsx6NOU13VpX0y0eB80oLHx2B0=; b=trrjrtCIp6vMpVIAPx3cFzFBE3
        qOAJec6NvBi+CokXXVznp3y8gCbfmgvOqBMmAR2jzO2cjtXfTIlgm5I8PJPuhmRsqp8o36O8eI5SM
        2weiYoz+OHIZy7yyOdc6AGNnr+bPO5re2BvZw5JUgysRlhWMwaTqMNcN0H1CywCZ9uAGfbTtXNDQM
        YStNOsstUocuiE9ul282impkDIx24AryFGoHQreoaXuhQd62z+3fHebis+XriqbVzwwE0SK3azZ6U
        uOlZhwHezbcjYm6cxaYzYDhIf3GbPThTSp5WXEZJcl/iTMBJLGk59HTDI536esIngp8B64CBuN+Yo
        q9S0Q86w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvf04-00EESH-51; Tue, 22 Jun 2021 11:55:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v12 17/33] mm/memcg: Add folio wrappers for various functions
Date:   Tue, 22 Jun 2021 12:41:02 +0100
Message-Id: <20210622114118.3388190-18-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622114118.3388190-1-willy@infradead.org>
References: <20210622114118.3388190-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add new wrapper functions folio_memcg(), folio_memcg_rcu(),
lock_folio_memcg(), unlock_folio_memcg(), mem_cgroup_folio_lruvec(),
count_memcg_folio_event() and the folio_lock_lruvec family of
functions.  No change to generated code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 include/linux/memcontrol.h | 72 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c193be760709..4460ff0e70a1 100644
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
@@ -482,6 +487,11 @@ static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
 	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 
+static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
+{
+	return page_memcg_rcu(&folio->page);
+}
+
 /*
  * page_memcg_check - get the memory cgroup associated with a page
  * @page: a pointer to the page struct
@@ -1058,6 +1068,15 @@ static inline void count_memcg_page_event(struct page *page,
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
@@ -1129,12 +1148,22 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
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
 	return NULL;
 }
 
+static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
+{
+	return page_memcg_rcu(&folio->page);
+}
+
 static inline struct mem_cgroup *page_memcg_check(struct page *page)
 {
 	return NULL;
@@ -1477,6 +1506,21 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
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
+static inline struct lruvec *mem_cgroup_folio_lruvec(struct folio *folio)
+{
+	return mem_cgroup_page_lruvec(&folio->page, folio_pgdat(folio));
+}
+
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
 {
 	__mod_lruvec_kmem_state(p, idx, 1);
@@ -1544,6 +1588,34 @@ static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
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

