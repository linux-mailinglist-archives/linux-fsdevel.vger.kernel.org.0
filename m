Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23D832B4FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450150AbhCCFap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383571AbhCBVQ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:16:28 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EB6C061788;
        Tue,  2 Mar 2021 13:09:55 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id l7so10422862pfd.3;
        Tue, 02 Mar 2021 13:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JLttgNfMq3Kov3tU2taLK4BnRrz26Wpbqh7r9Pz+2zU=;
        b=ZUR/GOeR+rzGWfJrXDJ9R713bPE1Gv+0qMwgH2DHrTXOjiaUpleSR+L5jDBb4MH8O9
         2aqJZgBtXRsaXqa1eHwHhJKzzYu4bKnwyu4yDfFP/o0ZeVbfQuPzvbBF0hU+2i+xLzWs
         gAgSOGdk76OpM0zP8Cq49cvh7Rw35W6ffYDZOngiT43r2V+GmSUv3d5jb1783ziIYG5q
         atYGoU0dcHGlYydbwXFI/yoFKojuhj54+Y+PEqNWzvKjo4cpikd0AP9UpzHjIg1GUx99
         pGKFU7QtutnjsrqgCkHqNl00PxuKzh+OslSm0WYp03iBV/kgA4ajgIRTvrq9WJrkbQ/j
         OUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JLttgNfMq3Kov3tU2taLK4BnRrz26Wpbqh7r9Pz+2zU=;
        b=fucB1pvrp21eeVBDc5gEblTHfkW5yPOovYGLVyRX00hcZ6foPiXi2YKCMRsfYpV263
         4QcZxQb2ItMXMYB+0A0YrBLrp21GhyOLpKgOZH6yQF4rEn5nFysaHticoWicwRH+EXpU
         pqcj1NRa1LTRVf4+95alEb3ih7tDJOj5u21v1eU1l+CbCK+1S3NfMyrEtm2uzJ4GnOc6
         BqphVGqf8BM8YTAzbw1eRWEMTtEgAPliMI9IMSad8WgOvLws6fbTzui70QeNUgJrzrKi
         3kcrqGopG4OkcgtroCyohV4GEeJZeTM4X6ClHo7A4sSmTG9nUyw01jeNiIZlrUWwy3VW
         76Yg==
X-Gm-Message-State: AOAM5331i7AQ8QrVuC1JBlGzPSVUAYx2AIYRlLKAa1Sgw21TiyxEBb4k
        VQSLCRWz6CjBfguUQ4Rc4Rc=
X-Google-Smtp-Source: ABdhPJzAIvods/GCYgMUuU2epYNi8LvhsVZq+3AIjibtUN4omfOt0B/q0+Yex7vBczbTbe3px3gFAg==
X-Received: by 2002:a63:610:: with SMTP id 16mr18860021pgg.423.1614719394641;
        Tue, 02 Mar 2021 13:09:54 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:c87:c34:99dc:ba23])
        by smtp.gmail.com with ESMTPSA id w17sm18980572pgg.41.2021.03.02.13.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 13:09:53 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 1/2] mm: disable LRU pagevec during the migration temporarily
Date:   Tue,  2 Mar 2021 13:09:48 -0800
Message-Id: <20210302210949.2440120-1-minchan@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

LRU pagevec holds refcount of pages until the pagevec are drained.
It could prevent migration since the refcount of the page is greater
than the expection in migration logic. To mitigate the issue,
callers of migrate_pages drains LRU pagevec via migrate_prep or
lru_add_drain_all before migrate_pages call.

However, it's not enough because pages coming into pagevec after the
draining call still could stay at the pagevec so it could keep
preventing page migration. Since some callers of migrate_pages have
retrial logic with LRU draining, the page would migrate at next trail
but it is still fragile in that it doesn't close the fundamental race
between upcoming LRU pages into pagvec and migration so the migration
failure could cause contiguous memory allocation failure in the end.

To close the race, this patch disables lru caches(i.e, pagevec)
during ongoing migration until migrate is done.

Since it's really hard to reproduce, I measured how many times
migrate_pages retried with force mode below debug code.

