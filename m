Return-Path: <linux-fsdevel+bounces-67698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FFCC476A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC673349F0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6043161A5;
	Mon, 10 Nov 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgY5q7B9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C991A7AE3;
	Mon, 10 Nov 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787329; cv=none; b=JmFleE7dzjJcDEhc91vAS01J9wjYLJwtEw5etQyxgcDklc0h99Ya7eW8092TVAMDy7DuA3drma36CP97WE+uoHm0fFoolo0h7R53spFXTNpCVPtEkX669qURgLp6bQdcfUxtfInLopeUNk0ePfiy082EYJJJyUyEqjG8fJQZ1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787329; c=relaxed/simple;
	bh=l2gKHF5YYANi9iKUp1grUz0ml7BUm8UgkW3nXou45Fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gwt/8bSzqCCH/npwUVU16WiBrva4PTsspI4hBAWoTgqqWOrUsPf4ZdSDHVAWK3xaP3a3r0vGjOi1D9gxg5tuXQRGQZVmgUZEO16OsWIniS0svzhy7yHQQ9uHn3Mkrynel71ICt+0jbGF5vdn4eckyNeLFdjdtO2WP48/rAKeq5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgY5q7B9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C54C116B1;
	Mon, 10 Nov 2025 15:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787326;
	bh=l2gKHF5YYANi9iKUp1grUz0ml7BUm8UgkW3nXou45Fg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CgY5q7B9+Oet7FfHxo03nK+KWQ2EIskPDwyYj72i4xKl2AYC7LVcMbiKlgO8BvMIC
	 ThTgqhEo+gRfSSs6QghUWjUaHB4a1xLA5arUEqeKWDntEyCui4zILiqOHLjUWyWMN0
	 ggDksKUlxFXXrNE/0XRWcJKD/UQs+stoNU3/ca7UYw8N8H6yKH3+m9rccLOp4VKM4y
	 siK5skeKa+z0CYMC46rutEH7sE5eK7x3TO27kwnh2pJDBDj5R+2l3qqZCtE3UzaA/Y
	 +1cJYC0+t0p7mqktPfON0spAHKE9dEEXRKQr/MRhpIE5PMSIMMwi/PQwOBEc3D/wYD
	 OWxrBQMbXrhUQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:13 +0100
Subject: [PATCH 01/17] ns: move namespace types into separate header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-1-e8a9264e0fb9@kernel.org>
References: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
In-Reply-To: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=19867; i=brauner@kernel.org;
 h=from:subject:message-id; bh=l2gKHF5YYANi9iKUp1grUz0ml7BUm8UgkW3nXou45Fg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v/MvodDfu+MGSmsKzdrGOR2GG59Gnj1wBfl4k8rl
 Yu6z4oJdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExElI3hn8nSWoZ9rSs0V1Vc
 162TbZbdp3NS7KPPvZvbDk97eW/nqXuMDIdfSB7KWd+b/VH6T6XgrQiJRm6JDy8XhQrLfLkg8y5
 /Og8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a dedicated header for namespace types.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns/ns_common_types.h | 205 +++++++++++++++++++++++++++++++++++++
 include/linux/ns_common.h          | 196 +----------------------------------
 2 files changed, 206 insertions(+), 195 deletions(-)

