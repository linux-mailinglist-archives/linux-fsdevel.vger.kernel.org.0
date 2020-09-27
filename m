Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488C727A22C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Sep 2020 19:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgI0R7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Sep 2020 13:59:52 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51636 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgI0R7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Sep 2020 13:59:52 -0400
Received: from [192.168.254.38] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0C87020B7178;
        Sun, 27 Sep 2020 10:59:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C87020B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601229590;
        bh=3zFwnKRcgxABj1at10B3AFPLB/6b8GJHVLkGjf9eUAk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RUUlitffQik8W7tu6hZ8IqiJOfZmg6DtFy7NKZ4oIXFAHWKtD2Tg1gzo0K/lOlztO
         HoSitzoPFEXIMvTJAzyOeHF+YNWryJYqMWhzoFh4DXtbmhcUoI9JKg2yoidLTLiOh+
         VdEFxjyZdZgXDbfVLYyzdjP7mFZfHlFBtllk3wFA=
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
 <b9dfeea3-a36d-5b60-a37b-409363b39ffd@linux.microsoft.com>
 <20200926155502.GA930344@rani.riverdale.lan>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <dcbe0b55-cc45-66e4-8666-571f87174b5c@linux.microsoft.com>
Date:   Sun, 27 Sep 2020 12:59:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200926155502.GA930344@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/26/20 10:55 AM, Arvind Sankar wrote:
> On Fri, Sep 25, 2020 at 05:44:56PM -0500, Madhavan T. Venkataraman wrote:
>>
>>
>> On 9/24/20 6:43 PM, Arvind Sankar wrote:
>>>
>>> The source PC will generally not be available if the compiler decided to
>>> tail-call optimize the call to the trampoline into a jump.
>>>
>>
>> This is still work in progress. But I am thinking that labels can be used.
>> So, if the code is:
>>
>> 	invoke_tramp:
>> 		(*tramp)();
>>
>> then, invoke_tramp can be supplied as the calling PC.
>>
>> Similarly, labels can be used in assembly functions as well.
>>
>> Like I said, I have to think about this more.
> 
> What I mean is that the kernel won't have access to the actual source
> PC. If I followed your v1 correctly, it works by making any branch to
> the trampoline code trigger a page fault. At this point, the PC has
> already been updated to the trampoline entry, so the only thing the
> fault handler can know is the return address on the top of the stack,
> which (a) might not be where the branch actually originated, either
> because it was a jump, or you've already been hacked and you got here
> using a ret; (b) is available to userspace anyway.

Like I said, this is work in progress. I have to spend time to figure out
how this would work or if this would work. So, let us brainstorm this
a little bit.

There are two ways to invoke the trampoline:

(1) By just branching to the trampoline address.

(2) Or, by treating the address as a function pointer and calling it.
    In the libffi case, it is (2).

If it is (2), it is easier. We can figure out the return address of the
call which would be the location after the call instruction.

If it is (1), it is harder as you point out. So, we can support this
at least for (2). The user can inform trampfd as to the type of
invocation for the trampoline.

For (1), the return address would be that of the call to the function
that contains the branch. If the kernel can get that call instruction
and figure out the function address, then we can do something.

I admit this is bit hairy at the moment. I have to work it out.

> 
>>
>>> What's special about these trampolines anyway? Any indirect function
>>> call could have these same problems -- an attacker could have
>>> overwritten the pointer the same way, whether it's supposed to point to
>>> a normal function or it is the target of this trampoline.
>>>
>>> For making them a bit safer, userspace could just map the page holding
>>> the data pointers/destination address(es) as read-only after
>>> initialization.
>>>
>>
>> You need to look at version 1 of trampfd for how to do "allowed pcs".
>> As an example, libffi defines ABI handlers for every arch-ABI combo.
>> These ABI handler pointers could be placed in an array in .rodata.
>> Then, the array can be written into trampfd for setting allowed PCS.
>> When the target PC is set for a trampoline, the kernel will check
>> it against allowed PCs and reject it if it has been overwritten.
> 
> I'm not asking how it's implemented. I'm asking what's the point? On a
> typical linux system, at least on x86, every library function call is an
> indirect branch. The protection they get is that the dynamic linker can
> map the pointer table read-only after initializing it.
> 

The security subsystem is concerned about dynamic code, not the indirect
branches set up for dynamic linking.


> For the RO mapping, libffi could be mapping both the entire closure
> structure, as well as the structure that describes the arguments and
> return types of the function, read-only once they are initialized.
> 

This has been suggested in some form before. The general problem with
this approach is that when the page is still writable, an attacker
can inject his code potentially. Making the page read-only after the
fact may not help. In specific use cases, it may work. But it is
not OK as a general approach to solving this problem.

