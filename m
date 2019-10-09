Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB66D05D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 05:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfJIDVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 23:21:33 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:46267 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730267AbfJIDVc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:21:32 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3FE9E43EC2F;
        Wed,  9 Oct 2019 14:21:27 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XX-0006BY-0P; Wed, 09 Oct 2019 14:21:27 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XW-00039Q-UQ; Wed, 09 Oct 2019 14:21:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/26] shrinker: defer work only to kswapd
Date:   Wed,  9 Oct 2019 14:21:09 +1100
Message-Id: <20191009032124.10541-12-david@fromorbit.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20191009032124.10541-1-david@fromorbit.com>
References: <20191009032124.10541-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=XobE76Q3jBoA:10 a=20KFwNOVAAAA:8
        a=DY0x1sV2QIg9a-hhTtsA:9 a=MCR_tvXtDtI_MWXX:21 a=Jfgs850-GcERAMIO:21
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Right now deferred work is picked up by whatever GFP_KERNEL context
reclaimer that wins the race to empty the node's deferred work
counter. However, if there are lots of direct reclaimers, that
work might be continually picked up by contexts taht can't do any
work and so the opportunities to do the work are missed by contexts
that could do them.

A further problem with the current code is that the deferred work
can be picked up by a random direct reclaimer, resulting in that
specific process having to do all the deferred reclaim work and
hence can take extremely long latencies if the reclaim work blocks
regularly. This is not good for direct reclaim fairness or for
minimising long tail latency events.

To avoid these problems, simply limit deferred work to kswapd
contexts. We know kswapd is a context that can always do reclaim
work, and hence deferring work to kswapd allows the deferred work to
be done in the background and not adversely affect any specific
process context doing direct reclaim.

The advantage of this is that amount of work to be done in direct
reclaim is now bound and predictable - it is entirely based on
the cache's freeable objects and the reclaim priority. hence all
direct reclaimers running at the same time should be doing
relatively equal amounts of work, thereby reducing the incidence of
long tail latencies due to uneven reclaim workloads.

