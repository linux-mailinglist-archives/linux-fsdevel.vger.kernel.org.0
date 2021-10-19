Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFED54331BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 11:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbhJSJE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 05:04:27 -0400
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:39945 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234962AbhJSJEY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:04:24 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 3BC9D1C60E2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 10:02:10 +0100 (IST)
Received: (qmail 8615 invoked from network); 19 Oct 2021 09:02:10 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 19 Oct 2021 09:02:09 -0000
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
Subject: [PATCH 5/8] mm/page_alloc: Remove the throttling logic from the page allocator
Date:   Tue, 19 Oct 2021 10:01:05 +0100
Message-Id: <20211019090108.25501-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019090108.25501-1-mgorman@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>
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

