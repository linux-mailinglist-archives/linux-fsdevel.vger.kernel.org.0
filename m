Return-Path: <linux-fsdevel+bounces-66062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57133C17B69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC77402C0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC062D73BC;
	Wed, 29 Oct 2025 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+89W111"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69781386C9;
	Wed, 29 Oct 2025 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699637; cv=none; b=NiJCs4d9Cxl2B4VXxM+TuuMCoEe8CXfXfhUneW6YCTZFSW6mhIicnlXRxuLyeb4wbH0uSrBnzQgyfP/Uehv5W6uzmuLMNxCKvTeGN7NDjuqpxviry3I0K8JbPuLwtILtjpLTS9ErSdsSoJwil7DrS17wtoHoOWP2HxYw0r5mxrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699637; c=relaxed/simple;
	bh=WBcQmhddMmlNEwU7MuPjmAvSJNR/iDyaP7QMlrXHrGE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcHRjnYtzQiS8i5YceiMdPfhDCCZy5QYRv6nedeFYtVdBJGadoYcydqQdPBRee39CZdJlfwWUSsioHCKnmPfpyfSdTbutxwo6j1WvMdxcnq2XCY0YlXvnewnBDW7W5UHDsy4mcxoeT2Fwt2R43dpPzRoTMfedeJ6qta0yBU8wWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+89W111; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC91C4CEE7;
	Wed, 29 Oct 2025 01:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699637;
	bh=WBcQmhddMmlNEwU7MuPjmAvSJNR/iDyaP7QMlrXHrGE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C+89W111zJQ/qihmMgpyTbb7GXd0pp6qz7Q7unb1nNyZF3RgnZeDljLXn688qQvMn
	 XWvLgXiS+XNaDz5gAkk+4dB4h2jCLj0DCyIbKno//uyDx/AjPXB/yX2sg71uEHKvru
	 9lReK09dMcLA/JHEv8RJjPV0NIzWSNfTcN5wI3z7BPXEQdB0IKj5swu3cvxVcKgUfm
	 9/qOYNxHki3cfSffAC8uUYvUagG0mwpKP7uIK4jzYOnewYOSPkKGU5Fs5zu0Oic+0y
	 9824F5F7S0gV6Mqc0Iqz8mbGvAhPdk34xRD3ljK6c41BwOic2eKZoiRNnd3zClOFjk
	 oRYABM7KFus1Q==
Date: Tue, 28 Oct 2025 18:00:36 -0700
Subject: [PATCH 05/22] libfuse: add a lowlevel notification to add a new
 device to iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813623.1427432.14615682864907341702.stgit@frogsfrogsfrogs>
In-Reply-To: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
References: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
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
index 99cc2a4245fa6a..3857259e27f9c1 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1127,6 +1127,13 @@ struct fuse_notify_retrieve_in {
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
index 344d1457e217ee..dcacde79e78b1a 100644
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
index ed0999e2c46b3c..570253b9dc74b6 100644
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


