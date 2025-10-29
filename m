Return-Path: <linux-fsdevel+bounces-66229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B5EC1A38A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F53150673C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93023355029;
	Wed, 29 Oct 2025 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ttvf/Azg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31511BCA1C;
	Wed, 29 Oct 2025 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740519; cv=none; b=YEL3n78TOTUZh9dWYddzTsqOng8jHNel0vjkdiH9c1JFkJcdNkknMb5BxPMDwR4S2hAOxgE5i7sp2/HVW+G+3cSn3PTtKccWWwd2YyvoLsgT8ivC4JaKm3TJwNr9yk+E2sjt+ZU5Htr2OmJX4KQ3PevcUjNSDnUEvgTFQkJTGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740519; c=relaxed/simple;
	bh=WRA0I35exugbAjGukfF0PjSWvMFh88nJ9OMdudItzfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UniFOr1UybIm4LhFC9r4C6OEobHOpfbugEocMikR7sSNFhlJHKcrQAiH6PVzOxudkO/B1auOx2XQW4Ua9p48F9O08+h7uHC6dQ2NOgXb3t609HbSAphGVFdrGTmCIKb5oet2PkPtYFuh9wRn/4bH8rj9r87VvHI27SvlFXmy3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ttvf/Azg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11142C116B1;
	Wed, 29 Oct 2025 12:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740519;
	bh=WRA0I35exugbAjGukfF0PjSWvMFh88nJ9OMdudItzfM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ttvf/AzgWa1pTssUTPxBQthbg6Jb3VaT4SZacRhF1TTUibtU+aFV6qghHGzysJ92/
	 lvDKxO8gqizhJx/Ni5TbICEi+DecXId31O0pSlBsdkp/75QYwGrtmmC6gohjMKIEc7
	 3Cd1+6DBN1ANHBW9GMHaaLGPgeyMvI03H6OLaeRJFeCAi2bnPZRZybV3eCVsi/Jod/
	 eCAflaVFEWv/e6dvWIscEFIPMiXGCX5quE9rdHEMiAaBwdIT0ICJdUOJcalKw0bDAl
	 IhDo8RoCsMDVhCut3fKxDeI9t+A1pDxeeTi9PHpEGwYeb+hQJq3Ab0C+9paTsiIUne
	 nfPji0e5kW4wg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:29 +0100
Subject: [PATCH v4 16/72] nstree: maintain list of owned namespaces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-16-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
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
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=10111; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WRA0I35exugbAjGukfF0PjSWvMFh88nJ9OMdudItzfM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfVseWEU258WZ6fPc64+i9V2l+XnpTPrl0lYSBuYd
 BTsqebvKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmAivFiPD/bfCRW/n2hU+/cbA
 rbnOQ3BlaNWW+DxNs50rXzVrT/nMxcjw2E45Y02dqGrC3QlPLwj+K9fUv/YkdZlSzv6qlJMbr71
 iBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The namespace tree doesn't express the ownership concept of namespace
appropriately. Maintain a list of directly owned namespaces per user
namespace. This will allow userspace and the kernel to use the listns()
system call to walk the namespace tree by owning user namespace. The
rbtree is used to find the relevant namespace entry point which allows
to continue iteration and the owner list can be used to walk the tree
completely lock free.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c            |  2 ++
 include/linux/ns_common.h |  6 +++++
 init/version-timestamp.c  |  2 ++
 ipc/msgutil.c             |  2 ++
 kernel/cgroup/cgroup.c    |  2 ++
 kernel/nscommon.c         |  4 +++
 kernel/nstree.c           | 68 ++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/pid.c              |  2 ++
 kernel/time/namespace.c   |  2 ++
 kernel/user.c             |  2 ++
 10 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 22b4ff6ba134..3e0361c4c138 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5995,6 +5995,8 @@ struct mnt_namespace init_mnt_ns = {
 	.mounts		= RB_ROOT,
 	.poll		= __WAIT_QUEUE_HEAD_INITIALIZER(init_mnt_ns.poll),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_mnt_ns.ns.ns_list_node),
+	.ns.ns_owner_entry = LIST_HEAD_INIT(init_mnt_ns.ns.ns_owner_entry),
+	.ns.ns_owner = LIST_HEAD_INIT(init_mnt_ns.ns.ns_owner),
 };
 
 static void __init init_mount_tree(void)
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 88f27b678b4e..e4041603434e 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -117,6 +117,12 @@ struct ns_common {
 				struct rb_node ns_tree_node;
 				struct list_head ns_list_node;
 			};
+			struct /* namespace ownership rbtree and list */ {
+				struct rb_root ns_owner_tree; /* rbtree of namespaces owned by this namespace */
+				struct list_head ns_owner; /* list of namespaces owned by this namespace */
+				struct rb_node ns_owner_tree_node; /* node in the owner namespace's rbtree */
+				struct list_head ns_owner_entry; /* node in the owner namespace's ns_owned list */
+			};
 			atomic_t __ns_ref_active; /* do not use directly */
 		};
 		struct rcu_head ns_rcu;
