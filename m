Return-Path: <linux-fsdevel+bounces-58480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ECFB2E9F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852C717A642
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E681C3BF7;
	Thu, 21 Aug 2025 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiKpcGUs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92BE4315A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738161; cv=none; b=AaY7tBu2nskiZ+rH1auQxSE3AgWJhILkOEVebzB0SC5EunJ49JZncrEW0c4scJlwDiNrInYW+K1UAWzczC+UoY/SzGasqMC5nJ/XRpKAzoomp2PpInSYsKemkOwl+lOdCw+LK6sNC8j4nwH7tTiyI2gR8T0OqLo2cOYlqlD0aEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738161; c=relaxed/simple;
	bh=RngvImYxXMBZmAqkh2Vj+aX0U9MeuH5j1FL+XsTz5rE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vE3Qb/A+lWJ1ge/fda4IN5RqSWjUm206I3faNXE2yI0HYpOjyGS2eVIz3NE2NZpXOufsN7j3Bn8IjdZxFTJ+zJd1hIswjxIdEo0EwiWb/x+66t34nMy4/jsltdILhC+h6r6iaHXwQxIZMlp4FR8BBLojTGfrbkI669VKQyo99og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiKpcGUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E061C4CEEB;
	Thu, 21 Aug 2025 01:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738160;
	bh=RngvImYxXMBZmAqkh2Vj+aX0U9MeuH5j1FL+XsTz5rE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=uiKpcGUsPXL2omiC8cJXuUXbCFgn53vokOLlp1RfNmRgKKnjhw9djBTQHqEzWGAk4
	 SYdaOPBUIQdYglsgrI5Hj1exKma9MtxKS7+hyfhZCGS2q8dn8j99ZWbLPnrDUzCalt
	 2nFEsKAamYw+YEMUwAAN5pZhmauHR6m9RFeO/LydrrqaLoMkr6lY9yYd/IsMNS5piw
	 zdGazy8h1UrxpGwBhFuX8eTEjk6Q8pC++pnMx4y3xjacIWsQO+QPYDeuJkpP7GMLGE
	 EK252VglFfGczhd+CKAgwElkKrskFaVMGX8POoGlg5y5wL8ULOH2gkGnSkTK5WVICz
	 J4Jxi5543BdOA==
Date: Wed, 20 Aug 2025 18:02:40 -0700
Subject: [PATCH 05/21] libfuse: add a lowlevel notification to add a new
 device to iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711377.19163.2191566758748191617.stgit@frogsfrogsfrogs>
In-Reply-To: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
References: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
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
 include/fuse_lowlevel.h |   29 ++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   48 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    2 ++
 3 files changed, 79 insertions(+)


diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index f9704533b5276d..45655781e510a0 100644
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
index c8106cb25a02d3..fec4e3265e53c1 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -580,6 +580,54 @@ int fuse_passthrough_close(fuse_req_t req, int backing_id)
 	return ret;
 }
 
+int fuse_lowlevel_iomap_device_add(struct fuse_session *se, int fd,
+				   unsigned int flags)
+{
+	struct fuse_backing_map map = {
+		.fd = fd,
+		.flags = flags,
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
index 17c9e538a67bfa..d785303bab99ea 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -221,6 +221,8 @@ FUSE_3.99 {
 	global:
 		fuse_iomap_pure_overwrite;
 		fuse_reply_iomap_begin;
+		fuse_lowlevel_iomap_device_add;
+		fuse_lowlevel_iomap_device_remove;
 } FUSE_3.18;
 
 # Local Variables:


