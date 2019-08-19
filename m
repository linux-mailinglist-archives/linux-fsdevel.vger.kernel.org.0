Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 855A792796
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfHSOxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 10:53:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47482 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfHSOw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:52:59 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzj1j-00060d-P9; Mon, 19 Aug 2019 16:52:55 +0200
Date:   Mon, 19 Aug 2019 16:52:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arul Jeniston <arul.jeniston@gmail.com>
cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read
 function.
In-Reply-To: <CACAVd4izozzXNF9qwNcXC+EUx5n1sfsNeb9JNXNJF56LdZkkYg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908191646350.2147@nanos.tec.linutronix.de>
References: <20190816083246.169312-1-arul.jeniston@gmail.com> <CACAVd4iXVH2U41msVKhT4GBGgE=2V2oXnOXkQUQKSSh72HMMmw@mail.gmail.com> <alpine.DEB.2.21.1908161224220.1873@nanos.tec.linutronix.de> <CACAVd4h05P2tWb7Eh1+3_0Cm7MkDNAt+SJVoBT4gErBfsBmsAQ@mail.gmail.com>
 <CACAVd4gHQ+_y5QBSQm3pMFHKrVgvvJZAABGvtp6=qt3drVXpTA@mail.gmail.com> <alpine.DEB.2.21.1908162255400.1923@nanos.tec.linutronix.de> <CACAVd4hT6QYtgtDsBcgy7c_s9WVBAH+1m0r5geBe7BUWJWYhbA@mail.gmail.com> <alpine.DEB.2.21.1908171942370.1923@nanos.tec.linutronix.de>
 <CACAVd4jfoSUK4xgLByKeMY5ZPHZ40exY+74e4fOcBDPeoLpqQg@mail.gmail.com> <alpine.DEB.2.21.1908190947290.1923@nanos.tec.linutronix.de> <CACAVd4izozzXNF9qwNcXC+EUx5n1sfsNeb9JNXNJF56LdZkkYg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Arul,

On Mon, 19 Aug 2019, Arul Jeniston wrote:
> >   1) TSCs are out of sync or affected otherwise
> 
> If the TSC clock is unstable and not synchronized, Linux kernel throws
> dmesg logs and changes the current clock source to next best timer
> (hpet). But we didn't see these logs in any of the 10000 units.

Did you see "TSC ADJUST" entries?

> >   2) Timekeeping has a bug.
> 
> As per our analysis,
> 
> After the timer expiry, after tsc is read in hrtimer_forward_now()
> -->ktime_get()-->timekeeping_get_ns(), if the current thread (t1) is
> interrupted and/or some other thread running in different CPU (t2)
> updates timekeeper cycle_last value with a latest tsc than t1,
> clocksource_delta() and timekeeping_get_delta() would return 0.
> Eventually   timekeeping_delta_to_ns() would return a smaller value
> based on the other two parameters (mult, xtime_nsec). If
> base(timekeeper.tkr_mono.base) is not updated all this time, then
> ktime_get() could return a value lesser than expiry time.
> Note: CONFIG_DEBUG_TIMEKEEPING is not configured in our system.

Sorry, but your analysis is wrong.

The timekeeping code does never return time going backwards, except for the
case where the hardware is buggered and the failure cannot be detected.

But for the above scenario:

ktime_get()
  	do {
                seq = read_seqcount_begin(&tk_core.seq);
	        base = tk->tkr_mono.base;
		nsecs = timekeeping_get_ns(&tk->tkr_mono);

        } while (read_seqcount_retry(&tk_core.seq, seq));

So if the interrupt which updates the timekeeper hits in the middle of
timekeeping_get_ns() then the result is discarded because the sequence
count changed and read_seqcount_retry() returns true. So it takes another
round which will be perfectly aligned with the updated time keeper.

Thanks,

	tglx
