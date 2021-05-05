Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C237373F44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhEEQLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbhEEQLd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:11:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4894BC061574;
        Wed,  5 May 2021 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=w0jGJsqw+Dj9n7t2IRtboGIu3/KBHxXl9/wQ2RoFEh8=; b=s4frGTRm8MaIvJDgcr9bJC6lmw
        Rtmt00zViXHhn6h9pog7qIMSLVtHcrVyuaOPCAz0MmugC+IDW4I9RfG8nsIGmUz2oc6YKY62MkyZ+
        GNEgRkDIE8yjVpB7JMBkzVwMyCKWOtAfKXfQIbsOH9RNozpU6rPzOPPSrMRQlUyxMB0YPStUBdXLw
        jw93iJPhE2EQ/D6rQCsOOlE/iu9C4wx6v+NbtTVp4Ox8y4NDeK8vxka8lMeuMTQsqpXbGnW+rM4N1
        HoV99og4TD8I0S9qEzDkRa6qBJ+iCRRCDtDFS083AIXOrqsQTjhEBH8rnVr7K0QasHG+bmE30QBvE
        HJHWyKeg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leK50-000ZDX-9Q; Wed, 05 May 2021 16:09:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 51/96] mm/memcg: Add folio_charge_cgroup
Date:   Wed,  5 May 2021 16:05:43 +0100
Message-Id: <20210505150628.111735-52-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mem_cgroup_charge() already assumed it was being passed a non-tail
page (and looking at the callers, that's true; it's called for freshly
allocated pages).  The only real change here is that folio_nr_pages()
doesn't compile away like thp_nr_pages() does as folio support
is not conditional on transparent hugepage support.  Reimplement
mem_cgroup_charge() as a wrapper around folio_charge_cgroup().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h |  8 ++++++++
 mm/folio-compat.c          |  7 +++++++
 mm/memcontrol.c            | 26 +++++++++++++-------------
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b45b505be0ec..d0798d54f637 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -699,6 +699,8 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 		page_counter_read(&memcg->memory);
 }
 
+int folio_charge_cgroup(struct folio *, struct mm_struct *, gfp_t);
+
 int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
 int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
@@ -1201,6 +1203,12 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 	return false;
 }
 
+static inline int folio_charge_cgroup(struct folio *folio,
+		struct mm_struct *mm, gfp_t gfp)
+{
+	return 0;
+}
+
 static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
 				    gfp_t gfp_mask)
 {
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index a374747ae1c6..1d71b8b587f8 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -48,3 +48,10 @@ void mark_page_accessed(struct page *page)
 	folio_mark_accessed(page_folio(page));
 }
 EXPORT_SYMBOL(mark_page_accessed);
+
+#ifdef CONFIG_MEMCG
+int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp)
+{
+	return folio_charge_cgroup(page_folio(page), mm, gfp);
+}
+#endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5493e094e9e9..529b10e72d5a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6503,10 +6503,9 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 			atomic_long_read(&parent->memory.children_low_usage)));
 }
 
-static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
+static int __mem_cgroup_charge(struct folio *folio, struct mem_cgroup *memcg,
 			       gfp_t gfp)
 {
-	struct folio *folio = page_folio(page);
 	unsigned int nr_pages = folio_nr_pages(folio);
 	int ret;
 
@@ -6519,26 +6518,26 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, nr_pages);
-	memcg_check_events(memcg, page);
+	memcg_check_events(memcg, &folio->page);
 	local_irq_enable();
 out:
 	return ret;
 }
 
 /**
- * mem_cgroup_charge - charge a newly allocated page to a cgroup
- * @page: page to charge
- * @mm: mm context of the victim
- * @gfp_mask: reclaim mode
+ * folio_charge_cgroup - Charge a newly allocated folio to a cgroup.
+ * @folio: Folio to charge.
+ * @mm: mm context of the allocating task.
+ * @gfp: reclaim mode
  *
- * Try to charge @page to the memcg that @mm belongs to, reclaiming
- * pages according to @gfp_mask if necessary.
+ * Try to charge @folio to the memcg that @mm belongs to, reclaiming
+ * pages according to @gfp if necessary.
  *
- * Do not use this for pages allocated for swapin.
+ * Do not use this for folios allocated for swapin.
  *
  * Returns 0 on success. Otherwise, an error code is returned.
  */
-int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
+int folio_charge_cgroup(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
 {
 	struct mem_cgroup *memcg;
 	int ret;
@@ -6547,7 +6546,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 		return 0;
 
 	memcg = get_mem_cgroup_from_mm(mm);
-	ret = __mem_cgroup_charge(page, memcg, gfp_mask);
+	ret = __mem_cgroup_charge(folio, memcg, gfp);
 	css_put(&memcg->css);
 
 	return ret;
@@ -6568,6 +6567,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry)
 {
+	struct folio *folio = page_folio(page);
 	struct mem_cgroup *memcg;
 	unsigned short id;
 	int ret;
@@ -6582,7 +6582,7 @@ int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
 		memcg = get_mem_cgroup_from_mm(mm);
 	rcu_read_unlock();
 
-	ret = __mem_cgroup_charge(page, memcg, gfp);
+	ret = __mem_cgroup_charge(folio, memcg, gfp);
 
 	css_put(&memcg->css);
 	return ret;
-- 
2.30.2

