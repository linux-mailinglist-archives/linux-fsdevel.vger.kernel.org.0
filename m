Return-Path: <linux-fsdevel+bounces-11394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FA685366B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E093F1F25014
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4445FEE9;
	Tue, 13 Feb 2024 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeSVAoTg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C33C5FDD8
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842755; cv=none; b=JKNdz4id4PXM3EId/qlIhQERuBk9ypQZgsEmnFwMFU/YwnT/N205xrXBs0bkhYSYRJqaZDCmjoxbm244oji+wslyE4Udt2tWd59K4R78Vq5qMPOxhE2cTTrDjspy53uB5Rk9ebUl3kFMAf+Ot20OqKXJiwItqU2HYgkWjX1dE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842755; c=relaxed/simple;
	bh=mzoSryXQAE28Ty6D4BldftRJA7rDPWVTevgfrqhZYy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MKxFfydY89zscV2p9AF9ZHAFnvViXK/8tnmouNIxZVbDCwhVoCOjy6bcKn6kQYYSqQkjgmv8JqNkGUWXocqBeKfjALmQo8uQU9y3tLBisi1oSJk+sASchTvY11S7wbKn5+/qDqpjRTWPWMepgy1CdvMUNBEJC0Iw5zA24rZQkmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeSVAoTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1E9C433C7;
	Tue, 13 Feb 2024 16:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707842754;
	bh=mzoSryXQAE28Ty6D4BldftRJA7rDPWVTevgfrqhZYy4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oeSVAoTgb8Ff3iaHxIhfTo3MsMQ7/W3/Ttyq+l75yeP/2egpRklwrGI6UnnRWhoWP
	 vamWz4zt0qRy98asdB8oMuF2NnsInKl3D/RaWB12GBgGWMAn58tp4ftxOhPSmy2eeT
	 LG3UzL0R5+9txDWN/2Ue0akvBJWpTgfCJQtD81aDbtTze2mRX4j3adTcked1wKO7EO
	 QcKGUpg27jGx2gbXiP9yEzMHZGwpjOpGUkOF4TT/mRcmWdsnbHbRjQbetotOxu7lHe
	 t6dlT3LsgT/90BtvpXw18a4cP8ZaOILUMM7PKxqTu5Fd9VScoPOnK93GgXd/jzq+/6
	 TUF2Im3U9lZgQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 13 Feb 2024 17:45:46 +0100
Subject: [PATCH 1/2] pidfd: move struct pidfd_fops
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-vfs-pidfd_fs-v1-1-f863f58cfce1@kernel.org>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
In-Reply-To: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=9199; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mzoSryXQAE28Ty6D4BldftRJA7rDPWVTevgfrqhZYy4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSenrMv6Y0z45vzU7qnP7g+b9aZANVrqRcaVvWvcwjMF
 GF6fnFLXkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE3pYzMpyrd5swx+yQcHpJ
 u1PjnvZLX6xr9W9bKOV9C+zhiSw37WBkeKX8vkMzfOp0t9N504Qdlin/5A4p4nrKsemp3XLrD2Z
 GHAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/Makefile   |   2 +-
 fs/pidfdfs.c  | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/fork.c | 110 ---------------------------------------------------
 3 files changed, 124 insertions(+), 111 deletions(-)

diff --git a/fs/Makefile b/fs/Makefile
index c09016257f05..0fe5d0151fcc 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -15,7 +15,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 		fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
-		kernel_read_file.o mnt_idmapping.o remap_range.o
+		kernel_read_file.o mnt_idmapping.o remap_range.o pidfdfs.o
 
 obj-$(CONFIG_BUFFER_HEAD)	+= buffer.o mpage.o
 obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
