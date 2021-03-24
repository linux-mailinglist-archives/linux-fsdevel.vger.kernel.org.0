Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7873479E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 14:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhCXNs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 09:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbhCXNrz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:47:55 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752C9C0613E0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 06:47:55 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so22768673otb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUH1uT1xGENlL23VeLmAGT6RQ/hIIGv8URJxekLD7KA=;
        b=NQINk5lciTHNfSmo0k4fLx5pcbEjTXfE1KI1AXj30vGqCN2lu5TqFPeK/1DUwA9bBf
         RRiDPZVJQkYd8iVT6pr3WD2Et13X50D4cLcdCSyws+n4HgeQuHX2sSFaDtMjnBmnfRYy
         Lsq/HbdcFYQTeKcCn/w7YxXyJFFRPS9rX5cHwBOP2yXMFX8NEmTJ26zeGY2UpfToe37h
         wC2Uw40HuR0jm60iWO7yCUiTFmaJ/kGdjLvKhf0niMRxrUF+Z2f4VHIxjsCBFDPxh7Yp
         Lr43KsTzjVBS8tDGIL9/HjNZxVXTRfiKkD1MplT+cSgG3jNy+Y7on3f7r/zuPCz5WBPO
         QtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUH1uT1xGENlL23VeLmAGT6RQ/hIIGv8URJxekLD7KA=;
        b=WB37YQaKzb0l0UKRj+cS+7EMcCSbNBv55tby5A7cQ7TbMSEGPSxiqDsadeMUMXWaCZ
         QnDWwfaN77VUYEqRJV7RcbQsDKw1z2vth2w6JV/W2ypEbu45Yd+jIgUCG5f7X4T2Jrii
         E2KFhmHB70VN5uFRP8bKOHUtrzG3c51IeEQBrhGkWqHx3RhJpFu8kWowLBlP4qKDCbXO
         wrt9qIvvPd8DhuZLiSflDCSmfYpglBxYsBgVHCwmH/4fphznP46rmycyRuWEho4Oz2ov
         h2Fn6kmNFV2pWxHRCnzfI2yTPI/7HkbD2tv48LLO3/7KkoIv90l969wc8c0mIMaAhB8f
         tBng==
X-Gm-Message-State: AOAM533WCEhRny6NXwvaZLZ/y762KjkbqhMgNpLj5WTmbN5yH6OvTFbX
        F7V0jt0SmgQ4rhPAWoga5fWx0iDmZG3Z+j0Nhj64Vw==
X-Google-Smtp-Source: ABdhPJy2OgdZKrA26uUEcG/eq5W9jxZ//Ow4t33ARzd9qJ2bSYThVpDB5tES5kneNDjwJcKWTmuug5z1ydukmkbeqb4=
X-Received: by 2002:a9d:5508:: with SMTP id l8mr3422469oth.233.1616593674497;
 Wed, 24 Mar 2021 06:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210324112503.623833-1-elver@google.com> <20210324112503.623833-8-elver@google.com>
 <YFs2XHqepwtlLinx@hirez.programming.kicks-ass.net> <YFs4RDKfbjw89tf3@hirez.programming.kicks-ass.net>
 <YFs84dx8KcAtSt5/@hirez.programming.kicks-ass.net>
In-Reply-To: <YFs84dx8KcAtSt5/@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 24 Mar 2021 14:47:43 +0100
Message-ID: <CANpmjNOXheY0e96uVAFL3YAB9OztyBs1Uh6Bg18-dPHKc=ehHQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] perf: Add breakpoint information to siginfo on SIGTRAP
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 24 Mar 2021 at 14:21, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 24, 2021 at 02:01:56PM +0100, Peter Zijlstra wrote:
> > On Wed, Mar 24, 2021 at 01:53:48PM +0100, Peter Zijlstra wrote:
> > > On Wed, Mar 24, 2021 at 12:24:59PM +0100, Marco Elver wrote:
> > > > Encode information from breakpoint attributes into siginfo_t, which
> > > > helps disambiguate which breakpoint fired.
> > > >
> > > > Note, providing the event fd may be unreliable, since the event may have
> > > > been modified (via PERF_EVENT_IOC_MODIFY_ATTRIBUTES) between the event
> > > > triggering and the signal being delivered to user space.
> > > >
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > ---
> > > > v2:
> > > > * Add comment about si_perf==0.
> > > > ---
> > > >  kernel/events/core.c | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > index 1e4c949bf75f..0316d39e8c8f 100644
> > > > --- a/kernel/events/core.c
> > > > +++ b/kernel/events/core.c
> > > > @@ -6399,6 +6399,22 @@ static void perf_sigtrap(struct perf_event *event)
> > > >   info.si_signo = SIGTRAP;
> > > >   info.si_code = TRAP_PERF;
> > > >   info.si_errno = event->attr.type;
> > > > +
> > > > + switch (event->attr.type) {
> > > > + case PERF_TYPE_BREAKPOINT:
> > > > +         info.si_addr = (void *)(unsigned long)event->attr.bp_addr;
> > > > +         info.si_perf = (event->attr.bp_len << 16) | (u64)event->attr.bp_type;
> > >
> > > Ahh, here's the si_perf user. I wasn't really clear to me what was
> > > supposed to be in that field at patch #5 where it was introduced.
> > >
> > > Would it perhaps make sense to put the user address of struct
> > > perf_event_attr in there instead? (Obviously we'd have to carry it from
> > > the syscall to here, but it might be more useful than a random encoding
> > > of some bits therefrom).
> > >
> > > Then we can also clearly document that's in that field, and it might be
> > > more useful for possible other uses.
> >
> > Something like so...
>
> Ok possibly something like so, which also gets the data address right
> for more cases.

It'd be nice if this could work. Though I think there's an inherent
problem (same as with fd) with trying to pass a reference back to the
user, while the user can concurrently modify that reference.

Let's assume that user space creates new copies of perf_event_attr for
every version they want, there's still a race where the user modifies
an event, and concurrently in another thread a signal arrives. I
currently don't see a way to determine when it's safe to free a
perf_event_attr or reuse, without there still being a chance that a
signal arrives due to some old perf_event_attr. And for our usecase,
we really need to know a precise subset out of attr that triggered the
event.

So the safest thing I can see is to stash a copy of the relevant
information in siginfo, which is how we ended up with encoding bits
from perf_event_attr into si_perf.

One way around this I could see is that we know that there's a limited
number of combinations of attrs, and the user just creates an instance
for every version they want (and hope it doesn't exceed some large
number). Of course, for breakpoints, we have bp_addr, but let's assume
that si_addr has the right version, so we won't need to access
perf_event_attr::bp_addr.

But given the additional complexities, I'm not sure it's worth it. Is
there a way to solve the modify-signal-race problem in a nicer way?

Thanks,
-- Marco
