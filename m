Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A27C22139C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 19:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgGORmp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 13:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGORmo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:42:44 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7636AC061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 10:42:44 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id h16so2712176ilj.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 10:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gm4cJkVdLFvOppBkIOqMCUu2qSw86ap68iyAEQRPRhE=;
        b=Bm0NGaitIVODvuUggUEQIBOWTWxwWXEXnGFyIGMmmPcre8fy3zs+HlUAfO5EY8sG75
         NamCk4hzruMflC50OJM1qjJFDZSLEJeBD1p6mANGbNDDlQ/T72Sw4r4VAcqXE025yxAd
         xffsqqslJ36+rQfHfWlCUqCJ4h+UnWd8YAVRyMBCbOO8CazAVODK92hMDe/paBr11CbY
         mBmvqArfqP2oJ/wtVwFlhvivbP5ArJZVIlYuJV1qQfBnkwRx5yWxK6vMoQPcgWtUDTwn
         h5zxOFudVpZmGJ3jCObdLh21st7LlV3oO7AhPvyAQ4hg+NYwTsbRQMga8v4sgSd34BSG
         PSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gm4cJkVdLFvOppBkIOqMCUu2qSw86ap68iyAEQRPRhE=;
        b=hBAxml0GCiIVFTdL1/ZPQ0hvnenbsgi6A8nGg4vUudwm0qOIIbgVyNLYYiyC3bbw9r
         fquANLTZmdxNhrnxJUuBkhHoujmIWqnIIU4fOl3PUmZq0Or4F7xHpmLiv/64gleiKek/
         byqFJCqWYe1eLGk28EBNWZPf5ihVifshb4n+nWVfL8RwaU9Ue1rmKCpM6UAiNmK22RHn
         SiwQd2FMWkHz6q83J4w6IGQ+Ztk7PX24g8JYjOwj43j58F0MfUbcURfgfxBwCJFlN59y
         JVl7Ij9wbGczF9VAxebSEteZa6GdPdJkSdkWwM+g4KVrroXLLBW5QWAhV/tGdg/SI/Hb
         NZMA==
X-Gm-Message-State: AOAM530jhLSDvwoGI6A79giUIOFItXiQbE9bGErYiB9QewsCPSHlvd5N
        4pS/xcQnqVhqYtsETTzxX1fcqf5oAJh6iuVyffQ=
X-Google-Smtp-Source: ABdhPJyrHFWtmCaIRe03zEQ1w+Nccz3pQK2n5s5/+UsDzqUiTxsMk4RbBSRKpIIiz4U+TBWJtf7vog5WYQBP57MJd2s=
X-Received: by 2002:a92:490d:: with SMTP id w13mr619016ila.250.1594834963637;
 Wed, 15 Jul 2020 10:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200702125744.10535-1-amir73il@gmail.com> <20200702125744.10535-4-amir73il@gmail.com>
 <20200714103455.GD23073@quack2.suse.cz> <CAOQ4uxi7oGHC5HJGWgF+PO3359CpbpzSC=pPhp=RPCczHHdv3g@mail.gmail.com>
 <20200715170937.GQ23073@quack2.suse.cz>
