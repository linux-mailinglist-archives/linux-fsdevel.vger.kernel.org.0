Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C2131DC97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 16:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhBQPn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 10:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbhBQPn0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:43:26 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650A4C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 07:42:46 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id z18so11638636ile.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 07:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fek2Gqwmh52bB93ScePwaOE34t2/uPu0800DU1hoYLw=;
        b=EArKhu6S2qxIYX+HT78GH8i25DevNv9oqKmUcZ9SnjWScK9Q6EKrXqoUIYUfGTLDzH
         mw8r76Sfwbo7pJj7ZYgG6t540IYX/sJ+uAgL3ykRzWNGdJt5+gTSELRJCIW40rFHi7RB
         ZkwT19jIw3cU9tL5uwLJoRihReCPCt+TCE93akyM997qHNd4htIiE+2vPQYymCCJgleo
         Qbr1+fbTLREJLzaHipW2wXqShstT6ZpeR+MAvsLeNzEfYcNu31HNBeDJiglF6U+78JIM
         e29UzRX8SzGNV2+sbwk54ay8SnWBVYnVHrA7pJmRo2yOAFXCPt7SHg9u0zd/hT4bxL8u
         XDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fek2Gqwmh52bB93ScePwaOE34t2/uPu0800DU1hoYLw=;
        b=iErGoY7s5ayRApoaSOcl/K2QELnBTQYt1aKejLQTCF2UM5bVHDFhamJgQNM/UAXV7L
         1ZjDVHt+9ma5uaLe9p6nDB35TQufHHA2bTQeatp1iR88+1f/qKOy+ZIAjM4Mb6b716wd
         aTJAw87gw6aVI5OvD33O+XHmUqZe5KK7+wU6egluH8E6DcVnDkP0eLBnAia12xYi1Q9V
         /5jXeil+vIqqUKKQBHvRrTuihFU0HsyhYLnnxU69tQb9Bc7BbK1gi2sB5SIdqni/g3LW
         DS7nctQYpstQB4bLCbZXBgCbLdKlpEUm/fJ3NoAHoLaIiIvcRLj5u34h3hmNXp1JsyF/
         BZJA==
X-Gm-Message-State: AOAM5324eSsH8fkuJQ2NZ95b/KwG1UY49TB/geWK9WuQKXB7uR3XIxem
        ArGmciBljBFULR/ue2YF8SkayF1ToW1305FzgQLyJ5+7AVQ=
X-Google-Smtp-Source: ABdhPJy80VjD3Du0+FPdK2EefuDkOr1o0m9WhTAWFHUFeAKG669JQZVOfxGbae58dTjb8Z9CFTrLMphrUbH9psTsuP4=
X-Received: by 2002:a92:8b89:: with SMTP id i131mr21533523ild.9.1613576565690;
 Wed, 17 Feb 2021 07:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20210202162010.305971-1-amir73il@gmail.com> <20210202162010.305971-3-amir73il@gmail.com>
 <20210216150247.GB21108@quack2.suse.cz> <CAOQ4uxhLQBPd3aeVOj0E3HpKiYoqpfzPv9wZ8H8ncWTG4FOrtA@mail.gmail.com>
 <20210217134837.GD14758@quack2.suse.cz>
In-Reply-To: <20210217134837.GD14758@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 Feb 2021 17:42:34 +0200
Message-ID: <CAOQ4uxjWXJpLBFQU8Z1WsaWxYTFB6_3HwAnUv5A5nKkTRtrXzA@mail.gmail.com>
Subject: Re: [PATCH 2/7] fsnotify: support hashed notification queue
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 3:48 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 17-02-21 14:33:46, Amir Goldstein wrote:
> > On Tue, Feb 16, 2021 at 5:02 PM Jan Kara <jack@suse.cz> wrote:
> > > > @@ -300,10 +301,16 @@ static long inotify_ioctl(struct file *file, unsigned int cmd,
> > > >       switch (cmd) {
> > > >       case FIONREAD:
> > > >               spin_lock(&group->notification_lock);
> > > > -             list_for_each_entry(fsn_event, &group->notification_list,
> > > > -                                 list) {
> > > > -                     send_len += sizeof(struct inotify_event);
> > > > -                     send_len += round_event_name_len(fsn_event);
> > > > +             list = fsnotify_first_notification_list(group);
> > > > +             /*
> > > > +              * With multi queue, send_len will be a lower bound
> > > > +              * on total events size.
> > > > +              */
> > > > +             if (list) {
> > > > +                     list_for_each_entry(fsn_event, list, list) {
> > > > +                             send_len += sizeof(struct inotify_event);
> > > > +                             send_len += round_event_name_len(fsn_event);
> > > > +                     }
> > >
> > > As I write below IMO we should enable hashed queues also for inotify (is
> > > there good reason not to?)
> >
> > I see your perception of inotify_merge() is the same as mine was
> > when I wrote a patch to support hashed queues for inotify.
> > It is only after that I realized that inotify_merge() only ever merges
> > with the last event and I dropped that patch.
> > I see no reason to change this long time behavior.
>
> Ah, I even briefly looked at that code but didn't notice it merges only
> with the last event. I agree that hashing for inotify doesn't make sense
> then.
>
> Hum, if the hashing and merging is specific to fanotify and as we decided
> to keep the event->list for the global event list, we could easily have the
> hash table just in fanotify private group data and hash->next pointer in
> fanotify private part of the event? Maybe that would even result in a more
> compact code?
>

Maybe, I am not so sure. I will look into it.

> > > > +static inline size_t fsnotify_group_size(unsigned int q_hash_bits)
> > > > +{
> > > > +     return sizeof(struct fsnotify_group) + (sizeof(struct list_head) << q_hash_bits);
> > > > +}
> > > > +
> > > > +static inline unsigned int fsnotify_event_bucket(struct fsnotify_group *group,
> > > > +                                              struct fsnotify_event *event)
> > > > +{
> > > > +     /* High bits are better for hash */
> > > > +     return (event->key >> (32 - group->q_hash_bits)) & group->max_bucket;
> > > > +}
> > >
> > > Why not use hash_32() here? IMHO better than just stripping bits...
> >
> > See hash_ptr(). There is a reason to use the highest bits.
>
> Well, but event->key is just a 32-bit number so I don't follow how high
> bits used by hash_ptr() matter?

Of course, you are right.
But that 32-bit number was already generated using a xor of several
hash_32() results from hash_ptr() and full_name_hash(), so we do not really
need to mix it anymore to get better entropy in the higher 7 bits.

I do not mind using hash_32() here for clarity.

Thanks,
Amir.
