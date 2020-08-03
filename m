Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACAF23ABF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 19:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHCR6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 13:58:08 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57750 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHCR6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:58:07 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1BE0F20B4908;
        Mon,  3 Aug 2020 10:58:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1BE0F20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596477485;
        bh=e9+Nlmg821uwNR6BTqHy8U85EfsNrcp1gJnhbkIF1W4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RXbxzv5ftfCeBZYTZ1xOaEuahvu0ZmS3TsY3B2lI4zQPGveiClYJbXunf6jcxWTaE
         zFhjrT2haLCCDZOPDnzXPZzvwPGn/e9dRmYKvybo3iVmcR5qsA6AV9454a8D66mhxE
         NSONMrvO7N+B4rraB/9eOHnMcDsal+bCE+M/J1n0=
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
 <6540b4b7-3f70-adbf-c922-43886599713a@linux.microsoft.com>
 <CALCETrWnNR5v3ZCLfBVQGYK8M0jAvQMaAc9uuO05kfZuh-4d6w@mail.gmail.com>
 <46a1adef-65f0-bd5e-0b17-54856fb7e7ee@linux.microsoft.com>
 <20200731183146.GD67415@C02TD0UTHF1T.local>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <86625441-80f3-2909-2f56-e18e2b60957d@linux.microsoft.com>
Date:   Mon, 3 Aug 2020 12:58:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731183146.GD67415@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/31/20 1:31 PM, Mark Rutland wrote:
> On Fri, Jul 31, 2020 at 12:13:49PM -0500, Madhavan T. Venkataraman wrote:
>> On 7/30/20 3:54 PM, Andy Lutomirski wrote:
>>> On Thu, Jul 30, 2020 at 7:24 AM Madhavan T. Venkataraman
>>> <madvenka@linux.microsoft.com> wrote:
>> Dealing with multiple architectures
>> -----------------------------------------------
>>
>> One good reason to use trampfd is multiple architecture support. The
>> trampoline table in a code page approach is neat. I don't deny that at
>> all. But my question is - can it be used in all cases?
>>
>> It requires PC-relative data references. I have not worked on all architectures.
>> So, I need to study this. But do all ISAs support PC-relative data references?
> Not all do, but pretty much any recent ISA will as it's a practical
> necessity for fast position-independent code.

So, two questions:

1. IIUC, for position independent code, we need PC-relative control transfers. I know that
    PC-relative control transfers are kinda fundamental. So, I expect most architectures
    support it. But to implement the trampoline table suggestion, we need PC-relative
    data references. Like:

    movq    X(%rip), %rax

2. Do you know which architectures do not support PC-relative data references? I am
    going to study this. But if you have some information, I would appreciate it.

In any case, I think we should support all of the architectures on which Linux currently
runs even if they are legacy.

>
>> Even in an ISA that supports it, there would be a maximum supported offset
>> from the current PC that can be reached for a data reference. That maximum
>> needs to be at least the size of a base page in the architecture. This is because
>> the code page and the data page need to be separate for security reasons.
>> Do all ISAs support a sufficiently large offset?
> ISAs with pc-relative addessing can usually generate PC-relative
> addresses into a GPR, from which they can apply an arbitrarily large
> offset.

I will study this. I need to nail down the list of architectures that cannot do this.

>
>> When the kernel generates the code for a trampoline, it can hard code data values
>> in the generated code itself so it does not need PC-relative data referencing.
>>
>> And, for ISAs that do support the large offset, we do have to implement and
>> maintain the code page stuff for different ISAs for each application and library
>> if we did not use trampfd.
> Trampoline code is architecture specific today, so I don't see that as a
> major issue. Common structural bits can probably be shared even if the
> specifid machine code cannot.

True. But an implementor may prefer a standard mechanism provided by
the kernel so all of his architectures can be supported easily with less
effort.

If you look at the libffi reference patch I have included, the architecture
specific changes to use trampfd just involve a single C function call to
a common code function.

So, from the point of view of adoption, IMHO, the kernel provided method
is preferable.

>
> [...]
>
>> Security
>> -----------
>>
>> With the user level trampoline table approach, the data part of the trampoline table
>> can be hacked by an attacker if an application has a vulnerability. Specifically, the
>> target PC can be altered to some arbitrary location. Trampfd implements an
>> "Allowed PCS" context. In the libffi changes, I have created a read-only array of
>> all ABI handlers used in closures for each architecture. This read-only array
>> can be used to restrict the PC values for libffi trampolines to prevent hacking.
>>
>> To generalize, we can implement security rules/features if the trampoline
>> object is in the kernel.
> I don't follow this argument. If it's possible to statically define that
> in the kernel, it's also possible to do that in userspace without any
> new kernel support.
It is not statically defined in the kernel.

Let us take the libffi example. In the 64-bit X86 arch code, there are 3
ABI handlers:

    ffi_closure_unix64_sse
    ffi_closure_unix64
    ffi_closure_win64

I could create an "Allowed PCs" context like this:

struct my_allowed_pcs {
    struct trampfd_values    pcs;
    __u64                             pc_values[3];
};

const struct my_allowed_pcs    my_allowed_pcs = {
    { 3, 0 },
    (uintptr_t) ffi_closure_unix64_sse,
    (uintptr_t) ffi_closure_unix64,
    (uintptr_t) ffi_closure_win64,
};

I have created a read-only array of allowed ABI handlers that closures use.

When I set up the context for a closure trampoline, I could do this:

    pwrite(trampfd, &my_allowed_pcs, sizeof(my_allowed_pcs), TRAMPFD_ALLOWED_PCS_OFFSET);
   
This copies the array into the trampoline object in the kernel.
When the register context is set for the trampoline, the kernel checks
the PC register value against allowed PCs.

Because my_allowed_pcs is read-only, a hacker cannot modify it. So, the only
permitted target PCs enforced by the kernel are the ABI handlers.
>
> [...]
>
>> Trampfd is a framework that can be used to implement multiple things. May be,
>> a few of those things can also be implemented in user land itself. But I think having
>> just one mechanism to execute dynamic code objects is preferable to having
>> multiple mechanisms not standardized across all applications.
> In abstract, having a common interface sounds nice, but in practice
> elements of this are always architecture-specific (e.g. interactiosn
> with HW CFI), and that common interface can result in more pain as it
> doesn't fit naturally into the context that ISAs were designed for (e.g. 
> where control-flow instructions are extended with new semantics).

In the case of trampfd, the code generation is indeed architecture
specific. But that is in the kernel. The application is not affected by it.

Again, referring to the libffi reference patch, I have defined wrapper
functions for trampfd in common code. The architecture specific code
in libffi only calls the set_context function defined in common code.
Even this is required only because register names are specific to each
architecture and the target PC (to the ABI handler) is specific to
each architecture-ABI combo.

> It also meass that you can't share the rough approach across OSs which
> do not implement an identical mechanism, so for code abstracting by ISA
> first, then by platform/ABI, there isn't much saving.

Why can you not share the same approach across OSes? In fact,
I have tried to design it so that other OSes can use the same
mechanism.

The only thing is that I have defined the API to be based on a file
descriptor since that is what is generally preferred by the Linux community
for a new API. If I were to implement it as a regular system call, the same
system call can be implemented in other OSes as well.

Thanks.

Madhavan
