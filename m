Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64758322CCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 15:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhBWOty (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 09:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhBWOts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:49:48 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12B9C06178A
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 06:49:07 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id gi9so7829358qvb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 06:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5S1278VXBXOSLVzud0ikIuJDPMbbC2qcHtU1cXjsgPk=;
        b=NiVKZu5i8qwDclQxF0dwzHxzXcPvLJbWdBqJ0G5HlyTCGT8dxnmVly+zHKAPdGPFrQ
         jLdOKWrkacctxFanoSKOGX3fa5L5bCcvzYdI6za53kIxVTLpypD57RLJB3PkyBrTsKkd
         lKj6wAgVQntdDLIQBxJ8PT4t95heusHlnfeTwdCiuCeqGzrqnyqBeEaDR+9vUSPaYSbq
         DG/uwnbkangeBPnYXVIcU4DYx5Qyusddt4EZdL8HrGfvG6gGArKhgL8JjHqAqZbyNnSP
         9/dOz/8pMQC+MMk4o8QWp5Tuz5WRqftR8WswyTX6bHnKj8/SSyC4Do5EmH6jhxTuAx7C
         iWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5S1278VXBXOSLVzud0ikIuJDPMbbC2qcHtU1cXjsgPk=;
        b=keo4uPGo5b+esJgCI30J4VMklYWNdSG/vZpAVJSmSRhAEGAHVYkgQvxzTAveFMiqNe
         B8xUHba6ZL5MERGHM1INEmd+1WAw4K5yZyU2Xx0rc6N1Ji1mN3vOkJXkLhsgseKQJ34z
         MuW+J9cfH4S66bGeU7nXAB9Ek7qa89tyYdGGYqHwYyi/h3U4K8JV7aX2dwFHkeuASGiX
         ga8Tf/B5maabF+hEkMT7sGtRbdkb5u79j8y7DPKo47ruQO4G1+FUgYWBkKRnLGc4CEZZ
         IKPvuUrN27WJgLjUpCNiVRWYXS6Wdhue78GzZ5WYRoWlwnyaGrs1hHy/55aBPelFfXGg
         /dVQ==
X-Gm-Message-State: AOAM533Pjxc8PgkE6lQyDVHRja8VCxxns9SXqHF+UEhp2vtD0a2F1a1w
        4tnesU8rb4MjR235r7LTtzXJNdxy60xFTfhcRKsL+Q==
X-Google-Smtp-Source: ABdhPJzkj0kFTsnMC8xw+10LnB3Mw8u1Yp18xzsvPq+XTQfqTRg36gkO97V96V/4F1u+24NycHQHKwxhsiqGo6/rJ1s=
X-Received: by 2002:a0c:e20f:: with SMTP id q15mr22742422qvl.13.1614091745827;
 Tue, 23 Feb 2021 06:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20210223143426.2412737-1-elver@google.com> <20210223143426.2412737-2-elver@google.com>
In-Reply-To: <20210223143426.2412737-2-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Feb 2021 15:48:54 +0100
Message-ID: <CACT4Y+YGrj3zc+KsxQ0=N5t3dPy58FwVuy=MY95RphOD4i4FHg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] perf/core: Apply PERF_EVENT_IOC_MODIFY_ATTRIBUTES
 to children
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

On Tue, Feb 23, 2021 at 3:34 PM Marco Elver <elver@google.com> wrote:
>
> As with other ioctls (such as PERF_EVENT_IOC_{ENABLE,DISABLE}), fix up
> handling of PERF_EVENT_IOC_MODIFY_ATTRIBUTES to also apply to children.
>
> Link: https://lkml.kernel.org/r/YBqVaY8aTMYtoUnX@hirez.programming.kicks-ass.net
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>


> ---
>  kernel/events/core.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 129dee540a8b..37a8297be164 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3179,16 +3179,36 @@ static int perf_event_modify_breakpoint(struct perf_event *bp,
>  static int perf_event_modify_attr(struct perf_event *event,
>                                   struct perf_event_attr *attr)
>  {
> +       int (*func)(struct perf_event *, struct perf_event_attr *);
> +       struct perf_event *child;
> +       int err;
> +
>         if (event->attr.type != attr->type)
>                 return -EINVAL;
>
>         switch (event->attr.type) {
>         case PERF_TYPE_BREAKPOINT:
> -               return perf_event_modify_breakpoint(event, attr);
> +               func = perf_event_modify_breakpoint;
> +               break;
>         default:
>                 /* Place holder for future additions. */
>                 return -EOPNOTSUPP;
>         }
> +
> +       WARN_ON_ONCE(event->ctx->parent_ctx);
> +
> +       mutex_lock(&event->child_mutex);
> +       err = func(event, attr);
> +       if (err)
> +               goto out;
> +       list_for_each_entry(child, &event->child_list, child_list) {
> +               err = func(child, attr);
> +               if (err)
> +                       goto out;
> +       }
> +out:
> +       mutex_unlock(&event->child_mutex);
> +       return err;
>  }
>
>  static void ctx_sched_out(struct perf_event_context *ctx,
> --
> 2.30.0.617.g56c4b15f3c-goog
>
