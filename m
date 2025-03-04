Return-Path: <linux-fsdevel+bounces-43062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4FFA4D8EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F3737A2858
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8084E1FECA7;
	Tue,  4 Mar 2025 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMvdX24R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07621FE463
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081290; cv=none; b=ptfXiTovR0j0vqXuqXBAfaHxx25VXFwvlCIP6gd7TW1o9+u1tABZO4GYCbzL48eZ59wo++gYN5FGi6SauyMq4VHPXv3CC3tcWEyBsOQWXP934sl5KZxc7aHLZRkgnQ3htgzsBl7F0LLZJprrslESB23n+v/th1SSGUpDy/jZLa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081290; c=relaxed/simple;
	bh=XN9X/td8salsDDg7E0zBTJF3WWiZhQidQo1kRxEKXEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uZa+eHa98qOsPRhZdg0lN5VYBq7dcY4JFKL1cmhIunjJZ5C2wnrR6uE1iA32vmmZ7lCugN/7adFSY4zrOJPvMYTkXwZnOEpbRKc/BhY2gBs1rwDx8zvD/SBPmuOrKj6uTIIWGPOcTei4eop7YMLPuUKXlw9OcpcY9yP/Tw7gzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMvdX24R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1627C4CEE5;
	Tue,  4 Mar 2025 09:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081289;
	bh=XN9X/td8salsDDg7E0zBTJF3WWiZhQidQo1kRxEKXEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tMvdX24RoFEVwckI156+nSj/0WSiF2gzpQz6X2Ot/RxxtBMzGelQUoK9A76IPbcvg
	 nMTwCbGL3gyzaksWBUJu4YPYXbUmwpxkb4ODHoNgptW6RN9kGTTOSnPQMZRGf0xSTK
	 mcFwq75yZ4EDrtfayab6rJtPjVy9lL8phLMpneg0j5QGzPfvUKOvbDW9rkoC2aURyJ
	 SpWFnJvE6mrCern/FSgWhfJM40hxR/SQBBNot5G6IDpz0S7L8IZ6kbXF9u6Vk4JKgb
	 H3H+l2L8BGxtRs2+du/knCugFaHoCT5+cEHQna/8U9Jn5JAk9IqFc3feQP9AHDTm8f
	 8Xm0qWq3hxy8Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Mar 2025 10:41:06 +0100
Subject: [PATCH v2 06/15] pidfs: allow to retrieve exit information
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-work-pidfs-kill_on_last_close-v2-6-44fdacfaa7b7@kernel.org>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=7026; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XN9X/td8salsDDg7E0zBTJF3WWiZhQidQo1kRxEKXEs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO7Xry0r2SaGGu3Y06t84qXY4YiO72IXibhkhbTftD
 3cXf8hu7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI/mRGho05m6pKD69r29BS
 8ZXxcd0U9+Urb1rUbGr4d6f3G5tSYxAjw7NefXOZBX8+T7bezyj/TZGfVfi6hIlU7Q+nN6l3dr9
 +wwYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Some tools like systemd's jounral need to retrieve the exit and cgroup
information after a process has already been reaped. This can e.g.,
happen when retrieving a pidfd via SCM_PIDFD or SCM_PEERPIDFD.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c                 | 88 ++++++++++++++++++++++++++++++++++++----------
 include/uapi/linux/pidfd.h |  3 +-
 kernel/exit.c              |  2 +-
 3 files changed, 73 insertions(+), 20 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 258e1c13ee56..11744d7fe177 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -36,7 +36,8 @@ struct pidfs_exit_info {
 };
 
 struct pidfs_inode {
-	struct pidfs_exit_info exit_info;
+	struct pidfs_exit_info __pei;
+	struct pidfs_exit_info *exit_info;
 	struct inode vfs_inode;
 };
 
@@ -228,17 +229,28 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	return poll_flags;
 }
 
-static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long arg)
+static inline bool current_in_pidns(struct pid *pid)
+{
+	const struct pid_namespace *ns = task_active_pid_ns(current);
+
+	if (ns->level <= pid->level)
+		return pid->numbers[ns->level].ns == ns;
+
+	return false;
+}
+
+static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
+	struct pid *pid = pidfd_pid(file);
 	size_t usize = _IOC_SIZE(cmd);
 	struct pidfd_info kinfo = {};
+	struct pidfs_exit_info *exit_info;
+	struct inode *inode = file_inode(file);
 	struct user_namespace *user_ns;
+	struct task_struct *task;
 	const struct cred *c;
 	__u64 mask;
-#ifdef CONFIG_CGROUPS
-	struct cgroup *cgrp;
-#endif
 
 	if (!uinfo)
 		return -EINVAL;
@@ -248,6 +260,37 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
 	if (copy_from_user(&mask, &uinfo->mask, sizeof(mask)))
 		return -EFAULT;
 
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task) {
+		if (!(mask & PIDFD_INFO_EXIT))
+			return -ESRCH;
+
+		if (!current_in_pidns(pid))
+			return -ESRCH;
+	}
+
+	if (mask & PIDFD_INFO_EXIT) {
+		exit_info = READ_ONCE(pidfs_i(inode)->exit_info);
+		if (exit_info) {
+#ifdef CONFIG_CGROUPS
+			kinfo.cgroupid = exit_info->cgroupid;
+			kinfo.mask |= PIDFD_INFO_EXIT | PIDFD_INFO_CGROUPID;
+#endif
+			kinfo.exit_code = exit_info->exit_code;
+		}
+	}
+
+	/*
+	 * If the task has already been reaped only exit information
+	 * can be provided. It's entirely possible that the task has
+	 * already been reaped but we managed to grab a reference to it
+	 * before that. So a full set of information about @task doesn't
+	 * mean it hasn't been waited upon. Similarly, a full set of
+	 * information doesn't mean that the task hasn't already exited.
+	 */
+	if (!task)
+		goto copy_out;
+
 	c = get_task_cred(task);
 	if (!c)
 		return -ESRCH;
