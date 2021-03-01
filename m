Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC74328028
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 15:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbhCAN7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 08:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbhCAN7Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:59:16 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5DEC06178B
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Mar 2021 05:58:35 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id a7so17765661iok.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Mar 2021 05:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFB6uxmUJfeQptqyN6NAu35Iub3LZxup61nbLx4pUfA=;
        b=KKEg7rNy05RUfePHCkCd4ojw+sEOhZY/1ftssLdkNzEK2SIGxFqGbI2Xn4SAbq2ri0
         VOCFMfM8HlwMP6aY2ND/lYlwBW8FMeSshQn1ZxYRhjHUCQm9MIf3aM26an2dF+p5y3MZ
         ezFdT/9FQcbWEtFEf8rYRoZQfmFzq2Xw81gtGYKeYXWCLbCjHHADLnJuIgH//T+IB6pN
         bXn686Chsfrvpe1LVZ4aIvmfwoeBS5jG7XvistpUFARXqrVgXSfrhxrmrRzvuPIcTnhc
         0MZO6HxMUMQ9j6qRlwwz1nY1UY7TGWCi6WHWrZcSKYHIpKm5kw2/D8WSRLtbsZq7Kr3L
         e8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFB6uxmUJfeQptqyN6NAu35Iub3LZxup61nbLx4pUfA=;
        b=F/nSfW7xnYNccLWNRGwb46dVGuUAg52XhctjjOu4SKfw3w7wy/qliRITgf3lP4XrKF
         HnZrOUVWMhS1eR4gUkyKG9pyfTFYu8X7ILMEVh8vknIpckZpULjFDNVhIOKaDE9JsExC
         F23p2O3D0DUetCDM/9+wbB9Ep3WNZLdlLwJrBcaUiKk1PGoAr92VV57I9F928VT3u29d
         14rLvFgvmaqN+kvwV8LVoBow9Iga2Ajal2ugQqriarjmG9ki8Xp7AMW/PzsL7x+G1rue
         o/I4JZlzk1CINCKnyGMUbVqS8SDewkh1cHKADooIepS1rPsTxOAEUw+c+7ZaNKFzdlo9
         uhng==
X-Gm-Message-State: AOAM53358AMj1VMUxe3nTMOBIdq0y5MWHUuYQ78ff2tTWZhy8dBeaD4S
        fXiZdDWNo43nVijgZ6SAlaf3BOPwUQwpUTM8jUehyDlI
X-Google-Smtp-Source: ABdhPJzcpTYGY/he+JH5ym2HI7jXEcM1uJfm4t5JaTfHe1hnZzMJgNDXrDCtijHWrebU6LVttHx9seQ6WziDOR8qxZ4=
X-Received: by 2002:a5e:8d01:: with SMTP id m1mr10462794ioj.72.1614607114576;
 Mon, 01 Mar 2021 05:58:34 -0800 (PST)
MIME-Version: 1.0
References: <20210202162010.305971-1-amir73il@gmail.com> <20210202162010.305971-6-amir73il@gmail.com>
 <CAOQ4uxiqnD7Qr=__apodWYfQYQ_JOvVnaZsi4jjGQmJ9S5hMyA@mail.gmail.com> <20210301130818.GE25026@quack2.suse.cz>
In-Reply-To: <20210301130818.GE25026@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 1 Mar 2021 15:58:23 +0200
Message-ID: <CAOQ4uxhOF2ZOfhFVTtQuW9AbJvdE07jR4aes_RaOhjcABDkaYQ@mail.gmail.com>
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

OK. Will post the series without this.

Thanks,
Amir.
