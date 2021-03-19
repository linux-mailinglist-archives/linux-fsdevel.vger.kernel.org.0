Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA453423B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 18:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCSRwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 13:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhCSRvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:51:51 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED892C06174A;
        Fri, 19 Mar 2021 10:51:50 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id k24so4187562pgl.6;
        Fri, 19 Mar 2021 10:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OeHyWKCGOpd9bY+kqlImZzFrLSiUBZ7zPZcgXqiKPbc=;
        b=S+wDoNwr6wE3jgHD2DQFV9qmbQR/k96QzLn8YE+nckAhTDtAciQmFyca0PPMQJmDvw
         3ibXqDaB0VXXKU1Y+QoCRb1qFULWIMr2AqK+DBnZqE5XdgiOX/rOvHJlG1KMQfIX7c3t
         FXpNPt2Hu+9YNk2l90lspW+JRYSHxLD4QsDElqe6l7Is5YYMn9GT18T9StpxUMdVk9nP
         MjifufLLuaOW3CjsawprcK0RZzvbYNSKK/qqQ2KL32V31xri4OiRbSCpqrXOUr5bhy/9
         aqSMYEVNMDRTJVdVRsVZCJyNotgQN/ZD3+howu6F4/WHDjeICzslDPIZQfCkEI3e6xH/
         TyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=OeHyWKCGOpd9bY+kqlImZzFrLSiUBZ7zPZcgXqiKPbc=;
        b=rW9+GrJtN/nb4QusPWwbqypZKDIW3Sxlp3PT42LwkICsnDlrv3Hl5xzQLYJ0Desgwf
         GMk9aXZZJV/PvuYs7mfXQPBev8lFu71s6tHSBv1Ezq6YTCjqo2YkGzHGiSw10qoMEgxc
         fy4J3t7kxV0rPnmPEL4qqUFuD79fsp4+mGC+08uFe1FaOKiJ6ei5vypIbCOecc1lt3EK
         QnD4Llpis7BLQgp7qnSCohheMRINg4oGLRD9q8pudKmsfCvyJGO1An9hIFKM/MG9a4Hb
         ErX9ZOaJ9Otqchdk6AIIeV9OU7WRRDHLh/aenpoSq7YT6GfNLuoMbaEip4z7RQ50O8GA
         S1OQ==
X-Gm-Message-State: AOAM530dj5Lb6VuM2Fmyr3BlEBGLTA8EOM8Dw73ruFImkVFs5p1stWQk
        XksONAEroxCFWoYOQstBpyc=
X-Google-Smtp-Source: ABdhPJyCw9zQ60569SfJUv7gjAimlBr2v0X3ndeNBs2C4c/AMLMtDTk8RkIeRB3sAGPI2DoUFf2Qjg==
X-Received: by 2002:a62:37c6:0:b029:1f0:abe0:8d1c with SMTP id e189-20020a6237c60000b02901f0abe08d1cmr10240412pfa.23.1616176310387;
        Fri, 19 Mar 2021 10:51:50 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:913d:5573:c956:f033])
        by smtp.gmail.com with ESMTPSA id w8sm5498287pgk.46.2021.03.19.10.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:51:49 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        oliver.sang@intel.com, Minchan Kim <minchan@kernel.org>
Subject: [PATCH v4 1/3] mm: disable LRU pagevec during the migration temporarily
Date:   Fri, 19 Mar 2021 10:51:25 -0700
Message-Id: <20210319175127.886124-1-minchan@kernel.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
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

Reviewed-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/migrate.h |  2 ++
 include/linux/swap.h    | 14 +++++++++
 mm/memory_hotplug.c     |  3 +-
 mm/mempolicy.c          |  4 +++
 mm/migrate.c            | 11 ++++---
 mm/page_alloc.c         |  2 ++
 mm/swap.c               | 64 +++++++++++++++++++++++++++++++++++------
 7 files changed, 86 insertions(+), 14 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3a389633b68f..9e4a2dc8622c 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -46,6 +46,7 @@ extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
 
 extern void migrate_prep(void);
