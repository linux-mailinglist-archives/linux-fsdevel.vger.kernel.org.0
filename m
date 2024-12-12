Return-Path: <linux-fsdevel+bounces-37243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03429EFFC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 00:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC99168A7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 23:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF9F1DE4FC;
	Thu, 12 Dec 2024 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md4v1rzB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7141DE3DB
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044643; cv=none; b=TpimSM3TEl8SKKD05vMrrH1Ay9zsmXDrqgMxN1wsa0nC3yrY+ccX3v9qEsmP/+syD+dHD/KkY+gKM6u302048r8/5nX9EdvehqrPCSi/27G0EHryzGk4xG9WZnc3XlnLgKmIFi/z3DmqL0QiqGTBsBbJ+gXCd9Yt6N8E+8bFCy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044643; c=relaxed/simple;
	bh=820WYTCAXjCPqP2AExAcrX3rT4vmFJWlBlgB1cdafIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cJFAwZ4naKqDrWcfxICtftSLlb1kdhzcFuL7pMl08RdVKYuofyoB0eUUX0ufGpNbdrXvLjJ2P/rRcVcfmKMIBloomidsWn3tDfZ00SvXHR7ccj8m0/HNWCBdxnS4d+tXbhO4bmw/q58nbaHfLMZGpBQJSLVeYekwz+lUag8R05A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md4v1rzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69704C4CECE;
	Thu, 12 Dec 2024 23:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734044642;
	bh=820WYTCAXjCPqP2AExAcrX3rT4vmFJWlBlgB1cdafIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=md4v1rzBL0QycBwoKWnNUjvPzz1Qng9RpmW8x2Yn/FGQPft3XBzCCr4R+ZPEbr+Rh
	 W8kCpCwbIZR/99j3+xMeyks/azy65AKZdNbg4Swxm9goXHX+sXMDnu7LrVqj88wEZF
	 pm9s5L34bfT0eo/mqridWp4oRvGTC17pK5B4oduyY0gQkC1B5J/0WdlcS9KwSlSw2B
	 V0/W5DQIAuKgRff5DcWixzr9SjJXhy+Q2lCvyvyMERgyRsAb3GSlGt4jUHtd3xClF0
	 bBTRge6Y7yn9nHNZQryfPe/eYBaNIsCgZcQNw5ywu4XcOgtC7lFFDfB//Knco4bpMI
	 tp3PH5MkPsNdw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 13 Dec 2024 00:03:42 +0100
Subject: [PATCH v3 03/10] fs: lockless mntns rbtree lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-work-mount-rbtree-lockless-v3-3-6e3cdaf9b280@kernel.org>
References: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
In-Reply-To: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6711; i=brauner@kernel.org;
 h=from:subject:message-id; bh=820WYTCAXjCPqP2AExAcrX3rT4vmFJWlBlgB1cdafIc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHZ9+6FntC+6aQJvurQgX2oDz5SzK/9u61Msj87K1dt
 8d33mP7jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncnMLwVyxvqc+BZs3u61Z5
 i0t2Mlplainud+quOanLK16px+C0geEPT/3eYx4v51W47RDhmRur8LnF/9ar8Aer6/wb1madmHy
 VFQA=
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
index 185fc56afc13338f8185fe818051444d540cbd5b..36ead0e45e8aa7614c00001102563a711d9dae6e 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -12,7 +12,10 @@ struct mnt_namespace {
 	struct user_namespace	*user_ns;
 	struct ucounts		*ucounts;
 	u64			seq;	/* Sequence number to prevent loops */
-	wait_queue_head_t poll;
+	union {
+		wait_queue_head_t	poll;
+		struct rcu_head		mnt_ns_rcu;
+	};
 	u64 event;
 	unsigned int		nr_mounts; /* # of mounts in the namespace */
 	unsigned int		pending_mounts;
diff --git a/fs/namespace.c b/fs/namespace.c
index 10fa18dd66018fadfdc9d18c59a851eed7bd55ad..52adee787eb1b6ee8831705b2b121854c3370fb3 100644
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
+	 * The last reference count is put with RCU delay so we can
+	 * unconditonally acquire a reference here.
+	 */
+	ns = node_to_mnt_ns(node);
+	refcount_inc(&ns->passive);
+	return ns;
 }
 
 static inline void lock_mount_hash(void)

-- 
2.45.2


