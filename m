Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95C7D05FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 05:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfJIDVp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 23:21:45 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:46801 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730574AbfJIDVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:21:41 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 5627843ECA7;
        Wed,  9 Oct 2019 14:21:27 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XX-0006Bb-1p; Wed, 09 Oct 2019 14:21:27 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XW-00039T-Vy; Wed, 09 Oct 2019 14:21:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/26] shrinker: clean up variable types and tracepoints
Date:   Wed,  9 Oct 2019 14:21:10 +1100
Message-Id: <20191009032124.10541-13-david@fromorbit.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20191009032124.10541-1-david@fromorbit.com>
References: <20191009032124.10541-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=XobE76Q3jBoA:10 a=20KFwNOVAAAA:8
        a=dfQxWFgAP5TgkvwPFjsA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

The tracepoint information in the shrinker code don't make a lot of
sense anymore and contain redundant information as a result of the
changes in the patchset. Refine the information passed to the
tracepoints so they expose the operation of the shrinkers more
precisely and clean up the remaining code and varibles in the
shrinker code so it all makes sense.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 include/trace/events/vmscan.h | 69 ++++++++++++++++-------------------
 mm/vmscan.c                   | 24 +++++-------
 2 files changed, 41 insertions(+), 52 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index a5ab2973e8dc..110637d9efa5 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -184,84 +184,77 @@ DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_memcg_softlimit_re
 
 TRACE_EVENT(mm_shrink_slab_start,
 	TP_PROTO(struct shrinker *shr, struct shrink_control *sc,
-		long nr_objects_to_shrink, unsigned long cache_items,
-		unsigned long long delta, unsigned long total_scan,
-		int priority),
+		int64_t deferred_count, int64_t freeable_objects,
+		int64_t scan_count, int priority),
 
