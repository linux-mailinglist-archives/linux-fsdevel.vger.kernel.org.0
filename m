Return-Path: <linux-fsdevel+bounces-47327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4383BA9C08B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5AA29A132A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 08:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B45233737;
	Fri, 25 Apr 2025 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV45fax+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08A323372C;
	Fri, 25 Apr 2025 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568711; cv=none; b=VejYFBFi8WgX4xEuskSPqync5EJVOT1FJXDu7AwiMcKiMEiTuQ34RMDRemOwkMni8hT1lXCVc0Kw3J51v4Q+WV+VVkR345dCCdP6PQTwKMETP473A9p2bnMneT/OrJ2oEf3OwdLT8vSPEzBRszTeXeqoubPexspJp4ocP116cRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568711; c=relaxed/simple;
	bh=nMJ3psWToc89ewO/cJ/7prDnz/wFMrPXq0ZW1NO0b4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ngxvy2O36c9QXCivN+DSprHd5A/ahtxfcAQ8U0SmIGpjaTZjrpxS6gozmLPfsr/qKtGNUaJKHKhHCFIVWWLb9SCXt6laQeITb0EjyUHjpu+rJIE7XdxhPAXhTf8zSQuZ/WfO3iIwuMO702Yv7VrUSGrRjfKLGdclFCGxpLPK7d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV45fax+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516A8C4CEEA;
	Fri, 25 Apr 2025 08:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745568711;
	bh=nMJ3psWToc89ewO/cJ/7prDnz/wFMrPXq0ZW1NO0b4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hV45fax+HKLTqmZh3rULF2KkDHyVLvBLBXQQhRlc09iJfYhXdvgDLmJ0TJE0wXFw/
	 jzrG0wX3FG20I75VnwriSDpj13F6eWQIPzG/35gpzGdLwW8LeOPcGZz2U3Kh6cKO+j
	 dIJAZdXCJ5MEjqWKEqey7u4/a0xffLVWzwOSR/TbDC4Ds+UnvdNhlsISZ3736njZE9
	 CL3ZJBoywv+4vviYO4iUPTZboqZErwjHqJ0z45ZUp1ANm+cYB71ZyHErHa+FZDQsgn
	 Jk0c/j/KiE2IiLPW6KjVX0qC6Chc8S9cPUdVbQ+sENTCBhfv6IU/Xwwa+rKNLHc/7Z
	 nV1mG5gjDawDQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 25 Apr 2025 10:11:32 +0200
Subject: [PATCH v2 3/4] pidfs: get rid of __pidfd_prepare()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-work-pidfs-net-v2-3-450a19461e75@kernel.org>
References: <20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org>
In-Reply-To: <20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, David Rheinsberg <david@readahead.eu>, 
 Jan Kara <jack@suse.cz>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Luca Boccassi <bluca@debian.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8672; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nMJ3psWToc89ewO/cJ/7prDnz/wFMrPXq0ZW1NO0b4M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRwO29NzEtx/dH5YpLiwYu803esbJhSpOP4+MaKE87CB
 ud25BmndJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk1U1GhnlT85+8dIttP521
 yGK9jXaNzZZn8ff7meeFabox6jKs/cTwm+U5T3TTF0WzoO3HT02fPMNm4//CnsKpXnxWj+a6Rd6
 IZgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Fold it into pidfd_prepare() and rename PIDFD_CLONE to PIDFD_STALE to
