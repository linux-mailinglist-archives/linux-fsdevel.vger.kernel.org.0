Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CB53342CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 17:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhCJQOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 11:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhCJQOh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:14:37 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFD9C061760;
        Wed, 10 Mar 2021 08:14:37 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 16so5276827pgo.13;
        Wed, 10 Mar 2021 08:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KFzn+HW7QU1YuokVuuLvjBXwnGWstmVEZGxg/O7T27g=;
        b=VlZhYEdYh2D1yn1Rbg0s72eZSpzYr0KpDPCmHl4nZjWVVDUT1XCmSMAySiCMOahHBD
         BraIyK0n++UWwDVoSSm+eC/FCVf0t16sFrkd965utyuDbnExST4iFgM91XlLiBPDCSrj
         5zcOdZhmUzvyY8aCuS092HxpuSkfgLlVscRSxImjRJIiUtMTFg5KLPkf1d5eEa6FvG3H
         j2rVIbDq9lxEJaLhvRGGOw2iv5qVRUxxKML2bwv5eMsB2GX/JkPmkUnr0IMELDLoxsnF
         RHHOFXKlCx93cONQgM5T0JUlYdfyPvKwihal32BEsQjVJuYJtW01p3Z/3L4GyQJ8LMxm
         nmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KFzn+HW7QU1YuokVuuLvjBXwnGWstmVEZGxg/O7T27g=;
        b=Ub/mfJNYWiCFqR3PE9Tq8bjcTXlZtnvtR9kHSqNYWrpiE+7lD0xeHtivW/FzTcEbLS
         vcWSWmfVuO9Lco/BA5rVCrXKjGJrz9RzQJkAsOZEsXUooAdvkpna+JuVBveiarmV5xAL
         ZR57J3M+6N4K2qtS81CRRGpeD8BkD7AktI7eKmStQUx4Alq2dt6er/d3DkLgIN1Vwgpq
         qqd9w4pgvIVyuBxYBO1kOPfr8E683au17C2TmM1aVAwyWMCU0uF+fLvZo2IUJ/GaJZuB
         LZau8ZjWVoLznonjbgab9MGFkXU5i9n8eb6roZKWQGnNbZfJXYwewI6ragHk45hTAJkB
         X1Ug==
X-Gm-Message-State: AOAM532g6YzvjOL+lIxl7rzed3RSXXsjsXkW1hKx5wZ1eCJeN7R37vM0
        ZLM3GUc6rIgUSh9sdQFQ/B0=
X-Google-Smtp-Source: ABdhPJz4uZh+gkV3hCHXAzdT1lkzni3EbzIsdM3/Zq33xtta7u3dDjDaFK7QSYhM0+a6PCPlula+0w==
X-Received: by 2002:a62:5344:0:b029:1df:c7d:3c3e with SMTP id h65-20020a6253440000b02901df0c7d3c3emr3482626pfb.11.1615392877113;
        Wed, 10 Mar 2021 08:14:37 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id d1sm7121189pjc.24.2021.03.10.08.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 08:14:36 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v3 2/3] mm: disable LRU pagevec during the migration temporarily
Date:   Wed, 10 Mar 2021 08:14:28 -0800
Message-Id: <20210310161429.399432-2-minchan@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210310161429.399432-1-minchan@kernel.org>
References: <20210310161429.399432-1-minchan@kernel.org>
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
migrate_pages retried with force mode(it is about a fallback to a
sync migration) with below debug code.

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

