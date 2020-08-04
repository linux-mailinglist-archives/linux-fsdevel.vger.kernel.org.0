Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71F23BB82
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 15:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgHDN4K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 09:56:10 -0400
Received: from foss.arm.com ([217.140.110.172]:44226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgHDN4J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:56:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 987D431B;
        Tue,  4 Aug 2020 06:56:08 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.37.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 585463F718;
        Tue,  4 Aug 2020 06:56:06 -0700 (PDT)
Date:   Tue, 4 Aug 2020 14:55:58 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
Message-ID: <20200804135558.GA7440@C02TD0UTHF1T.local>
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
 <6540b4b7-3f70-adbf-c922-43886599713a@linux.microsoft.com>
 <CALCETrWnNR5v3ZCLfBVQGYK8M0jAvQMaAc9uuO05kfZuh-4d6w@mail.gmail.com>
 <46a1adef-65f0-bd5e-0b17-54856fb7e7ee@linux.microsoft.com>
 <20200731183146.GD67415@C02TD0UTHF1T.local>
 <86625441-80f3-2909-2f56-e18e2b60957d@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86625441-80f3-2909-2f56-e18e2b60957d@linux.microsoft.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 12:58:04PM -0500, Madhavan T. Venkataraman wrote:
> On 7/31/20 1:31 PM, Mark Rutland wrote:
> > On Fri, Jul 31, 2020 at 12:13:49PM -0500, Madhavan T. Venkataraman wrote:
> >> On 7/30/20 3:54 PM, Andy Lutomirski wrote:
> >>> On Thu, Jul 30, 2020 at 7:24 AM Madhavan T. Venkataraman
> >>> <madvenka@linux.microsoft.com> wrote:
>> >> When the kernel generates the code for a trampoline, it can hard code data values
> >> in the generated code itself so it does not need PC-relative data referencing.
> >>
> >> And, for ISAs that do support the large offset, we do have to implement and
> >> maintain the code page stuff for different ISAs for each application and library
> >> if we did not use trampfd.
> > Trampoline code is architecture specific today, so I don't see that as a
> > major issue. Common structural bits can probably be shared even if the
> > specifid machine code cannot.
> 
> True. But an implementor may prefer a standard mechanism provided by
> the kernel so all of his architectures can be supported easily with less
> effort.
> 
> If you look at the libffi reference patch I have included, the architecture
> specific changes to use trampfd just involve a single C function call to
> a common code function.

Sure but in addition to that each architecture backend had to define a
set of arguments to that. I view the C function is analagous to the
"common structural bits".

I appreciate that your patch is small today (and architectures seem to
largely align on what they need), but I don't think it's necessarily
true that things will remain so simple as architecture are extended and
their calling conventions evolve, and I also don't think it's clear that
this will work for more complex cases elsewhere.

[...]

> >> With the user level trampoline table approach, the data part of the trampoline table
> >> can be hacked by an attacker if an application has a vulnerability. Specifically, the
> >> target PC can be altered to some arbitrary location. Trampfd implements an
> >> "Allowed PCS" context. In the libffi changes, I have created a read-only array of
> >> all ABI handlers used in closures for each architecture. This read-only array
> >> can be used to restrict the PC values for libffi trampolines to prevent hacking.
> >>
> >> To generalize, we can implement security rules/features if the trampoline
> >> object is in the kernel.
> > I don't follow this argument. If it's possible to statically define that
> > in the kernel, it's also possible to do that in userspace without any
> > new kernel support.
> It is not statically defined in the kernel.
> 
> Let us take the libffi example. In the 64-bit X86 arch code, there are 3
> ABI handlers:
> 
>     ffi_closure_unix64_sse
>     ffi_closure_unix64
>     ffi_closure_win64
> 
> I could create an "Allowed PCs" context like this:
> 
> struct my_allowed_pcs {
>     struct trampfd_values    pcs;
>     __u64                             pc_values[3];
> };
> 
> const struct my_allowed_pcs    my_allowed_pcs = {
>     { 3, 0 },
>     (uintptr_t) ffi_closure_unix64_sse,
>     (uintptr_t) ffi_closure_unix64,
>     (uintptr_t) ffi_closure_win64,
> };
> 
> I have created a read-only array of allowed ABI handlers that closures use.
> 
> When I set up the context for a closure trampoline, I could do this:
> 
>     pwrite(trampfd, &my_allowed_pcs, sizeof(my_allowed_pcs), TRAMPFD_ALLOWED_PCS_OFFSET);
>    
> This copies the array into the trampoline object in the kernel.
> When the register context is set for the trampoline, the kernel checks
> the PC register value against allowed PCs.
> 
> Because my_allowed_pcs is read-only, a hacker cannot modify it. So, the only
> permitted target PCs enforced by the kernel are the ABI handlers.

Sorry, when I said "statically define" meant when you knew legitimate
targets ahead of time when you create the trampoline (i.e. whether you
could enumerate those and know they would not change dynamically).

My point was that you can achieve the same in userspace if the
trampoline and array of legitimate targets are in read-only memory,
without having to trap to the kernel.

I think the key point here is that an adversary must be prevented from
altering a trampoline and any associated metadata, and I think that
there are ways of achieving that without having to trap into the kernel,
and without the kernel having to be intimately aware of the calling
conventions used in userspace.

[...]

> >> Trampfd is a framework that can be used to implement multiple things. May be,
> >> a few of those things can also be implemented in user land itself. But I think having
> >> just one mechanism to execute dynamic code objects is preferable to having
> >> multiple mechanisms not standardized across all applications.
> > In abstract, having a common interface sounds nice, but in practice
> > elements of this are always architecture-specific (e.g. interactiosn
> > with HW CFI), and that common interface can result in more pain as it
> > doesn't fit naturally into the context that ISAs were designed for (e.g. 
> > where control-flow instructions are extended with new semantics).
> 
> In the case of trampfd, the code generation is indeed architecture
> specific. But that is in the kernel. The application is not affected by it.

As an ABI detail, applications are *definitely* affected by this, and it
is wrong to suggest they are not even if you don't have a specific case
in mind today. As this forms a contract between userspace and the kernel
it's overly simplistic to say that it's the kernel's problem

For example, in the case of BTI on arm64, what should the trampoline
set PSTATE.BTYPE to? Different use-cases *will* want different values,
and not necessarily the value of PSTATE at the instant the call to the
trampoline was made. In the case of libffi specifically using the
original value of PSTATE.BTYPE probably is sound, but other code
sequences may need to restrict/broaden or entirely change that.

> Again, referring to the libffi reference patch, I have defined wrapper
> functions for trampfd in common code. The architecture specific code
> in libffi only calls the set_context function defined in common code.
> Even this is required only because register names are specific to each
> architecture and the target PC (to the ABI handler) is specific to
> each architecture-ABI combo.
> 
> > It also meass that you can't share the rough approach across OSs which
> > do not implement an identical mechanism, so for code abstracting by ISA
> > first, then by platform/ABI, there isn't much saving.
> 
> Why can you not share the same approach across OSes? In fact,
> I have tried to design it so that other OSes can use the same
> mechanism.

Sure, but where they *don't*, you must fall back to the existing
purely-userspace mechanisms, and so a codebase now has the burden of
maintaining two distinct mechanisms.

Whereas if there's a way of doing this in userspace with (stronger)
enforcement of memory permissions the trampoline code can be common for
when this is present or absent, which is much easier for a codebase rto
maintain, and could make use of weaker existing mechanisms to improve
the situation on systems without the new functionality.

Thanks,
Mark.
