Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57272B84CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgKRTTi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgKRTTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:38 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1206AC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:38 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 131so2035262pfb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uou+avacjLUgrd6sYNlplF7cpTImH06UMIPWOWB8yac=;
        b=nzxpNUj6PoGBVmyVq2S5Fp1qk7EKOPe6nNjaOmvNKESVqAaIkL9LtQBkbYPlh17oxN
         QWNpL4lDd9zQgBUi64ePtOxUDaqQczmWuQOZFHlNYGzDO17xu8DPVkyFiiL/D4wBr5jB
         vap+fxZY6N98wIMdyKpebAWkqFmWk46TOyHe8UD/y0BefzXbQxXE7pUN1yqSc7FjqfdS
         ccC3zfmoQ0hL1Yjijm3osiQC5SRVXv9u+itrHDoODV+cyRSGzd4M8iBsIrJzKKC3q+5m
         5uDJK0O2S8QT66/15D6WRfaeMBaygMxT9Fi28ILgSIR2xNCPJlRvBQDZRtdUKwbUqdiO
         o5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uou+avacjLUgrd6sYNlplF7cpTImH06UMIPWOWB8yac=;
        b=L5FIDOuf7KgOpUgEDO2iJ6psEz40jRfHyxpsZZ3awGoO4RFeioAfbxpeENCimmKNFD
         1LK6Ccys6Fy1R/I0rS9p/lN3BQO2WcKoKfyY9vDiel07BlYBmS1nBsVcue29JDdKaBJs
         wy/vmbYrIwefsrl0uUir6RLSq2FU3GM/UwzPFPY9gfTVZ2bmbydoGSyJ0suqaZzNCp29
         9YTS8R+o17VeWnkoVr4Mu9MdlMYhu9p1rZ5+CD0nP1WNAPiOn4CbWxJTnASHE0k9Poxi
         k18oSZZp8s8j6zn6394C0xhsnGJxfJEepEkfEAwTYRugMvbqvfn+XX9OzP7c6JcG6TYG
         CiJA==
X-Gm-Message-State: AOAM530yR8GHQxYtfmta86Fbw3c7r+5/+OgTWEPF5kt3xK+DsxLh1UvG
        OpAuTuzDZ3XMUtDCU/SPhOPFNQ==
X-Google-Smtp-Source: ABdhPJxeeAcMunQfSTcIXD946l5RX2PtUCFBhHPmRN80hYEI6+DTzpdaJ52wUPqWfy5Qhc4NJuKu6Q==
X-Received: by 2002:a05:6a00:16c4:b029:162:bf9f:6458 with SMTP id l4-20020a056a0016c4b0290162bf9f6458mr5955906pfc.55.1605727177373;
        Wed, 18 Nov 2020 11:19:37 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:36 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 09/13] btrfs-progs: receive: encoded_write fallback to explicit decode and write
Date:   Wed, 18 Nov 2020 11:18:56 -0800
Message-Id: <003ced29dccaac8e5bf41aa4f571f0154d011ae0.1605723745.git.osandov@osandov.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723600.git.osandov@fb.com>
References: <cover.1605723600.git.osandov@fb.com>
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
index 87f47a9a..361c7c8a 100644
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
@@ -82,6 +86,8 @@ struct btrfs_receive
 
 	int honor_end_cmd;
 
+	int force_decompress;
+
 	/*
 	 * Buffer to store capabilities from security.capabilities xattr,
 	 * usually 20 bytes, but make same room for potentially larger
@@ -89,6 +95,10 @@ struct btrfs_receive
 	 */
 	char cached_capabilities[64];
 	int cached_capabilities_len;
+
+	/* Reuse stream objects for encoded_write decompression fallback */
+	ZSTD_DStream *zstd_dstream;
+	z_stream *zlib_stream;
 };
 
 static int finish_subvol(struct btrfs_receive *rctx)
@@ -1077,9 +1087,222 @@ static int process_update_extent(const char *path, u64 offset, u64 len,
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
@@ -1096,6 +1319,7 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
 		{ &encoded, sizeof(encoded) },
 		{ (char *)data, len }
 	};
+	bool encoded_write = !rctx->force_decompress;
 
 	if (encryption) {
 		error("encoded_write: encryption not supported");
@@ -1112,17 +1336,25 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
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
@@ -1310,6 +1542,12 @@ out:
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
@@ -1340,6 +1578,9 @@ static const char * const cmd_receive_usage[] = {
 	"-m ROOTMOUNT     the root mount point of the destination filesystem.",
 	"                 If /proc is not accessible, use this to tell us where",
 	"                 this file system is mounted.",
+	"--force-decompress",
+	"                 if the stream contains compressed data, always",
+	"                 decompress it instead of writing it with encoded I/O",
 	"--dump           dump stream metadata, one line per operation,",
 	"                 does not require the MOUNT parameter",
 	"-v               deprecated, alias for global -v option",
@@ -1383,12 +1624,16 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
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
 
@@ -1431,6 +1676,9 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
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
2.29.2

