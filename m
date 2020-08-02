Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EB8239CEA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 00:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHBW7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Aug 2020 18:59:02 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57188 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgHBW7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Aug 2020 18:59:02 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2BD5420B4908;
        Sun,  2 Aug 2020 15:59:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2BD5420B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596409140;
        bh=Q7q31WyGpO6J3iZ6HoTSTxcyY2RYOO3HoBrVjNyqpPA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pT2y52UBji3W0nv8oaWqlXsVHl+hqxrTJnSZ5683V0Vq7481OEdHqda3OONYprXUp
         pUvC7Ja7yH7A7A7PnhVPoN4/nCrqBhOuCsyTs5k8KgsuxVR6rM+c6V/PJxlx37f+KW
         8krLq5y3aSQx9KIXxSdL4F/U4BEfCPv/l8nRqqTQ=
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
 <3b916198-3a98-bd19-9a1c-f2d8d44febe8@linux.microsoft.com>
 <CALCETrUJ2hBmJujyCtEqx4=pknRvjvi1-Gj9wfRcMMzejjKQsQ@mail.gmail.com>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <0fa7d888-c4fd-aeb3-db08-151ea648558d@linux.microsoft.com>
Date:   Sun, 2 Aug 2020 17:58:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUJ2hBmJujyCtEqx4=pknRvjvi1-Gj9wfRcMMzejjKQsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/2/20 3:00 PM, Andy Lutomirski wrote:
> On Sun, Aug 2, 2020 at 11:54 AM Madhavan T. Venkataraman
> <madvenka@linux.microsoft.com> wrote:
>> More responses inline..
>>
>> On 7/28/20 12:31 PM, Andy Lutomirski wrote:
>>>> On Jul 28, 2020, at 6:11 AM, madvenka@linux.microsoft.com wrote:
>>>>
>>>> ﻿From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
>>>>
>>> 2. Use existing kernel functionality.  Raise a signal, modify the
>>> state, and return from the signal.  This is very flexible and may not
>>> be all that much slower than trampfd.
>> Let me understand this. You are saying that the trampoline code
>> would raise a signal and, in the signal handler, set up the context
>> so that when the signal handler returns, we end up in the target
>> function with the context correctly set up. And, this trampoline code
>> can be generated statically at build time so that there are no
>> security issues using it.
>>
>> Have I understood your suggestion correctly?
> yes.
>
>> So, my argument would be that this would always incur the overhead
>> of a trip to the kernel. I think twice the overhead if I am not mistaken.
>> With trampfd, we can have the kernel generate the code so that there
>> is no performance penalty at all.
> I feel like trampfd is too poorly defined at this point to evaluate.
> There are three general things it could do.  It could generate actual
> code that varies by instance.  It could have static code that does not
> vary.  And it could actually involve a kernel entry.
>
> If it involves a kernel entry, then it's slow.  Maybe this is okay for
> some use cases.

Yes. IMO, it is OK for most cases except where dynamic code
is used specifically for enhancing performance such as interpreters
using JIT code for frequently executed sequences and dynamic
binary translation.

> If it involves only static code, I see no good reason that it should
> be in the kernel.

It does not involve only static code. This is meant for dynamic code.
However, see below.

> If it involves dynamic code, then I think it needs a clearly defined
> use case that actually requires dynamic code.

Fair enough. I will work on this and get back to you. This might take
a little time. So, bear with me.

But I would like to make one point here. There are many applications
and libraries out there that use trampolines. They may all require the
same sort of things:

    - set register context
    - push stuff on stack
    - jump to a target PC

But in each case, the context would be different:

    - only register context
    - only stack context
    - both register and stack contexts
    - different registers
    - different values pushed on the stack
    - different target PCs

If we had to do this purely at user level, each application/library would
need to roll its own solution, the solution has to be implemented for
each supported architecture and maintained. While the code is static
in each separate case, it is dynamic across all of them.

That is, the kernel will generate the code on the fly for each trampoline
instance based on its current context. It will not maintain any static
trampoline code at all.

Basically, it will supply the context to an arch-specific function and say:

    - generate instructions for loading these regs with these values
    - generate instructions to push these values on the stack
    - generate an instruction to jump to this target PC

It will place all of those generated instructions on a page and return the address.

So, even with the static case, there is a lot of value in the kernel providing
this. Plus, it has the framework to handle dynamic code.

>> Also, signals are asynchronous. So, they are vulnerable to race conditions.
>> To prevent other signals from coming in while handling the raised signal,
>> we would need to block and unblock signals. This will cause more
>> overhead.
> If you're worried about raise() racing against signals from out of
> thread, you have bigger problems to deal with.

Agreed. The signal blocking is just one example of problems related
to signals. There are other bigger problems as well. So, let us remove
the signal-based approach from our discussions.

Thanks.

Madhavan
