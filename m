Return-Path: <linux-fsdevel+bounces-15722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C42CF892849
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013E21C20C6E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF715B66F;
	Sat, 30 Mar 2024 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clxRADFY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AECCB653;
	Sat, 30 Mar 2024 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759074; cv=none; b=cxXfaUzPDsFhVklbNTFIYdcOp9joMcu7BWtxE4Ptk0njd4yEZ98gAVwAHW9a6TUoP7Ta5SpWOimNBG8qUWlyHt9+L+4tuhT4OuIRCJIfhiPU7tSig6wQivFwcPgl/mecTnJhvBgY4KjMyPgtPuGyUwLX7BFvSKCyglBh2S14LFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759074; c=relaxed/simple;
	bh=STBqeZqMuNwLfItZ+3VgD6CrueBX1pQweuS4BDpPNJk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsZ7eh5NsU2wFqbNMdQo+lIbTpPimWGAfRTuYOcc16FXM34Fx98U+VLhFs/lw5hICmLYPBBcpgkoXVz1RM7dq5yhH8GipgE9VS0SuyLBtP6CQunRsZCz5csBY4OibLQnFBIdUxELJQPdc30Qh3IAgivqb6gKaPAgtSzjPwkfp6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clxRADFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C19C433C7;
	Sat, 30 Mar 2024 00:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759074;
	bh=STBqeZqMuNwLfItZ+3VgD6CrueBX1pQweuS4BDpPNJk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=clxRADFYfaJ6fRzkV6eGSXwctFncJjrFPMdNxNFloihGc/j9r/fgJCbI+s9RpLhRj
	 85z/vVLtlgDWDdtK03s2HGPoXO1kFMrrGtADI/8JdCtqyzS0Nrx/YaT162EKX04QK+
	 DjROc1nV4ukhkLfuq4Z3DXD3y3m6JoaivGbhgd2nsDS9Dz19YvFGccqY8XsRIP+D5t
	 Xi56M8jePBSS/e70W1d/ii/Tqt8aqXNJIJuTfuN+KRRqPbI7zsTUA/kFaQBPz+ELAT
	 DlBAntSEKT2Ty6p4Em37t+aINIKa1B8X0YfO+wlUL3Q9NMXAE/nK8cvYIR4OuS38Dz
	 Yg8N10ylarl2Q==
Date: Fri, 29 Mar 2024 17:37:53 -0700
Subject: [PATCH 07/29] xfs: add fs-verity ro-compat flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868677.1988170.14218032834693374890.stgit@frogsfrogsfrogs>
In-Reply-To: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
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
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h |    1 +
 fs/xfs/libxfs/xfs_sb.c     |    2 ++
 fs/xfs/xfs_mount.h         |    2 ++
 3 files changed, 5 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 86a4c51493e7c..1532d37fd1029 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -387,6 +387,7 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_VERITY   (1 << 4)		/* fs-verity */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 747d28477b258..39b5083745d0e 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -167,6 +167,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_VERITY)
+		features |= XFS_FEAT_VERITY;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index f89632e0de006..08ec154eb0e98 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -313,6 +313,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
 #define XFS_FEAT_METADIR	(1ULL << 27)	/* metadata directory tree */
 #define XFS_FEAT_RTGROUPS	(1ULL << 28)	/* realtime groups */
+#define XFS_FEAT_VERITY		(1ULL << 29)	/* fs-verity */
 
 /* Mount features */
 #define XFS_FEAT_ADD_LOG_FEAT	(1ULL << 47)	/* can add log incompat features */
@@ -379,6 +380,7 @@ __XFS_HAS_FEAT(needsrepair, NEEDSREPAIR)
 __XFS_HAS_FEAT(large_extent_counts, NREXT64)
 __XFS_HAS_FEAT(metadir, METADIR)
 __XFS_HAS_FEAT(rtgroups, RTGROUPS)
+__XFS_HAS_FEAT(verity, VERITY)
 
 bool xfs_can_add_incompat_log_features(struct xfs_mount *mp, bool want_audit);
 


