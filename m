Return-Path: <linux-fsdevel+bounces-69401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4709EC7B2A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354553A3329
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31673350A27;
	Fri, 21 Nov 2025 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWKN19iN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF46332909
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748058; cv=none; b=fHWhe52Bb5lmh5SK98cgYIk1vPt3OGBOD3bPugEE9lwGDkaD/V4kebv1TKuPeVM1TZQfRshblLhhC6Vc+7r7y1dWBmVxm9TOu/D/eiIOIKiyuD1kjZCZqb0v9jVv13ohe4oiTIWHKHCGmeTlVJD7e93qM70iJ/PIemZWn+5k8dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748058; c=relaxed/simple;
	bh=Gq02EVaxKxmVERyVfDw2edh2EaFVKQX4i58rgHo81vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F9dm7wcJvdfU2J1+Ef99Xknihq/PvgbOo251J/szWFSNN9HKYvOLr1y+ck7sjFx/lotWU/WQm6GMQea9AizfYEQEsMhE+jkOn5paN2pAtsRXLSdeMvDvJ2G25PJSwIwBpbiVCPU30zDCaivClJjcOGYEOS3U0DCC6vtah8eVVSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWKN19iN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF73C16AAE;
	Fri, 21 Nov 2025 18:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748058;
	bh=Gq02EVaxKxmVERyVfDw2edh2EaFVKQX4i58rgHo81vk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iWKN19iNUCUEn9WPbzOOeceSgdxjT5dGqbWEsqR0RWiCo/xGtV/016zEugPWjo6LJ
	 iLnKN7EyBRQtllmnGJyeiYzxNFkgw+YM3uXgITf9KVITZYyF571DrSe+1pTt1OUkVw
	 0NfkRn2mDS6B8BvQNkLzeCcfdOG9wAT/torGTvrHnGwiXVxgt4ndc71cKyVGmOsABB
	 VXC4US0kpS2k32niWYWMhJzelPhkdquZYzI6VDXgGpTJz2NJwrhw2KcEV29Ip9IuAw
	 yP4Jeimr4XQ4J9qHtYFyM6FAZsJwq18bygLOd9F5VjnAL3z9/2+q10UNbV/EKoxR3K
	 5tsjym1KVO/bQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:42 +0100
Subject: [PATCH RFC v3 03/47] eventfd: convert do_eventfd() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-3-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Gq02EVaxKxmVERyVfDw2edh2EaFVKQX4i58rgHo81vk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDgvcshNusuuy0pph8BG8Sk7XLfHayxcwtlxX1r2d
 tPq7Y1WHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPhVGL4zdIdynbgofLp34ef
 pwvH3vPffJfl0bO0N2umvbpg0cJyMYWRYeLXfcneem3rV35in6vTkitkIrjUrPWNtKtXA6OsQmc
 8FwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/eventfd.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index af42b2c7d235..089eff8894ea 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -378,9 +378,8 @@ EXPORT_SYMBOL_GPL(eventfd_ctx_fileget);
 
 static int do_eventfd(unsigned int count, int flags)
 {
-	struct eventfd_ctx *ctx;
-	struct file *file;
-	int fd;
+	struct eventfd_ctx *ctx __free(kfree) = NULL;
+	int err;
 
 	/* Check the EFD_* constants for consistency.  */
 	BUILD_BUG_ON(EFD_CLOEXEC != O_CLOEXEC);
@@ -398,26 +397,20 @@ static int do_eventfd(unsigned int count, int flags)
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
+	err = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (err)
+		return err;
+
+	ctx->id = ida_alloc(&eventfd_ida, GFP_KERNEL);
+	retain_and_null_ptr(ctx);
+	return fd_publish(fdf);
 }
 
 SYSCALL_DEFINE2(eventfd2, unsigned int, count, int, flags)

-- 
2.47.3


