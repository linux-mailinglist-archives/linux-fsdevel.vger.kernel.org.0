Return-Path: <linux-fsdevel+bounces-61584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7496B58A00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C959166091
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCCE4207F;
	Tue, 16 Sep 2025 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5b8In7e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D495C96
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983684; cv=none; b=ZH25xCDj6nsnb5WozoVlTxOEEoCuMa1dXwsr7ZpuRdqFA4L0QoSsUTyltTtsRHpz2a/WETReu7tk5vHeUadkU1qgkrYDUTNJwjBhgG61NH1iHOsGrRm4b+0rhBaqC/2icJRvNejh1xXW6QTFXABH4tTuTmZTsipQiu1ykQDm2Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983684; c=relaxed/simple;
	bh=ayx7fxJLwd4DiptqR8ydUo+1NRzjZq3ihD9HINvYIpA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qxzql2BavNQ9kH0CeC4JFxT1B7N0eyoohoOyvu82e8gYJ+Jhdu1aBzmKFRygZjbC4EHS0kWzGbSXYFyerU9v8Hq5d6uLWWZ31MWLTdn01nJ6NXXqvsf+rSu/FjqC7MNfY9K0dwVN+POL3GmqAhy3UiEhHif/rj2oRMBicD06Hvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5b8In7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA6AC4CEF1;
	Tue, 16 Sep 2025 00:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983682;
	bh=ayx7fxJLwd4DiptqR8ydUo+1NRzjZq3ihD9HINvYIpA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=r5b8In7eewae92AlqQgqep940qwZafJocKahamRmt/t38CXHf4aPFo+TGsnvhGZcP
	 Sh5RnhRAFVqho04MnU93VjQDrgkl7qmIxIzb+J9iP9k8e9m94VejmUB06LJ6aHY1hN
	 JpwvLkBBicnI46+6fSZAV6WlpYeo1NVqKbRgk+MDTsMcmxQa7FVu6v2S1nfUz4Inyz
	 WM1GwtYHQgyb0/jxjnZ3dVliaczi6vcyEbFeBOs6qN77kh2t8bHaktRunxZBD0oNd8
	 zZ/4SZojhBR5ySqaqGSw0XqEdtfZ5fLAMG5UCYHARjKYcQ7UC8T6XbdiX7NdtQz5RT
	 0YULQNIkSPEoQ==
Date: Mon, 15 Sep 2025 17:48:02 -0700
Subject: [PATCH 1/3] libfuse: enable iomap cache management for lowlevel fuse
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798155530.387947.8457465046883846107.stgit@frogsfrogsfrogs>
In-Reply-To: <175798155502.387947.1593770316300327637.stgit@frogsfrogsfrogs>
References: <175798155502.387947.1593770316300327637.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add the library methods so that fuse servers can manage an in-kernel
iomap cache.  This enables better performance on small IOs and is
required if the filesystem needs synchronization between pagecache
writes and writeback.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h   |   12 ++++++++
 include/fuse_kernel.h   |   26 +++++++++++++++++
 include/fuse_lowlevel.h |   41 ++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   73 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    2 +
 5 files changed, 154 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 9016721320eb5a..ff245a82dd4069 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1158,6 +1158,10 @@ int fuse_convert_to_conn_want_ext(struct fuse_conn_info *conn);
 
 /* fuse-specific mapping type indicating that writes use the read mapping */
 #define FUSE_IOMAP_TYPE_PURE_OVERWRITE	(255)
+/* fuse-specific mapping type saying the server has populated the cache */
+#define FUSE_IOMAP_TYPE_RETRY_CACHE	(254)
+/* do not upsert this mapping */
+#define FUSE_IOMAP_TYPE_NOCACHE		(253)
 
 #define FUSE_IOMAP_DEV_NULL		(0U)	/* null device cookie */
 
@@ -1274,6 +1278,14 @@ struct fuse_iomap_config{
 	int64_t s_maxbytes;	/* max file size */
 };
 
+/* invalidate to end of file */
+#define FUSE_IOMAP_INVAL_TO_EOF		(~0ULL)
+
+struct fuse_iomap_inval {
+	uint64_t offset;	/* file offset to invalidate, bytes */
+	uint64_t length;	/* length to invalidate, bytes */
+};
+
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
  * ----------------------------------------------------------- */
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 4721c4e36159e1..3bb26fce2f6a0e 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -244,6 +244,8 @@
  *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
  *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of file
  *    attributes
+ *  - add FUSE_NOTIFY_IOMAP_UPSERT and FUSE_NOTIFY_IOMAP_INVAL so fuse servers
+ *    can cache iomappings in the kernel
  */
 
 #ifndef _LINUX_FUSE_H
@@ -702,6 +704,8 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
 	FUSE_NOTIFY_IOMAP_DEV_INVAL = 9,
+	FUSE_NOTIFY_IOMAP_UPSERT = 10,
+	FUSE_NOTIFY_IOMAP_INVAL = 11,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
@@ -1414,4 +1418,26 @@ struct fuse_iomap_dev_inval {
 	uint64_t offset;	/* range to invalidate pagecache, bytes */
 	uint64_t length;
 };
