Return-Path: <linux-fsdevel+bounces-58552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82373B2EA82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 481F94E39C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CB120B81B;
	Thu, 21 Aug 2025 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYkkZeOW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB8205ABA;
	Thu, 21 Aug 2025 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739287; cv=none; b=O9q0ClrgSRC2Sq9IOnt5nOamCtI3Km6sIt/RL7KfgHl3ydV27rFlavfzIbdDs97yz0klU86BE9diSPjR9uFxlfNbAKykCk7z63O9OL7zLIDsGyuucKXGtyv+5J77oodI1IRhQlQMW9UEiIRXmaTX8rArjCnpeZmu+j1gtCQTFpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739287; c=relaxed/simple;
	bh=uyLDsnExdgkvUx+mNWgQBTIUvtMRUVs/MhY7upUREHw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Opps5NfKMiOcVO0ISsBhwnbCNOIvmvb4yz/ZtLz4r2dnBKbsq4obO/MRFAJ+lxNyBUk08LphYPaGEpVlbB59s3Lk2ZFkhAYN8obGWN+ObuZVR/eSY9yQ1QLcLiClP71osS0WY5mG58rxAnGjUip9OdbHYS3oONtJWi3RK4h/HGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYkkZeOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4330C4CEE7;
	Thu, 21 Aug 2025 01:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739286;
	bh=uyLDsnExdgkvUx+mNWgQBTIUvtMRUVs/MhY7upUREHw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OYkkZeOWC17Oomga3iOVx0gUJCzundgtliYdZDdxv2ROKTsTBp0Ox6MnISWppBvlL
	 f2RDuVW7fNMR7xGfWON9n5sWeunNXTHtEvfiv9XAihIx3QKvNIF4hARoM14GYfNfUE
	 7Sia5vZDId6+0HLGTYzOjui09eQdaONkDeqN15MVv7VxJFVEJTJ1Zob2YRJ7ByDyS3
	 K6dnm6v37cZA4hBX+NyQxpl73yud+1c3pEzUsK/9SIcks5cc1yVO/nA6HIn5/u4stY
	 u2+sWwpuZDeMzKcf9OQiC/d4N2yO1UtTUpKESgvq/DF4OjFzYNNVVRUWCfi/dM5vBN
	 OuZCkZdzWZZzw==
Date: Wed, 20 Aug 2025 18:21:26 -0700
Subject: [PATCH 1/8] fuse2fs: skip permission checking on utimens when iomap
 is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714410.22854.8959091723427645115.stgit@frogsfrogsfrogs>
In-Reply-To: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
References: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

When iomap is enabled, the kernel is in charge of enforcing permissions
checks on timestamp updates for files.  We needn't do that in userspace
anymore.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   11 +++++++----
 misc/fuse4fs.c |   11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 1b44b836484b14..95e850e3cd49f1 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4609,13 +4609,16 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 
 	/*
 	 * ext4 allows timestamp updates of append-only files but only if we're
-	 * setting to current time
+	 * setting to current time.  If iomap is enabled, the kernel does the
+	 * permission checking for timestamp updates; skip the access check.
 	 */
 	if (ctv[0].tv_nsec == UTIME_NOW && ctv[1].tv_nsec == UTIME_NOW)
 		access |= A_OK;
-	ret = check_inum_access(ff, ino, access);
-	if (ret)
-		goto out;
+	if (!fuse2fs_iomap_enabled(ff)) {
+		ret = check_inum_access(ff, ino, access);
+		if (ret)
+			goto out;
+	}
 
 	err = fuse2fs_read_inode(fs, ino, &inode);
 	if (err) {
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index df8da745fcd7c7..8d547e03f558df 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -4816,13 +4816,16 @@ static int fuse4fs_utimens(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 
 	/*
 	 * ext4 allows timestamp updates of append-only files but only if we're
-	 * setting to current time
+	 * setting to current time.  If iomap is enabled, the kernel does the
+	 * permission checking for timestamp updates; skip the access check.
 	 */
 	if (aact == TA_NOW && mact == TA_NOW)
 		access |= A_OK;
-	ret = fuse4fs_inum_access(ff, ctxt, ino, access);
-	if (ret)
-		return ret;
+	if (!fuse4fs_iomap_enabled(ff)) {
+		ret = fuse4fs_inum_access(ff, ctxt, ino, access);
+		if (ret)
+			return ret;
+	}
 
 	if (aact != TA_OMIT)
 		EXT4_INODE_SET_XTIME(i_atime, &atime, inode);


