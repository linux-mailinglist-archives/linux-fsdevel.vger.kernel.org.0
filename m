Return-Path: <linux-fsdevel+bounces-37245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59899EFFC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 00:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683A5286700
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 23:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33A01DE8BE;
	Thu, 12 Dec 2024 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRNV1x7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232551DE3DB
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044647; cv=none; b=K6o4+bpcSQ0u0fG1TlnYBhyWHo0kBnRqbvX6QPHQ7XZYtT3xQjU4irE1vsZgTHpF3lzMiZLjR6XjlK9/KzaqiQBM/Z8mB55DjO6hSN+HUV92h1MY1E33U+iDg2QR5ELx6C3hA/WhxpnePzBYG3G6MlqhHwb8n5j8OI0P6GGMD34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044647; c=relaxed/simple;
	bh=+HrbHl3rDHja00XxAbQVDUlTGLxQ5nPTq9yadkF71tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aRCP9Ga5O1wPjOm4lizSriiNNM7dhQIFCi4W+WOie8kinOGe7+H9PsAOTX3Ah9WQezcy/AHXrVnAt/kKq4cwgRqJebhPi3x28wMl9Zummc8XA1LewnIhlUDLklmCJ7Yu47LmTxt/0Qbxy9aXvNmI0n9LXRrOvI63jKIWE/A1Z8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRNV1x7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA05C4CECE;
	Thu, 12 Dec 2024 23:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734044646;
	bh=+HrbHl3rDHja00XxAbQVDUlTGLxQ5nPTq9yadkF71tc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vRNV1x7LOpjUO+by3QHcN73B/7scyuKE3z7Asre47e9jPmoKibpfp5BvsBX0adG4c
	 JYKvkuyI/QYLxF3Dtv5I61INyOQozeJGzGNF7uF4H5MyV1rlX+G121/yOUpqX62lEY
	 DS7Aqa6PkMZrCqvrzQRC2/zENeZc522yDENVtRKv7B06MtJm7kEqyExAiAEueP/5fN
	 FKU5epRYYStagewjUC9xGIX+B5lTMMiceeHZYQpef923rtwe0mGQI9/NLwrrfc0TCE
	 KdiY33SfmFVr0wCufSvfcuELLiSP75Rr4cWC1cWOQuwDa5W96SQq763MkDuRocKrFj
	 rJGAunNJS2rwg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 13 Dec 2024 00:03:44 +0100
Subject: [PATCH v3 05/10] fs: lockless mntns lookup for nsfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-work-mount-rbtree-lockless-v3-5-6e3cdaf9b280@kernel.org>
References: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
In-Reply-To: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6145; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+HrbHl3rDHja00XxAbQVDUlTGLxQ5nPTq9yadkF71tc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHZ9/yYtV381722lRU4Gv68RNXp+tM55K5l/gsdL7n1
 979dRtiOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS+46RYbOZ+DeHt7mPU+8X
 icg36y6wup0ZGCyf1NZzc8ku7x3JqQx/uOWuMs7wv58leHZPvnd/d6Wnl9zH+/Y1qqwSJhvLOIo
 ZAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We already made the rbtree lookup lockless for the simple lookup case.
However, walking the list of mount namespaces via nsfs still happens
with taking the read lock blocking concurrent additions of new mount
namespaces pointlessly. Plus, such additions are rare anyway so allow
lockless lookup of the previous and next mount namespace by keeping a
separate list. This also allows to make some things simpler in the code.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mount.h     | 13 ++++---------
 fs/namespace.c | 42 +++++++++++++++++++++++++++++-------------
 fs/nsfs.c      |  5 +----
 3 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 36ead0e45e8aa7614c00001102563a711d9dae6e..8cda387f47c5efd9af5e2e422569446c3d51986f 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -20,6 +20,7 @@ struct mnt_namespace {
 	unsigned int		nr_mounts; /* # of mounts in the namespace */
 	unsigned int		pending_mounts;
 	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
+	struct list_head	mnt_ns_list; /* entry in the sequential list of mounts namespace */
 	refcount_t		passive; /* number references not pinning @mounts */
 } __randomize_layout;
 
@@ -157,15 +158,9 @@ static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
 }
 
 bool has_locked_children(struct mount *mnt, struct dentry *dentry);
