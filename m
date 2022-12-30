Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2D0659ECA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbiL3Xva (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbiL3Xv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:51:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB3D262A;
        Fri, 30 Dec 2022 15:51:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8826E61B98;
        Fri, 30 Dec 2022 23:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0D9C433D2;
        Fri, 30 Dec 2022 23:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672444287;
        bh=EY7L0C/1YQ2AVomIpr49dXSRG1X4cWxiGR+xoSKOoeU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=V0OuBRTN/SBoKm4Iu04kXo+RKtX4B6+RhjRCV2F03kNT+s4ucBfHR1R0UE2wWQMyT
         /SsUTJyLbNGnRj4ybqI+HT5yfzovb102NSQvNkgZeehr0BiCi8RcwmPjmrPWL6g2To
         8Ag8C/qRg527zCKK7poDkSFkPYfWnFR/HhRuuV8aXAf63uLMFBlPE7+z0/0xjWv5Ne
         v162//W4vRRn4Z+woGA98O4D4iNApQ3Fy180c24tn7oYZ31WlIPjs+groEK3AHPuvE
         t4KBOZaDlonLj7cVMzsrxXgaO0U6aqvv/gDqRnTYy8hn9pwme7xcchLo28vWdUfl5m
         ++BcovYWaEaiQ==
Subject: [PATCH 05/21] xfs: create a log incompat flag for atomic extent
 swapping
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:55 -0800
Message-ID: <167243843594.699466.3694791888640844542.stgit@magnolia>
In-Reply-To: <167243843494.699466.5163281976943635014.stgit@magnolia>
References: <167243843494.699466.5163281976943635014.stgit@magnolia>
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

Create a log incompat flag so that we only attempt to process swap
extent log items if the filesystem supports it, and a geometry flag to
advertise support if it's present.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h  |    1 +
 fs/xfs/libxfs/xfs_fs.h      |    1 +
 fs/xfs/libxfs/xfs_sb.c      |    3 +++
 fs/xfs/libxfs/xfs_swapext.h |   24 ++++++++++++++++++++++++
 4 files changed, 29 insertions(+)
 create mode 100644 fs/xfs/libxfs/xfs_swapext.h


diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 817adb36cb1e..1424976ec955 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -391,6 +391,7 @@ xfs_sb_has_incompat_feature(
 }
 
 #define XFS_SB_FEAT_INCOMPAT_LOG_XATTRS   (1 << 0)	/* Delayed Attributes */
+#define XFS_SB_FEAT_INCOMPAT_LOG_SWAPEXT  (1U << 31)	/* file extent swap */
 #define XFS_SB_FEAT_INCOMPAT_LOG_ALL \
 	(XFS_SB_FEAT_INCOMPAT_LOG_XATTRS)
 #define XFS_SB_FEAT_INCOMPAT_LOG_UNKNOWN	~XFS_SB_FEAT_INCOMPAT_LOG_ALL
diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 210c17f5a16c..a39fd65e6ee0 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -239,6 +239,7 @@ typedef struct xfs_fsop_resblks {
 #define XFS_FSOP_GEOM_FLAGS_BIGTIME	(1 << 21) /* 64-bit nsec timestamps */
 #define XFS_FSOP_GEOM_FLAGS_INOBTCNT	(1 << 22) /* inobt btree counter */
 #define XFS_FSOP_GEOM_FLAGS_NREXT64	(1 << 23) /* large extent counters */
+#define XFS_FSOP_GEOM_FLAGS_ATOMIC_SWAP	(1U << 31) /* atomic file extent swap */
 
 /*
  * Minimum and maximum sizes need for growth checks.
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index b3e8ab247b28..5b6f5939fda1 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -25,6 +25,7 @@
 #include "xfs_da_format.h"
 #include "xfs_health.h"
 #include "xfs_ag.h"
+#include "xfs_swapext.h"
 
 /*
  * Physical superblock buffer manipulations. Shared with libxfs in userspace.
@@ -1197,6 +1198,8 @@ xfs_fs_geometry(
 	}
 	if (xfs_has_large_extent_counts(mp))
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_NREXT64;
+	if (xfs_swapext_supported(mp))
+		geo->flags |= XFS_FSOP_GEOM_FLAGS_ATOMIC_SWAP;
 	geo->rtsectsize = sbp->sb_blocksize;
 	geo->dirblocksize = xfs_dir2_dirblock_bytes(sbp);
 
diff --git a/fs/xfs/libxfs/xfs_swapext.h b/fs/xfs/libxfs/xfs_swapext.h
new file mode 100644
index 000000000000..316323339d76
--- /dev/null
+++ b/fs/xfs/libxfs/xfs_swapext.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2022 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef __XFS_SWAPEXT_H_
+#define __XFS_SWAPEXT_H_ 1
+
+/*
+ * Decide if this filesystem supports using log items to swap file extents and
+ * restart the operation if the system fails before the operation completes.
+ *
+ * This can be done to individual file extents by using the block mapping log
+ * intent items introduced with reflink and rmap; or to entire file ranges
+ * using swapext log intent items to track the overall progress across multiple
+ * extent mappings.  Realtime is not supported yet.
+ */
+static inline bool xfs_swapext_supported(struct xfs_mount *mp)
+{
+	return (xfs_has_reflink(mp) || xfs_has_rmapbt(mp)) &&
+	       !xfs_has_realtime(mp);
+}
+
+#endif /* __XFS_SWAPEXT_H_ */

