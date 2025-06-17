Return-Path: <linux-fsdevel+bounces-51978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B32ADDDD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 23:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B173B1E38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 21:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC60C2F004D;
	Tue, 17 Jun 2025 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SDyvE7QZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB49527CCC4
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195138; cv=none; b=nQ7YXXPcXwPx+5LuOLR0DcWJa7e7gDkp8igJthY4Qdu/bbWeO+xa1bXvVtYJkfjUz2umVqI6VvsTHQLdWhvzlompdWFtlGkh7DXpCfw31b13HDxMmHQ22+efziW9M08FKaPgIOZNVng4DFmwT95Km9mAgssfRrkKxBj0WGX/UE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195138; c=relaxed/simple;
	bh=BLouMaNibfyPxr1qQVKZTrhvVG2aJj1uK6S4hNrk9Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qg8r1Z9efcyXXKbpqdMvuYvl76quLesDTBAdrjZC4HhNNCa+iuE84ZJusYHF+YT3ydXQ1lTlVQABdd29K5egZJAuAdnzg3lSQNgH5QT8NC8tdtgC4nSUAyx2vqCUNyOXPgwyCJ2be/h2YNBQlZGAnh3wnjysrU3MirZb99m4b+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SDyvE7QZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YppkFbGFHSBYgaatltcd3yaQODZUpmHPfK2fhwwbAoU=; b=SDyvE7QZTZiS0/fL0tpVCo5d6H
	G6aX+A+7SyksI6RXgHhkw9/f10SBHA1YlRPpK/NN0wGvPYqNqmqH1DQbH6YnEHV1x66nI86LQYuSI
	VXRKIrNAIbd2QcgrIwANo04iu2jbrLST6hD1M6j2etTQWeAHgTNENFiJOSM+atllg2uhxVKxuIOpM
	gAKFpS1/JdIv8Xi3Ztp+EazhyIzeBU+lQciXp6EllveKhBgkJ9O16VTJlrn4tkREaMzjLAm3V7o4i
	8qHSSJjrg0CTuo3cva9H0E1hTKUl96o0mMKW9TWdMdhC3CygSH2/ya7wD/0LCK5R0foDMiDxRC6ap
	ZSs4pOCA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRdhj-00000000yit-3BUs;
	Tue, 17 Jun 2025 21:18:52 +0000
Date: Tue, 17 Jun 2025 22:18:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH][RFC] replace collect_mounts()/drop_collected_mounts() with
 safer variant
Message-ID: <20250617211851.GA223162@ZenIV>
References: <20250515114150.GA3221059@ZenIV>
 <20250515114749.GB3221059@ZenIV>
 <20250516052139.GA4080802@ZenIV>
 <CAHk-=wi1r1QFu=mfr75VtsCpx3xw_uy5yMZaCz2Cyxg0fQh4hg@mail.gmail.com>
 <20250519213508.GA2023217@ZenIV>
 <20250520075317.GB2023217@ZenIV>
 <87y0uqlvxs.fsf@email.froward.int.ebiederm.org>
 <20250520231854.GF2023217@ZenIV>
 <20250521023219.GA1309405@ZenIV>
 <20250617041754.GA1591763@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617041754.GA1591763@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

collect_mounts() has several problems - one can't iterate over the results
directly, so it has to be done with callback passed to iterate_mounts();
it also has oopsable race with d_invalidate(); it also creates temporary
clones of mounts invisibly for sync umount (IOW, you can have umount return
with filesystem not mounted in any other locations and yet have it still
busy as umount(2) returns).

A saner approach is to give caller an array of struct path that would pin
every mount in a subtree, without cloning any mounts.

	* collect_mounts()/drop_collected_mounts()/iterate_mounts() is gone
	* collect_paths(where, preallocated, size) gives either ERR_PTR(-E...) or
