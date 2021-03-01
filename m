Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AA1327F0E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 14:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhCANJc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 08:09:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:43474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235442AbhCANJA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:09:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA649AB8C;
        Mon,  1 Mar 2021 13:08:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5D6081E04BE; Mon,  1 Mar 2021 14:08:18 +0100 (CET)
Date:   Mon, 1 Mar 2021 14:08:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 5/7] fanotify: limit number of event merge attempts
Message-ID: <20210301130818.GE25026@quack2.suse.cz>
References: <20210202162010.305971-1-amir73il@gmail.com>
 <20210202162010.305971-6-amir73il@gmail.com>
 <CAOQ4uxiqnD7Qr=__apodWYfQYQ_JOvVnaZsi4jjGQmJ9S5hMyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiqnD7Qr=__apodWYfQYQ_JOvVnaZsi4jjGQmJ9S5hMyA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 27-02-21 10:31:52, Amir Goldstein wrote:
> On Tue, Feb 2, 2021 at 6:20 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Event merges are expensive when event queue size is large.
> > Limit the linear search to 128 merge tests.
> > In combination with 128 hash lists, there is a potential to
> > merge with up to 16K events in the hashed queue.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fanotify/fanotify.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index 12df6957e4d8..6d3807012851 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -129,11 +129,15 @@ static bool fanotify_should_merge(struct fsnotify_event *old_fsn,
> >         return false;
> >  }
> >
> > +/* Limit event merges to limit CPU overhead per event */
> > +#define FANOTIFY_MAX_MERGE_EVENTS 128
> > +
> >  /* and the list better be locked by something too! */
> >  static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
> >  {
> >         struct fsnotify_event *test_event;
> >         struct fanotify_event *new;
> > +       int i = 0;
> >
> >         pr_debug("%s: list=%p event=%p\n", __func__, list, event);
> >         new = FANOTIFY_E(event);
> > @@ -147,6 +151,8 @@ static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
> >                 return 0;
> >
> >         list_for_each_entry_reverse(test_event, list, list) {
> > +               if (++i > FANOTIFY_MAX_MERGE_EVENTS)
> > +                       break;
> >                 if (fanotify_should_merge(test_event, event)) {
> >                         FANOTIFY_E(test_event)->mask |= new->mask;
> >                         return 1;
> > --
> > 2.25.1
> >
> 
> Jan,
> 
> I was thinking that this patch or a variant thereof should be applied to stable
> kernels, but not the entire series.
> 
> OTOH, I am concerned about regressing existing workloads that depend on
> merging events on more than 128 inodes.

Honestly, I don't think pushing anything to stable for this is really worth
it.

1) fanotify() is limited to CAP_SYS_ADMIN (in init namespace) so this is
hardly a security issue.

2) We have cond_resched() in the merge code now so the kernel doesn't
lockup anymore. So this is only about fanotify becoming slow if you have
lots of events.

3) I haven't heard any complaints since we've added the cond_resched()
patch so the performance issue seems to be really rare.

If I get complaits from real users about this, we can easily reconsider, it
is not a big deal. But I just don't think preemptive action is warranted...

								Honza

> I thought of this compromise between performance and functional regressions:
> 
> /*
>  * Limit event merges to limit CPU overhead per new event.
>  * For legacy mode, avoid unlimited CPU overhead, but do not regress the event
>  * merge ratio in heavy concurrent workloads with default queue size.
>  * For new FAN_REPORT_FID modes, make sure that CPU overhead is low.
>  */
> #define FANOTIFY_MAX_MERGE_OLD_EVENTS   16384
> #define FANOTIFY_MAX_MERGE_FID_EVENTS   128
> 
> static inline int fanotify_max_merge_events(struct fsnotify_group *group)
> {
>         if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS))
>                 return FANOTIFY_MAX_MERGE_FID_EVENTS;
>         else
>                 return FANOTIFY_MAX_MERGE_OLD_EVENTS;
> }
> 
> I can start the series with this patch and change that to:
> 
> #define FANOTIFY_MAX_MERGE_FID_EVENTS   128
> 
> static inline int fanotify_max_merge_events(struct fsnotify_group *group)
> {
>                return FANOTIFY_MAX_MERGE_EVENTS;
> }
> 
> At the end of the series.
> 
> What do you think?
> 
> Thanks,
> Amir.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
