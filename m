Return-Path: <linux-fsdevel+bounces-62563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0592BB9999B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627E47A5FCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436CF2FD7D6;
	Wed, 24 Sep 2025 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlW3iZrJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907B72FC011;
	Wed, 24 Sep 2025 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713660; cv=none; b=d98zVKs03Wvn+lc81BjNqG0Po7lOzKLuRiKKGRSqoVjZ6OyfaGPPONyniEnZM/enKRa26SedFM/8pbaoL0src/FZYi51uGlm/Y1gGaNXNpGiZAyiYESgyfCIHcGuXw6F1rG6pvMW6gTZXJusnX+VkIT+VoMFsWnt0veyqqHjYvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713660; c=relaxed/simple;
	bh=csdZcaDTZm69aQfJIrJPAiPZoXSVvrPNWee2K3u4J/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lhzEeqHzUTUx2+m2Xy5mof/MMhcdomyzDgFqyq8g6mrIfd8Vwz2VEcQ30hWPOAkwf2I/ANN0JrdIs+7IoDRWUrhYQB4CMKI3F5F3qOSzzvT6Q/zmHWoTjBW7jvuws9FJ5gaHzAtonBfFKGfBF5MJuOAsiKv/yWwd8kQ7scw+Exs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlW3iZrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E83C19422;
	Wed, 24 Sep 2025 11:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758713660;
	bh=csdZcaDTZm69aQfJIrJPAiPZoXSVvrPNWee2K3u4J/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VlW3iZrJ2RGOjS7JN1bcSZ+DXoCqDRkWewsrfOOc4tyZaBtXDJMZeOul91cnIpBYR
	 4wywu2sBRao3KYyFqwIdL5DTEt0UJqIh6xcIVzBNRtLcDO2+rRsv0nk9s/4CLZM+n0
	 BFRxEox3bI7ka4UrB6bU86nM/Y2AWY1Cxp+MjPfXCWtSCPKk4BuUowIUI+XgePTo5y
	 WvI6DNDZF/E9cRQk/R4nrmPmDqHNVpUjajEdaUMblRLftKEtA0ILaa1eXJcrjk0Pf0
	 3wmYNVq5bfXcCW/yQlORunmZQl8ZeSNFWpayJ5hLNu7Mg4bYeZQnOI/4bDDlsUSJbH
	 DvFMdHZKTnAag==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 24 Sep 2025 13:33:59 +0200
Subject: [PATCH 2/3] ns: move ns type into struct ns_common
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-work-namespaces-fixes-v1-2-8fb682c8678e@kernel.org>
References: <20250924-work-namespaces-fixes-v1-0-8fb682c8678e@kernel.org>
In-Reply-To: <20250924-work-namespaces-fixes-v1-0-8fb682c8678e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=16652; i=brauner@kernel.org;
 h=from:subject:message-id; bh=csdZcaDTZm69aQfJIrJPAiPZoXSVvrPNWee2K3u4J/Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcvq5fsip/Xqb0x+QtNqsv/Sn1UtriUfteRNRhQWrQB
 A67J4YuHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOxesrwm23P7YuSwa7aN3L6
 7oY3PLihs7NNuGaz6a/Ptgw3zxUHGTEyPJ4+1UVYear/77lLDaZtbtx/1kNoXnHgipgtx6ZuSlr
 nwQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It's misplaced in struct proc_ns_operations and ns->ops might be NULL if
the namespace is compiled out but we still want to know the type of the
namespace for the initial namespace struct.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c            |  6 +++---
 fs/nsfs.c                 | 18 +++++++++---------
 include/linux/ns_common.h | 30 +++++++++++++++++++++++++-----
 include/linux/proc_ns.h   |  1 -
 init/version-timestamp.c  |  1 +
 ipc/msgutil.c             |  1 +
 ipc/namespace.c           |  1 -
 kernel/cgroup/cgroup.c    |  1 +
 kernel/cgroup/namespace.c |  1 -
 kernel/nscommon.c         |  5 +++--
 kernel/nsproxy.c          |  4 ++--
 kernel/nstree.c           |  8 ++++----
 kernel/pid.c              |  1 +
 kernel/pid_namespace.c    |  2 --
 kernel/time/namespace.c   |  3 +--
 kernel/user.c             |  1 +
 kernel/user_namespace.c   |  1 -
 kernel/utsname.c          |  1 -
 net/core/net_namespace.c  |  1 -
 19 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d65917ec5544..01334d5038a2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4927,7 +4927,7 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
 		return -EINVAL;
 
 	ns = get_proc_ns(file_inode(fd_file(f)));
