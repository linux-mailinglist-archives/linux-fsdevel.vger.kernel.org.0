Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214B8AC6FA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 16:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394638AbfIGOjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Sep 2019 10:39:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49321 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbfIGOjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Sep 2019 10:39:01 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i6brc-0007RG-IA; Sat, 07 Sep 2019 16:38:56 +0200
Date:   Sat, 7 Sep 2019 16:38:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arul Jeniston <arul.jeniston@gmail.com>
cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read
 function.
In-Reply-To: <CACAVd4hS1i--fxWaarXP2psagW-JmBoLAJRrfu9gkRc49Ja4pg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1909071630000.1902@nanos.tec.linutronix.de>
References: <20190816083246.169312-1-arul.jeniston@gmail.com> <CACAVd4jfoSUK4xgLByKeMY5ZPHZ40exY+74e4fOcBDPeoLpqQg@mail.gmail.com> <alpine.DEB.2.21.1908190947290.1923@nanos.tec.linutronix.de> <CACAVd4izozzXNF9qwNcXC+EUx5n1sfsNeb9JNXNJF56LdZkkYg@mail.gmail.com>
 <alpine.DEB.2.21.1908191646350.2147@nanos.tec.linutronix.de> <CACAVd4j60pn=td5hh485SJOcoYZ_jWQDQg2DVasSodPtsaupkw@mail.gmail.com> <alpine.DEB.2.21.1908191752580.2147@nanos.tec.linutronix.de> <CACAVd4iRN7=eq_B1+Yb-xcspU-Sg1dmMo_=VtLXXVPkjN1hY5Q@mail.gmail.com>
 <alpine.DEB.2.21.1908191943280.1796@nanos.tec.linutronix.de> <CACAVd4jAJ5QcOH=q=Q9kAz20X4_nAc7=vVU_gPWTS1UuiGK-fg@mail.gmail.com> <alpine.DEB.2.21.1908201036200.2223@nanos.tec.linutronix.de> <CACAVd4jT4Ke7giPmKSzt+Wo3Ro-g9zWDRz_GHaRcs0Nb3_rkBw@mail.gmail.com>
 <CACAVd4gRoQih6f_K7kMzr=AwA_DvP0OksxBKj1bGPsP2F_9sFg@mail.gmail.com> <alpine.DEB.2.21.1909051707150.1902@nanos.tec.linutronix.de> <CACAVd4hS1i--fxWaarXP2psagW-JmBoLAJRrfu9gkRc49Ja4pg@mail.gmail.com>
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

On Fri, 6 Sep 2019, Arul Jeniston wrote:
> >Changing the return value to 1 would be just a cosmetic workaround.
> 
> Agreed. Returning 1 is incorrect as It causes the next read() to
> return before the interval time passed.
> 
> >So I rather change the documentation (this applies only to CLOCK_REALTIME
> >and CLOCK_REALTIME_ALARM) and explain the rationale.
> 
> When timerfd_read() returns 0, hrtimer_forward() doesn't change expiry
> time, So, instead of modifying the man page, can we call
> timerfd_read() functionality once again from kernel.
> 
> For example:-
> timerfd_read_wrapper()
> {
>    do {
>      ret = timerfd_read(...);
>    } while (ret == 0);
> }
> 
> Let us know whether you see any problem in handling this race in kernel.

There is no race. It's defined behaviour and I explained it to you in great
length why it is correct to return 0 and document that in the man page.

Any CLOCK_REALTIME ABSTIME based interface of the kernel is affected by
this and no, we are not papering over it in one particular place just
because.

If clock REALTIME gets set then all bets are off. The syscalls can return
either early or userspace cam observe that the return value is bogus when
it actually reads the time. You cannot handle this by any means.

The only way to handle this gracefully is by using the
TFD_TIMER_CANCEL_ON_SET flag and reevaluate the situation in user space.

So I'm going to send a patch to document that in the manpage.

Thanks,

	tglx




