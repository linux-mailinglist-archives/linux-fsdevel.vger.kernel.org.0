Return-Path: <linux-fsdevel+bounces-58477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5F3B2E9F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92C11749A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D221991DD;
	Thu, 21 Aug 2025 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us4pou5M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09E34315A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738113; cv=none; b=P0Xwm0tL3Kq1WSl5m5bU0/G2fsHn7wOYP3EhhOeZeVDXKlJFD8JrFfK0Hw7+jiNq5OrQCwHBzZtubfuhzutpnREZ3QmDOqtjB/WTbCUQsiQBPGzz6KZj9C8G3DeA987s+7gH/gOVTVRA7K5jVUioAOzrviAGbvNLu+Mb9rL2Pvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738113; c=relaxed/simple;
	bh=1UKdyNvOD85H+Rsu+ZLhYR+9Zkjhiqe/l5x0FNrZO/s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PW2L9LVgMKZn0TOaBl0VYvVHfGSv2uVEs0MMvETnOK9UqcHVC3a2w5b39EOqdAFWcc42KXlpuxrNTeA44GqdKBkaXZxk1sCbk5uVPeiUY5gaeZt8rUq4b+rd+4hRwZsV3O6/r+uJTEJ0bFxtxwZ0vNlvwJf1jQY3q5PJQtIAUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us4pou5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56F9C4CEE7;
	Thu, 21 Aug 2025 01:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738113;
	bh=1UKdyNvOD85H+Rsu+ZLhYR+9Zkjhiqe/l5x0FNrZO/s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=us4pou5MkKtSL28HUb4r8tou26hCMTp8tMkL2mYJYGa4154FyC5KqejhfBiLIsjQF
	 F4t1/mM31rHzxjPgKDMh/mo/hd4TcKxjWTknmc5Hj/JM3UlKRJXsyznbLSX39YRRSV
	 BvNQ3YanSQZraRXE2DmzouEie5iCSyfcqXaAvRWkCd5Ce0ySTXCVeIImtCrv141gV1
	 6Tszk6fFbuHtsjduRHD28mSDyw8y+P+Ij2Jetp6sWgS37cAkKJvWo7dVzlgEJy4DdP
	 ry37qdBR/+dW85iY1/soO7habTj8P5Z59jh34CC3DVtxdrJATRv24U2nTBSoqk8h1g
	 0RCWOniWaEAaw==
Date: Wed, 20 Aug 2025 18:01:53 -0700
Subject: [PATCH 02/21] libfuse: add kernel gates for FUSE_IOMAP
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711319.19163.14939847214113363417.stgit@frogsfrogsfrogs>
In-Reply-To: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
References: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
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
 include/fuse_kernel.h |    5 +++++
 lib/fuse_lowlevel.c   |   10 +++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)


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
index 4d68c4e8a71d5f..6779b9c69bb9e2 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -237,6 +237,8 @@
  *  - add FUSE_NOTIFY_INC_EPOCH
  *
  *  7.99
+ *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
+ *    SEEK_{DATA,HOLE}
  */
 
 #ifndef _LINUX_FUSE_H
@@ -445,6 +447,8 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
+ * FUSE_IOMAP: Client supports iomap for FIEMAP and SEEK_{DATA,HOLE} file
+ *	       operations.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -492,6 +496,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_IOMAP		(1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 6afcecd3bdda96..33c71ba216679c 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2686,7 +2686,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_NO_EXPORT_SUPPORT;
 		if (inargflags & FUSE_OVER_IO_URING)
 			se->conn.capable_ext |= FUSE_CAP_OVER_IO_URING;
-
+		if (inargflags & FUSE_IOMAP)
+			se->conn.capable_ext |= FUSE_CAP_IOMAP;
 	} else {
 		se->conn.max_readahead = 0;
 	}
@@ -2732,6 +2733,9 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		       FUSE_CAP_READDIRPLUS_AUTO);
 	LL_SET_DEFAULT(1, FUSE_CAP_OVER_IO_URING);
 
+	/* servers need to opt-in to iomap explicitly */
+	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP);
+
 	/* This could safely become default, but libfuse needs an API extension
 	 * to support it
 	 * LL_SET_DEFAULT(1, FUSE_CAP_SETXATTR_EXT);
@@ -2850,6 +2854,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		outargflags |= FUSE_REQUEST_TIMEOUT;
 		outarg.request_timeout = se->conn.request_timeout;
 	}
+	if (se->conn.want_ext & FUSE_CAP_IOMAP)
+		outargflags |= FUSE_IOMAP;
 
 	if (inargflags & FUSE_INIT_EXT) {
 		outargflags |= FUSE_INIT_EXT;
@@ -2891,6 +2897,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		if (se->conn.want_ext & FUSE_CAP_PASSTHROUGH)
 			fuse_log(FUSE_LOG_DEBUG, "   max_stack_depth=%u\n",
 				outarg.max_stack_depth);
+		if (se->conn.want_ext & FUSE_CAP_IOMAP)
+			fuse_log(FUSE_LOG_DEBUG, "   iomap=1\n");
 	}
 	if (arg->minor < 5)
 		outargsize = FUSE_COMPAT_INIT_OUT_SIZE;


