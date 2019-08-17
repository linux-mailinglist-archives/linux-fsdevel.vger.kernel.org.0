Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF21912AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 21:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfHQTXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Aug 2019 15:23:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44189 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfHQTXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Aug 2019 15:23:43 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hz4Ib-0007Hv-VH; Sat, 17 Aug 2019 21:23:38 +0200
Date:   Sat, 17 Aug 2019 21:23:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arul Jeniston <arul.jeniston@gmail.com>
cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read
 function.
In-Reply-To: <CACAVd4hT6QYtgtDsBcgy7c_s9WVBAH+1m0r5geBe7BUWJWYhbA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908171942370.1923@nanos.tec.linutronix.de>
References: <20190816083246.169312-1-arul.jeniston@gmail.com> <CACAVd4iXVH2U41msVKhT4GBGgE=2V2oXnOXkQUQKSSh72HMMmw@mail.gmail.com> <alpine.DEB.2.21.1908161224220.1873@nanos.tec.linutronix.de> <CACAVd4h05P2tWb7Eh1+3_0Cm7MkDNAt+SJVoBT4gErBfsBmsAQ@mail.gmail.com>
 <CACAVd4gHQ+_y5QBSQm3pMFHKrVgvvJZAABGvtp6=qt3drVXpTA@mail.gmail.com> <alpine.DEB.2.21.1908162255400.1923@nanos.tec.linutronix.de> <CACAVd4hT6QYtgtDsBcgy7c_s9WVBAH+1m0r5geBe7BUWJWYhbA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Arul,

On Sat, 17 Aug 2019, Arul Jeniston wrote:

> Do you agree the possibility of returning zero value from timerfd_read()?

Obviosuly it happens.
 
> > That has absolutely nothing to do with CLOCK_REALTIME. Your machines
> > TSC is either going backwards or not synchronized between cores.
> >
> > Hint: Dell has a track record of BIOS doing the wrong things to TSC in
> > order to hide their 'value add' features stealing CPU time.
> 
> We haven't seen any issue in Dell hardware but we would definitely check
> the possibility of hardware bug.

BIOS is the more likely candidate.

> Let us say, due to some reason the tsc goes backwards. Isn't it handled in
> clocksource_delta().

No. clocksource_delta() does damage limitation. It prevents insane large
time jumps which would result if the read out TSC value is less than the
base value which is used to calculate the delta. It cannot do more than
that.

> Is timerfd_read expected to return 0 if tsc drifts backwards? If so, why it
> is not documented?
> Being a system call, we expect all return values of read() on timerfd to be
> documented in the man page.

We expect TSC not to go backwards. If it does it's broken and not usable as
a clocksource for the kernel. The problem is that this is not necessarily
easy to detect.

Fact is, that your machines TSC goes backwards or is not properly
synchronized between the cores. Otherwise the problem would not exist at
all. That's the problem which needs to be fixed and not papered over with
crude hacks and weird justifications.

> > ktime_get() is CLOCK_MONOTONIC and not CLOCK_REALTIME.
> 
> We see the same base used for CLOCK_MONOTONIC, CLOCK_REALTIME timers here.
> both MONOTONIC, REALTIME timers hits the following code flow. we confirmed
> it through instrumentation.
> timerfd_read()-->hrtimer_forward_now()-->ktime_get()-->timekeeping_get_ns()-->timekeeping_get_delta()-->clocksource_delta().
>  Do you want me to share any other logs to confirm it?

No. That's the case when you use a relative timer with CLOCK_REALTIME
because only absolute timers are affected by modifications of
CLOCK_REALTIME. So it's NOT an issue of a CLOCK_REALTIME modification via
settimeofday() or adjtimex().

> > It's a bug, but either a hardware or a BIOS bug and you are trying to
> > paper over it at the place where you observe the symptom, which is
> > obviously the wrong place because:
> >
> >  1) Any other time related function even in timerfd is affected as well
> >
> >  2) We do not cure symptoms, we cure the root cause. And clearly the root
> >     cause hase not been explained and addressed.
> 
> if we don't fix this in kernel, can we document this return value in
> timerfd read() man page?

Again:

You cannot fix a hardware problem by hacking around it at exactly one place
where you can observe it. If that problem exists on your machine, then any
other time related function is affected as well.

Are you going to submit patches against _ALL_ time{r} related syscalls to
fix^Wpaper over this? Either against the kernel or against the man pages?

As this is a 4 core Rangely, it has a properly synchronized TSC on all 4
cores which runs with constant frequency and is not affected by deeper
C-States.

Here is the flow:

timerfd_read()

   waitfortick()

timer interrupt()
      time = ktime_get()
      expire timer			time >= timer_time
        tick++;
	wakeup_reader()

   hrtimer_forward_now()
	now = ktime_get()		In the failure case now < timer_time

i.e. time went backwards since the timer was expired. That's absolutely
unexpected behaviour and no, we are not papering over it.

Did you ever quantify how much time goes backwards in that case?

Is the timer expiry and the timerfd_read() on the same CPU or on different
ones?

Can you please provide a full dmesg from boot to after the point where this
failure happens?

Thanks,

	tglx
