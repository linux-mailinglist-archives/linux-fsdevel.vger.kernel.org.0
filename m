Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1F5331E41
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 06:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhCIFQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 00:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhCIFQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 00:16:34 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01FCC06174A;
        Mon,  8 Mar 2021 21:16:33 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso4508636pjb.4;
        Mon, 08 Mar 2021 21:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4V4MZz42xx1VLoP7TP10uY71kWCxhoB48xeGZheZ9nc=;
        b=tfxsVUrwWlUxMEfunHfoS0YSUrrnZDVA/XHNPDt1qz70CQKD4qKdBIZkPVzK7/JhrA
         YRBkYB8/2QBcOZUnUOg8MSY1TGxjp4SYtDSJ4+IhbsxYHhVGE7uGN2V/DDSdiZhm0708
         /45j/oYpq//uFU8V9iwvT2BXQR5cdDCO7UfjV7kxhNCUVDVLiY5e58/PZAVQtT0kYYVL
         y8qkjg7i0s+lYW040l6+DR0RhYMV4lOXnuKNCCN/iQMQhGVdqmH3BTjwnElojoc15CFc
         N8cgJmwvyZLLKSkM2u9WDum1SH8Y3L2kMsdJe9KjtKsrytWxyk6P5kmjW22uVoRYyaBT
         Kahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=4V4MZz42xx1VLoP7TP10uY71kWCxhoB48xeGZheZ9nc=;
        b=EWlgH+0XZ1OUkq5M727+3vbCSA/QbAWvfHobCIqDeqDzPO3HpnZTts8He4EXpWGYZ3
         yyI/K0EftkSfUjF7Bzyenw7aerUM/3Z+q7bDZabMG4s+RvvREjBUW8g4m+zW3kcml/rl
         oHhUq3lWQEZYAD8tZvCkHU5fP9IcU2In75IMqEq5FHVu8JmWYfL9BAplf6tvM5Ad1IBp
         1j5M/4Q05Xn3tLJbrNpq5jGehRZO9R7+eac4m3q19GR4v4NoRrveugEcWdSuk4yEL3cv
         pAjRaijMjvkAwWSe8jd8A6J96Pgl7ydX4P7fW8WKYSky7neJSHQ7QYYTSNGsyb77mo6k
         9FOw==
X-Gm-Message-State: AOAM533tI6VNehSZltRDmAUe5ivQDSeTTwltf9zA4G4mpqTHh+0iB0rt
        +iH9kwu1iw8QTH4C9BShdbo=
X-Google-Smtp-Source: ABdhPJxQqdUv5sskQWjEWKWv529xmH6AU0zMc288xT3dmzwNiQT0O5UbGGP0L8x0CteBeZxnu9ssHQ==
X-Received: by 2002:a17:902:9897:b029:e6:3e0a:b44a with SMTP id s23-20020a1709029897b02900e63e0ab44amr2315268plp.30.1615266993403;
        Mon, 08 Mar 2021 21:16:33 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:4ccc:acdd:25da:14d1])
        by smtp.gmail.com with ESMTPSA id b14sm1166576pji.14.2021.03.08.21.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 21:16:32 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 1/2] mm: disable LRU pagevec during the migration temporarily
Date:   Mon,  8 Mar 2021 21:16:27 -0800
Message-Id: <20210309051628.3105973-1-minchan@kernel.org>
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

It would be also useful for memory-hotplug.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* from v1 - https://lore.kernel.org/lkml/20210302210949.2440120-1-minchan@kernel.org/
  * introduce __lru_add_drain_all to minimize changes - mhocko
  * use lru_cache_disable for memory-hotplug
  * schedule for every cpu at force_all_cpus

* from RFC - http://lore.kernel.org/linux-mm/20210216170348.1513483-1-minchan@kernel.org
  * use atomic and lru_add_drain_all for strict ordering - mhocko
  * lru_cache_disable/enable - mhocko

 include/linux/migrate.h |  6 ++-
 include/linux/swap.h    |  2 +
 mm/memory_hotplug.c     |  3 +-
 mm/mempolicy.c          |  6 +++
 mm/migrate.c            | 13 ++++---
 mm/page_alloc.c         |  3 ++
 mm/swap.c               | 82 +++++++++++++++++++++++++++++++++--------
 7 files changed, 91 insertions(+), 24 deletions(-)

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
index 71166bc10d17..aaa6b9cc3f8a 100644
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
index a969463bdda4..9a5af00802f9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1571,6 +1571,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	 * in a way that pages from isolated pageblock are left on pcplists.
 	 */
 	zone_pcp_disable(zone);
+	lru_cache_disable();
 
 	/* set above range as isolated */
 	ret = start_isolate_page_range(start_pfn, end_pfn,
@@ -1602,7 +1603,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 			}
 
 			cond_resched();
-			lru_add_drain_all();
 
 			ret = scan_movable_pages(pfn, end_pfn, &pfn);
 			if (!ret) {
@@ -1647,6 +1647,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
 	spin_unlock_irqrestore(&zone->lock, flags);
 
+	lru_cache_enable();
 	zone_pcp_enable(zone);
 
 	/* removal success */
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
index a69da8aaeccd..3de67c5f70bc 100644
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
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9811663fcf0b..6c0b5c6a4779 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8491,6 +8491,9 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
 				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
 	}
+
+	migrate_finish();
+
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
 		return ret;
diff --git a/mm/swap.c b/mm/swap.c
index 31b844d4ed94..fc8acccb882b 100644
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
@@ -728,14 +740,7 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
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
@@ -780,7 +785,7 @@ void lru_add_drain_all(void)
 	 * (C) Exit the draining operation if a newer generation, from another
 	 * lru_add_drain_all(), was already scheduled for draining. Check (A).
 	 */
-	if (unlikely(this_gen != lru_drain_gen))
+	if (unlikely(this_gen != lru_drain_gen && !force_all_cpus))
 		goto done;
 
 	/*
@@ -810,7 +815,8 @@ void lru_add_drain_all(void)
 	for_each_online_cpu(cpu) {
 		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
 
-		if (pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
+		if (force_all_cpus ||
+		    pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
 		    data_race(pagevec_count(&per_cpu(lru_rotate.pvec, cpu))) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
@@ -828,6 +834,18 @@ void lru_add_drain_all(void)
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
@@ -835,6 +853,38 @@ void lru_add_drain_all(void)
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
2.30.1.766.gb4fecdf3b7-goog

