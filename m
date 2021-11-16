Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF47453296
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 14:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhKPNK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 08:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbhKPNKY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:10:24 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79442C061570;
        Tue, 16 Nov 2021 05:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1637068045;
        bh=CCY8GqrApXwby1Hbt51PqfGtVh1dhg5EbR5xIN52QR8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=d2YM51xHGowaVSrQ9jgIzzDA9OuPXxYP7vbOX2vVnaIKNWz8AvY6QzGhO+odp2wok
         HzMzRCD6ebhjICTjNA1rRnXdZF+lwU94s0Wl87DdcSigu4h/G33LHiyJjCeI3H8/5F
         Nbh7pc077HocCCinTmctfbhiOAwUG/sWxos2obkg=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E9B0B1280D04;
        Tue, 16 Nov 2021 08:07:25 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XZvdzU7voFax; Tue, 16 Nov 2021 08:07:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1637068045;
        bh=CCY8GqrApXwby1Hbt51PqfGtVh1dhg5EbR5xIN52QR8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=d2YM51xHGowaVSrQ9jgIzzDA9OuPXxYP7vbOX2vVnaIKNWz8AvY6QzGhO+odp2wok
         HzMzRCD6ebhjICTjNA1rRnXdZF+lwU94s0Wl87DdcSigu4h/G33LHiyJjCeI3H8/5F
         Nbh7pc077HocCCinTmctfbhiOAwUG/sWxos2obkg=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5155F1280D01;
        Tue, 16 Nov 2021 08:07:21 -0500 (EST)
Message-ID: <88093da62a4b85f015423cbd1ec2f5ad6eb0c5da.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 0/2] Introduce the pkill_on_warn parameter
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alexander Popov <alex.popov@linux.com>,
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
        Petr Mladek <pmladek@suse.com>,
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
Date:   Tue, 16 Nov 2021 08:07:19 -0500
In-Reply-To: <202111151116.933184F716@keescook>
References: <20211027233215.306111-1-alex.popov@linux.com>
         <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
         <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
         <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com>
         <CAKXUXMx5Oi-dNVKB+8E-pdrz+ooELMZf=oT_oGXKFrNWejz=fg@mail.gmail.com>
         <20211115110649.4f9cb390@gandalf.local.home>
         <202111151116.933184F716@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-11-15 at 14:06 -0800, Kees Cook wrote:
> On Mon, Nov 15, 2021 at 11:06:49AM -0500, Steven Rostedt wrote:
> > On Mon, 15 Nov 2021 14:59:57 +0100
> > Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > 
> > > 1. Allow a reasonably configured kernel to boot and run with
> > > panic_on_warn set. Warnings should only be raised when something
> > > is not configured as the developers expect it or the kernel is
> > > put into a state that generally is _unexpected_ and has been
> > > exposed little to the critical thought of the developer, to
> > > testing efforts and use in other systems in the wild. Warnings
> > > should not be used for something informative, which still allows
> > > the kernel to continue running in a proper way in a generally
> > > expected environment. Up to my knowledge, there are some kernels
> > > in production that run with panic_on_warn; so, IMHO, this
> > > requirement is generally accepted (we might of course
> > 
> > To me, WARN*() is the same as BUG*(). If it gets hit, it's a bug in
> > the kernel and needs to be fixed. I have several WARN*() calls in
> > my code, and it's all because the algorithms used is expected to
> > prevent the condition in the warning from happening. If the warning
> > triggers, it means either that the algorithm is wrong or my
> > assumption about the algorithm is wrong. In either case, the kernel
> > needs to be updated. All my tests fail if a WARN*() gets hit
> > (anywhere in the kernel, not just my own).
> > 
> > After reading all the replies and thinking about this more, I find
> > the pkill_on_warning actually worse than not doing anything. If you
> > are concerned about exploits from warnings, the only real solution
> > is a panic_on_warning. Yes, it brings down the system, but really,
> > it has to be brought down anyway, because it is in need of a kernel
> > update.
> 
> Hmm, yes. What it originally boiled down to, which is why Linus first
> objected to BUG(), was that we don't know what other parts of the
> system have been disrupted. The best example is just that of locking:
> if we BUG() or do_exit() in the middle of holding a lock, we'll wreck
> whatever subsystem that was attached to. Without a deterministic
> system state unwinder, there really isn't a "safe" way to just stop a
> kernel thread.

But this misses the real point: the majority of WARN conditions are in
device drivers checking expected device state against an internal state
model.  If this triggers it's a problem with the device not the thread,
so killing the thread is blaming the wrong party and making the
situation worse because it didn't do anything to address the actual
problem.

> With this pkill_on_warn, we avoid the BUG problem (since the thread
> of execution continues and stops at an 'expected' place: the signal
> handler).

And what about the unexpected state?

> However, now we have the newer objection from Linus, which is one of
> attribution: the WARN might be hit during an "unrelated" thread of
> execution and "current" gets blamed, etc. And beyond that, if we take
> down a portion of userspace, what in userspace may be destabilized?
> In theory, we get a case where any required daemons would be
> restarted by init, but that's not "known".
> 
> The safest version of this I can think of is for processes to opt
> into this mitigation. That would also cover the "special cases" we've
> seen exposed too. i.e. init and kthreads would not opt in.
> 
> However, that's a lot to implement when Marco's tracing suggestion
> might be sufficient and policy could be entirely implemented in
> userspace. It could be as simple as this (totally untested):

Really, no, this is precisely wrong thinking.  If the condition were
recoverable it wouldn't result in a WARN.  There are some WARNs where
we think the condition is unexpected enough not to bother adding error
handling (we need these reporting so we know that the assumption was
wrong), but for most if there were a way to handle it we'd have built
it into the usual error flow.  What WARN means is that an unexpected
condition occurred which means the kernel itself is in an unknown
state.  You can't recover from that by killing and restarting random
stuff, you have to reinitialize to a known state (i.e. reset the
system).  Some of the reason we do WARN instead of BUG is that we
believe the state contamination is limited and if you're careful the
system can continue in a degraded state if the user wants to accept the
risk.  Thinking the user can handle the state reset locally by some
preset policy is pure fantasy: if we didn't know how to fix it at the
point it occurred, why would something far away from the action when
most of the information has been lost have a better chance?

Your only policy choices when hitting WARN are

   1. Accept the risk and continue degraded operation, or
   2. reset the system to a known good state.

James



