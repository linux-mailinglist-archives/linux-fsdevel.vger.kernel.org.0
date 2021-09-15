Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36AD40C7A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbhIOOqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 10:46:04 -0400
Received: from outbound-smtp33.blacknight.com ([81.17.249.66]:59827 "EHLO
        outbound-smtp33.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233745AbhIOOqE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:46:04 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Sep 2021 10:46:03 EDT
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp33.blacknight.com (Postfix) with ESMTPS id A1F1DBAC82
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 15:35:12 +0100 (IST)
Received: (qmail 964 invoked from network); 15 Sep 2021 14:35:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Sep 2021 14:35:12 -0000
Date:   Wed, 15 Sep 2021 15:35:10 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Chinner <david@fromorbit.com>
Cc:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] EXT4: Remove ENOMEM/congestion_wait() loops.
Message-ID: <20210915143510.GE3959@techsingularity.net>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838437.13293.14244628630141187199.stgit@noble.brown>
 <20210914163432.GR3828@suse.com>
 <20210914235535.GL2361455@dread.disaster.area>
 <20210915085904.GU3828@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210915085904.GU3828@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 09:59:04AM +0100, Mel Gorman wrote:
> > Yup, that's what we need, but I don't see why it needs to be exposed
> > outside the allocation code at all.
> > 
> 
> Probably not. At least some of it could be contained within reclaim
> itself to block when reclaim is not making progress as opposed to anything
> congestion related. That might still livelock if no progress can be made
> but that's not new, the OOM hammer should eventually kick in.
> 

There are two sides to the reclaim-related throttling

1. throttling because zero progress is being made
2. throttling because there are too many dirty pages or pages under
   writeback cycling through the LRU too quickly.

The dirty page aspects (and the removal of wait_iff_congested which is
almost completely broken) could be done with something like the following
(completly untested). The downside is that end_page_writeback() takes an
atomic penalty if reclaim is throttled but at that point the system is
struggling anyway so I doubt it matters.

--8<--
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
index 6a1d79d84675..5a289ada48cb 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -841,6 +841,9 @@ typedef struct pglist_data {
 	int node_id;
 	wait_queue_head_t kswapd_wait;
 	wait_queue_head_t pfmemalloc_wait;
+	wait_queue_head_t reclaim_wait;	/* wq for throttling reclaim */
+	atomic_t nr_reclaim_throttled;	/* nr of throtted tasks */
+	atomic_t nr_reclaim_written;	/* nr pages written since throttled */
 	struct task_struct *kswapd;	/* Protected by
 					   mem_hotplug_begin/end() */
 	int kswapd_order;
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
index dae481293b5d..b9be9afa4308 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1606,6 +1606,8 @@ void end_page_writeback(struct page *page)
 	smp_mb__after_atomic();
 	wake_up_page(page, PG_writeback);
 	put_page(page);
+
+	acct_reclaim_writeback(page);
 }
 EXPORT_SYMBOL(end_page_writeback);
 
diff --git a/mm/internal.h b/mm/internal.h
index cf3cb933eba3..47e77009e0d5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -34,6 +34,13 @@
 
 void page_writeback_init(void);
 
+void __acct_reclaim_writeback(struct page *page);
+static inline void acct_reclaim_writeback(struct page *page)
+{
+	if (atomic_read(&page_pgdat(page)->nr_reclaim_throttled))
+		__acct_reclaim_writeback(page);
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
index 74296c2d1fed..b209564766b0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1006,6 +1006,40 @@ static void handle_write_error(struct address_space *mapping,
 	unlock_page(page);
 }
 
+static void
+reclaim_writeback_throttle(pg_data_t *pgdat, long timeout)
+{
+	wait_queue_head_t *wqh = &pgdat->reclaim_wait;
+	long ret;
+	DEFINE_WAIT(wait);
+
+	atomic_inc(&pgdat->nr_reclaim_throttled);
+
+	prepare_to_wait(wqh, &wait, TASK_INTERRUPTIBLE);
+	ret = schedule_timeout(timeout);
+	finish_wait(&pgdat->reclaim_wait, &wait);
+
+	if (atomic_dec_and_test(&pgdat->nr_reclaim_throttled))
+		atomic_set(&pgdat->nr_reclaim_written, 0);
+
+	/* TODO: Add tracepoint to track time sleeping */
+}
+
+/*
+ * Account for pages written if tasks are throttled waiting on dirty
+ * pages to clean. If enough pages have been cleaned since throttling
+ * started then wakeup the throttled tasks.
+ */
+void __acct_reclaim_writeback(struct page *page)
+{
+	pg_data_t *pgdat = page_pgdat(page);
+	int nr_written = atomic_inc_return(&pgdat->nr_reclaim_written);
+	int nr_throttled = atomic_read(&pgdat->nr_reclaim_throttled);
+
+	if (nr_written > SWAP_CLUSTER_MAX * nr_throttled)
+		wake_up_interruptible(&pgdat->reclaim_wait);
+}
+
 /* possible outcome of pageout() */
 typedef enum {
 	/* failed to write page out, page is locked */
@@ -1412,9 +1446,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 
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
@@ -3180,19 +3213,20 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		 * If kswapd scans pages marked for immediate
 		 * reclaim and under writeback (nr_immediate), it
 		 * implies that pages are cycling through the LRU
-		 * faster than they are written so also forcibly stall.
+		 * faster than they are written so forcibly stall
+		 * until some pages complete writeback.
 		 */
 		if (sc->nr.immediate)
-			congestion_wait(BLK_RW_ASYNC, HZ/10);
+			reclaim_writeback_throttle(pgdat, HZ/10);
 	}
 
 	/*
 	 * Tag a node/memcg as congested if all the dirty pages
 	 * scanned were backed by a congested BDI and
-	 * wait_iff_congested will stall.
+	 * non-kswapd tasks will stall on reclaim_writeback_throttle.
 	 *
 	 * Legacy memcg will stall in page writeback so avoid forcibly
-	 * stalling in wait_iff_congested().
+	 * stalling in reclaim_writeback_throttle().
 	 */
 	if ((current_is_kswapd() ||
 	     (cgroup_reclaim(sc) && writeback_throttling_sane(sc))) &&
@@ -3208,7 +3242,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	if (!current_is_kswapd() && current_may_throttle() &&
 	    !sc->hibernation_mode &&
 	    test_bit(LRUVEC_CONGESTED, &target_lruvec->flags))
-		wait_iff_congested(BLK_RW_ASYNC, HZ/10);
+		reclaim_writeback_throttle(pgdat, HZ/10);
 
 	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
 				    sc))
@@ -4286,6 +4320,8 @@ static int kswapd(void *p)
 
 	WRITE_ONCE(pgdat->kswapd_order, 0);
 	WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
+	atomic_set(&pgdat->nr_reclaim_throttled, 0);
+	atomic_set(&pgdat->nr_reclaim_written, 0);
 	for ( ; ; ) {
 		bool ret;
 
