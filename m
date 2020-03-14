Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6FF18539F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 02:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgCNBGL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 21:06:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51266 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCNBGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 21:06:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCvFf-00B8aM-T5; Sat, 14 Mar 2020 01:06:08 +0000
Date:   Sat, 14 Mar 2020 01:06:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH v4 15/69] new step_into() flag: WALK_NOFOLLOW
Message-ID: <20200314010607.GR23230@ZenIV.linux.org.uk>
References: <20200313235303.GP23230@ZenIV.linux.org.uk>
 <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200313235357.2646756-15-viro@ZenIV.linux.org.uk>
 <CAHk-=widhgJ=hB=dOcQMJzPL9mX+8TdbcAspBXs4FSdiLk2jMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=widhgJ=hB=dOcQMJzPL9mX+8TdbcAspBXs4FSdiLk2jMw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 13, 2020 at 05:32:32PM -0700, Linus Torvalds wrote:
> I mentioned this last time (perhaps for a different sequence):
> 
> On Fri, Mar 13, 2020 at 4:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         if (likely(!d_is_symlink(path->dentry)) ||
> > -          !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW)) {
> > +          !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW) ||
> > +          flags & WALK_NOFOLLOW) {
> 
> Yes, I know that bitwise operations have higher precedence than the
> logical ones. And I know & (and &&) have higher precedence than | (and
> ||).
> 
> But I have to _think_ about it every time I see code like this.
> 
> I'd really prefer to see
> 
>    if ((a & BIT) || (b & ANOTHER_BIT))
> 
> over the "equivalent" and shorter
> 
>    if (a & BIT || b & ANOTHER_BIT)
> 
> Please make it explicit. It wasn't before either, but it _could_ be.

Not a problem (actually, I'd done that several commits later when I was
rewriting the expression anyway).  Folded the following into it now:

diff --git a/fs/namei.c b/fs/namei.c
index e47b376cf442..79f06be7f5d4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1839,8 +1839,8 @@ static inline int step_into(struct nameidata *nd, struct path *path,
 			    int flags, struct inode *inode, unsigned seq)
 {
 	if (likely(!d_is_symlink(path->dentry)) ||
-	   !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW) ||
-	   flags & WALK_NOFOLLOW) {
+	   !((flags & WALK_FOLLOW) || (nd->flags & LOOKUP_FOLLOW)) ||
+	   (flags & WALK_NOFOLLOW)) {
 		/* not a symlink or should not follow */
 		path_to_nameidata(path, nd);
 		nd->inode = inode;
