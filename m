Return-Path: <linux-fsdevel+bounces-22636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4839F91A8E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 16:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C9D1F28DCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F05198A20;
	Thu, 27 Jun 2024 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9ccZP+6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27588198A17
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497526; cv=none; b=TJuv2dwX8fUdlv4wojPIkgfyLhFX5ksqeMOjOf8WZYTzIoaoSM/fzDadPJOxZN/zIELK5fWiefJ2kRy5ahKlj/PtENW9MCH5lpT4Z+/oAckku8mwLJGAKVKGRvdbO3W/aUNBo3JI7uhTwiI2thIKHUfyXWAGZjRDUXXDHv7bryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497526; c=relaxed/simple;
	bh=Qmbw4XMvnxGQLiSZgzcB/v1d+nHzcDHYvQenqTXMVWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RqbRYSe2o4F1LNi4VJjhtG35JNpouzrdfCI3ByQQl0yCt7be6vI6+H0TfLwsl/PL5G+9kdzyLGkdXqFV2KrKE9lMo+XYvzmiCIX8WGc31SXqegJX4kWMRFoCS2/2KBKytElMRu6xjX/2LSTi+gh6PcET5pdqWpAt6vg65+rd6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9ccZP+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE01DC4AF0A;
	Thu, 27 Jun 2024 14:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719497525;
	bh=Qmbw4XMvnxGQLiSZgzcB/v1d+nHzcDHYvQenqTXMVWk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z9ccZP+6Dgy+oKtzA35duhtiyx80TMKzwcHHQ7EOevXW0sihtD/QvUkI7Z8IbA9dd
	 Zq9Mj4nCXHALDeDZIRcdR6ePnHsmN/IrqM0GNSagJbeDuY1rPgEiu5SHTQk6SPltF2
	 psHLw1t+C2pyKWhUv/BJhg8N+PlcjrRj6nJX7gaCS0FDmKwyQ0jhOf/lfkbRqK0iGw
	 BFqmydsoY9KaGH3cH5AvNEksgcF+wLdjutg4MkzKofjbAysxyubDLDMsxYPObYzjS6
	 Ab6tN4IPW2Kdd0ViJtdlLNAnDvbWOB4t0t78xezeeVVm1RMd8qOpv/Pmc6EjNwRXR0
	 dyvfh2tswfpzA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 27 Jun 2024 16:11:42 +0200
Subject: [PATCH RFC 4/4] pidfs: allow retrieval of namespace file
 descriptors
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-work-pidfs-v1-4-7e9ab6cc3bb1@kernel.org>
References: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>
In-Reply-To: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Seth Forshee <sforshee@kernel.org>, 
 Stephane Graber <stgraber@stgraber.org>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=5166; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Qmbw4XMvnxGQLiSZgzcB/v1d+nHzcDHYvQenqTXMVWk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTVFmuF3LEv4bbPYZXWvtGatzc+0LvkRpPlinrmBxYz3
 HiVW5d3lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATCRgG8P/oKyHLApy8ayzmqpT
 sxmTniS9nPxMMHizuMkHjVmh72TYGRkeTzN59vZY9xKDmRziR+3Pfgu/f+R19jq/zqR1kXdEvwS
 yAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

For users that hold a reference to a pidfd procfs might not even be
available nor is it desirable to parse through procfs just for the sake
of getting namespace file descriptors for a process.

Make it possible to directly retrieve namespace file descriptors from a
pidfd. Pidfds already can be used with setns() to change a set of
namespaces atomically.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c                 | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pidfd.h | 14 +++++++
 2 files changed, 106 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index dbb9d854d1c5..957284e8b2dd 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -11,10 +11,16 @@
 #include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
 #include <linux/pseudo_fs.h>
+#include <linux/ptrace.h>
 #include <linux/seq_file.h>
 #include <uapi/linux/pidfd.h>
+#include <linux/ipc_namespace.h>
+#include <linux/time_namespace.h>
+#include <linux/utsname.h>
+#include <net/net_namespace.h>
 
 #include "internal.h"
