Return-Path: <linux-fsdevel+bounces-16982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B17368A5E86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D49C2862E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94249159210;
	Mon, 15 Apr 2024 23:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVQH8JUc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2880156974;
	Mon, 15 Apr 2024 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224418; cv=none; b=bMO3olgyzjnsf5Zqa5YMua8vnnJ1IcK76kgNvDj80pcm3vSs1eEnlh3tX1qsb356M4chNji8nZqCjenyw4DYb7rCYDaTpJMsmvbwSb/WIXWRgeAEXzCJ3UrLpr6YvUi8OExmEQREsWarjvVAumKabEJUEPDN5aO1vHFgL4TLf5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224418; c=relaxed/simple;
	bh=39b/mRHBfdN1qyETumT0bb7YGgmE9DVDH2yfT1PAbK4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psJTujdTSs5XtWohw72P/nOuxKsp/R67E4lXFVYGOYuQUaUlIxhoYudqS8ueaQb5q7yy9oRD+yiJeJBffy5h9L2eIGE4nJWX9LZ9W4vzuB6CE6q4xambdndoNTp6uEhhY26ISgbROC6UQZkFeD3CmaZrBOkLt8jVGHjILVRWgQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVQH8JUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78167C113CC;
	Mon, 15 Apr 2024 23:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224417;
	bh=39b/mRHBfdN1qyETumT0bb7YGgmE9DVDH2yfT1PAbK4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UVQH8JUclD+v7PTK7tv6Z2Dw3emJYDfH76unm0LDwmi2Wc3L2FYNsUChTzvttSB1J
	 xUrbJrM8Pm58EIZxy8I/6/57cYxB+GlK3qxsZ7HHkgVuzFFz+ujdRJcqNzgbmaL6UX
	 0oZZG8se1pYmozrVAY4pvq4+0SRv1K0PA2PiNTDxcTB81TKj7zXAuQt+bowHg7VnLx
	 U4PcBQ5js05hW/EfxwGFRfzHBS58fU9SzN6uSIqj9O9fN40oVFfhwecHzDsAjFG3oa
	 8lTpZbHNyn4anQDnyLAElJ5k8w8ttCdKAMVfHQvWIlbRiVIz7B/zQnY4CCxgzLsyEm
	 qr+fs59vsRC5Q==
Date: Mon, 15 Apr 2024 16:40:17 -0700
Subject: [PATCH 5/7] xfs: hoist multi-fsb allocation unit detection to a
 helper
From: "Darrick J. Wong" <djwong@kernel.org>
To: chandanbabu@kernel.org, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171322380812.87068.12260366227745061736.stgit@frogsfrogsfrogs>
In-Reply-To: <171322380710.87068.4499164955656161226.stgit@frogsfrogsfrogs>
References: <171322380710.87068.4499164955656161226.stgit@frogsfrogsfrogs>
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

Replace the open-coded logic to decide if a file has a multi-fsb
allocation unit to a helper to make the code easier to read.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_bmap_util.c |    4 ++--
 fs/xfs/xfs_inode.h     |    9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 19e11d1da660..53aa90a0ee3a 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -542,7 +542,7 @@ xfs_can_free_eofblocks(
 	 * forever.
 	 */
 	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
-	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1)
+	if (xfs_inode_has_bigrtalloc(ip))
 		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
 	last_fsb = XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes);
 	if (last_fsb <= end_fsb)
@@ -843,7 +843,7 @@ xfs_free_file_space(
 	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
 
 	/* We can only free complete realtime extents. */
-	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1) {
+	if (xfs_inode_has_bigrtalloc(ip)) {
 		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
 		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
 	}
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index fa3e605901e2..f559e68ee707 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -311,6 +311,15 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 	return ip->i_diflags2 & XFS_DIFLAG2_NREXT64;
 }
 
+/*
+ * Decide if this file is a realtime file whose data allocation unit is larger
+ * than a single filesystem block.
+ */
+static inline bool xfs_inode_has_bigrtalloc(struct xfs_inode *ip)
+{
+	return XFS_IS_REALTIME_INODE(ip) && ip->i_mount->m_sb.sb_rextsize > 1;
+}
+
 /*
  * Return the buftarg used for data allocations on a given inode.
  */


