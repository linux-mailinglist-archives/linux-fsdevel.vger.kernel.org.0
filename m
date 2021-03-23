Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008D134564A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 04:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCWDfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 23:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhCWDff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:35:35 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B74C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 20:35:34 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g24so14012521qts.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 20:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WxWS/Gdj9HB8+LY4XIChbYX4Fz5bQD6zz9sFEv2H7Lg=;
        b=IoftGevVp32A8qjV/yrhPqxOcjTlqVrjANAxbFNRBdflMbRRNI7+mTNV1U3LdtuIo4
         RA1pcVVbInzLI201oUijy/F+BnXvxpveh/jcSGvly/lj2aej8UGxA0KdoqztH5pOHqme
         HKesCOzRy2H3PWypJStIaUfZxjQ00LY6Esck3xNxJH4HFZGlKqwMzAwBnRoIseJDv8Z5
         3spj96MYC02acTuPtn9+MP3kmhtrhzaGbS3Xd5zGXGVbZFJKW8SJgOkFkjl7FFn7yLBC
         5LM5yEXJPy3ToLpB7tpL+Zi1FeFfnpU2WGvn7YKv9jksKoAvt/FIfNjngRZ+/+veSvm3
         uxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxWS/Gdj9HB8+LY4XIChbYX4Fz5bQD6zz9sFEv2H7Lg=;
        b=aiyKy4uqCCX03vx61jhp3TwDaO2T8Mg0ytubIi1PB/zeDIxVVqHz8y1TPUJPzgyOGn
         EVCIYrwWrkgbxRdVahqTkm3xpTdKFXaYdTa0bcAvUSZCobgx5NWCGYKBP94PfOC/GgF3
         ngUqyeGmDZv+xU9PggDo3KGyj7XQKXGuMvaFZvP878RHBDpcKtGSP+VeSQ9AoPHrQy5L
         wn9o4o7OFaYBMHGc3JxqPbo7p4Ot1e+KVOUefhhoiSCMKimvpE1SIScK4wePziZk14/h
         2VkVYwD9bFM0649+ldBYPYO/oJl9KLeTuM7H0ADwjTwWCsgxBIVvczx0aG87pwofeMsA
         fjmQ==
X-Gm-Message-State: AOAM531zAD9LmG0uNBifyyuQwMc092Fm5RYTRusvev3Z9FO+ilYQBUP1
        R/VClBegChgMIezrJcL8beCO2uwDwDY1y9Lr7uEwBA==
X-Google-Smtp-Source: ABdhPJy98ud3LIbedWM5prUkB4cwbvYzz+ALqBdd14E0lJ7LMYtU+3XABwmOMuhsgIf/npl1vgNt4at7eih7HFtZaxk=
X-Received: by 2002:a05:622a:3c8:: with SMTP id k8mr2788365qtx.101.1616470533440;
 Mon, 22 Mar 2021 20:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210317045949.1584952-1-joshdon@google.com> <20210317082550.GA3881262@gmail.com>
 <CABk29NvGx6KQa_+RU-6xmL6mUeBrqZjH1twOw93SCVD-NZkbMQ@mail.gmail.com> <20210319090252.GF15768@suse.de>
In-Reply-To: <20210319090252.GF15768@suse.de>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 22 Mar 2021 20:35:22 -0700
Message-ID: <CABk29NukHXUu22N5WyVx82TA6WEZsz+HOBmk5oAy4GQMx4W+cw@mail.gmail.com>
Subject: Re: [PATCH] sched: Warn on long periods of pending need_resched
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>, Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 2:02 AM Mel Gorman <mgorman@suse.de> wrote:
>
> Default disabling and hidden behind a static branch would be useful
> because the majority of users are not going to know what to do about
> a need_resched warning and the sysctl is not documented. As Ingo said,
> SCHED_DEBUG is enabled by default a lot. While I'm not sure what motivates
> most distributions, I have found it useful to display topology information
> on boot and in rare cases, for the enabling/disabling of sched features.
> Hence, sched debug features should avoid adding too much overhead where
> possible.
>
> The static branch would mean splitting the very large inline functions
> adding by the patch. The inline section should do a static check only and
> do the main work in a function in kernel/sched/debug.c so it has minimal
> overhead if unused.
>
> --
> Mel Gorman
> SUSE Labs

Makes sense, I'll include this in v2.

Thanks,
Josh
