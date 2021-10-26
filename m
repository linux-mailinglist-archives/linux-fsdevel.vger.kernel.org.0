Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59AE43B691
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 18:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbhJZQMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 12:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbhJZQMK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:12:10 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64318C061348;
        Tue, 26 Oct 2021 09:09:46 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h196so21248199iof.2;
        Tue, 26 Oct 2021 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rcwUM+yfYkd1fGoVQ1bAhhWXo7KweulJ4cGcrB1ov2k=;
        b=j3hPdCROifw9JEpIA+McCEuNKWXOqBx6EsNP39GxRzscQeiT6z+/qJVIw6tlre1oR0
         jenfCTu+YAhGgcdrYGOccXRLRIGsBdFZgMeSMz8sEwVfc1AqepJEJT9HHBm0UDZXs/O5
         ZfhiMhpKdc3n2JO5H5DAJ5jvPJVnCsROvENQxUjaXPRspotW4g8Va7dYRA/uOYEbytGK
         mNsdpH8oeQE1R+Od3g3VwR4XfDRvnLt4feNRnzdmfJko++vkI8GN7ieL6NMHCe8bt3AU
         Raymkh3ad9Q7ejXGgrSb8jF0qWnMZCQd6Pxqv5sjUlcBK8P3RfghnR5eBA1gAeAOkpd9
         qf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcwUM+yfYkd1fGoVQ1bAhhWXo7KweulJ4cGcrB1ov2k=;
        b=xuV5OsOsyTNPIm3ICQVCx7KYjjrfJcmsVOZ5OqGfUEMIPI7yxg+K3w7pep8uTaHNDw
         6rtutCXlpP5DxtvC0EZK/Q2qcNRBi0APSxuwAwoafWorJncMTi4PcN+0k6SxuS9C23ux
         Q7Qqg5ea8u+OTgmjjzEOXQS4/9/Dagvd9ygpUaNgOJpL5FdRJYBhIaMEg6jWyrKs/0pf
         cRkTjne4vm0uXrX+VbmgKTRkAu1bdX8QapjaLXA1OqZUsDKvCZNBwNS8kBhFQXxB6cIs
         qUx7PUiO51IK9B5kqWa5MWgJfscHUbAdIWJ4gEU/BihISNVxQ2I7G4+tFQQzCT48A5MA
         3T3w==
X-Gm-Message-State: AOAM530yzEvr7KPQghvuok6UIj4Q6Qox3XBhNrsv5Q1s0ZTjrbxNWeyz
        tNngYQIHGwiKVY0hTDA1MDwOdPB04r+wVAen4tE=
X-Google-Smtp-Source: ABdhPJxXrjxmBSp1hood0IVz9PaZRtPxRuaI3ESryi3mTB5SO+Lab1x+ccAB23JEegIpQOzsPDhPHWEbuL2xAQCM5j8=
X-Received: by 2002:a05:6602:1514:: with SMTP id g20mr16487935iow.9.1635264585800;
 Tue, 26 Oct 2021 09:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211025083315.4752-1-laoar.shao@gmail.com> <20211025083315.4752-9-laoar.shao@gmail.com>
 <202110251421.7056ACF84@keescook> <CALOAHbDPs-pbr5CnmuRv+b+CgMdEkzi4Yr2fSO9pKCE-chr3Yg@mail.gmail.com>
 <20211026091211.569a7ba2@gandalf.local.home>
In-Reply-To: <20211026091211.569a7ba2@gandalf.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 27 Oct 2021 00:09:09 +0800
Message-ID: <CALOAHbAK6u8qO5EiQ9yPp5a_HwddmDJE-JDUoDBK4QeEiR6ywQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] tools/bpf/bpftool/skeleton: make it adopt to
 task comm size change
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qiang Zhang <qiang.zhang@windriver.com>,
        robdclark <robdclark@chromium.org>,
        christian <christian@brauner.io>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        kbuild test robot <lkp@intel.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 9:12 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 26 Oct 2021 10:18:51 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > > So, if we're ever going to copying these buffers out of the kernel (I
> > > don't know what the object lifetime here in bpf is for "e", etc), we
> > > should be zero-padding (as get_task_comm() does).
> > >
> > > Should this, instead, be using a bounce buffer?
> >
> > The comment in bpf_probe_read_kernel_str_common() says
> >
> >   :      /*
> >   :       * The strncpy_from_kernel_nofault() call will likely not fill the
> >   :       * entire buffer, but that's okay in this circumstance as we're probing
> >   :       * arbitrary memory anyway similar to bpf_probe_read_*() and might
> >   :       * as well probe the stack. Thus, memory is explicitly cleared
> >   :       * only in error case, so that improper users ignoring return
> >   :       * code altogether don't copy garbage; otherwise length of string
> >   :       * is returned that can be used for bpf_perf_event_output() et al.
> >   :       */
> >
> > It seems that it doesn't matter if the buffer is filled as that is
> > probing arbitrary memory.
> >
> > >
> > > get_task_comm(comm, task->group_leader);
> >
> > This helper can't be used by the BPF programs, as it is not exported to BPF.
> >
> > > bpf_probe_read_kernel_str(&e.comm, sizeof(e.comm), comm);
>
> I guess Kees is worried that e.comm will have something exported to user
> space that it shouldn't. But since e is part of the BPF program, does the
> BPF JIT take care to make sure everything on its stack is zero'd out, such
> that a user BPF couldn't just read various items off its stack and by doing
> so, see kernel memory it shouldn't be seeing?
>
> I'm guessing it does, otherwise this would be a bigger issue than this
> patch series.
>

You guess is correct per my verification.
But the BPF JIT doesn't  zero it out, while it really does is adding
some character like '?' in my verification.

Anyway we don't need to worry that the kernel information may be
leaked though bpf_probe_read_kernel_str().

-- 
Thanks
Yafang
