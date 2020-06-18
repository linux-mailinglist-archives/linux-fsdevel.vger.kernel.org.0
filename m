Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D2B1FEE02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 10:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgFRIpy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 04:45:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44890 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgFRIpx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:45:53 -0400
Received: from ip-109-41-0-102.web.vodafone.de ([109.41.0.102] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jlqBB-0002LI-VL; Thu, 18 Jun 2020 08:45:50 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wolfgang Bumiller <w.bumiller@proxmox.com>,
        Serge Hallyn <serge@hallyn.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH] nsfs: add NS_GET_INIT_PID ioctl
Date:   Thu, 18 Jun 2020 10:45:43 +0200
Message-Id: <20200618084543.326605-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an ioctl() to return the PID of the init process/child reaper of a pid
namespace as seen in the caller's pid namespace.

LXCFS is a tiny fuse filesystem used to virtualize various aspects of
procfs. It is used actively by a large number of users including ChromeOS
and cloud providers. LXCFS is run on the host. The files and directories it
creates can be bind-mounted by e.g. a container at startup and mounted over
the various procfs files the container wishes to have virtualized. When
e.g. a read request for uptime is received, LXCFS will receive the pid of
the reader. In order to virtualize the corresponding read, LXCFS needs to
know the pid of the init process of the reader's pid namespace. In order to
do this, LXCFS first needs to fork() two helper processes. The first helper
process setns() to the readers pid namespace. The second helper process is
needed to create a process that is a proper member of the pid namespace.
The second helper process then creates a ucred message with ucred.pid set
to 1 and sends it back to LXCFS. The kernel will translate the ucred.pid
field to the corresponding pid number in LXCFS's pid namespace. This way
LXCFS can learn the init pid number of the reader's pid namespace and can
go on to virtualize. Since these two forks() are costly LXCFS maintains an
init pid cache that caches a given pid for a fixed amount of time. The
cache is pruned during new read requests. However, even with the cache the
hit of the two forks() is singificant when a very large number of
containers are running. With this simple patch we add an ns ioctl that
let's a caller retrieve the init pid nr of a pid namespace through its
pid namespace fd. This _significantly_ improves our performance with a very
simple change. A caller should do something like:
- pid_t init_pid = ioctl(pid_ns_fd, NS_GET_INIT_PID);
- verify init_pid is still valid (not necessarily both but recommended):
  - opening a pidfd to get a stable reference
  - opening /proc/<init_pid>/ns/pid and verifying that <pid_ns_fd>
    and the pid namespace fd of <init_pid> refer to the same pid namespace

Note, it is possible for the init process of the pid namespace (identified
via the child_reaper member in the relevant pid namespace) to die and get
reaped right after the ioctl returned. If that happens there are two cases
to consider:
- if the init process was single threaded, all other processes in the pid
  namespace will be zapped and any new process creation in there will fail;
  A caller can detect this case since either the init pid is still around
  but it is a zombie, or it already has exited and not been recycled, or it
  has exited, been reaped, and also been recycled. The last case is the
  most interesting one but a caller would then be able to detect that the
  recycled process lives in a different pid namespace.
- if the init process was multi-threaded, then the kernel will try to make
  one of the threads in the same thread-group - if any are still alive -
  the new child_reaper. In this case the caller can detect that the thread
  which exited and used to be the child_reaper is no longer alive. If it's
  tid has been recycled in the same pid namespace a caller can detect this
  by parsing through /proc/<tid>/stat, looking at the Nspid: field and if
  there's a entry with pid nr 1 in the respective pid namespace it can be
  sure that it hasn't been recycled.
Both options can be combined with pidfd_open() to make sure that a stable
reference is maintained.

Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/nsfs.c                 | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/nsfs.h |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 800c1d0eb0d0..5a7de1ee6df0 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -8,6 +8,7 @@
 #include <linux/magic.h>
 #include <linux/ktime.h>
 #include <linux/seq_file.h>
+#include <linux/pid_namespace.h>
 #include <linux/user_namespace.h>
 #include <linux/nsfs.h>
 #include <linux/uaccess.h>
@@ -189,6 +190,10 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			unsigned long arg)
 {
 	struct user_namespace *user_ns;
+	struct pid_namespace *pid_ns;
+	struct task_struct *child_reaper;
+	struct pid *pid_struct;
+	pid_t pid;
 	struct ns_common *ns = get_proc_ns(file_inode(filp));
 	uid_t __user *argp;
 	uid_t uid;
@@ -209,6 +214,30 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		argp = (uid_t __user *) arg;
 		uid = from_kuid_munged(current_user_ns(), user_ns->owner);
 		return put_user(uid, argp);
+	case NS_GET_INIT_PID:
+		if (ns->ops->type != CLONE_NEWPID)
+			return -EINVAL;
+
+		pid_ns = container_of(ns, struct pid_namespace, ns);
+
+		/*
+		 * If we're asking for the init pid of our own pid namespace
+		 * that's of course silly but no need to fail this since we can
+		 * both infer or find out our own pid namespaces's init pid
+		 * trivially. In all other cases, we require the same
+		 * privileges as for setns().
+		 */
+		if (task_active_pid_ns(current) != pid_ns &&
+		    !ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
+			return -EPERM;
+
+		pid = -ESRCH;
+		read_lock(&tasklist_lock);
+		if (likely(pid_ns->child_reaper))
+			pid = task_pid_vnr(pid_ns->child_reaper);
+		read_unlock(&tasklist_lock);
+
+		return pid;
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index a0c8552b64ee..29c775f42bbe 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -15,5 +15,7 @@
 #define NS_GET_NSTYPE		_IO(NSIO, 0x3)
 /* Get owner UID (in the caller's user namespace) for a user namespace */
 #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
+/* Get init PID (in the caller's pid namespace) of a pid namespace */
+#define NS_GET_INIT_PID		_IO(NSIO, 0x5)
 
 #endif /* __LINUX_NSFS_H */

base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
-- 
2.27.0

