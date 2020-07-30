Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD20233169
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgG3MAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:00:20 -0400
Received: from relay.sw.ru ([185.231.240.75]:56744 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728141AbgG3MAS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:00:18 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17E8-0002xT-2q; Thu, 30 Jul 2020 15:00:00 +0300
Subject: [PATCH 10/23] fs: Rename fs/proc/namespaces.c into
 fs/proc/task_namespaces.c
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 15:00:14 +0300
Message-ID: <159611041399.535980.15920460479176140405.stgit@localhost.localdomain>
In-Reply-To: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This file is about task namespaces, so we rename it.
No functional changes.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/proc/Makefile          |    2 
 fs/proc/internal.h        |    2 
 fs/proc/namespaces.c      |  183 ---------------------------------------------
 fs/proc/task_namespaces.c |  183 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 185 insertions(+), 185 deletions(-)
 delete mode 100644 fs/proc/namespaces.c
 create mode 100644 fs/proc/task_namespaces.c

diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index bd08616ed8ba..dc2d51f42905 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -24,7 +24,7 @@ proc-y	+= uptime.o
 proc-y	+= util.o
 proc-y	+= version.o
 proc-y	+= softirqs.o
-proc-y	+= namespaces.o
+proc-y	+= task_namespaces.o
 proc-y	+= self.o
 proc-y	+= thread_self.o
 proc-$(CONFIG_PROC_SYSCTL)	+= proc_sysctl.o
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 917cc85e3466..572757ff97be 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -223,7 +223,7 @@ extern struct inode *proc_get_inode(struct super_block *, struct proc_dir_entry
 extern void proc_entry_rundown(struct proc_dir_entry *);
 
 /*
- * proc_namespaces.c
+ * task_namespaces.c
  */
 extern const struct inode_operations proc_ns_dir_inode_operations;
 extern const struct file_operations proc_ns_dir_operations;
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
deleted file mode 100644
index 8e159fc78c0a..000000000000
--- a/fs/proc/namespaces.c
+++ /dev/null
@@ -1,183 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/proc_fs.h>
-#include <linux/nsproxy.h>
-#include <linux/ptrace.h>
-#include <linux/namei.h>
-#include <linux/file.h>
-#include <linux/utsname.h>
-#include <net/net_namespace.h>
-#include <linux/ipc_namespace.h>
-#include <linux/pid_namespace.h>
-#include <linux/user_namespace.h>
-#include "internal.h"
-
-
-static const struct proc_ns_operations *ns_entries[] = {
-#ifdef CONFIG_NET_NS
-	&netns_operations,
-#endif
-#ifdef CONFIG_UTS_NS
-	&utsns_operations,
-#endif
-#ifdef CONFIG_IPC_NS
-	&ipcns_operations,
-#endif
-#ifdef CONFIG_PID_NS
-	&pidns_operations,
-	&pidns_for_children_operations,
-#endif
-#ifdef CONFIG_USER_NS
-	&userns_operations,
-#endif
-	&mntns_operations,
-#ifdef CONFIG_CGROUPS
-	&cgroupns_operations,
-#endif
-#ifdef CONFIG_TIME_NS
-	&timens_operations,
-	&timens_for_children_operations,
-#endif
-};
-
-static const char *proc_ns_get_link(struct dentry *dentry,
-				    struct inode *inode,
-				    struct delayed_call *done)
-{
-	const struct proc_ns_operations *ns_ops = PROC_I(inode)->ns_ops;
-	struct task_struct *task;
-	struct path ns_path;
-	int error = -EACCES;
-
-	if (!dentry)
-		return ERR_PTR(-ECHILD);
-
-	task = get_proc_task(inode);
-	if (!task)
-		return ERR_PTR(-EACCES);
-
-	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
-		goto out;
-
-	error = ns_get_path(&ns_path, task, ns_ops);
-	if (error)
-		goto out;
-
-	error = nd_jump_link(&ns_path);
-out:
-	put_task_struct(task);
-	return ERR_PTR(error);
-}
-
-static int proc_ns_readlink(struct dentry *dentry, char __user *buffer, int buflen)
-{
-	struct inode *inode = d_inode(dentry);
-	const struct proc_ns_operations *ns_ops = PROC_I(inode)->ns_ops;
-	struct task_struct *task;
-	char name[50];
-	int res = -EACCES;
-
-	task = get_proc_task(inode);
-	if (!task)
-		return res;
-
-	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
-		res = ns_get_name(name, sizeof(name), task, ns_ops);
-		if (res >= 0)
-			res = readlink_copy(buffer, buflen, name);
-	}
-	put_task_struct(task);
-	return res;
-}
-
-static const struct inode_operations proc_ns_link_inode_operations = {
-	.readlink	= proc_ns_readlink,
-	.get_link	= proc_ns_get_link,
-	.setattr	= proc_setattr,
-};
-
-static struct dentry *proc_ns_instantiate(struct dentry *dentry,
-	struct task_struct *task, const void *ptr)
-{
-	const struct proc_ns_operations *ns_ops = ptr;
-	struct inode *inode;
-	struct proc_inode *ei;
-
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK | S_IRWXUGO);
-	if (!inode)
-		return ERR_PTR(-ENOENT);
-
-	ei = PROC_I(inode);
-	inode->i_op = &proc_ns_link_inode_operations;
-	ei->ns_ops = ns_ops;
-	pid_update_inode(task, inode);
-
-	d_set_d_op(dentry, &pid_dentry_operations);
-	return d_splice_alias(inode, dentry);
-}
-
-static int proc_ns_dir_readdir(struct file *file, struct dir_context *ctx)
-{
-	struct task_struct *task = get_proc_task(file_inode(file));
-	const struct proc_ns_operations **entry, **last;
-
-	if (!task)
-		return -ENOENT;
-
-	if (!dir_emit_dots(file, ctx))
-		goto out;
-	if (ctx->pos >= 2 + ARRAY_SIZE(ns_entries))
-		goto out;
-	entry = ns_entries + (ctx->pos - 2);
-	last = &ns_entries[ARRAY_SIZE(ns_entries) - 1];
-	while (entry <= last) {
-		const struct proc_ns_operations *ops = *entry;
-		if (!proc_fill_cache(file, ctx, ops->name, strlen(ops->name),
-				     proc_ns_instantiate, task, ops))
-			break;
-		ctx->pos++;
-		entry++;
-	}
-out:
-	put_task_struct(task);
-	return 0;
-}
-
-const struct file_operations proc_ns_dir_operations = {
-	.read		= generic_read_dir,
-	.iterate_shared	= proc_ns_dir_readdir,
-	.llseek		= generic_file_llseek,
-};
-
-static struct dentry *proc_ns_dir_lookup(struct inode *dir,
-				struct dentry *dentry, unsigned int flags)
-{
-	struct task_struct *task = get_proc_task(dir);
-	const struct proc_ns_operations **entry, **last;
-	unsigned int len = dentry->d_name.len;
-	struct dentry *res = ERR_PTR(-ENOENT);
-
-	if (!task)
-		goto out_no_task;
-
-	last = &ns_entries[ARRAY_SIZE(ns_entries)];
-	for (entry = ns_entries; entry < last; entry++) {
-		if (strlen((*entry)->name) != len)
-			continue;
-		if (!memcmp(dentry->d_name.name, (*entry)->name, len))
-			break;
-	}
-	if (entry == last)
-		goto out;
-
-	res = proc_ns_instantiate(dentry, task, *entry);
-out:
-	put_task_struct(task);
-out_no_task:
-	return res;
-}
-
-const struct inode_operations proc_ns_dir_inode_operations = {
-	.lookup		= proc_ns_dir_lookup,
-	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
-};
diff --git a/fs/proc/task_namespaces.c b/fs/proc/task_namespaces.c
new file mode 100644
index 000000000000..8e159fc78c0a
--- /dev/null
+++ b/fs/proc/task_namespaces.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/proc_fs.h>
+#include <linux/nsproxy.h>
+#include <linux/ptrace.h>
+#include <linux/namei.h>
+#include <linux/file.h>
+#include <linux/utsname.h>
+#include <net/net_namespace.h>
+#include <linux/ipc_namespace.h>
+#include <linux/pid_namespace.h>
+#include <linux/user_namespace.h>
+#include "internal.h"
+
+
+static const struct proc_ns_operations *ns_entries[] = {
+#ifdef CONFIG_NET_NS
+	&netns_operations,
+#endif
+#ifdef CONFIG_UTS_NS
+	&utsns_operations,
+#endif
+#ifdef CONFIG_IPC_NS
+	&ipcns_operations,
+#endif
+#ifdef CONFIG_PID_NS
+	&pidns_operations,
+	&pidns_for_children_operations,
+#endif
+#ifdef CONFIG_USER_NS
+	&userns_operations,
+#endif
+	&mntns_operations,
+#ifdef CONFIG_CGROUPS
+	&cgroupns_operations,
+#endif
+#ifdef CONFIG_TIME_NS
+	&timens_operations,
+	&timens_for_children_operations,
+#endif
+};
+
+static const char *proc_ns_get_link(struct dentry *dentry,
+				    struct inode *inode,
+				    struct delayed_call *done)
+{
+	const struct proc_ns_operations *ns_ops = PROC_I(inode)->ns_ops;
+	struct task_struct *task;
+	struct path ns_path;
+	int error = -EACCES;
+
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
+	task = get_proc_task(inode);
+	if (!task)
+		return ERR_PTR(-EACCES);
+
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
+		goto out;
+
+	error = ns_get_path(&ns_path, task, ns_ops);
+	if (error)
+		goto out;
+
+	error = nd_jump_link(&ns_path);
+out:
+	put_task_struct(task);
+	return ERR_PTR(error);
+}
+
+static int proc_ns_readlink(struct dentry *dentry, char __user *buffer, int buflen)
+{
+	struct inode *inode = d_inode(dentry);
+	const struct proc_ns_operations *ns_ops = PROC_I(inode)->ns_ops;
+	struct task_struct *task;
+	char name[50];
+	int res = -EACCES;
+
+	task = get_proc_task(inode);
+	if (!task)
+		return res;
+
+	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
+		res = ns_get_name(name, sizeof(name), task, ns_ops);
+		if (res >= 0)
+			res = readlink_copy(buffer, buflen, name);
+	}
+	put_task_struct(task);
+	return res;
+}
+
+static const struct inode_operations proc_ns_link_inode_operations = {
+	.readlink	= proc_ns_readlink,
+	.get_link	= proc_ns_get_link,
+	.setattr	= proc_setattr,
+};
+
+static struct dentry *proc_ns_instantiate(struct dentry *dentry,
+	struct task_struct *task, const void *ptr)
+{
+	const struct proc_ns_operations *ns_ops = ptr;
+	struct inode *inode;
+	struct proc_inode *ei;
+
+	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK | S_IRWXUGO);
+	if (!inode)
+		return ERR_PTR(-ENOENT);
+
+	ei = PROC_I(inode);
+	inode->i_op = &proc_ns_link_inode_operations;
+	ei->ns_ops = ns_ops;
+	pid_update_inode(task, inode);
+
+	d_set_d_op(dentry, &pid_dentry_operations);
+	return d_splice_alias(inode, dentry);
+}
+
+static int proc_ns_dir_readdir(struct file *file, struct dir_context *ctx)
+{
+	struct task_struct *task = get_proc_task(file_inode(file));
+	const struct proc_ns_operations **entry, **last;
+
+	if (!task)
+		return -ENOENT;
+
+	if (!dir_emit_dots(file, ctx))
+		goto out;
+	if (ctx->pos >= 2 + ARRAY_SIZE(ns_entries))
+		goto out;
+	entry = ns_entries + (ctx->pos - 2);
+	last = &ns_entries[ARRAY_SIZE(ns_entries) - 1];
+	while (entry <= last) {
+		const struct proc_ns_operations *ops = *entry;
+		if (!proc_fill_cache(file, ctx, ops->name, strlen(ops->name),
+				     proc_ns_instantiate, task, ops))
+			break;
+		ctx->pos++;
+		entry++;
+	}
+out:
+	put_task_struct(task);
+	return 0;
+}
+
+const struct file_operations proc_ns_dir_operations = {
+	.read		= generic_read_dir,
+	.iterate_shared	= proc_ns_dir_readdir,
+	.llseek		= generic_file_llseek,
+};
+
+static struct dentry *proc_ns_dir_lookup(struct inode *dir,
+				struct dentry *dentry, unsigned int flags)
+{
+	struct task_struct *task = get_proc_task(dir);
+	const struct proc_ns_operations **entry, **last;
+	unsigned int len = dentry->d_name.len;
+	struct dentry *res = ERR_PTR(-ENOENT);
+
+	if (!task)
+		goto out_no_task;
+
+	last = &ns_entries[ARRAY_SIZE(ns_entries)];
+	for (entry = ns_entries; entry < last; entry++) {
+		if (strlen((*entry)->name) != len)
+			continue;
+		if (!memcmp(dentry->d_name.name, (*entry)->name, len))
+			break;
+	}
+	if (entry == last)
+		goto out;
+
+	res = proc_ns_instantiate(dentry, task, *entry);
+out:
+	put_task_struct(task);
+out_no_task:
+	return res;
+}
+
+const struct inode_operations proc_ns_dir_inode_operations = {
+	.lookup		= proc_ns_dir_lookup,
+	.getattr	= pid_getattr,
+	.setattr	= proc_setattr,
+};


