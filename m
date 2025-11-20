Return-Path: <linux-fsdevel+bounces-69295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 13941C7683A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D510334E333
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E9331B10F;
	Thu, 20 Nov 2025 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGePl1Jk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930582FF660
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677970; cv=none; b=IajKtY2HDaQ+u0+q1eTeUozrjvJovon6uO3a01Qbq9ODf34RplRfI8iXI/h38+ic93nHTk+mubZupXvhneNzyhfe7Ze0TFSRreEooW6YdMUZdpl5p0SaxPdGeRCaGLiZRhEhZ4Q+jWqkny2uhu3fsXrtHhLrLM9NlU7cViWLDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677970; c=relaxed/simple;
	bh=O+EXhlRETzrI8VkgUdKtMXFB9wTX0BkWwxsZh4wxqlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IuyH0KgIXBW/4lj/8fq9GbMcZPok3/0GIPX0uREpk1iuLNvHEUQV1pL2alauN8+8Mkb6lNWk+WTGoh9mdtjgiwYWtA1f6vuszztTNpgr5jrrNgY9Z1soBoJzBiAGosa+QqBirStYg0bqa5fEvzG5S9UR3bYYmBPcWMtYBBONRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGePl1Jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DA6C113D0;
	Thu, 20 Nov 2025 22:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677970;
	bh=O+EXhlRETzrI8VkgUdKtMXFB9wTX0BkWwxsZh4wxqlY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WGePl1Jkmu19I/VtJy51Q1Hzx/OnD5QYcfnmb6pzJdabIHXwCcK9IvFjzPl5ajhCl
	 aZlQ1SNpFBq3k9KbnbfENI2F6qbYtFsD5yOKOUUFnffQQCUQckLTdSOd/yTfNoUqik
	 wnmcr5fuMYnHP1qmzoWVs817kRfkXXF8mJuOmxHUlMHdPdNjb+vaStx/OXvxCmeDcU
	 BFEckRUtRzu0hupjhHCnP0AU+suroQEtW3EvKbTQaAFNyn6oihpvj28/B2PyXK42+H
	 w5yFVljVcsgq/kX+2wbaR1KcPFTLfwOWoIfwaTrnYSYYDf+y0BPNaIRVlzYa6NtpFB
	 nWdedY1YwqvLA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:13 +0100
Subject: [PATCH RFC v2 16/48] userfaultfd: convert new_userfaultfd() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-16-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=brauner@kernel.org;
 h=from:subject:message-id; bh=O+EXhlRETzrI8VkgUdKtMXFB9wTX0BkWwxsZh4wxqlY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3tb0K0qxbDGWrFBsGaz3KsuJp/5us+nSpRMsdgVF
 FegLF/TUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHiGQz/q7f8DgxxaLm88dTW
 RYWcswwUhK7cmhKy96nXl4KWR41OKxgZFq6/8/HrLKnrh2yk7y+6ZqtQEP80eNL1f1md7dOWrru
 /mQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/userfaultfd.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 54c6cc7fe9c6..14f98caeae8e 100644
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
+					     O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL)) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	/* Create a new inode so that the LSM can block the creation.  */
-	file = anon_inode_create_getfile("[userfaultfd]", &userfaultfd_fops, ctx,
-			O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		fd = PTR_ERR(file);
-		goto err_out;
+		/* prevent the mm struct to be freed */
+		mmgrab(ctx->mm);
+		fd_prepare_file(fdf)->f_mode |= FMODE_NOWAIT;
+		retain_and_null_ptr(ctx);
+		return fd_publish(fdf);
 	}
-	/* prevent the mm struct to be freed */
-	mmgrab(ctx->mm);
-	file->f_mode |= FMODE_NOWAIT;
-	fd_install(fd, file);
-	return fd;
-err_out:
-	kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-	return fd;
 }
 
 static inline bool userfaultfd_syscall_allowed(int flags)

-- 
2.47.3


