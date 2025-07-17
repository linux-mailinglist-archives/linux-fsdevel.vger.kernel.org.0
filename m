Return-Path: <linux-fsdevel+bounces-55391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CAEB09888
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6306216E9D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65347241676;
	Thu, 17 Jul 2025 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5eMaSMZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE41EBA07;
	Thu, 17 Jul 2025 23:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795986; cv=none; b=d9ztblJJWDQBZjzzjWayYub3peyU+IoOVGrrEsO0Wl1QzmDU5KGy7oM+wd+SUuISshQRCsvf2oZ8xZhmXQxWazeJfIlFxCPdgv6tnCxNSJO84ZZwJaU6NPBqMgIgJ3y/cuCDbHgvMNLq3kzkWR5hycfEGpbFE8EGk/u1GVXfiSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795986; c=relaxed/simple;
	bh=KhvnJY9ApDpq2OciYUK2uq2SFbxSsnDvWEfdojrWnXY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6Tf8MUFEVkGJaBCbu0UGXKU18LfxfdBNzNIK8yFKaiBEV0g/M0o/Ir0nmnlQfn/YER2Aoik7E4DBWWsx67zwwO8hqSDTNAayIo7nkYYLBnUxsGErYInIBEXwbA1dMyHOBsSrlU7Hi6LT9qry8GgOUtYODWgt+BLcWBZJPHDTq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5eMaSMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E839C4CEE3;
	Thu, 17 Jul 2025 23:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795986;
	bh=KhvnJY9ApDpq2OciYUK2uq2SFbxSsnDvWEfdojrWnXY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=s5eMaSMZQAt3EVNXC92KQaYPk4PMKHYBKxJt+wMbTme3x7/i3iKDWMKOh1R2UOxPh
	 /5m3EkWs5iHN1cOkU55o+VC7kkTeo6ArzRcQvojnwWP5XjN4u+8Ymwi5vKKP9cgn5C
	 eWxt2sWZu2509GhsLJMMImZ/Qu0TBt5OPRRCX47mZZmcp/s3NCaKdOYY31wC22Nhes
	 Qf4om7auAZP8z8KVSQ13K+uRT5kOiYQSLMLNgeMuhPfMKVccSQA5MhjUb125Nkq73Q
	 QyFk8xpqUCHIsp5kL1PoeJenpIn5MvYIiuq9Aw6dVK/8cQgVmwFRBotLTZegwroxHs
	 HQohqs7vAOKsg==
Date: Thu, 17 Jul 2025 16:46:25 -0700
Subject: [PATCH 04/10] fuse2fs: better debugging for file mode updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461792.716436.14623391892076767727.stgit@frogsfrogsfrogs>
In-Reply-To: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
References: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Improve the tracing of a chmod operation so that we can debug file mode
updates.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index e580622d39b1d1..f2cb44a4e53b4c 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2964,12 +2964,13 @@ static int op_chmod(const char *path, mode_t mode
 #endif
 			)
 {
+	struct ext2_inode_large inode;
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
 	ext2_filsys fs;
 	errcode_t err;
 	ext2_ino_t ino;
-	struct ext2_inode_large inode;
+	mode_t new_mode;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -3008,11 +3009,12 @@ static int op_chmod(const char *path, mode_t mode
 			mode &= ~S_ISGID;
 	}
 
-	inode.i_mode &= ~0xFFF;
-	inode.i_mode |= mode & 0xFFF;
+	new_mode = (inode.i_mode & ~0xFFF) | (mode & 0xFFF);
 
-	dbg_printf(ff, "%s: path=%s new_mode=0%o ino=%d\n", __func__,
-		   path, inode.i_mode, ino);
+	dbg_printf(ff, "%s: path=%s old_mode=0%o new_mode=0%o ino=%d\n",
+		   __func__, path, inode.i_mode, new_mode, ino);
+
+	inode.i_mode = new_mode;
 
 	ret = update_ctime(fs, ino, &inode);
 	if (ret)


