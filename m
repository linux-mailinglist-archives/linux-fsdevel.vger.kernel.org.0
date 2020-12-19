Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9B42DF006
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 15:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgLSOcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 09:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgLSOcY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 09:32:24 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050BAC0617B0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Dec 2020 06:31:43 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 23so12890760lfg.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Dec 2020 06:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kyAFwzY0sPrnnPQcN7auHtfffP0Y1D/Bikbys2O3tQI=;
        b=so/IspvkFIx0+OC4zmCqi3AlTKufixgh+l9yOc74SWSsNpazhaDsTppHLKBcnOOoQz
         PKKPWjQR8uL9kVRcAb6NiJVNmiqpQl4pfVGHQvGbO3BXWZyKqSdmIzNJ8NW04nutAPg2
         T89lb7v0IqHnSMaFebUInWKiBaOuQ3ordOJCts8OH4djRWlCN6cwgGnMb4Oxs/tssnX5
         Lzk3W2u5DXZ6rOOBFHT6AEAfrSHJbvTGBBI15t3BO4ExyW610iHksW8MkgIFXpJe+3no
         n8OcoUOvE6a3nPBQv9a5MDSTDsBn97SwL0fASm/xV6p5ZRjwrlyORVXh/95XLtr+JT4k
         Ss5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyAFwzY0sPrnnPQcN7auHtfffP0Y1D/Bikbys2O3tQI=;
        b=tK49pRqL3KXUAwnRcP+BvhgbM0FEZpQUzjbLARQK4egJJoBK74FzaKgknB1HDbE8ob
         KEKrhl2HpxPTNnd3G67VQkNLcCyslNLiDB5F0NDY/n8hMt/hdI/tnIfNc9HkmDRV4nv2
         25xlnP3Es8Tcq1FhA3NYvHvzDrRnNJJ3jCVGVuK5iHKDGsA4vTeKdIKwa54iBv2y5bmo
         V8BgGASz//EIH2bsk+k4AIg7D7GfXi6DfH9C2UnSDmQL6I1p/2YuUwHXuck1YwkLeNwk
         P6B4UDpLGnFRFgs/zwhBnjpMyQVFOf8Zn47uIUqihKnZCfE3nrZteP3MGk+Q+eLIYLfI
         Jl2Q==
X-Gm-Message-State: AOAM530bqZCEpnK/fdVfrfMT7DrJyD3psygrT2NG/nUT2juK68VNiCzw
        55caJWnICeyXWvMkL9JhRUxt3gO6p4u1omwiYBQaVg==
X-Google-Smtp-Source: ABdhPJznhnS8iYvsoqUIy90/Z6NcIECkctZNXvp53fRIxO8TdZXEXTxK1o8PzqRI2UlooOKdoY1eFJD58OhFcbrN7rY=
X-Received: by 2002:a19:644b:: with SMTP id b11mr3159483lfj.358.1608388302054;
 Sat, 19 Dec 2020 06:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20201218221129.851003-1-shakeelb@google.com> <CAOQ4uxiyd=N-mvYWHFx6Yq1LW1BPcriZw++MAyOGB_4CDkDKYA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiyd=N-mvYWHFx6Yq1LW1BPcriZw++MAyOGB_4CDkDKYA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 19 Dec 2020 06:31:31 -0800
Message-ID: <CALvZod6uT+bH7NqooEbqMLC6ppcbu-v=QDQRyTcfWGUsQodYjQ@mail.gmail.com>
Subject: Re: [PATCH] inotify, memcg: account inotify instances to kmemcg
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 19, 2020 at 1:48 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sat, Dec 19, 2020 at 12:11 AM Shakeel Butt <shakeelb@google.com> wrote:
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
>
> Not that I have a problem with this patch, but what problem does it try to
> solve?

I am aiming for the simplicity to not set another limit which can
indirectly be limited by memcg limits. I just want to set the memcg
limit on our production environment which runs multiple workloads on a
system and not think about setting a sensible value to
max_user_instances in production. I would prefer to set
max_user_instances to max int and let the memcg limits of the
workloads limit their inotify usage.

