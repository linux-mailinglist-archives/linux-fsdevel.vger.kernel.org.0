Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5563C322D46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 16:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhBWPR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 10:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbhBWPRY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:17:24 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131BFC06178A
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 07:16:42 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id dr7so7913159qvb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 07:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yeydPNUBbnBa03B4CtFFI71u/VogiWMTrnYPrUvA5o=;
        b=uA/OwFba1OXPlE3eec0Lkuteazee/7d9Xd178WLkv5dnu8A92vJ3djvigMQ7jAUU3x
         nME8FehzY+kcVllN570rvIsKcFTRvTQDbwiIWDA0cQJz1KzNcJZX4h3plHWk+bqaBjZn
         SvN7Gfc1RxuY/+i/jtrAaPenwBNwNWegEHtOvmo0Vjx+8aRq1Ed96qCOX++Sjt87mB/X
         GTaVTu2K4unxbuD3deSDB5Gpq8x62S/upY7qcSNNBkfFos/vSWFzs2kFtXbKsusKVwNb
         7OlTcPYQlWfPWA0VtuzWC2Oxbe11yZH4qDiRafr6Ymkyv+N7fk7X9ZAaFHxyTMoLW8ij
         Er2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yeydPNUBbnBa03B4CtFFI71u/VogiWMTrnYPrUvA5o=;
        b=dpHY7GDxpXb5fOfBXPhFLweraibLSiRQkNkx5Pe/eYIN1WeiVSDC9M5rE3wPzJFGG1
         4eNtoMOYCO4omaRRbuD+W0IfvooH4DLlAu74qzYg2AGzndaqPzNtdln4zAa0iC5Zpsf+
         uNEsiTDC96y63V+ntbVGhzmugtp9UcUp1jucIURbyxU51Knn4GajMF7AxwYoMbeqXuLD
         fDGYvfu+gZvNIioijJZrgpsFKSf3iTYGkJOLFr3FKOy+cWW+eYhwUiUuQgPgI90QSH1k
         TnyCOUfa5i/72u6f0qpQbFFxf97NmhdeairHqyJX6lxy+h3odmnv+6HqHvrpKGTL7+mJ
         Z9FA==
X-Gm-Message-State: AOAM530sUH8P2yBg/ca3YBtwwlygVDwJmOd6Bsf4uQ49jgenJ16/xyjm
        aJbNw9892NJL0jLO4Wc0zHiqQCkukX+WC8h6aAur5Q==
X-Google-Smtp-Source: ABdhPJxLBKxZOO7lXuX++W27qocF5V5S96s4v/Tgf2IBWVEhIaFHgtodagR8vVVk8//B7pIxeik4PswMSc2P9YWh/9A=
X-Received: by 2002:a0c:8304:: with SMTP id j4mr25737289qva.18.1614093400799;
 Tue, 23 Feb 2021 07:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20210223143426.2412737-1-elver@google.com> <20210223143426.2412737-5-elver@google.com>
 <CACT4Y+aq6voiAEfs0d5Vd9trumVbnQhv-PHYfns2LefijmfyoQ@mail.gmail.com> <CANpmjNP1wQvG0SNPP2L9QO=natf0XU8HXj-r2_-U4QZxtr-dVA@mail.gmail.com>
In-Reply-To: <CANpmjNP1wQvG0SNPP2L9QO=natf0XU8HXj-r2_-U4QZxtr-dVA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Feb 2021 16:16:29 +0100
Message-ID: <CACT4Y+ar7=q0p=LFxkbKbKhz-U3rwdf=PJ3Gg3=ZLP6w_sgTeA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] perf/core: Add breakpoint information to siginfo
 on SIGTRAP
To:     Marco Elver <elver@google.com>
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

On Tue, Feb 23, 2021 at 4:10 PM 'Marco Elver' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
> > > Encode information from breakpoint attributes into siginfo_t, which
> > > helps disambiguate which breakpoint fired.
> > >
> > > Note, providing the event fd may be unreliable, since the event may have
> > > been modified (via PERF_EVENT_IOC_MODIFY_ATTRIBUTES) between the event
> > > triggering and the signal being delivered to user space.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >  kernel/events/core.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 8718763045fd..d7908322d796 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -6296,6 +6296,17 @@ static void perf_sigtrap(struct perf_event *event)
> > >         info.si_signo = SIGTRAP;
> > >         info.si_code = TRAP_PERF;
> > >         info.si_errno = event->attr.type;
> > > +
> > > +       switch (event->attr.type) {
> > > +       case PERF_TYPE_BREAKPOINT:
> > > +               info.si_addr = (void *)(unsigned long)event->attr.bp_addr;
> > > +               info.si_perf = (event->attr.bp_len << 16) | (u64)event->attr.bp_type;
> > > +               break;
> > > +       default:
> > > +               /* No additional info set. */
> >
> > Should we prohibit using attr.sigtrap for !PERF_TYPE_BREAKPOINT if we
> > don't know what info to pass yet?
>
> I don't think it's necessary. This way, by default we get support for
> other perf events. If user space observes si_perf==0, then there's no
> information available. That would require that any event type that
> sets si_perf in future, must ensure that it sets si_perf!=0.
>
> I can add a comment to document the requirement here (and user space
> facing documentation should get a copy of how the info is encoded,
> too).
>
> Alternatively, we could set si_errno to 0 if no info is available, at
> the cost of losing the type information for events not explicitly
> listed here.
>
> What do you prefer?

Ah, I see.
Let's wait for the opinions of other people. There are a number of
options for how to approach this.

> > > +               break;
> > > +       }
> > > +
> > >         force_sig_info(&info);
> > >  }
> > >
> > > --
> > > 2.30.0.617.g56c4b15f3c-goog
> > >
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/CANpmjNP1wQvG0SNPP2L9QO%3Dnatf0XU8HXj-r2_-U4QZxtr-dVA%40mail.gmail.com.
