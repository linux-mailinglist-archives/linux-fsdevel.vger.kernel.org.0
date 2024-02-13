Return-Path: <linux-fsdevel+bounces-11395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A1685366C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95747B24FDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183C65FF00;
	Tue, 13 Feb 2024 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnIQeN1K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0D45FEF6
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842757; cv=none; b=XeGMRm3r8G8hK6b4LVXPIXulm0lNbXzwQGCpldcgiT40TURZ1nZirVIygkF3dYNmwN8ahiMoskVf86l7L2arEms41UsZqzeI7RF7ToZXI83MJLut6VBqOqns1O1TTYmnkn6FtiMAXx3d79wFHRdfIq19RySgESt4MK1wLSRiJ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842757; c=relaxed/simple;
	bh=SF7qwLDVeOtCWpJa+s4xePDhYxhJ40fSS6SEgamkeHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SHV2QEQ3U4hK7AJo7X7p4rLDzozTLu1w+ppGf6rlYo0cB5NYYQfGyiYmo1vI/sMcxSdHZ24tpZJcdwBPbTpkvsZIvF5/QH25B1hsJ61zN2/gnzOPSip8QjGe+ntXohvOEr2MTsQIWXUeVWF0kawgmoMlNj5KcZV1uiIQXEsgs9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnIQeN1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A690C43394;
	Tue, 13 Feb 2024 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707842757;
	bh=SF7qwLDVeOtCWpJa+s4xePDhYxhJ40fSS6SEgamkeHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DnIQeN1KNKRAFGw5w7aMKwOaYIoiYAu1CeKK74DuK/ZYj7/fyxa9sdFpaj8FbTY+C
	 PWz+dPzAUkpIAdJ9SecauCmJKI59FttljC/Q+MI1ZOlfV6tkXsKR3xTKVH6DUT423B
	 Ltl3CQ6a9ncwmZ4l5pQ2GErzXlPhBPPpSUAlxj5VcHIZ655kXw8KCpsQNe5c8wl/7r
	 PAwvI3tgKYLuJufcas1Ir/3RJY2yBrFoFxntgAnrhdEMjswdIHyQO7L/fJV7J2zrIr
	 dGXGG2AsPFWJSImW9ecIbwwSdJUe6X1kRQTBLD5iXoiyGjM8xceBowKGKKYaimHrNW
	 g/57plBoUEBOA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 13 Feb 2024 17:45:47 +0100
Subject: [PATCH 2/2] pidfd: add pidfdfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
In-Reply-To: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=12803; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SF7qwLDVeOtCWpJa+s4xePDhYxhJ40fSS6SEgamkeHE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSenrNv9jsTDtbPLz4wPvnmyLC5sHdiScS04IlnUnjUa
 nh//P92raOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiExYwMhySzzZMWhygp8dz
 g/tx+Nl+86Kiyp/rLu6+bHH+CoO5vSPD/0JdwbUHt0iKWAt2X/Dr5EnJMtuvLVe9epJFQHzvxy2
 L+QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This moves pidfds from the anonymous inode infrastructure to a tiny
pseudo filesystem. This has been on my todo for quite a while as it will
unblock further work that we weren't able to do simply because of the
very justified limitations of anonymous inodes. Moving pidfds to a tiny
pseudo filesystem allows:

* statx() on pidfds becomes useful for the first time.
* pidfds can be compared simply via statx() and then comparing inode
  numbers.
* pidfds have unique inode numbers for the system lifetime.
* struct pid is now stashed in inode->i_private instead of
  file->private_data. This means it is now possible to introduce
  concepts that operate on a process once all file descriptors have been
  closed. A concrete example is kill-on-last-close.
* file->private_data is freed up for per-file options for pidfds.
* Each struct pid will refer to a different inode but the same struct
  pid will refer to the same inode if it's opened multiple times. In
  contrast to now where each struct pid refers to the same inode. Even
  if we were to move to anon_inode_create_getfile() which creates new
  inodes we'd still be associating the same struct pid with multiple
  different inodes.
* Pidfds now go through the regular dentry_open() path which means that
  all security hooks are called unblocking proper LSM management for
  pidfds. In addition fsnotify hooks are called and allow for listening
  to open events on pidfds.

