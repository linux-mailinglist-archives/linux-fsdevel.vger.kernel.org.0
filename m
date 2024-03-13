Return-Path: <linux-fsdevel+bounces-14341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046B587B0A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367101C217F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742ED59B45;
	Wed, 13 Mar 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCWnTH0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AFA59B44;
	Wed, 13 Mar 2024 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352652; cv=none; b=UVg3/8ZU2K77rtSpgrjzwqc+mR3tO7BCIff4/+HxqglfGX94nOPbXCXNJAHtKmdrZIZWJB9rPB/8J2mp0Zw085sxLWPkfHsN+c0f/YJ0VQQer2KzXTOeW2i1qsgRvu3SJ0l4ATrbC8uFJUGLsf38LXC4K9PbL5RSvS/xPmdZL+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352652; c=relaxed/simple;
	bh=SlQI136CHhejSV55+uq80fnqYG4X2Ac5Dqu6QQDTOlo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Af4X2s72vQzzGDTuUE+QsVRoB4hN/VDU4XLw3RGUQ7wGYK/NRRG8vYlulAf9KREfJ13kVmnXCsoXEwGEtrYuuqvSSDPiLITbbkV1R1t0XXN2DJWh9BX1S8KaPBwgIYXGEnsxxtz6ilwnoMgKe8jCIvl3KSlNcSYiGvP1bH/xD6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCWnTH0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC42C433C7;
	Wed, 13 Mar 2024 17:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352652;
	bh=SlQI136CHhejSV55+uq80fnqYG4X2Ac5Dqu6QQDTOlo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DCWnTH0KHwn7h+NQs0JgOCTsdd/PX45PmxdLnsZz5+FUIJy7B5L5zweoMUZM7xksA
	 n7fo+I3zGhcKDm0zu7CDRisJsGS5brBrPDIb0tnOqanbJX1c5x6DKcwR/aTAPC5ked
	 mzDp2ITGeXkmOEbn13lfzsPHASGjhbEZBsTTqixZg5dOlsnqesLNojs7OJOg4psb2a
	 yWv6bSoN1Zc/DqZNL7jEC1Pt0WG4Lozj2VLXvZHqHiPUWjrI9j3UD8bsrRAo/iJULo
	 jkA/bLnbE1tKvUhTo+ukBoCjXajRGqa8QPNIsYzsja2LiFY9GEV1VKNW3xsV+Vh1P8
	 Jjy/zQwWhtpYw==
Date: Wed, 13 Mar 2024 10:57:31 -0700
Subject: [PATCH 19/29] xfs: disable direct read path for fs-verity files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223662.2613863.13145834890665570172.stgit@frogsfrogsfrogs>
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

The direct path is not supported on verity files. Attempts to use direct
I/O path on such files should fall back to buffered I/O path.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: fix braces]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 74dba917be93..0ce51a020115 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -281,7 +281,8 @@ xfs_file_dax_read(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
-	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
+	struct inode		*inode = iocb->ki_filp->f_mapping->host;
+	struct xfs_inode	*ip = XFS_I(inode);
 	ssize_t			ret = 0;
 
 	trace_xfs_file_dax_read(iocb, to);
@@ -334,10 +335,18 @@ xfs_file_read_iter(
 
 	if (IS_DAX(inode))
 		ret = xfs_file_dax_read(iocb, to);
-	else if (iocb->ki_flags & IOCB_DIRECT)
+	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
 		ret = xfs_file_dio_read(iocb, to);
-	else
+	else {
+		/*
+		 * In case fs-verity is enabled, we also fallback to the
+		 * buffered read from the direct read path. Therefore,
+		 * IOCB_DIRECT is set and need to be cleared (see
+		 * generic_file_read_iter())
+		 */
+		iocb->ki_flags &= ~IOCB_DIRECT;
 		ret = xfs_file_buffered_read(iocb, to);
+	}
 
 	if (ret > 0)
 		XFS_STATS_ADD(mp, xs_read_bytes, ret);


