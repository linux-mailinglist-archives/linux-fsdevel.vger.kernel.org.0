Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320642DF073
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 17:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgLSQ0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 11:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgLSQ0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 11:26:01 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED728C0617B0;
        Sat, 19 Dec 2020 08:25:20 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n4so4971653iow.12;
        Sat, 19 Dec 2020 08:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yrIFpdKx7YIVx/PDK+vupPWevNBDzPRwa4m63HE0cY=;
        b=OhmNUdyIQa2uofyblJk7bZaNoeWRU1df0sN8cyikYP/9u258Kjf+MiQJz3CrNeZ5AJ
         lGSLDJLYmqoCFwjG2Bra6sCM0eAuSm8Rf8Q5pEimcU+Jvm59M/pK3jGmsOK0hLSsySyz
         6/Hhajz9bcJzXyQgOa48qs8kFhYanvJRW9M7SnmLTZb2mOyXFlUe6Q8cUhnZxumuReuI
         med+6B2rai36zzb8wYeiz0b24C94OymfMa6VcF2MhfwS0osVFtvjlU+/kD6gOUPsmPMs
         Xg/FtySW1FrBLHY6NdPH/2ISXxfKf5kgVjY0llpfmV3Zlt9ZywMW7o059KVxxbMTAeMk
         huUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yrIFpdKx7YIVx/PDK+vupPWevNBDzPRwa4m63HE0cY=;
        b=jZvQIjLhOrRb6/Gk9puwphs95Wm/rvjZ6Jy1KGO+Z4b2Ex0yFKcY9WVa3QUoWaM/Lx
         A81Gwtz/DaB5Gzfcd80KNa/u8ufAd+p3H04YUxz5MtP1up5gEeWf1lqlEMr7Cmr1wxOq
         vQldL6ZY4IsiQ5BDrEbyqJ01AGpVWsM9wNWazt42PcBQDjj7uHL6rEwdYcON19kA2MmO
         0/8fiu2OQJ1rAYYzsKh3BLzDke0oQHCvG5rkUBrKUkYqZimJBbSv71RfqC4djDdTmaUO
         Aqhijm2FNJynJRL1EZEZNSfgYNoU/HfgDvjS8MOWqB3UR33D53tlWe+hT0OhejCxE63C
         S3Hw==
X-Gm-Message-State: AOAM5306PR2mB7fuhU1116tef54AsK/0ruiKln4AzgTfxP0QKvrwLkF1
        UpHqO82g0Yjl53DWow0NkNKKDWd+aJpFvorO02w=
X-Google-Smtp-Source: ABdhPJyOOHA1gyrkp7K79TUDdOmt6MrWbzI2dZAskGmo4htBClXaVctgTHHlPagQIPV58hSmVTWIx51zcC5s/DiB0Kk=
X-Received: by 2002:a05:6602:1608:: with SMTP id x8mr8718768iow.72.1608395120279;
 Sat, 19 Dec 2020 08:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20201218221129.851003-1-shakeelb@google.com> <CAOQ4uxiyd=N-mvYWHFx6Yq1LW1BPcriZw++MAyOGB_4CDkDKYA@mail.gmail.com>
 <CALvZod6uT+bH7NqooEbqMLC6ppcbu-v=QDQRyTcfWGUsQodYjQ@mail.gmail.com>
In-Reply-To: <CALvZod6uT+bH7NqooEbqMLC6ppcbu-v=QDQRyTcfWGUsQodYjQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 19 Dec 2020 18:25:08 +0200
Message-ID: <CAOQ4uxh3vEBMs8afudFU3zxKLpcKG7KuWEGkLiH0hioncum1UA@mail.gmail.com>
Subject: Re: [PATCH] inotify, memcg: account inotify instances to kmemcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 19, 2020 at 4:31 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Sat, Dec 19, 2020 at 1:48 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Sat, Dec 19, 2020 at 12:11 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > Currently the fs sysctl inotify/max_user_instances is used to limit the
> > > number of inotify instances on the system. For systems running multiple
> > > workloads, the per-user namespace sysctl max_inotify_instances can be
> > > used to further partition inotify instances. However there is no easy
> > > way to set a sensible system level max limit on inotify instances and
> > > further partition it between the workloads. It is much easier to charge
> > > the underlying resource (i.e. memory) behind the inotify instances to
> > > the memcg of the workload and let their memory limits limit the number
> > > of inotify instances they can create.
> >
> > Not that I have a problem with this patch, but what problem does it try to
> > solve?
>
> I am aiming for the simplicity to not set another limit which can
> indirectly be limited by memcg limits. I just want to set the memcg
> limit on our production environment which runs multiple workloads on a
> system and not think about setting a sensible value to
> max_user_instances in production. I would prefer to set
> max_user_instances to max int and let the memcg limits of the
> workloads limit their inotify usage.
>