a pointer to array of struct path, one for each chunk of tree visible under
'where' (i.e. the first element is a copy of where, followed by (mount,root)
for everything mounted under it - the same set collect_mounts() would give).
Unlike collect_mounts(), the mounts are *not* cloned - we just get (pinning)
references to roots of subtree in the caller's namespaces.
	Array is terminated by {NULL, NULL} struct path.  If it fits into
preallocated array (on-stack, normally), that's where it goes; otherwise
it's allocated by kmalloc_array().  Passing 0 as size means that 'preallocated'
is ignored (and expected to be NULL).
	* drop_collected_paths(paths, preallocated) is given the array returned
by collect_paths() and the preallocated array used passed to the same.  All
mount/dentry references are dropped and array is kfree'd if it's not equal to
'preallocated'.
	* instead of iterate_mounts(), users should just iterate over array
of struct path - nothing exotic is needed for that.  Existing users (all in
audit_tree.c) are converted.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index bb95e5102916..aafbcd0a1c8f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2280,21 +2280,62 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
 	return dst_mnt;
 }
 
-/* Caller should check returned pointer for errors */
+static inline bool extend_array(struct path **res, struct path **to_free,
+				unsigned n, unsigned *count, unsigned new_count)
+{
+	struct path *p;
+
+	if (likely(n < *count))
+		return true;
+	p = kmalloc_array(new_count, sizeof(struct path), GFP_KERNEL);
+	if (p && *count)
+		memcpy(p, *res, *count * sizeof(struct path));
+	*count = new_count;
+	kfree(*to_free);
+	*to_free = *res = p;
+	return p;
+}
 
-struct vfsmount *collect_mounts(const struct path *path)
+struct path *collect_paths(const struct path *path,
+			      struct path *prealloc, unsigned count)
 {
-	struct mount *tree;
-	namespace_lock();
-	if (!check_mnt(real_mount(path->mnt)))
-		tree = ERR_PTR(-EINVAL);
-	else
-		tree = copy_tree(real_mount(path->mnt), path->dentry,
-				 CL_COPY_ALL | CL_PRIVATE);
-	namespace_unlock();
-	if (IS_ERR(tree))
-		return ERR_CAST(tree);
-	return &tree->mnt;
+	struct mount *root = real_mount(path->mnt);
+	struct mount *child;
+	struct path *res = prealloc, *to_free = NULL;
+	unsigned n = 0;
+
+	guard(rwsem_read)(&namespace_sem);
+
+	if (!check_mnt(root))
+		return ERR_PTR(-EINVAL);
+	if (!extend_array(&res, &to_free, 0, &count, 32))
+		return ERR_PTR(-ENOMEM);
+	res[n++] = *path;
+	list_for_each_entry(child, &root->mnt_mounts, mnt_child) {
+		if (!is_subdir(child->mnt_mountpoint, path->dentry))
+			continue;
+		for (struct mount *m = child; m; m = next_mnt(m, child)) {
+			if (!extend_array(&res, &to_free, n, &count, 2 * count))
+				return ERR_PTR(-ENOMEM);
+			res[n].mnt = &m->mnt;
+			res[n].dentry = m->mnt.mnt_root;
+			n++;
+		}
+	}
+	if (!extend_array(&res, &to_free, n, &count, count + 1))
+		return ERR_PTR(-ENOMEM);
+	memset(res + n, 0, (count - n) * sizeof(struct path));
+	for (struct path *p = res; p->mnt; p++)
+		path_get(p);
+	return res;
+}
+
+void drop_collected_paths(struct path *paths, struct path *prealloc)
+{
+	for (struct path *p = paths; p->mnt; p++)
+		path_put(p);
+	if (paths != prealloc)
+		kfree(paths);
 }
 
 static void free_mnt_ns(struct mnt_namespace *);
@@ -2335,15 +2376,6 @@ void dissolve_on_fput(struct vfsmount *mnt)
 	free_mnt_ns(ns);
 }
 
