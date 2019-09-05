Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E64AA764
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 17:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388398AbfIEPef (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 11:34:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43282 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfIEPef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:34:35 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i5tmI-0003aH-GY; Thu, 05 Sep 2019 17:34:30 +0200
Date:   Thu, 5 Sep 2019 17:34:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arul Jeniston <arul.jeniston@gmail.com>
cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read
 function.
In-Reply-To: <CACAVd4gRoQih6f_K7kMzr=AwA_DvP0OksxBKj1bGPsP2F_9sFg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1909051707150.1902@nanos.tec.linutronix.de>
References: <20190816083246.169312-1-arul.jeniston@gmail.com> <CACAVd4hT6QYtgtDsBcgy7c_s9WVBAH+1m0r5geBe7BUWJWYhbA@mail.gmail.com> <alpine.DEB.2.21.1908171942370.1923@nanos.tec.linutronix.de> <CACAVd4jfoSUK4xgLByKeMY5ZPHZ40exY+74e4fOcBDPeoLpqQg@mail.gmail.com>
 <alpine.DEB.2.21.1908190947290.1923@nanos.tec.linutronix.de> <CACAVd4izozzXNF9qwNcXC+EUx5n1sfsNeb9JNXNJF56LdZkkYg@mail.gmail.com> <alpine.DEB.2.21.1908191646350.2147@nanos.tec.linutronix.de> <CACAVd4j60pn=td5hh485SJOcoYZ_jWQDQg2DVasSodPtsaupkw@mail.gmail.com>
 <alpine.DEB.2.21.1908191752580.2147@nanos.tec.linutronix.de> <CACAVd4iRN7=eq_B1+Yb-xcspU-Sg1dmMo_=VtLXXVPkjN1hY5Q@mail.gmail.com> <alpine.DEB.2.21.1908191943280.1796@nanos.tec.linutronix.de> <CACAVd4jAJ5QcOH=q=Q9kAz20X4_nAc7=vVU_gPWTS1UuiGK-fg@mail.gmail.com>
 <alpine.DEB.2.21.1908201036200.2223@nanos.tec.linutronix.de> <CACAVd4jT4Ke7giPmKSzt+Wo3Ro-g9zWDRz_GHaRcs0Nb3_rkBw@mail.gmail.com> <CACAVd4gRoQih6f_K7kMzr=AwA_DvP0OksxBKj1bGPsP2F_9sFg@mail.gmail.com>
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

On Thu, 5 Sep 2019, Arul Jeniston wrote:
> When we adjust the date setting using date command we observed
> 'timerfd_read()' on CLOCK_REALTIME (TFD_TIMER_ABSTIME flag is set)
> returns 0.
> we don't see any hardware influence here and we are able to recreate
> it consistently. Is it expected? if yes, isn't it something to be
> documented in timerfd read() man page?

It's expected, yes. Simply because it hits the following condition:

     armtimer(T1)

     settime(T1 + X)  --> causes timer to fire

     		      	  	 wakeup reader
     settime(T0)

				 read number of intervals: 0

				 i.e. timer did not expire

Changing the return value to 1 would be just a cosmetic workaround. We
could also jump back and wait again. But that's all not consistent because

     armtimer(T1)

     settime(T1 + X)  --> causes timer to fire

     		      	  	 wakeup reader

				 read number of intervals: 1
     settime(T0)

				 user space reads time and figures that
				 the returned tick is bogus.

So I rather change the documentation (this applies only to CLOCK_REALTIME
and CLOCK_REALTIME_ALARM) and explain the rationale.

For applications which care about notifications when the time was set,
timerfd_settime() provides TFD_TIMER_CANCEL_ON_SET which causes the timer
to be canceled when time is set and returns -ECANCELED from the
read. That's unambiguous.

Thanks,

	tglx
