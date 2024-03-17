Return-Path: <linux-fsdevel+bounces-14623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD40D87DEC4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29CC281039
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5921CAAE;
	Sun, 17 Mar 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuzUTpOR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABB41B949;
	Sun, 17 Mar 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693324; cv=none; b=oGF4Lkoj3x4+kWax80er4aX7FPQKmfQU1rbJFdvSLhuf6L8sCemznunMvjWMn9zwwvzSBnCQditaPYqDS7GtFp7vwhV9t7IPNrnBmb5otLzIxUg/Y7vV2pf3sEzwQ7N+SFGhT3m7GIc95TfVhnhTTQ/wp0R5R3Y2g2Rxp3kUlEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693324; c=relaxed/simple;
	bh=DqyXpRyE725aMur+/9YXJmf0GJ8QI+0FYkHEZsvebfY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIzzJ9hdJINmYTAq2+YMJnekPRgl/GD3BgcWUMkMjEvK/wI/TWdweJYma9Gw7U6FLGLAHGmVE9t7QLOV00cGyPM7UhdnnHNlbFSFljlXSSNLdBiEgr6TUPW1bhxd405gskUkL2ohjBKxpK4sCyRHND/jWgs28qOerjvz0yaCxQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuzUTpOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E490C433C7;
	Sun, 17 Mar 2024 16:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693324;
	bh=DqyXpRyE725aMur+/9YXJmf0GJ8QI+0FYkHEZsvebfY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FuzUTpORcte1a91OqB/FgMVf7/veckc2/DShUSUo0BH05l5Hba9Vpikx4ZMNkztrs
	 x/mtwgs4qZzzS2+iIFvmnVbRCP4LZ635aaXP6/CfZQVBb+UdQu5NbbJiAtwilfRed6
	 QNnhT8ne6/GC19iOqJ7psoiryGRXLPvRK4MI2c43SpjcKKPVlqRMsWkznPmkdXXBXV
	 DFtcbdF/ne+iyfqf8dTdeZW5EdKzXWEXV89F6W7ngfgta6HwDf7Y0xbWMR5aWocZBa
	 alGhnJMdOu9biEg5dfz89uRB40KnmKUEE6CGFzibcyuytZInfkjxB90HDVmAwLoLZp
	 /19SzdN5bjrMQ==
Date: Sun, 17 Mar 2024 09:35:23 -0700
Subject: [PATCH 06/20] xfs: add fs-verity ro-compat flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247758.2685643.2308744744627785641.stgit@frogsfrogsfrogs>
In-Reply-To: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
References: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andrey Albershteyn <aalbersh@redhat.com>

To mark inodes with fs-verity enabled the new XFS_DIFLAG2_VERITY flag
will be added in further patch. This requires ro-compat flag to let
older kernels know that fs with fs-verity can not be modified.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 include/xfs_mount.h |    2 ++
 libxfs/xfs_format.h |    1 +
 libxfs/xfs_sb.c     |    2 ++
 3 files changed, 5 insertions(+)


diff --git a/include/xfs_mount.h b/include/xfs_mount.h
index 9c492b8f..e88535cd 100644
--- a/include/xfs_mount.h
+++ b/include/xfs_mount.h
@@ -169,6 +169,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_BIGTIME	(1ULL << 24)	/* large timestamps */
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
+#define XFS_FEAT_VERITY		(1ULL << 27)	/* fs-verity */
 
 #define __XFS_HAS_FEAT(name, NAME) \
 static inline bool xfs_has_ ## name (struct xfs_mount *mp) \
@@ -213,6 +214,7 @@ __XFS_HAS_FEAT(inobtcounts, INOBTCNT)
 __XFS_HAS_FEAT(bigtime, BIGTIME)
 __XFS_HAS_FEAT(needsrepair, NEEDSREPAIR)
 __XFS_HAS_FEAT(large_extent_counts, NREXT64)
+__XFS_HAS_FEAT(verity, VERITY)
 
 /* Kernel mount features that we don't support */
 #define __XFS_UNSUPP_FEAT(name) \
diff --git a/libxfs/xfs_format.h b/libxfs/xfs_format.h
index 2b2f9050..93d280eb 100644
--- a/libxfs/xfs_format.h
+++ b/libxfs/xfs_format.h
@@ -353,6 +353,7 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_VERITY   (1 << 4)		/* fs-verity */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
diff --git a/libxfs/xfs_sb.c b/libxfs/xfs_sb.c
index 00b0a937..d6755181 100644
--- a/libxfs/xfs_sb.c
+++ b/libxfs/xfs_sb.c
@@ -161,6 +161,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_VERITY)
+		features |= XFS_FEAT_VERITY;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)