-void drop_collected_mounts(struct vfsmount *mnt)
-{
-	namespace_lock();
-	lock_mount_hash();
-	umount_tree(real_mount(mnt), 0);
-	unlock_mount_hash();
-	namespace_unlock();
-}
-
 static bool __has_locked_children(struct mount *mnt, struct dentry *dentry)
 {
 	struct mount *child;
@@ -2443,21 +2475,6 @@ struct vfsmount *clone_private_mount(const struct path *path)
 }
 EXPORT_SYMBOL_GPL(clone_private_mount);
 
-int iterate_mounts(int (*f)(struct vfsmount *, void *), void *arg,
-		   struct vfsmount *root)
-{
-	struct mount *mnt;
-	int res = f(root, arg);
-	if (res)
-		return res;
-	list_for_each_entry(mnt, &real_mount(root)->mnt_list, mnt_list) {
-		res = f(&mnt->mnt, arg);
-		if (res)
-			return res;
-	}
-	return 0;
-}
-
 static void lock_mnt_tree(struct mount *mnt)
 {
 	struct mount *p;
@@ -6138,7 +6155,11 @@ void put_mnt_ns(struct mnt_namespace *ns)
 {
 	if (!refcount_dec_and_test(&ns->ns.count))
 		return;
-	drop_collected_mounts(&ns->root->mnt);
+	namespace_lock();
+	lock_mount_hash();
+	umount_tree(ns->root, 0);
+	unlock_mount_hash();
+	namespace_unlock();
 	free_mnt_ns(ns);
 }
 
diff --git a/fs/pnode.h b/fs/pnode.h
index bfc10c095cbf..04f1ac53aa49 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -28,8 +28,6 @@
 #define CL_SHARED_TO_SLAVE	0x20
 #define CL_COPY_MNT_NS_FILE	0x40
 
-#define CL_COPY_ALL		(CL_COPY_UNBINDABLE | CL_COPY_MNT_NS_FILE)
-
 static inline void set_mnt_shared(struct mount *mnt)
 {
 	mnt->mnt.mnt_flags &= ~MNT_SHARED_MASK;
diff --git a/include/linux/mount.h b/include/linux/mount.h
index cae7324650b6..65fa8442c00a 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -118,10 +118,8 @@ extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
 int do_mount(const char *, const char __user *,
 		     const char *, unsigned long, void *);
-extern struct vfsmount *collect_mounts(const struct path *);
-extern void drop_collected_mounts(struct vfsmount *);
-extern int iterate_mounts(int (*)(struct vfsmount *, void *), void *,
-			  struct vfsmount *);
+extern struct path *collect_paths(const struct path *, struct path *, unsigned);
+extern void drop_collected_paths(struct path *, struct path *);
 extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int num);
 
 extern int cifs_root_data(char **dev, char **opts);
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index f2f38903b2fe..68e042ae93c7 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -668,12 +668,6 @@ int audit_remove_tree_rule(struct audit_krule *rule)
 	return 0;
 }
 
-static int compare_root(struct vfsmount *mnt, void *arg)
-{
-	return inode_to_key(d_backing_inode(mnt->mnt_root)) ==
-	       (unsigned long)arg;
-}
-
 void audit_trim_trees(void)
 {
 	struct list_head cursor;
@@ -683,8 +677,9 @@ void audit_trim_trees(void)
 	while (cursor.next != &tree_list) {
 		struct audit_tree *tree;
 		struct path path;
-		struct vfsmount *root_mnt;
 		struct audit_node *node;
+		struct path *paths;
+		struct path array[16];
 		int err;
 
 		tree = container_of(cursor.next, struct audit_tree, list);
@@ -696,9 +691,9 @@ void audit_trim_trees(void)
 		if (err)
 			goto skip_it;
 
-		root_mnt = collect_mounts(&path);
+		paths = collect_paths(&path, array, 16);
 		path_put(&path);
-		if (IS_ERR(root_mnt))
+		if (IS_ERR(paths))
 			goto skip_it;
 
 		spin_lock(&hash_lock);
@@ -706,14 +701,17 @@ void audit_trim_trees(void)
 			struct audit_chunk *chunk = find_chunk(node);
 			/* this could be NULL if the watch is dying else where... */
 			node->index |= 1U<<31;
-			if (iterate_mounts(compare_root,
-					   (void *)(chunk->key),
-					   root_mnt))
-				node->index &= ~(1U<<31);
+			for (struct path *p = paths; p->dentry; p++) {
+				struct inode *inode = p->dentry->d_inode;
+				if (inode_to_key(inode) == chunk->key) {
+					node->index &= ~(1U<<31);
+					break;
+				}
+			}
 		}
 		spin_unlock(&hash_lock);
 		trim_marked(tree);
-		drop_collected_mounts(root_mnt);
+		drop_collected_paths(paths, array);
 skip_it:
 		put_tree(tree);
 		mutex_lock(&audit_filter_mutex);
@@ -742,9 +740,14 @@ void audit_put_tree(struct audit_tree *tree)
 	put_tree(tree);
 }
 
