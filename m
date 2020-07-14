Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824C021F1BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 14:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGNMo3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 08:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgGNMo2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:44:28 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE90DC061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 05:44:28 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p15so6432469ilh.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/iGjEd8abu1Xgk8l64vunJu7PM1PKUTyJT+8VOxIds=;
        b=TDEM1B2KoP3hz4JTto9Pw8cg8zi5rs1bewkwG0ZU8Bu2Ylak6E3gckFU7LZFnbCSTc
         2FQbIW89lRoOwhsZRiWYdQkXDCHsLz8XrOqwiPWI4oW3sutAob/ZtmM+K1gzNF7j49F/
         GbQOEyalSaZk+18HVeMjTClY+MeVJjqAxCIKvWeM4frZhxHRPXzVcPawu2icnMWd5POQ
         ZVu6MnmEBc0V6F0YGjtQylSPbWGs+YbqLOJ2PTKfS5I7Lk9V6JvQGgBOSTkCx+VuJorf
         edB4bSUKmtzJ6iApztXdcGrl1k9cbWPcit7veQDG/aGQIgooBfLVENhB/rXbS+gffdoc
         t8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/iGjEd8abu1Xgk8l64vunJu7PM1PKUTyJT+8VOxIds=;
        b=Ff3mv5wyapiScEZt1VjXDmAva1eADng4Diz6XSF+da55eG/hjk7laltouQMDOjrjTG
         cGOGy6KZQKcsYU07K6okySFzKItv0+tIlD9P4NxembJcgNvPDfDaZ68novJFMCKtu+9C
         xKpeqfq4HjdRYBDCdu0su1OroMmQ6ov8J+4VZoUxAs1w4SCAQRWOlzPfeZU8zvzdDnZt
         tzKtGWh6TXXj9fEimRGHcmRKKsMZ3EEHI9ftmiKZNj4dcfa0nrJcAs/rAYDYtj9QAN3B
         sR++YFEKDgqK5ksD11S1EDzGbS0sywhZIKRHBp41BX2DbF2NLR2zlUnvEZy47CB+spgH
         k5rQ==
X-Gm-Message-State: AOAM530/SMAjtBVN7k0je+eSViXcsaEZULqEBJk1dnTuPKixWwmx4TsS
        +ShKWdAeBO42ZHb0wlF6D6sLAejGXJWxYoaKFgCCYm5V
X-Google-Smtp-Source: ABdhPJy/0F3WApf4o0bbt+R3FINgMZfgyIQp5GssRrPB0EH7gqldCtd7UOwt/2l+H3ILKhL82v6BJKw1F0qzPt2xUYw=
X-Received: by 2002:a92:490d:: with SMTP id w13mr4562006ila.250.1594730667559;
 Tue, 14 Jul 2020 05:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200702125744.10535-1-amir73il@gmail.com> <20200702125744.10535-6-amir73il@gmail.com>
 <20200714121329.GF23073@quack2.suse.cz>
In-Reply-To: <20200714121329.GF23073@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 14 Jul 2020 15:44:16 +0300
Message-ID: <CAOQ4uxhs2Hc-qr9or2tYLgPkoB-tQ4w-pr0qPSYa8qrvcD3rVQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] fsnotify: send MOVE_SELF event with parent/name info
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 3:13 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 02-07-20 15:57:39, Amir Goldstein wrote:
> > MOVE_SELF event does not get reported to a parent watching children
> > when a child is moved, but it can be reported to sb/mount mark with
> > parent/name info if group is interested in parent/name info.
> >
> > Use the fsnotify_parent() helper to send a MOVE_SELF event and adjust
> > fsnotify() to handle the case of an event "on child" that should not
> > be sent to the watching parent's inode mark.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fsnotify.c             | 21 +++++++++++++++++----
> >  include/linux/fsnotify.h         |  5 +----
> >  include/linux/fsnotify_backend.h |  2 +-
> >  3 files changed, 19 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index 6683c77a5b13..0faf5b09a73e 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -352,6 +352,7 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
> >       struct super_block *sb = to_tell->i_sb;
> >       struct inode *dir = S_ISDIR(to_tell->i_mode) ? to_tell : NULL;
> >       struct mount *mnt = NULL;
> > +     struct inode *inode = NULL;
> >       struct inode *child = NULL;
> >       int ret = 0;
> >       __u32 test_mask, marks_mask;
> > @@ -362,6 +363,14 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
> >       if (mask & FS_EVENT_ON_CHILD)
> >               child = fsnotify_data_inode(data, data_type);
> >
> > +     /*
> > +      * If event is "on child" then to_tell is a watching parent.
> > +      * An event "on child" may be sent to mount/sb mark with parent/name
> > +      * info, but not appropriate for watching parent (e.g. FS_MOVE_SELF).
> > +      */
> > +     if (!child || (mask & FS_EVENTS_POSS_ON_CHILD))
> > +             inode = to_tell;
>
> I'm now confused. Don't you want to fill in FSNOTIFY_OBJ_TYPE_INODE below
> for FS_MOVE_SELF event? But this condition is false for it so you won't do
> it?
>

