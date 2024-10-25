Return-Path: <linux-fsdevel+bounces-32839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E70629AF6CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 03:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DB31F2247E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 01:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D64169AC5;
	Fri, 25 Oct 2024 01:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X6lVpR+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4A815ADA4;
	Fri, 25 Oct 2024 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819436; cv=none; b=tMXyO4DQ81+wxoyHwa2rEfSli+lX4yikOkkL4GVxlmnk+DYX85zA80I0LRzSj/TbzWH/Fb9nIr0fkcOGLL8qDAgDTR15SZRTiwtzod8PG5FsBTKR72Bxhu3IWVeqn/GV5uZ00G2hO5MdLgIdu+fOv1Mg/TBJ/rn3eCVoOIwKq0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819436; c=relaxed/simple;
	bh=JxFRtVDkVwNX/nKJf6rxYe1v7biKRdps+Stcu5DCQeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lydGVne2grPbYj0VyNsVofMZcRhk9U8ZVtxd0Z9h3Ua5nyMEIZk0DcLEgp7iYidobUL8pzfBWWZ6ePwChUIbAQ9iRGYz+i62wsEKHreD8hHvs88Sr6lOdAMw7D3LTTJiThrYIPZrzj4Wsyjgtd8jAMoCVTm5i4fYyRlQk85aK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X6lVpR+0; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729819430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jjur1v507XZcfB3R788/dravrRJmQ/huQN6yJVE4iP0=;
	b=X6lVpR+0svYZYTmREgda8K+Q5nDVFHBd55BgjpgPqXRl9N7A5sh3YIpfTn9mCmYM2o510J
	yMX0rj60TGESXeu9lgs72F8G4E2XTpHzj0ONdnTrRtQDJ0zcSYGbRGXJbVWV3+l9bO9g21
	EIt7G/uV/I9rJJ093abvTKdb8pbPiSY=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [RFC PATCH 3/3] memcg-v1: remove memcg move locking code
Date: Thu, 24 Oct 2024 18:23:04 -0700
Message-ID: <20241024065712.1274481-4-shakeel.butt@linux.dev> (raw)
In-Reply-To: <20241024065712.1274481-1-shakeel.butt@linux.dev>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The memcg v1's charge move feature has been deprecated. There is no need
to have any locking or protection against the moving charge. Let's
proceed to remove all the locking code related to charge moving.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 fs/buffer.c                |  5 ---
 include/linux/memcontrol.h | 54 -------------------------
 mm/filemap.c               |  1 -
 mm/memcontrol-v1.c         | 82 --------------------------------------
 mm/memcontrol.c            |  5 ---
 mm/page-writeback.c        | 21 ++--------
 mm/rmap.c                  |  1 -
 mm/vmscan.c                | 11 -----
 8 files changed, 3 insertions(+), 177 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1fc9a50def0b..88e765b0699f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -736,15 +736,12 @@ bool block_dirty_folio(struct address_space *mapping, struct folio *folio)
 	 * Lock out page's memcg migration to keep PageDirty
 	 * synchronized with per-memcg dirty page counters.
 	 */
-	folio_memcg_lock(folio);
 	newly_dirty = !folio_test_set_dirty(folio);
 	spin_unlock(&mapping->i_private_lock);
 
 	if (newly_dirty)
 		__folio_mark_dirty(folio, mapping, 1);
 