int migrate_pages(struct list_head *from, new_page_t get_new_page,
			..
			..

if (rc && reason == MR_CONTIG_RANGE && pass > 2) {
       printk(KERN_ERR, "pfn 0x%lx reason %d\n", page_to_pfn(page), rc);
       dump_page(page, "fail to migrate");
}

The test was repeating android apps launching with cma allocation
in background every five seconds. Total cma allocation count was
about 500 during the testing. With this patch, the dump_page count
was reduced from 400 to 30.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* from RFC - http://lore.kernel.org/linux-mm/20210216170348.1513483-1-minchan@kernel.org
  * use atomic and lru_add_drain_all for strict ordering - mhocko
  * lru_cache_disable/enable - mhocko

 fs/block_dev.c          |  2 +-
 include/linux/migrate.h |  6 +++--
 include/linux/swap.h    |  4 ++-
 mm/compaction.c         |  4 +--
 mm/fadvise.c            |  2 +-
 mm/gup.c                |  2 +-
 mm/khugepaged.c         |  2 +-
 mm/ksm.c                |  2 +-
 mm/memcontrol.c         |  4 +--
 mm/memfd.c              |  2 +-
 mm/memory-failure.c     |  2 +-
 mm/memory_hotplug.c     |  2 +-
 mm/mempolicy.c          |  6 +++++
 mm/migrate.c            | 15 ++++++-----
 mm/page_alloc.c         |  5 +++-
 mm/swap.c               | 55 +++++++++++++++++++++++++++++++++++------
 16 files changed, 85 insertions(+), 30 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7a814a13f9a4..1fe75dbd0ce0 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -93,7 +93,7 @@ void invalidate_bdev(struct block_device *bdev)
 
 	if (mapping->nrpages) {
 		invalidate_bh_lrus();
-		lru_add_drain_all();	/* make sure all lru add caches are flushed */
+		lru_add_drain_all(false);	/* make sure all lru add caches are flushed */
 		invalidate_mapping_pages(mapping, 0, -1);
 	}
 	/* 99% of the time, we don't need to flush the cleancache on the bdev.
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3a389633b68f..6a23174ea081 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -47,6 +47,7 @@ extern void putback_movable_page(struct page *page);
 
 extern void migrate_prep(void);
 extern void migrate_prep_local(void);
+extern void migrate_finish(void);
 extern void migrate_page_states(struct page *newpage, struct page *page);
 extern void migrate_page_copy(struct page *newpage, struct page *page);
 extern int migrate_huge_page_move_mapping(struct address_space *mapping,
@@ -66,8 +67,9 @@ static inline struct page *alloc_migration_target(struct page *page,
 static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	{ return -EBUSY; }
 
-static inline int migrate_prep(void) { return -ENOSYS; }
-static inline int migrate_prep_local(void) { return -ENOSYS; }
+static inline void migrate_prep(void) { return -ENOSYS; }
+static inline void migrate_prep_local(void) { return -ENOSYS; }
+static inline void migrate_done(void) {}
 
 static inline void migrate_page_states(struct page *newpage, struct page *page)
 {
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 71166bc10d17..8ab7ad7157f3 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -339,10 +339,12 @@ extern void lru_note_cost(struct lruvec *lruvec, bool file,
 extern void lru_note_cost_page(struct page *);
 extern void lru_cache_add(struct page *);
 extern void mark_page_accessed(struct page *);
+extern void lru_cache_disable(void);
+extern void lru_cache_enable(void);
 extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
-extern void lru_add_drain_all(void);
+extern void lru_add_drain_all(bool force_all_cpus);
 extern void rotate_reclaimable_page(struct page *page);
 extern void deactivate_file_page(struct page *page);
 extern void deactivate_page(struct page *page);
diff --git a/mm/compaction.c b/mm/compaction.c
index 50b31e2ec6cb..519f6c241e69 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2648,7 +2648,7 @@ static void compact_nodes(void)
 	int nid;
 
 	/* Flush pending updates to the LRU lists */
-	lru_add_drain_all();
+	lru_add_drain_all(false);
 
 	for_each_online_node(nid)
 		compact_node(nid);
@@ -2686,7 +2686,7 @@ static ssize_t sysfs_compact_node(struct device *dev,
 
 	if (nid >= 0 && nid < nr_node_ids && node_online(nid)) {
 		/* Flush pending updates to the LRU lists */
-		lru_add_drain_all();
+		lru_add_drain_all(false);
 
 		compact_node(nid);
 	}
diff --git a/mm/fadvise.c b/mm/fadvise.c
index d6baa4f451c5..6053cd878b18 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -165,7 +165,7 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 			 * pagevecs and try again.
 			 */
 			if (nr_pagevec) {
-				lru_add_drain_all();
+				lru_add_drain_all(false);
 				invalidate_mapping_pages(mapping, start_index,
 						end_index);
 			}
diff --git a/mm/gup.c b/mm/gup.c
index 3e086b073624..2d51edd1601b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1586,7 +1586,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 				isolate_huge_page(head, &cma_page_list);
 			else {
 				if (!PageLRU(head) && drain_allow) {
-					lru_add_drain_all();
+					lru_add_drain_all(false);
 					drain_allow = false;
 				}
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8369d9620f6d..65d08a35be08 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2211,7 +2211,7 @@ static void khugepaged_do_scan(void)
 
 	barrier(); /* write khugepaged_pages_to_scan to local stack */
 
-	lru_add_drain_all();
+	lru_add_drain_all(false);
 
 	while (progress < pages) {
 		if (!khugepaged_prealloc_page(&hpage, &wait))
diff --git a/mm/ksm.c b/mm/ksm.c
index 9694ee2c71de..3559e2c92ebf 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2245,7 +2245,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 		 * them here (here rather than on entry to ksm_do_scan(),
 		 * so we don't IPI too often when pages_to_scan is set low).
 		 */
-		lru_add_drain_all();
+		lru_add_drain_all(false);
 
 		/*
 		 * Whereas stale stable_nodes on the stable_tree itself
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ed5cc78a8dbf..12f70487915e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3520,7 +3520,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 	int nr_retries = MAX_RECLAIM_RETRIES;
 
 	/* we call try-to-free pages for make this cgroup empty */
-	lru_add_drain_all();
+	lru_add_drain_all(false);
 
 	drain_all_stock(memcg);
 
@@ -6140,7 +6140,7 @@ static const struct mm_walk_ops charge_walk_ops = {
 
 static void mem_cgroup_move_charge(void)
 {
-	lru_add_drain_all();
+	lru_add_drain_all(false);
 	/*
 	 * Signal lock_page_memcg() to take the memcg's move_lock
 	 * while we're moving its pages to another memcg. Then wait
diff --git a/mm/memfd.c b/mm/memfd.c
index 2647c898990c..79d6e004a89b 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -79,7 +79,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 			break;
 
 		if (!scan)
-			lru_add_drain_all();
+			lru_add_drain_all(false);
 		else if (schedule_timeout_killable((HZ << scan) / 200))
 			scan = LAST_SCAN;
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4e3684d694c1..aba281dc58d7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -272,7 +272,7 @@ void shake_page(struct page *p, int access)
 		return;
 
 	if (!PageSlab(p)) {
-		lru_add_drain_all();
+		lru_add_drain_all(false);
 		if (PageLRU(p) || is_free_buddy_page(p))
 			return;
 	}
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a969463bdda4..56d224e8e7f6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1602,7 +1602,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 			}
 
 			cond_resched();
-			lru_add_drain_all();
+			lru_add_drain_all(false);
 
 			ret = scan_movable_pages(pfn, end_pfn, &pfn);
 			if (!ret) {
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6961238c7ef5..46d9986c7bf0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1208,6 +1208,8 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 			break;
 	}
 	mmap_read_unlock(mm);
+	migrate_finish();
+
 	if (err < 0)
 		return err;
 	return busy;
@@ -1371,6 +1373,10 @@ static long do_mbind(unsigned long start, unsigned long len,
 	mmap_write_unlock(mm);
 mpol_out:
 	mpol_put(new);
+
+	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+		migrate_finish();
+
 	return err;
 }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index a69da8aaeccd..bcf4637f6950 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -65,12 +65,9 @@
 void migrate_prep(void)
 {
 	/*
-	 * Clear the LRU lists so pages can be isolated.
-	 * Note that pages may be moved off the LRU after we have
-	 * drained them. Those pages will fail to migrate like other
-	 * pages that may be busy.
+	 * Clear the LRU pcp lists so pages can be isolated.
 	 */
-	lru_add_drain_all();
+	lru_cache_disable();
 }
 
 /* Do the necessary work of migrate_prep but not if it involves other CPUs */
@@ -79,6 +76,11 @@ void migrate_prep_local(void)
 	lru_add_drain();
 }
 
+void migrate_finish(void)
+{
+	lru_cache_enable();
+}
+
 int isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
 	struct address_space *mapping;
@@ -1837,6 +1839,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	if (err >= 0)
 		err = err1;
 out:
+	migrate_finish();
 	return err;
 }
 
@@ -2673,7 +2676,7 @@ static void migrate_vma_prepare(struct migrate_vma *migrate)
 		if (!is_zone_device_page(page)) {
 			if (!PageLRU(page) && allow_drain) {
 				/* Drain CPU's pagevec */
-				lru_add_drain_all();
+				lru_add_drain_all(false);
 				allow_drain = false;
 			}
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6446778cbc6b..9214fdada691 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8493,6 +8493,9 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
 				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
 	}
+
+	migrate_finish();
+
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
 		return ret;
@@ -8603,7 +8606,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * isolated thus they won't get removed from buddy.
 	 */
 
-	lru_add_drain_all();
+	lru_add_drain_all(false);
 
 	order = 0;
 	outer_start = start;
diff --git a/mm/swap.c b/mm/swap.c
index 31b844d4ed94..c1fa6cac04c1 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -54,6 +54,32 @@ static DEFINE_PER_CPU(struct lru_rotate, lru_rotate) = {
 	.lock = INIT_LOCAL_LOCK(lock),
 };
 
+static atomic_t lru_disable_count = ATOMIC_INIT(0);
+
+bool lru_cache_disabled(void)
+{
+	return atomic_read(&lru_disable_count);
+}
+
+void lru_cache_disable(void)
+{
+	/*
+	 * lru_add_drain_all's IPI will make sure no new pages are added
+	 * to the pcp lists and drain them all.
+	 */
+	atomic_inc(&lru_disable_count);
+
+	/*
+	 * Clear the LRU lists so pages can be isolated.
+	 */
+	lru_add_drain_all(true);
+}
+
+void lru_cache_enable(void)
+{
+	atomic_dec(&lru_disable_count);
+}
+
 /*
  * The following struct pagevec are grouped together because they are protected
  * by disabling preemption (and interrupts remain enabled).
@@ -235,6 +261,18 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
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
@@ -252,7 +290,7 @@ void rotate_reclaimable_page(struct page *page)
 		get_page(page);
 		local_lock_irqsave(&lru_rotate.lock, flags);
 		pvec = this_cpu_ptr(&lru_rotate.pvec);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, pagevec_move_tail_fn);
 		local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
@@ -343,7 +381,7 @@ static void activate_page(struct page *page)
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.activate_page);
 		get_page(page);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, __activate_page);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -458,7 +496,7 @@ void lru_cache_add(struct page *page)
 	get_page(page);
 	local_lock(&lru_pvecs.lock);
 	pvec = this_cpu_ptr(&lru_pvecs.lru_add);
-	if (!pagevec_add(pvec, page) || PageCompound(page))
+	if (pagevec_add_and_need_flush(pvec, page))
 		__pagevec_lru_add(pvec);
 	local_unlock(&lru_pvecs.lock);
 }
@@ -654,7 +692,7 @@ void deactivate_file_page(struct page *page)
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
 
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -676,7 +714,7 @@ void deactivate_page(struct page *page)
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate);
 		get_page(page);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_fn);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -698,7 +736,7 @@ void mark_page_lazyfree(struct page *page)
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_lazyfree);
 		get_page(page);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -735,7 +773,7 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
  * Calling this function with cpu hotplug locks held can actually lead
  * to obscure indirect dependencies via WQ context.
  */
-void lru_add_drain_all(void)
+void lru_add_drain_all(bool force_all_cpus)
 {
 	/*
 	 * lru_drain_gen - Global pages generation number
@@ -810,7 +848,8 @@ void lru_add_drain_all(void)
 	for_each_online_cpu(cpu) {
 		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
 
-		if (pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
+		if (force_all_cpus ||
+		    pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
 		    data_race(pagevec_count(&per_cpu(lru_rotate.pvec, cpu))) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
-- 
2.30.1.766.gb4fecdf3b7-goog

