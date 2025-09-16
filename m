Return-Path: <linux-fsdevel+bounces-61642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FF3B58A93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402123B2F01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698781C84B8;
	Tue, 16 Sep 2025 01:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taAsBsxg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBFC3A1DB;
	Tue, 16 Sep 2025 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984638; cv=none; b=H073NFdUtMP/H7apgFDkvMp3GVk2sCZxxTfVKRx8a9SlN9XP40rYt8MgTsacUufUP9ZEdYNfjaAJiKdnEbem6ElsGpuL4ifmz/0t2LtHLugZIEAZksQuGxKzoZMUgN0uZfzYxOIUtxldPLwW0T2l3S8WzWec6LNW3BJI95X/Xmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984638; c=relaxed/simple;
	bh=gg8/oRyyr8rMLqRTbj+47iVR6Kkn6YytCzBX/J6mbQw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4HmFSc1HP6ze2CN3YtfoVV+vMebxn44iv4YJBnhwx0ARkMMm3yfFmcZpN6d0ZbxFZF7yp3P0jmUGsBTz+Vw6KLHW8yIwtDWN6AQMEpOIELl7ZXV9lQNuL1QMHpWsk31WfQpg0G9N9KCeJm8ZvyScu987qXbIPZbHTaYX541GMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taAsBsxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3ABC4CEF1;
	Tue, 16 Sep 2025 01:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984638;
	bh=gg8/oRyyr8rMLqRTbj+47iVR6Kkn6YytCzBX/J6mbQw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=taAsBsxgtBFNpyTMgOKIszaa+OzmZeypkVzbLUMbugGJiS97AHNJeWe9sdklyejrl
	 hhwJhb3AXp3mIqU7SFWbXpuveixYQbiUC4UDwSC2rj5t6hCeUmild+RIZU/KzrpEH8
	 qUhX3RPxFSFviIP1LZQpWAdde94f5nYYsSMOW1Rk3pMX4X5H/ZeATFJpzz40vnLrmX
	 CNUJXWyIiPwT+RoYSlIcz/qDvLbg9N2RkDpiV1nm+M+/7Lgh53iQa/a1COvKNl/ilE
	 L4LX+mIOij0rvXKJs1zzLZ1DYGPmGVQkYxEHEncZUvh+nT/So3l5DpDNiVQXgaM80M
	 +kgZlIsN1y6hA==
Date: Mon, 15 Sep 2025 18:03:57 -0700
Subject: [PATCH 02/10] fuse2fs: skip permission checking on utimens when iomap
 is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162376.391272.5639186132451318153.stgit@frogsfrogsfrogs>
In-Reply-To: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
References: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
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
 fuse4fs/fuse4fs.c |   11 +++++++----
 misc/fuse2fs.c    |   11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index bc2cf41085695f..06be49164c783d 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -4850,13 +4850,16 @@ static int fuse4fs_utimens(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 
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
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 8f7194f4f815ee..716793b5fa485c 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4500,13 +4500,16 @@ static int op_utimens(const char *path, const struct timespec ctv[2],
 
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


