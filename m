Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E19279452
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 00:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgIYWo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 18:44:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40484 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgIYWo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:44:59 -0400
Received: from [192.168.254.38] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id DE3432089ED3;
        Fri, 25 Sep 2020 15:44:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DE3432089ED3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601073897;
        bh=WY/Zhx0OkWgdKNXb6KD7NkVI4FAqTaUC8ip6BVzDyTw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Of1ErLnQKILG5G/HeAZUGf6kQFU4opuREYXDutW21uIYZBxzFgMS72QTjuwuNwDQG
         Qk7eQlshRTUs1GujwF3asIgJEn5KuPSJtJ7WxEgV/oKEmXTTpYwMI8imzyVAsnJ3Ev
         RbYisMeArtx5DWY+PTPXnxFPgtB8gFX1dSLeKYO8=
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, libffi-discuss@sourceware.org, luto@kernel.org,
        David.Laight@ACULAB.COM, mark.rutland@arm.com, mic@digikod.net,
        pavel@ucw.cz
References: <20200916150826.5990-1-madvenka@linux.microsoft.com>
 <87v9gdz01h.fsf@mid.deneb.enyo.de>
 <96ea02df-4154-5888-1669-f3beeed60b33@linux.microsoft.com>
 <20200923014616.GA1216401@rani.riverdale.lan>
 <20200923091125.GB1240819@rani.riverdale.lan>
 <a742b9cd-4ffb-60e0-63b8-894800009700@linux.microsoft.com>
 <20200923195147.GA1358246@rani.riverdale.lan>
 <2ed2becd-49b5-7e76-9836-6a43707f539f@linux.microsoft.com>
 <20200924234347.GA341645@rani.riverdale.lan>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <b9dfeea3-a36d-5b60-a37b-409363b39ffd@linux.microsoft.com>
Date:   Fri, 25 Sep 2020 17:44:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924234347.GA341645@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/24/20 6:43 PM, Arvind Sankar wrote:
> On Thu, Sep 24, 2020 at 03:23:52PM -0500, Madhavan T. Venkataraman wrote:
>>
>>
>>> Which ISA does not support PIC objects? You mentioned i386 below, but
>>> i386 does support them, it just needs to copy the PC into a GPR first
>>> (see below).
>>
>> Position Independent Code needs PC-relative branches. I was referring
>> to PC-relative data references. Like RIP-relative data references in
>> X64. i386 ISA does not support this.
> 
> I was talking about PC-relative data references too: they are a
> requirement for PIC code that wants to access any global data. They can
> be implemented easily on i386 even though it doesn't have an addressing
> mode that uses the PC.
> 
>> Otherwise, using an ABI quirk or a calling convention side effect to load the
>> PC into a GPR is, IMO, non-standard or non-compliant or non-approved or
>> whatever you want to call it. I would be conservative and not use it. Who knows
>> what incompatibility there will be with some future software or hardware
>> features?
>>
>> For instance, in the i386 example, we do a call without a matching return.
>> Also, we use a pop to undo the call. Can anyone tell me if this kind of use
>> is an ABI approved one?
> 
> This doesn't have anything to do with the ABI, since what happened here
> isn't visible to any caller or callee. Any machine instruction sequence
> that has the effect of copying the PC into a GPR is acceptable, but this
> is basically the only possible solution on i386. If you don't like the
> call/pop mismatch (though that's supported by the hardware, and is what
> clang likes to use), you can use the slightly different technique used
> in my example, which copies the top of stack into a GPR after a call.
> 
> This is how all i386 PIC code has always worked.
> 

I have responded to this in my reply to Florian. Basically, I accept the opinion
of the reviewers. I will assume that any trick we use to get the current PC into a
GPR will not cause ABI compliance issue in the future.

>> Standard API for all userland for all architectures
>> ---------------------------------------------------
>>
>> The next advantage in using the kernel is standardization.
>>
>> If the kernel supplies this, then all applications and libraries can use
>> it for all architectures with one single, simple API. Without this, each
>> application/library has to roll its own solution for every architecture-ABI
>> combo it wants to support.
> 
> But you can get even more standardization out of a userspace library,
> because that can work even on non-linux OS's, as well as versions of
> linux where the new syscall isn't available.
> 

Dealing with old vs new kernels is the same as dealing with old vs new libs.

In any case, what you have suggested above has already been suggested before
and I have accepted everyone's opinion. Please see my response to Florian's email.

