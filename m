Return-Path: <linux-fsdevel+bounces-55346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DE6B0981C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D88189E72A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2798B23A9AD;
	Thu, 17 Jul 2025 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4E7uv3Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC171FCFF8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795283; cv=none; b=WmyULuN6DB5szHaKkVLJX3qzyO/qktlx+xI9lkKrVebgU5XzakkTWXzjJm7aNMEU4Kt+7QdPlvH2R5zK2INmjucwQWdfIqfVwNDdVIXhl3kE1hGpp7/kluHr8CVGcQV+s0CP+9G7l/1GwMOm7VCVuJ63fdy4Ja6yT5fm21D0FXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795283; c=relaxed/simple;
	bh=Vd9lXtEo2pPbokwfYsl07aXPpHFWhi9CAhxaRHUIJPw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sn7STDNSP0LRhy5Kxo8a4uWTckQnYXqcvLo7DEH/Y2x1B1TzfxwBVDNByiRe23ZwWCH63S4GfQEbFNVdf1riCD7gzFgAlIFJ4gpGrX/z2LZiYdd0unLdIufnEXUnFUO6Px64V+IZQpY4r63KcDkAZL6N6UNi1HMcYG+KRJGVPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4E7uv3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099C4C4CEE3;
	Thu, 17 Jul 2025 23:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795281;
	bh=Vd9lXtEo2pPbokwfYsl07aXPpHFWhi9CAhxaRHUIJPw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=U4E7uv3Z2d1adPS81NdHfXYxPjAXQvwVAUBRXW4YJ/DB32HSiW5wX0jTGyls+7liL
	 q20wAhMRX4sLsf1f7y9P5xMEwWdv/2awLrrCKbPgIj+J0oQ+IB3yM0c5DUe6PHhOFT
	 WjpdWfBtq8ojkmKmk+5JnUMiW6c4VFecQ/lqcrGeLzoGOozI96sspZ98cYm7iVSHWd
	 xW8rlxGttqDJMW2uPhCFowW1tyXFCc+J0fhArggMcGfXqTtHq+AveQyum9l7QsEOPG
	 g8/4s4q3nds0eQBScoGQkpKraLunyEy6EI69yIZ6R8mGCTdgCOykq/TjmpzpzSecY4
	 KfNxcxmXQppUQ==
Date: Thu, 17 Jul 2025 16:34:40 -0700
Subject: [PATCH 01/14] libfuse: add kernel gates for FUSE_IOMAP and bump
 libfuse api version
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279459749.714161.10103402131143555529.stgit@frogsfrogsfrogs>
In-Reply-To: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add some flags to query and request kernel support for filesystem iomap
for regular files.  Bump the minor API version so that the new iomap
symbols don't go bleeding into old programs.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    5 +++++
 include/fuse_kernel.h |    9 ++++++++-
 lib/fuse_lowlevel.c   |    9 +++++++++
 lib/meson.build       |    2 +-
 4 files changed, 23 insertions(+), 2 deletions(-)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index b82f2c41deb30c..8f87263d78f999 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -520,6 +520,11 @@ struct fuse_loop_config_v1 {
  */
 #define FUSE_CAP_OVER_IO_URING (1UL << 31)
 
+/**
+ * Client supports using iomap for FIEMAP and SEEK_{DATA,HOLE}
+ */
+#define FUSE_CAP_IOMAP (1ULL << 32)
+
 /**
  * Ioctl flags
  *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 122d6586e8d4da..b1e42d3cf86e81 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -235,6 +235,10 @@
  *
  *  7.44
  *  - add FUSE_NOTIFY_INC_EPOCH
+ *
+ *  7.99
+ *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
+ *    SEEK_{DATA,HOLE} support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -270,7 +274,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 44
+#define FUSE_KERNEL_MINOR_VERSION 99
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -443,6 +447,8 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
+ * FUSE_IOMAP: Client supports iomap for FIEMAP and SEEK_{DATA,HOLE} file
+ *	       operations.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -490,6 +496,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_IOMAP		(1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 91f42440fca4b3..392e898a5e8ec1 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2624,6 +2624,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_NO_EXPORT_SUPPORT;
 		if (inargflags & FUSE_OVER_IO_URING)
 			se->conn.capable_ext |= FUSE_CAP_OVER_IO_URING;
+		if (inargflags & FUSE_IOMAP)
+			se->conn.capable_ext |= FUSE_CAP_IOMAP;
 
 	} else {
 		se->conn.max_readahead = 0;
@@ -2670,6 +2672,9 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		       FUSE_CAP_READDIRPLUS_AUTO);
 	LL_SET_DEFAULT(1, FUSE_CAP_OVER_IO_URING);
 
+	/* servers need to opt-in to iomap explicitly */
+	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP);
+
 	/* This could safely become default, but libfuse needs an API extension
 	 * to support it
 	 * LL_SET_DEFAULT(1, FUSE_CAP_SETXATTR_EXT);
@@ -2788,6 +2793,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		outargflags |= FUSE_REQUEST_TIMEOUT;
 		outarg.request_timeout = se->conn.request_timeout;
 	}
+	if (se->conn.want_ext & FUSE_CAP_IOMAP)
+		outargflags |= FUSE_IOMAP;
 
 	if (inargflags & FUSE_INIT_EXT) {
 		outargflags |= FUSE_INIT_EXT;
@@ -2829,6 +2836,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		if (se->conn.want_ext & FUSE_CAP_PASSTHROUGH)
 			fuse_log(FUSE_LOG_DEBUG, "   max_stack_depth=%u\n",
 				outarg.max_stack_depth);
+		if (se->conn.want_ext & FUSE_CAP_IOMAP)
+			fuse_log(FUSE_LOG_DEBUG, "   iomap=1\n");
 	}
 	if (arg->minor < 5)
 		outargsize = FUSE_COMPAT_INIT_OUT_SIZE;
diff --git a/lib/meson.build b/lib/meson.build
index fcd95741c9d374..2999abe8262afd 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -49,7 +49,7 @@ libfuse = library('fuse3',
                   dependencies: deps,
                   install: true,
                   link_depends: 'fuse_versionscript',
-                  c_args: [ '-DFUSE_USE_VERSION=317',
+                  c_args: [ '-DFUSE_USE_VERSION=318',
                             '-DFUSERMOUNT_DIR="@0@"'.format(fusermount_path) ],
                   link_args: ['-Wl,--version-script,' + meson.current_source_dir()
                               + '/fuse_versionscript' ])


