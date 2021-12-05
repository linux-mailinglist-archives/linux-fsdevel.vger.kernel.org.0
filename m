Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2534688F8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Dec 2021 04:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhLEDRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 22:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhLEDRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 22:17:02 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF10C061751;
        Sat,  4 Dec 2021 19:13:35 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so5630252pjb.5;
        Sat, 04 Dec 2021 19:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0undT0YJyHWH56ofdmr45Mkquy1Ol6IKr8TfIm45MQ=;
        b=alh+KS7FZNqGSxV+8P/PVttRyAnFMPPkSjin/9bJMU8hS7JmzzhS8j8eLur35oi55H
         A75i8/kfuqCKHqAVU5laxdL6wLaUq9RFf+1HxT2OK0u5WU1oI4adsc9mtBfKTcNG/ocq
         o86QB2wduzEsB9KSp8j8RhqWqzE6wRFttV7EPX6vbHqstHWUwotYmaBfBPjgjH4J601X
         KvQYgjXLDxu8TTDp1PHm4vvx0INBpZQBzIRvDsB4Ld4NXwSa3xEr1Pl36oQwhIqFDIIl
         UGUExDQQz18m2wdtcxNUzCWWm3cEn7ulnLmMTfruOlqsHWItjbH6f4xujPhKH0hCP2ym
         2aBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0undT0YJyHWH56ofdmr45Mkquy1Ol6IKr8TfIm45MQ=;
        b=XKdCXuTuxG03g0/dbAKuKOLJbawNKw9nc4kYJQSiICLdL0hk0Gzoq49XL03Lz+qBop
         oy65S4eigvvbTqF1IlEGQ1RJ3WeGJxsBIlWpilT31TglWvjzD7wg6KQSzocBCFh//ZEk
         kPIavNa/zxCL6th2dInWpzbe/m3Ankko54mMmDnMCPMINC43LRhiAxuzEDSrmbIHb0+m
         3VwixK+JQbF3guGzjmk66EUlAoJpOKarBcOfj1Y1kOM49IyoiPonaJMzWdrGXBw7BYny
         SUqI3RtBXw0JJKiqRPILYMZyEGzVFXwafrbHY3cAhvQwYIxkbJHNk3nEFv5UwzV5GJIH
         7aaA==
X-Gm-Message-State: AOAM533fnWdYHAW3aErT6juWS9hyqIH/0qmz8qAYkwiGjo++UUVsNCwh
        JwRql8HkJzxseVbcdDFm16xFJkSl4eOdlpS/tseP96e2
X-Google-Smtp-Source: ABdhPJzEGDaefqbNDy2qcJS5gL32CblBVcy3B0f9LoefTt56iGEQdx3xk6vDHLa2iGvTaoQIEcoFiVGvqdiAb5BmAfg=
X-Received: by 2002:a17:90b:4c03:: with SMTP id na3mr26426374pjb.62.1638674015106;
 Sat, 04 Dec 2021 19:13:35 -0800 (PST)
MIME-Version: 1.0
References: <20211204095256.78042-1-laoar.shao@gmail.com> <20211204095256.78042-6-laoar.shao@gmail.com>
 <CAADnVQLS4Ev7xChqCMbbJiFZ_kYSB+rbiVT6AJotheFJb1f5=w@mail.gmail.com> <CALOAHbCud62ivvoRuz1SV-d3sL9Y9knEga0N-jiXnM3SYzWxNA@mail.gmail.com>
In-Reply-To: <CALOAHbCud62ivvoRuz1SV-d3sL9Y9knEga0N-jiXnM3SYzWxNA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 4 Dec 2021 19:13:24 -0800
Message-ID: <CAADnVQLu+RWSeMfOe5eBuTsp9gxPsFC_bRTXoWmvWP+Lv_rZzQ@mail.gmail.com>
Subject: Re: [PATCH -mm 5/5] bpf/progs: replace hard-coded 16 with TASK_COMM_LEN
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 4, 2021 at 6:45 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Sun, Dec 5, 2021 at 12:44 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Dec 4, 2021 at 1:53 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > >  static int process_sample(void *ctx, void *data, size_t len)
> > >  {
> > > -       struct sample *s = data;
> > > +       struct sample_ringbuf *s = data;
> >
> > This is becoming pointless churn.
> > Nack.
> >
> > > index 145028b52ad8..7b1bb73c3501 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
> > > @@ -1,8 +1,7 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  // Copyright (c) 2019 Facebook
> > >
> > > -#include <linux/bpf.h>
> > > -#include <stdint.h>
> > > +#include <vmlinux.h>
> > >  #include <stdbool.h>
> > >  #include <bpf/bpf_helpers.h>
> > >  #include <bpf/bpf_core_read.h>
> > > @@ -23,11 +22,11 @@ struct core_reloc_kernel_output {
> > >         int comm_len;
> > >  };
> > >
> > > -struct task_struct {
> > > +struct task_struct_reloc {
> >
> > Churn that is not even compile tested.
>
> It is strange that I have successfully compiled it....
> Below is the compile log,
>
> $ cat make.log | grep test_core_reloc_kernel
>   CLNG-BPF [test_maps] test_core_reloc_kernel.o
>   GEN-SKEL [test_progs] test_core_reloc_kernel.skel.h
>   CLNG-BPF [test_maps] test_core_reloc_kernel.o
>   GEN-SKEL [test_progs-no_alu32] test_core_reloc_kernel.skel.h
>
> Also there's no error in the compile log.

and ran the tests too?
