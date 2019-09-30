Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13018C27B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 23:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbfI3VDR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 17:03:17 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:16404 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729964AbfI3VDR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:03:17 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 58C41A1934;
        Mon, 30 Sep 2019 20:35:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id 9E6exVSR4p2p; Mon, 30 Sep 2019 20:35:51 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH v13 4/9] namei: O_BENEATH-style path resolution flags
Date:   Tue,  1 Oct 2019 04:33:11 +1000
Message-Id: <20190930183316.10190-5-cyphar@cyphar.com>
In-Reply-To: <20190930183316.10190-1-cyphar@cyphar.com>
References: <20190930183316.10190-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the following flags to allow various restrictions on path resolution
(these affect the *entire* resolution, rather than just the final path
component -- as is the case with LOOKUP_FOLLOW).

The primary justification for these flags is to allow for programs to be
far more strict about how they want path resolution to handle symlinks,
mountpoint crossings, and paths that escape the dirfd (through an
absolute path or ".." shenanigans).

This is of particular concern to container runtimes that want to be very
careful about malicious root filesystems that a container's init might
have screwed around with (and there is no real way to protect against
this in userspace if you consider potential races against a malicious
container's init). More classical applications (which have their own
potentially buggy userspace path sanitisation code) include web servers,
archive extraction tools, network file servers, and so on.

These flags are exposed to userspace through openat2(2) in a later
patchset.

* LOOKUP_NO_XDEV: Disallow mount-point crossing (both *down* into one,
  or *up* from one). Both bind-mounts and cross-filesystem mounts are
  blocked by this flag. The naming is based on "find -xdev" as well as
  -EXDEV (though find(1) doesn't walk upwards, the semantics seem
  obvious).

* LOOKUP_NO_MAGICLINKS: Disallows ->get_link "symlink" (or rather,
  magic-link) jumping. This is a very specific restriction, and it
  exists because /proc/$pid/fd/... "symlinks" allow for access outside
  nd->root and pose risk to container runtimes that don't want to be
  tricked into accessing a host path (but do want to allow
  no-funny-business symlink resolution).

* LOOKUP_NO_SYMLINKS: Disallows resolution through symlinks of any kind
  (including magic-links).

* LOOKUP_BENEATH: Disallow "escapes" from the starting point of the
  filesystem tree during resolution (you must stay "beneath" the
  starting point at all times). Currently this is done by disallowing
  ".." and absolute paths (either in the given path or found during
  symlink resolution) entirely, as well as all magic-link jumping.

  The wholesale banning of ".." is because it is currently not safe to
  allow ".." resolution (races can cause the path to be moved outside of
  the root -- this is conceptually similar to historical chroot(2)
  escape attacks). Future patches in this series will address this, and
  will re-enable ".." resolution once it is safe. With those patches,
  ".." resolution will only be allowed if it remains in the root
  throughout resolution (such as "a/../b" not "a/../../outside/b").

  The banning of magic-link jumping is done because it is not clear
  whether semantically they should be allowed -- while some magic-links
  are safe there are many that can cause escapes (and once a
  resolution is outside of the root, O_BENEATH will no longer detect
  it). Future patches may re-enable magic-link jumping when such jumps
  would remain inside the root.

The LOOKUP_NO_*LINK flags return -ELOOP if path resolution would
violates their requirement, while the others all return -EXDEV.

This is a refresh of Al's AT_NO_JUMPS patchset[1] (which was a variation
on David Drysdale's O_BENEATH patchset[2], which in turn was based on
the Capsicum project[3]). Input from Linus and Andy in the AT_NO_JUMPS
thread[4] determined most of the API changes made in this refresh.

[1]: https://lwn.net/Articles/721443/
[2]: https://lwn.net/Articles/619151/
[3]: https://lwn.net/Articles/603929/
[4]: https://lwn.net/Articles/723057/

Cc: Christian Brauner <christian@brauner.io>
Suggested-by: David Drysdale <drysdale@google.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/namei.c            | 135 ++++++++++++++++++++++++++++++++++--------
 include/linux/namei.h |   9 +++
 2 files changed, 120 insertions(+), 24 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index bfeac55b23b7..b80efc0ae0f3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -504,7 +504,10 @@ struct nameidata {
 	struct filename	*name;
 	struct nameidata *saved;
 	struct inode	*link_inode;
-	umode_t last_magiclink_mode;
+	struct {
+		umode_t mode;
+		bool same_mnt;
+	} last_magiclink;
 	unsigned	root_seq;
 	int		dfd;
 } __randomize_layout;
