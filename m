Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674B740CA33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 18:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhIOQez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 12:34:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48542 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhIOQey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:34:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E985E221AF;
        Wed, 15 Sep 2021 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631723614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9CAesP9l05/qiFjD3jOUqKHzQbHjYyhw5mmZ/xisxyo=;
        b=wxG0JaJ4HyJe01JVeJpRj5HubgVLTEYvMZNIg41cKSiP+8xM/CoEekmD484WPrLElyALM/
        wsDghf1Va8Q45xMou/VJG+VUkRSl2HtYehmmFq05m58NYDbw16oyIBS7shZ0GK1wobEFek
        OQkfZQsgH3gi0npptOwp69VZASQq1b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631723614;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9CAesP9l05/qiFjD3jOUqKHzQbHjYyhw5mmZ/xisxyo=;
        b=J01JZoYriYTWzdkscQrD9lUzVduqjzxlc815Ool3U63p6XnOFLt6Q1A1w9RFbodF6iI/iA
        4ksPZlh7pEfkRKBw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id DDF53A3B91;
        Wed, 15 Sep 2021 16:33:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B8E981E0BEA; Wed, 15 Sep 2021 18:33:34 +0200 (CEST)
Date:   Wed, 15 Sep 2021 18:33:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 5/7] fanotify: limit number of event merge attempts
Message-ID: <20210915163334.GD6166@quack2.suse.cz>
References: <20210202162010.305971-1-amir73il@gmail.com>
 <20210202162010.305971-6-amir73il@gmail.com>
 <CAOQ4uxiqnD7Qr=__apodWYfQYQ_JOvVnaZsi4jjGQmJ9S5hMyA@mail.gmail.com>
 <20210301130818.GE25026@quack2.suse.cz>
 <CAOQ4uxi7MRV-6PxyVovaR83sLWX8mZpiOM9OjdUqOHvZM9h2Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi7MRV-6PxyVovaR83sLWX8mZpiOM9OjdUqOHvZM9h2Wg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-09-21 15:39:13, Amir Goldstein wrote:
> On Mon, Mar 1, 2021 at 3:08 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sat 27-02-21 10:31:52, Amir Goldstein wrote:
> > > On Tue, Feb 2, 2021 at 6:20 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > Event merges are expensive when event queue size is large.
> > > > Limit the linear search to 128 merge tests.
> > > > In combination with 128 hash lists, there is a potential to
> > > > merge with up to 16K events in the hashed queue.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  fs/notify/fanotify/fanotify.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > > > index 12df6957e4d8..6d3807012851 100644
> > > > --- a/fs/notify/fanotify/fanotify.c
> > > > +++ b/fs/notify/fanotify/fanotify.c
> > > > @@ -129,11 +129,15 @@ static bool fanotify_should_merge(struct fsnotify_event *old_fsn,
> > > >         return false;
> > > >  }
> > > >
> > > > +/* Limit event merges to limit CPU overhead per event */
> > > > +#define FANOTIFY_MAX_MERGE_EVENTS 128
> > > > +
> > > >  /* and the list better be locked by something too! */
> > > >  static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
> > > >  {
> > > >         struct fsnotify_event *test_event;
> > > >         struct fanotify_event *new;
> > > > +       int i = 0;
> > > >
> > > >         pr_debug("%s: list=%p event=%p\n", __func__, list, event);
> > > >         new = FANOTIFY_E(event);
> > > > @@ -147,6 +151,8 @@ static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
> > > >                 return 0;
> > > >
> > > >         list_for_each_entry_reverse(test_event, list, list) {
> > > > +               if (++i > FANOTIFY_MAX_MERGE_EVENTS)
> > > > +                       break;
> > > >                 if (fanotify_should_merge(test_event, event)) {
> > > >                         FANOTIFY_E(test_event)->mask |= new->mask;
> > > >                         return 1;
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > Jan,
> > >
> > > I was thinking that this patch or a variant thereof should be applied to stable
> > > kernels, but not the entire series.
> > >
> > > OTOH, I am concerned about regressing existing workloads that depend on
> > > merging events on more than 128 inodes.
> >
> > Honestly, I don't think pushing anything to stable for this is really worth
> > it.
> >
> > 1) fanotify() is limited to CAP_SYS_ADMIN (in init namespace) so this is
> > hardly a security issue.
> >
> > 2) We have cond_resched() in the merge code now so the kernel doesn't
> > lockup anymore. So this is only about fanotify becoming slow if you have
> > lots of events.
> >
> > 3) I haven't heard any complaints since we've added the cond_resched()
> > patch so the performance issue seems to be really rare.
> >
> > If I get complaits from real users about this, we can easily reconsider, it
> > is not a big deal. But I just don't think preemptive action is warranted...
> >
> 
> Hi Jan,
> 
> I know you have some catching up to do, but applying this patch to stable
> has become a priority for me.
> It was a mistake on my part not to push harder 6 months ago, so I am trying
> to rectify this mistake now as soon as possible.
> 
> To answer your arguments against preemptive action:
> 1) My application has CAP_SYS_ADMIN, it is not malicious, but it cannot
>     do its job without taking up more CPU that it needs to, because bursts of
>     events will cause the event queue to grow to thousands of events and
>     fanotify_merge() will become a high CPU consumer
> 2) It's not only about fanotify becoming slow, it's about fanotify making the
>      entire system slow and as a result it takes a long time for the system
>      to recover from this condition
> 3) You haven't heard any complains because nobody was using sb mark
>     We have been using sb mark in production for a few years and carry
>     this patch in our kernel, so I can say for certain that sb mark on a fs with
>     heavy workload is disturbing the entire system without this patch.
> 
> I don't think that "regressing" the number of merged event is a big issue,
> as we never guaranteed any specific merge behavior and the behavior
> was hard enough to predict, so I don't think applications could have
> relied on it.
> 
> So, are you ok with me sending this patch to stable as is?

Sure, go ahead. I was not strongly against pushing this to stable, I just
didn't see good reason to do that but your arguments make sense - you count
as a user report I was waiting for ;).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
