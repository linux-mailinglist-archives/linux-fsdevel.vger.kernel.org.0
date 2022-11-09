Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9777D62323E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 19:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiKISRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 13:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiKISRH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:17:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4DC27CCA;
        Wed,  9 Nov 2022 10:17:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CE28B81F68;
        Wed,  9 Nov 2022 18:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC6BC433D6;
        Wed,  9 Nov 2022 18:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668017823;
        bh=bDBaC3kLzhsAEb02rFjChCSbwh8XM2mgPnK15shHGOM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=d+MYxc4DeGharzpAJSrB71gjUD4KXJAjcbKfsTmI4kP1mBvr6FLoCyeBKysTeA806
         2FmTPDbt2DLXvOFBgKYSamA/+6UWCZK0WO8z6wXjKeaRAZofbe2cAkV7i7dHl/PeZS
         yPWUh9/H8Rql+mx/7GLCefdeX93dbQwEjuYnelSVOTIuyttFb58CWGMwUhqQTX73z8
         k8X+5KQucNu/HpT1wzbMrpRJzVYlfN5v2w8xr0vhs21uLKlYnrQcx7Z6cSCiBpZsj9
         dUtKDTEzzL6mzTjBqiBWVr0d+epkTL3Kmclu2znojG4SxRlOi7XOrCoJrpUnjngESs
         S11nXDrDX8EhQ==
Subject: [PATCH 14/14] xfs: add debug knob to slow down write for fun
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org
Date:   Wed, 09 Nov 2022 10:17:03 -0800
Message-ID: <166801782325.3992140.3655806096994688335.stgit@magnolia>
In-Reply-To: <166801774453.3992140.241667783932550826.stgit@magnolia>
References: <166801774453.3992140.241667783932550826.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add a new error injection knob so that we can arbitrarily slow down
pagecahe writes to test for race conditions and aberrant reclaim
behavior if the writeback mechanisms are slow to issue writeback.  This
will enable functional testing for the ifork sequence counters
introduced in commit XXXXXXXXXXXX that fixes write racing with reclaim
writeback.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_errortag.h |    4 +++-
 fs/xfs/xfs_error.c           |    3 +++
 fs/xfs/xfs_iomap.c           |   12 ++++++++++--
 3 files changed, 16 insertions(+), 3 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_errortag.h b/fs/xfs/libxfs/xfs_errortag.h
index 7c723a36df02..7e04523f44f2 100644
--- a/fs/xfs/libxfs/xfs_errortag.h
+++ b/fs/xfs/libxfs/xfs_errortag.h
@@ -62,7 +62,8 @@
 #define XFS_ERRTAG_DA_LEAF_SPLIT			40
 #define XFS_ERRTAG_ATTR_LEAF_TO_NODE			41
 #define XFS_ERRTAG_WB_DELAY_MS				44
-#define XFS_ERRTAG_MAX					45
+#define XFS_ERRTAG_WRITE_DELAY_MS			45
+#define XFS_ERRTAG_MAX					46
 
 /*
  * Random factors for above tags, 1 means always, 2 means 1/2 time, etc.
@@ -109,5 +110,6 @@
 #define XFS_RANDOM_DA_LEAF_SPLIT			1
 #define XFS_RANDOM_ATTR_LEAF_TO_NODE			1
 #define XFS_RANDOM_WB_DELAY_MS				3000
+#define XFS_RANDOM_WRITE_DELAY_MS			3000
 
 #endif /* __XFS_ERRORTAG_H_ */
diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
index b949cfe7dd18..ee00f5ab11a7 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -63,6 +63,7 @@ static unsigned int xfs_errortag_random_default[] = {
 	0, /* 42 */
 	0, /* 43 */
 	XFS_RANDOM_WB_DELAY_MS,
+	XFS_RANDOM_WRITE_DELAY_MS,
 };
 
 struct xfs_errortag_attr {
@@ -179,6 +180,7 @@ XFS_ERRORTAG_ATTR_RW(larp,		XFS_ERRTAG_LARP);
 XFS_ERRORTAG_ATTR_RW(da_leaf_split,	XFS_ERRTAG_DA_LEAF_SPLIT);
 XFS_ERRORTAG_ATTR_RW(attr_leaf_to_node,	XFS_ERRTAG_ATTR_LEAF_TO_NODE);
 XFS_ERRORTAG_ATTR_RW(wb_delay_ms,	XFS_ERRTAG_WB_DELAY_MS);
+XFS_ERRORTAG_ATTR_RW(write_delay_ms,	XFS_ERRTAG_WRITE_DELAY_MS);
 
 static struct attribute *xfs_errortag_attrs[] = {
 	XFS_ERRORTAG_ATTR_LIST(noerror),
@@ -223,6 +225,7 @@ static struct attribute *xfs_errortag_attrs[] = {
 	XFS_ERRORTAG_ATTR_LIST(da_leaf_split),
 	XFS_ERRORTAG_ATTR_LIST(attr_leaf_to_node),
 	XFS_ERRORTAG_ATTR_LIST(wb_delay_ms),
+	XFS_ERRORTAG_ATTR_LIST(write_delay_ms),
 	NULL,
 };
 ATTRIBUTE_GROUPS(xfs_errortag);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 5e746df2c63f..048e7d9a739b 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -27,6 +27,8 @@
 #include "xfs_dquot_item.h"
 #include "xfs_dquot.h"
 #include "xfs_reflink.h"
+#include "xfs_error.h"
+#include "xfs_errortag.h"
 
 #define XFS_ALLOC_ALIGN(mp, off) \
 	(((off) >> mp->m_allocsize_log) << mp->m_allocsize_log)
@@ -1368,11 +1370,17 @@ xfs_buffered_write_iomap_valid(
 	struct xfs_iomap_buffered_ctx	*ibc = iter->private;
 	struct xfs_inode		*ip = XFS_I(iter->inode);
 
-	if (ibc->data_seq != READ_ONCE(ip->i_df.if_seq))
+	if (ibc->data_seq != READ_ONCE(ip->i_df.if_seq)) {
+		XFS_ERRORTAG_REPORT(ip->i_mount, XFS_ERRTAG_WRITE_DELAY_MS);
 		return false;
+	}
 	if (ibc->has_cow_seq &&
-	    ibc->cow_seq != READ_ONCE(ip->i_cowfp->if_seq))
+	    ibc->cow_seq != READ_ONCE(ip->i_cowfp->if_seq)) {
+		XFS_ERRORTAG_REPORT(ip->i_mount, XFS_ERRTAG_WRITE_DELAY_MS);
 		return false;
+	}
+
+	XFS_ERRORTAG_DELAY(ip->i_mount, XFS_ERRTAG_WRITE_DELAY_MS);
 	return true;
 }
 

