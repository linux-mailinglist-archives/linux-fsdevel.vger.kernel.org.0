Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBDA23AB11
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 18:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgHCQ6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 12:58:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50394 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgHCQ6B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:58:01 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id B467120B4908;
        Mon,  3 Aug 2020 09:57:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B467120B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596473879;
        bh=/Go4zDYeTSuk4ndgu/MFpJIHKPIA61513wAH+zPQLoI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AEHkwZqwS8l770QsNs1X/AW1JIln6ecQ6zphLAP5to5/s35qA3/J5LEbv6frVRUUF
         MHxTURiYIgHfk2JxoDpbifS5VeL98OH4Nf74SvuznSa1gdrWSWukAFBDwb8hz1JjEQ
         hZaM11haDW8Rx5erWwK/c0VofTMWwP0O5L7cEKXQ=
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <20200731180955.GC67415@C02TD0UTHF1T.local>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <6236adf7-4bed-534e-0956-fddab4fd96b6@linux.microsoft.com>
Date:   Mon, 3 Aug 2020 11:57:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731180955.GC67415@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Responses inline..

On 7/31/20 1:09 PM, Mark Rutland wrote:
> Hi,
>
> On Tue, Jul 28, 2020 at 08:10:46AM -0500, madvenka@linux.microsoft.com wrote:
>> From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
>> Trampoline code is placed either in a data page or in a stack page. In
>> order to execute a trampoline, the page it resides in needs to be mapped
>> with execute permissions. Writable pages with execute permissions provide
>> an attack surface for hackers. Attackers can use this to inject malicious
>> code, modify existing code or do other harm.
> For the purpose of below, IIUC this assumes the adversary has an
> arbitrary write.
>
>> To mitigate this, LSMs such as SELinux may not allow pages to have both
>> write and execute permissions. This prevents trampolines from executing
>> and blocks applications that use trampolines. To allow genuine applications
>> to run, exceptions have to be made for them (by setting execmem, etc).
>> In this case, the attack surface is just the pages of such applications.
>>
>> An application that is not allowed to have writable executable pages
>> may try to load trampoline code into a file and map the file with execute
>> permissions. In this case, the attack surface is just the buffer that
>> contains trampoline code. However, a successful exploit may provide the
>> hacker with means to load his own code in a file, map it and execute it.
> It's not clear to me what power the adversary is assumed to have here,
> and consequently it's not clear to me how the proposal mitigates this.
>
> For example, if the attack can control the arguments to syscalls, and
> has an arbitrary write as above, what prevents them from creating a
> trampfd of their own?

That is the point. If a process is allowed to have pages that are both
writable and executable, a hacker can exploit some vulnerability such
as buffer overflow to write his own code into a page and somehow
contrive to execute that.

So, the context is - if security settings in a system disallow a page to have
both write and execute permissions, how do you allow the execution of
genuine trampolines that are runtime generated and placed in a data
page or a stack page?

trampfd tries to address that. So, trampfd is not a measure that increases
the security of a system or mitigates a security problem. It is a framework
to allow safe forms of dynamic code to execute when security settings
will block them otherwise.

>
> [...]
>
>> GCC has traditionally used trampolines for implementing nested
>> functions. The trampoline is placed on the user stack. So, the stack
>> needs to be executable.
> IIUC generally nested functions are avoided these days, specifically to
> prevent the creation of gadgets on the stack. So I don't think those are
> relevant as a cased to care about. Applications using them should move
> to not using them, and would be more secure generally for doing so.

Could not agree with you more.
>
> [...]
>
>> Trampoline File Descriptor (trampfd)
>> --------------------------
>>
>> I am proposing a kernel API using anonymous file descriptors that
>> can be used to create and execute trampolines with the help of the
>> kernel. In this solution also, the kernel does the work of the trampoline.
> What's the rationale for the kernel emulating the trampoline here?
>
> In ther case of EMUTRAMP this was necessary to work with existing
> application binaries and kernel ABIs which placed instructions onto the
> stack, and the stack needed to remain RW for other reasons. That
> restriction doesn't apply here.

