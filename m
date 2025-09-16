Return-Path: <linux-fsdevel+bounces-61562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B2B589E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A8907AE067
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31D1A3172;
	Tue, 16 Sep 2025 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5zSQUNu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD2148FE6
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983339; cv=none; b=e+4GJDZk68gki4A0zMlAdK2VgQnuPcWCAYBT9OGvNDzhu7gwpDKw5/3wclqg3UT/ojqkfRlf893pMjJNASX6slsDLvqfABBgr6cs7Nv1Kb+354HWKKECBbcUNPPJt1iU7o4rXOTRwu9X1gBUYjmKUhCC1HOBhPHa26j+1v5j94k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983339; c=relaxed/simple;
	bh=LOia5LE0kBHP+MCy3uBcVtEKirCiCoU3n6sX+HVKLKk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4IDlEXGJziqauHh2vUYKgLkvCET4SEcS20KE4m/2W00ZdIPbjrCqRlDgJxodV4qjgBRmv0d94DMxFmEPTdY5AsvzZCGF8R6p+N9+iiLIEHgr9NPwdb/dwuk1SafV8ak+tWbZ7qTOTEqfql/BL68dt4zW6euca9n8ys3XX0GjhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5zSQUNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2F6C4CEF9;
	Tue, 16 Sep 2025 00:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983339;
	bh=LOia5LE0kBHP+MCy3uBcVtEKirCiCoU3n6sX+HVKLKk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Y5zSQUNuTaga4/77NUMR9SzVGfTDVJDqs/JejOjmJjHHiFlQhXlOHy56qgqp2Zpmp
	 zFqPdTEs8KKc0XHLy3CwZOVtL1cAEd4wDUnnLnu7SL04Dd/XijQr7K/bcImfbjcDZq
	 EHmC5CiKHtMbmbb5De0saXFV4YoTbhkF93PaunkPgPCuxmuaIl6fJD813xpWNSMsPI
	 KLeJC9X2sx6W9XGoqNgJdnO10JXr+A9eBJgZTprbIpx1gPioU5SwMGBuXi4UzoMvqZ
	 y6RqFX0ADuiEJ5yA1hfvIZrsLQwqvbGkMo7oBhP7WeH6x+O6Bq9c7pGhrrFLDVbNZ3
	 kHdkJE8C/YqYQ==
Date: Mon, 15 Sep 2025 17:42:18 -0700
Subject: [PATCH 02/18] libfuse: add kernel gates for FUSE_IOMAP
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154550.386924.5847992133761129118.stgit@frogsfrogsfrogs>
In-Reply-To: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
References: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
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
index 4d68c4e8a71d5f..cfa71dab28fdde 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -237,6 +237,7 @@
  *  - add FUSE_NOTIFY_INC_EPOCH
  *
  *  7.99
+ *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  */
 
 #ifndef _LINUX_FUSE_H
@@ -445,6 +446,7 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
+ * FUSE_IOMAP: Client supports iomap for regular file operations
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -492,6 +494,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_IOMAP		(1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index e4544dfc30d5c6..649a500614b80e 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2686,7 +2686,10 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
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
@@ -2732,6 +2735,9 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		       FUSE_CAP_READDIRPLUS_AUTO);
 	LL_SET_DEFAULT(1, FUSE_CAP_OVER_IO_URING);
 
+	/* servers need to opt-in to iomap explicitly */
+	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP);
+
 	/* This could safely become default, but libfuse needs an API extension
 	 * to support it
 	 * LL_SET_DEFAULT(1, FUSE_CAP_SETXATTR_EXT);
@@ -2850,6 +2856,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		outargflags |= FUSE_REQUEST_TIMEOUT;
 		outarg.request_timeout = se->conn.request_timeout;
 	}
+	if (se->conn.want_ext & FUSE_CAP_IOMAP)
+		outargflags |= FUSE_IOMAP;
 
 	if (inargflags & FUSE_INIT_EXT) {
 		outargflags |= FUSE_INIT_EXT;
@@ -2891,6 +2899,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		if (se->conn.want_ext & FUSE_CAP_PASSTHROUGH)
 			fuse_log(FUSE_LOG_DEBUG, "   max_stack_depth=%u\n",
 				outarg.max_stack_depth);
+		if (se->conn.want_ext & FUSE_CAP_IOMAP)
+			fuse_log(FUSE_LOG_DEBUG, "   iomap=1\n");
 	}
 	if (arg->minor < 5)
 		outargsize = FUSE_COMPAT_INIT_OUT_SIZE;


