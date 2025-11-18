Return-Path: <linux-fsdevel+bounces-68965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3448C6A6D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 564064F469C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AF5368288;
	Tue, 18 Nov 2025 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S136V+87"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38016361DB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480990; cv=none; b=W/7LzaG4liX8oYyToV6HEam2aJ6iNiHDH/baBz7w2zElbwsDktjGu++/S7mmBBpU3GXlR6uIaZqK249/XzbmAHkweSBz7KybftQRTBg/4PnoK2mYg7FT5mvY9ck5X2uMNDNysF7qIZ9HkoSDVgEoV0Lwjcp7ptT8b/Ax/JobSqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480990; c=relaxed/simple;
	bh=/5P7Fq2oOHFkqu2L0suzXTBNhWE4ktLnymFTPyDRsWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W79gSq89DClUzkXqfGn5DUHThAeBQjcsrvFtSbzn3Oru/Njel88D5v+yCDMKl4/ISUBhScBY7cGVYK1oCTzEtHkb8mQZeb3EGeTDsaKhepJWxnW8p92IsidmMq772pNyTPW1+2gh3N4HPPZnHt8mFMfHjSoABbu3imvxS42pwcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S136V+87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207E8C19423;
	Tue, 18 Nov 2025 15:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763480989;
	bh=/5P7Fq2oOHFkqu2L0suzXTBNhWE4ktLnymFTPyDRsWg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S136V+87Z6L9X43Z4rtNy4JCaW1VUjF4xi6ZPmjoQlDXd7+5zaksIA32URiA7Uiwu
	 vhFPKc3n8Wx20/HxDP1c0NhOyBiqAcHYDyOB1vKFz8dcSrD9XEAVjrLqrPhJtM0dGM
	 sXQ+jBZgi3HZcbLiJMHMVDb6JHwB8aWGhJ+b7ErKxSoqqjBKL1MaJPW6oVviE+IupT
	 SXhPgfzHiSyg2BVHsVOl5W5Yn2zKE7wpbMLdMhF612s/BXkvafNy1B7aqVqqE2jtTY
	 nNQG67NibwEXK2GsSm+5NC5XZqGf6dxpzsPC82jvBhWQEuuNRrWm8LFTWBbT2vmUdU
	 r064AQLs+qcMQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:46 +0100
Subject: [PATCH DRAFT RFC UNTESTED 06/18] fs: namespace
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-6-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3156; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/5P7Fq2oOHFkqu2L0suzXTBNhWE4ktLnymFTPyDRsWg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO331Qy/evFy1MmLJ233fd5yoGddeu0Z+bLbir/qG
 3Im6Ysf7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIBxsjwwnvhF4L2V9GLOeF
 lQxXLj4St8ZvxU5u/bNHVh3MWcIprcTIcHjOHNU7wbP5Ln05uCxjjsgRzZNciSXP2EPvqra3f6/
 exgoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 54 +++++++++++++++++++++---------------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a6e170d6692d..55921ab2f2d3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4279,7 +4279,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	struct mnt_namespace *ns;
 	struct fs_context *fc;
 	struct file *file;
-	struct path newmount;
+	struct path newmount __free(path_put) = {};
 	struct mount *mnt;
 	unsigned int mnt_flags = 0;
 	long ret;
@@ -4317,33 +4317,32 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 
 	fc = fd_file(f)->private_data;
 
-	ret = mutex_lock_interruptible(&fc->uapi_mutex);
-	if (ret < 0)
+	ACQUIRE(mutex_intr, uapi_mutex)(&fc->uapi_mutex);
+	ret = ACQUIRE_ERR(mutex_intr, &uapi_mutex);
+	if (ret)
 		return ret;
 
 	/* There must be a valid superblock or we can't mount it */
 	ret = -EINVAL;
 	if (!fc->root)
-		goto err_unlock;
+		return ret;
 
 	ret = -EPERM;
 	if (mount_too_revealing(fc->root->d_sb, &mnt_flags)) {
 		errorfcp(fc, "VFS", "Mount too revealing");
-		goto err_unlock;
+		return ret;
 	}
 
 	ret = -EBUSY;
 	if (fc->phase != FS_CONTEXT_AWAITING_MOUNT)
-		goto err_unlock;
+		return ret;
 
 	if (fc->sb_flags & SB_MANDLOCK)
 		warn_mandlock();
 
 	newmount.mnt = vfs_create_mount(fc);
-	if (IS_ERR(newmount.mnt)) {
-		ret = PTR_ERR(newmount.mnt);
-		goto err_unlock;
-	}
+	if (IS_ERR(newmount.mnt))
+		return PTR_ERR(newmount.mnt);
 	newmount.dentry = dget(fc->root);
 	newmount.mnt->mnt_flags = mnt_flags;
 
@@ -4355,38 +4354,27 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	vfs_clean_context(fc);
 
 	ns = alloc_mnt_ns(current->nsproxy->mnt_ns->user_ns, true);
-	if (IS_ERR(ns)) {
-		ret = PTR_ERR(ns);
-		goto err_path;
-	}
+	if (IS_ERR(ns))
+		return PTR_ERR(ns);
 	mnt = real_mount(newmount.mnt);
 	ns->root = mnt;
 	ns->nr_mounts = 1;
 	mnt_add_to_ns(ns, mnt);
 	mntget(newmount.mnt);
 
-	/* Attach to an apparent O_PATH fd with a note that we need to unmount
-	 * it, not just simply put it.
-	 */
-	file = dentry_open(&newmount, O_PATH, fc->cred);
-	if (IS_ERR(file)) {
+	FD_PREPARE(fdprep, (flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0,
+		   dentry_open(&newmount, O_PATH, fc->cred));
+	if (fd_prepare_failed(fdprep)) {
 		dissolve_on_fput(newmount.mnt);
-		ret = PTR_ERR(file);
-		goto err_path;
+		return fd_prepare_error(fdprep);
 	}
-	file->f_mode |= FMODE_NEED_UNMOUNT;
 
-	ret = get_unused_fd_flags((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0);
-	if (ret >= 0)
-		fd_install(ret, file);
-	else
-		fput(file);
-
-err_path:
-	path_put(&newmount);
-err_unlock:
-	mutex_unlock(&fc->uapi_mutex);
-	return ret;
+	/*
+	 * Attach to an apparent O_PATH fd with a note that we
+	 * need to unmount it, not just simply put it.
+	 */
+	file->f_mode |= FMODE_NEED_UNMOUNT;
+	return fd_publish(fdprep);
 }
 
 static inline int vfs_move_mount(const struct path *from_path,

-- 
2.47.3


