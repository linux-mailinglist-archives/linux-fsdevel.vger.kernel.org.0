Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0848350B98
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhDABJb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232661AbhDABJQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:09:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4B6161059;
        Thu,  1 Apr 2021 01:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239355;
        bh=Iae0U/GX1iRk8GDGans7Go1+QT1TbzU+WNfMmDmYsDU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PjgW1WhZC4kPGi6hnK+ETcFRRy4Nyp7MHngy7SspEwK7f+uLdHsPTscZdsJg7coKh
         ID1qTUb6WEAY3Snmy4xO+mpL63gT1EJ4RzqFP6SX6kwjgzTAKorcP3vNnSWavWZlFA
         Zznkz/n9gXtUUHTcdM2bzta4K6pgPfjbt8CNntBmvO24CiMRmLirZ2LCtdKQZGRCsf
         1BkRwQ1Inv/lCwFZ5oguA42R8KzyPA4VuG+eeRc+Q5OHbYRoip34+lLRxtrHN1rQlI
         JwDaxvzt8htn+kuIfTsJabx1TvnjBovIoxOApj6DQ71XYy8ITX7YBFhDlfCyx9BrcF
         nAdN/t4uJf5DQ==
Subject: [PATCH 05/18] xfs: create a log incompat flag for atomic extent
 swapping
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:09:14 -0700
Message-ID: <161723935477.3149451.5072642258685986580.stgit@magnolia>
In-Reply-To: <161723932606.3149451.12366114306150243052.stgit@magnolia>
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Create a log incompat flag so that we only attempt to process swap
extent log items if the filesystem supports it.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h |   20 ++++++++++++++++++++
 fs/xfs/libxfs/xfs_fs.h     |    1 +
 fs/xfs/libxfs/xfs_sb.c     |    2 ++
 3 files changed, 23 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 7e9c964772c9..e81a7b12a0e3 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -485,6 +485,7 @@ xfs_sb_has_incompat_feature(
 	return (sbp->sb_features_incompat & feature) != 0;
 }
 
+#define XFS_SB_FEAT_INCOMPAT_LOG_ATOMIC_SWAP (1 << 0)
 #define XFS_SB_FEAT_INCOMPAT_LOG_ALL 0
 #define XFS_SB_FEAT_INCOMPAT_LOG_UNKNOWN	~XFS_SB_FEAT_INCOMPAT_LOG_ALL
 static inline bool
@@ -607,6 +608,25 @@ static inline bool xfs_sb_version_needsrepair(struct xfs_sb *sbp)
 		(sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_NEEDSREPAIR);
 }
 
+/*
+ * Decide if this filesystem can use log-assisted ("atomic") extent swapping.
+ * The atomic swap log intent items depend on the block mapping log intent
+ * items introduced with reflink and rmap.  Realtime is not supported yet.
+ */
+static inline bool xfs_sb_version_canatomicswap(struct xfs_sb *sbp)
+{
+	return (xfs_sb_version_hasreflink(sbp) ||
+		xfs_sb_version_hasrmapbt(sbp)) &&
+		!xfs_sb_version_hasrealtime(sbp);
+}
+
+static inline bool xfs_sb_version_hasatomicswap(struct xfs_sb *sbp)
+{
+	return XFS_SB_VERSION_NUM(sbp) == XFS_SB_VERSION_5 &&
+		(sbp->sb_features_log_incompat &
+		 XFS_SB_FEAT_INCOMPAT_LOG_ATOMIC_SWAP);
+}
+
 /*
  * end of superblock version macros
  */
diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index e7e1e3051739..08bfce39407e 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -252,6 +252,7 @@ typedef struct xfs_fsop_resblks {
 #define XFS_FSOP_GEOM_FLAGS_REFLINK	(1 << 20) /* files can share blocks */
 #define XFS_FSOP_GEOM_FLAGS_BIGTIME	(1 << 21) /* 64-bit nsec timestamps */
 #define XFS_FSOP_GEOM_FLAGS_INOBTCNT	(1 << 22) /* inobt btree counter */
+#define XFS_FSOP_GEOM_FLAGS_ATOMIC_SWAP	(1 << 23) /* atomic swapext */
 
 /*
  * Minimum and maximum sizes need for growth checks.
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 6adfe759190c..52791fe33a6e 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1140,6 +1140,8 @@ xfs_fs_geometry(
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_BIGTIME;
 	if (xfs_sb_version_hasinobtcounts(sbp))
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_INOBTCNT;
+	if (xfs_sb_version_canatomicswap(sbp))
+		geo->flags |= XFS_FSOP_GEOM_FLAGS_ATOMIC_SWAP;
 	if (xfs_sb_version_hassector(sbp))
 		geo->logsectsize = sbp->sb_logsectsize;
 	else

