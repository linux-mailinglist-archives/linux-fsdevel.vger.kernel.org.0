Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8434E4331B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 11:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhJSJDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 05:03:43 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:41635 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234840AbhJSJDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:03:42 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 292A918E206
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 10:01:29 +0100 (IST)
Received: (qmail 5454 invoked from network); 19 Oct 2021 09:01:28 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 19 Oct 2021 09:01:28 -0000
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
Subject: [PATCH 1/8] mm/vmscan: Throttle reclaim until some writeback completes if congested
Date:   Tue, 19 Oct 2021 10:01:01 +0100
Message-Id: <20211019090108.25501-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019090108.25501-1-mgorman@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Page reclaim throttles on wait_iff_congested under the following conditions

o kswapd is encountering pages under writeback and marked for immediate
  reclaim implying that pages are cycling through the LRU faster than
  pages can be cleaned.

o Direct reclaim will stall if all dirty pages are backed by congested
  inodes.

wait_iff_congested is almost completely broken with few exceptions. This
patch adds a new node-based workqueue and tracks the number of throttled
tasks and pages written back since throttling started. If enough pages
belonging to the node are written back then the throttled tasks will wake
early. If not, the throttled tasks sleeps until the timeout expires.

[neilb@suse.de: Uninterruptible sleep and simpler wakeups]
[hdanton@sina.com: Avoid race when reclaim starts]
[vbabka@suse.cz: vmstat irq-safe api, clarifications]
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/backing-dev.h      |  1 -
 include/linux/mmzone.h           |  9 ++++
 include/trace/events/vmscan.h    | 34 +++++++++++++
 include/trace/events/writeback.h |  7 ---
 mm/backing-dev.c                 | 48 -------------------
 mm/filemap.c                     |  1 +
 mm/internal.h                    | 11 +++++
 mm/page_alloc.c                  |  1 +
 mm/vmscan.c                      | 82 +++++++++++++++++++++++++++-----
 mm/vmstat.c                      |  1 +
 10 files changed, 127 insertions(+), 68 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index ac7f231b8825..9fb1f0ae273c 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -154,7 +154,6 @@ static inline int wb_congested(struct bdi_writeback *wb, int cong_bits)
 }
 
 long congestion_wait(int sync, long timeout);
