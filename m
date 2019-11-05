Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17562EF7FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 10:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387949AbfKEJIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 04:08:16 -0500
Received: from mout-p-202.mailbox.org ([80.241.56.172]:31828 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730652AbfKEJIP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:08:15 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 476kNB6hrJzQjjH;
        Tue,  5 Nov 2019 10:08:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id gm_8kwRv8N6d; Tue,  5 Nov 2019 10:08:05 +0100 (CET)
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
        Christian Brauner <christian.brauner@ubuntu.com>,
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
        Christian Brauner <christian@brauner.io>,
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
Subject: [PATCH v15 4/9] namei: LOOKUP_BENEATH: O_BENEATH-like scoped resolution
Date:   Tue,  5 Nov 2019 20:05:48 +1100
Message-Id: <20191105090553.6350-5-cyphar@cyphar.com>
In-Reply-To: <20191105090553.6350-1-cyphar@cyphar.com>
References: <20191105090553.6350-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

/* Background. */
There are many circumstances when userspace wants to resolve a path and
ensure that it doesn't go outside of a particular root directory during
resolution. Obvious examples include archive extraction tools, as well as
other security-conscious userspace programs. FreeBSD spun out O_BENEATH
from their Capsicum project[1,2], so it also seems reasonable to
implement similar functionality for Linux.

This is part of a refresh of Al's AT_NO_JUMPS patchset[3] (which was a
variation on David Drysdale's O_BENEATH patchset[4], which in turn was
based on the Capsicum project[5]).

/* Userspace API. */
LOOKUP_BENEATH will be exposed to userspace through openat2(2).

/* Semantics. */
Unlike most other LOOKUP flags (most notably LOOKUP_FOLLOW),
LOOKUP_BENEATH applies to all components of the path.

With LOOKUP_BENEATH, any path component which attempts to "escape" the
starting point of the filesystem lookup (the dirfd passed to openat)
will yield -EXDEV. Thus, all absolute paths and symlinks are disallowed.

Due to a security concern brought up by Jann[6], any ".." path
components are also blocked. This restriction will be lifted in a future
patch, but requires more work to ensure that permitting ".." is done
safely.

Magic-link jumps are also blocked, because they can beam the path lookup
across the starting point. It would be possible to detect and block
only the "bad" crossings with path_is_under() checks, but it's unclear
whether it makes sense to permit magic-links at all. However, userspace
is recommended to pass LOOKUP_NO_MAGICLINKS if they want to ensure that
magic-link crossing is entirely disabled.

/* Testing. */
LOOKUP_BENEATH is tested as part of the openat2(2) selftests.

[1]: https://reviews.freebsd.org/D2808
[2]: https://reviews.freebsd.org/D17547
[3]: https://lore.kernel.org/lkml/20170429220414.GT29622@ZenIV.linux.org.uk/
[4]: https://lore.kernel.org/lkml/1415094884-18349-1-git-send-email-drysdale@google.com/
[5]: https://lore.kernel.org/lkml/1404124096-21445-1-git-send-email-drysdale@google.com/
[6]: https://lore.kernel.org/lkml/CAG48ez1jzNvxB+bfOBnERFGp=oMM0vHWuLD6EULmne3R6xa53w@mail.gmail.com/

