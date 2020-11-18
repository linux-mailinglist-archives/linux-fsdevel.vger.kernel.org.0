Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1375B2B84CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgKRTTi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbgKRTTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:37 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48EAC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:35 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id bj5so717894plb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GSKSDRR8K/+TKUuUq5SwiGfUO6KTVDHzgwHOrlirzyk=;
        b=iZIK8j5ZVlJW3ibHpPfRgjY/R2IWpjUmAQWNTUIUac8hV6LSOlpLK9uclduYXRW2EE
         3tSywZp392AmcfprV0GK5UfY7rymX3b3iAWKAo52bXWzcK1XhSJYRFQcgsNDIHqmPlA2
         kf5xvz0eSlVYL69Lw9eA4dkGfirWFyUU94WCUFYmG4NBNU4JsdjqUV5rS8vQgrj0pnmg
         93P2NOSsMJHeNAyXqPP99nBqRuOMoZ1hpF05mpra2hGX08g17KHJ1+xMQTTqjXnohZJG
         3yBggj3a0QCBMAFX0nuMkEZhdAdB0tDwVkEIWxG7YSdDkl0XXzgvfyYV+jjH2AjX+Rr5
         NF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GSKSDRR8K/+TKUuUq5SwiGfUO6KTVDHzgwHOrlirzyk=;
        b=pCrWRh5GOom7wqJWDWX2Pc1SaNtgPR2Yw6Stou+Aqc6krMTCE3audvZNZBkVPLgE8A
         xxt/qaINlZcH4yxD/DZBo+AdScgMtfbyEW2glDQu38Z/Va+cbFwZql0HKUbIkkNh11nQ
         Zys9SktI3mq595UIll4nmq8/1CBxce8lGgCfahFdEufEimUcW4tK8yj0GbawWdS/kv9Q
         HcKGsrTl9Pf4WKXN5qK7O2PxrI4HqEHzJFYdXNs0dkhnz/qjk8h/82cgebgPiH8JcbyU
         n0u/eJJ6nUq+RAJk8Qf/8iKW3lUId8kEJDY4V7nOHbLaz8/XGF+e9c304bSitYiY4z9J
         kB3w==
X-Gm-Message-State: AOAM530eZJIHvetTObFXLzh1pMp8WYhS9hK6MC6Wci5ec1lXIDRCMRYp
        iTa2gnoSCp7doFBTFO7aKP5K2hQx6D/hAQ==
X-Google-Smtp-Source: ABdhPJx5TBEnjr5vEOFv+PxN5aWsXsCncd4fanIQGwc7uRj2/+E+lXhHxJtEXiPIwMXWcJjYvl7R7A==
X-Received: by 2002:a17:902:8c84:b029:d9:471:f0da with SMTP id t4-20020a1709028c84b02900d90471f0damr5225230plo.84.1605727175286;
        Wed, 18 Nov 2020 11:19:35 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:34 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 08/13] btrfs-progs: receive: process encoded_write commands
Date:   Wed, 18 Nov 2020 11:18:55 -0800
Message-Id: <c2a232489a5f64e1fadbc31bb2a46adc4e925e00.1605723745.git.osandov@osandov.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723600.git.osandov@fb.com>
References: <cover.1605723600.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boris Burkov <borisb@fb.com>

Add a new btrfs_send_op and support for both dumping and proper receive
processing which does actual encoded writes.

Encoded writes are only allowed on a file descriptor opened with an
extra flag that allows encoded writes, so we also add support for this
flag when opening or reusing a file for writing.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 cmds/receive-dump.c  |  16 +++++-
 cmds/receive.c       | 118 ++++++++++++++++++++++++++++++++++++++-----
 common/send-stream.c |  22 ++++++++
 common/send-stream.h |   4 ++
 stubs.h              |  56 ++++++++++++++++++++
 5 files changed, 203 insertions(+), 13 deletions(-)

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
index 2c56cea6..87f47a9a 100644
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
@@ -643,28 +647,69 @@ out:
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
-
-	if (rctx->write_fd != -1) {
-		if (strcmp(rctx->write_path, path) == 0)
-			goto out;
-		close(rctx->write_fd);
-		rctx->write_fd = -1;
-	}
-
 	/*
 	 * When opening with O_ALLOW_ENCODED, O_CLOEXEC must also be specified.
 	 * We might as well always use it even though we don't exec anything.
 	 */
-	rctx->write_fd = open(path, O_RDWR | O_CLOEXEC);
+	int flags = O_RDWR | O_CLOEXEC;
+
+	if (rctx->write_fd != -1) {
+		/*
+		 * if the existing fd is for this path and the needed flags are
+		 * satisfied, no need to open a new one
+		 */
+		if (strcmp(rctx->write_path, path) == 0) {
+			/* fixup the allow encoded flag, if necessary */
+			if (allow_encoded && !rctx->write_fd_allow_encoded)
+				ret = set_write_fd_allow_encoded(rctx);
+			goto out;
+		}
+		close(rctx->write_fd);
+		rctx->write_fd = -1;
+	}
+
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
@@ -695,7 +740,7 @@ static int process_write(const char *path, const void *data, u64 offset,
 		goto out;
 	}
 
