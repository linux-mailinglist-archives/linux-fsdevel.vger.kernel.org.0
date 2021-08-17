Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C86E3EF494
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 23:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhHQVI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 17:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbhHQVIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 17:08:18 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60447C0613C1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so7406078pjn.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WfHnbiQt1fQFIBcRrL7k/HdJ/hGCJWCOhBr097/dLJ4=;
        b=0ppxrXFGRqX73IwiFL4df7xBowqRmk4SXKHBTAhV/icyF7uoD+b2Y7L+SN7dJVGXXh
         nWP2WkpU8eqwyZAu77LeNWVT1ZTKwQLuY1NsXBITenc2ijsM0b0ot7124DIPqp2mjGz8
         MBExDfz3jjMGc9oF8Cos9RGPalTOzyTAAN2YqfFgwKMmjM1mqnaflzuTw9pbSBbaYxY8
         Wt4rH0YivQQI4Jl8rhWPu77pEI8hCzqosjiPKfFI58BVPQ0Qmji+2arTX/6wWDEqaTJj
         za6jC2WQQawmccFC5jrQUaTYZZRSstSMwQuNUsV1dlqc1UbhOfy0SpgpLRdCuHtbv5d4
         GS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfHnbiQt1fQFIBcRrL7k/HdJ/hGCJWCOhBr097/dLJ4=;
        b=l2+hbUnzaKk1Q8utrPXVmxv/+cGgt10fgcDU34U6OChLR/ugigZ6QPCCZ2yU1aDVL+
         hADXFaCXNQQhzY5c2DsDiNpMKUyorLDcyF7Fk9Nrno2Vp2ZslDMVkI4OrX9VOFiexX+G
         OMxDikLzDcuYyyRQ8GKeDd9KOqUCX1tqfxp0ibKDTbhUVAaLNRKhbBxdQwVJdi4A+uin
         EqvqlpvtoH/NiI4UiQsHnFEo4Ijo98fEF0MdEdkWbvPLxrN1GrU3tI+3MREUUYqJVvcK
         zZGTVZjOLPh42zsnuBBh1VNgPLTmDLbS8C7Pp1jWMrOitwnkOtlpeIlDuZwF4DHcQvSA
         TBEg==
X-Gm-Message-State: AOAM5321xfev8tsmVhEmaEkLJtKFJHhIRYH6T4zG625ZNpltvusNnYJn
        klLZLXOx/aIARXvK04qJo1Ye+w==
X-Google-Smtp-Source: ABdhPJybVVMyDHY2thQPt5v+9sOHx/sqyZhX396G/DKLKcVvZxCtl5VFxiMwnm6vGkZd0y6cS4iJsg==
X-Received: by 2002:a17:90a:9c6:: with SMTP id 64mr4006915pjo.155.1629234461803;
        Tue, 17 Aug 2021 14:07:41 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:41 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 05/10] btrfs-progs: receive: process encoded_write commands
Date:   Tue, 17 Aug 2021 14:06:51 -0700
Message-Id: <57eed8d0201430a3b16484d51d71014f77bcfff2.1629234282.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629234193.git.osandov@fb.com>
References: <cover.1629234193.git.osandov@fb.com>
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
 cmds/receive.c       |  47 +++++++++++++++
 common/send-stream.c |  22 ++++++++
 common/send-stream.h |   4 ++
 ioctl.h              | 132 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 220 insertions(+), 1 deletion(-)

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
index 4dd01fd3..b43c298f 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -29,12 +29,14 @@
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
 
@@ -51,6 +53,7 @@
 #include "cmds/receive-dump.h"
 #include "common/help.h"
 #include "common/path-utils.h"
