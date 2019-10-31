Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18DE4EBAF5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 00:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfJaXrl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 19:47:41 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:40131 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728696AbfJaXqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:46:32 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 61A077EA3C0;
        Fri,  1 Nov 2019 10:46:26 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-0007CU-Jz; Fri, 01 Nov 2019 10:46:19 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-000421-Hp; Fri, 01 Nov 2019 10:46:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/28] xfs: don't block kswapd in inode reclaim
Date:   Fri,  1 Nov 2019 10:46:08 +1100
Message-Id: <20191031234618.15403-19-david@fromorbit.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191031234618.15403-1-david@fromorbit.com>
References: <20191031234618.15403-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=20KFwNOVAAAA:8
        a=x2yLRZ3W9cWBXR4-ZBgA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

We have a number of reasons for blocking kswapd in XFS inode
reclaim, mainly all to do with the fact that memory reclaim has no
feedback mechanisms to throttle on dirty slab objects that need IO
to reclaim.

As a result, we currently throttle inode reclaim by issuing IO in
the reclaim context. The unfortunate side effect of this is that it
can cause long tail latencies in reclaim and for some workloads this
can be a problem.

Now that the shrinkers finally have a method of telling kswapd to
back off, we can start the process of making inode reclaim in XFS
non-blocking. The first thing we need to do is not block kswapd, but
so that doesn't cause immediate serious problems, make sure inode
writeback is always underway when kswapd is running.

As we don't block kswapd now, we don't have to worry about reclaim
scans taking long delays due to IO being issued and waited for.
Hence while direct reclaim gets delayed by IO, kswapd will not and
so it will keep pushing the AIL to clean inodes. Hence direct
reclaim doesn't need to push the AIL anymore as kswapd will do it
reliably now.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_icache.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 944add5ff8e0..edcc3f6bb3bf 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1378,11 +1378,22 @@ xfs_reclaim_inodes_nr(
 	struct xfs_mount	*mp,
 	int			nr_to_scan)
 {
-	/* kick background reclaimer and push the AIL */
+	int			sync_mode = SYNC_TRYLOCK;
+
+	/* kick background reclaimer */
 	xfs_reclaim_work_queue(mp);
-	xfs_ail_push_all(mp->m_ail);
 
-	return xfs_reclaim_inodes_ag(mp, SYNC_TRYLOCK | SYNC_WAIT, &nr_to_scan);
+	/*
+	 * For kswapd, we kick background inode writeback. For direct
+	 * reclaim, we issue and wait on inode writeback to throttle
+	 * reclaim rates and avoid shouty OOM-death.
+	 */
+	if (current_is_kswapd())
+		xfs_ail_push_all(mp->m_ail);
+	else
+		sync_mode |= SYNC_WAIT;
+
+	return xfs_reclaim_inodes_ag(mp, sync_mode, &nr_to_scan);
 }
 
 /*
-- 
2.24.0.rc0

