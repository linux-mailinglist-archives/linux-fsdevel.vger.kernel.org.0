Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA2464F4F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 15:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243293AbhLAODb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 09:03:31 -0500
Received: from outbound-smtp07.blacknight.com ([46.22.139.12]:34223 "EHLO
        outbound-smtp07.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238986AbhLAOD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:03:29 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id BB07B1C4735
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Dec 2021 14:00:07 +0000 (GMT)
Received: (qmail 16928 invoked from network); 1 Dec 2021 14:00:07 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 1 Dec 2021 14:00:07 -0000
Date:   Wed, 1 Dec 2021 14:00:05 +0000
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
Message-ID: <20211201140005.GU3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
 <20211127011246.7a8ac7b8@mail.inbox.lv>
 <20211129150117.GO3366@techsingularity.net>
 <20211201010348.31e99637@mail.inbox.lv>
 <20211130172754.GS3366@techsingularity.net>
 <20211201033836.4382a474@mail.inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211201033836.4382a474@mail.inbox.lv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 01, 2021 at 03:38:36AM +0900, Alexey Avramov wrote:
> >due to the
> >underlying storage.
> 
> I agree.
> 
> >and send me the trace.out file please?
> 
> https://drive.google.com/file/d/1FBjAmXwXakWPPjcn6K-B50S04vyySQO6/view
> 
> Typical entries:
> 
>            Timer-10841   [006] ..... 14341.639496: mm_vmscan_throttled: nid=0 usec_timeout=100000 usect_delayed=100000 reason=VMSCAN_THROTTLE_WRITEBACK
>            gmain-1246    [004] ..... 14341.639498: mm_vmscan_throttled: nid=0 usec_timeout=100000 usect_delayed=100000 reason=VMSCAN_THROTTLE_WRITEBACK

Ok, the bulk of the stalls were for the same reason. Using a laptop with
slower storge (SSD but slower than the first laptop), the stalls were
almost all from the same reason and from one callsite -- shrink_node.

I've included another patch below against 5.16-rc1 but it'll apply to
5.16-rc3. Using the same test I get

Swap off
--------
Kernel: 5.15
2021-12-01 13:06:23,432: Peak values:  avg10  avg60 avg300
2021-12-01 13:06:23,432: -----------  ------ ------ ------
2021-12-01 13:06:23,433: some cpu       4.72   2.68   1.25
2021-12-01 13:06:23,433: -----------  ------ ------ ------
2021-12-01 13:06:23,433: some io        7.63   3.29   1.03
2021-12-01 13:06:23,433: full io        4.28   1.91   0.63
2021-12-01 13:06:23,433: -----------  ------ ------ ------
2021-12-01 13:06:23,433: some memory   13.28   4.80   1.20
2021-12-01 13:06:23,434: full memory   12.22   4.44   1.11
2021-12-01 13:06:23,434: Stall times for the last 45.5s:
2021-12-01 13:06:23,434: -----------
2021-12-01 13:06:23,434: some cpu     1.8s, avg 4.0%
2021-12-01 13:06:23,435: -----------
2021-12-01 13:06:23,435: some io      2.9s, avg 6.5%
2021-12-01 13:06:23,435: full io      1.8s, avg 4.0%
2021-12-01 13:06:23,435: -----------
2021-12-01 13:06:23,435: some memory  4.4s, avg 9.6%
2021-12-01 13:06:23,435: full memory  4.0s, avg 8.8%
2021-12-01 13:06:23,435:

Kernel: 5.16-rc1
2021-12-01 13:13:33,662: Peak values:  avg10  avg60 avg300
2021-12-01 13:13:33,663: -----------  ------ ------ ------
2021-12-01 13:13:33,663: some cpu       1.97   1.84   0.80
2021-12-01 13:13:33,663: -----------  ------ ------ ------
2021-12-01 13:13:33,663: some io       49.60  26.97  13.26
2021-12-01 13:13:33,663: full io       45.91  24.56  12.13
2021-12-01 13:13:33,663: -----------  ------ ------ ------
2021-12-01 13:13:33,663: some memory   98.49  93.94  54.09
2021-12-01 13:13:33,663: full memory   98.49  93.75  53.82
2021-12-01 13:13:33,664: Stall times for the last 291.0s:
2021-12-01 13:13:33,664: -----------
2021-12-01 13:13:33,664: some cpu     2.3s, avg 0.8%
2021-12-01 13:13:33,664: -----------
2021-12-01 13:13:33,664: some io      57.2s, avg 19.7%
2021-12-01 13:13:33,664: full io      52.9s, avg 18.2%
2021-12-01 13:13:33,664: -----------
2021-12-01 13:13:33,664: some memory  244.8s, avg 84.1%
2021-12-01 13:13:33,664: full memory  242.9s, avg 83.5%
2021-12-01 13:13:33,664:

Kernel: 5.16-rc1-v3r4
2021-12-01 13:16:46,910: Peak values:  avg10  avg60 avg300
2021-12-01 13:16:46,910: -----------  ------ ------ ------
2021-12-01 13:16:46,910: some cpu       2.91   2.04   0.97
2021-12-01 13:16:46,910: -----------  ------ ------ ------
2021-12-01 13:16:46,910: some io        6.59   2.94   1.00
2021-12-01 13:16:46,910: full io        3.95   1.82   0.62
2021-12-01 13:16:46,910: -----------  ------ ------ ------
2021-12-01 13:16:46,910: some memory   10.29   3.67   0.90
2021-12-01 13:16:46,911: full memory    9.82   3.46   0.84
2021-12-01 13:16:46,911: Stall times for the last 44.4s:
2021-12-01 13:16:46,911: -----------
2021-12-01 13:16:46,911: some cpu     1.2s, avg 2.7%
2021-12-01 13:16:46,911: -----------
2021-12-01 13:16:46,911: some io      2.4s, avg 5.4%
2021-12-01 13:16:46,911: full io      1.5s, avg 3.5%
2021-12-01 13:16:46,911: -----------
2021-12-01 13:16:46,911: some memory  3.2s, avg 7.1%
2021-12-01 13:16:46,911: full memory  3.0s, avg 6.7%
2021-12-01 13:16:46,911:

So stall times with v5.15 and with the patch are vaguely similar with
stall times for 5.16-rc1 being terrible

Swap on
-------

Kernel: 5.15
2021-12-01 13:23:04,392: Peak values:  avg10  avg60 avg300
2021-12-01 13:23:04,392: -----------  ------ ------ ------
2021-12-01 13:23:04,393: some cpu       8.02   5.19   2.93
2021-12-01 13:23:04,393: -----------  ------ ------ ------
2021-12-01 13:23:04,393: some io       77.30  61.75  37.00
2021-12-01 13:23:04,393: full io       62.33  50.53  29.98
2021-12-01 13:23:04,393: -----------  ------ ------ ------
2021-12-01 13:23:04,393: some memory   82.05  66.42  39.74
2021-12-01 13:23:04,393: full memory   73.27  57.79  34.39
2021-12-01 13:23:04,393: Stall times for the last 272.6s:
2021-12-01 13:23:04,393: -----------
2021-12-01 13:23:04,393: some cpu     13.7s, avg 5.0%
2021-12-01 13:23:04,393: -----------
2021-12-01 13:23:04,393: some io      167.4s, avg 61.4%
2021-12-01 13:23:04,393: full io      135.0s, avg 49.5%
2021-12-01 13:23:04,394: -----------
2021-12-01 13:23:04,394: some memory  180.4s, avg 66.2%
2021-12-01 13:23:04,394: full memory  155.9s, avg 57.2%
2021-12-01 13:23:04,394:

Kernel: 5.16-rc1
2021-12-01 13:35:01,025: Peak values:  avg10  avg60 avg300
2021-12-01 13:35:01,025: -----------  ------ ------ ------
2021-12-01 13:35:01,025: some cpu       4.03   2.51   1.46
2021-12-01 13:35:01,025: -----------  ------ ------ ------
2021-12-01 13:35:01,025: some io       61.02  38.02  25.97
2021-12-01 13:35:01,025: full io       53.30  32.69  22.18
2021-12-01 13:35:01,025: -----------  ------ ------ ------
2021-12-01 13:35:01,025: some memory   99.02  87.77  68.67
2021-12-01 13:35:01,025: full memory   98.66  85.18  65.45
2021-12-01 13:35:01,026: Stall times for the last 620.8s:
2021-12-01 13:35:01,026: -----------
2021-12-01 13:35:01,026: some cpu     11.9s, avg 1.9%
2021-12-01 13:35:01,026: -----------
2021-12-01 13:35:01,026: some io      182.9s, avg 29.5%
2021-12-01 13:35:01,026: full io      156.0s, avg 25.1%
2021-12-01 13:35:01,026: -----------
2021-12-01 13:35:01,026: some memory  463.1s, avg 74.6%
2021-12-01 13:35:01,026: full memory  437.0s, avg 70.4%
2021-12-01 13:35:01,026:

Kernel: 5.16-rc1-v3r4
2021-12-01 13:42:43,066: Peak values:  avg10  avg60 avg300
2021-12-01 13:42:43,066: -----------  ------ ------ ------
2021-12-01 13:42:43,066: some cpu       6.45   3.62   2.21
2021-12-01 13:42:43,066: -----------  ------ ------ ------
2021-12-01 13:42:43,066: some io       74.16  58.74  34.14
2021-12-01 13:42:43,066: full io       62.77  48.21  27.97
2021-12-01 13:42:43,066: -----------  ------ ------ ------
2021-12-01 13:42:43,066: some memory   78.82  62.85  36.39
2021-12-01 13:42:43,067: full memory   71.42  55.12  31.92
2021-12-01 13:42:43,067: Stall times for the last 257.2s:
2021-12-01 13:42:43,067: -----------
2021-12-01 13:42:43,067: some cpu     9.9s, avg 3.9%
2021-12-01 13:42:43,067: -----------
2021-12-01 13:42:43,067: some io      150.9s, avg 58.7%
2021-12-01 13:42:43,067: full io      123.2s, avg 47.9%
2021-12-01 13:42:43,067: -----------
2021-12-01 13:42:43,067: some memory  161.5s, avg 62.8%
2021-12-01 13:42:43,067: full memory  141.6s, avg 55.1%
2021-12-01 13:42:43,067:

Again 5.16-rc1 stuttered badly but the new patch was comparable to 5.15.

As my baseline figures are very different to yours due to differences in
storage, can you test the following please?

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 58e744b78c2c..936dc0b6c226 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -277,6 +277,7 @@ enum vmscan_throttle_state {
 	VMSCAN_THROTTLE_WRITEBACK,
 	VMSCAN_THROTTLE_ISOLATED,
 	VMSCAN_THROTTLE_NOPROGRESS,
+	VMSCAN_THROTTLE_CONGESTED,
 	NR_VMSCAN_THROTTLE,
 };
 
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index f25a6149d3ba..ca2e9009a651 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -30,12 +30,14 @@
 #define _VMSCAN_THROTTLE_WRITEBACK	(1 << VMSCAN_THROTTLE_WRITEBACK)
 #define _VMSCAN_THROTTLE_ISOLATED	(1 << VMSCAN_THROTTLE_ISOLATED)
 #define _VMSCAN_THROTTLE_NOPROGRESS	(1 << VMSCAN_THROTTLE_NOPROGRESS)
+#define _VMSCAN_THROTTLE_CONGESTED	(1 << VMSCAN_THROTTLE_CONGESTED)
 
 #define show_throttle_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",					\
 		{_VMSCAN_THROTTLE_WRITEBACK,	"VMSCAN_THROTTLE_WRITEBACK"},	\
 		{_VMSCAN_THROTTLE_ISOLATED,	"VMSCAN_THROTTLE_ISOLATED"},	\
-		{_VMSCAN_THROTTLE_NOPROGRESS,	"VMSCAN_THROTTLE_NOPROGRESS"}	\
+		{_VMSCAN_THROTTLE_NOPROGRESS,	"VMSCAN_THROTTLE_NOPROGRESS"},	\
+		{_VMSCAN_THROTTLE_CONGESTED,	"VMSCAN_THROTTLE_CONGESTED"}	\
 		) : "VMSCAN_THROTTLE_NONE"
 
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb9584641ac7..e3f2dd1e8cd9 100644
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
@@ -1056,8 +1089,16 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 		}
 
 		break;
+	case VMSCAN_THROTTLE_CONGESTED:
+		fallthrough;
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
@@ -3321,7 +3362,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	if (!current_is_kswapd() && current_may_throttle() &&
 	    !sc->hibernation_mode &&
 	    test_bit(LRUVEC_CONGESTED, &target_lruvec->flags))
-		reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_CONGESTED);
 
 	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
 				    sc))
@@ -3386,16 +3427,16 @@ static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
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
 
@@ -3415,6 +3456,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 	unsigned long nr_soft_scanned;
 	gfp_t orig_mask;
 	pg_data_t *last_pgdat = NULL;
+	pg_data_t *first_pgdat = NULL;
 
 	/*
 	 * If the number of buffer_heads in the machine exceeds the maximum
@@ -3478,14 +3520,18 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
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

-- 
Mel Gorman
SUSE Labs
