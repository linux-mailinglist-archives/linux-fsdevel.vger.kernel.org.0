Return-Path: <linux-fsdevel+bounces-61063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20668B54D6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19FA11882A8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9985A3191C6;
	Fri, 12 Sep 2025 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmJ5nDYt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D582A3164A4;
	Fri, 12 Sep 2025 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678085; cv=none; b=OYekl6Ubm8jIUzp+79yB4l4XpApqYSeUjClU7PcrCFkpjQ32CSfrZr4hO4h+oMlAWHElaBByyiC+gHwQYgbD8nPUoB0ZI2VWDRsL2u16BEnuHA/rskvq5EtacgisAs/fXMaQS5ydyv4r8Z9pGbc805C8k8iFQRtCvexX+k7na8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678085; c=relaxed/simple;
	bh=YTjFTBklU0HxE4vzfmBNdDOoYZvR4PGiEb+GyMB7dP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l4xNb3PrqtGA9o3bYVg/JsWxUj9Hi596lGbeGFAwmn/vrQClA/uKJzkts/CThGUfO3tG8SVrBxNPeyaMlJxY2NmMf8z+AAAQGNxRtuilwfqqi1dYnbw/XKVvKAzUQiC3Rzhe7iso12SD22GareOFg/AFkWaEzcpxrcs+khEPbAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmJ5nDYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493DEC4CEF7;
	Fri, 12 Sep 2025 11:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678084;
	bh=YTjFTBklU0HxE4vzfmBNdDOoYZvR4PGiEb+GyMB7dP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PmJ5nDYtwkx0LxtEjykfgLKm8YAIJTCyFjJdDD2wKUQmhe2uqNPnVe+h8DUkCgv9d
	 0UUhuoZ1LzJCS5VcJyC/TBJThKnRrXcR6LoVPsOP+6uL5q6ld/2PVFAoxYo7lyxI5b
	 OqemD+SarHAE5HWlWaXq3mcvXLIZymtlbxdYFuUOoQJbHp/V6xNmjCzXMI1huap5bx
	 fO+9+c9ipozP8J84i/TYtLKEFMCEE4kQhGLsNNYIV+Tm/Fe6JiB5AkRnC/xUMT31Pe
	 ZeZ+mtQhkWCJlFCqPk83jlTQS0jtHwdfZ+NH1V6fH7IEG5VzloIqP+1zo8QGD+7zDj
	 kHJ2VjBm5Hf0A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:41 +0200
Subject: [PATCH v2 18/33] mnt: support ns lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-18-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=10978; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YTjFTBklU0HxE4vzfmBNdDOoYZvR4PGiEb+GyMB7dP0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZxabB7WOPvSVH5tq7wVh/8xnrDJO2fgyKZUerdyl
 5jn2jM2HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMRnMnI8EOYIbvzxn3el+vP
 9U/zfChVOZVxS47VnVu3NpuZ6h5Yc5KR4cbrUx9lN/2ZJWEXWLFARtjHtzn+W+s14edeDf6r/Dp
 f8gAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Move the mount namespace to the generic ns lookup infrastructure.
This allows us to drop a bunch of members from struct mnt_namespace.
                                                                      t
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mount.h     |  10 +---
 fs/namespace.c | 141 +++++++++++++--------------------------------------------
 fs/nsfs.c      |   4 +-
 3 files changed, 35 insertions(+), 120 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 97737051a8b9..76bf863c9ae2 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -17,11 +17,7 @@ struct mnt_namespace {
 	};
 	struct user_namespace	*user_ns;
 	struct ucounts		*ucounts;
-	u64			seq;	/* Sequence number to prevent loops */
-	union {
-		wait_queue_head_t	poll;
-		struct rcu_head		mnt_ns_rcu;
-	};
+	wait_queue_head_t	poll;
 	u64			seq_origin; /* Sequence number of origin mount namespace */
 	u64 event;
 #ifdef CONFIG_FSNOTIFY
@@ -30,8 +26,6 @@ struct mnt_namespace {
 #endif
 	unsigned int		nr_mounts; /* # of mounts in the namespace */
 	unsigned int		pending_mounts;
-	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
-	struct list_head	mnt_ns_list; /* entry in the sequential list of mounts namespace */
 	refcount_t		passive; /* number references not pinning @mounts */
 } __randomize_layout;
 
