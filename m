Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D47390654
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 19:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfHPRAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 13:00:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45897 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHPRAd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:00:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id a30so4497930lfk.12;
        Fri, 16 Aug 2019 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFeowMwOfZvUOFR7qFp9T0Fg57QUMSHNhashmQ6YNsI=;
        b=UTI6HTqrtjKgC30Vsc56x/QAO3559spivpML5U3PVB1+m0meGSQbInR6OOkaWR9Be0
         56sbM1NfbQOOuTcNTt/fFZl9Zqm3aOSgZu2wpwRsuV107iS1sPhayKy7JCjh71bVR5ss
         4gSYDXWy2R6cJ8vJWxHDCJ4+fQLGhK9S7HTsTHB4uZdJkzM5MpO4FTXryU8X55yseG2Q
         uFhnz1hXCAa4QpadFAH4zZ2Og+SfFKrn+4u5Sagqwjp5/XpNAD3FwzzHz1b3NqbRZBh0
         8H0JkCtqcmsD0KUORP+baHYQGgrhjcWlm6Ezma/mIoJ6mrQj1iC3Qif+3viCcYaCTPH5
         8fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFeowMwOfZvUOFR7qFp9T0Fg57QUMSHNhashmQ6YNsI=;
        b=t47ZxFIjyZ0p+tWMPNPoWCvQaP7BgEH/Zl9YIfRvZezikr+XZPELeJLZlxcB1YDg3d
         ljHRVLzqplfEvxeUKv8aSEl5RVljBFfhi+cYm/z6OWqxqeUMF+pw6Q+KprPTzt6JoKjH
         a4MvbIEZxedWgnPpz8/8uHY3yrbrdCkXET1LSZOfaitZUxBGkc5Ts+IUBF6q4myKb5uI
         LMT9PCX5O5DueSmwJoNJlhV8IVu1gIAj59PIzcusOYtvlY/SG+SOREuGPCUFG3juB3Nb
         8upXWVwrm2wpsakONxIubyQTktVMwZA3WWb23iDVruVEqzjpuxfDPwgVXalevM68jLol
         iRfA==
X-Gm-Message-State: APjAAAWvjT39MQoJFQWJOsUEuGxeAPmZENhDi7PaWIRd6cxh06vWmNtI
        lsmXND5UjX0BA+7m8mPkOJ8WPseIrBIlc+Lwaqo=
X-Google-Smtp-Source: APXvYqw4guuc5zoA2tl9fU/CLxd3JO4/xqCjmWnPVU4AeL/8c29q1SabHjTc0k+kTqv/tQSUKBHzbal4H3OVfmyzqVc=
X-Received: by 2002:a05:6512:403:: with SMTP id u3mr5812376lfk.10.1565974830381;
 Fri, 16 Aug 2019 10:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190816083246.169312-1-arul.jeniston@gmail.com>
 <CACAVd4iXVH2U41msVKhT4GBGgE=2V2oXnOXkQUQKSSh72HMMmw@mail.gmail.com>
 <alpine.DEB.2.21.1908161224220.1873@nanos.tec.linutronix.de> <CACAVd4h05P2tWb7Eh1+3_0Cm7MkDNAt+SJVoBT4gErBfsBmsAQ@mail.gmail.com>
In-Reply-To: <CACAVd4h05P2tWb7Eh1+3_0Cm7MkDNAt+SJVoBT4gErBfsBmsAQ@mail.gmail.com>
From:   Arul Jeniston <arul.jeniston@gmail.com>
Date:   Fri, 16 Aug 2019 22:30:18 +0530
Message-ID: <CACAVd4gHQ+_y5QBSQm3pMFHKrVgvvJZAABGvtp6=qt3drVXpTA@mail.gmail.com>
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read function.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding few more data points...

