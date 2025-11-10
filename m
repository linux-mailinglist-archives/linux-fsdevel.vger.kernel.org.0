Return-Path: <linux-fsdevel+bounces-67701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB99C476FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13F614EF16A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F45931A55F;
	Mon, 10 Nov 2025 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaySCa/X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A25731578B;
	Mon, 10 Nov 2025 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787342; cv=none; b=h2Urn9EZugWC4fBK7ompCVPWM1LRSiPq+yCV+PfeDE85UV5aAT4LtGGbeJE6fEHFzD7NEO4wy/T24bKtWAGrU6WkLNTZuWC65ZlTh9lOZsgntzFyiz3Ty9qmXhIq6NUB7TIjRT0PQjY6dTsa5emiyr8olPKlOMOn/nzLm6xQFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787342; c=relaxed/simple;
	bh=Mq/lh2EGcnwHUzOwsrRrFIt6PvPUazOB7TqAka8OiVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3BdOC49NSy7S3pjnOXsnXc/QSa2P6zbx4ZrQoJLU5+JVVGzv+jJH1OHi9i02qEjXN2n0FXOuZ3KiuOeT3b0JCPHuJJh+UR/RpvObH+5F5061kgdhkwObMRdzOqJPQ9uu3gKrz8QQpuRh4NiHYUquv7xMBMyww1C8kBQ2e0DuUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaySCa/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85EBC116D0;
	Mon, 10 Nov 2025 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787342;
	bh=Mq/lh2EGcnwHUzOwsrRrFIt6PvPUazOB7TqAka8OiVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MaySCa/XoKSzZOMD9I/42BwI5tx84fsPMZhIerTcEOahstePDxAbdge8sbeBSKCR2
	 gMfjPIPkHPMoi9Mkd1bkYKbTuv9UyoIOWNlz1c4jM+x6nvGKngwya8G4ltxxX0sI5W
	 s6s2VNQgqA9qLeP9vaQDFKSItvmMYxjVlEZj44g0J1+n3vQfNILrw399a5JCfk727P
	 N9ibmFla7A3ZNEdr0laOReXQcJApQ6SY6PnnMi7hX8sVKuT6nK5qjbvBO/J4fUKd3U
	 FZew1TLzZAFzeTGozcC54zeONyRHbWyOu0AdupBDvTk9PtigEVQVA535PSadmcr7Q6
	 P2B0ZAvxzDtLQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:16 +0100
Subject: [PATCH 04/17] nstree: add helper to operate on struct
 ns_tree_{node,root}
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-4-e8a9264e0fb9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3940; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Mq/lh2EGcnwHUzOwsrRrFIt6PvPUazOB7TqAka8OiVk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v884bTcEeG1Zh25m82P1uWLy36oqWJSz5V99L3Hr
 aPHq2d/RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETW9jEynMz5tJZb01/YLtr3
 FN+yC1/ap3xlUBdfsmS2yr09/q1aZQz/E96f23VedfXG9ObFr1545b5LvPOaqWfNm1mL+ub5Pkh
 sZwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add helpers that work on the combined rbtree and rculist combined.
This will make the code a lot more managable and legible.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/nstree.h |  8 +++++
 kernel/nstree.c        | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/include/linux/nstree.h b/include/linux/nstree.h
index 0e275df7e99a..98b848cf2f1c 100644
--- a/include/linux/nstree.h
+++ b/include/linux/nstree.h
@@ -22,6 +22,14 @@ extern struct ns_tree time_ns_tree;
 extern struct ns_tree user_ns_tree;
 extern struct ns_tree uts_ns_tree;
 
+void ns_tree_node_init(struct ns_tree_node *node);
+void ns_tree_root_init(struct ns_tree_root *root);
+bool ns_tree_node_empty(const struct ns_tree_node *node);
+struct rb_node *ns_tree_node_add(struct ns_tree_node *node,
+				  struct ns_tree_root *root,
+				  int (*cmp)(struct rb_node *, const struct rb_node *));
+void ns_tree_node_del(struct ns_tree_node *node, struct ns_tree_root *root);
+
 #define to_ns_tree(__ns)					\
 	_Generic((__ns),					\
 		struct cgroup_namespace *: &(cgroup_ns_tree),	\
diff --git a/kernel/nstree.c b/kernel/nstree.c
index 97404fb90749..fe71ff943f70 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -73,6 +73,91 @@ struct ns_tree time_ns_tree = {
 	.type = CLONE_NEWTIME,
 };
 
+/**
+ * ns_tree_node_init - Initialize a namespace tree node
+ * @node: The node to initialize
+ *
+ * Initializes both the rbtree node and list entry.
+ */
+void ns_tree_node_init(struct ns_tree_node *node)
+{
+	RB_CLEAR_NODE(&node->ns_node);
+	INIT_LIST_HEAD(&node->ns_list_entry);
+}
+
+/**
+ * ns_tree_root_init - Initialize a namespace tree root
+ * @root: The root to initialize
+ *
+ * Initializes both the rbtree root and list head.
+ */
+void ns_tree_root_init(struct ns_tree_root *root)
+{
+	root->ns_rb = RB_ROOT;
+	INIT_LIST_HEAD(&root->ns_list_head);
+}
+
+/**
+ * ns_tree_node_empty - Check if a namespace tree node is empty
+ * @node: The node to check
+ *
+ * Returns true if the node is not in any tree.
+ */
+bool ns_tree_node_empty(const struct ns_tree_node *node)
+{
+	return RB_EMPTY_NODE(&node->ns_node);
+}
+
+/**
+ * ns_tree_node_add - Add a node to a namespace tree
+ * @node: The node to add
+ * @root: The tree root to add to
+ * @cmp: Comparison function for rbtree insertion
+ *
+ * Adds the node to both the rbtree and the list, maintaining sorted order.
+ * The list is maintained in the same order as the rbtree to enable efficient
+ * iteration.
+ *
+ * Returns: NULL if insertion succeeded, existing node if duplicate found
+ */
+struct rb_node *ns_tree_node_add(struct ns_tree_node *node,
+				  struct ns_tree_root *root,
+				  int (*cmp)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node *ret, *prev;
+
+	/* Add to rbtree */
+	ret = rb_find_add_rcu(&node->ns_node, &root->ns_rb, cmp);
+
+	/* Add to list in sorted order */
+	prev = rb_prev(&node->ns_node);
+	if (!prev) {
+		/* No previous node, add at head */
+		list_add_rcu(&node->ns_list_entry, &root->ns_list_head);
+	} else {
+		/* Add after previous node */
+		struct ns_tree_node *prev_node;
+		prev_node = rb_entry(prev, struct ns_tree_node, ns_node);
+		list_add_rcu(&node->ns_list_entry, &prev_node->ns_list_entry);
+	}
+
+	return ret;
+}
+
+/**
+ * ns_tree_node_del - Remove a node from a namespace tree
+ * @node: The node to remove
+ * @root: The tree root to remove from
+ *
+ * Removes the node from both the rbtree and the list atomically.
+ */
+void ns_tree_node_del(struct ns_tree_node *node, struct ns_tree_root *root)
+{
+	rb_erase(&node->ns_node, &root->ns_rb);
+	RB_CLEAR_NODE(&node->ns_node);
+	list_bidir_del_rcu(&node->ns_list_entry);
+}
+
 static inline struct ns_common *node_to_ns(const struct rb_node *node)
 {
 	if (!node)

-- 
2.47.3


