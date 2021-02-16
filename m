Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFFC31CE9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 18:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhBPREk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 12:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhBPREg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:04:36 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9583C061574;
        Tue, 16 Feb 2021 09:03:54 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z15so6525493pfc.3;
        Tue, 16 Feb 2021 09:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JY/xjLys2p6Df/83yNvluuwt58vz7rso04y3aoxqnD8=;
        b=dWuiVyjzsHfoumFzHsotMyKdkUM5pYeGihMonK42WiCckLLntBKEMmSP0BCdjVXB53
         D8xlhFhXopKongDdMw7+1MhRmVmMvOG1RDMFOT5JkmkUizHVpuSjaT8q3DRrdAdPFsy/
         LtbuqoeEs6rbzREzx/FXC/5Jjx3T3N2dHPBKRonSvGaBeNW9aPiWeIDpQ8MElIUt92Ik
         iVOpA6ujExsUjxUtN+EF5KGtk2i1DGQxveeVCkUCJj/h1NKFk2FdOW3tXpDX1uQk4upi
         A78sCie8qvo4o3Yb6fbyhXOT9OdCFypXq5dl6xFKUlBIPK9pu/X4EKfhQXYJZxpK55cb
         GDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JY/xjLys2p6Df/83yNvluuwt58vz7rso04y3aoxqnD8=;
        b=VapCLtbSXzZoe/T8YrLMWNcOFKoLz4azHXJFMsgIZquNQ9Wtym9+zmWx5GUsm4dmcz
         QMjvgZqsSIve4BphXEujPZVmdJZZQGmwElvuFUlplkgS3Ha01edM1tJLDcJv4EppuW43
         mK+OA9Kepu0Lzja8/cYJ59e1gMxMZv6GvnP/Stsu0Xh4ki9TKsGgydHxGa84AbvwErqQ
         nxF6AyCJzQpHFK12zkrkSLMUgogV4dkuCFoZdhznEULKo600vERXZ3jSk+0gp+Fv8U50
         jEv5jYApi4EXFDzZZoUKtsQyQYq6YhK0lG2iK1TBfKvRCRuAWqsMNPEFWOE10NB1Bk/W
         AEFA==
X-Gm-Message-State: AOAM530z1Q/biUDJnHgJ8RwAqodz6xs98SEcXKI2BJ+/aYjlLtR97/PY
        6qekQ6ePG+GrCTSuWF7dTck=
X-Google-Smtp-Source: ABdhPJxN4hS40Q1KbiaUYSSXwZmevh2bhfAajbI7s3QAoqOTET5ECQ0rf6zq3rzvvHLKNJpYqSDdTg==
X-Received: by 2002:a65:6706:: with SMTP id u6mr19958722pgf.26.1613495034232;
        Tue, 16 Feb 2021 09:03:54 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:fc2a:a664:489d:d48f])
        by smtp.gmail.com with ESMTPSA id 143sm21876424pfw.3.2021.02.16.09.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 09:03:52 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        cgoldswo@codeaurora.org, linux-fsdevel@vger.kernel.org,
        willy@infradead.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, joaodias@google.com,
        Minchan Kim <minchan@kernel.org>
Subject: [RFC 1/2] mm: disable LRU pagevec during the migration temporarily
Date:   Tue, 16 Feb 2021 09:03:47 -0800
Message-Id: <20210216170348.1513483-1-minchan@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
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

The other concern is migration keeps retrying until pages in pagevec
are drained. During the time, migration repeatedly allocates target
page, unmap source page from page table of processes and then get to
know the failure, restore the original page to pagetable of processes,
free target page, which is also not good.

To solve the issue, this patch tries to close the race rather than
relying on retrial and luck. The idea is to introduce
migration-in-progress tracking count with introducing IPI barrier
after atomic updating the count to minimize read-side overhead.

The migrate_prep increases migrate_pending_count under the lock
and IPI call to guarantee every CPU see the uptodate value
of migrate_pending_count. Then, drain pagevec via lru_add_drain_all.
From now on, no LRU pages could reach pagevec since LRU handling
functions skips the batching if migration is in progress with checking
migrate_pedning(IOW, pagevec should be empty until migration is done).
Every migrate_prep's caller should call migrate_finish in pair to
decrease the migration tracking count.

With the migrate_pending, vulnerable places to make migration failure
could catch migration-in-progress and make their plan to help the
migration(e.g., bh_lru_install[1]) in future.

