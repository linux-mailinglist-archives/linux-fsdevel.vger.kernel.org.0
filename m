Return-Path: <linux-fsdevel+bounces-14611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 476F587DEA9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1531F20621
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9149D5221;
	Sun, 17 Mar 2024 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdoH3j+B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF536D;
	Sun, 17 Mar 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693137; cv=none; b=fQPID3lHSyLp3WVyehlhECT9Jt5uxH6Neb06RCzLibMhovA3zBJa/X80NRvsU9c+wC00RSis1+LUScxmMTlN1wpSZUR8AauvK2SzZZk172/jodjZrDCfYbUNqxWCrSiJfXBsR1dX5mv7GB0Nn5gf3/E6n8lWfOEbyfqqhYwcfaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693137; c=relaxed/simple;
	bh=yqHsxghv7Z64lboh1wQLuPmDG/JgBesCNaDkoWMgcDI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJz/PDWEFIuoNWYoK6d25ZjrDGQTmxyWCRrsXTOt1G+aA70Bvs7+UuxKcD+2IribrdpjZjwume6QEHHhIqIxeBECXmx3b5iE2d3GvLtqeDhMutEYiClxupVQH3wf7oOLY23G7EpCIXJ3rT+PEafj9NGb8hhkCEpEue5c37ncoJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdoH3j+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1B0C433F1;
	Sun, 17 Mar 2024 16:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693136;
	bh=yqHsxghv7Z64lboh1wQLuPmDG/JgBesCNaDkoWMgcDI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fdoH3j+BfNtnJQkvJBYn+e3mwqBH6ioXtFR91qJPFiFI/uKA8P45vaKy9IphMuAvm
	 BUy0tT7eWTAtajY5myEf4ily+AQAVVYyLrGHNEFvwluw33C5ZaOMdSz6vBDe88jccU
	 laQTC0vtLN5nikfLfAH1AYoGkrloKQ9h8K1fKOINQCd23EE0QGcecq0HJB5vu1zvuL
	 WyO4lIv5Qa2nxST6IANIZUjAh+I773C+983mGYAxWxACyiG3Wo1kINXMbzav+akE9k
	 vrJZsWFwhfcGluG2VETqlmqemOxaLysC6QwtwD2ar9v9age8Y5yyvSJK9QE3n8/F81
	 VhHpANd3hnC/g==
Date: Sun, 17 Mar 2024 09:32:15 -0700
Subject: [PATCH 34/40] xfs: advertise fs-verity being available on filesystem
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246454.2684506.17930149061393435049.stgit@frogsfrogsfrogs>
In-Reply-To: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
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
 fs/xfs/libxfs/xfs_fs.h |    1 +
 fs/xfs/libxfs/xfs_sb.c |    2 ++
 2 files changed, 3 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index ca1b17d01437..2f372088004f 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -239,6 +239,7 @@ typedef struct xfs_fsop_resblks {
 #define XFS_FSOP_GEOM_FLAGS_BIGTIME	(1 << 21) /* 64-bit nsec timestamps */
 #define XFS_FSOP_GEOM_FLAGS_INOBTCNT	(1 << 22) /* inobt btree counter */
 #define XFS_FSOP_GEOM_FLAGS_NREXT64	(1 << 23) /* large extent counters */
+#define XFS_FSOP_GEOM_FLAGS_VERITY	(1 << 24) /* fs-verity */
 
 /*
  * Minimum and maximum sizes need for growth checks.
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index a845cbe3f539..f5038d0d94fe 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1260,6 +1260,8 @@ xfs_fs_geometry(
 	}
 	if (xfs_has_large_extent_counts(mp))
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_NREXT64;
+	if (xfs_has_verity(mp))
+		geo->flags |= XFS_FSOP_GEOM_FLAGS_VERITY;
 	geo->rtsectsize = sbp->sb_blocksize;
 	geo->dirblocksize = xfs_dir2_dirblock_bytes(sbp);
 


