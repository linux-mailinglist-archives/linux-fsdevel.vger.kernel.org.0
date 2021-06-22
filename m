Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0BD3B0460
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhFVMbh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhFVMbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:31:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A52C061574;
        Tue, 22 Jun 2021 05:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ohr/infenvmlxFInMlKS/wkEJkJhjkFXyh5V5TExMDE=; b=GGllrnqYjjkiFygErb3cZkNNOz
        9uXz2iAKcWCf0j7EQimMEnypRpdgPn7f7HlPUjt8AOOIsx/4Fat5WTh9VVycr010w/3WvI1pk+lHq
        ARld6aMQAlA9LsfiLcYbNhdLSItOp/TTz/RESF7af7EAp4dU7TKv6GjbGfdDbq1LlTyoHv22M9v3I
        WukDmgQmuySyrilw05QcIJAc/+oK51QTPWcEFkaQhyCBewrDcIKxPxqfWYIX83spoo0pxU5ol9qtg
        qP7Go7nPHpYhJAQuxPgjNYogfBcqfcIk+gXLGSEyaicl341VNYWti8UspQD6lTFaGsPsQ5ettYiXI
        wrKcObWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfVb-00EH56-Kc; Tue, 22 Jun 2021 12:28:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/46] mm/memcg: Add folio_migrate_cgroup()
Date:   Tue, 22 Jun 2021 13:15:21 +0100
Message-Id: <20210622121551.3398730-17-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert all callers of mem_cgroup_migrate() to call folio_migrate_cgroup()
instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 .../admin-guide/cgroup-v1/memcg_test.rst      |  2 +-
 include/linux/memcontrol.h                    |  5 ++-
 mm/filemap.c                                  |  4 ++-
 mm/memcontrol.c                               | 31 +++++++++----------
 mm/migrate.c                                  |  4 ++-
 mm/shmem.c                                    |  5 ++-
 6 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memcg_test.rst b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
index 45b94f7b3beb..686beda647d0 100644
--- a/Documentation/admin-guide/cgroup-v1/memcg_test.rst
+++ b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
@@ -129,7 +129,7 @@ Under below explanation, we assume CONFIG_MEM_RES_CTRL_SWAP=y.
 7. Page Migration
 =================
 
-	mem_cgroup_migrate()
+	folio_migrate_cgroup()
 
 8. LRU
 ======
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d4b2bc939eee..8158c16f8097 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -706,6 +706,7 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 
 int folio_charge_cgroup(struct folio *, struct mm_struct *, gfp_t);
 void folio_uncharge_cgroup(struct folio *);
+void folio_migrate_cgroup(struct folio *old, struct folio *new);
 
 int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
 int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
@@ -715,8 +716,6 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
 void mem_cgroup_uncharge(struct page *page);
 void mem_cgroup_uncharge_list(struct list_head *page_list);
 