diff --git a/include/linux/ns/ns_common_types.h b/include/linux/ns/ns_common_types.h
new file mode 100644
index 000000000000..ccd1d1e116f6
--- /dev/null
+++ b/include/linux/ns/ns_common_types.h
@@ -0,0 +1,205 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_NS_COMMON_TYPES_H
+#define _LINUX_NS_COMMON_TYPES_H
+
+#include <linux/atomic.h>
+#include <linux/rbtree.h>
+#include <linux/refcount.h>
+#include <linux/types.h>
+
+struct cgroup_namespace;
+struct dentry;
+struct ipc_namespace;
+struct mnt_namespace;
+struct net;
+struct pid_namespace;
+struct proc_ns_operations;
+struct time_namespace;
+struct user_namespace;
+struct uts_namespace;
+
+extern struct cgroup_namespace init_cgroup_ns;
+extern struct ipc_namespace init_ipc_ns;
+extern struct mnt_namespace init_mnt_ns;
+extern struct net init_net;
+extern struct pid_namespace init_pid_ns;
+extern struct time_namespace init_time_ns;
+extern struct user_namespace init_user_ns;
+extern struct uts_namespace init_uts_ns;
+
+extern const struct proc_ns_operations cgroupns_operations;
+extern const struct proc_ns_operations ipcns_operations;
+extern const struct proc_ns_operations mntns_operations;
+extern const struct proc_ns_operations netns_operations;
+extern const struct proc_ns_operations pidns_operations;
+extern const struct proc_ns_operations pidns_for_children_operations;
+extern const struct proc_ns_operations timens_operations;
+extern const struct proc_ns_operations timens_for_children_operations;
+extern const struct proc_ns_operations userns_operations;
+extern const struct proc_ns_operations utsns_operations;
+
+/*
+ * Namespace lifetimes are managed via a two-tier reference counting model:
+ *
+ * (1) __ns_ref (refcount_t): Main reference count tracking memory
+ *     lifetime. Controls when the namespace structure itself is freed.
+ *     It also pins the namespace on the namespace trees whereas (2)
+ *     only regulates their visibility to userspace.
+ *
+ * (2) __ns_ref_active (atomic_t): Reference count tracking active users.
+ *     Controls visibility of the namespace in the namespace trees.
+ *     Any live task that uses the namespace (via nsproxy or cred) holds
+ *     an active reference. Any open file descriptor or bind-mount of
+ *     the namespace holds an active reference. Once all tasks have
+ *     called exited their namespaces and all file descriptors and
+ *     bind-mounts have been released the active reference count drops
+ *     to zero and the namespace becomes inactive. IOW, the namespace
+ *     cannot be listed or opened via file handles anymore.
+ *
+ *     Note that it is valid to transition from active to inactive and
+ *     back from inactive to active e.g., when resurrecting an inactive
+ *     namespace tree via the SIOCGSKNS ioctl().
+ *
+ * Relationship and lifecycle states:
+ *
+ * - Active (__ns_ref_active > 0):
+ *   Namespace is actively used and visible to userspace. The namespace
+ *   can be reopened via /proc/<pid>/ns/<ns_type>, via namespace file
+ *   handles, or discovered via listns().
+ *
+ * - Inactive (__ns_ref_active == 0, __ns_ref > 0):
+ *   No tasks are actively using the namespace and it isn't pinned by
+ *   any bind-mounts or open file descriptors anymore. But the namespace
+ *   is still kept alive by internal references. For example, the user
+ *   namespace could be pinned by an open file through file->f_cred
+ *   references when one of the now defunct tasks had opened a file and
+ *   handed the file descriptor off to another process via a UNIX
+ *   sockets. Such references keep the namespace structure alive through
+ *   __ns_ref but will not hold an active reference.
+ *
+ * - Destroyed (__ns_ref == 0):
+ *   No references remain. The namespace is removed from the tree and freed.
+ *
+ * State transitions:
+ *
+ * Active -> Inactive:
+ *   When the last task using the namespace exits it drops its active
+ *   references to all namespaces. However, user and pid namespaces
+ *   remain accessible until the task has been reaped.
+ *
+ * Inactive -> Active:
+ *   An inactive namespace tree might be resurrected due to e.g., the
+ *   SIOCGSKNS ioctl() on a socket.
+ *
+ * Inactive -> Destroyed:
+ *   When __ns_ref drops to zero the namespace is removed from the
+ *   namespaces trees and the memory is freed (after RCU grace period).
+ *
+ * Initial namespaces:
+ *   Boot-time namespaces (init_net, init_pid_ns, etc.) start with
+ *   __ns_ref_active = 1 and remain active forever.
+ */
+struct ns_common {
+	u32 ns_type;
+	struct dentry *stashed;
+	const struct proc_ns_operations *ops;
+	unsigned int inum;
+	refcount_t __ns_ref; /* do not use directly */
+	union {
+		struct {
+			u64 ns_id;
+			struct /* global namespace rbtree and list */ {
+				struct rb_node ns_unified_tree_node;
+				struct list_head ns_unified_list_node;
+			};
+			struct /* per type rbtree and list */ {
+				struct rb_node ns_tree_node;
+				struct list_head ns_list_node;
+			};
+			struct /* namespace ownership rbtree and list */ {
+				struct rb_root ns_owner_tree; /* rbtree of namespaces owned by this namespace */
+				struct list_head ns_owner; /* list of namespaces owned by this namespace */
+				struct rb_node ns_owner_tree_node; /* node in the owner namespace's rbtree */
+				struct list_head ns_owner_entry; /* node in the owner namespace's ns_owned list */
+			};
+			atomic_t __ns_ref_active; /* do not use directly */
+		};
+		struct rcu_head ns_rcu;
+	};
+};
+
+#define to_ns_common(__ns)                                    \
+	_Generic((__ns),                                      \
+		struct cgroup_namespace *:       &(__ns)->ns, \
+		const struct cgroup_namespace *: &(__ns)->ns, \
+		struct ipc_namespace *:          &(__ns)->ns, \
+		const struct ipc_namespace *:    &(__ns)->ns, \
+		struct mnt_namespace *:          &(__ns)->ns, \
+		const struct mnt_namespace *:    &(__ns)->ns, \
+		struct net *:                    &(__ns)->ns, \
+		const struct net *:              &(__ns)->ns, \
+		struct pid_namespace *:          &(__ns)->ns, \
+		const struct pid_namespace *:    &(__ns)->ns, \
+		struct time_namespace *:         &(__ns)->ns, \
+		const struct time_namespace *:   &(__ns)->ns, \
+		struct user_namespace *:         &(__ns)->ns, \
+		const struct user_namespace *:   &(__ns)->ns, \
+		struct uts_namespace *:          &(__ns)->ns, \
+		const struct uts_namespace *:    &(__ns)->ns)
+
+#define ns_init_inum(__ns)                                     \
+	_Generic((__ns),                                       \
+		struct cgroup_namespace *: CGROUP_NS_INIT_INO, \
+		struct ipc_namespace *:    IPC_NS_INIT_INO,    \
+		struct mnt_namespace *:    MNT_NS_INIT_INO,    \
+		struct net *:              NET_NS_INIT_INO,    \
+		struct pid_namespace *:    PID_NS_INIT_INO,    \
+		struct time_namespace *:   TIME_NS_INIT_INO,   \
+		struct user_namespace *:   USER_NS_INIT_INO,   \
+		struct uts_namespace *:    UTS_NS_INIT_INO)
+
+#define ns_init_ns(__ns)                                    \
+	_Generic((__ns),                                    \
+		struct cgroup_namespace *: &init_cgroup_ns, \
+		struct ipc_namespace *:    &init_ipc_ns,    \
+		struct mnt_namespace *:    &init_mnt_ns,     \
+		struct net *:              &init_net,       \
+		struct pid_namespace *:    &init_pid_ns,    \
+		struct time_namespace *:   &init_time_ns,   \
+		struct user_namespace *:   &init_user_ns,   \
+		struct uts_namespace *:    &init_uts_ns)
+
+#define ns_init_id(__ns)						\
+	_Generic((__ns),						\
+		struct cgroup_namespace *:	CGROUP_NS_INIT_ID,	\
+		struct ipc_namespace *:		IPC_NS_INIT_ID,		\
+		struct mnt_namespace *:		MNT_NS_INIT_ID,		\
+		struct net *:			NET_NS_INIT_ID,		\
+		struct pid_namespace *:		PID_NS_INIT_ID,		\
+		struct time_namespace *:	TIME_NS_INIT_ID,	\
+		struct user_namespace *:	USER_NS_INIT_ID,	\
+		struct uts_namespace *:		UTS_NS_INIT_ID)
+
+#define to_ns_operations(__ns)                                                                         \
+	_Generic((__ns),                                                                               \
+		struct cgroup_namespace *: (IS_ENABLED(CONFIG_CGROUPS) ? &cgroupns_operations : NULL), \
+		struct ipc_namespace *:    (IS_ENABLED(CONFIG_IPC_NS)  ? &ipcns_operations    : NULL), \
+		struct mnt_namespace *:    &mntns_operations,                                          \
+		struct net *:              (IS_ENABLED(CONFIG_NET_NS)  ? &netns_operations    : NULL), \
+		struct pid_namespace *:    (IS_ENABLED(CONFIG_PID_NS)  ? &pidns_operations    : NULL), \
+		struct time_namespace *:   (IS_ENABLED(CONFIG_TIME_NS) ? &timens_operations   : NULL), \
+		struct user_namespace *:   (IS_ENABLED(CONFIG_USER_NS) ? &userns_operations   : NULL), \
+		struct uts_namespace *:    (IS_ENABLED(CONFIG_UTS_NS)  ? &utsns_operations    : NULL))
+
+#define ns_common_type(__ns)                                \
+	_Generic((__ns),                                    \
+		struct cgroup_namespace *: CLONE_NEWCGROUP, \
+		struct ipc_namespace *:    CLONE_NEWIPC,    \
+		struct mnt_namespace *:    CLONE_NEWNS,     \
+		struct net *:              CLONE_NEWNET,    \
+		struct pid_namespace *:    CLONE_NEWPID,    \
+		struct time_namespace *:   CLONE_NEWTIME,   \
+		struct user_namespace *:   CLONE_NEWUSER,   \
+		struct uts_namespace *:    CLONE_NEWUTS)
+
+#endif /* _LINUX_NS_COMMON_TYPES_H */
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 66ea09b48377..6a4ca8c3b9c4 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -2,133 +2,12 @@
 #ifndef _LINUX_NS_COMMON_H
 #define _LINUX_NS_COMMON_H
 
