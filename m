Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDFD3157E2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 16:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgBJPGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 10:06:18 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:54120 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729230AbgBJPGR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:06:17 -0500
Received: from comp-core-i7-2640m-0182e6.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id 52C9AC61B22;
        Mon, 10 Feb 2020 15:06:14 +0000 (UTC)
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
        Solar Designer <solar@openwall.com>
Subject: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
Date:   Mon, 10 Feb 2020 16:05:15 +0100
Message-Id: <20200210150519.538333-8-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210150519.538333-1-gladkov.alexey@gmail.com>
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows to flush dcache entries of a task on multiple procfs mounts
per pid namespace.

The RCU lock is used because the number of reads at the task exit time
is much larger than the number of procfs mounts.

Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/proc/base.c                | 20 +++++++++++++++-----
 fs/proc/root.c                | 27 ++++++++++++++++++++++++++-
 include/linux/pid_namespace.h |  2 ++
 include/linux/proc_fs.h       |  2 ++
 4 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4ccb280a3e79..24b7c620ded3 100644
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
 
@@ -3208,14 +3208,24 @@ void proc_flush_task(struct task_struct *task)
 	int i;
 	struct pid *pid, *tgid;
 	struct upid *upid;
+	struct dentry *mnt_root;
+	struct proc_fs_info *fs_info;
 
 	pid = task_pid(task);
 	tgid = task_tgid(task);
 
 	for (i = 0; i <= pid->level; i++) {
 		upid = &pid->numbers[i];
-		proc_flush_task_mnt(upid->ns->proc_mnt, upid->nr,
-					tgid->numbers[i].nr);
+
+		rcu_read_lock();
+		list_for_each_entry_rcu(fs_info, &upid->ns->proc_mounts, pidns_entry) {
+			mnt_root = fs_info->m_super->s_root;
+			proc_flush_task_mnt_root(mnt_root, upid->nr, tgid->numbers[i].nr);
+		}
+		rcu_read_unlock();
+
+		mnt_root = upid->ns->proc_mnt->mnt_root;
+		proc_flush_task_mnt_root(mnt_root, upid->nr, tgid->numbers[i].nr);
 	}
 }
 
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 5d5cba4c899b..e2bb015da1a8 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -149,7 +149,22 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 	if (ret) {
 		return ret;
 	}
-	return proc_setup_thread_self(s);
+
+	ret = proc_setup_thread_self(s);
+	if (ret) {
+		return ret;
+	}
+
+	/*
+	 * back reference to flush dcache entries at process exit time.
+	 */
+	ctx->fs_info->m_super = s;
+
+	spin_lock(&pid_ns->proc_mounts_lock);
+	list_add_tail_rcu(&ctx->fs_info->pidns_entry, &pid_ns->proc_mounts);
+	spin_unlock(&pid_ns->proc_mounts_lock);
+
+	return 0;
 }
 
 static int proc_reconfigure(struct fs_context *fc)
@@ -211,10 +226,17 @@ static void proc_kill_sb(struct super_block *sb)
 {
 	struct proc_fs_info *fs_info = proc_sb_info(sb);
 
+	spin_lock(&fs_info->pid_ns->proc_mounts_lock);
+	list_del_rcu(&fs_info->pidns_entry);
+	spin_unlock(&fs_info->pid_ns->proc_mounts_lock);
+
+	synchronize_rcu();
+
 	if (fs_info->proc_self)
 		dput(fs_info->proc_self);
 	if (fs_info->proc_thread_self)
 		dput(fs_info->proc_thread_self);
+
 	kill_anon_super(sb);
 	put_pid_ns(fs_info->pid_ns);
 	kfree(fs_info);
@@ -336,6 +358,9 @@ int pid_ns_prepare_proc(struct pid_namespace *ns)
 		ctx->fs_info->pid_ns = ns;
 	}
 
+	spin_lock_init(&ns->proc_mounts_lock);
+	INIT_LIST_HEAD_RCU(&ns->proc_mounts);
+
 	mnt = fc_mount(fc);
 	put_fs_context(fc);
 	if (IS_ERR(mnt))
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 66f47f1afe0d..c36af1dfd862 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -26,6 +26,8 @@ struct pid_namespace {
 	struct pid_namespace *parent;
 #ifdef CONFIG_PROC_FS
 	struct vfsmount *proc_mnt; /* Internal proc mounted during each new pidns */
+	spinlock_t proc_mounts_lock;
+	struct list_head proc_mounts; /* list of separated procfs mounts */
 #endif
 #ifdef CONFIG_BSD_PROCESS_ACCT
 	struct fs_pin *bacct;
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 5f0b1b7e4271..f307940f8311 100644
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

