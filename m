Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 862137D320
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 04:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfHACSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 22:18:09 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:32913 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728891AbfHACSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:18:08 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B439443ECB2;
        Thu,  1 Aug 2019 12:17:58 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0eA-0003aU-QO; Thu, 01 Aug 2019 12:16:50 +1000
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0fG-0001ki-OR; Thu, 01 Aug 2019 12:17:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/24] shrinker: defer work only to kswapd
Date:   Thu,  1 Aug 2019 12:17:32 +1000
Message-Id: <20190801021752.4986-5-david@fromorbit.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801021752.4986-1-david@fromorbit.com>
References: <20190801021752.4986-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=FmdZ9Uzk2mMA:10 a=20KFwNOVAAAA:8
        a=CHVq44adYJMzgTTYFj8A:9 a=WRIbabeltRbYLjNO:21 a=R37gaMtEP60o-D4u:21
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

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 mm/vmscan.c | 93 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 43 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b7472953b0e6..c583b4efb9bf 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -500,15 +500,15 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 				    struct shrinker *shrinker, int priority)
 {
 	unsigned long freed = 0;
-	long total_scan;
 	int64_t freeable_objects = 0;
 	int64_t scan_count;
-	long nr;
+	int64_t scanned_objects = 0;
+	int64_t next_deferred = 0;
+	int64_t deferred_count = 0;
 	long new_nr;
 	int nid = shrinkctl->nid;
 	long batch_size = shrinker->batch ? shrinker->batch
 					  : SHRINK_BATCH;
-	long scanned = 0, next_deferred;
 
 	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
 		nid = 0;
@@ -519,47 +519,53 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
+		if (deferred_count > freeable_objects * 2)
+			deferred_count = freeable_objects * 2;
+
+	}
 
 	/*
 	 * Avoid risking looping forever due to too large nr value:
 	 * never try to free more than twice the estimate number of
 	 * freeable entries.
 	 */
-	if (total_scan > freeable_objects * 2)
-		total_scan = freeable_objects * 2;
+	if (scan_count > freeable_objects * 2)
+		scan_count = freeable_objects * 2;
 
-	trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
+	trace_mm_shrink_slab_start(shrinker, shrinkctl, deferred_count,
 				   freeable_objects, scan_count,
-				   total_scan, priority);
+				   scan_count, priority);
 
 	/*
 	 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
@@ -583,10 +589,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
@@ -596,17 +602,17 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		freed += ret;
 
 		count_vm_events(SLABS_SCANNED, shrinkctl->nr_scanned);
-		total_scan -= shrinkctl->nr_scanned;
-		scanned += shrinkctl->nr_scanned;
+		scan_count -= shrinkctl->nr_scanned;
+		scanned_objects += shrinkctl->nr_scanned;
 
 		cond_resched();
 	}
 
 done:
-	if (next_deferred >= scanned)
-		next_deferred -= scanned;
-	else
-		next_deferred = 0;
+	if (deferred_count)
+		next_deferred = deferred_count - scanned_objects;
+	else if (scan_count > 0)
+		next_deferred = scan_count;
 	/*
 	 * move the unused scan count back into the shrinker in a
 	 * manner that handles concurrent updates. If we exhausted the
@@ -618,7 +624,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	else
 		new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
 
-	trace_mm_shrink_slab_end(shrinker, nid, freed, nr, new_nr, total_scan);
+	trace_mm_shrink_slab_end(shrinker, nid, freed, deferred_count, new_nr,
+					scan_count);
 	return freed;
 }
 
-- 
2.22.0

