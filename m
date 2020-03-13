Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 099531852A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgCMXzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:55:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50166 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgCMXyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7x-00B6ds-33; Fri, 13 Mar 2020 23:54:05 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 56/69] pick_link(): more straightforward handling of allocation failures
Date:   Fri, 13 Mar 2020 23:53:44 +0000
Message-Id: <20200313235357.2646756-56-viro@ZenIV.linux.org.uk>
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

pick_link() needs to push onto stack; we start with using two-element
array embedded into struct nameidata and the first time we need
more than that we switch to separately allocated array.

Allocation can fail, of course, and handling of that would be simple
enough - we need to drop 'link' and bugger off.  However, the things
get more complicated in RCU mode.  There we must do GFP_ATOMIC
allocation.  If that fails, we try to switch to non-RCU mode and
repeat the allocation.

To switch to non-RCU mode we need to grab references to 'link' and
to everything in nameidata.  The latter done by unlazy_walk();
the former - legitimize_path().  'link' must go first - after
unlazy_walk() we are out of RCU-critical period and it's too
late to call legitimize_path() since the references in link->mnt
and link->dentry might be pointing to freed and reused memory.

So we do legitimize_path(), then unlazy_walk().  And that's where
it gets too subtle: what to do if the former fails?  We MUST
do path_put(link) to avoid leaks.  And we can't do that under
rcu_read_lock().  Solution in mainline was to empty then nameidata
manually, drop out of RCU mode and then do put_path().

In effect, we open-code the things eventual terminate_walk()
would've done on error in RCU mode.  That looks badly out of place
and confusing.  We could add a comment along the lines of the
explanation above, but... there's a simpler solution.  Call
unlazy_walk() even if legitimaze_path() fails.  It will take
us out of RCU mode, so we'll be able to do path_put(link).

Yes, it will do unnecessary work - attempt to grab references
on the stuff in nameidata, only to have them dropped as soon
as we return the error to upper layer and get terminate_walk()
called there.  So what?  We are thoroughly off the fast path
by that point - we had GFP_ATOMIC allocation fail, we had
->d_seq or mount_lock mismatch and we are about to try walking
the same path from scratch in non-RCU mode.  Which will need
to do the same allocation, this time with GFP_KERNEL, so it will
be able to apply memory pressure for blocking stuff.

Compared to that the cost of several lockref_get_not_dead()
is noise.  And the logics become much easier to understand
that way.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index fc946d6f02d6..a2b5dbe432d6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1612,14 +1612,13 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 	error = nd_alloc_stack(nd);
 	if (unlikely(error)) {
 		if (error == -ECHILD) {
-			if (unlikely(!legitimize_path(nd, link, seq))) {
-				drop_links(nd);
-				nd->depth = 0;
-				nd->flags &= ~LOOKUP_RCU;
-				nd->path.mnt = NULL;
-				nd->path.dentry = NULL;
-				rcu_read_unlock();
-			} else if (likely(unlazy_walk(nd)) == 0)
+			// we must grab link first
+			bool grabbed_link = legitimize_path(nd, link, seq);
+			// ... and we must unlazy to be able to clean up
+			error = unlazy_walk(nd);
+			if (unlikely(!grabbed_link))
+				error = -ECHILD;
+			if (!error)
 				error = nd_alloc_stack(nd);
 		}
 		if (error) {
-- 
2.11.0

