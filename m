Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06B441ED68
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 14:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353589AbhJAM3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 08:29:00 -0400
Received: from foss.arm.com ([217.140.110.172]:42676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231312AbhJAM3A (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:29:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BE1B106F;
        Fri,  1 Oct 2021 05:27:15 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.20.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 897F93F70D;
        Fri,  1 Oct 2021 05:27:12 -0700 (PDT)
Date:   Fri, 1 Oct 2021 13:27:06 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+488ddf8087564d6de6e2@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org, x86@kernel.org, live-patching@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [syzbot] upstream test error: KASAN: invalid-access Read in
 __entry_tramp_text_end
Message-ID: <20211001122706.GA66786@C02TD0UTHF1T.local>
References: <20210927171812.GB9201@C02TD0UTHF1T.local>
 <CACT4Y+actfuftwMMOGXmEsLYbnCnqcZ2gJGeoMLsFCUNE-AxcQ@mail.gmail.com>
 <20210928103543.GF1924@C02TD0UTHF1T.local>
 <20210929013637.bcarm56e4mqo3ndt@treble>
 <YVQYQzP/vqNWm/hO@hirez.programming.kicks-ass.net>
 <20210929085035.GA33284@C02TD0UTHF1T.local>
 <YVQ5F9aT7oSEKenh@hirez.programming.kicks-ass.net>
 <20210929103730.GC33284@C02TD0UTHF1T.local>
 <YVRRWzXqhMIpwelm@hirez.programming.kicks-ass.net>
 <20210930192638.xwemcsohivoynwx3@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930192638.xwemcsohivoynwx3@treble>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 12:26:38PM -0700, Josh Poimboeuf wrote:
> On Wed, Sep 29, 2021 at 01:43:23PM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 29, 2021 at 11:37:30AM +0100, Mark Rutland wrote:
> > 
> > > > This is because _ASM_EXTABLE only generates data for another section.
> > > > There doesn't need to be code continuity between these two asm
> > > > statements.
> > > 
> > > I think you've missed my point. It doesn't matter that the
> > > asm_volatile_goto() doesn't contain code, and this is solely about the
> > > *state* expected at entry/exit from each asm block being different.
> > 
> > Urgh.. indeed :/
> 
> So much for that idea :-/
> 
> To fix the issue of the wrong .fixup code symbol names getting printed,
> we could (as Mark suggested) add a '__fixup_text_start' symbol at the
> start of the .fixup section.  And then remove all other symbols in the
> .fixup section.

Just to be clear, that was just as a "make debugging slightly less
painful" aid, not as a fix for reliable stackrtrace and all that.

> For x86, that means removing the kvm_fastop_exception symbol and a few
> others.  That way it's all anonymous code, displayed by the kernel as
> "__fixup_text_start+0x1234".  Which isn't all that useful, but still
> better than printing the wrong symbol.
> 
> But there's still a bigger problem: the function with the faulting
> instruction doesn't get reported in the stack trace.
> 
> For example, in the up-thread bug report, __d_lookup() bug report
> doesn't get printed, even though its anonymous .fixup code is running in
> the context of the function and will be branching back to it shortly.
> 
> Even worse, this means livepatch is broken, because if for example
> __d_lookup()'s .fixup code gets preempted, __d_lookup() can get skipped
> by a reliable stack trace.
> 
> So we may need to get rid of .fixup altogether.  Especially for arches
> which support livepatch.
> 
> We can replace some of the custom .fixup handlers with generic handlers
> like x86 does, which do the fixup work in exception context.  This
> generally works better for more generic work like putting an error code
> in a certain register and resuming execution at the subsequent
> instruction.

I reckon even ignoring the unwind problems this'd be a good thing since
it'd save on redundant copies of the fixup logic that happen to be
identical, and the common cases like uaccess all fall into this shape.

As for how to do that, in the past Peter and I had come up with some
assembler trickery to get the name of the error code register encoded
into the extable info:

  https://lore.kernel.org/lkml/20170207111011.GB28790@leverpostej/
  https://lore.kernel.org/lkml/20170207160300.GB26173@leverpostej/
  https://lore.kernel.org/lkml/20170208091250.GT6515@twins.programming.kicks-ass.net/

... but maybe that's already solved on x86 in a different way?

> However a lot of the .fixup code is rather custom and doesn't
> necessarily work well with that model.

Looking at arm64, even where we'd need custom handlers it does appear we
could mostly do that out-of-line in the exception handler. The more
exotic cases are largely in out-of-line asm functions, where we can move
the fixups within the function, after the usual return.

I reckon we can handle the fixups for load_unaligned_zeropad() in the
exception handler.

Is there anything specific that you think is painful in the exception
handler?

> In such cases we could just move the .fixup code into the function
> (inline for older compilers; out-of-line for compilers that support
> CC_HAS_ASM_GOTO_OUTPUT).
> 
> Alternatively we could convert each .fixup code fragment into a proper
> function which returns to a specified resume point in the function, and
> then have the exception handler emulate a call to it like we do with
> int3_emulate_call().

For arm64 this would be somewhat unfortunate for inline asm due to our
calling convention -- we'd have to clobber the LR, and we'd need to
force the creation of a frame record in the caller which would otherwise
not be necessary.

Thanks,
Mark.
