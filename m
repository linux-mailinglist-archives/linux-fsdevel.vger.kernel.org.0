Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F302E6958AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 06:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjBNFvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 00:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjBNFvV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 00:51:21 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874781C5A7
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 21:51:20 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id bg2so4795970pjb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 21:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbSERSy/PBqC/ToxpRcHrmAej4xMlZuBPr9LcR+dPRY=;
        b=hBEf9Tmn9cESbfGcdQUCwbEoTy88i+UHeOdHDrOxKPHeI6dL5dUWZst1VvdMZTTNOt
         OPKoAacfW9Peqhr5GtvytNZLrqKj7Go3IYMdmqEnlkq0GbyZlhlC9nZKvdyi1VPiEoiK
         goQT7Zoc++/CLOB5xzdQtYsUmtMA8SrXBelxjBOlBuzW5QuojVRyBraMsmrdOlvctrPU
         UAcpGs/IOGGjbpcNm49wsZxqCV/1x2qi6dGZU736i02f0y9vED3lqywFkn2MLlV1b7c7
         qewjO2O0lsfwx1fHdhiaqncPP59MJf3Fe57lFKoKg0iH0cVgHcqzSdryNn+qcQIYveAE
         G8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbSERSy/PBqC/ToxpRcHrmAej4xMlZuBPr9LcR+dPRY=;
        b=EkV/9M4Kq0SwlCJuZNZxMZARRQ1dh4/cxVCk1N2OE289gbfdqmorcxrAEdO/GY8w3L
         abNc86HNcgtPxo6VPBGVMbl0Sbjp8NKuaWnh4dQaY1ZDD1L01L60aL8FHXaSQL3ZGO/R
         4fxzq7XJHGG1QTc8N02T29a7jj9FEf7vrudeHIXRAhUYZYV9xbPJxb8i2oyYTmQ5KQ+0
         azuDF3y6qM79WFplq6OqDZmaFA1Hw+7w6RsnZYHIg2WToJUe8J/DyGum4tCskj2Q+YhN
         iodboZpRjIj5HghdQE7bkqGrM49tdRn8pVw8vN+tXmw9Mm8jVDssti1MJxg8Sq9pfM9z
         cMNw==
X-Gm-Message-State: AO0yUKXHLLGdtWvHJZADnniwRp3+S+4Dasz/lkXJCS+9VdoAN6HGVymK
        sbjxy4OuFx9RmhgbpQ8lbTOOZg==
X-Google-Smtp-Source: AK7set+S1yg2yIVk4HLlpxdE1Bus4sMYyW1t8NDoLnzvcXs3PU/E/ZcnI1cCBMtrzjqbumpGoh1Qng==
X-Received: by 2002:a05:6a21:3284:b0:c0:c429:cbbd with SMTP id yt4-20020a056a21328400b000c0c429cbbdmr1409710pzb.6.1676353880030;
        Mon, 13 Feb 2023 21:51:20 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id e24-20020a62aa18000000b005a8dc935ec1sm396153pff.62.2023.02.13.21.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 21:51:19 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <dave@fromorbit.com>)
        id 1pRoDk-00F5yJ-ID; Tue, 14 Feb 2023 16:51:16 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.96)
        (envelope-from <dave@devoid.disaster.area>)
        id 1pRoDk-00HNdN-1h;
        Tue, 14 Feb 2023 16:51:16 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] xfs: failed delalloc conversion results in bad extent lists
Date:   Tue, 14 Feb 2023 16:51:13 +1100
Message-Id: <20230214055114.4141947-3-david@fromorbit.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230214055114.4141947-1-david@fromorbit.com>
References: <20230214055114.4141947-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

If we fail delayed allocation conversion because we cannot allocate
blocks, we end up in the situation where the inode extent list is
effectively corrupt and unresolvable. Whilst we have dirty data in
memory that we cannot allocate space for, we cannot write that data
back to disk. Unmounting a filesystem in this state results in data
loss.

In situations where we end up with a corrupt extent list in memory,
we can also be asked to convert a delayed region that does not have
a delalloc extent backing it. This should be considered a
corruption, too, not a "try again later" error.

These conversion failures result in the inode being sick and needing
repair, but we don't mark all the conditions that can lead to bmap
sickness being marked. Make sure that the error conditions that
indicate corruption are properly marked.