@@ -173,7 +167,7 @@ static inline bool is_local_mountpoint(const struct dentry *dentry)
 
 static inline bool is_anon_ns(struct mnt_namespace *ns)
 {
-	return ns->seq == 0;
+	return ns->ns.ns_id == 0;
 }
 
 static inline bool anon_ns_root(const struct mount *m)
diff --git a/fs/namespace.c b/fs/namespace.c
index 14c5cdbdd6e1..40a8d75f6b16 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -33,6 +33,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/pidfs.h>
+#include <linux/nstree.h>
 
 #include "pnode.h"
 #include "internal.h"
@@ -80,13 +81,10 @@ static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 static struct mnt_namespace *emptied_ns; /* protected by namespace_sem */
-static DEFINE_SEQLOCK(mnt_ns_tree_lock);
 
 #ifdef CONFIG_FSNOTIFY
 LIST_HEAD(notify_list); /* protected by namespace_sem */
 #endif
-static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
-static LIST_HEAD(mnt_ns_list); /* protected by mnt_ns_tree_lock */
 
 enum mount_kattr_flags_t {
 	MOUNT_KATTR_RECURSE		= (1 << 0),
@@ -119,53 +117,12 @@ __cacheline_aligned_in_smp DEFINE_SEQLOCK(mount_lock);
 
 static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
 {
+	struct ns_common *ns;
+
 	if (!node)
 		return NULL;
-	return rb_entry(node, struct mnt_namespace, mnt_ns_tree_node);
-}
-
-static int mnt_ns_cmp(struct rb_node *a, const struct rb_node *b)
-{
-	struct mnt_namespace *ns_a = node_to_mnt_ns(a);
-	struct mnt_namespace *ns_b = node_to_mnt_ns(b);
-	u64 seq_a = ns_a->seq;
-	u64 seq_b = ns_b->seq;
-
-	if (seq_a < seq_b)
-		return -1;
-	if (seq_a > seq_b)
-		return 1;
-	return 0;
-}
-
-static inline void mnt_ns_tree_write_lock(void)
-{
-	write_seqlock(&mnt_ns_tree_lock);
-}
-
-static inline void mnt_ns_tree_write_unlock(void)
-{
-	write_sequnlock(&mnt_ns_tree_lock);
-}
-
-static void mnt_ns_tree_add(struct mnt_namespace *ns)
-{
-	struct rb_node *node, *prev;
-
-	mnt_ns_tree_write_lock();
-	node = rb_find_add_rcu(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_cmp);
-	/*
-	 * If there's no previous entry simply add it after the
-	 * head and if there is add it after the previous entry.
-	 */
-	prev = rb_prev(&ns->mnt_ns_tree_node);
-	if (!prev)
-		list_add_rcu(&ns->mnt_ns_list, &mnt_ns_list);
-	else
-		list_add_rcu(&ns->mnt_ns_list, &node_to_mnt_ns(prev)->mnt_ns_list);
-	mnt_ns_tree_write_unlock();
-
-	WARN_ON_ONCE(node);
+	ns = rb_entry(node, struct ns_common, ns_tree_node);
+	return container_of(ns, struct mnt_namespace, ns);
 }
 
 static void mnt_ns_release(struct mnt_namespace *ns)
@@ -181,32 +138,16 @@ DEFINE_FREE(mnt_ns_release, struct mnt_namespace *, if (_T) mnt_ns_release(_T))
 
 static void mnt_ns_release_rcu(struct rcu_head *rcu)
 {
-	mnt_ns_release(container_of(rcu, struct mnt_namespace, mnt_ns_rcu));
+	mnt_ns_release(container_of(rcu, struct mnt_namespace, ns.ns_rcu));
 }
 
 static void mnt_ns_tree_remove(struct mnt_namespace *ns)
 {
 	/* remove from global mount namespace list */
-	if (!is_anon_ns(ns)) {
-		mnt_ns_tree_write_lock();
-		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
-		list_bidir_del_rcu(&ns->mnt_ns_list);
-		mnt_ns_tree_write_unlock();
-	}
-
-	call_rcu(&ns->mnt_ns_rcu, mnt_ns_release_rcu);
-}
-
-static int mnt_ns_find(const void *key, const struct rb_node *node)
-{
-	const u64 mnt_ns_id = *(u64 *)key;
-	const struct mnt_namespace *ns = node_to_mnt_ns(node);
+	if (!is_anon_ns(ns))
+		ns_tree_remove(ns);
 
-	if (mnt_ns_id < ns->seq)
-		return -1;
-	if (mnt_ns_id > ns->seq)
-		return 1;
-	return 0;
+	call_rcu(&ns->ns.ns_rcu, mnt_ns_release_rcu);
 }
 
 /*
@@ -225,28 +166,21 @@ static int mnt_ns_find(const void *key, const struct rb_node *node)
  */
 static struct mnt_namespace *lookup_mnt_ns(u64 mnt_ns_id)
 {
-	struct mnt_namespace *ns;
-	struct rb_node *node;
-	unsigned int seq;
+	struct mnt_namespace *mnt_ns;
+	struct ns_common *ns;
 
 	guard(rcu)();
-	do {
-		seq = read_seqbegin(&mnt_ns_tree_lock);
-		node = rb_find_rcu(&mnt_ns_id, &mnt_ns_tree, mnt_ns_find);
-		if (node)
-			break;
-	} while (read_seqretry(&mnt_ns_tree_lock, seq));
-
-	if (!node)
+	ns = ns_tree_lookup_rcu(mnt_ns_id, CLONE_NEWNS);
+	if (!ns)
 		return NULL;
 
 	/*
 	 * The last reference count is put with RCU delay so we can
 	 * unconditonally acquire a reference here.
 	 */
-	ns = node_to_mnt_ns(node);
-	refcount_inc(&ns->passive);
-	return ns;
+	mnt_ns = container_of(ns, struct mnt_namespace, ns);
+	refcount_inc(&mnt_ns->passive);
+	return mnt_ns;
 }
 
 static inline void lock_mount_hash(void)
@@ -1017,7 +951,7 @@ static inline bool check_anonymous_mnt(struct mount *mnt)
 		return false;
 
 	seq = mnt->mnt_ns->seq_origin;
-	return !seq || (seq == current->nsproxy->mnt_ns->seq);
+	return !seq || (seq == current->nsproxy->mnt_ns->ns.ns_id);
 }
 
 /*
@@ -2155,19 +2089,16 @@ struct ns_common *from_mnt_ns(struct mnt_namespace *mnt)
 
 struct mnt_namespace *get_sequential_mnt_ns(struct mnt_namespace *mntns, bool previous)
 {
+	struct ns_common *ns;
+
 	guard(rcu)();
 
 	for (;;) {
-		struct list_head *list;
-
-		if (previous)
-			list = rcu_dereference(list_bidir_prev_rcu(&mntns->mnt_ns_list));
-		else
-			list = rcu_dereference(list_next_rcu(&mntns->mnt_ns_list));
-		if (list_is_head(list, &mnt_ns_list))
-			return ERR_PTR(-ENOENT);
+		ns = ns_tree_adjoined_rcu(mntns, previous);
+		if (IS_ERR(ns))
+			return ERR_CAST(ns);
 
-		mntns = list_entry_rcu(list, struct mnt_namespace, mnt_ns_list);
+		mntns = to_mnt_ns(ns);
 
 		/*
 		 * The last passive reference count is put with RCU
@@ -2207,7 +2138,7 @@ static bool mnt_ns_loop(struct dentry *dentry)
 	if (!mnt_ns)
 		return false;
 
-	return current->nsproxy->mnt_ns->seq >= mnt_ns->seq;
+	return current->nsproxy->mnt_ns->ns.ns_id >= mnt_ns->ns.ns_id;
 }
 
 struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
@@ -3070,7 +3001,7 @@ static struct file *open_detached_copy(struct path *path, bool recursive)
 		if (is_anon_ns(src_mnt_ns))
 			ns->seq_origin = src_mnt_ns->seq_origin;
 		else
-			ns->seq_origin = src_mnt_ns->seq;
+			ns->seq_origin = src_mnt_ns->ns.ns_id;
 	}
 
 	mnt = __do_loopback(path, recursive);
@@ -4153,15 +4084,6 @@ static void free_mnt_ns(struct mnt_namespace *ns)
 	mnt_ns_tree_remove(ns);
 }
 
-/*
- * Assign a sequence number so we can detect when we attempt to bind
- * mount a reference to an older mount namespace into the current
- * mount namespace, preventing reference counting loops.  A 64bit
- * number incrementing at 10Ghz will take 12,427 years to wrap which
- * is effectively never, so we can ignore the possibility.
- */
-static atomic64_t mnt_ns_seq = ATOMIC64_INIT(1);
-
 static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool anon)
 {
 	struct mnt_namespace *new_ns;
@@ -4185,11 +4107,11 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 		return ERR_PTR(ret);
 	}
 	if (!anon)
-		new_ns->seq = atomic64_inc_return(&mnt_ns_seq);
+		ns_tree_gen_id(&new_ns->ns);
+	RB_CLEAR_NODE(&new_ns->ns.ns_tree_node);
+	INIT_LIST_HEAD(&new_ns->ns.ns_list_node);
 	refcount_set(&new_ns->passive, 1);
 	new_ns->mounts = RB_ROOT;
-	INIT_LIST_HEAD(&new_ns->mnt_ns_list);
-	RB_CLEAR_NODE(&new_ns->mnt_ns_tree_node);
 	init_waitqueue_head(&new_ns->poll);
 	new_ns->user_ns = get_user_ns(user_ns);
 	new_ns->ucounts = ucounts;
@@ -4275,7 +4197,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	if (pwdmnt)
 		mntput(pwdmnt);
 
-	mnt_ns_tree_add(new_ns);
+	ns_tree_add_raw(new_ns);
 	return new_ns;
 }
 
@@ -5385,7 +5307,7 @@ static int statmount_sb_source(struct kstatmount *s, struct seq_file *seq)
 static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespace *ns)
 {
 	s->sm.mask |= STATMOUNT_MNT_NS_ID;
-	s->sm.mnt_ns_id = ns->seq;
+	s->sm.mnt_ns_id = ns->ns.ns_id;
 }
 
 static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