-static int tag_mount(struct vfsmount *mnt, void *arg)
+static int tag_mounts(struct path *paths, struct audit_tree *tree)
 {
-	return tag_chunk(d_backing_inode(mnt->mnt_root), arg);
+	for (struct path *p = paths; p->dentry; p++) {
+		int err = tag_chunk(p->dentry->d_inode, tree);
+		if (err)
+			return err;
+	}
+	return 0;
 }
 
 /*
@@ -801,7 +804,8 @@ int audit_add_tree_rule(struct audit_krule *rule)
 {
 	struct audit_tree *seed = rule->tree, *tree;
 	struct path path;
-	struct vfsmount *mnt;
+	struct path array[16];
+	struct path *paths;
 	int err;
 
 	rule->tree = NULL;
@@ -828,16 +832,16 @@ int audit_add_tree_rule(struct audit_krule *rule)
 	err = kern_path(tree->pathname, 0, &path);
 	if (err)
 		goto Err;
-	mnt = collect_mounts(&path);
+	paths = collect_paths(paths, array, 16);
 	path_put(&path);
-	if (IS_ERR(mnt)) {
-		err = PTR_ERR(mnt);
+	if (IS_ERR(paths)) {
+		err = PTR_ERR(paths);
 		goto Err;
 	}
 
 	get_tree(tree);
-	err = iterate_mounts(tag_mount, tree, mnt);
-	drop_collected_mounts(mnt);
+	err = tag_mounts(paths, tree);
+	drop_collected_paths(paths, array);
 
 	if (!err) {
 		struct audit_node *node;
@@ -872,20 +876,21 @@ int audit_tag_tree(char *old, char *new)
 	struct list_head cursor, barrier;
 	int failed = 0;
 	struct path path1, path2;
-	struct vfsmount *tagged;
+	struct path array[16];
+	struct path *paths;
 	int err;
 
 	err = kern_path(new, 0, &path2);
 	if (err)
 		return err;
-	tagged = collect_mounts(&path2);
+	paths = collect_paths(&path2, array, 16);
 	path_put(&path2);
-	if (IS_ERR(tagged))
-		return PTR_ERR(tagged);
+	if (IS_ERR(paths))
+		return PTR_ERR(paths);
 
 	err = kern_path(old, 0, &path1);
 	if (err) {
-		drop_collected_mounts(tagged);
+		drop_collected_paths(paths, array);
 		return err;
 	}
 
@@ -914,7 +919,7 @@ int audit_tag_tree(char *old, char *new)
 			continue;
 		}
 
-		failed = iterate_mounts(tag_mount, tree, tagged);
+		failed = tag_mounts(paths, tree);
 		if (failed) {
 			put_tree(tree);
 			mutex_lock(&audit_filter_mutex);
@@ -955,7 +960,7 @@ int audit_tag_tree(char *old, char *new)
 	list_del(&cursor);
 	mutex_unlock(&audit_filter_mutex);
 	path_put(&path1);
-	drop_collected_mounts(tagged);
+	drop_collected_paths(paths, array);
 	return failed;
 }
 

