Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4473640C566
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 14:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbhIOMko (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 08:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhIOMkn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:40:43 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E5BC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 05:39:24 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id q14so2737727ils.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 05:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awmZ9/aj5UdmxkDVCav7n6Y7y0c9VB2OwUb7oxmZKt4=;
        b=ddnDf17nWdCPjtX6rjw6SpQ98JjakbHjHvQG6bvv6P94v1Cova2OJYmbq6tvI9duLF
         ix9x8cRNlfNpOarfGwo8cYx7mwn0viQ9v8d2v0w6wqHMM+oUDpVHLHrjt63tRPT9GfkM
         FGte6PwzksKlBo6KK2tflZIXi5nLTW6MoaPVWsfcpqT866Ks/NFx0iG9cxXExaeTvwL0
         3/AKURgPopYqdd2Nb0QYtwE4bS5TdQnZCYK1plhmr122Cb5pWeXHwJHwja804oI15vsU
         OSAqH/R+k4YzMRp8CLAxuoMPQ7sjzfQTIpKo4m1uJ0a8a8Qac96gcJDmsLilb92LsS2n
         NX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awmZ9/aj5UdmxkDVCav7n6Y7y0c9VB2OwUb7oxmZKt4=;
        b=U6LEHsVUPiB4MaQv4sR69ARSSIkT8zzBguED0BQCHdrU7idEoWdhDsoeeDbwOjhabR
         EySrsoDlIgx8KklV6z1ZxU2dgqdXAaEKScVc6f/bepMlhWOjXM/HdP0WoXcr85BRQsg3
         WyKwJvPCAb9V5YMrtK7sAjjv2VYwp/NwOmOPX2D29qmX8GlMcJJMkgyqdMyV5ZQK2xNf
         KytDfRKTHgmtcEz/6m6kSzULlgq4mQdlrkTW6riwlq4Q0tBHyB26lo73KUAxB9Wt3+vh
         LbARooJWEGzS/C/4HeqT2KXlaoZiO3PFC3cbS521a3ZaYS93ASAHkA21qNLf45e0f+H/
         264Q==
X-Gm-Message-State: AOAM533g329ywSf+5r6NBuaXDCq93mDKuQv6SgNDsnR6Lq3oN4svNTMG
        BG+cPBX3YB8dMaxfhWc3C39KnoPj6Ww03vrg/QKOoudrQVI=
X-Google-Smtp-Source: ABdhPJwK/6nvG8WTWB/hE/4NbUJ2fYZfd3dO9c3vu+YJRvAPxJXk2T9iWQ1e++IgKXB5/jAddJ30MIhT7P6QT+8FZzk=
X-Received: by 2002:a92:d491:: with SMTP id p17mr6492380ilg.107.1631709564217;
 Wed, 15 Sep 2021 05:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210202162010.305971-1-amir73il@gmail.com> <20210202162010.305971-6-amir73il@gmail.com>
 <CAOQ4uxiqnD7Qr=__apodWYfQYQ_JOvVnaZsi4jjGQmJ9S5hMyA@mail.gmail.com> <20210301130818.GE25026@quack2.suse.cz>
In-Reply-To: <20210301130818.GE25026@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 15 Sep 2021 15:39:13 +0300
Message-ID: <CAOQ4uxi7MRV-6PxyVovaR83sLWX8mZpiOM9OjdUqOHvZM9h2Wg@mail.gmail.com>
Subject: Re: [PATCH 5/7] fanotify: limit number of event merge attempts
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 1, 2021 at 3:08 PM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 27-02-21 10:31:52, Amir Goldstein wrote:
> > On Tue, Feb 2, 2021 at 6:20 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Event merges are expensive when event queue size is large.
> > > Limit the linear search to 128 merge tests.
> > > In combination with 128 hash lists, there is a potential to
> > > merge with up to 16K events in the hashed queue.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/notify/fanotify/fanotify.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > > index 12df6957e4d8..6d3807012851 100644
> > > --- a/fs/notify/fanotify/fanotify.c
> > > +++ b/fs/notify/fanotify/fanotify.c
> > > @@ -129,11 +129,15 @@ static bool fanotify_should_merge(struct fsnotify_event *old_fsn,
> > >         return false;
> > >  }
> > >
> > > +/* Limit event merges to limit CPU overhead per event */
> > > +#define FANOTIFY_MAX_MERGE_EVENTS 128
> > > +
> > >  /* and the list better be locked by something too! */
> > >  static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
> > >  {
> > >         struct fsnotify_event *test_event;
> > >         struct fanotify_event *new;
> > > +       int i = 0;
> > >
> > >         pr_debug("%s: list=%p event=%p\n", __func__, list, event);
> > >         new = FANOTIFY_E(event);
> > > @@ -147,6 +151,8 @@ static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
> > >                 return 0;
> > >
> > >         list_for_each_entry_reverse(test_event, list, list) {
> > > +               if (++i > FANOTIFY_MAX_MERGE_EVENTS)
> > > +                       break;
> > >                 if (fanotify_should_merge(test_event, event)) {
> > >                         FANOTIFY_E(test_event)->mask |= new->mask;
> > >                         return 1;
> > > --
> > > 2.25.1
> > >
> >
> > Jan,
> >
> > I was thinking that this patch or a variant thereof should be applied to stable
> > kernels, but not the entire series.
> >
> > OTOH, I am concerned about regressing existing workloads that depend on
> > merging events on more than 128 inodes.
>
> Honestly, I don't think pushing anything to stable for this is really worth
> it.
>
> 1) fanotify() is limited to CAP_SYS_ADMIN (in init namespace) so this is
> hardly a security issue.
>
> 2) We have cond_resched() in the merge code now so the kernel doesn't
> lockup anymore. So this is only about fanotify becoming slow if you have
> lots of events.
>
> 3) I haven't heard any complaints since we've added the cond_resched()
> patch so the performance issue seems to be really rare.
>
> If I get complaits from real users about this, we can easily reconsider, it
> is not a big deal. But I just don't think preemptive action is warranted...
>

Hi Jan,

I know you have some catching up to do, but applying this patch to stable
has become a priority for me.
It was a mistake on my part not to push harder 6 months ago, so I am trying
to rectify this mistake now as soon as possible.

To answer your arguments against preemptive action:
1) My application has CAP_SYS_ADMIN, it is not malicious, but it cannot
    do its job without taking up more CPU that it needs to, because bursts of
    events will cause the event queue to grow to thousands of events and
    fanotify_merge() will become a high CPU consumer
2) It's not only about fanotify becoming slow, it's about fanotify making the
     entire system slow and as a result it takes a long time for the system
     to recover from this condition
3) You haven't heard any complains because nobody was using sb mark
    We have been using sb mark in production for a few years and carry
    this patch in our kernel, so I can say for certain that sb mark on a fs with
    heavy workload is disturbing the entire system without this patch.

I don't think that "regressing" the number of merged event is a big issue,
as we never guaranteed any specific merge behavior and the behavior
was hard enough to predict, so I don't think applications could have
relied on it.

So, are you ok with me sending this patch to stable as is?

Thanks,
Amir.
