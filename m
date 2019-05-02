Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D19B120EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 19:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfEBRWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 13:22:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40903 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfEBRWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 13:22:31 -0400
Received: by mail-io1-f65.google.com with SMTP id m9so2874280iok.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVHnT7hS+jtT3CyJtyT3U+Tp35eXJOQlQwQcIaozN1k=;
        b=FLgcmPKzggLBQIsMH4re/H0qjoV0go8u3NnhOQTe3q6vtF7IZyqdZhxY2Frt/Uzr3D
         8he+fhuhfJhPyDhgiPSeR1tqXNPbHuTm7cZwA5xQzKPhBw8Q1Dc/1Io5z/6XN8T11+s9
         jr9cIJmfO1yOy7RVgVgwAZhMS+uQDzeU7Hfww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVHnT7hS+jtT3CyJtyT3U+Tp35eXJOQlQwQcIaozN1k=;
        b=tu7xoD+R63VT+pyH4TC5XeSw+SpScdovS7gqwDGrInDnOzHx8LhD0tK9AZ0LY1D5Jj
         keJBP9AWc0ocj4WkF4/ghHuw3hkE+vvYIOLG/wcEs2+bsPi/Z+bGHx4ZyTulAIGxNI2c
         NQlapaW2Z+OLtUZ6nrZmUNCUs+Sf1sV504Fkrg3sdmgpH//1bcjsiZ5VZq/NxH2/Bw8X
         Qw57U51JsyXRzhtsKmtHZQyp0zJ4NcREYtPTGwnBw3kVue3fBakS9dJjXydlI1k9ROfL
         raxNaBcSo2ZMXZYnUOv51lOxL4Z8ek3OkhyuBqBkFKGw3ffUApDmaLDOk9fZOsaXuIAq
         h4xA==
X-Gm-Message-State: APjAAAWFlI4ycRDzFU9vBT+FDPvUzVyua+GnynoIzNxECAl/6Gv6K3UP
        aQyMC9/51hvRbBgUxVZ9gCYVo2lZi6vMgkLsSUq2Fh7b
X-Google-Smtp-Source: APXvYqxRcQWDmHe7TCWgRcO75l9wTQKl4tNubQ/rdcxvg4G1z8dMoWm7dqyPzBWAwF9NM6opXmtOKPro585mJXhMVVA=
X-Received: by 2002:a6b:ee04:: with SMTP id i4mr3469718ioh.246.1556817750306;
 Thu, 02 May 2019 10:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190501205541.GC30899@veci.piliscsaba.redhat.com>
 <20190502143905.GA25032@quack2.suse.cz> <CAOQ4uxiLwwmOG0gtNDXng3O=hq3o0jAx66aXnSYV+T7UHtr=8A@mail.gmail.com>
 <20190502154137.GC25032@quack2.suse.cz>
In-Reply-To: <20190502154137.GC25032@quack2.suse.cz>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 2 May 2019 13:22:19 -0400
Message-ID: <CAJfpeguj6pPnm2C=PX+ZR0kHAis4YBQC0sWwve5cLW6RiJ9eLA@mail.gmail.com>
Subject: Re: [RFC PATCH] network fs notification
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Steve French <smfrench@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 11:41 AM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 02-05-19 11:08:41, Amir Goldstein wrote:
> > On Thu, May 2, 2019 at 10:39 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 01-05-19 16:55:41, Miklos Szeredi wrote:
> > > > This is a really really trivial first iteration, but I think it's enough to
> > > > try out CIFS notification support.  Doesn't deal with mark deletion, but
> > > > that's best effort anyway: fsnotify() will filter out unneeded events.
> > > >
> > > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > > ---
> > > >  fs/notify/fanotify/fanotify_user.c |    6 +++++-
> > > >  fs/notify/inotify/inotify_user.c   |    2 ++
> > > >  include/linux/fs.h                 |    1 +
> > > >  3 files changed, 8 insertions(+), 1 deletion(-)
> > > >
> > > > --- a/fs/notify/fanotify/fanotify_user.c
> > > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > > @@ -1041,9 +1041,13 @@ static int do_fanotify_mark(int fanotify
> > > >               else if (mark_type == FAN_MARK_FILESYSTEM)
> > > >                       ret = fanotify_add_sb_mark(group, mnt->mnt_sb, mask,
> > > >                                                  flags, fsid);
> > > > -             else
> > > > +             else {
> > > >                       ret = fanotify_add_inode_mark(group, inode, mask,
> > > >                                                     flags, fsid);
> > > > +
> > > > +                     if (!ret && inode->i_op->notify_update)
> > > > +                             inode->i_op->notify_update(inode);
> > > > +             }
> > >
> > > Yeah, so I had something like this in mind but I wanted to inform the
> > > filesystem about superblock and mountpoint marks as well. And I'd pass the
> > > 'mask' as well as presumably filesystem could behave differently depending
> > > on whether we are looking for create vs unlink vs file change events etc...

Hmm.  I'm not sure we need to pass the mask, since it's in the inode
filesystem can read it.  But this code is completely racy in this
respect and doesn't even include hooks in the delete notification.  So
it's basically just to try it out.

> >
> > It probably wouldn't hurt to update fs about mount marks,
> > but in the context of "remote" fs, the changes are most certainly
> > being done on a different mount, a different machine most likely...
>
> I agree. I guess I'm missing your point :) What I understood from Steve is
> that e.g. cifs could ask the server to provide the notifications. E.g. FUSE
> could propagate this information to userspace daemon which could place
> appropriate fsnotify marks on underlying objects and then transform the
> events to events on the FUSE filesystem? At least that's what I was
> imagining, didn't think too much about it.

Exactly.  For inode and superblock notification that's clear (don't
know if CIFS can do superblock notifications or not).  However, mount
notification is something that possibly means: notify me of any
changes made through this mount only.  I.e. if there's a bind mount
and the filesystem is modified through that, then we don't get the
mount notification for the original mount.  So I guess it makes sense
to say: if you want remote notifications, just use the superblock
notification.

Thanks,
Miklos
