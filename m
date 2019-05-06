Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42EC115208
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 18:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfEFQzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 12:55:51 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:58662 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbfEFQzu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 12:55:50 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 83EBCA109D;
        Mon,  6 May 2019 18:55:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id z2MDBo7DheqW; Mon,  6 May 2019 18:55:28 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v6 2/6] namei: O_BENEATH-style path resolution flags
Date:   Tue,  7 May 2019 02:54:35 +1000
Message-Id: <20190506165439.9155-3-cyphar@cyphar.com>
In-Reply-To: <20190506165439.9155-1-cyphar@cyphar.com>
References: <20190506165439.9155-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the following flags to allow various restrictions on path
resolution (these affect the *entire* resolution, rather than just the
final path component -- as is the case with most other AT_* flags).

The primary justification for these flags is to allow for programs to be
far more strict about how they want path resolution to handle symlinks,
mountpoint crossings, and paths that escape the dirfd (through an
absolute path or ".." shenanigans).

This is of particular concern to container runtimes that want to be very
careful about malicious root filesystems that a container's init might
have screwed around with (and there is no real way to protect against
this in userspace if you consider potential races against a malicious
container's init). More classical applications (which have their own
potentially buggy userspace path sanitisation code) include web
servers, archive extraction tools, network file servers, and so on.

These flags are exposed to userspace in a later patchset.

* LOOKUP_XDEV: Disallow mount-point crossing (both *down* into one, or
  *up* from one). The primary "scoping" use is to blocking resolution
  that crosses a bind-mount, which has a similar property to a symlink
  (in the way that it allows for escape from the starting-point). Since
  it is not possible to differentiate bind-mounts However since
  bind-mounting requires privileges (in ways symlinks don't) this has
  been split from LOOKUP_BENEATH. The naming is based on "find -xdev" as
  well as -EXDEV (though find(1) doesn't walk upwards, the semantics
  seem obvious).

* LOOKUP_NO_MAGICLINKS: Disallows ->get_link "symlink" jumping. This is
  a very specific restriction, and it exists because /proc/$pid/fd/...
  "symlinks" allow for access outside nd->root and pose risk to
  container runtimes that don't want to be tricked into accessing a host
  path (but do want to allow no-funny-business symlink resolution).

* LOOKUP_NO_SYMLINKS: Disallows symlink jumping *of any kind*. Implies
  LOOKUP_NO_MAGICLINKS (obviously).

* LOOKUP_BENEATH: Disallow "escapes" from the starting point of the
  filesystem tree during resolution (you must stay "beneath" the
  starting point at all times). Currently this is done by disallowing
  ".." and absolute paths (either in the given path or found during
  symlink resolution) entirely, as well as all "magic link" jumping.

  The wholesale banning of ".." is because it is currently not safe to
  allow ".." resolution (races can cause the path to be moved outside of
  the root -- this is conceptually similar to historical chroot(2)
  escape attacks). Future patches in this series will address this, and
  will re-enable ".." resolution once it is safe. With those patches,
  ".." resolution will only be allowed if it remains in the root
  throughout resolution (such as "a/../b" not "a/../../outside/b").

  The banning of "magic link" jumping is done because it is not clear
  whether semantically they should be allowed -- while some "magic
  links" are safe there are many that can cause escapes (and once a
  resolution is outside of the root, O_BENEATH will no longer detect
  it). Future patches may re-enable "magic link" jumping when such jumps
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

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Kees Cook <keescook@chromium.org>
Suggested-by: David Drysdale <drysdale@google.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/namei.c            | 76 ++++++++++++++++++++++++++++++++++++-------
 include/linux/namei.h |  7 ++++
 2 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2a91b72aa5e9..e13a02720a9d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -843,6 +843,12 @@ static inline void path_to_nameidata(const struct path *path,
 
 static int nd_jump_root(struct nameidata *nd)
 {
+	if (unlikely(nd->flags & LOOKUP_BENEATH))
+		return -EXDEV;
+	if (unlikely(nd->flags & LOOKUP_XDEV)) {
+		if (nd->path.mnt != nd->root.mnt)
+			return -EXDEV;
+	}
 	if (nd->flags & LOOKUP_RCU) {
 		struct dentry *d;
 		nd->path = nd->root;
@@ -1051,6 +1057,9 @@ const char *get_link(struct nameidata *nd)
 	int error;
 	const char *res;
 
+	if (unlikely(nd->flags & LOOKUP_NO_SYMLINKS))
+		return ERR_PTR(-ELOOP);
+
 	if (!(nd->flags & LOOKUP_RCU)) {
 		touch_atime(&last->link);
 		cond_resched();
@@ -1081,14 +1090,23 @@ const char *get_link(struct nameidata *nd)
 		} else {
 			res = get(dentry, inode, &last->done);
 		}
+		/* If we just jumped it was because of a procfs-style link. */
+		if (unlikely(nd->flags & LOOKUP_JUMPED)) {
+			if (unlikely(nd->flags & LOOKUP_NO_MAGICLINKS))
+				return ERR_PTR(-ELOOP);
+			/* Not currently safe. */
+			if (unlikely(nd->flags & LOOKUP_BENEATH))
+				return ERR_PTR(-EXDEV);
+		}
 		if (IS_ERR_OR_NULL(res))
 			return res;
 	}
 	if (*res == '/') {
 		if (!nd->root.mnt)
 			set_root(nd);
-		if (unlikely(nd_jump_root(nd)))
-			return ERR_PTR(-ECHILD);
+		error = nd_jump_root(nd);
+		if (unlikely(error))
+			return ERR_PTR(error);
 		while (unlikely(*++res == '/'))
 			;
 	}
@@ -1269,12 +1287,16 @@ static int follow_managed(struct path *path, struct nameidata *nd)
 		break;
 	}
 
-	if (need_mntput && path->mnt == mnt)
-		mntput(path->mnt);
+	if (need_mntput) {
+		if (path->mnt == mnt)
+			mntput(path->mnt);
+		if (unlikely(nd->flags & LOOKUP_XDEV))
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
@@ -1331,6 +1353,8 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 		mounted = __lookup_mnt(path->mnt, path->dentry);
 		if (!mounted)
 			break;
+		if (unlikely(nd->flags & LOOKUP_XDEV))
+			return false;
 		path->mnt = &mounted->mnt;
 		path->dentry = mounted->mnt.mnt_root;
 		nd->flags |= LOOKUP_JUMPED;
@@ -1351,8 +1375,11 @@ static int follow_dotdot_rcu(struct nameidata *nd)
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
@@ -1377,6 +1404,8 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 				return -ECHILD;
 			if (&mparent->mnt == nd->path.mnt)
 				break;
+			if (unlikely(nd->flags & LOOKUP_XDEV))
+				return -EXDEV;
 			/* we know that mountpoint was pinned */
 			nd->path.dentry = mountpoint;
 			nd->path.mnt = &mparent->mnt;
@@ -1391,6 +1420,8 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 			return -ECHILD;
 		if (!mounted)
 			break;
+		if (unlikely(nd->flags & LOOKUP_XDEV))
+			return -EXDEV;
 		nd->path.mnt = &mounted->mnt;
 		nd->path.dentry = mounted->mnt.mnt_root;
 		inode = nd->path.dentry->d_inode;
@@ -1479,8 +1510,11 @@ static int path_parent_directory(struct path *path)
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
@@ -1489,6 +1523,8 @@ static int follow_dotdot(struct nameidata *nd)
 		}
 		if (!follow_up(&nd->path))
 			break;
+		if (unlikely(nd->flags & LOOKUP_XDEV))
+			return -EXDEV;
 	}
 	follow_mount(&nd->path);
 	nd->inode = nd->path.dentry->d_inode;
