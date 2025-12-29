Return-Path: <linux-fsdevel+bounces-72180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 342A8CE6D1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 14:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE88D301637D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 13:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028CA288520;
	Mon, 29 Dec 2025 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX5CLR6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544811DF759
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767013423; cv=none; b=n2ZncUgs7wTZ0pXKKwyBW6EqEFuszOvcxGZDE2W48Wy/L5UYsuLp71D8tz11fgmaohE6Q7EAKYfgbe7lfq7PxrFyXRm0BWlhe7wv/DftCjGvAng0fioxt9Z4qWOB8fYHLGrHUlmZpMvn0A5r1DcKbvBXBodNvBKoqQD8D8rhmvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767013423; c=relaxed/simple;
	bh=DMgqK8M8L49mI4ywk3Nk0o4THSYJNVX0qob52eF2cgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NOCZDYZlhp2FMOgsjhFZmkNcK2KvXNdfmcnsji2KgGuJIT6bktOBTHIsx1nTZIFjZc25vyBgYNPTVuOGlVwmdiNjgYVJt5VKDFQe09LjYOe5MfHiPhoXoLA+MK73iWuKtnsOgDqfigs0HOcFBBW5XakLr6BhJRNwFTj6A96eGjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX5CLR6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2139C4AF09;
	Mon, 29 Dec 2025 13:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767013422;
	bh=DMgqK8M8L49mI4ywk3Nk0o4THSYJNVX0qob52eF2cgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HX5CLR6nuScpD71EyMwuzfggscu/ehDFh9Lmi4dlXK+hpkAHiaGmQ+xOpF1/IeAS4
	 uppeLiBJ2eZRAWME5ipPHlTNldfi9kD02iHQssQ10/P0AcdyfljqGoSrRwWmUUh7lt
	 9yNNJAVbLo0vWPttK+APrlsSeDWq2d1qvXpxAWpk2furGj2dg70PhbdG5RViiRttn1
	 xAco4M7++D/7s+8TjWKnNahXkTqTRbAT4+tsy0ctUujPzt9lizuH8i78HhpkN3tcU4
	 J462uMOQVtuUkGkNhG+gBOTerbSDEoz14ge/XPZXP92RNhjbwdcDWHVFLn+ae4SaLl
	 i1hTe7jEPXFNg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 29 Dec 2025 14:03:24 +0100
Subject: [PATCH 1/2] mount: add OPEN_TREE_NAMESPACE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-work-empty-namespace-v1-1-bfb24c7b061f@kernel.org>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
In-Reply-To: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12750; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DMgqK8M8L49mI4ywk3Nk0o4THSYJNVX0qob52eF2cgU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQG1agvP3tpe86dvU0nGyqnTdZaLNl2yyxkyR6XEsuUM
 te1+196dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkljkjQ+M1s91HDUy0eS2e
 JxlPSy1gcxbKYlTu/ygg+aPAbOmSNoZ/5lY3l7Jd22GwuDS/eqc32/45JmHhb9iFpnlaqarf8pz
 BDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When creating containers the setup usually involves using CLONE_NEWNS
via clone3() or unshare(). This copies the caller's complete mount
namespace. The runtime will also assemble a new rootfs and then use
pivot_root() to switch the old mount tree with the new rootfs. Afterward
it will recursively umount the old mount tree thereby getting rid of all
mounts.

On a basic system here where the mount table isn't particularly large
this still copies about 30 mounts. Copying all of these mounts only to
get rid of them later is pretty wasteful.

This is exacerbated if intermediary mount namespaces are used that only
exist for a very short amount of time and are immediately destroyed
again causing a ton of mounts to be copied and destroyed needlessly.

With a large mount table and a system where thousands or ten-thousands
of containers are spawned in parallel this quickly becomes a bottleneck
increasing contention on the semaphore.

Extend open_tree() with a new OPEN_TREE_NAMESPACE flag. Similar to
OPEN_TREE_CLONE only the indicated mount tree is copied. Instead of
returning a file descriptor referring to that mount tree
OPEN_TREE_NAMESPACE will cause open_tree() to return a file descriptor
to a new mount namespace. In that new mount namespace the copied mount
tree has been mounted on top of a copy of the real rootfs.

The caller can setns() into that mount namespace and perform any
additionally required setup such as move_mount() detached mounts in
there.

This allows OPEN_TREE_NAMESPACE to function as a combined
unshare(CLONE_NEWNS) and pivot_root().

