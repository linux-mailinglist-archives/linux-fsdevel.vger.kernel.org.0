Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 880A0D05DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 05:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfJIDVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 23:21:34 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:57921 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730475AbfJIDVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:21:33 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4133D362EDA;
        Wed,  9 Oct 2019 14:21:27 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XW-0006B9-Nw; Wed, 09 Oct 2019 14:21:26 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XW-000395-M9; Wed, 09 Oct 2019 14:21:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/26] xfs: Improve metadata buffer reclaim accountability
Date:   Wed,  9 Oct 2019 14:21:02 +1100
Message-Id: <20191009032124.10541-5-david@fromorbit.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20191009032124.10541-1-david@fromorbit.com>
References: <20191009032124.10541-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=XobE76Q3jBoA:10 a=20KFwNOVAAAA:8
        a=1dk79d6Hl8FtNpQQbMkA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

The buffer cache shrinker frees more than just the xfs_buf slab
objects - it also frees the pages attached to the buffers. Make sure
the memory reclaim code accounts for this memory being freed
correctly, similar to how the inode shrinker accounts for pages
freed from the page cache due to mapping invalidation.

We also need to make sure that the mm subsystem knows these are
reclaimable objects. We provide the memory reclaim subsystem with a
a shrinker to reclaim xfs_bufs, so we should really mark the slab
that way.

We also have a lot of xfs_bufs in a busy system, spread them around
like we do inodes.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_buf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index e484f6bead53..45b470f55ad7 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -324,6 +324,9 @@ xfs_buf_free(
 
 			__free_page(page);
 		}
+		if (current->reclaim_state)
+			current->reclaim_state->reclaimed_slab +=
+							bp->b_page_count;
 	} else if (bp->b_flags & _XBF_KMEM)
 		kmem_free(bp->b_addr);
 	_xfs_buf_free_pages(bp);
@@ -2064,7 +2067,8 @@ int __init
 xfs_buf_init(void)
 {
 	xfs_buf_zone = kmem_zone_init_flags(sizeof(xfs_buf_t), "xfs_buf",
-						KM_ZONE_HWALIGN, NULL);
+			KM_ZONE_HWALIGN | KM_ZONE_SPREAD | KM_ZONE_RECLAIM,
+			NULL);
 	if (!xfs_buf_zone)
 		goto out;
 
-- 
2.23.0.rc1

