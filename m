Return-Path: <linux-fsdevel+bounces-55565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FADB0BF45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB843B6E4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 08:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2DA289E37;
	Mon, 21 Jul 2025 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="kv5YexTN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7119428983B;
	Mon, 21 Jul 2025 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087507; cv=none; b=Sczv/hn1AAGNwLSD3XMrZPMysHKQG5R0UFmG/gTHkcDqJIt00lFaeAF1BPU744oUTkKsQh5zyORzjzLESGdv7r/Dc+5TZRDdCxMIz1Q/2zyzZ8j5qYSYot2HUnpaXr//IbR16vmchToP9Bv1ZKnuejaBqPoUCEumv4w3nUqlH2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087507; c=relaxed/simple;
	bh=VDUvhCyC74lM9Wn9zyyY7zzmasB5eWfkNk+iC9mxqfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EY6DEFjH22544usgMEb1zeyqojFA+a3XsLnG3Tjbu20vyaCh+t730Xyj/ePUL7GAU8x6yg52NC47I5AsshWWt1cPIalZQHx1jGa9mTdMfZ5//PpiQZh9yeuD7x/HVuXpeyMW+GFC/Jsgprxy4wOz/5nwwy103Tc5LStX/U2+ApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=kv5YexTN; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4blv995h4Sz9spn;
	Mon, 21 Jul 2025 10:45:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753087501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeipYVnusBOwdX61rjwa47m9ibpcdMacHHxPihfaDm8=;
	b=kv5YexTNwCM3tRGGO3uyUB6GteAnuDJPur89GZ4fdCP3deIYQYnzvC0KLwkLtwTUuec36i
	OPb09CP346CRcoaJRIUC+gpXN1Bo28HW34W/JVXPaZu3dwIqKNx9cKpMERosga84s/rfHQ
	k7akG9KVlp4HzH1cMJK3fT+axMkXksu5lAWiL9p0hA6oeKH4l7i4KoQrCtbIrfnrhVeHL/
	4jOyXoTL6sIKT81zdOfj1W9BeNfoo7nxxxfJj37AKQ+XT01MypQLkZG6atTrzhd36LTiHW
	CNXCbzn12IgP9dD7sgLxLJhvssLP+AgTQhWC3krdtjKT/piMUJmqXePyVWy3Rw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Mon, 21 Jul 2025 18:44:13 +1000
Subject: [PATCH RFC 3/4] procfs: add PROCFS_GET_PID_NAMESPACE ioctl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-procfs-pidns-api-v1-3-5cd9007e512d@cyphar.com>
References: <20250721-procfs-pidns-api-v1-0-5cd9007e512d@cyphar.com>
In-Reply-To: <20250721-procfs-pidns-api-v1-0-5cd9007e512d@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4941; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=VDUvhCyC74lM9Wn9zyyY7zzmasB5eWfkNk+iC9mxqfM=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWTU/v0wj31npZ+X6u/Kuszn3cGfLLyjV2hc5wpc9cHt+
 80Ke42+jlIWBjEuBlkxRZZtfp6hm+YvvpL8aSUbzBxWJpAhDFycAjCRX/sY/rtk6Mb+sTm5JTjY
 RO9E6pRGGaXzMzkkepOmhb+/N0n5uxHD/+SWuWkT2HdELL5wj2HS859M0p7vbggJL3utVSiV8uK
 jBy8A
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4blv995h4Sz9spn

/proc has historically had very opaque semantics about PID namespaces,
which is a little unfortunate for container runtimes and other programs
that deal with switching namespaces very often. One common issue is that
of converting between PIDs in the process's namespace and PIDs in the
namespace of /proc.

In principle, it is possible to do this today by opening a pidfd with
pidfd_open(2) and then looking at /proc/self/fdinfo/$n (which will
contain a PID value translated to the pid namespace associated with that
procfs superblock).

However, allocating a new file for each PID to be converted is less than
ideal for programs that may need to scan procfs, and it is generally
useful for userspace to be able to finally get this information from
procfs. This also acts as a sister feature to the pidns= mount option,
finally allowing userspace full control of the pid namespaces associated
with /proc instances.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 Documentation/filesystems/proc.rst |  4 +++
 fs/proc/root.c                     | 52 ++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/fs.h            |  3 +++
 3 files changed, 57 insertions(+), 2 deletions(-)

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
index 10ca94be0eef..ee90749ccd8e 100644
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
@@ -408,15 +410,61 @@ static int proc_root_readdir(struct file *file, struct dir_context *ctx)
 	return proc_pid_readdir(file, ctx);
 }
 
+static long int proc_root_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
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


