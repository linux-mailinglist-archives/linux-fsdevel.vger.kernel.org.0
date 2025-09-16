Return-Path: <linux-fsdevel+bounces-61636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2312B58A85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19F03ACBAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A40C1C5F23;
	Tue, 16 Sep 2025 01:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcRpUAC+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55BA18C933;
	Tue, 16 Sep 2025 01:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984544; cv=none; b=YYzTzO4NzlQIaXpvwj9u9Olt3lpNo7/C6H32abuOwcvuPvnF3PEbvbCom1qnfpDQ8jVVMVfo3rIp6JFKokpj5QpySHRrNvws8Kb5pfGZqEGFIKHCEBA66GNBsiuwjTw1FpeJELn6EZnYvFKIY4BztVKGNcq8KSh/vdtHvOs74J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984544; c=relaxed/simple;
	bh=M+ohi2t4tbP+WIix8M6dxSbfrslw2Xn/GmZNSNanK+E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnSshwF730janDI57R5sv1UMy+ujs4qIsInCq6KcFlGfMOqUDWEkjSmQxKT6/zeF9hid0Ga/ebit8ly6dqOurYc1Te/3TSj8dYK6xDelRMyGhfmxY0WqUMfB/7ftPPVa9FBGSauCsKzI7R0cjZaEO2yMw0TSEUJ0vW2yVeU2qMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcRpUAC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559B5C4CEF1;
	Tue, 16 Sep 2025 01:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984544;
	bh=M+ohi2t4tbP+WIix8M6dxSbfrslw2Xn/GmZNSNanK+E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AcRpUAC+t2MkU5kIeQO7QdG/U6XKPzqwJ1hawn3QvmFuyBGYOXoPz/582uqeEuu6d
	 EGnxBs4bON5e4DznGj8sjUGfBtZuApfNM/1wIsrCxncT8in5ke1ru4UrevOyPAE0Sh
	 k5Ra8eu1V/X6dWsyTtEyJtMfYEPdqFEjZSc+ctEKFjVSRW8dXwz8TkBfJv/Mve+1yr
	 X1ES6IbO8qvXnlscwcVcPtWr8ZBlHAj8Fz27231ixbcx44n2OuBy3Lq3Znt3YnrVjD
	 VByR6vIW+MmKwghQKhT65RrUcXhMVj7ri04IBYp4qKx3G2J3diATRUn9qmWcJkNnGW
	 9p050zi5khefA==
Date: Mon, 15 Sep 2025 18:02:23 -0700
Subject: [PATCH 14/17] fuse2fs: configure block device block size
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161972.390496.6445090397878860567.stgit@frogsfrogsfrogs>
In-Reply-To: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
References: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Set the blocksize of the block device to the filesystem blocksize.
This prevents the bdev pagecache from caching file data blocks that
iomap will read and write directly.  Cache duplication is dangerous.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 misc/fuse2fs.c    |   43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 37999d864a05e5..6f3ddceea85c27 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -6247,6 +6247,45 @@ static off_t fuse4fs_max_size(struct fuse4fs *ff, off_t upper_limit)
 	return res;
 }
 
+/*
+ * Set the block device's blocksize to the fs blocksize.
+ *
+ * This is required to avoid creating uptodate bdev pagecache that aliases file
+ * data blocks because iomap reads and writes directly to file data blocks.
+ */
+static int fuse4fs_set_bdev_blocksize(struct fuse4fs *ff, int fd)
+{
+	int blocksize = ff->fs->blocksize;
+	int set_error;
+	int ret;
+
+	ret = ioctl(fd, BLKBSZSET, &blocksize);
+	if (!ret)
+		return 0;
+
+	/*
+	 * Save the original errno so we can report that if the block device
+	 * blocksize isn't set in an agreeable way.
+	 */
+	set_error = errno;
+
+	ret = ioctl(fd, BLKBSZGET, &blocksize);
+	if (ret)
+		goto out_bad;
+
+	/* Pretend that BLKBSZSET rejected our proposed block size */
+	if (blocksize > ff->fs->blocksize) {
+		set_error = EINVAL;
+		goto out_bad;
+	}
+
+	return 0;
+out_bad:
+	err_printf(ff, "%s: cannot set blocksize %u: %s\n", __func__,
+		   blocksize, strerror(set_error));
+	return -EIO;
+}
+
 static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 {
 	errcode_t err;
@@ -6257,6 +6296,10 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 	if (err)
 		return translate_error(ff->fs, 0, err);
 
+	ret = fuse4fs_set_bdev_blocksize(ff, fd);
+	if (ret)
+		return ret;
+
 	ret = fuse_lowlevel_iomap_device_add(ff->fuse, fd, 0);
 	if (ret < 0) {
 		dbg_printf(ff, "%s: cannot register iomap dev fd=%d, err=%d\n",
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 32fcada0426752..9212235495dc22 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5777,6 +5777,45 @@ static off_t fuse2fs_max_size(struct fuse2fs *ff, off_t upper_limit)
 	return res;
 }
 
+/*
+ * Set the block device's blocksize to the fs blocksize.
+ *
+ * This is required to avoid creating uptodate bdev pagecache that aliases file
+ * data blocks because iomap reads and writes directly to file data blocks.
+ */
+static int fuse2fs_set_bdev_blocksize(struct fuse2fs *ff, int fd)
+{
+	int blocksize = ff->fs->blocksize;
+	int set_error;
+	int ret;
+
+	ret = ioctl(fd, BLKBSZSET, &blocksize);
+	if (!ret)
+		return 0;
+
+	/*
+	 * Save the original errno so we can report that if the block device
+	 * blocksize isn't set in an agreeable way.
+	 */
+	set_error = errno;
+
+	ret = ioctl(fd, BLKBSZGET, &blocksize);
+	if (ret)
+		goto out_bad;
+
+	/* Pretend that BLKBSZSET rejected our proposed block size */
+	if (blocksize > ff->fs->blocksize) {
+		set_error = EINVAL;
+		goto out_bad;
+	}
+
+	return 0;
+out_bad:
+	err_printf(ff, "%s: cannot set blocksize %u: %s\n", __func__,
+		   blocksize, strerror(set_error));
+	return -EIO;
+}
+
 static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
 {
 	errcode_t err;
@@ -5787,6 +5826,10 @@ static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
 	if (err)
 		return translate_error(ff->fs, 0, err);
 
+	ret = fuse2fs_set_bdev_blocksize(ff, fd);
+	if (ret)
+		return ret;
+
 	ret = fuse_fs_iomap_device_add(fd, 0);
 	if (ret < 0) {
 		dbg_printf(ff, "%s: cannot register iomap dev fd=%d, err=%d\n",