@@ -1703,6 +1739,13 @@ static inline int may_lookup(struct nameidata *nd)
 static inline int handle_dots(struct nameidata *nd, int type)
 {
 	if (type == LAST_DOTDOT) {
+		/*
+		 * LOOKUP_BENEATH resolving ".." is not currently safe -- races can
+		 * cause our parent to have moved outside of the root and us to skip
+		 * over it.
+		 */
+		if (unlikely(nd->flags & LOOKUP_BENEATH))
+			return -EXDEV;
 		if (!nd->root.mnt)
 			set_root(nd);
 		if (nd->flags & LOOKUP_RCU) {
@@ -2251,6 +2294,15 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	nd->path.dentry = NULL;
 
 	nd->m_seq = read_seqbegin(&mount_lock);
+
+	if (unlikely(nd->flags & LOOKUP_BENEATH)) {
+		error = dirfd_path_init(nd);
+		if (unlikely(error))
+			return ERR_PTR(error);
+		nd->root = nd->path;
+		if (!(nd->flags & LOOKUP_RCU))
+			path_get(&nd->root);
+	}
 	if (*s == '/') {
 		if (likely(!nd->root.mnt))
 			set_root(nd);
@@ -2259,9 +2311,11 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			s = ERR_PTR(error);
 		return s;
 	}
-	error = dirfd_path_init(nd);
-	if (unlikely(error))
-		return ERR_PTR(error);
+	if (likely(!nd->path.mnt)) {
+		error = dirfd_path_init(nd);
+		if (unlikely(error))
+			return ERR_PTR(error);
+	}
 	return s;
 }
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 9138b4471dbf..7bc819ad0cd3 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -50,6 +50,13 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 #define LOOKUP_EMPTY		0x4000
 #define LOOKUP_DOWN		0x8000
 
+/* Scoping flags for lookup. */
+#define LOOKUP_BENEATH		0x010000 /* No escaping from starting point. */
+#define LOOKUP_XDEV		0x020000 /* No mountpoint crossing. */
+#define LOOKUP_NO_MAGICLINKS	0x040000 /* No /proc/$pid/fd/ "symlink" crossing. */
+#define LOOKUP_NO_SYMLINKS	0x080000 /* No symlink crossing *at all*.
+					    Implies LOOKUP_NO_MAGICLINKS. */
+
 extern int path_pts(struct path *path);
 
 extern int user_path_at_empty(int, const char __user *, unsigned, struct path *, int *empty);
-- 
2.21.0

