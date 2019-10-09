Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE12CD0609
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 05:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfJIDVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 23:21:54 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:58007 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730496AbfJIDVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:21:35 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 56B213632DC;
        Wed,  9 Oct 2019 14:21:28 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XX-0006Bj-61; Wed, 09 Oct 2019 14:21:27 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XX-00039c-47; Wed, 09 Oct 2019 14:21:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/26] mm: kswapd backoff for shrinkers
Date:   Wed,  9 Oct 2019 14:21:13 +1100
Message-Id: <20191009032124.10541-16-david@fromorbit.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20191009032124.10541-1-david@fromorbit.com>
References: <20191009032124.10541-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=XobE76Q3jBoA:10 a=20KFwNOVAAAA:8
        a=NNMOctoXzqbiiAOzY8AA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

When kswapd reaches the end of the page LRU and starts hitting dirty
pages, the logic in shrink_node() allows it to back off and wait for
IO to complete, thereby preventing kswapd from scanning excessively
and driving the system into swap thrashing and OOM conditions.

When we have inode cache heavy workloads on XFS, we have exactly the
same problem with reclaim inodes. The non-blocking kswapd reclaim
will keep putting pressure onto the inode cache which is unable to
make progress. When the system gets to the point where there is no
pages in the LRU to free, there is no swap left and there are no
clean inodes that can be freed, it will OOM. This has a specific
signature in OOM:

[  110.841987] Mem-Info:
[  110.842816] active_anon:241 inactive_anon:82 isolated_anon:1
                active_file:168 inactive_file:143 isolated_file:0
                unevictable:2621523 dirty:1 writeback:8 unstable:0
                slab_reclaimable:564445 slab_unreclaimable:420046
                mapped:1042 shmem:11 pagetables:6509 bounce:0
                free:77626 free_pcp:2 free_cma:0

In this case, we have about 500-600 pages left in teh LRUs, but we
have ~565000 reclaimable slab pages still available for reclaim.
Unfortunately, they are mostly dirty inodes, and so we really need
to be able to throttle kswapd when shrinker progress is limited due
to reaching the dirty end of the LRU...

So, add a flag into the reclaim_state so if the shrinker decides it
needs kswapd to back off and wait for a while (for whatever reason)
it can do so.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/swap.h |  1 +
 mm/vmscan.c          | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index da0913e14bb9..76fc28f0e483 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -133,6 +133,7 @@ struct reclaim_state {
 	unsigned long	reclaimed_pages;	/* pages freed by shrinkers */
 	unsigned long	scanned_objects;	/* quantity of work done */ 
 	unsigned long	deferred_objects;	/* work that wasn't done */
+	bool		need_backoff;		/* tell kswapd to slow down */
 };
 
 /*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fe8e8508f98d..c56a9ac6d042 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2951,8 +2951,16 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			 * implies that pages are cycling through the LRU
 			 * faster than they are written so also forcibly stall.
 			 */
-			if (sc->nr.immediate)
+			if (sc->nr.immediate) {
 				congestion_wait(BLK_RW_ASYNC, HZ/10);
+			} else if (reclaim_state && reclaim_state->need_backoff) {
+				/*
+				 * Ditto, but it's a slab cache that is cycling
+				 * through the LRU faster than they are written
+				 */
+				congestion_wait(BLK_RW_ASYNC, HZ/10);
+				reclaim_state->need_backoff = false;
+			}
 		}
 
 		/*
-- 
2.23.0.rc1

