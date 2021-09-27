Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4499419142
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 11:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhI0JFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 05:05:48 -0400
Received: from foss.arm.com ([217.140.110.172]:34674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233519AbhI0JFr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:05:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF478D6E;
        Mon, 27 Sep 2021 02:04:09 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA6D03F70D;
        Mon, 27 Sep 2021 02:04:04 -0700 (PDT)
Date:   Mon, 27 Sep 2021 10:03:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Vito Caputo <vcaputo@pengaru.com>, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <20210927090337.GB1131@C02TD0UTHF1T.local>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
 <20210924135424.GA33573@C02TD0UTHF1T.local>
 <202109240716.A0792BE46@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109240716.A0792BE46@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 07:26:22AM -0700, Kees Cook wrote:
> On Fri, Sep 24, 2021 at 02:54:24PM +0100, Mark Rutland wrote:
> > On Thu, Sep 23, 2021 at 06:16:16PM -0700, Kees Cook wrote:
> > > On Thu, Sep 23, 2021 at 05:22:30PM -0700, Vito Caputo wrote:
> > > > Instead of unwinding stacks maybe the kernel should be sticking an
> > > > entrypoint address in the current task struct for get_wchan() to
> > > > access, whenever userspace enters the kernel?
> > > 
> > > wchan is supposed to show where the kernel is at the instant the
> > > get_wchan() happens. (i.e. recording it at syscall entry would just
> > > always show syscall entry.)
> > 
> > It's supposed to show where a blocked task is blocked; the "wait
> > channel".
> > 
> > I'd wanted to remove get_wchan since it requires cross-task stack
> > walking, which is generally painful.
> 
> Right -- this is the "fragile" part I'm worried about.
> 
> > We could instead have the scheduler entrypoints snapshot their caller
> > into a field in task_struct. If there are sufficiently few callers, that
> > could be an inline wrapper that passes a __func__ string. Otherwise, we
> > still need to symbolize.
> 
> Hmm. Does PREEMPT break this?

Within the core scheduler functions interrupts should be disabled, and
as long as we only update task_struct there we shouldn't have a race.

> Can we actually use __builtin_return_address(0) in __schedule?

We'd need to do this in a few entry points above __schedule, since the
currently get_wchan walks until !in_sched_functions(). It should be
possible, though we might need to make sure those the nexus points
aren't inlined.

Thanks,
Mark.