> For libffi, there are three indirect branches for every trampoline call
> with your suggested trampoline: one to get to the trampoline, one to
> jump to the handler, and one to call the actual user function. If we are
> particularly concerned about the trampoline to handler branch for some
> reason, we could just replace it with a direct branch: if the kernel was
> generating the code, there's no reason to allow the data pointer or code
> target to be changed after the trampoline was created. It can just
> hard-code them in the generated code and be done with it. Even with
> user-space trampolines, you can use a direct call. All you need is
> libffi-trampoline.so which contains a few thousand trampolines all
> jumping to one handler, which then decides what to do based on which
> trampoline was called. Sure libffi currently dispatches to one of 2-3
> handlers based on the ABI, but there's no technical reason it couldn't
> dispatch to just one that handled all the ABIs, and the trampoline could
> be boiled down to just:
> 	endbr
> 	call handler
> 	ret
> 
One still needs this trampoline:

	load closure in some register
	jump to single_handler

In the kernel based solution, the user would specify to the kernel the
target PC in a code context.

	pwrite(trampfd, code_context, size, CODE_OFFSET);

code_context itself can be hacked unless it is in .rodata. The allowed_pcs
thing exists for apps/libs that are unable or unwilling to place code_context
in .rodata.

I would like to not just focus how to solve things for libffi alone.


>>>>
>>>> In order to address the FFI_REGISTER ABI in libffi, we could use the secure
>>>> trampoline. In FFI_REGISTER, the data is pushed on the stack and the code
>>>> is jumped to without using any registers.
>>>>
>>>> As outlined in version 1, the kernel can push the data address on the stack
>>>> and write the code address into the PC and return to userland.
>>>>
>>>> For doing all of this, we need trampfd.
>>>
>>> We don't need this for FFI_REGISTER. I presented a solution that works
>>> in userspace. Even if you want to use a trampoline created by the
>>> kernel, there's no reason it needs to trap into the kernel at trampoline
>>> execution time. libffi's trampolines already handle this case today.
>>>
>>
>> libffi handles this using user level dynamic code which needs to be executed.
>> If the security subsystem prevents that, then the dynamic code cannot execute.
>> That is the whole point of this RFC.
> 
> /If/ you are using a trampoline created by the kernel, it can just
> create the one that libffi is using today; which doesn't need trapping
> into the kernel at execution time.
> 
> And if you aren't, you can use the trampoline I wrote, which has no
> dynamic code, and doesn't need to trap into the kernel at execution time
> either.
> 

The kernel based solution gives you the opportunity to make additional
security checks at the time a trampoline is invoked. A purely user level
solution cannot do that. E.g., I would like to prevent even the minimal
trampoline from being used in BOP/ROP chains.

>>
>>>>
>>>> Permitting the use of trampfd
>>>> -----------------------------
>>>>
>>>> An "exectramp" setting can be implemented in SELinux to selectively allow the
>>>> use of trampfd for applications.
>>>>
>>>> Madhavan
>>>
>>> Applications can use their own userspace trampolines regardless of this
>>> setting, so it doesn't provide any additional security benefit by
>>> preventing usage of trampfd.
>>>
>>
>> The background for all of this is that dynamic code such as trampolines
>> need to be placed in a page with executable permissions so they can
>> execute. If security measures such as W^X are present, this will not
>> be possible. Admitted, today some user level tricks exist to get around
>> W^X. I have alluded to those. IMO, they are all security holes and will
>> get plugged sooner or later. Then, these trampolines cannot execute.
>> Currently, there exist security exceptions such as execmem to let them
>> execute. But we would like to do it without making security exceptions.
>>
>> Madhavan
> 
> How can you still say this after this whole discussion? Applications can
> get the exact same functionality as your proposed trampfd using static
> code, no W^X tricks needed.
> 
> This only matters if you have a trampfd that generates _truly_ dynamic
> code, not just code that can be trivially made static.
> 

How can *you* still say this after all this discussion?

I have already explained all of this. The trivial bootstrap trampoline can
be provided in a user library as well the kernel. The user land solution
provides a fast trampoline that does the job. The kernel solution
is slower but allows for additional security checks that a user land
solution does not allow. IMO, it should be a choice what type of trampoline
the user wants.

And this is not just for libffi that we can somehow do this within libffi.
I would like to provide something so that the maintainers of other
dynamic code can use it to convert their dynamic code to static code
when their dynamic code is a lot more complex that the libffi trampoline.

I am already willing to implement a user land only solution. I don't see
the problem.

Madhavan
