Return-Path: <linux-fsdevel+bounces-49618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFA1AC00FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DBBB7B3533
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8BD64D;
	Thu, 22 May 2025 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwX5cu2w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7C5367
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872336; cv=none; b=iOkh1XoLALm9O2hvXnCxdgYtL5Vz8rLkhuL4qu1U9tQ4UCq268bLao9jr3b0i3W0KpMnAgbKbn1Xkm305J9RoPW2KCQkwms2QJPdCCO9rxs9eV+3zw8LE+Wb9RojuWVan54qdo4OaWuZyvY42lmz/vQvfh++JumU05SjgaVLt+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872336; c=relaxed/simple;
	bh=fktgoVForhKX8oYTgy/IL5OcWNI4x8se8IyomDyILyI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kr+1nm2rQZeM9MjrL4naND58VZ591gZ5CGZ7UNTyC3yxy9Hg382K/nZUpcaL6Jj8nUfbPoC92jw98jv7h843YBz5Bv9kl1waxYICVMmhlOJwk897rCxX6cmk4dIcDgOcCklhuaTaJ4qLwXf0yocfBzVPxENiTxxe2cF4c0bvHVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwX5cu2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A63CC4CEE4;
	Thu, 22 May 2025 00:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872335;
	bh=fktgoVForhKX8oYTgy/IL5OcWNI4x8se8IyomDyILyI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dwX5cu2w5LAfwqYqRRthtxFzbhschoR9U1DKhbmsLBy6gmBukMS8bGyDxrw+iUob5
	 K1YzrfmRjdB3AYvdABsz39HQz3Uhfin8QGcHkVboltOAq/DCkD44QY7KYl52O4TmJO
	 dnQSZeTNitzk8rP2SGN6nM+3WzfbpewEzysYPKSgeAKRnRi7aCnL5ZOggZQHvkX3gm
	 2qdVZrV1Y3KzU9qE81CXcmeoZzrBwPp80AFwKvppz3ee8cU8cLN9LFW/Oszh3ezXDu
	 QgwrLv2kcg0b623ggumOQ6k6jAg+YKxrbXP1JyWA0oEIwMZHheuiDXGlP2a9VUArw0
	 38o709Kneph1g==
Date: Wed, 21 May 2025 17:05:34 -0700
Subject: [PATCH 1/8] libfuse: add kernel gates for FUSE_IOMAP and bump libfuse
 api version
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, John@groves.net,
 joannelkoong@gmail.com, miklos@szeredi.hu
Message-ID: <174787196376.1483718.8624821729317801057.stgit@frogsfrogsfrogs>
In-Reply-To: <174787196326.1483718.13513023339006584229.stgit@frogsfrogsfrogs>
References: <174787196326.1483718.13513023339006584229.stgit@frogsfrogsfrogs>
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
index 249e0c94f81ea4..2394655140dc26 100644
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
index 5e0eb41d967e9d..f519fb2dc08b3f 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -229,6 +229,10 @@
  *    - FUSE_URING_IN_OUT_HEADER_SZ
  *    - FUSE_URING_OP_IN_OUT_SZ
  *    - enum fuse_uring_cmd
+ *
+ *  7.44
+ *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
+ *    SEEK_{DATA,HOLE} support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -264,7 +268,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 42
+#define FUSE_KERNEL_MINOR_VERSION 44
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -435,6 +439,8 @@ struct fuse_file_lock {
  *		    of the request ID indicates resend requests
  * FUSE_ALLOW_IDMAP: allow creation of idmapped mounts
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
+ * FUSE_IOMAP: Client supports iomap for FIEMAP and SEEK_{DATA,HOLE} file
+ *	       operations.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -482,6 +488,7 @@ struct fuse_file_lock {
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
+#define FUSE_IOMAP		(1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 7f4326cb3c14c9..4b03e626dab508 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2544,6 +2544,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_NO_EXPORT_SUPPORT;
 		if (inargflags & FUSE_OVER_IO_URING)
 			se->conn.capable_ext |= FUSE_CAP_OVER_IO_URING;
+		if (inargflags & FUSE_IOMAP)
+			se->conn.capable_ext |= FUSE_CAP_IOMAP;
 
 	} else {
 		se->conn.max_readahead = 0;
@@ -2590,6 +2592,9 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		       FUSE_CAP_READDIRPLUS_AUTO);
 	LL_SET_DEFAULT(1, FUSE_CAP_OVER_IO_URING);
 
+	/* servers need to opt-in to iomap explicitly */
+	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP);
+
 	/* This could safely become default, but libfuse needs an API extension
 	 * to support it
 	 * LL_SET_DEFAULT(1, FUSE_CAP_SETXATTR_EXT);
@@ -2713,6 +2718,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		outargflags |= FUSE_NO_EXPORT_SUPPORT;
 	if (se->conn.want_ext & FUSE_CAP_OVER_IO_URING)
 		outargflags |= FUSE_OVER_IO_URING;
+	if (se->conn.want_ext & FUSE_CAP_IOMAP)
+		outargflags |= FUSE_IOMAP;
 
 	if (inargflags & FUSE_INIT_EXT) {
 		outargflags |= FUSE_INIT_EXT;
@@ -2754,6 +2761,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
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


