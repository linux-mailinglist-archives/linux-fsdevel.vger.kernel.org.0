Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1BE1852FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgCMX6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:58:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49998 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgCMXyA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:00 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7r-00B6ZV-0n; Fri, 13 Mar 2020 23:53:59 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 14/69] step_into() callers: dismiss the symlink earlier
Date:   Fri, 13 Mar 2020 23:53:02 +0000
Message-Id: <20200313235357.2646756-14-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
References: <20200313235303.GP23230@ZenIV.linux.org.uk>
 <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

We need to dismiss a symlink when we are done traversing it;
currently that's done when we call step_into() for its last
component.  For the cases when we do not call step_into()
for that component (i.e. when it's . or ..) we do the same
symlink dismissal after the call of handle_dots().

What we need to guarantee is that the symlink won't be dismissed
while we are still using nd->last.name - it's pointing into the
body of said symlink.  step_into() is sufficiently late - by
the time it's called we'd already obtained the dentry, so the
name we'd been looking up is no longer needed.  However, it
turns out to be cleaner to have that ("we are done with that
component now, can dismiss the link") done explicitly - in the
callers of step_into().

In handle_dots() case we won't be using the component string
at all, so for . and .. the corresponding point is actually
_before_ the call of handle_dots(), not after it.

Fix a minor irregularity in do_last(), while we are at it -
if trailing symlink ended with . or .. we forgot to dismiss
it.  Not a problem, since nameidata is about to be done with
(neither . nor .. can be a trailing symlink, so this is the
last iteration through the loop) and terminate_walk() will
clean the stack anyway, but let's keep it more regular.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 84ce7ccd944e..3097edcb4a1a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1838,8 +1838,6 @@ enum {WALK_FOLLOW = 1, WALK_MORE = 2};
 static inline int step_into(struct nameidata *nd, struct path *path,
 			    int flags, struct inode *inode, unsigned seq)
 {
-	if (!(flags & WALK_MORE) && nd->depth)
-		put_link(nd);
 	if (likely(!d_is_symlink(path->dentry)) ||
 	   !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW)) {
 		/* not a symlink or should not follow */
@@ -1869,9 +1867,9 @@ static int walk_component(struct nameidata *nd, int flags)
 	 * parent relationships.
 	 */
 	if (unlikely(nd->last_type != LAST_NORM)) {
-		err = handle_dots(nd, nd->last_type);
 		if (!(flags & WALK_MORE) && nd->depth)
 			put_link(nd);
+		err = handle_dots(nd, nd->last_type);
 		return err;
 	}
 	dentry = lookup_fast(nd, &inode, &seq);
@@ -1882,6 +1880,8 @@ static int walk_component(struct nameidata *nd, int flags)
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 	}
+	if (!(flags & WALK_MORE) && nd->depth)
+		put_link(nd);
 
 	err = handle_mounts(nd, dentry, &path, &inode, &seq);
 	if (unlikely(err < 0))
@@ -3291,6 +3291,8 @@ static int do_last(struct nameidata *nd,
 	nd->flags |= op->intent;
 
 	if (nd->last_type != LAST_NORM) {
+		if (nd->depth)
+			put_link(nd);
 		error = handle_dots(nd, nd->last_type);
 		if (unlikely(error))
 			return error;
@@ -3382,6 +3384,8 @@ static int do_last(struct nameidata *nd,
 	}
 
 finish_lookup:
+	if (nd->depth)
+		put_link(nd);
 	error = handle_mounts(nd, dentry, &path, &inode, &seq);
 	if (unlikely(error < 0))
 		return error;
-- 
2.11.0