-	ret = open_inode_for_write(rctx, full_path);
+	ret = open_inode_for_write(rctx, full_path, false);
 	if (ret < 0)
 		goto out;
 
@@ -738,7 +783,7 @@ static int process_clone(const char *path, u64 offset, u64 len,
 		goto out;
 	}
 
-	ret = open_inode_for_write(rctx, full_path);
+	ret = open_inode_for_write(rctx, full_path, false);
 	if (ret < 0)
 		goto out;
 
@@ -1032,6 +1077,54 @@ static int process_update_extent(const char *path, u64 offset, u64 len,
 	return 0;
 }
 
+static int process_encoded_write(const char *path, const void *data, u64 offset,
+	u64 len, u64 unencoded_file_len, u64 unencoded_len,
+	u64 unencoded_offset, u32 compression, u32 encryption, void *user)
+{
+	int ret;
+	ssize_t w;
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
+	if (encryption) {
+		error("encoded_write: encryption not supported");
+		return -EOPNOTSUPP;
+	}
+
+	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
+	if (ret < 0) {
+		error("encoded_write: path invalid: %s", path);
+		return ret;
+	}
+
+	ret = open_inode_for_write(rctx, full_path, true);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * NOTE: encoded writes guarantee no partial writes, so we don't need to
+	 * handle that possibility.
+	 */
+	w = pwritev2(rctx->write_fd, iov, 2, offset, RWF_ENCODED);
+	if (w < 0) {
+		ret = -errno;
+		error("encoded_write: writing to %s failed: %m", path);
+		return ret;
+	}
+	return 0;
+}
+
 static struct btrfs_send_ops send_ops = {
 	.subvol = process_subvol,
 	.snapshot = process_snapshot,
@@ -1054,6 +1147,7 @@ static struct btrfs_send_ops send_ops = {
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
index b39f8a69..7574ae8f 100644
--- a/stubs.h
+++ b/stubs.h
@@ -1,6 +1,8 @@
 #ifndef _BTRFS_STUBS_H
 #define _BTRFS_STUBS_H
 
+#include <fcntl.h>
+#include <linux/fs.h>
 #include <sys/types.h>
 
 struct iovec;
@@ -8,4 +10,58 @@ struct iovec;
 ssize_t pwritev2(int fd, const struct iovec *iov, int iovcnt, off_t offset,
 		 int flags);
 
+#ifndef O_ALLOW_ENCODED
+#if defined(__alpha__)
+#define O_ALLOW_ENCODED      0200000000
+#elif defined(__hppa__)
+#define O_ALLOW_ENCODED      100000000
+#elif defined(__sparc__)
+#define O_ALLOW_ENCODED      0x8000000
+#else
+#define O_ALLOW_ENCODED      040000000
 #endif
+#endif
+
+#ifndef RWF_ENCODED
+
+enum {
+        ENCODED_IOV_COMPRESSION_NONE,
+#define ENCODED_IOV_COMPRESSION_NONE ENCODED_IOV_COMPRESSION_NONE
+        ENCODED_IOV_COMPRESSION_BTRFS_ZLIB,
+#define ENCODED_IOV_COMPRESSION_BTRFS_ZLIB ENCODED_IOV_COMPRESSION_BTRFS_ZLIB
+        ENCODED_IOV_COMPRESSION_BTRFS_ZSTD,
+#define ENCODED_IOV_COMPRESSION_BTRFS_ZSTD ENCODED_IOV_COMPRESSION_BTRFS_ZSTD
+        ENCODED_IOV_COMPRESSION_BTRFS_LZO_4K,
+#define ENCODED_IOV_COMPRESSION_BTRFS_LZO_4K ENCODED_IOV_COMPRESSION_BTRFS_LZO_4K
+        ENCODED_IOV_COMPRESSION_BTRFS_LZO_8K,
+#define ENCODED_IOV_COMPRESSION_BTRFS_LZO_8K ENCODED_IOV_COMPRESSION_BTRFS_LZO_8K
+        ENCODED_IOV_COMPRESSION_BTRFS_LZO_16K,
+#define ENCODED_IOV_COMPRESSION_BTRFS_LZO_16K ENCODED_IOV_COMPRESSION_BTRFS_LZO_16K
+        ENCODED_IOV_COMPRESSION_BTRFS_LZO_32K,
+#define ENCODED_IOV_COMPRESSION_BTRFS_LZO_32K ENCODED_IOV_COMPRESSION_BTRFS_LZO_32K
+        ENCODED_IOV_COMPRESSION_BTRFS_LZO_64K,
+#define ENCODED_IOV_COMPRESSION_BTRFS_LZO_64K ENCODED_IOV_COMPRESSION_BTRFS_LZO_64K
+        ENCODED_IOV_COMPRESSION_TYPES = ENCODED_IOV_COMPRESSION_BTRFS_LZO_64K,
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
2.29.2

