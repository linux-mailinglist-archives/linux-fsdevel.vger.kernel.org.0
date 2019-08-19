Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC88191E8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 10:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfHSIEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 04:04:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46118 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSIEa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 04:04:30 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzceP-0006to-Tx; Mon, 19 Aug 2019 10:04:26 +0200
Date:   Mon, 19 Aug 2019 10:04:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arul Jeniston <arul.jeniston@gmail.com>
cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read
 function.
In-Reply-To: <CACAVd4jfoSUK4xgLByKeMY5ZPHZ40exY+74e4fOcBDPeoLpqQg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908190947290.1923@nanos.tec.linutronix.de>
References: <20190816083246.169312-1-arul.jeniston@gmail.com> <CACAVd4iXVH2U41msVKhT4GBGgE=2V2oXnOXkQUQKSSh72HMMmw@mail.gmail.com> <alpine.DEB.2.21.1908161224220.1873@nanos.tec.linutronix.de> <CACAVd4h05P2tWb7Eh1+3_0Cm7MkDNAt+SJVoBT4gErBfsBmsAQ@mail.gmail.com>
 <CACAVd4gHQ+_y5QBSQm3pMFHKrVgvvJZAABGvtp6=qt3drVXpTA@mail.gmail.com> <alpine.DEB.2.21.1908162255400.1923@nanos.tec.linutronix.de> <CACAVd4hT6QYtgtDsBcgy7c_s9WVBAH+1m0r5geBe7BUWJWYhbA@mail.gmail.com> <alpine.DEB.2.21.1908171942370.1923@nanos.tec.linutronix.de>
 <CACAVd4jfoSUK4xgLByKeMY5ZPHZ40exY+74e4fOcBDPeoLpqQg@mail.gmail.com>
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

On Mon, 19 Aug 2019, Arul Jeniston wrote:
> During normal run, we do see small amount (~1000 cycles) of backward
> time drifts one in a while.
> This is likely happens due to the race between multiple processors and
> ISR routines.

No.

> We have added a hook to read_tsc() and observed backward time drift
> when isr comes between reading tsc register and returning the value.
> This drifting time differs based on the number of isr handled and the
> time taken to service each isr.

This is not a drift. Please do not misuse technical expressions which have
a well defined meaning.

rdtsc()
  val = read()

interrupt
	....

  return val

Time does not go backwards in that case simply because at the point it was
taken it was correct.

Versus that timerfd problem this situaiton is completely irrelevant simply
because hrtimer_forward_now() happens _AFTER_ the timer was expired not
before.

So the read of CLOCK_MONOTONIC in hrtimer_forward_now() is _AFTER_ the read
of CLOCK_MONOTONIC in hrtimer_interrupt() which expires the timer and there
are only two issue which can make that read in hrtimer_forward_now() go
backwards vs. the time which was read when the timer was expired:

  1) TSCs are out of sync or affected otherwise

  2) Timekeeping has a bug.

That's where the problem lies it needs to be analyzed whether this is
caused by #1 or by #2. Once we know that we can discuss solutions.

> Agreed. Our intention is not to put a workaround. Intention is to
> write a reliable application that handles all values returned by a
> system call.
> At present, the application doesn't know  whether 0 return value is a
> bug or valid case.

Again, you are tackling the wrong end. You need to find, analyze and fix
the root cause.

> > Is the timer expiry and the timerfd_read() on the same CPU or on different
> > ones?
> 
> We don't have data to answer this. However, the kernel is configured
> to allow timer migration.
> So, we believe, the timer expiry and timerfd_read happens on different CPUs.

Believe is a matter of religion and pretty useless to analyze technical
problems. It's not rocket science to figure this out with tracing.

> > Can you please provide a full dmesg from boot to after the point where this
> > failure happens?
> 
> We don't see any logs in dmesg during the occurrence of this problem.
> We may not be able to share complete dmesg logs due to security reasons.
> We haven't seen any time drifting related messages too.
> Let us know, if you are looking for any specific log message.

I was asking for a full boot log for a reason. Is it impossible to stick
that into a mail?

Thanks,

	tglx
