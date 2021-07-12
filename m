Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB643C4213
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhGLDnX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbhGLDnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:43:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A11C0613DD;
        Sun, 11 Jul 2021 20:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oQKt01iazgo4xFjXgxVBnZbcIhPdfOavjDavURIYVHk=; b=unyYncVFrWWGWsy+hrpYwM1iQd
        qLzaIq27vJata6ChJD38iYMdQV2poe0jCrybQAt3QQ4tMg+9BQrSBL1IOg5zPuQDQTnJdKKq9d4nC
        QY6utm3LVilHxhtvllM1KmFQdRoX+H2+3gVNA1IHm0Zerdn+60h6JlqzkMgEv4g/W6esWw8o5Vo/D
        Tuq5gNVQcaFAE3mlAeo8XtFv4da/6Q2pJRzfGfglFOGVMyRmLKLTvxUVpgwjgM0Ae/AuKaPlcPoAg
        /9PL9zU5n6M/0RaXkR0+mSKrSh9k8o6cYSWqZezBSpurD9TZ7lTCNpINgi+qOACy2uRWqWVSP4r8N
        dA4FIRvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mnG-00Gp4k-Cq; Mon, 12 Jul 2021 03:39:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 061/137] mm/migrate: Add folio_migrate_flags()
Date:   Mon, 12 Jul 2021 04:05:45 +0100
Message-Id: <20210712030701.4000097-62-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Turn migrate_page_states() into a wrapper around folio_migrate_flags().
Also convert two functions only called from folio_migrate_flags() to
be folio-based.  ksm_migrate_page() becomes folio_migrate_ksm() and
copy_page_owner() becomes folio_copy_owner().  folio_migrate_flags()
alone shrinks by two thirds -- 1967 bytes down to 642 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/ksm.h        |  4 +-
 include/linux/migrate.h    |  1 +
 include/linux/page_owner.h |  8 ++--
 mm/folio-compat.c          |  6 +++
 mm/ksm.c                   | 31 ++++++++------
 mm/migrate.c               | 84 +++++++++++++++++++-------------------
 mm/page_owner.c            | 10 ++---
 7 files changed, 77 insertions(+), 67 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 161e8164abcf..a38a5bca1ba5 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -52,7 +52,7 @@ struct page *ksm_might_need_to_copy(struct page *page,
 			struct vm_area_struct *vma, unsigned long address);
 
 void rmap_walk_ksm(struct page *page, struct rmap_walk_control *rwc);
-void ksm_migrate_page(struct page *newpage, struct page *oldpage);
+void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
 
 #else  /* !CONFIG_KSM */
 
@@ -83,7 +83,7 @@ static inline void rmap_walk_ksm(struct page *page,
 {
 }
 
-static inline void ksm_migrate_page(struct page *newpage, struct page *oldpage)
+static inline void folio_migrate_ksm(struct folio *newfolio, struct folio *old)
 {
 }
 #endif /* CONFIG_MMU */
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 52bf62763205..b9cd88915c6b 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -52,6 +52,7 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, int extra_count);
 extern void copy_huge_page(struct page *dst, struct page *src);
+void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int extra_count);
 #else
diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 719bfe5108c5..43c638c51c1f 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -12,7 +12,7 @@ extern void __reset_page_owner(struct page *page, unsigned int order);
 extern void __set_page_owner(struct page *page,
 			unsigned int order, gfp_t gfp_mask);
 extern void __split_page_owner(struct page *page, unsigned int nr);
-extern void __copy_page_owner(struct page *oldpage, struct page *newpage);
+extern void __folio_copy_owner(struct folio *newfolio, struct folio *old);
 extern void __set_page_owner_migrate_reason(struct page *page, int reason);
 extern void __dump_page_owner(const struct page *page);
 extern void pagetypeinfo_showmixedcount_print(struct seq_file *m,
@@ -36,10 +36,10 @@ static inline void split_page_owner(struct page *page, unsigned int nr)
 	if (static_branch_unlikely(&page_owner_inited))
 		__split_page_owner(page, nr);
 }
-static inline void copy_page_owner(struct page *oldpage, struct page *newpage)
+static inline void folio_copy_owner(struct folio *newfolio, struct folio *old)
 {
 	if (static_branch_unlikely(&page_owner_inited))
-		__copy_page_owner(oldpage, newpage);
+		__folio_copy_owner(newfolio, old);
 }
 static inline void set_page_owner_migrate_reason(struct page *page, int reason)
 {
@@ -63,7 +63,7 @@ static inline void split_page_owner(struct page *page,
 			unsigned int order)
 {
 }
-static inline void copy_page_owner(struct page *oldpage, struct page *newpage)
+static inline void folio_copy_owner(struct folio *newfolio, struct folio *folio)
 {
 }
 static inline void set_page_owner_migrate_reason(struct page *page, int reason)
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index d883d964fd52..3f00ad92d1ff 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -58,4 +58,10 @@ int migrate_page_move_mapping(struct address_space *mapping,
 					page_folio(page), extra_count);
 }
 EXPORT_SYMBOL(migrate_page_move_mapping);
