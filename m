Return-Path: <linux-fsdevel+bounces-37151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B9C9EE661
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431741883C27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9602153D4;
	Thu, 12 Dec 2024 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUU1RRCs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4147A212B09
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004585; cv=none; b=o9wgz638CwEKKvoNNUmj2KjbB4Y9OElhTd9ENngjgHIvhPwSUDbtdWxRORVgY1KqupFxKT6S3TA5r28t3SLJ4ThRgwh1zNlSJlF+KM6ghVHKL9aGMchQo8jBq8cp6Oa0LXJEAKDz61i35fzEiFK74KRDl/KRnKqwrZHYt2/z1QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004585; c=relaxed/simple;
	bh=xmuZyV5Vglw81sFyX91aDi/KlVW2DZtC+gI8wbR8FEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=maMWDSsTVFIZNBtQmh1w0ZwJB9aSRG/NwTOGb/Qa4uNM9f5k1anq3ulp5Whq0H9OqBDjv3T2IPJ1CZCgN5QHFvAQnVTd/rctiioIVB79Xi62nzD/DiE8mc9sodSNHwy30YjlQOTSD7QgHMvKEBykEWW3ltl1Lgn1aPSOmtvQqI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUU1RRCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3A2C4CED0;
	Thu, 12 Dec 2024 11:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734004584;
	bh=xmuZyV5Vglw81sFyX91aDi/KlVW2DZtC+gI8wbR8FEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BUU1RRCsP5YvXICxDmKkLFs68YMwy9ulTI9xK1y+TR51tvjBP0IPl9usTua8uyNkx
	 bv1Qu7UqT2/UEPSBdJZ4F3u1c5vi8EobnbNYESNBENb5PE29PCPjFNdHZUQ3nK1fzL
	 9AThSl/d19E9d6Q8ili0Bk0zl24ASgdNQIuHtyFKGmVzx7TyUgjOuC8BkEvQBCEyYh
	 LZDDl3k/SSZGlO+cGopFgIenI6RXS+wnB8t5yfe7DygJcNQjKcn5HD6H/dm55IT8JQ
	 3p4yABWf36NQiQjBOYfwf5qMa3KZLnt/hrvRyGUmeXrGuhjp1nZxv3CDWlsNxM3MJE
	 gnmOtkGiWMxYA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Dec 2024 12:56:04 +0100
Subject: [PATCH v2 5/8] fs: lockless mntns lookup for nsfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-work-mount-rbtree-lockless-v2-5-4fe6cef02534@kernel.org>
References: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
In-Reply-To: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5823; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xmuZyV5Vglw81sFyX91aDi/KlVW2DZtC+gI8wbR8FEg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHnY+5XnV4s3BM4q6fc7Sn8nxhfzjhcEVcZXSAwQ2fl
 zrGnf8fdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEXY3hv88M1luWl9sS5oTZ
 Np5cy6zM/O1q9gurc8xvMgQvhU1XE2Bk6LzyedrFi/eLdl2zPPhkGcfzs9dLTn3nuP5n7pTtEwR
 ZO5kA
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
 fs/mount.h     | 17 +++++++----------
 fs/namespace.c | 34 +++++++++++++++++++++-------------
 fs/nsfs.c      |  5 +----
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 3c3763d8ae821d6a117c528808dbc94d0251f964..b7edb4034c2131b758f953cefbf47d060e27e03a 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -17,7 +17,10 @@ struct mnt_namespace {
 	unsigned int		nr_mounts; /* # of mounts in the namespace */
 	unsigned int		pending_mounts;
 	union {
-		struct rb_node	mnt_ns_tree_node; /* node in the mnt_ns_tree */
+		struct {
+			struct list_head	mnt_ns_list;
+			struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
+		};
 		struct rcu_head mnt_ns_rcu;
 	};
 	refcount_t		passive; /* number references not pinning @mounts */
@@ -157,15 +160,9 @@ static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
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
index 9463b9ab95f0a5db32cfe5fc5564d7f25ce3e06f..a5e1b166be9430d47c295159292cb9028b2e2339 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -82,6 +82,7 @@ static DEFINE_RWLOCK(mnt_ns_tree_lock);
 static seqcount_rwlock_t mnt_ns_tree_seqcount = SEQCNT_RWLOCK_ZERO(mnt_ns_tree_seqcount, &mnt_ns_tree_lock);
 
 static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
+static LIST_HEAD(mnt_ns_list); /* protected by mnt_ns_tree_lock */
 
 struct mount_kattr {
 	unsigned int attr_set;
@@ -146,6 +147,7 @@ static void mnt_ns_tree_add(struct mnt_namespace *ns)
 
 	mnt_ns_tree_write_lock();
 	node = rb_find_add_rcu(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_cmp);
+	list_add_tail_rcu(&ns->mnt_ns_list, &mnt_ns_list);
 	mnt_ns_tree_write_unlock();
 
 	WARN_ON_ONCE(node);
@@ -177,6 +179,7 @@ static void mnt_ns_tree_remove(struct mnt_namespace *ns)
 	if (!is_anon_ns(ns)) {
 		mnt_ns_tree_write_lock();
 		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
+		list_bidir_del_rcu(&ns->mnt_ns_list);
 		mnt_ns_tree_write_unlock();
 	}
 
@@ -2091,30 +2094,34 @@ struct ns_common *from_mnt_ns(struct mnt_namespace *mnt)
 	return &mnt->ns;
 }
 
-struct mnt_namespace *__lookup_next_mnt_ns(struct mnt_namespace *mntns, bool previous)
+struct mnt_namespace *get_sequential_mnt_ns(struct mnt_namespace *mntns, bool previous)
 {
-	guard(read_lock)(&mnt_ns_tree_lock);
-	for (;;) {
-		struct rb_node *node;
+	struct list_head *list;
+
+	guard(rcu)();
 
+	for (;;) {
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
+		 * safe it's members are all still valid.
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
@@ -3931,6 +3938,7 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
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


