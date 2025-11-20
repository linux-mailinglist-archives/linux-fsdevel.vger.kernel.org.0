Return-Path: <linux-fsdevel+bounces-69282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED3EC7680A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A79C94E2ECD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC9C3002BD;
	Thu, 20 Nov 2025 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1Oiv6ms"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291327B349
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677944; cv=none; b=XPDlvFPQ2hGp7jQOAGApAi13QJ2Hh+R3ighm3FYqBg+MXpme/bvVQr7qCxTUPHjzr+22IoGwl+IklZf5lxOMLwayTZ0SC2swkcxyadjvqJmYQtMPHce9kcIJaa5dZ4MwQZpjZW5jIU9h3Lld3s6NwVCZGSPb3/ZI/9Gx73wkIMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677944; c=relaxed/simple;
	bh=rTy18poQ4dWWDkqgD5qL89lPAJjxfrPnj6sCQLIIEkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gw136S1CDZuQHrzV/Objh+NlEga2Y19qeuCqSbShONPrQktNh0dBstC8EPBS0qLGJgVhtxKdz2sfTLzfIKVkUDc07+h0KONoW4ZC6eMdFB/WKt+08tceMSHX/P86UsKAbxYSMG5Pq7kvhJeST5jckIOcpfyMejv0VuaCd0+mRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1Oiv6ms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18441C4AF09;
	Thu, 20 Nov 2025 22:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677943;
	bh=rTy18poQ4dWWDkqgD5qL89lPAJjxfrPnj6sCQLIIEkw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L1Oiv6msNBqDUwsQKzoiTQcx0SkSimJikusvXKMB1sxr+6L2cEP6XebPcPb2/+4yv
	 AOoOPlgaZMhbOV8/x4QX35fvqk5FtAmW/Ue7lhkAScl5jv7FdNElKGVnDeQnClzC4Z
	 hEGLD7ET5MDYpMYCkouXukVODBTRe7EsP1p4B77EOdYqRJxltQI8g3EuPW2yjixEh+
	 ej5GDZsfj7xlY5fWUN92OmmqyD8GHhNljP6V8Os617x2J03Zhz4l0EROPhmAbv0I9N
	 wC8PFqBYJ1oMMchkqdqpiyv4xavSAy+bacOhM3RYGQjy37dCWB3eP+1SHsO4o67TGm
	 qVueNwGteA/bw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:00 +0100
Subject: [PATCH RFC v2 03/48] eventfd: convert do_eventfd() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-3-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1611; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rTy18poQ4dWWDkqgD5qL89lPAJjxfrPnj6sCQLIIEkw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3sj4bdYzftQ8P+8S3kRCbXt2eL/dolo8V7fr9/fd
 DfIbKN8RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESevGX4p7rhIfv3nPpeiSnL
 lodfOpyS3/PuePJfvusVFWVfn+1pDGJkWMMRyWQ+wSdRwcpIXZHPltn01aukf58P3xX8x5zryOH
 FCAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/eventfd.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index af42b2c7d235..9df390447c3b 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -378,9 +378,7 @@ EXPORT_SYMBOL_GPL(eventfd_ctx_fileget);
 
 static int do_eventfd(unsigned int count, int flags)
 {
-	struct eventfd_ctx *ctx;
-	struct file *file;
-	int fd;
+	struct eventfd_ctx *ctx __free(kfree) = NULL;
 
 	/* Check the EFD_* constants for consistency.  */
 	BUILD_BUG_ON(EFD_CLOEXEC != O_CLOEXEC);
@@ -398,26 +396,20 @@ static int do_eventfd(unsigned int count, int flags)
 	init_waitqueue_head(&ctx->wqh);
 	ctx->count = count;
 	ctx->flags = flags;
-	ctx->id = ida_alloc(&eventfd_ida, GFP_KERNEL);
 
 	flags &= EFD_SHARED_FCNTL_FLAGS;
 	flags |= O_RDWR;
-	fd = get_unused_fd_flags(flags);
-	if (fd < 0)
-		goto err;
-
-	file = anon_inode_getfile_fmode("[eventfd]", &eventfd_fops,
-					ctx, flags, FMODE_NOWAIT);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		fd = PTR_ERR(file);
-		goto err;
+
+	FD_PREPARE(fdf, flags, anon_inode_getfile_fmode("[eventfd]", &eventfd_fops, ctx,
+							flags, FMODE_NOWAIT)) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
+
+		ctx->id = ida_alloc(&eventfd_ida, GFP_KERNEL);
+		retain_and_null_ptr(ctx);
+
+		return fd_publish(fdf);
 	}
-	fd_install(fd, file);
-	return fd;
-err:
-	eventfd_free_ctx(ctx);
-	return fd;
 }
 
 SYSCALL_DEFINE2(eventfd2, unsigned int, count, int, flags)

-- 
2.47.3