In addition to the stack, EMUTRAMP also allows the emulation
of the same well-known trampolines placed in a non-stack data page.
For instance, libffi closures embed a trampoline in a closure structure.
That gets executed when the caller of libffi invokes it.

The goal of EMUTRAMP is to allow safe trampolines to execute when
security settings disallow their execution. Mainly, it permits applications
that use libffi to run. A lot of applications use libffi.

They chose the emulation method so that no changes need to be made
to application code to use them. But the EMUTRAMP implementors note
in their description that the real solution to the problem is a kernel
API that is backed by a safe code generator.

trampd is an attempt to define such an API. This is just a starting point.
I realize that we need to have a lot of discussion to refine the approach.

> Assuming trampfd creation is somehow authenticated, the code could be
> placed in a r-x page (which the kernel could refuse to add write
> permission), in order to prevent modification. If that's sufficient,
> it's not much of a leap to allow userspace to generate the code.

IIUC, you are suggesting that the user hands the kernel a code fragment
and requests it to be placed in an r-x page, correct? However, the
kernel cannot trust any code given to it by the user. Nor can it scan any
piece of code and reliably decide if it is safe or not.

So, the problem of executing dynamic code when security settings are
restrictive cannot be solved in userland. The only option I can think of is
to have the kernel provide support for dynamic code. It must have one
or more safe, trusted code generation components and an API to use
the components.

My goal is to introduce an API and start off by supporting simple, regular
trampolines that are widely used. Then, evolve the feature over a period
of time to include other forms of dynamic code such as JIT code.

>> The kernel creates the trampoline mapping without any permissions. When
>> the trampoline is executed by user code, a page fault happens and the
>> kernel gets control. The kernel recognizes that this is a trampoline
>> invocation. It sets up the user registers based on the specified
>> register context, and/or pushes values on the user stack based on the
>> specified stack context, and sets the user PC to the requested target
>> PC. When the kernel returns, execution continues at the target PC.
>> So, the kernel does the work of the trampoline on behalf of the
>> application.
>>
>> In this case, the attack surface is the context buffer. A hacker may
>> attack an application with a vulnerability and may be able to modify the
>> context buffer. So, when the register or stack context is set for
>> a trampoline, the values may have been tampered with. From an attack
>> surface perspective, this is similar to Trampoline Emulation. But
>> with trampfd, user code can retrieve a trampoline's context from the
>> kernel and add defensive checks to see if the context has been
>> tampered with.
> Can you elaborate on this: what sort of checks would be applied, and
> how?

So, an application that uses trampfd would do the following steps:

1. Create a trampoline by calling trampfd_create()
2. Set the register and/or stack contexts for the trampoline.
3. mmap() the trampoline to get an address
4. Invoke the trampoline using the address

Let us say that the application has a vulnerability such as buffer overflow
that allows a hacker to modify the data that is used to do step 2.

Potentially, a hacker could modify the following things:
    - register values specified in the register context
    - values specified in the stack context
    - the target PC specified in the register context

When the trampoline is invoked in step 4, the kernel will gain control,
load the registers, push stuff on the stack and transfer control to the target
PC. Whatever the hacker had modified in step 2 will take effect in step 4.
His values will get loaded and his PC is the one that will get control.

A paranoid application could add a step to this sequence. So, the steps
would be:

1. Create a trampoline by calling trampfd_create()
2. Set the register and/or stack contexts for the trampoline.
3. mmap() the trampoline to get an address
4a. Retrieve the register and stack context for the trampoline from the
      kernel and check if anything has been altered. If yes, abort.
4b. Invoke the trampoline using the address

The check that I mentioned will be in step 4a. Now, the hacker has to
hack both step 2 and step 4a to let his stuff take effect. That is far
less likely to succeed because there needs to exist a vulnerability in
both places.

> Why is this not possible in a r-x user page?