A caller may for example choose to create an extremely minimal rootfs:

fd_mntns = open_tree(-EBADF, "/var/lib/containers/wootwoot", OPEN_TREE_NAMESPACE);

This will create a mount namespace where "wootwoot" has become the
rootfs mounted on top of the real rootfs. The caller can now setns()
into this new mount namespace and assemble additional mounts.

This also works with user namespaces:

unshare(CLONE_NEWUSER);
fd_mntns = open_tree(-EBADF, "/var/lib/containers/wootwoot", OPEN_TREE_NAMESPACE);

which creates a new mount namespace owned by the earlier created user
namespace with "wootwoot" as the rootfs mounted on top of the real
rootfs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/internal.h              |   1 +
 fs/namespace.c             | 155 ++++++++++++++++++++++++++++++++++++++++-----
 fs/nsfs.c                  |  13 ++++
 include/uapi/linux/mount.h |   3 +-
 4 files changed, 155 insertions(+), 17 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index ab638d41ab81..b5aad5265e0e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -247,6 +247,7 @@ extern void mnt_pin_kill(struct mount *m);
  */
 extern const struct dentry_operations ns_dentry_operations;
 int open_namespace(struct ns_common *ns);
+struct file *open_namespace_file(struct ns_common *ns);
 
 /*
  * fs/stat.c:
diff --git a/fs/namespace.c b/fs/namespace.c
index c58674a20cad..fd9698671c70 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2796,6 +2796,9 @@ static inline void unlock_mount(struct pinned_mountpoint *m)
 		__unlock_mount(m);
 }
 
+static void lock_mount_exact(const struct path *path,
+			     struct pinned_mountpoint *mp);
+
 #define LOCK_MOUNT_MAYBE_BENEATH(mp, path, beneath) \
 	struct pinned_mountpoint mp __cleanup(unlock_mount) = {}; \
 	do_lock_mount((path), &mp, (beneath))
@@ -2946,10 +2949,11 @@ static inline bool may_copy_tree(const struct path *path)
 	return check_anonymous_mnt(mnt);
 }
 
-
-static struct mount *__do_loopback(const struct path *old_path, int recurse)
+static struct mount *__do_loopback(const struct path *old_path,
+				   unsigned int flags, unsigned int copy_flags)
 {
 	struct mount *old = real_mount(old_path->mnt);
+	bool recurse = flags & AT_RECURSIVE;
 
 	if (IS_MNT_UNBINDABLE(old))
 		return ERR_PTR(-EINVAL);
@@ -2960,10 +2964,22 @@ static struct mount *__do_loopback(const struct path *old_path, int recurse)
 	if (!recurse && __has_locked_children(old, old_path->dentry))
 		return ERR_PTR(-EINVAL);
 
+	/*
+	 * When creating a new mount namespace we don't want to copy over
+	 * mounts of mount namespaces to avoid the risk of cycles and also to
+	 * minimize the default complex interdependencies between mount
+	 * namespaces.
+	 *
+	 * We could ofc just check whether all mount namespace files aren't
+	 * creating cycles but really let's keep this simple.
+	 */
+	if (!(flags & OPEN_TREE_NAMESPACE))
+		copy_flags |= CL_COPY_MNT_NS_FILE;
+
 	if (recurse)