understood.
and I guess the multiple workloads cannot run each in their own userns?
because then you wouldn't need to change max_user_instances limit.

> > Are you concerned of users depleting system memory by creating
> > userns's and allocating 128 * (struct fsnotify_group) at a time?
> >
> > IMO, that is not what max_user_instances was meant to protect against.
> > There are two reasons I can think of to limit user instances:
> > 1. Pre-memgc, user allocation of events is limited to
> >     <max_user_instances>*<max_queued_events>
> > 2. Performance penalty. User can place <max_user_instances>
> >     watches on the same "hot" directory, that will cause any access to
> >     that directory by any task on the system to pay the penalty of traversing
> >     <max_user_instances> marks and attempt to queue <max_user_instances>
> >     events. That cost, including <max_user_instances> inotify_merge() loops
> >     could be significant
> >
> > #1 is not a problem anymore, since you already took care of accounting events
> > to the user's memcg.
> > #2 is not addressed by your patch.
>
> Yes, I am not addressing #2. Our workloads in prod have their own
> private filesystems, so this is not an issue we observed.
>
> >
> > >
> > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > ---
> > >  fs/notify/group.c                | 14 ++++++++++++--
> > >  fs/notify/inotify/inotify_user.c |  5 +++--
> > >  include/linux/fsnotify_backend.h |  2 ++
> > >  3 files changed, 17 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/notify/group.c b/fs/notify/group.c
> > > index a4a4b1c64d32..fab3cfdb4d9e 100644
> > > --- a/fs/notify/group.c
> > > +++ b/fs/notify/group.c
> > > @@ -114,11 +114,12 @@ EXPORT_SYMBOL_GPL(fsnotify_put_group);
> > >  /*
> > >   * Create a new fsnotify_group and hold a reference for the group returned.
> > >   */
> > > -struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
> > > +struct fsnotify_group *fsnotify_alloc_group_gfp(const struct fsnotify_ops *ops,
> > > +                                               gfp_t gfp)
> > >  {
> > >         struct fsnotify_group *group;
> > >
> > > -       group = kzalloc(sizeof(struct fsnotify_group), GFP_KERNEL);
> > > +       group = kzalloc(sizeof(struct fsnotify_group), gfp);
> > >         if (!group)
> > >                 return ERR_PTR(-ENOMEM);
> > >
> > > @@ -139,6 +140,15 @@ struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
> > >
> > >         return group;
> > >  }
> > > +EXPORT_SYMBOL_GPL(fsnotify_alloc_group_gfp);
> > > +
> > > +/*
> > > + * Create a new fsnotify_group and hold a reference for the group returned.
> > > + */
> > > +struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
> > > +{
> > > +       return fsnotify_alloc_group_gfp(ops, GFP_KERNEL);
> > > +}
> > >  EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
> > >
> > >  int fsnotify_fasync(int fd, struct file *file, int on)
> > > diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> > > index 59c177011a0f..7cb528c6154c 100644
> > > --- a/fs/notify/inotify/inotify_user.c
> > > +++ b/fs/notify/inotify/inotify_user.c
> > > @@ -632,11 +632,12 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
> > >         struct fsnotify_group *group;
> > >         struct inotify_event_info *oevent;
> > >
> > > -       group = fsnotify_alloc_group(&inotify_fsnotify_ops);
> > > +       group = fsnotify_alloc_group_gfp(&inotify_fsnotify_ops,
> > > +                                        GFP_KERNEL_ACCOUNT);
> > >         if (IS_ERR(group))
> > >                 return group;
> > >
> > > -       oevent = kmalloc(sizeof(struct inotify_event_info), GFP_KERNEL);
> > > +       oevent = kmalloc(sizeof(struct inotify_event_info), GFP_KERNEL_ACCOUNT);
> > >         if (unlikely(!oevent)) {
> > >                 fsnotify_destroy_group(group);
> > >                 return ERR_PTR(-ENOMEM);
> >
> > Any reason why you did not include fanotify in this patch?
>
> The motivation was inotify's max_user_instances but we can charge
> fsnotify_group for fanotify as well. Though I would prefer that to be
> a separate patch. Let me know what you prefer?
>

I would prefer to add the helper fsnotify_alloc_user_group()
that will use the GFP_KERNEL_ACCOUNT allocation flags
internally.

fsnotify_alloc_group() is used by all backends that initialize a single
group instance for internal use and  fsnotify_alloc_user_group() will be
used by inotify/fanotify when users create instances.
I see no reason to separate that to two patches.

Thanks,
Amir.