Cc: Christian Brauner <christian.brauner@ubuntu.com>
Suggested-by: David Drysdale <drysdale@google.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/namei.c            | 91 +++++++++++++++++++++++++++++++++++--------
 include/linux/namei.h |  4 ++
 2 files changed, 79 insertions(+), 16 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index b73ee1601bd4..54fdbdfbeb94 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -644,6 +644,14 @@ static bool legitimize_links(struct nameidata *nd)
 
 static bool legitimize_root(struct nameidata *nd)
 {
+	/*
+	 * For scoped-lookups (where nd->root has been zeroed), we need to
+	 * restart the whole lookup from scratch -- because set_root() is wrong
+	 * for these lookups (nd->dfd is the root, not the filesystem root).
+	 */
+	if (!nd->root.mnt && (nd->flags & LOOKUP_IS_SCOPED))
+		return false;
+	/* Nothing to do if nd->root is zero or is managed by the VFS user. */
 	if (!nd->root.mnt || (nd->flags & LOOKUP_ROOT))
 		return true;
 	nd->flags |= LOOKUP_ROOT_GRABBED;
@@ -779,7 +787,11 @@ static int complete_walk(struct nameidata *nd)
 	int status;
 
 	if (nd->flags & LOOKUP_RCU) {
-		if (!(nd->flags & LOOKUP_ROOT))
+		/*
+		 * We don't want to zero nd->root for scoped-lookups or
+		 * externally-managed nd->root.
+		 */
+		if (!(nd->flags & (LOOKUP_ROOT | LOOKUP_IS_SCOPED)))
 			nd->root.mnt = NULL;
 		if (unlikely(unlazy_walk(nd)))
 			return -ECHILD;
@@ -801,10 +813,18 @@ static int complete_walk(struct nameidata *nd)
 	return status;
 }
 
-static void set_root(struct nameidata *nd)
+static int set_root(struct nameidata *nd)
 {
 	struct fs_struct *fs = current->fs;
 
+	/*
+	 * Jumping to the real root in a scoped-lookup is a BUG in namei, but we
+	 * still have to ensure it doesn't happen because it will cause a breakout
+	 * from the dirfd.
+	 */
+	if (WARN_ON(nd->flags & LOOKUP_IS_SCOPED))
+		return -ENOTRECOVERABLE;
+
 	if (nd->flags & LOOKUP_RCU) {
 		unsigned seq;
 
@@ -817,6 +837,7 @@ static void set_root(struct nameidata *nd)
 		get_fs_root(fs, &nd->root);
 		nd->flags |= LOOKUP_ROOT_GRABBED;
 	}
+	return 0;
 }
 
 static void path_put_conditional(struct path *path, struct nameidata *nd)
@@ -840,11 +861,18 @@ static inline void path_to_nameidata(const struct path *path,
 
 static int nd_jump_root(struct nameidata *nd)
 {
+	if (unlikely(nd->flags & LOOKUP_BENEATH))
+		return -EXDEV;
 	if (unlikely(nd->flags & LOOKUP_NO_XDEV)) {
 		/* Absolute path arguments to path_init() are allowed. */
 		if (nd->path.mnt != NULL && nd->path.mnt != nd->root.mnt)
 			return -EXDEV;
 	}
+	if (!nd->root.mnt) {
+		int error = set_root(nd);
+		if (error)
+			return error;
+	}
 	if (nd->flags & LOOKUP_RCU) {
 		struct dentry *d;
 		nd->path = nd->root;
@@ -1096,15 +1124,17 @@ const char *get_link(struct nameidata *nd)
 				if (!nd->last_magiclink.same_mnt)
 					return ERR_PTR(-EXDEV);
 			}
+			/* Not currently safe for scoped-lookups. */
+			if (unlikely(nd->flags & LOOKUP_IS_SCOPED))
+				return ERR_PTR(-EXDEV);
 		}
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
@@ -1373,8 +1403,11 @@ static int follow_dotdot_rcu(struct nameidata *nd)
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
@@ -1505,8 +1538,11 @@ static int path_parent_directory(struct path *path)
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
@@ -1731,8 +1767,20 @@ static inline int may_lookup(struct nameidata *nd)
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
+		if (unlikely(nd->flags & LOOKUP_IS_SCOPED))
+			return -EXDEV;
+		if (!nd->root.mnt) {
+			error = set_root(nd);
+			if (error)
+				return error;
+		}
 		if (nd->flags & LOOKUP_RCU) {
 			return follow_dotdot_rcu(nd);
 		} else
@@ -2195,6 +2243,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 /* must be paired with terminate_walk() */
 static const char *path_init(struct nameidata *nd, unsigned flags)
 {
+	int error;
 	const char *s = nd->name->name;
 
 	if (!*s)
@@ -2227,11 +2276,12 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
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
@@ -2247,7 +2297,6 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			get_fs_pwd(current->fs, &nd->path);
 			nd->inode = nd->path.dentry->d_inode;
 		}
-		return s;
 	} else {
 		/* Caller must check execute permissions on the starting path component */
 		struct fd f = fdget_raw(nd->dfd);
@@ -2272,8 +2321,18 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			nd->inode = nd->path.dentry->d_inode;
 		}
 		fdput(f);
-		return s;
 	}
+	/* For scoped-lookups we need to set the root to the dirfd as well. */
+	if (flags & LOOKUP_IS_SCOPED) {
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
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 6105c8a59fc8..12f4f36835c2 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_NAMEI_H
 #define _LINUX_NAMEI_H
 
+#include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/path.h>
 #include <linux/fcntl.h>
@@ -44,6 +45,9 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 #define LOOKUP_NO_SYMLINKS	0x020000 /* No symlink crossing. */
 #define LOOKUP_NO_MAGICLINKS	0x040000 /* No /proc/$pid/fd/ "symlink" crossing. */
 #define LOOKUP_NO_XDEV		0x080000 /* No mountpoint crossing. */
+#define LOOKUP_BENEATH		0x100000 /* No escaping from starting point. */
+/* LOOKUP_* flags which do scope-related checks based on the dirfd. */
+#define LOOKUP_IS_SCOPED LOOKUP_BENEATH
 
 extern int path_pts(struct path *path);
 
-- 
2.23.0

