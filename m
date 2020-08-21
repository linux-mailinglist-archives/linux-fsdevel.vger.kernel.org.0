Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BC124CFAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgHUHlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgHUHkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D94C061348
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:49 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v16so525635plo.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JJzpMUwPLLywPgZkTrDSxUbJuyFfFwLySMrCBI6an1Q=;
        b=WGb9lD/EEk978nTwkBnFUsrmz3dmqQKyQbLPwgQoKrWdtYB6kznfddOnyC0TdeBF0y
         vRqm5dQyCRM/c26lXGuBu09O8VS7qa24Q4ynJEPOGjk4trJu8hpNWtnNVfFpU4nyXrP8
         5O8lbSNrFT2hzzbVAdXBHUMDyZzjVka/HpqCf+BKVu/DYHMxxizDGCprS/Bajbni5IuY
         xvXdpZ2lQoSHVMECaT7QhLOd5EE4Yn94SM+QNMwchDZYXVnMAotJBP2JSHUzxGyNRpYJ
         8ZwGdqt8ZnbSel36mhQzN1e58pODamtIHPUft1QUHp3ZIqauxrV5EoV7DmcpUrsN83JD
         grgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJzpMUwPLLywPgZkTrDSxUbJuyFfFwLySMrCBI6an1Q=;
        b=iparRGNzLB3WTVSiN7KsROPZ+ZLx5IQxxrgDirB3ATPvRtC2To446GUtiZ7cAPSgMY
         BckxItP6ofna0F0XwWTsZ3UmnZOrcg7+KfZsy8jxHYHcTDnfQP/q1n0ymNFTJ/JY3oBY
         mZ6IktXkFnhtAu/ZJ6WiZO6xqQnryR/v1lwRZlAa87ZcSUoJPFqSQoO1HKZg0frQ79B1
         2o+YFd0S8/TSBXanqo5zjcmLiOUUY39ZvNJMK6BmZw6bbD53AK34BYvTuTNgtgMN59sQ
         keYwtMuSZ6rOkXOuw/m0qZzAXF0IRY85edZQSA4wzh8tjfMF952+Z9bilzrWIyOP/f5N
         bcog==
X-Gm-Message-State: AOAM53200Mtp42d3Y4buIQ6VTjqczzlqEdu1YjPTMneFNAcyWu6PFKQy
        Ya/33ZmMmmqg9l0Ak8MDC3iFaw==
X-Google-Smtp-Source: ABdhPJxsk3zqP0HOjMeW9POjNCWYqpmClhHKnIxSUapiYItczePylr2VHUZuKznq9sCJyt45kJAimw==
X-Received: by 2002:a17:90a:bf86:: with SMTP id d6mr1394211pjs.83.1597995649334;
        Fri, 21 Aug 2020 00:40:49 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:47 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/11] btrfs-progs: receive: encoded_write fallback to explicit decode and write
Date:   Fri, 21 Aug 2020 00:40:06 -0700
Message-Id: <8e4bf8b613ad4504376e9f00ff87ee2e51222a23.1597994354.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
 cmds/receive.c | 273 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 262 insertions(+), 11 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index cd0f47ec..c67d4653 100644
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
@@ -1073,9 +1083,210 @@ static int process_update_extent(const char *path, u64 offset, u64 len,
 	return 0;
 }
 
