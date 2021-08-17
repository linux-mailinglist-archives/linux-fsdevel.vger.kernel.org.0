Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8743EF499
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 23:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhHQVIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbhHQVIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 17:08:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DC6C061796
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l11so492076plk.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fKowfL7OViYRKKODkIk4NQlXHL7HGvltNijURvMy2g=;
        b=FyFXoRuNI2pMHkiH9CopbXqzh6akpLAURyNhHeqJyVFo1FKn78JlNIfkDNsmOno8Gz
         R7nN1JrXGmfSNJIK0btVyDWuErks+AiBjIhGx6VsgrAmQNXojUuZ4zdC2OPdGtzNvlqI
         UjKjw75RRHojmWJkmRMLl3gDx8uFNQycFC75cWt84xiCCILLEi8PMjh6S09Zim/BZxa9
         FXpF5B3Ke3iWpgbV41bf4uz5to/plJR9XMWP+tEiCJpahwB92M0GQHFpcLQlhdAtHzV0
         hOPv9lTUfdmqrPsjtRMf5JLg2Fr+Cs6LP3SyNrvNNkRI4B/WTZmRuJ9vLFsGYemWk93S
         dMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fKowfL7OViYRKKODkIk4NQlXHL7HGvltNijURvMy2g=;
        b=qSPi0DV5uTLB+Lv2g462CJWlFfDAfoaMAtcvA/iD9UpphDnAwlAZG9yShg82ULQiXs
         1UETu6y5Ai3Q8oMqaiuZm+ixZpqfwt7yw+pBVi6/V3R61/gvHEezA8jNht1A+npX6foi
         1xBI7PcCui7LNvQhsm4+mnzf8QEI2a0CV8D6WYtVDXDTQKwC7IKYk9nLfihZUL/hSVm0
         XffT8f2V5/kSMdUvdGo02vjbtVnFGhORtDO+lajvoRLYxVN/i2Rm+V9kR8vcEcesyVwt
         41cBG4ngmGRLD9qPWXDrIvwBBRnMD6ADbmVKnwLVRlHHb5NKyaU+4MuvT4a3GUA/oJzU
         aTRg==
X-Gm-Message-State: AOAM532/5UrpkooRJkn6v7qOwnTNAoV4XOW4ZdbQS7zhyjW2elRGYoSv
        EY5G1Jc+OwO/ZytLHIvNi7rtpA==
X-Google-Smtp-Source: ABdhPJwQQewypG+k1skVS7GXNhT6y0QoO0Fs01u27mYuer/sNzcoTtpH2CxPkl5MVUdbbLlelq/mzw==
X-Received: by 2002:a17:90a:1f44:: with SMTP id y4mr5593627pjy.51.1629234463215;
        Tue, 17 Aug 2021 14:07:43 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:42 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 06/10] btrfs-progs: receive: encoded_write fallback to explicit decode and write
Date:   Tue, 17 Aug 2021 14:06:52 -0700
Message-Id: <27ad30578c6e4347ff4161183c55ba6dee2e9227.1629234282.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629234193.git.osandov@fb.com>
References: <cover.1629234193.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boris Burkov <boris@bur.io>

An encoded_write can fail if the file system it is being applied to does
not support encoded writes or if it can't find enough contiguous space
to accommodate the encoded extent. In those cases, we can likely still
process an encoded_write by explicitly decoding the data and doing a
normal write.

Add the necessary fallback path for decoding data compressed with zlib,
lzo, or zstd. zlib and zstd have reusable decoding context data
structures which we cache in the receive context so that we don't have
to recreate them on every encoded_write.

Finally, add a command line flag for force-decompress which causes
receive to always use the fallback path rather than first attempting the
encoded write.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 Documentation/btrfs-receive.asciidoc |   4 +
 cmds/receive.c                       | 266 ++++++++++++++++++++++++++-
 2 files changed, 261 insertions(+), 9 deletions(-)

