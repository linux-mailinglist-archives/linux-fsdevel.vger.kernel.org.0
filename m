Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60AB694951
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfHSP7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 11:59:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47899 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfHSP7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:59:05 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzk3g-0007Pk-NG; Mon, 19 Aug 2019 17:59:00 +0200
Date:   Mon, 19 Aug 2019 17:59:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arul Jeniston <arul.jeniston@gmail.com>
cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read
 function.
In-Reply-To: <CACAVd4j60pn=td5hh485SJOcoYZ_jWQDQg2DVasSodPtsaupkw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908191752580.2147@nanos.tec.linutronix.de>
References: <20190816083246.169312-1-arul.jeniston@gmail.com> <CACAVd4iXVH2U41msVKhT4GBGgE=2V2oXnOXkQUQKSSh72HMMmw@mail.gmail.com> <alpine.DEB.2.21.1908161224220.1873@nanos.tec.linutronix.de> <CACAVd4h05P2tWb7Eh1+3_0Cm7MkDNAt+SJVoBT4gErBfsBmsAQ@mail.gmail.com>
 <CACAVd4gHQ+_y5QBSQm3pMFHKrVgvvJZAABGvtp6=qt3drVXpTA@mail.gmail.com> <alpine.DEB.2.21.1908162255400.1923@nanos.tec.linutronix.de> <CACAVd4hT6QYtgtDsBcgy7c_s9WVBAH+1m0r5geBe7BUWJWYhbA@mail.gmail.com> <alpine.DEB.2.21.1908171942370.1923@nanos.tec.linutronix.de>
 <CACAVd4jfoSUK4xgLByKeMY5ZPHZ40exY+74e4fOcBDPeoLpqQg@mail.gmail.com> <alpine.DEB.2.21.1908190947290.1923@nanos.tec.linutronix.de> <CACAVd4izozzXNF9qwNcXC+EUx5n1sfsNeb9JNXNJF56LdZkkYg@mail.gmail.com> <alpine.DEB.2.21.1908191646350.2147@nanos.tec.linutronix.de>
 <CACAVd4j60pn=td5hh485SJOcoYZ_jWQDQg2DVasSodPtsaupkw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 19 Aug 2019, Arul Jeniston wrote:

> hi Tglx,
> > But for the above scenario:
> >
> > ktime_get()
> >         do {
> >                 seq = read_seqcount_begin(&tk_core.seq);
> >                 base = tk->tkr_mono.base;
> >                 nsecs = timekeeping_get_ns(&tk->tkr_mono);
> >
> >         } while (read_seqcount_retry(&tk_core.seq, seq));
> >
> > So if the interrupt which updates the timekeeper hits in the middle of
> > timekeeping_get_ns() then the result is discarded because the sequence
> > count changed and read_seqcount_retry() returns true. So it takes another
> > round which will be perfectly aligned with the updated time keeper.
> >
> 
> Do you mean to say the timekeeper  updates always happen from ktime_get?
> My point was, when one thread is in ktime_get other thread/isr updates
> timekeeper from different flow.

Timekeeper updates happen of course NOT from ktime_get(), but ktime_get()
is protected against concurrent updates via the seqcount. Simplified
without all the required barriers etc.

ktime_get()

    do {
       seq = tk->seq;
       if (seq & 1)
          continue;
       base = tk->base;
       nsec = get_nsec();
    while (seq != tk->seq);

update()

   tk->seq++;
   update_data();
   tk-<seq++;

It does not matter whether the update is an interrupt on the same CPU which
hits ktime_get() or whether it happens concurrent on a different CPU.

ktime_get() can never use inconsistent tk data for calculating the time.

Thanks,

	tglx
