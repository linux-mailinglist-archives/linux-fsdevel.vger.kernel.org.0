Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F89437945
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 16:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhJVOum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 10:50:42 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:44081 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233096AbhJVOum (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 10:50:42 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id C58C918E126
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 15:48:23 +0100 (IST)
Received: (qmail 32390 invoked from network); 22 Oct 2021 14:48:23 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 22 Oct 2021 14:48:23 -0000
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
Date:   Fri, 22 Oct 2021 15:46:51 +0100
Message-Id: <20211022144651.19914-9-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211022144651.19914-1-mgorman@techsingularity.net>
References: <20211022144651.19914-1-mgorman@techsingularity.net>
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
 mm/vmscan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 35b6ccaa01c3..812d4697d50d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
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