+static int decompress_zlib(struct btrfs_receive *rctx, const void *encoded_data,
+			   u64 encoded_len, char *unencoded_data,
+			   u64 unencoded_len)
+{
+	int status = 0;
+	bool init = false;
+	int ret;
+
+	if (!rctx->zlib_stream) {
+		init = true;
+		rctx->zlib_stream = malloc(sizeof(z_stream));
+		if (!rctx->zlib_stream) {
+			error("failed to allocate zlib stream %m");
+			status = -ENOMEM;
+			goto out;
+		}
+	}
+	rctx->zlib_stream->next_in = (void *)encoded_data;
+	rctx->zlib_stream->avail_in = encoded_len;
+	rctx->zlib_stream->next_out = (void *)unencoded_data;
+	rctx->zlib_stream->avail_out = unencoded_len;
+
+	if (!init)
+		ret = inflateReset(rctx->zlib_stream);
+	else {
+		rctx->zlib_stream->zalloc = Z_NULL;
+		rctx->zlib_stream->zfree = Z_NULL;
+		rctx->zlib_stream->opaque = Z_NULL;
+		ret = inflateInit(rctx->zlib_stream);
+	}
+	if (ret != Z_OK) {
+		error("zlib inflate init failed %d", ret);
+		status = -EIO;
+		goto out;
+	}
+
+	while (rctx->zlib_stream->avail_in > 0 &&
+	       rctx->zlib_stream->avail_out > 0) {
+		ret = inflate(rctx->zlib_stream, Z_FINISH);
+		if (ret == Z_STREAM_END) {
+			break;
+		} else if (ret != Z_OK) {
+			error("zlib inflate failed %d", ret);
+			status = -EIO;
+			break;
+		}
+	}
+out:
+	return status;
+}
+
+static int decompress_lzo(const void *encoded_data, u64 encoded_len,
+			  char *unencoded_data, u64 unencoded_len)
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
+		uint32_t src_len;
+		lzo_uint dst_len = unencoded_len - out_pos;
+		int ret;
+
+		if (total_len - in_pos < 4) {
+			error("lzo segment header is truncated");
+			return -EIO;
+		}
+		memcpy(&src_len, encoded_data + in_pos, 4);
+		src_len = le32toh(src_len);
+		in_pos += 4;
+		if (src_len > total_len - in_pos) {
+			error("lzo segment header is invalid\n");
+			return -EIO;
+		}
+
+		ret = lzo1x_decompress_safe((void *)(encoded_data + in_pos),
+			src_len, (void *)(unencoded_data + out_pos), &dst_len,
+			NULL);
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
+static int decompress_zstd(struct btrfs_receive *rctx, const void *encoded_buf,
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
+	int status = 0;
+	size_t ret;
+
+	if (!rctx->zstd_dstream) {
+		rctx->zstd_dstream = ZSTD_createDStream();
+		if (!rctx->zstd_dstream) {
+			error("failed to create zstd dstream");
+			status = -ENOMEM;
+			goto out;
+		}
+	}
+	ret = ZSTD_initDStream(rctx->zstd_dstream);
+	if (ZSTD_isError(ret)) {
+		error("failed to init zstd stream %s", ZSTD_getErrorName(ret));
+		status = -EIO;
+		goto out;
+	}
+	while (in_buf.pos < in_buf.size && out_buf.pos < out_buf.size) {
+		ret = ZSTD_decompressStream(rctx->zstd_dstream, &out_buf, &in_buf);
+		if (ret == 0) {
+			break;
+		} else if (ZSTD_isError(ret)) {
+			error("failed to decompress zstd stream: %s",
+			      ZSTD_getErrorName(ret));
+			status = -EIO;
+			goto out;
+		}
+	}
+
+out:
+	return status;
+}
+
+static int decompress_and_write(const void *encoded_data, u64 encoded_len,
+				u64 unencoded_file_len, u64 unencoded_len,
+				u64 unencoded_offset, u32 compression,
+				void *user)
+{
+	int ret = 0;
+	size_t pos;
+	ssize_t w;
+	struct btrfs_receive *rctx = user;
+	char *unencoded_data;
+
+	unencoded_data = calloc(unencoded_len, sizeof(*unencoded_data));
+	if (!unencoded_data) {
+		error("allocating space for unencoded data failed: %m");
+		return -errno;
+	}
+
+	switch (compression) {
+	case ENCODED_IOV_COMPRESSION_ZLIB:
+		ret = decompress_zlib(rctx, encoded_data, encoded_len,
+				  unencoded_data, unencoded_len);
+		if (ret)
+			goto out;
+		break;
+	case ENCODED_IOV_COMPRESSION_LZO:
+		ret = decompress_lzo(encoded_data, encoded_len,
+				 unencoded_data, unencoded_len);
+		if (ret)
+			goto out;
+		break;
+	case ENCODED_IOV_COMPRESSION_ZSTD:
+		ret = decompress_zstd(rctx, encoded_data, encoded_len,
+				  unencoded_data, unencoded_len);
+		if (ret)
+			goto out;
+		break;
+	}
+
+	pos = unencoded_offset;
+	while (pos < unencoded_file_len) {
+		w = pwrite(rctx->write_fd, unencoded_data + pos,
+			   unencoded_file_len - pos, unencoded_offset + pos);
+		if (w < 0) {
+			ret = -errno;
+			error("writing unencoded data failed: %m");
+			goto out;
+		}
+		pos += w;
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
@@ -1091,6 +1302,14 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
 		{ &encoded, sizeof(encoded) },
 		{ (char *)data, len }
 	};
+	bool encoded_write = !rctx->force_decompress;
+	bool decompress = rctx->force_decompress;
+
+	if (encryption) {
+		error("encoded_write: encryption not supported\n");
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
 
 	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
 	if (ret < 0) {
@@ -1102,15 +1321,37 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
 	if (ret < 0)
 		goto out;
 
-	/*
-	 * NOTE: encoded writes guarantee no partial writes,
-	 * so we don't need to handle that possibility.
-	 */
-	ret = pwritev2(rctx->write_fd, iov, 2, offset, RWF_ENCODED);
-	if (ret < 0) {
-		ret = -errno;
-		error("encoded_write: writing to %s failed: %m", path);
+	if (encoded_write) {
+		/*
+		 * NOTE: encoded writes guarantee no partial writes,
+		 * so we don't need to handle that possibility.
+		 */
+		ret = pwritev2(rctx->write_fd, iov, 2, offset, RWF_ENCODED);
+		if (ret < 0) {
+			/*
+			 * error conditions where fallback to manual decompress
+			 * and write make sense.
+			 */
+			if (errno == ENOSPC ||
+			    errno == EOPNOTSUPP ||
+			    errno == EINVAL)
+				decompress = true;
+			else {
+				ret = -errno;
+				error("encoded_write: writing to %s failed: %m", path);
+				goto out;
+			}
+		}
 	}
+
+	if (decompress) {
+		ret = decompress_and_write(data, len, unencoded_file_len,
+				unencoded_len, unencoded_offset,
+				compression, user);
+		if (ret < 0)
+			goto out;
+	}
+	ret = 0;
 out:
 	return ret;
 }
@@ -1300,6 +1541,12 @@ out:
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
@@ -1373,12 +1620,13 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 	optind = 0;
 	while (1) {
 		int c;
-		enum { GETOPT_VAL_DUMP = 257 };
+		enum { GETOPT_VAL_DUMP = 257, GETOPT_VAL_FORCE_DECOMPRESS };
 		static const struct option long_opts[] = {
 			{ "max-errors", required_argument, NULL, 'E' },
 			{ "chroot", no_argument, NULL, 'C' },
 			{ "dump", no_argument, NULL, GETOPT_VAL_DUMP },
 			{ "quiet", no_argument, NULL, 'q' },
+			{ "force-decompress", no_argument, NULL, GETOPT_VAL_FORCE_DECOMPRESS },
 			{ NULL, 0, NULL, 0 }
 		};
 
@@ -1421,6 +1669,9 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
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
2.28.0

