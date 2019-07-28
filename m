Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E5277CE9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2019 03:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbfG1BHd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jul 2019 21:07:33 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:48640 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729005AbfG1BHd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jul 2019 21:07:33 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 9AA3B425D0;
        Sun, 28 Jul 2019 03:07:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id RHHYCCgowNYg; Sun, 28 Jul 2019 03:07:20 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH v11 5/8] namei: LOOKUP_IN_ROOT: chroot-like path resolution
Date:   Sun, 28 Jul 2019 11:02:04 +1000
Message-Id: <20190728010207.9781-6-cyphar@cyphar.com>
In-Reply-To: <20190728010207.9781-1-cyphar@cyphar.com>
References: <20190728010207.9781-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The primary motivation for the need for this flag is container runtimes
which have to interact with malicious root filesystems in the host
namespaces. One of the first requirements for a container runtime to be
secure against a malicious rootfs is that they correctly scope symlinks
(that is, they should be scoped as though they are chroot(2)ed into the
container's rootfs) and ".."-style paths[*]. The already-existing
LOOKUP_NO_XDEV and LOOKUP_NO_MAGICLINKS help defend against other
potential attacks in a malicious rootfs scenario.

Currently most container runtimes try to do this resolution in
userspace[1], causing many potential race conditions. In addition, the
"obvious" alternative (actually performing a {ch,pivot_}root(2))
requires a fork+exec (for some runtimes) which is *very* costly if
necessary for every filesystem operation involving a container.

[*] At the moment, ".." and magic-link jumping are disallowed for the
    same reason it is disabled for LOOKUP_BENEATH -- currently it is not
    safe to allow it. Future patches may enable it unconditionally once
    we have resolved the possible races (for "..") and semantics (for
    magic-link jumping).

The most significant *at(2) semantic change with LOOKUP_IN_ROOT is that
absolute pathnames no longer cause the dirfd to be ignored completely.

The rationale is that LOOKUP_IN_ROOT must necessarily chroot-scope
symlinks with absolute paths to dirfd, and so doing it for the base path
seems to be the most consistent behaviour (and also avoids foot-gunning
users who want to scope paths that are absolute).

[1]: https://github.com/cyphar/filepath-securejoin

Suggested-by: Christian Brauner <christian@brauner.io>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/namei.c            | 41 +++++++++++++++++++++++++++++++----------
 include/linux/namei.h |  1 +
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2e18ce5a313e..0352d275bd13 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -676,7 +676,7 @@ static int unlazy_walk(struct nameidata *nd)
 		goto out1;
 	if (!nd->root.mnt) {
 		/* Restart from path_init() if nd->root was cleared. */
-		if (nd->flags & LOOKUP_BENEATH)
+		if (nd->flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT))
 			goto out;
 	} else if (!(nd->flags & LOOKUP_ROOT)) {
 		if (unlikely(!legitimize_path(nd, &nd->root, nd->root_seq)))
@@ -809,10 +809,18 @@ static int complete_walk(struct nameidata *nd)
 	return status;
 }
 
-static void set_root(struct nameidata *nd)
+static int set_root(struct nameidata *nd)
 {
 	struct fs_struct *fs = current->fs;
 
+	/*
+	 * Jumping to the real root as part of LOOKUP_IN_ROOT is a BUG in namei,
+	 * but we still have to ensure it doesn't happen because it will cause a
+	 * breakout from the dirfd.
+	 */
+	if (WARN_ON(nd->flags & LOOKUP_IN_ROOT))
+		return -ENOTRECOVERABLE;
+
 	if (nd->flags & LOOKUP_RCU) {
 		unsigned seq;
 
@@ -824,6 +832,7 @@ static void set_root(struct nameidata *nd)
 	} else {
 		get_fs_root(fs, &nd->root);
 	}
+	return 0;
 }
 
 static void path_put_conditional(struct path *path, struct nameidata *nd)
@@ -854,6 +863,11 @@ static int nd_jump_root(struct nameidata *nd)
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
@@ -1100,15 +1114,13 @@ const char *get_link(struct nameidata *nd)
 			if (unlikely(nd->flags & LOOKUP_NO_MAGICLINKS))
 				return ERR_PTR(-ELOOP);
 			/* Not currently safe. */
-			if (unlikely(nd->flags & LOOKUP_BENEATH))
+			if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT)))
 				return ERR_PTR(-EXDEV);
 		}
 		if (IS_ERR_OR_NULL(res))
 			return res;
 	}
 	if (*res == '/') {
-		if (!nd->root.mnt)
-			set_root(nd);
 		error = nd_jump_root(nd);
 		if (unlikely(error))
 			return ERR_PTR(error);
@@ -1744,15 +1756,20 @@ static inline int may_lookup(struct nameidata *nd)
 static inline int handle_dots(struct nameidata *nd, int type)
 {
 	if (type == LAST_DOTDOT) {
+		int error = 0;
+
 		/*
 		 * LOOKUP_BENEATH resolving ".." is not currently safe -- races
 		 * can cause our parent to have moved outside of the root and
 		 * us to skip over it.
 		 */
-		if (unlikely(nd->flags & LOOKUP_BENEATH))
+		if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT)))
 			return -EXDEV;
-		if (!nd->root.mnt)
-			set_root(nd);
+		if (!nd->root.mnt) {
+			error = set_root(nd);
+			if (error)
+				return error;
+		}
 		if (nd->flags & LOOKUP_RCU) {
 			return follow_dotdot_rcu(nd);
 		} else
@@ -2251,9 +2268,13 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 	nd->m_seq = read_seqbegin(&mount_lock);
 
+	/* LOOKUP_IN_ROOT treats absolute paths as being relative-to-dirfd. */
+	if (flags & LOOKUP_IN_ROOT)
+		while (*s == '/')
+			s++;
+
 	/* Figure out the starting path and root (if needed). */
 	if (*s == '/') {
-		set_root(nd);
 		error = nd_jump_root(nd);
 		if (unlikely(error))
 			return ERR_PTR(error);
@@ -2298,7 +2319,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		fdput(f);
 	}
 	/* For scoped-lookups we need to set the root to the dirfd as well. */
-	if (flags & LOOKUP_BENEATH) {
+	if (flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT)) {
 		nd->root = nd->path;
 		if (flags & LOOKUP_RCU)
 			nd->root_seq = nd->seq;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index be407415c28a..ec2c6c588ea7 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -57,6 +57,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 #define LOOKUP_NO_MAGICLINKS	0x080000 /* No /proc/$pid/fd/ "symlink" crossing. */
 #define LOOKUP_NO_SYMLINKS	0x100000 /* No symlink crossing *at all*.
 					    Implies LOOKUP_NO_MAGICLINKS. */
+#define LOOKUP_IN_ROOT		0x200000 /* Treat dirfd as %current->fs->root. */
 
 extern int path_pts(struct path *path);
 
-- 
2.22.0

