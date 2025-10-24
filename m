Return-Path: <linux-fsdevel+bounces-65453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36345C05BDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12DB14FBBAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2091C31B124;
	Fri, 24 Oct 2025 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhPIpmO2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC5C313287;
	Fri, 24 Oct 2025 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303247; cv=none; b=ueI6Uo/oDHpEJthYBUKsv9mR2wZRm60n7XNgNwxPDM7RNxHYOFV7uDeizGUqI08TOLATSHCnwHdG0NlqOliidjeTCxi1t1/XvJ7pnW408RdfXR761yWgcaaFlOW7dX3eHG6t7Cg4HCSzrgrPiZSsAtkVH2N0pujWbcVFekKGaVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303247; c=relaxed/simple;
	bh=I9Gr6zapSqyfvp5VjlbXhfKK8aPWlTON9tgSCFZUh0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uJrRw+JdKj9GvSxcxMo2jGzFJ+5xKk3DSSsFhPsSQi6n5N5B++hfA8804XvKv0aot5FRku2X5EaP+ybK7G86KgFxP/4Z9yqi1UeQFWTZIjOO2nlGM0t8DNRFLaxDkK+101nhyOE7k9qJZKgVyWiE8sBw5+l7xbElXp3Aq5QpqhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhPIpmO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C501DC4CEFF;
	Fri, 24 Oct 2025 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303247;
	bh=I9Gr6zapSqyfvp5VjlbXhfKK8aPWlTON9tgSCFZUh0w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DhPIpmO2v9pkzDZ9lSp9pTjzXFrYTMiLUmwnR3dAsHS7ND6sLWL6KiaYBPQDPoyR/
	 hjVCEtWYXuUYZITY3hPRl0lI8zhgHUPRn1iFGgpFiAgVwNCq6HhyMZ0IA4H9JHwI5r
	 HT253FTtnTEUesvYNz90cijTHQASXi2EBPd75DnsHDTFOhktu48jVb9iDZm4VZW72k
	 hwzgpzIvELflKeoil/SpKCwubi2Y5wL3Mx28zoKg/ccJfm+xc/4wRO7Z/RtEVHulzJ
	 oMH8SLWSwFsq7GDuTURKpHdkx+f/uU9n77yLgO8c2YEHPgUFTzj8RriUN6gpANs1bp
	 L59NMFWOau3jA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:52:42 +0200
Subject: [PATCH v3 13/70] nstree: introduce a unified tree
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-13-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8126; i=brauner@kernel.org;
 h=from:subject:message-id; bh=I9Gr6zapSqyfvp5VjlbXhfKK8aPWlTON9tgSCFZUh0w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmo5c5w7fNfHN5MvvSrK/K9Q/fN4YN3MxRu6o8QNb
 NjChYq+dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkYQfD/4zNckcqZi5rbpie
 un1Wz9pSMe0M66rlCyMNfSZ9/niNq4OR4SLP1qrnBy9tOnS/bPKBJJunhmcDPWfLNrw/W9CZt2b
 ScW4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This will allow userspace to lookup and stat a namespace simply by its
identifier without having to know what type of namespace it is.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h |  4 ++
 kernel/nscommon.c         |  1 +
 kernel/nstree.c           | 94 ++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 77 insertions(+), 22 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index f340a279acc2..b7d2123a9d19 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -115,6 +115,10 @@ struct ns_common {
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
index d750e554d50b..bdd32e14a587 100644
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
index 369fd1675c6a..d21df06b6747 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -4,31 +4,30 @@
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
+	int type;
 };
 
 struct ns_tree mnt_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(mnt_ns_tree.ns_list),
-	.ns_tree_lock = __SEQLOCK_UNLOCKED(mnt_ns_tree.ns_tree_lock),
 	.type = CLONE_NEWNS,
 };
 
 struct ns_tree net_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(net_ns_tree.ns_list),
-	.ns_tree_lock = __SEQLOCK_UNLOCKED(net_ns_tree.ns_tree_lock),
 	.type = CLONE_NEWNET,
 };
 EXPORT_SYMBOL_GPL(net_ns_tree);
@@ -36,42 +35,36 @@ EXPORT_SYMBOL_GPL(net_ns_tree);
 struct ns_tree uts_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(uts_ns_tree.ns_list),
-	.ns_tree_lock = __SEQLOCK_UNLOCKED(uts_ns_tree.ns_tree_lock),
 	.type = CLONE_NEWUTS,
 };
 
 struct ns_tree user_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(user_ns_tree.ns_list),
-	.ns_tree_lock = __SEQLOCK_UNLOCKED(user_ns_tree.ns_tree_lock),
 	.type = CLONE_NEWUSER,
 };
 
 struct ns_tree ipc_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(ipc_ns_tree.ns_list),
-	.ns_tree_lock = __SEQLOCK_UNLOCKED(ipc_ns_tree.ns_tree_lock),
 	.type = CLONE_NEWIPC,
 };
 
 struct ns_tree pid_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(pid_ns_tree.ns_list),
-	.ns_tree_lock = __SEQLOCK_UNLOCKED(pid_ns_tree.ns_tree_lock),
 	.type = CLONE_NEWPID,
 };
 
 struct ns_tree cgroup_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(cgroup_ns_tree.ns_list),
-	.ns_tree_lock = __SEQLOCK_UNLOCKED(cgroup_ns_tree.ns_tree_lock),
 	.type = CLONE_NEWCGROUP,
 };
 
 struct ns_tree time_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(time_ns_tree.ns_list),
-	.ns_tree_lock = __SEQLOCK_UNLOCKED(time_ns_tree.ns_tree_lock),
 	.type = CLONE_NEWTIME,
 };
 
@@ -84,6 +77,13 @@ static inline struct ns_common *node_to_ns(const struct rb_node *node)
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
@@ -98,13 +98,27 @@ static inline int ns_cmp(struct rb_node *a, const struct rb_node *b)
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
+	write_seqlock(&ns_tree_lock);
 
 	VFS_WARN_ON_ONCE(ns->ns_type != ns_tree->type);
 
@@ -119,7 +133,8 @@ void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
 	else
 		list_add_rcu(&ns->ns_list_node, &node_to_ns(prev)->ns_list_node);
 
-	write_sequnlock(&ns_tree->ns_tree_lock);
+	rb_find_add_rcu(&ns->ns_unified_tree_node, &ns_unified_tree, ns_cmp_unified);
+	write_sequnlock(&ns_tree_lock);
 
 	VFS_WARN_ON_ONCE(node);
 }
@@ -130,11 +145,12 @@ void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree)
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
 
@@ -150,6 +166,17 @@ static int ns_find(const void *key, const struct rb_node *node)
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
@@ -175,28 +202,51 @@ static struct ns_tree *ns_tree_from_type(int ns_type)
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


