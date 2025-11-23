Return-Path: <linux-fsdevel+bounces-69529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CC1C7E3B7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 196D9349740
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FC72248B9;
	Sun, 23 Nov 2025 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxnHRNmg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6A3221FBA
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915629; cv=none; b=iCQ0iuYP3n1wmv1jgJzVO6P3IARk7K/tvHuM2HOklztJxL+JuRabyoM3zqN6WlMTiW1rNs43+TTYVUUP5qMgdLnCnUlbKHBpA/oOdE7l6Kmw098mNBVICcaSChoE0/XNn45M2NOZf577xfawCfqN2UtBlyWpFE7feinoiGqcJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915629; c=relaxed/simple;
	bh=XbTr4TQI9GFd4Rt9fvEdF9Rk05wqJ7gyMaayEeTMpM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BZZKiLu9NuJMdO5kUMmq5GCBa/ULJsvwIoz0Kd6Q1UHlp/A97fETTcXQasoMsMGO5m6wi5/96IhM+6AtsBcSL/LkAsXdfIL/01pGTyk495QXqgvNTPZnYvpONUNl3b2YCGdtN1Hx25Yj8W6Y1rL/ylutQoF5xe/YPbnKSj9mE2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxnHRNmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E910FC116D0;
	Sun, 23 Nov 2025 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915629;
	bh=XbTr4TQI9GFd4Rt9fvEdF9Rk05wqJ7gyMaayEeTMpM4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QxnHRNmgs6iJo6tGtkDB4lTxUJw7am2OSdebSIFWKcgg9x+qhnbS0X+IodvtshRFM
	 oARGNYKpelJUIX+r9Hc5vz93DWNM0m2Sh05pplWCQkC1rOI4Ww0zT8HaGgwCIxILLM
	 Szhv6tomKbl7W7T5pa2PakeKIe9qveagnq4ITD2FssdbJ5cu3JYvnLHMCnJomItFST
	 IzlMkpeHukJYM+a3zb1PSN1XJ9I/cYywabfqSGP2ED7NzXvCKIGBOgiU7MU/oaxrlF
	 wQdtJdItr4xP8wzb+ycQD9REeOWzHUK3oKHevt3/yJxDGACf6VJqgXPZzUDPG1cQux
	 OiVL5YQwgIgPw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:25 +0100
Subject: [PATCH v4 07/47] namespace: convert fsmount() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-7-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3105; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XbTr4TQI9GFd4Rt9fvEdF9Rk05wqJ7gyMaayEeTMpM4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0eGrEh3FtoctPD6T6lu0UmJ6zxdF/heE+ZRrr5bX
 SuTuVe5o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLeTxl+McnfscmbwFuY43nT
 vUj4BGd0uSWXnq0iz6TIWYIGKg+YGf77njm8tr1a880N7ncFExySU5lu9NyTrNghcJ3/49Q7t0x
 5AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 55 +++++++++++++++++++++----------------------------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 0c4024558c13..f118fc318156 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4273,8 +4273,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 {
 	struct mnt_namespace *ns;
 	struct fs_context *fc;
-	struct file *file;
-	struct path newmount;
+	struct path newmount __free(path_put) = {};
 	struct mount *mnt;
 	unsigned int mnt_flags = 0;
 	long ret;
@@ -4312,33 +4311,32 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 
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
 
@@ -4350,38 +4348,27 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
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
+	if (fdf.err) {
 		dissolve_on_fput(newmount.mnt);
-		ret = PTR_ERR(file);
-		goto err_path;
+		return fdf.err;
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


