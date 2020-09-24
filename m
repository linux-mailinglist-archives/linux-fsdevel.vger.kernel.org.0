Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89EC277A22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 22:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIXUX4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 16:23:56 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38718 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXUX4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:23:56 -0400
Received: from [192.168.254.38] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1691420B7179;
        Thu, 24 Sep 2020 13:23:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1691420B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600979034;
        bh=+237tDspiVrie5yBP4VnYYu5EdHBP8CLEagktXJUIh0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m9ieD3411ySMRyYTZj0HBVhwJ2vpH7M2uALr6xd0ro7ushCvjRwuKOLgGf2j5onXW
         coOERdSa0yW7KltJ4+GBkMTq9XpZgZaUr5+hLUlOBSIt00Ms8RIYwoiAChQqd7uTs3
         ojHylXUFG38DkhHGUlferrWOL47+8MEWvMmAOGLc=
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
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <2ed2becd-49b5-7e76-9836-6a43707f539f@linux.microsoft.com>
Date:   Thu, 24 Sep 2020 15:23:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923195147.GA1358246@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/23/20 2:51 PM, Arvind Sankar wrote:
> On Wed, Sep 23, 2020 at 02:17:30PM -0500, Madhavan T. Venkataraman wrote:
>>
>>
>> On 9/23/20 4:11 AM, Arvind Sankar wrote:
>>> For libffi, I think the proposed standard trampoline won't actually
>>> work, because not all ABIs have two scratch registers available to use
>>> as code_reg and data_reg. Eg i386 fastcall only has one, and register
>>> has zero scratch registers. I believe 32-bit ARM only has one scratch
>>> register as well.
>>
>> The trampoline is invoked as a function call in the libffi case. Any
>> caller saved register can be used as code_reg, can it not? And the
>> scratch register is needed only to jump to the code. After that, it
>> can be reused for any other purpose.
>>
>> However, for ARM, you are quite correct. There is only one scratch
>> register. This means that I have to provide two types of trampolines:
>>
>> 	- If an architecture has enough scratch registers, use the currently
>> 	  defined trampoline.
>>
>> 	- If the architecture has only one scratch register, but has PC-relative
>> 	  data references, then embed the code address at the bottom of the
>> 	  trampoline and access it using PC-relative addressing.
>>
>> Thanks for pointing this out.
>>
>> Madhavan
> 
> libffi is trying to provide closures with non-standard ABIs as well: the
> actual user function is standard ABI, but the closure can be called with
> a different ABI. If the closure was created with FFI_REGISTER abi, there
> are no registers available for the trampoline to use: EAX, EDX and ECX
> contain the first three arguments of the function, and every other
> register is callee-save.
> 
> I provided a sample of the kind of trampoline that would be needed in
> this case -- it's position-independent and doesn't clobber any registers
> at all, and you get 255 trampolines per page. If I take another 16-byte
> slot out of the page for the end trampoline that does the actual work,
> I'm sure I could even come up with one that can just call a normal C
> function, only the return might need special handling depending on the
> return type.
> 
> And again, do you actually have any example of an architecture that
> cannot run position-independent code? PC-relative addressing is an
> implementation detail: the fact that it's available for x86_64 but not
> for i386 just makes position-independent code more cumbersome on i386,
> but it doesn't make it impossible. For the tiny trampolines here, it
> makes almost no difference.
> 

I have tried to answer all of your previous comments here. Let me know
if I missed anything:


> Which ISA does not support PIC objects? You mentioned i386 below, but
> i386 does support them, it just needs to copy the PC into a GPR first
> (see below).

Position Independent Code needs PC-relative branches. I was referring
to PC-relative data references. Like RIP-relative data references in
X64. i386 ISA does not support this.

> i386 just needs a tiny bit of code to copy the PC into a GPR first, i.e.
> the trampoline would be:
> 
> 	call	1f
> 1:	pop	%data_reg
> 	movl	(code_table + X - 1b)(%data_reg), %code_reg
> 	movl	(data_table + X - 1b)(%data_reg), %data_reg
> 	jmp	*(%code_reg)
> 
> I do not understand the point about passing data at runtime. This
> trampoline is to achieve exactly that, no?

PC-relative data referencing
----------------------------

I agree that the current PC value can be loaded in a GPR using the trick
of call, pop on i386.

