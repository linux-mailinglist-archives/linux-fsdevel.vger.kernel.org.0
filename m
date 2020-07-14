Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7680B21F632
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 17:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgGNPbY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 11:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgGNPbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:31:23 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FCDC061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 08:31:23 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x9so14555262ila.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 08:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUfHk7qDczXDe39Rw2AAnj5x4ddaYogD2wPKePA2rMA=;
        b=Mo/NF3SD+ETHuMrfrLJdZ0KLQZQRoTXMuisyns4cdFhaimiDxo2gqcfprWIcyYX+iu
         +HrM89zCNHJ3caaoLxwqQk1O63wYcAW8EIj2gBkQciU0+CA29qjeq+1Bd2SBo/RbkjpN
         M5I9bNm8q1lm7riLZ5YnKy83pgLZ1NoogqXiiXRoZywcwM99xt8yV/AiuGcCXYtRGwhT
         aYgo+aaSgYO1kLY270ixHvpUXmY0ZKQYBCnCjscgK5h/IEC0v0wPegTgvAA5k9rKcYmQ
         JmrNnHzhkD88Xm9o6XwnQLKw0X8WesonfD0tG0V+uTyXolS2RJezqLwkJqROMgkc3+Gt
         D9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUfHk7qDczXDe39Rw2AAnj5x4ddaYogD2wPKePA2rMA=;
        b=TCmuTlbTCyp/dI0bAZGS9KIFqBfv6XOHhbxQPpi06uErkyNKg1+IEwTq/WeydKgmpl
         81Sg3xmaAezsDQPRDzBLKMd8uSQxUYf6CFHrL84Uhtzsfs6+T6tkNr5DHIUMfcnH4FQP
         fSPerIK6xd5EgTRtYszVfAplt5y9qOyChl9HY/OLRpKWkvKaae9tx/uyu4yTwpc4+FH3
         OCy7RsPc4Q9BZAdwq+ahCA/KAxaD6VUaUH1K0CoSJAOaJ0YAHL6SFxclczwATlqRuhkY
         hvVzwWtroYgHGDRAA9FnrILsYfCz11RjkYn4GbT3nQdEw2c0mh/U32eml6wau/ZzyK14
         9OoQ==
X-Gm-Message-State: AOAM531EavjltqARJU6BFgk0zyB3BJ6MfE063MC78mZUAk9Cg2+EcV2C
        iMEujmSllCr6q8S9pqGwHdrR9N603BTRFxVXrh4=
X-Google-Smtp-Source: ABdhPJx279wkGTrow5KlAdsNm4M8XixHLr7ehZgXQEDk21L/1uzJZ92qHqG6U6sCFk622aeKkFhWV0tbjjkg4pa00ik=
X-Received: by 2002:a92:490d:: with SMTP id w13mr5244352ila.250.1594740682611;
 Tue, 14 Jul 2020 08:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200702125744.10535-1-amir73il@gmail.com> <20200702125744.10535-5-amir73il@gmail.com>
 <20200714115451.GE23073@quack2.suse.cz> <CAOQ4uxjKj=S6s_L2m4d65PEha+H-MCHUmiozx42NAs1K40ZfXw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjKj=S6s_L2m4d65PEha+H-MCHUmiozx42NAs1K40ZfXw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 14 Jul 2020 18:31:11 +0300
Message-ID: <CAOQ4uxi2aS_XnQcX1t54VekUF49aWC8mNgjb2L9JdBhjTAPBoA@mail.gmail.com>
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

> > > +     const struct path *path = fsnotify_data_path(data, data_type);
> > > +     struct mount *mnt = path ? real_mount(path->mnt) : NULL;
> > >       struct inode *inode = d_inode(dentry);
> > >       struct dentry *parent;
> > > +     bool parent_watched = dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED;
> > > +     __u32 p_mask, test_mask, marks_mask = 0;
> > >       struct inode *p_inode;
> > >       int ret = 0;
> > >
> > > +     /*
> > > +      * Do inode/sb/mount care about parent and name info on non-dir?
> > > +      * Do they care about any event at all?
> > > +      */
> > > +     if (!inode->i_fsnotify_marks && !inode->i_sb->s_fsnotify_marks &&
> > > +         (!mnt || !mnt->mnt_fsnotify_marks)) {
> > > +             if (!parent_watched)
> > > +                     return 0;
> > > +     } else if (!(mask & FS_ISDIR) && !IS_ROOT(dentry)) {
> > > +             marks_mask |= fsnotify_want_parent(inode->i_fsnotify_mask);
> > > +             marks_mask |= fsnotify_want_parent(inode->i_sb->s_fsnotify_mask);
> > > +             if (mnt)
> > > +                     marks_mask |= fsnotify_want_parent(mnt->mnt_fsnotify_mask);
> > > +     }
> >
> > OK, so AFAIU at this point (mask & marks_mask) tells us whether we need to
> > grab parent because some mark needs parent into reported. Correct?
> >
> > Maybe I'd rename fsnotify_want_parent() (which seems like it returns bool)
> > to fsnotify_parent_needed_mask() or something like that. Also I'd hide all
> > those checks in a helper function like:
> >
> >         fsnotify_event_needs_parent(mnt, inode, mask)
> >
> > So we'd then have just something like:
> >         if (!inode->i_fsnotify_marks && !inode->i_sb->s_fsnotify_marks &&
> >             (!mnt || !mnt->mnt_fsnotify_marks) && !parent_watched)
> >                 return 0;
> >         if (!parent_watched && !fsnotify_event_needs_parent(mnt, inode, mask))
> >                 goto notify_child;
>
> OK, but we'd still need to store marks_mask for later in case event
> needs parent.
>

Nevermind, I understand now what you meant.
Changed the function according to your guidance and looks much better.
Fits now in one terminal screen :-)

>
> >         ...
> >
> > > +
> > >       parent = NULL;
> > > -     if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
> > > +     test_mask = mask & FS_EVENTS_POSS_TO_PARENT;
> > > +     if (!(marks_mask & test_mask) && !parent_watched)
> > >               goto notify_child;
> > >
> > > +     /* Does parent inode care about events on children? */
> > >       parent = dget_parent(dentry);
> > >       p_inode = parent->d_inode;
> > > +     p_mask = fsnotify_inode_watches_children(p_inode);
> > >
> > > -     if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
> > > +     if (p_mask)
> > > +             marks_mask |= p_mask;
> > > +     else if (unlikely(parent_watched))
> > >               __fsnotify_update_child_dentry_flags(p_inode);
> > > -     } else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
> > > +
> > > +     if ((marks_mask & test_mask) && p_inode != inode) {
> >                                         ^^ this is effectively
> > !IS_ROOT(dentry), isn't it? But since you've checked that above can it ever
> > be that p_inode == inode?
> >
>
> True, but only if you add the hidden assumption (which should be true) that
> DCACHE_FSNOTIFY_PARENT_WATCHED cannot be set on an IS_ROOT
> dentry. Otherwise you can have parent_watched and not check IS_ROOT()
> so prefered defensive here, but I don't mind dropping it.
>

I dropped this and also dropped the IS_ROOT(dentry) check because
there is already a check in the inline fsnotify_parent().

FYI, pushed these changes to branch fsnotify_name.
Rebased/tested/pushed branch fanotify_name_fid on top.
There are no changes to following patches as they are all
fanotify patches.

Thanks,
Amir.