+#include "stubs.h"
 
 struct btrfs_receive
 {
@@ -986,6 +989,49 @@ static int process_update_extent(const char *path, u64 offset, u64 len,
 	return 0;
 }
 
+static int process_encoded_write(const char *path, const void *data, u64 offset,
+	u64 len, u64 unencoded_file_len, u64 unencoded_len,
+	u64 unencoded_offset, u32 compression, u32 encryption, void *user)
+{
+	int ret;
+	struct btrfs_receive *rctx = user;
+	char full_path[PATH_MAX];
+	struct iovec iov = { (char *)data, len };
+	struct btrfs_ioctl_encoded_io_args encoded = {
+		.iov = &iov,
+		.iovcnt = 1,
+		.offset = offset,
+		.len = unencoded_file_len,
+		.unencoded_len = unencoded_len,
+		.unencoded_offset = unencoded_offset,
+		.compression = compression,
+		.encryption = encryption,
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
+	ret = open_inode_for_write(rctx, full_path);
+	if (ret < 0)
+		return ret;
+
+	ret = ioctl(rctx->write_fd, BTRFS_IOC_ENCODED_WRITE, &encoded);
+	if (ret < 0) {
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
@@ -1008,6 +1054,7 @@ static struct btrfs_send_ops send_ops = {
 	.chown = process_chown,
 	.utimes = process_utimes,
 	.update_extent = process_update_extent,
+	.encoded_write = process_encoded_write,
 };
 
 static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
diff --git a/common/send-stream.c b/common/send-stream.c
index 4d819185..044e101b 100644
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
diff --git a/ioctl.h b/ioctl.h
index 9e1e3403..a472dbd2 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -775,6 +775,134 @@ struct btrfs_ioctl_get_subvol_rootref_args {
 };
 BUILD_ASSERT(sizeof(struct btrfs_ioctl_get_subvol_rootref_args) == 4096);
 
+/*
+ * Data and metadata for an encoded read or write.
+ *
+ * Encoded I/O bypasses any encoding automatically done by the filesystem (e.g.,
+ * compression). This can be used to read the compressed contents of a file or
+ * write pre-compressed data directly to a file.
+ *
+ * BTRFS_IOC_ENCODED_READ and BTRFS_IOC_ENCODED_WRITE are essentially
+ * preadv/pwritev with additional metadata about how the data is encoded and the
+ * size of the unencoded data.
+ *
+ * BTRFS_IOC_ENCODED_READ fills the given iovecs with the encoded data, fills
+ * the metadata fields, and returns the size of the encoded data. It reads one
+ * extent per call. It can also read data which is not encoded.
+ *
+ * BTRFS_IOC_ENCODED_WRITE uses the metadata fields, writes the encoded data
+ * from the iovecs, and returns the size of the encoded data. Note that the
+ * encoded data is not validated when it is written; if it is not valid (e.g.,
+ * it cannot be decompressed), then a subsequent read may return an error.
+ *
+ * Since the filesystem page cache contains decoded data, encoded I/O bypasses
+ * the page cache. Encoded I/O requires CAP_SYS_ADMIN.
+ */
+struct btrfs_ioctl_encoded_io_args {
+	/* Input parameters for both reads and writes. */
+
+	/*
+	 * iovecs containing encoded data.
+	 *
+	 * For reads, if the size of the encoded data is larger than the sum of
+	 * iov[n].iov_len for 0 <= n < iovcnt, then the ioctl fails with
+	 * ENOBUFS.
+	 *
+	 * For writes, the size of the encoded data is the sum of iov[n].iov_len
+	 * for 0 <= n < iovcnt. This must be less than 128 KiB (this limit may
+	 * increase in the future). This must also be less than or equal to
+	 * unencoded_len.
+	 */
+	const struct iovec *iov;
+	/* Number of iovecs. */
+	unsigned long iovcnt;
+	/*
+	 * Offset in file.
+	 *
+	 * For writes, must be aligned to the sector size of the filesystem.
+	 */
+	__s64 offset;
+	/* Currently must be zero. */
+	__u64 flags;
+
+	/*
+	 * For reads, the following members are filled in with the metadata for
+	 * the encoded data.
+	 * For writes, the following members must be set to the metadata for the
+	 * encoded data.
+	 */
+
+	/*
+	 * Length of the data in the file.
+	 *
+	 * Must be less than or equal to unencoded_len - unencoded_offset. For
+	 * writes, must be aligned to the sector size of the filesystem unless
+	 * the data ends at or beyond the current end of the file.
+	 */
+	__u64 len;
+	/*
+	 * Length of the unencoded (i.e., decrypted and decompressed) data.
+	 *
+	 * For writes, must be no more than 128 KiB (this limit may increase in
+	 * the future). If the unencoded data is actually longer than
+	 * unencoded_len, then it is truncated; if it is shorter, then it is
+	 * extended with zeroes.
+	 */
+	__u64 unencoded_len;
+	/*
+	 * Offset from the first byte of the unencoded data to the first byte of
+	 * logical data in the file.
+	 *
+	 * Must be less than unencoded_len.
+	 */
+	__u64 unencoded_offset;
+	/*
+	 * BTRFS_ENCODED_IO_COMPRESSION_* type.
+	 *
+	 * For writes, must not be BTRFS_ENCODED_IO_COMPRESSION_NONE.
+	 */
+	__u32 compression;
+	/* Currently always BTRFS_ENCODED_IO_ENCRYPTION_NONE. */
+	__u32 encryption;
+	/*
+	 * Reserved for future expansion.
+	 *
+	 * For reads, always returned as zero. Users should check for non-zero
+	 * bytes. If there are any, then the kernel has a newer version of this
+	 * structure with additional information that the user definition is
+	 * missing.
+	 *
+	 * For writes, must be zeroed.
+	 */
+	__u8 reserved[32];
+};
+
+/* Data is not compressed. */
+#define BTRFS_ENCODED_IO_COMPRESSION_NONE 0
+/* Data is compressed as a single zlib stream. */
+#define BTRFS_ENCODED_IO_COMPRESSION_ZLIB 1
+/*
+ * Data is compressed as a single zstd frame with the windowLog compression
+ * parameter set to no more than 17.
+ */
+#define BTRFS_ENCODED_IO_COMPRESSION_ZSTD 2
+/*
+ * Data is compressed page by page (using the page size indicated by the name of
+ * the constant) with LZO1X and wrapped in the format documented in
+ * fs/btrfs/lzo.c. For writes, the compression page size must match the
+ * filesystem page size.
+ */
+#define BTRFS_ENCODED_IO_COMPRESSION_LZO_4K 3
+#define BTRFS_ENCODED_IO_COMPRESSION_LZO_8K 4
+#define BTRFS_ENCODED_IO_COMPRESSION_LZO_16K 5
+#define BTRFS_ENCODED_IO_COMPRESSION_LZO_32K 6
+#define BTRFS_ENCODED_IO_COMPRESSION_LZO_64K 7
+#define BTRFS_ENCODED_IO_COMPRESSION_TYPES 8
+
+/* Data is not encrypted. */
+#define BTRFS_ENCODED_IO_ENCRYPTION_NONE 0
+#define BTRFS_ENCODED_IO_ENCRYPTION_TYPES 1
+
 /* Error codes as returned by the kernel */
 enum btrfs_err_code {
 	notused,
@@ -949,6 +1077,10 @@ static inline char *btrfs_err_str(enum btrfs_err_code err_code)
 				struct btrfs_ioctl_ino_lookup_user_args)
 #define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
 				   struct btrfs_ioctl_vol_args_v2)
+#define BTRFS_IOC_ENCODED_READ _IOR(BTRFS_IOCTL_MAGIC, 64, \
+				    struct btrfs_ioctl_encoded_io_args)
+#define BTRFS_IOC_ENCODED_WRITE _IOW(BTRFS_IOCTL_MAGIC, 64, \
+				     struct btrfs_ioctl_encoded_io_args)
 
 #ifdef __cplusplus
 }
-- 
2.32.0

