Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C7F21EFD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 13:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGNLy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 07:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgGNLy5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:54:57 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1433BC061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 04:54:57 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id l1so16942619ioh.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogABOJ9kq9ShjeaQx7oQS3GJ1bIja1Y/L2sF+4bHzj0=;
        b=rZy+94BlWgb8e8j1s2tqJvjHJVFd1Y1QD0Sr0tHNtiknyUMZRjjDD2yCU/nAviP3jH
         GPVgMntOCIN1FWjSEBIG2HqUW2BdMwBo29XbecOOFlEdcFzUMlXoxnf9gJDw2jlViJum
         5g9AJsPS3/KHR9aChGFkvrvplrr1FaNTm7p/s0ITRCWzK4ujSMPBaOKeahWFuAiotmbb
         iqIQ2kxay510cY9NoNEe7cN9jdaAIvTXsBx2mBnFuJwMZQuVs39a/C6y/Bh5tw8buW+J
         mYbTxH4RbaVEQSumqIoU5M9LAC7PtTP1ut2ZtXIDNAaiq/zGCbwWw5Gmso3lHGkZ8uA6
         iw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogABOJ9kq9ShjeaQx7oQS3GJ1bIja1Y/L2sF+4bHzj0=;
        b=lCXB5ue10QeHn5W3jT3Pn3cyuj1l/+iaSaQqh2OxwWWrT/W4NmNa8irzJIcHHFaa3S
         MyVOpekeEStNXXXIhNhkFcRz253H6t7GYNc+eToT24QBl7Vcs4VZ62vJe9baoPvfbwCe
         s9HwuVinnumASlaGd+q3XmCEuc4CMjz9jwsSNJVCDLyRyqDVMkD9zDjANCMZ55ww4Y2e
         hy7jqv7j5zA4tPQAiz4gJw+djM1FPRCDjlQxJaS5e7czubs5WecgWFz26I9lv7NKCMun
         nhNvEWsfWL5KpLnU4tJ+YwEFRMLJWLFlwB4DTZKwmOvzf+CQ0eBaeorQl5Ey8O6751Ch
         qnLw==
X-Gm-Message-State: AOAM532hKSSyAkmO+PfB0LTOySkmytDPjBz6g9oTDj8rYTMG1acOwOBH
        inlsDu15wBdKS3e+nv9+644IEzXB9lbk73cFSYwzC6J6
X-Google-Smtp-Source: ABdhPJxxzVvz15KUIsc13SJ+iplI+1KEHP7XJka1/xZqnzcupefOT/XNQAdhBIuYtu+1g+TXAvPBAS2d8vGXMGtw83s=
X-Received: by 2002:a6b:b483:: with SMTP id d125mr4584716iof.186.1594727696224;
 Tue, 14 Jul 2020 04:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200702125744.10535-1-amir73il@gmail.com> <20200702125744.10535-4-amir73il@gmail.com>
 <20200714103455.GD23073@quack2.suse.cz>
In-Reply-To: <20200714103455.GD23073@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 14 Jul 2020 14:54:44 +0300
Message-ID: <CAOQ4uxi7oGHC5HJGWgF+PO3359CpbpzSC=pPhp=RPCczHHdv3g@mail.gmail.com>
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

On Tue, Jul 14, 2020 at 1:34 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 02-07-20 15:57:37, Amir Goldstein wrote:
> > Instead of calling fsnotify() twice, once with parent inode and once
> > with child inode, if event should be sent to parent inode, send it
> > with both parent and child inodes marks in object type iterator and call
> > the backend handle_event() callback only once.
> >
> > The parent inode is assigned to the standard "inode" iterator type and
> > the child inode is assigned to the special "child" iterator type.
> >
> > In that case, the bit FS_EVENT_ON_CHILD will be set in the event mask,
> > the dir argment to handle_event will be the parent inode, the file_name
> > argument to handle_event is non NULL and refers to the name of the child
> > and the child inode can be accessed with fsnotify_data_inode().
> >
> > This will allow fanotify to make decisions based on child or parent's
> > ignored mask.  For example, when a parent is interested in a specific
> > event on its children, but a specific child wishes to ignore this event,
> > the event will not be reported.  This is not what happens with current
> > code, but according to man page, it is the expected behavior.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> I like the direction where this is going. But can't we push it even a bit
> further? I like the fact that we now have "one fs event" -> "one fsnotify()
> call". Ideally I'd like to get rid of FS_EVENT_ON_CHILD in the event mask
> because it's purpose seems very weak now and it complicates code (and now

