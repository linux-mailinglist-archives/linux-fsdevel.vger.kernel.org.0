Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E918822B755
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 22:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgGWUPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 16:15:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60982 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWUPU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:15:20 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595535317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wLeYvK4WU299PQEtv/NKty1ri+ij6okAVbv/cvUrEeY=;
        b=oyPtyDLEyrQxVGt8iJo2xBVK2GuF7oNCZSR0MZXlO55sJxMcbRwOTcx+pZMm8iupNKXkY6
        cmNtzBQ14NEZrpefB9QYqESp/CsQv15uuPoDty1IWmk7EkFqw0BvF+SMFXwhgJXdEOq5rA
        0oXjb1YnIKnXU+YnlCK6ARyPtSRZaG5FTFcxDobkytwRsenOVpi32CpfiCGflKlCMd97Xv
        K66n+f+ml/uyyisyllGyCA0lEfZgGSX8JWy+xVHuPNfppCO6WqD6LYPsdk6weGw638QfaJ
        npBu2XCpFllhkCWgpy53paqFUouUnngUtCxG+BVCjd1gsWXBw1/morHz26HXVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595535317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wLeYvK4WU299PQEtv/NKty1ri+ij6okAVbv/cvUrEeY=;
        b=xMq58S6bjjF6OmxCQMrCWKgry7jvqsd5b97YDXj6lRB8oTRACn+ydkU/iCO6YRSjFiVyVw
        OKqEl3CJJ8XV30CQ==
To:     Ira Weiny <ira.weiny@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <87o8o6vvt0.fsf@nanos.tec.linutronix.de>
References: <20200717072056.73134-1-ira.weiny@intel.com> <20200717072056.73134-18-ira.weiny@intel.com> <20200717100610.GH10769@hirez.programming.kicks-ass.net> <20200722052709.GB478587@iweiny-DESK2.sc.intel.com> <87o8o6vvt0.fsf@nanos.tec.linutronix.de>
Date:   Thu, 23 Jul 2020 22:15:17 +0200
Message-ID: <87lfjavvhm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Ira Weiny <ira.weiny@intel.com> writes:
>> On Fri, Jul 17, 2020 at 12:06:10PM +0200, Peter Zijlstra wrote:
>>> On Fri, Jul 17, 2020 at 12:20:56AM -0700, ira.weiny@intel.com wrote:
>> I've been really digging into this today and I'm very concerned that I'm
>> completely missing something WRT idtentry_enter() and idtentry_exit().
>>
>> I've instrumented idt_{save,restore}_pkrs(), and __dev_access_{en,dis}able()
>> with trace_printk()'s.
>>
>> With this debug code, I have found an instance where it seems like
>> idtentry_enter() is called without a corresponding idtentry_exit().  This has
>> left the thread ref counter at 0 which results in very bad things happening
>> when __dev_access_disable() is called and the ref count goes negative.
>>
>> Effectively this seems to be happening:
>>
>> ...
>> 	// ref == 0
>> 	dev_access_enable()  // ref += 1 ==> disable protection
>> 		// exception  (which one I don't know)
>> 			idtentry_enter()
>> 				// ref = 0
>> 				_handler() // or whatever code...
>> 			// *_exit() not called [at least there is no trace_printk() output]...
>> 			// Regardless of trace output, the ref is left at 0
>> 	dev_access_disable() // ref -= 1 ==> -1 ==> does not enable protection
>> 	(Bad stuff is bound to happen now...)
>
> Well, if any exception which calls idtentry_enter() would return without
> going through idtentry_exit() then lots of bad stuff would happen even
> without your patches.
>
>> Also is there any chance that the process could be getting scheduled and that
>> is causing an issue?
>
> Only from #PF, but after the fault has been resolved and the tasks is
> scheduled in again then the task returns through idtentry_exit() to the
> place where it took the fault. That's not guaranteed to be on the same
> CPU. If schedule is not aware of the fact that the exception turned off
> stuff then you surely get into trouble. So you really want to store it
> in the task itself then the context switch code can actually see the
> state and act accordingly.

Actually thats nasty as well as you need a stack of PKRS values to
handle nested exceptions. But it might be still the most reasonable
thing to do. 7 PKRS values plus an index should be really sufficient,
that's 32bytes total, not that bad.

Thanks,

        tglx