diff --git a/fs/pidfdfs.c b/fs/pidfdfs.c
new file mode 100644
index 000000000000..55e8396e7fc4
--- /dev/null
+++ b/fs/pidfdfs.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/magic.h>
+#include <linux/mount.h>
+#include <linux/pid.h>
+#include <linux/pid_namespace.h>
+#include <linux/poll.h>
+#include <linux/proc_fs.h>
+#include <linux/proc_ns.h>
+#include <linux/pseudo_fs.h>
+#include <linux/seq_file.h>
+#include <uapi/linux/pidfd.h>
+
+static int pidfd_release(struct inode *inode, struct file *file)
+{
+	struct pid *pid = file->private_data;
+
+	file->private_data = NULL;
+	put_pid(pid);
+	return 0;
+}
+
+#ifdef CONFIG_PROC_FS
+/**
+ * pidfd_show_fdinfo - print information about a pidfd
+ * @m: proc fdinfo file
+ * @f: file referencing a pidfd
+ *
+ * Pid:
+ * This function will print the pid that a given pidfd refers to in the
+ * pid namespace of the procfs instance.
+ * If the pid namespace of the process is not a descendant of the pid
+ * namespace of the procfs instance 0 will be shown as its pid. This is
+ * similar to calling getppid() on a process whose parent is outside of
+ * its pid namespace.
+ *
+ * NSpid:
+ * If pid namespaces are supported then this function will also print
+ * the pid of a given pidfd refers to for all descendant pid namespaces
+ * starting from the current pid namespace of the instance, i.e. the
+ * Pid field and the first entry in the NSpid field will be identical.
+ * If the pid namespace of the process is not a descendant of the pid
+ * namespace of the procfs instance 0 will be shown as its first NSpid
+ * entry and no others will be shown.
+ * Note that this differs from the Pid and NSpid fields in
+ * /proc/<pid>/status where Pid and NSpid are always shown relative to
+ * the  pid namespace of the procfs instance. The difference becomes
+ * obvious when sending around a pidfd between pid namespaces from a
+ * different branch of the tree, i.e. where no ancestral relation is
+ * present between the pid namespaces:
+ * - create two new pid namespaces ns1 and ns2 in the initial pid
+ *   namespace (also take care to create new mount namespaces in the
+ *   new pid namespace and mount procfs)
+ * - create a process with a pidfd in ns1
+ * - send pidfd from ns1 to ns2
+ * - read /proc/self/fdinfo/<pidfd> and observe that both Pid and NSpid
+ *   have exactly one entry, which is 0
+ */
+static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct pid *pid = f->private_data;
+	struct pid_namespace *ns;
+	pid_t nr = -1;
+
+	if (likely(pid_has_task(pid, PIDTYPE_PID))) {
+		ns = proc_pid_ns(file_inode(m->file)->i_sb);
+		nr = pid_nr_ns(pid, ns);
+	}
+
+	seq_put_decimal_ll(m, "Pid:\t", nr);
+
+#ifdef CONFIG_PID_NS
+	seq_put_decimal_ll(m, "\nNSpid:\t", nr);
+	if (nr > 0) {
+		int i;
+
+		/* If nr is non-zero it means that 'pid' is valid and that
+		 * ns, i.e. the pid namespace associated with the procfs
+		 * instance, is in the pid namespace hierarchy of pid.
+		 * Start at one below the already printed level.
+		 */
+		for (i = ns->level + 1; i <= pid->level; i++)
+			seq_put_decimal_ll(m, "\t", pid->numbers[i].nr);
+	}
+#endif
+	seq_putc(m, '\n');
+}
+#endif
+
+/*
+ * Poll support for process exit notification.
+ */
+static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
+{
+	struct pid *pid = file->private_data;
+	bool thread = file->f_flags & PIDFD_THREAD;
+	struct task_struct *task;
+	__poll_t poll_flags = 0;
+
+	poll_wait(file, &pid->wait_pidfd, pts);
+	/*
+	 * Depending on PIDFD_THREAD, inform pollers when the thread
+	 * or the whole thread-group exits.
+	 */
+	rcu_read_lock();
+	task = pid_task(pid, PIDTYPE_PID);
+	if (!task)
+		poll_flags = EPOLLIN | EPOLLRDNORM | EPOLLHUP;
+	else if (task->exit_state && (thread || thread_group_empty(task)))
+		poll_flags = EPOLLIN | EPOLLRDNORM;
+	rcu_read_unlock();
+
+	return poll_flags;
+}
+
+const struct file_operations pidfd_fops = {
+	.release	= pidfd_release,
+	.poll		= pidfd_poll,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo	= pidfd_show_fdinfo,
+#endif
+};
diff --git a/kernel/fork.c b/kernel/fork.c
index 3f22ec90c5c6..662a61f340ce 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1993,116 +1993,6 @@ struct pid *pidfd_pid(const struct file *file)
 	return ERR_PTR(-EBADF);
 }
 
