Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888841B5A8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 13:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgDWLaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 07:30:07 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:33224 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgDWLaH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:30:07 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 7276B20A01;
        Thu, 23 Apr 2020 11:29:27 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v13 2/7] proc: allow to mount many instances of proc in one pid namespace
Date:   Thu, 23 Apr 2020 13:28:58 +0200
Message-Id: <20200423112858.95820-1-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200419141057.621356-3-gladkov.alexey@gmail.com>
References: <20200419141057.621356-3-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Thu, 23 Apr 2020 11:30:01 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch allows to have multiple procfs instances inside the
same pid namespace. The aim here is lightweight sandboxes, and to allow
that we have to modernize procfs internals.

1) The main aim of this work is to have on embedded systems one
supervisor for apps. Right now we have some lightweight sandbox support,
however if we create pid namespacess we have to manages all the
processes inside too, where our goal is to be able to run a bunch of
apps each one inside its own mount namespace without being able to
notice each other. We only want to use mount namespaces, and we want
procfs to behave more like a real mount point.

2) Linux Security Modules have multiple ptrace paths inside some
subsystems, however inside procfs, the implementation does not guarantee
that the ptrace() check which triggers the security_ptrace_check() hook
will always run. We have the 'hidepid' mount option that can be used to
force the ptrace_may_access() check inside has_pid_permissions() to run.
The problem is that 'hidepid' is per pid namespace and not attached to
the mount point, any remount or modification of 'hidepid' will propagate
to all other procfs mounts.

This also does not allow to support Yama LSM easily in desktop and user
sessions. Yama ptrace scope which restricts ptrace and some other
syscalls to be allowed only on inferiors, can be updated to have a
per-task context, where the context will be inherited during fork(),
clone() and preserved across execve(). If we support multiple private
procfs instances, then we may force the ptrace_may_access() on
/proc/<pids>/ to always run inside that new procfs instances. This will
allow to specifiy on user sessions if we should populate procfs with
pids that the user can ptrace or not.

By using Yama ptrace scope, some restricted users will only be able to see
inferiors inside /proc, they won't even be able to see their other
processes. Some software like Chromium, Firefox's crash handler, Wine
and others are already using Yama to restrict which processes can be
ptracable. With this change this will give the possibility to restrict
/proc/<pids>/ but more importantly this will give desktop users a
generic and usuable way to specifiy which users should see all processes
and which users can not.

Side notes:
* This covers the lack of seccomp where it is not able to parse
arguments, it is easy to install a seccomp filter on direct syscalls
that operate on pids, however /proc/<pid>/ is a Linux ABI using
filesystem syscalls. With this change LSMs should be able to analyze
open/read/write/close...

In the new patch set version I removed the 'newinstance' option
as suggested by Eric W. Biederman.

Selftest has been added to verify new behavior.

Fixed getting proc_pidns in the lock_get_status() and locks_show() directly from
the superblock, which caused a crash:

=== arm64 ===
[12140.366814] LTP: starting proc01 (proc01 -m 128)
[12149.580943] ==================================================================
[12149.589521] BUG: KASAN: out-of-bounds in pid_nr_ns+0x2c/0x90 pid_nr_ns at kernel/pid.c:456
[12149.595939] Read of size 4 at addr 1bff000bfa8c0388 by task = proc01/50298
[12149.603392] Pointer tag: [1b], memory tag: [fe]