@@ -642,6 +645,13 @@ static bool legitimize_links(struct nameidata *nd)
 
 static bool legitimize_root(struct nameidata *nd)
 {
+	/*
+	 * If nd->root was zeroed with scoped-lookup flags, we need to restart
+	 * the whole lookup from scratch (get_fs_root() is dangerous for these
+	 * lookups because the root is nd->dfd, not the fs root).
+	 */
+	if (!nd->root.mnt && (nd->flags & LOOKUP_DIRFD_SCOPE_FLAGS))
+		return false;
 	if (!nd->root.mnt || (nd->flags & LOOKUP_ROOT))
 		return true;
 	nd->flags |= LOOKUP_ROOT_GRABBED;
@@ -799,10 +809,18 @@ static int complete_walk(struct nameidata *nd)
 	return status;
 }
 
-static void set_root(struct nameidata *nd)
+static int set_root(struct nameidata *nd)
 {
 	struct fs_struct *fs = current->fs;
 
+	/*
+	 * Jumping to the real root with O_BENEATH-style lookup flags is a BUG in
+	 * namei, but we still have to ensure it doesn't happen because it will
+	 * cause a breakout from the dirfd.
+	 */
+	if (WARN_ON(nd->flags & LOOKUP_DIRFD_SCOPE_FLAGS))
+		return -ENOTRECOVERABLE;
+
 	if (nd->flags & LOOKUP_RCU) {
 		unsigned seq;
 
@@ -815,6 +833,7 @@ static void set_root(struct nameidata *nd)
 		get_fs_root(fs, &nd->root);
 		nd->flags |= LOOKUP_ROOT_GRABBED;
 	}
+	return 0;
 }
 
 static void path_put_conditional(struct path *path, struct nameidata *nd)
