Return-Path: <linux-fsdevel+bounces-11846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCAC857C16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 12:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A455B213B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 11:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534C578685;
	Fri, 16 Feb 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYfUq2x5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA287866E
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084250; cv=none; b=UFYv06yuFyzNZTxzpZ4V2K81vCdogDX+mPgO3/Xoc10rgDxCVfmSvZTqKCR0ThmgFLV/QAyZ1XT4XWfQM6VbCwWNr5G/J8cRR+b0CQwEUOZ+IDFvKuS3A3iMa51e7muJhcTYA1u9OlV0H3fVxXQk73YZmrlcQ363QIeMyPlpW74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084250; c=relaxed/simple;
	bh=phzkWeGarHExd3Uysp4Dg8W8D9F0anTC5BqYCVul3pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lso3RFBTno7eL/Rfe4q154nCLnXWn9shkqXpbnfkNklJEVtA1iRkNYlmkWU+380lHDg1xvcRo14b41+L4Vzs1E+hcxHfU4eQS9Cdd80B3/JeQerJeQaRJyUXM2jWWNwziVOLds1n4p5WkX4/swks+7I0vyQ5sI2mtbNSV2mIlgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYfUq2x5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2FEC433F1;
	Fri, 16 Feb 2024 11:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708084250;
	bh=phzkWeGarHExd3Uysp4Dg8W8D9F0anTC5BqYCVul3pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYfUq2x5G9Ad1tqavSVJgn63wUu13KpNg0u1AwOzDCyd+ZbGXc1/x1A5BoX3ttQzt
	 zZK7cf/F3STXL58KTI+urexuaoxhk6pt0eb5Pav86I98+MzNGT4mPtSjlM50ZEOayb
	 ZfTREVkq3+E4DxboDLaOrnT2ah1tKooiC9UWZpBmY6m4APdG9zmrSGYHs2V5YwlqRK
	 AcH+QdpUrbBt0H2fFlLu3yyGXa0vR7cIfnmcJvQTjHixMcdM6iBfTSXMIZszOKq0nX
	 +qN8u5om5Ll0FhWJ+NBvAD5f3yjfqTXzJ/UuSxLCW8uQVJYk7CeegPd10Lap96tYJP
	 H/K5fu6JhKFDA==
Date: Fri, 16 Feb 2024 12:50:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
 <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner>
 <20240214-kanal-laufleistung-d884f8a1f5f2@brauner>
 <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
 <20240215-einzuarbeiten-entfuhr-0b9330d76cb0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="kdq6g2bssqs2acur"
Content-Disposition: inline
In-Reply-To: <20240215-einzuarbeiten-entfuhr-0b9330d76cb0@brauner>


--kdq6g2bssqs2acur
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Feb 15, 2024 at 05:11:31PM +0100, Christian Brauner wrote:
> On Wed, Feb 14, 2024 at 10:37:33AM -0800, Linus Torvalds wrote:
> > On Wed, 14 Feb 2024 at 10:27, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > Ok, that turned out to be simpler than I had evisioned - unless I made
> > > horrible mistakes:
> > 
> > Hmm. Could we do the same for nsfs?

Ok, here's what I got. I'll put the changes to switch both nsfs and
pidfdfs to the proposed unique mechanism suggested yesterday on top. I
would send that in two batches in any case. So if that's somehow broken
then we can just drop it.

--kdq6g2bssqs2acur
Content-Type: message/rfc822
Content-Disposition: attachment;
	filename="0001-pidfd-move-struct-pidfd_fops.eml"

From: Christian Brauner <brauner@kernel.org>
Date: Fri, 16 Feb 2024 12:40:11 +0100
Subject: [PATCH v2 1/5] pidfd: move struct pidfd_fops
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-vfs-pidfd_fs-v2-1-8365d659464d@kernel.org>
References: <20240216-vfs-pidfd_fs-v2-0-8365d659464d@kernel.org>
In-Reply-To: <20240216-vfs-pidfd_fs-v2-0-8365d659464d@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=9199; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mzoSryXQAE28Ty6D4BldftRJA7rDPWVTevgfrqhZYy4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSe95wtfdK9l73icWPHeaapXT/8/y356Cvv9PutSnPlq
 cXtu49Fd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkhh8jw8vdbZuu1J7XmpOz
 7OyjOTVxqaw1WoatWQtsdypunHj/sQEjw7bOExnzX5leNpxm76NRdungHMHH1a/uOjxZlnFr5pY
 /PWwA
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