+#include <linux/ns/ns_common_types.h>
 #include <linux/refcount.h>
-#include <linux/rbtree.h>
 #include <linux/vfsdebug.h>
 #include <uapi/linux/sched.h>
 #include <uapi/linux/nsfs.h>
 
-struct proc_ns_operations;
-
-struct cgroup_namespace;
-struct ipc_namespace;
-struct mnt_namespace;
-struct net;
-struct pid_namespace;
-struct time_namespace;
-struct user_namespace;
-struct uts_namespace;
-
-extern struct cgroup_namespace init_cgroup_ns;
-extern struct ipc_namespace init_ipc_ns;
-extern struct mnt_namespace init_mnt_ns;
-extern struct net init_net;
-extern struct pid_namespace init_pid_ns;
-extern struct time_namespace init_time_ns;
-extern struct user_namespace init_user_ns;
-extern struct uts_namespace init_uts_ns;
-
-extern const struct proc_ns_operations netns_operations;
-extern const struct proc_ns_operations utsns_operations;
-extern const struct proc_ns_operations ipcns_operations;
-extern const struct proc_ns_operations pidns_operations;
-extern const struct proc_ns_operations pidns_for_children_operations;
-extern const struct proc_ns_operations userns_operations;
-extern const struct proc_ns_operations mntns_operations;
-extern const struct proc_ns_operations cgroupns_operations;
-extern const struct proc_ns_operations timens_operations;
-extern const struct proc_ns_operations timens_for_children_operations;
-
-/*
- * Namespace lifetimes are managed via a two-tier reference counting model:
- *
- * (1) __ns_ref (refcount_t): Main reference count tracking memory
- *     lifetime. Controls when the namespace structure itself is freed.
- *     It also pins the namespace on the namespace trees whereas (2)
- *     only regulates their visibility to userspace.
- *
- * (2) __ns_ref_active (atomic_t): Reference count tracking active users.
- *     Controls visibility of the namespace in the namespace trees.
- *     Any live task that uses the namespace (via nsproxy or cred) holds
- *     an active reference. Any open file descriptor or bind-mount of
- *     the namespace holds an active reference. Once all tasks have
- *     called exited their namespaces and all file descriptors and
- *     bind-mounts have been released the active reference count drops
- *     to zero and the namespace becomes inactive. IOW, the namespace
- *     cannot be listed or opened via file handles anymore.
- *
- *     Note that it is valid to transition from active to inactive and
- *     back from inactive to active e.g., when resurrecting an inactive
- *     namespace tree via the SIOCGSKNS ioctl().
- *
- * Relationship and lifecycle states:
- *
- * - Active (__ns_ref_active > 0):
- *   Namespace is actively used and visible to userspace. The namespace
- *   can be reopened via /proc/<pid>/ns/<ns_type>, via namespace file
- *   handles, or discovered via listns().
- *
- * - Inactive (__ns_ref_active == 0, __ns_ref > 0):
- *   No tasks are actively using the namespace and it isn't pinned by
- *   any bind-mounts or open file descriptors anymore. But the namespace
- *   is still kept alive by internal references. For example, the user
- *   namespace could be pinned by an open file through file->f_cred
- *   references when one of the now defunct tasks had opened a file and
- *   handed the file descriptor off to another process via a UNIX
- *   sockets. Such references keep the namespace structure alive through
- *   __ns_ref but will not hold an active reference.
- *
- * - Destroyed (__ns_ref == 0):
- *   No references remain. The namespace is removed from the tree and freed.
- *
- * State transitions:
- *
- * Active -> Inactive:
- *   When the last task using the namespace exits it drops its active
- *   references to all namespaces. However, user and pid namespaces
- *   remain accessible until the task has been reaped.
- *
- * Inactive -> Active:
- *   An inactive namespace tree might be resurrected due to e.g., the
- *   SIOCGSKNS ioctl() on a socket.
- *
- * Inactive -> Destroyed:
- *   When __ns_ref drops to zero the namespace is removed from the
- *   namespaces trees and the memory is freed (after RCU grace period).
- *
- * Initial namespaces:
- *   Boot-time namespaces (init_net, init_pid_ns, etc.) start with
- *   __ns_ref_active = 1 and remain active forever.
- */
-struct ns_common {
-	u32 ns_type;
-	struct dentry *stashed;
-	const struct proc_ns_operations *ops;
-	unsigned int inum;
-	refcount_t __ns_ref; /* do not use directly */
-	union {
-		struct {
-			u64 ns_id;
-			struct /* global namespace rbtree and list */ {
-				struct rb_node ns_unified_tree_node;
-				struct list_head ns_unified_list_node;
-			};
-			struct /* per type rbtree and list */ {
-				struct rb_node ns_tree_node;
-				struct list_head ns_list_node;
-			};
-			struct /* namespace ownership rbtree and list */ {
-				struct rb_root ns_owner_tree; /* rbtree of namespaces owned by this namespace */
-				struct list_head ns_owner; /* list of namespaces owned by this namespace */
-				struct rb_node ns_owner_tree_node; /* node in the owner namespace's rbtree */
-				struct list_head ns_owner_entry; /* node in the owner namespace's ns_owned list */
-			};
-			atomic_t __ns_ref_active; /* do not use directly */
-		};
-		struct rcu_head ns_rcu;
-	};
-};
-
 bool is_current_namespace(struct ns_common *ns);
 int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum);
 void __ns_common_free(struct ns_common *ns);
