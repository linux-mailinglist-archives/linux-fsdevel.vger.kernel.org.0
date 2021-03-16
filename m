Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9968D33DDFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbhCPTp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhCPTpF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:45:05 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AEAC0613E2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:44 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 18so9545456pfo.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71QLsbBKRN4JEnDqyl9cH6L4uu++i8y8AUFQmN5/hC0=;
        b=Xb1euGmo2k8oGv+R/bRYu3VMTz7/QTIBls+XEcOGcw+QvA1qxV5abQ+FZzz5KnVTtL
         eRZAYmUilH8fhFZhVZfV0dp0+Us9YRlpoq3xz0l0W8j9QKKSegEa9YmYAT/AC+G7zyXc
         OP2KS3kWzxY6gG7yDFqjoW+uqUCDTCjxc6/sTHUSbtmqL0rVG+TCHDUM+UUQAWrgOr+U
         cF8/y8lNPCy9xDEivR1IU9f7y5mTZcwfJ2WmDgZAKoBse8eFHppwUSDI5zWzrJ8pu4Fr
         fhqjPgHMG7Jne2bC02TktNgBQ/oD4duf5hA6I4Rt9R6tjmkRpe3ojtSsaB3DXMkkKSwB
         B4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71QLsbBKRN4JEnDqyl9cH6L4uu++i8y8AUFQmN5/hC0=;
        b=RNXcWWioj4TVgralufli17xtuY1gXPkcveD1SF9wwfF2fLnbaf/agBnuQW3gtphZrR
         SW4RCB5YKLV4vnB9fDBYuufwPkpUiqU/aJthTSuEDQrW0mnkwY6pGRxlbi5lQACZtodE
         nXMjZkoNciW8VxwEEdbRcxvu4Y22195/64d7BgM2EuytKUnlOQgj9X60OVkpedNaXEpz
         BBh4330bAwau2Nq7PwTTCnlfPM3dKD1JO/2x15VGIkrbBL9gUfoREpwcHzxMk9Z1+tQl
         ITWpW+ix68q4zVy4xTv9Cma4x4UGaVTbijAfhl9u+e10WEb2Wr5L+qF1TjgaDL38yyTQ
         rS7w==
X-Gm-Message-State: AOAM531DaBF02v4gGRNreZOUSlGWJyLQOVxWq5sDVoUhuuz5yG2QA6/a
        w858uPrmtoUZZ86sPqYp3EkJM+1jULw9Ig==
X-Google-Smtp-Source: ABdhPJzLuSyiuw8SSaPCdcVGN1aojjJKp5mvQJCTBQPmv9X/1TzYIma5KKqiVtUrr0JfhBZK2J+yaw==
X-Received: by 2002:aa7:9d1c:0:b029:1f1:53b2:a5b0 with SMTP id k28-20020aa79d1c0000b02901f153b2a5b0mr1008634pfp.13.1615923884196;
        Tue, 16 Mar 2021 12:44:44 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:43 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 07/11] btrfs-progs: receive: encoded_write fallback to explicit decode and write
Date:   Tue, 16 Mar 2021 12:44:01 -0700
Message-Id: <12bad5c88e48f6e23bfb3cc76fb6a876468e8705.1615922859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922753.git.osandov@fb.com>
References: <cover.1615922753.git.osandov@fb.com>
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
 cmds/receive.c                       | 274 +++++++++++++++++++++++++--
 2 files changed, 265 insertions(+), 13 deletions(-)

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
index ad1e3021..f0236f50 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -41,6 +41,10 @@
 #include <sys/xattr.h>
 #include <uuid/uuid.h>
 
+#include <lzo/lzo1x.h>
+#include <zlib.h>
+#include <zstd.h>
+
 #include "kernel-shared/ctree.h"
 #include "ioctl.h"
 #include "cmds/commands.h"
@@ -81,6 +85,12 @@ struct btrfs_receive
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
@@ -1032,9 +1042,222 @@ static int process_update_extent(const char *path, u64 offset, u64 len,
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
+	case ENCODED_IOV_COMPRESSION_BTRFS_ZLIB:
+		ret = decompress_zlib(rctx, encoded_data, encoded_len,
+				      unencoded_data, unencoded_len);
+		if (ret)
+			goto out;
+		break;
+	case ENCODED_IOV_COMPRESSION_BTRFS_ZSTD:
+		ret = decompress_zstd(rctx, encoded_data, encoded_len,
+				      unencoded_data, unencoded_len);
+		if (ret)
+			goto out;
+		break;
+	case ENCODED_IOV_COMPRESSION_BTRFS_LZO_4K:
+	case ENCODED_IOV_COMPRESSION_BTRFS_LZO_8K:
+	case ENCODED_IOV_COMPRESSION_BTRFS_LZO_16K:
+	case ENCODED_IOV_COMPRESSION_BTRFS_LZO_32K:
+	case ENCODED_IOV_COMPRESSION_BTRFS_LZO_64K:
+		page_shift = compression - ENCODED_IOV_COMPRESSION_BTRFS_LZO_4K + 12;
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
 	ssize_t w;
@@ -1051,6 +1274,7 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
 		{ &encoded, sizeof(encoded) },
 		{ (char *)data, len }
 	};
+	bool encoded_write = !rctx->force_decompress;
 
 	if (encryption) {
 		error("encoded_write: encryption not supported");
@@ -1067,17 +1291,25 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
 	if (ret < 0)
 		return ret;
 
-	/*
-	 * NOTE: encoded writes guarantee no partial writes, so we don't need to
-	 * handle that possibility.
-	 */
-	w = pwritev2(rctx->write_fd, iov, 2, offset, RWF_ENCODED);
-	if (w < 0) {
-		ret = -errno;
-		error("encoded_write: writing to %s failed: %m", path);
-		return ret;
+	if (encoded_write) {
+		/*
+		 * NOTE: encoded writes guarantee no partial writes, so we don't
+		 * need to handle that possibility.
+		 */
+		w = pwritev2(rctx->write_fd, iov, 2, offset, RWF_ENCODED);
+		if (w >= 0)
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
@@ -1257,6 +1489,12 @@ out:
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
@@ -1287,6 +1525,9 @@ static const char * const cmd_receive_usage[] = {
 	"-m ROOTMOUNT     the root mount point of the destination filesystem.",
 	"                 If /proc is not accessible, use this to tell us where",
 	"                 this file system is mounted.",
+	"--force-decompress",
+	"                 if the stream contains compressed data, always",
+	"                 decompress it instead of writing it with encoded I/O",
 	"--dump           dump stream metadata, one line per operation,",
 	"                 does not require the MOUNT parameter",
 	"-v               deprecated, alias for global -v option",
@@ -1330,12 +1571,16 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
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
 
@@ -1378,6 +1623,9 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
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
2.30.2

