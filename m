Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA35A2DFB2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 11:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgLUKpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 05:45:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:40598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgLUKpK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 05:45:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52188ADD6;
        Mon, 21 Dec 2020 10:44:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 06B2F1E1332; Mon, 21 Dec 2020 11:44:27 +0100 (CET)
Date:   Mon, 21 Dec 2020 11:44:26 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] inotify, memcg: account inotify instances to kmemcg
Message-ID: <20201221104426.GA13601@quack2.suse.cz>
References: <20201220044608.1258123-1-shakeelb@google.com>
 <CAOQ4uxi4b-zXfWhLNQ+aGWn2qG3vqMCjkJnhrugc0+oER1EjUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi4b-zXfWhLNQ+aGWn2qG3vqMCjkJnhrugc0+oER1EjUA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 20-12-20 13:32:46, Amir Goldstein wrote:
> On Sun, Dec 20, 2020 at 6:46 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > Currently the fs sysctl inotify/max_user_instances is used to limit the
> > number of inotify instances on the system. For systems running multiple
> > workloads, the per-user namespace sysctl max_inotify_instances can be
> > used to further partition inotify instances. However there is no easy
> > way to set a sensible system level max limit on inotify instances and
> > further partition it between the workloads. It is much easier to charge
> > the underlying resource (i.e. memory) behind the inotify instances to
> > the memcg of the workload and let their memory limits limit the number
> > of inotify instances they can create.
> >
> > With inotify instances charged to memcg, the admin can simply set
> > max_user_instances to INT_MAX and let the memcg limits of the jobs limit
> > their inotify instances.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

The patch looks good to me. Thanks for review Amir. I've picked the
patch to my tree although it's currently in flux as we're currently in the
middle of the merge window. So I won't push out the branch with the patch
yet since I plan on rebasing it on top of -rc1 anyway.

								Honza

> > Changes since v1:
> > - introduce fsnotify_alloc_user_group() and convert fanotify in addition
> >   to inotify to use that function. [suggested by Amir]
> >
> >  fs/notify/fanotify/fanotify_user.c |  2 +-
> >  fs/notify/group.c                  | 25 ++++++++++++++++++++-----
> >  fs/notify/inotify/inotify_user.c   |  4 ++--
> >  include/linux/fsnotify_backend.h   |  1 +
> >  4 files changed, 24 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index 3e01d8f2ab90..7e7afc2b62e1 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -976,7 +976,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
> >                 f_flags |= O_NONBLOCK;
> >
> >         /* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
> > -       group = fsnotify_alloc_group(&fanotify_fsnotify_ops);
> > +       group = fsnotify_alloc_user_group(&fanotify_fsnotify_ops);
> >         if (IS_ERR(group)) {
> >                 free_uid(user);
> >                 return PTR_ERR(group);
> > diff --git a/fs/notify/group.c b/fs/notify/group.c
> > index a4a4b1c64d32..ffd723ffe46d 100644
> > --- a/fs/notify/group.c
> > +++ b/fs/notify/group.c
> > @@ -111,14 +111,12 @@ void fsnotify_put_group(struct fsnotify_group *group)
> >  }
> >  EXPORT_SYMBOL_GPL(fsnotify_put_group);
> >
> > -/*
> > - * Create a new fsnotify_group and hold a reference for the group returned.
> > - */
> > -struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
> > +static struct fsnotify_group *__fsnotify_alloc_group(
> > +                               const struct fsnotify_ops *ops, gfp_t gfp)
> >  {
> >         struct fsnotify_group *group;
> >
> > -       group = kzalloc(sizeof(struct fsnotify_group), GFP_KERNEL);
> > +       group = kzalloc(sizeof(struct fsnotify_group), gfp);
> >         if (!group)
> >                 return ERR_PTR(-ENOMEM);
> >
> > @@ -139,8 +137,25 @@ struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
> >
> >         return group;
> >  }
> > +
> > +/*
> > + * Create a new fsnotify_group and hold a reference for the group returned.
> > + */
> > +struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
> > +{
> > +       return __fsnotify_alloc_group(ops, GFP_KERNEL);
> > +}
> >  EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
> >
> > +/*
> > + * Create a new fsnotify_group and hold a reference for the group returned.
> > + */
> > +struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops)
> > +{
> > +       return __fsnotify_alloc_group(ops, GFP_KERNEL_ACCOUNT);
> > +}
> > +EXPORT_SYMBOL_GPL(fsnotify_alloc_user_group);
> > +
> >  int fsnotify_fasync(int fd, struct file *file, int on)
> >  {
> >         struct fsnotify_group *group = file->private_data;
> > diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> > index 59c177011a0f..266d17e8ecb9 100644
> > --- a/fs/notify/inotify/inotify_user.c
> > +++ b/fs/notify/inotify/inotify_user.c
> > @@ -632,11 +632,11 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
> >         struct fsnotify_group *group;
> >         struct inotify_event_info *oevent;
> >
> > -       group = fsnotify_alloc_group(&inotify_fsnotify_ops);
> > +       group = fsnotify_alloc_user_group(&inotify_fsnotify_ops);
> >         if (IS_ERR(group))
> >                 return group;
> >
> > -       oevent = kmalloc(sizeof(struct inotify_event_info), GFP_KERNEL);
> > +       oevent = kmalloc(sizeof(struct inotify_event_info), GFP_KERNEL_ACCOUNT);
> >         if (unlikely(!oevent)) {
> >                 fsnotify_destroy_group(group);
> >                 return ERR_PTR(-ENOMEM);
> > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> > index a2e42d3cd87c..e5409b83e731 100644
> > --- a/include/linux/fsnotify_backend.h
> > +++ b/include/linux/fsnotify_backend.h
> > @@ -470,6 +470,7 @@ static inline void fsnotify_update_flags(struct dentry *dentry)
> >
> >  /* create a new group */
> >  extern struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops);
> > +extern struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops);
> >  /* get reference to a group */
> >  extern void fsnotify_get_group(struct fsnotify_group *group);
> >  /* drop reference on a group from fsnotify_alloc_group */
> > --
> > 2.29.2.684.gfbc64c5ab5-goog
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
