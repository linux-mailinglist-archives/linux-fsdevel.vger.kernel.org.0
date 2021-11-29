Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D2D461A97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 16:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbhK2PGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 10:06:43 -0500
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:58047 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245630AbhK2PEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:04:38 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id E89D11C3E07
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 15:01:19 +0000 (GMT)
Received: (qmail 18935 invoked from network); 29 Nov 2021 15:01:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Nov 2021 15:01:19 -0000
Date:   Mon, 29 Nov 2021 15:01:17 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Alexey Avramov <hakavlad@inbox.lv>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <20211129150117.GO3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
 <20211127011246.7a8ac7b8@mail.inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211127011246.7a8ac7b8@mail.inbox.lv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 27, 2021 at 01:12:46AM +0900, Alexey Avramov wrote:
> >After the patch, the test gets killed after roughly 15 seconds which is
> >the same length of time taken in 5.15.
> 
> In my tests, the 5.15 still performs much better.
> 
> New question: is timeout=1 has sense? Will it save CPU?

Ok, the following on top of 5.16-rc1 survived 8 minutes of watching youtube
on a laptop while "tail /dev/zero" was running within the background. While
there were some very short glitches, they were no worse than 5.15. I've
not reproduced your exact test case yet or the memcg ones yet but sending
now in case I don't complete them before the end of the day.

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb9584641ac7..1af12072f40e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1021,6 +1021,39 @@ static void handle_write_error(struct address_space *mapping,
 	unlock_page(page);
 }
 
+bool skip_throttle_noprogress(pg_data_t *pgdat)
+{
+	int reclaimable = 0, write_pending = 0;
+	int i;
+
+	/*
+	 * If kswapd is disabled, reschedule if necessary but do not
+	 * throttle as the system is likely near OOM.
+	 */
+	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
+		return true;
+
+	/*
+	 * If there are a lot of dirty/writeback pages then do not
+	 * throttle as throttling will occur when the pages cycle
+	 * towards the end of the LRU if still under writeback.
+	 */
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		struct zone *zone = pgdat->node_zones + i;
+
+		if (!populated_zone(zone))
+			continue;
+
+		reclaimable += zone_reclaimable_pages(zone);
+		write_pending += zone_page_state_snapshot(zone,
+						  NR_ZONE_WRITE_PENDING);
+	}
+	if (2 * write_pending <= reclaimable)
+		return true;
+
+	return false;
+}
+
 void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 {
 	wait_queue_head_t *wqh = &pgdat->reclaim_wait[reason];
@@ -1057,7 +1090,13 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 
 		break;
 	case VMSCAN_THROTTLE_NOPROGRESS:
-		timeout = HZ/2;
+		if (skip_throttle_noprogress(pgdat)) {
+			cond_resched();
+			return;
+		}
+
+		timeout = 1;
+
 		break;
 	case VMSCAN_THROTTLE_ISOLATED:
 		timeout = HZ/50;
@@ -3386,16 +3425,16 @@ static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
 	}
 
 	/*
-	 * Do not throttle kswapd on NOPROGRESS as it will throttle on
-	 * VMSCAN_THROTTLE_WRITEBACK if there are too many pages under
-	 * writeback and marked for immediate reclaim at the tail of
-	 * the LRU.
+	 * Do not throttle kswapd or cgroup reclaim on NOPROGRESS as it will
+	 * throttle on VMSCAN_THROTTLE_WRITEBACK if there are too many pages
+	 * under writeback and marked for immediate reclaim at the tail of the
+	 * LRU.
 	 */
-	if (current_is_kswapd())
+	if (current_is_kswapd() || cgroup_reclaim(sc))
 		return;
 
 	/* Throttle if making no progress at high prioities. */
-	if (sc->priority < DEF_PRIORITY - 2)
+	if (sc->priority == 1 && !sc->nr_reclaimed)
 		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS);
 }
 
@@ -3415,6 +3454,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 	unsigned long nr_soft_scanned;
 	gfp_t orig_mask;
 	pg_data_t *last_pgdat = NULL;
+	pg_data_t *first_pgdat = NULL;
 
 	/*
 	 * If the number of buffer_heads in the machine exceeds the maximum
@@ -3478,14 +3518,18 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 			/* need some check for avoid more shrink_zone() */
 		}
 
+		if (!first_pgdat)
+			first_pgdat = zone->zone_pgdat;
+
 		/* See comment about same check for global reclaim above */
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
 		last_pgdat = zone->zone_pgdat;
 		shrink_node(zone->zone_pgdat, sc);
-		consider_reclaim_throttle(zone->zone_pgdat, sc);
 	}
 
+	consider_reclaim_throttle(first_pgdat, sc);
+
 	/*
 	 * Restore to original mask to avoid the impact on the caller if we
 	 * promoted it to __GFP_HIGHMEM.
