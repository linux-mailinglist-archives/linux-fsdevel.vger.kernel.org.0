Return-Path: <linux-fsdevel+bounces-67702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A15C4770C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5B7D4EF5AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D900931B100;
	Mon, 10 Nov 2025 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdlqQhBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FE7315769;
	Mon, 10 Nov 2025 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787348; cv=none; b=CnFPzOrulmx+Cn2vwexpZkc1Fye4reA9fyvfGYc0y/Cp0TTBNEKNbjQhvTU9tH8wIiSZHPkYpgN+IbtJqAhkPm5HVJty7Pm9Qwr0vo64JsmimuwY4cuN2HsHFnAy1z+O7757NeDKwvHrD8tZ5rmHABnFvn4TnJTwBGaFj9257/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787348; c=relaxed/simple;
	bh=rkR9bUFxnRPUsosmOrW8f/PleAP2dOIzbCKPPcATwc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eVgVByEohEXKi+TAizPnNmGiGbYIJyGOXjHmdk0WJHXRiD3b32gkA242eAqlZV08Fa15CLCdBrsjD47351XEq+uvAWgb/8Auo++EKPN9B0BOs0L9ZP1j319CIoE6QYkxf723MudjqUmgToDZ4wLZw3R0gjdkCAIXmghZfQaliBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdlqQhBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC36CC116B1;
	Mon, 10 Nov 2025 15:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787347;
	bh=rkR9bUFxnRPUsosmOrW8f/PleAP2dOIzbCKPPcATwc0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rdlqQhBysbg1Vu4T/L3zwnL7iUpTMj5wFUzM0dgpALmwUFGC4Mlhi86auqSzv4mVG
	 myy/1mZCAFA/HMb1SJiAWDn9hpLGBGJoPTkD7DzWSB3SveI4nuZLR75o4Qtcs+i1wE
	 KFB9EhHaFFrGxONMM64yI/3rQ3g40icca8v05PWsD3NDcr8AST51lMX1DA73tH5leB
	 k4Saeyqq7k9dXnFAPfUUkIAUwTPDPpeRxniLfKKYi/cnDBOdLq8Uao6G9sq6cVzRXY
	 R6Wll52W5IDvc0Y71z4JiAnxc9l5NoT1a5z38nOWtIFWMPF7W3uNL6Ibsmkxj+0qKS
	 8UuwrphpNNpIQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:17 +0100
Subject: [PATCH 05/17] nstree: switch to new structures
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-5-e8a9264e0fb9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=23703; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rkR9bUFxnRPUsosmOrW8f/PleAP2dOIzbCKPPcATwc0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v98PLXvkfIelyOW1/Wl939aqsi1bMJ9dV62uEy2y
 H7uZVumd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExENJnhn277D83eR/xrlqd/
 PDy30/E5V7JR4NOpnwqnp1QUfS5P7mH4Z/FjRnmAindrlao8n89drXPztr4UES+RXu7RmjSZ+Ss
 /LwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Switch the nstree management to the new combined structures.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c                     |   2 +-
 include/linux/ns/ns_common_types.h |  27 ++---
 include/linux/ns/nstree_types.h    |  19 ++++
 include/linux/ns_common.h          |  27 +++--
 include/linux/nstree.h             |  26 ++---
 kernel/nscommon.c                  |  13 +--
 kernel/nstree.c                    | 199 ++++++++++++++-----------------------
 7 files changed, 136 insertions(+), 177 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index eded33eeb647..ad19530a13b2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -138,7 +138,7 @@ static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
 
 	if (!node)
 		return NULL;
-	ns = rb_entry(node, struct ns_common, ns_tree_node);
+	ns = rb_entry(node, struct ns_common, ns_tree_node.ns_node);
 	return container_of(ns, struct mnt_namespace, ns);
 }
 
diff --git a/include/linux/ns/ns_common_types.h b/include/linux/ns/ns_common_types.h
index ccd1d1e116f6..b332b019b29c 100644
--- a/include/linux/ns/ns_common_types.h
+++ b/include/linux/ns/ns_common_types.h
@@ -3,6 +3,7 @@
 #define _LINUX_NS_COMMON_TYPES_H
 
 #include <linux/atomic.h>
