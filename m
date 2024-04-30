Return-Path: <linux-fsdevel+bounces-18265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E33B8B68DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D35FB23B2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7B811CBD;
	Tue, 30 Apr 2024 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjDRS6iI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E680711185;
	Tue, 30 Apr 2024 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447995; cv=none; b=j5+p0DchQoF36tK18QiKUwTrsUb9PDq+3C6ILiYEutWs9AToS6QV9A14a4HojWckP8ErXLD2b7agM3xn0mLPrq07982EjSLHWHIVwEU5OFmMnuH+oifoVLrUMk1+0a2EvUYZ/Ue+aVCF83usz58PmSIP7tMjB4sWBxinMpDfZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447995; c=relaxed/simple;
	bh=mk+zLUVmXEi8haoSJ7rnhSB6+ldL0fqflhlXH2lN9aw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6Vs6q+lpeove8CAkikjw6oc5XO7z/z+nig9KIrxrvA8DE55QkDIIqGXwws7woZRnKdAatg23aacSw/Uc1Xl41kcTZyxhUpGNTMn+aURbTh4eDpW9gY8HqIYyQq7vhdsqO1mUG5CCQsc2XdloEQMHGjSrduRQW5kJpRjgKYfkRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjDRS6iI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A80C116B1;
	Tue, 30 Apr 2024 03:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447994;
	bh=mk+zLUVmXEi8haoSJ7rnhSB6+ldL0fqflhlXH2lN9aw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=RjDRS6iIZZldYtIFiJPkagxvkx+0FfKzl8K/q/kddnvqFk6jLQFGmEpHsA5gfBmae
	 WEieK47OiAgOFQoLpD2yLCH3IQM0XhIVPcNlj4+Im4AvzToaYahNga8/z/G9p2V5mJ
	 MIwsegIfuOyP3xpr3zaX1ZhIceSrnmaLWiItdi+uNkkFzdpHz4VAUBh9qDMuIC5S9w
	 iFVuY6x1YcJD2AnHccH/JzPgeWBlPk1Y1p4cqgbbVqoHIdfT0lIrJyMp2HSHA8v6Zj
	 SxvpsEd+VDCmqYMooVooStMrNr7bq7XYjeVSFWZUbdThO5ruVr0SfQqZyvutUG7pQT
	 /94n16t8mTioQ==
Date: Mon, 29 Apr 2024 20:33:13 -0700
Subject: [PATCH 09/38] xfs: add fs-verity ro-compat flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683250.960383.8312595761762505501.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
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
 include/xfs_mount.h |    2 ++
 libxfs/xfs_format.h |    1 +
 libxfs/xfs_sb.c     |    2 ++
 3 files changed, 5 insertions(+)


diff --git a/include/xfs_mount.h b/include/xfs_mount.h
index c78266e602b2..d63fee5718f1 100644
--- a/include/xfs_mount.h
+++ b/include/xfs_mount.h
@@ -187,6 +187,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
 #define XFS_FEAT_METADIR	(1ULL << 28)	/* metadata directory tree */
 #define XFS_FEAT_RTGROUPS	(1ULL << 29)	/* realtime groups */
+#define XFS_FEAT_VERITY		(1ULL << 30)	/* fs-verity */
 
 #define __XFS_HAS_FEAT(name, NAME) \
 static inline bool xfs_has_ ## name (struct xfs_mount *mp) \
@@ -234,6 +235,7 @@ __XFS_HAS_FEAT(large_extent_counts, NREXT64)
 __XFS_HAS_FEAT(exchange_range, EXCHANGE_RANGE)
 __XFS_HAS_FEAT(metadir, METADIR)
 __XFS_HAS_FEAT(rtgroups, RTGROUPS)
+__XFS_HAS_FEAT(verity, VERITY)
 
 static inline bool xfs_has_rtrmapbt(struct xfs_mount *mp)
 {
diff --git a/libxfs/xfs_format.h b/libxfs/xfs_format.h
index e9585ba12ded..563f359f2f07 100644
--- a/libxfs/xfs_format.h
+++ b/libxfs/xfs_format.h
@@ -387,6 +387,7 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_VERITY   (1 << 4)		/* fs-verity */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
diff --git a/libxfs/xfs_sb.c b/libxfs/xfs_sb.c
index 2e5161c63b6b..f8902c4778da 100644
--- a/libxfs/xfs_sb.c
+++ b/libxfs/xfs_sb.c
@@ -164,6 +164,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_VERITY)
+		features |= XFS_FEAT_VERITY;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)


