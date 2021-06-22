Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4803B0458
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhFVMaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhFVMaU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:30:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8F0C061574;
        Tue, 22 Jun 2021 05:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nFD2Y1hDSjB701coKKMQ+TJGR6t40bE1X+2F4ufKGTs=; b=brwlYO9g4/6ZcIV+6Nay9flzFz
        40YfwDyhIowXWW7ZJUNX3YxbJxVQSTp7QQDMrWpDKalUMMcL9VtegOvNEyNdEr7Rq9ZPpnTFGWIY9
        HX7G3t/weijW1QwMTgz77S0sot7Xb0MgCIbre3YAnXtA/WxgoDi50vXoBltaOa9zBuXf2+PwUJm/4
        fV5IQn0/S8ReTcK2Yd4DVyLGAOcPj/nKBZovVaFH8PjuW3RoV7mg+nXptVz/QkRd3wRLEq85CTiEV
        imOCpJkHPiW8/Oofmblu2XjJwhKCs1aaWe3rhVH6cEZShPmfdtoL/mMbqhTVUspJ6Ii/lqUp6GEDW
        blOP0mrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfUO-00EGxZ-MY; Tue, 22 Jun 2021 12:26:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/46] mm/memcg: Add folio_charge_cgroup()
Date:   Tue, 22 Jun 2021 13:15:19 +0100
Message-Id: <20210622121551.3398730-15-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
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
index 4460ff0e70a1..a50e5cee6d2c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -704,6 +704,8 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 		page_counter_read(&memcg->memory);
 }
 
+int folio_charge_cgroup(struct folio *, struct mm_struct *, gfp_t);
+
 int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
 int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
@@ -1216,6 +1218,12 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
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
index 7939e4e9118d..69638f84d11b 100644
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

