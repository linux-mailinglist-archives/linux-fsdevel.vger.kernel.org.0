Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B374EBB12
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 00:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfJaXsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 19:48:30 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:40221 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728395AbfJaXq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:46:28 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 947547EA8FA;
        Fri,  1 Nov 2019 10:46:20 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-0007C4-5A; Fri, 01 Nov 2019 10:46:19 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-00041O-2l; Fri, 01 Nov 2019 10:46:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/28] xfs: correctly acount for reclaimable slabs
Date:   Fri,  1 Nov 2019 10:45:55 +1100
Message-Id: <20191031234618.15403-6-david@fromorbit.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191031234618.15403-1-david@fromorbit.com>
References: <20191031234618.15403-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=20KFwNOVAAAA:8
        a=yPCof4ZbAAAA:8 a=Lohin5lSNhcegm5w81oA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

The XFS inode item slab actually reclaimed by inode shrinker
callbacks from the memory reclaim subsystem. These should be marked
as reclaimable so the mm subsystem has the full picture of how much
memory it can actually reclaim from the XFS slab caches.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index bcb1575a5652..ebe2ccd36127 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1876,7 +1876,7 @@ xfs_init_zones(void)
 
 	xfs_ili_zone =
 		kmem_zone_init_flags(sizeof(xfs_inode_log_item_t), "xfs_ili",
-					KM_ZONE_SPREAD, NULL);
+					KM_ZONE_SPREAD | KM_ZONE_RECLAIM, NULL);
 	if (!xfs_ili_zone)
 		goto out_destroy_inode_zone;
 	xfs_icreate_zone = kmem_zone_init(sizeof(struct xfs_icreate_item),
-- 
2.24.0.rc0

