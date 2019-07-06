Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3679061187
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2019 17:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfGFPAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jul 2019 11:00:06 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:35316 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfGFPAG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jul 2019 11:00:06 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id D7E8DA018C;
        Sat,  6 Jul 2019 17:00:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id MMumB93k1MBt; Sat,  6 Jul 2019 16:59:53 +0200 (CEST)
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
Subject: [PATCH v9 06/10] namei: LOOKUP_IN_ROOT: chroot-like path resolution
Date:   Sun,  7 Jul 2019 00:57:33 +1000
Message-Id: <20190706145737.5299-7-cyphar@cyphar.com>
In-Reply-To: <20190706145737.5299-1-cyphar@cyphar.com>
References: <20190706145737.5299-1-cyphar@cyphar.com>
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

[*] At the moment, ".." and magic-link jumping are disallowed for the
    same reason it is disabled for LOOKUP_BENEATH -- currently it is not
    safe to allow it. Future patches may enable it unconditionally once
    we have resolved the possible races (for "..") and semantics (for
    magic-link jumping).

The most significant *at(2) semantic change with LOOKUP_IN_ROOT is that
absolute pathnames no longer cause dirfd to be ignored completely. The
rationale is that LOOKUP_IN_ROOT must necessarily chroot-scope symlinks
with absolute paths to dirfd, and so doing it for the base path seems to
be the most consistent behaviour (and also avoids foot-gunning users who
want to scope paths that are absolute).

[1]: https://github.com/cyphar/filepath-securejoin

Co-developed-by: Christian Brauner <christian@brauner.io>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/namei.c            | 6 +++---
 include/linux/namei.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9c3ed597466b..ff016b9e9082 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1149,7 +1149,7 @@ const char *get_link(struct nameidata *nd, bool trailing)
 			if (unlikely(nd->flags & LOOKUP_NO_MAGICLINKS))
 				return ERR_PTR(-ELOOP);
 			/* Not currently safe. */
-			if (unlikely(nd->flags & LOOKUP_BENEATH))
+			if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT)))
 				return ERR_PTR(-EXDEV);
 			/*
 			 * For trailing_symlink we check whether the symlink's
@@ -1833,7 +1833,7 @@ static inline int handle_dots(struct nameidata *nd, int type)
 		 * cause our parent to have moved outside of the root and us to skip
 		 * over it.
 		 */
-		if (unlikely(nd->flags & LOOKUP_BENEATH))
+		if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT)))
 			return -EXDEV;
 		if (!nd->root.mnt)
 			set_root(nd);
@@ -2384,7 +2384,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
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
2.22.0

