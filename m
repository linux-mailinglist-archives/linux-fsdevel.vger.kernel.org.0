Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8439350BBC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhDABKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233070AbhDABKX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:10:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB68361059;
        Thu,  1 Apr 2021 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239422;
        bh=mRlxk8I+TaQUbs4S+9lca+Ixa4Ve6+SLIeDO69HS+Po=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MmcGXzB0auqZ5irdNkPiXit3DU4/D1O8tisz33gVx9EWtzp/uWpWWuK7eD74xp13b
         J06WW2KZAY33/IVfeaJprBKAvD+S0JFw9bZKHqT7hsjR5Uewag3un4dwMPF8Nmz0IB
         I0frPdEeLXe0XeXFZuXZbPHD5YJuxYvm5IJW1PDHTwieT4gh8+13ZdT7y7Vf21bv5W
         gOwjN7Xuo3+bY36aH5AaSP4M3Bm8W8vndUv2VPxueizKHsCmuzYpWiyZF1bLb09jkW
         8cGjYNxS2JU6461e93GyAJ+YQsxWqUe6o050/guqWgcvIlaIm2Juctc82X8oSRwJKF
         v1QPHmp8doy8Q==
Subject: [PATCH 17/18] xfs: make atomic extent swapping support realtime files
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:10:21 -0700
Message-ID: <161723942188.3149451.1970633936998780647.stgit@magnolia>
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

Now that bmap items support the realtime device, we can add the
necessary pieces to the atomic extent swapping code to support such
things.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h  |    7 ++--
 fs/xfs/libxfs/xfs_swapext.c |   67 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 6 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index e81a7b12a0e3..15d967414500 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -611,13 +611,12 @@ static inline bool xfs_sb_version_needsrepair(struct xfs_sb *sbp)
 /*
  * Decide if this filesystem can use log-assisted ("atomic") extent swapping.
  * The atomic swap log intent items depend on the block mapping log intent
- * items introduced with reflink and rmap.  Realtime is not supported yet.
+ * items introduced with reflink and rmap.
  */
 static inline bool xfs_sb_version_canatomicswap(struct xfs_sb *sbp)
 {
-	return (xfs_sb_version_hasreflink(sbp) ||
-		xfs_sb_version_hasrmapbt(sbp)) &&
-		!xfs_sb_version_hasrealtime(sbp);
+	return  xfs_sb_version_hasreflink(sbp) ||
+		xfs_sb_version_hasrmapbt(sbp);
 }
 
 static inline bool xfs_sb_version_hasatomicswap(struct xfs_sb *sbp)
diff --git a/fs/xfs/libxfs/xfs_swapext.c b/fs/xfs/libxfs/xfs_swapext.c
index 41042ee05e40..995b59d86d79 100644
--- a/fs/xfs/libxfs/xfs_swapext.c
+++ b/fs/xfs/libxfs/xfs_swapext.c
@@ -279,7 +279,14 @@ xfs_swapext_check_extents(
 	struct xfs_mount		*mp,
 	const struct xfs_swapext_req	*req)
 {
+	struct xfs_bmbt_irec		irec1, irec2;
 	struct xfs_ifork		*ifp1, *ifp2;
+	xfs_fileoff_t			startoff1 = req->startoff1;
+	xfs_fileoff_t			startoff2 = req->startoff2;
+	xfs_filblks_t			blockcount = req->blockcount;
+	uint32_t			mod;
+	int				nimaps;
+	int				error;
 
 	/* No fork? */
 	ifp1 = XFS_IFORK_PTR(req->ip1, req->whichfork);
@@ -292,12 +299,68 @@ xfs_swapext_check_extents(
 	    ifp2->if_format == XFS_DINODE_FMT_LOCAL)
 		return -EINVAL;
 
-	/* We don't support realtime data forks yet. */
+	/*
+	 * There may be partially written rt extents lurking in the ranges to
+	 * be swapped.  If we support atomic swapext log intent items, we can
+	 * guarantee that operations will always finish and never leave an rt
+	 * extent partially mapped to two files, and can move on.  If we don't
+	 * have that coordination, we have to scan both ranges to ensure that
+	 * there are no partially written extents.
+	 */
 	if (!XFS_IS_REALTIME_INODE(req->ip1))
 		return 0;
 	if (req->whichfork == XFS_ATTR_FORK)
 		return 0;
-	return -EINVAL;
+	if (xfs_sb_version_hasatomicswap(&mp->m_sb))
+		return 0;
+	if (mp->m_sb.sb_rextsize == 1)
+		return 0;
+
+	while (blockcount > 0) {
+		/* Read extent from the first file */
+		nimaps = 1;
+		error = xfs_bmapi_read(req->ip1, startoff1, blockcount,
+				&irec1, &nimaps, 0);
+		if (error)
+			return error;
+		ASSERT(nimaps == 1);
+
+		/* Read extent from the second file */
+		nimaps = 1;
+		error = xfs_bmapi_read(req->ip2, startoff2,
+				irec1.br_blockcount, &irec2, &nimaps,
+				0);
+		if (error)
+			return error;
+		ASSERT(nimaps == 1);
+
+		/*
+		 * We can only swap as many blocks as the smaller of the two
+		 * extent maps.
+		 */
+		irec1.br_blockcount = min(irec1.br_blockcount,
+					  irec2.br_blockcount);
+
+		/*
+		 * Both mappings must be aligned to the realtime extent size
+		 * if either mapping comes from the realtime volume.
+		 */
+		div_u64_rem(irec1.br_startoff, mp->m_sb.sb_rextsize, &mod);
+		if (mod)
+			return -EINVAL;
+		div_u64_rem(irec2.br_startoff, mp->m_sb.sb_rextsize, &mod);
+		if (mod)
+			return -EINVAL;
+		div_u64_rem(irec1.br_blockcount, mp->m_sb.sb_rextsize, &mod);
+		if (mod)
+			return -EINVAL;
+
+		startoff1 += irec1.br_blockcount;
+		startoff2 += irec1.br_blockcount;
+		blockcount -= irec1.br_blockcount;
+	}
+
+	return 0;
 }
 
 #ifdef CONFIG_XFS_QUOTA

