Return-Path: <linux-fsdevel+bounces-36986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7939EBB52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 21:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068ED1888D1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 20:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6542D22E3E4;
	Tue, 10 Dec 2024 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpPr7Tf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C519422B596
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864294; cv=none; b=AhzX0O5s1kxSnzcQDzHo5rd1Qm8vgvZ6VuKB2RaFWgdeMb0766U4P5gQMtkrmE8u48PY3kYvaDus9IJIkRLwYSqgUmP95Kub4+WPA2AhTtrxsvBlK1rxAzDcaftPgobT0gfG7jTUdnYQ56ueoesaIXSfHZlNuIDdsCdfmMsSawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864294; c=relaxed/simple;
	bh=eyBvy/l7ngDTdBGmraPBL6uSWAS16HYF9BkT++0RqHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMhrnUdyLQeV4KkPqeqU27NpD2mrdLRZpYzGB8qgJhmD+KGXBsgimU9ka3aLAwu1EQwo4S9j8fuEv+gNfmafDwL0US69gX37cAd6PyAxmsfjr5FyC5eWr4UcohlA7SX2p4Le3KsGPMcOSqDf6De8eQ/wB1YMpt3mqq0kllEUJco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpPr7Tf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7461CC4CED6;
	Tue, 10 Dec 2024 20:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733864294;
	bh=eyBvy/l7ngDTdBGmraPBL6uSWAS16HYF9BkT++0RqHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XpPr7Tf/EP86+w4O614OWPLrENGDQ3aP3cHdOeAW7pa65SMzAUPabIFkizV4KAtlF
	 cA86A5HQ6WFa1eLgO6z2guJ2vobMelZlhV1feZtccjaN9f3G3RhGcM7VHugoTaKpDz
	 n6buxSZLHuwKoEs4iQiOQVTri43LujbHixDQPy1T2xbCoyMyjCEQ4krP+MP7/avhpb
	 vN850GkZ9g/s2/cg7dEOt47i8Tejo26OxA2cRy+FoxmNRQhKYVa4qv3tWgYXD7sUmW
	 JhuzasK0KU/OL5bFDn1TTg/uQ3weBCQrFrekwYI9RAb55fk+5/iQKkzRbOjOdm6K5O
	 9J5Lv/JWNfeDQ==
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] fs: lockless mntns rbtree lookup
Date: Tue, 10 Dec 2024 21:57:59 +0100
Message-ID: <20241210-work-mount-rbtree-lockless-v1-3-338366b9bbe4@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210-work-mount-rbtree-lockless-v1-0-338366b9bbe4@kernel.org>
References: <20241210-work-mount-rbtree-lockless-v1-0-338366b9bbe4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6625; i=brauner@kernel.org; h=from:subject:message-id; bh=eyBvy/l7ngDTdBGmraPBL6uSWAS16HYF9BkT++0RqHA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHrI7o90jMPJJoZlUzZ/NXCc4lVvlLVj/Zoakb71Ly/ /b+6DqVjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInUTWdk2FH5OrGYpV/x9G8z A+ZJMhu2de7xftJjy75CKNjF7l7HF4b/zjxvDj1e4VU9aY+hwjF9cy6bqVucVszl7U3ZsIfHeck 9bgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Currently we use a read-write lock but for the simple search case we can
make this lockless. Creating a new mount namespace is a rather rare
event compared with querying mounts in a foreign mount namespace. Once
this is picked up by e.g., systemd to list mounts in another mount in
it's isolated services or in containers this will be used a lot so this
seems worthwhile doing.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mount.h     |  5 ++-
 fs/namespace.c | 99 ++++++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 73 insertions(+), 31 deletions(-)

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
index 10fa18dd66018fadfdc9d18c59a851eed7bd55ad..21e990482c5b2e1844d17413b55b58803fa7b008 100644
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
 
-	return mnt_ns_cmp(seq_a, ns_b) < 0;
+	if (seq_a < seq_b)
+		return -1;
+	if (seq_a > seq_b)
+		return 1;
+	return 0;
+}
+
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
@@ -150,15 +163,24 @@ static void mnt_ns_release(struct mnt_namespace *ns)
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
 
 /*
@@ -168,23 +190,23 @@ static void mnt_ns_tree_remove(struct mnt_namespace *ns)
 static struct mnt_namespace *mnt_ns_find_id_at(u64 mnt_ns_id)
 {
 	struct rb_node *node = mnt_ns_tree.rb_node;
-	struct mnt_namespace *ret = NULL;
+	struct mnt_namespace *mnt_ns = NULL;
 
-	lockdep_assert_held(&mnt_ns_tree_lock);
+	lockdep_assert(rcu_read_lock_held());
 
 	while (node) {
 		struct mnt_namespace *n = node_to_mnt_ns(node);
 
 		if (mnt_ns_id <= n->seq) {
-			ret = node_to_mnt_ns(node);
+			mnt_ns = node_to_mnt_ns(node);
 			if (mnt_ns_id == n->seq)
 				break;
-			node = node->rb_left;
+			node = rcu_dereference_raw(node->rb_left);
 		} else {
-			node = node->rb_right;
+			node = rcu_dereference_raw(node->rb_right);
 		}
 	}
-	return ret;
+	return mnt_ns;
 }
 
 /*
@@ -194,18 +216,35 @@ static struct mnt_namespace *mnt_ns_find_id_at(u64 mnt_ns_id)
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
+	unsigned int seq;
 
-       guard(read_lock)(&mnt_ns_tree_lock);
-       ns = mnt_ns_find_id_at(mnt_ns_id);
-       if (!ns || ns->seq != mnt_ns_id)
-               return NULL;
+	guard(rcu)();
+	do {
+		seq = read_seqcount_begin(&mnt_ns_tree_seqcount);
+		ns = mnt_ns_find_id_at(mnt_ns_id);
+		if (ns)
+			break;
+	} while (read_seqcount_retry(&mnt_ns_tree_seqcount, seq));
 
-       refcount_inc(&ns->passive);
-       return ns;
+	if (!ns || ns->seq != mnt_ns_id)
+		return NULL;
+
+	/*
+	* The last reference count is put with after RCU delay so we
+	* don't need to use refcount_inc_not_zero().
+	*/
+	refcount_inc(&ns->passive);
+	return ns;
 }
 
 static inline void lock_mount_hash(void)

-- 
2.45.2


