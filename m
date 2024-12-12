Return-Path: <linux-fsdevel+bounces-37149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B769EE60C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617B8286748
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2BF2153C0;
	Thu, 12 Dec 2024 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWRH0tDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11F921505C
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004581; cv=none; b=HO+bYdg+O+xq7dGu9xF0AY7IcGsCtxnKFR8tEQBZQlkgcAErXFsK6cCtLDjnt1wKK/eoCNS6V+liKsr4RIfGL9jv5EBDNQG0kamcOXj6H8ZBsZ403WFZ3ph0JLRsRi9O7ulx25cZwSAjmbSlS2CextFYbJXmQoaGwL+C/SpUir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004581; c=relaxed/simple;
	bh=9uZqIQyo8NI+Xi741dduNxbfHpc/apSEbGpd2RtJsJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+UjCq1kTD0l/pPT3EJJXauHUbY5MsIZdKeR9eYEy8G91EBZ9B1Su4Bm3sidErPV82cyLpVgyflYWcHleMDzeQenZTrYxDV21dVF8Qq4HgdSlzM2u9EA7F0EnP643Nz1LaX+FhZD6cRbyJ8RKOfmVLSSugTDQbUI1JjE9tZY1UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWRH0tDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1D9C4CED0;
	Thu, 12 Dec 2024 11:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734004580;
	bh=9uZqIQyo8NI+Xi741dduNxbfHpc/apSEbGpd2RtJsJI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pWRH0tDVJjNtwkwmZ2ZQxaGAR4kd9ZisQa90QP/GN01thzzLrReQQ1IkS3hIR20e+
	 6Tw8NoowdpPDgbxXo2HchiUZKcNtNEtoha07qWfB5JPDVaYhGmgniWuMyWTLqBUnrw
	 Rh3QGP8vij6hS7e/oNCNEdzUINmyy4KgnZYjynCi0IVgFOMnmWlieQnBZtYFyL0lfP
	 BncAeP39A4vt41NjcFYG5JDGtD4tXTanvwuO58GcZcqpQvuZz+OWY+5qSfpHn66IRa
	 PLV1Q28UCVanymNJBcdbWZmNMJkKaAFVl21hiH6WJgpNmRU/kVi2ffNTiYJq+eTZlw
	 lZ2YBhmwUAkyQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Dec 2024 12:56:02 +0100
Subject: [PATCH v2 3/8] fs: lockless mntns rbtree lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-work-mount-rbtree-lockless-v2-3-4fe6cef02534@kernel.org>
References: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
In-Reply-To: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6771; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9uZqIQyo8NI+Xi741dduNxbfHpc/apSEbGpd2RtJsJI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHnY85x+uo+SzkhCzjquzUHw+PeAt9L8t8a9L8bvmTV
 5MSxBp9O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZif4OR4VHDp8/inroOc2Xk
 n3IveddZt/KeTeG5+A+fT0T/11/ZeZSR4fCEhy5+cv/fvrtfxRi+6nNL8PUN7bITc/WMY/ffmTa
 fmRUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently we use a read-write lock but for the simple search case we can
make this lockless. Creating a new mount namespace is a rather rare
event compared with querying mounts in a foreign mount namespace. Once
this is picked up by e.g., systemd to list mounts in another mount in
it's isolated services or in containers this will be used a lot so this
seems worthwhile doing.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mount.h     |   5 ++-
 fs/namespace.c | 119 +++++++++++++++++++++++++++++++++++----------------------
 2 files changed, 77 insertions(+), 47 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 185fc56afc13338f8185fe818051444d540cbd5b..3c3763d8ae821d6a117c528808dbc94d0251f964 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -16,7 +16,10 @@ struct mnt_namespace {
 	u64 event;
 	unsigned int		nr_mounts; /* # of mounts in the namespace */
 	unsigned int		pending_mounts;
-	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
+	union {
+		struct rb_node	mnt_ns_tree_node; /* node in the mnt_ns_tree */
+		struct rcu_head mnt_ns_rcu;
+	};
 	refcount_t		passive; /* number references not pinning @mounts */
 } __randomize_layout;
 
