Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98058426C19
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 15:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241411AbhJHN4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 09:56:14 -0400
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:51666 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241376AbhJHN4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:56:11 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id D2485C0C98
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Oct 2021 14:54:13 +0100 (IST)
Received: (qmail 6295 invoked from network); 8 Oct 2021 13:54:13 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 8 Oct 2021 13:54:13 -0000
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
Subject: [PATCH 3/8] mm/vmscan: Throttle reclaim when no progress is being made
Date:   Fri,  8 Oct 2021 14:53:27 +0100
Message-Id: <20211008135332.19567-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008135332.19567-1-mgorman@techsingularity.net>
References: <20211008135332.19567-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Memcg reclaim throttles on congestion if no reclaim progress is made.
This makes little sense, it might be due to writeback or a host of
other factors.

For !memcg reclaim, it's messy. Direct reclaim primarily is throttled
in the page allocator if it is failing to make progress. Kswapd
throttles if too many pages are under writeback and marked for
immediate reclaim.

This patch explicitly throttles if reclaim is failing to make progress.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mmzone.h        |  1 +
 include/trace/events/vmscan.h |  4 +++-
 mm/memcontrol.c               | 10 +--------
 mm/vmscan.c                   | 38 +++++++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ca65d6a64bdd..7c08cc91d526 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -276,6 +276,7 @@ enum lru_list {
 enum vmscan_throttle_state {
 	VMSCAN_THROTTLE_WRITEBACK,
 	VMSCAN_THROTTLE_ISOLATED,
+	VMSCAN_THROTTLE_NOPROGRESS,
 	NR_VMSCAN_THROTTLE,
 };
 
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index d4905bd9e9c4..f25a6149d3ba 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -29,11 +29,13 @@
 
 #define _VMSCAN_THROTTLE_WRITEBACK	(1 << VMSCAN_THROTTLE_WRITEBACK)
 #define _VMSCAN_THROTTLE_ISOLATED	(1 << VMSCAN_THROTTLE_ISOLATED)
+#define _VMSCAN_THROTTLE_NOPROGRESS	(1 << VMSCAN_THROTTLE_NOPROGRESS)
 
 #define show_throttle_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",					\
 		{_VMSCAN_THROTTLE_WRITEBACK,	"VMSCAN_THROTTLE_WRITEBACK"},	\
-		{_VMSCAN_THROTTLE_ISOLATED,	"VMSCAN_THROTTLE_ISOLATED"}	\
+		{_VMSCAN_THROTTLE_ISOLATED,	"VMSCAN_THROTTLE_ISOLATED"},	\
+		{_VMSCAN_THROTTLE_NOPROGRESS,	"VMSCAN_THROTTLE_NOPROGRESS"}	\
 		) : "VMSCAN_THROTTLE_NONE"
 
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6da5020a8656..8b33152c9b85 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3465,19 +3465,11 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 
 	/* try to free all pages in this cgroup */
 	while (nr_retries && page_counter_read(&memcg->memory)) {
-		int progress;
-
 		if (signal_pending(current))
 			return -EINTR;
 
-		progress = try_to_free_mem_cgroup_pages(memcg, 1,
-							GFP_KERNEL, true);
-		if (!progress) {
+		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL, true))
 			nr_retries--;
-			/* maybe some writeback is necessary */
-			congestion_wait(BLK_RW_ASYNC, HZ/10);
-		}
-
 	}
 
 	return 0;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9ce4195d4123..cdebfc618179 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3311,6 +3311,33 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 	return zone_watermark_ok_safe(zone, 0, watermark, sc->reclaim_idx);
 }
 
+static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
+{
+	/* If reclaim is making progress, wake any throttled tasks. */
+	if (sc->nr_reclaimed) {
+		wait_queue_head_t *wqh;
+
+		wqh = &pgdat->reclaim_wait[VMSCAN_THROTTLE_NOPROGRESS];
+		if (waitqueue_active(wqh))
+			wake_up_all(wqh);
+
+		return;
+	}
+
+	/*
+	 * Do not throttle kswapd on NOPROGRESS as it will throttle on
+	 * VMSCAN_THROTTLE_WRITEBACK if there are too many pages under
+	 * writeback and marked for immediate reclaim at the tail of
+	 * the LRU.
+	 */
+	if (current_is_kswapd())
+		return;
+
+	/* Throttle if making no progress at high prioities. */
+	if (sc->priority < DEF_PRIORITY - 2)
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS, HZ/10);
+}
+
 /*
  * This is the direct reclaim path, for page-allocating processes.  We only
  * try to reclaim pages from zones which will satisfy the caller's allocation
@@ -3395,6 +3422,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 			continue;
 		last_pgdat = zone->zone_pgdat;
 		shrink_node(zone->zone_pgdat, sc);
+		consider_reclaim_throttle(zone->zone_pgdat, sc);
 	}
 
 	/*
@@ -3769,6 +3797,16 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
 	set_task_reclaim_state(current, NULL);
 
+	if (!nr_reclaimed) {
+		struct zoneref *z;
+		pg_data_t *pgdat;
+
+		z = first_zones_zonelist(zonelist, sc.reclaim_idx, sc.nodemask);
+		pgdat = zonelist_zone(z)->zone_pgdat;
+
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS, HZ/10);
+	}
+
 	return nr_reclaimed;
 }
 #endif
-- 
2.31.1

