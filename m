Return-Path: <linux-fsdevel+bounces-55355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC60B09829
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A310189C9C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B502923ABB7;
	Thu, 17 Jul 2025 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxLDUT1c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A291FCFF8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795422; cv=none; b=UZxD7OzBcOmAdb9Y/VG3BUbJD0YYBZnclt5AY+h+drFzWRN4CVWEE/k07JySFIjEfRGM7HtrtpwPAUHeam7A0qEx5VDEBn7txrrKcL3BUZPIezj71niwD1nihDNr1ewzxpyNezWRhEm4Ho68jpv2mXuc1IPAKCXMYDsyWizJK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795422; c=relaxed/simple;
	bh=54lIo+AiUWO4zp51IB7twxz6hI+aCkT5T5cjS4nh7BM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0ODDCtB2TnzY2jz/DakXcrioKUOpCj8ZCWmCZPteKLcCSL15YD1QR5miYjJWtryPZhkf2cjasFQmK6egdUBb0oDD8g+1+N7aEGcd+dNIV5DJcJQzWfMlB6tSViafbDgZJp3l8QGCGZVxlZqgfrJWaoyGQ2uvV0nkUQ/tD6EMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxLDUT1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EF0C4CEE3;
	Thu, 17 Jul 2025 23:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795421;
	bh=54lIo+AiUWO4zp51IB7twxz6hI+aCkT5T5cjS4nh7BM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=IxLDUT1cvCq1hLhxCDv94DyRviSeyL76LUHfY0SendJpQsjst3vg9mW7DjGYPqTBF
	 Add00z+0okRU7Fc3paNHPCDsFFc2Xz4VRhx3kppoAC2UZyPK3L9q3HApXgUF03o5Iu
	 N/x8dnX7gzKvdTlk0+lnkcayFzw62BqLaeMk5KTkvs3dDf7eBvfiJA0WM503yQGKFp
	 xl4tKWfQvkrWtwtcZSbUlBntuaa3blJnoGuwr+B4aKXuiTqqRAHlGJLggI4UpdxWAq
	 +tVOM9CIAYFfd33iodZTpug1sXB4+UoLoKnFh8gs8+C4CYmqrqr7oVlaJUBVH760bY
	 lE7J7/gT4JTvg==
Date: Thu, 17 Jul 2025 16:37:01 -0700
Subject: [PATCH 10/14] libfuse: add FUSE_IOMAP_FILEIO
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279459911.714161.4594001739046468918.stgit@frogsfrogsfrogs>
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

Make it so that fuse servers can ask the kernel fuse driver to use iomap
to support buffered IO.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    7 +++++++
 include/fuse_kernel.h |    5 +++++
 lib/fuse_lowlevel.c   |    9 +++++++++
 3 files changed, 21 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 657256b6309284..8bc21677b6e5c7 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -530,6 +530,11 @@ struct fuse_loop_config_v1 {
  */
 #define FUSE_CAP_IOMAP_DIRECTIO (1ULL << 33)
 
+/*
+ * Client supports using iomap for buffered I/O file operations
+ */
+#define FUSE_CAP_IOMAP_FILEIO (1ULL << 34)
+
 /**
  * Ioctl flags
  *
@@ -1219,6 +1224,8 @@ struct fuse_iomap {
 #define FUSE_IFLAG_DAX			(1U << 0)
 /* use iomap for directio */
 #define FUSE_IFLAG_IOMAP_DIRECTIO	(1U << 1)
+/* use iomap for buffered io */
+#define FUSE_IFLAG_IOMAP_FILEIO		(1U << 2)
 
 #endif /* FUSE_USE_VERSION >= 318 */
 
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 7205de018634b9..17ab74255cbf33 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -241,6 +241,7 @@
  *    SEEK_{DATA,HOLE} support
  *  - add FUSE_DEV_IOC_IOMAP_DEV_ADD to configure block devices for iomap
  *  - add FUSE_IOMAP_DIRECTIO/FUSE_ATTR_IOMAP_DIRECTIO for direct I/O support
+ *  - add FUSE_IOMAP_FILEIO/FUSE_ATTR_IOMAP_FILEIO for buffered I/O support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -452,6 +453,7 @@ struct fuse_file_lock {
  * FUSE_IOMAP: Client supports iomap for FIEMAP and SEEK_{DATA,HOLE} file
  *	       operations.
  * FUSE_IOMAP_DIRECTIO: Client supports iomap for direct I/O operations.
+ * FUSE_IOMAP_FILEIO: Client supports iomap for buffered I/O operations.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -501,6 +503,7 @@ struct fuse_file_lock {
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
 #define FUSE_IOMAP		(1ULL << 43)
 #define FUSE_IOMAP_DIRECTIO	(1ULL << 44)
+#define FUSE_IOMAP_FILEIO	(1ULL << 45)
 
 /**
  * CUSE INIT request/reply flags
@@ -585,10 +588,12 @@ struct fuse_file_lock {
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
  * FUSE_ATTR_IOMAP_DIRECTIO: Use iomap for directio
+ * FUSE_ATTR_IOMAP_FILEIO: Use iomap for buffered io
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_IOMAP_DIRECTIO	(1 << 2)
+#define FUSE_ATTR_IOMAP_FILEIO	(1 << 3)
 
 /**
  * Open flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index f98900c51d4a9b..d354b947a4fb6b 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -126,6 +126,8 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
 		attr->flags |= FUSE_ATTR_DAX;
 	if (iflags & FUSE_IFLAG_IOMAP_DIRECTIO)
 		attr->flags |= FUSE_ATTR_IOMAP_DIRECTIO;
+	if (iflags & FUSE_IFLAG_IOMAP_FILEIO)
+		attr->flags |= FUSE_ATTR_IOMAP_FILEIO;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)
@@ -2781,6 +2783,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_IOMAP;
 		if (inargflags & FUSE_IOMAP_DIRECTIO)
 			se->conn.capable_ext |= FUSE_CAP_IOMAP_DIRECTIO;
+		if (inargflags & FUSE_IOMAP_FILEIO)
+			se->conn.capable_ext |= FUSE_CAP_IOMAP_FILEIO;
 	} else {
 		se->conn.max_readahead = 0;
 	}
@@ -2829,6 +2833,7 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 	/* servers need to opt-in to iomap explicitly */
 	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP);
 	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP_DIRECTIO);
+	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP_FILEIO);
 
 	/* This could safely become default, but libfuse needs an API extension
 	 * to support it
@@ -2952,6 +2957,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		outargflags |= FUSE_IOMAP;
 	if (se->conn.want_ext & FUSE_CAP_IOMAP_DIRECTIO)
 		outargflags |= FUSE_IOMAP_DIRECTIO;
+	if (se->conn.want_ext & FUSE_CAP_IOMAP_FILEIO)
+		outargflags |= FUSE_IOMAP_FILEIO;
 
 	if (inargflags & FUSE_INIT_EXT) {
 		outargflags |= FUSE_INIT_EXT;
@@ -2997,6 +3004,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			fuse_log(FUSE_LOG_DEBUG, "   iomap=1\n");
 		if (se->conn.want_ext & FUSE_CAP_IOMAP_DIRECTIO)
 			fuse_log(FUSE_LOG_DEBUG, "   iomap_directio=1\n");
+		if (se->conn.want_ext & FUSE_CAP_IOMAP_FILEIO)
+			fuse_log(FUSE_LOG_DEBUG, "   iomap_fileio=1\n");
 	}
 	if (arg->minor < 5)
 		outargsize = FUSE_COMPAT_INIT_OUT_SIZE;


