Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB0821F0EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 14:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgGNMSE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 08:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgGNMSA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:18:00 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABC3C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 05:18:00 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v6so17025189iob.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 05:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdFgJyHseyYObNBPdG3u/U8C+IlSbkxUbQ/N7B6Yeq0=;
        b=XNWUXdsuPx3bRQ5FtDlih6TgidC5lPrLm4vCsvx3jkyM7mmwCQtUQ08MlLeBGvVnfD
         l5g4OrwJDHcC9HgNqzcVqldyPu9w8Pm2svvyXCEu62oQpC2k4hfqFRcKxwzmPFKXabCN
         MbymZwKL79715A5iWm6squw6Aw6ZJdjzyKdUCuETQMvGPB6GuQlnI30TjtHLoiyfCJQG
         IALXRzKnmWpRZ5tPxVmaB+j0q35StNrfQEgw+YPfwoBzRnvN5PCjW1C88+GqVLjh7rW7
         Vn0lZ6HSW81rYe4ydT6kkFFP/AAKZ/wP9uHOTqncdgrCoqgOMoYSotyQIUp8Qq+FQ2iH
         bI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdFgJyHseyYObNBPdG3u/U8C+IlSbkxUbQ/N7B6Yeq0=;
        b=N7L+/lDzgif0cWdr7YjK+mj0jqIZB89UhRVpYJ3auz93JUluv3tWmIuhho9pDVDfNe
         mPMPBFiAvUVuIlILWE7HctlH4b+Bl2NwM+Ze+Wyr8USR5cus12iNe4etoiDuL3TOXooV
         QdTT5toQDZIYxCZCdKWwQjPQwpAy0+1/eON8GOJlFekwNGnKAKDthKdHfnYcXrCLsYi0
         EqDieCB+QuD7Vbuw52w/uni3emq9fXH54LBy1/FBSG0MBD0GGz1S7iSuPISVZCjS7T+u
         CJR0p1p13ERw06R/6FdK3lLXXlQh/I5ZDbj7yurPl+vpdVSCLNuKUFsXTK7I2o/XykTH
         DPlQ==
X-Gm-Message-State: AOAM532S6uw/wuaH2FdLP++z9bA1Sw0SEjlDRQgunjmVTdkRFPzEwhRB
        WCXra5/Kiv/avSAlgqda6emP9hDWfigaePUeHR13Jw==
X-Google-Smtp-Source: ABdhPJw5nwi2uNZqM3XIflQPfiAYXERHpldHzZNslb1iuuIlC0lRMAViTZL3blB5c+5raRO6fkqs5B4ibLI4dsbRC1c=
X-Received: by 2002:a05:6638:d96:: with SMTP id l22mr5654482jaj.120.1594729080050;
 Tue, 14 Jul 2020 05:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200702125744.10535-1-amir73il@gmail.com> <20200702125744.10535-5-amir73il@gmail.com>
 <20200714115451.GE23073@quack2.suse.cz>
In-Reply-To: <20200714115451.GE23073@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 14 Jul 2020 15:17:48 +0300
Message-ID: <CAOQ4uxjKj=S6s_L2m4d65PEha+H-MCHUmiozx42NAs1K40ZfXw@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] fsnotify: send event with parent/name info to
 sb/mount/non-dir marks
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 2:54 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 02-07-20 15:57:38, Amir Goldstein wrote:
> > Similar to events "on child" to watching directory, send event "on child"
> > with parent/name info if sb/mount/non-dir marks are interested in
> > parent/name info.
> >
> > The FS_EVENT_ON_CHILD flag can be set on sb/mount/non-dir marks to specify
> > interest in parent/name info for events on non-directory inodes.
> >
> > Events on "orphan" children (disconnected dentries) are sent without
> > parent/name info.
> >
> > Events on direcories are send with parent/name info only if the parent
> > directory is watching.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fsnotify.c             | 50 +++++++++++++++++++++++---------
> >  include/linux/fsnotify.h         | 10 +++++--
> >  include/linux/fsnotify_backend.h | 32 +++++++++++++++++---
> >  3 files changed, 73 insertions(+), 19 deletions(-)
> >
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index 7c6e624b24c9..6683c77a5b13 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -144,27 +144,55 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
> >
> >  /*
> >   * Notify this dentry's parent about a child's events with child name info
> > - * if parent is watching.
> > - * Notify only the child without name info if parent is not watching.
> > + * if parent is watching or if inode/sb/mount are interested in events with
> > + * parent and name info.
> > + *
> > + * Notify only the child without name info if parent is not watching and
> > + * inode/sb/mount are not interested in events with parent and name info.
> >   */
> >  int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> >                     int data_type)
> >  {
>
> Ugh, I have to say this function is now pretty difficult to digest. I was
> staring at it for an hour before I could make some sence of it...
>

Yeh, it took many trials to get to something that does the job,
but it could use some cosmetic changes ;-)

