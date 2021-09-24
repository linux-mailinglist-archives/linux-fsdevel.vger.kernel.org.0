Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927C54168E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 02:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243644AbhIXAYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 20:24:04 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:37182 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243602AbhIXAYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 20:24:03 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id BA2931A56019; Thu, 23 Sep 2021 17:22:30 -0700 (PDT)
Date:   Thu, 23 Sep 2021 17:22:30 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Jann Horn <jannh@google.com>
Cc:     Vito Caputo <vcaputo@pengaru.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 02:08:45AM +0200, Jann Horn wrote:
> On Fri, Sep 24, 2021 at 1:59 AM Vito Caputo <vcaputo@pengaru.com> wrote:
> > On Thu, Sep 23, 2021 at 04:31:05PM -0700, Kees Cook wrote:
> > > The /proc/$pid/wchan file has been broken by default on x86_64 for 4
> > > years now[1]. As this remains a potential leak of either kernel
> > > addresses (when symbolization fails) or limited observation of kernel
> > > function progress, just remove the contents for good.
> > >
> > > Unconditionally set the contents to "0" and also mark the wchan
> > > field in /proc/$pid/stat with 0.
> > >
> > > This leaves kernel/sched/fair.c as the only user of get_wchan(). But
> > > again, since this was broken for 4 years, was this profiling logic
> > > actually doing anything useful?
> > >
> > > [1] https://lore.kernel.org/lkml/20210922001537.4ktg3r2ky3b3r6yp@treble/
> > >
> > > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Cc: Vito Caputo <vcaputo@pengaru.com>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > <snip>
> >
> >
> > Please don't deliberately break WCHANs wholesale.  This is a very
> > useful tool for sysadmins to get a vague sense of where processes are
> > spending time in the kernel on production systems without affecting
> > performance or having to restart things under instrumentation.
> 
> Wouldn't /proc/$pid/stack be more useful for that anyway? As long as
> you have root privileges, you can read that to get the entire stack,
> not just a single method name.
> 
> (By the way, I guess that might be an alternative to ripping wchan out
> completely - require CAP_SYS_ADMIN like for /proc/$pid/stack?)

WCHAN is a first-class concept of the OS.  As a result we have
long-standing useful tools exposing them in far more organized,
documented, and discoverable ways than poking around linux-specific
/proc files at the shell.  Even `top` can show WCHAN in a column
alongside everything else it exposes, complete with sorting etc, and
I've already demonstrated the support in `ps`.

I also think it's worth preserving the ability for regular users to
observe the WCHAN of their own processes.  It's unclear to me why this
is such a worry.  If the WCHAN as-implemented is granular enough to
expose too much kernel inner workings, then it should be watered down
to be more vague.  Even if it just said "ioctl" when a process was
blocked in D state through making an ioctl() it would still be much
more useful than saying nothing at all.  Can't regular users see this
much about their own processes via strace/gdb anyways?

Instead of unwinding stacks maybe the kernel should be sticking an
entrypoint address in the current task struct for get_wchan() to
access, whenever userspace enters the kernel?

Regards,
Vito Caputo