diff --git a/Documentation/btrfs-receive.asciidoc b/Documentation/btrfs-receive.asciidoc
index e4c4d2c0..354a71dc 100644
--- a/Documentation/btrfs-receive.asciidoc
+++ b/Documentation/btrfs-receive.asciidoc
@@ -60,6 +60,10 @@ By default the mountpoint is searched in '/proc/self/mounts'.
 If '/proc' is not accessible, eg. in a chroot environment, use this option to
 tell us where this filesystem is mounted.
 
+--force-decompress::
+if the stream contains compressed data (see '--compressed-data' in
+`btrfs-send`(8)), always decompress it instead of writing it with encoded I/O.
+
 --dump::
 dump the stream metadata, one line per operation
 +
diff --git a/cmds/receive.c b/cmds/receive.c
index b43c298f..7506f992 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -40,6 +40,10 @@
 #include <sys/xattr.h>
 #include <uuid/uuid.h>
 
+#include <lzo/lzo1x.h>
+#include <zlib.h>
+#include <zstd.h>
+
 #include "kernel-shared/ctree.h"
 #include "ioctl.h"
 #include "cmds/commands.h"
@@ -79,6 +83,12 @@ struct btrfs_receive
 	struct subvol_uuid_search sus;
 
 	int honor_end_cmd;
+
+	int force_decompress;
+
+	/* Reuse stream objects for encoded_write decompression fallback */
+	ZSTD_DStream *zstd_dstream;
+	z_stream *zlib_stream;
 };
 
 static int finish_subvol(struct btrfs_receive *rctx)
@@ -989,9 +999,222 @@ static int process_update_extent(const char *path, u64 offset, u64 len,
 	return 0;
 }
 