-void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
-
 /**
  * mem_cgroup_lruvec - get the lru list vector for a memcg & node
  * @memcg: memcg of the wanted lruvec
@@ -1253,7 +1252,7 @@ static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
 {
 }
 
-static inline void mem_cgroup_migrate(struct page *old, struct page *new)
+static inline void folio_migrate_cgroup(struct page *old, struct page *new)
 {
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 7b0e4d0e4741..4b2698e5e8e2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -817,6 +817,8 @@ EXPORT_SYMBOL(file_write_and_wait_range);
  */
 void replace_page_cache_page(struct page *old, struct page *new)
 {
+	struct folio *fold = page_folio(old);
+	struct folio *fnew = page_folio(new);
 	struct address_space *mapping = old->mapping;
 	void (*freepage)(struct page *) = mapping->a_ops->freepage;
 	pgoff_t offset = old->index;
@@ -831,7 +833,7 @@ void replace_page_cache_page(struct page *old, struct page *new)
 	new->mapping = mapping;
 	new->index = offset;
 
-	mem_cgroup_migrate(old, new);
+	folio_migrate_cgroup(fold, fnew);
 
 	xas_lock_irqsave(&xas, flags);
 	xas_store(&xas, new);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a6befc0843e7..a9857e091455 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5410,7 +5410,7 @@ static int mem_cgroup_move_account(struct page *page,
 	VM_BUG_ON(compound && !PageTransHuge(page));
 
 	/*
-	 * Prevent mem_cgroup_migrate() from looking at
+	 * Prevent folio_migrate_cgroup() from looking at
 	 * page's memory cgroup of its source page while we change it.
 	 */
 	ret = -EBUSY;
@@ -6761,40 +6761,39 @@ void mem_cgroup_uncharge_list(struct list_head *page_list)
 }
 
 /**
- * mem_cgroup_migrate - charge a page's replacement
- * @oldpage: currently circulating page
- * @newpage: replacement page
+ * folio_migrate_cgroup - charge a folio's replacement
+ * @oldfolio: currently circulating folio
+ * @newfolio: replacement folio
  *
- * Charge @newpage as a replacement page for @oldpage. @oldpage will
+ * Charge @newfolio as a replacement folio for @oldfolio. @oldfolio will
  * be uncharged upon free.
  *
- * Both pages must be locked, @newpage->mapping must be set up.
+ * Both folios must be locked, @newfolio->mapping must be set up.
  */
-void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
+void folio_migrate_cgroup(struct folio *old, struct folio *newfolio)
 {
-	struct folio *newfolio = page_folio(newpage);
 	struct mem_cgroup *memcg;
 	unsigned int nr_pages = folio_nr_pages(newfolio);
 	unsigned long flags;
 
-	VM_BUG_ON_PAGE(!PageLocked(oldpage), oldpage);
+	VM_BUG_ON_FOLIO(!folio_locked(old), old);
 	VM_BUG_ON_FOLIO(!folio_locked(newfolio), newfolio);
-	VM_BUG_ON_FOLIO(PageAnon(oldpage) != folio_anon(newfolio), newfolio);
-	VM_BUG_ON_FOLIO(compound_nr(oldpage) != nr_pages, newfolio);
+	VM_BUG_ON_FOLIO(folio_anon(old) != folio_anon(newfolio), newfolio);
+	VM_BUG_ON_FOLIO(folio_nr_pages(old) != nr_pages, newfolio);
 
 	if (mem_cgroup_disabled())
 		return;
 
-	/* Page cache replacement: new page already charged? */
+	/* Page cache replacement: new folio already charged? */
 	if (folio_memcg(newfolio))
 		return;
 
-	memcg = page_memcg(oldpage);
-	VM_WARN_ON_ONCE_PAGE(!memcg, oldpage);
+	memcg = folio_memcg(old);
+	VM_WARN_ON_ONCE_FOLIO(!memcg, old);
 	if (!memcg)
 		return;
 
-	/* Force-charge the new page. The old one will be freed soon */
+	/* Force-charge the new folio. The old one will be freed soon */
 	page_counter_charge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
 		page_counter_charge(&memcg->memsw, nr_pages);
@@ -6804,7 +6803,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 
 	local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, nr_pages);
-	memcg_check_events(memcg, newpage);
+	memcg_check_events(memcg, &newfolio->page);
 	local_irq_restore(flags);
 }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index b234c3f3acb7..fff63e139767 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -581,6 +581,8 @@ static void copy_huge_page(struct page *dst, struct page *src)
  */
 void migrate_page_states(struct page *newpage, struct page *page)
 {
+	struct folio *folio = page_folio(page);
+	struct folio *newfolio = page_folio(newpage);
 	int cpupid;
 
 	if (PageError(page))
@@ -645,7 +647,7 @@ void migrate_page_states(struct page *newpage, struct page *page)
 	copy_page_owner(page, newpage);
 
 	if (!PageHuge(page))
-		mem_cgroup_migrate(page, newpage);
+		folio_migrate_cgroup(folio, newfolio);
 }
 EXPORT_SYMBOL(migrate_page_states);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 5d46611cba8d..efc77a7e19bd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1619,6 +1619,7 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
 				struct shmem_inode_info *info, pgoff_t index)
 {
 	struct page *oldpage, *newpage;
+	struct folio *old, *new;
 	struct address_space *swap_mapping;
 	swp_entry_t entry;
 	pgoff_t swap_index;
@@ -1655,7 +1656,9 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
 	xa_lock_irq(&swap_mapping->i_pages);
 	error = shmem_replace_entry(swap_mapping, swap_index, oldpage, newpage);
 	if (!error) {
-		mem_cgroup_migrate(oldpage, newpage);
+		old = page_folio(oldpage);
+		new = page_folio(newpage);
+		folio_migrate_cgroup(old, new);
 		__inc_lruvec_page_state(newpage, NR_FILE_PAGES);
 		__dec_lruvec_page_state(oldpage, NR_FILE_PAGES);
 	}
-- 
2.30.2

