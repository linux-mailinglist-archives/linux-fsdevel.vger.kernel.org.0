Return-Path: <linux-fsdevel+bounces-68962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E9CC6A6C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 370DA355B7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5FD331A40;
	Tue, 18 Nov 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8YIRhFf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B984329E4B
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480984; cv=none; b=Jqc4pRnF7xnRAuv1gGF5qvhVAgl3fD+FYJww9n+tFoIRhGQd8+iBCF9h/SjrmT1DLWzatGaVx3s29SWrfR0IiB/InO9tHcZ55/Hj1jVhJSv6EopeGmSovqhdvKIgaXKUX7dsTdql8Qc5TsLHWoyl0US9P5bWIpYsYf0kaykd23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480984; c=relaxed/simple;
	bh=TzVY8Gpjlj+hwFJoyWHG797ZNSH9ztif0eel0l88nnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hThcMK2HrfY1jyZnzxLdniwAMC6zd6TkCcb0dTPyyjNPNA6qqHEegmjFqz4rSEZoJFPH1fAlH3Hfw+M2wdbEXFgRz3RtkQktfovQKJE82S9+QL4N+isZiZzRWKo3RMOhwqLQ+0kfVU1Rk549uDGm4rg+laY3Gnw/QJJpoUNYAvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8YIRhFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AB8C4CEF5;
	Tue, 18 Nov 2025 15:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763480983;
	bh=TzVY8Gpjlj+hwFJoyWHG797ZNSH9ztif0eel0l88nnU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r8YIRhFfm+VTyzvUY91qaXTsm4uwETrp9eA2QUHv8q+mbFoIu1MT15/LF92CbHwB3
	 6Y8po2cjQAfU/eoL0slTQfJWEGkywnc7kOOHE2XIjEiiiOX0B5aTPOqo2hmAoYFVa7
	 uBFquDohv4CcNGqPV+L1V/vEcVy4dOm4ZiOVEq0y9EjpwrAC/Jqw/ydjqoqkaUJQNj
	 gpk0Wd7apdzXq4Vd217wGJ0Vr1sinHduLfzg3W+WVRCWBDj6RjwAEiqFwjAyDGk9lc
	 RlZ5Zz+y8qf+JwZMJxZ0CmipxpcSXG/S/042cBnCmHhYGR4vs1UUTHfK5oW+ENbpJB
	 HJwuIgMpHhqzA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:43 +0100
Subject: [PATCH DRAFT RFC UNTESTED 03/18] fs: eventfd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-3-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TzVY8Gpjlj+hwFJoyWHG797ZNSH9ztif0eel0l88nnU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO3j8/BMjVrC8+mGQoa03urk/CWxbhpVm7Y+yPqre
 8/nil1vRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQK9jH8sxSJ/SMf82u24bU2
 u6OHdzyL5QrWWGdck23J/v1BoNe6Oob/OUqalz4tfvUmWC7468P06kSOve/yX0fqrti+w30R159
 GHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/eventfd.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index af42b2c7d235..ae672255215d 100644
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
-	}
-	fd_install(fd, file);
-	return fd;
-err:
-	eventfd_free_ctx(ctx);
-	return fd;
+
+	FD_PREPARE(fdprep, flags,
+		   anon_inode_getfile_fmode("[eventfd]", &eventfd_fops, ctx,
+					    flags, FMODE_NOWAIT));
+	if (fd_prepare_failed(fdprep))
+		return fd_prepare_error(fdprep);
+
+	ctx->id = ida_alloc(&eventfd_ida, GFP_KERNEL);
+	retain_and_null_ptr(ctx);
+
+	return fd_publish(fdprep);
 }
 
 SYSCALL_DEFINE2(eventfd2, unsigned int, count, int, flags)

-- 
2.47.3


