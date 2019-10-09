Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E699D05EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 05:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfJIDVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 23:21:40 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:46801 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730098AbfJIDVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:21:36 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 532C943EB2A;
        Wed,  9 Oct 2019 14:21:28 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XW-0006BO-SU; Wed, 09 Oct 2019 14:21:26 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XW-00039H-QV; Wed, 09 Oct 2019 14:21:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/26] mm: directed shrinker work deferral
Date:   Wed,  9 Oct 2019 14:21:06 +1100
Message-Id: <20191009032124.10541-9-david@fromorbit.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20191009032124.10541-1-david@fromorbit.com>
References: <20191009032124.10541-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=XobE76Q3jBoA:10 a=20KFwNOVAAAA:8
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
index 0f80123650e2..3405c39ab92c 100644
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
+	bool defer_work;
 };
 
 #define SHRINK_STOP (~0UL)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c6659bb758a4..1445bc7578c0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -535,6 +535,13 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
 				   freeable, delta, total_scan, priority);
 
+	/*
+	 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
+	 * defer the work to a context that can scan the cache.
+	 */
+	if (shrinkctl->defer_work)
+		goto done;
+
 	/*
 	 * Normally, we should not scan less than batch_size objects in one
 	 * pass to avoid too frequent shrinker calls, but if the slab has less
@@ -569,6 +576,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		cond_resched();
 	}
 
+done:
 	if (next_deferred >= scanned)
 		next_deferred -= scanned;
 	else
-- 
2.23.0.rc1