Note that we use signed integers for everything except the freed
count as the returns from the shrinker callouts cannot be guaranteed
untainted. Indeed, the shrinkers can return scan counts larger that
were fed in, so we need scan counts to underflow in a detectable
manner to terminate loops. This is necessary to avoid a misbehaving
shrinker from triggering endless scanning loops.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/shrinker.h |  2 +-
 mm/vmscan.c              | 98 +++++++++++++++++++++-------------------
 2 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 3405c39ab92c..30c10f42109f 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -81,7 +81,7 @@ struct shrinker {
 	int id;
 #endif
 	/* objs pending delete, per node */
-	atomic_long_t *nr_deferred;
+	atomic64_t *nr_deferred;
 };
 #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index de6b09ad97ed..d05f64bd26ff 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -516,16 +516,16 @@ static int64_t shrink_scan_count(struct shrink_control *shrinkctl,
 static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 				    struct shrinker *shrinker, int priority)
 {
-	unsigned long freed = 0;
-	long total_scan;
+	uint64_t freed = 0;
 	int64_t freeable_objects = 0;
 	int64_t scan_count;
-	long nr;
-	long new_nr;
+	int64_t scanned_objects = 0;
+	int64_t next_deferred = 0;
+	int64_t deferred_count = 0;
+	int64_t new_nr;
 	int nid = shrinkctl->nid;
 	long batch_size = shrinker->batch ? shrinker->batch
 					  : SHRINK_BATCH;
-	long scanned = 0, next_deferred;
 
 	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
 		nid = 0;
@@ -536,47 +536,51 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		return scan_count;
 
 	/*
-	 * copy the current shrinker scan count into a local variable
-	 * and zero it so that other concurrent shrinker invocations
-	 * don't also do this scanning work.
+	 * If kswapd, we take all the deferred work and do it here. We don't let
+	 * direct reclaim do this, because then it means some poor sod is going
+	 * to have to do somebody else's GFP_NOFS reclaim, and it hides the real
+	 * amount of reclaim work from concurrent kswapd operations. Hence we do
+	 * the work in the wrong place, at the wrong time, and it's largely
+	 * unpredictable.
+	 *
+	 * By doing the deferred work only in kswapd, we can schedule the work
+	 * according the the reclaim priority - low priority reclaim will do
+	 * less deferred work, hence we'll do more of the deferred work the more
+	 * desperate we become for free memory. This avoids the need for needing
+	 * to specifically avoid deferred work windup as low amount os memory
+	 * pressure won't excessive trim caches anymore.
 	 */
-	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
+	if (current_is_kswapd()) {
+		int64_t	deferred_scan;
 
-	total_scan = nr + scan_count;
-	if (total_scan < 0) {
-		pr_err("shrink_slab: %pS negative objects to delete nr=%ld\n",
-		       shrinker->scan_objects, total_scan);
-		total_scan = scan_count;
-		next_deferred = nr;
-	} else
-		next_deferred = total_scan;
+		deferred_count = atomic64_xchg(&shrinker->nr_deferred[nid], 0);
 
-	/*
-	 * We need to avoid excessive windup on filesystem shrinkers
-	 * due to large numbers of GFP_NOFS allocations causing the
-	 * shrinkers to return -1 all the time. This results in a large
-	 * nr being built up so when a shrink that can do some work
-	 * comes along it empties the entire cache due to nr >>>
-	 * freeable. This is bad for sustaining a working set in
-	 * memory.
-	 *
-	 * Hence only allow the shrinker to scan the entire cache when
-	 * a large delta change is calculated directly.
-	 */
-	if (scan_count < freeable_objects / 4)
-		total_scan = min_t(long, total_scan, freeable_objects / 2);
+		/* we want to scan 5-10% of the deferred work here at minimum */
+		deferred_scan = deferred_count;
+		if (priority)
+			do_div(deferred_scan, priority);
+		scan_count += deferred_scan;
+
+		/*
+		 * If there is more deferred work than the number of freeable
+		 * items in the cache, limit the amount of work we will carry
+		 * over to the next kswapd run on this cache. This prevents
+		 * deferred work windup.
+		 */
+		deferred_count = min(deferred_count, freeable_objects * 2);
+
+	}
 
 	/*
 	 * Avoid risking looping forever due to too large nr value:
 	 * never try to free more than twice the estimate number of
 	 * freeable entries.
 	 */
-	if (total_scan > freeable_objects * 2)
-		total_scan = freeable_objects * 2;
+	scan_count = min(scan_count, freeable_objects * 2);
 
-	trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
+	trace_mm_shrink_slab_start(shrinker, shrinkctl, deferred_count,
 				   freeable_objects, scan_count,
-				   total_scan, priority);
+				   scan_count, priority);
 
 	/*
 	 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
@@ -600,10 +604,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 * scanning at high prio and therefore should try to reclaim as much as
 	 * possible.
 	 */
-	while (total_scan >= batch_size ||
-	       total_scan >= freeable_objects) {
+	while (scan_count >= batch_size ||
+	       scan_count >= freeable_objects) {
 		unsigned long ret;
-		unsigned long nr_to_scan = min(batch_size, total_scan);
+		unsigned long nr_to_scan = min_t(long, batch_size, scan_count);
 
 		shrinkctl->nr_to_scan = nr_to_scan;
 		shrinkctl->nr_scanned = nr_to_scan;
@@ -613,29 +617,29 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		freed += ret;
 
 		count_vm_events(SLABS_SCANNED, shrinkctl->nr_scanned);
-		total_scan -= shrinkctl->nr_scanned;
-		scanned += shrinkctl->nr_scanned;
+		scan_count -= shrinkctl->nr_scanned;
+		scanned_objects += shrinkctl->nr_scanned;
 
 		cond_resched();
 	}
-
 done:
-	if (next_deferred >= scanned)
-		next_deferred -= scanned;
+	if (deferred_count)
+		next_deferred = deferred_count - scanned_objects;
 	else
-		next_deferred = 0;
+		next_deferred = scan_count;
 	/*
 	 * move the unused scan count back into the shrinker in a
 	 * manner that handles concurrent updates. If we exhausted the
 	 * scan, there is no need to do an update.
 	 */
 	if (next_deferred > 0)
-		new_nr = atomic_long_add_return(next_deferred,
+		new_nr = atomic64_add_return(next_deferred,
 						&shrinker->nr_deferred[nid]);
 	else
-		new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
+		new_nr = atomic64_read(&shrinker->nr_deferred[nid]);
 
-	trace_mm_shrink_slab_end(shrinker, nid, freed, nr, new_nr, total_scan);
+	trace_mm_shrink_slab_end(shrinker, nid, freed, deferred_count, new_nr,
+					scan_count);
 	return freed;
 }
 
-- 
2.23.0.rc1

