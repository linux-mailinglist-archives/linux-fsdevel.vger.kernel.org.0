Return-Path: <linux-fsdevel+bounces-11594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276BB85520F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 19:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F9C1F29A75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E78A128395;
	Wed, 14 Feb 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIjp7SGb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3257128360
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935260; cv=none; b=KOZOpratNg06JAR2tX9lVL9wKyIbsFqPctGkbSJugLv67K6xH2Q8HvhxevVw/HTEE+JplAZdbS1KGU53AXk/+1sXo5llMrUAw+zBJUvzKdK/AV5onOXpwFCIEiC9EEBpCCJFbulGhmIYoHJB93W7OGMM0LoUEF6aOAl7UCsvf8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935260; c=relaxed/simple;
	bh=eWMcKuQcX//tv42JjDwySXAX7+Ft4kCcsDdJ75TKCg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMJ/LeFVkVjLs8IpDSOiJfNdIC3iuPwlXRK3ksCKb6acEl3yXdgJW+jd3Cxw6hhCCw02Wn/Zwujfqsk7JvrpZU12avaDb2ExVYRVJzXU6lWvL4tM8kN/rGoMw3FTNXJuLHMPYW048SZwVFFU6aIyudPJRfcgO0NixqdKxoa21Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIjp7SGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48696C433F1;
	Wed, 14 Feb 2024 18:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707935259;
	bh=eWMcKuQcX//tv42JjDwySXAX7+Ft4kCcsDdJ75TKCg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIjp7SGbGYG4mpDgQ1c4+A6DhBBCW02B5TqQDQrUVlzZCXev+dWbsem7PN9qRfRk7
	 kJ8MQhDLWXontLnucRrpMQHDLVaeSeXcyW6e/Y+iULRNH3VgmwZrxDWQz+ESDHxFJn
	 0uoKAgckqu5f0ZE7txoVL2U/Tu2nCyiZmI/ZC6hVflJ9eP+cznQQ9frzVQ9R2R/v6+
	 Th/fMjwqJg1p4bvFST27Eq+IK14M5kWLYtJeMDTruRn28QHkL6M3QP0Wn2dFpgCfcp
	 GpKsn88gkQV16BoFcuCeBA5GCR94lSgweX9BrKMCCe7hM1SyphyGsMYEHLjn+J3va/
	 bVNb0xc9KatEQ==
Date: Wed, 14 Feb 2024 19:27:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240214-kanal-laufleistung-d884f8a1f5f2@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
 <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner>

On Wed, Feb 14, 2024 at 03:40:26PM +0100, Christian Brauner wrote:
> On Tue, Feb 13, 2024 at 09:17:18AM -0800, Linus Torvalds wrote:
> > On Tue, 13 Feb 2024 at 08:46, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > * Each struct pid will refer to a different inode but the same struct
> > >   pid will refer to the same inode if it's opened multiple times. In
> > >   contrast to now where each struct pid refers to the same inode.
> > 
> > The games for this are disgusting. This needs to be done some other way.
> 
> Yeah, I'm not particularly happy about it and I did consider deviating
> from this completely and doing a lookup based on stashed inode number
> alone. But that would've been a bit more code. Let me see though.

Ok, that turned out to be simpler than I had evisioned - unless I made
horrible mistakes:

From c96d88910d029ea639902d245619acbd910fc32d Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Feb 2024 16:32:38 +0100
Subject: [PATCH] [RFC] pidfd: add pidfdfs

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

The tiny pseudo filesystem is not visible anywhere in userspace exactly
like e.g., pipefs and sockfs. There's no lookup, there's no complex
inode operations, nothing. Dentries and inodes are always deleted when
the last pidfd is closed.

We allocate a new inode for each struct pid and we reuse that inode for
all pidfds. We use iget_locked() to find that inode again based on the
inode number which isn't recycled. We allocate a new dentry for each
pidfd that uses the same inode. That is similar to anonymous inodes
which reuse the same inode for thousands of dentries. For pidfds we're
talking way less than that. There usually won't be a lot of concurrent
openers of the same struct pid. They can probably often be counted on
two hands. I know that systemd does use separate pidfd for the same
struct pid for various complex process tracking issues. So I think with
that things actually become way simpler. Especially because we don't
have to care about lookup. Dentries and inodes continue to be always
deleted.

The code is entirely optional and fairly small. If it's not selected we
fallback to anonymous inodes. Heavily inspired by nsfs which uses a
similar stashing mechanism just for namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/Kconfig                 |   6 ++
 fs/pidfdfs.c               | 134 ++++++++++++++++++++++++++++++++++++-
 include/linux/pid.h        |   3 +
 include/linux/pidfdfs.h    |   9 +++
 include/uapi/linux/magic.h |   1 +
 init/main.c                |   2 +
 kernel/fork.c              |  13 +---
 kernel/nsproxy.c           |   2 +-
 kernel/pid.c               |   2 +
 9 files changed, 158 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/pidfdfs.h

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
index 55e8396e7fc4..80caf1759f97 100644
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
@@ -121,3 +136,118 @@ const struct file_operations pidfd_fops = {
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
+	.drop_inode	= generic_delete_inode,
+	.evict_inode	= pidfdfs_evict_inode,
+	.statfs		= simple_statfs,
+};
+
+static char *pidfdfs_dname(struct dentry *dentry, char *buffer, int buflen)
+{
+	return dynamic_dname(buffer, buflen, "pidfd:[%lu]",
+			     d_inode(dentry)->i_ino);
+}
+
+const struct dentry_operations pidfdfs_dentry_operations = {
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
+struct file *pidfdfs_alloc_file(struct pid *pid, unsigned int flags)
+{
+
+	struct inode *inode;
+	struct file *pidfd_file;
+
+	inode = iget_locked(pidfdfs_sb, pid->ino);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	if (inode->i_state & I_NEW) {
+		inode->i_ino = pid->ino;
+		inode->i_mode = S_IFREG | S_IRUGO;
+		inode->i_fop = &pidfd_fops;
+		inode->i_flags |= S_IMMUTABLE;
+		inode->i_private = get_pid(pid);
+		simple_inode_init_ts(inode);
+		unlock_new_inode(inode);
+	}
+
+	pidfd_file = alloc_file_pseudo(inode, pidfdfs_mnt, "", flags, &pidfd_fops);
+	if (IS_ERR(pidfd_file))
+		iput(inode);
+
+	return pidfd_file;
+}
+
+void pid_init_pidfdfs(struct pid *pid)
+{
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
index 8124d57752b9..7b6f5deab36a 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -55,6 +55,9 @@ struct pid
 	refcount_t count;
 	unsigned int level;
 	spinlock_t lock;
+#ifdef CONFIG_FS_PIDFD
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