In-Reply-To: <20200715170937.GQ23073@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 15 Jul 2020 20:42:32 +0300
Message-ID: <CAOQ4uxj_SoOvG1ozC8tSc7VYeYwOyS30TL=9-+T6J_++-q8qXg@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] fsnotify: send event to parent and child with
 single callback
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 8:09 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 14-07-20 14:54:44, Amir Goldstein wrote:
> > On Tue, Jul 14, 2020 at 1:34 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 02-07-20 15:57:37, Amir Goldstein wrote:
> > > > Instead of calling fsnotify() twice, once with parent inode and once
> > > > with child inode, if event should be sent to parent inode, send it
> > > > with both parent and child inodes marks in object type iterator and call
> > > > the backend handle_event() callback only once.
> > > >
> > > > The parent inode is assigned to the standard "inode" iterator type and
> > > > the child inode is assigned to the special "child" iterator type.
> > > >
> > > > In that case, the bit FS_EVENT_ON_CHILD will be set in the event mask,
> > > > the dir argment to handle_event will be the parent inode, the file_name
> > > > argument to handle_event is non NULL and refers to the name of the child
> > > > and the child inode can be accessed with fsnotify_data_inode().
> > > >
> > > > This will allow fanotify to make decisions based on child or parent's
> > > > ignored mask.  For example, when a parent is interested in a specific
> > > > event on its children, but a specific child wishes to ignore this event,
> > > > the event will not be reported.  This is not what happens with current
> > > > code, but according to man page, it is the expected behavior.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > I like the direction where this is going. But can't we push it even a bit
> > > further? I like the fact that we now have "one fs event" -> "one fsnotify()
> > > call". Ideally I'd like to get rid of FS_EVENT_ON_CHILD in the event mask
> > > because it's purpose seems very weak now and it complicates code (and now
> >
> > Can you give an example where it complicates the code?
> > Don't confuse this with the code in fanotify_user.c that subscribes for
> > events on child/with name.
>
> I refer mostly to the stuff like:
>
>         /* An event "on child" is not intended for a mount/sb mark */
>         if (mask & FS_EVENT_ON_CHILD)
>                 ...
>
> They are not big complications. But it would be nice to get rid of special
> cases like this. Basically my thinking was like: Now that we generate each
> event exactly once (i.e., no event duplication once with FS_EVENT_ON_CHILD
> and once without it), we should just be able to deliver all events to sb,
> mnt, parent, child and they'll just ignore it if they don't care. No
> special cases needed. But I understand I'm omitting a lot of detail in this
> highlevel "feeling" and these details may make this impractical.
>

Well, you may be right.
I have the opposite "feeling" but you often prove me wrong.
I will try to look closer at your proposal, but I must say, even
if the flag is redundant information, so what?
You may say the same thing about FS_ISDIR now.
I agree that we should simplify code that doesn't need to use the
flag, but if in the end the need to report the child FID is determined by
this flag, why should we recalculate it if we can conveniently set the
flag in the right case in fsnotify_parent().

If I am not mistaken, the alternative would mean special casing the
DIRENT_EVENTS in the event handler.
Yes, we already do special case them, but in some places special
casing them can be avoided by consulting the FS_EVENT_ON_CHILD flag.

> > In one before the last patch of the series I am testing FS_EVENT_ON_CHILD
> > in mask to know how to report the event inside fanotify_alloc_event().
> > I may be able to carry this information not in mask, but the flag space is
> > already taken anyway by FAN_EVENT_ON_CHILD input arg, so not sure
> > what is there to gain from not setting FS_EVENT_ON_CHILD.
> >
> > > it became even a bit of a misnomer) - intuitively, ->handle_event is now
> >
> > I thought of changing the name to FS_EVENT_WITH_NAME, but that was
> > confusing because create/delete are also events with a name.
> > Maybe FS_EVENT_WITH_CHILD_NAME :-/
>
> Yeah, FS_EVENT_WITH_CHILD_NAME would describe the use better now but then
> the aliasing with FAN_EVENT_ON_CHILD will be confusing as well. So if we
> keep passing the flag, I guess keeping the name is the least confusing.
>
> > > passed sb, mnt, parent, child so it should have all the info to decide
> > > where the event should be reported and I don't see a need for
> > > FS_EVENT_ON_CHILD flag.
> >
> > Do you mean something like this?
> >
> >         const struct path *inode = fsnotify_data_inode(data, data_type);
> >         bool event_on_child = !!file_name && dir != inode;
>
> Not quite. E.g. in fanotify_group_event_mask() we could replace the
> FS_EVENT_ON_CHILD usage with something like:
>
>         /* If parent isn't interested in events on child, skip adding its mask */
>         if (type == FSNOTIFY_OBJ_TYPE_INODE &&
>             !(mark->mask & FS_EVENT_ON_CHILD))
>                 continue;
>
> And AFAIU this should do just what we need if we always fill in the
> TYPE_CHILD field and TYPE_INODE only if we need the parent information
> (either for reporting to parent or for parent info in the event).
>

Yes, this specific condition could be simplified like you wrote.
It is a relic from before I unified the two event flavors and I forgot to
change it.

