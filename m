Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64DD994CED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 20:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfHSSaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 14:30:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48188 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbfHSSaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:30:00 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzmPj-0001Tl-5O; Mon, 19 Aug 2019 20:29:55 +0200
Date:   Mon, 19 Aug 2019 20:29:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arul Jeniston <arul.jeniston@gmail.com>
cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read
 function.
In-Reply-To: <CACAVd4iRN7=eq_B1+Yb-xcspU-Sg1dmMo_=VtLXXVPkjN1hY5Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908191943280.1796@nanos.tec.linutronix.de>
References: <20190816083246.169312-1-arul.jeniston@gmail.com> <CACAVd4iXVH2U41msVKhT4GBGgE=2V2oXnOXkQUQKSSh72HMMmw@mail.gmail.com> <alpine.DEB.2.21.1908161224220.1873@nanos.tec.linutronix.de> <CACAVd4h05P2tWb7Eh1+3_0Cm7MkDNAt+SJVoBT4gErBfsBmsAQ@mail.gmail.com>
 <CACAVd4gHQ+_y5QBSQm3pMFHKrVgvvJZAABGvtp6=qt3drVXpTA@mail.gmail.com> <alpine.DEB.2.21.1908162255400.1923@nanos.tec.linutronix.de> <CACAVd4hT6QYtgtDsBcgy7c_s9WVBAH+1m0r5geBe7BUWJWYhbA@mail.gmail.com> <alpine.DEB.2.21.1908171942370.1923@nanos.tec.linutronix.de>
 <CACAVd4jfoSUK4xgLByKeMY5ZPHZ40exY+74e4fOcBDPeoLpqQg@mail.gmail.com> <alpine.DEB.2.21.1908190947290.1923@nanos.tec.linutronix.de> <CACAVd4izozzXNF9qwNcXC+EUx5n1sfsNeb9JNXNJF56LdZkkYg@mail.gmail.com> <alpine.DEB.2.21.1908191646350.2147@nanos.tec.linutronix.de>
 <CACAVd4j60pn=td5hh485SJOcoYZ_jWQDQg2DVasSodPtsaupkw@mail.gmail.com> <alpine.DEB.2.21.1908191752580.2147@nanos.tec.linutronix.de> <CACAVd4iRN7=eq_B1+Yb-xcspU-Sg1dmMo_=VtLXXVPkjN1hY5Q@mail.gmail.com>
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

> > hits ktime_get() or whether it happens concurrent on a different CPU.
> > ktime_get() can never use inconsistent tk data for calculating the time.
> 
> Agreed. I think, I am not making my point clear here.
> Do you mean to say ktime_get() would always return incremental time
> irrespective of isr and multi-processors?

Yes. The only exception is when the TSC is either jumping or not fully in
sync between cores.

> If yes, this is where, I have difference of understanding.

And your understanding is still wrong. I explain it to you _once_ more:

The side which updates the timekeeper:

    - increments the sequence count _BEFORE_ it changes any data. After that
      increment the sequence count is odd, i.e. bit 0 is set.

    - updates data (base, last, mult, shift ....)

    - increments it again _AFTER_ it updated data.  After that increment
      the sequence count is even, i.e. bit 0 is cleared.

The read out side:

start:
    - reads the sequence count
      - if sequence count is odd (update in progress) go back to start

    - reads base from timekeeper data
    - reads TSC and calculates the delta with timekeeper data
      (last, mult, shift ...), i.e. timekeeping_get_ns().

    - reads the sequence count again.

      If it is even and the same as read above, the data is valid and
      consistent and the result is returned.

      If the sequence count is different to the original value it goes back
      to start.

It does not matter at all if timekeeping_get_ns() returns occasionally a
wrong value due to timekeeper data being updated concurrently. The result
is discarded and never returned to the caller. It tries again.

All places which update the timer keeper issue the sequence count increment
protection and are properly serialized against each other. So there is no
occacional point where ktime_get() would return random crap due to being
interrupted by an update or due to a concurrent update on a different CPU.

This is a protection mechanism which is well understood in computer science
(seqlock with lockless readers) and it works in kernel timekeeping for way
more than a decade without any issue except when the underlying hardware
clocksource (TSC in that case) misbehaves. There is no way to protect the
code against this and we are not going to do anything about it simply
because we can't.

The fact that you can observe the (cycles < last) condition is not proving
anything. Just looking at the (cycles < last) condition is wrong. You need
to proof that the result is returned from ktime_get() without a retry
despite the sequence counter being changed. I doubt you can.

If you can prove that the condition is met _AND_ the sequence counter has
NOT changed, then you have proven that the TSC on your machine is not
correctly synchronized or otherwise returning crap values.

You can make up further weird theories about the incorrectness of that
code, but these theories wont become magically true.

Thanks,

	tglx