The tiny pseudo filesystem is not visible anywhere in userspace exactly
like e.g., pipefs and sockfs. There's no lookup, there's no complex
inode operations, nothing. Dentries and inodes are always deleted when
the last pidfd is closed.

The code is entirely optional and fairly small. If it's not selected we
fallback to anonymous inodes. Heavily inspired by nsfs which uses a
similar stashing mechanism just for namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/Kconfig                 |   6 ++
 fs/pidfdfs.c               | 189 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pid.h        |   4 +
 include/linux/pidfdfs.h    |   9 +++
 include/uapi/linux/magic.h |   1 +
 init/main.c                |   2 +
 kernel/fork.c              |  13 +---
 kernel/nsproxy.c           |   2 +-
 kernel/pid.c               |   2 +
 9 files changed, 214 insertions(+), 14 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 89fdbefd1075..c7ed65e34820 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -174,6 +174,12 @@ source "fs/proc/Kconfig"
 source "fs/kernfs/Kconfig"
 source "fs/sysfs/Kconfig"
 
+config FS_PIDFD
+	bool "Pseudo filesystem for process file descriptors"
+	depends on 64BIT
+	help
+	  Pidfdfs implements advanced features for process file descriptors.
+
 config TMPFS
 	bool "Tmpfs virtual memory file system support (former shm fs)"
 	depends on SHMEM
diff --git a/fs/pidfdfs.c b/fs/pidfdfs.c
index 55e8396e7fc4..efc68ef3a08d 100644
--- a/fs/pidfdfs.c
+++ b/fs/pidfdfs.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/anon_inodes.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/magic.h>
 #include <linux/mount.h>
 #include <linux/pid.h>
+#include <linux/pidfdfs.h>
 #include <linux/pid_namespace.h>
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
@@ -12,12 +14,25 @@
 #include <linux/seq_file.h>
 #include <uapi/linux/pidfd.h>
 
+struct pid *pidfd_pid(const struct file *file)
+{
+	if (file->f_op != &pidfd_fops)
+		return ERR_PTR(-EBADF);
+#ifdef CONFIG_FS_PIDFD
+	return file_inode(file)->i_private;
+#else
+	return file->private_data;
+#endif
+}
+
 static int pidfd_release(struct inode *inode, struct file *file)
 {
+#ifndef CONFIG_FS_PIDFD
 	struct pid *pid = file->private_data;
 
 	file->private_data = NULL;
 	put_pid(pid);
+#endif
 	return 0;
 }
 
