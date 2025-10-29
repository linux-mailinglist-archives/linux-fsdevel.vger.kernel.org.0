Return-Path: <linux-fsdevel+bounces-66226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A00C1A384
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086E91B26754
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FE8350A27;
	Wed, 29 Oct 2025 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajawMwtQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8B0344022;
	Wed, 29 Oct 2025 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740505; cv=none; b=o8ig7FXfVHt+u3ghBCbcmzeoVGtcnl1UhvE/4iPn1EmT635e5DH5mGio6DlxJpWdKmYtUnyKGxvYDKSdH7/a30Igxli7BhgUALhy/A9hPvztuzi+eilSLacXukr4DfdeNvgCXlezJTYg9ZumzJ8E7gk1A7yEVtCGIz8VDUB0AFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740505; c=relaxed/simple;
	bh=gSgGIpCVPo6ljx2uG9Sli0vSC4D2sfzy0ATjD38IwRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J20KXZ2PS7VC8Cg/L8M+NmIHROAz0qJ5GNJIRHIeBvfWA2E807hD0MXTaHmHO+8aU7innmSpKD4hcCACuIfIq6WbPkcWxxWb3dtpWNLh539jmbo4RRjC5uGmIV9DFh3MtHKuig1Zp0oGZNdJ/lcf1GzCD6WsOauq7KbFO7LX93A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajawMwtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021CDC4CEFD;
	Wed, 29 Oct 2025 12:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740504;
	bh=gSgGIpCVPo6ljx2uG9Sli0vSC4D2sfzy0ATjD38IwRo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ajawMwtQkHSbh7ZMTwrx/5nDg5x/FGqqq7zkpC+2b1qQhju5Zpv8/pZmLUFpU4ABn
	 cOoyVBwkykwZg3v+om8M6yRDobvK76id0GwXizpFbuAreCgSQjCnql6eqdeWHJLQRd
	 wu5Y6okPhysYD5dCQJY4qoS5b7K0rEbZE7ha7hcsrUT/G7T0cKKnr1r9LqTTzSFC72
	 GQ0OhdBFltwHTwwacfKKxaiJ7KvKTl3qg0apMzjT5Tegw2wI4VugcfNWKL4yvHow4X
	 3wPkgKHBt9nFWh1iRIsH/YdUaPlidjSVkIGEx6SJpuw2/sXfnP9cUrW+gRXRPtUZOf
	 kHxrY4FA6UodA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:26 +0100
Subject: [PATCH v4 13/72] nstree: introduce a unified tree
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-13-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8507; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gSgGIpCVPo6ljx2uG9Sli0vSC4D2sfzy0ATjD38IwRo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfXE/1y8k9dERT/T2qfo1YUJ11gtSjVb71kt/r07Y
 MrEm0qtHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNRWs7IsPvwwW1mzFL+jhcU
 Nr5sbmD95OVyQIKv80bLHbHFkd010xgZFh9ZN6FKrPLpAcGpsjxCX+3rHgY1PNxS9barZgHH0ts
 KDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This will allow userspace to lookup and stat a namespace simply by its
