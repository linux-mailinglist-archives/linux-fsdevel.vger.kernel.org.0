Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112A9426C20
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 15:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhJHN4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 09:56:44 -0400
Received: from outbound-smtp61.blacknight.com ([46.22.136.249]:32885 "EHLO
        outbound-smtp61.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242348AbhJHN4l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:56:41 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp61.blacknight.com (Postfix) with ESMTPS id 8664BFAB5F
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Oct 2021 14:54:44 +0100 (IST)
Received: (qmail 7524 invoked from network); 8 Oct 2021 13:54:44 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 8 Oct 2021 13:54:44 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
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
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 6/8] mm/vmscan: Centralise timeout values for reclaim_throttle
Date:   Fri,  8 Oct 2021 14:53:30 +0100
Message-Id: <20211008135332.19567-7-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008135332.19567-1-mgorman@techsingularity.net>
References: <20211008135332.19567-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
index f34f54fcd5b4..4b01a6872f9e 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2374,7 +2374,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 		 * guess as any.
 		 */
 		reclaim_throttle(NODE_DATA(numa_node_id()),
-			VMSCAN_THROTTLE_WRITEBACK, HZ/50);
+			VMSCAN_THROTTLE_WRITEBACK);
 	}
 	/*
 	 * Usually few pages are written by now from those we've just submitted
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cdebfc618179..e096e81dcbd8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1006,11 +1006,10 @@ static void handle_write_error(struct address_space *mapping,
 	unlock_page(page);
 }
 
-void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
-							long timeout)
+void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 {
 	wait_queue_head_t *wqh = &pgdat->reclaim_wait[reason];
-	long ret;
+	long timeout, ret;
 	DEFINE_WAIT(wait);
 
 	/*
@@ -1027,6 +1026,30 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
 			node_page_state(pgdat, NR_THROTTLED_WRITTEN));
 	}
 
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
 	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
 	ret = schedule_timeout(timeout);
 	finish_wait(wqh, &wait);
@@ -2307,7 +2330,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 
 		/* wait a bit for the reclaimer. */
 		stalled = true;
-		reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED, HZ/10);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED);
 
 		/* We are about to die and free our memory. Return now. */
 		if (fatal_signal_pending(current))
@@ -3239,7 +3262,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		 * until some pages complete writeback.
 		 */
 		if (sc->nr.immediate)
-			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK, HZ/10);
+			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
 	}
 
 	/*
@@ -3263,7 +3286,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	if (!current_is_kswapd() && current_may_throttle() &&
 	    !sc->hibernation_mode &&
 	    test_bit(LRUVEC_CONGESTED, &target_lruvec->flags))
-		reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK, HZ/10);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
 
 	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
 				    sc))
@@ -3335,7 +3358,7 @@ static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
 
 	/* Throttle if making no progress at high prioities. */
 	if (sc->priority < DEF_PRIORITY - 2)
-		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS, HZ/10);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS);
 }
 
 /*
@@ -3804,7 +3827,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		z = first_zones_zonelist(zonelist, sc.reclaim_idx, sc.nodemask);
 		pgdat = zonelist_zone(z)->zone_pgdat;
 
-		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS, HZ/10);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS);
 	}
 
 	return nr_reclaimed;
-- 
2.31.1