@@ -59,7 +74,7 @@ static int pidfd_release(struct inode *inode, struct file *file)
  */
 static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 {
-	struct pid *pid = f->private_data;
+	struct pid *pid = pidfd_pid(f);
 	struct pid_namespace *ns;
 	pid_t nr = -1;
 
@@ -93,7 +108,7 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
  */
 static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 {
-	struct pid *pid = file->private_data;
+	struct pid *pid = pidfd_pid(file);
 	bool thread = file->f_flags & PIDFD_THREAD;
 	struct task_struct *task;
 	__poll_t poll_flags = 0;
@@ -121,3 +136,173 @@ const struct file_operations pidfd_fops = {
 	.show_fdinfo	= pidfd_show_fdinfo,
 #endif
 };
+
+#ifdef CONFIG_FS_PIDFD
+static struct vfsmount *pidfdfs_mnt __ro_after_init;
+static struct super_block *pidfdfs_sb __ro_after_init;
+static u64 pidfdfs_ino = 0;
+
+static void pidfdfs_evict_inode(struct inode *inode)
+{
+	struct pid *pid = inode->i_private;
+
+	clear_inode(inode);
+	put_pid(pid);
+}
+
+static const struct super_operations pidfdfs_sops = {
+	.statfs		= simple_statfs,
+	.evict_inode	= pidfdfs_evict_inode,
+};
+
+static void pidfdfs_prune_dentry(struct dentry *dentry)
+{
+	struct inode *inode;
+	struct pid *pid;
+
+	inode = d_inode(dentry);
+	if (!inode)
+		return;
+
+	pid = inode->i_private;
+	atomic_long_set(&pid->stashed, 0);
+}
+
+static char *pidfdfs_dname(struct dentry *dentry, char *buffer, int buflen)
+{
+	return dynamic_dname(buffer, buflen, "pidfd:[%lu]",
+			     d_inode(dentry)->i_ino);
+}
+
+const struct dentry_operations pidfdfs_dentry_operations = {
+	.d_prune	= pidfdfs_prune_dentry,
+	.d_delete	= always_delete_dentry,
+	.d_dname	= pidfdfs_dname,
+};
+
+static int pidfdfs_init_fs_context(struct fs_context *fc)
+{
+	struct pseudo_fs_context *ctx;
+
+	ctx = init_pseudo(fc, PIDFDFS_MAGIC);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->ops = &pidfdfs_sops;
+	ctx->dops = &pidfdfs_dentry_operations;
+	return 0;
+}
+
+static struct file_system_type pidfdfs_type = {
+	.name			= "pidfdfs",
+	.init_fs_context	= pidfdfs_init_fs_context,
+	.kill_sb		= kill_anon_super,
+};
+
+static struct dentry *pidfdfs_dentry(struct pid *pid)
+{
+	struct inode *inode;
+	struct dentry *dentry;
+	unsigned long i_ptr;
+
+	inode = new_inode_pseudo(pidfdfs_sb);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	inode->i_ino	= pid->ino;
+	inode->i_mode	= S_IFREG | S_IRUGO;
+	inode->i_fop	= &pidfd_fops;
+	inode->i_flags |= S_IMMUTABLE;
+	simple_inode_init_ts(inode);
+	/* grab a reference */
+	inode->i_private = get_pid(pid);
+
+	/* consumes @inode */
+	dentry = d_make_root(inode);
+	if (!dentry)
+		return ERR_PTR(-ENOMEM);
+
+	i_ptr = atomic_long_cmpxchg(&pid->stashed, 0, (unsigned long)dentry);
+	if (i_ptr) {
+		d_delete(dentry); /* make sure ->d_prune() does nothing */
+		dput(dentry);
+		cpu_relax();
+		return ERR_PTR(-EAGAIN);
+	}
+
+	return dentry;
+}
+
+struct file *pidfdfs_alloc_file(struct pid *pid, unsigned int flags)
+{
+
+	struct path path;
+	struct dentry *dentry;
+	struct file *pidfd_file;
+
+	for (;;) {
+		rcu_read_lock();
+		dentry = (struct dentry *)atomic_long_read(&pid->stashed);
+		if (!dentry || !lockref_get_not_dead(&dentry->d_lockref)) {
+			rcu_read_unlock();
+
+			dentry = pidfdfs_dentry(pid);
+			if (!IS_ERR(dentry))
+				break;
+			if (PTR_ERR(dentry) == -EAGAIN)
+				continue;
+		}
+		rcu_read_unlock();
+		break;
+	}
+	if (IS_ERR(dentry))
+		return ERR_CAST(dentry);
+
+	path.mnt = mntget(pidfdfs_mnt);
+	path.dentry = dentry;
+
+	pidfd_file = dentry_open(&path, flags, current_cred());
+	path_put(&path);
+
+	return pidfd_file;
+}
+
+void pid_init_pidfdfs(struct pid *pid)
+{
+	atomic_long_set(&pid->stashed, 0);
+	pid->ino = ++pidfdfs_ino;
+}
+
+void __init pidfdfs_init(void)
+{
+	int err;
+
+	err = register_filesystem(&pidfdfs_type);
+	if (err)
+		panic("Failed to register pidfdfs pseudo filesystem");
+
+	pidfdfs_mnt = kern_mount(&pidfdfs_type);
+	if (IS_ERR(pidfdfs_mnt))
+		panic("Failed to mount pidfdfs pseudo filesystem");
+
+	pidfdfs_sb = pidfdfs_mnt->mnt_sb;
+}
+
+#else /* !CONFIG_FS_PIDFD */
+
+struct file *pidfdfs_alloc_file(struct pid *pid, unsigned int flags)
+{
+	struct file *pidfd_file;
+
+	pidfd_file = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
+					flags | O_RDWR);
+	if (IS_ERR(pidfd_file))
+		return pidfd_file;
+
+	get_pid(pid);
+	return pidfd_file;
+}
+
+void pid_init_pidfdfs(struct pid *pid) { }
+void __init pidfdfs_init(void) { }
+#endif
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 8124d57752b9..1a47676a04c2 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -55,6 +55,10 @@ struct pid
 	refcount_t count;
 	unsigned int level;
 	spinlock_t lock;
+#ifdef CONFIG_FS_PIDFD
+	atomic_long_t stashed;
+	unsigned long ino;
+#endif
 	/* lists of tasks that use this pid */
 	struct hlist_head tasks[PIDTYPE_MAX];
 	struct hlist_head inodes;
diff --git a/include/linux/pidfdfs.h b/include/linux/pidfdfs.h
new file mode 100644
index 000000000000..760dbc163625
--- /dev/null
+++ b/include/linux/pidfdfs.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PIDFDFS_H
+#define _LINUX_PIDFDFS_H
+
+struct file *pidfdfs_alloc_file(struct pid *pid, unsigned int flags);
+void __init pidfdfs_init(void);
+void pid_init_pidfdfs(struct pid *pid);
+
+#endif /* _LINUX_PIDFDFS_H */
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 6325d1d0e90f..a0d5480115c5 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -101,5 +101,6 @@
 #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
+#define PIDFDFS_MAGIC		0x50494446	/* "PIDF" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/init/main.c b/init/main.c
index e24b0780fdff..0663003f3146 100644
--- a/init/main.c
+++ b/init/main.c
@@ -99,6 +99,7 @@
 #include <linux/init_syscalls.h>
 #include <linux/stackdepot.h>
 #include <linux/randomize_kstack.h>
+#include <linux/pidfdfs.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -1059,6 +1060,7 @@ void start_kernel(void)
 	seq_file_init();
 	proc_root_init();
 	nsfs_init();
+	pidfdfs_init();
 	cpuset_init();
 	cgroup_init();
 	taskstats_init_early();
diff --git a/kernel/fork.c b/kernel/fork.c
index 662a61f340ce..eab2fcc90342 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -102,6 +102,7 @@
 #include <linux/iommu.h>
 #include <linux/rseq.h>
 #include <uapi/linux/pidfd.h>
+#include <linux/pidfdfs.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -1985,14 +1986,6 @@ static inline void rcu_copy_process(struct task_struct *p)
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
-struct pid *pidfd_pid(const struct file *file)
-{
-	if (file->f_op == &pidfd_fops)
-		return file->private_data;
-
-	return ERR_PTR(-EBADF);
-}
-
 /**
  * __pidfd_prepare - allocate a new pidfd_file and reserve a pidfd
  * @pid:   the struct pid for which to create a pidfd
@@ -2030,13 +2023,11 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
 	if (pidfd < 0)
 		return pidfd;
 
-	pidfd_file = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
-					flags | O_RDWR);
+	pidfd_file = pidfdfs_alloc_file(pid, flags | O_RDWR);
 	if (IS_ERR(pidfd_file)) {
 		put_unused_fd(pidfd);
 		return PTR_ERR(pidfd_file);
 	}
-	get_pid(pid); /* held by pidfd_file now */
 	/*
 	 * anon_inode_getfile() ignores everything outside of the
 	 * O_ACCMODE | O_NONBLOCK mask, set PIDFD_THREAD manually.
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 15781acaac1c..6ec3deec68c2 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -573,7 +573,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	if (proc_ns_file(f.file))
 		err = validate_ns(&nsset, ns);
 	else
-		err = validate_nsset(&nsset, f.file->private_data);
+		err = validate_nsset(&nsset, pidfd_pid(f.file));
 	if (!err) {
 		commit_nsset(&nsset);
 		perf_event_namespaces(current);
diff --git a/kernel/pid.c b/kernel/pid.c
index c1d940fbd314..dbff84493bff 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -42,6 +42,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/idr.h>
+#include <linux/pidfdfs.h>
 #include <net/sock.h>
 #include <uapi/linux/pidfd.h>
 
@@ -270,6 +271,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 
 	upid = pid->numbers + ns->level;
 	spin_lock_irq(&pidmap_lock);
+	pid_init_pidfdfs(pid);
 	if (!(ns->pid_allocated & PIDNS_ADDING))
 		goto out_unlock;
 	for ( ; upid >= pid->numbers; --upid) {

-- 
2.43.0


