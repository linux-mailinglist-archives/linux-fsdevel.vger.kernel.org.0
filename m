Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0558A4FBB83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 14:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiDKMC6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 08:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345989AbiDKMCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:02:48 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352AA2FE48
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 05:00:34 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id t7so15931644qta.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 05:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4nn83ffV4NNWGAN8F0/qNZZrdYiX7vAO0zRZlBQz3c=;
        b=oMHi5kBh09gUyn/PymWHdcXXapI1vDbDfj6X8pR5bQ8KhNT3dKQ2SpH3cAQXCrX4ID
         sBvXxNk6/L2pN+AuiCe39Hivvw6+hMNPwHnMNAcRaZEG/DFjDjxcB/4T0P4TQLwyDdUC
         3AH80ZNqWhKZinwLlbBh7i18Fl2JC4M1sSNAX53CoMcQIfSsvCe2r64QPbYxvz0evIwh
         GqhD+/+9nZMQpD4WKPlL6mNeIERHCrw2RqhAiApJKysBnBUdNHE+CH/vtcybHU1CabMv
         GEg0KeHiZJ89YrZHaOEw2h796eQzVi75E4wwHLSkby4nQXMD3w3k+A6xS2PIxk8F+/gN
         Rkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4nn83ffV4NNWGAN8F0/qNZZrdYiX7vAO0zRZlBQz3c=;
        b=j3bKqVGxO7xy2ATsfBiyxAMZDmJrC3xevvwayQhHqqvGugn36K5VxcVMFlKC6fes40
         qTSKVQI4bMrXeSH3la5n06qxoe9eWtsT1A4R/P9F4BGXgM32u5vcu3lscLpI0jif7S+a
         KXcW+qpl4SElHatG/9I+aXIc2OxSu5X7jS6y6/BAl1Ptju0WAK6ItyRIsjKyrD+wiQNJ
         OL49x2J2pepjBNiybFoVN3e9RKLEaV4fkhvgHIGAt5CgQ8ZaBHYrLMA4vxUUBEQqhW53
         DhoEy4Vcj1xkl2IS6hfokBsr3RTIfw8ZDgc0cjShPpnu4F+9GgENUsW5RLda2qmW+QgJ
         NGWA==
X-Gm-Message-State: AOAM5334fRdIPgdTZeGtzyRDk4i3Waj4jqeWLvIi9OspvU7fCp7GN1mK
        flkCYducA5+/vpGrnbAxJVkx5Pq6Z3J1lDoLarUiiHcx
X-Google-Smtp-Source: ABdhPJwaIfux0Z3Jm7fsdEnpVxQYz46bjpxOKnVs33zlMLDecA5gJ0cyUuGhCq+Zi03e9mIOhN85ackfD/Hv5ERKFfA=
X-Received: by 2002:ac8:5a4f:0:b0:2ed:d39b:5264 with SMTP id
 o15-20020ac85a4f000000b002edd39b5264mr4096802qta.477.1649678433320; Mon, 11
 Apr 2022 05:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220329074904.2980320-1-amir73il@gmail.com> <20220329074904.2980320-13-amir73il@gmail.com>
 <20220411105258.uehi4kuuop4gwwy4@quack3.lan>
In-Reply-To: <20220411105258.uehi4kuuop4gwwy4@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 11 Apr 2022 15:00:21 +0300
Message-ID: <CAOQ4uxjhH4T9hH9+Gri0Tet25i1Jmk3EcREtq0SWS0+Z5Yc3Hw@mail.gmail.com>
Subject: Re: [PATCH v2 12/16] fanotify: factor out helper fanotify_mark_update_flags()
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 1:53 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 29-03-22 10:49:00, Amir Goldstein wrote:
> > Handle FAN_MARK_IGNORED_SURV_MODIFY flag change in a helper that
> > is called after updating the mark mask.
> >
> > Move recalc of object mask inside fanotify_mark_add_to_mask() which
> > makes the code a bit simpler to follow.
> >
> > Add also helper to translate fsnotify mark flags to user visible
> > fanotify mark flags.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fanotify/fanotify.h      | 10 ++++++++
> >  fs/notify/fanotify/fanotify_user.c | 39 +++++++++++++++++-------------
> >  fs/notify/fdinfo.c                 |  6 ++---
> >  3 files changed, 34 insertions(+), 21 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> > index a3d5b751cac5..87142bc0131a 100644
> > --- a/fs/notify/fanotify/fanotify.h
> > +++ b/fs/notify/fanotify/fanotify.h
> > @@ -490,3 +490,13 @@ static inline unsigned int fanotify_event_hash_bucket(
> >  {
> >       return event->hash & FANOTIFY_HTABLE_MASK;
> >  }
> > +
> > +static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark *mark)
> > +{
> > +     unsigned int mflags = 0;
> > +
> > +     if (mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
> > +             mflags |= FAN_MARK_IGNORED_SURV_MODIFY;
> > +
> > +     return mflags;
> > +}
>
> This, together with fdinfo change should probably be a separate commit. I
> don't see a good reason to mix these two changes...
>

True.

> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index 0f0db1efa379..6e78ea12239c 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -1081,42 +1081,50 @@ static int fanotify_remove_inode_mark(struct fsnotify_group *group,
> >                                   flags, umask);
> >  }
> >
> > -static void fanotify_mark_add_ignored_mask(struct fsnotify_mark *fsn_mark,
> > -                                        __u32 mask, unsigned int flags,
> > -                                        __u32 *removed)
> > +static int fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
> > +                                   unsigned int flags, bool *recalc)
> >  {
> > -     fsn_mark->ignored_mask |= mask;
> > -
> >       /*
> >        * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time may lead to
> >        * the removal of the FS_MODIFY bit in calculated mask if it was set
> >        * because of an ignored mask that is now going to survive FS_MODIFY.
> >        */
> >       if ((flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
> > +         (flags & FAN_MARK_IGNORED_MASK) &&
> >           !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)) {
> >               fsn_mark->flags |= FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY;
> >               if (!(fsn_mark->mask & FS_MODIFY))
> > -                     *removed = FS_MODIFY;
> > +                     *recalc = true;
> >       }
> > +
> > +     return 0;
> >  }
> >
> > -static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
> > -                                    __u32 mask, unsigned int flags,
> > -                                    __u32 *removed)
> > +static int fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
> > +                                  __u32 mask, unsigned int flags)
> >  {
> > -     __u32 oldmask, newmask;
> > +     __u32 oldmask;
> > +     bool recalc = false;
> > +     int ret;
> >
> >       spin_lock(&fsn_mark->lock);
> >       oldmask = fsnotify_calc_mask(fsn_mark);
> >       if (!(flags & FAN_MARK_IGNORED_MASK)) {
> >               fsn_mark->mask |= mask;
> >       } else {
> > -             fanotify_mark_add_ignored_mask(fsn_mark, mask, flags, removed);
> > +             fsn_mark->ignored_mask |= mask;
> >       }
> > -     newmask = fsnotify_calc_mask(fsn_mark);
> > +
> > +     recalc = fsnotify_calc_mask(fsn_mark) & ~oldmask &
> > +             ~fsnotify_conn_mask(fsn_mark->connector);
>
> oldmask should be a subset of fsnotify_conn_mask() so the above should be
> equivalent to:
>
> recalc = fsnotify_calc_mask(fsn_mark) & ~fsnotify_conn_mask(fsn_mark->connector)
>
> shouldn't it?

I just translated the old expression of 'added',
but I guess there is no reason to look at the oldmask
only the newmask matters, so I can drop oldmask variable altogether.

Thanks,
Amir.