--kdq6g2bssqs2acur
Content-Type: message/rfc822
Content-Disposition: attachment; filename="0002-pidfd-add-pidfdfs.eml"

From: Christian Brauner <brauner@kernel.org>
Date: Fri, 16 Feb 2024 12:40:12 +0100
Subject: [PATCH v2 2/5] pidfd: add pidfdfs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-vfs-pidfd_fs-v2-2-8365d659464d@kernel.org>
References: <20240216-vfs-pidfd_fs-v2-0-8365d659464d@kernel.org>
In-Reply-To: <20240216-vfs-pidfd_fs-v2-0-8365d659464d@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=12402; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jlmnJKiEMiaIq9PfXnAcSO+VPHOdH0Hy0sAWIZzNZB4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSe95xdomvMaHPl0c45rQHLw55OXhDQx3MxWyb416Oyj
 pVuBo6pHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5OpPhf8RlqQcTebXymRXv
 p0Ul7Zh9VNfunPVU555t8+921jde12dkWHHYP5X9T4vvucBA3wgfLj6Om5ull8sypWtd8703wcK
 XGwA=
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
 fs/Kconfig                 |   6 +++
 fs/pidfdfs.c               | 128 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pid.h        |   3 ++
 include/linux/pidfdfs.h    |   9 ++++
 include/uapi/linux/magic.h |   1 +
 init/main.c                |   2 +
 kernel/fork.c              |  13 +----
 kernel/nsproxy.c           |   2 +-
 kernel/pid.c               |   7 +++
 9 files changed, 157 insertions(+), 14 deletions(-)

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
index 55e8396e7fc4..be4e74cec8b9 100644
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
@@ -121,3 +136,112 @@ const struct file_operations pidfd_fops = {
 	.show_fdinfo	= pidfd_show_fdinfo,
 #endif
 };
+
+#ifdef CONFIG_FS_PIDFD
+static struct vfsmount *pidfdfs_mnt __ro_after_init;
+static struct super_block *pidfdfs_sb __ro_after_init;
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
index c1d940fbd314..2c0a9e8f58e2 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -42,6 +42,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/idr.h>
+#include <linux/pidfdfs.h>
 #include <net/sock.h>
 #include <uapi/linux/pidfd.h>
 
@@ -65,6 +66,9 @@ int pid_max = PID_MAX_DEFAULT;
 
 int pid_max_min = RESERVED_PIDS + 1;
 int pid_max_max = PID_MAX_LIMIT;
+#ifdef CONFIG_FS_PIDFD
+static u64 pidfdfs_ino = 0;
+#endif
 
 /*
  * PID-map pages start out as NULL, they get allocated upon
@@ -272,6 +276,9 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 	spin_lock_irq(&pidmap_lock);
 	if (!(ns->pid_allocated & PIDNS_ADDING))
 		goto out_unlock;
+#ifdef CONFIG_FS_PIDFD
+	pid->ino = ++pidfdfs_ino;
+#endif
 	for ( ; upid >= pid->numbers; --upid) {
 		/* Make the PID visible to find_pid_ns. */
 		idr_replace(&upid->ns->idr, pid, upid->nr);

-- 
2.43.0


--kdq6g2bssqs2acur
Content-Type: message/rfc822
Content-Disposition: attachment;
	filename="0003-dcache-add-d_instantiate_unique_anon.eml"

From: Christian Brauner <brauner@kernel.org>
Date: Fri, 16 Feb 2024 12:40:13 +0100
Subject: [PATCH v2 3/5] dcache: add d_instantiate_unique_anon()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-vfs-pidfd_fs-v2-3-8365d659464d@kernel.org>
References: <20240216-vfs-pidfd_fs-v2-0-8365d659464d@kernel.org>
In-Reply-To: <20240216-vfs-pidfd_fs-v2-0-8365d659464d@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=2815; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3lDPOOuWZEQQR3cCbYIb8n/QvCONU/KBd97LS98thXc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSe95xdblTqcs7gyNb7C796sRw5/rRIXbjrxlTzlKvad
 xMLuxTlO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZiJcjwz2SHdrKBmd5DpTyu
 js6nrY8VGP8HGl3lu7D0wKHPrxnrohj+Kd5Urzp0QSJ7l833jAfTs1x/K1TFPvjL6VDMPkunQu0
 2DwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a helper for nsfs and pidfds. Both filesystems only allocate