-struct mnt_namespace *__lookup_next_mnt_ns(struct mnt_namespace *mnt_ns, bool previous);
-static inline struct mnt_namespace *lookup_next_mnt_ns(struct mnt_namespace *mntns)
-{
-	return __lookup_next_mnt_ns(mntns, false);
-}
-static inline struct mnt_namespace *lookup_prev_mnt_ns(struct mnt_namespace *mntns)
-{
-	return __lookup_next_mnt_ns(mntns, true);
-}
+struct mnt_namespace *get_sequential_mnt_ns(struct mnt_namespace *mnt_ns,
+					    bool previous);
+
 static inline struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 {
 	return container_of(ns, struct mnt_namespace, ns);
diff --git a/fs/namespace.c b/fs/namespace.c
index 52adee787eb1b6ee8831705b2b121854c3370fb3..71509309652315e5aa9c6b16d13de678bf1c98b3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -82,6 +82,7 @@ static DEFINE_RWLOCK(mnt_ns_tree_lock);
 static seqcount_rwlock_t mnt_ns_tree_seqcount = SEQCNT_RWLOCK_ZERO(mnt_ns_tree_seqcount, &mnt_ns_tree_lock);
 
 static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
+static LIST_HEAD(mnt_ns_list); /* protected by mnt_ns_tree_lock */
 
 struct mount_kattr {
 	unsigned int attr_set;
@@ -142,10 +143,19 @@ static inline void mnt_ns_tree_write_unlock(void)
 
 static void mnt_ns_tree_add(struct mnt_namespace *ns)
 {
-	struct rb_node *node;
+	struct rb_node *node, *prev;
 
 	mnt_ns_tree_write_lock();
 	node = rb_find_add_rcu(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_cmp);
+	/*
+	 * If there's no previous entry simply add it after the
+	 * head and if there is add it after the previous entry.
+	 */
+	prev = rb_prev(&ns->mnt_ns_tree_node);
+	if (!prev)
+		list_add_rcu(&ns->mnt_ns_list, &mnt_ns_list);
+	else
+		list_add_rcu(&ns->mnt_ns_list, &node_to_mnt_ns(prev)->mnt_ns_list);
 	mnt_ns_tree_write_unlock();
 
 	WARN_ON_ONCE(node);
@@ -177,6 +187,7 @@ static void mnt_ns_tree_remove(struct mnt_namespace *ns)
 	if (!is_anon_ns(ns)) {
 		mnt_ns_tree_write_lock();
 		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
+		list_bidir_del_rcu(&ns->mnt_ns_list);
 		mnt_ns_tree_write_unlock();
 	}
 
@@ -2091,30 +2102,34 @@ struct ns_common *from_mnt_ns(struct mnt_namespace *mnt)
 	return &mnt->ns;
 }
 
-struct mnt_namespace *__lookup_next_mnt_ns(struct mnt_namespace *mntns, bool previous)
+struct mnt_namespace *get_sequential_mnt_ns(struct mnt_namespace *mntns, bool previous)
 {
-	guard(read_lock)(&mnt_ns_tree_lock);
+	guard(rcu)();
+
 	for (;;) {
-		struct rb_node *node;
+		struct list_head *list;
 
 		if (previous)
-			node = rb_prev(&mntns->mnt_ns_tree_node);
+			list = rcu_dereference(list_bidir_prev_rcu(&mntns->mnt_ns_list));
 		else
-			node = rb_next(&mntns->mnt_ns_tree_node);
-		if (!node)
+			list = rcu_dereference(list_next_rcu(&mntns->mnt_ns_list));
+		if (list_is_head(list, &mnt_ns_list))
 			return ERR_PTR(-ENOENT);
 
-		mntns = node_to_mnt_ns(node);
-		node = &mntns->mnt_ns_tree_node;
+		mntns = list_entry_rcu(list, struct mnt_namespace, mnt_ns_list);
 
+		/*
+		 * The last passive reference count is put with RCU
+		 * delay so accessing the mount namespace is not just
+		 * safe but all relevant members are still valid.
+		 */
 		if (!ns_capable_noaudit(mntns->user_ns, CAP_SYS_ADMIN))
 			continue;
 
 		/*
-		 * Holding mnt_ns_tree_lock prevents the mount namespace from
-		 * being freed but it may well be on it's deathbed. We want an
-		 * active reference, not just a passive one here as we're
-		 * persisting the mount namespace.
+		 * We need an active reference count as we're persisting
+		 * the mount namespace and it might already be on its
+		 * deathbed.
 		 */
 		if (!refcount_inc_not_zero(&mntns->ns.count))
 			continue;
@@ -3931,6 +3946,7 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 	refcount_set(&new_ns->ns.count, 1);
 	refcount_set(&new_ns->passive, 1);
 	new_ns->mounts = RB_ROOT;
+	INIT_LIST_HEAD(&new_ns->mnt_ns_list);
 	RB_CLEAR_NODE(&new_ns->mnt_ns_tree_node);
 	init_waitqueue_head(&new_ns->poll);
 	new_ns->user_ns = get_user_ns(user_ns);
diff --git a/fs/nsfs.c b/fs/nsfs.c
index c675fc40ce2dc674f0dafce5c4924b910a73a23f..663f8656158d52d391ba80ef1d320197d3d654e0 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -274,10 +274,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		if (usize < MNT_NS_INFO_SIZE_VER0)
 			return -EINVAL;
 
-		if (previous)
-			mnt_ns = lookup_prev_mnt_ns(to_mnt_ns(ns));
-		else
-			mnt_ns = lookup_next_mnt_ns(to_mnt_ns(ns));
+		mnt_ns = get_sequential_mnt_ns(to_mnt_ns(ns), previous);
 		if (IS_ERR(mnt_ns))
 			return PTR_ERR(mnt_ns);
 

-- 
2.45.2


