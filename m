Return-Path: <linux-fsdevel+bounces-55360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B45DFB09830
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2481C26319
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C1923771E;
	Thu, 17 Jul 2025 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1ARvNK5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86701233D85
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795500; cv=none; b=VMZ2J/EaRDbJAumLwOGvKF5Z6apFxOhGmKuUelSXvbCeIXlP3xGj5oK04pyurRwLZmbiHcUG+BD+aoFaO4/dVtgkUP7l40cjxR5qOrs+TTdKQXnf2UStX7yNVHhebaboOJsjixP7XZ1wHVKJJukse86a+LhtGNh+hPR4sB4YDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795500; c=relaxed/simple;
	bh=wXlNPzasg68EMrcPg+WVl4Zoop9kcGkL2t6VZLJbpvg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8fnxmSUdfavLIMlgkfctLNeoOliMYlSwSL3r2+jaXFRKLyNsWOYoIoYw/pG8tgaiDaC9wXg9WJ1qrkfNXjnV4GkzQmRcm8qKkEgNSJUinCCyfoujN99lCKQrRZvzXW4z09eoMZMWuv8iq69ZzDN2ez5h/YSbHiS3k37Q8X0+Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1ARvNK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B222C4CEE3;
	Thu, 17 Jul 2025 23:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795500;
	bh=wXlNPzasg68EMrcPg+WVl4Zoop9kcGkL2t6VZLJbpvg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=T1ARvNK5LOrXqolTVsGQywWOKh4Anpj4d9Jq1EFyC82ToxZ5+S4+C6fQFzTAAWFUX
	 2bru4NOExVQJVj6oRX9yuPtABIz8rRngvrUC8Wybcd4eDHMN5MiVevTXV0o/VhBmSQ
	 uxlMAN0cI2WQ+RaFML4ImIhG7MEXk5Ey2GliBZ34x+ZRuzK2fKLsdoWuR0HVjG5vV7
	 PWaujzJ+gBsoy2a8e8qyg3zHsoH96sXZZmDJhf1Ql0V1dCtkJZ8iAjqMmUkx2gmJHm
	 7jhqF81DQJLN00y9/vogQVXm98s7FzkU7cyAgmCB+gKcW08ZJZNi8Xg5c289h2i6eg
	 mkOE1sG2/cNDg==
Date: Thu, 17 Jul 2025 16:38:19 -0700
Subject: [PATCH 1/1] libfuse: enable iomap cache management
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279460180.714730.8674508220056498050.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460162.714730.17358082513177016895.stgit@frogsfrogsfrogs>
References: <175279460162.714730.17358082513177016895.stgit@frogsfrogsfrogs>
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
 include/fuse_common.h   |    9 +++++
 include/fuse_kernel.h   |   34 +++++++++++++++++++
 include/fuse_lowlevel.h |   39 ++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   82 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    2 +
 5 files changed, 166 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 98cb8f656efd13..1237cc2656b9c4 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1164,6 +1164,7 @@ int fuse_convert_to_conn_want_ext(struct fuse_conn_info *conn);
  */
 #if FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 18)
 #define FUSE_IOMAP_TYPE_PURE_OVERWRITE	(0xFFFF) /* use read mapping data */
+#define FUSE_IOMAP_TYPE_NULL		(0xFFFE) /* no mapping here */
 #define FUSE_IOMAP_TYPE_HOLE		0	/* no blocks allocated, need allocation */
 #define FUSE_IOMAP_TYPE_DELALLOC	1	/* delayed allocation blocks */
 #define FUSE_IOMAP_TYPE_MAPPED		2	/* blocks allocated at @addr */
@@ -1208,6 +1209,11 @@ struct fuse_iomap {
 	uint32_t dev;		/* device cookie */
 };
 
+struct fuse_iomap_inval {
+	uint64_t offset;	/* file offset to invalidate, bytes */
+	uint64_t length;	/* length to invalidate, bytes */
+};
+
 /* out of place write extent */
 #define FUSE_IOMAP_IOEND_SHARED		(1U << 0)
 /* unwritten extent */
@@ -1258,6 +1264,9 @@ struct fuse_iomap_config{
 	int64_t s_maxbytes;	/* max file size */
 };
 
+/* invalidate to end of file */
+#define FUSE_IOMAP_INVAL_TO_EOF		(~0ULL)
+
 #endif /* FUSE_USE_VERSION >= 318 */
 
 /* ----------------------------------------------------------- *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 3c704f03434693..f1a93dbd1ff443 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -243,6 +243,8 @@
  *  - add FUSE_IOMAP_DIRECTIO/FUSE_ATTR_IOMAP_DIRECTIO for direct I/O support
  *  - add FUSE_IOMAP_FILEIO/FUSE_ATTR_IOMAP_FILEIO for buffered I/O support
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
+ *  - add FUSE_NOTIFY_IOMAP_UPSERT and FUSE_NOTIFY_IOMAP_INVAL so fuse servers
+ *    can cache iomappings in the kernel
  */
 
 #ifndef _LINUX_FUSE_H
@@ -699,6 +701,8 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
+	FUSE_NOTIFY_IOMAP_UPSERT = 9,
+	FUSE_NOTIFY_IOMAP_INVAL = 10,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
@@ -1406,4 +1410,34 @@ struct fuse_iomap_config_out {
 	int64_t s_maxbytes;	/* max file size */
 };
 