identifier without having to know what type of namespace it is.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h |   4 ++
 kernel/nscommon.c         |   1 +
 kernel/nstree.c           | 114 ++++++++++++++++++++++++++++++++++++----------
 3 files changed, 95 insertions(+), 24 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index adc3542042af..88f27b678b4e 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -109,6 +109,10 @@ struct ns_common {
 	union {
 		struct {
 			u64 ns_id;
+			struct /* global namespace rbtree and list */ {
+				struct rb_node ns_unified_tree_node;
+				struct list_head ns_unified_list_node;
+			};
 			struct /* per type rbtree and list */ {
 				struct rb_node ns_tree_node;
 				struct list_head ns_list_node;
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index 1935f640f05a..98a237be64bc 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -61,6 +61,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 	ns->ns_id = 0;
 	ns->ns_type = ns_type;
 	RB_CLEAR_NODE(&ns->ns_tree_node);
+	RB_CLEAR_NODE(&ns->ns_unified_tree_node);
 	INIT_LIST_HEAD(&ns->ns_list_node);
 
 #ifdef CONFIG_DEBUG_VFS
diff --git a/kernel/nstree.c b/kernel/nstree.c
index a231cd2e9368..dbe4fb18f021 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -4,75 +4,86 @@
 #include <linux/proc_ns.h>
 #include <linux/vfsdebug.h>
 
+__cacheline_aligned_in_smp DEFINE_SEQLOCK(ns_tree_lock);
+static struct rb_root ns_unified_tree = RB_ROOT; /* protected by ns_tree_lock */
+
 /**
  * struct ns_tree - Namespace tree
  * @ns_tree: Rbtree of namespaces of a particular type
  * @ns_list: Sequentially walkable list of all namespaces of this type
- * @ns_tree_lock: Seqlock to protect the tree and list
  * @type: type of namespaces in this tree
  */
 struct ns_tree {
-       struct rb_root ns_tree;
-       struct list_head ns_list;
-       seqlock_t ns_tree_lock;
-       int type;
+	struct rb_root ns_tree;
+	struct list_head ns_list;
+#ifdef CONFIG_DEBUG_VFS
+	int type;
+#endif
 };
 
 struct ns_tree mnt_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(mnt_ns_tree.ns_list),
-	.ns_tree_lock = __SEQLOCK_UNLOCKED(mnt_ns_tree.ns_tree_lock),
+#ifdef CONFIG_DEBUG_VFS
 	.type = CLONE_NEWNS,
+#endif
 };
 
 struct ns_tree net_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(net_ns_tree.ns_list),
-	.ns_tree_lock = __SEQLOCK_UNLOCKED(net_ns_tree.ns_tree_lock),
+#ifdef CONFIG_DEBUG_VFS
 	.type = CLONE_NEWNET,
+#endif
 };
 EXPORT_SYMBOL_GPL(net_ns_tree);
 
 struct ns_tree uts_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(uts_ns_tree.ns_list),
-	.ns_tree_lock = __SEQLOCK_UNLOCKED(uts_ns_tree.ns_tree_lock),
+#ifdef CONFIG_DEBUG_VFS
 	.type = CLONE_NEWUTS,
+#endif
 };
 
 struct ns_tree user_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(user_ns_tree.ns_list),
-	.ns_tree_lock = __SEQLOCK_UNLOCKED(user_ns_tree.ns_tree_lock),
+#ifdef CONFIG_DEBUG_VFS
 	.type = CLONE_NEWUSER,
+#endif
 };
 
 struct ns_tree ipc_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(ipc_ns_tree.ns_list),
-	.ns_tree_lock = __SEQLOCK_UNLOCKED(ipc_ns_tree.ns_tree_lock),
+#ifdef CONFIG_DEBUG_VFS
 	.type = CLONE_NEWIPC,
+#endif
 };
 
 struct ns_tree pid_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(pid_ns_tree.ns_list),
-	.ns_tree_lock = __SEQLOCK_UNLOCKED(pid_ns_tree.ns_tree_lock),
+#ifdef CONFIG_DEBUG_VFS
 	.type = CLONE_NEWPID,
+#endif
 };
 
 struct ns_tree cgroup_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(cgroup_ns_tree.ns_list),
-	.ns_tree_lock = __SEQLOCK_UNLOCKED(cgroup_ns_tree.ns_tree_lock),
+#ifdef CONFIG_DEBUG_VFS
 	.type = CLONE_NEWCGROUP,
+#endif
 };
 
 struct ns_tree time_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(time_ns_tree.ns_list),
-	.ns_tree_lock = __SEQLOCK_UNLOCKED(time_ns_tree.ns_tree_lock),
+#ifdef CONFIG_DEBUG_VFS
 	.type = CLONE_NEWTIME,
+#endif
 };
 
 DEFINE_COOKIE(namespace_cookie);
@@ -84,6 +95,13 @@ static inline struct ns_common *node_to_ns(const struct rb_node *node)
 	return rb_entry(node, struct ns_common, ns_tree_node);
 }
 
+static inline struct ns_common *node_to_ns_unified(const struct rb_node *node)
+{
+	if (!node)
+		return NULL;
+	return rb_entry(node, struct ns_common, ns_unified_tree_node);
+}
+
 static inline int ns_cmp(struct rb_node *a, const struct rb_node *b)
 {
 	struct ns_common *ns_a = node_to_ns(a);
@@ -98,15 +116,27 @@ static inline int ns_cmp(struct rb_node *a, const struct rb_node *b)
 	return 0;
 }
 
