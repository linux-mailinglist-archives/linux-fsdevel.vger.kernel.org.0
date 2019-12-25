Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCA7B12A7FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 14:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfLYNDS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 08:03:18 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:36196 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfLYNDQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 08:03:16 -0500
Received: from localhost.localdomain (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id C5DCEC61B14;
        Wed, 25 Dec 2019 12:53:16 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
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
        Solar Designer <solar@openwall.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v6 07/10] proc: flush task dcache entries from all procfs instances
Date:   Wed, 25 Dec 2019 13:51:48 +0100
Message-Id: <20191225125151.1950142-8-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191225125151.1950142-1-gladkov.alexey@gmail.com>
References: <20191225125151.1950142-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows to flush dcache entries of a task on multiple procfs mounts
per pid namespace.

Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/proc/base.c                | 23 ++++++++++++++-----
 fs/proc/root.c                | 14 ++++++++++++
 include/linux/pid_namespace.h | 42 +++++++++++++++++++++++++++++++++++
 include/linux/proc_fs.h       |  2 ++
 4 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4ccb280a3e79..f4f1bcb28603 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3133,7 +3133,7 @@ static const struct inode_operations proc_tgid_base_inode_operations = {
 	.permission	= proc_pid_permission,
 };
 
-static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
+static void proc_flush_task_mnt_root(struct dentry *mnt_root, pid_t pid, pid_t tgid)
 {
 	struct dentry *dentry, *leader, *dir;
 	char buf[10 + 1];
@@ -3142,7 +3142,7 @@ static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
 	name.name = buf;
 	name.len = snprintf(buf, sizeof(buf), "%u", pid);
 	/* no ->d_hash() rejects on procfs */
-	dentry = d_hash_and_lookup(mnt->mnt_root, &name);
+	dentry = d_hash_and_lookup(mnt_root, &name);
 	if (dentry) {
 		d_invalidate(dentry);
 		dput(dentry);
@@ -3153,7 +3153,7 @@ static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
 
 	name.name = buf;
 	name.len = snprintf(buf, sizeof(buf), "%u", tgid);
-	leader = d_hash_and_lookup(mnt->mnt_root, &name);
+	leader = d_hash_and_lookup(mnt_root, &name);
 	if (!leader)
 		goto out;
 
@@ -3208,14 +3208,27 @@ void proc_flush_task(struct task_struct *task)
 	int i;
 	struct pid *pid, *tgid;
 	struct upid *upid;
+	struct pid_namespace *pid_ns;
+	struct dentry *mnt_root;
+	struct proc_fs_info *fs_info;
 
 	pid = task_pid(task);
 	tgid = task_tgid(task);
 
 	for (i = 0; i <= pid->level; i++) {
 		upid = &pid->numbers[i];
-		proc_flush_task_mnt(upid->ns->proc_mnt, upid->nr,
-					tgid->numbers[i].nr);
+
+		pid_ns = upid->ns;
+
+		pidns_proc_lock_shared(pid_ns);
+		list_for_each_entry(fs_info, &pid_ns->proc_mounts, pidns_entry) {
+			mnt_root = fs_info->m_super->s_root;
+			proc_flush_task_mnt_root(mnt_root, upid->nr, tgid->numbers[i].nr);
+		}
+		pidns_proc_unlock_shared(pid_ns);
+
+		mnt_root = pid_ns->proc_mnt->mnt_root;
+		proc_flush_task_mnt_root(mnt_root, upid->nr, tgid->numbers[i].nr);
 	}
 }
 
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 5d5cba4c899b..3bb8df360cf7 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -112,6 +112,12 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 
 	proc_apply_options(ctx->fs_info, fc, pid_ns, current_user_ns());
 
+	ctx->fs_info->m_super = s;
+
+	pidns_proc_lock(pid_ns);
+	list_add_tail(&ctx->fs_info->pidns_entry, &pid_ns->proc_mounts);
+	pidns_proc_unlock(pid_ns);
+
 	/* User space would break if executables or devices appear on proc */
 	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
 	s->s_flags |= SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
@@ -215,6 +221,11 @@ static void proc_kill_sb(struct super_block *sb)
 		dput(fs_info->proc_self);
 	if (fs_info->proc_thread_self)
 		dput(fs_info->proc_thread_self);
+
+	pidns_proc_lock(fs_info->pid_ns);
+	list_del(&fs_info->pidns_entry);
+	pidns_proc_unlock(fs_info->pid_ns);
+
 	kill_anon_super(sb);
 	put_pid_ns(fs_info->pid_ns);
 	kfree(fs_info);
@@ -336,6 +347,9 @@ int pid_ns_prepare_proc(struct pid_namespace *ns)
 		ctx->fs_info->pid_ns = ns;
 	}
 
+	init_rwsem(&ns->rw_proc_mounts);
+	INIT_LIST_HEAD(&ns->proc_mounts);
+
 	mnt = fc_mount(fc);
 	put_fs_context(fc);
 	if (IS_ERR(mnt))
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 66f47f1afe0d..297b39604312 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -26,6 +26,8 @@ struct pid_namespace {
 	struct pid_namespace *parent;
 #ifdef CONFIG_PROC_FS
 	struct vfsmount *proc_mnt; /* Internal proc mounted during each new pidns */
+	struct rw_semaphore rw_proc_mounts;
+	struct list_head proc_mounts; /* list of separated procfs mounts */
 #endif
 #ifdef CONFIG_BSD_PROCESS_ACCT
 	struct fs_pin *bacct;
@@ -90,4 +92,44 @@ extern struct pid_namespace *task_active_pid_ns(struct task_struct *tsk);
 void pidhash_init(void);
 void pid_idr_init(void);
 
+#ifdef CONFIG_PROC_FS
+static inline void pidns_proc_lock(struct pid_namespace *pid_ns)
+{
+	down_write(&pid_ns->rw_proc_mounts);
+}
+
+static inline void pidns_proc_unlock(struct pid_namespace *pid_ns)
+{
+	up_write(&pid_ns->rw_proc_mounts);
+}
+
+static inline void pidns_proc_lock_shared(struct pid_namespace *pid_ns)
+{
+	down_read(&pid_ns->rw_proc_mounts);
+}
+
+static inline void pidns_proc_unlock_shared(struct pid_namespace *pid_ns)
+{
+	up_read(&pid_ns->rw_proc_mounts);
+}
+#else /* !CONFIG_PROC_FS */
+
+static inline void pidns_proc_lock(struct pid_namespace *pid_ns)
+{
+}
+
+static inline void pidns_proc_unlock(struct pid_namespace *pid_ns)
+{
+}
+
+static inline void pidns_proc_lock_shared(struct pid_namespace *pid_ns)
+{
+}
+
+static inline void pidns_proc_unlock_shared(struct pid_namespace *pid_ns)
+{
+}
+
+#endif /* CONFIG_PROC_FS */
+
 #endif /* _LINUX_PID_NS_H */
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index fd92bf38aa62..e349fcafd729 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -20,6 +20,8 @@ enum {
 };
 
 struct proc_fs_info {
+	struct list_head pidns_entry;    /* Node in procfs_mounts of a pidns */
+	struct super_block *m_super;
 	struct pid_namespace *pid_ns;
 	struct dentry *proc_self;        /* For /proc/self */
 	struct dentry *proc_thread_self; /* For /proc/thread-self */
-- 
2.24.1

