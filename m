Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF6FE7D33A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 04:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfHACSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 22:18:06 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:60926 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728398AbfHACSC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:18:02 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A28C443E4AA;
        Thu,  1 Aug 2019 12:17:58 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0eB-0003b8-9B; Thu, 01 Aug 2019 12:16:51 +1000
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0fH-0001lK-7I; Thu, 01 Aug 2019 12:17:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/24] xfs: Lower CIL flush limit for large logs
Date:   Thu,  1 Aug 2019 12:17:44 +1000
Message-Id: <20190801021752.4986-17-david@fromorbit.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801021752.4986-1-david@fromorbit.com>
References: <20190801021752.4986-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=FmdZ9Uzk2mMA:10 a=20KFwNOVAAAA:8
        a=y69QCnB_skpws7lHVjcA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

The current CIL size aggregation limit is 1/8th the log size. This
means for large logs we might be aggregating at least 250MB of dirty objects
in memory before the CIL is flushed to the journal. With CIL shadow
buffers sitting around, this means the CIL is often consuming >500MB
of temporary memory that is all allocated under GFP_NOFS conditions.

FLushing the CIL can take some time to do if there is other IO
ongoing, and can introduce substantial log force latency by itself.
It also pins the memory until the objects are in the AIL and can be
written back and reclaimed by shrinkers. Hence this threshold also
tends to determine the minimum amount of memory XFS can operate in
under heavy modification without triggering the OOM killer.

Modify the CIL space limit to prevent such huge amounts of pinned
metadata from aggregating. We can 2MB of log IO in flight at once,
so limit aggregation to 8x this size (arbitrary). This has some
impact on performance (5-10% decrease on 16-way fsmark) and
increases the amount of log traffic (~50% on same workload) but it
is necessary to prevent rampant OOM killing under iworkloads that
modify large amounts of metadata under heavy memory pressure.

This was found via trace analysis or AIL behaviour. e.g. insertion
from a single CIL flush:

xfs_ail_insert: old lsn 0/0 new lsn 1/3033090 type XFS_LI_INODE flags IN_AIL

$ grep xfs_ail_insert /mnt/scratch/s.t |grep "new lsn 1/3033090" |wc -l
1721823
$

So there were 1.7 million objects inserted into the AIL from this
CIL checkpoint, the first at 2323.392108, the last at 2325.667566 which
was the end of the trace (i.e. it hadn't finished). Clearly a major
problem.

XXX: Need to try bigger sizes to see where the performance/stability
boundary lies to see if some of the losses can be regained and log
bandwidth increases minimised.

XXX: Ideally this threshold should slide with memory pressure. We
can allow large amounts of metadata to build up when there is no
memory pressure, but then close the window as memory pressure builds
up to reduce the footprint of the CIL until memory pressure passes.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_log_priv.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index b880c23cb6e4..87c6191daef7 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -329,7 +329,8 @@ struct xfs_cil {
  * enforced to ensure we stay within our maximum checkpoint size bounds.
  * threshold, yet give us plenty of space for aggregation on large logs.
  */
-#define XLOG_CIL_SPACE_LIMIT(log)	(log->l_logsize >> 3)
+#define XLOG_CIL_SPACE_LIMIT(log)	\
+	min_t(int, (log)->l_logsize >> 3, XLOG_TOTAL_REC_SHIFT(log) << 3)
 
 /*
  * ticket grant locks, queues and accounting have their own cachlines
-- 
2.22.0

