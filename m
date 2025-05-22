Return-Path: <linux-fsdevel+bounces-49624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B0AAC0102
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177E89E4F87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50B6A50;
	Thu, 22 May 2025 00:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bd3hyAgA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF5380
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872430; cv=none; b=QF3UCYT7dyxU+IwZjxjTwul0UXXarQZca0uOuhbZDVonMzbG4MtbKqW/cZ6Q0xmtRrRvzia2cthlzw7V+nXOCBMALcSJTRogYZItWV8HiqaIVFT1LaW4waf412o2Rh9+TVm8EjSOo7LZAHEqkPK85nkc9oeqxcnSWBqZ4MvytUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872430; c=relaxed/simple;
	bh=59+DQkUcP7WJHjDa2/dJIuzQ+gnPbRCFncnAqmzK838=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6hd0407vJu6/G5pp1gWicCnCxZiaFF1/7VPuTOkQQLhxRHM5SbLJD9EMobEVYu1FQ5NFqwYqckUXn+QoiPpLVhJIv1KNRTmg6iidErlDJa341K13AUROpu7s4xuI0b8VImpXdI2Brsv1oHAFlQhSeHdxs+rZOCO24VelslNbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bd3hyAgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F18C4CEE4;
	Thu, 22 May 2025 00:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872429;
	bh=59+DQkUcP7WJHjDa2/dJIuzQ+gnPbRCFncnAqmzK838=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Bd3hyAgA1iyJZ3Vtl509Obgsv9kpKARG8dJIsLvkIFukYGdYBsj4lsKhsOBW3gzfe
	 v9Kex2BPtzGGgMaaBmoPAy95XrrM+4kbLKgjPhom8sipB7/sStp1/fp1py4/Brg9+W
	 N20pr46IwHcf7Iph/M9N97Aqe/e3G01AcXeDxcGhFXoNFrYzIpkraUyVeIHdGNpDDg
	 XdWO7AKpzVicxFaqKLNUeo1HdUjKcWhr5qrs331mcsd466RR8WFWlx+IvDCjzTP+vy
	 0th3quFc74v/JPiPrj3KJwyKhWb2cOZSkr4/djYpyuqMKobf+UP3leRFfWD7iRoetE
	 7t8doeY4bm4ZA==
Date: Wed, 21 May 2025 17:07:09 -0700
Subject: [PATCH 7/8] libfuse: add FUSE_IOMAP_PAGECACHE
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, John@groves.net,
 joannelkoong@gmail.com, miklos@szeredi.hu
Message-ID: <174787196484.1483718.1589463471865066104.stgit@frogsfrogsfrogs>
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

Make it so that fuse servers can ask the kernel fuse driver to use iomap
to support buffered IO.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    5 +++++
 include/fuse_kernel.h |    3 +++
 lib/fuse_lowlevel.c   |    8 +++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index f7bc03427d12e4..a102e450944f4a 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -530,6 +530,11 @@ struct fuse_loop_config_v1 {
  */
 #define FUSE_CAP_IOMAP_DIRECTIO (1ULL << 33)
 
+/*
+ * Client supports using iomap for pagecache I/O file operations
+ */
+#define FUSE_CAP_IOMAP_PAGECACHE (1ULL << 34)
+
 /**
  * Ioctl flags
  *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index a2c044b5957169..93ecb98a0bc20f 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -235,6 +235,7 @@
  *    SEEK_{DATA,HOLE} support
  *  - add FUSE_NOTIFY_ADD_IOMAP_DEVICE for multi-device filesystems
  *  - add FUSE_IOMAP_DIRECTIO for direct I/O support
+ *  - add FUSE_IOMAP_PAGECACHE for pagecache I/O support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -444,6 +445,7 @@ struct fuse_file_lock {
  * FUSE_IOMAP: Client supports iomap for FIEMAP and SEEK_{DATA,HOLE} file
  *	       operations.
  * FUSE_IOMAP_DIRECTIO: Client supports iomap for direct I/O operations.
+ * FUSE_IOMAP_PAGECACHE: Client supports iomap for pagecache I/O operations.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -493,6 +495,7 @@ struct fuse_file_lock {
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_IOMAP		(1ULL << 43)
 #define FUSE_IOMAP_DIRECTIO	(1ULL << 44)
+#define FUSE_IOMAP_PAGECACHE	(1ULL << 45)
 
 /**
  * CUSE INIT request/reply flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 9d07743fe522c6..fd12daf509cebf 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2639,7 +2639,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_IOMAP;
 		if (inargflags & FUSE_IOMAP_DIRECTIO)
 			se->conn.capable_ext |= FUSE_CAP_IOMAP_DIRECTIO;
-
+		if (inargflags & FUSE_IOMAP_PAGECACHE)
+			se->conn.capable_ext |= FUSE_CAP_IOMAP_PAGECACHE;
 	} else {
 		se->conn.max_readahead = 0;
 	}
@@ -2688,6 +2689,7 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 	/* servers need to opt-in to iomap explicitly */
 	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP);
 	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP_DIRECTIO);
+	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP_PAGECACHE);
 
 	/* This could safely become default, but libfuse needs an API extension
 	 * to support it
@@ -2816,6 +2818,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		outargflags |= FUSE_IOMAP;
 	if (se->conn.want_ext & FUSE_CAP_IOMAP_DIRECTIO)
 		outargflags |= FUSE_IOMAP_DIRECTIO;
+	if (se->conn.want_ext & FUSE_CAP_IOMAP_PAGECACHE)
+		outargflags |= FUSE_IOMAP_PAGECACHE;
 
 	if (inargflags & FUSE_INIT_EXT) {
 		outargflags |= FUSE_INIT_EXT;
@@ -2861,6 +2865,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			fuse_log(FUSE_LOG_DEBUG, "   iomap=1\n");
 		if (se->conn.want_ext & FUSE_CAP_IOMAP_DIRECTIO)
 			fuse_log(FUSE_LOG_DEBUG, "   iomap_directio=1\n");
+		if (se->conn.want_ext & FUSE_CAP_IOMAP_PAGECACHE)
+			fuse_log(FUSE_LOG_DEBUG, "   iomap_pagecache=1\n");
 	}
 	if (arg->minor < 5)
 		outargsize = FUSE_COMPAT_INIT_OUT_SIZE;


