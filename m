Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1962D7CBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 18:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394553AbgLKRVp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 12:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393483AbgLKRVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:21:41 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0320CC0613D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 09:21:00 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knm6A-000asj-6e; Fri, 11 Dec 2020 17:20:54 +0000
Date:   Fri, 11 Dec 2020 17:20:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
Message-ID: <20201211172054.GX3579531@ZenIV.linux.org.uk>
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-2-axboe@kernel.dk>
 <CAHk-=wif32e=MvP-rNn9wL9wXinrL1FK6OQ6xPMtuQ2VQTxvqw@mail.gmail.com>
 <139ecda1-bb08-b1f2-655f-eeb9976e8cff@kernel.dk>
 <20201211024553.GW3579531@ZenIV.linux.org.uk>
 <89f96b42-9d58-cd46-e157-758e91269d89@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89f96b42-9d58-cd46-e157-758e91269d89@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 11, 2020 at 09:05:26AM -0700, Jens Axboe wrote:

> > Finally, I really wonder what is that for; if you are in conditions when
> > you really don't want to risk going to sleep, you do *NOT* want to
> > do mnt_want_write().  Or ->open().  Or truncate().  Or, for Cthulhu
> > sake, IMA hash calculation.
> 
> I just want to do the RCU side lookup, that is all. That's my fast path.
> If that doesn't work, then we'll go through the motions of pushing this
> to a context that allows blocking open.

Explain, please.  What's the difference between blocking in a lookup and
blocking in truncate?  Either your call site is fine with a potentially
long sleep, or it is not; I don't understand what makes one source of
that behaviour different from another.

"Fast path" in context like "we can't sleep here, but often enough we
won't need to; here's a function that will bail out rather than blocking,
let's call that and go through offload to helper thread in rare case
when it does bail out" does make sense; what you are proposing to do
here is rather different and AFAICS saying "that's my fast path" is
meaningless here.

I really do not understand what it is that you are trying to achieve;
fastpath lookup part would be usable on its own, but mixed with
the rest of do_open() (as well as the open_last_lookups(), BTW)
it does not give the caller any useful warranties.

Theoretically it could be amended into something usable, but you
would need to make do_open(), open_last_lookups() (as well as
do_tmpfile()) honour your flag, with similar warranties provided
to caller.

AFAICS, without that part it is pretty much worthless.  And details
of what you are going to do in the missing bits *do* matter - unlike the
pathwalk side (which is trivial) it has potential for being very
messy.  I want to see _that_ before we commit to going there, and
a user-visible flag to openat2() makes a very strong commitment.

PS: just to make sure we are on the same page - O_NDELAY will *NOT*
suffice here.  I apologize if that's obvious to you, but I think
it's worth spelling out explicitly.

PPS: regarding unlazy_walk() change...  If we go that way, I would
probably changed the name to "try_to_unlazy" and inverted the meaning
of return value.  0 for success, -E... for failure is fine, but
false for success, true for failure is asking for recurring confusion.
IOW, I would rather do something like (completely untested)
diff --git a/fs/namei.c b/fs/namei.c
index d4a6dd772303..5abd1de11306 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -669,17 +669,17 @@ static bool legitimize_root(struct nameidata *nd)
  */
 
 /**
- * unlazy_walk - try to switch to ref-walk mode.
+ * try_to_unlazy - try to switch to ref-walk mode.
  * @nd: nameidata pathwalk data
- * Returns: 0 on success, -ECHILD on failure
+ * Returns: true on success, false on failure
  *
- * unlazy_walk attempts to legitimize the current nd->path and nd->root
+ * try_to_unlazy attempts to legitimize the current nd->path and nd->root
  * for ref-walk mode.
  * Must be called from rcu-walk context.
- * Nothing should touch nameidata between unlazy_walk() failure and
+ * Nothing should touch nameidata between try_to_unlazy() failure and
  * terminate_walk().
  */