The new interface is also useful for memory hotplug which currently
drains lru pcp caches after each migration failure. This is rather
suboptimal as it has to disrupt others running during the operation.
With the new interface the operation happens only once. This is also in
line with pcp allocator cache which are disabled for the offlining as
well.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/swap.h |  3 ++
 mm/memory_hotplug.c  |  3 +-
 mm/mempolicy.c       |  4 ++-
 mm/migrate.c         |  3 +-
 mm/swap.c            | 79 ++++++++++++++++++++++++++++++++++++--------
 5 files changed, 75 insertions(+), 17 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 32f665b1ee85..a3e258335a7f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -339,6 +339,9 @@ extern void lru_note_cost(struct lruvec *lruvec, bool file,
 extern void lru_note_cost_page(struct page *);
 extern void lru_cache_add(struct page *);
 extern void mark_page_accessed(struct page *);
+extern void lru_cache_disable(void);
+extern void lru_cache_enable(void);
+extern bool lru_cache_disabled(void);
 extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 5ba51a8bdaeb..959f659ef085 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1611,6 +1611,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	 * in a way that pages from isolated pageblock are left on pcplists.
 	 */
 	zone_pcp_disable(zone);
+	lru_cache_disable();
 
 	/* set above range as isolated */
 	ret = start_isolate_page_range(start_pfn, end_pfn,
@@ -1642,7 +1643,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 			}
 
 			cond_resched();
-			lru_add_drain_all();
 
 			ret = scan_movable_pages(pfn, end_pfn, &pfn);
 			if (!ret) {
@@ -1687,6 +1687,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
 	spin_unlock_irqrestore(&zone->lock, flags);
 
+	lru_cache_enable();
 	zone_pcp_enable(zone);
 
 	/* removal success */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index fc024e97be37..658238e69551 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1323,7 +1323,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
 
-		lru_add_drain_all();
+		lru_cache_disable();
 	}
 	{
 		NODEMASK_SCRATCH(scratch);
@@ -1371,6 +1371,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 	mmap_write_unlock(mm);
 mpol_out:
 	mpol_put(new);
+	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+		lru_cache_enable();
 	return err;
 }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 45f925e10f5a..acc9913e4303 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1747,7 +1747,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	int start, i;
 	int err = 0, err1;
 
-	lru_add_drain_all();
+	lru_cache_disable();
 
 	for (i = start = 0; i < nr_pages; i++) {
 		const void __user *p;
@@ -1816,6 +1816,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	if (err >= 0)
 		err = err1;
 out:
+	lru_cache_enable();
 	return err;
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index 441d1ae1f285..fbdf6ac05aec 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -235,6 +235,18 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
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
@@ -252,7 +264,7 @@ void rotate_reclaimable_page(struct page *page)
 		get_page(page);
 		local_lock_irqsave(&lru_rotate.lock, flags);
 		pvec = this_cpu_ptr(&lru_rotate.pvec);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, pagevec_move_tail_fn);
 		local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
@@ -343,7 +355,7 @@ static void activate_page(struct page *page)
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.activate_page);
 		get_page(page);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, __activate_page);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -458,7 +470,7 @@ void lru_cache_add(struct page *page)
 	get_page(page);
 	local_lock(&lru_pvecs.lock);
 	pvec = this_cpu_ptr(&lru_pvecs.lru_add);
-	if (!pagevec_add(pvec, page) || PageCompound(page))
+	if (pagevec_add_and_need_flush(pvec, page))
 		__pagevec_lru_add(pvec);
 	local_unlock(&lru_pvecs.lock);
 }
@@ -654,7 +666,7 @@ void deactivate_file_page(struct page *page)
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
 
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -676,7 +688,7 @@ void deactivate_page(struct page *page)
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate);
 		get_page(page);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_fn);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -698,7 +710,7 @@ void mark_page_lazyfree(struct page *page)
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_lazyfree);
 		get_page(page);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -729,18 +741,13 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
 }
 
 /*
- * lru_add_drain_all() usually needs to be called before we start compiling
- * a list of pages to be migrated using isolate_lru_page(). Note that pages
- * may be moved off the LRU after we have drained them. Those pages will
- * fail to migrate like other pages that may be busy.
- *
  * Doesn't need any cpu hotplug locking because we do rely on per-cpu
  * kworkers being shut down before our page_alloc_cpu_dead callback is
  * executed on the offlined cpu.
  * Calling this function with cpu hotplug locks held can actually lead
  * to obscure indirect dependencies via WQ context.
  */
-void lru_add_drain_all(void)
+static void __lru_add_drain_all(bool force_all_cpus)
 {
 	/*
 	 * lru_drain_gen - Global pages generation number
@@ -785,7 +792,7 @@ void lru_add_drain_all(void)
 	 * (C) Exit the draining operation if a newer generation, from another
 	 * lru_add_drain_all(), was already scheduled for draining. Check (A).
 	 */
-	if (unlikely(this_gen != lru_drain_gen))
+	if (unlikely(this_gen != lru_drain_gen && !force_all_cpus))
 		goto done;
 
 	/*
@@ -815,7 +822,8 @@ void lru_add_drain_all(void)
 	for_each_online_cpu(cpu) {
 		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
 
-		if (pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
+		if (force_all_cpus ||
+		    pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
 		    data_race(pagevec_count(&per_cpu(lru_rotate.pvec, cpu))) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
@@ -833,6 +841,11 @@ void lru_add_drain_all(void)
 done:
 	mutex_unlock(&lock);
 }
+
+void lru_add_drain_all(void)
+{
+	__lru_add_drain_all(false);
+}
 #else
 void lru_add_drain_all(void)
 {
@@ -840,6 +853,44 @@ void lru_add_drain_all(void)
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
+
+/*
+ * lru_cache_disable() needs to be called before we start compiling
+ * a list of pages to be migrated using isolate_lru_page().
+ * It drains pages on LRU cache and then disable on all cpus until
+ * lru_cache_enable is called.
+ *
+ * Must be paired with a call to lru_cache_enable().
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
2.30.1.766.gb4fecdf3b7-goog

