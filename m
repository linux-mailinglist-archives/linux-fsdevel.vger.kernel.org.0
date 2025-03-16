Return-Path: <linux-fsdevel+bounces-44144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6223AA635AB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 13:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E900188EE9C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 12:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2851A83E8;
	Sun, 16 Mar 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M17U5ERM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C14E1A5BB2
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Mar 2025 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742129359; cv=none; b=Ru1S8X9BXdfYmDIfHIUrMFe4p8TsRZ6NvOh0nKcL/WtDqI8X//7gOJtBvn7oTjUE5apRHwCkct+lHLH0tV0hFaOV1oYYv+0DnKmek7J+r7Nf78pRk9Lh/J84OhAOOF1cRQRTeI1+pxizsFCfrJiMMUXHxfwqYTA4dqbqKndVixQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742129359; c=relaxed/simple;
	bh=gYGNBY+d4J2eTwFtOpFvwnowHkLW5Z0a1XFfZs4JGwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gaBC4XEMRdNtyKYdUe2/xCbjQ4rOxzn+xZmg6hUnVCA3YXOu/3NaflATl1DEDVfh9iiK8msW/Nz6ncerEQ6SheYG2WipwJY3Mzi3xBn0H8Df/p8H4GYWQ9vHaa2LNCim/Gn4el9KfAW2P+ubkM60UHEC1b0osfCYImxmZPsG3HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M17U5ERM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC542C4CEDD;
	Sun, 16 Mar 2025 12:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742129357;
	bh=gYGNBY+d4J2eTwFtOpFvwnowHkLW5Z0a1XFfZs4JGwk=;
	h=From:To:Cc:Subject:Date:From;
	b=M17U5ERMHrN7upUcpJ2CPWm6CsLD5BUOAKRlqCLl3O5qBtTa0Z9fCbswduGAjBVwq
	 Ir3zU0ivrK5ugO5FT4ND8NReVTz8nnZrT7EuMy4F8t15s4ZuKhUUQb80hAtQp38PS1
	 S8TZUd4XOqFbZmlSrPU/RJP7yS4inKVm8KDhfoM1zwNzvYEAMjC8nPPl3G+nHt4rjv
	 EHY58qqYgbvu5pYLfpkdUNrRrfi2BhkauxzpXOu4mS3T0OUPuOaM6G1vW21cyP0LXE
	 jV4nGjXD8LZZJzRrDDoDzULJmWC3g8O+XMuBRm+zUX7i0G4oNwK64hC/L5o0O24/Ge
	 zeeubp0OUNgnA==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: [PATCH] pidfs: ensure that PIDFS_INFO_EXIT is available
Date: Sun, 16 Mar 2025 13:49:09 +0100
Message-ID: <20250316-kabel-fehden-66bdb6a83436@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4815; i=brauner@kernel.org; h=from:subject:message-id; bh=gYGNBY+d4J2eTwFtOpFvwnowHkLW5Z0a1XFfZs4JGwk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRfO3FMyqHDLM0unjHa5Efv/Z7nGm8Yi767+lV0H2+2n KBTp1baUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBGXZIY/vJJ/XDezX05d80JH 4Pj21Ii9YrP26prekcj5Hb00ksn0CCPD/sfXD7yYbFL+V+96j2DvRzeO2BnlWV9UyvR/yp6SZH/ BBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

When we currently create a pidfd we check that the task hasn't been
reaped right before we create the pidfd. But it is of course possible
that by the time we return the pidfd to userspace the task has already
been reaped since we don't check again after having created a dentry for
it.

This was fine until now because that race was meaningless. But now that
we provide PIDFD_INFO_EXIT it is a problem because it is possible that
the kernel returns a reaped pidfd and it depends on the race whether
PIDFD_INFO_EXIT information is available. This depends on if the task
gets reaped before or after a dentry has been attached to struct pid.

Make this consistent and only returned pidfds for reaped tasks if
PIDFD_INFO_EXIT information is available. This is done by performing
another check whether the task has been reaped right after we attached a
dentry to struct pid.