+extern void migrate_finish(void);
 extern void migrate_prep_local(void);
 extern void migrate_page_states(struct page *newpage, struct page *page);
 extern void migrate_page_copy(struct page *newpage, struct page *page);
@@ -67,6 +68,7 @@ static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	{ return -EBUSY; }
 
 static inline int migrate_prep(void) { return -ENOSYS; }
+static inline int migrate_finish(void) { return -ENOSYS; }
 static inline int migrate_prep_local(void) { return -ENOSYS; }
 
 static inline void migrate_page_states(struct page *newpage, struct page *page)
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 32f665b1ee85..85cf022072a0 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -339,6 +339,20 @@ extern void lru_note_cost(struct lruvec *lruvec, bool file,
 extern void lru_note_cost_page(struct page *);
 extern void lru_cache_add(struct page *);
 extern void mark_page_accessed(struct page *);
+
+extern atomic_t lru_disable_count;
+
+static inline bool lru_cache_disabled(void)
+{
+	return atomic_read(&lru_disable_count);
+}
+
+static inline void lru_cache_enable(void)
+{
+	atomic_dec(&lru_disable_count);
+}
+
+extern void lru_cache_disable(void);
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
index ab51132547b8..495b43a4b0f8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1208,6 +1208,8 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 			break;
 	}
 	mmap_read_unlock(mm);
+
+	migrate_finish();
 	if (err < 0)
 		return err;
 	return busy;
@@ -1371,6 +1373,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 	mmap_write_unlock(mm);
 mpol_out:
 	mpol_put(new);
+	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+		migrate_finish();
 	return err;
 }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 62b81d5257aa..4d6c306d41c6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -66,11 +66,13 @@ void migrate_prep(void)
 {
 	/*
 	 * Clear the LRU lists so pages can be isolated.
-	 * Note that pages may be moved off the LRU after we have
-	 * drained them. Those pages will fail to migrate like other
-	 * pages that may be busy.
 	 */
-	lru_add_drain_all();
+	lru_cache_disable();
+}
+
+void migrate_finish(void)
+{
+	lru_cache_enable();
 }
 
 /* Do the necessary work of migrate_prep but not if it involves other CPUs */
@@ -1838,6 +1840,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	if (err >= 0)
 		err = err1;
 out:
+	migrate_finish();
 	return err;
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e8348936df8..af5d4eeb2999 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8495,6 +8495,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
 				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
 	}
+
+	migrate_finish();
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
 		return ret;
diff --git a/mm/swap.c b/mm/swap.c
index 31b844d4ed94..c94f55e7b649 100644
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
@@ -735,7 +747,7 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
  * Calling this function with cpu hotplug locks held can actually lead
  * to obscure indirect dependencies via WQ context.
  */
-void lru_add_drain_all(void)
+inline void __lru_add_drain_all(bool force_all_cpus)
 {
 	/*
 	 * lru_drain_gen - Global pages generation number
@@ -780,7 +792,7 @@ void lru_add_drain_all(void)
 	 * (C) Exit the draining operation if a newer generation, from another
 	 * lru_add_drain_all(), was already scheduled for draining. Check (A).
 	 */
-	if (unlikely(this_gen != lru_drain_gen))
+	if (unlikely(this_gen != lru_drain_gen && !force_all_cpus))
 		goto done;
 
 	/*
@@ -810,7 +822,8 @@ void lru_add_drain_all(void)
 	for_each_online_cpu(cpu) {
 		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
 
-		if (pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
+		if (force_all_cpus ||
+		    pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
 		    data_race(pagevec_count(&per_cpu(lru_rotate.pvec, cpu))) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
@@ -828,6 +841,11 @@ void lru_add_drain_all(void)
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
@@ -835,6 +853,34 @@ void lru_add_drain_all(void)
 }
 #endif /* CONFIG_SMP */
 
+atomic_t lru_disable_count = ATOMIC_INIT(0);
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
2.31.0.rc2.261.g7f71774620-goog

