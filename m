Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794EA411182
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 11:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbhITJEj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 05:04:39 -0400
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:32897 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234857AbhITJEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:04:34 -0400
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Sep 2021 05:04:33 EDT
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id CC9E1FBD70
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Sep 2021 09:55:41 +0100 (IST)
Received: (qmail 29275 invoked from network); 20 Sep 2021 08:55:41 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 20 Sep 2021 08:55:41 -0000
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
Subject: [PATCH 5/5] mm/page_alloc: Remove the throttling logic from the page allocator
Date:   Mon, 20 Sep 2021 09:54:36 +0100
Message-Id: <20210920085436.20939-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210920085436.20939-1-mgorman@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The page allocator stalls based on the number of pages that are
waiting for writeback to start but this should now be redundant.
shrink_inactive_list() will wake flusher threads if the LRU tail are
unqueued dirty pages so the flusher should be active. If it fails to make
progress due to pages under writeback not being completed quickly then
it should stall on VMSCAN_THROTTLE_WRITEBACK.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 78e538067651..8fa0109ff417 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4795,30 +4795,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		trace_reclaim_retry_zone(z, order, reclaimable,
 				available, min_wmark, *no_progress_loops, wmark);
 		if (wmark) {
-			/*
-			 * If we didn't make any progress and have a lot of
-			 * dirty + writeback pages then we should wait for
-			 * an IO to complete to slow down the reclaim and
-			 * prevent from pre mature OOM
-			 */
-			if (!did_some_progress) {
-				unsigned long write_pending;
-
-				write_pending = zone_page_state_snapshot(zone,
-							NR_ZONE_WRITE_PENDING);
-
-				if (2 * write_pending > reclaimable) {
-					congestion_wait(BLK_RW_ASYNC, HZ/10);
-					return true;
-				}
-			}
-
 			ret = true;
-			goto out;
+			break;
 		}
 	}
 
-out:
 	/*
 	 * Memory allocation/reclaim might be called from a WQ context and the
 	 * current implementation of the WQ concurrency control doesn't
-- 
2.31.1