-	TP_ARGS(shr, sc, nr_objects_to_shrink, cache_items, delta, total_scan,
+	TP_ARGS(shr, sc, deferred_count, freeable_objects, scan_count,
 		priority),
 
 	TP_STRUCT__entry(
 		__field(struct shrinker *, shr)
 		__field(void *, shrink)
 		__field(int, nid)
-		__field(long, nr_objects_to_shrink)
-		__field(gfp_t, gfp_flags)
-		__field(unsigned long, cache_items)
-		__field(unsigned long long, delta)
-		__field(unsigned long, total_scan)
+		__field(int64_t, deferred_count)
+		__field(int64_t, freeable_objects)
+		__field(int64_t, scan_count)
 		__field(int, priority)
+		__field(gfp_t, gfp_flags)
 	),
 
 	TP_fast_assign(
 		__entry->shr = shr;
 		__entry->shrink = shr->scan_objects;
 		__entry->nid = sc->nid;
-		__entry->nr_objects_to_shrink = nr_objects_to_shrink;
-		__entry->gfp_flags = sc->gfp_mask;
-		__entry->cache_items = cache_items;
-		__entry->delta = delta;
-		__entry->total_scan = total_scan;
+		__entry->deferred_count = deferred_count;
+		__entry->freeable_objects = freeable_objects;
+		__entry->scan_count = scan_count;
 		__entry->priority = priority;
+		__entry->gfp_flags = sc->gfp_mask;
 	),
 
-	TP_printk("%pS %p: nid: %d objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d",
+	TP_printk("%pS %p: nid: %d scan count %lld freeable items %lld deferred count %lld priority %d gfp_flags %s",
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
-		__entry->nr_objects_to_shrink,
-		show_gfp_flags(__entry->gfp_flags),
-		__entry->cache_items,
-		__entry->delta,
-		__entry->total_scan,
-		__entry->priority)
+		__entry->scan_count,
+		__entry->freeable_objects,
+		__entry->deferred_count,
+		__entry->priority,
+		show_gfp_flags(__entry->gfp_flags))
 );
 
 TRACE_EVENT(mm_shrink_slab_end,
-	TP_PROTO(struct shrinker *shr, int nid, int shrinker_retval,
-		long unused_scan_cnt, long new_scan_cnt, long total_scan),
+	TP_PROTO(struct shrinker *shr, int nid, int64_t freed_objects,
+		int64_t scanned_objects, int64_t deferred_scan),
 
-	TP_ARGS(shr, nid, shrinker_retval, unused_scan_cnt, new_scan_cnt,
-		total_scan),
+	TP_ARGS(shr, nid, freed_objects, scanned_objects,
+		deferred_scan),
 
 	TP_STRUCT__entry(
 		__field(struct shrinker *, shr)
 		__field(int, nid)
 		__field(void *, shrink)
-		__field(long, unused_scan)
-		__field(long, new_scan)
-		__field(int, retval)
-		__field(long, total_scan)
+		__field(long long, freed_objects)
+		__field(long long, scanned_objects)
+		__field(long long, deferred_scan)
 	),
 
 	TP_fast_assign(
 		__entry->shr = shr;
 		__entry->nid = nid;
 		__entry->shrink = shr->scan_objects;
-		__entry->unused_scan = unused_scan_cnt;
-		__entry->new_scan = new_scan_cnt;
-		__entry->retval = shrinker_retval;
-		__entry->total_scan = total_scan;
+		__entry->freed_objects = freed_objects;
+		__entry->scanned_objects = scanned_objects;
+		__entry->deferred_scan = deferred_scan;
 	),
 
-	TP_printk("%pS %p: nid: %d unused scan count %ld new scan count %ld total_scan %ld last shrinker return val %d",
+	TP_printk("%pS %p: nid: %d freed objects %lld scanned objects %lld, deferred scan %lld",
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
-		__entry->unused_scan,
-		__entry->new_scan,
-		__entry->total_scan,
-		__entry->retval)
+		__entry->freed_objects,
+		__entry->scanned_objects,
+		__entry->deferred_scan)
 );
 
 TRACE_EVENT(mm_vmscan_lru_isolate,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d05f64bd26ff..65093dd89dd7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -522,7 +522,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	int64_t scanned_objects = 0;
 	int64_t next_deferred = 0;
 	int64_t deferred_count = 0;
-	int64_t new_nr;
 	int nid = shrinkctl->nid;
 	long batch_size = shrinker->batch ? shrinker->batch
 					  : SHRINK_BATCH;
@@ -579,8 +578,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	scan_count = min(scan_count, freeable_objects * 2);
 
 	trace_mm_shrink_slab_start(shrinker, shrinkctl, deferred_count,
-				   freeable_objects, scan_count,
-				   scan_count, priority);
+				   freeable_objects, scan_count, priority);
 
 	/*
 	 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
@@ -623,23 +621,21 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		cond_resched();
 	}
 done:
+	/*
+	 * Calculate the remaining work that we need to defer to kswapd, and
+	 * store it in a manner that handles concurrent updates. If we exhausted
+	 * the scan, there is no need to do an update.
+	 */
 	if (deferred_count)
 		next_deferred = deferred_count - scanned_objects;
 	else
 		next_deferred = scan_count;
-	/*
-	 * move the unused scan count back into the shrinker in a
-	 * manner that handles concurrent updates. If we exhausted the
-	 * scan, there is no need to do an update.
-	 */
+
 	if (next_deferred > 0)
-		new_nr = atomic64_add_return(next_deferred,
-						&shrinker->nr_deferred[nid]);
-	else
-		new_nr = atomic64_read(&shrinker->nr_deferred[nid]);
+		atomic64_add(next_deferred, &shrinker->nr_deferred[nid]);
 
-	trace_mm_shrink_slab_end(shrinker, nid, freed, deferred_count, new_nr,
-					scan_count);
+	trace_mm_shrink_slab_end(shrinker, nid, freed, scanned_objects,
+				 next_deferred);
 	return freed;
 }
 
-- 
2.23.0.rc1

