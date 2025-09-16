Return-Path: <linux-fsdevel+bounces-61565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C4EB589EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E0F3A84C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248CE1A3172;
	Tue, 16 Sep 2025 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foHmk9vS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85744179A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983386; cv=none; b=SdrYBMnPG+FCOO102aSbf6WWlp3Y9bN93c9OEjyIpZNT0Yd/LSizdKS9xtsC+OuQ54wejp12KyvqT2SFIk/YZRFUwfln2YMNk3reMSe7YIWhhtrjzqRtlhP2ZIhGb6WraS4pzoHtDBMz/GkDx08UMR4S3madZ3Ll2XXspbHeVP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983386; c=relaxed/simple;
	bh=z0UolR444oM6/Z6ndLplcYqhBHaayyvnNM7OuzXz4Io=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onOrf17P2gkd83Mgs61VaQORBxoxbP8Kvhms3FvP/4fQmn4tkHwGBBbFFT7fAvclfmXQZ2YOhctEqtfP2BQkbrO1pzmhI6wGx8sIv2ZOLEaNgcZdckCdNb5/S+gIgUT69bmMk+pimLRbcmuRetRQ2p6vjEtEsPlMxQy7+EgSHuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foHmk9vS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048B6C4CEF1;
	Tue, 16 Sep 2025 00:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983386;
	bh=z0UolR444oM6/Z6ndLplcYqhBHaayyvnNM7OuzXz4Io=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=foHmk9vS8+ZdHfIljiqye70/UUae71WBGMlDZu+WviS0s0tGQdkXkRHiRQ6vodkm2
	 dcXixmLzTp2u4ZEHbbROb03A6V344Jgzui0j5A9PWuAGEbp8wVpUFfYhZlQODOP0hi
	 prb3Ty6istOJ888vk7AwAgFA3ozgdd7vfIEU1Uu5hyWZ6cX/MLhlELRWu0soV4acLr
	 yBw8JcgB9ILMT61jpYA1Zi1Ppx3nlf+tx5EkoMmNK3JtCznfWYzhNIfwYNc2RTdIN4
	 E7L27LDTmH4yR33QRKQQ10HYpzYRh0OiwHn/PkaStTK+Ps3zr0QnJHCi/fXSG8/DaU
	 tWWnFDQTNqNDQ==
Date: Mon, 15 Sep 2025 17:43:05 -0700
Subject: [PATCH 05/18] libfuse: add a lowlevel notification to add a new
 device to iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154600.386924.7245319646442431808.stgit@frogsfrogsfrogs>
In-Reply-To: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
References: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Plumb in the pieces needed to attach block devices to a fuse+iomap mount
for use with iomap operations.  This enables us to have filesystems
where the metadata could live somewhere else, but the actual file IO
goes to locally attached storage.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h   |    7 +++++++
 include/fuse_lowlevel.h |   29 ++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   49 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    2 ++
 4 files changed, 87 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 111aef43e17245..b544d0700165e8 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1122,6 +1122,13 @@ struct fuse_notify_retrieve_in {
 	uint64_t	dummy4;
 };
 
+#define FUSE_BACKING_TYPE_MASK		(0xFF)
+#define FUSE_BACKING_TYPE_PASSTHROUGH	(0)
+#define FUSE_BACKING_TYPE_IOMAP		(1)
+#define FUSE_BACKING_MAX_TYPE		(FUSE_BACKING_TYPE_IOMAP)
+
+#define FUSE_BACKING_FLAGS_ALL		(FUSE_BACKING_TYPE_MASK)
+
 struct fuse_backing_map {
 	int32_t		fd;
 	uint32_t	flags;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index e2a81948811554..45e3cf8c79b91d 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1998,6 +1998,35 @@ int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
 int fuse_lowlevel_notify_retrieve(struct fuse_session *se, fuse_ino_t ino,
 				  size_t size, off_t offset, void *cookie);
 
+/**
+ * Attach an open file descriptor to a fuse+iomap mount.  Currently must be
+ * a block device.
+ *
+ * Added in FUSE protocol version 7.99. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param fd file descriptor of an open block device
+ * @param flags flags for the operation; none defined so far
+ * @return positive nonzero device id on success, or negative errno on failure
+ */
+int fuse_lowlevel_iomap_device_add(struct fuse_session *se, int fd,
+				   unsigned int flags);
+
+/**
+ * Detach an open file from a fuse+iomap mount.  Must be a device id returned
+ * by fuse_lowlevel_iomap_device_add.
+ *
+ * Added in FUSE protocol version 7.99. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param device_id device index as returned by fuse_lowlevel_iomap_device_add
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_lowlevel_iomap_device_remove(struct fuse_session *se, int device_id);
 
 /* ----------------------------------------------------------- *
  * Utility functions					       *
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 89fcdb87db7dee..a3cc5491ff6a24 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -580,6 +580,55 @@ int fuse_passthrough_close(fuse_req_t req, int backing_id)
 	return ret;
 }
 
+int fuse_lowlevel_iomap_device_add(struct fuse_session *se, int fd,
+				   unsigned int flags)
+{
+	struct fuse_backing_map map = {
+		.fd = fd,
+		.flags = FUSE_BACKING_TYPE_IOMAP |
+			(flags & ~FUSE_BACKING_TYPE_MASK),
+	};
+	int ret;
+
+	if (!(se->conn.want_ext & FUSE_CAP_IOMAP))
+		return -ENOSYS;
+
+	ret = ioctl(se->fd, FUSE_DEV_IOC_BACKING_OPEN, &map);
+	if (ret == 0) {
+		/* not supposed to happen */
+		ret = -1;
+		errno = ERANGE;
+	}
+	if (ret < 0) {
+		int err = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: iomap_device_add: %s\n",
+			 strerror(err));
+		return -err;
+	}
+
+	return ret;
+}
+
+int fuse_lowlevel_iomap_device_remove(struct fuse_session *se, int device_id)
+{
+	int ret;
+
+	if (!(se->conn.want_ext & FUSE_CAP_IOMAP))
+		return -ENOSYS;
+
+	ret = ioctl(se->fd, FUSE_DEV_IOC_BACKING_CLOSE, &device_id);
+	if (ret < 0) {
+		int err = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: iomap_device_remove: %s\n",
+			 strerror(errno));
+		return -err;
+	}
+
+	return ret;
+}
+
 int fuse_reply_open(fuse_req_t req, const struct fuse_file_info *f)
 {
 	struct fuse_open_out arg;
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index eb4d2f350ec63c..e796100c5ee414 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -222,6 +222,8 @@ FUSE_3.99 {
 	global:
 		fuse_iomap_pure_overwrite;
 		fuse_reply_iomap_begin;
+		fuse_lowlevel_iomap_device_add;
+		fuse_lowlevel_iomap_device_remove;
 } FUSE_3.18;
 
 # Local Variables:


