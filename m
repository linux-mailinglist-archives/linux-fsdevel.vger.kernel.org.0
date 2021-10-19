Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918E64331B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 11:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbhJSJEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 05:04:01 -0400
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:35341 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234929AbhJSJD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:03:56 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 7E0511C60E3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 10:01:39 +0100 (IST)
Received: (qmail 6109 invoked from network); 19 Oct 2021 09:01:39 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 19 Oct 2021 09:01:39 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     NeilBrown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/8] mm/vmscan: Throttle reclaim and compaction when too may pages are isolated
Date:   Tue, 19 Oct 2021 10:01:02 +0100
Message-Id: <20211019090108.25501-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019090108.25501-1-mgorman@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Page reclaim throttles on congestion if too many parallel reclaim instances
have isolated too many pages. This makes no sense, excessive parallelisation
has nothing to do with writeback or congestion.

This patch creates an additional workqueue to sleep on when too many
pages are isolated. The throttled tasks are woken when the number
of isolated pages is reduced or a timeout occurs. There may be
some false positive wakeups for GFP_NOIO/GFP_NOFS callers but
the tasks will throttle again if necessary.

[shy828301@gmail.com: Wake up from compaction context]
[vbabka@suse.cz: Account number of throttled tasks only for writeback]
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mmzone.h        |  6 ++++--
 include/trace/events/vmscan.h |  4 +++-
 mm/compaction.c               | 10 ++++++++--
 mm/internal.h                 | 13 ++++++++++++-
 mm/page_alloc.c               |  6 +++++-
 mm/vmscan.c                   | 28 +++++++++++++++++++---------
 6 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ef0a63ebd21d..58a25d42c31c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -275,6 +275,8 @@ enum lru_list {
 
 enum vmscan_throttle_state {
 	VMSCAN_THROTTLE_WRITEBACK,
+	VMSCAN_THROTTLE_ISOLATED,
+	NR_VMSCAN_THROTTLE,
 };
 
 #define for_each_lru(lru) for (lru = 0; lru < NR_LRU_LISTS; lru++)
@@ -846,8 +848,8 @@ typedef struct pglist_data {
 	int node_id;
 	wait_queue_head_t kswapd_wait;
 	wait_queue_head_t pfmemalloc_wait;
-	wait_queue_head_t reclaim_wait;	/* wq for throttling reclaim */
-	atomic_t nr_reclaim_throttled;	/* nr of throtted tasks */
+	wait_queue_head_t reclaim_wait[NR_VMSCAN_THROTTLE];
+	atomic_t nr_writeback_throttled;/* nr of writeback-throttled tasks */
 	unsigned long nr_reclaim_start;	/* nr pages written while throttled
 					 * when throttling started. */
 	struct task_struct *kswapd;	/* Protected by
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index c317f9fe0d17..d4905bd9e9c4 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -28,10 +28,12 @@
 		) : "RECLAIM_WB_NONE"
 
 #define _VMSCAN_THROTTLE_WRITEBACK	(1 << VMSCAN_THROTTLE_WRITEBACK)
+#define _VMSCAN_THROTTLE_ISOLATED	(1 << VMSCAN_THROTTLE_ISOLATED)
 
 #define show_throttle_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",					\
-		{_VMSCAN_THROTTLE_WRITEBACK,	"VMSCAN_THROTTLE_WRITEBACK"}	\
+		{_VMSCAN_THROTTLE_WRITEBACK,	"VMSCAN_THROTTLE_WRITEBACK"},	\
+		{_VMSCAN_THROTTLE_ISOLATED,	"VMSCAN_THROTTLE_ISOLATED"}	\
 		) : "VMSCAN_THROTTLE_NONE"
 
 
diff --git a/mm/compaction.c b/mm/compaction.c
index bfc93da1c2c7..7359093d8ac0 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -761,6 +761,8 @@ isolate_freepages_range(struct compact_control *cc,
 /* Similar to reclaim, but different enough that they don't share logic */
 static bool too_many_isolated(pg_data_t *pgdat)
 {
+	bool too_many;
+
 	unsigned long active, inactive, isolated;
 
 	inactive = node_page_state(pgdat, NR_INACTIVE_FILE) +
@@ -770,7 +772,11 @@ static bool too_many_isolated(pg_data_t *pgdat)
 	isolated = node_page_state(pgdat, NR_ISOLATED_FILE) +
 			node_page_state(pgdat, NR_ISOLATED_ANON);
 
-	return isolated > (inactive + active) / 2;
+	too_many = isolated > (inactive + active) / 2;
+	if (!too_many)
+		wake_throttle_isolated(pgdat);
+
+	return too_many;
 }
 
 /**
@@ -822,7 +828,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (cc->mode == MIGRATE_ASYNC)
 			return -EAGAIN;
 
-		congestion_wait(BLK_RW_ASYNC, HZ/10);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED, HZ/10);
 
 		if (fatal_signal_pending(current))
 			return -EINTR;
diff --git a/mm/internal.h b/mm/internal.h
index 90764d646e02..3461a1055975 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -39,12 +39,21 @@ void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page,
 static inline void acct_reclaim_writeback(struct page *page)
 {
 	pg_data_t *pgdat = page_pgdat(page);
-	int nr_throttled = atomic_read(&pgdat->nr_reclaim_throttled);
+	int nr_throttled = atomic_read(&pgdat->nr_writeback_throttled);
 
 	if (nr_throttled)
 		__acct_reclaim_writeback(pgdat, page, nr_throttled);
 }
 
+static inline void wake_throttle_isolated(pg_data_t *pgdat)
+{
+	wait_queue_head_t *wqh;
+
+	wqh = &pgdat->reclaim_wait[VMSCAN_THROTTLE_ISOLATED];
+	if (waitqueue_active(wqh))
+		wake_up_all(wqh);
+}
+
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
@@ -120,6 +129,8 @@ extern unsigned long highest_memmap_pfn;
  */
 extern int isolate_lru_page(struct page *page);
 extern void putback_lru_page(struct page *page);
+extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
+								long timeout);
 
 /*
  * in mm/rmap.c:
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d849ddfc1e51..78e538067651 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7389,6 +7389,8 @@ static void pgdat_init_kcompactd(struct pglist_data *pgdat) {}
 
 static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 {
+	int i;
+
 	pgdat_resize_init(pgdat);
 
 	pgdat_init_split_queue(pgdat);
@@ -7396,7 +7398,9 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 
 	init_waitqueue_head(&pgdat->kswapd_wait);
 	init_waitqueue_head(&pgdat->pfmemalloc_wait);
-	init_waitqueue_head(&pgdat->reclaim_wait);
+
+	for (i = 0; i < NR_VMSCAN_THROTTLE; i++)
+		init_waitqueue_head(&pgdat->reclaim_wait[i]);
 
 	pgdat_page_ext_init(pgdat);
 	lruvec_init(&pgdat->__lruvec);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 735b1f2b5d9e..29434d4fc1c7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1006,12 +1006,12 @@ static void handle_write_error(struct address_space *mapping,
 	unlock_page(page);
 }
 
-static void
-reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
+void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
 							long timeout)
 {
-	wait_queue_head_t *wqh = &pgdat->reclaim_wait;
+	wait_queue_head_t *wqh = &pgdat->reclaim_wait[reason];
 	long ret;
+	bool acct_writeback = (reason == VMSCAN_THROTTLE_WRITEBACK);
 	DEFINE_WAIT(wait);
 
 	/*
@@ -1023,7 +1023,8 @@ reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
 	    current->flags & (PF_IO_WORKER|PF_KTHREAD))
 		return;
 
-	if (atomic_inc_return(&pgdat->nr_reclaim_throttled) == 1) {
+	if (acct_writeback &&
+	    atomic_inc_return(&pgdat->nr_writeback_throttled) == 1) {
 		WRITE_ONCE(pgdat->nr_reclaim_start,
 			node_page_state(pgdat, NR_THROTTLED_WRITTEN));
 	}
@@ -1031,7 +1032,9 @@ reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
 	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
 	ret = schedule_timeout(timeout);
 	finish_wait(wqh, &wait);
-	atomic_dec(&pgdat->nr_reclaim_throttled);
+
+	if (acct_writeback)
+		atomic_dec(&pgdat->nr_writeback_throttled);
 
 	trace_mm_vmscan_throttled(pgdat->node_id, jiffies_to_usecs(timeout),
 				jiffies_to_usecs(timeout - ret),
@@ -1061,7 +1064,7 @@ void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page,
 		READ_ONCE(pgdat->nr_reclaim_start);
 
 	if (nr_written > SWAP_CLUSTER_MAX * nr_throttled)
-		wake_up_all(&pgdat->reclaim_wait);
+		wake_up_all(&pgdat->reclaim_wait[VMSCAN_THROTTLE_WRITEBACK]);
 }
 
 /* possible outcome of pageout() */
@@ -2176,6 +2179,7 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
 		struct scan_control *sc)
 {
 	unsigned long inactive, isolated;
+	bool too_many;
 
 	if (current_is_kswapd())
 		return 0;
@@ -2199,7 +2203,13 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
 	if ((sc->gfp_mask & (__GFP_IO | __GFP_FS)) == (__GFP_IO | __GFP_FS))
 		inactive >>= 3;
 
-	return isolated > inactive;
+	too_many = isolated > inactive;
+
+	/* Wake up tasks throttled due to too_many_isolated. */
+	if (!too_many)
+		wake_throttle_isolated(pgdat);
+
+	return too_many;
 }
 
 /*
@@ -2308,8 +2318,8 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 			return 0;
 
 		/* wait a bit for the reclaimer. */
-		msleep(100);
 		stalled = true;
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED, HZ/10);
 
 		/* We are about to die and free our memory. Return now. */
 		if (fatal_signal_pending(current))
@@ -4343,7 +4353,7 @@ static int kswapd(void *p)
 
 	WRITE_ONCE(pgdat->kswapd_order, 0);
 	WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
-	atomic_set(&pgdat->nr_reclaim_throttled, 0);
+	atomic_set(&pgdat->nr_writeback_throttled, 0);
 	for ( ; ; ) {
 		bool ret;
 
-- 
2.31.1

