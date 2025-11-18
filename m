Return-Path: <linux-fsdevel+bounces-68975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 132DCC6A71F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32D6C4F6A34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2C336828B;
	Tue, 18 Nov 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBz9OKGo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A673433E37D
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481010; cv=none; b=k5rwyPDtijdige1Qos3J8MuLCxVLGHPVvy/0LuMqoC21CfTGa+xH8y1wjJISRk/3t3EWxTwDTiXR0USr5n5LLfoMjhpYFtxTScOkoa1PTHlrlH4C1QyL9YZJm3erqJJxFv19EK4TGiO2zrnWQz2scMYGWU0JcQAcjqmV/Bm7RlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481010; c=relaxed/simple;
	bh=I7h9T64gaHheuh30/P9JJqAq11eWmCk8+OVh7JKGy7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=diWbaQm1a4acY538Ly8BLeIV5/z0kBKF4QO2iRio1xXRUvIxW4QtVwqgaVR0eeU5yvG6naZDieDe6oe8hlgczF3QokzBxdJunMhfTO0tTOU3e9cg9L8OVmyLsp6eY1n4cbsipeQ0OU/JZ+iuB6+hpDoJsZ1v8+AstEUg2KFLYz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBz9OKGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C876C2BCB5;
	Tue, 18 Nov 2025 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763481010;
	bh=I7h9T64gaHheuh30/P9JJqAq11eWmCk8+OVh7JKGy7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XBz9OKGoYTjrO7oGYoVgCs9eWXskmdzXfTUsGjDay9IsaBtPEShY0lwbHZesYGQ4Q
	 yRCDNnSsimbOhy2+cOwZ20TH7IIx5wAHS9NfBHvxLtHzMpzPyj2BcXC7jLvo8Q9qKR
	 3S7BtrqQ32LFPscEidq2VkVi13DJ6AtNJLLKo746NE5wsoqJBHMj8VO9+HpM55Vlyk
	 Vau6VovO72z9ZBbbEsSVQ8S0mnI5GlGlfKe+w64odjbalUIBT1gbwRcxVnmfaVxJ8l
	 Agez3MOyGQP8YjCkG33+5y2WFZNm8RCLwHS+tAI1wIGft6K/4gNhHbUD32Af2B2X45
	 G5ga9ibKdwf+A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:56 +0100
Subject: [PATCH DRAFT RFC UNTESTED 16/18] fs: userfaultfd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-16-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1808; i=brauner@kernel.org;
 h=from:subject:message-id; bh=I7h9T64gaHheuh30/P9JJqAq11eWmCk8+OVh7JKGy7M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO1/uui7S+w9S08N6ZlOebk3ir7aph44f/xmdPRcq
 wQ/Nd8lHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNhCGJkONUi0tCYxXxDZcX3
 wE/CsqcYTobM9eG42idUs/i1yfTuEwx/uNw8NJ1mnS+Lm65sWT2Zudzhopxeyvnm3cfLd7Arsqx
 jAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/userfaultfd.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 54c6cc7fe9c6..77048b86d781 100644
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
 
@@ -2135,26 +2133,17 @@ static int new_userfaultfd(int flags)
 	atomic_set(&ctx->mmap_changing, 0);
 	ctx->mm = current->mm;
 
-	fd = get_unused_fd_flags(flags & UFFD_SHARED_FCNTL_FLAGS);
-	if (fd < 0)
-		goto err_out;
+	FD_PREPARE(fdprep, flags & UFFD_SHARED_FCNTL_FLAGS,
+		   anon_inode_create_getfile("[userfaultfd]", &userfaultfd_fops, ctx,
+					     O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL));
+	if (fd_prepare_failed(fdprep))
+		return fd_prepare_error(fdprep);
 
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
+	fd_prepare_file(fdprep)->f_mode |= FMODE_NOWAIT;
+	retain_and_null_ptr(ctx);
+	return fd_publish(fdprep);
 }
 
 static inline bool userfaultfd_syscall_allowed(int flags)

-- 
2.47.3


