Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D3A426C1C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 15:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242229AbhJHN4V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 09:56:21 -0400
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:44797 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241536AbhJHN4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:56:20 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 2C96CCACD7
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Oct 2021 14:54:24 +0100 (IST)
Received: (qmail 6769 invoked from network); 8 Oct 2021 13:54:23 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 8 Oct 2021 13:54:23 -0000
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
Subject: [PATCH 4/8] mm/writeback: Throttle based on page writeback instead of congestion
Date:   Fri,  8 Oct 2021 14:53:28 +0100
Message-Id: <20211008135332.19567-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008135332.19567-1-mgorman@techsingularity.net>
References: <20211008135332.19567-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

do_writepages throttles on congestion if the writepages() fails due to a
lack of memory but congestion_wait() is partially broken as the congestion
state is not updated for all BDIs.

This patch stalls waiting for a number of pages to complete writeback
that located on the local node. The main weakness is that there is no
correlation between the location of the inode's pages and locality but
that is still better than congestion_wait.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page-writeback.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 4812a17b288c..f34f54fcd5b4 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2366,8 +2366,15 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 			ret = generic_writepages(mapping, wbc);
 		if ((ret != -ENOMEM) || (wbc->sync_mode != WB_SYNC_ALL))
 			break;
-		cond_resched();
-		congestion_wait(BLK_RW_ASYNC, HZ/50);
+
+		/*
+		 * Lacking an allocation context or the locality or writeback
+		 * state of any of the inode's pages, throttle based on
+		 * writeback activity on the local node. It's as good a
+		 * guess as any.
+		 */
+		reclaim_throttle(NODE_DATA(numa_node_id()),
+			VMSCAN_THROTTLE_WRITEBACK, HZ/50);
 	}
 	/*
 	 * Usually few pages are written by now from those we've just submitted
-- 
2.31.1