+#include <linux/ns/nstree_types.h>
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
@@ -98,6 +99,13 @@ extern const struct proc_ns_operations utsns_operations;
  * Initial namespaces:
  *   Boot-time namespaces (init_net, init_pid_ns, etc.) start with
  *   __ns_ref_active = 1 and remain active forever.
+ *
+ * @ns_type: type of namespace (e.g., CLONE_NEWNET)
+ * @stashed: cached dentry to be used by the vfs
+ * @ops: namespace operations
+ * @inum: namespace inode number (quickly recycled for non-initial namespaces)
+ * @__ns_ref: main reference count (do not use directly)
+ * @ns_tree: namespace tree nodes and active reference count
  */
 struct ns_common {
 	u32 ns_type;
@@ -106,24 +114,7 @@ struct ns_common {
 	unsigned int inum;
 	refcount_t __ns_ref; /* do not use directly */
 	union {
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
+		struct ns_tree;
 		struct rcu_head ns_rcu;
 	};
 };
diff --git a/include/linux/ns/nstree_types.h b/include/linux/ns/nstree_types.h
index 6ee0c39686f8..2fb28ee31efb 100644
--- a/include/linux/ns/nstree_types.h
+++ b/include/linux/ns/nstree_types.h
@@ -33,4 +33,23 @@ struct ns_tree_node {
 	struct list_head ns_list_entry;
 };
 
+/**
+ * struct ns_tree - Namespace tree nodes and active reference count
+ * @ns_id: Unique namespace identifier
+ * @__ns_ref_active: Active reference count (do not use directly)
+ * @ns_unified_node: Node in the global namespace tree
+ * @ns_tree_node: Node in the per-type namespace tree
+ * @ns_owner_node: Node in the owner namespace's tree of owned namespaces
+ * @ns_owner_root: Root of the tree of namespaces owned by this namespace
+ *                 (only used when this namespace is an owner)
+ */
+struct ns_tree {
+	u64 ns_id;
+	atomic_t __ns_ref_active;
+	struct ns_tree_node ns_unified_node;
+	struct ns_tree_node ns_tree_node;
+	struct ns_tree_node ns_owner_node;
+	struct ns_tree_root ns_owner_root;
+};
+
 #endif /* _LINUX_NSTREE_TYPES_H */
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 6a4ca8c3b9c4..f90509ee0900 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -26,20 +26,19 @@ static __always_inline bool is_ns_init_id(const struct ns_common *ns)
 	return ns->ns_id <= NS_LAST_INIT_ID;
 }
 
