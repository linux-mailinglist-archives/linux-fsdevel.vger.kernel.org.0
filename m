Return-Path: <linux-fsdevel+bounces-69405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A723C7B319
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4B1B380D8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B038350D5F;
	Fri, 21 Nov 2025 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N617H6w4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F4827FB34
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748066; cv=none; b=GvuFT00exM0ZvPhcXL1BmY/uJvs6SlkqLct2+USNU6XWPb/24gpCwQg5E7FJ/LDM0Kay+rPJAuJXN6s/CVIusi5locoRPa3LEZT/0KBmrET1dOnOGIT4mx0w9C4PEekRUhNFIn3/ytBNfS86ch7iBuikCJinSa+0zr5c9qRAd/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748066; c=relaxed/simple;
	bh=+33SZYvCf+KbLd53CQiUAkrprkqBsOZBJo73gXJoZfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rl0iA0DFvxHLpuMKwAmviO04T5uf4MgVkkAqfDruVFMT4Ujlutzi///Fq1xpGadPymsPurUMGVneQPq+kAu9izRCXnqo1y6PzjpXqc93DoWueX55Wf2AFAPgzbUe94z/fdcx9D3UYkNPDoKe/H+ek5532KjSzveTUKOCL/c0Q7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N617H6w4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7EDC19422;
	Fri, 21 Nov 2025 18:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748066;
	bh=+33SZYvCf+KbLd53CQiUAkrprkqBsOZBJo73gXJoZfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N617H6w4XqkFX1HbT/w5hhxWhxTj4D8LhR4J4uYm3G51+PuzmzfLeNO3A+1Uo3Nf0
	 5vHCGSQu1vTMxoK4gXNWHhVNCKj6kiuduGR6yj/V3dD3NXxJ1JqarE1wNIGa8NwGiA
	 fdBP5O3gOlkDUR4A2R+YMQQrWr/Ur5kVcyOCeabrN8q3kRGOUCJLF/cRg+zitcJ+MS
	 So0HFQKxFQ35LnDGcitOmKuQ9RRyA09z9crvggaqc+CV1ufLHE0mHtTu9Ww5yM6MKA
	 r2RKx14ExVvxc/wfx8zS65eGpI6z+m8sbF/3b1SYllczUEi7wYTiB56yyElVVWie/L
	 Yg7f5gPMWFitQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:46 +0100
Subject: [PATCH RFC v3 07/47] namespace: convert fsmount() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-7-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3138; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+33SZYvCf+KbLd53CQiUAkrprkqBsOZBJo73gXJoZfY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDgfLseyx+HePaa9XLN1Or51mtrrfVPjZt7fZWfM9
 Hlr9gGrjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImYyzH8d1fR/mNxr7FZWzJQ
 3/C1EZdOSosUz/5Tyoumd/KfY37wiuGvWPFLj2vdXmzz3Nl6VAJfHLvIsvXy+y6V55Ib9K/t13D
 lAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 56 ++++++++++++++++++++++----------------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 74157dd471ee..8716aedada2c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4280,8 +4280,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 {
 	struct mnt_namespace *ns;
 	struct fs_context *fc;
-	struct file *file;
-	struct path newmount;
+	struct path newmount __free(path_put) = {};
 	struct mount *mnt;
 	unsigned int mnt_flags = 0;
 	long ret;
@@ -4319,33 +4318,32 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 
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
 
@@ -4357,38 +4355,28 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
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
+	FD_PREPARE(fdf, (flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0,
+		   dentry_open(&newmount, O_PATH, fc->cred));
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret) {
 		dissolve_on_fput(newmount.mnt);
-		ret = PTR_ERR(file);
-		goto err_path;
+		return ret;
 	}
-	file->f_mode |= FMODE_NEED_UNMOUNT;
-
-	ret = get_unused_fd_flags((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0);
-	if (ret >= 0)
-		fd_install(ret, file);
-	else
-		fput(file);
 
-err_path:
-	path_put(&newmount);
-err_unlock:
-	mutex_unlock(&fc->uapi_mutex);
-	return ret;
+	/*
+	 * Attach to an apparent O_PATH fd with a note that we
+	 * need to unmount it, not just simply put it.
+	 */
+	fd_prepare_file(fdf)->f_mode |= FMODE_NEED_UNMOUNT;
+	return fd_publish(fdf);
 }
 
 static inline int vfs_move_mount(const struct path *from_path,

-- 
2.47.3


