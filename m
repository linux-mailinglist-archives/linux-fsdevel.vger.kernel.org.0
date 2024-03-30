Return-Path: <linux-fsdevel+bounces-15718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF651892841
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A59B219B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406924C8A;
	Sat, 30 Mar 2024 00:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB46jTGd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3D04685;
	Sat, 30 Mar 2024 00:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759011; cv=none; b=marMW7vqyx2AIzKoiMQU8I6uwwHBJpYG+NWCTzlE1IMJ7ruggfYNRYMzo5nTKxGDgmqDlYVvLtqbXMdqw4zOJpu5CyC/LhtcY2QASypjgmXYOKTCvXNOJha2kpGoYWQqbs1ADvDFHQDNuLqjp04vfzFJZARA9Exr9PgiVEY0y/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759011; c=relaxed/simple;
	bh=hvYTprEUADnxGd3t/GzxmtItDq5eIs0D2/gCmlmHBpY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7AYChFOIBHdor6P+40h6Q1j5nGTrFUFLNiRCnsynZ8/pBrqu5gYIhyy+SwcQh3V5Z5y4ClvB9pIT1qZ0JAwtR+DGgjAwa/8UNPQia1gtlLoK+sZ7JwC3NJrK18fCcUw1DOw5gs5cfNJk727aJoFiRHuYCVSrSHrmFvXKG8YUrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB46jTGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BC1C433F1;
	Sat, 30 Mar 2024 00:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759011;
	bh=hvYTprEUADnxGd3t/GzxmtItDq5eIs0D2/gCmlmHBpY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kB46jTGdZUU+VrlmVvcnSNhI1OQJZMyJAOn5T8irRy2xPLP9/UfdGgoVHG7CluqFw
	 BmvSpN0q35ybuSHTL9RG/+QN7R5xEDBEn7gToMub+1xg8+grc9Jl7mt9gNzfIFNZdA
	 IuxJ+A1Gy2qitPA5yNnK4W1DzaA1J7VKbrvwBTcZ3o2XzMqpLUFy7uiU6yL0T+6PaK
	 RdQIWrNnTlObdr8nAvK2aGl2wthpBO88S8xAkmQoMAXcLh4xfaCoKdTk27xx0IzPyV
	 4A25aiv00FGGsNHCFxybhWOWhiPm5AHFY+UOMWrqruv3zuL5bAeYmoV4zG3BN0mXsN
	 ituk2pp5sKQlQ==
Date: Fri, 29 Mar 2024 17:36:50 -0700
Subject: [PATCH 03/29] xfs: create a helper to compute the blockcount of a max
 sized remote value
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868610.1988170.11402681235329108487.stgit@frogsfrogsfrogs>
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

From: Darrick J. Wong <djwong@kernel.org>

Create a helper function to compute the number of fsblocks needed to
store a maximally-sized extended attribute value.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_attr.c        |    4 ++--
 fs/xfs/libxfs/xfs_attr_remote.h |    6 ++++++
 fs/xfs/scrub/reap.c             |    4 ++--
 3 files changed, 10 insertions(+), 4 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index 45dd3e57615e7..c21def69cf636 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -1063,7 +1063,7 @@ xfs_attr_set(
 			rmt_blks = xfs_attr3_rmt_blocks(mp, args->valuelen);
 	} else {
 		XFS_STATS_INC(mp, xs_attr_remove);
-		rmt_blks = xfs_attr3_rmt_blocks(mp, XFS_XATTR_SIZE_MAX);
+		rmt_blks = xfs_attr3_max_rmt_blocks(mp);
 	}
 
 	/*
@@ -1228,7 +1228,7 @@ xfs_attr_removename(
 	ASSERT(!args->trans);
 
 	rmt_extents = XFS_IEXT_ATTR_MANIP_CNT(
-				xfs_attr3_rmt_blocks(mp, XFS_XATTR_SIZE_MAX));
+				xfs_attr3_max_rmt_blocks(mp));
 
 	xfs_init_attr_trans(args, &tres, &total);
 	error = xfs_trans_alloc_inode(dp, &tres, total, 0, rsvd, &args->trans);
diff --git a/fs/xfs/libxfs/xfs_attr_remote.h b/fs/xfs/libxfs/xfs_attr_remote.h
index c64b04f91cafd..e3c6c7d774bf9 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.h
+++ b/fs/xfs/libxfs/xfs_attr_remote.h
@@ -8,6 +8,12 @@
 
 unsigned int xfs_attr3_rmt_blocks(struct xfs_mount *mp, unsigned int attrlen);
 
+/* Number of rmt blocks needed to store the maximally sized attr value */
+static inline unsigned int xfs_attr3_max_rmt_blocks(struct xfs_mount *mp)
+{
+	return xfs_attr3_rmt_blocks(mp, XFS_XATTR_SIZE_MAX);
+}
+
 int xfs_attr_rmtval_get(struct xfs_da_args *args);
 int xfs_attr_rmtval_stale(struct xfs_inode *ip, struct xfs_bmbt_irec *map,
 		xfs_buf_flags_t incore_flags);
diff --git a/fs/xfs/scrub/reap.c b/fs/xfs/scrub/reap.c
index b8166e19726a4..fbf4d248f0060 100644
--- a/fs/xfs/scrub/reap.c
+++ b/fs/xfs/scrub/reap.c
@@ -227,7 +227,7 @@ xrep_bufscan_max_sectors(
 	int			max_fsbs;
 
 	/* Remote xattr values are the largest buffers that we support. */
-	max_fsbs = xfs_attr3_rmt_blocks(mp, XFS_XATTR_SIZE_MAX);
+	max_fsbs = xfs_attr3_max_rmt_blocks(mp);
 
 	return XFS_FSB_TO_BB(mp, min_t(xfs_extlen_t, fsblocks, max_fsbs));
 }
@@ -1070,7 +1070,7 @@ xreap_bmapi_binval(
 	 * of the next hole.
 	 */
 	off = imap->br_startoff + imap->br_blockcount;
-	max_off = off + xfs_attr3_rmt_blocks(mp, XFS_XATTR_SIZE_MAX);
+	max_off = off + xfs_attr3_max_rmt_blocks(mp);
 	while (off < max_off) {
 		struct xfs_bmbt_irec	hmap;
 		int			nhmaps = 1;


