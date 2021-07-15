Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED4B3CAE04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbhGOUjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbhGOUjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:39:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8557EC061762
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 13:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aG1Z62nXu6WKzoz8firz+hfiIW2uMXHCr6KhoOFkmPs=; b=wSjcZGqCc2vOb+LRU9rIrIQCQb
        s6KjnJYTfsJQT3qUVUVX+ZnwBxRwSj2akQMrjuoJDYdh/9DOOmk9iwy1WNO/+yEUH+YvNg00DMNQT
        nylqleKHcucwRBg4ovhwE3pGBylizf56zn2oelmlUH1Ju0M6OK5V+BGUvNZt3f5g8acrCgMf4DxSJ
        ZXOOBsI/6g91E0DM6/CIdT1fl3MMY+iEL6RjitJyAxX/JPWadTIB07QQsH7/nuqQEr2r8MEHltm3/
        q+LIWx2S1kTNZZjm/Cn61uXVuo6KvAAjU++qgsjUOcegcj7END5D4HDm1a6zz0aKhwuhuYoAtldTG
        WKgbEq+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m483g-003qFb-Vk; Thu, 15 Jul 2021 20:34:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 34/39] mm/page_alloc: Add folio allocation functions
Date:   Thu, 15 Jul 2021 21:00:25 +0100
Message-Id: <20210715200030.899216-35-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715200030.899216-1-willy@infradead.org>
References: <20210715200030.899216-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The __folio_alloc(), __folio_alloc_node() and folio_alloc() functions
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
index dc5ff40608ce..3745efd21cf6 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -523,6 +523,8 @@ static inline void arch_alloc_page(struct page *page, int order) { }
 
 struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask);
+struct folio *__folio_alloc(gfp_t gfp, unsigned int order, int preferred_nid,
+		nodemask_t *nodemask);
 
 unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 				nodemask_t *nodemask, int nr_pages,
@@ -564,6 +566,15 @@ __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
 	return __alloc_pages(gfp_mask, order, nid, NULL);
 }
 
+static inline
+struct folio *__folio_alloc_node(gfp_t gfp, unsigned int order, int nid)
+{
+	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
+	VM_WARN_ON((gfp & __GFP_THISNODE) && !node_online(nid));
+
+	return __folio_alloc(gfp, order, nid, NULL);
+}
+
 /*
  * Allocate pages, preferring the node given as nid. When nid == NUMA_NO_NODE,
  * prefer the current CPU's closest node. Otherwise node must be valid and
@@ -580,6 +591,7 @@ static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
 
 #ifdef CONFIG_NUMA
 struct page *alloc_pages(gfp_t gfp, unsigned int order);
+struct folio *folio_alloc(gfp_t gfp, unsigned order);
 extern struct page *alloc_pages_vma(gfp_t gfp_mask, int order,
 			struct vm_area_struct *vma, unsigned long addr,
 			int node, bool hugepage);
@@ -590,6 +602,10 @@ static inline struct page *alloc_pages(gfp_t gfp_mask, unsigned int order)
 {
 	return alloc_pages_node(numa_node_id(), gfp_mask, order);
 }
+static inline struct folio *folio_alloc(gfp_t gfp, unsigned int order)
+{
+	return __folio_alloc_node(gfp, order, numa_node_id());
+}
 #define alloc_pages_vma(gfp_mask, order, vma, addr, node, false)\
 	alloc_pages(gfp_mask, order)
 #define alloc_hugepage_vma(gfp_mask, vma, addr, order) \
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e32360e90274..95d0cf05f7ca 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2249,6 +2249,16 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
 }
 EXPORT_SYMBOL(alloc_pages);
 
+struct folio *folio_alloc(gfp_t gfp, unsigned order)
+{
+	struct page *page = alloc_pages(gfp | __GFP_COMP, order);
+
+	if (page && order > 1)
+		prep_transhuge_page(page);
+	return (struct folio *)page;
+}
+EXPORT_SYMBOL(folio_alloc);
+
 int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
 {
 	struct mempolicy *pol = mpol_dup(vma_policy(src));
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d72a0d9d4184..d03145671934 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5399,6 +5399,18 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 }
 EXPORT_SYMBOL(__alloc_pages);
 
+struct folio *__folio_alloc(gfp_t gfp, unsigned int order, int preferred_nid,
+		nodemask_t *nodemask)
+{
+	struct page *page = __alloc_pages(gfp | __GFP_COMP, order,
+			preferred_nid, nodemask);
+
+	if (page && order > 1)
+		prep_transhuge_page(page);
+	return (struct folio *)page;
+}
+EXPORT_SYMBOL(__folio_alloc);
+
 /*
  * Common helper functions. Never use with __GFP_HIGHMEM because the returned
  * address cannot represent highmem pages. Use alloc_pages and then kmap if
-- 
2.30.2