diff --git a/init/version-timestamp.c b/init/version-timestamp.c
index c38498f94646..e5c278dabecf 100644
--- a/init/version-timestamp.c
+++ b/init/version-timestamp.c
@@ -22,6 +22,8 @@ struct uts_namespace init_uts_ns = {
 	.user_ns = &init_user_ns,
 	.ns.inum = ns_init_inum(&init_uts_ns),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_uts_ns.ns.ns_list_node),
+	.ns.ns_owner_entry = LIST_HEAD_INIT(init_uts_ns.ns.ns_owner_entry),
+	.ns.ns_owner = LIST_HEAD_INIT(init_uts_ns.ns.ns_owner),
 #ifdef CONFIG_UTS_NS
 	.ns.ops = &utsns_operations,
 #endif
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index d7c66b430470..ce1de73725c0 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -32,6 +32,8 @@ struct ipc_namespace init_ipc_ns = {
 	.user_ns = &init_user_ns,
 	.ns.inum = ns_init_inum(&init_ipc_ns),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_ipc_ns.ns.ns_list_node),
+	.ns.ns_owner_entry = LIST_HEAD_INIT(init_ipc_ns.ns.ns_owner_entry),
+	.ns.ns_owner = LIST_HEAD_INIT(init_ipc_ns.ns.ns_owner),
 #ifdef CONFIG_IPC_NS
 	.ns.ops = &ipcns_operations,
 #endif
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 45e470011c77..9fa082e2eb1a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -258,6 +258,8 @@ struct cgroup_namespace init_cgroup_ns = {
 	.root_cset	= &init_css_set,
 	.ns.ns_type	= ns_common_type(&init_cgroup_ns),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_cgroup_ns.ns.ns_list_node),
+	.ns.ns_owner_entry = LIST_HEAD_INIT(init_cgroup_ns.ns.ns_owner_entry),
+	.ns.ns_owner = LIST_HEAD_INIT(init_cgroup_ns.ns.ns_owner),
 };
 
 static struct file_system_type cgroup2_fs_type;
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index 98a237be64bc..bd4cf8bb8a77 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -62,7 +62,11 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 	ns->ns_type = ns_type;
 	RB_CLEAR_NODE(&ns->ns_tree_node);
 	RB_CLEAR_NODE(&ns->ns_unified_tree_node);
+	RB_CLEAR_NODE(&ns->ns_owner_tree_node);
 	INIT_LIST_HEAD(&ns->ns_list_node);
+	ns->ns_owner_tree = RB_ROOT;
+	INIT_LIST_HEAD(&ns->ns_owner);
+	INIT_LIST_HEAD(&ns->ns_owner_entry);
 
 #ifdef CONFIG_DEBUG_VFS
 	ns_debug(ns, ops);
diff --git a/kernel/nstree.c b/kernel/nstree.c
index bd6b0a22fd8e..59ec7d6ba302 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -2,7 +2,9 @@
 
 #include <linux/nstree.h>
 #include <linux/proc_ns.h>
+#include <linux/rculist.h>
 #include <linux/vfsdebug.h>
+#include <linux/user_namespace.h>
 
 __cacheline_aligned_in_smp DEFINE_SEQLOCK(ns_tree_lock);
 static struct rb_root ns_unified_tree = RB_ROOT; /* protected by ns_tree_lock */
@@ -100,6 +102,13 @@ static inline struct ns_common *node_to_ns_unified(const struct rb_node *node)
 	return rb_entry(node, struct ns_common, ns_unified_tree_node);
 }
 
+static inline struct ns_common *node_to_ns_owner(const struct rb_node *node)
+{
+	if (!node)
+		return NULL;
+	return rb_entry(node, struct ns_common, ns_owner_tree_node);
+}
+
 static inline int ns_cmp(struct rb_node *a, const struct rb_node *b)
 {
 	struct ns_common *ns_a = node_to_ns(a);
@@ -128,11 +137,27 @@ static inline int ns_cmp_unified(struct rb_node *a, const struct rb_node *b)
 	return 0;
 }
 
