Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 540EF169A64
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 23:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgBWWHt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 17:07:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:34946 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgBWWHs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 17:07:48 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5zPf-0003GM-9F; Sun, 23 Feb 2020 22:07:47 +0000
Date:   Sun, 23 Feb 2020 22:07:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 14/34] new step_into() flag: WALK_NOFOLLOW
Message-ID: <20200223220747.GZ23230@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
 <20200223011626.4103706-14-viro@ZenIV.linux.org.uk>
 <CAHk-=whzmY4RdkqtitWVB=OJvHG-8_VLZrU1oXBX8b+5qJKBag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whzmY4RdkqtitWVB=OJvHG-8_VLZrU1oXBX8b+5qJKBag@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 22, 2020 at 06:14:45PM -0800, Linus Torvalds wrote:
> On Sat, Feb 22, 2020 at 5:20 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         if (likely(!d_is_symlink(path->dentry)) ||
> > -          !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW)) {
> > +          !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW) ||
> > +          flags & WALK_NOFOLLOW) {
> 
> Humor me, and don't mix bitwise ops with logical boolean ops without
> parentheses, ok?
> 
> And yes, the old code did it too, so it's not a new thing.
> 
> But as it gets even more complex, let's just generally strive for doing
> 
>    (a & b) || (c & d)
> 
> instead of
> 
>    a & b || c & d
> 
> to make it easier to mentally see the grouping.

Can do...  FWIW, the only case where the normal "'and' is multiplication,
'or' is addition" doesn't give the right result is
	x | y && z
written instead of
	x | (y && z)
where you would be better off rewriting the expression anyway.

FWIW, one of the things in the local pile is this:

commit cc1b6724b32de1be108cf6a5f28dbb5aa424b42f
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Jan 19 12:44:18 2020 -0500

    namei: invert the meaning of WALK_FOLLOW
    
    old flags & WALK_FOLLOW <=> new !(flags & WALK_TRAILING)
    That's what that flag had really been used for.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/namei.c b/fs/namei.c
index 6eb708014d4b..7d938241157f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1786,7 +1786,7 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 	return NULL;
 }
 
-enum {WALK_FOLLOW = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
+enum {WALK_TRAILING = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
 
 /*
  * Do we need to follow links? We _really_ want to be able
@@ -1805,7 +1805,7 @@ static const char *step_into(struct nameidata *nd, int flags,
 	if (!(flags & WALK_MORE) && nd->depth)
 		put_link(nd);
 	if (likely(!d_is_symlink(path.dentry)) ||
-	   !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW) ||
+	   (flags & WALK_TRAILING && !(nd->flags & LOOKUP_FOLLOW)) ||
 	   flags & WALK_NOFOLLOW) {
 		/* not a symlink or should not follow */
 		path_to_nameidata(&path, nd);
@@ -2157,10 +2157,10 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 			if (!name)
 				return 0;
 			/* last component of nested symlink */
-			link = walk_component(nd, WALK_FOLLOW);
+			link = walk_component(nd, 0);
 		} else {
 			/* not the last component */
-			link = walk_component(nd, WALK_FOLLOW | WALK_MORE);
+			link = walk_component(nd, WALK_MORE);
 		}
 		if (unlikely(link)) {
 			if (IS_ERR(link))
@@ -2288,7 +2288,7 @@ static inline const char *lookup_last(struct nameidata *nd)
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
 	nd->flags &= ~LOOKUP_PARENT;
-	link = walk_component(nd, 0);
+	link = walk_component(nd, WALK_TRAILING);
 	if (link) {
 		nd->flags |= LOOKUP_PARENT;
 		nd->stack[0].name = NULL;
@@ -3241,7 +3241,7 @@ static const char *do_last(struct nameidata *nd,
 	}
 
 finish_lookup:
-	link = step_into(nd, 0, dentry, inode, seq);
+	link = step_into(nd, WALK_TRAILING, dentry, inode, seq);
 	if (unlikely(link)) {
 		nd->flags |= LOOKUP_PARENT;
 		nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);


and I can simply fold adding extra parens into it.  Or I can fold that into
the patch you'd been replying to  - I'm still uncertain about the series
containing WALK_TRAILING...