This is answered above.
>
> [...]
>
>> - trampfd provides a basic framework. In the future, new trampoline types
>>   can be implemented, new contexts can be defined, and additional rules
>>   can be implemented for security purposes.
> >From a kernel developer perspective, this reads as "this ABI will become
> more complex", which I think is worrisome.

I hear you. My goal from the beginning is to not have the kernel deal
with ABI issues. ABI handling is best left to userland (except in cases
like signal handlers where the kernel does have to deal with it).

In the libffi changes, this is certainly true. The kernel only helps with
the trampoline that passes control to the ABI handler. The ABI handler
itself is part of libffi.

> I'm also worried that this is liable to have nasty interaction with HW
> CFI mechanisms (e.g. PAC+BTI on arm64) either now or in future, and that
> we bake incompatibility into ABI.

I will study CFI and then answer this question. So, bear with me.
>> - For instance, trampfd defines an "Allowed PCs" context in this initial
>>   work. As an example, libffi can create a read-only array of all ABI
>>   handlers for an architecture at build time. This array can be used to
>>   set the list of allowed PCs for a trampoline. This will mean that a hacker
>>   cannot hack the PC part of the register context and make it point to
>>   arbitrary locations.
> I'm not exactly sure what's meant here. Do you mean that this prevents
> userspace from branching into the middle of a trampoline, or that the
> trampfd code prevents where the trampoline itself can branch to?
>
> Both x86 and arm64 have upcoming HW CFI (CET and BTI) to deal with the
> former, and I believe the latter can also be implemented in userspace
> with defensive checks in the trampolines, provided that they are
> protected read-only.

So, I mentioned before that a hacker can potentially alter the target
PC that a trampoline finally jumps to.

If a process were allowed to have pages with both write and execute
permissions, a hacker could load his own code in one of those pages and
point the PC to that.

In the context of trampfd, we are talking about the case where a process is
not permitted to have both write and execute permissions. In this case,
the hacker cannot load his own code anywhere and hope to execute it.
But a hacker can point the PC to some arbitrary place such as return
from glibc.

>
>> - An SELinux setting called "exectramp" can be implemented along the
>>   lines of "execmem", "execstack" and "execheap" to selectively allow the
>>   use of trampolines on a per application basis.
>>
>> - User code can add defensive checks in the code before invoking a
>>   trampoline to make sure that a hacker has not modified the context data.
>>   It can do this by getting the trampoline context from the kernel and
>>   double checking it.
> As above, without examples it's not clear to me what sort of chacks are
> possible nor where they wouild need to be made. So it's difficult to see
> whether that's actually possible or subject to TOCTTOU races and
> similar.

I have explained this above. If there are any further questions on that,
please let me know.

>
>> - In the future, if the kernel can be enhanced to use a safe code
>>   generation component, that code can be placed in the trampoline mapping
>>   pages. Then, the trampoline invocation does not have to incur a trip
>>   into the kernel.
>>
>> - Also, if the kernel can be enhanced to use a safe code generation
>>   component, other forms of dynamic code such as JIT code can be
>>   addressed by the trampfd framework.
> I don't see why it's necessary for the kernel to generate code at all.
> If the trampfd creation requests can be trusted, what prevents trusting
> a sealed set of instructions generated in userspace?

Let us consider a system in which:
    - a process is not permitted to have pages with both write and execute
    - a process is not permitted to map any file as executable unless it
      is properly signed. In other words, cryptographically verified.

Then, the process cannot execute any code that is runtime generated.
That includes trampolines. Only trampoline code that is part of program
text at build time would be permitted to execute.

In this scenario, trampfd requests are coming from signed code. So, they
are trusted by the kernel. But trampoline code could be dynamically generated.
The kernel will not trust it.

>> - Trampolines can be shared across processes which can give rise to
>>   interesting uses in the future.
> This sounds like the use-case of a sealed memfd. Is a sealed executable
> memfd not sufficient?

I will answer this in a separate email.

Thanks.

Madhavan