+static inline int ns_cmp_unified(struct rb_node *a, const struct rb_node *b)
+{
+	struct ns_common *ns_a = node_to_ns_unified(a);
+	struct ns_common *ns_b = node_to_ns_unified(b);
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
 
 	VFS_WARN_ON_ONCE(!ns->ns_id);
 
-	write_seqlock(&ns_tree->ns_tree_lock);
-
-	VFS_WARN_ON_ONCE(ns->ns_type != ns_tree->type);
+	write_seqlock(&ns_tree_lock);
 
 	node = rb_find_add_rcu(&ns->ns_tree_node, &ns_tree->ns_tree, ns_cmp);
 	/*
@@ -119,7 +149,8 @@ void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
 	else
 		list_add_rcu(&ns->ns_list_node, &node_to_ns(prev)->ns_list_node);
 
-	write_sequnlock(&ns_tree->ns_tree_lock);
+	rb_find_add_rcu(&ns->ns_unified_tree_node, &ns_unified_tree, ns_cmp_unified);
+	write_sequnlock(&ns_tree_lock);
 
 	VFS_WARN_ON_ONCE(node);
 
@@ -138,11 +169,12 @@ void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree)
 	VFS_WARN_ON_ONCE(list_empty(&ns->ns_list_node));
 	VFS_WARN_ON_ONCE(ns->ns_type != ns_tree->type);
 
-	write_seqlock(&ns_tree->ns_tree_lock);
+	write_seqlock(&ns_tree_lock);
 	rb_erase(&ns->ns_tree_node, &ns_tree->ns_tree);
+	rb_erase(&ns->ns_unified_tree_node, &ns_unified_tree);
 	list_bidir_del_rcu(&ns->ns_list_node);
 	RB_CLEAR_NODE(&ns->ns_tree_node);
-	write_sequnlock(&ns_tree->ns_tree_lock);
+	write_sequnlock(&ns_tree_lock);
 }
 EXPORT_SYMBOL_GPL(__ns_tree_remove);
 
@@ -158,6 +190,17 @@ static int ns_find(const void *key, const struct rb_node *node)
 	return 0;
 }
 
+static int ns_find_unified(const void *key, const struct rb_node *node)
+{
+	const u64 ns_id = *(u64 *)key;
+	const struct ns_common *ns = node_to_ns_unified(node);
+
+	if (ns_id < ns->ns_id)
+		return -1;
+	if (ns_id > ns->ns_id)
+		return 1;
+	return 0;
+}
 
 static struct ns_tree *ns_tree_from_type(int ns_type)
 {
@@ -183,28 +226,51 @@ static struct ns_tree *ns_tree_from_type(int ns_type)
 	return NULL;
 }
 
-struct ns_common *ns_tree_lookup_rcu(u64 ns_id, int ns_type)
+static struct ns_common *__ns_unified_tree_lookup_rcu(u64 ns_id)
 {
-	struct ns_tree *ns_tree;
 	struct rb_node *node;
 	unsigned int seq;
 
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "suspicious ns_tree_lookup_rcu() usage");
+	do {
+		seq = read_seqbegin(&ns_tree_lock);
+		node = rb_find_rcu(&ns_id, &ns_unified_tree, ns_find_unified);
+		if (node)
+			break;
+	} while (read_seqretry(&ns_tree_lock, seq));
+
+	return node_to_ns_unified(node);
+}
+
+static struct ns_common *__ns_tree_lookup_rcu(u64 ns_id, int ns_type)
+{
+	struct ns_tree *ns_tree;
+	struct rb_node *node;
+	unsigned int seq;
 
 	ns_tree = ns_tree_from_type(ns_type);
 	if (!ns_tree)
 		return NULL;
 
 	do {
-		seq = read_seqbegin(&ns_tree->ns_tree_lock);
+		seq = read_seqbegin(&ns_tree_lock);
 		node = rb_find_rcu(&ns_id, &ns_tree->ns_tree, ns_find);
 		if (node)
 			break;
-	} while (read_seqretry(&ns_tree->ns_tree_lock, seq));
+	} while (read_seqretry(&ns_tree_lock, seq));
 
 	return node_to_ns(node);
 }
 
+struct ns_common *ns_tree_lookup_rcu(u64 ns_id, int ns_type)
+{
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "suspicious ns_tree_lookup_rcu() usage");
+
+	if (ns_type)
+		return __ns_tree_lookup_rcu(ns_id, ns_type);
+
+	return __ns_unified_tree_lookup_rcu(ns_id);
+}
+
 /**
  * ns_tree_adjoined_rcu - find the next/previous namespace in the same
  * tree

-- 
2.47.3


