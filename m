Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C5D24CFB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgHUHln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgHUHkr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45BEC061387
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m8so672179pfh.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59wLxKEGGMVdmg8WMIQKvh0B8MJPz8LP0c+p/JHjMeI=;
        b=ai0qVSvd4xZ+AVf2o+pCvnuJY6w2zbKNosA5+1QEVloHHlZDjhTUNHRaBHr0o2GGe9
         /W8lJaqO60mKN3qpsSGDDJfidQxMTHvRRU3PDe/TlPPhIcycyXsM8vx8d7tCJ+0iaymJ
         Qg2bMJwzRT898RuHe2kEzYZECtI7HcIr7NXmUAGnk3y4l+DcgMMGH/+h8PnRQyGv0KOV
         Lw/XH9vQcJ8wv6JB+Q9/QzxFU4UDy4X9Xo3rX7gI/pQR4g4c1kzO1rPXoWT/vqb4RwTv
         AkNKmy88wEhULnqSqxbDuwpE/w++tOowz7PUX3oVzeWfxPKQMbTINeG+fAS4bjah6HQ+
         v7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59wLxKEGGMVdmg8WMIQKvh0B8MJPz8LP0c+p/JHjMeI=;
        b=ophlAdS9l8+7beyw06ni/XCGjwGmx6WU0/ug7286zHpVw5RFA4OO9cutWXD3O6IDEX
         /J1wVDcG/60FRPO7YUgI55m3hFb8bB1oH5FX9cAfOOKS7HiCMz0SkFcuTqNLqZL0g4Re
         /dsQM3OBroD97Xh4z7uH1TmfGnPVv/KdCwUlNC0XnI2KjptK7PQmtbVzELo3T9NvgHZc
         YdDAUPD/2MNhjYU9MBbemlFwR8TnBpTBdwd91RbYKZzT++SgkxB/OdifXILQwWDOD+L3
         PlAiMYIR6eynn7toCwIhYy4gdb0iIiuijDQ2xzn6S3aTWk6P1as+hhEUC0gs6SL8oG6k
         8YmQ==
X-Gm-Message-State: AOAM5314jVJEcaAId6fqsrhBoDNL6LMB/6T+qWLBlMNo7VmM92KQHGcA
        m1124qJ1eo5YcMUvDnrijEperw==
X-Google-Smtp-Source: ABdhPJwdeePrHZyVrmtrTedqGtO/xbSVOtbAgk45i31trv/BfN2gKuUv+E6Z5eJeg73eoPeyfchUEQ==
X-Received: by 2002:a63:b913:: with SMTP id z19mr373213pge.283.1597995647115;
        Fri, 21 Aug 2020 00:40:47 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:45 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/11] btrfs-progs: receive: process encoded_write commands
Date:   Fri, 21 Aug 2020 00:40:05 -0700
Message-Id: <acd0ffe6a8691cbdd7c410d3c1bc152201663704.1597994354.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boris Burkov <borisb@fb.com>

Add a new btrfs_send_op and support for both dumping and proper receive
processing which does actual encoded writes.

Encoded writes are only allowed on a file descriptor opened with an extra
flag that allows encoded writes, so we also add support for this flag
when opening or reusing a file for writing.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 cmds/receive-dump.c  | 16 +++++++-
 cmds/receive.c       | 98 +++++++++++++++++++++++++++++++++++++++++---
 common/send-stream.c | 22 ++++++++++
 common/send-stream.h |  4 ++
 stubs.h              | 39 ++++++++++++++++++
 5 files changed, 173 insertions(+), 6 deletions(-)

diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
index 648d9314..20ec2b70 100644
--- a/cmds/receive-dump.c
+++ b/cmds/receive-dump.c
@@ -316,6 +316,19 @@ static int print_update_extent(const char *path, u64 offset, u64 len,
 			  offset, len);
 }
 
+static int print_encoded_write(const char *path, const void *data, u64 offset,
+			       u64 len, u64 unencoded_file_len,
+			       u64 unencoded_len, u64 unencoded_offset,
+			       u32 compression, u32 encryption, void *user)
+{
+	return PRINT_DUMP(user, path, "encoded_write",
+			  "offset=%llu len=%llu, unencoded_file_len=%llu, "
+			  "unencoded_len=%llu, unencoded_offset=%llu, "
+			  "compression=%u, encryption=%u",
+			  offset, len, unencoded_file_len, unencoded_len,
+			  unencoded_offset, compression, encryption);
+}
+
 struct btrfs_send_ops btrfs_print_send_ops = {
 	.subvol = print_subvol,
 	.snapshot = print_snapshot,
@@ -337,5 +350,6 @@ struct btrfs_send_ops btrfs_print_send_ops = {
 	.chmod = print_chmod,
 	.chown = print_chown,
 	.utimes = print_utimes,
-	.update_extent = print_update_extent
+	.update_extent = print_update_extent,
+	.encoded_write = print_encoded_write,
 };
diff --git a/cmds/receive.c b/cmds/receive.c
index 2aaba3ff..cd0f47ec 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -30,12 +30,14 @@
 #include <assert.h>
 #include <getopt.h>
 #include <limits.h>
+#include <errno.h>
 
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/ioctl.h>
 #include <sys/time.h>
 #include <sys/types.h>
+#include <sys/uio.h>
 #include <sys/xattr.h>
 #include <uuid/uuid.h>
 
@@ -52,6 +54,7 @@
 #include "cmds/receive-dump.h"
 #include "common/help.h"
 #include "common/path-utils.h"
+#include "stubs.h"
 
 struct btrfs_receive
 {
@@ -60,6 +63,7 @@ struct btrfs_receive
 
 	int write_fd;
 	char write_path[PATH_MAX];
+	int write_fd_allow_encoded;
 
 	char *root_path;
 	char *dest_dir_path; /* relative to root_path */
@@ -643,24 +647,65 @@ out:
 	return ret;
 }
 
-static int open_inode_for_write(struct btrfs_receive *rctx, const char *path)
+static int set_write_fd_allow_encoded(struct btrfs_receive *rctx)
+{
+	int ret;
+	int flags;
+
+	flags = fcntl(rctx->write_fd, F_GETFL);
+	if (flags < 0) {
+		ret = -errno;
+		error("failed to fetch old fd flags");
+		goto close_fd;
+	}
+	ret = fcntl(rctx->write_fd, F_SETFL, flags | O_ALLOW_ENCODED);
+	if (ret < 0) {
+		ret = -errno;
+		error("failed to enable encoded writes");
+		goto close_fd;
+	}
+	rctx->write_fd_allow_encoded = true;
+	ret = 0;
+	goto out;
+close_fd:
+	close(rctx->write_fd);
+	rctx->write_fd = -1;
+	rctx->write_fd_allow_encoded = false;
+out:
+	return ret;
+}
+
+static int open_inode_for_write(struct btrfs_receive *rctx, const char *path,
+				bool allow_encoded)
 {
 	int ret = 0;
+	int flags = O_RDWR;
 
 	if (rctx->write_fd != -1) {
-		if (strcmp(rctx->write_path, path) == 0)
+		/*
+		 * if the existing fd is for this path and the needed flags are
+		 * satisfied, no need to open a new one
+		 */
+		if (strcmp(rctx->write_path, path) == 0) {
+			/* fixup the allow encoded flag, if necessary */
+			if (allow_encoded && !rctx->write_fd_allow_encoded)
+				ret = set_write_fd_allow_encoded(rctx);
 			goto out;
+		}
 		close(rctx->write_fd);
 		rctx->write_fd = -1;
 	}
 
-	rctx->write_fd = open(path, O_RDWR);
+	if (allow_encoded)
+		flags |= O_ALLOW_ENCODED;
+	rctx->write_fd = open(path, flags);
 	if (rctx->write_fd < 0) {
 		ret = -errno;
 		error("cannot open %s: %m", path);
 		goto out;
 	}
 	strncpy_null(rctx->write_path, path);
+	rctx->write_fd_allow_encoded = allow_encoded;
 
 out:
 	return ret;
@@ -691,7 +736,7 @@ static int process_write(const char *path, const void *data, u64 offset,
 		goto out;
 	}
 
-	ret = open_inode_for_write(rctx, full_path);
+	ret = open_inode_for_write(rctx, full_path, false);
 	if (ret < 0)
 		goto out;
 
@@ -734,7 +779,7 @@ static int process_clone(const char *path, u64 offset, u64 len,
 		goto out;
 	}
 
-	ret = open_inode_for_write(rctx, full_path);
+	ret = open_inode_for_write(rctx, full_path, false);
 	if (ret < 0)
 		goto out;
 
@@ -1028,6 +1073,48 @@ static int process_update_extent(const char *path, u64 offset, u64 len,
 	return 0;
 }
 
+static int process_encoded_write(const char *path, const void *data, u64 offset,
+	u64 len, u64 unencoded_file_len, u64 unencoded_len,
+	u64 unencoded_offset, u32 compression, u32 encryption, void *user)
+{
+	int ret;
+	struct btrfs_receive *rctx = user;
+	char full_path[PATH_MAX];
+	struct encoded_iov encoded = {
+		.len = unencoded_file_len,
+		.unencoded_len = unencoded_len,
+		.unencoded_offset = unencoded_offset,
+		.compression = compression,
+		.encryption = encryption,
+	};
+	struct iovec iov[2] = {
+		{ &encoded, sizeof(encoded) },
+		{ (char *)data, len }
+	};
+
+	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
+	if (ret < 0) {
+		error("encoded_write: path invalid: %s", path);
+		goto out;
+	}
+
+	ret = open_inode_for_write(rctx, full_path, true);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * NOTE: encoded writes guarantee no partial writes,
+	 * so we don't need to handle that possibility.
+	 */
+	ret = pwritev2(rctx->write_fd, iov, 2, offset, RWF_ENCODED);
+	if (ret < 0) {
+		ret = -errno;
+		error("encoded_write: writing to %s failed: %m", path);
+	}
+out:
+	return ret;
+}
+
 static struct btrfs_send_ops send_ops = {
 	.subvol = process_subvol,
 	.snapshot = process_snapshot,
@@ -1050,6 +1137,7 @@ static struct btrfs_send_ops send_ops = {
 	.chown = process_chown,
 	.utimes = process_utimes,
 	.update_extent = process_update_extent,
+	.encoded_write = process_encoded_write,
 };
 
 static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
diff --git a/common/send-stream.c b/common/send-stream.c
index 77d5cd04..1376e00b 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -354,6 +354,8 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 	struct timespec mt;
 	u8 uuid[BTRFS_UUID_SIZE];
 	u8 clone_uuid[BTRFS_UUID_SIZE];
+	u32 compression;
+	u32 encryption;
 	u64 tmp;
 	u64 tmp2;
 	u64 ctransid;
@@ -362,6 +364,9 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 	u64 dev;
 	u64 clone_offset;
 	u64 offset;
+	u64 unencoded_file_len;
+	u64 unencoded_len;
+	u64 unencoded_offset;
 	int len;
 	int xattr_len;
 
@@ -436,6 +441,23 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 		TLV_GET(sctx, BTRFS_SEND_A_DATA, &data, &len);
 		ret = sctx->ops->write(path, data, offset, len, sctx->user);
 		break;
+	case BTRFS_SEND_C_ENCODED_WRITE:
+		TLV_GET_STRING(sctx, BTRFS_SEND_A_PATH, &path);
+		TLV_GET_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, &offset);
+		TLV_GET_U64(sctx, BTRFS_SEND_A_UNENCODED_FILE_LEN,
+			    &unencoded_file_len);
+		TLV_GET_U64(sctx, BTRFS_SEND_A_UNENCODED_LEN, &unencoded_len);
+		TLV_GET_U64(sctx, BTRFS_SEND_A_UNENCODED_OFFSET,
+			    &unencoded_offset);
+		TLV_GET_U32(sctx, BTRFS_SEND_A_COMPRESSION, &compression);
+		TLV_GET_U32(sctx, BTRFS_SEND_A_ENCRYPTION, &encryption);
+		TLV_GET(sctx, BTRFS_SEND_A_DATA, &data, &len);
+		ret = sctx->ops->encoded_write(path, data, offset, len,
+					       unencoded_file_len,
+					       unencoded_len, unencoded_offset,
+					       compression, encryption,
+					       sctx->user);
+		break;
 	case BTRFS_SEND_C_CLONE:
 		TLV_GET_STRING(sctx, BTRFS_SEND_A_PATH, &path);
 		TLV_GET_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, &offset);
diff --git a/common/send-stream.h b/common/send-stream.h
index 39901f86..607bc007 100644
--- a/common/send-stream.h
+++ b/common/send-stream.h
@@ -66,6 +66,10 @@ struct btrfs_send_ops {
 		      struct timespec *mt, struct timespec *ct,
 		      void *user);
 	int (*update_extent)(const char *path, u64 offset, u64 len, void *user);
+	int (*encoded_write)(const char *path, const void *data, u64 offset,
+			     u64 len, u64 unencoded_file_len, u64 unencoded_len,
+			     u64 unencoded_offset, u32 compression,
+			     u32 encryption, void *user);
 };
 
 int btrfs_read_and_process_send_stream(int fd,
diff --git a/stubs.h b/stubs.h
index b39f8a69..d0ad0d06 100644
--- a/stubs.h
+++ b/stubs.h
@@ -1,6 +1,8 @@
 #ifndef _BTRFS_STUBS_H
 #define _BTRFS_STUBS_H
 
+#include <fcntl.h>
+#include <linux/fs.h>
 #include <sys/types.h>
 
 struct iovec;
@@ -8,4 +10,41 @@ struct iovec;
 ssize_t pwritev2(int fd, const struct iovec *iov, int iovcnt, off_t offset,
 		 int flags);
 
+#ifndef O_ALLOW_ENCODED
+#define O_ALLOW_ENCODED      040000000
 #endif
+
+#ifndef RWF_ENCODED
+enum {
+	ENCODED_IOV_COMPRESSION_NONE,
+#define ENCODED_IOV_COMPRESSION_NONE ENCODED_IOV_COMPRESSION_NONE
+	ENCODED_IOV_COMPRESSION_ZLIB,
+#define ENCODED_IOV_COMPRESSION_ZLIB ENCODED_IOV_COMPRESSION_ZLIB
+	ENCODED_IOV_COMPRESSION_LZO,
+#define ENCODED_IOV_COMPRESSION_LZO ENCODED_IOV_COMPRESSION_LZO
+	ENCODED_IOV_COMPRESSION_ZSTD,
+#define ENCODED_IOV_COMPRESSION_ZSTD ENCODED_IOV_COMPRESSION_ZSTD
+	ENCODED_IOV_COMPRESSION_TYPES = ENCODED_IOV_COMPRESSION_ZSTD,
+};
+
+enum {
+	ENCODED_IOV_ENCRYPTION_NONE,
+#define ENCODED_IOV_ENCRYPTION_NONE ENCODED_IOV_ENCRYPTION_NONE
+	ENCODED_IOV_ENCRYPTION_TYPES = ENCODED_IOV_ENCRYPTION_NONE,
+};
+
+struct encoded_iov {
+	__aligned_u64 len;
+	__aligned_u64 unencoded_len;
+	__aligned_u64 unencoded_offset;
+	__u32 compression;
+	__u32 encryption;
+};
+
+#define ENCODED_IOV_SIZE_VER0 32
+
+/* encoded (e.g., compressed and/or encrypted) IO */
+#define RWF_ENCODED    ((__kernel_rwf_t)0x00000020)
+#endif /* RWF_ENCODED */
+
+#endif /* _BTRFS_STUBS_H */
-- 
2.28.0