+
+struct fuse_iomap_inval_out {
+	uint64_t nodeid;	/* Inode ID */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+
+	uint64_t read_offset;	/* range to invalidate read iomaps, bytes */
+	uint64_t read_length;	/* can be FUSE_IOMAP_INVAL_TO_EOF */
+
+	uint64_t write_offset;	/* range to invalidate write iomaps, bytes */
+	uint64_t write_length;	/* can be FUSE_IOMAP_INVAL_TO_EOF */
+};
+
+struct fuse_iomap_upsert_out {
+	uint64_t nodeid;	/* Inode ID */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+
+	/* read file data from here */
+	struct fuse_iomap_io	read;
+
+	/* write file data to here, if applicable */
+	struct fuse_iomap_io	write;
+};
 #endif /* _LINUX_FUSE_H */
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 9de93392d6df67..1d73f2befc5f3c 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2189,6 +2189,47 @@ int fuse_lowlevel_iomap_device_remove(struct fuse_session *se, int device_id);
 int fuse_lowlevel_iomap_device_invalidate(struct fuse_session *se, int dev,
 					  off_t offset, off_t length);
 
+/*
+ * Upsert some file mapping information into the kernel.  This is necessary
+ * for filesystems that require coordination of mapping state changes between
+ * buffered writes and writeback, and desirable for better performance
+ * elsewhere.
+ *
+ * Added in FUSE protocol version 7.99. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param nodeid the inode number
+ * @param attr_ino inode number as told by fuse_attr::ino
+ * @param read mapping information for file reads
+ * @param write mapping information for file writes
+ * @return zero for success, -errno for failure
+ */
+int fuse_lowlevel_notify_iomap_upsert(struct fuse_session *se,
+				      fuse_ino_t nodeid, uint64_t attr_ino,
+				      const struct fuse_file_iomap *read,
+				      const struct fuse_file_iomap *write);
+
+/**
+ * Invalidate some file mapping information in the kernel.
+ *
+ * Added in FUSE protocol version 7.99. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param nodeid the inode number
+ * @param attr_ino inode number as told by fuse_attr::ino
+ * @param read read mapping range to invalidate
+ * @param write write mapping range to invalidate
+ * @return zero for success, -errno for failure
+ */
+int fuse_lowlevel_notify_iomap_inval(struct fuse_session *se,
+				     fuse_ino_t nodeid, uint64_t attr_ino,
+				     const struct fuse_iomap_inval *read,
+				     const struct fuse_iomap_inval *write);
+
 /* ----------------------------------------------------------- *
  * Utility functions					       *
  * ----------------------------------------------------------- */
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 668645dd1c2e08..1dc0fcbe54be6c 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -3530,6 +3530,79 @@ int fuse_lowlevel_iomap_device_invalidate(struct fuse_session *se, int dev,
 	return send_notify_iov(se, FUSE_NOTIFY_IOMAP_DEV_INVAL, iov, 2);
 }
 
+int fuse_lowlevel_notify_iomap_upsert(struct fuse_session *se,
+				      fuse_ino_t nodeid, uint64_t attr_ino,
+				      const struct fuse_file_iomap *read,
+				      const struct fuse_file_iomap *write)
+{
+	struct fuse_iomap_upsert_out outarg = {
+		.nodeid		= nodeid,
+		.attr_ino	= attr_ino,
+		.read		= {
+			.type	= FUSE_IOMAP_TYPE_NOCACHE,
+		},
+		.write		= {
+			.type	= FUSE_IOMAP_TYPE_NOCACHE,
+		}
+	};
+	struct iovec iov[2];
+
+	if (!se)
+		return -EINVAL;
+
+	if (se->conn.proto_minor < 99)
+		return -ENOSYS;
+
+	if (!read && !write)
+		return 0;
+
+	if (read)
+		fuse_iomap_to_kernel(&outarg.read, read);
+
+	if (write)
+		fuse_iomap_to_kernel(&outarg.write, write);
+
+	iov[1].iov_base = &outarg;
+	iov[1].iov_len = sizeof(outarg);
+
+	return send_notify_iov(se, FUSE_NOTIFY_IOMAP_UPSERT, iov, 2);
+}
+
+int fuse_lowlevel_notify_iomap_inval(struct fuse_session *se,
+				     fuse_ino_t nodeid, uint64_t attr_ino,
+				     const struct fuse_iomap_inval *read,
+				     const struct fuse_iomap_inval *write)
+{
+	struct fuse_iomap_inval_out outarg = {
+		.nodeid		= nodeid,
+		.attr_ino	= attr_ino,
+	};
+	struct iovec iov[2];
+
+	if (!se)
+		return -EINVAL;
+
+	if (se->conn.proto_minor < 99)
+		return -ENOSYS;
+
+	if (!read && !write)
+		return 0;
+
+	if (read) {
+		outarg.read_offset = read->offset;
+		outarg.read_length = read->length;
+	}
+	if (write) {
+		outarg.write_offset = write->offset;
+		outarg.write_length = write->length;
+	}
+
+	iov[1].iov_base = &outarg;
+	iov[1].iov_len = sizeof(outarg);
+
+	return send_notify_iov(se, FUSE_NOTIFY_IOMAP_INVAL, iov, 2);
+}
+
 struct fuse_retrieve_req {
 	struct fuse_notify_req nreq;
 	void *cookie;
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index a275b53c6f9f1a..48918d94d822e0 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -236,6 +236,8 @@ FUSE_3.99 {
 		fuse_reply_iomap_config;
 		fuse_lowlevel_iomap_device_invalidate;
 		fuse_fs_iomap_device_invalidate;
+		fuse_lowlevel_notify_iomap_upsert;
+		fuse_lowlevel_notify_iomap_inval;
 } FUSE_3.18;
 
 # Local Variables:


