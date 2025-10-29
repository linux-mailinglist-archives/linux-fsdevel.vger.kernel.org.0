Return-Path: <linux-fsdevel+bounces-66085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45137C17C20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7015A501602
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9442D8767;
	Wed, 29 Oct 2025 01:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7Ql/BZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729A1A7264;
	Wed, 29 Oct 2025 01:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699997; cv=none; b=s9dVfm7HQNAAcC//CNczlVTPAh/hQTI/AHx/RdcTYCbWLCmDFk1fl2m/0ZAwkQMqq4P2PmC8RiIFOUNOYJjJvgyyAtAwZj4E5YLbXVvYOyIfr++x1OBhTTpjLXyNDY5RlComCfocVsbo74Nsybz4uSye1pG3uzf1k6irNVpp+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699997; c=relaxed/simple;
	bh=j6m0+Zbn4UmHyZRBzZ4JAfnn2Go7XC/KVvPqfbrY/yk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhC42MMZiN9+23Dt3F0oiiyAT6VMq+b76j9N44v49B0QpY7FZyXXuz7Na6bPwmrh1yXbgjyydpNmiP9Z4ntSgKLO/bj6XPGEY9hekvWr9eEAexHvXXYSvDUSgXunIVGLrYHnVRqHgz80c/Ea/YRCdmOeiw0Ticoa+stqq8mAzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7Ql/BZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB64EC4CEE7;
	Wed, 29 Oct 2025 01:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699996;
	bh=j6m0+Zbn4UmHyZRBzZ4JAfnn2Go7XC/KVvPqfbrY/yk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=N7Ql/BZC20LIm2CcvgxO1zq5a/llBmR/j9HFVlvCe7VJBSt1zNUHik6KVxG6DIZVq
	 yGpmH6Sk7MAINLv04wPNd/tYKxOVEcChmU1XdX4dKph83Qf+UTuBdcrQ06y9Zs06Np
	 a9psn160eN0ubZhZrwhBzKrjdor3kYry4txvjbjoI9ONa+flrYrIBi6hF3EGavETQ+
	 WOEQk9CU1rXwg57/0OodLvWM7sobzJEArvmmWn2dxXBk/z6+h8WxNdyZh4d/1R0kwL
	 HKBzeTNFpDSCA2aPfwynRFoIMvfgsX+BmJcZuuFp4C4hbxWlDuErEl+kQpOwF5KUKV
	 fa9evnd+Wc6og==
Date: Tue, 28 Oct 2025 18:06:36 -0700
Subject: [PATCH 1/3] libfuse: enable iomap cache management for lowlevel fuse
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169814597.1428599.11880346679875224215.stgit@frogsfrogsfrogs>
In-Reply-To: <176169814570.1428599.1070273812934230095.stgit@frogsfrogsfrogs>
References: <176169814570.1428599.1070273812934230095.stgit@frogsfrogsfrogs>
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
index 5df95ba35ce341..472f1160f14fd3 100644
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
 
@@ -1279,6 +1283,14 @@ struct fuse_iomap_config{
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
index 6fd0397b758eae..10bdf276ef9b74 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -248,6 +248,8 @@
  *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
  *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of file
  *    attributes
+ *  - add FUSE_NOTIFY_IOMAP_UPSERT and FUSE_NOTIFY_IOMAP_INVAL so fuse servers
+ *    can cache iomappings in the kernel
  */
 
 #ifndef _LINUX_FUSE_H
@@ -711,6 +713,8 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
 	FUSE_NOTIFY_IOMAP_DEV_INVAL = 99,
+	FUSE_NOTIFY_IOMAP_UPSERT = 100,
+	FUSE_NOTIFY_IOMAP_INVAL = 101,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
@@ -1436,4 +1440,26 @@ struct fuse_iomap_dev_inval {
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
index f12f9b8226aa89..d79b7e1902b331 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2224,6 +2224,47 @@ int fuse_lowlevel_iomap_device_remove(struct fuse_session *se, int device_id);
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
index f58ffa36978ae7..00f8f1b6035df4 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -3649,6 +3649,79 @@ int fuse_lowlevel_iomap_device_invalidate(struct fuse_session *se, int dev,
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
index 32dc681bf518d0..696cb77a254ccb 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -237,6 +237,8 @@ FUSE_3.99 {
 		fuse_lowlevel_iomap_device_invalidate;
 		fuse_fs_iomap_device_invalidate;
 		fuse_loopdev_setup;
+		fuse_lowlevel_notify_iomap_upsert;
+		fuse_lowlevel_notify_iomap_inval;
 } FUSE_3.18;
 
 # Local Variables:


