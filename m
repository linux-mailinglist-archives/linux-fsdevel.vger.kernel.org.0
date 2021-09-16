Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F8C40D560
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 11:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhIPJBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 05:01:48 -0400
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:35204 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235852AbhIPJBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:01:32 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id 181DFC0D1E
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 10:00:10 +0100 (IST)
Received: (qmail 14747 invoked from network); 16 Sep 2021 09:00:09 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Sep 2021 09:00:09 -0000
Date:   Thu, 16 Sep 2021 10:00:08 +0100
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
Message-ID: <20210916090008.GF3959@techsingularity.net>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838437.13293.14244628630141187199.stgit@noble.brown>
 <20210914163432.GR3828@suse.com>
 <20210914235535.GL2361455@dread.disaster.area>
 <20210915085904.GU3828@suse.com>
 <20210915143510.GE3959@techsingularity.net>
 <20210915223858.GM2361455@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210915223858.GM2361455@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 08:38:58AM +1000, Dave Chinner wrote:
> On Wed, Sep 15, 2021 at 03:35:10PM +0100, Mel Gorman wrote:
> > On Wed, Sep 15, 2021 at 09:59:04AM +0100, Mel Gorman wrote:
> > > > Yup, that's what we need, but I don't see why it needs to be exposed
> > > > outside the allocation code at all.
> > > > 
> > > 
> > > Probably not. At least some of it could be contained within reclaim
> > > itself to block when reclaim is not making progress as opposed to anything
> > > congestion related. That might still livelock if no progress can be made
> > > but that's not new, the OOM hammer should eventually kick in.
> > > 
> > 
> > There are two sides to the reclaim-related throttling
> > 
> > 1. throttling because zero progress is being made
> > 2. throttling because there are too many dirty pages or pages under
> >    writeback cycling through the LRU too quickly.
> > 
> > The dirty page aspects (and the removal of wait_iff_congested which is
> > almost completely broken) could be done with something like the following
> > (completly untested). The downside is that end_page_writeback() takes an
> > atomic penalty if reclaim is throttled but at that point the system is
> > struggling anyway so I doubt it matters.
> 
> The atomics are pretty nasty, as is directly accessing the pgdat on
> every call to end_page_writeback(). Those will be performance
> limiting factors. Indeed, we don't use atomics for dirty page
> throttling, which does dirty page accounting via
> percpu counters on the BDI and doesn't require wakeups.
> 

Thanks for taking a look!

From end_page_writeback, the first atomic operation is an atomic read
which is READ_ONCE on most architectures (alpha is a counter example as it
has a memory barrier but alpha is niche). The main atomic penalty is when
the system is reclaim throttled but it can be a per-cpu node page state
counter instead. That sacrifices accuracy for speed but in this context,
I think that's ok. As for accessing the pgdat structure, every vmstat
counter for the node involves a pgdat lookup as the API is page-based
and so there are already a bunch of pgdat lookups in the IO path.

> Also, we've already got per-node and per-zone counters there for
> dirty/write pending stats, so do we actually need new counters and
> wakeups here?
> 

I think we need at least a new counter because dirty/write pending
stats do not tell us how many pages were cleaned since reclaim started
hitting problems with dirty pages at the tail of the LRU. Reading
dirty/write_pending stats at two points of time cannot be used to
infer how many pages were cleaned during the same interval. At minimum,
we'd need nr_dirtied and a new nr_cleaned stat to infer pages cleaned
between two points in time. That can be done but if the new counters is
NR_THROTTLED_WRITTEN (NR_WRITTEN while reclaim throttled), we only need one
field in struct zone to track nr_reclaim_throttled when throttling
startsi (updated patch at the end of the mail).

> i.e. balance_dirty_pages() does not have an explicit wakeup - it
> bases it's sleep time on the (memcg aware) measured writeback rate
> on the BDI the page belongs to and the amount of outstanding dirty
> data on that BDI. i.e. it estimates fairly accurately what the wait
> time for this task should be given the dirty page demand and current
> writeback progress being made is and just sleeps for that length of
> time.
> 
> Ideally, that's what should be happening here - we should be able to
> calculate a page cleaning rate estimation and then base the sleep
> time on that. No wakeups needed - when we've waited for the
> estimated time, we try to reclaim again...
> 
> In fact, why can't this "too many dirty pages" case just use the
> balance_dirty_pages() infrastructure to do the "wait for writeback"
> reclaim backoff? Why do we even need to re-invent the wheel here?
> 

Conceptually I can see what you are asking for but am finding it hard to
translate it into an implementation. Dirty page throttling is throttling
heavy writers on a task and bdi basis but does not care about the
positioning of pages on the LRU or what node the page is allocated from.
On the reclaim side, the concern is how many pages that are dirty or
writeback at the tail of the LRU regardless of what task dirtied that
page or BDI it belongs to.