[1] https://lore.kernel.org/linux-mm/c083b0ab6e410e33ca880d639f90ef4f6f3b33ff.1613020616.git.cgoldswo@codeaurora.org/

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/migrate.h |  3 +++
 mm/mempolicy.c          |  6 +++++
 mm/migrate.c            | 55 ++++++++++++++++++++++++++++++++++++++---
 mm/page_alloc.c         |  3 +++
 mm/swap.c               | 24 +++++++++++++-----
 5 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3a389633b68f..047d5358fe0d 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -46,6 +46,8 @@ extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
 
 extern void migrate_prep(void);
+extern void migrate_finish(void);
+extern bool migrate_pending(void);
 extern void migrate_prep_local(void);
 extern void migrate_page_states(struct page *newpage, struct page *page);
 extern void migrate_page_copy(struct page *newpage, struct page *page);
@@ -67,6 +69,7 @@ static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	{ return -EBUSY; }
 
 static inline int migrate_prep(void) { return -ENOSYS; }
+static inline void migrate_finish(void) {}
 static inline int migrate_prep_local(void) { return -ENOSYS; }
 
 static inline void migrate_page_states(struct page *newpage, struct page *page)
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
index a69da8aaeccd..d70e113eee04 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -57,6 +57,22 @@
 
 #include "internal.h"
 
+static DEFINE_SPINLOCK(migrate_pending_lock);
+static unsigned long migrate_pending_count;
+static DEFINE_PER_CPU(struct work_struct, migrate_pending_work);
+
+static void read_migrate_pending(struct work_struct *work)
+{
+	/* TODO : not sure it's needed */
+	unsigned long dummy = __READ_ONCE(migrate_pending_count);
+	(void)dummy;
+}
+
+bool migrate_pending(void)
+{
+	return migrate_pending_count;
+}
+
 /*
  * migrate_prep() needs to be called before we start compiling a list of pages
  * to be migrated using isolate_lru_page(). If scheduling work on other CPUs is
@@ -64,11 +80,27 @@
  */
 void migrate_prep(void)
 {
+	unsigned int cpu;
+
+	spin_lock(&migrate_pending_lock);
+	migrate_pending_count++;
+	spin_unlock(&migrate_pending_lock);
+
+	for_each_online_cpu(cpu) {
+		struct work_struct *work = &per_cpu(migrate_pending_work, cpu);
+
+		INIT_WORK(work, read_migrate_pending);
+		queue_work_on(cpu, mm_percpu_wq, work);
+	}
+
+	for_each_online_cpu(cpu)
+		flush_work(&per_cpu(migrate_pending_work, cpu));
+	/*
+	 * From now on, every online cpu will see uptodate
+	 * migarte_pending_work.
+	 */
 	/*
 	 * Clear the LRU lists so pages can be isolated.
-	 * Note that pages may be moved off the LRU after we have
-	 * drained them. Those pages will fail to migrate like other
-	 * pages that may be busy.
 	 */
 	lru_add_drain_all();
 }
@@ -79,6 +111,22 @@ void migrate_prep_local(void)
 	lru_add_drain();
 }
 
+void migrate_finish(void)
+{
+	int cpu;
+
+	spin_lock(&migrate_pending_lock);
+	migrate_pending_count--;
+	spin_unlock(&migrate_pending_lock);
+
+	for_each_online_cpu(cpu) {
+		struct work_struct *work = &per_cpu(migrate_pending_work, cpu);
+
+		INIT_WORK(work, read_migrate_pending);
+		queue_work_on(cpu, mm_percpu_wq, work);
+	}
+}
+
 int isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
 	struct address_space *mapping;
@@ -1837,6 +1885,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	if (err >= 0)
 		err = err1;
 out:
+	migrate_finish();
 	return err;
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6446778cbc6b..e4cb959f64dc 100644
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
diff --git a/mm/swap.c b/mm/swap.c
index 31b844d4ed94..e42c4b4bf2b3 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -36,6 +36,7 @@
 #include <linux/hugetlb.h>
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
+#include <linux/migrate.h>
 
 #include "internal.h"
 
@@ -235,6 +236,17 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
 	}
 }
 
+/* return true if pagevec needs flush */
+static bool pagevec_add_and_need_flush(struct pagevec *pvec, struct page *page)
+{
+	bool ret = false;
+
+	if (!pagevec_add(pvec, page) || PageCompound(page) || migrate_pending())
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
-- 
2.30.0.478.g8a0d178c01-goog

