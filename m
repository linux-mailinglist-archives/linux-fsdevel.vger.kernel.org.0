Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DF42CD900
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 15:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbgLCOYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 09:24:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:45656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389112AbgLCOYo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:24:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7FE5AAC65;
        Thu,  3 Dec 2020 14:24:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BA8C91E12FF; Thu,  3 Dec 2020 15:24:01 +0100 (CET)
Date:   Thu, 3 Dec 2020 15:24:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/7] fsnotify: fix events reported to watching parent and
 child
Message-ID: <20201203142401.GG11854@quack2.suse.cz>
References: <20201202120713.702387-1-amir73il@gmail.com>
 <20201202120713.702387-4-amir73il@gmail.com>
 <20201203115336.GD11854@quack2.suse.cz>
 <CAOQ4uxgi0LjdsetRyWoz+y9s4YdVxJwoY+0JGF3bgSpC+8Awqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgi0LjdsetRyWoz+y9s4YdVxJwoY+0JGF3bgSpC+8Awqg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-12-20 14:58:41, Amir Goldstein wrote:
> On Thu, Dec 3, 2020 at 1:53 PM Jan Kara <jack@suse.cz> wrote:
> > > The semantics of INODE and CHILD marks were hard to follow and made the
> > > logic more complicated than it should have been.  Replace it with INODE
> > > and PARENT marks semantics to hopefully make the logic more clear.
> >
> > Heh, wasn't I complaining about this when I was initially reviewing the
> > changes? ;)
> 
> You certainly did and rightfully so.
> It took me a long time to untangle this knot, so I hope you like the result.

Yes, it is IMO more readable now.

> > > Fixes: eca4784cbb18 ("fsnotify: send event to parent and child with single callback")
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/notify/fanotify/fanotify.c    |  7 ++-
> > >  fs/notify/fsnotify.c             | 78 ++++++++++++++++++--------------
> > >  include/linux/fsnotify_backend.h |  6 +--
> > >  3 files changed, 51 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > > index 9167884a61ec..1192c9953620 100644
> > > --- a/fs/notify/fanotify/fanotify.c
> > > +++ b/fs/notify/fanotify/fanotify.c
> > > @@ -268,12 +268,11 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
> > >                       continue;
> > >
> > >               /*
> > > -              * If the event is for a child and this mark is on a parent not
> > > +              * If the event is on a child and this mark is on a parent not
> > >                * watching children, don't send it!
> > >                */
> > > -             if (event_mask & FS_EVENT_ON_CHILD &&
> > > -                 type == FSNOTIFY_OBJ_TYPE_INODE &&
> > > -                  !(mark->mask & FS_EVENT_ON_CHILD))
> > > +             if (type == FSNOTIFY_OBJ_TYPE_PARENT &&
> > > +                 !(mark->mask & FS_EVENT_ON_CHILD))
> > >                       continue;
> > >
> > >               marks_mask |= mark->mask;
> > > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > > index c5c68bcbaadf..0676ce4d3352 100644
> > > --- a/fs/notify/fsnotify.c
> > > +++ b/fs/notify/fsnotify.c
> > > @@ -152,6 +152,13 @@ static bool fsnotify_event_needs_parent(struct inode *inode, struct mount *mnt,
> > >       if (mask & FS_ISDIR)
> > >               return false;
> > >
> > > +     /*
> > > +      * All events that are possible on child can also may be reported with
> > > +      * parent/name info to inode/sb/mount.  Otherwise, a watching parent
> > > +      * could result in events reported with unexpected name info to sb/mount.
> > > +      */
> > > +     BUILD_BUG_ON(FS_EVENTS_POSS_ON_CHILD & ~FS_EVENTS_POSS_TO_PARENT);
> > > +
> > >       /* Did either inode/sb/mount subscribe for events with parent/name? */
> > >       marks_mask |= fsnotify_parent_needed_mask(inode->i_fsnotify_mask);
> > >       marks_mask |= fsnotify_parent_needed_mask(inode->i_sb->s_fsnotify_mask);
> > > @@ -249,6 +256,10 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
> > >           path && d_unlinked(path->dentry))
> > >               return 0;
> > >
> > > +     /* Check interest of this mark in case event was sent with two marks */
> > > +     if (!(mask & inode_mark->mask & ALL_FSNOTIFY_EVENTS))
> > > +             return 0;
> > > +
> > >       return ops->handle_inode_event(inode_mark, mask, inode, dir, name, cookie);
> > >  }
> > >
> > > @@ -258,38 +269,40 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
> > >                                u32 cookie, struct fsnotify_iter_info *iter_info)
> > >  {
> > >       struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
> > > -     struct fsnotify_mark *child_mark = fsnotify_iter_child_mark(iter_info);
> > > +     struct fsnotify_mark *parent_mark = fsnotify_iter_parent_mark(iter_info);
> > >       int ret;
> > >
> > >       if (WARN_ON_ONCE(fsnotify_iter_sb_mark(iter_info)) ||
> > >           WARN_ON_ONCE(fsnotify_iter_vfsmount_mark(iter_info)))
> > >               return 0;
> > >
> > > -     /*
> > > -      * An event can be sent on child mark iterator instead of inode mark
> > > -      * iterator because of other groups that have interest of this inode
> > > -      * and have marks on both parent and child.  We can simplify this case.
> > > -      */
> > > -     if (!inode_mark) {
> > > -             inode_mark = child_mark;
> > > -             child_mark = NULL;
> > > +     if (parent_mark) {
> > > +             /*
> > > +              * parent_mark indicates that the parent inode is watching children
> > > +              * and interested in this event, which is an event possible on child.
> > > +              * But is this mark watching children and interested in this event?
> > > +              */
> > > +             if (parent_mark->mask & FS_EVENT_ON_CHILD) {
> >
> > Is this really enough? I'd expect us to also check (mask &
> > parent_mark->mask & ALL_FSNOTIFY_EVENTS) != 0...
> 
> I put it up in fsnotify_event_needs_parent() because this check is needed
> for both parent and child.

Right, I missed that. Thanks for explanation.

> BTW, at first I was thinking we needed to check EVENTS_POSS_ON_CHILD
> here but we don't because if event is not EVENTS_POSS_ON_CHILD
> (a.k.a. !parent_interested) then flag ON_CHILD is not set and parent_mark
> is not iterated .

OK :). I'll just improve the changelog and pick this patch up.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
