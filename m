Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0093A11C34
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 17:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfEBPIy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 11:08:54 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39319 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBPIy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 11:08:54 -0400
Received: by mail-yw1-f66.google.com with SMTP id x204so1814690ywg.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqMffDWXPbkTYXOIBLsJNd+7CEmQumG8SUdlx8ggtc0=;
        b=vC4wZGu2IpVydbPCSH9vHrpqk8meiMYppOXxYoPwqm7VjAywlTAIqtXFNNV6+zMJDv
         UWxbsKqbE7Kb7Z4x1ZjURc0quvxhkL+Cq+2Y3Sg6vajFUO0jEmSFITVf0APBYE3jG3vA
         DMhEjr4vZ7+2RyZrk4DGL0OthF3iXObSJCWC3CqLGV+iEj48VqDekbqDOuig2/QKcBiX
         Gm8pmjgX+aB7/0il9s2+E8l0negisHbq545NhESDWqwB/H6ASVeHjXB1k9G+iB5HePi2
         mvWENmiWbPZc4FyEgJtEtN72+m+sGKt/bXqt99hnTFlVs1HLXE9y0N1Z9kztTkLWy6vP
         MATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqMffDWXPbkTYXOIBLsJNd+7CEmQumG8SUdlx8ggtc0=;
        b=RUxlIfwZbaYUuYvzqM2LR1Je4+gWmKkE7Wj04Cs7UWMM0xFMGxPWZxcDL4mognwTW1
         nq620JL/Z3lWWz++L+oXEzVwj6sTREPb+bIkMx71PeY9WCGVillcKLOTSHUnF50bkg4l
         RAdJZaGh9wt3k1TtZ++241weYIv2Caq6E28as3Zk1EolVFy3MNxOV314IKkbELZtEs9R
         jxaz7df2EUrKMhiQSh/y/mnWGnVLVmqMrVPiEwj4DpWkKtFu8YaYio6yhAIETdWQMOkc
         H4O54eNVky9wFx8fyQRG589pjWkulhOCD3vMNDGsEsgCKM/BPdRItV58QCiZtULD41yI
         bDSg==
X-Gm-Message-State: APjAAAW0Vs/I8qt3LwI5vl6B5RQ6CREv/PH+F2C3cWWvSwLKUbhacuir
        Ex0qrjzqv8WP9EVQUEVqcGDAXa7AA4odyotz/rY=
X-Google-Smtp-Source: APXvYqwCR58QzycDRUxQQ1hl8P0btB4wDeWX3RWnOY7WHU+aV1E6OKHY1ZpCV/IkBF4QeqRbAPzeyYoPbV3cWasAwTs=
X-Received: by 2002:a0d:ff82:: with SMTP id p124mr3747501ywf.409.1556809732891;
 Thu, 02 May 2019 08:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190501205541.GC30899@veci.piliscsaba.redhat.com> <20190502143905.GA25032@quack2.suse.cz>
In-Reply-To: <20190502143905.GA25032@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 2 May 2019 11:08:41 -0400
Message-ID: <CAOQ4uxiLwwmOG0gtNDXng3O=hq3o0jAx66aXnSYV+T7UHtr=8A@mail.gmail.com>
Subject: Re: [RFC PATCH] network fs notification
To:     Jan Kara <jack@suse.cz>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <smfrench@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 10:39 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 01-05-19 16:55:41, Miklos Szeredi wrote:
> > This is a really really trivial first iteration, but I think it's enough to
> > try out CIFS notification support.  Doesn't deal with mark deletion, but
> > that's best effort anyway: fsnotify() will filter out unneeded events.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/notify/fanotify/fanotify_user.c |    6 +++++-
> >  fs/notify/inotify/inotify_user.c   |    2 ++
> >  include/linux/fs.h                 |    1 +
> >  3 files changed, 8 insertions(+), 1 deletion(-)
> >
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -1041,9 +1041,13 @@ static int do_fanotify_mark(int fanotify
> >               else if (mark_type == FAN_MARK_FILESYSTEM)
> >                       ret = fanotify_add_sb_mark(group, mnt->mnt_sb, mask,
> >                                                  flags, fsid);
> > -             else
> > +             else {
> >                       ret = fanotify_add_inode_mark(group, inode, mask,
> >                                                     flags, fsid);
> > +
> > +                     if (!ret && inode->i_op->notify_update)
> > +                             inode->i_op->notify_update(inode);
> > +             }
>
> Yeah, so I had something like this in mind but I wanted to inform the
> filesystem about superblock and mountpoint marks as well. And I'd pass the
> 'mask' as well as presumably filesystem could behave differently depending
> on whether we are looking for create vs unlink vs file change events etc...
>

It probably wouldn't hurt to update fs about mount marks,
but in the context of "remote" fs, the changes are most certainly
being done on a different mount, a different machine most likely...

Thanks,
Amir.
