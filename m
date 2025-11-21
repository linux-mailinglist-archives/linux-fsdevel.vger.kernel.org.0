Return-Path: <linux-fsdevel+bounces-69414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A3FC7B2BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BE23A4083
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ED5351FCE;
	Fri, 21 Nov 2025 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0giy5R3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C24238159
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748086; cv=none; b=CbCYDig5pJLVyxCTjJn5b31QeH8sF0c7QvNDAXSbcjm7kB50rz9fTuzyQVqiBUFP4Hy/rGr7Zwp4gX3db/ZlpOA6LnmGZDAEhGmuYnz/z6ZRlE2s3TU4whRTIYIQjsmDNAUEnq7AD6Yu3FnVXZqL6v21Ubj5gKyRi459mOyyO98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748086; c=relaxed/simple;
	bh=7u8LvFB0x0JeGQMkpimDJgmyXP7RHSsDTIgn3lrCRGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZh7Wxcfo+ILsg1dUPw6UI8V1hMlSS51ffFbTSBoUvOXP9GY22RX0iDaBokdlBRfsTDQEkR40AguEjdvzjhzAwio84lQ3vhqfBJIAH5a0Q9n8rUOXsKRWx5O4oEc1ZqO4l9xZhw9u99h4bOd0c46IZCJePcjXyM36x2hu7xKJr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0giy5R3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1253C4CEF1;
	Fri, 21 Nov 2025 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748085;
	bh=7u8LvFB0x0JeGQMkpimDJgmyXP7RHSsDTIgn3lrCRGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R0giy5R3Euu/b0dy0/RHITLytAbLNKS1pc9LFGHIKFEWmLNBiJRZmG7wXvmzLqZOU
	 WlIOEWrvy8gDk3ksfhkmBo8c6j20ssMI1joQMaUBDmW6ykvPfPjBr4CGIanZZM0fD3
	 SyhPLBI6PIxWvzfTVbjSQxTI4EMbJEJlWrkJaSOdDr0MpEpCO3MU9H+wNSPIW9jpyD
	 95A8SD7LCChzfQJWYBYT+BPxVycEUZWdYFBMs0qvkU98x1/oWv5g1aaKLGm4JqDPYt
	 qAwBHXEbiIpP6oF4vq+zgW0UErL0j8NIhhE5i0wEXa0nN3kL6YvcrVHxEEO79VR302
	 wNiEhT3MVUl8w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:55 +0100
Subject: [PATCH RFC v3 16/47] userfaultfd: convert new_userfaultfd() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-16-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7u8LvFB0x0JeGQMkpimDJgmyXP7RHSsDTIgn3lrCRGM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDjP6byvtD3rxtbj75fzGS6Rt0zq//PihePf9W6Rz
 I5sx09Wd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE/yQjw654+w/5C30nfPog
 X+Q8/+Jr5T0/a9qnv1Kfc+13xm9D4yUMf7g1paacr95X8lW1+fCJFdJG3IJ9c0RXvtoi/ODkzZe
 8M9gB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/userfaultfd.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 54c6cc7fe9c6..6388a525cdb1 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2111,9 +2111,8 @@ static void init_once_userfaultfd_ctx(void *mem)
 
 static int new_userfaultfd(int flags)
 {
-	struct userfaultfd_ctx *ctx;
-	struct file *file;
-	int fd;
+	int ret;
+	struct userfaultfd_ctx *ctx __free(kfree) = NULL;
 
 	VM_WARN_ON_ONCE(!current->mm);
 
@@ -2135,26 +2134,19 @@ static int new_userfaultfd(int flags)
 	atomic_set(&ctx->mmap_changing, 0);
 	ctx->mm = current->mm;
 
-	fd = get_unused_fd_flags(flags & UFFD_SHARED_FCNTL_FLAGS);
-	if (fd < 0)
-		goto err_out;
+	FD_PREPARE(fdf, flags & UFFD_SHARED_FCNTL_FLAGS,
+		   anon_inode_create_getfile("[userfaultfd]", &userfaultfd_fops, ctx,
+					     O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS),
+					     NULL));
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret)
+		return ret;
 
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


