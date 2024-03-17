Return-Path: <linux-fsdevel+bounces-14626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C16187DECE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAFF1F21A38
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501911CD11;
	Sun, 17 Mar 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rO3Kt6NZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFCE3C26;
	Sun, 17 Mar 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693371; cv=none; b=Nr3MnrofovWmagfoMFL6rx+yJIU5vKAKFow6nNA1pfCz2CarO0G5jYq1KCyV5xUJEZuTiiXdaJu/2XzAzYytyWJuTaAZK5WcnHgOVkM2K35nAyY/yu1bTsYWIN9mygjWiFiksmklRHxdF6mjXTebrf4sT9wthVeijcfI3W/rFNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693371; c=relaxed/simple;
	bh=7AFXBmyZcF9rLEw8hbInBtTbS/b4JUyzWP5bwVz+Ct4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhxQdc2IO7HhLFLsVI64xov1U8Yqyrqw78Hn1IRH51XRCMMEH+/AabKuCh0/pWs0iufFGLOiB3fvC1JuSIaSR0K5QAQtQgMh3eoEwQsOvcNq9onK8a0WLoDoqxXsaBx+es4wJ2B4Bbw0jH40GyCKpuFDVDSk+9SrV7s+lw370M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rO3Kt6NZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E337C433F1;
	Sun, 17 Mar 2024 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693371;
	bh=7AFXBmyZcF9rLEw8hbInBtTbS/b4JUyzWP5bwVz+Ct4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rO3Kt6NZ0AmYGXxYxDa+cRP1+XF4rucT8hxTVjdsbnsTgddgI/rwsUUud0/Ts5Vmo
	 WGRnjnZApdx8x4LR4Tf59Z7zFZ6PpU9OLXPq8z9aVFMmLyG+hhcjFIGtQDJNMmPZqw
	 fT10V5qwzXRyUoEbrqqgtZjlCvy9Q54aG4wJRk9dyWXvkt7LoBSwhxbgnoMXH2ap/l
	 7gR8Yr42g8aAgGUMXCFE1OrhRTPbCfLvZeNXmjs8oK4+ZnmovclPTCpeuMB9Wl8yrZ
	 YumkvVL1gazPtukyn21j+HWIE/YUoxVmkiDz2jeF4nqH4B5ydLIA2AFAVeePzxk2Vn
	 ZN27Pvt8KIagA==
Date: Sun, 17 Mar 2024 09:36:10 -0700
Subject: [PATCH 09/20] xfs: advertise fs-verity being available on filesystem
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247799.2685643.3109060869144056617.stgit@frogsfrogsfrogs>
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

From: Darrick J. Wong <djwong@kernel.org>

Advertise that this filesystem supports fsverity.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 libxfs/xfs_fs.h |    1 +
 libxfs/xfs_sb.c |    2 ++
 2 files changed, 3 insertions(+)


diff --git a/libxfs/xfs_fs.h b/libxfs/xfs_fs.h
index ca1b17d0..2f372088 100644
--- a/libxfs/xfs_fs.h
+++ b/libxfs/xfs_fs.h
@@ -239,6 +239,7 @@ typedef struct xfs_fsop_resblks {
 #define XFS_FSOP_GEOM_FLAGS_BIGTIME	(1 << 21) /* 64-bit nsec timestamps */
 #define XFS_FSOP_GEOM_FLAGS_INOBTCNT	(1 << 22) /* inobt btree counter */
 #define XFS_FSOP_GEOM_FLAGS_NREXT64	(1 << 23) /* large extent counters */
+#define XFS_FSOP_GEOM_FLAGS_VERITY	(1 << 24) /* fs-verity */
 
 /*
  * Minimum and maximum sizes need for growth checks.
diff --git a/libxfs/xfs_sb.c b/libxfs/xfs_sb.c
index d6755181..fc2269a2 100644
--- a/libxfs/xfs_sb.c
+++ b/libxfs/xfs_sb.c
@@ -1258,6 +1258,8 @@ xfs_fs_geometry(
 	}
 	if (xfs_has_large_extent_counts(mp))
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_NREXT64;
+	if (xfs_has_verity(mp))
+		geo->flags |= XFS_FSOP_GEOM_FLAGS_VERITY;
 	geo->rtsectsize = sbp->sb_blocksize;
 	geo->dirblocksize = xfs_dir2_dirblock_bytes(sbp);
 


