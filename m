Return-Path: <linux-fsdevel+bounces-18260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412BE8B68D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE33B22719
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E212E6A;
	Tue, 30 Apr 2024 03:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri2kOjqU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529DC25761;
	Tue, 30 Apr 2024 03:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447916; cv=none; b=iPH80MrNKGFaCCbQevH4Vvl7uasYbFpqxcvn6GeXbyP4gg9fNWQ48O9Q9AkXlr/uCxcp/JXQObthY1LAJGM9+Ecfi+7dr/LYjuEdV91S1dyyYTi44oDtVIUzkag2YDc8EvtxAP5TWUeLNCvA111grVPdbFOj7+vcH9l3WCiG94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447916; c=relaxed/simple;
	bh=R+BH8nTsJIAEYRlZRA4F44cuNyWlV+WB0m2MU7h+QYQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m78p/5n5B8cNJVVne37+g3Y7M1VRq7ZIp7dEjMnhREkTivvan/nKENczobkR3IKzZ73K2gpYXfDYSIi2YeC7ZN5bmxpjCUNKKBM/c+M51lelvGZ7G738Cc+sebc1+UO3+CbQs9MQ4X1cuWfz4KQrok9Sgv9zRCpxqvP+jTdkNgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ri2kOjqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25881C116B1;
	Tue, 30 Apr 2024 03:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447916;
	bh=R+BH8nTsJIAEYRlZRA4F44cuNyWlV+WB0m2MU7h+QYQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ri2kOjqUtOGmkv4jn1FfmZsizBj1/II65dqww+x+b9pamdjboYu5YdtZ801Hwl6iw
	 Zic6vItRM6lEniCSIISHHcvr72XmzD7JAAdZ1dvz7QSgIokE1mfafocS+1nwFbBWvv
	 ru6W+9Yn17zl7cncVdeZq0mlqO5ZRwOvWzVyMU75oiIxqcEud9FaD6nMmY4IDPXkQ1
	 H+RmbR81KP4lj7uzJdaFS1Qlzy1DAd1gTS6UJtManv37Etqf5eEyIv1b1IHZ395+Cv
	 0fFTnky2Z35Fw5FY9nV14IjLpLDMb8H9u6CBbhhlNkEdJihI04nZxWJ4gNswfZrR3l
	 ahf8v8FY5o5tA==
Date: Mon, 29 Apr 2024 20:31:55 -0700
Subject: [PATCH 04/38] xfs: create a helper to compute the blockcount of a max
 sized remote value
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683172.960383.15459655209472642137.stgit@frogsfrogsfrogs>
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

From: Darrick J. Wong <djwong@kernel.org>

Create a helper function to compute the number of fsblocks needed to
store a maximally-sized extended attribute value.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 libxfs/xfs_attr.c        |    2 +-
 libxfs/xfs_attr_remote.h |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)


diff --git a/libxfs/xfs_attr.c b/libxfs/xfs_attr.c
index 04cb39f31bdc..3058e609c514 100644
--- a/libxfs/xfs_attr.c
+++ b/libxfs/xfs_attr.c
@@ -1038,7 +1038,7 @@ xfs_attr_set(
 		break;
 	case XFS_ATTRUPDATE_REMOVE:
 		XFS_STATS_INC(mp, xs_attr_remove);
-		rmt_blks = xfs_attr3_rmt_blocks(mp, XFS_XATTR_SIZE_MAX);
+		rmt_blks = xfs_attr3_max_rmt_blocks(mp);
 		break;
 	}
 
diff --git a/libxfs/xfs_attr_remote.h b/libxfs/xfs_attr_remote.h
index c64b04f91caf..e3c6c7d774bf 100644
--- a/libxfs/xfs_attr_remote.h
+++ b/libxfs/xfs_attr_remote.h
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


