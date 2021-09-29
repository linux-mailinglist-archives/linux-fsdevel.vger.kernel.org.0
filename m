Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB2141C2C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 12:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244333AbhI2KjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 06:39:17 -0400
Received: from foss.arm.com ([217.140.110.172]:58210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232437AbhI2KjR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:39:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EECB0D6E;
        Wed, 29 Sep 2021 03:37:35 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.21.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 594C63F70D;
        Wed, 29 Sep 2021 03:37:33 -0700 (PDT)
Date:   Wed, 29 Sep 2021 11:37:30 +0100
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
Message-ID: <20210929103730.GC33284@C02TD0UTHF1T.local>
References: <20210921165134.GE35846@C02TD0UTHF1T.local>
 <CACT4Y+ZjRgb57EV6mvC-bVK0uT0aPXUjtZJabuWasYcshKNcgw@mail.gmail.com>
 <20210927170122.GA9201@C02TD0UTHF1T.local>
 <20210927171812.GB9201@C02TD0UTHF1T.local>
 <CACT4Y+actfuftwMMOGXmEsLYbnCnqcZ2gJGeoMLsFCUNE-AxcQ@mail.gmail.com>
 <20210928103543.GF1924@C02TD0UTHF1T.local>
 <20210929013637.bcarm56e4mqo3ndt@treble>
 <YVQYQzP/vqNWm/hO@hirez.programming.kicks-ass.net>
 <20210929085035.GA33284@C02TD0UTHF1T.local>
 <YVQ5F9aT7oSEKenh@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVQ5F9aT7oSEKenh@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:59:51AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 29, 2021 at 09:50:45AM +0100, Mark Rutland wrote:
> > On Wed, Sep 29, 2021 at 09:39:47AM +0200, Peter Zijlstra wrote:
> > > On Tue, Sep 28, 2021 at 06:36:37PM -0700, Josh Poimboeuf wrote:
> 
> > > > +	asm volatile("417: rdmsr\n"
> > > > +		     : EAX_EDX_RET(val, low, high)
> > > > +		     : "c" (msr));
> > > > +	asm_volatile_goto(_ASM_EXTABLE(417b, %l[Efault]) :::: Efault);
> > > 
> > > That's terrible :-) Could probably do with a comment, but might just
> > > work..
> > 
> > The compiler is well within its rights to spill/restore/copy/shuffle
> > registers or modify memory between the two asm blocks (which it's liable
> > to do that when optimizing this after a few layers of inlining), and
> > skipping that would cause all sorts of undefined behaviour.
> 
> Ah, but in this case it'll work irrespective of that (which is why we
> needs a comment!).
> 
> This is because _ASM_EXTABLE only generates data for another section.
> There doesn't need to be code continuity between these two asm
> statements.

I think you've missed my point. It doesn't matter that the
asm_volatile_goto() doesn't contain code, and this is solely about the
*state* expected at entry/exit from each asm block being different.

The problem is that when the compiler encounters the
asm_volatile_goto(), it will generate a target for `Efault` expecting
the state of registers/stack/etc to be consistent with the state at
entry to the asm_volatile_goto() block. So if the compiler places any
register/memory manipulation between the asm volatile and the
asm_volatile_goto block, that expectation will be violated, since we
effectively branch from the first asm volatile block directly to the
label handed to the asm_volatile_goto block.

Consider the following pseudo asm example:

inline unsigned long read_magic_asm_thing(void)
{
	// asm constraints allocates this into x3 for now
	unsigned long ret = 3;

	asm volatile(
	"magic_insn_that_can_only_read_into x3\n"
	"fault_insn: some_faulting_insn x3\n"
	: [x3] "x3" (ret)
	);

	// compiler moves x3 into x0 because that's simpler for later
	// code (in both the fall-through and branch case of the
	// asm_volatile_goto()).
	// Maybe it shuffles other things too, e.g. moving another
	// variable into x3.

	// This is generated expecting the register allocation at this
	// instant in the code
	asm_volatile_goto(extable_from_to(fault_isn, Efault));

	// When not faulting, x0 is used here; this works correctly.
	return ret;

Efault:
	// When we take a fault from the first asm, the `ret` value is
	// in x3, and we skipped the moves between the two asm blocks.
	// This code was generated assuming those had happened (since
	// that was the case at the start of the asm_volatile_goto(),
	// and consumes x0 here, which contains garbage.
	do_something_with(ret);

	// Maybe this uses something that was moved into x3, but we have
	// `ret` there instead.
	something_else();
	
	// Who knows if we even got here safely.
	return whatever;
}

Thanks,
Mark.
