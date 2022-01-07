Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FC24872E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 06:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiAGFwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 00:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiAGFwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:52:33 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48193C061245
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jan 2022 21:52:33 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5iAt-000HOt-NF; Fri, 07 Jan 2022 05:52:27 +0000
Date:   Fri, 7 Jan 2022 05:52:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namei: clear nd->root.mnt before O_CREAT unlazy
Message-ID: <YdfVG56XZnkePk7c@zeniv-ca.linux.org.uk>
References: <20220105180259.115760-1-bfoster@redhat.com>
 <4a13a560520e1ef522fcbb9f7dfd5e8c88d5b238.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a13a560520e1ef522fcbb9f7dfd5e8c88d5b238.camel@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 07, 2022 at 07:46:10AM +0800, Ian Kent wrote:
> On Wed, 2022-01-05 at 13:02 -0500, Brian Foster wrote:
> > The unlazy sequence of an rcuwalk lookup occurs a bit earlier than
> > normal for O_CREAT lookups (i.e. in open_last_lookups()). The create
> > logic here historically invoked complete_walk(), which clears the
> > nd->root.mnt pointer when appropriate before the unlazy.  This
> > changed in commit 72287417abd1 ("open_last_lookups(): don't abuse
> > complete_walk() when all we want is unlazy"), which refactored the
> > create path to invoke unlazy_walk() and not consider nd->root.mnt.
> > 
> > This tweak negatively impacts performance on a concurrent
> > open(O_CREAT) workload to multiple independent mounts beneath the
> > root directory. This attributes to increased spinlock contention on
> > the root dentry via legitimize_root(), to the point where the
> > spinlock becomes the primary bottleneck over the directory inode
> > rwsem of the individual submounts. For example, the completion rate
> > of a 32k thread aim7 create/close benchmark that repeatedly passes
> > O_CREAT to open preexisting files drops from over 700k "jobs per
> > minute" to 30, increasing the overall test time from a few minutes
> > to over an hour.
> > 
> > A similar, more simplified test to create a set of opener tasks
> > across a set of submounts can demonstrate the problem more quickly.
> > For example, consider sets of 100 open/close tasks each running
> > against 64 independent filesystem mounts (i.e. 6400 tasks total),
> > with each task completing 10k iterations before it exits. On an
> > 80xcpu box running v5.16.0-rc2, this test completes in 50-55s. With
> > this patch applied, the same test completes in 10-15s.
> > 
> > This is not the most realistic workload in the world as it factors
> > out inode allocation in the filesystem. The contention can also be
> > avoided by more selective use of O_CREAT or via use of relative
> > pathnames. That said, this regression appears to be an unintentional
> > side effect of code cleanup and might be unexpected for users.
> > Restore original behavior prior to commit 72287417abd1 by factoring
> > the rcu logic from complete_walk() into a new helper and invoke that
> > from both places.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/namei.c | 37 +++++++++++++++++++++----------------
> >  1 file changed, 21 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 1f9d2187c765..b32fcbc99929 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -856,6 +856,22 @@ static inline int d_revalidate(struct dentry
> > *dentry, unsigned int flags)
> >                 return 1;
> >  }
> >  
> > +static inline bool complete_walk_rcu(struct nameidata *nd)
> > +{
> > +       if (nd->flags & LOOKUP_RCU) {
> > +               /*
> > +                * We don't want to zero nd->root for scoped-lookups
> > or
> > +                * externally-managed nd->root.
> > +                */
> > +               if (!(nd->state & ND_ROOT_PRESET))
> > +                       if (!(nd->flags & LOOKUP_IS_SCOPED))
> > +                               nd->root.mnt = NULL;
> > +               nd->flags &= ~LOOKUP_CACHED;
> > +               return try_to_unlazy(nd);
> > +       }
> > +       return true;
> > +}
> > +
> >  /**
> >   * complete_walk - successful completion of path walk
> >   * @nd:  pointer nameidata
> > @@ -871,18 +887,8 @@ static int complete_walk(struct nameidata *nd)
> >         struct dentry *dentry = nd->path.dentry;
> >         int status;
> >  
> > -       if (nd->flags & LOOKUP_RCU) {
> > -               /*
> > -                * We don't want to zero nd->root for scoped-lookups
> > or
> > -                * externally-managed nd->root.
> > -                */
> > -               if (!(nd->state & ND_ROOT_PRESET))
> > -                       if (!(nd->flags & LOOKUP_IS_SCOPED))
> > -                               nd->root.mnt = NULL;
> > -               nd->flags &= ~LOOKUP_CACHED;
> > -               if (!try_to_unlazy(nd))
> > -                       return -ECHILD;
> > -       }
> > +       if (!complete_walk_rcu(nd))
> > +               return -ECHILD;
> >  
> >         if (unlikely(nd->flags & LOOKUP_IS_SCOPED)) {
> >                 /*
> > @@ -3325,10 +3331,9 @@ static const char *open_last_lookups(struct
> > nameidata *nd,
> >                 BUG_ON(nd->flags & LOOKUP_RCU);
> >         } else {
> >                 /* create side of things */
> > -               if (nd->flags & LOOKUP_RCU) {
> > -                       if (!try_to_unlazy(nd))
> > -                               return ERR_PTR(-ECHILD);
> > -               }
> > +               if (!complete_walk_rcu(nd))
> > +                       return ERR_PTR(-ECHILD);
> > +
> >                 audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
> >                 /* trailing slashes? */
> >                 if (unlikely(nd->last.name[nd->last.len]))
> 
> Looks good, assuming Al is ok with the re-factoring.
> Reviewed-by: Ian Kent <raven@themaw.net>

Ummm....  Mind resending that?  I'm still digging myself from under
the huge pile of mail, and this seems to have been lost in process...