Further, if we trip over these corruptions conditions, we then have
to reclaim an inode that has unresolvable delayed allocation extents
attached to the inode. This generally happens at unmount and inode
inactivation will fire assert failures because we've left stray
delayed allocation extents behind on the inode. Hence we need to
ensure that we only trigger the stale delalloc extent checks if the
inode is fully healthy.

Even then, this may not be enough, because the inactivation code
assumes that there will be no stray delayed extents unless the
filesystem is shut down. If the inode is unhealthy, we need to
ensure we clean up delayed allocation extents within EOF because
the VFS has already tossed the data away. Hence there's no longer
any data over the delalloc extents to write back, so we need to also
toss the delayed allocation extents to ensure we release the space
reservation the delalloc extent holds. Failure to punch delalloc
extents in this case results in assert failures during unmount when
the delalloc block counter is torn down.

This all needs to be in place before the next patch which resolves a
bug in the iomap code that discards delalloc extents backing dirty
pages on writeback error without discarding the dirty data. Hence we
need to be able to handle delalloc extents in inode cleanup sanely,
rather than rely on incorrectly punching the delalloc extents on the
first writeback error that occurs.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 13 ++++++++++---
 fs/xfs/xfs_icache.c      |  4 +++-
 fs/xfs/xfs_inode.c       | 10 ++++++++++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 958e4bb2e51e..fb718a5825d5 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4553,8 +4553,12 @@ xfs_bmapi_convert_delalloc(
 		 * should only happen for the COW fork, where another thread
 		 * might have moved the extent to the data fork in the meantime.
 		 */
-		WARN_ON_ONCE(whichfork != XFS_COW_FORK);
-		error = -EAGAIN;
+		if (whichfork != XFS_COW_FORK) {
+			xfs_bmap_mark_sick(ip, whichfork);
+			error = -EFSCORRUPTED;
+		} else {
+			error = -EAGAIN;
+		}
 		goto out_trans_cancel;
 	}
 
@@ -4598,8 +4602,11 @@ xfs_bmapi_convert_delalloc(
 		bma.prev.br_startoff = NULLFILEOFF;
 
 	error = xfs_bmapi_allocate(&bma);
-	if (error)
+	if (error) {
+		if ((error == -EFSCORRUPTED) || (error == -EFSBADCRC))
+			xfs_bmap_mark_sick(ip, whichfork);
 		goto out_finish;
+	}
 
 	error = -ENOSPC;
 	if (WARN_ON_ONCE(bma.blkno == NULLFSBLOCK))
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index ddeaccc04aec..4354b6639dec 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -24,6 +24,7 @@
 #include "xfs_ialloc.h"
 #include "xfs_ag.h"
 #include "xfs_log_priv.h"
+#include "xfs_health.h"
 
 #include <linux/iversion.h>
 
@@ -1810,7 +1811,8 @@ xfs_inodegc_set_reclaimable(
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_perag	*pag;
 
-	if (!xfs_is_shutdown(mp) && ip->i_delayed_blks) {
+	if (ip->i_delayed_blks && xfs_inode_is_healthy(ip) &&
+	    !xfs_is_shutdown(mp)) {
 		xfs_check_delalloc(ip, XFS_DATA_FORK);
 		xfs_check_delalloc(ip, XFS_COW_FORK);
 		ASSERT(0);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index d354ea2b74f9..06f1229ef628 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -37,6 +37,7 @@
 #include "xfs_reflink.h"
 #include "xfs_ag.h"
 #include "xfs_log_priv.h"
+#include "xfs_health.h"
 
 struct kmem_cache *xfs_inode_cache;
 
@@ -1738,6 +1739,15 @@ xfs_inactive(
 		if (xfs_can_free_eofblocks(ip, true))
 			xfs_free_eofblocks(ip);
 
+		/*
+		 * If the inode is sick, then it might have delalloc extents
+		 * within EOF that we were unable to convert. We have to punch
+		 * them out here to release the reservation as there is no
+		 * longer any data to write back into the delalloc range now.
+		 */
+		if (!xfs_inode_is_healthy(ip))
+			xfs_bmap_punch_delalloc_range(ip, 0,
+						i_size_read(VFS_I(ip)));
 		goto out;
 	}
 
-- 
2.39.0