+struct fuse_iomap_upsert_out {
+	uint64_t nodeid;	/* Inode ID */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+
+	uint64_t read_offset;	/* file offset of mapping, bytes */
+	uint64_t read_length;	/* length of mapping, bytes */
+	uint64_t read_addr;	/* disk offset of mapping, bytes */
+	uint16_t read_type;	/* FUSE_IOMAP_TYPE_* */
+	uint16_t read_flags;	/* FUSE_IOMAP_F_* */
+	uint32_t read_dev;	/* device cookie */
+
+	uint64_t write_offset;	/* file offset of mapping, bytes */
+	uint64_t write_length;	/* length of mapping, bytes */
+	uint64_t write_addr;	/* disk offset of mapping, bytes */
+	uint16_t write_type;	/* FUSE_IOMAP_TYPE_* */
+	uint16_t write_flags;	/* FUSE_IOMAP_F_* */
+	uint32_t write_dev;	/* device cookie * */
+};
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
 #endif /* _LINUX_FUSE_H */
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index fd7df5c2c11e16..f690c62fcdd61c 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2101,6 +2101,45 @@ int fuse_lowlevel_notify_retrieve(struct fuse_session *se, fuse_ino_t ino,
  * @return positive device id for success, zero for failure
  */
 int fuse_iomap_add_device(struct fuse_session *se, int fd, unsigned int flags);
+
+/**
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
+ * @param read_iomap mapping information for file reads
+ * @param write_iomap mapping information for file reads
+ * @return zero for success, -errno for failure
+ */
+int fuse_lowlevel_notify_iomap_upsert(struct fuse_session *se,
+				      fuse_ino_t nodeid, uint64_t attr_ino,
+				      const struct fuse_iomap *read_iomap,
+				      const struct fuse_iomap *write_iomap);
+
+/**
+ * Invalidate some file mapping information in the kernel.
+ *
+ * Added in FUSE protocol version 7.99. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param read read mapping range to invalidate
+ * @param write write mapping range to invalidate
+ * @return zero for success, -errno for failure
+ */
+int fuse_lowlevel_notify_iomap_inval(struct fuse_session *se,
+				     fuse_ino_t nodeid,
+				     const struct fuse_iomap_inval *read,
+				     const struct fuse_iomap_inval *write);
 #endif
 
 /* ----------------------------------------------------------- *
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index ed9464d592c8a1..e31ce96593a9b3 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -3349,6 +3349,88 @@ int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
 	return res;
 }
 
+int fuse_lowlevel_notify_iomap_upsert(struct fuse_session *se,
+				      fuse_ino_t nodeid, uint64_t attr_ino,
+				      const struct fuse_iomap *read_iomap,
+				      const struct fuse_iomap *write_iomap)
+{
+	struct fuse_iomap_upsert_out outarg = {
+		.nodeid		= nodeid,
+		.attr_ino	= attr_ino,
+	};
+	struct iovec iov[2];
+
+	if (!se)
+		return -EINVAL;
+
+	if (se->conn.proto_minor < 44)
+		return -ENOSYS;
+
+	if (!read_iomap && !write_iomap)
+		return 0;
+
+	if (read_iomap) {
+		outarg.read_offset = read_iomap->offset;
+		outarg.read_length = read_iomap->length;
+		outarg.read_addr = read_iomap->addr;
+		outarg.read_type = read_iomap->type;
+		outarg.read_flags = read_iomap->flags;
+		outarg.read_dev = read_iomap->dev;
+	} else {
+		outarg.read_type = FUSE_IOMAP_TYPE_NULL;
+	}
+
+	if (write_iomap) {
+		outarg.write_offset = write_iomap->offset;
+		outarg.write_length = write_iomap->length;
+		outarg.write_addr = write_iomap->addr;
+		outarg.write_type = write_iomap->type;
+		outarg.write_flags = write_iomap->flags;
+		outarg.write_dev = write_iomap->dev;
+	} else {
+		outarg.write_type = FUSE_IOMAP_TYPE_NULL;
+	}
+
+	iov[1].iov_base = &outarg;
+	iov[1].iov_len = sizeof(outarg);
+
+	return send_notify_iov(se, FUSE_NOTIFY_IOMAP_UPSERT, iov, 2);
+}
+
+int fuse_lowlevel_notify_iomap_inval(struct fuse_session *se,
+				     fuse_ino_t nodeid,
+				     const struct fuse_iomap_inval *read,
+				     const struct fuse_iomap_inval *write)
+{
+	struct fuse_iomap_inval_out outarg = {
+		.nodeid		= nodeid,
+	};
+	struct iovec iov[2];
+
+	if (!se)
+		return -EINVAL;
+
+	if (se->conn.proto_minor < 44)
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
index 9cb46d8a7afdd2..dc9fa2428b5325 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -221,6 +221,8 @@ FUSE_3.18 {
 		fuse_add_direntry_plus_iflags;
 		fuse_discover_iomap;
 		fuse_reply_iomap_config;
+		fuse_lowlevel_notify_iomap_upsert;
+		fuse_lowlevel_notify_iomap_inval;
 } FUSE_3.17;
 
 # Local Variables:


