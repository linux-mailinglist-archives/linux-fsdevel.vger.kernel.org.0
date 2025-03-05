Return-Path: <linux-fsdevel+bounces-43225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C305EA4FB43
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAC13A5321
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2AD2063DF;
	Wed,  5 Mar 2025 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQdgrBr0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2EF205E06
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169317; cv=none; b=SqQY1I8MLSwuIVc3PBcliMGikdR2PWKGac2krk79KMFszv+HrvaofUK6VkopDyWfKtVLTiMBZpJoYa9ltqBUbeVpjTLA+5YGKcb8Ye9YMidihsIcSe1ONUTAik8k9gXn4BIVx46qVZ7/v5lq0YG0dn+Ga9d+GZqo7Cg5R1arHJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169317; c=relaxed/simple;
	bh=JXrYrLNBggp1OwoK9I55On5p9kX9hSPyXO9PjAY+VL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OX1q2z4yaAjemzRelbrkaAAhOSvinukxOJnEqD0/Me1VPRkGxhWQ+rjV6cT3FoCBn2ZwytJX2LVu+H+Aevu6IdiJjCwu838u0c1IsgZ8qW3o/Mq8AIzsrNcvytSxFGkP/AhwVyJdYMNhjWOi3MHztKlSSHpCCkVKa3sTEKWgOwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQdgrBr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AA3C4CEE9;
	Wed,  5 Mar 2025 10:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169317;
	bh=JXrYrLNBggp1OwoK9I55On5p9kX9hSPyXO9PjAY+VL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GQdgrBr0eXadC8ytCTkN+FprhB53Sm2DcXRNF09bH0DzeP7rtxoJLUcf0ysIGFnXf
	 nRLAKrwcbuFtaZvWO8AcpZp0n7tAgKykktly/pEEOEGQQhNjuJ9lNk3rbxZqAnJRU9
	 lzDAav8C5U/+SGfwtj/C5HIgnFVOhcaxbL4/DUkrFLHVfcrZv4F1f+V8OvnMGkR6jH
	 zZ8+TpQ0j4rbp3QJ9sS4wzoAJy2JvlQf6HqiQDkLgjMus/XfrFpbg3Jtr3sWZTtnXe
	 zPJsFIhbeAfhAaNi+aGjGyurYPmjl1P6hJATPwviwo0fazAJRFpomUkh8FzL/nZFvW
	 wdHwDcAOlETFA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Mar 2025 11:08:15 +0100
Subject: [PATCH v3 05/16] pidfs: record exit code and cgroupid at exit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-5-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4649; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JXrYrLNBggp1OwoK9I55On5p9kX9hSPyXO9PjAY+VL0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfUJohcL52T3LanAbHlP21AazhDCHaqfMDZhxTKXI61
 HdbO3FpRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESWhDP8Zg8X/bMmN2JBYoNu
 3le9UzsOfu14WH8x+s/DxDkLnNz31TL84dw2ad5kEaujXIWpS0995t37rLtX3yn2rKPKAwtBhat
 T2AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Record the exit code and cgroupid in release_task() and stash in struct
pidfs_exit_info so it can be retrieved even after the task has been
reaped.

Link: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2-5-44fdacfaa7b7@kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/internal.h         |  1 +
 fs/libfs.c            |  4 ++--
 fs/pidfs.c            | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pidfs.h |  1 +
 kernel/exit.c         |  2 ++
 5 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index e7f02ae1e098..c1e6d8b294cb 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -325,6 +325,7 @@ struct stashed_operations {
 int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 		      struct path *path);
 void stashed_dentry_prune(struct dentry *dentry);
+struct dentry *stashed_dentry_get(struct dentry **stashed);
 /**
  * path_mounted - check whether path is mounted
  * @path: path to check
diff --git a/fs/libfs.c b/fs/libfs.c
index 8444f5cc4064..cf5a267aafe4 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2113,7 +2113,7 @@ struct timespec64 simple_inode_init_ts(struct inode *inode)
 }
 EXPORT_SYMBOL(simple_inode_init_ts);
 
-static inline struct dentry *get_stashed_dentry(struct dentry **stashed)
+struct dentry *stashed_dentry_get(struct dentry **stashed)
 {
 	struct dentry *dentry;
 
@@ -2215,7 +2215,7 @@ int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 	const struct stashed_operations *sops = mnt->mnt_sb->s_fs_info;
 
 	/* See if dentry can be reused. */
-	path->dentry = get_stashed_dentry(stashed);
+	path->dentry = stashed_dentry_get(stashed);
 	if (path->dentry) {
 		sops->put_data(data);
 		goto out_path;
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 282511a36fd9..c4e6527013e7 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -458,6 +458,47 @@ struct pid *pidfd_pid(const struct file *file)
 	return file_inode(file)->i_private;
 }
 
+/*
+ * We're called from release_task(). We know there's at least one
+ * reference to struct pid being held that won't be released until the
+ * task has been reaped which cannot happen until we're out of
+ * release_task().
+ *
+ * If this struct pid is referred to by a pidfd then
+ * stashed_dentry_get() will return the dentry and inode for that struct
+ * pid. Since we've taken a reference on it there's now an additional
+ * reference from the exit path on it. Which is fine. We're going to put
+ * it again in a second and we know that the pid is kept alive anyway.
+ *
+ * Worst case is that we've filled in the info and immediately free the
+ * dentry and inode afterwards since the pidfd has been closed. Since
+ * pidfs_exit() currently is placed after exit_task_work() we know that
+ * it cannot be us aka the exiting task holding a pidfd to ourselves.
+ */
+void pidfs_exit(struct task_struct *tsk)
+{
+	struct dentry *dentry;
+
+	might_sleep();
+
+	dentry = stashed_dentry_get(&task_pid(tsk)->stashed);
+	if (dentry) {
+		struct inode *inode = d_inode(dentry);
+		struct pidfs_exit_info *exit_info = &pidfs_i(inode)->exit_info;
+#ifdef CONFIG_CGROUPS
+		struct cgroup *cgrp;
+
+		rcu_read_lock();
+		cgrp = task_dfl_cgroup(tsk);
+		exit_info->cgroupid = cgroup_id(cgrp);
+		rcu_read_unlock();
+#endif
+		exit_info->exit_code = tsk->exit_code;
+
+		dput(dentry);
+	}
+}
+
 static struct vfsmount *pidfs_mnt __ro_after_init;
 
 /*
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 7c830d0dec9a..05e6f8f4a026 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -6,6 +6,7 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
 void __init pidfs_init(void);
 void pidfs_add_pid(struct pid *pid);
 void pidfs_remove_pid(struct pid *pid);
+void pidfs_exit(struct task_struct *tsk);
 extern const struct dentry_operations pidfs_dentry_operations;
 
 #endif /* _LINUX_PID_FS_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 3485e5fc499e..9916305e34d3 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -69,6 +69,7 @@
 #include <linux/sysfs.h>
 #include <linux/user_events.h>
 #include <linux/uaccess.h>
+#include <linux/pidfs.h>
 
 #include <uapi/linux/wait.h>
 
@@ -249,6 +250,7 @@ void release_task(struct task_struct *p)
 	dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
 	rcu_read_unlock();
 
+	pidfs_exit(p);
 	cgroup_release(p);
 
 	write_lock_irq(&tasklist_lock);

-- 
2.47.2


