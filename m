Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1123C7D31F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 04:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfHACSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 22:18:07 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:35254 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728848AbfHACSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:18:05 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B13D136185C;
        Thu,  1 Aug 2019 12:17:58 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0eB-0003bB-Ak; Thu, 01 Aug 2019 12:16:51 +1000
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0fH-0001lN-8Z; Thu, 01 Aug 2019 12:17:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/24] xfs: don't block kswapd in inode reclaim
Date:   Thu,  1 Aug 2019 12:17:45 +1000
Message-Id: <20190801021752.4986-18-david@fromorbit.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801021752.4986-1-david@fromorbit.com>
References: <20190801021752.4986-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=FmdZ9Uzk2mMA:10 a=20KFwNOVAAAA:8
        a=lu14g41xD__19t-wDHQA:9
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

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_icache.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 0b0fd10a36d4..2fa2f8dcf86b 100644
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
2.22.0