@@ -147,79 +26,6 @@ static __always_inline bool is_ns_init_id(const struct ns_common *ns)
 	return ns->ns_id <= NS_LAST_INIT_ID;
 }
 
-#define to_ns_common(__ns)                                    \
-	_Generic((__ns),                                      \
-		struct cgroup_namespace *:       &(__ns)->ns, \
-		const struct cgroup_namespace *: &(__ns)->ns, \
-		struct ipc_namespace *:          &(__ns)->ns, \
-		const struct ipc_namespace *:    &(__ns)->ns, \
-		struct mnt_namespace *:          &(__ns)->ns, \
-		const struct mnt_namespace *:    &(__ns)->ns, \
-		struct net *:                    &(__ns)->ns, \
-		const struct net *:              &(__ns)->ns, \
-		struct pid_namespace *:          &(__ns)->ns, \
-		const struct pid_namespace *:    &(__ns)->ns, \
-		struct time_namespace *:         &(__ns)->ns, \
-		const struct time_namespace *:   &(__ns)->ns, \
-		struct user_namespace *:         &(__ns)->ns, \
-		const struct user_namespace *:   &(__ns)->ns, \
-		struct uts_namespace *:          &(__ns)->ns, \
-		const struct uts_namespace *:    &(__ns)->ns)
-
-#define ns_init_inum(__ns)                                     \
-	_Generic((__ns),                                       \
-		struct cgroup_namespace *: CGROUP_NS_INIT_INO, \
-		struct ipc_namespace *:    IPC_NS_INIT_INO,    \
-		struct mnt_namespace *:    MNT_NS_INIT_INO,    \
-		struct net *:              NET_NS_INIT_INO,    \
-		struct pid_namespace *:    PID_NS_INIT_INO,    \
-		struct time_namespace *:   TIME_NS_INIT_INO,   \
-		struct user_namespace *:   USER_NS_INIT_INO,   \
-		struct uts_namespace *:    UTS_NS_INIT_INO)
-
-#define ns_init_ns(__ns)                                    \
-	_Generic((__ns),                                    \
-		struct cgroup_namespace *: &init_cgroup_ns, \
-		struct ipc_namespace *:    &init_ipc_ns,    \
-		struct mnt_namespace *:    &init_mnt_ns,     \
-		struct net *:              &init_net,       \
-		struct pid_namespace *:    &init_pid_ns,    \
-		struct time_namespace *:   &init_time_ns,   \
-		struct user_namespace *:   &init_user_ns,   \
-		struct uts_namespace *:    &init_uts_ns)
-
-#define ns_init_id(__ns)						\
-	_Generic((__ns),						\
-		struct cgroup_namespace *:	CGROUP_NS_INIT_ID,	\
-		struct ipc_namespace *:		IPC_NS_INIT_ID,		\
-		struct mnt_namespace *:		MNT_NS_INIT_ID,		\
-		struct net *:			NET_NS_INIT_ID,		\
-		struct pid_namespace *:		PID_NS_INIT_ID,		\
-		struct time_namespace *:	TIME_NS_INIT_ID,	\
-		struct user_namespace *:	USER_NS_INIT_ID,	\
-		struct uts_namespace *:		UTS_NS_INIT_ID)
-
-#define to_ns_operations(__ns)                                                                         \
-	_Generic((__ns),                                                                               \
-		struct cgroup_namespace *: (IS_ENABLED(CONFIG_CGROUPS) ? &cgroupns_operations : NULL), \
-		struct ipc_namespace *:    (IS_ENABLED(CONFIG_IPC_NS)  ? &ipcns_operations    : NULL), \
-		struct mnt_namespace *:    &mntns_operations,                                          \
-		struct net *:              (IS_ENABLED(CONFIG_NET_NS)  ? &netns_operations    : NULL), \
-		struct pid_namespace *:    (IS_ENABLED(CONFIG_PID_NS)  ? &pidns_operations    : NULL), \
-		struct time_namespace *:   (IS_ENABLED(CONFIG_TIME_NS) ? &timens_operations   : NULL), \
-		struct user_namespace *:   (IS_ENABLED(CONFIG_USER_NS) ? &userns_operations   : NULL), \
-		struct uts_namespace *:    (IS_ENABLED(CONFIG_UTS_NS)  ? &utsns_operations    : NULL))
-
-#define ns_common_type(__ns)                                \
-	_Generic((__ns),                                    \
-		struct cgroup_namespace *: CLONE_NEWCGROUP, \
-		struct ipc_namespace *:    CLONE_NEWIPC,    \
-		struct mnt_namespace *:    CLONE_NEWNS,     \
-		struct net *:              CLONE_NEWNET,    \
-		struct pid_namespace *:    CLONE_NEWPID,    \
-		struct time_namespace *:   CLONE_NEWTIME,   \
-		struct user_namespace *:   CLONE_NEWUSER,   \
-		struct uts_namespace *:    CLONE_NEWUTS)
 
 #define NS_COMMON_INIT(nsname, refs)							\
 {											\

-- 
2.47.3