Perhaps, on other architectures, we can do similar things. For instance,
in architectures that load the return address in a designated register
instead of pushing it on the stack, the trampoline could call a leaf function
that moves the value of that register into data_reg so that at the location
after the call instruction, the current PC is already loaded in data_reg.
SPARC is one example I can think of.

My take is - if the ISA supports PC-relative data referencing explicitly (like
X64 or ARM64), then we can use it. Or, if the ABI specification documents an
approved way to load the PC into a GPR, we can use it.

Otherwise, using an ABI quirk or a calling convention side effect to load the
PC into a GPR is, IMO, non-standard or non-compliant or non-approved or
whatever you want to call it. I would be conservative and not use it. Who knows
what incompatibility there will be with some future software or hardware
features?

For instance, in the i386 example, we do a call without a matching return.
Also, we use a pop to undo the call. Can anyone tell me if this kind of use
is an ABI approved one?

Kernel supplied trampoline
--------------------------

One advantage in doing this in the kernel is that we don't need to use
non-standard or non-ABI compliant code.

To minimize the number of registers used by the trampoline, I will redefine
the kernel generated trampoline as follows:

- The kernel loads the trampoline and the code and the data addresses to be
  dereferenced like this:

	A ----> -------------------
		| Trampoline code |
	B ---->	-------------------
	        | Data Address    |
		-------------------
		| Code Address    |
		-------------------

So, the trampoline code would be:

	mov B, %data_reg
	jump (%data_reg + sizeof(Data address))

The kernel will hard code B into the trampoline.

The static code that the trampoline jumps to looks like this:

	load (%data_reg), %data_reg
	rest of the code

Use of scratch registers
------------------------

With this new trampoline, we only use one scratch register. So, the same
RFC will work for libffi on ARM.

You pointed out that in the FFI_REGISTER ABI no scratch registers can
be used. Read the section "Secure vs Performant trampoline" below where
this is addressed.

Standard API for all userland for all architectures
---------------------------------------------------

The next advantage in using the kernel is standardization.

If the kernel supplies this, then all applications and libraries can use
it for all architectures with one single, simple API. Without this, each
application/library has to roll its own solution for every architecture-ABI
combo it wants to support.

Furthermore, if this work gets accepted, I plan to add a glibc wrapper for
the kernel API. The glibc API would look something like this:

	Allocate a trampoline
	---------------------

	tramp = alloc_tramp();

	Set trampoline parameters
	-------------------------

	init_tramp(tramp, code, data);

	Free the trampoline
	-------------------

	free_tramp(tramp);

glibc will allocate and manage the code and data tables, handle kernel API
details and manage the trampoline table.

As an example, in libffi:

	ffi_closure_alloc() would call alloc_tramp()

	ffi_prep_closure_loc() would call init_tramp()

	ffi_closure_free() would call free_tramp()

That is it! It works on all the architectures supported in the kernel for
trampfd.

This makes it really easy for maintainers to adopt the API and move their
code to a more secure model (which is the fundamental idea behind this work).
For this advantage alone, IMO, it is worth doing it in the kernel.

Secure vs Performant trampoline
-------------------------------

If you recall, in version 1, I presented a trampoline type that is
implemented in the kernel. When an application invokes the trampoline,
it traps into the kernel and the kernel performs the work of the trampoline.

The disadvantage is that a trip to the kernel is needed. That can be
expensive.

The advantage is that the kernel can add security checks before doing the
work. Mainly, I am looking at checks that might prevent the trampoline
from being used in an ROP/BOP chain. Some half-baked ideas:

	- Check that the invocation is at the starting point of the
	  trampoline

	- Check if the trampoline is jumping to an allowed PC

	- Check if the trampoline is being invoked from an allowed
	  calling PC or PC range

Allowed PCs can be input using the trampfd API mentioned in version 1.
Basically, an array of PCs is written into trampfd.

Suggestions for other checks are most welcome!

I would like to implement an option in the trampfd API. The user can
choose a secure trampoline or a performant trampoline. For a performant
trampoline, the kernel will generate the code. For a secure trampoline,
the kernel will do the work itself.

In order to address the FFI_REGISTER ABI in libffi, we could use the secure
trampoline. In FFI_REGISTER, the data is pushed on the stack and the code
is jumped to without using any registers.

As outlined in version 1, the kernel can push the data address on the stack
and write the code address into the PC and return to userland.

For doing all of this, we need trampfd.

Permitting the use of trampfd
-----------------------------

An "exectramp" setting can be implemented in SELinux to selectively allow the
use of trampfd for applications.

Madhavan
