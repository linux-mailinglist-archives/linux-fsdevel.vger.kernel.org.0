Return-Path: <linux-fsdevel+bounces-16405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC45A89D136
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 05:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2914A1C24127
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 03:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E4254F92;
	Tue,  9 Apr 2024 03:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEm/EJyh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA5054743;
	Tue,  9 Apr 2024 03:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633890; cv=none; b=r0ZnVX5/Oj11iCQibf8yhPcIrnSoWPfSPBs5RMPtDwqNpSjdeLcdOVd19ZYv7+B8ctD9nOCgKISrQdEkdo0iw9Zj1tuh5XV9vqxpngesCoKUcvWTNZmzWonOukFDXwpN8eqxTnnJ1PkN+CW340KnN0H6QAnwGsdV0r0zLeKmWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633890; c=relaxed/simple;
	bh=ELKmwFqCSGIa9bFW2fTV8LC2jnDYZE9rfzsks6eASqc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9FFGs2vzTTuGV2sSO2rC5p0pCGt+nXdM5MQhfMOG8Sc6bb0D0Etsh6MxG/SfecHP3yiKIz3CgW/oAhKvMRQMUrZnUBnLGKHii/lXIoyopPbpW6N/7pvTZIQBY8HGonfKLxlZDMW9Gqs/lw+FDqoPjwKvuZxAvA+sI5vbbGzW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEm/EJyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9BBC433F1;
	Tue,  9 Apr 2024 03:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633890;
	bh=ELKmwFqCSGIa9bFW2fTV8LC2jnDYZE9rfzsks6eASqc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OEm/EJyhxpZR+3J2/d0pNPNx0RMo2J4PH01ZKJ3foXj1lMl7ONUCgou0dqtz3kuN9
	 LXbWZ3n+rAhEW2u+fHEor/05etH+A5bUOcNCuSbiVMI+5Cvobxcw2+gz2PHmRq60Is
	 1qy+joTy6qBmHMSxYt59ZzbVdJrAdpJzkoVZWzql6GmoP9RSwLYchKFcb9izE4vZio
	 d4BTh+J5gsvFV+tREHRtL1i2hTt0FtCneziAU8DcO+cI9EoREqwGUZ0gp3eVkKtXON
	 hzKwhr69Ea/A27zxeYP9ltFVC4qbxc8DvdQBt+SgebTaw+WfIhsoSL1t28s0Dk790a
	 VnGM+ZkxDK4QQ==
Date: Mon, 08 Apr 2024 20:38:09 -0700
Subject: [PATCH 14/14] xfs: enable logged file mapping exchange feature
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171263348694.2978056.5602516562413686254.stgit@frogsfrogsfrogs>
In-Reply-To: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
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

Add the XFS_SB_FEAT_INCOMPAT_EXCHRANGE feature to the set of features
that we will permit when mounting a filesystem.  This turns on support
for the file range exchange feature.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_format.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index ff1e28316e1bb..10153ce116d4c 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -380,7 +380,8 @@ xfs_sb_has_ro_compat_feature(
 		 XFS_SB_FEAT_INCOMPAT_META_UUID | \
 		 XFS_SB_FEAT_INCOMPAT_BIGTIME | \
 		 XFS_SB_FEAT_INCOMPAT_NEEDSREPAIR | \
-		 XFS_SB_FEAT_INCOMPAT_NREXT64)
+		 XFS_SB_FEAT_INCOMPAT_NREXT64 | \
+		 XFS_SB_FEAT_INCOMPAT_EXCHRANGE)
 
 #define XFS_SB_FEAT_INCOMPAT_UNKNOWN	~XFS_SB_FEAT_INCOMPAT_ALL
 static inline bool


