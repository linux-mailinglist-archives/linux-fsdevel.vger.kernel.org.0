Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E23D05E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 05:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbfJIDVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 23:21:39 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:57923 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730479AbfJIDVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:21:37 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6CC1C36271F;
        Wed,  9 Oct 2019 14:21:28 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XW-0006B7-N8; Wed, 09 Oct 2019 14:21:26 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XW-000391-LG; Wed, 09 Oct 2019 14:21:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/26] xfs: don't allow log IO to be throttled
Date:   Wed,  9 Oct 2019 14:21:01 +1100
Message-Id: <20191009032124.10541-4-david@fromorbit.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20191009032124.10541-1-david@fromorbit.com>
References: <20191009032124.10541-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=XobE76Q3jBoA:10 a=20KFwNOVAAAA:8
        a=5HahVxdoFHTWBnBQlCYA:9 a=DiKeHqHhRZ4A:10
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Running metadata intensive workloads, I've been seeing the AIL
pushing getting stuck on pinned buffers and triggering log forces.
The log force is taking a long time to run because the log IO is
getting throttled by wbt_wait() - the block layer writeback
throttle. It's being throttled because there is a huge amount of
metadata writeback going on which is filling the request queue.

IOWs, we have a priority inversion problem here.

Mark the log IO bios with REQ_IDLE so they don't get throttled
by the block layer writeback throttle. When we are forcing the CIL,
we are likely to need to to tens of log IOs, and they are issued as
fast as they can be build and IO completed. Hence REQ_IDLE is
appropriate - it's an indication that more IO will follow shortly.

And because we also set REQ_SYNC, the writeback throttle will no
treat log IO the same way it treats direct IO writes - it will not
throttle them at all. Hence we solve the priority inversion problem
caused by the writeback throttle being unable to distinguish between
high priority log IO and background metadata writeback.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_log.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 6f99d6eae6a4..cf098e19967e 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1751,7 +1751,15 @@ xlog_write_iclog(
 	iclog->ic_bio.bi_iter.bi_sector = log->l_logBBstart + bno;
 	iclog->ic_bio.bi_end_io = xlog_bio_end_io;
 	iclog->ic_bio.bi_private = iclog;
-	iclog->ic_bio.bi_opf = REQ_OP_WRITE | REQ_META | REQ_SYNC | REQ_FUA;
+
+	/*
+	 * We use REQ_SYNC | REQ_IDLE here to tell the block layer the are more
+	 * IOs coming immediately after this one. This prevents the block layer
+	 * writeback throttle from throttling log writes behind background
+	 * metadata writeback and causing priority inversions.
+	 */
+	iclog->ic_bio.bi_opf = REQ_OP_WRITE | REQ_META | REQ_SYNC |
+				REQ_IDLE | REQ_FUA;
 	if (need_flush)
 		iclog->ic_bio.bi_opf |= REQ_PREFLUSH;
 
-- 
2.23.0.rc1

