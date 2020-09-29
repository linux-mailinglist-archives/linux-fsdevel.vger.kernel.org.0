Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EE327D56C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 20:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgI2SHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 14:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgI2SH3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:07:29 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E53D621941;
        Tue, 29 Sep 2020 18:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601402849;
        bh=wg9JE9PV44JFDw2/BXHVYrXqYBiwMcvmaAm8NTvb8V4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rS9v8jsZaCnsb0vJ7juSw6VwTJmz58xK4Nh6UJC7d7tR+CcJkcD0Yd2N5wHdJENVy
         YL9LeB27w3OIs4d8PlHFk2v/Bt66+alWTNqyba802U/V5LqNMAIXVnC8mSrgFp32nC
         ChZcOms7H1vxCft/YgSmOvRPCaDzGLPwPWrvCgxE=
Received: by mail-ot1-f53.google.com with SMTP id o8so5378651otl.4;
        Tue, 29 Sep 2020 11:07:28 -0700 (PDT)
X-Gm-Message-State: AOAM532dA+HzR17aUvAU24RGWP4oDdszSQj0koioH99vnr7aflg0jN9S
        TnL3SKm1JqoGPcuoJ0s8NwDdC6zABLaVbSD3vaI=
X-Google-Smtp-Source: ABdhPJx8tYWBlF2irZ4KQVeLHcCnvYnKRH9OZJXa+9qJHU0tWEF60dIPXEG68Fb5If2LNukB5Sc5MBMramIqJy3Z4x0=
X-Received: by 2002:a9d:335:: with SMTP id 50mr3458330otv.90.1601402848082;
 Tue, 29 Sep 2020 11:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200915140750.137881-1-houtao1@huawei.com> <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com> <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net> <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <20200917084831.GA29295@willie-the-truck> <522e22a5-98e8-3a99-8f82-dc3789508638@huawei.com>
 <20200929174958.GG14317@willie-the-truck>
In-Reply-To: <20200929174958.GG14317@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 29 Sep 2020 20:07:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGdOcqDG2HXF0z6C5Pb7k-_ziLbtc5OPbY5WMf5ox4f=A@mail.gmail.com>
Message-ID: <CAMj1kXGdOcqDG2HXF0z6C5Pb7k-_ziLbtc5OPbY5WMf5ox4f=A@mail.gmail.com>
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for read_count
To:     Will Deacon <will@kernel.org>
Cc:     Hou Tao <houtao1@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 29 Sep 2020 at 19:50, Will Deacon <will@kernel.org> wrote:
>
> On Thu, Sep 24, 2020 at 07:55:19PM +0800, Hou Tao wrote:
> > The following is the newest performance data:
> >
> > aarch64 host (4 sockets, 24 cores per sockets)
> >
> > * v4.19.111
> >
> > no writer, reader cn                                | 24        | 48        | 72        | 96
> > rate of percpu_down_read/percpu_up_read per second  |
> > default: use __this_cpu_inc|dec()                   | 166129572 | 166064100 | 165963448 | 165203565
> > patched: use this_cpu_inc|dec()                     |  87727515 |  87698669 |  87675397 |  87337435
> > modified: local_irq_save + __this_cpu_inc|dec()     |  15470357       |  15460642 |  15439423 |  15377199
> >
> > * v4.19.111+ [1]
> >
> > modified: use this_cpu_inc|dec() + LSE atomic       |   8224023 |   8079416 | 7883046 |   7820350
> >
> > * 5.9-rc6
> >
> > no writer, reader cn                                | 24        | 48        | 72        | 96
> > rate of percpu_down_read/percpu_up_read per second  |
> > reverted: use __this_cpu_inc|dec() + revert 91fc957c| 169664061 | 169481176 | 168493488 | 168844423
> > reverted: use __this_cpu_inc|dec()                  |  78355071 |  78294285 |  78026030 |  77860492
> > modified: use this_cpu_inc|dec() + no LSE atomic    |  64291101 |  64259867 |  64223206 |  63992316
> > default: use this_cpu_inc|dec() + LSE atomic        |  16231421 |  16215618 |  16188581 |  15959290
> >
> > It seems that enabling LSE atomic has a negative impact on performance under this test scenario.
> >
> > And it is astonished to me that for my test scenario the performance of v5.9-rc6 is just one half of v4.19.
> > The bisect finds the culprit is 91fc957c9b1d6 ("arm64/bpf: don't allocate BPF JIT programs in module memory").
> > If reverting the patch brute-forcibly under 5.9-rc6 [2], the performance will be the same with
> > v4.19.111 (169664061 vs 166129572). I have had the simplified test module [3] and .config attached [4],
> > so could you please help to check what the problem is ?
>
> I have no idea how that patch can be responsible for this :/ Have you
> confirmed that the bisection is not bogus?
>
> Ard, do you have any ideas?
>

Unless the benchmark could be affected by the fact that BPF programs
are now loaded out of direct branching range of the core kernel, I
don't see how that patch could affect performance in this way.

What you could do is revert the patch partially - drop the new alloc
and free routines, but retain the new placement of the module and
kernel areas, which all got shifted around as a result. That would at
least narrow it down, although it looks very unlikely to me that this
change itself is the root cause of the regression.
