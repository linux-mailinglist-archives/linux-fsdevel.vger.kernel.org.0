Return-Path: <linux-fsdevel+bounces-43061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F38DA4D8EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACACF7A16AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033EB1FECA6;
	Tue,  4 Mar 2025 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3MhY94p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AF61FE45B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081287; cv=none; b=Jt4boip89d2RSJ5lKullynTpz2AL7hUinre8s3DaqUeFatIhbPiVFtUgu2jUrkBEk8q1O/p0jCVmuGFJVTynkVaPJnUdQbDnL8Q0iP/Mu38cvB3bKPDs5YmbuULB+OAEvNF741JVHZW9rRCLmifi/ELESwAiDCjzVuOuJhYcg9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081287; c=relaxed/simple;
	bh=TYE4iFEVdG9VIp4MYrNzinTHKElGftXfRUJU/Zd8M/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEMf53N6uWJPkzdOFAEmiAAOy0Av3VvkWOGUr5O8K7aOkme6JAS7VWBlutxVP/obY37Iokf0Odz+TLG7Y6XzueWzkwmeoihdst01QG1FWm28fCUDpH+E26NR6qxREpc9CSM7Lvpo5h7t7D6rdrK+J3kbQ8oYCMPmf0SjgxgBfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3MhY94p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5799C4CEE8;
	Tue,  4 Mar 2025 09:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081287;
	bh=TYE4iFEVdG9VIp4MYrNzinTHKElGftXfRUJU/Zd8M/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p3MhY94phBStHob9ceT0BaJWt/ASZaUHreA0HiB9/f4IXvk6QVaVJzCFLwRn4n8Jd
	 JFKpnzeFuSxrRlX6rstL8boFTqL5AYOh/e/6RfYdzeaYal7Ol3NLH0JrMB7yi6f2k2
	 eQHAoFkL1I2IrVHOpMe+g1khISekrviPXsiJUWXTRRSXpkvzTVAwwJhI62xE+nG0Oe
	 b02q+z1c0/rz/6FyAGcbLjgWeauGVafAysBoHNhhG6DPiUdlNRBvgspzO3PhkhMlj0
	 ZX072+NoTaE6r1EIl5AFVxzWlsPQ2xgPHwkdvKsN72BgbtkxsnEv5OAZs7JtGxavVK
	 +ggMze9yNejIw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Mar 2025 10:41:05 +0100
Subject: [PATCH v2 05/15] pidfs: record exit code and cgroupid at exit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-work-pidfs-kill_on_last_close-v2-5-44fdacfaa7b7@kernel.org>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4655; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TYE4iFEVdG9VIp4MYrNzinTHKElGftXfRUJU/Zd8M/0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO7XLpD1W5AZnrjmXUO4tM1erXeaXCrZXz5Ff0/iT6
 cOuo7bHOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSZMXw363C9/ujD/bbjau6
 bdoWcehNrQldfurFqUUMD0yFpof/CmFkeF7x1jl8gsCeYqb+jzP3fA8907Rx+cff39qVa2SPrJg
 SwQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Record the exit code and cgroupid in do_exit() and stash in struct
pidfs_exit_info so it can be retrieved even after the task has been
reaped.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/internal.h         |  1 +
 fs/libfs.c            |  4 ++--
 fs/pidfs.c            | 41 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/pidfs.h |  1 +
 kernel/exit.c         |  2 ++
 5 files changed, 46 insertions(+), 3 deletions(-)

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
index eaecb0a947f0..258e1c13ee56 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -32,7 +32,7 @@ static struct kmem_cache *pidfs_cachep __ro_after_init;
  */
 struct pidfs_exit_info {
 	__u64 cgroupid;
-	__u64 exit_code;
+	__s32 exit_code;
 };
 
 struct pidfs_inode {
@@ -458,6 +458,45 @@ struct pid *pidfd_pid(const struct file *file)
 	return file_inode(file)->i_private;
 }
 
+/*
+ * We're called from release_task(). We know there's at least one
+ * reference to struct pid being held that won't be released until the
+ * task has been reaped which cannot happen until we're out of
+ * release_task().
+ *
+ * If this struct pid is refered to by a pidfd then stashed_dentry_get()
+ * will return the dentry and inode for that struct pid. Since we've
+ * taken a reference on it there's now an additional reference from the
+ * exit path on it. Which is fine. We're going to put it again in a
+ * second and we know that the pid is kept alive anyway.
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
index 3485e5fc499e..98d292120296 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -69,6 +69,7 @@
 #include <linux/sysfs.h>
 #include <linux/user_events.h>
 #include <linux/uaccess.h>
+#include <linux/pidfs.h>
 
 #include <uapi/linux/wait.h>
 
@@ -254,6 +255,7 @@ void release_task(struct task_struct *p)
 	write_lock_irq(&tasklist_lock);
 	ptrace_release_task(p);
 	thread_pid = get_pid(p->thread_pid);
+	pidfs_exit(p);
 	__exit_signal(p);
 
 	/*

-- 
2.47.2


