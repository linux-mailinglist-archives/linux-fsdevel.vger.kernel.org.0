Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717B241C0F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 10:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244868AbhI2Iwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 04:52:40 -0400
Received: from foss.arm.com ([217.140.110.172]:51244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244640AbhI2Iwi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:52:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8B60101E;
        Wed, 29 Sep 2021 01:50:57 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.21.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 639C83F793;
        Wed, 29 Sep 2021 01:50:55 -0700 (PDT)
Date:   Wed, 29 Sep 2021 09:50:45 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+488ddf8087564d6de6e2@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org, x86@kernel.org
Subject: Re: [syzbot] upstream test error: KASAN: invalid-access Read in
 __entry_tramp_text_end
Message-ID: <20210929085035.GA33284@C02TD0UTHF1T.local>
References: <000000000000a3cf8605cb2a1ec0@google.com>
 <CACT4Y+aS6w1gFuMVY1fnAG0Yp0XckQTM+=tUHkOuxHUy2mkxrg@mail.gmail.com>
 <20210921165134.GE35846@C02TD0UTHF1T.local>
 <CACT4Y+ZjRgb57EV6mvC-bVK0uT0aPXUjtZJabuWasYcshKNcgw@mail.gmail.com>
 <20210927170122.GA9201@C02TD0UTHF1T.local>
 <20210927171812.GB9201@C02TD0UTHF1T.local>
 <CACT4Y+actfuftwMMOGXmEsLYbnCnqcZ2gJGeoMLsFCUNE-AxcQ@mail.gmail.com>
 <20210928103543.GF1924@C02TD0UTHF1T.local>
 <20210929013637.bcarm56e4mqo3ndt@treble>
 <YVQYQzP/vqNWm/hO@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVQYQzP/vqNWm/hO@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 09:39:47AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 28, 2021 at 06:36:37PM -0700, Josh Poimboeuf wrote:
> > On Tue, Sep 28, 2021 at 11:35:43AM +0100, Mark Rutland wrote:
> > > > In the other x86 thread Josh Poimboeuf suggested to use asm goto to a
> > > > cold part of the function instead of .fixup:
> > > > https://lore.kernel.org/lkml/20210927234543.6waods7rraxseind@treble/
> > > > This sounds like a more reliable solution that will cause less
> > > > maintenance burden. Would it work for arm64 as well?
> > > 
> > > Maybe we can use that when CC_HAS_ASM_GOTO_OUTPUT is avaiable, but in
> > > general we can't rely on asm goto supporting output arguments (and IIRC
> > > GCC doesn't support that at all), so we'd still have to support the
> > > current fixup scheme.
> 
> gcc-11 has it

Neat. Worth looking at for future, then.

> > Even without CC_HAS_ASM_GOTO_OUTPUT it should still be possible to hack
> > something together if you split the original insn asm and the extable
> > asm into separate statements, like:
> > 
> > diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> > index 6b52182e178a..8f62469f2027 100644
> > --- a/arch/x86/include/asm/msr.h
> > +++ b/arch/x86/include/asm/msr.h
> > @@ -137,20 +139,21 @@ static inline unsigned long long native_read_msr_safe(unsigned int msr,
> >  {
> >  	DECLARE_ARGS(val, low, high);
> >  
> > +	*err = 0;
> > +	asm volatile("417: rdmsr\n"
> > +		     : EAX_EDX_RET(val, low, high)
> > +		     : "c" (msr));
> > +	asm_volatile_goto(_ASM_EXTABLE(417b, %l[Efault]) :::: Efault);
> 
> That's terrible :-) Could probably do with a comment, but might just
> work..

The compiler is well within its rights to spill/restore/copy/shuffle
registers or modify memory between the two asm blocks (which it's liable
to do that when optimizing this after a few layers of inlining), and
skipping that would cause all sorts of undefined behaviour.

It's akin to trying to do an asm goto without the compiler supporting
asm goto.

This would probably happen to work in the common case, but it'd cause
nightmarish bugs in others...

Thanks,
Mark.


> > +
> > +done:
> >  	if (tracepoint_enabled(read_msr))
> >  		do_trace_read_msr(msr, EAX_EDX_VAL(val, low, high), *err);
> >  	return EAX_EDX_VAL(val, low, high);
> > +
> > +Efault:
> > +	*err = -EIO;
> > +	ZERO_ARGS(val, low, high);
> > +	goto done;
> >  }
> >  
> >  /* Can be uninlined because referenced by paravirt */
> > 
