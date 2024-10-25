Return-Path: <linux-fsdevel+bounces-32834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2ED9AF6B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 03:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A2C7B2173C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 01:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DAD1386C6;
	Fri, 25 Oct 2024 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SBOeM/0c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466667A0D
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 01:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819420; cv=none; b=fPkWQr4b3N93+HTyUbz7MGuxk/cvgNK6jXeN2+iQLzyO+pkl/5nzb9VNvM1TLktkoRUAbusHM9RQijgsuZQo+4uogB5n4WPPLJ7Lx8YQU0uBwhwMsXaM4KP/oe9RpW+o+QrUz3QrUrmqOvhX7Gj/8LtoA9Y9agd9V5fkEgBvdPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819420; c=relaxed/simple;
	bh=0F/V54UcELiyTCIi9Q3KuypU90dNkSnixVfTGmRr3BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgpwwdZKCcivLqtkSSiCao8ln2nlmcbFSxtkMvKxFphTvz5waTMPdOtuLTnOkpBP0PUap48wh6Wvee3H953NVET8yvB08qWQt/2xLvw3HSxqgXCn/VfLoIMBiNOXRguGh+dQx1INMHQ/Dg7Ob5ztyVZ77eb6IKkbm08JNk+3z1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SBOeM/0c; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729819413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkv2k7zB4FzCfldIONhKIVqkDHKenpJYxbxDPiqQtgw=;
	b=SBOeM/0c1tJsEnwEpVlUjON9rbt7EaqF+SMfe5gOedK/Eu7TmhT5pq3uJ7S25R4opr6nGf
	Wj69m6+XXOEH93NenURVqMy37BIxITMtJSAOUjI7+eY4VbdmsX3qKt8bFO+4CAt+GmJy8M
	AybIrv7WNxcLYp9tKOWRt7SJUcuD00U=
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
	Meta kernel team <kernel-team@meta.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v1 2/6] memcg-v1: remove charge move code
