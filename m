Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E563C4254
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbhGLD4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbhGLD4H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:56:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D482C0613E8;
        Sun, 11 Jul 2021 20:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=q9NmHAenqYTBxelcEw91o9UPmxVbgGrVj1KNyeBfTGA=; b=BrZg6ig71iKbtskl8zxErKUcjC
        7iVxulyqf9SEqygQjUOKilyRvQHEz/yHj4Q0E5nRvHHkxMg5nSDBsRWL2uV9Ye4lhvc0MtgkMyqeK
        kO2TZ5ICYaFs6W2RJnYrpvuXulOQthy0IMxnYxInRj5NUqodCaaHkTDoK+pYDuV+XHEmUPkPAXYP9
        MjABPTxT73ZnEeym8HFURCWMhLVivDp/G3La/0hr9hEbAk6v5o9b+6RjmSH3haqRzM5tv74CeB3mT
        QckyTpc9Bns1gvIF+Zspoh6cQizUldFqR/mQU4TvUCtSv/oW3g9KZ0fb80emmhL6sLwQYYLdWBdJz
        Pd8HolCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2myk-00GptO-Pv; Mon, 12 Jul 2021 03:51:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 083/137] mm/page_alloc: Add folio allocation functions
Date:   Mon, 12 Jul 2021 04:06:07 +0100
Message-Id: <20210712030701.4000097-84-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The __alloc_folio(), __alloc_folio_node() and alloc_folio() functions
are mostly for type safety, but they also ensure that the page allocator
allocates a compound page and initialises the deferred list if the page
is large enough to have one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/gfp.h | 16 ++++++++++++++++
 mm/mempolicy.c      | 10 ++++++++++
 mm/page_alloc.c     | 12 ++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index dc5ff40608ce..48b293f097f6 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -523,6 +523,8 @@ static inline void arch_alloc_page(struct page *page, int order) { }
 
 struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask);
+struct folio *__alloc_folio(gfp_t gfp, unsigned int order, int preferred_nid,
+		nodemask_t *nodemask);
 
 unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 				nodemask_t *nodemask, int nr_pages,
@@ -564,6 +566,15 @@ __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
 	return __alloc_pages(gfp_mask, order, nid, NULL);
 }
 
+static inline
+struct folio *__alloc_folio_node(gfp_t gfp, unsigned int order, int nid)
+{
+	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
+	VM_WARN_ON((gfp & __GFP_THISNODE) && !node_online(nid));
+
+	return __alloc_folio(gfp, order, nid, NULL);
+}
+
 /*
  * Allocate pages, preferring the node given as nid. When nid == NUMA_NO_NODE,
  * prefer the current CPU's closest node. Otherwise node must be valid and
@@ -580,6 +591,7 @@ static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
 
 #ifdef CONFIG_NUMA
 struct page *alloc_pages(gfp_t gfp, unsigned int order);
+struct folio *alloc_folio(gfp_t gfp, unsigned order);
 extern struct page *alloc_pages_vma(gfp_t gfp_mask, int order,
 			struct vm_area_struct *vma, unsigned long addr,
 			int node, bool hugepage);
@@ -590,6 +602,10 @@ static inline struct page *alloc_pages(gfp_t gfp_mask, unsigned int order)
 {
 	return alloc_pages_node(numa_node_id(), gfp_mask, order);
 }
+static inline struct folio *alloc_folio(gfp_t gfp, unsigned int order)
+{
+	return __alloc_folio_node(gfp, order, numa_node_id());
+}
 #define alloc_pages_vma(gfp_mask, order, vma, addr, node, false)\
 	alloc_pages(gfp_mask, order)
 #define alloc_hugepage_vma(gfp_mask, vma, addr, order) \
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e32360e90274..eb0ca234a4f8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2249,6 +2249,16 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
 }
 EXPORT_SYMBOL(alloc_pages);
 
+struct folio *alloc_folio(gfp_t gfp, unsigned order)
+{
+	struct page *page = alloc_pages(gfp | __GFP_COMP, order);
+
+	if (page && order > 1)
+		prep_transhuge_page(page);
+	return (struct folio *)page;
+}
+EXPORT_SYMBOL(alloc_folio);
+
 int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
 {
 	struct mempolicy *pol = mpol_dup(vma_policy(src));
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d72a0d9d4184..33ad323b98fb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5399,6 +5399,18 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 }
 EXPORT_SYMBOL(__alloc_pages);
 
+struct folio *__alloc_folio(gfp_t gfp, unsigned int order, int preferred_nid,
+		nodemask_t *nodemask)
+{
+	struct page *page = __alloc_pages(gfp | __GFP_COMP, order,
+			preferred_nid, nodemask);
+
+	if (page && order > 1)
+		prep_transhuge_page(page);
+	return (struct folio *)page;
+}
+EXPORT_SYMBOL(__alloc_folio);
+
 /*
  * Common helper functions. Never use with __GFP_HIGHMEM because the returned
  * address cannot represent highmem pages. Use alloc_pages and then kmap if
-- 
2.30.2