Can you give an example where it complicates the code?
Don't confuse this with the code in fanotify_user.c that subscribes for events
on child/with name.

In one before the last patch of the series I am testing FS_EVENT_ON_CHILD
in mask to know how to report the event inside fanotify_alloc_event().
I may be able to carry this information not in mask, but the flag space is
already taken anyway by FAN_EVENT_ON_CHILD input arg, so not sure
what is there to gain from not setting FS_EVENT_ON_CHILD.

> it became even a bit of a misnomer) - intuitively, ->handle_event is now

I thought of changing the name to FS_EVENT_WITH_NAME, but that was
confusing because create/delete are also events with a name.
Maybe FS_EVENT_WITH_CHILD_NAME :-/

> passed sb, mnt, parent, child so it should have all the info to decide
> where the event should be reported and I don't see a need for
> FS_EVENT_ON_CHILD flag.

Do you mean something like this?

        const struct path *inode = fsnotify_data_inode(data, data_type);
        bool event_on_child = !!file_name && dir != inode;

It may be true that all information is there, but I think the above is
a bit ugly and quite not trivial to explain, whereas the flag is quite
intuitive (to me) and adds no extra complexity (IMO).

> With fsnotify() call itself we still use
> FS_EVENT_ON_CHILD to determine what the arguments mean but can't we just
> mandate that 'data' always points to the child, 'to_tell' is always the
> parent dir if watching or NULL (and I'd rename that argument to 'dir' and
> maybe move it after 'data_type' argument). What do you think?
>

I think what you are missing is the calls from fsnotify_name().
For those calls, data is the dir and so is to_tell and name is the entry name.

> Some further comments about the current implementation are below...
>
> > ---
> >  fs/kernfs/file.c     | 10 ++++++----
> >  fs/notify/fsnotify.c | 40 ++++++++++++++++++++++++++--------------
> >  2 files changed, 32 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> > index e23b3f62483c..5b1468bc509e 100644
> > --- a/fs/kernfs/file.c
> > +++ b/fs/kernfs/file.c
> > @@ -883,6 +883,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
> >
> >       list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
> >               struct kernfs_node *parent;
> > +             struct inode *p_inode = NULL;
> >               struct inode *inode;
> >               struct qstr name;
> >
> > @@ -899,8 +900,6 @@ static void kernfs_notify_workfn(struct work_struct *work)
> >               name = (struct qstr)QSTR_INIT(kn->name, strlen(kn->name));
> >               parent = kernfs_get_parent(kn);
> >               if (parent) {
> > -                     struct inode *p_inode;
> > -
> >                       p_inode = ilookup(info->sb, kernfs_ino(parent));
> >                       if (p_inode) {
> >                               fsnotify(p_inode, FS_MODIFY | FS_EVENT_ON_CHILD,
> > @@ -911,8 +910,11 @@ static void kernfs_notify_workfn(struct work_struct *work)
> >                       kernfs_put(parent);
> >               }
> >
> > -             fsnotify(inode, FS_MODIFY, inode, FSNOTIFY_EVENT_INODE,
> > -                      NULL, 0);
> > +             if (!p_inode) {
> > +                     fsnotify(inode, FS_MODIFY, inode, FSNOTIFY_EVENT_INODE,
> > +                              NULL, 0);
> > +             }
> > +
> >               iput(inode);
> >       }
> >
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index 51ada3cfd2ff..7c6e624b24c9 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -145,15 +145,17 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
> >  /*
> >   * Notify this dentry's parent about a child's events with child name info
> >   * if parent is watching.
> > - * Notify also the child without name info if child inode is watching.
> > + * Notify only the child without name info if parent is not watching.
> >   */
> >  int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> >                     int data_type)
> >  {
> > +     struct inode *inode = d_inode(dentry);
> >       struct dentry *parent;
> >       struct inode *p_inode;
> >       int ret = 0;
> >
> > +     parent = NULL;
> >       if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
> >               goto notify_child;
> >
> > @@ -165,23 +167,23 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> >       } else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
> >               struct name_snapshot name;
> >
> > -             /*
> > -              * We are notifying a parent, so set a flag in mask to inform
> > -              * backend that event has information about a child entry.
> > -              */
> > +             /* When notifying parent, child should be passed as data */
> > +             WARN_ON_ONCE(inode != fsnotify_data_inode(data, data_type));
> > +
> > +             /* Notify both parent and child with child name info */
> >               take_dentry_name_snapshot(&name, dentry);
> >               ret = fsnotify(p_inode, mask | FS_EVENT_ON_CHILD, data,
> >                              data_type, &name.name, 0);
> >               release_dentry_name_snapshot(&name);
> > +     } else {
> > +notify_child:
> > +             /* Notify child without child name info */
> > +             ret = fsnotify(inode, mask, data, data_type, NULL, 0);
> >       }
>
> AFAICT this will miss notifying the child if the condition
>         !fsnotify_inode_watches_children(p_inode)
> above is true... And I've noticed this because jumping into a branch in an
> if block is usually a bad idea and so I gave it a closer look. Exactly
> because of problems like this. Usually it's better to restructure
> conditions instead.
>
> In this case I think we could structure the code like:
>         struct name_snapshot name
>         struct qstr *namestr = NULL;
>
>         if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
>                 goto notify;
>         parent = dget_parent(dentry);
>         p_inode = parent->d_inode;
>
>         if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
>                 __fsnotify_update_child_dentry_flags(p_inode);
>         } else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
>                 take_dentry_name_snapshot(&name, dentry);
>                 namestr = &name.name;
>                 mask |= FS_EVENT_ON_CHILD;
>         }
> notify:
>         ret = fsnotify(p_inode, mask, data, data_type, namestr, 0);
>         if (namestr)
>                 release_dentry_name_snapshot(&name);
>         dput(parent);
>         return ret;

