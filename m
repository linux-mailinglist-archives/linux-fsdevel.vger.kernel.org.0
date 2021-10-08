Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D66426C24
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 15:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242370AbhJHN5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 09:57:02 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:56298 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234113AbhJHN5B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:57:01 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 1B4E6CACD8
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Oct 2021 14:55:05 +0100 (IST)
Received: (qmail 8314 invoked from network); 8 Oct 2021 13:55:04 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 8 Oct 2021 13:55:04 -0000
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
Subject: [PATCH 8/8] mm/vmscan: Delay waking of tasks throttled on NOPROGRESS
Date:   Fri,  8 Oct 2021 14:53:32 +0100
Message-Id: <20211008135332.19567-9-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008135332.19567-1-mgorman@techsingularity.net>
References: <20211008135332.19567-1-mgorman@techsingularity.net>
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
---
 mm/vmscan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7b54fec4072c..80a9a26f701f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3338,8 +3338,11 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 
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

