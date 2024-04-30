Return-Path: <linux-fsdevel+bounces-18294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50288B6921
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D691C21CD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB710A3F;
	Tue, 30 Apr 2024 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+tdP6lP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717E010799;
	Tue, 30 Apr 2024 03:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448448; cv=none; b=YxBtOQklXp0hmZfkteh9Nl1XD+C/cvfEBXhjf3lmEktPS6kzxJR0ruISb1MUv7ESN9q5Us+i97C9F1g32S8oBqmV8lLBbYxYhp2V9r/D9T2pVW7fFhvG7hnE+kM6EN8pgLjayZ1wh75Z/hzQe7VjZhfpcm5fOPfIgJyEi5H5G3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448448; c=relaxed/simple;
	bh=9e954+QHvj9tMJLgPijkcXorbpOlmEW65OfO9efU7rQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaW44+r9zZYAFkTZEjkPg6iZDix74laU4OIjc/crHmCx3veh5fuhzYCvSaVARYQmot8YSG+QP51/RzUBfnYLH54dOEykuNONnzwCcIB9KVUM4v5wZJxorFxqRwkIpIiErl0aCkKBbZuyBjyIOFPzSmWeEfGqHd3nBwy+gnL/ifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+tdP6lP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B90C116B1;
	Tue, 30 Apr 2024 03:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448448;
	bh=9e954+QHvj9tMJLgPijkcXorbpOlmEW65OfO9efU7rQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=X+tdP6lPRnnmbvTdH1aH4Ux/F4rgULfc1ECK8u9tXVoodVgdCvJDI2quvYUX6+Y/b
	 rWBqgaKMhJ+77rD6pRxA9VRBPCfoEuRFtAb2lZuPx4vAIoqzSkRtM2yta/ax42hfwI
	 cYSHojn1011HUOQ5G3L/mdsdjg6vs5s+X8iRr8fFO/MftGAl3RnTQ0OrGEaijBSGDe
	 xSFpu1gZzQnpwkxbccG0XKQE06I7Y1FxgN5yIv80DQSVj9TMEZE6am30LfiREYXaUC
	 WYqf3b3KReCktFTZnVE5myUoYuHvK7a74U0ZW5ySFAPugc5gGc5LiPgdH/k0wS87B+
	 ynfQBVsa/Ex9Q==
Date: Mon, 29 Apr 2024 20:40:47 -0700
Subject: [PATCH 38/38] mkfs.xfs: add verity parameter
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683691.960383.4793005629088454964.stgit@frogsfrogsfrogs>
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

From: Andrey Albershteyn <aalbersh@redhat.com>

fs-verity brings on-disk changes (inode flag). Add parameter to
enable (default disabled) fs-verity flag in superblock. This will
make newly create filesystem read-only for older kernels.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: make this an -i(node) option, edit manpage]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 man/man8/mkfs.xfs.8.in |    6 ++++++
 mkfs/lts_4.19.conf     |    1 +
 mkfs/lts_5.10.conf     |    1 +
 mkfs/lts_5.15.conf     |    1 +
 mkfs/lts_5.4.conf      |    1 +
 mkfs/lts_6.1.conf      |    1 +
 mkfs/lts_6.6.conf      |    1 +
 mkfs/xfs_mkfs.c        |   25 ++++++++++++++++++++++++-
 8 files changed, 36 insertions(+), 1 deletion(-)


diff --git a/man/man8/mkfs.xfs.8.in b/man/man8/mkfs.xfs.8.in
index 1db6765a805a..431cbcb8c7be 100644
--- a/man/man8/mkfs.xfs.8.in
+++ b/man/man8/mkfs.xfs.8.in
@@ -688,6 +688,12 @@ Online repair uses this functionality to rebuild extended attributes,
 directories, symbolic links, and realtime metadata files.
 This feature is disabled by default.
 This feature is only available for filesystems formatted with -m crc=1.
+.TP
+.BI verity[= value]
+This flag activates verity support, which enables sealing of regular file data
+with hashes and cryptographic signatures.
+This feature is disabled by default.
+This feature is only available for filesystems formatted with -m crc=1.
 .RE
 .PP
 .PD 0
diff --git a/mkfs/lts_4.19.conf b/mkfs/lts_4.19.conf
index 700dd2dff977..2cd8999b207c 100644
--- a/mkfs/lts_4.19.conf
+++ b/mkfs/lts_4.19.conf
@@ -14,6 +14,7 @@ rmapbt=0
 sparse=1
 nrext64=0
 exchange=0
+verity=0
 
 [naming]
 parent=0
diff --git a/mkfs/lts_5.10.conf b/mkfs/lts_5.10.conf
index a03cebfc41b9..765ffde89dca 100644
--- a/mkfs/lts_5.10.conf
+++ b/mkfs/lts_5.10.conf
@@ -14,6 +14,7 @@ rmapbt=0
 sparse=1
 nrext64=0
 exchange=0
+verity=0
 
 [naming]
 parent=0
diff --git a/mkfs/lts_5.15.conf b/mkfs/lts_5.15.conf
index 0c93950f3119..76afb3cae691 100644
--- a/mkfs/lts_5.15.conf
+++ b/mkfs/lts_5.15.conf
@@ -14,6 +14,7 @@ rmapbt=0
 sparse=1
 nrext64=0
 exchange=0