I will look into this proposal, but please be aware that this function
completely changes
in the next patch "send event with parent/name info to sb/mount/non-dir marks",
so some of the things that look weird here or possibly even bugs might go away.
That is not to say that I won't fix them, but please review with the
next patch in mind
when considering reconstruct.

> >
> >       dput(parent);
> >
> > -     if (ret)
> > -             return ret;
> > -
> > -notify_child:
> > -     return fsnotify(d_inode(dentry), mask, data, data_type, NULL, 0);
> > +     return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(__fsnotify_parent);
> >
> > @@ -322,12 +324,16 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
> >       struct super_block *sb = to_tell->i_sb;
> >       struct inode *dir = S_ISDIR(to_tell->i_mode) ? to_tell : NULL;
> >       struct mount *mnt = NULL;
> > +     struct inode *child = NULL;
> >       int ret = 0;
> >       __u32 test_mask, marks_mask;
> >
> >       if (path)
> >               mnt = real_mount(path->mnt);
> >
> > +     if (mask & FS_EVENT_ON_CHILD)
> > +             child = fsnotify_data_inode(data, data_type);
> > +
> >       /*
> >        * Optimization: srcu_read_lock() has a memory barrier which can
> >        * be expensive.  It protects walking the *_fsnotify_marks lists.
> > @@ -336,21 +342,23 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
> >        * need SRCU to keep them "alive".
> >        */
> >       if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
> > -         (!mnt || !mnt->mnt_fsnotify_marks))
> > +         (!mnt || !mnt->mnt_fsnotify_marks) &&
> > +         (!child || !child->i_fsnotify_marks))
> >               return 0;
> >
> >       /* An event "on child" is not intended for a mount/sb mark */
> >       marks_mask = to_tell->i_fsnotify_mask;
> > -     if (!(mask & FS_EVENT_ON_CHILD)) {
> > +     if (!child) {
> >               marks_mask |= sb->s_fsnotify_mask;
> >               if (mnt)
> >                       marks_mask |= mnt->mnt_fsnotify_mask;
> > +     } else {
> > +             marks_mask |= child->i_fsnotify_mask;
> >       }
>
> I don't think this is correct. The FS_EVENT_ON_CHILD events should
> also be reported to sb & mnt marks because we now generate only
> FS_EVENT_ON_CHILD if parent is watching but that doesn't mean e.g. sb
> shouldn't receive the event. Am I missing something? If I'm indeed right,
> maybe we should extend our LTP coverage a bit to catch breakage like
> this...
>

You are right.
I will see if the bug is interim or stays with the next patch and will check
if LTP coverage covers this mid series breakage.

Thanks,
Amir.
