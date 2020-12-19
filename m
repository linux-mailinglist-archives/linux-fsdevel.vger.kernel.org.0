Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547A12DEE0B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 10:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgLSJtd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 04:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbgLSJtc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 04:49:32 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08351C0617B0;
        Sat, 19 Dec 2020 01:48:52 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id k8so4506727ilr.4;
        Sat, 19 Dec 2020 01:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfGvnUgrwCW53SrhDS2DbeVCGuni7enrdbWnfiDJQOo=;
        b=fEEeNbEe37auHYpkISMemSM72YLICf4geOnLz4JvaVJiJkWIU6brmaJhqFdqmk1xgP
         3bjfGT3T1vxMFqh6cCusXn2s+QAq5RTWvnOyoFHeLniyGgiEmX8Z2ivhZG6mYF4JCy33
         CLsDWHDVlSPcEsSUxi1k9rWcdeuhh1IRIUnyssoUYcfTsBIZ1ZcY9JFE86xzNVdBfCRk
         yaT6Xbezm5jP3eXCogfPaClpYV+GMta84XnloDRjujHpq6GhOt4bciMNme5JY1UaCJGT
         gZ5cEeBM1M1vwQON7ol0daUFOCHE2aSbwQYjkzs5N6cbZXg0JFvJLgzlMzvwA2C9KaMF
         Zf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfGvnUgrwCW53SrhDS2DbeVCGuni7enrdbWnfiDJQOo=;
        b=MfFDv7hEwqBnY1nTVDLHr1eNwCqlBevrWPd5cRCrLTRCo2CWRtaQcgQTLvkuxf+q6Q
         zr98H+p4U0qclUNU1BikduwP21J3TROOeH5eauvTAgr6YF1QMT49KezzDneSmf94ivVH
         gprW6AScXQNt8Z5TpRpPCj8uxgx9Jew5yPFe7lVTCimtBxKuuLZ+WdxzOmGzSuHe6T8i
         MbmAXBWxi6PTQ4gAU/ykeg+brR+CkB472ygelM6+sPnMFCHBoz2pOG/gD1VbGN26fkzR
         ZqZ44vHXzLlSLAhyeCG8p3uKkyokR4WLgei7/RMnz1th2ctef7KxGROCn1rHBYSD9ZIx
         YB5Q==
X-Gm-Message-State: AOAM533U7M6En5Hq0/eHL+5P9YWLhZ1X35MHIIUdkI4E5z0YLBHWh4oA
        4MEtnLd0nUtN9vQ2o+4aFrXuv+Lj6coPPaumDFpd30pg7xY=
X-Google-Smtp-Source: ABdhPJxoSpq2DeABvrvIUDgEyP2RORo0sn44qbYTMofch0xM/u2Xks9tpSI3FWS6XQFAJZRoYywmdLOGj+zw2+KDkSE=
X-Received: by 2002:a92:da82:: with SMTP id u2mr8406011iln.137.1608371331279;
 Sat, 19 Dec 2020 01:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20201218221129.851003-1-shakeelb@google.com>
In-Reply-To: <20201218221129.851003-1-shakeelb@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 19 Dec 2020 11:48:40 +0200
Message-ID: <CAOQ4uxiyd=N-mvYWHFx6Yq1LW1BPcriZw++MAyOGB_4CDkDKYA@mail.gmail.com>
Subject: Re: [PATCH] inotify, memcg: account inotify instances to kmemcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 19, 2020 at 12:11 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> Currently the fs sysctl inotify/max_user_instances is used to limit the
> number of inotify instances on the system. For systems running multiple
> workloads, the per-user namespace sysctl max_inotify_instances can be
> used to further partition inotify instances. However there is no easy
> way to set a sensible system level max limit on inotify instances and
> further partition it between the workloads. It is much easier to charge
> the underlying resource (i.e. memory) behind the inotify instances to
> the memcg of the workload and let their memory limits limit the number
> of inotify instances they can create.

Not that I have a problem with this patch, but what problem does it try to
solve? Are you concerned of users depleting system memory by creating
userns's and allocating 128 * (struct fsnotify_group) at a time?

IMO, that is not what max_user_instances was meant to protect against.
There are two reasons I can think of to limit user instances:
1. Pre-memgc, user allocation of events is limited to
    <max_user_instances>*<max_queued_events>
2. Performance penalty. User can place <max_user_instances>
    watches on the same "hot" directory, that will cause any access to
    that directory by any task on the system to pay the penalty of traversing
    <max_user_instances> marks and attempt to queue <max_user_instances>
    events. That cost, including <max_user_instances> inotify_merge() loops
    could be significant

#1 is not a problem anymore, since you already took care of accounting events
to the user's memcg.
#2 is not addressed by your patch.

>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  fs/notify/group.c                | 14 ++++++++++++--
>  fs/notify/inotify/inotify_user.c |  5 +++--
>  include/linux/fsnotify_backend.h |  2 ++
>  3 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/fs/notify/group.c b/fs/notify/group.c
> index a4a4b1c64d32..fab3cfdb4d9e 100644
> --- a/fs/notify/group.c
> +++ b/fs/notify/group.c
> @@ -114,11 +114,12 @@ EXPORT_SYMBOL_GPL(fsnotify_put_group);
>  /*
>   * Create a new fsnotify_group and hold a reference for the group returned.
>   */
> -struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
> +struct fsnotify_group *fsnotify_alloc_group_gfp(const struct fsnotify_ops *ops,
> +                                               gfp_t gfp)
>  {
>         struct fsnotify_group *group;
>
> -       group = kzalloc(sizeof(struct fsnotify_group), GFP_KERNEL);
> +       group = kzalloc(sizeof(struct fsnotify_group), gfp);
>         if (!group)
>                 return ERR_PTR(-ENOMEM);
>
> @@ -139,6 +140,15 @@ struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
>
>         return group;
>  }
> +EXPORT_SYMBOL_GPL(fsnotify_alloc_group_gfp);
> +
> +/*
> + * Create a new fsnotify_group and hold a reference for the group returned.
> + */
> +struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
> +{
> +       return fsnotify_alloc_group_gfp(ops, GFP_KERNEL);
> +}
>  EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
>
>  int fsnotify_fasync(int fd, struct file *file, int on)
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 59c177011a0f..7cb528c6154c 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -632,11 +632,12 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
>         struct fsnotify_group *group;
>         struct inotify_event_info *oevent;
>
> -       group = fsnotify_alloc_group(&inotify_fsnotify_ops);
> +       group = fsnotify_alloc_group_gfp(&inotify_fsnotify_ops,
> +                                        GFP_KERNEL_ACCOUNT);
>         if (IS_ERR(group))
>                 return group;
>
> -       oevent = kmalloc(sizeof(struct inotify_event_info), GFP_KERNEL);
> +       oevent = kmalloc(sizeof(struct inotify_event_info), GFP_KERNEL_ACCOUNT);
>         if (unlikely(!oevent)) {
>                 fsnotify_destroy_group(group);
>                 return ERR_PTR(-ENOMEM);

Any reason why you did not include fanotify in this patch?

Thanks,
Amir.