-
-#define NS_COMMON_INIT(nsname, refs)							\
-{											\
-	.ns_type		= ns_common_type(&nsname),				\
-	.ns_id			= ns_init_id(&nsname),					\
-	.inum			= ns_init_inum(&nsname),				\
-	.ops			= to_ns_operations(&nsname),				\
-	.stashed		= NULL,							\
-	.__ns_ref		= REFCOUNT_INIT(refs),					\
-	.__ns_ref_active	= ATOMIC_INIT(1),					\
-	.ns_list_node		= LIST_HEAD_INIT(nsname.ns.ns_list_node),		\
-	.ns_owner_entry		= LIST_HEAD_INIT(nsname.ns.ns_owner_entry),		\
-	.ns_owner		= LIST_HEAD_INIT(nsname.ns.ns_owner),			\
-	.ns_unified_list_node	= LIST_HEAD_INIT(nsname.ns.ns_unified_list_node),	\
+#define NS_COMMON_INIT(nsname, refs)									\
+{													\
+	.ns_type			= ns_common_type(&nsname),					\
+	.ns_id				= ns_init_id(&nsname),						\
+	.inum				= ns_init_inum(&nsname),					\
+	.ops				= to_ns_operations(&nsname),					\
+	.stashed			= NULL,								\
+	.__ns_ref			= REFCOUNT_INIT(refs),						\
+	.__ns_ref_active		= ATOMIC_INIT(1),						\
+	.ns_unified_node.ns_list_entry	= LIST_HEAD_INIT(nsname.ns.ns_unified_node.ns_list_entry),	\
+	.ns_tree_node.ns_list_entry	= LIST_HEAD_INIT(nsname.ns.ns_tree_node.ns_list_entry),		\
+	.ns_owner_node.ns_list_entry	= LIST_HEAD_INIT(nsname.ns.ns_owner_node.ns_list_entry),	\
+	.ns_owner_root.ns_list_head	= LIST_HEAD_INIT(nsname.ns.ns_owner_root.ns_list_head),		\
 }
 
 #define ns_common_init(__ns)                     \
diff --git a/include/linux/nstree.h b/include/linux/nstree.h
index 98b848cf2f1c..175e4625bfa6 100644
--- a/include/linux/nstree.h
+++ b/include/linux/nstree.h
@@ -13,14 +13,14 @@
 
 struct ns_common;
 
-extern struct ns_tree cgroup_ns_tree;
-extern struct ns_tree ipc_ns_tree;
-extern struct ns_tree mnt_ns_tree;
-extern struct ns_tree net_ns_tree;
-extern struct ns_tree pid_ns_tree;
-extern struct ns_tree time_ns_tree;
-extern struct ns_tree user_ns_tree;
-extern struct ns_tree uts_ns_tree;
+extern struct ns_tree_root cgroup_ns_tree;
+extern struct ns_tree_root ipc_ns_tree;
+extern struct ns_tree_root mnt_ns_tree;
+extern struct ns_tree_root net_ns_tree;
+extern struct ns_tree_root pid_ns_tree;
+extern struct ns_tree_root time_ns_tree;
+extern struct ns_tree_root user_ns_tree;
+extern struct ns_tree_root uts_ns_tree;
 
 void ns_tree_node_init(struct ns_tree_node *node);
 void ns_tree_root_init(struct ns_tree_root *root);
@@ -46,14 +46,14 @@ void ns_tree_node_del(struct ns_tree_node *node, struct ns_tree_root *root);
 			 (((__ns) == ns_init_ns(__ns)) ? ns_init_id(__ns) : 0))
 
 u64 __ns_tree_gen_id(struct ns_common *ns, u64 id);
-void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree);
-void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree);
+void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree_root *ns_tree);
+void __ns_tree_remove(struct ns_common *ns, struct ns_tree_root *ns_tree);
 struct ns_common *ns_tree_lookup_rcu(u64 ns_id, int ns_type);
 struct ns_common *__ns_tree_adjoined_rcu(struct ns_common *ns,
-					 struct ns_tree *ns_tree,
+					 struct ns_tree_root *ns_tree,
 					 bool previous);
 
