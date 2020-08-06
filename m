Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196A623DE77
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 19:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgHFR0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 13:26:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59224 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgHFR0F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:26:05 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2A06620B4908;
        Thu,  6 Aug 2020 10:26:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A06620B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596734763;
        bh=SKMTpymjM2dm1WgVhMrKQuNr9tnwmD1sIq+q78ljXI4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e52b+HsfeIrZBK4wd2YokPWiDGtVrTgHsUcshaMv/Q+OZ4/ixW20KNmfWuWvqGZx5
         tyqKKklbNwZq0c9vHJI4FRFVgiMVS4haqJy4sZeFyMsivmCKtipv1WlRbXCzCUMjOy
         zCggK+Qp7AEqHKECbf1qqN6OApZ4JBNLNtAf0X/s=
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
 <6236adf7-4bed-534e-0956-fddab4fd96b6@linux.microsoft.com>
 <20200804143018.GB7440@C02TD0UTHF1T.local>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <b3368692-afe6-89b5-d634-12f4f0a601f8@linux.microsoft.com>
Date:   Thu, 6 Aug 2020 12:26:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804143018.GB7440@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for the lively discussion. I have tried to answer some of the
comments below.

On 8/4/20 9:30 AM, Mark Rutland wrote:
>
>> So, the context is - if security settings in a system disallow a page to have
>> both write and execute permissions, how do you allow the execution of
>> genuine trampolines that are runtime generated and placed in a data
>> page or a stack page?
> There are options today, e.g.
>
> a) If the restriction is only per-alias, you can have distinct aliases
>    where one is writable and another is executable, and you can make it
>    hard to find the relationship between the two.
>
> b) If the restriction is only temporal, you can write instructions into
>    an RW- buffer, transition the buffer to R--, verify the buffer
>    contents, then transition it to --X.
>
> c) You can have two processes A and B where A generates instrucitons into
>    a buffer that (only) B can execute (where B may be restricted from
>    making syscalls like write, mprotect, etc).

The general principle of the mitigation is W^X. I would argue that
the above options are violations of the W^X principle. If they are
allowed today, they must be fixed. And they will be. So, we cannot
rely on them.

a) This requires a remap operation. Two mappings point to the same
     physical page. One mapping has W and the other one has X. This
     is a violation of W^X.

b) This is again a violation. The kernel should refuse to give execute
     permission to a page that was writeable in the past and refuse to
     give write permission to a page that was executable in the past.

c) This is just a variation of (a).

In general, the problem with user-level methods to map and execute
dynamic code is that the kernel cannot tell if a genuine application is
using them or an attacker is using them or piggy-backing on them.
If a security subsystem blocks all user-level methods for this reason,
we need a kernel mechanism to deal with the problem.

The kernel mechanism is not to be a backdoor. It is there to define
ways in which safe dynamic code can be executed.

