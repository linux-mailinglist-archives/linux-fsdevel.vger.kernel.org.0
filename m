Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB2F1EBB1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 00:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfJaXq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 19:46:27 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:39711 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728207AbfJaXqZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:46:25 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 692A27EA8CC;
        Fri,  1 Nov 2019 10:46:20 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-0007Bw-0I; Fri, 01 Nov 2019 10:46:19 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8w-00041C-Te; Fri, 01 Nov 2019 10:46:18 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/28] xfs: Lower CIL flush limit for large logs
Date:   Fri,  1 Nov 2019 10:45:51 +1100
Message-Id: <20191031234618.15403-2-david@fromorbit.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191031234618.15403-1-david@fromorbit.com>
References: <20191031234618.15403-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=20KFwNOVAAAA:8
        a=yPCof4ZbAAAA:8 a=UuDO-KUg2xYWwgiXHJ0A:9
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

Flushing the CIL can take some time to do if there is other IO
ongoing, and can introduce substantial log force latency by itself.
It also pins the memory until the objects are in the AIL and can be
written back and reclaimed by shrinkers. Hence this threshold also
tends to determine the minimum amount of memory XFS can operate in
under heavy modification without triggering the OOM killer.

Modify the CIL space limit to prevent such huge amounts of pinned
metadata from aggregating. We can have 2MB of log IO in flight at
once, so limit aggregation to 16x this size. This threshold was
chosen as it little impact on performance (on 16-way fsmark) or log
traffic but pins a lot less memory on large logs especially under
heavy memory pressure.  An aggregation limit of 8x had 5-10%
performance degradation and a 50% increase in log throughput for
the same workload, so clearly that was too small for highly
concurrent workloads on large logs.

This was found via trace analysis of AIL behaviour. e.g. insertion
from a single CIL flush:

xfs_ail_insert: old lsn 0/0 new lsn 1/3033090 type XFS_LI_INODE flags IN_AIL

$ grep xfs_ail_insert /mnt/scratch/s.t |grep "new lsn 1/3033090" |wc -l
1721823
$

So there were 1.7 million objects inserted into the AIL from this
CIL checkpoint, the first at 2323.392108, the last at 2325.667566 which
was the end of the trace (i.e. it hadn't finished). Clearly a major
problem.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_log_priv.h | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index 4f19375f6592..abd382cfffe3 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -318,13 +318,30 @@ struct xfs_cil {
  * tries to keep 25% of the log free, so we need to keep below that limit or we
  * risk running out of free log space to start any new transactions.
  *
- * In order to keep background CIL push efficient, we will set a lower
- * threshold at which background pushing is attempted without blocking current
- * transaction commits.  A separate, higher bound defines when CIL pushes are
- * enforced to ensure we stay within our maximum checkpoint size bounds.
- * threshold, yet give us plenty of space for aggregation on large logs.
+ * In order to keep background CIL push efficient, we only need to ensure the
+ * CIL is large enough to maintain sufficient in-memory relogging to avoid
+ * repeated physical writes of frequently modified metadata. If we allow the CIL
+ * to grow to a substantial fraction of the log, then we may be pinning hundreds
+ * of megabytes of metadata in memory until the CIL flushes. This can cause
+ * issues when we are running low on memory - pinned memory cannot be reclaimed,
+ * and the CIL consumes a lot of memory. Hence we need to set an upper physical
+ * size limit for the CIL that limits the maximum amount of memory pinned by the
+ * CIL but does not limit performance by reducing relogging efficiency
+ * significantly.
+ *
+ * As such, the CIL push threshold ends up being the smaller of two thresholds:
+ * - a threshold large enough that it allows CIL to be pushed and progress to be
+ *   made without excessive blocking of incoming transaction commits. This is
+ *   defined to be 12.5% of the log space - half the 25% push threshold of the
+ *   AIL.
+ * - small enough that it doesn't pin excessive amounts of memory but maintains
+ *   close to peak relogging efficiency. This is defined to be 16x the iclog
+ *   buffer window (32MB) as measurements have shown this to be roughly the
+ *   point of diminishing performance increases under highly concurrent
+ *   modification workloads.
  */
-#define XLOG_CIL_SPACE_LIMIT(log)	(log->l_logsize >> 3)
+#define XLOG_CIL_SPACE_LIMIT(log)	\
+	min_t(int, (log)->l_logsize >> 3, BBTOB(XLOG_TOTAL_REC_SHIFT(log)) << 4)
 
 /*
  * ticket grant locks, queues and accounting have their own cachlines
-- 
2.24.0.rc0