@@ -267,11 +310,15 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
 	put_cred(c);
 
 #ifdef CONFIG_CGROUPS
-	rcu_read_lock();
-	cgrp = task_dfl_cgroup(task);
-	kinfo.cgroupid = cgroup_id(cgrp);
-	kinfo.mask |= PIDFD_INFO_CGROUPID;
-	rcu_read_unlock();
+	if (!kinfo.cgroupid) {
+		struct cgroup *cgrp;
+
+		rcu_read_lock();
+		cgrp = task_dfl_cgroup(task);
+		kinfo.cgroupid = cgroup_id(cgrp);
+		kinfo.mask |= PIDFD_INFO_CGROUPID;
+		rcu_read_unlock();
+	}
 #endif
 
 	/*
@@ -291,6 +338,7 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
 	if (kinfo.pid == 0 || kinfo.tgid == 0 || (kinfo.ppid == 0 && kinfo.pid != 1))
 		return -ESRCH;
 
+copy_out:
 	/*
 	 * If userspace and the kernel have the same struct size it can just
 	 * be copied. If userspace provides an older struct, only the bits that
@@ -325,7 +373,6 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct task_struct *task __free(put_task) = NULL;
 	struct nsproxy *nsp __free(put_nsproxy) = NULL;
-	struct pid *pid = pidfd_pid(file);
 	struct ns_common *ns_common = NULL;
 	struct pid_namespace *pid_ns;
 
@@ -340,13 +387,13 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return put_user(file_inode(file)->i_generation, argp);
 	}
 
-	task = get_pid_task(pid, PIDTYPE_PID);
-	if (!task)
-		return -ESRCH;
-
 	/* Extensible IOCTL that does not open namespace FDs, take a shortcut */
 	if (_IOC_NR(cmd) == _IOC_NR(PIDFD_GET_INFO))
-		return pidfd_info(task, cmd, arg);
+		return pidfd_info(file, cmd, arg);
+
+	task = get_pid_task(pidfd_pid(file), PIDTYPE_PID);
+	if (!task)
+		return -ESRCH;
 
 	if (arg)
 		return -EINVAL;
@@ -479,10 +526,12 @@ void pidfs_exit(struct task_struct *tsk)
 {
 	struct dentry *dentry;
 
+	might_sleep();
+
 	dentry = stashed_dentry_get(&task_pid(tsk)->stashed);
 	if (dentry) {
 		struct inode *inode = d_inode(dentry);
-		struct pidfs_exit_info *exit_info = &pidfs_i(inode)->exit_info;
+		struct pidfs_exit_info *exit_info = &pidfs_i(inode)->__pei;
 #ifdef CONFIG_CGROUPS
 		struct cgroup *cgrp;
 
@@ -493,6 +542,8 @@ void pidfs_exit(struct task_struct *tsk)
 #endif
 		exit_info->exit_code = tsk->exit_code;
 
+		/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
+		smp_store_release(&pidfs_i(inode)->exit_info, &pidfs_i(inode)->__pei);
 		dput(dentry);
 	}
 }
@@ -560,7 +611,8 @@ static struct inode *pidfs_alloc_inode(struct super_block *sb)
 	if (!pi)
 		return NULL;
 
-	memset(&pi->exit_info, 0, sizeof(pi->exit_info));
+	memset(&pi->__pei, 0, sizeof(pi->__pei));
+	pi->exit_info = NULL;
 
 	return &pi->vfs_inode;
 }
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index e0abd0b18841..e5966f1a7743 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -20,6 +20,7 @@
 #define PIDFD_INFO_PID			(1UL << 0) /* Always returned, even if not requested */
 #define PIDFD_INFO_CREDS		(1UL << 1) /* Always returned, even if not requested */
 #define PIDFD_INFO_CGROUPID		(1UL << 2) /* Always returned if available, even if not requested */
+#define PIDFD_INFO_EXIT			(1UL << 3) /* Always returned if available, even if not requested */
 
 #define PIDFD_INFO_SIZE_VER0		64 /* sizeof first published struct */
 
@@ -86,7 +87,7 @@ struct pidfd_info {
 	__u32 sgid;
 	__u32 fsuid;
 	__u32 fsgid;
-	__u32 spare0[1];
+	__s32 exit_code;
 };
 
 #define PIDFS_IOCTL_MAGIC 0xFF
diff --git a/kernel/exit.c b/kernel/exit.c
index 98d292120296..9916305e34d3 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -250,12 +250,12 @@ void release_task(struct task_struct *p)
 	dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
 	rcu_read_unlock();
 
+	pidfs_exit(p);
 	cgroup_release(p);
 
 	write_lock_irq(&tasklist_lock);
 	ptrace_release_task(p);
 	thread_pid = get_pid(p->thread_pid);
-	pidfs_exit(p);
 	__exit_signal(p);
 
 	/*

-- 
2.47.2