-		return copy_tree(old, old_path->dentry, CL_COPY_MNT_NS_FILE);
-	else
-		return clone_mnt(old, old_path->dentry, 0);
+		return copy_tree(old, old_path->dentry, copy_flags);
+
+	return clone_mnt(old, old_path->dentry, copy_flags);
 }
 
 /*
@@ -2974,7 +2990,9 @@ static int do_loopback(const struct path *path, const char *old_name,
 {
 	struct path old_path __free(path_put) = {};
 	struct mount *mnt = NULL;
+	unsigned int flags = recurse ? AT_RECURSIVE : 0;
 	int err;
+
 	if (!old_name || !*old_name)
 		return -EINVAL;
 	err = kern_path(old_name, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &old_path);
@@ -2991,7 +3009,7 @@ static int do_loopback(const struct path *path, const char *old_name,
 	if (!check_mnt(mp.parent))
 		return -EINVAL;
 
-	mnt = __do_loopback(&old_path, recurse);
+	mnt = __do_loopback(&old_path, flags, 0);
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
@@ -3004,7 +3022,7 @@ static int do_loopback(const struct path *path, const char *old_name,
 	return err;
 }
 
-static struct mnt_namespace *get_detached_copy(const struct path *path, bool recursive)
+static struct mnt_namespace *get_detached_copy(const struct path *path, unsigned int flags)
 {
 	struct mnt_namespace *ns, *mnt_ns = current->nsproxy->mnt_ns, *src_mnt_ns;
 	struct user_namespace *user_ns = mnt_ns->user_ns;
@@ -3029,7 +3047,7 @@ static struct mnt_namespace *get_detached_copy(const struct path *path, bool rec
 			ns->seq_origin = src_mnt_ns->ns.ns_id;
 	}
 
-	mnt = __do_loopback(path, recursive);
+	mnt = __do_loopback(path, flags, 0);
 	if (IS_ERR(mnt)) {
 		emptied_ns = ns;
 		return ERR_CAST(mnt);
@@ -3043,9 +3061,9 @@ static struct mnt_namespace *get_detached_copy(const struct path *path, bool rec
 	return ns;
 }
 
-static struct file *open_detached_copy(struct path *path, bool recursive)
+static struct file *open_detached_copy(struct path *path, unsigned int flags)
 {
-	struct mnt_namespace *ns = get_detached_copy(path, recursive);
+	struct mnt_namespace *ns = get_detached_copy(path, flags);
 	struct file *file;
 
 	if (IS_ERR(ns))
@@ -3061,21 +3079,114 @@ static struct file *open_detached_copy(struct path *path, bool recursive)
 	return file;
 }
 
+DEFINE_FREE(put_empty_mnt_ns, struct mnt_namespace *,
+	    if (!IS_ERR_OR_NULL(_T)) free_mnt_ns(_T))
+
+static struct file *open_new_namespace(struct path *path, unsigned int flags)
+{
+	struct mnt_namespace *new_ns __free(put_empty_mnt_ns) = NULL;
+	struct path to_path __free(path_put) = {};
+	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
+	struct user_namespace *user_ns = current_user_ns();
+	struct mount *new_ns_root;
+	struct mount *mnt;
+	struct ns_common *new_ns_common;
+	unsigned int copy_flags = 0;
+	bool locked = false;
+
+	if (user_ns != ns->user_ns)
+		copy_flags |= CL_SLAVE;
+
+	new_ns = alloc_mnt_ns(user_ns, false);
+	if (IS_ERR(new_ns))
+		return ERR_CAST(new_ns);
+
+	scoped_guard(namespace_excl) {
+		new_ns_root = clone_mnt(ns->root, ns->root->mnt.mnt_root, copy_flags);
+		if (IS_ERR(new_ns_root))
+			return ERR_CAST(new_ns_root);
+
+		/*
+		 * If the real rootfs had a locked mount on top of it somewhere
+		 * in the stack, lock the new mount tree as well so it can't be
+		 * exposed.
+		 */
+		mnt = ns->root;
+		while (mnt->overmount) {
+			mnt = mnt->overmount;
+			if (mnt->mnt.mnt_flags & MNT_LOCKED)
+				locked = true;
+		}
+	}
+
+	/*
+	 * We dropped the namespace semaphore so we can actually lock
+	 * the copy for mounting. The copied mount isn't attached to any
+	 * mount namespace and it is thus excluded from any propagation.
+	 * So realistically we're isolated and the mount can't be
+	 * overmounted.
+	 */
+
+	/* Borrow the reference from clone_mnt(). */
+	to_path.mnt = &new_ns_root->mnt;
+	to_path.dentry = dget(new_ns_root->mnt.mnt_root);
+
+	/* Now lock for actual mounting. */
+	LOCK_MOUNT_EXACT(mp, &to_path);
+	if (unlikely(IS_ERR(mp.parent)))
+		return ERR_CAST(mp.parent);
+
+	/*
+	 * We don't emulate unshare()ing a mount namespace. We stick to the
+	 * restrictions of creating detached bind-mounts. It has a lot
+	 * saner and simpler semantics.
+	 */
+	mnt = __do_loopback(path, flags, copy_flags);
+	if (IS_ERR(mnt))
+		return ERR_CAST(mnt);
+
+	scoped_guard(mount_writer) {
+		if (locked)
+			mnt->mnt.mnt_flags |= MNT_LOCKED;
+		/*
+		 * Now mount the detached tree on top of the copy of the
+		 * real rootfs we created.
+		 */
+		attach_mnt(mnt, new_ns_root, mp.mp);
+		if (user_ns != ns->user_ns)
+			lock_mnt_tree(new_ns_root);
+	}
+
+	/* Add all mounts to the new namespace. */
+	for (struct mount *p = new_ns_root; p; p = next_mnt(p, new_ns_root)) {
+		mnt_add_to_ns(new_ns, p);
+		new_ns->nr_mounts++;
+	}
+
+	new_ns->root = real_mount(no_free_ptr(to_path.mnt));
+	ns_tree_add_raw(new_ns);
+	new_ns_common = to_ns_common(no_free_ptr(new_ns));
+	return open_namespace_file(new_ns_common);
+}
+
 static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned int flags)
 {
 	int ret;
 	struct path path __free(path_put) = {};
 	int lookup_flags = LOOKUP_AUTOMOUNT | LOOKUP_FOLLOW;
-	bool detached = flags & OPEN_TREE_CLONE;
 
 	BUILD_BUG_ON(OPEN_TREE_CLOEXEC != O_CLOEXEC);
 
 	if (flags & ~(AT_EMPTY_PATH | AT_NO_AUTOMOUNT | AT_RECURSIVE |
 		      AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLONE |
-		      OPEN_TREE_CLOEXEC))
+		      OPEN_TREE_CLOEXEC | OPEN_TREE_NAMESPACE))
 		return ERR_PTR(-EINVAL);
 
