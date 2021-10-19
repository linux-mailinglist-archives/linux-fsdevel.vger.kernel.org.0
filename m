Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FA74331C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 11:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhJSJEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 05:04:55 -0400
Received: from outbound-smtp35.blacknight.com ([46.22.139.218]:42431 "EHLO
        outbound-smtp35.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234908AbhJSJEy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:04:54 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 111EB2788
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 10:02:41 +0100 (IST)
Received: (qmail 10926 invoked from network); 19 Oct 2021 09:02:40 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 19 Oct 2021 09:02:40 -0000
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
Subject: [PATCH 8/8] mm/vmscan: Delay waking of tasks throttled on NOPROGRESS
Date:   Tue, 19 Oct 2021 10:01:08 +0100
Message-Id: <20211019090108.25501-9-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019090108.25501-1-mgorman@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tracing indicates that tasks throttled on NOPROGRESS are woken
prematurely resulting in occasional massive spikes in direct
reclaim activity. This patch wakes tasks throttled on NOPROGRESS
if reclaim efficiency is at least 12%.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/vmscan.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ec2006680242..28adc196353d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1057,7 +1057,7 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 	ret = schedule_timeout(timeout);
 	finish_wait(wqh, &wait);
 
-	if (reason == VMSCAN_THROTTLE_ISOLATED)
+	if (reason == VMSCAN_THROTTLE_WRITEBACK)
 		atomic_dec(&pgdat->nr_writeback_throttled);
 
 	trace_mm_vmscan_throttled(pgdat->node_id, jiffies_to_usecs(timeout),
@@ -3349,8 +3349,11 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 
 static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
 {
-	/* If reclaim is making progress, wake any throttled tasks. */
-	if (sc->nr_reclaimed) {
+	/*
+	 * If reclaim is making progress greater than 12% efficiency then
+	 * wake all the NOPROGRESS throttled tasks.
+	 */
+	if (sc->nr_reclaimed > (sc->nr_scanned >> 3)) {
 		wait_queue_head_t *wqh;
 
 		wqh = &pgdat->reclaim_wait[VMSCAN_THROTTLE_NOPROGRESS];
-- 
2.31.1