-static int pidfd_release(struct inode *inode, struct file *file)
-{
-	struct pid *pid = file->private_data;
-
-	file->private_data = NULL;
-	put_pid(pid);
-	return 0;
-}
-
-#ifdef CONFIG_PROC_FS
-/**
- * pidfd_show_fdinfo - print information about a pidfd
- * @m: proc fdinfo file
- * @f: file referencing a pidfd
- *
- * Pid:
- * This function will print the pid that a given pidfd refers to in the
- * pid namespace of the procfs instance.
- * If the pid namespace of the process is not a descendant of the pid
- * namespace of the procfs instance 0 will be shown as its pid. This is
- * similar to calling getppid() on a process whose parent is outside of
- * its pid namespace.
- *
- * NSpid:
- * If pid namespaces are supported then this function will also print
- * the pid of a given pidfd refers to for all descendant pid namespaces
- * starting from the current pid namespace of the instance, i.e. the
- * Pid field and the first entry in the NSpid field will be identical.
- * If the pid namespace of the process is not a descendant of the pid
- * namespace of the procfs instance 0 will be shown as its first NSpid
- * entry and no others will be shown.
- * Note that this differs from the Pid and NSpid fields in
- * /proc/<pid>/status where Pid and NSpid are always shown relative to
- * the  pid namespace of the procfs instance. The difference becomes
- * obvious when sending around a pidfd between pid namespaces from a
- * different branch of the tree, i.e. where no ancestral relation is
- * present between the pid namespaces:
- * - create two new pid namespaces ns1 and ns2 in the initial pid
- *   namespace (also take care to create new mount namespaces in the
- *   new pid namespace and mount procfs)
- * - create a process with a pidfd in ns1
- * - send pidfd from ns1 to ns2
- * - read /proc/self/fdinfo/<pidfd> and observe that both Pid and NSpid
- *   have exactly one entry, which is 0
- */
-static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
-{
-	struct pid *pid = f->private_data;
-	struct pid_namespace *ns;
-	pid_t nr = -1;
-
-	if (likely(pid_has_task(pid, PIDTYPE_PID))) {
-		ns = proc_pid_ns(file_inode(m->file)->i_sb);
-		nr = pid_nr_ns(pid, ns);
-	}
-
-	seq_put_decimal_ll(m, "Pid:\t", nr);
-
-#ifdef CONFIG_PID_NS
-	seq_put_decimal_ll(m, "\nNSpid:\t", nr);
-	if (nr > 0) {
-		int i;
-
-		/* If nr is non-zero it means that 'pid' is valid and that
-		 * ns, i.e. the pid namespace associated with the procfs
-		 * instance, is in the pid namespace hierarchy of pid.
-		 * Start at one below the already printed level.
-		 */
-		for (i = ns->level + 1; i <= pid->level; i++)
-			seq_put_decimal_ll(m, "\t", pid->numbers[i].nr);
-	}
-#endif
-	seq_putc(m, '\n');
-}
-#endif
-
-/*
- * Poll support for process exit notification.
- */
-static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
-{
-	struct pid *pid = file->private_data;
-	bool thread = file->f_flags & PIDFD_THREAD;
-	struct task_struct *task;
-	__poll_t poll_flags = 0;
-
-	poll_wait(file, &pid->wait_pidfd, pts);
-	/*
-	 * Depending on PIDFD_THREAD, inform pollers when the thread
-	 * or the whole thread-group exits.
-	 */
-	rcu_read_lock();
-	task = pid_task(pid, PIDTYPE_PID);
-	if (!task)
-		poll_flags = EPOLLIN | EPOLLRDNORM | EPOLLHUP;
-	else if (task->exit_state && (thread || thread_group_empty(task)))
-		poll_flags = EPOLLIN | EPOLLRDNORM;
-	rcu_read_unlock();
-
-	return poll_flags;
-}
-
-const struct file_operations pidfd_fops = {
-	.release = pidfd_release,
-	.poll = pidfd_poll,
-#ifdef CONFIG_PROC_FS
-	.show_fdinfo = pidfd_show_fdinfo,
-#endif
-};
-
 /**
  * __pidfd_prepare - allocate a new pidfd_file and reserve a pidfd
  * @pid:   the struct pid for which to create a pidfd

-- 
2.43.0