-	if ((flags & (AT_RECURSIVE | OPEN_TREE_CLONE)) == AT_RECURSIVE)
+	if ((flags & (AT_RECURSIVE | OPEN_TREE_CLONE | OPEN_TREE_NAMESPACE)) ==
+	    AT_RECURSIVE)
+		return ERR_PTR(-EINVAL);
+
+	if (hweight32(flags & (OPEN_TREE_CLONE | OPEN_TREE_NAMESPACE)) > 1)
 		return ERR_PTR(-EINVAL);
 
 	if (flags & AT_NO_AUTOMOUNT)
@@ -3085,15 +3196,27 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
 	if (flags & AT_EMPTY_PATH)
 		lookup_flags |= LOOKUP_EMPTY;
 
-	if (detached && !may_mount())
+	/*
+	 * If we create a new mount namespace with the cloned mount tree we
+	 * just care about being privileged over our current user namespace.
+	 * The new mount namespace will be owned by it.
+	 */
+	if ((flags & OPEN_TREE_NAMESPACE) &&
+	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
+		return ERR_PTR(-EPERM);
+
+	if ((flags & OPEN_TREE_CLONE) && !may_mount())
 		return ERR_PTR(-EPERM);
 
 	ret = user_path_at(dfd, filename, lookup_flags, &path);
 	if (unlikely(ret))
 		return ERR_PTR(ret);
 
-	if (detached)
-		return open_detached_copy(&path, flags & AT_RECURSIVE);
+	if (flags & OPEN_TREE_NAMESPACE)
+		return open_new_namespace(&path, flags);
+
+	if (flags & OPEN_TREE_CLONE)
+		return open_detached_copy(&path, flags);
 
 	return dentry_open(&path, O_PATH, current_cred());
 }
diff --git a/fs/nsfs.c b/fs/nsfs.c
index bf27d5da91f1..db91de208645 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -99,6 +99,19 @@ int ns_get_path(struct path *path, struct task_struct *task,
 	return ns_get_path_cb(path, ns_get_path_task, &args);
 }
 
+struct file *open_namespace_file(struct ns_common *ns)
+{
+	struct path path __free(path_put) = {};
+	int err;
+
+	/* call first to consume reference */
+	err = path_from_stashed(&ns->stashed, nsfs_mnt, ns, &path);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	return dentry_open(&path, O_RDONLY, current_cred());
+}
+
 /**
  * open_namespace - open a namespace
  * @ns: the namespace to open
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 5d3f8c9e3a62..acbc22241c9c 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -61,7 +61,8 @@
 /*
  * open_tree() flags.
  */
-#define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
+#define OPEN_TREE_CLONE		(1 << 0)	/* Clone the target tree and attach the clone */
+#define OPEN_TREE_NAMESPACE	(1 << 1)	/* Clone the target tree into a new mount namespace */
 #define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
 
 /*

-- 
2.47.3