+verity=0
 
 [naming]
 parent=0
diff --git a/mkfs/lts_5.4.conf b/mkfs/lts_5.4.conf
index 059af4126223..f0f6526da72c 100644
--- a/mkfs/lts_5.4.conf
+++ b/mkfs/lts_5.4.conf
@@ -14,6 +14,7 @@ rmapbt=0
 sparse=1
 nrext64=0
 exchange=0
+verity=0
 
 [naming]
 parent=0
diff --git a/mkfs/lts_6.1.conf b/mkfs/lts_6.1.conf
index 4d1409208669..7591699396ca 100644
--- a/mkfs/lts_6.1.conf
+++ b/mkfs/lts_6.1.conf
@@ -14,6 +14,7 @@ rmapbt=0
 sparse=1
 nrext64=0
 exchange=0
+verity=0
 
 [naming]
 parent=0
diff --git a/mkfs/lts_6.6.conf b/mkfs/lts_6.6.conf
index 0420e8e4760b..e3f99d2aa4ee 100644
--- a/mkfs/lts_6.6.conf
+++ b/mkfs/lts_6.6.conf
@@ -14,6 +14,7 @@ rmapbt=1
 sparse=1
 nrext64=1
 exchange=0
+verity=0
 
 [naming]
 parent=0
diff --git a/mkfs/xfs_mkfs.c b/mkfs/xfs_mkfs.c
index 7e30404646c2..f41d9749b4ba 100644
--- a/mkfs/xfs_mkfs.c
+++ b/mkfs/xfs_mkfs.c
@@ -92,6 +92,7 @@ enum {
 	I_SPINODES,
 	I_NREXT64,
 	I_EXCHANGE,
+	I_VERITY,
 	I_MAX_OPTS,
 };
 
@@ -477,6 +478,7 @@ static struct opt_params iopts = {
 		[I_SPINODES] = "sparse",
 		[I_NREXT64] = "nrext64",
 		[I_EXCHANGE] = "exchange",
+		[I_VERITY] = "verity",
 		[I_MAX_OPTS] = NULL,
 	},
 	.subopt_params = {
@@ -538,6 +540,12 @@ static struct opt_params iopts = {
 		  .maxval = 1,
 		  .defaultval = 1,
 		},
+		{ .index = I_VERITY,
+		  .conflicts = { { NULL, LAST_CONFLICT } },
+		  .minval = 0,
+		  .maxval = 1,
+		  .defaultval = 1,
+		},
 	},
 };
 
@@ -946,6 +954,7 @@ struct sb_feat_args {
 	bool	nrext64;
 	bool	exchrange;		/* XFS_SB_FEAT_INCOMPAT_EXCHRANGE */
 	bool	rtgroups;		/* XFS_SB_FEAT_INCOMPAT_RTGROUPS */
+	bool	verity;			/* XFS_SB_FEAT_RO_COMPAT_VERITY */
 };
 
 struct cli_params {
@@ -1087,7 +1096,7 @@ usage( void )
 /* force overwrite */	[-f]\n\
 /* inode size */	[-i perblock=n|size=num,maxpct=n,attr=0|1|2,\n\
 			    projid32bit=0|1,sparse=0|1,nrext64=0|1,\n\
-			    exchange=0|1]\n\
+			    exchange=0|1,verity=0|1]\n\
 /* no discard */	[-K]\n\
 /* log subvol */	[-l agnum=n,internal,size=num,logdev=xxx,version=n\n\
 			    sunit=value|su=num,sectsize=num,lazy-count=0|1,\n\
@@ -1789,6 +1798,9 @@ inode_opts_parser(
 	case I_EXCHANGE:
 		cli->sb_feat.exchrange = getnum(value, opts, subopt);
 		break;
+	case I_VERITY:
+		cli->sb_feat.verity = getnum(value, opts, subopt);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -2470,6 +2482,14 @@ _("metadata directory not supported without CRC support\n"));
 			usage();
 		}
 		cli->sb_feat.metadir = false;
+
+		if (cli->sb_feat.verity &&
+		    cli_opt_set(&iopts, I_VERITY)) {
+			fprintf(stderr,
+_("verity not supported without CRC support\n"));
+			usage();
+		}
+		cli->sb_feat.verity = false;
 	}
 
 	if (!cli->sb_feat.finobt) {
@@ -3813,6 +3833,8 @@ sb_set_features(
 		sbp->sb_features_ro_compat |= XFS_SB_FEAT_RO_COMPAT_REFLINK;
 	if (fp->inobtcnt)
 		sbp->sb_features_ro_compat |= XFS_SB_FEAT_RO_COMPAT_INOBTCNT;
+	if (fp->verity)
+		sbp->sb_features_ro_compat |= XFS_SB_FEAT_RO_COMPAT_VERITY;
 	if (fp->bigtime)
 		sbp->sb_features_incompat |= XFS_SB_FEAT_INCOMPAT_BIGTIME;
 	if (fp->parent_pointers) {
@@ -4766,6 +4788,7 @@ main(
 			.nortalign = false,
 			.bigtime = true,
 			.nrext64 = true,
+			.verity = false,
 			/*
 			 * When we decide to enable a new feature by default,
 			 * please remember to update the mkfs conf files.


