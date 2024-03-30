Return-Path: <linux-fsdevel+bounces-15737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD97892869
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A924B23045
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9638C15A5;
	Sat, 30 Mar 2024 00:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIVloQ2S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BB07E8;
	Sat, 30 Mar 2024 00:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759309; cv=none; b=DCtZynwT59QRzFaS9H00KgnBzk2W+r+CHc52tBYJGUDfGK7a1kSiUtqgzMsUFOA/2noMhZbBqNhhIgNZkFoBquyzLCVvdGSJ69AYRXHLUw03LEQBZ8h3sWV+RFc0XPm+ETgOiynjO9E+W4T7yxvZoZMCo97X05u0Z/8utjXXCu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759309; c=relaxed/simple;
	bh=NQSk1hnEy7lbmTKI1smEmFcIiyw7nhUuurvysocgDpA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rT2XiUGGlhxp6B4IADJkajO3Y3v8fQ7nRrJAKBBhvnArGKwJZgWbJ0BO74yUXj1AKOgzStYMAdlmOS8WazpYOQSXWoM+Lc4zJfSl4FOD5egixQ91lAjk2I+6v/2Iorme5YWjGnYZl21JrawebjPA2ivvACkHLI7qjzokjCVVrlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIVloQ2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39D5C433C7;
	Sat, 30 Mar 2024 00:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759308;
	bh=NQSk1hnEy7lbmTKI1smEmFcIiyw7nhUuurvysocgDpA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AIVloQ2SVn7ikWhkZiJsBtA1SWUeyw3beydQmhu8b4Dc1CafoYf/PAb1muvzSQOv7
	 ZAolrwEKoeE91xB84oWIZv7cbQR8KWqcrslVl33vL0iYZLgNg0liCqrSoHtt2kndF9
	 OAeoL2TfubYfod94swD5lbGUKo8RsIpjjd2jweYOZRCYdI9mRmQg8mrYGtwEffQsbj
	 ukW7Nhh+ja8CKD0XxOxDvyb45OCbLLQqYCB+ttA/s2KI8Pp41xxXwiNPLjA4qSNd2C
	 Z0iejjJC7sA1/hx7HqnUlN4Gl6v0JdbuwieNz/PizoSx/N2vL8NHjSDeFWKXbWmaKM
	 M5jxFpqMclmoQ==
Date: Fri, 29 Mar 2024 17:41:48 -0700
Subject: [PATCH 22/29] xfs: advertise fs-verity being available on filesystem
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868924.1988170.14529689278344464510.stgit@frogsfrogsfrogs>
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

Advertise that this filesystem supports fsverity.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h |    1 +
 fs/xfs/libxfs/xfs_sb.c |    2 ++
 2 files changed, 3 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 6ede243fbecf7..af45a246eb1c1 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -247,6 +247,7 @@ typedef struct xfs_fsop_resblks {
 /* file range exchange available to userspace */
 #define XFS_FSOP_GEOM_FLAGS_EXCHANGE_RANGE	(1 << 24)
 
+#define XFS_FSOP_GEOM_FLAGS_VERITY	(1U << 28) /* fs-verity */
 #define XFS_FSOP_GEOM_FLAGS_METADIR	(1U << 29) /* metadata directories */
 #define XFS_FSOP_GEOM_FLAGS_PARENT	(1U << 30) /* parent pointers */
 
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 39b5083745d0e..24e22a2dea51c 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1427,6 +1427,8 @@ xfs_fs_geometry(
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_EXCHANGE_RANGE;
 	if (xfs_has_metadir(mp))
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_METADIR;
+	if (xfs_has_verity(mp))
+		geo->flags |= XFS_FSOP_GEOM_FLAGS_VERITY;
 	geo->rtsectsize = sbp->sb_blocksize;
 	geo->dirblocksize = xfs_dir2_dirblock_bytes(sbp);
 