+
+void migrate_page_states(struct page *newpage, struct page *page)
+{
+	folio_migrate_flags(page_folio(newpage), page_folio(page));
+}
+EXPORT_SYMBOL(migrate_page_states);
 #endif
diff --git a/mm/ksm.c b/mm/ksm.c
index 23d36b59f997..82875051872d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -753,7 +753,7 @@ static struct page *get_ksm_page(struct stable_node *stable_node,
 	/*
 	 * We come here from above when page->mapping or !PageSwapCache
 	 * suggests that the node is stale; but it might be under migration.
-	 * We need smp_rmb(), matching the smp_wmb() in ksm_migrate_page(),
+	 * We need smp_rmb(), matching the smp_wmb() in folio_migrate_ksm(),
 	 * before checking whether node->kpfn has been changed.
 	 */
 	smp_rmb();
@@ -854,9 +854,14 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
 	return err;
 }
 
+static inline struct stable_node *folio_stable_node(struct folio *folio)
+{
+	return folio_ksm(folio) ? folio_rmapping(folio) : NULL;
+}
+
 static inline struct stable_node *page_stable_node(struct page *page)
 {
-	return PageKsm(page) ? page_rmapping(page) : NULL;
+	return folio_stable_node(page_folio(page));
 }
 
 static inline void set_page_stable_node(struct page *page,
@@ -2661,26 +2666,26 @@ void rmap_walk_ksm(struct page *page, struct rmap_walk_control *rwc)
 }
 
 #ifdef CONFIG_MIGRATION
-void ksm_migrate_page(struct page *newpage, struct page *oldpage)
+void folio_migrate_ksm(struct folio *newfolio, struct folio *folio)
 {
 	struct stable_node *stable_node;
 
-	VM_BUG_ON_PAGE(!PageLocked(oldpage), oldpage);
-	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
-	VM_BUG_ON_PAGE(newpage->mapping != oldpage->mapping, newpage);
+	VM_BUG_ON_FOLIO(!folio_locked(folio), folio);
+	VM_BUG_ON_FOLIO(!folio_locked(newfolio), newfolio);
+	VM_BUG_ON_FOLIO(newfolio->mapping != folio->mapping, newfolio);
 
-	stable_node = page_stable_node(newpage);
+	stable_node = folio_stable_node(folio);
 	if (stable_node) {
-		VM_BUG_ON_PAGE(stable_node->kpfn != page_to_pfn(oldpage), oldpage);
-		stable_node->kpfn = page_to_pfn(newpage);
+		VM_BUG_ON_FOLIO(stable_node->kpfn != folio_pfn(folio), folio);
+		stable_node->kpfn = folio_pfn(newfolio);
 		/*
-		 * newpage->mapping was set in advance; now we need smp_wmb()
+		 * newfolio->mapping was set in advance; now we need smp_wmb()
 		 * to make sure that the new stable_node->kpfn is visible
-		 * to get_ksm_page() before it can see that oldpage->mapping
-		 * has gone stale (or that PageSwapCache has been cleared).
+		 * to get_ksm_page() before it can see that folio->mapping
+		 * has gone stale (or that folio_swapcache has been cleared).
 		 */
 		smp_wmb();
-		set_page_stable_node(oldpage, NULL);
+		set_page_stable_node(&folio->page, NULL);
 	}
 }
 #endif /* CONFIG_MIGRATION */
diff --git a/mm/migrate.c b/mm/migrate.c
index 19dd053b4a52..c16923052e13 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -586,82 +586,80 @@ void copy_huge_page(struct page *dst, struct page *src)
 }
 
 /*
- * Copy the page to its new location
+ * Copy the flags and some other ancillary information
  */
-void migrate_page_states(struct page *newpage, struct page *page)
+void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-	struct folio *newfolio = page_folio(newpage);
 	int cpupid;
 
-	if (PageError(page))
-		SetPageError(newpage);
-	if (PageReferenced(page))
-		SetPageReferenced(newpage);
-	if (PageUptodate(page))
-		SetPageUptodate(newpage);
-	if (TestClearPageActive(page)) {
-		VM_BUG_ON_PAGE(PageUnevictable(page), page);
-		SetPageActive(newpage);
-	} else if (TestClearPageUnevictable(page))
-		SetPageUnevictable(newpage);
-	if (PageWorkingset(page))
-		SetPageWorkingset(newpage);
-	if (PageChecked(page))
-		SetPageChecked(newpage);
-	if (PageMappedToDisk(page))
-		SetPageMappedToDisk(newpage);
+	if (folio_error(folio))
+		folio_set_error_flag(newfolio);
+	if (folio_referenced(folio))
+		folio_set_referenced_flag(newfolio);
+	if (folio_uptodate(folio))
+		folio_mark_uptodate(newfolio);
+	if (folio_test_clear_active_flag(folio)) {
+		VM_BUG_ON_FOLIO(folio_unevictable(folio), folio);
+		folio_set_active_flag(newfolio);
+	} else if (folio_test_clear_unevictable_flag(folio))
+		folio_set_unevictable_flag(newfolio);
+	if (folio_workingset(folio))
+		folio_set_workingset_flag(newfolio);
+	if (folio_checked(folio))
+		folio_set_checked_flag(newfolio);
+	if (folio_mappedtodisk(folio))
+		folio_set_mappedtodisk_flag(newfolio);
 
 	/* Move dirty on pages not done by folio_migrate_mapping() */