+#include "mount.h"
 
 #ifdef CONFIG_PROC_FS
 /**
@@ -108,11 +114,97 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	return poll_flags;
 }
 
+static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct task_struct *task __free(put_task) = NULL;
+	struct nsproxy *nsp __free(put_nsproxy) = NULL;
+	struct user_namespace *user_ns = NULL;
+	struct pid_namespace *pid_ns = NULL;
+	struct pid *pid = pidfd_pid(file);
+	struct ns_common *ns_common;
+
+	if (arg)
+		return -EINVAL;
+
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task)
+		return -ESRCH;
+
+	scoped_guard(task_lock, task) {
+		nsp = task->nsproxy;
+		if (nsp)
+			get_nsproxy(nsp);
+	}
+	if (!nsp)
+		return -ESRCH; /* just pretend it didn't exist */
+
+	/*
+	 * We're trying to open a file descriptor to the namespace so perform a
+	 * filesystem cred ptrace check. Also, we mirror nsfs behavior.
+	 */
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
+		return -EACCES;
+
+	switch (cmd) {
+	case PIDFD_GET_CGROUP_NAMESPACE:
+		get_cgroup_ns(nsp->cgroup_ns);
+		ns_common = &nsp->cgroup_ns->ns;
+		break;
+	case PIDFD_GET_IPC_NAMESPACE:
+		get_ipc_ns(nsp->ipc_ns);
+		ns_common = &nsp->ipc_ns->ns;
+		break;
+	case PIDFD_GET_MNT_NAMESPACE:
+		get_mnt_ns(nsp->mnt_ns);
+		ns_common = &nsp->mnt_ns->ns;
+		break;
+	case PIDFD_GET_NET_NAMESPACE:
+		ns_common = &nsp->net_ns->ns;
+		get_net_ns(ns_common);
+		break;
+	case PIDFD_GET_PID_NAMESPACE:
+		rcu_read_lock();
+		pid_ns = get_pid_ns(task_active_pid_ns(task));
+		rcu_read_unlock();
+		ns_common = &pid_ns->ns;
+		break;
+	case PIDFD_GET_PID_FOR_CHILDREN_NAMESPACE:
+		get_pid_ns(nsp->pid_ns_for_children);
+		ns_common = &nsp->pid_ns_for_children->ns;
+		break;
+	case PIDFD_GET_TIME_NAMESPACE:
+		get_time_ns(nsp->time_ns);
+		ns_common = &nsp->time_ns->ns;
+		break;
+	case PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE:
+		get_time_ns(nsp->time_ns_for_children);
+		ns_common = &nsp->time_ns_for_children->ns;
+		break;
+	case PIDFD_GET_USER_NAMESPACE:
+		rcu_read_lock();
+		user_ns = get_user_ns(task_cred_xxx(task, user_ns));
+		rcu_read_unlock();
+		ns_common = &user_ns->ns;
+		break;
+	case PIDFD_GET_UTS_NAMESPACE:
+		get_uts_ns(nsp->uts_ns);
+		ns_common = &nsp->uts_ns->ns;
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	/* open_namespace() unconditionally consumes the reference */
+	return open_namespace(ns_common);
+}
+
 static const struct file_operations pidfs_file_operations = {
 	.poll		= pidfd_poll,
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= pidfd_show_fdinfo,
 #endif
+	.unlocked_ioctl	= pidfd_ioctl,
+	.compat_ioctl   = compat_ptr_ioctl,
 };
 
 struct pid *pidfd_pid(const struct file *file)
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 72ec000a97cd..565fc0629fff 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -5,6 +5,7 @@
 
 #include <linux/types.h>
 #include <linux/fcntl.h>
+#include <linux/ioctl.h>
 
 /* Flags for pidfd_open().  */
 #define PIDFD_NONBLOCK	O_NONBLOCK
@@ -15,4 +16,17 @@
 #define PIDFD_SIGNAL_THREAD_GROUP	(1UL << 1)
 #define PIDFD_SIGNAL_PROCESS_GROUP	(1UL << 2)
 
+#define PIDFS_IOCTL_MAGIC 0xFF
+
+#define PIDFD_GET_CGROUP_NAMESPACE            _IO(PIDFS_IOCTL_MAGIC, 1)
+#define PIDFD_GET_IPC_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 2)
+#define PIDFD_GET_MNT_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 3)
+#define PIDFD_GET_NET_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 4)
+#define PIDFD_GET_PID_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 5)
+#define PIDFD_GET_PID_FOR_CHILDREN_NAMESPACE  _IO(PIDFS_IOCTL_MAGIC, 6)
+#define PIDFD_GET_TIME_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 7)
+#define PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE _IO(PIDFS_IOCTL_MAGIC, 8)
+#define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
+#define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
+
 #endif /* _UAPI_LINUX_PIDFD_H */

-- 
2.43.0