diff --git a/fs/namespace.c b/fs/namespace.c
index 10fa18dd66018fadfdc9d18c59a851eed7bd55ad..9463b9ab95f0a5db32cfe5fc5564d7f25ce3e06f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -79,6 +79,8 @@ static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 static DEFINE_RWLOCK(mnt_ns_tree_lock);
+static seqcount_rwlock_t mnt_ns_tree_seqcount = SEQCNT_RWLOCK_ZERO(mnt_ns_tree_seqcount, &mnt_ns_tree_lock);
+
 static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
 
 struct mount_kattr {
@@ -105,17 +107,6 @@ EXPORT_SYMBOL_GPL(fs_kobj);
  */
 __cacheline_aligned_in_smp DEFINE_SEQLOCK(mount_lock);
 
-static int mnt_ns_cmp(u64 seq, const struct mnt_namespace *ns)
-{
-	u64 seq_b = ns->seq;
-
-	if (seq < seq_b)
-		return -1;
-	if (seq > seq_b)
-		return 1;
-	return 0;
-}
-
 static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
 {
 	if (!node)
@@ -123,19 +114,41 @@ static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
 	return rb_entry(node, struct mnt_namespace, mnt_ns_tree_node);
 }
 
-static bool mnt_ns_less(struct rb_node *a, const struct rb_node *b)
+static int mnt_ns_cmp(struct rb_node *a, const struct rb_node *b)
 {
 	struct mnt_namespace *ns_a = node_to_mnt_ns(a);
 	struct mnt_namespace *ns_b = node_to_mnt_ns(b);
 	u64 seq_a = ns_a->seq;
+	u64 seq_b = ns_b->seq;
+
+	if (seq_a < seq_b)
+		return -1;
+	if (seq_a > seq_b)
+		return 1;
+	return 0;
+}
 
-	return mnt_ns_cmp(seq_a, ns_b) < 0;
+static inline void mnt_ns_tree_write_lock(void)
+{
+	write_lock(&mnt_ns_tree_lock);
+	write_seqcount_begin(&mnt_ns_tree_seqcount);
+}
+
+static inline void mnt_ns_tree_write_unlock(void)
+{
+	write_seqcount_end(&mnt_ns_tree_seqcount);
+	write_unlock(&mnt_ns_tree_lock);
 }
 
 static void mnt_ns_tree_add(struct mnt_namespace *ns)
 {
-	guard(write_lock)(&mnt_ns_tree_lock);
-	rb_add(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_less);
+	struct rb_node *node;
+
+	mnt_ns_tree_write_lock();
+	node = rb_find_add_rcu(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_cmp);
+	mnt_ns_tree_write_unlock();
+
+	WARN_ON_ONCE(node);
 }
 
 static void mnt_ns_release(struct mnt_namespace *ns)
@@ -150,41 +163,36 @@ static void mnt_ns_release(struct mnt_namespace *ns)
 }
 DEFINE_FREE(mnt_ns_release, struct mnt_namespace *, if (_T) mnt_ns_release(_T))
 
+static void mnt_ns_release_rcu(struct rcu_head *rcu)
+{
+	struct mnt_namespace *mnt_ns;
+
+	mnt_ns = container_of(rcu, struct mnt_namespace, mnt_ns_rcu);
+	mnt_ns_release(mnt_ns);
+}
+
 static void mnt_ns_tree_remove(struct mnt_namespace *ns)
 {
 	/* remove from global mount namespace list */
 	if (!is_anon_ns(ns)) {
-		guard(write_lock)(&mnt_ns_tree_lock);
+		mnt_ns_tree_write_lock();
 		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
+		mnt_ns_tree_write_unlock();
 	}
 
-	mnt_ns_release(ns);
+	call_rcu(&ns->mnt_ns_rcu, mnt_ns_release_rcu);
 }
 
-/*
- * Returns the mount namespace which either has the specified id, or has the
- * next smallest id afer the specified one.
- */
-static struct mnt_namespace *mnt_ns_find_id_at(u64 mnt_ns_id)
+static int mnt_ns_find(const void *key, const struct rb_node *node)
 {
-	struct rb_node *node = mnt_ns_tree.rb_node;
-	struct mnt_namespace *ret = NULL;
-
-	lockdep_assert_held(&mnt_ns_tree_lock);
-
-	while (node) {
-		struct mnt_namespace *n = node_to_mnt_ns(node);
+	const u64 mnt_ns_id = *(u64 *)key;
+	const struct mnt_namespace *ns = node_to_mnt_ns(node);
 
-		if (mnt_ns_id <= n->seq) {
-			ret = node_to_mnt_ns(node);
-			if (mnt_ns_id == n->seq)
-				break;
-			node = node->rb_left;
-		} else {
-			node = node->rb_right;
-		}
-	}
-	return ret;
+	if (mnt_ns_id < ns->seq)
+		return -1;
+	if (mnt_ns_id > ns->seq)
+		return 1;
+	return 0;
 }
 
 /*
@@ -194,18 +202,37 @@ static struct mnt_namespace *mnt_ns_find_id_at(u64 mnt_ns_id)
  * namespace the @namespace_sem must first be acquired. If the namespace has
  * already shut down before acquiring @namespace_sem, {list,stat}mount() will
  * see that the mount rbtree of the namespace is empty.
+ *
+ * Note the lookup is lockless protected by a sequence counter. We only
+ * need to guard against false negatives as false positives aren't
+ * possible. So if we didn't find a mount namespace and the sequence
+ * counter has changed we need to retry. If the sequence counter is
+ * still the same we know the search actually failed.
  */
 static struct mnt_namespace *lookup_mnt_ns(u64 mnt_ns_id)
 {
-       struct mnt_namespace *ns;
+	struct mnt_namespace *ns;
+	struct rb_node *node;
+	unsigned int seq;
+
+	guard(rcu)();
+	do {
+		seq = read_seqcount_begin(&mnt_ns_tree_seqcount);
+		node = rb_find_rcu(&mnt_ns_id, &mnt_ns_tree, mnt_ns_find);
+		if (node)
+			break;
+	} while (read_seqcount_retry(&mnt_ns_tree_seqcount, seq));
 
-       guard(read_lock)(&mnt_ns_tree_lock);
-       ns = mnt_ns_find_id_at(mnt_ns_id);
-       if (!ns || ns->seq != mnt_ns_id)
-               return NULL;
+	if (!node)
+		return NULL;
 
-       refcount_inc(&ns->passive);
-       return ns;
+	/*
+	 * The last reference count is put with after RCU delay so we
+	 * don't need to use refcount_inc_not_zero().
+	 */
+	ns = node_to_mnt_ns(node);
+	refcount_inc(&ns->passive);
+	return ns;
 }
 
 static inline void lock_mount_hash(void)

-- 
2.45.2