anonymous dentries that aren't children of any other dentries and aren't
parents of any other dentries. So dentry->d_parent points to dentry. For
each unique inode we only need a unique dentry. Add a helper that both
nsfs and pidfdfs can use. Not exported, only internal.h and others
should refrain from using this.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/dcache.c   | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/internal.h |  1 +
 2 files changed, 50 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index b813528fb147..e492c515b0e6 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2642,6 +2642,55 @@ void d_add(struct dentry *entry, struct inode *inode)
 }
 EXPORT_SYMBOL(d_add);
 
+/**
+ * d_instantiate_unique_anon - reuse existing, unhashed dentry or add new one
+ * @entry: dentry to add
+ * @inode: The inode to attach this dentry
+ *
+ * Helper for special filesystems that want to recycle the exact same dentry
+ * over and over. Dentries must be unhashed, IS_ROOT() dentries gotten via
+ * d_alloc_anon(). Anything else is a bug. Caller must provide valid inode.
+ */
+struct dentry *d_instantiate_unique_anon(struct dentry *entry, struct inode *inode)
+{
+	struct dentry *alias;
+	unsigned int hash = entry->d_name.hash;
+
+	if (!inode)
+		return NULL;
+
+	if (!IS_ROOT(entry))
+		return NULL;
+
+	if (WARN_ON_ONCE(!d_unhashed(entry)))
+		return NULL;
+
+	if (WARN_ON_ONCE(!hlist_unhashed(&entry->d_u.d_alias)))
+		return NULL;
+
+	spin_lock(&inode->i_lock);
+	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
+		if (alias->d_name.hash != hash)
+			continue;
+		if (!d_same_name(alias, entry->d_parent, &entry->d_name))
+			continue;
+		if (WARN_ON_ONCE(!IS_ROOT(alias)))
+			continue;
+		if (WARN_ON_ONCE(!d_unhashed(alias)))
+			continue;
+		spin_lock(&alias->d_lock);
+		dget_dlock(alias);
+		spin_unlock(&alias->d_lock);
+		spin_unlock(&inode->i_lock);
+		return alias;
+	}
+
+	__d_instantiate(entry, inode);
+	spin_unlock(&inode->i_lock);
+	security_d_instantiate(entry, inode); /* groan */
+	return NULL;
+}
+
 /**
  * d_exact_alias - find and hash an exact unhashed alias
  * @entry: dentry to add
diff --git a/fs/internal.h b/fs/internal.h
index b67406435fc0..41b441c7b2a0 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -310,3 +310,4 @@ ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *po
 struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns);
 struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
 void mnt_idmap_put(struct mnt_idmap *idmap);
+struct dentry *d_instantiate_unique_anon(struct dentry *entry, struct inode *inode);

-- 
2.43.0


--kdq6g2bssqs2acur
Content-Type: message/rfc822
Content-Disposition: attachment; filename="0004-pidfdfs-use-new-helper.eml"

From: Christian Brauner <brauner@kernel.org>
Date: Fri, 16 Feb 2024 12:40:14 +0100
Subject: [PATCH v2 4/5] pidfdfs: use new helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-vfs-pidfd_fs-v2-4-8365d659464d@kernel.org>
References: <20240216-vfs-pidfd_fs-v2-0-8365d659464d@kernel.org>
In-Reply-To: <20240216-vfs-pidfd_fs-v2-0-8365d659464d@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768; i=brauner@kernel.org;
 h=from:subject:message-id; bh=S30jwASVo12x/sPMOs3hVzrddAgOqdwAm5tUrZcK5RU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSe95y9wCtqm6LvxYNXnloEym31/Vgn6zu5xSDNTXXDo
 X6F3zozO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayp5nhf97/+PzozC+zrz+t
 irn368jtGXP3qGz/0c7w96hUot665O2MDHf3L1b3FRI41sK7hYn7mfL7Y2GbVfPNNc5WrL+RJH6
 NhRMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We currently allocate a new dentry for each opener of the same struct
pid. We don't really need that and with the new helper introduced
earlier we can just reuse any existing dentry.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfdfs.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/pidfdfs.c b/fs/pidfdfs.c
index be4e74cec8b9..cff617fa3fb9 100644
--- a/fs/pidfdfs.c
+++ b/fs/pidfdfs.c
@@ -14,6 +14,8 @@
 #include <linux/seq_file.h>
 #include <uapi/linux/pidfd.h>
 
+#include "internal.h"
+
 struct pid *pidfd_pid(const struct file *file)
 {
 	if (file->f_op != &pidfd_fops)
@@ -189,11 +191,19 @@ struct file *pidfdfs_alloc_file(struct pid *pid, unsigned int flags)
 {
 
 	struct inode *inode;
+	struct dentry *dentry, *alias;
+	struct path path;
 	struct file *pidfd_file;
 
+	dentry = d_alloc_anon(pidfdfs_sb);
+	if (!dentry)
+		return ERR_PTR(-ENOMEM);
+
 	inode = iget_locked(pidfdfs_sb, pid->ino);
-	if (!inode)
+	if (!inode) {
+		dput(dentry);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	if (inode->i_state & I_NEW) {
 		inode->i_ino = pid->ino;
@@ -205,10 +215,16 @@ struct file *pidfdfs_alloc_file(struct pid *pid, unsigned int flags)
 		unlock_new_inode(inode);
 	}
 
-	pidfd_file = alloc_file_pseudo(inode, pidfdfs_mnt, "", flags, &pidfd_fops);
-	if (IS_ERR(pidfd_file))
-		iput(inode);
+	alias = d_instantiate_unique_anon(dentry, inode);
+	if (alias) {
+		dput(dentry);
+		dentry = alias;
+	}
 
+	path.dentry = dentry;
+	path.mnt = mntget(pidfdfs_mnt);
+	pidfd_file = dentry_open(&path, flags, current_cred());
+	path_put(&path);
 	return pidfd_file;
 }
 

-- 
2.43.0


--kdq6g2bssqs2acur
Content-Type: message/rfc822
Content-Disposition: attachment;
	filename="0005-nsfs-remove-dentry-stashing-mechanism.eml"

From: Christian Brauner <brauner@kernel.org>
Date: Fri, 16 Feb 2024 12:40:15 +0100
Subject: [PATCH v2 5/5] nsfs: remove dentry stashing mechanism
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-vfs-pidfd_fs-v2-5-8365d659464d@kernel.org>
References: <20240216-vfs-pidfd_fs-v2-0-8365d659464d@kernel.org>
In-Reply-To: <20240216-vfs-pidfd_fs-v2-0-8365d659464d@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=5386; i=brauner@kernel.org;
 h=from:subject:message-id; bh=i24D9kqimodVS69+Up6q6WfW4EV/rNTVnzsr0iWB/Tc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSe95x9eEpMZ4RZ1WL/I2qvtW+d4/q7LXfu+y+zgl5Il
 lcIVQa/6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhInCIjw+lWU4c3K4WWF+pV
 dfS8ubzoydo7pbz/S7+9eXGhQDZm4RuGv1JJe8/veD5ZSX/ZTdXVEsJuNxKtTkU2G/8V2Wx732G
 hOBcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

As Linus points out this is pretty ugly. With the new helper we can
achieve the same result without the ugliness.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c                 | 118 ++++++++++++++++++----------------------------
 include/linux/ns_common.h |   1 -
 include/linux/proc_ns.h   |   1 -
 3 files changed, 45 insertions(+), 75 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 34e1e3e36733..0c7593865ec9 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -33,20 +33,9 @@ static char *ns_dname(struct dentry *dentry, char *buffer, int buflen)
 		ns_ops->name, inode->i_ino);
 }
 
-static void ns_prune_dentry(struct dentry *dentry)
-{
-	struct inode *inode = d_inode(dentry);
-	if (inode) {
-		struct ns_common *ns = inode->i_private;
-		atomic_long_set(&ns->stashed, 0);
-	}
-}
-
-const struct dentry_operations ns_dentry_operations =
-{
-	.d_prune	= ns_prune_dentry,
-	.d_delete	= always_delete_dentry,
-	.d_dname	= ns_dname,
+const struct dentry_operations ns_dentry_operations = {
+	.d_delete = always_delete_dentry,
+	.d_dname = ns_dname,
 };
 
 static void nsfs_evict(struct inode *inode)
@@ -58,65 +47,51 @@ static void nsfs_evict(struct inode *inode)
 
 static int __ns_get_path(struct path *path, struct ns_common *ns)
 {
-	struct vfsmount *mnt = nsfs_mnt;
-	struct dentry *dentry;
+	struct super_block *nsfs_sb = nsfs_mnt->mnt_sb;
+	struct dentry *dentry, *alias;
 	struct inode *inode;
-	unsigned long d;
-
-	rcu_read_lock();
-	d = atomic_long_read(&ns->stashed);
-	if (!d)
-		goto slow;
-	dentry = (struct dentry *)d;
-	if (!lockref_get_not_dead(&dentry->d_lockref))
-		goto slow;
-	rcu_read_unlock();
-	ns->ops->put(ns);
-got_it:
-	path->mnt = mntget(mnt);
-	path->dentry = dentry;
-	return 0;
-slow:
-	rcu_read_unlock();
-	inode = new_inode_pseudo(mnt->mnt_sb);
+
+	dentry = d_alloc_anon(nsfs_sb);
+	if (!dentry)
+		return -ENOMEM;
+
+	inode = iget_locked(nsfs_sb, ns->inum);
 	if (!inode) {
-		ns->ops->put(ns);
+		dput(dentry);
 		return -ENOMEM;
 	}
-	inode->i_ino = ns->inum;
-	simple_inode_init_ts(inode);
-	inode->i_flags |= S_IMMUTABLE;
-	inode->i_mode = S_IFREG | S_IRUGO;
-	inode->i_fop = &ns_file_operations;
-	inode->i_private = ns;
-
-	dentry = d_make_root(inode);	/* not the normal use, but... */
-	if (!dentry)
-		return -ENOMEM;
+
+	if (inode->i_state & I_NEW) {
+		inode->i_ino = ns->inum;
+		simple_inode_init_ts(inode);
+		inode->i_flags |= S_IMMUTABLE;
+		inode->i_mode = S_IFREG | S_IRUGO;
+		inode->i_fop = &ns_file_operations;
+		inode->i_private = ns;
+		unlock_new_inode(inode);
+	} else {
+		ns->ops->put(ns);
+	}
+
 	dentry->d_fsdata = (void *)ns->ops;
