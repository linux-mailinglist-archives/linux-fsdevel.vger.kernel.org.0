Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4C7332392
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 12:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCILDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 06:03:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:46034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhCILDK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:03:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615287789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SwNPfiPRmFVwhreQmgJwMSgtgCsgF30o2ShSACX6TzU=;
        b=I8BHarof5e9crSCr1YsVqjn6jSug3BluUnmccgHqooFH+pYfKgwhkoGik0jupbqX5sy93E
        TMUzc4SRJJHik1wxAsl7shsq7lAe9xxlbf55fRxU7PWlJO0wcFOnMoBYkBR3L51FXqJCW4
        tnRQvvkIfDYTXRVwIZKQCE4BR83io7s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52761AC8C;
        Tue,  9 Mar 2021 11:03:09 +0000 (UTC)
Date:   Tue, 9 Mar 2021 12:03:08 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, cgoldswo@codeaurora.org, willy@infradead.org,
        david@redhat.com, vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YEdV7Leo7MC93PlK@dhcp22.suse.cz>
References: <20210309051628.3105973-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309051628.3105973-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 08-03-21 21:16:27, Minchan Kim wrote:
> LRU pagevec holds refcount of pages until the pagevec are drained.
> It could prevent migration since the refcount of the page is greater
> than the expection in migration logic. To mitigate the issue,
> callers of migrate_pages drains LRU pagevec via migrate_prep or
> lru_add_drain_all before migrate_pages call.
> 
> However, it's not enough because pages coming into pagevec after the
> draining call still could stay at the pagevec so it could keep
> preventing page migration. Since some callers of migrate_pages have
> retrial logic with LRU draining, the page would migrate at next trail
> but it is still fragile in that it doesn't close the fundamental race
> between upcoming LRU pages into pagvec and migration so the migration
> failure could cause contiguous memory allocation failure in the end.
> 
> To close the race, this patch disables lru caches(i.e, pagevec)
> during ongoing migration until migrate is done.
> 
> Since it's really hard to reproduce, I measured how many times
> migrate_pages retried with force mode below debug code.

