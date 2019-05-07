Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82D6A1683D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 18:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfEGQoZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 12:44:25 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:61234 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfEGQoY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 12:44:24 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 0397A4D72B;
        Tue,  7 May 2019 18:44:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id IyNO8Fiw78fC; Tue,  7 May 2019 18:44:09 +0200 (CEST)
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
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v7 3/5] namei: LOOKUP_IN_ROOT: chroot-like path resolution
Date:   Wed,  8 May 2019 02:43:15 +1000
Message-Id: <20190507164317.13562-4-cyphar@cyphar.com>
In-Reply-To: <20190507164317.13562-1-cyphar@cyphar.com>
References: <20190507164317.13562-1-cyphar@cyphar.com>
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
LOOKUP_XDEV and LOOKUP_NO_MAGICLINKS help defend against other potential
attacks in a malicious rootfs scenario.

Currently most container runtimes try to do this resolution in
userspace[1], causing many potential race conditions. In addition, the
"obvious" alternative (actually performing a {ch,pivot_}root(2))
requires a fork+exec (for some runtimes) which is *very* costly if
necessary for every filesystem operation involving a container.

[*] At the moment, ".." and "magic link" jumping are disallowed for the
    same reason it is disabled for LOOKUP_BENEATH -- currently it is not
    safe to allow it. Future patches may enable it unconditionally once
    we have resolved the possible races (for "..") and semantics (for
    "magic link" jumping).

The most significant openat(2) semantic change with LOOKUP_IN_ROOT is
that absolute pathnames no longer cause dirfd to be ignored completely.
The rationale is that LOOKUP_IN_ROOT must necessarily chroot-scope
symlinks with absolute paths to dirfd, and so doing it for the base path
seems to be the most consistent behaviour (and also avoids foot-gunning
users who want to scope paths that are absolute).

[1]: https://github.com/cyphar/filepath-securejoin

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/namei.c            | 6 +++---
 include/linux/namei.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e13a02720a9d..3a3cba593b85 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1095,7 +1095,7 @@ const char *get_link(struct nameidata *nd)
 			if (unlikely(nd->flags & LOOKUP_NO_MAGICLINKS))
 				return ERR_PTR(-ELOOP);
 			/* Not currently safe. */
-			if (unlikely(nd->flags & LOOKUP_BENEATH))
+			if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT)))
 				return ERR_PTR(-EXDEV);
 		}
 		if (IS_ERR_OR_NULL(res))
@@ -1744,7 +1744,7 @@ static inline int handle_dots(struct nameidata *nd, int type)
 		 * cause our parent to have moved outside of the root and us to skip
 		 * over it.
 		 */
-		if (unlikely(nd->flags & LOOKUP_BENEATH))
+		if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT)))
 			return -EXDEV;
 		if (!nd->root.mnt)
 			set_root(nd);
@@ -2295,7 +2295,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 	nd->m_seq = read_seqbegin(&mount_lock);
 
-	if (unlikely(nd->flags & LOOKUP_BENEATH)) {
+	if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT))) {
 		error = dirfd_path_init(nd);
 		if (unlikely(error))
 			return ERR_PTR(error);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 7bc819ad0cd3..4b1ee717cb14 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -56,6 +56,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 #define LOOKUP_NO_MAGICLINKS	0x040000 /* No /proc/$pid/fd/ "symlink" crossing. */
 #define LOOKUP_NO_SYMLINKS	0x080000 /* No symlink crossing *at all*.
 					    Implies LOOKUP_NO_MAGICLINKS. */
+#define LOOKUP_IN_ROOT		0x100000 /* Treat dirfd as %current->fs->root. */
 
 extern int path_pts(struct path *path);
 
-- 
2.21.0