[12149.610906] CPU: 69 PID: 50298 Comm: proc01 Tainted: G L 5.7.0-rc2-next-20200422 #6
[12149.620585] Hardware name: HPE Apollo 70 /C01_APACHE_MB , BIOS L50_5.13_1.11 06/18/2019
[12149.631074] Call trace:
[12149.634304]  dump_backtrace+0x0/0x22c
[12149.638745]  show_stack+0x28/0x34
[12149.642839]  dump_stack+0x104/0x194
[12149.647110]  print_address_description+0x70/0x3a4
[12149.652576]  __kasan_report+0x188/0x238
[12149.657169]  kasan_report+0x3c/0x58
[12149.661430]  check_memory_region+0x98/0xa0
[12149.666303]  __hwasan_load4_noabort+0x18/0x20
[12149.671431]  pid_nr_ns+0x2c/0x90
[12149.675446]  locks_translate_pid+0xf4/0x1a0
[12149.680382]  locks_show+0x68/0x110
[12149.684536]  seq_read+0x380/0x930
[12149.688604]  pde_read+0x5c/0x78
[12149.692498]  proc_reg_read+0x74/0xc0
[12149.696813]  __vfs_read+0x84/0x1d0
[12149.700939]  vfs_read+0xec/0x124
[12149.704889]  ksys_read+0xb0/0x120
[12149.708927]  __arm64_sys_read+0x54/0x88
[12149.713485]  do_el0_svc+0x128/0x1dc
[12149.717697]  el0_sync_handler+0x150/0x250
[12149.722428]  el0_sync+0x164/0x180

[12149.728672] Allocated by task 1:
[12149.732624]  __kasan_kmalloc+0x124/0x188
[12149.737269]  kasan_kmalloc+0x10/0x18
[12149.741568]  kmem_cache_alloc_trace+0x2e4/0x3d4
[12149.746820]  proc_fill_super+0x48/0x1fc
[12149.751377]  vfs_get_super+0xcc/0x170
[12149.755760]  get_tree_nodev+0x28/0x34
[12149.760143]  proc_get_tree+0x24/0x30
[12149.764439]  vfs_get_tree+0x54/0x158
[12149.768736]  do_mount+0x80c/0xaf0
[12149.772774]  __arm64_sys_mount+0xe0/0x18c
[12149.777504]  do_el0_svc+0x128/0x1dc
[12149.781715]  el0_sync_handler+0x150/0x250
[12149.786445]  el0_sync+0x164/0x180

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/locks.c                                    |  4 +-
 fs/proc/base.c                                | 31 +++++++-----
 fs/proc/inode.c                               | 11 ++---
 fs/proc/root.c                                | 49 +++++++++----------
 fs/proc/self.c                                |  6 +--
 fs/proc/thread_self.c                         |  6 +--
 include/linux/pid_namespace.h                 | 12 -----
 include/linux/proc_fs.h                       | 22 ++++++++-
 tools/testing/selftests/proc/.gitignore       |  1 +
 tools/testing/selftests/proc/Makefile         |  1 +
 .../selftests/proc/proc-multiple-procfs.c     | 48 ++++++++++++++++++
 11 files changed, 126 insertions(+), 65 deletions(-)
 create mode 100644 tools/testing/selftests/proc/proc-multiple-procfs.c

diff --git a/fs/locks.c b/fs/locks.c
index b8a31c1c4fff..399c5dbb72c4 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2823,7 +2823,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 {
 	struct inode *inode = NULL;
 	unsigned int fl_pid;
-	struct pid_namespace *proc_pidns = file_inode(f->file)->i_sb->s_fs_info;
+	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file));
 
 	fl_pid = locks_translate_pid(fl, proc_pidns);
 	/*
@@ -2901,7 +2901,7 @@ static int locks_show(struct seq_file *f, void *v)
 {
 	struct locks_iterator *iter = f->private;
 	struct file_lock *fl, *bfl;
-	struct pid_namespace *proc_pidns = file_inode(f->file)->i_sb->s_fs_info;
+	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file));
 
 	fl = hlist_entry(v, struct file_lock, fl_link);
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6042b646ab27..93b5d05c142c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -697,13 +697,13 @@ int proc_setattr(struct dentry *dentry, struct iattr *attr)
  * May current process learn task's sched/cmdline info (for hide_pid_min=1)
  * or euid/egid (for hide_pid_min=2)?
  */