@@ -838,6 +857,18 @@ static inline void path_to_nameidata(const struct path *path,
 
 static int nd_jump_root(struct nameidata *nd)
 {
+	if (unlikely(nd->flags & LOOKUP_BENEATH))
+		return -EXDEV;
+	if (unlikely(nd->flags & LOOKUP_NO_XDEV)) {
+		/* Absolute path arguments to path_init() are allowed. */
+		if (nd->path.mnt != NULL && nd->path.mnt != nd->root.mnt)
+			return -EXDEV;
+	}
+	if (!nd->root.mnt) {
+		int error = set_root(nd);
+		if (error)
+			return error;
+	}
 	if (nd->flags & LOOKUP_RCU) {
 		struct dentry *d;
 		nd->path = nd->root;
@@ -863,12 +894,14 @@ static int nd_jump_root(struct nameidata *nd)
 void nd_jump_link(struct path *path, umode_t mode)
 {
 	struct nameidata *nd = current->nameidata;
+
+	nd->last_magiclink.mode = mode;
+	nd->last_magiclink.same_mnt = (nd->path.mnt == path->mnt);
 	path_put(&nd->path);
 
 	nd->path = *path;
 	nd->inode = nd->path.dentry->d_inode;
 	nd->flags |= LOOKUP_JUMPED | LOOKUP_MAGICLINK_JUMPED;
-	nd->last_magiclink_mode = mode;
 }
 
 static inline void put_link(struct nameidata *nd)
@@ -1047,6 +1080,9 @@ const char *get_link(struct nameidata *nd)
 	int error;
 	const char *res;
 
+	if (unlikely(nd->flags & LOOKUP_NO_SYMLINKS))
+		return ERR_PTR(-ELOOP);
+
 	if (!(nd->flags & LOOKUP_RCU)) {
 		touch_atime(&last->link);
 		cond_resched();
@@ -1078,14 +1114,24 @@ const char *get_link(struct nameidata *nd)
 		} else {
 			res = get(dentry, inode, &last->done);
 		}
+		if (nd->flags & LOOKUP_MAGICLINK_JUMPED) {
+			if (unlikely(nd->flags & LOOKUP_NO_MAGICLINKS))
+				return ERR_PTR(-ELOOP);
+			if (unlikely(nd->flags & LOOKUP_NO_XDEV)) {
+				if (!nd->last_magiclink.same_mnt)
+					return ERR_PTR(-EXDEV);
+			}
+			/* Not currently safe for scoped-lookups. */
+			if (unlikely(nd->flags & LOOKUP_DIRFD_SCOPE_FLAGS))
+				return ERR_PTR(-EXDEV);
+		}
 		if (IS_ERR_OR_NULL(res))
 			return res;
 	}
 	if (*res == '/') {
-		if (!nd->root.mnt)
-			set_root(nd);
-		if (unlikely(nd_jump_root(nd)))
-			return ERR_PTR(-ECHILD);
+		error = nd_jump_root(nd);
+		if (unlikely(error))
+			return ERR_PTR(error);
 		while (unlikely(*++res == '/'))
 			;
 	}
@@ -1266,12 +1312,16 @@ static int follow_managed(struct path *path, struct nameidata *nd)
 		break;
 	}
 
-	if (need_mntput && path->mnt == mnt)
-		mntput(path->mnt);
+	if (need_mntput) {
+		if (path->mnt == mnt)
+			mntput(path->mnt);
+		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+			ret = -EXDEV;
+		else
+			nd->flags |= LOOKUP_JUMPED;
+	}
 	if (ret == -EISDIR || !ret)
 		ret = 1;
-	if (need_mntput)
-		nd->flags |= LOOKUP_JUMPED;
 	if (unlikely(ret < 0))
 		path_put_conditional(path, nd);
 	return ret;
@@ -1328,6 +1378,8 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 		mounted = __lookup_mnt(path->mnt, path->dentry);
 		if (!mounted)
 			break;
+		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+			return false;
 		path->mnt = &mounted->mnt;
 		path->dentry = mounted->mnt.mnt_root;
 		nd->flags |= LOOKUP_JUMPED;
@@ -1348,8 +1400,11 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 	struct inode *inode = nd->inode;
 
 	while (1) {
-		if (path_equal(&nd->path, &nd->root))
+		if (path_equal(&nd->path, &nd->root)) {
+			if (unlikely(nd->flags & LOOKUP_BENEATH))
+				return -EXDEV;
 			break;
+		}
 		if (nd->path.dentry != nd->path.mnt->mnt_root) {
 			struct dentry *old = nd->path.dentry;
 			struct dentry *parent = old->d_parent;
@@ -1374,6 +1429,8 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 				return -ECHILD;
 			if (&mparent->mnt == nd->path.mnt)
 				break;
+			if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+				return -EXDEV;
 			/* we know that mountpoint was pinned */
 			nd->path.dentry = mountpoint;
 			nd->path.mnt = &mparent->mnt;
@@ -1388,6 +1445,8 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 			return -ECHILD;
 		if (!mounted)
 			break;
+		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+			return -EXDEV;
 		nd->path.mnt = &mounted->mnt;
 		nd->path.dentry = mounted->mnt.mnt_root;
 		inode = nd->path.dentry->d_inode;
@@ -1476,8 +1535,11 @@ static int path_parent_directory(struct path *path)
 static int follow_dotdot(struct nameidata *nd)
 {
 	while(1) {
-		if (path_equal(&nd->path, &nd->root))
+		if (path_equal(&nd->path, &nd->root)) {
+			if (unlikely(nd->flags & LOOKUP_BENEATH))
+				return -EXDEV;
 			break;
+		}
 		if (nd->path.dentry != nd->path.mnt->mnt_root) {
 			int ret = path_parent_directory(&nd->path);
 			if (ret)
@@ -1486,6 +1548,8 @@ static int follow_dotdot(struct nameidata *nd)
 		}
 		if (!follow_up(&nd->path))
 			break;
+		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+			return -EXDEV;
 	}
 	follow_mount(&nd->path);
 	nd->inode = nd->path.dentry->d_inode;
@@ -1700,8 +1764,20 @@ static inline int may_lookup(struct nameidata *nd)
 static inline int handle_dots(struct nameidata *nd, int type)
 {
 	if (type == LAST_DOTDOT) {
-		if (!nd->root.mnt)
-			set_root(nd);
+		int error = 0;
+
+		/*
+		 * Scoped-lookup flags resolving ".." is not currently safe --
+		 * races can cause our parent to have moved outside of the root
+		 * and us to skip over it.
+		 */
+		if (unlikely(nd->flags & LOOKUP_DIRFD_SCOPE_FLAGS))
+			return -EXDEV;
+		if (!nd->root.mnt) {
+			error = set_root(nd);
+			if (error)
+				return error;
+		}
 		if (nd->flags & LOOKUP_RCU) {
 			return follow_dotdot_rcu(nd);
 		} else
@@ -2164,6 +2240,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 /* must be paired with terminate_walk() */
 static const char *path_init(struct nameidata *nd, unsigned flags)
 {
+	int error;
 	const char *s = nd->name->name;
 
 	if (!*s)
@@ -2196,11 +2273,12 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	nd->path.dentry = NULL;
 
 	nd->m_seq = read_seqbegin(&mount_lock);
+
+	/* Figure out the starting path and root (if needed). */
 	if (*s == '/') {
-		set_root(nd);
-		if (likely(!nd_jump_root(nd)))
-			return s;
-		return ERR_PTR(-ECHILD);
+		error = nd_jump_root(nd);
+		if (unlikely(error))
+			return ERR_PTR(error);
 	} else if (nd->dfd == AT_FDCWD) {
 		if (flags & LOOKUP_RCU) {
 			struct fs_struct *fs = current->fs;
@@ -2216,7 +2294,6 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			get_fs_pwd(current->fs, &nd->path);
 			nd->inode = nd->path.dentry->d_inode;
 		}
-		return s;
 	} else {
 		/* Caller must check execute permissions on the starting path component */
 		struct fd f = fdget_raw(nd->dfd);
@@ -2241,8 +2318,18 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			nd->inode = nd->path.dentry->d_inode;
 		}
 		fdput(f);
-		return s;
 	}
+	/* For scoped-lookups we need to set the root to the dirfd as well. */
+	if (flags & LOOKUP_DIRFD_SCOPE_FLAGS) {
+		nd->root = nd->path;
+		if (flags & LOOKUP_RCU) {
+			nd->root_seq = nd->seq;
+		} else {
+			path_get(&nd->root);
+			nd->flags |= LOOKUP_ROOT_GRABBED;
+		}
+	}
+	return s;
 }
 
 static const char *trailing_symlink(struct nameidata *nd)
@@ -3550,16 +3637,16 @@ static int trailing_magiclink(struct nameidata *nd, int acc_mode,
 		return 0;
 
 	/*
-	 * Figure out the upgrade-mask of nd->last_magiclink_mode (which was
+	 * Figure out the upgrade-mask of nd->last_magiclink.mode (which was
 	 * stashed away during the jump with nd_jump_link()).
 	 *
 	 * Since these aren't strictly POSIX semantics we don't do an
 	 * acl_permission_check() here, so we only care that at least one bit
 	 * is set for each upgrade-mode.
 	 */
-	if (nd->last_magiclink_mode & S_IRUGO)
+	if (nd->last_magiclink.mode & S_IRUGO)
 		upgrade_mask |= FMODE_PATH_READ;
-	if (nd->last_magiclink_mode & S_IWUGO)
+	if (nd->last_magiclink.mode & S_IWUGO)
 		upgrade_mask |= FMODE_PATH_WRITE;
 	/* Restrict the O_PATH upgrade-mask of the caller. */
 	if (opath_mask)
diff --git a/include/linux/namei.h b/include/linux/namei.h
index d1b9048fe0f1..88b610ca4d83 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -42,6 +42,15 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 #define LOOKUP_DOWN		0x8000
 #define LOOKUP_MAGICLINK_JUMPED	0x10000
 
+/* Scoping flags for lookup. */
+#define LOOKUP_BENEATH		0x020000 /* No escaping from starting point. */
+#define LOOKUP_NO_XDEV		0x040000 /* No mountpoint crossing. */
+#define LOOKUP_NO_MAGICLINKS	0x080000 /* No /proc/$pid/fd/ "symlink" crossing. */
+#define LOOKUP_NO_SYMLINKS	0x100000 /* No symlink crossing *at all*.
+					    Implies LOOKUP_NO_MAGICLINKS. */
+/* LOOKUP_* flags which do scope-related checks based on the dirfd. */
+#define LOOKUP_DIRFD_SCOPE_FLAGS LOOKUP_BENEATH
+
 extern int path_pts(struct path *path);
 
 extern int user_path_at_empty(int, const char __user *, unsigned, struct path *, int *empty);
-- 
2.23.0

