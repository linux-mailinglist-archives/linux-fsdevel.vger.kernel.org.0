Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4C24144FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 11:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhIVJXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 05:23:32 -0400
Received: from outbound-smtp61.blacknight.com ([46.22.136.249]:46659 "EHLO
        outbound-smtp61.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232258AbhIVJXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:23:32 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp61.blacknight.com (Postfix) with ESMTPS id 9458BFBDC6
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 10:22:01 +0100 (IST)
Received: (qmail 20703 invoked from network); 22 Sep 2021 09:22:01 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Sep 2021 09:22:01 -0000
Date:   Wed, 22 Sep 2021 10:21:59 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     NeilBrown <neilb@suse.de>
Cc:     Linux-MM <linux-mm@kvack.org>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] mm/vmscan: Throttle reclaim when no progress is
 being made
Message-ID: <20210922092159.GW3959@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
 <20210920085436.20939-4-mgorman@techsingularity.net>
 <163218069080.3992.14261132300912173043@noble.neil.brown.name>
 <20210921111630.GR3959@techsingularity.net>
 <163226081891.21861.1286773174123207227@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163226081891.21861.1286773174123207227@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 07:46:58AM +1000, NeilBrown wrote:
> On Tue, 21 Sep 2021, Mel Gorman wrote:
> > On Tue, Sep 21, 2021 at 09:31:30AM +1000, NeilBrown wrote:
> > > On Mon, 20 Sep 2021, Mel Gorman wrote:
> > > > +
> > > > +		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS, HZ/10);
> > > 
> > > We always seem to pass "HZ/10" to reclaim_throttle().  Should we just
> > > hard-code that in the one place inside reclaim_throttle() itself?
> > > 
> > 
> > do_writepages passes in HZ/50. I'm not sure if these values even have
> > any special meaning, I think it's more likely they were pulled out of
> > the air based on the speed of some disk in the past and then copied.
> > It's another reason why I want the wakeups to be based on events within
> > the mm as much as possible.
> 
> Yes, I saw the HZ/50 shortly after writing that email :-)
> I agree with your guess for the source of these numbers.  I still think
> we should pull them all from the same piece of air.
> Hopefully, once these changes are properly understood and the events
> reliably come as expected, we can make it quite large (HZ?) with minimal
> cost.
> 

I'd prefer to do it as a separate patch. At some point congestion_wait
worked and the original timeouts may have been selected based on testing
(I severely doubt it but I'm trying to be optimistic). However, we can
at least centralise the decision based on "reason" with this

---8<---
From 11e5197c0c569e89145475afd511efe3ce61711c Mon Sep 17 00:00:00 2001
From: Mel Gorman <mgorman@techsingularity.net>
Date: Wed, 22 Sep 2021 10:16:33 +0100
Subject: [PATCH] mm/vmscan: Centralise timeout values for reclaim_throttle

Neil Brown raised concerns about callers of reclaim_throttle specifying
a timeout value. The original timeout values to congestion_wait() were
probably pulled out of thin air or copy&pasted from somewhere else.
This patch centralises the timeout values and selects a timeout based
on the reason for reclaim throttling. These figures are also pulled
out of the same thin air but better values may be derived

Running a workload that is throttling for inappropriate periods
and tracing mm_vmscan_throttled can be used to pick a more appropriate
value. Excessive throttling would pick a lower timeout where as
excessive CPU usage in reclaim context would select a larger timeout.
Ideally a large value would always be used and the wakeups would
occur before a timeout but that requires careful testing.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c     |  2 +-
 mm/internal.h       |  3 +--
 mm/page-writeback.c |  2 +-
 mm/vmscan.c         | 39 +++++++++++++++++++++++++++++++--------
 4 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 7359093d8ac0..151b04c4dab3 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -828,7 +828,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (cc->mode == MIGRATE_ASYNC)
 			return -EAGAIN;
 
-		reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED, HZ/10);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED);
 
 		if (fatal_signal_pending(current))
 			return -EINTR;
diff --git a/mm/internal.h b/mm/internal.h
index 06d0c376efcd..f8d203cfd4e1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -129,8 +129,7 @@ extern unsigned long highest_memmap_pfn;
  */
 extern int isolate_lru_page(struct page *page);
 extern void putback_lru_page(struct page *page);
-extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
-								long timeout);
+extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason);
 
 /*
  * in mm/rmap.c:
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index f34f54fcd5b4..7d08706c541a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2374,7 +2374,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 		 * guess as any.
 		 */
 		reclaim_throttle(NODE_DATA(numa_node_id()),
-			VMSCAN_THROTTLE_WRITEBACK, HZ/50);
+						VMSCAN_THROTTLE_WRITEBACK);
 	}
 	/*
 	 * Usually few pages are written by now from those we've just submitted
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b0012f9536e1..36b21549a3a4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1006,14 +1006,37 @@ static void handle_write_error(struct address_space *mapping,
 	unlock_page(page);
 }
 
-void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
-							long timeout)
+void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 {
 	wait_queue_head_t *wqh = &pgdat->reclaim_wait[reason];
 	unsigned long start = jiffies;
-	long ret;
+	long timeout, ret;
 	DEFINE_WAIT(wait);
 
+	/*
+	 * These figures are pulled out of thin air.
+	 * VMSCAN_THROTTLE_ISOLATED is a transient condition based on too many
+	 * parallel reclaimers which is a short-lived event so the timeout is
+	 * short. Failing to make progress or waiting on writeback are
+	 * potentially long-lived events so use a longer timeout. This is shaky
+	 * logic as a failure to make progress could be due to anything from
+	 * writeback to a slow device to excessive references pages at the tail
+	 * of the inactive LRU.
+	 */
+	switch(reason) {
+	case VMSCAN_THROTTLE_NOPROGRESS:
+	case VMSCAN_THROTTLE_WRITEBACK:
+		timeout = HZ/10;
+		break;
+	case VMSCAN_THROTTLE_ISOLATED:
+		timeout = HZ/50;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		timeout = HZ;
+		break;
+	}
+
 	atomic_inc(&pgdat->nr_reclaim_throttled);
 	WRITE_ONCE(pgdat->nr_reclaim_start,
 		 node_page_state(pgdat, NR_THROTTLED_WRITTEN));
@@ -2298,7 +2321,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 
 		/* wait a bit for the reclaimer. */
 		stalled = true;
-		reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED, HZ/10);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED);
 
 		/* We are about to die and free our memory. Return now. */
 		if (fatal_signal_pending(current))
@@ -3230,7 +3253,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		 * until some pages complete writeback.
 		 */
 		if (sc->nr.immediate)
-			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK, HZ/10);
+			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
 	}
 
 	/*
@@ -3254,7 +3277,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	if (!current_is_kswapd() && current_may_throttle() &&
 	    !sc->hibernation_mode &&
 	    test_bit(LRUVEC_CONGESTED, &target_lruvec->flags))
-		reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK, HZ/10);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
 
 	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
 				    sc))
@@ -3326,7 +3349,7 @@ static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
 
 	/* Throttle if making no progress at high prioities. */
 	if (sc->priority < DEF_PRIORITY - 2)
-		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS, HZ/10);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS);
 }
 
 /*
@@ -3795,7 +3818,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		z = first_zones_zonelist(zonelist, sc.reclaim_idx, sc.nodemask);
 		pgdat = zonelist_zone(z)->zone_pgdat;
 
-		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS, HZ/10);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS);
 	}
 
 	return nr_reclaimed;