> Are you concerned of users depleting system memory by creating
> userns's and allocating 128 * (struct fsnotify_group) at a time?
>
> IMO, that is not what max_user_instances was meant to protect against.
> There are two reasons I can think of to limit user instances:
> 1. Pre-memgc, user allocation of events is limited to
>     <max_user_instances>*<max_queued_events>
> 2. Performance penalty. User can place <max_user_instances>
>     watches on the same "hot" directory, that will cause any access to
>     that directory by any task on the system to pay the penalty of traversing
>     <max_user_instances> marks and attempt to queue <max_user_instances>
>     events. That cost, including <max_user_instances> inotify_merge() loops
>     could be significant
>
> #1 is not a problem anymore, since you already took care of accounting events
> to the user's memcg.
> #2 is not addressed by your patch.

Yes, I am not addressing #2. Our workloads in prod have their own
private filesystems, so this is not an issue we observed.

>
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >  fs/notify/group.c                | 14 ++++++++++++--
> >  fs/notify/inotify/inotify_user.c |  5 +++--
> >  include/linux/fsnotify_backend.h |  2 ++
> >  3 files changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/notify/group.c b/fs/notify/group.c
> > index a4a4b1c64d32..fab3cfdb4d9e 100644
> > --- a/fs/notify/group.c
> > +++ b/fs/notify/group.c
> > @@ -114,11 +114,12 @@ EXPORT_SYMBOL_GPL(fsnotify_put_group);
> >  /*
> >   * Create a new fsnotify_group and hold a reference for the group returned.
> >   */
> > -struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
> > +struct fsnotify_group *fsnotify_alloc_group_gfp(const struct fsnotify_ops *ops,
> > +                                               gfp_t gfp)
> >  {
> >         struct fsnotify_group *group;
> >
> > -       group = kzalloc(sizeof(struct fsnotify_group), GFP_KERNEL);
> > +       group = kzalloc(sizeof(struct fsnotify_group), gfp);
> >         if (!group)
> >                 return ERR_PTR(-ENOMEM);
> >
> > @@ -139,6 +140,15 @@ struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
> >
> >         return group;
> >  }
> > +EXPORT_SYMBOL_GPL(fsnotify_alloc_group_gfp);
> > +
> > +/*
> > + * Create a new fsnotify_group and hold a reference for the group returned.
> > + */
> > +struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
> > +{
> > +       return fsnotify_alloc_group_gfp(ops, GFP_KERNEL);
> > +}
> >  EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
> >
> >  int fsnotify_fasync(int fd, struct file *file, int on)
> > diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> > index 59c177011a0f..7cb528c6154c 100644
> > --- a/fs/notify/inotify/inotify_user.c
> > +++ b/fs/notify/inotify/inotify_user.c
> > @@ -632,11 +632,12 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
> >         struct fsnotify_group *group;
> >         struct inotify_event_info *oevent;
> >
> > -       group = fsnotify_alloc_group(&inotify_fsnotify_ops);
> > +       group = fsnotify_alloc_group_gfp(&inotify_fsnotify_ops,
> > +                                        GFP_KERNEL_ACCOUNT);
> >         if (IS_ERR(group))
> >                 return group;
> >
> > -       oevent = kmalloc(sizeof(struct inotify_event_info), GFP_KERNEL);
> > +       oevent = kmalloc(sizeof(struct inotify_event_info), GFP_KERNEL_ACCOUNT);
> >         if (unlikely(!oevent)) {
> >                 fsnotify_destroy_group(group);
> >                 return ERR_PTR(-ENOMEM);
>
> Any reason why you did not include fanotify in this patch?

The motivation was inotify's max_user_instances but we can charge
fsnotify_group for fanotify as well. Though I would prefer that to be
a separate patch. Let me know what you prefer?

>
> Thanks,
> Amir.

Thanks for the review. I really appreciate your time.

Shakeel
