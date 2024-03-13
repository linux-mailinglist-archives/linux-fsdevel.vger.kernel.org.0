Return-Path: <linux-fsdevel+bounces-14337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021A987B09C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973D41F29003
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000EE1448EC;
	Wed, 13 Mar 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/VZSL5o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A91448C1;
	Wed, 13 Mar 2024 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352590; cv=none; b=LsyDSEA9KzDqP6yfoF4w2+Q5YtoIDe3dcueI30qf8r1i34IX6vTnBw6FIfva9RWKR0P5dDKYILo5o1NPm2JjBvo3knSyp/7J4ttt86kVHETyrAZlI2Fx1xxR2OfniQ5c3sOyVHRDF8UadVFodFduFOA8D5PXT0a9x3mM3K9CoWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352590; c=relaxed/simple;
	bh=FzNl6nZ5sppQ85tcUujB6tjeJo5nqun0Z4MKseE0oes=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MU8L5Kzdt4htj0XrlRKyYKtBr94kAcyjF4kRYYUyszVMZfrXmfXAmMYX9C95FQ26pD/3GltyyFEEfDMiYgffpl28bKoXckhKohShgMsmDwypls2JQPT7hKGi2J8D9XeKaYqmXMfz89uRF8YONpkGId1+dMxRVomp9YgpO/xNz1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/VZSL5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2A2C433C7;
	Wed, 13 Mar 2024 17:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352589;
	bh=FzNl6nZ5sppQ85tcUujB6tjeJo5nqun0Z4MKseE0oes=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=c/VZSL5oQEV9qlu1whlxfzuBUJqxXyijksgdSBkJTa1mSGAJL11U84A/qBDCm/Br+
	 Cx2EAy6v2OtzyMGoT1VIn2Ei2Y2Fg7fKS9dYCw/z96X1fzY9nUIj0yW34kfkfLJXrQ
	 MPvc6AeqAA68v8dM+ietXm89lzirke0s3++RvMAZ7czPt4axJnGyOxgH9k8q+EXFn3
	 YiQPSTPezAMOkH205yS74h5HbZD/xA6DYbzKkU4f7GRpMVi7VBQYXaMAzR4VMPHFc6
	 IP20pg2TZJ3/kfuJFDFiI84+HG13Tss8Td5PCduH/6nAAE18aaJ8NBR1IZdveCdmBJ
	 qqWqxTr+NiQmA==
Date: Wed, 13 Mar 2024 10:56:29 -0700
Subject: [PATCH 15/29] xfs: add fs-verity ro-compat flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223599.2613863.9328414681604065824.stgit@frogsfrogsfrogs>
In-Reply-To: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
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
index 2b2f9050fbfb..93d280eb8451 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -353,6 +353,7 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_VERITY   (1 << 4)		/* fs-verity */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index d991eec05436..a845cbe3f539 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -163,6 +163,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_VERITY)
+		features |= XFS_FEAT_VERITY;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e880aa48de68..f198d7c82552 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -292,6 +292,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_BIGTIME	(1ULL << 24)	/* large timestamps */
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
+#define XFS_FEAT_VERITY		(1ULL << 27)	/* fs-verity */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -355,6 +356,7 @@ __XFS_HAS_FEAT(inobtcounts, INOBTCNT)
 __XFS_HAS_FEAT(bigtime, BIGTIME)
 __XFS_HAS_FEAT(needsrepair, NEEDSREPAIR)
 __XFS_HAS_FEAT(large_extent_counts, NREXT64)
+__XFS_HAS_FEAT(verity, VERITY)
 
 /*
  * Mount features