-static bool has_pid_permissions(struct pid_namespace *pid,
+static bool has_pid_permissions(struct proc_fs_info *fs_info,
 				 struct task_struct *task,
 				 int hide_pid_min)
 {
-	if (pid->hide_pid < hide_pid_min)
+	if (fs_info->hide_pid < hide_pid_min)
 		return true;
-	if (in_group_p(pid->pid_gid))
+	if (in_group_p(fs_info->pid_gid))
 		return true;
 	return ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
 }
@@ -711,18 +711,18 @@ static bool has_pid_permissions(struct pid_namespace *pid,
 
 static int proc_pid_permission(struct inode *inode, int mask)
 {
-	struct pid_namespace *pid = proc_pid_ns(inode);
+	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
 	struct task_struct *task;
 	bool has_perms;
 
 	task = get_proc_task(inode);
 	if (!task)
 		return -ESRCH;
-	has_perms = has_pid_permissions(pid, task, HIDEPID_NO_ACCESS);
+	has_perms = has_pid_permissions(fs_info, task, HIDEPID_NO_ACCESS);
 	put_task_struct(task);
 
 	if (!has_perms) {
-		if (pid->hide_pid == HIDEPID_INVISIBLE) {
+		if (fs_info->hide_pid == HIDEPID_INVISIBLE) {
 			/*
 			 * Let's make getdents(), stat(), and open()
 			 * consistent with each other.  If a process
@@ -1897,7 +1897,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
 		u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
-	struct pid_namespace *pid = proc_pid_ns(inode);
+	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
 	struct task_struct *task;
 
 	generic_fillattr(inode, stat);
@@ -1907,7 +1907,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
 	rcu_read_lock();
 	task = pid_task(proc_pid(inode), PIDTYPE_PID);
 	if (task) {
-		if (!has_pid_permissions(pid, task, HIDEPID_INVISIBLE)) {
+		if (!has_pid_permissions(fs_info, task, HIDEPID_INVISIBLE)) {
 			rcu_read_unlock();
 			/*
 			 * This doesn't prevent learning whether PID exists,
@@ -3301,6 +3301,7 @@ struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
 {
 	struct task_struct *task;
 	unsigned tgid;
+	struct proc_fs_info *fs_info;
 	struct pid_namespace *ns;
 	struct dentry *result = ERR_PTR(-ENOENT);
 
@@ -3308,7 +3309,8 @@ struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
 	if (tgid == ~0U)
 		goto out;
 
-	ns = dentry->d_sb->s_fs_info;
+	fs_info = proc_sb_info(dentry->d_sb);
+	ns = fs_info->pid_ns;
 	rcu_read_lock();
 	task = find_task_by_pid_ns(tgid, ns);
 	if (task)
@@ -3372,6 +3374,7 @@ static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter ite
 int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct tgid_iter iter;
+	struct proc_fs_info *fs_info = proc_sb_info(file_inode(file)->i_sb);
 	struct pid_namespace *ns = proc_pid_ns(file_inode(file));
 	loff_t pos = ctx->pos;
 
@@ -3379,13 +3382,13 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 		return 0;
 
 	if (pos == TGID_OFFSET - 2) {
-		struct inode *inode = d_inode(ns->proc_self);
+		struct inode *inode = d_inode(fs_info->proc_self);
 		if (!dir_emit(ctx, "self", 4, inode->i_ino, DT_LNK))
 			return 0;
 		ctx->pos = pos = pos + 1;
 	}
 	if (pos == TGID_OFFSET - 1) {
-		struct inode *inode = d_inode(ns->proc_thread_self);
+		struct inode *inode = d_inode(fs_info->proc_thread_self);
 		if (!dir_emit(ctx, "thread-self", 11, inode->i_ino, DT_LNK))
 			return 0;
 		ctx->pos = pos = pos + 1;
@@ -3399,7 +3402,7 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 		unsigned int len;
 
 		cond_resched();
-		if (!has_pid_permissions(ns, iter.task, HIDEPID_INVISIBLE))
+		if (!has_pid_permissions(fs_info, iter.task, HIDEPID_INVISIBLE))
 			continue;
 
 		len = snprintf(name, sizeof(name), "%u", iter.tgid);
@@ -3599,6 +3602,7 @@ static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry
 	struct task_struct *task;
 	struct task_struct *leader = get_proc_task(dir);
 	unsigned tid;
+	struct proc_fs_info *fs_info;
 	struct pid_namespace *ns;
 	struct dentry *result = ERR_PTR(-ENOENT);
 
@@ -3609,7 +3613,8 @@ static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry
 	if (tid == ~0U)
 		goto out;
 
-	ns = dentry->d_sb->s_fs_info;
+	fs_info = proc_sb_info(dentry->d_sb);
+	ns = fs_info->pid_ns;
 	rcu_read_lock();
 	task = find_task_by_pid_ns(tid, ns);
 	if (task)
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index fb4cace9ea41..9c756531282a 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -167,13 +167,12 @@ void proc_invalidate_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock
 
 static int proc_show_options(struct seq_file *seq, struct dentry *root)
 {
-	struct super_block *sb = root->d_sb;
-	struct pid_namespace *pid = sb->s_fs_info;
+	struct proc_fs_info *fs_info = proc_sb_info(root->d_sb);
 
-	if (!gid_eq(pid->pid_gid, GLOBAL_ROOT_GID))
-		seq_printf(seq, ",gid=%u", from_kgid_munged(&init_user_ns, pid->pid_gid));
-	if (pid->hide_pid != HIDEPID_OFF)
-		seq_printf(seq, ",hidepid=%u", pid->hide_pid);
+	if (!gid_eq(fs_info->pid_gid, GLOBAL_ROOT_GID))
+		seq_printf(seq, ",gid=%u", from_kgid_munged(&init_user_ns, fs_info->pid_gid));
+	if (fs_info->hide_pid != HIDEPID_OFF)
+		seq_printf(seq, ",hidepid=%u", fs_info->hide_pid);
 
 	return 0;
 }
diff --git a/fs/proc/root.c b/fs/proc/root.c
index cdbe9293ea55..208989274923 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -77,26 +77,31 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
-static void proc_apply_options(struct super_block *s,
+static void proc_apply_options(struct proc_fs_info *fs_info,
 			       struct fs_context *fc,
-			       struct pid_namespace *pid_ns,
 			       struct user_namespace *user_ns)
 {
 	struct proc_fs_context *ctx = fc->fs_private;
 
 	if (ctx->mask & (1 << Opt_gid))
-		pid_ns->pid_gid = make_kgid(user_ns, ctx->gid);
+		fs_info->pid_gid = make_kgid(user_ns, ctx->gid);
 	if (ctx->mask & (1 << Opt_hidepid))
-		pid_ns->hide_pid = ctx->hidepid;
+		fs_info->hide_pid = ctx->hidepid;
 }
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 {
-	struct pid_namespace *pid_ns = get_pid_ns(s->s_fs_info);
+	struct proc_fs_context *ctx = fc->fs_private;
 	struct inode *root_inode;
+	struct proc_fs_info *fs_info;
 	int ret;
 
-	proc_apply_options(s, fc, pid_ns, current_user_ns());
+	fs_info = kzalloc(sizeof(*fs_info), GFP_KERNEL);
+	if (!fs_info)
+		return -ENOMEM;
+
+	fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
+	proc_apply_options(fs_info, fc, current_user_ns());
 
 	/* User space would break if executables or devices appear on proc */
 	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
@@ -106,6 +111,7 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_magic = PROC_SUPER_MAGIC;
 	s->s_op = &proc_sops;
 	s->s_time_gran = 1;
+	s->s_fs_info = fs_info;
 
 	/*
 	 * procfs isn't actually a stacking filesystem; however, there is
@@ -113,7 +119,7 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 	 * top of it
 	 */
 	s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
-	
+
 	/* procfs dentries and inodes don't require IO to create */
 	s->s_shrink.seeks = 0;
 
@@ -140,19 +146,17 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 static int proc_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
-	struct pid_namespace *pid = sb->s_fs_info;
+	struct proc_fs_info *fs_info = proc_sb_info(sb);
 
 	sync_filesystem(sb);
 
-	proc_apply_options(sb, fc, pid, current_user_ns());
+	proc_apply_options(fs_info, fc, current_user_ns());
 	return 0;
 }
 
 static int proc_get_tree(struct fs_context *fc)
 {
-	struct proc_fs_context *ctx = fc->fs_private;
-
-	return get_tree_keyed(fc, proc_fill_super, ctx->pid_ns);
+	return get_tree_nodev(fc, proc_fill_super);
 }
 
 static void proc_fs_context_free(struct fs_context *fc)
@@ -188,22 +192,17 @@ static int proc_init_fs_context(struct fs_context *fc)
 
 static void proc_kill_sb(struct super_block *sb)
 {
-	struct pid_namespace *ns;
+	struct proc_fs_info *fs_info = proc_sb_info(sb);
 
-	ns = (struct pid_namespace *)sb->s_fs_info;
-	if (ns->proc_self)
-		dput(ns->proc_self);
-	if (ns->proc_thread_self)
-		dput(ns->proc_thread_self);
-	kill_anon_super(sb);
+	if (fs_info->proc_self)
+		dput(fs_info->proc_self);
 
-	/* Make the pid namespace safe for the next mount of proc */
-	ns->proc_self = NULL;
-	ns->proc_thread_self = NULL;
-	ns->pid_gid = GLOBAL_ROOT_GID;
-	ns->hide_pid = 0;
+	if (fs_info->proc_thread_self)
+		dput(fs_info->proc_thread_self);
 
-	put_pid_ns(ns);
+	kill_anon_super(sb);
+	put_pid_ns(fs_info->pid_ns);
+	kfree(fs_info);
 }
 
 static struct file_system_type proc_fs_type = {
diff --git a/fs/proc/self.c b/fs/proc/self.c
index 57c0a1047250..309301ac0136 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -36,10 +36,10 @@ static unsigned self_inum __ro_after_init;
 int proc_setup_self(struct super_block *s)
 {
 	struct inode *root_inode = d_inode(s->s_root);
-	struct pid_namespace *ns = proc_pid_ns(root_inode);
+	struct proc_fs_info *fs_info = proc_sb_info(s);
 	struct dentry *self;
 	int ret = -ENOMEM;
-	
+
 	inode_lock(root_inode);
 	self = d_alloc_name(s->s_root, "self");
 	if (self) {
@@ -62,7 +62,7 @@ int proc_setup_self(struct super_block *s)
 	if (ret)
 		pr_err("proc_fill_super: can't allocate /proc/self\n");
 	else
-		ns->proc_self = self;
+		fs_info->proc_self = self;
 
 	return ret;
 }
diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index f61ae53533f5..2493cbbdfa6f 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -36,7 +36,7 @@ static unsigned thread_self_inum __ro_after_init;
 int proc_setup_thread_self(struct super_block *s)
 {
 	struct inode *root_inode = d_inode(s->s_root);
-	struct pid_namespace *ns = proc_pid_ns(root_inode);
+	struct proc_fs_info *fs_info = proc_sb_info(s);
 	struct dentry *thread_self;
 	int ret = -ENOMEM;
 
@@ -60,9 +60,9 @@ int proc_setup_thread_self(struct super_block *s)
 	inode_unlock(root_inode);
 
 	if (ret)
-		pr_err("proc_fill_super: can't allocate /proc/thread_self\n");
+		pr_err("proc_fill_super: can't allocate /proc/thread-self\n");
 	else
-		ns->proc_thread_self = thread_self;
+		fs_info->proc_thread_self = thread_self;
 
 	return ret;
 }
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 4956e362e55e..5a5cb45ac57e 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -17,12 +17,6 @@
 
 struct fs_pin;
 
-enum { /* definitions for pid_namespace's hide_pid field */
-	HIDEPID_OFF	  = 0,
-	HIDEPID_NO_ACCESS = 1,
-	HIDEPID_INVISIBLE = 2,
-};
-
 struct pid_namespace {
 	struct kref kref;
 	struct idr idr;
@@ -32,17 +26,11 @@ struct pid_namespace {
 	struct kmem_cache *pid_cachep;
 	unsigned int level;
 	struct pid_namespace *parent;
-#ifdef CONFIG_PROC_FS
-	struct dentry *proc_self;
-	struct dentry *proc_thread_self;
-#endif
 #ifdef CONFIG_BSD_PROCESS_ACCT
 	struct fs_pin *bacct;
 #endif
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
-	kgid_t pid_gid;
-	int hide_pid;
 	int reboot;	/* group exit code if this pidns was rebooted */
 	struct ns_common ns;
 } __randomize_layout;
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 45c05fd9c99d..1b98a41fdd8a 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -42,6 +42,26 @@ struct proc_ops {
 	unsigned long (*proc_get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 } __randomize_layout;
 
+/* definitions for hide_pid field */
+enum {
+	HIDEPID_OFF	  = 0,
+	HIDEPID_NO_ACCESS = 1,
+	HIDEPID_INVISIBLE = 2,
+};
+
+struct proc_fs_info {
+	struct pid_namespace *pid_ns;
+	struct dentry *proc_self;        /* For /proc/self */
+	struct dentry *proc_thread_self; /* For /proc/thread-self */
+	kgid_t pid_gid;
+	int hide_pid;
+};
+
+static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
 #ifdef CONFIG_PROC_FS
 
 typedef int (*proc_write_t)(struct file *, char *, size_t);
@@ -176,7 +196,7 @@ int open_related_ns(struct ns_common *ns,
 /* get the associated pid namespace for a file in procfs */
 static inline struct pid_namespace *proc_pid_ns(const struct inode *inode)
 {
-	return inode->i_sb->s_fs_info;
+	return proc_sb_info(inode->i_sb)->pid_ns;
 }
 
 #endif /* _LINUX_PROC_FS_H */
diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/selftests/proc/.gitignore
index 4bca5a9327a4..126901c5d6f4 100644
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -3,6 +3,7 @@
 /fd-002-posix-eq
 /fd-003-kthread
 /proc-loadavg-001
+/proc-multiple-procfs
 /proc-pid-vm
 /proc-self-map-files-001
 /proc-self-map-files-002
diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index a8ed0f684829..bf22457256be 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -19,5 +19,6 @@ TEST_GEN_PROGS += self
 TEST_GEN_PROGS += setns-dcache
 TEST_GEN_PROGS += setns-sysvipc
 TEST_GEN_PROGS += thread-self
+TEST_GEN_PROGS += proc-multiple-procfs
 
 include ../lib.mk
diff --git a/tools/testing/selftests/proc/proc-multiple-procfs.c b/tools/testing/selftests/proc/proc-multiple-procfs.c
new file mode 100644
index 000000000000..ab912ad95dab
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-multiple-procfs.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright © 2020 Alexey Gladkov <gladkov.alexey@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+#include <assert.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/mount.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+int main(void)
+{
+	struct stat proc_st1, proc_st2;
+	char procbuff[] = "/tmp/proc.XXXXXX/meminfo";
+	char procdir1[] = "/tmp/proc.XXXXXX";
+	char procdir2[] = "/tmp/proc.XXXXXX";
+
+	assert(mkdtemp(procdir1) != NULL);
+	assert(mkdtemp(procdir2) != NULL);
+
+	assert(!mount("proc", procdir1, "proc", 0, "hidepid=1"));
+	assert(!mount("proc", procdir2, "proc", 0, "hidepid=2"));
+
+	snprintf(procbuff, sizeof(procbuff), "%s/meminfo", procdir1);
+	assert(!stat(procbuff, &proc_st1));
+
+	snprintf(procbuff, sizeof(procbuff), "%s/meminfo", procdir2);
+	assert(!stat(procbuff, &proc_st2));
+
+	umount(procdir1);
+	umount(procdir2);
+
+	assert(proc_st1.st_dev != proc_st2.st_dev);
+
+	return 0;
+}
-- 
2.25.3

