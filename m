Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB4CC44724
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbfFMQ5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:57:21 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35157 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732430AbfFMQ5U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:57:20 -0400
Received: by mail-yb1-f196.google.com with SMTP id v17so8128977ybm.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fEjnMzfA3Hv1ozzthCse/fQV+F5H9Bjmjys7If1K+ZQ=;
        b=GRoD/Oz9s/SMjATDeRqd+McD5yeHRXzYd3k5crBTXdaXxD1cwG+h5YBfaWeYObjoQ6
         OzfNtWLpaYtA2e1fLIPBaG6c403qYDA9mHpUTzAuxG9G3O/789UsgUV+DQpWCz46Ohz8
         sXkStCerG5vjXybbnZ6FogN77H5c8O31XmNk8q/dM6reFdZDDDAblfB/Jq3Lxf47d/kq
         C74S5jnP1fpIGxTPch1cWHdgMrprXk6WKDMFkhowpG+Mj2vWgEVabnqvpW2SlQKURUU6
         rg+2YFQz+KsYMY4Yfo5r7z94HOWawfahOG6af/BtFbUpdxjBraN2HkFCBsF/I32nerkI
         tUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fEjnMzfA3Hv1ozzthCse/fQV+F5H9Bjmjys7If1K+ZQ=;
        b=RilozdBe313NMJRANKKLGxbxQRhnGuJlWubZDmKKinmoCjxtmgPtLVbqtpG22fMhpZ
         3auINFZaJhPGyWcm8hwG9bvlOTDVgpq44Rkp3iT1yCnie1E08Nq+VjJIEVsrvyseW1n0
         lQ3gY6RINXIc+z1XoWsfEwuyA6+iOmw+oxmiSPzpr1iyPLYACOyZT0QKLq6/I0xxIzeW
         ZIus1E7AfF2KYhmPZzcskh95C7jBAUgR0TogoFU7zaqRE1MdTXyyXnwMxBOrlnFHFfIn
         IgYjb0BQ8qpK9o0TOmFRqkxkuFfHBycIk9z03OeV6Ng9Rqd/1JYYo5/a/KXjhEIcH3ZS
         4gLA==
X-Gm-Message-State: APjAAAXPWh7JSwp4IicdGVTpR1gernee1NyOdel21Xfk8NJBdf1iuf74
        OVODNFRRlgnCRJ6kLx9drFEUs25mC+VtbNcBIdI=
X-Google-Smtp-Source: APXvYqxu9GKAm29nyl5U0qBIi/xI22YgFenFXuqCo+Vf+7wU+9qGldWegftYnXJrmlw+qzb1Pl2uqydbcJmLZcRWjCk=
X-Received: by 2002:a25:d946:: with SMTP id q67mr42216892ybg.126.1560445039670;
 Thu, 13 Jun 2019 09:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190526143411.11244-1-amir73il@gmail.com> <20190526143411.11244-9-amir73il@gmail.com>
 <CAOQ4uxi+1xQW5eoH7r18DHjvQQyKeMGq2Qtbe1hcxtcmqA_hAg@mail.gmail.com>
In-Reply-To: <CAOQ4uxi+1xQW5eoH7r18DHjvQQyKeMGq2Qtbe1hcxtcmqA_hAg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 13 Jun 2019 19:57:08 +0300
Message-ID: <CAOQ4uxiCOa0+wKwaVrg=0_Gyc5yxhkutOCP6rFFrXN+b8G_WnQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] configfs: call fsnotify_rmdir() hook
To:     Christoph Hellwig <hch@lst.de>, Joel Becker <jlbec@evilplan.org>,
        Jan Kara <jack@suse.cz>
Cc:     David Sterba <dsterba@suse.com>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 30, 2019 at 9:06 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sun, May 26, 2019 at 5:34 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > This will allow generating fsnotify delete events on unregister
> > of group/subsystem after the fsnotify_nameremove() hook is removed
> > from d_delete().
> >
> > The rest of the d_delete() calls from this filesystem are either
> > called recursively from within debugfs_unregister_{group,subsystem},
> > called from a vfs function that already has delete hooks or are
> > called from shutdown/cleanup code.
> >
> > Cc: Joel Becker <jlbec@evilplan.org>
> > Cc: Christoph Hellwig <hch@lst.de>
>
> Hi Christoph and Joel,
>
> Per Christoph's request, I cc'ed you guys on the entire patch series
> for context,
> so my discussion with Greg [1] about the special status of configfs in
> this patch set
> should already be somewhere in your mailboxes...
>
> Could I ask you to provide an ACK on this patch and on the chosen

PING.
Any comment from configfs maintainers?

Jan,

We can also drop this patch from the series given that configs has no
explicit fsnotify create hooks. If users come shouting, we can add
the missing create and delete hooks.

Thanks,
Amir.

> policy. To recap:
> Before patch set:
> 1. User gets create/delete events when files/dirs created/removed via vfs_*()
> 2. User does *not* get create events when files/dirs created via
> debugfs_register_*()
> 3. User *does* get delete events when files/dirs removed via
> debugfs_unregister_*()
>
> After patch set:
> 1. No change
> 2. No change
> 3. User will get delete events only on the root group/subsystem dir
> when tree is removed via debugfs_unregister_*()
>
> For symmetry, we could also add create events for  root group/subsystem dir
> when tree is created via debugfs_unregister_*(), but that would be a
> followup patch.
> For users though, it may be that delete events are more important than
> create events
> (i.e. for user cleanup tasks).
>
> Thanks,
> Amir.
>
> [1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjyg5AVPrcR4bPm4zMY9BKmgV8g7TAuH--cfKNJv8pRYQ@mail.gmail.com/
>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/configfs/dir.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> > index 5e7932d668ab..ba17881a8d84 100644
> > --- a/fs/configfs/dir.c
> > +++ b/fs/configfs/dir.c
> > @@ -27,6 +27,7 @@
> >  #undef DEBUG
> >
> >  #include <linux/fs.h>
> > +#include <linux/fsnotify.h>
> >  #include <linux/mount.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> > @@ -1804,6 +1805,7 @@ void configfs_unregister_group(struct config_group *group)
> >         configfs_detach_group(&group->cg_item);
> >         d_inode(dentry)->i_flags |= S_DEAD;
> >         dont_mount(dentry);
> > +       fsnotify_rmdir(d_inode(parent), dentry);
> >         d_delete(dentry);
> >         inode_unlock(d_inode(parent));
> >
> > @@ -1932,6 +1934,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
> >         configfs_detach_group(&group->cg_item);
> >         d_inode(dentry)->i_flags |= S_DEAD;
> >         dont_mount(dentry);
> > +       fsnotify_rmdir(d_inode(root), dentry);
> >         inode_unlock(d_inode(dentry));
> >
> >         d_delete(dentry);
> > --
> > 2.17.1
> >
