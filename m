Return-Path: <linux-fsdevel+bounces-56722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A6BB1ADB2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 07:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F45F3BFE87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 05:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D885821C19A;
	Tue,  5 Aug 2025 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="jng5FF6m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825262C190;
	Tue,  5 Aug 2025 05:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754372752; cv=none; b=S4YNkFEFRwNEaV+VUNFd9IStQ3WrkXOU6pwLTPqtbavVX6fLEAdo+eWcxWiDZHiuOpplboqKtrfeI0y/BTeGmpGqsA5n1LX37IcRyGHJz+YXJoq34FrkvakP5kDTBKdXyXY8Gs4N2YQT4S1pu3mikXdmERq5xYRakLlMl8hEh6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754372752; c=relaxed/simple;
	bh=/C2qq021xjStGJSu48HiSZ6087KYAeI74YlFmkObQ3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfZYPhzoLA4GQJiuWD2tqIFH2VJXfJmzoPelBwcSiUmxTDmF0DoDBlpiMOe4RqNx1GdUIToX6b/EamCUdT6eiBFaJSpN+R09MC0gPn36iE/q3C8vWNU0fx4kMysS1i4NbUVuDQmLwoELSGIIHh9yaLxyvS8aFiry9E//4OOPpMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=jng5FF6m; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bx2TQ02zQz9t5k;
	Tue,  5 Aug 2025 07:45:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754372746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxh09IEl4Hu0nkwkl0408Z833h/l8jerTqbtoqOiqXE=;
	b=jng5FF6mcfs6j9WuoI0ngkbm+BiE+nBYPxA0tG+4/XKBC4k0M+/LJZTac/G8vPuhwDv2T5
	GYjG9aNiWkRizdmVpmz5b2iv2JYwJylMD/fJh1wwHCG0g4I52ptJpKJ5yHJvpVAmdeaDGs
	vKzTBDzPOPa6y7T4ej+Wjy4XJS3hQeCJ3MRZRKx3AuCbLWbnwSsqWIGROfIYPUGV4pneM6
	ruotpSPck9eKzgAh88hZqweXigkXSOATlHddpE/lvN3VO4csSdkcJZovOK01leE/xFKtDx
	6sYoPtXHytOkORwObg66OsppSByt6KpgxEs07DjpCJ7geKPN/uNyj/3iIfBAHw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Tue, 05 Aug 2025 15:45:10 +1000
Subject: [PATCH v4 3/4] procfs: add PROCFS_GET_PID_NAMESPACE ioctl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-procfs-pidns-api-v4-3-705f984940e7@cyphar.com>
References: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
In-Reply-To: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6728; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=/C2qq021xjStGJSu48HiSZ6087KYAeI74YlFmkObQ3M=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMnJXvsWmHmjTTrkUTt0szTJr+56zM1Rm3vi4QzkxbW
 fva5Ge0bkcpC4MYF4OsmCLLNj/P0E3zF19J/rSSDWYOKxPIEAYuTgGYSJINw/+04Ai5cjP5xfPE
 HrTYBnjm/F7d9eZlpYf3hrRl3asdej0YGZ4K/ckSOD0zpmj/N59DlSeMW3a4Tfy3+umH7/zT/wn
 +/cwKAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bx2TQ02zQz9t5k

/proc has historically had very opaque semantics about PID namespaces,
which is a little unfortunate for container runtimes and other programs
that deal with switching namespaces very often. One common issue is that
of converting between PIDs in the process's namespace and PIDs in the
namespace of /proc.

In principle, it is possible to do this today by opening a pidfd with
pidfd_open(2) and then looking at /proc/self/fdinfo/$n (which will
contain a PID value translated to the pid namespace associated with that
procfs superblock). However, allocating a new file for each PID to be
converted is less than ideal for programs that may need to scan procfs,
and it is generally useful for userspace to be able to finally get this
information from procfs.

So, add a new API to get the pid namespace of a procfs instance, in the
form of an ioctl(2) you can call on the root directory of said procfs.
The returned file descriptor will have O_CLOEXEC set. This acts as a
sister feature to the new "pidns" mount option, finally allowing
userspace full control of the pid namespaces associated with procfs
instances.

The permission model for this is a bit looser than that of the "pidns"
mount option (and also setns(2)) because /proc/1/ns/pid provides the
same information, so as long as you have access to that magic-link (or
something equivalently reasonable such as being in an ancestor pid
namespace) it makes sense to allow userspace to grab a handle. Ideally
we would check for ptrace-read access against all processes in the pidns
(which is very likely to be true for at least one process, as
SUID_DUMP_DISABLE is cleared on exec(2) and is rarely set by most
programs), but this would obviously not scale.

