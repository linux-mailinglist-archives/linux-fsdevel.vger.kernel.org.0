Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067D6221351
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 19:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGORJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 13:09:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:58668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgGORJk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:09:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CD6FBB07D;
        Wed, 15 Jul 2020 17:09:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1B03E1E12C9; Wed, 15 Jul 2020 19:09:37 +0200 (CEST)
Date:   Wed, 15 Jul 2020 19:09:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 03/10] fsnotify: send event to parent and child with
 single callback
Message-ID: <20200715170937.GQ23073@quack2.suse.cz>
References: <20200702125744.10535-1-amir73il@gmail.com>
 <20200702125744.10535-4-amir73il@gmail.com>
 <20200714103455.GD23073@quack2.suse.cz>
 <CAOQ4uxi7oGHC5HJGWgF+PO3359CpbpzSC=pPhp=RPCczHHdv3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi7oGHC5HJGWgF+PO3359CpbpzSC=pPhp=RPCczHHdv3g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 14-07-20 14:54:44, Amir Goldstein wrote:
> On Tue, Jul 14, 2020 at 1:34 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 02-07-20 15:57:37, Amir Goldstein wrote:
> > > Instead of calling fsnotify() twice, once with parent inode and once
> > > with child inode, if event should be sent to parent inode, send it
> > > with both parent and child inodes marks in object type iterator and call
> > > the backend handle_event() callback only once.
> > >
> > > The parent inode is assigned to the standard "inode" iterator type and
> > > the child inode is assigned to the special "child" iterator type.
> > >
> > > In that case, the bit FS_EVENT_ON_CHILD will be set in the event mask,
> > > the dir argment to handle_event will be the parent inode, the file_name
> > > argument to handle_event is non NULL and refers to the name of the child
> > > and the child inode can be accessed with fsnotify_data_inode().
> > >
> > > This will allow fanotify to make decisions based on child or parent's
> > > ignored mask.  For example, when a parent is interested in a specific
> > > event on its children, but a specific child wishes to ignore this event,
> > > the event will not be reported.  This is not what happens with current
> > > code, but according to man page, it is the expected behavior.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > I like the direction where this is going. But can't we push it even a bit
> > further? I like the fact that we now have "one fs event" -> "one fsnotify()
> > call". Ideally I'd like to get rid of FS_EVENT_ON_CHILD in the event mask
> > because it's purpose seems very weak now and it complicates code (and now
> 
> Can you give an example where it complicates the code?
> Don't confuse this with the code in fanotify_user.c that subscribes for
> events on child/with name.

I refer mostly to the stuff like:

        /* An event "on child" is not intended for a mount/sb mark */
        if (mask & FS_EVENT_ON_CHILD)
 		...

They are not big complications. But it would be nice to get rid of special
cases like this. Basically my thinking was like: Now that we generate each
event exactly once (i.e., no event duplication once with FS_EVENT_ON_CHILD
and once without it), we should just be able to deliver all events to sb,
mnt, parent, child and they'll just ignore it if they don't care. No
special cases needed. But I understand I'm omitting a lot of detail in this
highlevel "feeling" and these details may make this impractical.

> In one before the last patch of the series I am testing FS_EVENT_ON_CHILD
> in mask to know how to report the event inside fanotify_alloc_event().
> I may be able to carry this information not in mask, but the flag space is
> already taken anyway by FAN_EVENT_ON_CHILD input arg, so not sure
> what is there to gain from not setting FS_EVENT_ON_CHILD.
> 
> > it became even a bit of a misnomer) - intuitively, ->handle_event is now
> 
> I thought of changing the name to FS_EVENT_WITH_NAME, but that was
> confusing because create/delete are also events with a name.
> Maybe FS_EVENT_WITH_CHILD_NAME :-/

Yeah, FS_EVENT_WITH_CHILD_NAME would describe the use better now but then
the aliasing with FAN_EVENT_ON_CHILD will be confusing as well. So if we
keep passing the flag, I guess keeping the name is the least confusing.

> > passed sb, mnt, parent, child so it should have all the info to decide
> > where the event should be reported and I don't see a need for
> > FS_EVENT_ON_CHILD flag.
> 
> Do you mean something like this?
> 
>         const struct path *inode = fsnotify_data_inode(data, data_type);
>         bool event_on_child = !!file_name && dir != inode;

Not quite. E.g. in fanotify_group_event_mask() we could replace the
FS_EVENT_ON_CHILD usage with something like:

	/* If parent isn't interested in events on child, skip adding its mask */
	if (type == FSNOTIFY_OBJ_TYPE_INODE &&
	    !(mark->mask & FS_EVENT_ON_CHILD))
		continue;

