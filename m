Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D66146E0FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 03:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhLICqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 21:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLICqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:46:24 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35B1C061746;
        Wed,  8 Dec 2021 18:42:51 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id w14so3847850qkf.5;
        Wed, 08 Dec 2021 18:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ni8ukBhnwq4xfJn2KEfRGFk9CvW/EaamTsKpCF9U5jw=;
        b=FledoWYccQAWv6FRpva8r4lIbEIfgQM+BjswBkDz+Ede5Wkeo8QjIZfKPDzFnpjhRl
         QxEn1AjrahGgFvRzd0cqSJ2eUckDV58c4ITNjL0+zpwShqj3e3GzQEJJrRPRDFoVUbqy
         o30GCFnGk5euP4CXUr97UvPvq8KYjwaf3iQZUJP4LvlcPSpLmp29dzjB+vLPQnYPOImv
         5/62MrA1RYw6hgl+MJlK/vZBz7MfRRWvJC7nVMIx/grd+5AnrUm6g22228Or3MWIOGMV
         FijRDzb8IFS4aOCXYGiqC2nBprxecfD8vuc9vHLcuwXLUJiobdQUv/tz+wefcirK74rv
         ty3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ni8ukBhnwq4xfJn2KEfRGFk9CvW/EaamTsKpCF9U5jw=;
        b=Lbw3tgFt8InLmhEHNUnCPaswAlqsyLIcnHNOoEYcVAPpIrUtC+2fS3qCcd7uxpjPmM
         dYz761rGR4uPT8emYvNmblNu/0OpIXG70VqySy2StgN1heKXvddKH5HxuSrzvHRYWrQ0
         5dLuj0Q3Fz9M08MQf+cJDuFZ49zEOKz7w304Tmf4zSc9wROj9aX4FMykV8i+Yvwm20Tb
         WafM2yublUuKiQxVoGYMz0yZCz95bknV3vE4iRxhclwTsTvaM7uYGP7I5mkLeznbuxtu
         eX2FIx9p9EoMg7Yz3F0Lg2DTAhm3J+IchyZN37K7nEyWP7V2z2tif8ZT3wokQlFT3usj
         F9zw==
X-Gm-Message-State: AOAM5327uNf5nweCk1Vg1hCBxxYnazr1eyLOvIlr2K3mlNITc7G3mI2x
        mMPsSZm8SUEV6XYliycKF5tAUfY1EmDskdC7cUli2et6n5diekSU
X-Google-Smtp-Source: ABdhPJzPyV2mTICg4ujehOAo8kaXJvx2de02S+39TMWQ8+kUht18v3fGS9QAWvbiXI0QEc1UOZ9N36zfY4aRtfuIbw0=
X-Received: by 2002:a05:620a:2e3:: with SMTP id a3mr10866422qko.451.1639017771202;
 Wed, 08 Dec 2021 18:42:51 -0800 (PST)
MIME-Version: 1.0
References: <20211204095256.78042-1-laoar.shao@gmail.com> <20211204095256.78042-5-laoar.shao@gmail.com>
 <20211208134304.615abbbf@gandalf.local.home>
In-Reply-To: <20211208134304.615abbbf@gandalf.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 9 Dec 2021 10:42:15 +0800
Message-ID: <CALOAHbAP7w95r_soihp+i1NjWxz4KVHGizARpX80wuL3ZLO7Uw@mail.gmail.com>
Subject: Re: [PATCH -mm 4/5] tools/perf: replace hard-coded 16 with TASK_COMM_LEN
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Linux MM <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 9, 2021 at 2:43 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat,  4 Dec 2021 09:52:55 +0000
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > @@ -43,7 +45,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
> >               return -1;
> >       }
> >
> > -     if (evsel__test_field(evsel, "prev_comm", 16, false))
> > +     if (evsel__test_field(evsel, "prev_comm", TASK_COMM_LEN, false))
> >               ret = -1;
> >
> >       if (evsel__test_field(evsel, "prev_pid", 4, true))
> > @@ -55,7 +57,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
> >       if (evsel__test_field(evsel, "prev_state", sizeof(long), true))
> >               ret = -1;
> >
> > -     if (evsel__test_field(evsel, "next_comm", 16, false))
> > +     if (evsel__test_field(evsel, "next_comm", TASK_COMM_LEN, false))
> >               ret = -1;
> >
> >       if (evsel__test_field(evsel, "next_pid", 4, true))
> > @@ -73,7 +75,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
> >               return -1;
> >       }
> >
> > -     if (evsel__test_field(evsel, "comm", 16, false))
> > +     if (evsel__test_field(evsel, "comm", TASK_COMM_LEN, false))
>
> Shouldn't all these be TASK_COMM_LEN_16?
>

The value here must be the same with TASK_COMM_LEN, so I use TASK_COMM_LEN here.
But we may also change the code as
https://lore.kernel.org/lkml/20211101060419.4682-9-laoar.shao@gmail.com/
if TASK_COMM_LEN is changed, so TASK_COMM_LEN_16 is also okay here.
I will change it to TASK_COMM_LEN_16 in the next version.

>
> >               ret = -1;
> >
> >       if (evsel__test_field(evsel, "pid", 4, true))
>


-- 
Thanks
Yafang