-static inline void __ns_tree_add(struct ns_common *ns, struct ns_tree *ns_tree, u64 id)
+static inline void __ns_tree_add(struct ns_common *ns, struct ns_tree_root *ns_tree, u64 id)
 {
 	__ns_tree_gen_id(ns, id);
 	__ns_tree_add_raw(ns, ns_tree);
@@ -91,6 +91,6 @@ static inline void __ns_tree_add(struct ns_common *ns, struct ns_tree *ns_tree,
 #define ns_tree_adjoined_rcu(__ns, __previous) \
 	__ns_tree_adjoined_rcu(to_ns_common(__ns), to_ns_tree(__ns), __previous)
 
-#define ns_tree_active(__ns) (!RB_EMPTY_NODE(&to_ns_common(__ns)->ns_tree_node))
+#define ns_tree_active(__ns) (!RB_EMPTY_NODE(&to_ns_common(__ns)->ns_tree_node.ns_node))
 
 #endif /* _LINUX_NSTREE_H */
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index c910b979e433..88f70baccb75 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
 
 #include <linux/ns_common.h>
+#include <linux/nstree.h>
 #include <linux/proc_ns.h>
 #include <linux/user_namespace.h>
 #include <linux/vfsdebug.h>
@@ -61,14 +62,10 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 	ns->ops = ops;
 	ns->ns_id = 0;
 	ns->ns_type = ns_type;
-	RB_CLEAR_NODE(&ns->ns_tree_node);
-	RB_CLEAR_NODE(&ns->ns_unified_tree_node);
-	RB_CLEAR_NODE(&ns->ns_owner_tree_node);
-	INIT_LIST_HEAD(&ns->ns_list_node);
-	INIT_LIST_HEAD(&ns->ns_unified_list_node);
-	ns->ns_owner_tree = RB_ROOT;
-	INIT_LIST_HEAD(&ns->ns_owner);
-	INIT_LIST_HEAD(&ns->ns_owner_entry);
+	ns_tree_node_init(&ns->ns_tree_node);
+	ns_tree_node_init(&ns->ns_unified_node);
+	ns_tree_node_init(&ns->ns_owner_node);
+	ns_tree_root_init(&ns->ns_owner_root);
 
 #ifdef CONFIG_DEBUG_VFS
 	ns_debug(ns, ops);
diff --git a/kernel/nstree.c b/kernel/nstree.c
index fe71ff943f70..6c7ec9fbf25f 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -9,68 +9,51 @@
 #include <linux/user_namespace.h>
 
 static __cacheline_aligned_in_smp DEFINE_SEQLOCK(ns_tree_lock);
-static struct rb_root ns_unified_tree = RB_ROOT; /* protected by ns_tree_lock */
-static LIST_HEAD(ns_unified_list); /* protected by ns_tree_lock */
 
-/**
- * struct ns_tree - Namespace tree
- * @ns_tree: Rbtree of namespaces of a particular type
- * @ns_list: Sequentially walkable list of all namespaces of this type
- * @type: type of namespaces in this tree
- */
-struct ns_tree {
-	struct rb_root ns_tree;
-	struct list_head ns_list;
-	int type;
+static struct ns_tree_root ns_unified_root = { /* protected by ns_tree_lock */
+	.ns_rb = RB_ROOT,
+	.ns_list_head = LIST_HEAD_INIT(ns_unified_root.ns_list_head),
 };
 
-struct ns_tree mnt_ns_tree = {
-	.ns_tree = RB_ROOT,
-	.ns_list = LIST_HEAD_INIT(mnt_ns_tree.ns_list),
-	.type = CLONE_NEWNS,
+struct ns_tree_root mnt_ns_tree = {
+	.ns_rb = RB_ROOT,
+	.ns_list_head = LIST_HEAD_INIT(mnt_ns_tree.ns_list_head),
 };
 
-struct ns_tree net_ns_tree = {
-	.ns_tree = RB_ROOT,
-	.ns_list = LIST_HEAD_INIT(net_ns_tree.ns_list),
-	.type = CLONE_NEWNET,
+struct ns_tree_root net_ns_tree = {
+	.ns_rb = RB_ROOT,
+	.ns_list_head = LIST_HEAD_INIT(net_ns_tree.ns_list_head),
 };
 EXPORT_SYMBOL_GPL(net_ns_tree);
 
-struct ns_tree uts_ns_tree = {
-	.ns_tree = RB_ROOT,
-	.ns_list = LIST_HEAD_INIT(uts_ns_tree.ns_list),
-	.type = CLONE_NEWUTS,
+struct ns_tree_root uts_ns_tree = {
+	.ns_rb = RB_ROOT,
+	.ns_list_head = LIST_HEAD_INIT(uts_ns_tree.ns_list_head),
 };
 
-struct ns_tree user_ns_tree = {
-	.ns_tree = RB_ROOT,
-	.ns_list = LIST_HEAD_INIT(user_ns_tree.ns_list),
-	.type = CLONE_NEWUSER,
+struct ns_tree_root user_ns_tree = {
+	.ns_rb = RB_ROOT,
+	.ns_list_head = LIST_HEAD_INIT(user_ns_tree.ns_list_head),
 };
 
-struct ns_tree ipc_ns_tree = {
-	.ns_tree = RB_ROOT,
-	.ns_list = LIST_HEAD_INIT(ipc_ns_tree.ns_list),
-	.type = CLONE_NEWIPC,
+struct ns_tree_root ipc_ns_tree = {
+	.ns_rb = RB_ROOT,
+	.ns_list_head = LIST_HEAD_INIT(ipc_ns_tree.ns_list_head),
 };
 
-struct ns_tree pid_ns_tree = {
-	.ns_tree = RB_ROOT,
-	.ns_list = LIST_HEAD_INIT(pid_ns_tree.ns_list),
-	.type = CLONE_NEWPID,
+struct ns_tree_root pid_ns_tree = {
+	.ns_rb = RB_ROOT,
+	.ns_list_head = LIST_HEAD_INIT(pid_ns_tree.ns_list_head),
 };
 
-struct ns_tree cgroup_ns_tree = {
-	.ns_tree = RB_ROOT,
-	.ns_list = LIST_HEAD_INIT(cgroup_ns_tree.ns_list),
-	.type = CLONE_NEWCGROUP,
+struct ns_tree_root cgroup_ns_tree = {
+	.ns_rb = RB_ROOT,
+	.ns_list_head = LIST_HEAD_INIT(cgroup_ns_tree.ns_list_head),
 };
 
-struct ns_tree time_ns_tree = {
-	.ns_tree = RB_ROOT,
-	.ns_list = LIST_HEAD_INIT(time_ns_tree.ns_list),
-	.type = CLONE_NEWTIME,
+struct ns_tree_root time_ns_tree = {
+	.ns_rb = RB_ROOT,
+	.ns_list_head = LIST_HEAD_INIT(time_ns_tree.ns_list_head),
 };
 
 /**
@@ -162,21 +145,21 @@ static inline struct ns_common *node_to_ns(const struct rb_node *node)
 {
 	if (!node)
 		return NULL;
-	return rb_entry(node, struct ns_common, ns_tree_node);
+	return rb_entry(node, struct ns_common, ns_tree_node.ns_node);
 }
 
 static inline struct ns_common *node_to_ns_unified(const struct rb_node *node)
 {
 	if (!node)
 		return NULL;
-	return rb_entry(node, struct ns_common, ns_unified_tree_node);
+	return rb_entry(node, struct ns_common, ns_unified_node.ns_node);
 }
 
 static inline struct ns_common *node_to_ns_owner(const struct rb_node *node)
 {
 	if (!node)
 		return NULL;
-	return rb_entry(node, struct ns_common, ns_owner_tree_node);
+	return rb_entry(node, struct ns_common, ns_owner_node.ns_node);
 }
 
 static int ns_id_cmp(u64 id_a, u64 id_b)
@@ -203,35 +186,22 @@ static int ns_cmp_owner(struct rb_node *a, const struct rb_node *b)
 	return ns_id_cmp(node_to_ns_owner(a)->ns_id, node_to_ns_owner(b)->ns_id);
 }
 
-void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
+void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree_root *ns_tree)
 {
-	struct rb_node *node, *prev;
+	struct rb_node *node;
 	const struct proc_ns_operations *ops = ns->ops;
 
 	VFS_WARN_ON_ONCE(!ns->ns_id);
-	VFS_WARN_ON_ONCE(ns->ns_type != ns_tree->type);
 
 	write_seqlock(&ns_tree_lock);
 
-	node = rb_find_add_rcu(&ns->ns_tree_node, &ns_tree->ns_tree, ns_cmp);
-	/*
-	 * If there's no previous entry simply add it after the
-	 * head and if there is add it after the previous entry.
-	 */
-	prev = rb_prev(&ns->ns_tree_node);
-	if (!prev)
-		list_add_rcu(&ns->ns_list_node, &ns_tree->ns_list);
-	else
-		list_add_rcu(&ns->ns_list_node, &node_to_ns(prev)->ns_list_node);
+	/* Add to per-type tree and list */
+	node = ns_tree_node_add(&ns->ns_tree_node, ns_tree, ns_cmp);
 
 	/* Add to unified tree and list */
-	rb_find_add_rcu(&ns->ns_unified_tree_node, &ns_unified_tree, ns_cmp_unified);
-	prev = rb_prev(&ns->ns_unified_tree_node);
-	if (!prev)
-		list_add_rcu(&ns->ns_unified_list_node, &ns_unified_list);
-	else
-		list_add_rcu(&ns->ns_unified_list_node, &node_to_ns_unified(prev)->ns_unified_list_node);
+	ns_tree_node_add(&ns->ns_unified_node, &ns_unified_root, ns_cmp_unified);
 
+	/* Add to owner's tree if applicable */
 	if (ops) {
 		struct user_namespace *user_ns;
 
@@ -241,15 +211,8 @@ void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
 			struct ns_common *owner = &user_ns->ns;
 			VFS_WARN_ON_ONCE(owner->ns_type != CLONE_NEWUSER);
 
-			/* Insert into owner's rbtree */
-			rb_find_add_rcu(&ns->ns_owner_tree_node, &owner->ns_owner_tree, ns_cmp_owner);
-
-			/* Insert into owner's list in sorted order */
-			prev = rb_prev(&ns->ns_owner_tree_node);
-			if (!prev)
-				list_add_rcu(&ns->ns_owner_entry, &owner->ns_owner);
-			else
-				list_add_rcu(&ns->ns_owner_entry, &node_to_ns_owner(prev)->ns_owner_entry);
+			/* Insert into owner's tree and list */
+			ns_tree_node_add(&ns->ns_owner_node, &owner->ns_owner_root, ns_cmp_owner);
 		} else {
 			/* Only the initial user namespace doesn't have an owner. */
 			VFS_WARN_ON_ONCE(ns != to_ns_common(&init_user_ns));
@@ -260,36 +223,29 @@ void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
 	VFS_WARN_ON_ONCE(node);
 }
 
-void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree)
+void __ns_tree_remove(struct ns_common *ns, struct ns_tree_root *ns_tree)
 {
 	const struct proc_ns_operations *ops = ns->ops;
 	struct user_namespace *user_ns;
 
-	VFS_WARN_ON_ONCE(RB_EMPTY_NODE(&ns->ns_tree_node));
-	VFS_WARN_ON_ONCE(list_empty(&ns->ns_list_node));
-	VFS_WARN_ON_ONCE(ns->ns_type != ns_tree->type);
+	VFS_WARN_ON_ONCE(ns_tree_node_empty(&ns->ns_tree_node));
+	VFS_WARN_ON_ONCE(list_empty(&ns->ns_tree_node.ns_list_entry));
 
 	write_seqlock(&ns_tree_lock);
-	rb_erase(&ns->ns_tree_node, &ns_tree->ns_tree);
-	RB_CLEAR_NODE(&ns->ns_tree_node);
-
-	list_bidir_del_rcu(&ns->ns_list_node);
 
-	rb_erase(&ns->ns_unified_tree_node, &ns_unified_tree);
-	RB_CLEAR_NODE(&ns->ns_unified_tree_node);
+	/* Remove from per-type tree and list */
+	ns_tree_node_del(&ns->ns_tree_node, ns_tree);
 
-	list_bidir_del_rcu(&ns->ns_unified_list_node);
+	/* Remove from unified tree and list */
+	ns_tree_node_del(&ns->ns_unified_node, &ns_unified_root);
 
-	/* Remove from owner's rbtree if this namespace has an owner */
+	/* Remove from owner's tree if applicable */
 	if (ops) {
 		user_ns = ops->owner(ns);
 		if (user_ns) {
 			struct ns_common *owner = &user_ns->ns;
-			rb_erase(&ns->ns_owner_tree_node, &owner->ns_owner_tree);
-			RB_CLEAR_NODE(&ns->ns_owner_tree_node);
+			ns_tree_node_del(&ns->ns_owner_node, &owner->ns_owner_root);
 		}
-
-		list_bidir_del_rcu(&ns->ns_owner_entry);
 	}
 
 	write_sequnlock(&ns_tree_lock);
@@ -320,7 +276,7 @@ static int ns_find_unified(const void *key, const struct rb_node *node)
 	return 0;
 }
 
-static struct ns_tree *ns_tree_from_type(int ns_type)
+static struct ns_tree_root *ns_tree_from_type(int ns_type)
 {
 	switch (ns_type) {
 	case CLONE_NEWCGROUP:
@@ -351,7 +307,7 @@ static struct ns_common *__ns_unified_tree_lookup_rcu(u64 ns_id)
 
 	do {
 		seq = read_seqbegin(&ns_tree_lock);
-		node = rb_find_rcu(&ns_id, &ns_unified_tree, ns_find_unified);
+		node = rb_find_rcu(&ns_id, &ns_unified_root.ns_rb, ns_find_unified);
 		if (node)
 			break;
 	} while (read_seqretry(&ns_tree_lock, seq));
@@ -361,7 +317,7 @@ static struct ns_common *__ns_unified_tree_lookup_rcu(u64 ns_id)
 
 static struct ns_common *__ns_tree_lookup_rcu(u64 ns_id, int ns_type)
 {
-	struct ns_tree *ns_tree;
+	struct ns_tree_root *ns_tree;
 	struct rb_node *node;
 	unsigned int seq;
 
@@ -371,7 +327,7 @@ static struct ns_common *__ns_tree_lookup_rcu(u64 ns_id, int ns_type)
 
 	do {
 		seq = read_seqbegin(&ns_tree_lock);
-		node = rb_find_rcu(&ns_id, &ns_tree->ns_tree, ns_find);
+		node = rb_find_rcu(&ns_id, &ns_tree->ns_rb, ns_find);
 		if (node)
 			break;
 	} while (read_seqretry(&ns_tree_lock, seq));
@@ -399,22 +355,20 @@ struct ns_common *ns_tree_lookup_rcu(u64 ns_id, int ns_type)
  * there is no next/previous namespace, -ENOENT is returned.
  */
 struct ns_common *__ns_tree_adjoined_rcu(struct ns_common *ns,
-					 struct ns_tree *ns_tree, bool previous)
+					 struct ns_tree_root *ns_tree, bool previous)
 {
 	struct list_head *list;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "suspicious ns_tree_adjoined_rcu() usage");
 
 	if (previous)
-		list = rcu_dereference(list_bidir_prev_rcu(&ns->ns_list_node));
+		list = rcu_dereference(list_bidir_prev_rcu(&ns->ns_tree_node.ns_list_entry));
 	else
-		list = rcu_dereference(list_next_rcu(&ns->ns_list_node));
-	if (list_is_head(list, &ns_tree->ns_list))
+		list = rcu_dereference(list_next_rcu(&ns->ns_tree_node.ns_list_entry));
+	if (list_is_head(list, &ns_tree->ns_list_head))
 		return ERR_PTR(-ENOENT);
 
-	VFS_WARN_ON_ONCE(list_entry_rcu(list, struct ns_common, ns_list_node)->ns_type != ns_tree->type);
-
-	return list_entry_rcu(list, struct ns_common, ns_list_node);
+	return list_entry_rcu(list, struct ns_common, ns_tree_node.ns_list_entry);
 }
 
 /**
@@ -508,7 +462,7 @@ static struct ns_common *lookup_ns_owner_at(u64 ns_id, struct ns_common *owner)
 	VFS_WARN_ON_ONCE(owner->ns_type != CLONE_NEWUSER);
 
 	read_seqlock_excl(&ns_tree_lock);
-	node = owner->ns_owner_tree.rb_node;
+	node = owner->ns_owner_root.ns_rb.rb_node;
 
 	while (node) {
 		struct ns_common *ns;
@@ -638,16 +592,15 @@ static ssize_t do_listns_userns(struct klistns *kls)
 	}
 
 	ret = 0;
-	head = &to_ns_common(kls->user_ns)->ns_owner;
+	head = &to_ns_common(kls->user_ns)->ns_owner_root.ns_list_head;
 	kls->userns_capable = ns_capable_noaudit(kls->user_ns, CAP_SYS_ADMIN);
 
 	rcu_read_lock();
 
 	if (!first_ns)
-		first_ns = list_entry_rcu(head->next, typeof(*ns), ns_owner_entry);
-
-	for (ns = first_ns; &ns->ns_owner_entry != head && nr_ns_ids;
-	     ns = list_entry_rcu(ns->ns_owner_entry.next, typeof(*ns), ns_owner_entry)) {
+		first_ns = list_entry_rcu(head->next, typeof(*ns), ns_owner_node.ns_list_entry);
+	for (ns = first_ns; &ns->ns_owner_node.ns_list_entry != head && nr_ns_ids;
+	     ns = list_entry_rcu(ns->ns_owner_node.ns_list_entry.next, typeof(*ns), ns_owner_node.ns_list_entry)) {
 		struct ns_common *valid;
 
 		valid = legitimize_ns(kls, ns);
@@ -682,7 +635,7 @@ static ssize_t do_listns_userns(struct klistns *kls)
 static struct ns_common *lookup_ns_id_at(u64 ns_id, int ns_type)
 {
 	struct ns_common *ret = NULL;
-	struct ns_tree *ns_tree = NULL;
+	struct ns_tree_root *ns_tree = NULL;
 	struct rb_node *node;
 
 	if (ns_type) {
@@ -693,9 +646,9 @@ static struct ns_common *lookup_ns_id_at(u64 ns_id, int ns_type)
 
 	read_seqlock_excl(&ns_tree_lock);
 	if (ns_tree)
-		node = ns_tree->ns_tree.rb_node;
+		node = ns_tree->ns_rb.rb_node;
 	else
-		node = ns_unified_tree.rb_node;
+		node = ns_unified_root.ns_rb.rb_node;
 
 	while (node) {
 		struct ns_common *ns;
@@ -725,28 +678,28 @@ static struct ns_common *lookup_ns_id_at(u64 ns_id, int ns_type)
 }
 
 static inline struct ns_common *first_ns_common(const struct list_head *head,
-						struct ns_tree *ns_tree)
+						struct ns_tree_root *ns_tree)
 {
 	if (ns_tree)
-		return list_entry_rcu(head->next, struct ns_common, ns_list_node);
-	return list_entry_rcu(head->next, struct ns_common, ns_unified_list_node);
+		return list_entry_rcu(head->next, struct ns_common, ns_tree_node.ns_list_entry);
+	return list_entry_rcu(head->next, struct ns_common, ns_unified_node.ns_list_entry);
 }
 
 static inline struct ns_common *next_ns_common(struct ns_common *ns,
-					       struct ns_tree *ns_tree)
+					       struct ns_tree_root *ns_tree)
 {
 	if (ns_tree)
-		return list_entry_rcu(ns->ns_list_node.next, struct ns_common, ns_list_node);
-	return list_entry_rcu(ns->ns_unified_list_node.next, struct ns_common, ns_unified_list_node);
+		return list_entry_rcu(ns->ns_tree_node.ns_list_entry.next, struct ns_common, ns_tree_node.ns_list_entry);
+	return list_entry_rcu(ns->ns_unified_node.ns_list_entry.next, struct ns_common, ns_unified_node.ns_list_entry);
 }
 
 static inline bool ns_common_is_head(struct ns_common *ns,
 				     const struct list_head *head,
-				     struct ns_tree *ns_tree)
+				     struct ns_tree_root *ns_tree)
 {
 	if (ns_tree)
-		return &ns->ns_list_node == head;
-	return &ns->ns_unified_list_node == head;
+		return &ns->ns_tree_node.ns_list_entry == head;
+	return &ns->ns_unified_node.ns_list_entry == head;
 }
 
 static ssize_t do_listns(struct klistns *kls)
@@ -754,7 +707,7 @@ static ssize_t do_listns(struct klistns *kls)
 	u64 __user *ns_ids = kls->uns_ids;
 	size_t nr_ns_ids = kls->nr_ns_ids;
 	struct ns_common *ns, *first_ns = NULL, *prev = NULL;
-	struct ns_tree *ns_tree = NULL;
+	struct ns_tree_root *ns_tree = NULL;
 	const struct list_head *head;
 	u32 ns_type;
 	ssize_t ret;
@@ -779,9 +732,9 @@ static ssize_t do_listns(struct klistns *kls)
 
 	ret = 0;
 	if (ns_tree)
-		head = &ns_tree->ns_list;
+		head = &ns_tree->ns_list_head;
 	else
-		head = &ns_unified_list;
+		head = &ns_unified_root.ns_list_head;
 
 	rcu_read_lock();
 

-- 
2.47.3