-	folio_memcg_unlock(folio);
-
 	if (newly_dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 
@@ -1194,13 +1191,11 @@ void mark_buffer_dirty(struct buffer_head *bh)
 		struct folio *folio = bh->b_folio;
 		struct address_space *mapping = NULL;
 
-		folio_memcg_lock(folio);
 		if (!folio_test_set_dirty(folio)) {
 			mapping = folio->mapping;
 			if (mapping)
 				__folio_mark_dirty(folio, mapping, 0);
 		}
-		folio_memcg_unlock(folio);
 		if (mapping)
 			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 798db70b0a30..932534291ca2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -299,20 +299,10 @@ struct mem_cgroup {
 	/* For oom notifier event fd */
 	struct list_head oom_notify;
 
-	/* taken only while moving_account > 0 */
-	spinlock_t move_lock;
-	unsigned long move_lock_flags;
-
 	/* Legacy tcp memory accounting */
 	bool tcpmem_active;
 	int tcpmem_pressure;
 
-	/*
-	 * set > 0 if pages under this cgroup are moving to other cgroup.
-	 */
-	atomic_t moving_account;
-	struct task_struct *move_lock_task;
-
 	/* List of events which userspace want to receive */
 	struct list_head event_list;
 	spinlock_t event_list_lock;
@@ -428,9 +418,7 @@ static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
  *
  * - the folio lock
  * - LRU isolation
- * - folio_memcg_lock()
  * - exclusive reference
- * - mem_cgroup_trylock_pages()
  *
  * For a kmem folio a caller should hold an rcu read lock to protect memcg
  * associated with a kmem folio from being released.
@@ -499,9 +487,7 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
  *
  * - the folio lock
  * - LRU isolation
- * - lock_folio_memcg()
  * - exclusive reference
- * - mem_cgroup_trylock_pages()
  *
  * For a kmem folio a caller should hold an rcu read lock to protect memcg
  * associated with a kmem folio from being released.
@@ -1873,26 +1859,6 @@ static inline bool task_in_memcg_oom(struct task_struct *p)
 	return p->memcg_in_oom;
 }
 
-void folio_memcg_lock(struct folio *folio);
-void folio_memcg_unlock(struct folio *folio);
-
-/* try to stablize folio_memcg() for all the pages in a memcg */
-static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
-{
-	rcu_read_lock();
-
-	if (mem_cgroup_disabled() || !atomic_read(&memcg->moving_account))
-		return true;
-
-	rcu_read_unlock();
-	return false;
-}
-
-static inline void mem_cgroup_unlock_pages(void)
-{
-	rcu_read_unlock();
-}
-
 static inline void mem_cgroup_enter_user_fault(void)
 {
 	WARN_ON(current->in_user_fault);
@@ -1914,26 +1880,6 @@ unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
 	return 0;
 }
 
-static inline void folio_memcg_lock(struct folio *folio)
-{
-}
-
-static inline void folio_memcg_unlock(struct folio *folio)
-{
-}
-
-static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
-{
-	/* to match folio_memcg_rcu() */
-	rcu_read_lock();
-	return true;
-}
-
-static inline void mem_cgroup_unlock_pages(void)
-{
-	rcu_read_unlock();
-}
-
 static inline bool task_in_memcg_oom(struct task_struct *p)
 {
 	return false;
diff --git a/mm/filemap.c b/mm/filemap.c
index 630a1c431ea1..e582a1545d2a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -119,7 +119,6 @@
  *    ->i_pages lock		(folio_remove_rmap_pte->set_page_dirty)
  *    bdi.wb->list_lock		(folio_remove_rmap_pte->set_page_dirty)
  *    ->inode->i_lock		(folio_remove_rmap_pte->set_page_dirty)
- *    ->memcg->move_lock	(folio_remove_rmap_pte->folio_memcg_lock)
  *    bdi.wb->list_lock		(zap_pte_range->set_page_dirty)
  *    ->inode->i_lock		(zap_pte_range->set_page_dirty)
  *    ->private_lock		(zap_pte_range->block_dirty_folio)
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 79339cb65b9d..b14f01a93d0c 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -401,87 +401,6 @@ unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
 	return nr_reclaimed;
 }
 
-/**
- * folio_memcg_lock - Bind a folio to its memcg.
- * @folio: The folio.
- *
- * This function prevents unlocked LRU folios from being moved to
- * another cgroup.
- *
- * It ensures lifetime of the bound memcg.  The caller is responsible
- * for the lifetime of the folio.
- */
-void folio_memcg_lock(struct folio *folio)
-{
-	struct mem_cgroup *memcg;
-	unsigned long flags;
-
-	/*
-	 * The RCU lock is held throughout the transaction.  The fast
-	 * path can get away without acquiring the memcg->move_lock
-	 * because page moving starts with an RCU grace period.
-         */
-	rcu_read_lock();
-
-	if (mem_cgroup_disabled())
-		return;
-again:
-	memcg = folio_memcg(folio);
-	if (unlikely(!memcg))
-		return;
-
-#ifdef CONFIG_PROVE_LOCKING
-	local_irq_save(flags);
-	might_lock(&memcg->move_lock);
-	local_irq_restore(flags);
-#endif
-
-	if (atomic_read(&memcg->moving_account) <= 0)
-		return;
-
-	spin_lock_irqsave(&memcg->move_lock, flags);
-	if (memcg != folio_memcg(folio)) {
-		spin_unlock_irqrestore(&memcg->move_lock, flags);
-		goto again;
-	}
-
-	/*
-	 * When charge migration first begins, we can have multiple
-	 * critical sections holding the fast-path RCU lock and one
-	 * holding the slowpath move_lock. Track the task who has the
-	 * move_lock for folio_memcg_unlock().
-	 */
-	memcg->move_lock_task = current;
-	memcg->move_lock_flags = flags;
-}
-
-static void __folio_memcg_unlock(struct mem_cgroup *memcg)
-{
-	if (memcg && memcg->move_lock_task == current) {
-		unsigned long flags = memcg->move_lock_flags;
-
-		memcg->move_lock_task = NULL;
-		memcg->move_lock_flags = 0;
-
-		spin_unlock_irqrestore(&memcg->move_lock, flags);
-	}
-
-	rcu_read_unlock();
-}
-
-/**
- * folio_memcg_unlock - Release the binding between a folio and its memcg.
- * @folio: The folio.
- *
- * This releases the binding created by folio_memcg_lock().  This does
- * not change the accounting of this folio to its memcg, but it does
- * permit others to change it.
- */
-void folio_memcg_unlock(struct folio *folio)
-{
-	__folio_memcg_unlock(folio_memcg(folio));
-}
-
 static u64 mem_cgroup_move_charge_read(struct cgroup_subsys_state *css,
 				struct cftype *cft)
 {
@@ -1187,7 +1106,6 @@ void memcg1_memcg_init(struct mem_cgroup *memcg)
 {
 	INIT_LIST_HEAD(&memcg->oom_notify);
 	mutex_init(&memcg->thresholds_lock);
-	spin_lock_init(&memcg->move_lock);
 	INIT_LIST_HEAD(&memcg->event_list);
 	spin_lock_init(&memcg->event_list_lock);
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 94279b9c766a..3c223aaeb6af 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1189,7 +1189,6 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
  * These functions are safe to use under any of the following conditions:
  * - folio locked
  * - folio_test_lru false
- * - folio_memcg_lock()
  * - folio frozen (refcount of 0)
  *
  * Return: The lruvec this folio is on with its lock held.
@@ -1211,7 +1210,6 @@ struct lruvec *folio_lruvec_lock(struct folio *folio)
  * These functions are safe to use under any of the following conditions:
  * - folio locked
  * - folio_test_lru false
- * - folio_memcg_lock()
  * - folio frozen (refcount of 0)
  *
  * Return: The lruvec this folio is on with its lock held and interrupts
@@ -1235,7 +1233,6 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
  * These functions are safe to use under any of the following conditions:
  * - folio locked
  * - folio_test_lru false
- * - folio_memcg_lock()
  * - folio frozen (refcount of 0)
  *
  * Return: The lruvec this folio is on with its lock held and interrupts
@@ -2375,9 +2372,7 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 	 *
 	 * - the page lock
 	 * - LRU isolation
-	 * - folio_memcg_lock()
 	 * - exclusive reference
-	 * - mem_cgroup_trylock_pages()
 	 */
 	folio->memcg_data = (unsigned long)memcg;
 }
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 1d7179aba8e3..e33727dd6b47 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2743,8 +2743,6 @@ EXPORT_SYMBOL(noop_dirty_folio);
 /*
  * Helper function for set_page_dirty family.
  *
- * Caller must hold folio_memcg_lock().
- *
  * NOTE: This relies on being atomic wrt interrupts.
  */
 static void folio_account_dirtied(struct folio *folio,
@@ -2776,8 +2774,6 @@ static void folio_account_dirtied(struct folio *folio,
 
 /*
  * Helper function for deaccounting dirty page without writeback.
- *
- * Caller must hold folio_memcg_lock().
  */
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
 {
@@ -2795,9 +2791,8 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
  * If warn is true, then emit a warning if the folio is not uptodate and has
  * not been truncated.
  *
- * The caller must hold folio_memcg_lock().  It is the caller's
- * responsibility to prevent the folio from being truncated while
- * this function is in progress, although it may have been truncated
+ * It is the caller's responsibility to prevent the folio from being truncated
+ * while this function is in progress, although it may have been truncated
  * before this function is called.  Most callers have the folio locked.
  * A few have the folio blocked from truncation through other means (e.g.
  * zap_vma_pages() has it mapped and is holding the page table lock).
@@ -2841,14 +2836,10 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
  */
 bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
-	folio_memcg_lock(folio);
-	if (folio_test_set_dirty(folio)) {
-		folio_memcg_unlock(folio);
+	if (folio_test_set_dirty(folio))
 		return false;
-	}
 
 	__folio_mark_dirty(folio, mapping, !folio_test_private(folio));
-	folio_memcg_unlock(folio);
 
 	if (mapping->host) {
 		/* !PageAnon && !swapper_space */
@@ -2975,14 +2966,12 @@ void __folio_cancel_dirty(struct folio *folio)
 		struct bdi_writeback *wb;
 		struct wb_lock_cookie cookie = {};
 
-		folio_memcg_lock(folio);
 		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 
 		if (folio_test_clear_dirty(folio))
 			folio_account_cleaned(folio, wb);
 
 		unlocked_inode_to_wb_end(inode, &cookie);
-		folio_memcg_unlock(folio);
 	} else {
 		folio_clear_dirty(folio);
 	}
@@ -3093,7 +3082,6 @@ bool __folio_end_writeback(struct folio *folio)
 	struct address_space *mapping = folio_mapping(folio);
 	bool ret;
 
-	folio_memcg_lock(folio);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
@@ -3124,7 +3112,6 @@ bool __folio_end_writeback(struct folio *folio)
 	lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr);
 	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
 	node_stat_mod_folio(folio, NR_WRITTEN, nr);
-	folio_memcg_unlock(folio);
 
 	return ret;
 }
@@ -3137,7 +3124,6 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 
 	VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
 
-	folio_memcg_lock(folio);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		XA_STATE(xas, &mapping->i_pages, folio_index(folio));
 		struct inode *inode = mapping->host;
@@ -3178,7 +3164,6 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 
 	lruvec_stat_mod_folio(folio, NR_WRITEBACK, nr);
 	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
-	folio_memcg_unlock(folio);
 
 	access_ret = arch_make_folio_accessible(folio);
 	/*
diff --git a/mm/rmap.c b/mm/rmap.c
index 4785a693857a..c6c4d4ea29a7 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -32,7 +32,6 @@
  *                   swap_lock (in swap_duplicate, swap_info_get)
  *                     mmlist_lock (in mmput, drain_mmlist and others)
  *                     mapping->private_lock (in block_dirty_folio)
- *                       folio_lock_memcg move_lock (in block_dirty_folio)
  *                         i_pages lock (widely used)
  *                           lruvec->lru_lock (in folio_lruvec_lock_irq)
  *                     inode->i_lock (in set_page_dirty's __mark_inode_dirty)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 29c098790b01..fd7171658b63 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3662,10 +3662,6 @@ static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
 		if (walk->seq != max_seq)
 			break;
 
-		/* folio_update_gen() requires stable folio_memcg() */
-		if (!mem_cgroup_trylock_pages(memcg))
-			break;
-
 		/* the caller might be holding the lock for write */
 		if (mmap_read_trylock(mm)) {
 			err = walk_page_range(mm, walk->next_addr, ULONG_MAX, &mm_walk_ops, walk);
@@ -3673,8 +3669,6 @@ static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
 			mmap_read_unlock(mm);
 		}
 
-		mem_cgroup_unlock_pages();
-
 		if (walk->batched) {
 			spin_lock_irq(&lruvec->lru_lock);
 			reset_batch_size(walk);
@@ -4096,10 +4090,6 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		}
 	}
 
-	/* folio_update_gen() requires stable folio_memcg() */
-	if (!mem_cgroup_trylock_pages(memcg))
-		return true;
-
 	arch_enter_lazy_mmu_mode();
 
 	pte -= (addr - start) / PAGE_SIZE;
@@ -4144,7 +4134,6 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	}
 
 	arch_leave_lazy_mmu_mode();
-	mem_cgroup_unlock_pages();
 
 	/* feedback from rmap walkers to page table walkers */
 	if (mm_state && suitable_to_scan(i, young))
-- 
2.43.5

