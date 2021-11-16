Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F679452D0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 09:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhKPIov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 03:44:51 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38642 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhKPIou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:44:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7CF68218F0;
        Tue, 16 Nov 2021 08:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637052112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C55AwTWUd1GkY83Qar7hlYhX0sMPC1zTqlrpdkKmksU=;
        b=ujlSZx2xq2UNx6Gfwb6APaWg8C/a5u7GwUcCTjJEpL+nfxQYYq4zZrH7hSjeCyqLbIP0Qs
        3sYoOjRqSyOSvhKR2GJ6JAzLfipwCa7iHvYMPyCrL0/snaFxOQDeTN9Dl6lzauB/SngQ89
        obm/9puvR0ZvvQrT4Mq2Wzx5nF3C2OM=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 31C55A3B83;
        Tue, 16 Nov 2021 08:41:50 +0000 (UTC)
Date:   Tue, 16 Nov 2021 09:41:46 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Gabriele Paoloni <gpaoloni@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Robert Krutsch <krutsch@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Laura Abbott <labbott@kernel.org>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Scull <ascull@google.com>,
        Marc Zyngier <maz@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wang Qing <wangqing@vivo.com>, Mel Gorman <mgorman@suse.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Kitt <steve@sk2.org>, Stephen Boyd <sboyd@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, notify@kernel.org,
        main@lists.elisa.tech, safety-architecture@lists.elisa.tech,
        devel@lists.elisa.tech, Shuah Khan <shuah@kernel.org>
Subject: Re: [ELISA Safety Architecture WG] [PATCH v2 0/2] Introduce the
 pkill_on_warn parameter
Message-ID: <YZNuyssYsAB0ogUD@alley>
References: <20211027233215.306111-1-alex.popov@linux.com>
 <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
 <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
 <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com>
 <CAKXUXMx5Oi-dNVKB+8E-pdrz+ooELMZf=oT_oGXKFrNWejz=fg@mail.gmail.com>
 <22828e84-b34f-7132-c9e9-bb42baf9247b@redhat.com>
 <cf57fb34-460c-3211-840f-8a5e3d88811a@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf57fb34-460c-3211-840f-8a5e3d88811a@linux.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 2021-11-16 10:52:39, Alexander Popov wrote:
> On 15.11.2021 18:51, Gabriele Paoloni wrote:
> > On 15/11/2021 14:59, Lukas Bulwahn wrote:
> > > On Sat, Nov 13, 2021 at 7:14 PM Alexander Popov <alex.popov@linux.com> wrote:
> > > > On 13.11.2021 00:26, Linus Torvalds wrote:
> > > > > On Fri, Nov 12, 2021 at 10:52 AM Alexander Popov <alex.popov@linux.com> wrote:
> > > > Killing the process that hit a kernel warning complies with the Fail-Fast
> > > > principle [1]. pkill_on_warn sysctl allows the kernel to stop the process when
> > > > the **first signs** of wrong behavior are detected.
> > > > 
> > > In summary, I am not supporting pkill_on_warn. I would support the
> > > other points I mentioned above, i.e., a good enforced policy for use
> > > of warn() and any investigation to understand the complexity of
> > > panic() and reducing its complexity if triggered by such an
> > > investigation.
> > 
> > Hi Alex
> > 
> > I also agree with the summary that Lukas gave here. From my experience
> > the safety system are always guarded by an external flow monitor (e.g. a
> > watchdog) that triggers in case the safety relevant workloads slows down
> > or block (for any reason); given this condition of use, a system that
> > goes into the panic state is always safe, since the watchdog would
> > trigger and drive the system automatically into safe state.
> > So I also don't see a clear advantage of having pkill_on_warn();
> > actually on the flip side it seems to me that such feature could
> > introduce more risk, as it kills only the threads of the process that
> > caused the kernel warning whereas the other processes are trusted to
> > run on a weaker Kernel (does killing the threads of the process that
> > caused the kernel warning always fix the Kernel condition that lead to
> > the warning?)
> 
> Lukas, Gabriele, Robert,
> Thanks for showing this from the safety point of view.
> 
> The part about believing in panic() functionality is amazing :)

Nothing is 100% reliable.

With printk() maintainer hat on, the current panic() implementation
is less reliable because it tries hard to provide some debugging
information, for example, error message, backtrace, registry,
flush pending messages on console, crashdump.

See panic() implementation, the reboot is done by emergency_restart().
The rest is about duping the information.

Well, the information is important. Otherwise, it is really hard to
fix the problem.

From my experience, especially the access to consoles is not fully
safe. The reliability might improve a lot when a lockless console
is used. I guess that using non-volatile memory for the log buffer
might be even more reliable.

I am not familiar with the code under emergency_restart(). I am not
sure how reliable it is.

> Yes, safety critical systems depend on the robust ability to restart.

If I wanted to implement a super-reliable panic() I would
use some external device that would cause power-reset when
the watched device is not responding.

Best Regards,
Petr


PS: I do not believe much into the pkill approach as well.

    It is similar to OOM killer. And I always had to restart the
    system when it was triggered.

    Also kernel is not prepared for the situation that an external
    code kills a kthread. And kthreads are used by many subsystems
    to handle work that has to be done asynchronously and/or in
    process context. And I guess that kthreads are non-trivial
    source of WARN().
