Return-Path: <linux-fsdevel+bounces-55359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E778B0982F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0768A3B4DB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399682417C2;
	Thu, 17 Jul 2025 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6GTvhqY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9364523ABB7
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795484; cv=none; b=R6g4EEyM/ko+o7f1sUPRPl3iskgtq7Ip6ewDZN94AiKL741v/v040CqoST3uyXO3BPd+/MFBnfDH8Yr2NRV5JD939DonFJdAyHO8VWASL7+Yd2nFFIR+fzbpU9y0D+5XZSZfAJGoPq0aMlCI2Fm6H9R6xEKFy9qqydoZ6CuW3IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795484; c=relaxed/simple;
	bh=jtH1mqxSqMJJtxviY6RrQj0Lc7iiRe82I1llGz34OtQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBOQkA+vPZyCL/uK9HPDLZhnhSCY3a5s2qpMZ1MlQmZwNNzYIy09+varXbClX6/0gHmT8H/w0Cio0ky8so8IepAplWavyLDne+ZLEA5MUdyi3skxdBgm2bVA24UkEM0z6xGoXWA6OhPyrsc61UDwPcaVY2PeC1j/AksLv94V1kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6GTvhqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A65AC4CEE3;
	Thu, 17 Jul 2025 23:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795484;
	bh=jtH1mqxSqMJJtxviY6RrQj0Lc7iiRe82I1llGz34OtQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=m6GTvhqYTA7TuipG2VObNZLjPOElstRIk6tE6KAV2gpB2s7FJGTxTGw/WYLTG8EmZ
	 SvLlz+jO9eFJft9Dyxzt6NSOqP/zIGsxnGCqBqmjQTXW0yu4/pE+ZzgSlJ11rd4cHs
	 Ihi7lykZ4hEZIFdUANrGW9OJaX85yldl81n/EDx9zFrKAzEarqXsLJFBtGGdy3eo1Q
	 L25T2aSXX/MKhqXnfWB4ZTr1jO4bFB89f4R7krB6ozxevCGVJBfxpaNblbZk1d70Ut
	 DrFLuG+9VZ2QmQ8m2qbNZhNrBOefvmbpz/0hDLLLv//zClkrzzC89wL1AFCQBzdAfm
	 ub9XNXsO57eXA==
Date: Thu, 17 Jul 2025 16:38:04 -0700
Subject: [PATCH 14/14] libfuse: add strictatime/lazytime mount options
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279459983.714161.10905694231673874725.stgit@frogsfrogsfrogs>
In-Reply-To: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

fuse+iomap leaves the kernel completely in charge of handling
timestamps.  Add the lazytime and strictatime mount options so that
fuse+iomap filesystems can take advantage of those options.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/mount.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)


diff --git a/lib/mount.c b/lib/mount.c
index 2eb967399c9606..3d021428a2ecfc 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -116,9 +116,16 @@ static const struct fuse_opt fuse_mount_opts[] = {
 	FUSE_OPT_KEY("dirsync",			KEY_KERN_FLAG),
 	FUSE_OPT_KEY("noatime",			KEY_KERN_FLAG),
 	FUSE_OPT_KEY("nodiratime",		KEY_KERN_FLAG),
-	FUSE_OPT_KEY("nostrictatime",		KEY_KERN_FLAG),
 	FUSE_OPT_KEY("symfollow",		KEY_KERN_FLAG),
 	FUSE_OPT_KEY("nosymfollow",		KEY_KERN_FLAG),
+#ifdef MS_LAZYTIME
+	FUSE_OPT_KEY("lazytime",		KEY_KERN_FLAG),
+	FUSE_OPT_KEY("nolazytime",		KEY_KERN_FLAG),
+#endif
+#ifdef MS_STRICTATIME
+	FUSE_OPT_KEY("strictatime",		KEY_KERN_FLAG),
+	FUSE_OPT_KEY("nostrictatime",		KEY_KERN_FLAG),
+#endif
 	FUSE_OPT_END
 };
 
@@ -189,11 +196,18 @@ static const struct mount_flags mount_flags[] = {
 	{"noatime", MS_NOATIME,	    1},
 	{"nodiratime",	    MS_NODIRATIME,	1},
 	{"norelatime",	    MS_RELATIME,	0},
-	{"nostrictatime",   MS_STRICTATIME,	0},
 	{"symfollow",	    MS_NOSYMFOLLOW,	0},
 	{"nosymfollow",	    MS_NOSYMFOLLOW,	1},
 #ifndef __NetBSD__
 	{"dirsync", MS_DIRSYNC,	    1},
+#endif
+#ifdef MS_LAZYTIME
+	{"lazytime",	    MS_LAZYTIME,	1},
+	{"nolazytime",	    MS_LAZYTIME,	0},
+#endif
+#ifdef MS_STRICTATIME
+	{"strictatime",	    MS_STRICTATIME,	1},
+	{"nostrictatime",   MS_STRICTATIME,	0},
 #endif
 	{NULL,	    0,		    0}
 };


