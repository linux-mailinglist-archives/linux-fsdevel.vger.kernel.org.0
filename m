Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1629B11EE0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfEBPlm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 11:41:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:42662 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728236AbfEBPll (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 11:41:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B7C1AC63;
        Thu,  2 May 2019 15:41:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E81C81E0D71; Thu,  2 May 2019 17:41:37 +0200 (CEST)
Date:   Thu, 2 May 2019 17:41:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <smfrench@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] network fs notification
Message-ID: <20190502154137.GC25032@quack2.suse.cz>
References: <20190501205541.GC30899@veci.piliscsaba.redhat.com>
 <20190502143905.GA25032@quack2.suse.cz>
 <CAOQ4uxiLwwmOG0gtNDXng3O=hq3o0jAx66aXnSYV+T7UHtr=8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiLwwmOG0gtNDXng3O=hq3o0jAx66aXnSYV+T7UHtr=8A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 02-05-19 11:08:41, Amir Goldstein wrote:
> On Thu, May 2, 2019 at 10:39 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 01-05-19 16:55:41, Miklos Szeredi wrote:
> > > This is a really really trivial first iteration, but I think it's enough to
> > > try out CIFS notification support.  Doesn't deal with mark deletion, but
> > > that's best effort anyway: fsnotify() will filter out unneeded events.
> > >
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > ---
> > >  fs/notify/fanotify/fanotify_user.c |    6 +++++-
> > >  fs/notify/inotify/inotify_user.c   |    2 ++
> > >  include/linux/fs.h                 |    1 +
> > >  3 files changed, 8 insertions(+), 1 deletion(-)
> > >
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -1041,9 +1041,13 @@ static int do_fanotify_mark(int fanotify
> > >               else if (mark_type == FAN_MARK_FILESYSTEM)
> > >                       ret = fanotify_add_sb_mark(group, mnt->mnt_sb, mask,
> > >                                                  flags, fsid);
> > > -             else
> > > +             else {
> > >                       ret = fanotify_add_inode_mark(group, inode, mask,
> > >                                                     flags, fsid);
> > > +
> > > +                     if (!ret && inode->i_op->notify_update)
> > > +                             inode->i_op->notify_update(inode);
> > > +             }
> >
> > Yeah, so I had something like this in mind but I wanted to inform the
> > filesystem about superblock and mountpoint marks as well. And I'd pass the
> > 'mask' as well as presumably filesystem could behave differently depending
> > on whether we are looking for create vs unlink vs file change events etc...
> >
> 
> It probably wouldn't hurt to update fs about mount marks,
> but in the context of "remote" fs, the changes are most certainly
> being done on a different mount, a different machine most likely...

I agree. I guess I'm missing your point :) What I understood from Steve is
that e.g. cifs could ask the server to provide the notifications. E.g. FUSE
could propagate this information to userspace daemon which could place
appropriate fsnotify marks on underlying objects and then transform the
events to events on the FUSE filesystem? At least that's what I was
imagining, didn't think too much about it.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