> > +     const struct path *path = fsnotify_data_path(data, data_type);
> > +     struct mount *mnt = path ? real_mount(path->mnt) : NULL;
> >       struct inode *inode = d_inode(dentry);
> >       struct dentry *parent;
> > +     bool parent_watched = dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED;
> > +     __u32 p_mask, test_mask, marks_mask = 0;
> >       struct inode *p_inode;
> >       int ret = 0;
> >
> > +     /*
> > +      * Do inode/sb/mount care about parent and name info on non-dir?
> > +      * Do they care about any event at all?
> > +      */
> > +     if (!inode->i_fsnotify_marks && !inode->i_sb->s_fsnotify_marks &&
> > +         (!mnt || !mnt->mnt_fsnotify_marks)) {
> > +             if (!parent_watched)
> > +                     return 0;
> > +     } else if (!(mask & FS_ISDIR) && !IS_ROOT(dentry)) {
> > +             marks_mask |= fsnotify_want_parent(inode->i_fsnotify_mask);
> > +             marks_mask |= fsnotify_want_parent(inode->i_sb->s_fsnotify_mask);
> > +             if (mnt)
> > +                     marks_mask |= fsnotify_want_parent(mnt->mnt_fsnotify_mask);
> > +     }
>
> OK, so AFAIU at this point (mask & marks_mask) tells us whether we need to
> grab parent because some mark needs parent into reported. Correct?
>
> Maybe I'd rename fsnotify_want_parent() (which seems like it returns bool)
> to fsnotify_parent_needed_mask() or something like that. Also I'd hide all
> those checks in a helper function like:
>
>         fsnotify_event_needs_parent(mnt, inode, mask)
>
> So we'd then have just something like:
>         if (!inode->i_fsnotify_marks && !inode->i_sb->s_fsnotify_marks &&
>             (!mnt || !mnt->mnt_fsnotify_marks) && !parent_watched)
>                 return 0;
>         if (!parent_watched && !fsnotify_event_needs_parent(mnt, inode, mask))
>                 goto notify_child;

OK, but we'd still need to store marks_mask for later in case event
needs parent.


>         ...
>
> > +
> >       parent = NULL;
> > -     if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
> > +     test_mask = mask & FS_EVENTS_POSS_TO_PARENT;
> > +     if (!(marks_mask & test_mask) && !parent_watched)
> >               goto notify_child;
> >
> > +     /* Does parent inode care about events on children? */
> >       parent = dget_parent(dentry);
> >       p_inode = parent->d_inode;
> > +     p_mask = fsnotify_inode_watches_children(p_inode);
> >
> > -     if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
> > +     if (p_mask)
> > +             marks_mask |= p_mask;
> > +     else if (unlikely(parent_watched))
> >               __fsnotify_update_child_dentry_flags(p_inode);
> > -     } else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
> > +
> > +     if ((marks_mask & test_mask) && p_inode != inode) {
>                                         ^^ this is effectively
> !IS_ROOT(dentry), isn't it? But since you've checked that above can it ever
> be that p_inode == inode?
>

True, but only if you add the hidden assumption (which should be true) that
DCACHE_FSNOTIFY_PARENT_WATCHED cannot be set on an IS_ROOT
dentry. Otherwise you can have parent_watched and not check IS_ROOT()
so prefered defensive here, but I don't mind dropping it.

> Also if marks_mask & test_mask == 0, why do you go to a branch that
> notifies child? There shouldn't be anything to report there either. Am I
> missing something? ... Oh, I see, the FS_EVENTS_POSS_TO_PARENT masking
> above could cause that child is still interested. Because mask & marks_mask
> can still contain something. Maybe it would be more comprehensible if we
> restructure the above like:
>
>         p_mask = fsnotify_inode_watches_children(p_inode);
>         if (unlikely(parent_watched && !p_mask))
>                 __fsnotify_update_child_dentry_flags(p_inode);
>         /*
>          * Include parent in notification either if some notification
>          * groups require parent info (!parent_watched case) or the parent is
>          * interested in this event.
>          */
>         if (!parent_watched || (mask & p_mask & ALL_FSNOTIFY_EVENTS)) {
>                 ...
>         }
>

Sure!

> >               struct name_snapshot name;
> >
> >               /* When notifying parent, child should be passed as data */
> > @@ -346,15 +374,11 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
> >           (!child || !child->i_fsnotify_marks))
> >               return 0;
> >
> > -     /* An event "on child" is not intended for a mount/sb mark */
> > -     marks_mask = to_tell->i_fsnotify_mask;
> > -     if (!child) {
> > -             marks_mask |= sb->s_fsnotify_mask;
> > -             if (mnt)
> > -                     marks_mask |= mnt->mnt_fsnotify_mask;
> > -     } else {
> > +     marks_mask = to_tell->i_fsnotify_mask | sb->s_fsnotify_mask;
> > +     if (mnt)
> > +             marks_mask |= mnt->mnt_fsnotify_mask;
> > +     if (child)
> >               marks_mask |= child->i_fsnotify_mask;
> > -     }
>
> This hunk seems to belong to the previous patch... It fixes the problem
> I've spotted there.

I figured that we would find it here :-)
I will fix the previous patch.

Thanks,
Amir.
