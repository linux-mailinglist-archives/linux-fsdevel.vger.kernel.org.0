Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33CCC7D329
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 04:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfHACSQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 22:18:16 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:35254 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729354AbfHACSL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:18:11 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5532E361C52;
        Thu,  1 Aug 2019 12:17:57 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0eA-0003aO-Nk; Thu, 01 Aug 2019 12:16:50 +1000
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0fG-0001kZ-L8; Thu, 01 Aug 2019 12:17:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/24] mm: directed shrinker work deferral
Date:   Thu,  1 Aug 2019 12:17:29 +1000
Message-Id: <20190801021752.4986-2-david@fromorbit.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801021752.4986-1-david@fromorbit.com>
References: <20190801021752.4986-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=FmdZ9Uzk2mMA:10 a=20KFwNOVAAAA:8
        a=3J8m_CEvPCn7CZIx0tYA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Introduce a mechanism for ->count_objects() to indicate to the
shrinker infrastructure that the reclaim context will not allow
scanning work to be done and so the work it decides is necessary
needs to be deferred.

This simplifies the code by separating out the accounting of
deferred work from the actual doing of the work, and allows better
decisions to be made by the shrinekr control logic on what action it
can take.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/shrinker.h | 7 +++++++
 mm/vmscan.c              | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 9443cafd1969..af78c475fc32 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -31,6 +31,13 @@ struct shrink_control {
 
 	/* current memcg being shrunk (for memcg aware shrinkers) */
 	struct mem_cgroup *memcg;
+
+	/*
+	 * set by ->count_objects if reclaim context prevents reclaim from
+	 * occurring. This allows the shrinker to immediately defer all the
+	 * work and not even attempt to scan the cache.
+	 */
+	bool will_defer;
 };
 
 #define SHRINK_STOP (~0UL)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 44df66a98f2a..ae3035fe94bc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -541,6 +541,13 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
 				   freeable, delta, total_scan, priority);
 
+	/*
+	 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
+	 * defer the work to a context that can scan the cache.
+	 */
+	if (shrinkctl->will_defer)
+		goto done;
+
 	/*
 	 * Normally, we should not scan less than batch_size objects in one
 	 * pass to avoid too frequent shrinker calls, but if the slab has less
@@ -575,6 +582,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		cond_resched();
 	}
 
+done:
 	if (next_deferred >= scanned)
 		next_deferred -= scanned;
 	else
-- 
2.22.0