It would be better to explicitly state that this is about a fallback to
a sync migration.

 
> int migrate_pages(struct list_head *from, new_page_t get_new_page,
> 			..
> 			..
> 
> if (rc && reason == MR_CONTIG_RANGE && pass > 2) {
>        printk(KERN_ERR, "pfn 0x%lx reason %d\n", page_to_pfn(page), rc);
>        dump_page(page, "fail to migrate");
> }
> 
> The test was repeating android apps launching with cma allocation
> in background every five seconds. Total cma allocation count was
> about 500 during the testing. With this patch, the dump_page count
> was reduced from 400 to 30.

I still find these results hard to argue about because it has really no
relation to any measurable effect for those apps you are mentioning. I
would expect sync migration would lead to performance difference. Is
there any?

> It would be also useful for memory-hotplug.

This is a statment that would deserve some explanation.
"
The new interface is alsow useful for memory hotplug which currently
drains lru pcp caches after each migration failure. This is rather
suboptimal as it has to disrupt others running during the operation.
With the new interface the operation happens only once. This is also in
line with pcp allocator cache which are disabled for the offlining as
well.
"
 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> * from v1 - https://lore.kernel.org/lkml/20210302210949.2440120-1-minchan@kernel.org/
>   * introduce __lru_add_drain_all to minimize changes - mhocko
>   * use lru_cache_disable for memory-hotplug
>   * schedule for every cpu at force_all_cpus
> 
> * from RFC - http://lore.kernel.org/linux-mm/20210216170348.1513483-1-minchan@kernel.org
>   * use atomic and lru_add_drain_all for strict ordering - mhocko
>   * lru_cache_disable/enable - mhocko
> 
>  include/linux/migrate.h |  6 ++-
>  include/linux/swap.h    |  2 +
>  mm/memory_hotplug.c     |  3 +-
>  mm/mempolicy.c          |  6 +++
>  mm/migrate.c            | 13 ++++---
>  mm/page_alloc.c         |  3 ++
>  mm/swap.c               | 82 +++++++++++++++++++++++++++++++++--------
>  7 files changed, 91 insertions(+), 24 deletions(-)

Sorry for nit picking but I think the additional abstraction for
migrate_prep is not really needed and we can remove some more code.
Maybe we should even get rid of migrate_prep_local which only has a
single caller and open coding lru draining with a comment would be
better from code reading POV IMO.

 include/linux/migrate.h |  4 +--
 include/linux/swap.h    |  2 ++
 mm/memory_hotplug.c     |  3 +-
 mm/mempolicy.c          | 10 ++++--
 mm/migrate.c            | 19 ++----------
 mm/page_alloc.c         |  5 ++-
 mm/swap.c               | 82 +++++++++++++++++++++++++++++++++++++++----------
 7 files changed, 85 insertions(+), 40 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 4594838a0f7c..dbd6311f23be 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -45,7 +45,6 @@ extern struct page *alloc_migration_target(struct page *page, unsigned long priv
 extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
 
-extern void migrate_prep(void);
 extern void migrate_prep_local(void);
 extern void migrate_page_states(struct page *newpage, struct page *page);
 extern void migrate_page_copy(struct page *newpage, struct page *page);
@@ -66,8 +65,7 @@ static inline struct page *alloc_migration_target(struct page *page,
 static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	{ return -EBUSY; }
 
-static inline int migrate_prep(void) { return -ENOSYS; }
-static inline int migrate_prep_local(void) { return -ENOSYS; }
+static inline void migrate_prep_local(void) { return -ENOSYS; }
 
 static inline void migrate_page_states(struct page *newpage, struct page *page)
 {
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 596bc2f4d9b0..c11d92582378 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -339,6 +339,8 @@ extern void lru_note_cost(struct lruvec *lruvec, bool file,
 extern void lru_note_cost_page(struct page *);
 extern void lru_cache_add(struct page *);
 extern void mark_page_accessed(struct page *);
+extern void lru_cache_disable(void);
+extern void lru_cache_enable(void);
 extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f9d57b9be8c7..d86868dd2d78 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1496,6 +1496,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	 * in a way that pages from isolated pageblock are left on pcplists.
 	 */
 	zone_pcp_disable(zone);
+	lru_cache_disable();
 
 	/* set above range as isolated */
 	ret = start_isolate_page_range(start_pfn, end_pfn,
@@ -1527,7 +1528,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 			}
 
 			cond_resched();
-			lru_add_drain_all();
 
 			ret = scan_movable_pages(pfn, end_pfn, &pfn);
 			if (!ret) {
@@ -1572,6 +1572,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
 	spin_unlock_irqrestore(&zone->lock, flags);
 
+	lru_cache_enable();
 	zone_pcp_enable(zone);
 
 	/* removal success */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2c3a86502053..c9f45a5e2714 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1114,7 +1114,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 	int err = 0;
 	nodemask_t tmp;
 
-	migrate_prep();
+	lru_cache_disable();
 
 	mmap_read_lock(mm);
 
@@ -1198,6 +1198,8 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 			break;
 	}
 	mmap_read_unlock(mm);
+	lru_cache_enable();
+
 	if (err < 0)
 		return err;
 	return busy;
@@ -1313,7 +1315,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
 
-		migrate_prep();
+		lru_cache_disable();
 	}
 	{
 		NODEMASK_SCRATCH(scratch);
@@ -1361,6 +1363,10 @@ static long do_mbind(unsigned long start, unsigned long len,
 	mmap_write_unlock(mm);
 mpol_out:
 	mpol_put(new);
+
+	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+		lru_cache_enable();
+
 	return err;
 }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 20ca887ea769..ec50966e9a80 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -57,22 +57,6 @@
 
 #include "internal.h"
 
-/*
- * migrate_prep() needs to be called before we start compiling a list of pages
- * to be migrated using isolate_lru_page(). If scheduling work on other CPUs is
- * undesirable, use migrate_prep_local()
- */
-void migrate_prep(void)
-{
-	/*
-	 * Clear the LRU lists so pages can be isolated.
-	 * Note that pages may be moved off the LRU after we have
-	 * drained them. Those pages will fail to migrate like other
-	 * pages that may be busy.
-	 */
-	lru_add_drain_all();
-}
-
 /* Do the necessary work of migrate_prep but not if it involves other CPUs */
 void migrate_prep_local(void)
 {
@@ -1763,7 +1747,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	int start, i;
 	int err = 0, err1;
 
-	migrate_prep();
+	lru_cache_disable();
 
 	for (i = start = 0; i < nr_pages; i++) {
 		const void __user *p;
@@ -1832,6 +1816,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	if (err >= 0)
 		err = err1;
 out:
+	lru_cache_enable();
 	return err;
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 519a60d5b6f7..692d298aff31 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8482,7 +8482,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
 	};
 
-	migrate_prep();
+	lru_cache_disable();
 
 	while (pfn < end || !list_empty(&cc->migratepages)) {
 		if (fatal_signal_pending(current)) {
@@ -8510,6 +8510,9 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
 				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
 	}
+
+	lru_cache_enable();
+
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
 		return ret;
diff --git a/mm/swap.c b/mm/swap.c
index 2cca7141470c..eb4aafd1685d 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -236,6 +236,18 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
 	}
 }
 
+/* return true if pagevec needs to drain */
+static bool pagevec_add_and_need_flush(struct pagevec *pvec, struct page *page)
+{
+	bool ret = false;
+
+	if (!pagevec_add(pvec, page) || PageCompound(page) ||
+			lru_cache_disabled())
+		ret = true;
+
+	return ret;
+}
+
 /*
  * Writeback is about to end against a page which has been marked for immediate
  * reclaim.  If it still appears to be reclaimable, move it to the tail of the
@@ -253,7 +265,7 @@ void rotate_reclaimable_page(struct page *page)
 		get_page(page);
 		local_lock_irqsave(&lru_rotate.lock, flags);
 		pvec = this_cpu_ptr(&lru_rotate.pvec);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, pagevec_move_tail_fn);
 		local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
@@ -346,7 +358,7 @@ static void activate_page(struct page *page)
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.activate_page);
 		get_page(page);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, __activate_page);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -461,7 +473,7 @@ void lru_cache_add(struct page *page)
 	get_page(page);
 	local_lock(&lru_pvecs.lock);
 	pvec = this_cpu_ptr(&lru_pvecs.lru_add);
-	if (!pagevec_add(pvec, page) || PageCompound(page))
+	if (pagevec_add_and_need_flush(pvec, page))
 		__pagevec_lru_add(pvec);
 	local_unlock(&lru_pvecs.lock);
 }
@@ -664,7 +676,7 @@ void deactivate_file_page(struct page *page)
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
 
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -686,7 +698,7 @@ void deactivate_page(struct page *page)
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate);
 		get_page(page);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_fn);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -708,7 +720,7 @@ void mark_page_lazyfree(struct page *page)
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_lazyfree);
 		get_page(page);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -738,14 +750,7 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
 	lru_add_drain();
 }
 
-/*
- * Doesn't need any cpu hotplug locking because we do rely on per-cpu
- * kworkers being shut down before our page_alloc_cpu_dead callback is
- * executed on the offlined cpu.
- * Calling this function with cpu hotplug locks held can actually lead
- * to obscure indirect dependencies via WQ context.
- */
-void lru_add_drain_all(void)
+void __lru_add_drain_all(bool force_all_cpus)
 {
 	/*
 	 * lru_drain_gen - Global pages generation number
@@ -790,7 +795,7 @@ void lru_add_drain_all(void)
 	 * (C) Exit the draining operation if a newer generation, from another
 	 * lru_add_drain_all(), was already scheduled for draining. Check (A).
 	 */
-	if (unlikely(this_gen != lru_drain_gen))
+	if (unlikely(this_gen != lru_drain_gen && !force_all_cpus))
 		goto done;
 
 	/*
@@ -820,7 +825,8 @@ void lru_add_drain_all(void)
 	for_each_online_cpu(cpu) {
 		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
 
-		if (pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
+		if (force_all_cpus ||
+		    pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
 		    data_race(pagevec_count(&per_cpu(lru_rotate.pvec, cpu))) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
@@ -838,6 +844,18 @@ void lru_add_drain_all(void)
 done:
 	mutex_unlock(&lock);
 }
+
+/*
+ * Doesn't need any cpu hotplug locking because we do rely on per-cpu
+ * kworkers being shut down before our page_alloc_cpu_dead callback is
+ * executed on the offlined cpu.
+ * Calling this function with cpu hotplug locks held can actually lead
+ * to obscure indirect dependencies via WQ context.
+ */
+void lru_add_drain_all(void)
+{
+	__lru_add_drain_all(false);
+}
 #else
 void lru_add_drain_all(void)
 {
@@ -845,6 +863,38 @@ void lru_add_drain_all(void)
 }
 #endif /* CONFIG_SMP */
 
+static atomic_t lru_disable_count = ATOMIC_INIT(0);
+
+bool lru_cache_disabled(void)
+{
+	return atomic_read(&lru_disable_count);
+}
+
+void lru_cache_enable(void)
+{
+	atomic_dec(&lru_disable_count);
+}
+/*
+ * Clear the LRU lists so pages can be isolated.
+ */
+void lru_cache_disable(void)
+{
+	atomic_inc(&lru_disable_count);
+#ifdef CONFIG_SMP
+	/*
+	 * lru_add_drain_all in the force mode will schedule draining on
+	 * all online CPUs so any calls of lru_cache_disabled wrapped by
+	 * local_lock or preemption disabled would be ordered by that.
+	 * The atomic operation doesn't need to have stronger ordering
+	 * requirements because that is enforeced by the scheduling
+	 * guarantees.
+	 */
+	__lru_add_drain_all(true);
+#else
+	lru_add_drain();
+#endif
+}
+
 /**
  * release_pages - batched put_page()
  * @pages: array of pages to release
-- 
Michal Hocko
SUSE Labs