-long wait_iff_congested(int sync, long timeout);
 
 static inline bool mapping_can_writeback(struct address_space *mapping)
 {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 6a1d79d84675..ef0a63ebd21d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -199,6 +199,7 @@ enum node_stat_item {
 	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
 	NR_DIRTIED,		/* page dirtyings since bootup */
 	NR_WRITTEN,		/* page writings since bootup */
+	NR_THROTTLED_WRITTEN,	/* NR_WRITTEN while reclaim throttled */
 	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
 	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
 	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
@@ -272,6 +273,10 @@ enum lru_list {
 	NR_LRU_LISTS
 };
 
+enum vmscan_throttle_state {
+	VMSCAN_THROTTLE_WRITEBACK,
+};
+
 #define for_each_lru(lru) for (lru = 0; lru < NR_LRU_LISTS; lru++)
 
 #define for_each_evictable_lru(lru) for (lru = 0; lru <= LRU_ACTIVE_FILE; lru++)
@@ -841,6 +846,10 @@ typedef struct pglist_data {
 	int node_id;
 	wait_queue_head_t kswapd_wait;
 	wait_queue_head_t pfmemalloc_wait;
+	wait_queue_head_t reclaim_wait;	/* wq for throttling reclaim */
+	atomic_t nr_reclaim_throttled;	/* nr of throtted tasks */
+	unsigned long nr_reclaim_start;	/* nr pages written while throttled
+					 * when throttling started. */
 	struct task_struct *kswapd;	/* Protected by
 					   mem_hotplug_begin/end() */
 	int kswapd_order;
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 88faf2400ec2..c317f9fe0d17 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -27,6 +27,14 @@
 		{RECLAIM_WB_ASYNC,	"RECLAIM_WB_ASYNC"}	\
 		) : "RECLAIM_WB_NONE"
 
+#define _VMSCAN_THROTTLE_WRITEBACK	(1 << VMSCAN_THROTTLE_WRITEBACK)
+
+#define show_throttle_flags(flags)						\
+	(flags) ? __print_flags(flags, "|",					\
+		{_VMSCAN_THROTTLE_WRITEBACK,	"VMSCAN_THROTTLE_WRITEBACK"}	\
+		) : "VMSCAN_THROTTLE_NONE"
+
+
 #define trace_reclaim_flags(file) ( \
 	(file ? RECLAIM_WB_FILE : RECLAIM_WB_ANON) | \
 	(RECLAIM_WB_ASYNC) \
@@ -454,6 +462,32 @@ DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_node_reclaim_end,
 	TP_ARGS(nr_reclaimed)
 );
 
+TRACE_EVENT(mm_vmscan_throttled,
+
+	TP_PROTO(int nid, int usec_timeout, int usec_delayed, int reason),
+
+	TP_ARGS(nid, usec_timeout, usec_delayed, reason),
+
+	TP_STRUCT__entry(
+		__field(int, nid)
+		__field(int, usec_timeout)
+		__field(int, usec_delayed)
+		__field(int, reason)
+	),
+
+	TP_fast_assign(
+		__entry->nid = nid;
+		__entry->usec_timeout = usec_timeout;
+		__entry->usec_delayed = usec_delayed;
+		__entry->reason = 1U << reason;
+	),
+
+	TP_printk("nid=%d usec_timeout=%d usect_delayed=%d reason=%s",
+		__entry->nid,
+		__entry->usec_timeout,
+		__entry->usec_delayed,
+		show_throttle_flags(__entry->reason))
+);
 #endif /* _TRACE_VMSCAN_H */
 
 /* This part must be outside protection */
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 840d1ba84cf5..3bc759b81897 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -763,13 +763,6 @@ DEFINE_EVENT(writeback_congest_waited_template, writeback_congestion_wait,
 	TP_ARGS(usec_timeout, usec_delayed)
 );
 
-DEFINE_EVENT(writeback_congest_waited_template, writeback_wait_iff_congested,
-
-	TP_PROTO(unsigned int usec_timeout, unsigned int usec_delayed),
-
-	TP_ARGS(usec_timeout, usec_delayed)
-);
-
 DECLARE_EVENT_CLASS(writeback_single_inode_template,
 
 	TP_PROTO(struct inode *inode,
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 4a9d4e27d0d9..0ea1a105eae5 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1041,51 +1041,3 @@ long congestion_wait(int sync, long timeout)
 	return ret;
 }
 EXPORT_SYMBOL(congestion_wait);
-
-/**
- * wait_iff_congested - Conditionally wait for a backing_dev to become uncongested or a pgdat to complete writes
- * @sync: SYNC or ASYNC IO
- * @timeout: timeout in jiffies
- *
- * In the event of a congested backing_dev (any backing_dev) this waits
- * for up to @timeout jiffies for either a BDI to exit congestion of the
- * given @sync queue or a write to complete.
- *
- * The return value is 0 if the sleep is for the full timeout. Otherwise,
- * it is the number of jiffies that were still remaining when the function
- * returned. return_value == timeout implies the function did not sleep.
- */
-long wait_iff_congested(int sync, long timeout)
-{
-	long ret;
-	unsigned long start = jiffies;
-	DEFINE_WAIT(wait);
-	wait_queue_head_t *wqh = &congestion_wqh[sync];
-
-	/*
-	 * If there is no congestion, yield if necessary instead
-	 * of sleeping on the congestion queue
-	 */
-	if (atomic_read(&nr_wb_congested[sync]) == 0) {
-		cond_resched();
-
-		/* In case we scheduled, work out time remaining */
-		ret = timeout - (jiffies - start);
-		if (ret < 0)
-			ret = 0;
-
-		goto out;
-	}
-
-	/* Sleep until uncongested or a write happens */
-	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
-	ret = io_schedule_timeout(timeout);
-	finish_wait(wqh, &wait);
-
-out:
-	trace_writeback_wait_iff_congested(jiffies_to_usecs(timeout),
-					jiffies_to_usecs(jiffies - start));
-
-	return ret;
-}
-EXPORT_SYMBOL(wait_iff_congested);
diff --git a/mm/filemap.c b/mm/filemap.c
index dae481293b5d..59187787fbfc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1605,6 +1605,7 @@ void end_page_writeback(struct page *page)
 
 	smp_mb__after_atomic();
 	wake_up_page(page, PG_writeback);
+	acct_reclaim_writeback(page);
 	put_page(page);
 }
 EXPORT_SYMBOL(end_page_writeback);
diff --git a/mm/internal.h b/mm/internal.h
index cf3cb933eba3..90764d646e02 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -34,6 +34,17 @@
 
 void page_writeback_init(void);
 
+void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page,
+						int nr_throttled);
+static inline void acct_reclaim_writeback(struct page *page)
+{
+	pg_data_t *pgdat = page_pgdat(page);
+	int nr_throttled = atomic_read(&pgdat->nr_reclaim_throttled);
+
+	if (nr_throttled)
+		__acct_reclaim_writeback(pgdat, page, nr_throttled);
+}
+
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf..d849ddfc1e51 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7396,6 +7396,7 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 
 	init_waitqueue_head(&pgdat->kswapd_wait);
 	init_waitqueue_head(&pgdat->pfmemalloc_wait);
+	init_waitqueue_head(&pgdat->reclaim_wait);
 
 	pgdat_page_ext_init(pgdat);
 	lruvec_init(&pgdat->__lruvec);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 74296c2d1fed..735b1f2b5d9e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1006,6 +1006,64 @@ static void handle_write_error(struct address_space *mapping,
 	unlock_page(page);
 }
 