Since pidfs_exit() is called before struct pid's task linkage is removed
the case where the task got reaped but a dentry was already attached to
struct pid and exit information was recorded and published can be
handled correctly. In that case we do return a pidfd for a reaped task
like we would've before.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Note: I haven't had time to run selftests over this yet.
---
 fs/pidfs.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++++----
 kernel/fork.c |  7 +++++--
 2 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 3c630e9d4a62..3f6eca0ea4c1 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -753,8 +753,49 @@ static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
 	return 0;
 }
 
+static inline bool pidfs_pid_valid(struct pid *pid, const struct path *path,
+				   unsigned int flags)
+{
+	enum pid_type type;
+
+	if (flags & CLONE_PIDFD)
+		return true;
+
+	/*
+	 * Make sure that if a pidfd is created PIDFD_INFO_EXIT
+	 * information will be available. So after an inode for the
+	 * pidfd has been allocated perform another check that the pid
+	 * is still alive. If it is exit information is available even
+	 * if the task gets reaped before the pidfd is returned to
+	 * userspace. The only exception is CLONE_PIDFD where no task
+	 * linkage has been established for @pid yet and the kernel is
+	 * in the middle of process creation so there's nothing for
+	 * pidfs to miss.
+	 */
+	if (flags & PIDFD_THREAD)
+		type = PIDTYPE_PID;
+	else
+		type = PIDTYPE_TGID;
+
+	/*
+	 * Since pidfs_exit() is called before struct pid's task linkage
+	 * is removed  the case where the task got reaped but a dentry
+	 * was already attached to struct pid and exit information was
+	 * recorded and published can be handled correctly.
+	 */
+	if (unlikely(!pid_has_task(pid, type))) {
+		struct inode *inode = d_inode(path->dentry);
+		return !!READ_ONCE(pidfs_i(inode)->exit_info);
+	}
+
+	return true;
+}
+
 static struct file *pidfs_export_open(struct path *path, unsigned int oflags)
 {
+	if (!pidfs_pid_valid(d_inode(path->dentry)->i_private, path, oflags))
+		return ERR_PTR(-ESRCH);
+
 	/*
 	 * Clear O_LARGEFILE as open_by_handle_at() forces it and raise
 	 * O_RDWR as pidfds always are.
@@ -820,19 +861,24 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 {
 
 	struct file *pidfd_file;
-	struct path path;
+	struct path path __free(path_put) = {};
+	unsigned int pidfd_flags = (flags & ~CLONE_PIDFD);
 	int ret;
 
+	BUILD_BUG_ON(O_DSYNC != CLONE_PIDFD);
+
 	ret = path_from_stashed(&pid->stashed, pidfs_mnt, get_pid(pid), &path);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	pidfd_file = dentry_open(&path, flags, current_cred());
+	if (!pidfs_pid_valid(pid, &path, flags))
+		return ERR_PTR(-ESRCH);
+
+	pidfd_file = dentry_open(&path, pidfd_flags, current_cred());
 	/* Raise PIDFD_THREAD explicitly as do_dentry_open() strips it. */
 	if (!IS_ERR(pidfd_file))
-		pidfd_file->f_flags |= (flags & PIDFD_THREAD);
+		pidfd_file->f_flags |= (pidfd_flags & PIDFD_THREAD);
 
-	path_put(&path);
 	return pidfd_file;
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 8eac9cd3385b..2c25de14df02 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2425,8 +2425,11 @@ __latent_entropy struct task_struct *copy_process(
 	if (clone_flags & CLONE_PIDFD) {
 		int flags = (clone_flags & CLONE_THREAD) ? PIDFD_THREAD : 0;
 
-		/* Note that no task has been attached to @pid yet. */
-		retval = __pidfd_prepare(pid, flags, &pidfile);
+		/*
+		 * Note that no task has been attached to @pid yet indicate
+		 * that via CLONE_PIDFD.
+		 */
+		retval = __pidfd_prepare(pid, flags | CLONE_PIDFD, &pidfile);
 		if (retval < 0)
 			goto bad_fork_free_pid;
 		pidfd = retval;
-- 
2.47.2