On Fri, Aug 16, 2019 at 10:25 PM Arul Jeniston <arul.jeniston@gmail.com> wrote:
>
> Hi tglx,
>
> Thank you for your comments.
> Please find my commend in-lined
>
> On Fri, Aug 16, 2019 at 4:15 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Arul,
> >
> > On Fri, 16 Aug 2019, Arul Jeniston wrote:
> >
> > > Subject: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read function.
> >
> > The prefix is not 'FS: timerfd:'
> >
> > 1) The usual prefix for fs/* is: 'fs:' but...
> >
> > 2) git log fs/timerfd.c gives you a pretty good hint for the proper
> >    prefix. Look at the commits which actually do functional changes to that
> >    file, not at those which do (sub)system wide cleanups/adjustments.
> >
> > Also 'timerfd_read function' can be written as 'timerfd_read()' which
> > spares the redundant function and clearly marks it as function via the
> > brackets.
> >
> > > 'hrtimer_forward_now()' returns zero due to bigger backward time drift.
> > > This causes timerfd_read to return 0. As per man page, read on timerfd
> > >  is not expected to return 0.
> > > This problem is well explained in https://lkml.org/lkml/2019/7/31/442
> >
> > 1) The explanation needs to be in the changelog itself. Links can point to
> >    discussions, bug-reports which have supplementary information.
> >
> > 2) Please do not use lkml.org links.
> >
> > Again: Please read and follow Documentation/process/submitting-patches.rst
> >
> > > . This patch fixes this problem.
> > > Signed-off-by: Arul Jeniston <arul.jeniston@gmail.com>
> >
> > Missing empty line before Signed-off-by. Please use git-log to see how
> > changelogs are properly formatted.
> >
> > Also: 'This patch fixes this problem' is not helpful at all. Again see the
> > document I already pointed you to.
> >
>
> Agreed. Would incorporate all the above comments.
>
> > > ---
> > >  fs/timerfd.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/timerfd.c b/fs/timerfd.c
> > > index 6a6fc8aa1de7..f5094e070e9a 100644
> > > --- a/fs/timerfd.c
> > > +++ b/fs/timerfd.c
> > > @@ -284,8 +284,16 @@ static ssize_t timerfd_read(struct file *file,
> > > char __user *buf, size_t count,
> > >                                         &ctx->t.alarm, ctx->tintv) - 1;
> > >                                 alarm_restart(&ctx->t.alarm);
> > >                         } else {
> > > -                               ticks += hrtimer_forward_now(&ctx->t.tmr,
> > > -                                                            ctx->tintv) - 1;
> > > +                               u64 nooftimeo = hrtimer_forward_now(&ctx->t.tmr,
> > > +                                                                ctx->tintv);
> >
> > nooftimeo is pretty non-intuitive. The function documentation of
> > hrtimer_forward_now() says:
> >
> >       Returns the number of overruns.
> >
> > So the obvious variable name is overruns, right?
> >
>
> Agreed. Would change the variable name to overruns.
>
> > > +                               /*
> > > +                                * ticks shouldn't become zero at this point.
> > > +                                * Ignore if hrtimer_forward_now returns 0
> > > +                                * due to larger backward time drift.
> >
> > Again. This explanation does not make any sense at all.
> >
> > Time does not go backwards, except if it is CLOCK_REALTIME which can be set
> > backwards via clock_settime() or settimeofday().
> >
> > > +                                */
> > > +                               if (likely(nooftimeo)) {
> > > +                                       ticks += nooftimeo - 1;
> > > +                               }
> >
> > Again: Pointless brackets.
> >
> > If you disagree with my review comment, then tell me in a reply. If not,
> > then fix it. If you decide to ignore my comments, then don't wonder if I
> > ignore your patches.
> >
>
> We use CLOCK_REALTIME while creating timer_fd.
> Can read() on timerfd return 0 when the clock is set to CLOCK_REALTIME?
>
> We have Intel rangely 4 cpu system running debian stretch linux
> kernel. The current clock source is set to tsc. During our testing, we
> observed the time drifts backward occasionally. Through kernel
> instrumentation, we observed, sometimes clocksource_delta() finds the
> current time lesser than last time. and returns 0 delta.
>

This causes the following code flow to return a time which is lesser
than previously fetched time.
ktime_get()-->timekeeping_get_ns()-->timekeeping_get_delta()-->clocksource_delta()

Since ktime_get() returns a time which is lesser than the expiry time,
hrtimer_forward_now return 0.
This in-turn causes timerfd_read to return 0.
Is it not a bug?

> > Thanks,
> >
> >         tglx
