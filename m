Return-Path: <linux-fsdevel+bounces-47231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE38A9AD59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A47F923A66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 12:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5651A25E44F;
	Thu, 24 Apr 2025 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skjFl12L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A608325DD1E;
	Thu, 24 Apr 2025 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497526; cv=none; b=aY1puDEfGZFssFyhvvZmfFQ1Ju5GYeK/IlYveNt8MgJ8ZYgwoQCzlHynhIG/QeLBX2YiCcjB9Olhuwh16IDUgR1vfUrHLpasl1ZHKL7m2fgm4ih6z8xKlQ2kE+0KJlHTAdcQMhIerenNtxLPlJ1e9xll32HoAEkYJY2HMf177Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497526; c=relaxed/simple;
	bh=q0Zul5GmEGj0WjtZQ7Mk0Q5/9DR1bnkoJs7kA778bl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iq3ka3BjYfb9OAj7FrT1S8UuRREtosgylx+ZJOUbNxXqwNkROCeV9Xvsgwz6vGyvGxByiyQaOwHLu2Ts81ayE2p0TBjTevpCppPqLqnLDQhZs8D44vg6FgSEgtD46Bu7SvAHPneDQA93+sm4Va3SwnC5Ystipe/FCjOJYUNYNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skjFl12L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DE5C4CEE8;
	Thu, 24 Apr 2025 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745497526;
	bh=q0Zul5GmEGj0WjtZQ7Mk0Q5/9DR1bnkoJs7kA778bl4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=skjFl12LA4JxPQ9blgcChu0HgzagItI7BnpsuFND+zYE/jXupVQDYSp31KwyItZoI
	 X2JnKrYMtnwsw/SlcezWDi2aNWNven8bldIy7MmPwpU5MoqPgoUyKq7fFi7LrdIhnB
	 EOAiLkTVET6QHqhQgvwksPcbFodxLarKg5eCHI2s7jSfVbIDGpzE6x4KA4UxSw0GyL
	 kKQhM2Hs7k23ZJy1cYGIdgPIbuptTPKDg2hlmqCBAH3ra7SnbsdiXULxR7WFDMny6g
	 3trd+w9t7oOhbc1Rlyoh1Dk46hChCvvRyAcy9DBYCUktexiBo+asAfteTmIk2a1+rk
	 JKEEP/P0G75dQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 24 Apr 2025 14:24:36 +0200
Subject: [PATCH RFC 3/4] pidfs: get rid of __pidfd_prepare()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-work-pidfs-net-v1-3-0dc97227d854@kernel.org>
References: <20250424-work-pidfs-net-v1-0-0dc97227d854@kernel.org>
In-Reply-To: <20250424-work-pidfs-net-v1-0-0dc97227d854@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6898; i=brauner@kernel.org;
 h=from:subject:message-id; bh=q0Zul5GmEGj0WjtZQ7Mk0Q5/9DR1bnkoJs7kA778bl4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRw6S69s0Nw6wHGzAv+OssFa01v8Ri5Lz4i3aJxXs8h+
 YZto/KPjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlEH2VkmHiGedINp8VSIbn/
 e7mf8KeFbZqZpi/cVfT2ZodqxpJvuYwMF1sWMfc8YDLSY/I6Myk7/a03r3XgXmumidNXpN/6/IK
 TEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Fold it into pidfd_prepare() and rename PIDFD_CLONE to PIDFD_STALE to
indicate that the passed pid might not have task linkage and no explicit
check for that should be performed.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c                 | 12 +++----
 include/uapi/linux/pidfd.h |  2 +-
 kernel/fork.c              | 78 ++++++++++++++--------------------------------
 3 files changed, 31 insertions(+), 61 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 8e6c11774c60..3199ec02aaec 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -768,7 +768,7 @@ static inline bool pidfs_pid_valid(struct pid *pid, const struct path *path,
 {
 	enum pid_type type;
 
-	if (flags & PIDFD_CLONE)
+	if (flags & PIDFD_STALE)
 		return true;
 
 	/*
@@ -777,7 +777,7 @@ static inline bool pidfs_pid_valid(struct pid *pid, const struct path *path,
 	 * pidfd has been allocated perform another check that the pid
 	 * is still alive. If it is exit information is available even
 	 * if the task gets reaped before the pidfd is returned to
-	 * userspace. The only exception is PIDFD_CLONE where no task
+	 * userspace. The only exception is PIDFD_STALE where no task
 	 * linkage has been established for @pid yet and the kernel is
 	 * in the middle of process creation so there's nothing for
 	 * pidfs to miss.
@@ -874,11 +874,11 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
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
@@ -887,7 +887,7 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	if (!pidfs_pid_valid(pid, &path, flags))
 		return ERR_PTR(-ESRCH);
 
-	flags &= ~PIDFD_CLONE;
+	flags &= ~PIDFD_STALE;
 	pidfd_file = dentry_open(&path, flags, current_cred());
 	/* Raise PIDFD_THREAD explicitly as do_dentry_open() strips it. */
 	if (!IS_ERR(pidfd_file))
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
index f7403e1fb0d4..365687e1698f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2035,50 +2035,6 @@ static inline void rcu_copy_process(struct task_struct *p)
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
@@ -2108,14 +2064,19 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  */
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
 {
-	/*
-	 * While holding the pidfd waitqueue lock removing the task
-	 * linkage for the thread-group leader pid (PIDTYPE_TGID) isn't
-	 * possible. Thus, if there's still task linkage for PIDTYPE_PID
-	 * not having thread-group leader linkage for the pid means it
-	 * wasn't a thread-group leader in the first place.
-	 */
-	scoped_guard(spinlock_irq, &pid->wait_pidfd.lock) {
+	struct file *pidfd_file;
+
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
@@ -2128,7 +2089,16 @@ int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
 			return -ENOENT;
 	}
 
-	return __pidfd_prepare(pid, flags, ret);
+	CLASS(get_unused_fd, pidfd)(O_CLOEXEC);
+	if (pidfd < 0)
+		return pidfd;
+
+	pidfd_file = pidfs_alloc_file(pid, flags | O_RDWR);
+	if (IS_ERR(pidfd_file))
+		return PTR_ERR(pidfd_file);
+
+	*ret = pidfd_file;
+	return take_fd(pidfd);
 }
 
 static void __delayed_free_task(struct rcu_head *rhp)
@@ -2477,7 +2447,7 @@ __latent_entropy struct task_struct *copy_process(
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


