Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AD4426C22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 15:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbhJHN4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 09:56:54 -0400
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:38849 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242338AbhJHN4u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:56:50 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id BF33B1BD5
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Oct 2021 14:54:54 +0100 (IST)
Received: (qmail 7895 invoked from network); 8 Oct 2021 13:54:54 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 8 Oct 2021 13:54:54 -0000
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
Subject: [PATCH 7/8] mm/vmscan: Increase the timeout if page reclaim is not making progress
Date:   Fri,  8 Oct 2021 14:53:31 +0100
Message-Id: <20211008135332.19567-8-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008135332.19567-1-mgorman@techsingularity.net>
References: <20211008135332.19567-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tracing of the stutterp workload showed the following delays

      1 usect_delayed=124000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usect_delayed=128000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usect_delayed=176000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usect_delayed=536000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usect_delayed=544000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usect_delayed=556000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usect_delayed=624000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usect_delayed=716000 reason=VMSCAN_THROTTLE_NOPROGRESS
      1 usect_delayed=772000 reason=VMSCAN_THROTTLE_NOPROGRESS
      2 usect_delayed=512000 reason=VMSCAN_THROTTLE_NOPROGRESS
     16 usect_delayed=120000 reason=VMSCAN_THROTTLE_NOPROGRESS
     53 usect_delayed=116000 reason=VMSCAN_THROTTLE_NOPROGRESS
    116 usect_delayed=112000 reason=VMSCAN_THROTTLE_NOPROGRESS
   5907 usect_delayed=108000 reason=VMSCAN_THROTTLE_NOPROGRESS
  71741 usect_delayed=104000 reason=VMSCAN_THROTTLE_NOPROGRESS

All the throttling hit the full timeout and then there was wakeup delays
meaning that the wakeups are premature as no other reclaimer such as
kswapd has made progress. This patch increases the maximum timeout.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/vmscan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e096e81dcbd8..7b54fec4072c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1038,6 +1038,8 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 	 */
 	switch(reason) {
 	case VMSCAN_THROTTLE_NOPROGRESS:
+		timeout = HZ/2;
+		break;
 	case VMSCAN_THROTTLE_WRITEBACK:
 		timeout = HZ/10;
 		break;
-- 
2.31.1

