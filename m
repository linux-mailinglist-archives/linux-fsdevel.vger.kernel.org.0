Return-Path: <linux-fsdevel+bounces-66059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B13C17B4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3640F188EA65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6188524BD1A;
	Wed, 29 Oct 2025 00:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHAYP7Dd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7061CAA7D;
	Wed, 29 Oct 2025 00:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699590; cv=none; b=bFuPwFQTWxDvBSq7I01GGRzXt1WcHlCe4UfSyufbj8PONxEXQVBv04HYQ7RjRqSEi2x4r4hmojAD+B1QCl/JCY70dC0hWzDdRdSOJGO80OXFVnSp/1JO2hDaz93LTpvypr0pWkMbdmMCjtbrTWUe3Qa/sJttrK8NlqEAJeqnV3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699590; c=relaxed/simple;
	bh=SxP6pXlk3pMkHrs1XlKtpue/Z4Jxb/m9D8C3qNDx6Tc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrNI7o4qtPT1V3NP+GL5/DIOU171lOmcCtxKvNf5CmU64DFsJLtV0DEmCxhdCLjezDnfAgct+j3eaHKWVxcW5O/PbNEDEhbuWV4U3by718xKBHJZiniGA9qdieOmEoRF6tQwW4JenhzMHbUOguLfTH4PDBfciK3/B9pbwX2cRM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHAYP7Dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357EEC4CEE7;
	Wed, 29 Oct 2025 00:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699590;
	bh=SxP6pXlk3pMkHrs1XlKtpue/Z4Jxb/m9D8C3qNDx6Tc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kHAYP7DdhsW/vjE1vNon8iyZPPdvIWW5xZLXhuESBcM4fesg9ACeiy4ejRFmNDntt
	 9pkRltavpl+8fAuP1WGnv81X28O7MAIPIQUeA/wG4N4VhWij0eGCaXXSQ/5xhwVT2P
	 1VDTySR4I/o7SNrAt748J2j1beC2cjdvPqQFWJd3ZPBZNE/uMzMJsMjKhWMWB0blyJ
	 vIlhZZX8s38KTUJr6LQTi/yZOFwmmZt/txeyRDW3sVUU9DtP9PtSxqCBLRgU1FnSWu
	 qKyir+8TK2XRQJT+oSbCz1OcT3dJUdtMAxaSsG8NWU0dACHDyjaUmOe0Sfvu/jvZ7y
	 5C2ieyFs75cEw==
Date: Tue, 28 Oct 2025 17:59:49 -0700
Subject: [PATCH 02/22] libfuse: add kernel gates for FUSE_IOMAP
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813569.1427432.5266892141831578605.stgit@frogsfrogsfrogs>
In-Reply-To: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
References: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
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
for regular files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    5 +++++
 include/fuse_kernel.h |    3 +++
 lib/fuse_lowlevel.c   |   12 +++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 041188ec7fa732..9d53354de78868 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -512,6 +512,11 @@ struct fuse_loop_config_v1 {
  */
 #define FUSE_CAP_OVER_IO_URING (1UL << 31)
 
+/**
+ * Client supports using iomap for regular file operations
+ */
+#define FUSE_CAP_IOMAP (1ULL << 32)
+
 /**
  * Ioctl flags
  *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index cf4a5f1a35c98b..80ac8c09d2dd64 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -241,6 +241,7 @@
  *  - add struct fuse_copy_file_range_out
  *
  *  7.99
+ *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  */
 
 #ifndef _LINUX_FUSE_H
@@ -449,6 +450,7 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
+ * FUSE_IOMAP: Client supports iomap for regular file operations
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -496,6 +498,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_IOMAP		(1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index d420b257b9dd78..913a2d910504e1 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2746,7 +2746,10 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_NO_EXPORT_SUPPORT;
 		if (inargflags & FUSE_OVER_IO_URING)
 			se->conn.capable_ext |= FUSE_CAP_OVER_IO_URING;
-
+		if (inargflags & FUSE_IOMAP)
+			se->conn.capable_ext |= FUSE_CAP_IOMAP;
+		/* Don't let anyone touch iomap until the end of the patchset. */
+		se->conn.capable_ext &= ~FUSE_CAP_IOMAP;
 	} else {
 		se->conn.max_readahead = 0;
 	}
@@ -2792,6 +2795,9 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		       FUSE_CAP_READDIRPLUS_AUTO);
 	LL_SET_DEFAULT(1, FUSE_CAP_OVER_IO_URING);
 
+	/* servers need to opt-in to iomap explicitly */
+	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP);
+
 	/* This could safely become default, but libfuse needs an API extension
 	 * to support it
 	 * LL_SET_DEFAULT(1, FUSE_CAP_SETXATTR_EXT);
@@ -2909,6 +2915,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		outargflags |= FUSE_REQUEST_TIMEOUT;
 		outarg.request_timeout = se->conn.request_timeout;
 	}
+	if (se->conn.want_ext & FUSE_CAP_IOMAP)
+		outargflags |= FUSE_IOMAP;
 
 	outarg.max_readahead = se->conn.max_readahead;
 	outarg.max_write = se->conn.max_write;
@@ -2943,6 +2951,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		if (se->conn.want_ext & FUSE_CAP_PASSTHROUGH)
 			fuse_log(FUSE_LOG_DEBUG, "   max_stack_depth=%u\n",
 				outarg.max_stack_depth);
+		if (se->conn.want_ext & FUSE_CAP_IOMAP)
+			fuse_log(FUSE_LOG_DEBUG, "   iomap=1\n");
 	}
 	if (arg->minor < 5)
 		outargsize = FUSE_COMPAT_INIT_OUT_SIZE;