indicate that the passed pid might not have task linkage and no explicit
check for that should be performed.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c                 | 22 +++++++-----
 include/linux/pid.h        |  2 +-
 include/uapi/linux/pidfd.h |  2 +-
 kernel/fork.c              | 83 ++++++++++++++++------------------------------
 4 files changed, 44 insertions(+), 65 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 308792d4b11a..0afaffd5a18a 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -768,7 +768,7 @@ static inline bool pidfs_pid_valid(struct pid *pid, const struct path *path,
 {
 	enum pid_type type;
 
-	if (flags & PIDFD_CLONE)
+	if (flags & PIDFD_STALE)
 		return true;
 
 	/*
@@ -777,10 +777,14 @@ static inline bool pidfs_pid_valid(struct pid *pid, const struct path *path,
 	 * pidfd has been allocated perform another check that the pid
 	 * is still alive. If it is exit information is available even
 	 * if the task gets reaped before the pidfd is returned to
-	 * userspace. The only exception is PIDFD_CLONE where no task
-	 * linkage has been established for @pid yet and the kernel is
-	 * in the middle of process creation so there's nothing for
-	 * pidfs to miss.
+	 * userspace. The only exception are indicated by PIDFD_STALE:
+	 *
+	 * (1) The kernel is in the middle of task creation and thus no
+	 *     task linkage has been established yet.
+	 * (2) The caller knows @pid has been registered in pidfs at a
+	 *     time when the task was still alive.
+	 *
+	 * In both cases exit information will have been reported.
 	 */
 	if (flags & PIDFD_THREAD)
 		type = PIDTYPE_PID;
@@ -874,11 +878,11 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	int ret;
 
 	/*
-	 * Ensure that PIDFD_CLONE can be passed as a flag without
+	 * Ensure that PIDFD_STALE can be passed as a flag without
 	 * overloading other uapi pidfd flags.
 	 */
-	BUILD_BUG_ON(PIDFD_CLONE == PIDFD_THREAD);
-	BUILD_BUG_ON(PIDFD_CLONE == PIDFD_NONBLOCK);
+	BUILD_BUG_ON(PIDFD_STALE == PIDFD_THREAD);
+	BUILD_BUG_ON(PIDFD_STALE == PIDFD_NONBLOCK);
 
 	ret = path_from_stashed(&pid->stashed, pidfs_mnt, get_pid(pid), &path);
 	if (ret < 0)
@@ -887,7 +891,7 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	if (!pidfs_pid_valid(pid, &path, flags))
 		return ERR_PTR(-ESRCH);
 
-	flags &= ~PIDFD_CLONE;
+	flags &= ~PIDFD_STALE;
 	pidfd_file = dentry_open(&path, flags, current_cred());
 	/* Raise PIDFD_THREAD explicitly as do_dentry_open() strips it. */
 	if (!IS_ERR(pidfd_file))
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 311ecebd7d56..453ae6d8a68d 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -77,7 +77,7 @@ struct file;
 struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
-int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
+int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret_file);
 void do_notify_pidfd(struct task_struct *task);
 
 static inline struct pid *get_pid(struct pid *pid)
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 2970ef44655a..8c1511edd0e9 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -12,7 +12,7 @@
 #define PIDFD_THREAD	O_EXCL
 #ifdef __KERNEL__
 #include <linux/sched.h>
-#define PIDFD_CLONE CLONE_PIDFD
+#define PIDFD_STALE CLONE_PIDFD
 #endif
 
 /* Flags for pidfd_send_signal(). */
diff --git a/kernel/fork.c b/kernel/fork.c
index f7403e1fb0d4..1d95f4dae327 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2035,55 +2035,11 @@ static inline void rcu_copy_process(struct task_struct *p)
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
-/**
- * __pidfd_prepare - allocate a new pidfd_file and reserve a pidfd
- * @pid:   the struct pid for which to create a pidfd
- * @flags: flags of the new @pidfd
- * @ret: Where to return the file for the pidfd.
- *
- * Allocate a new file that stashes @pid and reserve a new pidfd number in the
- * caller's file descriptor table. The pidfd is reserved but not installed yet.
- *
- * The helper doesn't perform checks on @pid which makes it useful for pidfds
- * created via CLONE_PIDFD where @pid has no task attached when the pidfd and
- * pidfd file are prepared.
- *
- * If this function returns successfully the caller is responsible to either
- * call fd_install() passing the returned pidfd and pidfd file as arguments in
- * order to install the pidfd into its file descriptor table or they must use
- * put_unused_fd() and fput() on the returned pidfd and pidfd file
- * respectively.
- *
- * This function is useful when a pidfd must already be reserved but there
- * might still be points of failure afterwards and the caller wants to ensure
- * that no pidfd is leaked into its file descriptor table.
- *
- * Return: On success, a reserved pidfd is returned from the function and a new
- *         pidfd file is returned in the last argument to the function. On
- *         error, a negative error code is returned from the function and the
- *         last argument remains unchanged.
- */
-static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
-{
-	struct file *pidfd_file;
-
-	CLASS(get_unused_fd, pidfd)(O_CLOEXEC);
-	if (pidfd < 0)
-		return pidfd;
-
-	pidfd_file = pidfs_alloc_file(pid, flags | O_RDWR);
-	if (IS_ERR(pidfd_file))
-		return PTR_ERR(pidfd_file);
-
-	*ret = pidfd_file;
-	return take_fd(pidfd);
-}
-
 /**
  * pidfd_prepare - allocate a new pidfd_file and reserve a pidfd
  * @pid:   the struct pid for which to create a pidfd
  * @flags: flags of the new @pidfd
- * @ret: Where to return the pidfd.
+ * @ret_file: return the new pidfs file
  *
  * Allocate a new file that stashes @pid and reserve a new pidfd number in the
  * caller's file descriptor table. The pidfd is reserved but not installed yet.
@@ -2106,16 +2062,26 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  *         error, a negative error code is returned from the function and the
  *         last argument remains unchanged.
  */
-int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
+int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret_file)
 {
+	struct file *pidfs_file;
+
 	/*
-	 * While holding the pidfd waitqueue lock removing the task
-	 * linkage for the thread-group leader pid (PIDTYPE_TGID) isn't
-	 * possible. Thus, if there's still task linkage for PIDTYPE_PID
-	 * not having thread-group leader linkage for the pid means it
-	 * wasn't a thread-group leader in the first place.
+	 * PIDFD_STALE is only allowed to be passed if the caller knows
+	 * that @pid is already registered in pidfs and thus
+	 * PIDFD_INFO_EXIT information is guaranteed to be available.
 	 */
-	scoped_guard(spinlock_irq, &pid->wait_pidfd.lock) {
+	if (!(flags & PIDFD_STALE)) {
+		/*
+		 * While holding the pidfd waitqueue lock removing the
+		 * task linkage for the thread-group leader pid
+		 * (PIDTYPE_TGID) isn't possible. Thus, if there's still
+		 * task linkage for PIDTYPE_PID not having thread-group
+		 * leader linkage for the pid means it wasn't a
+		 * thread-group leader in the first place.
+		 */
+		guard(spinlock_irq)(&pid->wait_pidfd.lock);
+
 		/* Task has already been reaped. */
 		if (!pid_has_task(pid, PIDTYPE_PID))
 			return -ESRCH;
@@ -2128,7 +2094,16 @@ int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
 			return -ENOENT;
 	}
 
-	return __pidfd_prepare(pid, flags, ret);
+	CLASS(get_unused_fd, pidfd)(O_CLOEXEC);
+	if (pidfd < 0)
+		return pidfd;
+
+	pidfs_file = pidfs_alloc_file(pid, flags | O_RDWR);
+	if (IS_ERR(pidfs_file))
+		return PTR_ERR(pidfs_file);
+
+	*ret_file = pidfs_file;
+	return take_fd(pidfd);
 }
 
 static void __delayed_free_task(struct rcu_head *rhp)
@@ -2477,7 +2452,7 @@ __latent_entropy struct task_struct *copy_process(
 		 * Note that no task has been attached to @pid yet indicate
 		 * that via CLONE_PIDFD.
 		 */
-		retval = __pidfd_prepare(pid, flags | PIDFD_CLONE, &pidfile);
+		retval = pidfd_prepare(pid, flags | PIDFD_STALE, &pidfile);
 		if (retval < 0)
 			goto bad_fork_free_pid;
 		pidfd = retval;

-- 
2.47.2