Date: Thu, 24 Oct 2024 18:22:59 -0700
Message-ID: <20241025012304.2473312-3-shakeel.butt@linux.dev>
In-Reply-To: <20241025012304.2473312-1-shakeel.butt@linux.dev>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The memcg-v1 charge move feature has been deprecated completely and
let's remove the relevant code as well.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h |   5 -
 mm/memcontrol-v1.c         | 862 -------------------------------------
 mm/memcontrol-v1.h         |   6 -
 mm/memcontrol.c            |   9 -
 4 files changed, 882 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 524006313b0d..798db70b0a30 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -299,11 +299,6 @@ struct mem_cgroup {
 	/* For oom notifier event fd */
 	struct list_head oom_notify;
 
-	/*
-	 * Should we move charges of a task when a task is moved into this
-	 * mem_cgroup ? And what type of charges should we move ?
-	 */
-	unsigned long move_charge_at_immigrate;
 	/* taken only while moving_account > 0 */
 	spinlock_t move_lock;
 	unsigned long move_lock_flags;
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 9b3b1a446c65..9c0fba8c8a83 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -40,31 +40,6 @@ static struct mem_cgroup_tree soft_limit_tree __read_mostly;
 #define	MEM_CGROUP_MAX_RECLAIM_LOOPS		100
 #define	MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS	2
 
-/* Stuffs for move charges at task migration. */
-/*
- * Types of charges to be moved.
- */
-#define MOVE_ANON	0x1ULL
-#define MOVE_FILE	0x2ULL
-#define MOVE_MASK	(MOVE_ANON | MOVE_FILE)
-
-/* "mc" and its members are protected by cgroup_mutex */
-static struct move_charge_struct {
-	spinlock_t	  lock; /* for from, to */
-	struct mm_struct  *mm;
-	struct mem_cgroup *from;
-	struct mem_cgroup *to;
-	unsigned long flags;
-	unsigned long precharge;
-	unsigned long moved_charge;
-	unsigned long moved_swap;
-	struct task_struct *moving_task;	/* a task moving charges */
-	wait_queue_head_t waitq;		/* a waitq for other context */
-} mc = {
-	.lock = __SPIN_LOCK_UNLOCKED(mc.lock),
-	.waitq = __WAIT_QUEUE_HEAD_INITIALIZER(mc.waitq),
-};
-
 /* for OOM */
 struct mem_cgroup_eventfd_list {
 	struct list_head list;
@@ -426,51 +401,6 @@ unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
 	return nr_reclaimed;
 }
 
-/*
- * A routine for checking "mem" is under move_account() or not.
- *
- * Checking a cgroup is mc.from or mc.to or under hierarchy of
- * moving cgroups. This is for waiting at high-memory pressure
- * caused by "move".
- */
-static bool mem_cgroup_under_move(struct mem_cgroup *memcg)
-{
-	struct mem_cgroup *from;
-	struct mem_cgroup *to;
-	bool ret = false;
-	/*
-	 * Unlike task_move routines, we access mc.to, mc.from not under
-	 * mutual exclusion by cgroup_mutex. Here, we take spinlock instead.
-	 */
-	spin_lock(&mc.lock);
-	from = mc.from;
-	to = mc.to;
-	if (!from)
-		goto unlock;
-
-	ret = mem_cgroup_is_descendant(from, memcg) ||
-		mem_cgroup_is_descendant(to, memcg);
-unlock:
-	spin_unlock(&mc.lock);
-	return ret;
-}
-
-bool memcg1_wait_acct_move(struct mem_cgroup *memcg)
-{
-	if (mc.moving_task && current != mc.moving_task) {
-		if (mem_cgroup_under_move(memcg)) {
-			DEFINE_WAIT(wait);
-			prepare_to_wait(&mc.waitq, &wait, TASK_INTERRUPTIBLE);
-			/* moving charge context might have finished. */
-			if (mc.moving_task)
-				schedule();
-			finish_wait(&mc.waitq, &wait);
-			return true;
-		}
-	}
-	return false;
-}
-
 /**
  * folio_memcg_lock - Bind a folio to its memcg.
  * @folio: The folio.
@@ -552,44 +482,6 @@ void folio_memcg_unlock(struct folio *folio)
 	__folio_memcg_unlock(folio_memcg(folio));
 }
 
-#ifdef CONFIG_SWAP
-/**
- * mem_cgroup_move_swap_account - move swap charge and swap_cgroup's record.
- * @entry: swap entry to be moved
- * @from:  mem_cgroup which the entry is moved from
- * @to:  mem_cgroup which the entry is moved to
- *
- * It succeeds only when the swap_cgroup's record for this entry is the same
- * as the mem_cgroup's id of @from.
- *
- * Returns 0 on success, -EINVAL on failure.
- *
- * The caller must have charged to @to, IOW, called page_counter_charge() about
- * both res and memsw, and called css_get().
- */
-static int mem_cgroup_move_swap_account(swp_entry_t entry,
-				struct mem_cgroup *from, struct mem_cgroup *to)
-{
-	unsigned short old_id, new_id;
-
-	old_id = mem_cgroup_id(from);
-	new_id = mem_cgroup_id(to);
-
-	if (swap_cgroup_cmpxchg(entry, old_id, new_id) == old_id) {
-		mod_memcg_state(from, MEMCG_SWAP, -1);
-		mod_memcg_state(to, MEMCG_SWAP, 1);
-		return 0;
-	}
-	return -EINVAL;
-}
-#else
-static inline int mem_cgroup_move_swap_account(swp_entry_t entry,
-				struct mem_cgroup *from, struct mem_cgroup *to)
-{
-	return -EINVAL;
-}
-#endif
-
 static u64 mem_cgroup_move_charge_read(struct cgroup_subsys_state *css,
 				struct cftype *cft)
 {
@@ -616,760 +508,6 @@ static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
 }
 #endif
 
-#ifdef CONFIG_MMU
-/* Handlers for move charge at task migration. */
-static int mem_cgroup_do_precharge(unsigned long count)
-{
-	int ret;
-
-	/* Try a single bulk charge without reclaim first, kswapd may wake */
-	ret = try_charge(mc.to, GFP_KERNEL & ~__GFP_DIRECT_RECLAIM, count);
-	if (!ret) {
-		mc.precharge += count;
-		return ret;
-	}
-
-	/* Try charges one by one with reclaim, but do not retry */
-	while (count--) {
-		ret = try_charge(mc.to, GFP_KERNEL | __GFP_NORETRY, 1);
-		if (ret)
-			return ret;
-		mc.precharge++;
-		cond_resched();
-	}
-	return 0;
-}
-
-union mc_target {
-	struct folio	*folio;
-	swp_entry_t	ent;
-};
-
-enum mc_target_type {
-	MC_TARGET_NONE = 0,
-	MC_TARGET_PAGE,
-	MC_TARGET_SWAP,
-	MC_TARGET_DEVICE,
-};
-
-static struct page *mc_handle_present_pte(struct vm_area_struct *vma,
-						unsigned long addr, pte_t ptent)
-{
-	struct page *page = vm_normal_page(vma, addr, ptent);
-
-	if (!page)
-		return NULL;
-	if (PageAnon(page)) {
-		if (!(mc.flags & MOVE_ANON))
-			return NULL;
-	} else {
-		if (!(mc.flags & MOVE_FILE))
-			return NULL;
-	}
-	get_page(page);
-
-	return page;
-}
-
-#if defined(CONFIG_SWAP) || defined(CONFIG_DEVICE_PRIVATE)
-static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
-			pte_t ptent, swp_entry_t *entry)
-{
-	struct page *page = NULL;
-	swp_entry_t ent = pte_to_swp_entry(ptent);
-
-	if (!(mc.flags & MOVE_ANON))
-		return NULL;
-
-	/*
-	 * Handle device private pages that are not accessible by the CPU, but
-	 * stored as special swap entries in the page table.
-	 */
-	if (is_device_private_entry(ent)) {
-		page = pfn_swap_entry_to_page(ent);
-		if (!get_page_unless_zero(page))
-			return NULL;
-		return page;
-	}
-
-	if (non_swap_entry(ent))
-		return NULL;
-
-	/*
-	 * Because swap_cache_get_folio() updates some statistics counter,
-	 * we call find_get_page() with swapper_space directly.
-	 */
-	page = find_get_page(swap_address_space(ent), swap_cache_index(ent));
-	entry->val = ent.val;
-
-	return page;
-}
-#else
-static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
-			pte_t ptent, swp_entry_t *entry)
-{
-	return NULL;
-}
-#endif
-
-static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
-			unsigned long addr, pte_t ptent)
-{
-	unsigned long index;
-	struct folio *folio;
-
-	if (!vma->vm_file) /* anonymous vma */
-		return NULL;
-	if (!(mc.flags & MOVE_FILE))
-		return NULL;
-
-	/* folio is moved even if it's not RSS of this task(page-faulted). */
-	/* shmem/tmpfs may report page out on swap: account for that too. */
-	index = linear_page_index(vma, addr);
-	folio = filemap_get_incore_folio(vma->vm_file->f_mapping, index);
-	if (IS_ERR(folio))
-		return NULL;
-	return folio_file_page(folio, index);
-}
-
-static void memcg1_check_events(struct mem_cgroup *memcg, int nid);
-static void memcg1_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
-
-/**
- * mem_cgroup_move_account - move account of the folio
- * @folio: The folio.
- * @compound: charge the page as compound or small page
- * @from: mem_cgroup which the folio is moved from.
- * @to:	mem_cgroup which the folio is moved to. @from != @to.
- *
- * The folio must be locked and not on the LRU.
- *
- * This function doesn't do "charge" to new cgroup and doesn't do "uncharge"
- * from old cgroup.
- */
-static int mem_cgroup_move_account(struct folio *folio,
-				   bool compound,
-				   struct mem_cgroup *from,
-				   struct mem_cgroup *to)
-{
-	struct lruvec *from_vec, *to_vec;
-	struct pglist_data *pgdat;
-	unsigned int nr_pages = compound ? folio_nr_pages(folio) : 1;
-	int nid, ret;
-
-	VM_BUG_ON(from == to);
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
-	VM_BUG_ON(compound && !folio_test_large(folio));
-
-	ret = -EINVAL;
-	if (folio_memcg(folio) != from)
-		goto out;
-
-	pgdat = folio_pgdat(folio);
-	from_vec = mem_cgroup_lruvec(from, pgdat);
-	to_vec = mem_cgroup_lruvec(to, pgdat);
-
-	folio_memcg_lock(folio);
-
-	if (folio_test_anon(folio)) {
-		if (folio_mapped(folio)) {
-			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
-			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
-			if (folio_test_pmd_mappable(folio)) {
-				__mod_lruvec_state(from_vec, NR_ANON_THPS,
-						   -nr_pages);
-				__mod_lruvec_state(to_vec, NR_ANON_THPS,
-						   nr_pages);
-			}
-		}
-	} else {
-		__mod_lruvec_state(from_vec, NR_FILE_PAGES, -nr_pages);
-		__mod_lruvec_state(to_vec, NR_FILE_PAGES, nr_pages);
-
-		if (folio_test_swapbacked(folio)) {
-			__mod_lruvec_state(from_vec, NR_SHMEM, -nr_pages);
-			__mod_lruvec_state(to_vec, NR_SHMEM, nr_pages);
-		}
-
-		if (folio_mapped(folio)) {
-			__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
-			__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
-		}
-
-		if (folio_test_dirty(folio)) {
-			struct address_space *mapping = folio_mapping(folio);
-
-			if (mapping_can_writeback(mapping)) {
-				__mod_lruvec_state(from_vec, NR_FILE_DIRTY,
-						   -nr_pages);
-				__mod_lruvec_state(to_vec, NR_FILE_DIRTY,
-						   nr_pages);
-			}
-		}
-	}
-
-#ifdef CONFIG_SWAP
-	if (folio_test_swapcache(folio)) {
-		__mod_lruvec_state(from_vec, NR_SWAPCACHE, -nr_pages);
-		__mod_lruvec_state(to_vec, NR_SWAPCACHE, nr_pages);
-	}
-#endif
-	if (folio_test_writeback(folio)) {
-		__mod_lruvec_state(from_vec, NR_WRITEBACK, -nr_pages);
-		__mod_lruvec_state(to_vec, NR_WRITEBACK, nr_pages);
-	}
-
-	/*
-	 * All state has been migrated, let's switch to the new memcg.
-	 *
-	 * It is safe to change page's memcg here because the page
-	 * is referenced, charged, isolated, and locked: we can't race
-	 * with (un)charging, migration, LRU putback, or anything else
-	 * that would rely on a stable page's memory cgroup.
-	 *
-	 * Note that folio_memcg_lock is a memcg lock, not a page lock,
-	 * to save space. As soon as we switch page's memory cgroup to a
-	 * new memcg that isn't locked, the above state can change
-	 * concurrently again. Make sure we're truly done with it.
-	 */
-	smp_mb();
-
-	css_get(&to->css);
-	css_put(&from->css);
-
-	folio->memcg_data = (unsigned long)to;
-
-	__folio_memcg_unlock(from);
-
-	ret = 0;
-	nid = folio_nid(folio);
-
-	local_irq_disable();
-	memcg1_charge_statistics(to, nr_pages);
-	memcg1_check_events(to, nid);
-	memcg1_charge_statistics(from, -nr_pages);
-	memcg1_check_events(from, nid);
-	local_irq_enable();
-out:
-	return ret;
-}
-
-/**
- * get_mctgt_type - get target type of moving charge
- * @vma: the vma the pte to be checked belongs
- * @addr: the address corresponding to the pte to be checked
- * @ptent: the pte to be checked
- * @target: the pointer the target page or swap ent will be stored(can be NULL)
- *
- * Context: Called with pte lock held.
- * Return:
- * * MC_TARGET_NONE - If the pte is not a target for move charge.
- * * MC_TARGET_PAGE - If the page corresponding to this pte is a target for
- *   move charge. If @target is not NULL, the folio is stored in target->folio
- *   with extra refcnt taken (Caller should release it).
- * * MC_TARGET_SWAP - If the swap entry corresponding to this pte is a
- *   target for charge migration.  If @target is not NULL, the entry is
- *   stored in target->ent.
- * * MC_TARGET_DEVICE - Like MC_TARGET_PAGE but page is device memory and
- *   thus not on the lru.  For now such page is charged like a regular page
- *   would be as it is just special memory taking the place of a regular page.
- *   See Documentations/vm/hmm.txt and include/linux/hmm.h
- */
-static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
-		unsigned long addr, pte_t ptent, union mc_target *target)
-{
-	struct page *page = NULL;
-	struct folio *folio;
-	enum mc_target_type ret = MC_TARGET_NONE;
-	swp_entry_t ent = { .val = 0 };
-
-	if (pte_present(ptent))
-		page = mc_handle_present_pte(vma, addr, ptent);
-	else if (pte_none_mostly(ptent))
-		/*
-		 * PTE markers should be treated as a none pte here, separated
-		 * from other swap handling below.
-		 */
-		page = mc_handle_file_pte(vma, addr, ptent);
-	else if (is_swap_pte(ptent))
-		page = mc_handle_swap_pte(vma, ptent, &ent);
-
-	if (page)
-		folio = page_folio(page);
-	if (target && page) {
-		if (!folio_trylock(folio)) {
-			folio_put(folio);
-			return ret;
-		}
-		/*
-		 * page_mapped() must be stable during the move. This
-		 * pte is locked, so if it's present, the page cannot
-		 * become unmapped. If it isn't, we have only partial
-		 * control over the mapped state: the page lock will
-		 * prevent new faults against pagecache and swapcache,
-		 * so an unmapped page cannot become mapped. However,
-		 * if the page is already mapped elsewhere, it can
-		 * unmap, and there is nothing we can do about it.
-		 * Alas, skip moving the page in this case.
-		 */
-		if (!pte_present(ptent) && page_mapped(page)) {
-			folio_unlock(folio);
-			folio_put(folio);
-			return ret;
-		}
-	}
-
-	if (!page && !ent.val)
-		return ret;
-	if (page) {
-		/*
-		 * Do only loose check w/o serialization.
-		 * mem_cgroup_move_account() checks the page is valid or
-		 * not under LRU exclusion.
-		 */
-		if (folio_memcg(folio) == mc.from) {
-			ret = MC_TARGET_PAGE;
-			if (folio_is_device_private(folio) ||
-			    folio_is_device_coherent(folio))
-				ret = MC_TARGET_DEVICE;
-			if (target)
-				target->folio = folio;
-		}
-		if (!ret || !target) {
-			if (target)
-				folio_unlock(folio);
-			folio_put(folio);
-		}
-	}
-	/*
-	 * There is a swap entry and a page doesn't exist or isn't charged.
-	 * But we cannot move a tail-page in a THP.
-	 */
-	if (ent.val && !ret && (!page || !PageTransCompound(page)) &&
-	    mem_cgroup_id(mc.from) == lookup_swap_cgroup_id(ent)) {
-		ret = MC_TARGET_SWAP;
-		if (target)
-			target->ent = ent;
-	}
-	return ret;
-}
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-/*
- * We don't consider PMD mapped swapping or file mapped pages because THP does
- * not support them for now.
- * Caller should make sure that pmd_trans_huge(pmd) is true.
- */
-static enum mc_target_type get_mctgt_type_thp(struct vm_area_struct *vma,
-		unsigned long addr, pmd_t pmd, union mc_target *target)
-{
-	struct page *page = NULL;
-	struct folio *folio;
-	enum mc_target_type ret = MC_TARGET_NONE;
-
-	if (unlikely(is_swap_pmd(pmd))) {
-		VM_BUG_ON(thp_migration_supported() &&
-				  !is_pmd_migration_entry(pmd));
-		return ret;
-	}
-	page = pmd_page(pmd);
-	VM_BUG_ON_PAGE(!page || !PageHead(page), page);
-	folio = page_folio(page);
-	if (!(mc.flags & MOVE_ANON))
-		return ret;
-	if (folio_memcg(folio) == mc.from) {
-		ret = MC_TARGET_PAGE;
-		if (target) {
-			folio_get(folio);
-			if (!folio_trylock(folio)) {
-				folio_put(folio);
-				return MC_TARGET_NONE;
-			}
-			target->folio = folio;
-		}
-	}
-	return ret;
-}
-#else
-static inline enum mc_target_type get_mctgt_type_thp(struct vm_area_struct *vma,
-		unsigned long addr, pmd_t pmd, union mc_target *target)
-{
-	return MC_TARGET_NONE;
-}
-#endif
-
-static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
-					unsigned long addr, unsigned long end,
-					struct mm_walk *walk)
-{
-	struct vm_area_struct *vma = walk->vma;
-	pte_t *pte;
-	spinlock_t *ptl;
-
-	ptl = pmd_trans_huge_lock(pmd, vma);
-	if (ptl) {
-		/*
-		 * Note their can not be MC_TARGET_DEVICE for now as we do not
-		 * support transparent huge page with MEMORY_DEVICE_PRIVATE but
-		 * this might change.
-		 */
-		if (get_mctgt_type_thp(vma, addr, *pmd, NULL) == MC_TARGET_PAGE)
-			mc.precharge += HPAGE_PMD_NR;
-		spin_unlock(ptl);
-		return 0;
-	}
-
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
-	if (!pte)
-		return 0;
-	for (; addr != end; pte++, addr += PAGE_SIZE)
-		if (get_mctgt_type(vma, addr, ptep_get(pte), NULL))
-			mc.precharge++;	/* increment precharge temporarily */
-	pte_unmap_unlock(pte - 1, ptl);
-	cond_resched();
-
-	return 0;
-}
-
-static const struct mm_walk_ops precharge_walk_ops = {
-	.pmd_entry	= mem_cgroup_count_precharge_pte_range,
-	.walk_lock	= PGWALK_RDLOCK,
-};
-
-static unsigned long mem_cgroup_count_precharge(struct mm_struct *mm)
-{
-	unsigned long precharge;
-
-	mmap_read_lock(mm);
-	walk_page_range(mm, 0, ULONG_MAX, &precharge_walk_ops, NULL);
-	mmap_read_unlock(mm);
-
-	precharge = mc.precharge;
-	mc.precharge = 0;
-
-	return precharge;
-}
-
-static int mem_cgroup_precharge_mc(struct mm_struct *mm)
-{
-	unsigned long precharge = mem_cgroup_count_precharge(mm);
-
-	VM_BUG_ON(mc.moving_task);
-	mc.moving_task = current;
-	return mem_cgroup_do_precharge(precharge);
-}
-
-/* cancels all extra charges on mc.from and mc.to, and wakes up all waiters. */
-static void __mem_cgroup_clear_mc(void)
-{
-	struct mem_cgroup *from = mc.from;
-	struct mem_cgroup *to = mc.to;
-
-	/* we must uncharge all the leftover precharges from mc.to */
-	if (mc.precharge) {
-		mem_cgroup_cancel_charge(mc.to, mc.precharge);
-		mc.precharge = 0;
-	}
-	/*
-	 * we didn't uncharge from mc.from at mem_cgroup_move_account(), so
-	 * we must uncharge here.
-	 */
-	if (mc.moved_charge) {
-		mem_cgroup_cancel_charge(mc.from, mc.moved_charge);
-		mc.moved_charge = 0;
-	}
-	/* we must fixup refcnts and charges */
-	if (mc.moved_swap) {
-		/* uncharge swap account from the old cgroup */
-		if (!mem_cgroup_is_root(mc.from))
-			page_counter_uncharge(&mc.from->memsw, mc.moved_swap);
-
-		mem_cgroup_id_put_many(mc.from, mc.moved_swap);
-
-		/*
-		 * we charged both to->memory and to->memsw, so we
-		 * should uncharge to->memory.
-		 */
-		if (!mem_cgroup_is_root(mc.to))
-			page_counter_uncharge(&mc.to->memory, mc.moved_swap);
-
-		mc.moved_swap = 0;
-	}
-	memcg1_oom_recover(from);
-	memcg1_oom_recover(to);
-	wake_up_all(&mc.waitq);
-}
-
-static void mem_cgroup_clear_mc(void)
-{
-	struct mm_struct *mm = mc.mm;
-
-	/*
-	 * we must clear moving_task before waking up waiters at the end of
-	 * task migration.
-	 */
-	mc.moving_task = NULL;
-	__mem_cgroup_clear_mc();
-	spin_lock(&mc.lock);
-	mc.from = NULL;
-	mc.to = NULL;
-	mc.mm = NULL;
-	spin_unlock(&mc.lock);
-
-	mmput(mm);
-}
-
-int memcg1_can_attach(struct cgroup_taskset *tset)
-{
-	struct cgroup_subsys_state *css;
-	struct mem_cgroup *memcg = NULL; /* unneeded init to make gcc happy */
-	struct mem_cgroup *from;
-	struct task_struct *leader, *p;
-	struct mm_struct *mm;
-	unsigned long move_flags;
-	int ret = 0;
-
-	/* charge immigration isn't supported on the default hierarchy */
-	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		return 0;
-
-	/*
-	 * Multi-process migrations only happen on the default hierarchy
-	 * where charge immigration is not used.  Perform charge
-	 * immigration if @tset contains a leader and whine if there are
-	 * multiple.
-	 */
-	p = NULL;
-	cgroup_taskset_for_each_leader(leader, css, tset) {
-		WARN_ON_ONCE(p);
-		p = leader;
-		memcg = mem_cgroup_from_css(css);
-	}
-	if (!p)
-		return 0;
-
-	/*
-	 * We are now committed to this value whatever it is. Changes in this
-	 * tunable will only affect upcoming migrations, not the current one.
-	 * So we need to save it, and keep it going.
-	 */
-	move_flags = READ_ONCE(memcg->move_charge_at_immigrate);
-	if (!move_flags)
-		return 0;
-
-	from = mem_cgroup_from_task(p);
-
-	VM_BUG_ON(from == memcg);
-
-	mm = get_task_mm(p);
-	if (!mm)
-		return 0;
-	/* We move charges only when we move a owner of the mm */
-	if (mm->owner == p) {
-		VM_BUG_ON(mc.from);
-		VM_BUG_ON(mc.to);
-		VM_BUG_ON(mc.precharge);
-		VM_BUG_ON(mc.moved_charge);
-		VM_BUG_ON(mc.moved_swap);
-
-		spin_lock(&mc.lock);
-		mc.mm = mm;
-		mc.from = from;
-		mc.to = memcg;
-		mc.flags = move_flags;
-		spin_unlock(&mc.lock);
-		/* We set mc.moving_task later */
-
-		ret = mem_cgroup_precharge_mc(mm);
-		if (ret)
-			mem_cgroup_clear_mc();
-	} else {
-		mmput(mm);
-	}
-	return ret;
-}
-
-void memcg1_cancel_attach(struct cgroup_taskset *tset)
-{
-	if (mc.to)
-		mem_cgroup_clear_mc();
-}
-
-static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
-				unsigned long addr, unsigned long end,
-				struct mm_walk *walk)
-{
-	int ret = 0;
-	struct vm_area_struct *vma = walk->vma;
-	pte_t *pte;
-	spinlock_t *ptl;
-	enum mc_target_type target_type;
-	union mc_target target;
-	struct folio *folio;
-
-	ptl = pmd_trans_huge_lock(pmd, vma);
-	if (ptl) {
-		if (mc.precharge < HPAGE_PMD_NR) {
-			spin_unlock(ptl);
-			return 0;
-		}
-		target_type = get_mctgt_type_thp(vma, addr, *pmd, &target);
-		if (target_type == MC_TARGET_PAGE) {
-			folio = target.folio;
-			if (folio_isolate_lru(folio)) {
-				if (!mem_cgroup_move_account(folio, true,
-							     mc.from, mc.to)) {
-					mc.precharge -= HPAGE_PMD_NR;
-					mc.moved_charge += HPAGE_PMD_NR;
-				}
-				folio_putback_lru(folio);
-			}
-			folio_unlock(folio);
-			folio_put(folio);
-		} else if (target_type == MC_TARGET_DEVICE) {
-			folio = target.folio;
-			if (!mem_cgroup_move_account(folio, true,
-						     mc.from, mc.to)) {
-				mc.precharge -= HPAGE_PMD_NR;
-				mc.moved_charge += HPAGE_PMD_NR;
-			}
-			folio_unlock(folio);
-			folio_put(folio);
-		}
-		spin_unlock(ptl);
-		return 0;
-	}
-
-retry:
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
-	if (!pte)
-		return 0;
-	for (; addr != end; addr += PAGE_SIZE) {
-		pte_t ptent = ptep_get(pte++);
-		bool device = false;
-		swp_entry_t ent;
-
-		if (!mc.precharge)
-			break;
-
-		switch (get_mctgt_type(vma, addr, ptent, &target)) {
-		case MC_TARGET_DEVICE:
-			device = true;
-			fallthrough;
-		case MC_TARGET_PAGE:
-			folio = target.folio;
-			/*
-			 * We can have a part of the split pmd here. Moving it
-			 * can be done but it would be too convoluted so simply
-			 * ignore such a partial THP and keep it in original
-			 * memcg. There should be somebody mapping the head.
-			 */
-			if (folio_test_large(folio))
-				goto put;
-			if (!device && !folio_isolate_lru(folio))
-				goto put;
-			if (!mem_cgroup_move_account(folio, false,
-						mc.from, mc.to)) {
-				mc.precharge--;
-				/* we uncharge from mc.from later. */
-				mc.moved_charge++;
-			}
-			if (!device)
-				folio_putback_lru(folio);
-put:			/* get_mctgt_type() gets & locks the page */
-			folio_unlock(folio);
-			folio_put(folio);
-			break;
-		case MC_TARGET_SWAP:
-			ent = target.ent;
-			if (!mem_cgroup_move_swap_account(ent, mc.from, mc.to)) {
-				mc.precharge--;
-				mem_cgroup_id_get_many(mc.to, 1);
-				/* we fixup other refcnts and charges later. */
-				mc.moved_swap++;
-			}
-			break;
-		default:
-			break;
-		}
-	}
-	pte_unmap_unlock(pte - 1, ptl);
-	cond_resched();
-
-	if (addr != end) {
-		/*
-		 * We have consumed all precharges we got in can_attach().
-		 * We try charge one by one, but don't do any additional
-		 * charges to mc.to if we have failed in charge once in attach()
-		 * phase.
-		 */
-		ret = mem_cgroup_do_precharge(1);
-		if (!ret)
-			goto retry;
-	}
-
-	return ret;
-}
-
-static const struct mm_walk_ops charge_walk_ops = {
-	.pmd_entry	= mem_cgroup_move_charge_pte_range,
-	.walk_lock	= PGWALK_RDLOCK,
-};
-
-static void mem_cgroup_move_charge(void)
-{
-	lru_add_drain_all();
-	/*
-	 * Signal folio_memcg_lock() to take the memcg's move_lock
-	 * while we're moving its pages to another memcg. Then wait
-	 * for already started RCU-only updates to finish.
-	 */
-	atomic_inc(&mc.from->moving_account);
-	synchronize_rcu();
-retry:
-	if (unlikely(!mmap_read_trylock(mc.mm))) {
-		/*
-		 * Someone who are holding the mmap_lock might be waiting in
-		 * waitq. So we cancel all extra charges, wake up all waiters,
-		 * and retry. Because we cancel precharges, we might not be able
-		 * to move enough charges, but moving charge is a best-effort
-		 * feature anyway, so it wouldn't be a big problem.
-		 */
-		__mem_cgroup_clear_mc();
-		cond_resched();
-		goto retry;
-	}
-	/*
-	 * When we have consumed all precharges and failed in doing
-	 * additional charge, the page walk just aborts.
-	 */
-	walk_page_range(mc.mm, 0, ULONG_MAX, &charge_walk_ops, NULL);
-	mmap_read_unlock(mc.mm);
-	atomic_dec(&mc.from->moving_account);
-}
-
-void memcg1_move_task(void)
-{
-	if (mc.to) {
-		mem_cgroup_move_charge();
-		mem_cgroup_clear_mc();
-	}
-}
-
-#else	/* !CONFIG_MMU */
-int memcg1_can_attach(struct cgroup_taskset *tset)
-{
-	return 0;
-}
-void memcg1_cancel_attach(struct cgroup_taskset *tset)
-{
-}
-void memcg1_move_task(void)
-{
-}
-#endif
-
 static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
 {
 	struct mem_cgroup_threshold_ary *t;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index c0672e25bcdb..0e3b82951d91 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -80,12 +80,7 @@ static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
 	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
 }
 
