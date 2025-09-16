Return-Path: <linux-fsdevel+bounces-61664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF6BB58ADA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D301B26B9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67301E1A3D;
	Tue, 16 Sep 2025 01:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjU55giO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139821C84B8;
	Tue, 16 Sep 2025 01:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984967; cv=none; b=Bfvk1E5u0P3mS+G65MnaSB9rnCBJp9k4PmSVAbHZlbPfFO7YUFOcxjOo0V0mQ+BUUPThZtZw9EZLO8yLJEmkMIkEYfhWbQ1NbP5vQfU5aNyTzPBo2ta16h0JPbvMIBL/Yg/s+lvLwhZU10PLsvMTmsywJsSDG2ZaXGHQTDrB14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984967; c=relaxed/simple;
	bh=FwybMnKCoTO6dYzytLK04GE496dfqF9GYP67GUYAz/0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZY4SMgVo1CX/eUFsCzL2M4bylAbYT/HARqHugrIlFk6ufCE37srEtTFkID3W9iRGscJcs3FHo0SvZhuaXwzRpNBUnPd/WqySVntNmgi2yiYKoO41tu5YNxwk0RPmPtw2k/Nm+8LCQqMfSjFktMFpYhLXIGQ2tuO0QMFjes6pug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjU55giO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEEFC4CEF1;
	Tue, 16 Sep 2025 01:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984966;
	bh=FwybMnKCoTO6dYzytLK04GE496dfqF9GYP67GUYAz/0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kjU55giOnVJk/SSkHUTCd4VrF1evTC0G4OG6Q5LchkJqrf106PZeN1SHZONTHNpuW
	 dE7DYZvk8OMkEQAYgpCsYASnhcQ8Avrqo7ACCxieeWZC38/g29cc1AipsUTq1XhP6d
	 XT61uSMWdArAeo1/NIEO9tfm2LaWGfq+8EEsU+e633vbWoHmi00Vt1PP0JKdrjoWfo
	 OWqW19fg9DGD8A6HRgBf6MhXRnpcTlZUETgcybiEkbT6jGwEV+XaoPiQBkBcc2HnAC
	 9rqQooYv94oDxsguajuD1yuuewTl2PzF/ODXh7YKkWFn4lalM1VCQHksw0p1GyWt4m
	 VrsFgmRqrZceA==
Date: Mon, 15 Sep 2025 18:09:26 -0700
Subject: [PATCH 4/4] fuse4fs: set iomap backing device blocksize
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798163172.392148.13591414637945028939.stgit@frogsfrogsfrogs>
In-Reply-To: <175798163083.392148.13563951490661745612.stgit@frogsfrogsfrogs>
References: <175798163083.392148.13563951490661745612.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If we're running as an unprivileged iomap fuse server, we must ask the
kernel to set the blocksize of the block device.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 0e43e99c3c080d..40171a8cab5279 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1371,6 +1371,21 @@ static int fuse4fs_service(struct fuse4fs *ff, struct fuse_session *se,
 
 	return 0;
 }
+
+int fuse4fs_service_set_bdev_blocksize(struct fuse4fs *ff, int dev_index)
+{
+	int ret;
+
+	ret = fuse_lowlevel_iomap_set_blocksize(ff->fusedev_fd, dev_index,
+						ff->fs->blocksize);
+	if (ret) {
+		err_printf(ff, "%s: cannot set blocksize %u: %s\n", __func__,
+			   ff->fs->blocksize, strerror(errno));
+		return -EIO;
+	}
+
+	return 0;
+}
 #else
 # define fuse4fs_is_service(...)		(false)
 # define fuse4fs_service_connect(...)		(0)
@@ -1382,6 +1397,7 @@ static int fuse4fs_service(struct fuse4fs *ff, struct fuse_session *se,
 # define fuse4fs_service_openfs(...)		(EOPNOTSUPP)
 # define fuse4fs_service_configure_iomap(...)	(EOPNOTSUPP)
 # define fuse4fs_service(...)			(EOPNOTSUPP)
+# define fuse4fs_service_set_bdev_blocksize(...) (EOPNOTSUPP)
 #endif
 
 static errcode_t fuse4fs_acquire_lockfile(struct fuse4fs *ff)
@@ -6798,21 +6814,19 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 {
 	errcode_t err;
 	int fd;
+	int dev_index;
 	int ret;
 
 	err = io_channel_get_fd(ff->fs->io, &fd);
 	if (err)
 		return translate_error(ff->fs, 0, err);
 
-	ret = fuse4fs_set_bdev_blocksize(ff, fd);
-	if (ret)
-		return ret;
-
-	ret = fuse_lowlevel_iomap_device_add(ff->fuse, fd, 0);
-	if (ret < 0) {
-		dbg_printf(ff, "%s: cannot register iomap dev fd=%d, err=%d\n",
-			   __func__, fd, -ret);
-		return translate_error(ff->fs, 0, -ret);
+	dev_index = fuse_lowlevel_iomap_device_add(ff->fuse, fd, 0);
+	if (dev_index < 0) {
+		ret = -dev_index;
+		dbg_printf(ff, "%s: cannot register iomap dev fd=%d: %s\n",
+			   __func__, fd, strerror(ret));
+		return translate_error(ff->fs, 0, ret);
 	}
 
 	dbg_printf(ff, "%s: registered iomap dev fd=%d iomap_dev=%u\n",
@@ -6820,7 +6834,14 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 
 	fuse4fs_configure_atomic_write(ff, fd);
 
-	ff->iomap_dev = ret;
+	if (fuse4fs_is_service(ff))
+		ret = fuse4fs_service_set_bdev_blocksize(ff, dev_index);
+	else
+		ret = fuse4fs_set_bdev_blocksize(ff, fd);
+	if (ret)
+		return ret;
+
+	ff->iomap_dev = dev_index;
 	return 0;
 }
 