-	d = atomic_long_cmpxchg(&ns->stashed, 0, (unsigned long)dentry);
-	if (d) {
-		d_delete(dentry);	/* make sure ->d_prune() does nothing */
+	alias = d_instantiate_unique_anon(dentry, inode);
+	if (alias) {
 		dput(dentry);
-		cpu_relax();
-		return -EAGAIN;
+		dentry = alias;
 	}
-	goto got_it;
+
+	path->dentry = dentry;
+	path->mnt = mntget(nsfs_mnt);
+	return 0;
 }
 
 int ns_get_path_cb(struct path *path, ns_get_path_helper_t *ns_get_cb,
-		     void *private_data)
+		   void *private_data)
 {
-	int ret;
-
-	do {
-		struct ns_common *ns = ns_get_cb(private_data);
-		if (!ns)
-			return -ENOENT;
-		ret = __ns_get_path(path, ns);
-	} while (ret == -EAGAIN);
-
-	return ret;
+	struct ns_common *ns = ns_get_cb(private_data);
+	if (!ns)
+		return -ENOENT;
+	return __ns_get_path(path, ns);
 }
 
 struct ns_get_path_task_args {
@@ -147,6 +122,7 @@ int open_related_ns(struct ns_common *ns,
 {
 	struct path path = {};
 	struct file *f;
+	struct ns_common *relative;
 	int err;
 	int fd;
 
@@ -154,18 +130,13 @@ int open_related_ns(struct ns_common *ns,
 	if (fd < 0)
 		return fd;
 
-	do {
-		struct ns_common *relative;
-
-		relative = get_ns(ns);
-		if (IS_ERR(relative)) {
-			put_unused_fd(fd);
-			return PTR_ERR(relative);
-		}
-
-		err = __ns_get_path(&path, relative);
-	} while (err == -EAGAIN);
+	relative = get_ns(ns);
+	if (IS_ERR(relative)) {
+		put_unused_fd(fd);
+		return PTR_ERR(relative);
+	}
 
+	err = __ns_get_path(&path, relative);
 	if (err) {
 		put_unused_fd(fd);
 		return err;
@@ -259,6 +230,7 @@ static const struct super_operations nsfs_ops = {
 	.statfs = simple_statfs,
 	.evict_inode = nsfs_evict,
 	.show_path = nsfs_show_path,
+	.drop_inode = generic_delete_inode,
 };
 
 static int nsfs_init_fs_context(struct fs_context *fc)
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 0f1d024bd958..016258562b5d 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -7,7 +7,6 @@
 struct proc_ns_operations;
 
 struct ns_common {
-	atomic_long_t stashed;
 	const struct proc_ns_operations *ops;
 	unsigned int inum;
 	refcount_t count;
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 49539bc416ce..acd3d347a6a5 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -66,7 +66,6 @@ static inline void proc_free_inum(unsigned int inum) {}
 
 static inline int ns_alloc_inum(struct ns_common *ns)
 {
-	atomic_long_set(&ns->stashed, 0);
 	return proc_alloc_inum(&ns->inum);
 }
 

-- 
2.43.0


--kdq6g2bssqs2acur--

