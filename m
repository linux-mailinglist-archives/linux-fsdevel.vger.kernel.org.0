Return-Path: <linux-fsdevel+bounces-66106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD592C17CB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47D64503BB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D512D94B8;
	Wed, 29 Oct 2025 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prkVPTiK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C9E2D6E53;
	Wed, 29 Oct 2025 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700325; cv=none; b=X0iehXXzv9bA58FKIP+OcPyaVME73M4mTfKhqgjVb/ZMfcyV0e7/2pIdDlOu7016Enj2pZQ+EWPJoM3ydhQQjsrqBe0mmBhpuvTW8vsb+KPoJ+AI+vke3zSzzdbdpRjp4KFOs4qM911AVlRdMtAYvhV54BZktuqOCPZycIGsQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700325; c=relaxed/simple;
	bh=X2gB734SqGf/BDjuBbfv5C8qKsl5YEPuFuUfPvzRU8k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9nJRi7HpAIfpaiZkaGBPuNUNZyDYazpYM2jF1Lq+Hk9vvdUUc9aoxscbI3a7fHGWsB/mws8vqqk+5xVcczDrW3HzG4g17cgvGHR3ZUBLvKrM46c3yUJpWbIMaqiAjQXbUE99RJJxldFzjRiJCxuJyCJKrDccITU311174kRF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prkVPTiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EB3C4CEE7;
	Wed, 29 Oct 2025 01:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700325;
	bh=X2gB734SqGf/BDjuBbfv5C8qKsl5YEPuFuUfPvzRU8k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=prkVPTiKwrssoCZqhZhxYzJBiESZt2JxTvHrVKX/8+Cqnw6bVmcyQ50ZjKdrT0tzQ
	 Ja3sx9N9hEfZywudFFG8bXir/TuxNqW5J4z8+/0f7jY0vwwiALTP7uHlZCtxq9g3eE
	 gHTntidj3f3hkUhbB2e4ebxgcHxn1gheYtSc69l+MOmm+Qvi2lgTA9VfbfWcdyFE4a
	 UQBq0eg4Vt5VXOUE/DJSAGmrzv8zKty7KC5nejJ8WvEuvW4gnRqTqSL7XixHuvarNB
	 67DchlDG71UoaWYz2dEcWu/21b8T+0XS1mUGelqvcugd+eqHuc566GCzZGIzEc+ucS
	 CyUvRKemRE2Pg==
Date: Tue, 28 Oct 2025 18:12:04 -0700
Subject: [PATCH 14/17] fuse2fs: configure block device block size
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817818.1429568.15851552708306786003.stgit@frogsfrogsfrogs>
In-Reply-To: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
References: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
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
index e83fbf8c8fe8fc..49b895dfbcc35b 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -6653,6 +6653,45 @@ static off_t fuse4fs_max_size(struct fuse4fs *ff, off_t upper_limit)
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
@@ -6663,6 +6702,10 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
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
index 6abf1e53656e5a..20201265916960 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -6186,6 +6186,45 @@ static off_t fuse2fs_max_size(struct fuse2fs *ff, off_t upper_limit)
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
@@ -6196,6 +6235,10 @@ static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
 	if (err)
 		return translate_error(ff->fs, 0, err);
 
+	ret = fuse2fs_set_bdev_blocksize(ff, fd);
+	if (ret)
+		return ret;
+
 	ret = fuse_fs_iomap_device_add(fd, 0);
 	if (ret < 0) {
 		dbg_printf(ff, "%s: cannot register iomap dev fd=%d, err=%d\n",