-	if (PageDirty(page))
-		SetPageDirty(newpage);
+	if (folio_dirty(folio))
+		folio_set_dirty_flag(newfolio);
 
-	if (page_is_young(page))
-		set_page_young(newpage);
-	if (page_is_idle(page))
-		set_page_idle(newpage);
+	if (folio_young(folio))
+		folio_set_young_flag(newfolio);
+	if (folio_idle(folio))
+		folio_set_idle_flag(newfolio);
 
 	/*
 	 * Copy NUMA information to the new page, to prevent over-eager
 	 * future migrations of this same page.
 	 */
-	cpupid = page_cpupid_xchg_last(page, -1);
-	page_cpupid_xchg_last(newpage, cpupid);
+	cpupid = page_cpupid_xchg_last(&folio->page, -1);
+	page_cpupid_xchg_last(&newfolio->page, cpupid);
 
-	ksm_migrate_page(newpage, page);
+	folio_migrate_ksm(newfolio, folio);
 	/*
 	 * Please do not reorder this without considering how mm/ksm.c's
 	 * get_ksm_page() depends upon ksm_migrate_page() and PageSwapCache().
 	 */
-	if (PageSwapCache(page))
-		ClearPageSwapCache(page);
-	ClearPagePrivate(page);
+	if (folio_swapcache(folio))
+		folio_clear_swapcache_flag(folio);
+	folio_clear_private_flag(folio);
 
 	/* page->private contains hugetlb specific flags */
-	if (!PageHuge(page))
-		set_page_private(page, 0);
+	if (!folio_hugetlb(folio))
+		folio->private = NULL;
 
 	/*
 	 * If any waiters have accumulated on the new page then
 	 * wake them up.
 	 */
-	if (PageWriteback(newpage))
-		end_page_writeback(newpage);
+	if (folio_writeback(newfolio))
+		folio_end_writeback(newfolio);
 
 	/*
 	 * PG_readahead shares the same bit with PG_reclaim.  The above
 	 * end_page_writeback() may clear PG_readahead mistakenly, so set the
 	 * bit after that.
 	 */
-	if (PageReadahead(page))
-		SetPageReadahead(newpage);
+	if (folio_readahead(folio))
+		folio_set_readahead_flag(newfolio);
 
-	copy_page_owner(page, newpage);
+	folio_copy_owner(folio, newfolio);
 
-	if (!PageHuge(page))
+	if (!folio_hugetlb(folio))
 		mem_cgroup_migrate(folio, newfolio);
 }
-EXPORT_SYMBOL(migrate_page_states);
+EXPORT_SYMBOL(folio_migrate_flags);
 
 void migrate_page_copy(struct page *newpage, struct page *page)
 {
@@ -702,7 +700,7 @@ int migrate_page(struct address_space *mapping,
 	if (mode != MIGRATE_SYNC_NO_COPY)
 		migrate_page_copy(newpage, page);
 	else
-		migrate_page_states(newpage, page);
+		folio_migrate_flags(newfolio, folio);
 	return MIGRATEPAGE_SUCCESS;
 }
 EXPORT_SYMBOL(migrate_page);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index f51a57e92aa3..23bfb074ca3f 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -210,10 +210,10 @@ void __split_page_owner(struct page *page, unsigned int nr)
 	}
 }
 
-void __copy_page_owner(struct page *oldpage, struct page *newpage)
+void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 {
-	struct page_ext *old_ext = lookup_page_ext(oldpage);
-	struct page_ext *new_ext = lookup_page_ext(newpage);
+	struct page_ext *old_ext = lookup_page_ext(&old->page);
+	struct page_ext *new_ext = lookup_page_ext(&newfolio->page);
 	struct page_owner *old_page_owner, *new_page_owner;
 
 	if (unlikely(!old_ext || !new_ext))
@@ -231,11 +231,11 @@ void __copy_page_owner(struct page *oldpage, struct page *newpage)
 	new_page_owner->free_ts_nsec = old_page_owner->ts_nsec;
 
 	/*
-	 * We don't clear the bit on the oldpage as it's going to be freed
+	 * We don't clear the bit on the old folio as it's going to be freed
 	 * after migration. Until then, the info can be useful in case of
 	 * a bug, and the overall stats will be off a bit only temporarily.
 	 * Also, migrate_misplaced_transhuge_page() can still fail the
-	 * migration and then we want the oldpage to retain the info. But
+	 * migration and then we want the old folio to retain the info. But
 	 * in that case we also don't need to explicitly clear the info from
 	 * the new page, which will be freed.
 	 */
-- 
2.30.2