>>
>> Furthermore, if this work gets accepted, I plan to add a glibc wrapper for
>> the kernel API. The glibc API would look something like this:
>>
>> 	Allocate a trampoline
>> 	---------------------
>>
>> 	tramp = alloc_tramp();
>>
>> 	Set trampoline parameters
>> 	-------------------------
>>
>> 	init_tramp(tramp, code, data);
>>
>> 	Free the trampoline
>> 	-------------------
>>
>> 	free_tramp(tramp);
>>
>> glibc will allocate and manage the code and data tables, handle kernel API
>> details and manage the trampoline table.
> 
> glibc could do this already if it wants, even without the syscall,
> because this can be done in userspace already.
> 

I am wary of using ABI tricks or calling convention side-effects. However,
since the reviewers feel it is OK, I have accepted that opinion. I have
assumed now that any trick to load the current PC into a GPR can be used
without any risk. I hope that assumption is correct.

>>
>> Secure vs Performant trampoline
>> -------------------------------
>>
>> If you recall, in version 1, I presented a trampoline type that is
>> implemented in the kernel. When an application invokes the trampoline,
>> it traps into the kernel and the kernel performs the work of the trampoline.
>>
>> The disadvantage is that a trip to the kernel is needed. That can be
>> expensive.
>>
>> The advantage is that the kernel can add security checks before doing the
>> work. Mainly, I am looking at checks that might prevent the trampoline
>> from being used in an ROP/BOP chain. Some half-baked ideas:
>>
>> 	- Check that the invocation is at the starting point of the
>> 	  trampoline
>>
>> 	- Check if the trampoline is jumping to an allowed PC
>>
>> 	- Check if the trampoline is being invoked from an allowed
>> 	  calling PC or PC range
>>
>> Allowed PCs can be input using the trampfd API mentioned in version 1.
>> Basically, an array of PCs is written into trampfd.
> 
> The source PC will generally not be available if the compiler decided to
> tail-call optimize the call to the trampoline into a jump.
> 

This is still work in progress. But I am thinking that labels can be used.
So, if the code is:

	invoke_tramp:
		(*tramp)();

then, invoke_tramp can be supplied as the calling PC.

Similarly, labels can be used in assembly functions as well.

Like I said, I have to think about this more.

> What's special about these trampolines anyway? Any indirect function
> call could have these same problems -- an attacker could have
> overwritten the pointer the same way, whether it's supposed to point to
> a normal function or it is the target of this trampoline.
> 
> For making them a bit safer, userspace could just map the page holding
> the data pointers/destination address(es) as read-only after
> initialization.
> 

You need to look at version 1 of trampfd for how to do "allowed pcs".
As an example, libffi defines ABI handlers for every arch-ABI combo.
These ABI handler pointers could be placed in an array in .rodata.
Then, the array can be written into trampfd for setting allowed PCS.
When the target PC is set for a trampoline, the kernel will check
it against allowed PCs and reject it if it has been overwritten.

>>
>> Suggestions for other checks are most welcome!
>>
>> I would like to implement an option in the trampfd API. The user can
>> choose a secure trampoline or a performant trampoline. For a performant
>> trampoline, the kernel will generate the code. For a secure trampoline,
>> the kernel will do the work itself.
>>
>> In order to address the FFI_REGISTER ABI in libffi, we could use the secure
>> trampoline. In FFI_REGISTER, the data is pushed on the stack and the code
>> is jumped to without using any registers.
>>
>> As outlined in version 1, the kernel can push the data address on the stack
>> and write the code address into the PC and return to userland.
>>
>> For doing all of this, we need trampfd.
> 
> We don't need this for FFI_REGISTER. I presented a solution that works
> in userspace. Even if you want to use a trampoline created by the
> kernel, there's no reason it needs to trap into the kernel at trampoline
> execution time. libffi's trampolines already handle this case today.
> 

libffi handles this using user level dynamic code which needs to be executed.
If the security subsystem prevents that, then the dynamic code cannot execute.
That is the whole point of this RFC.

>>
>> Permitting the use of trampfd
>> -----------------------------
>>
>> An "exectramp" setting can be implemented in SELinux to selectively allow the
>> use of trampfd for applications.
>>
>> Madhavan
> 
> Applications can use their own userspace trampolines regardless of this
> setting, so it doesn't provide any additional security benefit by
> preventing usage of trampfd.
> 

The background for all of this is that dynamic code such as trampolines
need to be placed in a page with executable permissions so they can
execute. If security measures such as W^X are present, this will not
be possible. Admitted, today some user level tricks exist to get around
W^X. I have alluded to those. IMO, they are all security holes and will
get plugged sooner or later. Then, these trampolines cannot execute.
Currently, there exist security exceptions such as execmem to let them
execute. But we would like to do it without making security exceptions.

Madhavan