I do not.
For events with the flag FS_EVENT_ON_CHILD, the inode in
FSNOTIFY_OBJ_TYPE_INODE is always the parent and the inode in
FSNOTIFY_OBJ_TYPE_CHILD is always the child.
So FS_MOVE_SELF will be reported if sb/mount are watching
or if child inode is watching, but NOT if only parent inode is watching.

I realize I may have been able to make other choices, but seemed like
the most consistent choice to me.
If you see a better option, let me know.

> > +
> >       /*
> >        * Optimization: srcu_read_lock() has a memory barrier which can
> >        * be expensive.  It protects walking the *_fsnotify_marks lists.
> > @@ -369,14 +378,17 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
> >        * SRCU because we have no references to any objects and do not
> >        * need SRCU to keep them "alive".
> >        */
> > -     if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
> > +     if (!sb->s_fsnotify_marks &&
> >           (!mnt || !mnt->mnt_fsnotify_marks) &&
> > +         (!inode || !inode->i_fsnotify_marks) &&
> >           (!child || !child->i_fsnotify_marks))
> >               return 0;
> >
> > -     marks_mask = to_tell->i_fsnotify_mask | sb->s_fsnotify_mask;
> > +     marks_mask = sb->s_fsnotify_mask;
> >       if (mnt)
> >               marks_mask |= mnt->mnt_fsnotify_mask;
> > +     if (inode)
> > +             marks_mask |= inode->i_fsnotify_mask;
> >       if (child)
> >               marks_mask |= child->i_fsnotify_mask;
> >
> > @@ -390,14 +402,15 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
> >
> >       iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
> >
> > -     iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
> > -             fsnotify_first_mark(&to_tell->i_fsnotify_marks);
> >       iter_info.marks[FSNOTIFY_OBJ_TYPE_SB] =
> >               fsnotify_first_mark(&sb->s_fsnotify_marks);
> >       if (mnt) {
> >               iter_info.marks[FSNOTIFY_OBJ_TYPE_VFSMOUNT] =
> >                       fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
> >       }
> > +     if (inode)
> > +             iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
> > +                     fsnotify_first_mark(&inode->i_fsnotify_marks);
> >       if (child) {
> >               iter_info.marks[FSNOTIFY_OBJ_TYPE_CHILD] =
> >                       fsnotify_first_mark(&child->i_fsnotify_marks);
> > diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> > index 044cae3a0628..61dccaf21e7b 100644
> > --- a/include/linux/fsnotify.h
> > +++ b/include/linux/fsnotify.h
> > @@ -131,7 +131,6 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
> >       u32 fs_cookie = fsnotify_get_cookie();
> >       __u32 old_dir_mask = FS_MOVED_FROM;
> >       __u32 new_dir_mask = FS_MOVED_TO;
> > -     __u32 mask = FS_MOVE_SELF;
> >       const struct qstr *new_name = &moved->d_name;
> >
> >       if (old_dir == new_dir)
> > @@ -140,7 +139,6 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
> >       if (isdir) {
> >               old_dir_mask |= FS_ISDIR;
> >               new_dir_mask |= FS_ISDIR;
> > -             mask |= FS_ISDIR;
> >       }
> >
> >       fsnotify_name(old_dir, old_dir_mask, source, old_name, fs_cookie);
> > @@ -149,8 +147,7 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
> >       if (target)
> >               fsnotify_link_count(target);
> >
> > -     if (source)
> > -             fsnotify(source, mask, source, FSNOTIFY_EVENT_INODE, NULL, 0);
> > +     fsnotify_dentry(moved, FS_MOVE_SELF);
>
> I'm somewhat unsure about this. Does this mean that 'moved' is guaranteed
> to be positive or that you've made sure that all the code below
> fsnotify_dentry() is actually fine with a negative dentry? I don't find
> either trivial to verify so some note in a changelog or maybe even a
> separate patch for this would be useful.
>

Oh, it's true. I should've mentioned it or separate this change.
I guess my reaction was the opposite of yours - it seemed obvious to
me that moved
dentry is positive - vfs_rename() is called under lock_rename() and it seemed
obvious to me that callers verified positive source, but in any case,
vfs_rename()
starts with may_delete() that verifies positive rename victim and
debugfs_rename(), the other caller of fsnotify_move() also verifies
positive victim.

I will add this information to the commit message.

Thanks,
Amir.
