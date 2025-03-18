Return-Path: <linux-fsdevel+bounces-44293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537E3A66E65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 09:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2421763FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4B3204F8A;
	Tue, 18 Mar 2025 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzVbHHI6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E10204F65
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286903; cv=none; b=nOESNwhBJtloFJkQYlcPQwUskxo+hTeutx1JRFUCB4g01RCy2lUX7HnS8NXKxXBRy8POLl/SV6Fxb4nqaetes4fAJaBdmK0IiWWAPEzZJkUbkKTgrjvrjr45gR4aR1w+ZRh5GjCMNbuH4kMrPHPnKRuCPhha8dIneqfm6jojwmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286903; c=relaxed/simple;
	bh=RntO+3M2/psv1Zs3oZ+vHjdEEKvp6GZN4SqKzd/TB5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9c9aEO5b+fmzP2wDxvCspq8Nca8JN+I5LsaqjzyL9zRjtG5t7B8BmSctmdcqjxSS3cea0od0HzaCJoZuDbyZnQtYnLD63a0WVYYXMOLZ5nY3zrF08souzhUr6g6AodhzlwG+zu23o4RXmJkwrr0922njfAdiv/OOPE+IPcNpCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzVbHHI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C567C4CEDD;
	Tue, 18 Mar 2025 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742286902;
	bh=RntO+3M2/psv1Zs3oZ+vHjdEEKvp6GZN4SqKzd/TB5s=;
	h=From:To:Cc:Subject:Date:From;
	b=bzVbHHI6BP44+cxg4OZr0cynOLPhQmjg/Cc0e0264WSn4PDVwnPmtprCVxO33TnXb
	 hTI/CwgRvoEWIRndA//OrhS/v5UVx7mdnOa/WcuzkQkMvDKB9cuEjhE4u+5ffcgF2A
	 yOKWQz636a/AteMkrlXFoh0pyRm/GkdIpXULYTb7+ssda9NwpzBA4DLNIx/1THlzoT
	 d8AlAupbz8JHTvtQj9QF0q7qkMBxiLoO6nXsSL0IIvu1jrDZh+ZKLJP0soleRcTH2j
	 w6EIlCPL6Cmz+NIvMNdN8yAN80mk8XCSEfoh/HHfwqIiL2FQfozJ+y8c2zo1seW6l7
	 fEj6LL4pf0eFQ==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: [PATCH v2] pidfs: ensure that PIDFS_INFO_EXIT is available
Date: Tue, 18 Mar 2025 09:34:53 +0100
Message-ID: <20250318-geknebelt-anekdote-87bdb6add5fd@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4979; i=brauner@kernel.org; h=from:subject:message-id; bh=RntO+3M2/psv1Zs3oZ+vHjdEEKvp6GZN4SqKzd/TB5s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfNNBbmbuy/uGriXqK7JWXDc4H79EImHXLuNrFIv27m ojM8jkCHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZ84Hhv3Pb+bhrXUvs3j7O vNw6cz+jfoSm3MeA3hM+v1QeRTwxFmdkOLDuW4Gf82KheQzHDy0qfPlu7mOR9rt8KZ2Cz45+ZGw JZwMA
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

Link: https://lore.kernel.org/r/20250316-kabel-fehden-66bdb6a83436@brauner
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Now tested and no regressions were observed.
This contains minor changes.
---
 fs/pidfs.c    | 56 ++++++++++++++++++++++++++++++++++++++++++++++++---
 kernel/fork.c |  7 +++++--
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 3c630e9d4a62..d980f779c213 100644
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
+	 * is removed the case where the task got reaped but a dentry
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
@@ -818,21 +859,30 @@ static struct file_system_type pidfs_type = {
 
 struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 {
-
 	struct file *pidfd_file;
-	struct path path;
+	struct path path __free(path_put) = {};
 	int ret;
 
+	/*
+	 * Ensure that CLONE_PIDFD can be passed as a flag without
+	 * overloading other uapi pidfd flags.
+	 */
+	BUILD_BUG_ON(CLONE_PIDFD == PIDFD_THREAD);
+	BUILD_BUG_ON(CLONE_PIDFD == PIDFD_NONBLOCK);
+
 	ret = path_from_stashed(&pid->stashed, pidfs_mnt, get_pid(pid), &path);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
+	if (!pidfs_pid_valid(pid, &path, flags))
+		return ERR_PTR(-ESRCH);
+
+	flags &= ~CLONE_PIDFD;
 	pidfd_file = dentry_open(&path, flags, current_cred());
 	/* Raise PIDFD_THREAD explicitly as do_dentry_open() strips it. */
 	if (!IS_ERR(pidfd_file))
 		pidfd_file->f_flags |= (flags & PIDFD_THREAD);
 
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


