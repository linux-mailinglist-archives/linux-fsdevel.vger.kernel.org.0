Return-Path: <linux-fsdevel+bounces-66135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0806CC17DB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0416F1A68122
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC8F1DE8B5;
	Wed, 29 Oct 2025 01:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Laq+n+Ll"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F24C2741DA;
	Wed, 29 Oct 2025 01:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700780; cv=none; b=tG1gL80ucdekOUJ+BoW1gAXa0ebouRSqjWAyDfOCwP0zhmT7oodI2kbzcreY+g5GMtdhDoMQAUKFn0Wji0FJ57uWZ2JvsXACHEbFzrurnLYWQFVJOXwfhYUEEJkhDN9wffUlqooyrkHB3q+Y7QtWtea69NucL59/s1kez8bA+/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700780; c=relaxed/simple;
	bh=9RhkzRSUy6EHqoFnv0s1B/65WhFkLR9hxJuj3xjDz+E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjj8ft6AV3c5lwqAtYVVAOv40R6+iYp1jGVbpW4EBOPtjQYl/uG3L4saCd+gdU3+rRJ+aZRkCTIoqYw9/Glw0Ng1FWOH3Z5Nq2igxFuaZH7Y0kEojUBBO7FpCtEmzw1A6t44jpsp9GLf0Gek63TdZ1pzaNK0BS7vcpC4b2V9yLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Laq+n+Ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAC2C4CEE7;
	Wed, 29 Oct 2025 01:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700779;
	bh=9RhkzRSUy6EHqoFnv0s1B/65WhFkLR9hxJuj3xjDz+E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Laq+n+Ll+8WP5vzZg2qtJ/xlUXHcUUpmee5Sl5XHVZdIfcmnmGsSpxYgFSMT4gFE+
	 JR+wODoYExZkMXb4bbpz230bsLdU/XRFYi/g9QtXT/gJ4j20L+PgxoU5jU8bvXyZhR
	 jSiAToEo1ml4B1qn7kwSGhC3cSKOE1tb85QtcEZAgGwWuQrxsgpL3SXwyU06GOkDe5
	 6XkgQd/a7e1NMcoYH8GWvZZtNGu60HBoN7e61UWjvGUZRQltsjqcnVyufkUimIsEew
	 ClaUMfZ9FuhysfVZsVssDFzNWwPdO/6v7y/1rqd2vq02EsdTt6c/bmGcN1IGQL3w1J
	 t2PV2oWqQHr7A==
Date: Tue, 28 Oct 2025 18:19:39 -0700
Subject: [PATCH 4/7] fuse4fs: set iomap backing device blocksize
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169819105.1431292.15189746034163940622.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819000.1431292.8063152341472986305.stgit@frogsfrogsfrogs>
References: <176169819000.1431292.8063152341472986305.stgit@frogsfrogsfrogs>
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
index 0a67456243d0c3..fb8a897aa1706e 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1608,6 +1608,21 @@ static int fuse4fs_service(struct fuse4fs *ff, struct fuse_session *se,
 
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
 # define fuse4fs_service_connect(...)		(0)
 # define fuse4fs_service_set_proc_cmdline(...)	((void)0)
@@ -1619,6 +1634,7 @@ static int fuse4fs_service(struct fuse4fs *ff, struct fuse_session *se,
 # define fuse4fs_service_openfs(...)		(EOPNOTSUPP)
 # define fuse4fs_service_configure_iomap(...)	(EOPNOTSUPP)
 # define fuse4fs_service(...)			(EOPNOTSUPP)
+# define fuse4fs_service_set_bdev_blocksize(...) (EOPNOTSUPP)
 #endif
 
 static errcode_t fuse4fs_acquire_lockfile(struct fuse4fs *ff)
@@ -7355,21 +7371,19 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
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
@@ -7377,7 +7391,14 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 
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
 


