Return-Path: <linux-fsdevel+bounces-55354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA34B09828
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEFD3A3512
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BE023FC4C;
	Thu, 17 Jul 2025 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGtyPR3l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442C1FCFF8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795406; cv=none; b=iJQHIYDRIE/T4Ofto5MCfeqyk9J2DnjZ1SG43OS1zyNDQP7YKbG4eVhW25HLCO77lKZ8T0oOAmrsLATyPZdXi1O5rn0DFTsaZ8MH1zrx3KDdLsCBDbVtBnLAnQfPg0HfkhuoOvBfCWSdLAHU4ZpUFREzTVnJvtdsDfOm3RmYjFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795406; c=relaxed/simple;
	bh=71PtaWU8YNH23E6Pd7wRJa8yYKR19d4dWz8VfPpkFS4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2CxeCHMVypL/CCiovDxwD2DlXWQ3Mo4WIymtX/AqpoCAozQDR8q3YtAf47ZeLRszAo722/nCY208fnrlApU0LHgRAJl/0EFCGqZw/tJ9WgDKm8ONIZu3X3VdJNPoK8E0BXeAIyHH7wXGuZ3WjQM4F1ERvAE0uF2NuNaOy6VdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGtyPR3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160CFC4CEE3;
	Thu, 17 Jul 2025 23:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795406;
	bh=71PtaWU8YNH23E6Pd7wRJa8yYKR19d4dWz8VfPpkFS4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dGtyPR3lCPIbjsIJCOJnsf88lIXXmsFr/p4ZOdKh0HWl1cYCKmJAfObodKkYLAPV6
	 nacK4aqom1+j3Yb5TowS4cuCpLG9O+3u29qw2868QL/rW/SD+9wR10WzrbuXB6RU95
	 7uE4UkBDKckahxYUw4XBqFoMBDIZYTEDh4w2vYdFVGpA/5D2aVONHl6STdWRirzX5z
	 HTqqV6oTkoKBSjzv/UcMr8zxfQK2+xJ/LYXKltiUU8DuJeLMqPWdjtiK2sFj1Sf3GU
	 It98DIcjpHVCyBUhwhA/EG/U9rI+dcj80aU2uYnj+WA2LAvwLHTWhraGktQoCA4J3z
	 XtXOG5jtegOUQ==
Date: Thu, 17 Jul 2025 16:36:45 -0700
Subject: [PATCH 09/14] libfuse: add FUSE_IOMAP_DIRECTIO
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279459893.714161.2356948961186080590.stgit@frogsfrogsfrogs>
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
to support direct IO.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    7 +++++++
 include/fuse_kernel.h |    5 +++++
 lib/fuse_lowlevel.c   |    9 +++++++++
 3 files changed, 21 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 11eb22d011896c..657256b6309284 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -525,6 +525,11 @@ struct fuse_loop_config_v1 {
  */
 #define FUSE_CAP_IOMAP (1ULL << 32)
 
+/**
+ * Client supports using iomap for direct I/O file operations
+ */
+#define FUSE_CAP_IOMAP_DIRECTIO (1ULL << 33)
+
 /**
  * Ioctl flags
  *
@@ -1212,6 +1217,8 @@ struct fuse_iomap {
 
 /* enable fsdax */
 #define FUSE_IFLAG_DAX			(1U << 0)
+/* use iomap for directio */
+#define FUSE_IFLAG_IOMAP_DIRECTIO	(1U << 1)
 
 #endif /* FUSE_USE_VERSION >= 318 */
 
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index a06c16243a7885..7205de018634b9 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -240,6 +240,7 @@
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
  *    SEEK_{DATA,HOLE} support
  *  - add FUSE_DEV_IOC_IOMAP_DEV_ADD to configure block devices for iomap
+ *  - add FUSE_IOMAP_DIRECTIO/FUSE_ATTR_IOMAP_DIRECTIO for direct I/O support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -450,6 +451,7 @@ struct fuse_file_lock {
  *			 init_out.request_timeout contains the timeout (in secs)
  * FUSE_IOMAP: Client supports iomap for FIEMAP and SEEK_{DATA,HOLE} file
  *	       operations.
+ * FUSE_IOMAP_DIRECTIO: Client supports iomap for direct I/O operations.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -498,6 +500,7 @@ struct fuse_file_lock {
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
 #define FUSE_IOMAP		(1ULL << 43)
+#define FUSE_IOMAP_DIRECTIO	(1ULL << 44)
 
 /**
  * CUSE INIT request/reply flags
@@ -581,9 +584,11 @@ struct fuse_file_lock {
  *
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
+ * FUSE_ATTR_IOMAP_DIRECTIO: Use iomap for directio
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
+#define FUSE_ATTR_IOMAP_DIRECTIO	(1 << 2)
 
 /**
  * Open flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 568db13502a7d7..f98900c51d4a9b 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -124,6 +124,8 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
 	attr->flags	= 0;
 	if (iflags & FUSE_IFLAG_DAX)
 		attr->flags |= FUSE_ATTR_DAX;
+	if (iflags & FUSE_IFLAG_IOMAP_DIRECTIO)
+		attr->flags |= FUSE_ATTR_IOMAP_DIRECTIO;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)
@@ -2777,6 +2779,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_OVER_IO_URING;
 		if (inargflags & FUSE_IOMAP)
 			se->conn.capable_ext |= FUSE_CAP_IOMAP;
+		if (inargflags & FUSE_IOMAP_DIRECTIO)
+			se->conn.capable_ext |= FUSE_CAP_IOMAP_DIRECTIO;
 	} else {
 		se->conn.max_readahead = 0;
 	}
@@ -2824,6 +2828,7 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 
 	/* servers need to opt-in to iomap explicitly */
 	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP);
+	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP_DIRECTIO);
 
 	/* This could safely become default, but libfuse needs an API extension
 	 * to support it
@@ -2945,6 +2950,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 	}
 	if (se->conn.want_ext & FUSE_CAP_IOMAP)
 		outargflags |= FUSE_IOMAP;
+	if (se->conn.want_ext & FUSE_CAP_IOMAP_DIRECTIO)
+		outargflags |= FUSE_IOMAP_DIRECTIO;
 
 	if (inargflags & FUSE_INIT_EXT) {
 		outargflags |= FUSE_INIT_EXT;
@@ -2988,6 +2995,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 				outarg.max_stack_depth);
 		if (se->conn.want_ext & FUSE_CAP_IOMAP)
 			fuse_log(FUSE_LOG_DEBUG, "   iomap=1\n");
+		if (se->conn.want_ext & FUSE_CAP_IOMAP_DIRECTIO)
+			fuse_log(FUSE_LOG_DEBUG, "   iomap_directio=1\n");
 	}
 	if (arg->minor < 5)
 		outargsize = FUSE_COMPAT_INIT_OUT_SIZE;


