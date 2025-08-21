Return-Path: <linux-fsdevel+bounces-58545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8A8B2EA7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43B43B1D11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3136D1FAC42;
	Thu, 21 Aug 2025 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATIWZ13P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF4F36CE02;
	Thu, 21 Aug 2025 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739177; cv=none; b=Zew2p5hs5eJWMfg1k8nPoY+M6F061+0MXlhqGDufm2FRxkAa5BDaSlpqS1G0+kehbrjqBd2Jxm2vGr8iHPC46IWucz8U+drX9xpMSgDJs1ZnGqmCcKP5Fn5ov8zd/jfv2Wf2rZu0bH3ErzYzAWwDX+ifVFhwMYMr0Y+/tHTZMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739177; c=relaxed/simple;
	bh=E6I6hnU3F+8LTUWytL8bp0nImuihJjpAueceuv4V/1A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzinKIZL3lSW9oYqKbLC6WTP7nNAN0ZlSy9vYYLuG07NCwEuJ5mMMoNn6+JjQbL5dAYM/xrTFizOCGVTadCP5ZGpw6pfcIqez0fHDY62geGEs2QmkNYLKEKAMnqNmclEiOoIyQMu26TeNYPZkmM1r/sIkAMpTVkCwfeM8C77Dfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATIWZ13P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61212C4CEE7;
	Thu, 21 Aug 2025 01:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739177;
	bh=E6I6hnU3F+8LTUWytL8bp0nImuihJjpAueceuv4V/1A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ATIWZ13PjPHWjwT6D6L7zVSNC7fe31Y/KvtlMLHxO8IoPHUQ9pVGO6pWzvq7wJAV0
	 OLv2hs1aKkCQNZ87V6CopfjdJPs9v8s20Zi3mNYOZS1SEwZGDGwauXrow1KDob3AIW
	 Q4E9n9l0Wf+ryyuF9r5JJpnr9FeYubxBT6MGHs/XRdRg9DwW9mcJ/IjYDVPvuvbkjR
	 fQfuju3SLho4LLetCTXEE8jVq/diTQmTCWZkhe1fLrIPScYwXFIt2q4wJkYyTXnEXb
	 BXyTLgEgmrazEvPOnq4w4I7P+W+sujuHWH+3vgWuc2uzqTDCWyHsG1IhGc56aR/fLm
	 Xp8sF9joAsIWw==
Date: Wed, 20 Aug 2025 18:19:36 -0700
Subject: [PATCH 15/19] fuse2fs: configure block device block size
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714001.21970.14211527780780900187.stgit@frogsfrogsfrogs>
In-Reply-To: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
References: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   41 +++++++++++++++++++++++++++++++++++++++++
 misc/fuse4fs.c |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 9ac9077f3508f7..874fe3bbcc3b9f 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5862,6 +5862,43 @@ static off_t fuse2fs_max_size(struct fuse2fs *ff, off_t upper_limit)
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
+	if (blocksize > ff->fs->blocksize)
+		set_error = EINVAL;
+
+	return 0;
+out_bad:
+	err_printf(ff, "%s: cannot set blocksize %u: %s\n", __func__,
+		   blocksize, strerror(set_error));
+	return EIO;
+}
+
 static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
 {
 	errcode_t err;
@@ -5872,6 +5909,10 @@ static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
 	if (err)
 		return translate_error(ff->fs, 0, err);
 
+	ret = fuse2fs_set_bdev_blocksize(ff, fd);
+	if (ret)
+		return ret;
+
 	ret = fuse_fs_iomap_device_add(fd, 0);
 	if (ret < 0) {
 		dbg_printf(ff, "%s: cannot register iomap dev fd=%d, err=%d\n",
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 1050238c88632d..304bac191e7c4c 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -6182,6 +6182,43 @@ static off_t fuse4fs_max_size(struct fuse4fs *ff, off_t upper_limit)
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
+	if (blocksize > ff->fs->blocksize)
+		set_error = EINVAL;
+
+	return 0;
+out_bad:
+	err_printf(ff, "%s: cannot set blocksize %u: %s\n", __func__,
+		   blocksize, strerror(set_error));
+	return EIO;
+}
+
 static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 {
 	errcode_t err;
@@ -6192,6 +6229,10 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 	if (err)
 		return translate_error(ff->fs, 0, err);
 
+	ret = fuse4fs_set_bdev_blocksize(ff, fd);
+	if (ret)
+		return ret;
+
 	ret = fuse_lowlevel_iomap_device_add(ff->fuse, fd, 0);
 	if (ret < 0) {
 		dbg_printf(ff, "%s: cannot register iomap dev fd=%d, err=%d\n",