-	if (ns->ops->type != CLONE_NEWUSER)
+	if (ns->ns_type != CLONE_NEWUSER)
 		return -EINVAL;
 
 	/*
@@ -5830,7 +5830,7 @@ static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq
 			return ERR_PTR(-EINVAL);
 
 		ns = get_proc_ns(file_inode(fd_file(f)));
-		if (ns->ops->type != CLONE_NEWNS)
+		if (ns->ns_type != CLONE_NEWNS)
 			return ERR_PTR(-EINVAL);
 
 		mnt_ns = to_mnt_ns(ns);
@@ -6016,6 +6016,7 @@ struct mnt_namespace init_mnt_ns = {
 	.ns.ops		= &mntns_operations,
 	.user_ns	= &init_user_ns,
 	.ns.__ns_ref	= REFCOUNT_INIT(1),
+	.ns.ns_type	= ns_common_type(&init_mnt_ns),
 	.passive	= REFCOUNT_INIT(1),
 	.mounts		= RB_ROOT,
 	.poll		= __WAIT_QUEUE_HEAD_INITIALIZER(init_mnt_ns.poll),
@@ -6333,7 +6334,6 @@ static struct user_namespace *mntns_owner(struct ns_common *ns)
 
 const struct proc_ns_operations mntns_operations = {
 	.name		= "mnt",
-	.type		= CLONE_NEWNS,
 	.get		= mntns_get,
 	.put		= mntns_put,
 	.install	= mntns_install,
diff --git a/fs/nsfs.c b/fs/nsfs.c
index dc0a4404b971..e7fd8a790aaa 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -219,9 +219,9 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			return -EINVAL;
 		return open_related_ns(ns, ns->ops->get_parent);
 	case NS_GET_NSTYPE:
-		return ns->ops->type;
+		return ns->ns_type;
 	case NS_GET_OWNER_UID:
-		if (ns->ops->type != CLONE_NEWUSER)
+		if (ns->ns_type != CLONE_NEWUSER)
 			return -EINVAL;
 		user_ns = container_of(ns, struct user_namespace, ns);
 		argp = (uid_t __user *) arg;
@@ -234,7 +234,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 	case NS_GET_PID_IN_PIDNS:
 		fallthrough;
 	case NS_GET_TGID_IN_PIDNS: {
-		if (ns->ops->type != CLONE_NEWPID)
+		if (ns->ns_type != CLONE_NEWPID)
 			return -EINVAL;
 
 		ret = -ESRCH;
@@ -273,7 +273,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		return ret;
 	}
 	case NS_GET_MNTNS_ID:
-		if (ns->ops->type != CLONE_NEWNS)
+		if (ns->ns_type != CLONE_NEWNS)
 			return -EINVAL;
 		fallthrough;
 	case NS_GET_ID: {
@@ -293,7 +293,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		struct mnt_ns_info __user *uinfo = (struct mnt_ns_info __user *)arg;
 		size_t usize = _IOC_SIZE(ioctl);
 
-		if (ns->ops->type != CLONE_NEWNS)
+		if (ns->ns_type != CLONE_NEWNS)
 			return -EINVAL;
 
 		if (!uinfo)
@@ -314,7 +314,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		struct file *f __free(fput) = NULL;
 		size_t usize = _IOC_SIZE(ioctl);
 
-		if (ns->ops->type != CLONE_NEWNS)
+		if (ns->ns_type != CLONE_NEWNS)
 			return -EINVAL;
 
 		if (usize < MNT_NS_INFO_SIZE_VER0)
@@ -453,7 +453,7 @@ static int nsfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	}
 
 	fid->ns_id	= ns->ns_id;
-	fid->ns_type	= ns->ops->type;
+	fid->ns_type	= ns->ns_type;
 	fid->ns_inum	= inode->i_ino;
 	return FILEID_NSFS;
 }
@@ -489,14 +489,14 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 			return NULL;
 
 		VFS_WARN_ON_ONCE(ns->ns_id != fid->ns_id);
-		VFS_WARN_ON_ONCE(ns->ops->type != fid->ns_type);
+		VFS_WARN_ON_ONCE(ns->ns_type != fid->ns_type);
 		VFS_WARN_ON_ONCE(ns->inum != fid->ns_inum);
 
 		if (!__ns_ref_get(ns))
 			return NULL;
 	}
 
-	switch (ns->ops->type) {
+	switch (ns->ns_type) {
 #ifdef CONFIG_CGROUPS
 	case CLONE_NEWCGROUP:
 		if (!current_in_namespace(to_cg_ns(ns)))
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 56492cd9ff8d..f5b68b8abb54 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -4,6 +4,7 @@
 
 #include <linux/refcount.h>
 #include <linux/rbtree.h>
+#include <uapi/linux/sched.h>
 
 struct proc_ns_operations;
 
@@ -37,6 +38,7 @@ extern const struct proc_ns_operations timens_operations;
 extern const struct proc_ns_operations timens_for_children_operations;
 
 struct ns_common {
+	u32 ns_type;
 	struct dentry *stashed;
 	const struct proc_ns_operations *ops;
 	unsigned int inum;
@@ -51,7 +53,7 @@ struct ns_common {
 	};
 };
 
-int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops, int inum);
+int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum);
 void __ns_common_free(struct ns_common *ns);
 
 #define to_ns_common(__ns)                                    \
@@ -106,10 +108,28 @@ void __ns_common_free(struct ns_common *ns);
 		struct user_namespace *:   (IS_ENABLED(CONFIG_USER_NS) ? &userns_operations   : NULL), \
 		struct uts_namespace *:    (IS_ENABLED(CONFIG_UTS_NS)  ? &utsns_operations    : NULL))
 
-#define ns_common_init(__ns) \
-	__ns_common_init(to_ns_common(__ns), to_ns_operations(__ns), (((__ns) == ns_init_ns(__ns)) ? ns_init_inum(__ns) : 0))
-
-#define ns_common_init_inum(__ns, __inum) __ns_common_init(to_ns_common(__ns), to_ns_operations(__ns), __inum)
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
+#define ns_common_init(__ns)                     \
+	__ns_common_init(to_ns_common(__ns),     \
+			 ns_common_type(__ns),   \
+			 to_ns_operations(__ns), \
+			 (((__ns) == ns_init_ns(__ns)) ? ns_init_inum(__ns) : 0))
+
+#define ns_common_init_inum(__ns, __inum)        \
+	__ns_common_init(to_ns_common(__ns),     \
+			 ns_common_type(__ns),   \
+			 to_ns_operations(__ns), \
+			 __inum)
 
 #define ns_common_free(__ns) __ns_common_free(to_ns_common((__ns)))
 
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 08016f6e0e6f..e81b8e596e4f 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -17,7 +17,6 @@ struct inode;
 struct proc_ns_operations {
 	const char *name;
 	const char *real_ns_name;
-	int type;
 	struct ns_common *(*get)(struct task_struct *task);
 	void (*put)(struct ns_common *ns);
 	int (*install)(struct nsset *nsset, struct ns_common *ns);
diff --git a/init/version-timestamp.c b/init/version-timestamp.c
index 376b7c856d4d..d071835121c2 100644
--- a/init/version-timestamp.c
+++ b/init/version-timestamp.c
@@ -8,6 +8,7 @@
 #include <linux/utsname.h>
 
 struct uts_namespace init_uts_ns = {
+	.ns.ns_type = ns_common_type(&init_uts_ns),
 	.ns.__ns_ref = REFCOUNT_INIT(2),
 	.name = {
 		.sysname	= UTS_SYSNAME,
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index dca6c8ec8f5f..7a03f6d03de3 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -33,6 +33,7 @@ struct ipc_namespace init_ipc_ns = {
 #ifdef CONFIG_IPC_NS
 	.ns.ops = &ipcns_operations,
 #endif
+	.ns.ns_type = ns_common_type(&init_ipc_ns),
 };
 
 struct msg_msgseg {
diff --git a/ipc/namespace.c b/ipc/namespace.c
index d89dfd718d2b..76abac74a5c3 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -248,7 +248,6 @@ static struct user_namespace *ipcns_owner(struct ns_common *ns)
 
 const struct proc_ns_operations ipcns_operations = {
 	.name		= "ipc",
-	.type		= CLONE_NEWIPC,
 	.get		= ipcns_get,
 	.put		= ipcns_put,
 	.install	= ipcns_install,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 245b43ff2fa4..9b75102e81cb 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -224,6 +224,7 @@ struct cgroup_namespace init_cgroup_ns = {
 	.ns.ops		= &cgroupns_operations,
 	.ns.inum	= ns_init_inum(&init_cgroup_ns),
 	.root_cset	= &init_css_set,
+	.ns.ns_type	= ns_common_type(&init_cgroup_ns),
 };
 
 static struct file_system_type cgroup2_fs_type;
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index 04c98338ac08..241ca05f07c8 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -137,7 +137,6 @@ static struct user_namespace *cgroupns_owner(struct ns_common *ns)
 
 const struct proc_ns_operations cgroupns_operations = {
 	.name		= "cgroup",
-	.type		= CLONE_NEWCGROUP,
 	.get		= cgroupns_get,
 	.put		= cgroupns_put,
 	.install	= cgroupns_install,
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index 3cef89ddef41..92c9df1e8774 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -7,7 +7,7 @@
 #ifdef CONFIG_DEBUG_VFS
 static void ns_debug(struct ns_common *ns, const struct proc_ns_operations *ops)
 {
-	switch (ns->ops->type) {
+	switch (ns->ns_type) {
 #ifdef CONFIG_CGROUPS
 	case CLONE_NEWCGROUP:
 		VFS_WARN_ON_ONCE(ops != &cgroupns_operations);
@@ -52,12 +52,13 @@ static void ns_debug(struct ns_common *ns, const struct proc_ns_operations *ops)
 }
 #endif
 
-int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops, int inum)
+int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum)
 {
 	refcount_set(&ns->__ns_ref, 1);
 	ns->stashed = NULL;
 	ns->ops = ops;
 	ns->ns_id = 0;
+	ns->ns_type = ns_type;
 	RB_CLEAR_NODE(&ns->ns_tree_node);
 	INIT_LIST_HEAD(&ns->ns_list_node);
 
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 5f31fdff8a38..8d62449237b6 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -545,9 +545,9 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 
 	if (proc_ns_file(fd_file(f))) {
 		ns = get_proc_ns(file_inode(fd_file(f)));
-		if (flags && (ns->ops->type != flags))
+		if (flags && (ns->ns_type != flags))
 			err = -EINVAL;
-		flags = ns->ops->type;
+		flags = ns->ns_type;
 	} else if (!IS_ERR(pidfd_pid(fd_file(f)))) {
 		err = check_setns_flags(flags);
 	} else {
diff --git a/kernel/nstree.c b/kernel/nstree.c
index 113d681857f1..ef956924db06 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -105,7 +105,7 @@ void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
 
 	write_seqlock(&ns_tree->ns_tree_lock);
 
-	VFS_WARN_ON_ONCE(ns->ops->type != ns_tree->type);
+	VFS_WARN_ON_ONCE(ns->ns_type != ns_tree->type);
 
 	node = rb_find_add_rcu(&ns->ns_tree_node, &ns_tree->ns_tree, ns_cmp);
 	/*
@@ -127,7 +127,7 @@ void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree)
 {
 	VFS_WARN_ON_ONCE(RB_EMPTY_NODE(&ns->ns_tree_node));
 	VFS_WARN_ON_ONCE(list_empty(&ns->ns_list_node));
-	VFS_WARN_ON_ONCE(ns->ops->type != ns_tree->type);
+	VFS_WARN_ON_ONCE(ns->ns_type != ns_tree->type);
 
 	write_seqlock(&ns_tree->ns_tree_lock);
 	rb_erase(&ns->ns_tree_node, &ns_tree->ns_tree);
@@ -196,7 +196,7 @@ struct ns_common *ns_tree_lookup_rcu(u64 ns_id, int ns_type)
 	if (!node)
 		return NULL;
 
-	VFS_WARN_ON_ONCE(node_to_ns(node)->ops->type != ns_type);
+	VFS_WARN_ON_ONCE(node_to_ns(node)->ns_type != ns_type);
 
 	return node_to_ns(node);
 }
@@ -224,7 +224,7 @@ struct ns_common *__ns_tree_adjoined_rcu(struct ns_common *ns,
 	if (list_is_head(list, &ns_tree->ns_list))
 		return ERR_PTR(-ENOENT);
 
-	VFS_WARN_ON_ONCE(list_entry_rcu(list, struct ns_common, ns_list_node)->ops->type != ns_tree->type);
+	VFS_WARN_ON_ONCE(list_entry_rcu(list, struct ns_common, ns_list_node)->ns_type != ns_tree->type);
 
 	return list_entry_rcu(list, struct ns_common, ns_list_node);
 }
diff --git a/kernel/pid.c b/kernel/pid.c
index 7e8c66e0bf67..0c2dcddb317a 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -85,6 +85,7 @@ struct pid_namespace init_pid_ns = {
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
 	.memfd_noexec_scope = MEMFD_NOEXEC_SCOPE_EXEC,
 #endif
+	.ns.ns_type = ns_common_type(&init_pid_ns),
 };
 EXPORT_SYMBOL_GPL(init_pid_ns);
 
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index a262a3f19443..f5b222c8ac39 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -443,7 +443,6 @@ static struct user_namespace *pidns_owner(struct ns_common *ns)
 
 const struct proc_ns_operations pidns_operations = {
 	.name		= "pid",
-	.type		= CLONE_NEWPID,
 	.get		= pidns_get,
 	.put		= pidns_put,
 	.install	= pidns_install,
@@ -454,7 +453,6 @@ const struct proc_ns_operations pidns_operations = {
 const struct proc_ns_operations pidns_for_children_operations = {
 	.name		= "pid_for_children",
 	.real_ns_name	= "pid",
-	.type		= CLONE_NEWPID,
 	.get		= pidns_for_children_get,
 	.put		= pidns_put,
 	.install	= pidns_install,
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 9f26e61be044..530cf99c2212 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -462,7 +462,6 @@ int proc_timens_set_offset(struct file *file, struct task_struct *p,
 
 const struct proc_ns_operations timens_operations = {
 	.name		= "time",
-	.type		= CLONE_NEWTIME,
 	.get		= timens_get,
 	.put		= timens_put,
 	.install	= timens_install,
@@ -472,7 +471,6 @@ const struct proc_ns_operations timens_operations = {
 const struct proc_ns_operations timens_for_children_operations = {
 	.name		= "time_for_children",
 	.real_ns_name	= "time",
-	.type		= CLONE_NEWTIME,
 	.get		= timens_for_children_get,
 	.put		= timens_put,
 	.install	= timens_install,
@@ -480,6 +478,7 @@ const struct proc_ns_operations timens_for_children_operations = {
 };
 
 struct time_namespace init_time_ns = {
+	.ns.ns_type	= ns_common_type(&init_time_ns),
 	.ns.__ns_ref	= REFCOUNT_INIT(3),
 	.user_ns	= &init_user_ns,
 	.ns.inum	= ns_init_inum(&init_time_ns),
diff --git a/kernel/user.c b/kernel/user.c
index b2a53674d506..0163665914c9 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -65,6 +65,7 @@ struct user_namespace init_user_ns = {
 			.nr_extents = 1,
 		},
 	},
+	.ns.ns_type = ns_common_type(&init_user_ns),
 	.ns.__ns_ref = REFCOUNT_INIT(3),
 	.owner = GLOBAL_ROOT_UID,
 	.group = GLOBAL_ROOT_GID,
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index e1559e8a8a02..03cb63883d04 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1400,7 +1400,6 @@ static struct user_namespace *userns_owner(struct ns_common *ns)
 
 const struct proc_ns_operations userns_operations = {
 	.name		= "user",
-	.type		= CLONE_NEWUSER,
 	.get		= userns_get,
 	.put		= userns_put,
 	.install	= userns_install,
diff --git a/kernel/utsname.c b/kernel/utsname.c
index 00001592ad13..a8cdc84648ee 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -146,7 +146,6 @@ static struct user_namespace *utsns_owner(struct ns_common *ns)
 
 const struct proc_ns_operations utsns_operations = {
 	.name		= "uts",
-	.type		= CLONE_NEWUTS,
 	.get		= utsns_get,
 	.put		= utsns_put,
 	.install	= utsns_install,
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index bdea7d5fac56..dfe84bd35f98 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1543,7 +1543,6 @@ static struct user_namespace *netns_owner(struct ns_common *ns)
 
 const struct proc_ns_operations netns_operations = {
 	.name		= "net",
-	.type		= CLONE_NEWNET,
 	.get		= netns_get,
 	.put		= netns_put,
 	.install	= netns_install,

-- 
2.47.3