+static void
+reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
+							long timeout)
+{
+	wait_queue_head_t *wqh = &pgdat->reclaim_wait;
+	long ret;
+	DEFINE_WAIT(wait);
+
+	/*
+	 * Do not throttle IO workers, kthreads other than kswapd or
+	 * workqueues. They may be required for reclaim to make
+	 * forward progress (e.g. journalling workqueues or kthreads).
+	 */
+	if (!current_is_kswapd() &&
+	    current->flags & (PF_IO_WORKER|PF_KTHREAD))
+		return;
+
+	if (atomic_inc_return(&pgdat->nr_reclaim_throttled) == 1) {
+		WRITE_ONCE(pgdat->nr_reclaim_start,
+			node_page_state(pgdat, NR_THROTTLED_WRITTEN));
+	}
+
+	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+	ret = schedule_timeout(timeout);
+	finish_wait(wqh, &wait);
+	atomic_dec(&pgdat->nr_reclaim_throttled);
+
+	trace_mm_vmscan_throttled(pgdat->node_id, jiffies_to_usecs(timeout),
+				jiffies_to_usecs(timeout - ret),
+				reason);
+}
+
+/*
+ * Account for pages written if tasks are throttled waiting on dirty
+ * pages to clean. If enough pages have been cleaned since throttling
+ * started then wakeup the throttled tasks.
+ */
+void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page,
+							int nr_throttled)
+{
+	unsigned long nr_written;
+
+	inc_node_page_state(page, NR_THROTTLED_WRITTEN);
+
+	/*
+	 * This is an inaccurate read as the per-cpu deltas may not
+	 * be synchronised. However, given that the system is
+	 * writeback throttled, it is not worth taking the penalty
+	 * of getting an accurate count. At worst, the throttle
+	 * timeout guarantees forward progress.
+	 */
+	nr_written = node_page_state(pgdat, NR_THROTTLED_WRITTEN) -
+		READ_ONCE(pgdat->nr_reclaim_start);
+
+	if (nr_written > SWAP_CLUSTER_MAX * nr_throttled)
+		wake_up_all(&pgdat->reclaim_wait);
+}
+
 /* possible outcome of pageout() */
 typedef enum {
 	/* failed to write page out, page is locked */
@@ -1412,9 +1470,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 
 		/*
 		 * The number of dirty pages determines if a node is marked
-		 * reclaim_congested which affects wait_iff_congested. kswapd
-		 * will stall and start writing pages if the tail of the LRU
-		 * is all dirty unqueued pages.
+		 * reclaim_congested. kswapd will stall and start writing
+		 * pages if the tail of the LRU is all dirty unqueued pages.
 		 */
 		page_check_dirty_writeback(page, &dirty, &writeback);
 		if (dirty || writeback)
@@ -3180,19 +3237,19 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		 * If kswapd scans pages marked for immediate
 		 * reclaim and under writeback (nr_immediate), it
 		 * implies that pages are cycling through the LRU
-		 * faster than they are written so also forcibly stall.
+		 * faster than they are written so forcibly stall
+		 * until some pages complete writeback.
 		 */
 		if (sc->nr.immediate)
-			congestion_wait(BLK_RW_ASYNC, HZ/10);
+			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK, HZ/10);
 	}
 
 	/*
-	 * Tag a node/memcg as congested if all the dirty pages
-	 * scanned were backed by a congested BDI and
-	 * wait_iff_congested will stall.
+	 * Tag a node/memcg as congested if all the dirty pages were marked
+	 * for writeback and immediate reclaim (counted in nr.congested).
 	 *
 	 * Legacy memcg will stall in page writeback so avoid forcibly
-	 * stalling in wait_iff_congested().
+	 * stalling in reclaim_throttle().
 	 */
 	if ((current_is_kswapd() ||
 	     (cgroup_reclaim(sc) && writeback_throttling_sane(sc))) &&
@@ -3200,15 +3257,15 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		set_bit(LRUVEC_CONGESTED, &target_lruvec->flags);
 
 	/*
-	 * Stall direct reclaim for IO completions if underlying BDIs
-	 * and node is congested. Allow kswapd to continue until it
+	 * Stall direct reclaim for IO completions if the lruvec is
+	 * node is congested. Allow kswapd to continue until it
 	 * starts encountering unqueued dirty pages or cycling through
 	 * the LRU too quickly.
 	 */
 	if (!current_is_kswapd() && current_may_throttle() &&
 	    !sc->hibernation_mode &&
 	    test_bit(LRUVEC_CONGESTED, &target_lruvec->flags))
-		wait_iff_congested(BLK_RW_ASYNC, HZ/10);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK, HZ/10);
 
 	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
 				    sc))
@@ -4286,6 +4343,7 @@ static int kswapd(void *p)
 
 	WRITE_ONCE(pgdat->kswapd_order, 0);
 	WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
+	atomic_set(&pgdat->nr_reclaim_throttled, 0);
 	for ( ; ; ) {
 		bool ret;
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8ce2620344b2..9b2bc9d61d4b 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1225,6 +1225,7 @@ const char * const vmstat_text[] = {
 	"nr_vmscan_immediate_reclaim",
 	"nr_dirtied",
 	"nr_written",
+	"nr_throttled_written",
 	"nr_kernel_misc_reclaimable",
 	"nr_foll_pin_acquired",
 	"nr_foll_pin_released",
-- 
2.31.1