> > It may be true that all information is there, but I think the above is
> > a bit ugly and quite not trivial to explain, whereas the flag is quite
> > intuitive (to me) and adds no extra complexity (IMO).
> >
> > > With fsnotify() call itself we still use
> > > FS_EVENT_ON_CHILD to determine what the arguments mean but can't we just
> > > mandate that 'data' always points to the child, 'to_tell' is always the
> > > parent dir if watching or NULL (and I'd rename that argument to 'dir' and
> > > maybe move it after 'data_type' argument). What do you think?
> > >
> >
> > I think what you are missing is the calls from fsnotify_name().
> > For those calls, data is the dir and so is to_tell and name is the entry name.
>
> Really? I can see in the final version:
>
> static inline void fsnotify_name(struct inode *dir, __u32 mask,
>                                  struct inode *child,
>                                  const struct qstr *name, u32 cookie)
> {
>         fsnotify(dir, mask, child, FSNOTIFY_EVENT_INODE, name, cookie);
> }
>
> so it appears 'to_tell' is dir and data is the child inode...
>

Yes. right again.

> > > > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > > > index 51ada3cfd2ff..7c6e624b24c9 100644
> > > > --- a/fs/notify/fsnotify.c
> > > > +++ b/fs/notify/fsnotify.c
> > > > @@ -145,15 +145,17 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
> > > >  /*
> > > >   * Notify this dentry's parent about a child's events with child name info
> > > >   * if parent is watching.
> > > > - * Notify also the child without name info if child inode is watching.
> > > > + * Notify only the child without name info if parent is not watching.
> > > >   */
> > > >  int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> > > >                     int data_type)
> > > >  {
> > > > +     struct inode *inode = d_inode(dentry);
> > > >       struct dentry *parent;
> > > >       struct inode *p_inode;
> > > >       int ret = 0;
> > > >
> > > > +     parent = NULL;
> > > >       if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
> > > >               goto notify_child;
> > > >
> > > > @@ -165,23 +167,23 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> > > >       } else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
> > > >               struct name_snapshot name;
> > > >
> > > > -             /*
> > > > -              * We are notifying a parent, so set a flag in mask to inform
> > > > -              * backend that event has information about a child entry.
> > > > -              */
> > > > +             /* When notifying parent, child should be passed as data */
> > > > +             WARN_ON_ONCE(inode != fsnotify_data_inode(data, data_type));
> > > > +
> > > > +             /* Notify both parent and child with child name info */
> > > >               take_dentry_name_snapshot(&name, dentry);
> > > >               ret = fsnotify(p_inode, mask | FS_EVENT_ON_CHILD, data,
> > > >                              data_type, &name.name, 0);
> > > >               release_dentry_name_snapshot(&name);
> > > > +     } else {
> > > > +notify_child:
> > > > +             /* Notify child without child name info */
> > > > +             ret = fsnotify(inode, mask, data, data_type, NULL, 0);
> > > >       }
> > >
> > > AFAICT this will miss notifying the child if the condition
> > >         !fsnotify_inode_watches_children(p_inode)
> > > above is true... And I've noticed this because jumping into a branch in an
> > > if block is usually a bad idea and so I gave it a closer look. Exactly
> > > because of problems like this. Usually it's better to restructure
> > > conditions instead.
> > >
> > > In this case I think we could structure the code like:
> > >         struct name_snapshot name
> > >         struct qstr *namestr = NULL;
> > >
> > >         if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
> > >                 goto notify;
> > >         parent = dget_parent(dentry);
> > >         p_inode = parent->d_inode;
> > >
> > >         if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
> > >                 __fsnotify_update_child_dentry_flags(p_inode);
> > >         } else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
> > >                 take_dentry_name_snapshot(&name, dentry);
> > >                 namestr = &name.name;
> > >                 mask |= FS_EVENT_ON_CHILD;
> > >         }
> > > notify:
> > >         ret = fsnotify(p_inode, mask, data, data_type, namestr, 0);
> > >         if (namestr)
> > >                 release_dentry_name_snapshot(&name);
> > >         dput(parent);
> > >         return ret;
> >
> > I will look into this proposal, but please be aware that this function
> > completely changes in the next patch "send event with parent/name info to
> > sb/mount/non-dir marks", so some of the things that look weird here or
> > possibly even bugs might go away.  That is not to say that I won't fix
> > them, but please review with the next patch in mind when considering
> > reconstruct.
>
> Yes, I've then noticed the function changes significantly later and the bug
> actually gets silently fixed. So maybe what I proposed here isn't ideal and
> the fix should look differently. But my main dislike was the jump into the
> if branch which stays till the end AFAICT.
>

And you were right.
I implemented all re-structure suggestions and pushed to fsnotify_name branch.
Will try to look at reducing the use of the FS_EVENT_ON_CHILD flag.

Thanks,
Amir.