setns(2) will still have their own permission checks, so being able to
open a pidns handle doesn't really provide too many other capabilities.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 Documentation/filesystems/proc.rst |  4 +++
 fs/proc/root.c                     | 68 ++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/fs.h            |  4 +++
 3 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 5a157dadea0b..840f820fb467 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2400,6 +2400,10 @@ will use the calling process's active pid namespace. Note that the pid
 namespace of an existing procfs instance cannot be modified (attempting to do
 so will give an `-EBUSY` error).
 
+Processes can check which pid namespace is used by a procfs instance by using
+the `PROCFS_GET_PID_NAMESPACE` ioctl() on the root directory of the procfs
+instance.
+
 Chapter 5: Filesystem behavior
 ==============================
 
diff --git a/fs/proc/root.c b/fs/proc/root.c
index fd1f1c8a939a..ac9b115fad7b 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -23,8 +23,10 @@
 #include <linux/cred.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include <linux/ptrace.h>
 
 #include "internal.h"
+#include "../internal.h"
 
 struct proc_fs_context {
 	struct pid_namespace	*pid_ns;
@@ -426,15 +428,77 @@ static int proc_root_readdir(struct file *file, struct dir_context *ctx)
 	return proc_pid_readdir(file, ctx);
 }
 
+static long int proc_root_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case PROCFS_GET_PID_NAMESPACE: {
+#ifdef CONFIG_PID_NS
+		struct pid_namespace *active = task_active_pid_ns(current);
+		struct pid_namespace *ns = proc_pid_ns(file_inode(filp)->i_sb);
+		bool can_access_pidns = false;
+
+		/*
+		 * Having a handle to a pidns is not sufficient to do anything
+		 * particularly harmful, as setns(2) has its own separate
+		 * privilege checks. So, we can loosen the privilege
+		 * requirements here a little to make this more ergonomic.
+		 *
+		 * If we are in an ancestor pidns of the pidns, then we can
+		 * already address any process in the pidns. From a setns(2)
+		 * privileges perspective, we can create a pidfd which setns(2)
+		 * would also accept (pending any privilege checks).
+		 *
+		 * If we are not in an ancestor pidns, because this operation
+		 * is being done on the root of the /proc instance, the caller
+		 * can try to access /proc/1/ns/pid which is equivalent to this
+		 * ioctl and so we should copy the PTRACE_MODE_READ_FSCREDS
+		 * permission model use by proc_ns_get_link(). Ideally we would
+		 * check for ptrace-read access against all processes in the
+		 * pidns (which is very likely to be true for at least one
+		 * process, as SUID_DUMP_DISABLE is cleared on exec(2) and is
+		 * rarely set by most programs), but this would obviously not
+		 * scale.
+		 *
+		 * If there is no root process, then there is no real downside
+		 * to unprivileged users to open a handle to it.
+		 */
+		can_access_pidns = pidns_is_ancestor(ns, active);
+		if (!can_access_pidns) {
+			bool cannot_ptrace_pid1 = false;
+
+			read_lock(&tasklist_lock);
+			if (ns->child_reaper)
+				cannot_ptrace_pid1 = ptrace_may_access(ns->child_reaper,
+								       PTRACE_MODE_READ_FSCREDS);
+			read_unlock(&tasklist_lock);
+			can_access_pidns = !cannot_ptrace_pid1;
+		}
+		if (!can_access_pidns)
+			return -EPERM;
+
+		/* open_namespace() unconditionally consumes the reference. */
+		get_pid_ns(ns);
+		return open_namespace(to_ns_common(ns));
+#else
+		return -EOPNOTSUPP;
+#endif
+	}
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
 /*
  * The root /proc directory is special, as it has the
  * <pid> directories. Thus we don't use the generic
  * directory handling functions for that..
  */
 static const struct file_operations proc_root_operations = {
-	.read		 = generic_read_dir,
-	.iterate_shared	 = proc_root_readdir,
+	.read		= generic_read_dir,
+	.iterate_shared	= proc_root_readdir,
 	.llseek		= generic_file_llseek,
+	.unlocked_ioctl = proc_root_ioctl,
+	.compat_ioctl   = compat_ptr_ioctl,
 };
 
 /*
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 0bd678a4a10e..68e65e6d7d6b 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -435,8 +435,12 @@ typedef int __bitwise __kernel_rwf_t;
 			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
 			 RWF_DONTCACHE)
 
+/* This matches XSDFEC_MAGIC, so we need to allocate subvalues carefully. */
 #define PROCFS_IOCTL_MAGIC 'f'
 
+/* procfs root ioctls */
+#define PROCFS_GET_PID_NAMESPACE	_IO(PROCFS_IOCTL_MAGIC, 32)
+
 /* Pagemap ioctl */
 #define PAGEMAP_SCAN	_IOWR(PROCFS_IOCTL_MAGIC, 16, struct pm_scan_arg)
 

-- 
2.50.1


