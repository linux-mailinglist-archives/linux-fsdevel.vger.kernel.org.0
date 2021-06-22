Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B1F3B053F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhFVM4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhFVM4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:56:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8665AC061574;
        Tue, 22 Jun 2021 05:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nwXVZG3l0M94ILeaXKqtRfAaWvr4u/uFLa8y/Za3Xjc=; b=rc8Vwp4DhTKAIgfjzfrn5x8tsP
        kpbS5Q7NzT5WPJcTUH2qyN+NvPjSajbU8UwlgHOCYRdmkQre5uY7xSckC5dJ8ZfFm3vUPyRM9QFqx
        SiWi0TiWKrBdv0aIDn1kD+tlDcxMmFLj2ReVF2rUMa29Cx2ERC40/0IuPBSVxtz/KyWtS+wJX8xbi
        hgCH07+iQgNjMkD+GK3wQ5KIoq3yg/BEV5Jm6kmQqCAMN3ObwWHq3jACj5HIimFcZ0fRMUsmCrDaV
        20svEjaLhA3FH0WXv1DUC5HvZEWs6XWWkzwj1nWd4tTE+4dnuZHmSAQC1U3hCwBmNFf5J0HCyi3ce
        Q1VE46xw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvft2-00EIxQ-Ql; Tue, 22 Jun 2021 12:52:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 41/46] mm/page_alloc: Add folio allocation functions
Date:   Tue, 22 Jun 2021 13:15:46 +0100
Message-Id: <20210622121551.3398730-42-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
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
---
 include/linux/gfp.h | 16 ++++++++++++++++
 mm/mempolicy.c      | 10 ++++++++++
 mm/page_alloc.c     | 12 ++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index a503d928e684..76086c798cb1 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -511,6 +511,8 @@ static inline void arch_alloc_page(struct page *page, int order) { }
 
 struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask);
+struct folio *__alloc_folio(gfp_t gfp, unsigned int order, int preferred_nid,
+		nodemask_t *nodemask);
 
 unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 				nodemask_t *nodemask, int nr_pages,
@@ -543,6 +545,15 @@ __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
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
@@ -559,6 +570,7 @@ static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
 
 #ifdef CONFIG_NUMA
 struct page *alloc_pages(gfp_t gfp, unsigned int order);
+struct folio *alloc_folio(gfp_t gfp, unsigned order);
 extern struct page *alloc_pages_vma(gfp_t gfp_mask, int order,
 			struct vm_area_struct *vma, unsigned long addr,
 			int node, bool hugepage);
@@ -569,6 +581,10 @@ static inline struct page *alloc_pages(gfp_t gfp_mask, unsigned int order)
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
index d79fa299b70c..382fec380f28 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2277,6 +2277,16 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
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
index 6f2e131d08b5..b466d0aaaa18 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5225,6 +5225,18 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
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

