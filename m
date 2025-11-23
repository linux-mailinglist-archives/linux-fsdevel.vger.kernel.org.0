Return-Path: <linux-fsdevel+bounces-69538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07457C7E3C3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B08D24E2B49
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE02231A41;
	Sun, 23 Nov 2025 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFZw7o0f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE628D8CC
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915649; cv=none; b=pZ2DqwnMkDkyQ+2yv6lDNhC3dncJUsnkV0drLNqpjrv6xu5MtvCXU9s09wBQD3vKJfOyMLVnrrruYtglTk1E6q3VWipxylXIYhZUykhqjPc9xCsTOjgMdsr/OMC0u11izxCixXuZWibDHcoerohT4yjYBiSw81A3mPbXof2ZvnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915649; c=relaxed/simple;
	bh=bA1Y7b3nzmkfFKUiaSzwAO74GA8FGlnB2tHcjR3IITY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eolePOONibQ6JXi4FZIlTqI1vD6vQiAUXvCIDHJqa6eQ4RJmeMMrDwXV2Q26OQ6k8TwYFKVtyfLAA4evuVu5ehsetdVXD5aD/C6agOG9wti4SBHNPkdfH/lIQGSHP1xAG7D8FdjgPs/VHjnVuEgIif/POFGbBR3FPl/jLdgQZEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFZw7o0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA6AC116D0;
	Sun, 23 Nov 2025 16:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915649;
	bh=bA1Y7b3nzmkfFKUiaSzwAO74GA8FGlnB2tHcjR3IITY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vFZw7o0fsgd6vFUHdqO0QkjCzmMrXKd10ytg/UcTPmZ6lgqGAS2bcHbUjpTIOj/g3
	 9YZ6w2CS46lYm2IasMxXilSHocs3hy4a+BLnhkDw2JlLYlkyP84ksXJlGT9oeLdzFh
	 9X0t2NTlBgTJ/wJM5aEm2uLCkWK2f0yv46gS/8p5XBpNyvF58pByydhLyBNSMNAmxu
	 uELrqw/f0w+z/AQg+pZR0OR4KtKxt5oiS/H0l3SbnOu0dS3nQenN4+Zjd4qCpVQnrK
	 osTyXCIspDYfVshzwIYsqohIkMXyM0z8pRdFlyCk3X/+Tt5vISCEFtbM5cBPfd+5ZE
	 BgubYQNWix3hQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:34 +0100
Subject: [PATCH v4 16/47] userfaultfd: convert new_userfaultfd() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-16-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bA1Y7b3nzmkfFKUiaSzwAO74GA8FGlnB2tHcjR3IITY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0eem7pmf5D3o/bFRuVtK2Ra+48/LN+3ce0JyaVLj
 168VqT7tKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi73YwMvQIf7ZJtgr9JCAQ
 l9a7Szek5kt6uuzFWT2vpjD+9MwOY2P479XqnJikouzBLbbVX7R/bdB9Wak7tu8ucAc/klqW4lz
 BCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/userfaultfd.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 54c6cc7fe9c6..e6e74b384087 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2111,9 +2111,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 
 static int new_userfaultfd(int flags)
 {
-	struct userfaultfd_ctx *ctx;
-	struct file *file;
-	int fd;
+	struct userfaultfd_ctx *ctx __free(kfree) = NULL;
 
 	VM_WARN_ON_ONCE(!current->mm);
 
@@ -2135,26 +2133,18 @@ static int new_userfaultfd(int flags)
 	atomic_set(&ctx->mmap_changing, 0);
 	ctx->mm = current->mm;
 
-	fd = get_unused_fd_flags(flags & UFFD_SHARED_FCNTL_FLAGS);
-	if (fd < 0)
-		goto err_out;
+	FD_PREPARE(fdf, flags & UFFD_SHARED_FCNTL_FLAGS,
+		   anon_inode_create_getfile("[userfaultfd]", &userfaultfd_fops, ctx,
+					     O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS),
+					     NULL));
+	if (fdf.err)
+		return fdf.err;
 
-	/* Create a new inode so that the LSM can block the creation.  */
-	file = anon_inode_create_getfile("[userfaultfd]", &userfaultfd_fops, ctx,
-			O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		fd = PTR_ERR(file);
-		goto err_out;
-	}
 	/* prevent the mm struct to be freed */
 	mmgrab(ctx->mm);
-	file->f_mode |= FMODE_NOWAIT;
-	fd_install(fd, file);
-	return fd;
-err_out:
-	kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-	return fd;
+	fd_prepare_file(fdf)->f_mode |= FMODE_NOWAIT;
+	retain_and_null_ptr(ctx);
+	return fd_publish(fdf);
 }
 
 static inline bool userfaultfd_syscall_allowed(int flags)

-- 
2.47.3