+static inline int ns_cmp_owner(struct rb_node *a, const struct rb_node *b)
+{
+	struct ns_common *ns_a = node_to_ns_owner(a);
+	struct ns_common *ns_b = node_to_ns_owner(b);
+	u64 ns_id_a = ns_a->ns_id;
+	u64 ns_id_b = ns_b->ns_id;
+
+	if (ns_id_a < ns_id_b)
+		return -1;
+	if (ns_id_a > ns_id_b)
+		return 1;
+	return 0;
+}
+
 void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
 {
 	struct rb_node *node, *prev;
+	const struct proc_ns_operations *ops = ns->ops;
 
 	VFS_WARN_ON_ONCE(!ns->ns_id);
+	VFS_WARN_ON_ONCE(ns->ns_type != ns_tree->type);
 
 	write_seqlock(&ns_tree_lock);
 
@@ -148,6 +173,30 @@ void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
 		list_add_rcu(&ns->ns_list_node, &node_to_ns(prev)->ns_list_node);
 
 	rb_find_add_rcu(&ns->ns_unified_tree_node, &ns_unified_tree, ns_cmp_unified);
+
+	if (ops) {
+		struct user_namespace *user_ns;
+
+		VFS_WARN_ON_ONCE(!ops->owner);
+		user_ns = ops->owner(ns);
+		if (user_ns) {
+			struct ns_common *owner = &user_ns->ns;
+			VFS_WARN_ON_ONCE(owner->ns_type != CLONE_NEWUSER);
+
+			/* Insert into owner's rbtree */
+			rb_find_add_rcu(&ns->ns_owner_tree_node, &owner->ns_owner_tree, ns_cmp_owner);
+
+			/* Insert into owner's list in sorted order */
+			prev = rb_prev(&ns->ns_owner_tree_node);
+			if (!prev)
+				list_add_rcu(&ns->ns_owner_entry, &owner->ns_owner);
+			else
+				list_add_rcu(&ns->ns_owner_entry, &node_to_ns_owner(prev)->ns_owner_entry);
+		} else {
+			/* Only the initial user namespace doesn't have an owner. */
+			VFS_WARN_ON_ONCE(ns != to_ns_common(&init_user_ns));
+		}
+	}
 	write_sequnlock(&ns_tree_lock);
 
 	VFS_WARN_ON_ONCE(node);
@@ -163,6 +212,9 @@ void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
 
 void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree)
 {
+	const struct proc_ns_operations *ops = ns->ops;
+	struct user_namespace *user_ns;
+
 	VFS_WARN_ON_ONCE(RB_EMPTY_NODE(&ns->ns_tree_node));
 	VFS_WARN_ON_ONCE(list_empty(&ns->ns_list_node));
 	VFS_WARN_ON_ONCE(ns->ns_type != ns_tree->type);
@@ -170,8 +222,22 @@ void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree)
 	write_seqlock(&ns_tree_lock);
 	rb_erase(&ns->ns_tree_node, &ns_tree->ns_tree);
 	rb_erase(&ns->ns_unified_tree_node, &ns_unified_tree);
-	list_bidir_del_rcu(&ns->ns_list_node);
 	RB_CLEAR_NODE(&ns->ns_tree_node);
+
+	list_bidir_del_rcu(&ns->ns_list_node);
+
+	/* Remove from owner's rbtree if this namespace has an owner */
+	if (ops) {
+		user_ns = ops->owner(ns);
+		if (user_ns) {
+			struct ns_common *owner = &user_ns->ns;
+			rb_erase(&ns->ns_owner_tree_node, &owner->ns_owner_tree);
+			RB_CLEAR_NODE(&ns->ns_owner_tree_node);
+		}
+
+		list_bidir_del_rcu(&ns->ns_owner_entry);
+	}
+
 	write_sequnlock(&ns_tree_lock);
 }
 EXPORT_SYMBOL_GPL(__ns_tree_remove);
diff --git a/kernel/pid.c b/kernel/pid.c
index ec9051d387ee..8134c40b2584 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -80,6 +80,8 @@ struct pid_namespace init_pid_ns = {
 	.user_ns = &init_user_ns,
 	.ns.inum = ns_init_inum(&init_pid_ns),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_pid_ns.ns.ns_list_node),
+	.ns.ns_owner_entry = LIST_HEAD_INIT(init_pid_ns.ns.ns_owner_entry),
+	.ns.ns_owner = LIST_HEAD_INIT(init_pid_ns.ns.ns_owner),
 #ifdef CONFIG_PID_NS
 	.ns.ops = &pidns_operations,
 #endif
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 68b67c68670d..f543c4a83229 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -484,6 +484,8 @@ struct time_namespace init_time_ns = {
 	.user_ns	= &init_user_ns,
 	.ns.inum	= ns_init_inum(&init_time_ns),
 	.ns.ops		= &timens_operations,
+	.ns.ns_owner_entry = LIST_HEAD_INIT(init_time_ns.ns.ns_owner_entry),
+	.ns.ns_owner = LIST_HEAD_INIT(init_time_ns.ns.ns_owner),
 	.frozen_offsets	= true,
 	.ns.ns_list_node = LIST_HEAD_INIT(init_time_ns.ns.ns_list_node),
 };
diff --git a/kernel/user.c b/kernel/user.c
index bf60532856db..e392768ccd44 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -72,6 +72,8 @@ struct user_namespace init_user_ns = {
 	.group = GLOBAL_ROOT_GID,
 	.ns.inum = ns_init_inum(&init_user_ns),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_user_ns.ns.ns_list_node),
+	.ns.ns_owner_entry = LIST_HEAD_INIT(init_user_ns.ns.ns_owner_entry),
+	.ns.ns_owner = LIST_HEAD_INIT(init_user_ns.ns.ns_owner),
 #ifdef CONFIG_USER_NS
 	.ns.ops = &userns_operations,
 #endif

-- 
2.47.3


