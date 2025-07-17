Return-Path: <linux-fsdevel+bounces-55349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B5DB09823
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1543A9812
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2741023FC4C;
	Thu, 17 Jul 2025 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulNZkGxi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886901FCFF8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795328; cv=none; b=gpjEFnKci6Lzczzs8lgL/srchYtuzuurQa7ORLcG7oxARMoy9kzkihw+YhjGlAXSmuCou7heKy+iCFBojE+Hjjh/LeARZmvWF+XuHluNzOIgFfiHePoSxm+7Y7FoleFZL31xhjxgEaFt2xT1qRwE0zD8G5edN69KDvqtP2Fb/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795328; c=relaxed/simple;
	bh=n4rSzJAA46wcGTxcE6g0/EXC6xV/IoUZGmkwSup24Yg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4Cj7QebJjrc3HiVvdBy7RTCmAlfRc+HR8MRfKlTf9IQ0NP58Zg48gp+tyeGBWBCiP74qK3kUnTnaA3z74oeBCg/xQQVKiLBhZMR7wrcuTiItiYM2eKTHck9Lzk7d/p5vbhCXEq3ba32SYYZ/XB0YE/zYWX2dkffYIb/ihlb4po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulNZkGxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCDDC4CEE3;
	Thu, 17 Jul 2025 23:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795328;
	bh=n4rSzJAA46wcGTxcE6g0/EXC6xV/IoUZGmkwSup24Yg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ulNZkGxi0l4x5TmYx2cDUsmFyM3mwtpeG58OGSclLwwyYAiirylGiWn6GD9Lhu1eI
	 wClJICjZJCRZPBVwSFKpLUg19AxUWnQHwmX7Ny9Hn0M+ninsOaw63nXS89H3N/jDKf
	 VufQ8PQfXwDCuCy+oyTtgoPuNwuwWH+VERxnoNVcWcF9FDo8J74/NN69GtgMd/jAue
	 GelBsu2UP9iXwxF0EEx9rbbN6FMbDakYelMYm0ohaCwKl4Ex3IPHn7sz4a37eiRfVR
	 7edzqSY4VDeIkExBza56/cxBoqvcV2BL3mIxiRglcatqbD5t484TPyi92WOkIzRXi7
	 Px+im6FTv/Agw==
Date: Thu, 17 Jul 2025 16:35:27 -0700
Subject: [PATCH 04/14] libfuse: add a notification to add a new device to
 iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279459803.714161.8814424637325014212.stgit@frogsfrogsfrogs>
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

Plumb in the pieces needed to attach block devices to a fuse+iomap mount
for use with iomap operations.  This enables us to have filesystems
where the metadata could live somewhere else, but the actual file IO
goes to locally attached storage.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h   |    3 +++
 include/fuse_lowlevel.h |   16 ++++++++++++++++
 lib/fuse_lowlevel.c     |   17 +++++++++++++++++
 lib/fuse_versionscript  |    1 +
 4 files changed, 37 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index eb59ff687b2e7d..97ca55f0114b1d 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -239,6 +239,7 @@
  *  7.99
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
  *    SEEK_{DATA,HOLE} support
+ *  - add FUSE_DEV_IOC_IOMAP_DEV_ADD to configure block devices for iomap
  */
 
 #ifndef _LINUX_FUSE_H
@@ -1136,6 +1137,8 @@ struct fuse_backing_map {
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_IOMAP_DEV_ADD	_IOW(FUSE_DEV_IOC_MAGIC, 3, \
+					     struct fuse_backing_map)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index d3de87897c47b8..d3e505ed52815b 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1962,6 +1962,22 @@ int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
 int fuse_lowlevel_notify_retrieve(struct fuse_session *se, fuse_ino_t ino,
 				  size_t size, off_t offset, void *cookie);
 
+#if FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 18)
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
+ * @return positive device id for success, zero for failure
+ */
+int fuse_iomap_add_device(struct fuse_session *se, int fd, unsigned int flags);
+#endif
 
 /* ----------------------------------------------------------- *
  * Utility functions					       *
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 875d2345461251..5df0cdd4ac461a 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -580,6 +580,23 @@ int fuse_passthrough_close(fuse_req_t req, int backing_id)
 	return ret;
 }
 
+int fuse_iomap_add_device(struct fuse_session *se, int fd, unsigned int flags)
+{
+	struct fuse_backing_map map = {
+		.fd = fd,
+		.flags = flags,
+	};
+	int ret;
+
+	ret = ioctl(se->fd, FUSE_DEV_IOC_IOMAP_DEV_ADD, &map);
+	if (ret <= 0) {
+		fuse_log(FUSE_LOG_ERR, "fuse: iomap_dev_add: %s\n", strerror(errno));
+		return 0;
+	}
+
+	return ret;
+}
+
 int fuse_reply_open(fuse_req_t req, const struct fuse_file_info *f)
 {
 	struct fuse_open_out arg;
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 2b4c16abdaf519..4cdae6a6a42051 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -214,6 +214,7 @@ FUSE_3.18 {
 		fuse_convert_to_conn_want_ext;
 
 		fuse_reply_iomap_begin;
+		fuse_iomap_add_device;
 } FUSE_3.17;
 
 # Local Variables:


