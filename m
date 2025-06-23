Return-Path: <linux-fsdevel+bounces-52467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A88AE3489
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 003547A5083
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD101F1921;
	Mon, 23 Jun 2025 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rqUD63Cn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB22D1DFDA5
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654477; cv=none; b=EO9HA/1B87Ov6xJbAxy3qsQ9ZoJZFCSzgO0s0ldYkl3xbn91Y4sd7RMNegMsoiTYgU/PKDkZCv0eliCV4nMOw0K+ADl/+CI9kFIyblfReINjsszCxge+SarWVqFwKR9vZxNogF9Mvqjsq26lU2ObdyseUTjFRZJpNtF/jchEHmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654477; c=relaxed/simple;
	bh=+9tU+WsWDoLDbKN91plpfGIjcMhGbF9SfIUcUyVayag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtThhjLFobaMDKEzl9bY1oHXXZeMygynwN0Wa91gy9ee3WPFk/t3uYsBzMVhGnvCU6hqG/3ixGWTQyvzXkXYecRGxUCX4r+k4oZoBLzA9CGxt4qPJoCd74HkJhfJuQq7YGK1oxgYtTcgxTBuRKEVxtL21g9NW+2IIMpKItqdgAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rqUD63Cn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aCFmwhziK22ZGIhyq0guwT78i8o/g7Ux0+abjpFtMUM=; b=rqUD63Cn76EYrBMxE4BLwLo2la
	tjs+HykTsajZAPU/qpnzS0c9FxWyE5utWiAo/0u2Cymn4mCJvaABdT7SHEW9m0TM2m8F28q0nbRVp
	7RIOg9BccF2/9MtWl3ZcwS1Lo2eW7mEBsMAPRKn+feMN5wXHyjtPCi+ErrApzq8+01ARBgWeYe4ui
	W4BZXPrgRLH2eTZcJni7vWBUcKVSKfV1jSczpcVtSQC9HcOz5OUG0lv2lRvdonpOpSvvCLrhC/fRT
	ls+DMYI5nX34WJ5bDpqpdhx6kTmjKre7yHz0M9+HD6C/4lOIzPwGCnASBiGb6uwsPwVcJ0zQs5F6v
	HJ1noldg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCT-00000005Ktv-0Srk;
	Mon, 23 Jun 2025 04:54:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 29/35] get rid of mountpoint->m_count
Date: Mon, 23 Jun 2025 05:54:22 +0100
Message-ID: <20250623045428.1271612-29-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

struct mountpoint has an odd kinda-sorta refcount in it.  It's always
either equal to or one above the number of mounts attached to that
mountpoint.

"One above" happens when a function takes a temporary reference to
mountpoint.  Things get simpler if we express that as inserting
a local object into ->m_list and removing it to drop the reference.

New calling conventions:

1) lock_mount(), do_lock_mount(), get_mountpoint() and lookup_mountpoint()
take an extra struct pinned_mountpoint * argument and returns 0/-E...
(or true/false in case of lookup_mountpoint()) instead of returning
struct mountpoint pointers.  In case of success, the struct mountpoint *
we used to get can be found as pinned_mountpoint.mp

2) unlock_mount() (always paired with lock_mount()/do_lock_mount()) takes
an address of struct pinned_mountpoint - the same that had been passed to
lock_mount()/do_lock_mount().

3) put_mountpoint() for a temporary reference (paired with get_mountpoint()
or lookup_mountpoint()) is replaced with unpin_mountpoint(), which takes
the address of pinned_mountpoint we passed to matching {get,lookup}_mountpoint().

4) all instances of pinned_mountpoint are local variables; they always live on
stack.  {} is used for initializer, after successful {get,lookup}_mountpoint()
we must make sure to call unpin_mountpoint() before leaving the scope and
after successful {do_,}lock_mount() we must make sure to call unlock_mount()
before leaving the scope.

5) all manipulations of ->m_count are gone, along with ->m_count itself.
struct mountpoint lives while its ->m_list is non-empty.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h     |   1 -
 fs/namespace.c | 186 ++++++++++++++++++++++++-------------------------
 2 files changed, 92 insertions(+), 95 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index fb93d3e16724..4355c482a841 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -44,7 +44,6 @@ struct mountpoint {
 	struct hlist_node m_hash;
 	struct dentry *m_dentry;
 	struct hlist_head m_list;
-	int m_count;
 };
 
 struct mount {
diff --git a/fs/namespace.c b/fs/namespace.c
index 5a18ba6e7df2..debc43282b26 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -910,42 +910,48 @@ bool __is_local_mountpoint(const struct dentry *dentry)
 	return is_covered;
 }
 
-static struct mountpoint *lookup_mountpoint(struct dentry *dentry)
+struct pinned_mountpoint {
+	struct hlist_node node;
+	struct mountpoint *mp;
+};
+
+static bool lookup_mountpoint(struct dentry *dentry, struct pinned_mountpoint *m)
 {
 	struct hlist_head *chain = mp_hash(dentry);
 	struct mountpoint *mp;
 
 	hlist_for_each_entry(mp, chain, m_hash) {
 		if (mp->m_dentry == dentry) {
-			mp->m_count++;
-			return mp;
+			hlist_add_head(&m->node, &mp->m_list);
+			m->mp = mp;
+			return true;
 		}
 	}
-	return NULL;
+	return false;
 }
 
-static struct mountpoint *get_mountpoint(struct dentry *dentry)
+static int get_mountpoint(struct dentry *dentry, struct pinned_mountpoint *m)
 {
-	struct mountpoint *mp, *new = NULL;
+	struct mountpoint *mp __free(kfree) = NULL;
+	bool found;
 	int ret;
 
 	if (d_mountpoint(dentry)) {
 		/* might be worth a WARN_ON() */
 		if (d_unlinked(dentry))
-			return ERR_PTR(-ENOENT);
+			return -ENOENT;
 mountpoint:
 		read_seqlock_excl(&mount_lock);
-		mp = lookup_mountpoint(dentry);
+		found = lookup_mountpoint(dentry, m);
 		read_sequnlock_excl(&mount_lock);
-		if (mp)
-			goto done;
+		if (found)
+			return 0;
 	}
 
-	if (!new)
-		new = kmalloc(sizeof(struct mountpoint), GFP_KERNEL);
-	if (!new)
-		return ERR_PTR(-ENOMEM);
-
+	if (!mp)
+		mp = kmalloc(sizeof(struct mountpoint), GFP_KERNEL);
+	if (!mp)
+		return -ENOMEM;
 
 	/* Exactly one processes may set d_mounted */
 	ret = d_set_mounted(dentry);
@@ -955,34 +961,28 @@ static struct mountpoint *get_mountpoint(struct dentry *dentry)
 		goto mountpoint;
 
 	/* The dentry is not available as a mountpoint? */
-	mp = ERR_PTR(ret);
 	if (ret)
-		goto done;
+		return ret;
 
 	/* Add the new mountpoint to the hash table */
 	read_seqlock_excl(&mount_lock);
-	new->m_dentry = dget(dentry);
-	new->m_count = 1;
-	hlist_add_head(&new->m_hash, mp_hash(dentry));
-	INIT_HLIST_HEAD(&new->m_list);
+	mp->m_dentry = dget(dentry);
+	hlist_add_head(&mp->m_hash, mp_hash(dentry));
+	INIT_HLIST_HEAD(&mp->m_list);
+	hlist_add_head(&m->node, &mp->m_list);
+	m->mp = no_free_ptr(mp);
 	read_sequnlock_excl(&mount_lock);
-
-	mp = new;
-	new = NULL;
-done:
-	kfree(new);
-	return mp;
+	return 0;
 }
 
 /*
  * vfsmount lock must be held.  Additionally, the caller is responsible
  * for serializing calls for given disposal list.
  */
-static void __put_mountpoint(struct mountpoint *mp, struct list_head *list)
+static void maybe_free_mountpoint(struct mountpoint *mp, struct list_head *list)
 {
-	if (!--mp->m_count) {
+	if (hlist_empty(&mp->m_list)) {
 		struct dentry *dentry = mp->m_dentry;
-		BUG_ON(!hlist_empty(&mp->m_list));
 		spin_lock(&dentry->d_lock);
 		dentry->d_flags &= ~DCACHE_MOUNTED;
 		spin_unlock(&dentry->d_lock);
@@ -992,10 +992,15 @@ static void __put_mountpoint(struct mountpoint *mp, struct list_head *list)
 	}
 }
 
-/* called with namespace_lock and vfsmount lock */
-static void put_mountpoint(struct mountpoint *mp)
+/*
+ * locks: mount_lock [read_seqlock_excl], namespace_sem [excl]
+ */
+static void unpin_mountpoint(struct pinned_mountpoint *m)
 {
-	__put_mountpoint(mp, &ex_mountpoints);
+	if (m->mp) {
+		hlist_del(&m->node);
+		maybe_free_mountpoint(m->mp, &ex_mountpoints);
+	}
 }
 
 static inline int check_mnt(struct mount *mnt)
@@ -1052,7 +1057,7 @@ static void __umount_mnt(struct mount *mnt, struct list_head *shrink_list)
 	hlist_del_init(&mnt->mnt_mp_list);
 	mp = mnt->mnt_mp;
 	mnt->mnt_mp = NULL;
-	__put_mountpoint(mp, shrink_list);
+	maybe_free_mountpoint(mp, shrink_list);
 }
 
 /*
@@ -1070,7 +1075,6 @@ void mnt_set_mountpoint(struct mount *mnt,
 			struct mountpoint *mp,
 			struct mount *child_mnt)
 {
-	mp->m_count++;
 	mnt_add_count(mnt, 1);	/* essentially, that's mntget */
 	child_mnt->mnt_mountpoint = mp->m_dentry;
 	child_mnt->mnt_parent = mnt;
@@ -1122,7 +1126,7 @@ void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct m
 
 	attach_mnt(mnt, parent, mp);
 
-	put_mountpoint(old_mp);
+	maybe_free_mountpoint(old_mp, &ex_mountpoints);
 	mnt_add_count(old_parent, -1);
 }
 
@@ -2030,25 +2034,24 @@ static int do_umount(struct mount *mnt, int flags)
  */
 void __detach_mounts(struct dentry *dentry)
 {
-	struct mountpoint *mp;
+	struct pinned_mountpoint mp = {};
 	struct mount *mnt;
 
 	namespace_lock();
 	lock_mount_hash();
-	mp = lookup_mountpoint(dentry);
-	if (!mp)
+	if (!lookup_mountpoint(dentry, &mp))
 		goto out_unlock;
 
 	event++;
-	while (!hlist_empty(&mp->m_list)) {
-		mnt = hlist_entry(mp->m_list.first, struct mount, mnt_mp_list);
+	while (mp.node.next) {
+		mnt = hlist_entry(mp.node.next, struct mount, mnt_mp_list);
 		if (mnt->mnt.mnt_flags & MNT_UMOUNT) {
 			umount_mnt(mnt);
 			hlist_add_head(&mnt->mnt_umount, &unmounted);
 		}
 		else umount_tree(mnt, UMOUNT_CONNECTED);
 	}
-	put_mountpoint(mp);
+	unpin_mountpoint(&mp);
 out_unlock:
 	unlock_mount_hash();
 	namespace_unlock();
@@ -2641,7 +2644,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
 	HLIST_HEAD(tree_list);
 	struct mnt_namespace *ns = dest_mnt->mnt_ns;
-	struct mountpoint *smp;
+	struct pinned_mountpoint root = {};
 	struct mountpoint *shorter = NULL;
 	struct mount *child, *p;
 	struct mount *top;
@@ -2657,9 +2660,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		if (!shorter && is_mnt_ns_file(top->mnt.mnt_root))
 			shorter = top->mnt_mp;
 	}
-	smp = get_mountpoint(top->mnt.mnt_root);
-	if (IS_ERR(smp))
-		return PTR_ERR(smp);
+	err = get_mountpoint(top->mnt.mnt_root, &root);
+	if (err)
+		return err;
 
 	/* Is there space to add these mounts to the mount namespace? */
 	if (!moving) {
@@ -2719,7 +2722,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		q = __lookup_mnt(&child->mnt_parent->mnt,
 				 child->mnt_mountpoint);
 		if (q) {
-			struct mountpoint *mp = smp;
+			struct mountpoint *mp = root.mp;
 			struct mount *r = child;
 			while (unlikely(r->overmount))
 				r = r->overmount;
@@ -2729,7 +2732,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		}
 		commit_tree(child);
 	}
-	put_mountpoint(smp);
+	unpin_mountpoint(&root);
 	unlock_mount_hash();
 
 	return 0;
@@ -2746,7 +2749,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	ns->pending_mounts = 0;
 
 	read_seqlock_excl(&mount_lock);
-	put_mountpoint(smp);
+	unpin_mountpoint(&root);
 	read_sequnlock_excl(&mount_lock);
 
 	return err;
@@ -2786,12 +2789,12 @@ static int attach_recursive_mnt(struct mount *source_mnt,
  * Return: Either the target mountpoint on the top mount or the top
  *         mount's mountpoint.
  */
-static struct mountpoint *do_lock_mount(struct path *path, bool beneath)
+static int do_lock_mount(struct path *path, struct pinned_mountpoint *pinned, bool beneath)
 {
 	struct vfsmount *mnt = path->mnt;
 	struct dentry *dentry;
-	struct mountpoint *mp = ERR_PTR(-ENOENT);
 	struct path under = {};
+	int err = -ENOENT;
 
 	for (;;) {
 		struct mount *m = real_mount(mnt);
@@ -2829,8 +2832,8 @@ static struct mountpoint *do_lock_mount(struct path *path, bool beneath)
 			path->dentry = dget(mnt->mnt_root);
 			continue;	// got overmounted
 		}
-		mp = get_mountpoint(dentry);
-		if (IS_ERR(mp))
+		err = get_mountpoint(dentry, pinned);
+		if (err)
 			break;
 		if (beneath) {
 			/*
@@ -2841,25 +2844,25 @@ static struct mountpoint *do_lock_mount(struct path *path, bool beneath)
 			 */
 			path_put(&under);
 		}
-		return mp;
+		return 0;
 	}
 	namespace_unlock();
 	inode_unlock(dentry->d_inode);
 	if (beneath)
 		path_put(&under);
-	return mp;
+	return err;
 }
 
-static inline struct mountpoint *lock_mount(struct path *path)
+static inline int lock_mount(struct path *path, struct pinned_mountpoint *m)
 {
-	return do_lock_mount(path, false);
+	return do_lock_mount(path, m, false);
 }
 
-static void unlock_mount(struct mountpoint *where)
+static void unlock_mount(struct pinned_mountpoint *m)
 {
-	inode_unlock(where->m_dentry->d_inode);
+	inode_unlock(m->mp->m_dentry->d_inode);
 	read_seqlock_excl(&mount_lock);
-	put_mountpoint(where);
+	unpin_mountpoint(m);
 	read_sequnlock_excl(&mount_lock);
 	namespace_unlock();
 }
@@ -3024,7 +3027,7 @@ static int do_loopback(struct path *path, const char *old_name,
 {
 	struct path old_path;
 	struct mount *mnt = NULL, *parent;
-	struct mountpoint *mp;
+	struct pinned_mountpoint mp = {};
 	int err;
 	if (!old_name || !*old_name)
 		return -EINVAL;
@@ -3036,11 +3039,9 @@ static int do_loopback(struct path *path, const char *old_name,
 	if (mnt_ns_loop(old_path.dentry))
 		goto out;
 
-	mp = lock_mount(path);
-	if (IS_ERR(mp)) {
-		err = PTR_ERR(mp);
+	err = lock_mount(path, &mp);
+	if (err)
 		goto out;
-	}
 
 	parent = real_mount(path->mnt);
 	if (!check_mnt(parent))
@@ -3052,14 +3053,14 @@ static int do_loopback(struct path *path, const char *old_name,
 		goto out2;
 	}
 
-	err = graft_tree(mnt, parent, mp);
+	err = graft_tree(mnt, parent, mp.mp);
 	if (err) {
 		lock_mount_hash();
 		umount_tree(mnt, UMOUNT_SYNC);
 		unlock_mount_hash();
 	}
 out2:
-	unlock_mount(mp);
+	unlock_mount(&mp);
 out:
 	path_put(&old_path);
 	return err;
@@ -3603,13 +3604,13 @@ static int do_move_mount(struct path *old_path,
 	struct mount *p;
 	struct mount *old;
 	struct mount *parent;
-	struct mountpoint *mp;
+	struct pinned_mountpoint mp;
 	int err;
 	bool beneath = flags & MNT_TREE_BENEATH;
 
-	mp = do_lock_mount(new_path, beneath);
-	if (IS_ERR(mp))
-		return PTR_ERR(mp);
+	err = do_lock_mount(new_path, &mp, beneath);
+	if (err)
+		return err;
 
 	old = real_mount(old_path->mnt);
 	p = real_mount(new_path->mnt);
@@ -3658,7 +3659,7 @@ static int do_move_mount(struct path *old_path,
 		goto out;
 
 	if (beneath) {
-		err = can_move_mount_beneath(old_path, new_path, mp);
+		err = can_move_mount_beneath(old_path, new_path, mp.mp);
 		if (err)
 			goto out;
 
@@ -3678,9 +3679,9 @@ static int do_move_mount(struct path *old_path,
 	if (mount_is_ancestor(old, p))
 		goto out;
 
-	err = attach_recursive_mnt(old, p, mp);
+	err = attach_recursive_mnt(old, p, mp.mp);
 out:
-	unlock_mount(mp);
+	unlock_mount(&mp);
 	if (!err) {
 		if (!is_anon_ns(ns)) {
 			mntput_no_expire(parent);
@@ -3750,7 +3751,7 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 			   unsigned int mnt_flags)
 {
 	struct vfsmount *mnt;
-	struct mountpoint *mp;
+	struct pinned_mountpoint mp = {};
 	struct super_block *sb = fc->root->d_sb;
 	int error;
 
@@ -3771,13 +3772,12 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 
 	mnt_warn_timestamp_expiry(mountpoint, mnt);
 
-	mp = lock_mount(mountpoint);
-	if (IS_ERR(mp)) {
-		mntput(mnt);
-		return PTR_ERR(mp);
+	error = lock_mount(mountpoint, &mp);
+	if (!error) {
+		error = do_add_mount(real_mount(mnt), mp.mp,
+				     mountpoint, mnt_flags);
+		unlock_mount(&mp);
 	}
-	error = do_add_mount(real_mount(mnt), mp, mountpoint, mnt_flags);
-	unlock_mount(mp);
 	if (error < 0)
 		mntput(mnt);
 	return error;
@@ -3845,7 +3845,7 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 int finish_automount(struct vfsmount *m, const struct path *path)
 {
 	struct dentry *dentry = path->dentry;
-	struct mountpoint *mp;
+	struct pinned_mountpoint mp = {};
 	struct mount *mnt;
 	int err;
 
@@ -3877,14 +3877,13 @@ int finish_automount(struct vfsmount *m, const struct path *path)
 		err = 0;
 		goto discard_locked;
 	}
-	mp = get_mountpoint(dentry);
-	if (IS_ERR(mp)) {
-		err = PTR_ERR(mp);
+	err = get_mountpoint(dentry, &mp);
+	if (err)
 		goto discard_locked;
-	}
 
-	err = do_add_mount(mnt, mp, path, path->mnt->mnt_flags | MNT_SHRINKABLE);
-	unlock_mount(mp);
+	err = do_add_mount(mnt, mp.mp, path,
+			   path->mnt->mnt_flags | MNT_SHRINKABLE);
+	unlock_mount(&mp);
 	if (unlikely(err))
 		goto discard;
 	return 0;
@@ -4685,7 +4684,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 {
 	struct path new, old, root;
 	struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent, *ex_parent;
-	struct mountpoint *old_mp;
+	struct pinned_mountpoint old_mp = {};
 	int error;
 
 	if (!may_mount())
@@ -4706,9 +4705,8 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 		goto out2;
 
 	get_fs_root(current->fs, &root);
-	old_mp = lock_mount(&old);
-	error = PTR_ERR(old_mp);
-	if (IS_ERR(old_mp))
+	error = lock_mount(&old, &old_mp);
+	if (error)
 		goto out3;
 
 	error = -EINVAL;
@@ -4757,7 +4755,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	umount_mnt(root_mnt);
 	mnt_add_count(root_parent, -1);
 	/* mount old root on put_old */
-	attach_mnt(root_mnt, old_mnt, old_mp);
+	attach_mnt(root_mnt, old_mnt, old_mp.mp);
 	touch_mnt_namespace(current->nsproxy->mnt_ns);
 	/* A moved mount should not expire automatically */
 	list_del_init(&new_mnt->mnt_expire);
@@ -4767,7 +4765,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	chroot_fs_refs(&root, &new);
 	error = 0;
 out4:
-	unlock_mount(old_mp);
+	unlock_mount(&old_mp);
 	if (!error)
 		mntput_no_expire(ex_parent);
 out3:
-- 
2.39.5