-static int unlazy_walk(struct nameidata *nd)
+static bool try_to_unlazy(struct nameidata *nd)
 {
 	struct dentry *parent = nd->path.dentry;
 
@@ -694,14 +694,14 @@ static int unlazy_walk(struct nameidata *nd)
 		goto out;
 	rcu_read_unlock();
 	BUG_ON(nd->inode != parent->d_inode);
-	return 0;
+	return true;
 
 out1:
 	nd->path.mnt = NULL;
 	nd->path.dentry = NULL;
 out:
 	rcu_read_unlock();
-	return -ECHILD;
+	return false;
 }
 
 /**
@@ -792,7 +792,7 @@ static int complete_walk(struct nameidata *nd)
 		 */
 		if (!(nd->flags & (LOOKUP_ROOT | LOOKUP_IS_SCOPED)))
 			nd->root.mnt = NULL;
-		if (unlikely(unlazy_walk(nd)))
+		if (unlikely(!try_to_unlazy(nd)))
 			return -ECHILD;
 	}
 
@@ -1466,7 +1466,7 @@ static struct dentry *lookup_fast(struct nameidata *nd,
 		unsigned seq;
 		dentry = __d_lookup_rcu(parent, &nd->last, &seq);
 		if (unlikely(!dentry)) {
-			if (unlazy_walk(nd))
+			if (!try_to_unlazy(nd))
 				return ERR_PTR(-ECHILD);
 			return NULL;
 		}
@@ -1567,10 +1567,8 @@ static inline int may_lookup(struct nameidata *nd)
 {
 	if (nd->flags & LOOKUP_RCU) {
 		int err = inode_permission(nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
-		if (err != -ECHILD)
+		if (err != -ECHILD || !try_to_unlazy(nd))
 			return err;
-		if (unlazy_walk(nd))
-			return -ECHILD;
 	}
 	return inode_permission(nd->inode, MAY_EXEC);
 }
@@ -1592,7 +1590,7 @@ static int reserve_stack(struct nameidata *nd, struct path *link, unsigned seq)
 		// unlazy even if we fail to grab the link - cleanup needs it
 		bool grabbed_link = legitimize_path(nd, link, seq);
 
-		if (unlazy_walk(nd) != 0 || !grabbed_link)
+		if (!try_to_unlazy(nd) || !grabbed_link)
 			return -ECHILD;
 
 		if (nd_alloc_stack(nd))
@@ -1634,7 +1632,7 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 		touch_atime(&last->link);
 		cond_resched();
 	} else if (atime_needs_update(&last->link, inode)) {
-		if (unlikely(unlazy_walk(nd)))
+		if (unlikely(!try_to_unlazy(nd)))
 			return ERR_PTR(-ECHILD);
 		touch_atime(&last->link);
 	}
@@ -1651,11 +1649,8 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 		get = inode->i_op->get_link;
 		if (nd->flags & LOOKUP_RCU) {
 			res = get(NULL, inode, &last->done);
-			if (res == ERR_PTR(-ECHILD)) {
-				if (unlikely(unlazy_walk(nd)))
-					return ERR_PTR(-ECHILD);
+			if (res == ERR_PTR(-ECHILD) && try_to_unlazy(nd))
 				res = get(link->dentry, inode, &last->done);
-			}
 		} else {
 			res = get(link->dentry, inode, &last->done);
 		}
@@ -2193,7 +2188,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		}
 		if (unlikely(!d_can_lookup(nd->path.dentry))) {
 			if (nd->flags & LOOKUP_RCU) {
-				if (unlazy_walk(nd))
+				if (!try_to_unlazy(nd))
 					return -ECHILD;
 			}
 			return -ENOTDIR;
@@ -3127,7 +3122,6 @@ static const char *open_last_lookups(struct nameidata *nd,
 	struct inode *inode;
 	struct dentry *dentry;
 	const char *res;
-	int error;
 
 	nd->flags |= op->intent;
 
@@ -3151,9 +3145,8 @@ static const char *open_last_lookups(struct nameidata *nd,
 	} else {
 		/* create side of things */
 		if (nd->flags & LOOKUP_RCU) {
-			error = unlazy_walk(nd);
-			if (unlikely(error))
-				return ERR_PTR(error);
+			if (unlikely(!try_to_unlazy(nd)))
+				return ERR_PTR(-ECHILD);
 		}
 		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
 		/* trailing slashes? */
@@ -3162,8 +3155,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 	}
 
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
-		error = mnt_want_write(nd->path.mnt);
-		if (!error)
+		if (!mnt_want_write(nd->path.mnt))
 			got_write = true;
 		/*
 		 * do _not_ fail yet - we might not need that or fail with
