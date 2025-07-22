Return-Path: <linux-fsdevel+bounces-55767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F760B0E717
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 01:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202901CC1126
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 23:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70F228D840;
	Tue, 22 Jul 2025 23:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="X1Gjg01a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A08228A1C9;
	Tue, 22 Jul 2025 23:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226382; cv=none; b=Pfj2Ur1kPvyIVnqbA3oocFNIu0aCRGHP8IV7m9ZcuAVn15D5nDeKt1plQdDlLO4ML3xQl4kso4UAO6a4iCdhJK4PvhXkN78zIXm3wSpC8vFRtRpYr262M5e2TDaKjI1xNNQ+8e9dCJnZPKW43M4Rtce7/AX5amhUtZCit8VFg0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226382; c=relaxed/simple;
	bh=UmPMDauKqZHT2KGHGZlGLyTzSUO3Tof/oDKXZ1ByKLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GqMJexLc4Feg9fHECdYihtogJclfIuWvnv625xoS5plDFBNf6safyKxPaDNz11JThDJeBddlRE5/MuzBNmbUXYolVoWEXrO3wYJUd4PUOvqa+lbmFmgZwyqbClEeVDuj0pN4ZQQN5AqJdkXJw+kkMlsQwMiY5/TooAW0vq3I/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=X1Gjg01a; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bmtWr6CR2z9v23;
	Wed, 23 Jul 2025 01:19:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753226376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/Z2GV+fudpYe8e8bFuab6/Kln8z/eUc8/jutrOYdpI=;
	b=X1Gjg01ad4Y91Kw6MHnHRO3k6m2v/9cn3sxuLFEfXDY/XmVab9n3TzkW3htPnPdXUpp8Vn
	6Khx+rLiL6W0AxvKrFi+HUJHFxSj5vliglUnMOfJGHcDMMjjkWbp1rZhUGe4kaUvwPDrJF
	1fg3F5fhyO12UFqqxeCfk27v13+Z/lkzY3V6PvvGAXh2A5l06qjUtIn0JBWpq6TyKLw8tn
	gG9Sxe48XW8Mza+ItuitHbdUHzcwSeBvZAIe9LvOtVbZmxGhqZlHgiYZK1DJrF5f0ELYqr
	DjFin5xi/8CDWxhLSxaH0IYU6cU3fLrrX4c4MybvFtbvbikztgT7iqyX3t2nBg==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Wed, 23 Jul 2025 09:18:53 +1000
Subject: [PATCH RFC v2 3/4] procfs: add PROCFS_GET_PID_NAMESPACE ioctl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-procfs-pidns-api-v2-3-621e7edd8e40@cyphar.com>
References: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
In-Reply-To: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5677; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=UmPMDauKqZHT2KGHGZlGLyTzSUO3Tof/oDKXZ1ByKLY=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWQ0yOTn7lj3qNve/vRDw39yYWmbjiXv4vDbzbTj9ErLg
 3ePO3Yf6ShlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIZwsDFKQATmbmD4Q/v30zWTVm7mjY6
 7tmUwzBpa1eXrdUDDnN9R0/t6q+Vj08x/FONDm+KUo5yLgio37L25a6s39umeN5vrGmsO9Sg8+l
 nKBMA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

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

So, add a new API for this in the form of an ioctl(2) you can call on
the root directory of procfs. The returned file descriptor will have
O_CLOEXEC set. This acts as a sister feature to the new "pidns" mount
option, finally allowing userspace full control of the pid namespaces
associated with procfs instances.

The permission model for this is a bit looser than that of the "pidns"
mount option, but this is mainly because /proc/1/ns/pid provides the
same information, so as long as you have access to that magic-link (or
something equivalently reasonable such as privileges with CAP_SYS_ADMIN
or being in an ancestor pid namespace) it makes sense to allow userspace
to grab a handle. setns(2) will still have their own permission checks,
so being able to open a pidns handle doesn't really provide too many
other capabilities.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 Documentation/filesystems/proc.rst |  4 +++
 fs/proc/root.c                     | 54 ++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/fs.h            |  3 +++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index c520b9f8a3fd..506383273c9d 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2398,6 +2398,10 @@ pidns= specifies a pid namespace (either as a string path to something like
 will be used by the procfs instance when translating pids. By default, procfs
 will use the calling process's active pid namespace.
 
+Processes can check which pid namespace is used by a procfs instance by using
+the `PROCFS_GET_PID_NAMESPACE` ioctl() on the root directory of the procfs
+instance.
+
 Chapter 5: Filesystem behavior
 ==============================
 
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 057c8a125c6e..548a57ec2152 100644
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
@@ -418,15 +420,63 @@ static int proc_root_readdir(struct file *file, struct dir_context *ctx)
 	return proc_pid_readdir(file, ctx);
 }
 
+static long int proc_root_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+#ifdef CONFIG_PID_NS
+	case PROCFS_GET_PID_NAMESPACE: {
+		struct pid_namespace *active = task_active_pid_ns(current);
+		struct pid_namespace *ns = proc_pid_ns(file_inode(filp)->i_sb);
+		bool can_access_pidns = false;
+
+		/*
+		 * If we are in an ancestors of the pidns, or have join
+		 * privileges (CAP_SYS_ADMIN), then it makes sense that we
+		 * would be able to grab a handle to the pidns.
+		 *
+		 * Otherwise, if there is a root process, then being able to
+		 * access /proc/$pid/ns/pid is equivalent to this ioctl and so
+		 * we should probably match the permission model. For empty
+		 * namespaces it seems unlikely for there to be a downside to
+		 * allowing unprivileged users to open a handle to it (setns
+		 * will fail for unprivileged users anyway).
+		 */
+		can_access_pidns = pidns_is_ancestor(ns, active) ||
+				   ns_capable(ns->user_ns, CAP_SYS_ADMIN);
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
+	}
+#endif /* CONFIG_PID_NS */
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
index 0bd678a4a10e..aa642cb48feb 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -437,6 +437,9 @@ typedef int __bitwise __kernel_rwf_t;
 
 #define PROCFS_IOCTL_MAGIC 'f'
 
+/* procfs root ioctls */
+#define PROCFS_GET_PID_NAMESPACE	_IO(PROCFS_IOCTL_MAGIC, 1)
+
 /* Pagemap ioctl */
 #define PAGEMAP_SCAN	_IOWR(PROCFS_IOCTL_MAGIC, 16, struct pm_scan_arg)
 

-- 
2.50.0


