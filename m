Return-Path: <linux-fsdevel+bounces-69286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF76C76819
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 635B44E2716
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95712305065;
	Thu, 20 Nov 2025 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmtC+9bk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26B12E8DE2
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677952; cv=none; b=Uq6B+B3IIH1F/YPwc8vT8Uef0MwMPkZoFhaDX6wydUobe7YelKrCaoO+yqAGSYUDTlA6fFjoHd0olLxGTMveobrRDyW8XNA0aSFkNe11MCIMNOYuK4lFYkaS0ZJMZrSM5GguyMaK2ayQbRGbygGDBhnwj533mLwnheBiVg2NiJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677952; c=relaxed/simple;
	bh=Lo4B7xARKO9IZoWOl6AuESZBEJ7tNYBsvPnMfnwpOlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PY5dtct5fw8TYuCpn9qAGbPHR5av+2ab99whmPHnBZRUnE0eo9hRg6YJ+Juq0SwC4ijtX9Kcry2sK2UMyPKz6NnhwF6iRdnZosRl/yDalL0Ep42rXcABNRio/az72UxVkOBWq6Hoyh/L81adt395LfuBt/2lGL8TChe1eWMuz7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmtC+9bk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43699C113D0;
	Thu, 20 Nov 2025 22:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677951;
	bh=Lo4B7xARKO9IZoWOl6AuESZBEJ7tNYBsvPnMfnwpOlU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZmtC+9bkagd9oG2Otf6ZuGgZnJ5r/we6ILtyrNNO7/9DrCegT4qaWLp/UgzSNQ0fc
	 ovD4bniO7+4eaC8gBmXwUcTvSeM0krpYbl2v/GtcLPFltWAsr7LMYAXrKvAwwr1yVQ
	 1YRt+WgHFQ+R8v92KxwfycwD+pJeChCbFr63JmRzvtK0gGAQnd9r17wvG804R2E+rZ
	 NEu5wGl9Zc1D+0B9oFgLdOTnm/FGu4q6lqUPsbqaEpNDwG61qE/znyxYet0wR24hnF
	 6BPei0eWr0qwJgwY6lp5kCWuJY94M6PQut+Mgirr2Ark5QvTdRKdZjcBiAfvJ5LD+J
	 DjMqVEQWMJ7FQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:04 +0100
Subject: [PATCH RFC v2 07/48] namespace: convert fsmount() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-7-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3194; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Lo4B7xARKO9IZoWOl6AuESZBEJ7tNYBsvPnMfnwpOlU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vjlfBys8OJDyuePLe56fx6kdfkM8ssbGy4vPemL
 wzZrtD5vaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiO7oZ/oeyT9t4SW+jn87h
 vqWMTRvq9ykovPi6MLnh+fbLq9Y+v8fM8L+qRWBS8bZrNcHmN7MfRgvKGDE3Fv3l6OH5cmrhgn8
 mITwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 60 +++++++++++++++++++++++-----------------------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2be135c8de05..03e991df1603 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4278,8 +4278,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 {
 	struct mnt_namespace *ns;
 	struct fs_context *fc;
-	struct file *file;
-	struct path newmount;
+	struct path newmount __free(path_put) = {};
 	struct mount *mnt;
 	unsigned int mnt_flags = 0;
 	long ret;
@@ -4317,33 +4316,32 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 
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
 
@@ -4355,38 +4353,28 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
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
-		dissolve_on_fput(newmount.mnt);
-		ret = PTR_ERR(file);
-		goto err_path;
-	}
-	file->f_mode |= FMODE_NEED_UNMOUNT;
-
-	ret = get_unused_fd_flags((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0);
-	if (ret >= 0)
-		fd_install(ret, file);
-	else
-		fput(file);
+	FD_PREPARE(fdf, (flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0,
+		   dentry_open(&newmount, O_PATH, fc->cred)) {
+		if (fd_prepare_failed(fdf)) {
+			dissolve_on_fput(newmount.mnt);
+			return fd_prepare_error(fdf);
+		}
 
-err_path:
-	path_put(&newmount);
-err_unlock:
-	mutex_unlock(&fc->uapi_mutex);
-	return ret;
+		/*
+		 * Attach to an apparent O_PATH fd with a note that we
+		 * need to unmount it, not just simply put it.
+		 */
+		fd_prepare_file(fdf)->f_mode |= FMODE_NEED_UNMOUNT;
+		return fd_publish(fdf);
+	}
 }
 
 static inline int vfs_move_mount(const struct path *from_path,

-- 
2.47.3