Hence I'm failing to see how the same rate-limiting mechanism could be
used on the reclaim side.

I guess we could look at the reclaim efficiency for a given task by
tracking pages that could not be reclaimed due to dirty/writeback relative
to pages that could be reclaimed and sleeping for increasing lengths of
time unconditionally when the reclaim efficiency is low.  However it's
complex and would be hard to debug. It could hit serious problems in
cases where there are both fast and slow bdi's with the pages backed by a
slow bdi dominating the tail of the LRU -- it could throttle excessively
prematurely. Alternatively, look at taking pages that are dirty/writeback
off the inactive list like what is done for LRU_UNEVICTABLE pages
and throttling based on a high rate of INACTIVE_FILE:LRU_UNEVICTABLE,
but again, it's complex and could incur additional penalties in the
end_page_writeback due to LRU manipulations. Both are essentially
re-inventing a very complex wheel.

I'm aware that what I'm proposing also has its problems. It could wake
prematurely because all the pages cleaned were backed by a fast bdi when
the pages it scanned were backed by a slow bdi. Prehaps this could
be dealt with by tracking the estimated writeback speed of pages cleaned
and comparing it against the estimated writeback speed of pages at the
tail of the LRU but again, the complexity may be excessive.

If the first solution is too complex, it'll get hit with the KISS hammer
with a request to justify the complexity when the basis for comparison is
a broken concept. So I want to start simple, all it has to be is better
than congestion_wait/wait_iff_congested. If that still is not good enough,
the more complex options will have a basis for comparison.

> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index dae481293b5d..b9be9afa4308 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1606,6 +1606,8 @@ void end_page_writeback(struct page *page)
> >  	smp_mb__after_atomic();
> >  	wake_up_page(page, PG_writeback);
> >  	put_page(page);
> > +
> > +	acct_reclaim_writeback(page);
> 
> UAF - that would need to be before the put_page() call...
> 

UAF indeed.

Here is another version of the same concept that avoids atomic updates
from end_page_writeback() context and limits pgdat lookups. It's still
not tested other than "it boots under kvm".

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
index 6a1d79d84675..12a011912c3c 100644
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
@@ -841,6 +842,10 @@ typedef struct pglist_data {
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
index cf3cb933eba3..cd8b892537a0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -34,6 +34,14 @@
 
 void page_writeback_init(void);
 
+void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page);
+static inline void acct_reclaim_writeback(struct page *page)
+{
+	pg_data_t *pgdat = page_pgdat(page);
+	if (atomic_read(&pgdat->nr_reclaim_throttled))
+		__acct_reclaim_writeback(pgdat, page);
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
index 74296c2d1fed..f7908ed079f7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1006,6 +1006,43 @@ static void handle_write_error(struct address_space *mapping,
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
+	WRITE_ONCE(pgdat->nr_reclaim_start,
+		 node_page_state(pgdat, NR_THROTTLED_WRITTEN));
+
+	prepare_to_wait(wqh, &wait, TASK_INTERRUPTIBLE);
+	ret = schedule_timeout(timeout);
+	finish_wait(&pgdat->reclaim_wait, &wait);
+	atomic_dec(&pgdat->nr_reclaim_throttled);
+
+	/* TODO: Add tracepoint to track time sleeping */
+}
+
+/*
+ * Account for pages written if tasks are throttled waiting on dirty
+ * pages to clean. If enough pages have been cleaned since throttling
+ * started then wakeup the throttled tasks.
+ */
+void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page)
+{
+	unsigned long nr_written;
+	int nr_throttled = atomic_read(&pgdat->nr_reclaim_throttled);
+
+	__inc_node_page_state(page, NR_THROTTLED_WRITTEN);
+	nr_written = node_page_state(pgdat, NR_THROTTLED_WRITTEN) -
+		READ_ONCE(pgdat->nr_reclaim_start);
+
+	if (nr_written > SWAP_CLUSTER_MAX * nr_throttled)
+		wake_up_interruptible(&pgdat->reclaim_wait);
+}
+
 /* possible outcome of pageout() */
 typedef enum {
 	/* failed to write page out, page is locked */
@@ -1412,9 +1449,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 
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
@@ -3180,19 +3216,20 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
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
@@ -3208,7 +3245,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	if (!current_is_kswapd() && current_may_throttle() &&
 	    !sc->hibernation_mode &&
 	    test_bit(LRUVEC_CONGESTED, &target_lruvec->flags))
-		wait_iff_congested(BLK_RW_ASYNC, HZ/10);
+		reclaim_writeback_throttle(pgdat, HZ/10);
 
 	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
 				    sc))
@@ -4286,6 +4323,7 @@ static int kswapd(void *p)
 
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
