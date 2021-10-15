Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9507042EA3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 09:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbhJOHgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 03:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhJOHgH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:36:07 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9797BC061570;
        Fri, 15 Oct 2021 00:34:01 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id f15so6211424ilu.7;
        Fri, 15 Oct 2021 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGXqQlD57SzH6K8JHsXa6fCVA/v+S+0d8ni3Vc3WTD0=;
        b=K2k/QWYfBmJfLumVNmfvXyo/5oW2zIQTWcXU8fznGesIuwTLkq6AOz/jdAIWfrqzLz
         wA1LZYvfz1p5eZ0eRDTQBmowKQOhpESBq4JPdvCFHuAEahEaDTfmHpT3kNs0kpu6/6sY
         OIAcu0Exfn4A4cAbji8xkU6eovldYrcJEco3mS7VlcmR8pkjNDTAzNhAVelDFa+Mdk/w
         v2u/kx5S8wEaetxK/QPOfJX6nYWkQ6nJc3u176B79+CBGJoz/61s2ToBttKzfrXrcci7
         VI2UFVgD6L4nN1ppuAQwB7a1d4FWIZYwegZwRIp4YSgoTmmwCJXDxUEVgR4UR9vNg4Fe
         gvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGXqQlD57SzH6K8JHsXa6fCVA/v+S+0d8ni3Vc3WTD0=;
        b=eq35JaId6l0SY4aTV9WHN4AYmRYjzqY7E1kwZzic4REQW55VscqH+W0RVvhYNOV97W
         C77vwLUdu/MdLm/LLn2T5xvuU4RqrTx3+POUAr21wryBkSVZY/kxXOMx0Y57e91GIH9D
         uthlmf+hYjsNpgWVBZ+9DUwZY3oVRoJSXFvR5voFwUMMdGSzao9g77t4RJL9kCiFC51L
         2bX3dTPpE9Pg3jAqJtD4BwNEdvc4B023OLCgvh/EqnqD8uT/d4boMiMGumDIJdsh4pfJ
         MoXAnunWWqSNxMdM9AawuRgw/il2GGa0gbZ1pePkLPvzkBc6QkqsqV+ZSxiNUwye65ha
         j+pg==
X-Gm-Message-State: AOAM531ygZsLq7ynC1Rwcs/S02MWmupC+6f3fpfYCMGBdckEWqC0aog/
        6hv7/R8P2p7PAWmlcGmeSGW76U4qNz6SNtWsTcQ=
X-Google-Smtp-Source: ABdhPJwkncGxbFc33AXwAUBlqXdqpcB5wrMTrbLYKKSdsR6nX2M/VEaO5DOHfdzbykdAacznqykSxYI762wLw8rjnX0=
X-Received: by 2002:a05:6e02:1be8:: with SMTP id y8mr2776106ilv.24.1634283241040;
 Fri, 15 Oct 2021 00:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-19-krisman@collabora.com> <CAOQ4uxh+Xt5xrL7WgNVWxdigBRhR-HCixiUsAQvUT7L87TzTNg@mail.gmail.com>
In-Reply-To: <CAOQ4uxh+Xt5xrL7WgNVWxdigBRhR-HCixiUsAQvUT7L87TzTNg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Oct 2021 10:33:50 +0300
Message-ID: <CAOQ4uxiS7rC3nNyF+0XVGVm3qKXBSDseyXP-H3DKnfc2qzQPtw@mail.gmail.com>
Subject: Re: [PATCH v7 18/28] fanotify: Pre-allocate pool of error events
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 9:19 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Oct 15, 2021 at 12:39 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Error reporting needs to be done in an atomic context.  This patch
> > introduces a group-wide mempool of error events, shared by all
> > marks in this group.
> >
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > ---
> >  fs/notify/fanotify/fanotify.c      |  3 +++
> >  fs/notify/fanotify/fanotify.h      | 11 +++++++++++
> >  fs/notify/fanotify/fanotify_user.c | 26 +++++++++++++++++++++++++-
> >  include/linux/fsnotify_backend.h   |  2 ++
> >  4 files changed, 41 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index 8f152445d75c..01d68dfc74aa 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -819,6 +819,9 @@ static void fanotify_free_group_priv(struct fsnotify_group *group)
> >         if (group->fanotify_data.ucounts)
> >                 dec_ucount(group->fanotify_data.ucounts,
> >                            UCOUNT_FANOTIFY_GROUPS);
> > +
> > +       if (mempool_initialized(&group->fanotify_data.error_events_pool))
> > +               mempool_exit(&group->fanotify_data.error_events_pool);
> >  }
> >
> >  static void fanotify_free_path_event(struct fanotify_event *event)
> > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> > index c42cf8fd7d79..a577e87fac2b 100644
> > --- a/fs/notify/fanotify/fanotify.h
> > +++ b/fs/notify/fanotify/fanotify.h
> > @@ -141,6 +141,7 @@ enum fanotify_event_type {
> >         FANOTIFY_EVENT_TYPE_PATH,
> >         FANOTIFY_EVENT_TYPE_PATH_PERM,
> >         FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
> > +       FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
> >         __FANOTIFY_EVENT_TYPE_NUM
> >  };
> >
> > @@ -196,6 +197,16 @@ FANOTIFY_NE(struct fanotify_event *event)
> >         return container_of(event, struct fanotify_name_event, fae);
> >  }
> >
> > +struct fanotify_error_event {
> > +       struct fanotify_event fae;
> > +};
> > +
> > +static inline struct fanotify_error_event *
> > +FANOTIFY_EE(struct fanotify_event *event)
> > +{
> > +       return container_of(event, struct fanotify_error_event, fae);
> > +}
> > +
> >  static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
> >  {
> >         if (event->type == FANOTIFY_EVENT_TYPE_FID)
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index 66ee3c2805c7..f1cf863d6f9f 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -30,6 +30,7 @@
> >  #define FANOTIFY_DEFAULT_MAX_EVENTS    16384
> >  #define FANOTIFY_OLD_DEFAULT_MAX_MARKS 8192
> >  #define FANOTIFY_DEFAULT_MAX_GROUPS    128
> > +#define FANOTIFY_DEFAULT_FEE_POOL      32
> >
>
> We can probably start with a more generous pool (128?)
> It doesn't cost that much.
> But anyway, I think this pool needs to auto-grow (up to a maximum size)
> instead of having a rigid arbitrary limit.
>

As long as the pool grows, I don't mind if it start at size 32,
but I just noticed that mempools cannot be accounted to memcg??
Then surely the maximum size need to be kept pretty low.

Thanks,
Amir.
