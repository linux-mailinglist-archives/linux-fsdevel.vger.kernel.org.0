Return-Path: <linux-fsdevel+bounces-15723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1201A89284C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D79B220F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA26ECC;
	Sat, 30 Mar 2024 00:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DreHyU+d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D4197;
	Sat, 30 Mar 2024 00:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759090; cv=none; b=VppKiX4qtOdePeataOAbRrxPjeXyEtOvUjDPFazOHcbF7WvMvpXLyUFjJIiToApiNfZPUk7ELk62WtNpjeK4jBM28P9Zz+kwzm9f4QAdMeIKUxObMJo7m8bmypnsRUQNiqTmZ4wbZo2hh2OZmOtZoiCIGhp2ld2gpWyY6JLnGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759090; c=relaxed/simple;
	bh=kelOQlvwOy6It/u8qRUqG79iQJlCeZ73U0XhGC61cjg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oM53SABHKAq/kQYN8t1/aTAkQMYwJVxBo+6tESNAL+sUSeaZxeRHpIRwtmuH5g2dA+5aytVTWxIdtSJh5MfhSe09noW3JnmsJdaHpOx7laAefW6H3TUquvQn3pPK5+rjM/AegphmV08GT6VIgc0uwTGBI4keskgl/Yt6qVULG1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DreHyU+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C314C433C7;
	Sat, 30 Mar 2024 00:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759089;
	bh=kelOQlvwOy6It/u8qRUqG79iQJlCeZ73U0XhGC61cjg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DreHyU+dZ1SklJpmJE/IX83clUvk0Omc3PvB40enr+SBm8eiJY4QJPRQjKa/frrO8
	 K3MTdbK4HKgqkF+fnA36CG4j38o/vM6zZns5ESYyOes8E0GEU6cBi0dhfSnYmeq1NO
	 Z0IM30MneHtEJL9tSRevMjbB5gDeTbaETVx6GqK9rtl8qdqrj8EPUbJqs4nI2KG6WU
	 wiFPsCft5ktvaDjEyVK+eYkLGGZRHnPvxaxpnBKkZWQ4cPmGVOqg03hhpVlZteXH58
	 f+F06EstZcfCmyT1UStO7Yr53mZgk/EpHexqhU49Sn02eDZYkjpykp2IIDz8Mctrpw
	 KmeGPXBBgD6qw==
Date: Fri, 29 Mar 2024 17:38:09 -0700
Subject: [PATCH 08/29] xfs: add inode on-disk VERITY flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868693.1988170.8596275385018721223.stgit@frogsfrogsfrogs>
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

Add flag to mark inodes which have fs-verity enabled on them (i.e.
descriptor exist and tree is built).

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h     |    5 ++++-
 fs/xfs/libxfs/xfs_inode_util.c |    2 ++
 fs/xfs/xfs_iops.c              |    2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 1532d37fd1029..e7ed55f747d01 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -1207,6 +1207,7 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
 #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
 #define XFS_DIFLAG2_NREXT64_BIT	4	/* large extent counters */
+#define XFS_DIFLAG2_VERITY_BIT	5	/* inode sealed by fsverity */
 #define XFS_DIFLAG2_METADIR_BIT	63	/* filesystem metadata */
 
 #define XFS_DIFLAG2_DAX		(1ULL << XFS_DIFLAG2_DAX_BIT)
@@ -1214,6 +1215,7 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_COWEXTSIZE	(1ULL << XFS_DIFLAG2_COWEXTSIZE_BIT)
 #define XFS_DIFLAG2_BIGTIME	(1ULL << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1ULL << XFS_DIFLAG2_NREXT64_BIT)
+#define XFS_DIFLAG2_VERITY	(1ULL << XFS_DIFLAG2_VERITY_BIT)
 
 /*
  * The inode contains filesystem metadata and can be found through the metadata
@@ -1242,7 +1244,8 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_METADIR)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_METADIR | \
+	 XFS_DIFLAG2_VERITY)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
index a448e4a2a3e59..fcea20ad675e8 100644
--- a/fs/xfs/libxfs/xfs_inode_util.c
+++ b/fs/xfs/libxfs/xfs_inode_util.c
@@ -127,6 +127,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_DAX;
 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
 			flags |= FS_XFLAG_COWEXTSIZE;
+		if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+			flags |= FS_XFLAG_VERITY;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index b453d5966bfc7..b0672af049043 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1291,6 +1291,8 @@ xfs_diflags_to_iflags(
 		flags |= S_NOATIME;
 	if (init && xfs_inode_should_enable_dax(ip))
 		flags |= S_DAX;
+	if (xflags & FS_XFLAG_VERITY)
+		flags |= S_VERITY;
 
 	/*
 	 * S_DAX can only be set during inode initialization and is never set by