@@ -6090,7 +6012,6 @@ static void __init init_mount_tree(void)
 	ns = alloc_mnt_ns(&init_user_ns, true);
 	if (IS_ERR(ns))
 		panic("Can't allocate initial namespace");
-	ns->seq = atomic64_inc_return(&mnt_ns_seq);
 	ns->ns.inum = PROC_MNT_INIT_INO;
 	m = real_mount(mnt);
 	ns->root = m;
@@ -6105,7 +6026,7 @@ static void __init init_mount_tree(void)
 	set_fs_pwd(current->fs, &root);
 	set_fs_root(current->fs, &root);
 
-	mnt_ns_tree_add(ns);
+	ns_tree_add(ns);
 }
 
 void __init mnt_init(void)
diff --git a/fs/nsfs.c b/fs/nsfs.c
index d016d36272d4..80e631aeb3ce 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -139,7 +139,7 @@ static int copy_ns_info_to_user(const struct mnt_namespace *mnt_ns,
 	 * the size value will be set to the size the kernel knows about.
 	 */
 	kinfo->size		= min(usize, sizeof(*kinfo));
-	kinfo->mnt_ns_id	= mnt_ns->seq;
+	kinfo->mnt_ns_id	= mnt_ns->ns.ns_id;
 	kinfo->nr_mounts	= READ_ONCE(mnt_ns->nr_mounts);
 	/* Subtract the root mount of the mount namespace. */
 	if (kinfo->nr_mounts)
@@ -221,7 +221,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 
 		mnt_ns = container_of(ns, struct mnt_namespace, ns);
 		idp = (__u64 __user *)arg;
-		id = mnt_ns->seq;
+		id = mnt_ns->ns.ns_id;
 		return put_user(id, idp);
 	}
 	case NS_GET_PID_FROM_PIDNS:

-- 
2.47.3


