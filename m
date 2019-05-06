Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6BE1520E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 18:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfEFQ4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 12:56:04 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:59248 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfEFQ4E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 12:56:04 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 7B83DA0AED;
        Mon,  6 May 2019 18:56:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id cCMuw5rMncnT; Mon,  6 May 2019 18:55:48 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v6 4/6] namei: aggressively check for nd->root escape on ".." resolution
Date:   Tue,  7 May 2019 02:54:37 +1000
Message-Id: <20190506165439.9155-5-cyphar@cyphar.com>
In-Reply-To: <20190506165439.9155-1-cyphar@cyphar.com>
References: <20190506165439.9155-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch allows for O_BENEATH and O_THISROOT to safely permit ".."
resolution (in the case of O_BENEATH the resolution will still fail if
".." resolution would resolve a path outside of the root -- while
O_THISROOT will chroot(2)-style scope it). "magic link" jumps are still
disallowed entirely because now they could result in inconsistent
behaviour if resolution encounters a subsequent "..".

The need for this patch is explained by observing there is a fairly
easy-to-exploit race condition with chroot(2) (and thus by extension
O_THISROOT and O_BENEATH) where a rename(2) of a path can be used to
"skip over" nd->root and thus escape to the filesystem above nd->root.

  thread1 [attacker]:
    for (;;)
      renameat2(AT_FDCWD, "/a/b/c", AT_FDCWD, "/a/d", RENAME_EXCHANGE);
  thread2 [victim]:
    for (;;)
      openat(dirb, "b/c/../../etc/shadow", O_THISROOT);

With fairly significant regularity, thread2 will resolve to
"/etc/shadow" rather than "/a/b/etc/shadow". There is also a similar
(though somewhat more privileged) attack using MS_MOVE.

With this patch, such cases will be detected *during* ".." resolution
(which is the weak point of chroot(2) -- since walking *into* a
subdirectory tautologically cannot result in you walking *outside*
nd->root -- except through a bind-mount or "magic link"). By detecting
this at ".." resolution (rather than checking only at the end of the
entire resolution) we can both correct escapes by jumping back to the
root (in the case of O_THISROOT), as well as avoid revealing to
attackers the structure of the filesystem outside of the root (through
timing attacks for instance).

In order to avoid a quadratic lookup with each ".." entry, we only
activate the slow path if a write through &rename_lock or &mount_lock
have occurred during path resolution (&rename_lock and &mount_lock are
re-taken to further optimise the lookup). Since the primary attack being
protected against is MS_MOVE or rename(2), not doing additional checks
unless a mount or rename have occurred avoids making the common case
slow.

The use of path_is_under() here might seem suspect, but on further
inspection of the most important race (a path was *inside* the root but
is now *outside*), there appears to be no attack potential. If
path_is_under() occurs before the rename, then the path will be resolved
but since the path was originally inside the root there is no escape.
Subsequent ".." jumps are guaranteed to check path_is_under() (by
construction, &rename_lock or &mount_lock must have been taken by the
attacker after path_is_under() returned in the victim), and thus will
not be able to escape from the previously-inside-root path. Walking down
is still safe since the entire subtree was moved (either by rename(2) or
MS_MOVE) and because (as discussed above) walking down is safe.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/namei.c | 48 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3a3cba593b85..2b6a1bf4e745 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -491,7 +491,7 @@ struct nameidata {
 	struct path	root;
 	struct inode	*inode; /* path.dentry.d_inode */
 	unsigned int	flags;
-	unsigned	seq, m_seq;
+	unsigned	seq, m_seq, r_seq;
 	int		last_type;
 	unsigned	depth;
 	int		total_link_count;
@@ -1739,19 +1739,35 @@ static inline int may_lookup(struct nameidata *nd)
 static inline int handle_dots(struct nameidata *nd, int type)
 {
 	if (type == LAST_DOTDOT) {
-		/*
-		 * LOOKUP_BENEATH resolving ".." is not currently safe -- races can
-		 * cause our parent to have moved outside of the root and us to skip
-		 * over it.
-		 */
-		if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT)))
-			return -EXDEV;
+		int error = 0;
+
 		if (!nd->root.mnt)
 			set_root(nd);
-		if (nd->flags & LOOKUP_RCU) {
-			return follow_dotdot_rcu(nd);
-		} else
-			return follow_dotdot(nd);
+		if (nd->flags & LOOKUP_RCU)
+			error = follow_dotdot_rcu(nd);
+		else
+			error = follow_dotdot(nd);
+		if (error)
+			return error;
+
+		if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT))) {
+			bool m_retry = read_seqretry(&mount_lock, nd->m_seq);
+			bool r_retry = read_seqretry(&rename_lock, nd->r_seq);
+
+			/*
+			 * Don't bother checking unless there's a racing
+			 * rename(2) or MS_MOVE.
+			 */
+			if (likely(!m_retry && !r_retry))
+				return 0;
+
+			if (m_retry && !(nd->flags & LOOKUP_RCU))
+				nd->m_seq = read_seqbegin(&mount_lock);
+			if (r_retry)
+				nd->r_seq = read_seqbegin(&rename_lock);
+			if (!path_is_under(&nd->path, &nd->root))
+				return -EXDEV;
+		}
 	}
 	return 0;
 }
@@ -2272,6 +2288,11 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
 	nd->flags = flags | LOOKUP_JUMPED | LOOKUP_PARENT;
 	nd->depth = 0;
+
+	nd->m_seq = read_seqbegin(&mount_lock);
+	if (unlikely(flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT)))
+		nd->r_seq = read_seqbegin(&rename_lock);
+
 	if (flags & LOOKUP_ROOT) {
 		struct dentry *root = nd->root.dentry;
 		struct inode *inode = root->d_inode;
@@ -2282,7 +2303,6 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		if (flags & LOOKUP_RCU) {
 			nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
 			nd->root_seq = nd->seq;
-			nd->m_seq = read_seqbegin(&mount_lock);
 		} else {
 			path_get(&nd->path);
 		}
@@ -2293,8 +2313,6 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	nd->path.mnt = NULL;
 	nd->path.dentry = NULL;
 
-	nd->m_seq = read_seqbegin(&mount_lock);
-
 	if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT))) {
 		error = dirfd_path_init(nd);
 		if (unlikely(error))
-- 
2.21.0

