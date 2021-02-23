Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA31A322D2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 16:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhBWPLj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 10:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhBWPLg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:11:36 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26313C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 07:10:55 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id k13so5333902otn.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 07:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAvFxow2tg8sBdIKol2WVfke34KD7HcGzBLgosBBq0o=;
        b=jvghciHCbxESrwcZC3Kxe25IOlJnCPRu4y1Dfo7kSWksWzpDqcwlBOp0oYoM/yBRwz
         3G6GuIXwAhZKsyJ/oyQfnXqCWKh2+tYuCg2X+Krk1T7Kunho7bLRWGsDuG32hImf486x
         HN7/+3ommi2zIwJwwITL80uM+J2EHmMpz9xZOwfYeiUS6ieApY8yPO64TaAr7DC76z54
         8JH29774RYXsTKsuDgE840XaVcNHO/T9GwST1KI7Ya7BHwgMa4HplKmOXzACVxN25O3w
         EVtnhZHMrA+xnQESANwDibvasLjc2lRAKucy/S1OKG7KAlJi8wTZvGnKyMlwDCfhB0ZY
         vmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAvFxow2tg8sBdIKol2WVfke34KD7HcGzBLgosBBq0o=;
        b=Nq+HV556mfwP96ahQCcJmBft3Xvt9q8v8TKuLSg3t02WqHEAh4BlJh0faZXDatyoDB
         e2XPvXXAyfbnLKPjyjBelwRFDHNXjYmhNqpSOJ9rlETWey6FoCWWfFS+ZYOkjS98YIbH
         j1giX9K9jjRcKtxzIIXr15SK+OwPIpweplPUmRmQS7HKAeMwN5yZQZ8/bP+BOStHuxFL
         NZLwOLipjfPoW36Gh6+iGrNe1wHrRqaT9pDJjjPA9zRD+q4CtlzQwCN3m5oarwaiw/Ha
         hEv26+jmIYOr5s7Y61X23TbyofdD+PEbspT/Fy2tmpMosMo7jX3KHROvznwhOBfoEO07
         F2Hw==
X-Gm-Message-State: AOAM530xetIIsAFndbL7cPxkNG9P8KEzaD9leZ/pXQ1HC3muxpcqnS68
        yNjnmgNQhy2a8LyB4SBXohWlhRNmvgjJA+YJFk5t3w==
X-Google-Smtp-Source: ABdhPJxTrkdjvGWoStg4d6uOKPtQqEGb7GF6pNqbxkke77f5PHHQz9DjDY01mKFsNpQJLFgOwtcn9+6TqgJtYp+GNjc=
X-Received: by 2002:a9d:5a05:: with SMTP id v5mr21074835oth.17.1614093054391;
 Tue, 23 Feb 2021 07:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20210223143426.2412737-1-elver@google.com> <20210223143426.2412737-5-elver@google.com>
 <CACT4Y+aq6voiAEfs0d5Vd9trumVbnQhv-PHYfns2LefijmfyoQ@mail.gmail.com>
In-Reply-To: <CACT4Y+aq6voiAEfs0d5Vd9trumVbnQhv-PHYfns2LefijmfyoQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 23 Feb 2021 16:10:42 +0100
Message-ID: <CANpmjNP1wQvG0SNPP2L9QO=natf0XU8HXj-r2_-U4QZxtr-dVA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] perf/core: Add breakpoint information to siginfo
 on SIGTRAP
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 23 Feb 2021 at 16:01, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Feb 23, 2021 at 3:34 PM Marco Elver <elver@google.com> wrote:
> >
> > Encode information from breakpoint attributes into siginfo_t, which
> > helps disambiguate which breakpoint fired.
> >
> > Note, providing the event fd may be unreliable, since the event may have
> > been modified (via PERF_EVENT_IOC_MODIFY_ATTRIBUTES) between the event
> > triggering and the signal being delivered to user space.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  kernel/events/core.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 8718763045fd..d7908322d796 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6296,6 +6296,17 @@ static void perf_sigtrap(struct perf_event *event)
> >         info.si_signo = SIGTRAP;
> >         info.si_code = TRAP_PERF;
> >         info.si_errno = event->attr.type;
> > +
> > +       switch (event->attr.type) {
> > +       case PERF_TYPE_BREAKPOINT:
> > +               info.si_addr = (void *)(unsigned long)event->attr.bp_addr;
> > +               info.si_perf = (event->attr.bp_len << 16) | (u64)event->attr.bp_type;
> > +               break;
> > +       default:
> > +               /* No additional info set. */
>
> Should we prohibit using attr.sigtrap for !PERF_TYPE_BREAKPOINT if we
> don't know what info to pass yet?

I don't think it's necessary. This way, by default we get support for
other perf events. If user space observes si_perf==0, then there's no
information available. That would require that any event type that
sets si_perf in future, must ensure that it sets si_perf!=0.

I can add a comment to document the requirement here (and user space
facing documentation should get a copy of how the info is encoded,
too).

Alternatively, we could set si_errno to 0 if no info is available, at
the cost of losing the type information for events not explicitly
listed here.

What do you prefer?

> > +               break;
> > +       }
> > +
> >         force_sig_info(&info);
> >  }
> >
> > --
> > 2.30.0.617.g56c4b15f3c-goog
> >