I admit I have to provide more proof that my API and framework can
cover different cases. So, that is what I am doing now. I am in the process
of identifying other examples (per Andy's comment) and attempting to
show that this API and framework can address them. It will take a little time.


>>
>> IIUC, you are suggesting that the user hands the kernel a code fragment
>> and requests it to be placed in an r-x page, correct? However, the
>> kernel cannot trust any code given to it by the user. Nor can it scan any
>> piece of code and reliably decide if it is safe or not.
> Per that same logic the kernel cannot trust trampfd creation calls to be
> legitimate as the adversary could mess with the arguments. It doesn't
> matter if the kernel's codegen is trustworthy if it's potentially driven
> by an adversary.

That is not true. IMO, this is not a deficiency in trampfd. This is
something that is there even for regular system calls. For instance,
the write() system call will faithfully write out a buffer to a file
even if the buffer contents have been hacked by an attacker.
A system call can perform certain checks on incoming arguments.
But it cannot tell if a hacker has modified them.

So, there are two aspects in dynamic code that I am considering -
data and code. I submit that the data part can be hacked if an
application has a vulnerability such as buffer overflow. I don't see
how we can ever help that.

So, I am focused on the code generation part. Not all dynamic code
is the same. They have different degrees of trust.

Off the top of my head, I have tried to identify some examples
where we can have more trust on dynamic code and have the kernel
permit its execution.

1. If the kernel can do the job, then that is one safe way. Here, the kernel
    is the code. There is no code generation involved. This is what I
    have presented in the patch series as the first cut.

2. If the kernel can generate the code, then that code has a measure
    of trust. For trampolines, I agreed to do this for performance.

3. If the code resides in a signed file, then we know that it comes from
    an known source and it was generated at build time. So, it is not
    hacker generated. So, there is a measure of trust.

    This is not just program text. This could also be a buffer that contains
    trampoline code that resides in the read-only data section of a binary.

4. If the code resides in a signed file and is emulated (e.g. by QEMU)
    and we generate code for dynamic binary translation, we should
    be able to do that provided the code generator itself is not suspect.
    See the next point.   

5. The above are examples of actual machine code or equivalent.
    We could also have source code from which we generate machine
    code. E.g., JIT code from Java byte code. In this case, if the source
   code is in a signed file, we have a measure of trust on the source.
   If the kernel uses its own trusted code generator to generate the
   object code from the source code, then that object code has a
   measure of trust.

Anyway, these are just examples. The principle is - if we can identify
dynamic code that has a certain measure of trust, can the kernel
permit their execution?

All other code that cannot really be trusted by the kernel cannot be
executed safely (unless we find some safe and efficient way to
sandbox such code and limit the effects of the code to within
the sandbox). This is outside the scope of what I am doing.

>> So, the problem of executing dynamic code when security settings are
>> restrictive cannot be solved in userland. The only option I can think of is
>> to have the kernel provide support for dynamic code. It must have one
>> or more safe, trusted code generation components and an API to use
>> the components.
>>
>> My goal is to introduce an API and start off by supporting simple, regular
>> trampolines that are widely used. Then, evolve the feature over a period
>> of time to include other forms of dynamic code such as JIT code.
> I think that you're making a leap to this approach without sufficient
> justification that it actually solves the problem, and I believe that
> there will be ABI issues with this approach which can be sidestepped by
> other potential approaches.
>
> Taking a step back, I think it's necessary to better describe the
> problem and constraints that you believe apply before attempting to
> justify any potential solution.

I totally agree that more justification is needed and I am working on it.

As I have mentioned above, I intend to have the kernel generate code
only if the code generation is simple enough. For more complicated cases,
I plan to use a user-level code generator that is for exclusive kernel use.
I have yet to work out the details on how this would work. Need time.

>
> [...]
>
>>
>> 1. Create a trampoline by calling trampfd_create()
>> 2. Set the register and/or stack contexts for the trampoline.
>> 3. mmap() the trampoline to get an address
>> 4a. Retrieve the register and stack context for the trampoline from the
>>       kernel and check if anything has been altered. If yes, abort.
>> 4b. Invoke the trampoline using the address
> As above, you can also do this when using mprotect today, transitioning
> the buffer RWX -> R-- -> R-X. If you're worried about subsequent
> modification via an alias, a sealed memfd would work assuming that can
> be mapped R-X.

This is a violation of W^X and the security subsystem must be fixed
if it permits it.

> This approach is applicable to trampfd, but it isn't a specific benefit
> of trampfd.
>
> [...] 
>
>>>> - In the future, if the kernel can be enhanced to use a safe code
>>>>   generation component, that code can be placed in the trampoline mapping
>>>>   pages. Then, the trampoline invocation does not have to incur a trip
>>>>   into the kernel.
>>>>
>>>> - Also, if the kernel can be enhanced to use a safe code generation
>>>>   component, other forms of dynamic code such as JIT code can be
>>>>   addressed by the trampfd framework.
>>> I don't see why it's necessary for the kernel to generate code at all.
>>> If the trampfd creation requests can be trusted, what prevents trusting
>>> a sealed set of instructions generated in userspace?
>> Let us consider a system in which:
>>     - a process is not permitted to have pages with both write and execute
>>     - a process is not permitted to map any file as executable unless it
>>       is properly signed. In other words, cryptographically verified.
>>
>> Then, the process cannot execute any code that is runtime generated.
>> That includes trampolines. Only trampoline code that is part of program
>> text at build time would be permitted to execute.
>>
>> In this scenario, trampfd requests are coming from signed code. So, they
>> are trusted by the kernel. But trampoline code could be dynamically generated.
>> The kernel will not trust it.
> I think this a very hand-wavy argument, as it suggests that generated
> code is not trusted, but what is effectively a generated bytecode is.
> If certain codegen can be trusted, then we can add mechanisms to permit
> the results of this to be mapped r-x. If that is not possible, then the
> same argument says that trampfd requests cannot be trusted.

There is certainly an extra measure of trust in code that is in
signature verified files as compared to code that is generated
on the fly. At least, we know that the place from which we get
that code is known and the file was generated at build time
and not hacker generated. Such files could still contain a vulnerability.
But because these files are maintained by a known source, chances
are that there is nothing malicious in them.

Thanks.

Madhavan