+static int decompress_zlib(struct btrfs_receive *rctx, const char *encoded_data,
+			   u64 encoded_len, char *unencoded_data,
+			   u64 unencoded_len)
+{
+	bool init = false;
+	int ret;
+
+	if (!rctx->zlib_stream) {
+		init = true;
+		rctx->zlib_stream = malloc(sizeof(z_stream));
+		if (!rctx->zlib_stream) {
+			error("failed to allocate zlib stream %m");
+			return -ENOMEM;
+		}
+	}
+	rctx->zlib_stream->next_in = (void *)encoded_data;
+	rctx->zlib_stream->avail_in = encoded_len;
+	rctx->zlib_stream->next_out = (void *)unencoded_data;
+	rctx->zlib_stream->avail_out = unencoded_len;
+
+	if (init) {
+		rctx->zlib_stream->zalloc = Z_NULL;
+		rctx->zlib_stream->zfree = Z_NULL;
+		rctx->zlib_stream->opaque = Z_NULL;
+		ret = inflateInit(rctx->zlib_stream);
+	} else {
+		ret = inflateReset(rctx->zlib_stream);
+	}
+	if (ret != Z_OK) {
+		error("zlib inflate init failed: %d", ret);
+		return -EIO;
+	}
+
+	while (rctx->zlib_stream->avail_in > 0 &&
+	       rctx->zlib_stream->avail_out > 0) {
+		ret = inflate(rctx->zlib_stream, Z_FINISH);
+		if (ret == Z_STREAM_END) {
+			break;
+		} else if (ret != Z_OK) {
+			error("zlib inflate failed: %d", ret);
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
+static int decompress_zstd(struct btrfs_receive *rctx, const char *encoded_buf,
+			   u64 encoded_len, char *unencoded_buf,
+			   u64 unencoded_len)
+{
+	ZSTD_inBuffer in_buf = {
+		.src = encoded_buf,
+		.size = encoded_len
+	};
+	ZSTD_outBuffer out_buf = {
+		.dst = unencoded_buf,
+		.size = unencoded_len
+	};
+	size_t ret;
+
+	if (!rctx->zstd_dstream) {
+		rctx->zstd_dstream = ZSTD_createDStream();
+		if (!rctx->zstd_dstream) {
+			error("failed to create zstd dstream");
+			return -ENOMEM;
+		}
+	}
+	ret = ZSTD_initDStream(rctx->zstd_dstream);
+	if (ZSTD_isError(ret)) {
+		error("failed to init zstd stream: %s", ZSTD_getErrorName(ret));
+		return -EIO;
+	}
+	while (in_buf.pos < in_buf.size && out_buf.pos < out_buf.size) {
+		ret = ZSTD_decompressStream(rctx->zstd_dstream, &out_buf, &in_buf);
+		if (ret == 0) {
+			break;
+		} else if (ZSTD_isError(ret)) {
+			error("failed to decompress zstd stream: %s",
+			      ZSTD_getErrorName(ret));
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
+static int decompress_lzo(const char *encoded_data, u64 encoded_len,
+			  char *unencoded_data, u64 unencoded_len,
+			  unsigned int page_size)
+{
+	uint32_t total_len;
+	size_t in_pos, out_pos;
+
+	if (encoded_len < 4) {
+		error("lzo header is truncated");
+		return -EIO;
+	}
+	memcpy(&total_len, encoded_data, 4);
+	total_len = le32toh(total_len);
+	if (total_len > encoded_len) {
+		error("lzo header is invalid");
+		return -EIO;
+	}
+
+	in_pos = 4;
+	out_pos = 0;
+	while (in_pos < total_len && out_pos < unencoded_len) {
+		size_t page_remaining;
+		uint32_t src_len;
+		lzo_uint dst_len;
+		int ret;
+
+		page_remaining = -in_pos % page_size;
+		if (page_remaining < 4) {
+			if (total_len - in_pos <= page_remaining)
+				break;
+			in_pos += page_remaining;
+		}
+
+		if (total_len - in_pos < 4) {
+			error("lzo segment header is truncated");
+			return -EIO;
+		}
+
+		memcpy(&src_len, encoded_data + in_pos, 4);
+		src_len = le32toh(src_len);
+		in_pos += 4;
+		if (src_len > total_len - in_pos) {
+			error("lzo segment header is invalid");
+			return -EIO;
+		}
+
+		dst_len = page_size;
+		ret = lzo1x_decompress_safe((void *)(encoded_data + in_pos),
+					    src_len,
+					    (void *)(unencoded_data + out_pos),
+					    &dst_len, NULL);
+		if (ret != LZO_E_OK) {
+			error("lzo1x_decompress_safe failed: %d", ret);
+			return -EIO;
+		}
+
+		in_pos += src_len;
+		out_pos += dst_len;
+	}
+	return 0;
+}
+
+static int decompress_and_write(struct btrfs_receive *rctx,
+				const char *encoded_data, u64 offset,
+				u64 encoded_len, u64 unencoded_file_len,
+				u64 unencoded_len, u64 unencoded_offset,
+				u32 compression)
+{
+	int ret = 0;
+	size_t pos;
+	ssize_t w;
+	char *unencoded_data;
+	int page_shift;
+
+	unencoded_data = calloc(unencoded_len, 1);
+	if (!unencoded_data) {
+		error("allocating space for unencoded data failed: %m");
+		return -errno;
+	}
+
+	switch (compression) {
+	case BTRFS_ENCODED_IO_COMPRESSION_ZLIB:
+		ret = decompress_zlib(rctx, encoded_data, encoded_len,
+				      unencoded_data, unencoded_len);
+		if (ret)
+			goto out;
+		break;
+	case BTRFS_ENCODED_IO_COMPRESSION_ZSTD:
+		ret = decompress_zstd(rctx, encoded_data, encoded_len,
+				      unencoded_data, unencoded_len);
+		if (ret)
+			goto out;
+		break;
+	case BTRFS_ENCODED_IO_COMPRESSION_LZO_4K:
+	case BTRFS_ENCODED_IO_COMPRESSION_LZO_8K:
+	case BTRFS_ENCODED_IO_COMPRESSION_LZO_16K:
+	case BTRFS_ENCODED_IO_COMPRESSION_LZO_32K:
+	case BTRFS_ENCODED_IO_COMPRESSION_LZO_64K:
+		page_shift = compression - BTRFS_ENCODED_IO_COMPRESSION_LZO_4K + 12;
+		ret = decompress_lzo(encoded_data, encoded_len, unencoded_data,
+				     unencoded_len, 1U << page_shift);
+		if (ret)
+			goto out;
+		break;
+	default:
+		error("unknown compression: %d", compression);
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	pos = unencoded_offset;
+	while (pos < unencoded_file_len) {
+		w = pwrite(rctx->write_fd, unencoded_data + pos,
+			   unencoded_file_len - pos, offset);
+		if (w < 0) {
+			ret = -errno;
+			error("writing unencoded data failed: %m");
+			goto out;
+		}
+		pos += w;
+		offset += w;
+	}
+out:
+	free(unencoded_data);
+	return ret;
+}
+
 static int process_encoded_write(const char *path, const void *data, u64 offset,
-	u64 len, u64 unencoded_file_len, u64 unencoded_len,
-	u64 unencoded_offset, u32 compression, u32 encryption, void *user)
+				 u64 len, u64 unencoded_file_len,
+				 u64 unencoded_len, u64 unencoded_offset,
+				 u32 compression, u32 encryption, void *user)
 {
 	int ret;
 	struct btrfs_receive *rctx = user;
@@ -1007,6 +1230,7 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
 		.compression = compression,
 		.encryption = encryption,
 	};
+	bool encoded_write = !rctx->force_decompress;
 
 	if (encryption) {
 		error("encoded_write: encryption not supported");
@@ -1023,13 +1247,21 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
 	if (ret < 0)
 		return ret;
 
-	ret = ioctl(rctx->write_fd, BTRFS_IOC_ENCODED_WRITE, &encoded);
-	if (ret < 0) {
-		ret = -errno;
-		error("encoded_write: writing to %s failed: %m", path);
-		return ret;
+	if (encoded_write) {
+		ret = ioctl(rctx->write_fd, BTRFS_IOC_ENCODED_WRITE, &encoded);
+		if (ret >= 0)
+			return 0;
+		/* Fall back for these errors, fail hard for anything else. */
+		if (errno != ENOSPC && errno != EOPNOTSUPP && errno != EINVAL) {
+			ret = -errno;
+			error("encoded_write: writing to %s failed: %m", path);
+			return ret;
+		}
 	}
-	return 0;
+
+	return decompress_and_write(rctx, data, offset, len, unencoded_file_len,
+				    unencoded_len, unencoded_offset,
+				    compression);
 }
 
 static struct btrfs_send_ops send_ops = {
@@ -1209,6 +1441,12 @@ out:
 		close(rctx->dest_dir_fd);
 		rctx->dest_dir_fd = -1;
 	}
+	if (rctx->zstd_dstream)
+		ZSTD_freeDStream(rctx->zstd_dstream);
+	if (rctx->zlib_stream) {
+		inflateEnd(rctx->zlib_stream);
+		free(rctx->zlib_stream);
+	}
 
 	return ret;
 }
@@ -1239,6 +1477,9 @@ static const char * const cmd_receive_usage[] = {
 	"-m ROOTMOUNT     the root mount point of the destination filesystem.",
 	"                 If /proc is not accessible, use this to tell us where",
 	"                 this file system is mounted.",
+	"--force-decompress",
+	"                 if the stream contains compressed data, always",
+	"                 decompress it instead of writing it with encoded I/O",
 	"--dump           dump stream metadata, one line per operation,",
 	"                 does not require the MOUNT parameter",
 	"-v               deprecated, alias for global -v option",
@@ -1282,12 +1523,16 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 	optind = 0;
 	while (1) {
 		int c;
-		enum { GETOPT_VAL_DUMP = 257 };
+		enum {
+			GETOPT_VAL_DUMP = 257,
+			GETOPT_VAL_FORCE_DECOMPRESS,
+		};
 		static const struct option long_opts[] = {
 			{ "max-errors", required_argument, NULL, 'E' },
 			{ "chroot", no_argument, NULL, 'C' },
 			{ "dump", no_argument, NULL, GETOPT_VAL_DUMP },
 			{ "quiet", no_argument, NULL, 'q' },
+			{ "force-decompress", no_argument, NULL, GETOPT_VAL_FORCE_DECOMPRESS },
 			{ NULL, 0, NULL, 0 }
 		};
 
@@ -1330,6 +1575,9 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 		case GETOPT_VAL_DUMP:
 			dump = 1;
 			break;
+		case GETOPT_VAL_FORCE_DECOMPRESS:
+			rctx.force_decompress = 1;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
-- 
2.32.0

