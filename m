Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0064D4331C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 11:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhJSJEg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 05:04:36 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:32835 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234961AbhJSJEf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:04:35 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 8F2541C60E3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 10:02:20 +0100 (IST)
Received: (qmail 9401 invoked from network); 19 Oct 2021 09:02:20 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 19 Oct 2021 09:02:20 -0000
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
Subject: [PATCH 6/8] mm/vmscan: Centralise timeout values for reclaim_throttle
Date:   Tue, 19 Oct 2021 10:01:06 +0100
Message-Id: <20211019090108.25501-7-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019090108.25501-1-mgorman@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>
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
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/compaction.c     |  2 +-
 mm/internal.h       |  3 +--
 mm/page-writeback.c |  2 +-
 mm/vmscan.c         | 48 +++++++++++++++++++++++++++++++++------------
 4 files changed, 38 insertions(+), 17 deletions(-)

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
index 3461a1055975..63d8ebbc5a6d 100644
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
index 14127bbf2c3b..1f5c467dc83c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1006,12 +1006,10 @@ static void handle_write_error(struct address_space *mapping,
 	unlock_page(page);
 }
 
-void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
-							long timeout)
+void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 {
 	wait_queue_head_t *wqh = &pgdat->reclaim_wait[reason];
-	long ret;
-	bool acct_writeback = (reason == VMSCAN_THROTTLE_WRITEBACK);
+	long timeout, ret;
 	DEFINE_WAIT(wait);
 
 	/*
@@ -1023,17 +1021,41 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
 	    current->flags & (PF_IO_WORKER|PF_KTHREAD))
 		return;
 
-	if (acct_writeback &&
-	    atomic_inc_return(&pgdat->nr_writeback_throttled) == 1) {
-		WRITE_ONCE(pgdat->nr_reclaim_start,
-			node_page_state(pgdat, NR_THROTTLED_WRITTEN));
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
+
+		if (atomic_inc_return(&pgdat->nr_writeback_throttled) == 1) {
+			WRITE_ONCE(pgdat->nr_reclaim_start,
+				node_page_state(pgdat, NR_THROTTLED_WRITTEN));
+		}
+
+		break;
+	case VMSCAN_THROTTLE_ISOLATED:
+		timeout = HZ/50;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		timeout = HZ;
+		break;
 	}
 
 	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
 	ret = schedule_timeout(timeout);
 	finish_wait(wqh, &wait);
 
-	if (acct_writeback)
+	if (reason == VMSCAN_THROTTLE_ISOLATED)
 		atomic_dec(&pgdat->nr_writeback_throttled);
 
 	trace_mm_vmscan_throttled(pgdat->node_id, jiffies_to_usecs(timeout),
@@ -2319,7 +2341,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 
 		/* wait a bit for the reclaimer. */
 		stalled = true;
-		reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED, HZ/10);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED);
 
 		/* We are about to die and free our memory. Return now. */
 		if (fatal_signal_pending(current))
@@ -3251,7 +3273,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		 * until some pages complete writeback.
 		 */
 		if (sc->nr.immediate)
-			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK, HZ/10);
+			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
 	}
 
 	/*
@@ -3275,7 +3297,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	if (!current_is_kswapd() && current_may_throttle() &&
 	    !sc->hibernation_mode &&
 	    test_bit(LRUVEC_CONGESTED, &target_lruvec->flags))
-		reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK, HZ/10);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
 
 	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
 				    sc))
@@ -3347,7 +3369,7 @@ static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
 
 	/* Throttle if making no progress at high prioities. */
 	if (sc->priority < DEF_PRIORITY - 2)
-		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS, HZ/10);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS);
 }
 
 /*
-- 
2.31.1

