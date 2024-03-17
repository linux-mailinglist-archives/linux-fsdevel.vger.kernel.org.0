Return-Path: <linux-fsdevel+bounces-14637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 777D987DEE6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDF0281461
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD07D1CA96;
	Sun, 17 Mar 2024 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdAIkMEs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC41CA87;
	Sun, 17 Mar 2024 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693543; cv=none; b=IaTa/Ztt29J4ak9E3me+GsTpUU3J+w3cymxR9Wqev/3ZpmDZVrKcVutrXQ9GcgVaLMsYh9j1PHqMoabfE5Hyw1r8CTkrGWYX8ReQloynveTqXiN+zAQkZokfd9iotPhkKf/OcHIfNu4b+yo/lMuMb+pntC/nzHc6fZUUGD7VAVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693543; c=relaxed/simple;
	bh=sQpc0kmxBtO4UBUhStV0HJX0r8qKG+wP7go6XMJGgxw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpOcWXS0kABxxaxsERglN+w1UPCPiCjHB9+O5LS06uiNOLYvvR9jjiBtV4S26xVqAZ9KhhXoqMgh53zz04FLezZ+6lMz5eVbel1t7nfzqBsh4sou1g8glhm1e088AKxuglXpJEsRqE7MgrbO0MRBmqYgC+HrVZNPWchX1a7Pez8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdAIkMEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C68DC433C7;
	Sun, 17 Mar 2024 16:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693543;
	bh=sQpc0kmxBtO4UBUhStV0HJX0r8qKG+wP7go6XMJGgxw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UdAIkMEskTR/S/WGLI7y4Wqf2AI7XwyB9tFElEO3lsunFWmZxfBeqo24K+Hd9Otex
	 18pHJ5G6AdLVV5jagjPQ5pdyuOjw0E5GiX4m/aTxg/IdLQCIfNwqBPLKVbnICuuH9E
	 65bm586XXV5B3Xe0VltS9ynVKFOtGleCcmQMr0pG+Ui4ReFD4CuCyWGE1hNlkERbWj
	 aA2CjeTBrBB5k2p9pmCiIWuO20WagFAivvuQZ4TJ5gyPhmhocCl6RcFWwuTc12BRG8
	 Gkcg+X+5ccIBgT5wPeJI4Fz4COieXuRjiuSv9lsWtsf1oUkufLkr10JIDW3NlbUtiL
	 1UheMcoembTVw==
Date: Sun, 17 Mar 2024 09:39:02 -0700
Subject: [PATCH 20/20] mkfs.xfs: add verity parameter
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247951.2685643.5838885180227203125.stgit@frogsfrogsfrogs>
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

From: Andrey Albershteyn <aalbersh@redhat.com>

fs-verity brings on-disk changes (inode flag). Add parameter to
enable (default disabled) fs-verity flag in superblock. This will
make newly create filesystem read-only for older kernels.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: make this an -i(node) option, edit manpage]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 man/man8/mkfs.xfs.8.in |    4 ++++
 mkfs/xfs_mkfs.c        |   19 +++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)


diff --git a/man/man8/mkfs.xfs.8.in b/man/man8/mkfs.xfs.8.in
index 8060d342..4864b4d4 100644
--- a/man/man8/mkfs.xfs.8.in
+++ b/man/man8/mkfs.xfs.8.in
@@ -670,6 +670,10 @@ If the value is omitted, 1 is assumed.
 This feature will be enabled when possible.
 This feature is only available for filesystems formatted with -m crc=1.
 .TP
+.BI verity[= value]
+This flag activates verity support, which enables sealing of regular file data
+with hashes and cryptographic signatures.
+This feature is only available for filesystems formatted with -m crc=1.
 .RE
 .PP
 .PD 0
diff --git a/mkfs/xfs_mkfs.c b/mkfs/xfs_mkfs.c
index d6fa48ed..dec5edaf 100644
--- a/mkfs/xfs_mkfs.c
+++ b/mkfs/xfs_mkfs.c
@@ -90,6 +90,7 @@ enum {
 	I_PROJID32BIT,
 	I_SPINODES,
 	I_NREXT64,
+	I_VERITY,
 	I_MAX_OPTS,
 };
 
@@ -469,6 +470,7 @@ static struct opt_params iopts = {
 		[I_PROJID32BIT] = "projid32bit",
 		[I_SPINODES] = "sparse",
 		[I_NREXT64] = "nrext64",
+		[I_VERITY] = "verity",
 		[I_MAX_OPTS] = NULL,
 	},
 	.subopt_params = {
@@ -523,7 +525,13 @@ static struct opt_params iopts = {
 		  .minval = 0,
 		  .maxval = 1,
 		  .defaultval = 1,
-		}
+		},
+		{ .index = I_VERITY,
+		  .conflicts = { { NULL, LAST_CONFLICT } },
+		  .minval = 0,
+		  .maxval = 1,
+		  .defaultval = 1,
+		},
 	},
 };
 
@@ -889,6 +897,7 @@ struct sb_feat_args {
 	bool	nodalign;
 	bool	nortalign;
 	bool	nrext64;
+	bool	verity;			/* XFS_SB_FEAT_RO_COMPAT_VERITY */
 };
 
 struct cli_params {
@@ -1024,7 +1033,7 @@ usage( void )
 			    sectsize=num,concurrency=num]\n\
 /* force overwrite */	[-f]\n\
 /* inode size */	[-i perblock=n|size=num,maxpct=n,attr=0|1|2,\n\
-			    projid32bit=0|1,sparse=0|1,nrext64=0|1]\n\
+			    projid32bit=0|1,sparse=0|1,nrext64=0|1,verity=0|1]\n\
 /* no discard */	[-K]\n\
 /* log subvol */	[-l agnum=n,internal,size=num,logdev=xxx,version=n\n\
 			    sunit=value|su=num,sectsize=num,lazy-count=0|1,\n\
@@ -1722,6 +1731,9 @@ inode_opts_parser(
 	case I_NREXT64:
 		cli->sb_feat.nrext64 = getnum(value, opts, subopt);
 		break;
+	case I_VERITY:
+		cli->sb_feat.verity = getnum(value, opts, subopt);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -3478,6 +3490,8 @@ sb_set_features(
 		sbp->sb_features_ro_compat |= XFS_SB_FEAT_RO_COMPAT_REFLINK;
 	if (fp->inobtcnt)
 		sbp->sb_features_ro_compat |= XFS_SB_FEAT_RO_COMPAT_INOBTCNT;
+	if (fp->verity)
+		sbp->sb_features_ro_compat |= XFS_SB_FEAT_RO_COMPAT_VERITY;
 	if (fp->bigtime)
 		sbp->sb_features_incompat |= XFS_SB_FEAT_INCOMPAT_BIGTIME;
 
@@ -4339,6 +4353,7 @@ main(
 			.nortalign = false,
 			.bigtime = true,
 			.nrext64 = true,
+			.verity = false,
 			/*
 			 * When we decide to enable a new feature by default,
 			 * please remember to update the mkfs conf files.


