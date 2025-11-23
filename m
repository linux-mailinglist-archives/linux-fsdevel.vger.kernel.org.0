Return-Path: <linux-fsdevel+bounces-69525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D845C7E3A2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B4AC4E2641
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85C729A33E;
	Sun, 23 Nov 2025 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZXEwnrA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA6222FDFF
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915620; cv=none; b=kONonYKQQ84stVW41I8ZzjG++0XR6CGwS50R3J0HNh1YOTG2yAwrWr4aNUgGueQDvSvhSxmKaslz8++RWbJdgnU7O//47/v8LP3xenHQxBfdHHhKF7KRaf90tFU2NDFt4tSUMHM3uQkAPyqqhjuPoc+/wQV0W47qs61Wr5ZagWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915620; c=relaxed/simple;
	bh=fa4SLxzPh5q2b6zamwg4HZAeOChhZWvGgyzCdoX7XjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MKn0p9C/++XiHCEIjzeMmodT9nFYd8g1MPvgdappByF5jwX9JiA+P7tQD+1c0Ljov4aY0JNGrVg/fV5XJeL6Pp4OCjEPKsTHY2+BqsKYQ+qdJiGaxmjuN2RctYAvCEP2i911AuI37X4LlXMG/NoELiellwrde6RUkP0whA+dJNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZXEwnrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C02C116D0;
	Sun, 23 Nov 2025 16:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915620;
	bh=fa4SLxzPh5q2b6zamwg4HZAeOChhZWvGgyzCdoX7XjU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XZXEwnrAvmcKwia+2Ax/YHD5av16rv9mBEVti0cG4UpySzRrbvgHJc+GMHzAFh7FP
	 9i1VjSU/8aE0SUi2RdoETolT9LFP1R5eFOD5pE+b+aFTuCDSAzah3i5CYgypUAUrhf
	 Rr5bLuA6Q7MzHlHcUvSCMa7Sa7cyLHf9IP89MaBN+0bCMD5eSZ9QY3X3IC3QN290EC
	 XjMqAcosR0pXUAI6VB8O6C4+L/G52nAwaL1AW955zjTmZ7y6jPJQBjRaGJHWKBtbiJ
	 pBiy+fJNdr7WAFKcku8/nAv7sdnvwN01gdy2dQ1SyP70uBzeW/kh2fyx788m7L/JZG
	 JwiGG4MkyFZhw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:21 +0100
Subject: [PATCH v4 03/47] eventfd: convert do_eventfd() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-3-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1583; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fa4SLxzPh5q2b6zamwg4HZAeOChhZWvGgyzCdoX7XjU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0ecvvSEf87XysOrrq7ek6l+2yth5s/e3hvTxDkN+
 xvnzZ1yuKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiCtKMDN2qS5/fDZWZFLPw
 Z9Olz/8s3jMt/l7iEfOeZZLX2d0qOzUZGU7fux/eF7EoIe5P5uwt77LPs39VO2+10367WPeFxrz
 /BswA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/eventfd.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index af42b2c7d235..3219e0d596fe 100644
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
@@ -398,26 +396,19 @@ static int do_eventfd(unsigned int count, int flags)
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
-	}
-	fd_install(fd, file);
-	return fd;
-err:
-	eventfd_free_ctx(ctx);
-	return fd;
+
+	FD_PREPARE(fdf, flags,
+		   anon_inode_getfile_fmode("[eventfd]", &eventfd_fops, ctx,
+					    flags, FMODE_NOWAIT));
+	if (fdf.err)
+		return fdf.err;
+
+	ctx->id = ida_alloc(&eventfd_ida, GFP_KERNEL);
+	retain_and_null_ptr(ctx);
+	return fd_publish(fdf);
 }
 
 SYSCALL_DEFINE2(eventfd2, unsigned int, count, int, flags)

-- 
2.47.3