-bool memcg1_wait_acct_move(struct mem_cgroup *memcg);
-
 struct cgroup_taskset;
-int memcg1_can_attach(struct cgroup_taskset *tset);
-void memcg1_cancel_attach(struct cgroup_taskset *tset);
-void memcg1_move_task(void);
 void memcg1_css_offline(struct mem_cgroup *memcg);
 
 /* for encoding cft->private value on file */
@@ -130,7 +125,6 @@ static inline void memcg1_free_events(struct mem_cgroup *memcg) {}
 static inline void memcg1_memcg_init(struct mem_cgroup *memcg) {}
 static inline void memcg1_remove_from_trees(struct mem_cgroup *memcg) {}
 static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg) {}
-static inline bool memcg1_wait_acct_move(struct mem_cgroup *memcg) { return false; }
 static inline void memcg1_css_offline(struct mem_cgroup *memcg) {}
 
 static inline bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked) { return true; }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5c3a8629ef3e..94279b9c766a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2242,12 +2242,6 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 */
 	if (nr_reclaimed && nr_pages <= (1 << PAGE_ALLOC_COSTLY_ORDER))
 		goto retry;
-	/*
-	 * At task move, charge accounts can be doubly counted. So, it's
-	 * better to wait until the end of task_move if something is going on.
-	 */
-	if (memcg1_wait_acct_move(mem_over_limit))
-		goto retry;
 
 	if (nr_retries--)
 		goto retry;
@@ -4439,9 +4433,6 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.exit = mem_cgroup_exit,
 	.dfl_cftypes = memory_files,
 #ifdef CONFIG_MEMCG_V1
-	.can_attach = memcg1_can_attach,
-	.cancel_attach = memcg1_cancel_attach,
-	.post_attach = memcg1_move_task,
 	.legacy_cftypes = mem_cgroup_legacy_files,
 #endif
 	.early_init = 0,
-- 
2.43.5