And AFAIU this should do just what we need if we always fill in the
TYPE_CHILD field and TYPE_INODE only if we need the parent information
(either for reporting to parent or for parent info in the event).

> It may be true that all information is there, but I think the above is
> a bit ugly and quite not trivial to explain, whereas the flag is quite
> intuitive (to me) and adds no extra complexity (IMO).
> 
> > With fsnotify() call itself we still use
> > FS_EVENT_ON_CHILD to determine what the arguments mean but can't we just
> > mandate that 'data' always points to the child, 'to_tell' is always the
> > parent dir if watching or NULL (and I'd rename that argument to 'dir' and
> > maybe move it after 'data_type' argument). What do you think?
> >
> 
> I think what you are missing is the calls from fsnotify_name().
> For those calls, data is the dir and so is to_tell and name is the entry name.

Really? I can see in the final version:

static inline void fsnotify_name(struct inode *dir, __u32 mask,
				 struct inode *child,
				 const struct qstr *name, u32 cookie)
{
	fsnotify(dir, mask, child, FSNOTIFY_EVENT_INODE, name, cookie);
}

so it appears 'to_tell' is dir and data is the child inode...

> > > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > > index 51ada3cfd2ff..7c6e624b24c9 100644
> > > --- a/fs/notify/fsnotify.c
> > > +++ b/fs/notify/fsnotify.c
> > > @@ -145,15 +145,17 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
> > >  /*
> > >   * Notify this dentry's parent about a child's events with child name info
> > >   * if parent is watching.
> > > - * Notify also the child without name info if child inode is watching.
> > > + * Notify only the child without name info if parent is not watching.
> > >   */
> > >  int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> > >                     int data_type)
> > >  {
> > > +     struct inode *inode = d_inode(dentry);
> > >       struct dentry *parent;
> > >       struct inode *p_inode;
> > >       int ret = 0;
> > >
> > > +     parent = NULL;
> > >       if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
> > >               goto notify_child;
> > >
> > > @@ -165,23 +167,23 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> > >       } else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
> > >               struct name_snapshot name;
> > >
> > > -             /*
> > > -              * We are notifying a parent, so set a flag in mask to inform
> > > -              * backend that event has information about a child entry.
> > > -              */
> > > +             /* When notifying parent, child should be passed as data */
> > > +             WARN_ON_ONCE(inode != fsnotify_data_inode(data, data_type));
> > > +
> > > +             /* Notify both parent and child with child name info */
> > >               take_dentry_name_snapshot(&name, dentry);
> > >               ret = fsnotify(p_inode, mask | FS_EVENT_ON_CHILD, data,
> > >                              data_type, &name.name, 0);
> > >               release_dentry_name_snapshot(&name);
> > > +     } else {
> > > +notify_child:
> > > +             /* Notify child without child name info */
> > > +             ret = fsnotify(inode, mask, data, data_type, NULL, 0);
> > >       }
> >
> > AFAICT this will miss notifying the child if the condition
> >         !fsnotify_inode_watches_children(p_inode)
> > above is true... And I've noticed this because jumping into a branch in an
> > if block is usually a bad idea and so I gave it a closer look. Exactly
> > because of problems like this. Usually it's better to restructure
> > conditions instead.
> >
> > In this case I think we could structure the code like:
> >         struct name_snapshot name
> >         struct qstr *namestr = NULL;
> >
> >         if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
> >                 goto notify;
> >         parent = dget_parent(dentry);
> >         p_inode = parent->d_inode;
> >
> >         if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
> >                 __fsnotify_update_child_dentry_flags(p_inode);
> >         } else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
> >                 take_dentry_name_snapshot(&name, dentry);
> >                 namestr = &name.name;
> >                 mask |= FS_EVENT_ON_CHILD;
> >         }
> > notify:
> >         ret = fsnotify(p_inode, mask, data, data_type, namestr, 0);
> >         if (namestr)
> >                 release_dentry_name_snapshot(&name);
> >         dput(parent);
> >         return ret;
> 
> I will look into this proposal, but please be aware that this function
> completely changes in the next patch "send event with parent/name info to
> sb/mount/non-dir marks", so some of the things that look weird here or
> possibly even bugs might go away.  That is not to say that I won't fix
> them, but please review with the next patch in mind when considering
> reconstruct.

Yes, I've then noticed the function changes significantly later and the bug
actually gets silently fixed. So maybe what I proposed here isn't ideal and
the fix should look differently. But my main dislike was the jump into the
if branch which stays till the end AFAICT.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
