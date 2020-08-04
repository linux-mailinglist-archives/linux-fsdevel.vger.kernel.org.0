Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAE623BC2D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 16:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgHDOas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 10:30:48 -0400
Received: from foss.arm.com ([217.140.110.172]:44604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729150AbgHDOaY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:30:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E9A631B;
        Tue,  4 Aug 2020 07:30:23 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.37.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DB4D3F718;
        Tue,  4 Aug 2020 07:30:20 -0700 (PDT)
Date:   Tue, 4 Aug 2020 15:30:18 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
Message-ID: <20200804143018.GB7440@C02TD0UTHF1T.local>
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <20200731180955.GC67415@C02TD0UTHF1T.local>
 <6236adf7-4bed-534e-0956-fddab4fd96b6@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6236adf7-4bed-534e-0956-fddab4fd96b6@linux.microsoft.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 11:57:57AM -0500, Madhavan T. Venkataraman wrote:
> Responses inline..
> 
> On 7/31/20 1:09 PM, Mark Rutland wrote:
> > Hi,
> >
> > On Tue, Jul 28, 2020 at 08:10:46AM -0500, madvenka@linux.microsoft.com wrote:
> >> From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
> >> Trampoline code is placed either in a data page or in a stack page. In
> >> order to execute a trampoline, the page it resides in needs to be mapped
> >> with execute permissions. Writable pages with execute permissions provide
> >> an attack surface for hackers. Attackers can use this to inject malicious
> >> code, modify existing code or do other harm.
> > For the purpose of below, IIUC this assumes the adversary has an
> > arbitrary write.
> >
> >> To mitigate this, LSMs such as SELinux may not allow pages to have both
> >> write and execute permissions. This prevents trampolines from executing
> >> and blocks applications that use trampolines. To allow genuine applications
> >> to run, exceptions have to be made for them (by setting execmem, etc).
> >> In this case, the attack surface is just the pages of such applications.
> >>
> >> An application that is not allowed to have writable executable pages
> >> may try to load trampoline code into a file and map the file with execute
> >> permissions. In this case, the attack surface is just the buffer that
> >> contains trampoline code. However, a successful exploit may provide the
> >> hacker with means to load his own code in a file, map it and execute it.
> > It's not clear to me what power the adversary is assumed to have here,
> > and consequently it's not clear to me how the proposal mitigates this.
> >
> > For example, if the attack can control the arguments to syscalls, and
> > has an arbitrary write as above, what prevents them from creating a
> > trampfd of their own?
> 
> That is the point. If a process is allowed to have pages that are both
> writable and executable, a hacker can exploit some vulnerability such
> as buffer overflow to write his own code into a page and somehow
> contrive to execute that.

I understood that, and that was not my question.

> So, the context is - if security settings in a system disallow a page to have
> both write and execute permissions, how do you allow the execution of
> genuine trampolines that are runtime generated and placed in a data
> page or a stack page?

There are options today, e.g.

a) If the restriction is only per-alias, you can have distinct aliases
   where one is writable and another is executable, and you can make it
   hard to find the relationship between the two.

b) If the restriction is only temporal, you can write instructions into
   an RW- buffer, transition the buffer to R--, verify the buffer
   contents, then transition it to --X.

c) You can have two processes A and B where A generates instrucitons into
   a buffer that (only) B can execute (where B may be restricted from
   making syscalls like write, mprotect, etc).

If (as this series appears to) you assume that an adversary can't
control the arguments trampfd_create() and any such call is legitimate,
then something like (b) is not weaker and can be much more general
without many of the potential ABI or performance problems of trying to
fiddle with precedure call details in the kernel.

If that's not an assumption, then I'm missing how you expect to
determine that a trampfd_create() call is legitimate, and why that could
not be applied to other calls.

[...]

> Could not agree with you more.
> >
> > [...]
> >
> >> Trampoline File Descriptor (trampfd)
> >> --------------------------
> >>
> >> I am proposing a kernel API using anonymous file descriptors that
> >> can be used to create and execute trampolines with the help of the
> >> kernel. In this solution also, the kernel does the work of the trampoline.
> > What's the rationale for the kernel emulating the trampoline here?
> >
> > In ther case of EMUTRAMP this was necessary to work with existing
> > application binaries and kernel ABIs which placed instructions onto the
> > stack, and the stack needed to remain RW for other reasons. That
> > restriction doesn't apply here.
> 
> In addition to the stack, EMUTRAMP also allows the emulation
> of the same well-known trampolines placed in a non-stack data page.
> For instance, libffi closures embed a trampoline in a closure structure.
> That gets executed when the caller of libffi invokes it.
> 
> The goal of EMUTRAMP is to allow safe trampolines to execute when
> security settings disallow their execution. Mainly, it permits applications
> that use libffi to run. A lot of applications use libffi.
> 
> They chose the emulation method so that no changes need to be made
> to application code to use them. But the EMUTRAMP implementors note
> in their description that the real solution to the problem is a kernel
> API that is backed by a safe code generator.
> 
> trampd is an attempt to define such an API. This is just a starting point.
> I realize that we need to have a lot of discussion to refine the approach.
> 
> > Assuming trampfd creation is somehow authenticated, the code could be
> > placed in a r-x page (which the kernel could refuse to add write
> > permission), in order to prevent modification. If that's sufficient,
> > it's not much of a leap to allow userspace to generate the code.
> 
> IIUC, you are suggesting that the user hands the kernel a code fragment
> and requests it to be placed in an r-x page, correct? However, the
> kernel cannot trust any code given to it by the user. Nor can it scan any
> piece of code and reliably decide if it is safe or not.

Per that same logic the kernel cannot trust trampfd creation calls to be
legitimate as the adversary could mess with the arguments. It doesn't
matter if the kernel's codegen is trustworthy if it's potentially driven
by an adversary.

> So, the problem of executing dynamic code when security settings are
> restrictive cannot be solved in userland. The only option I can think of is
> to have the kernel provide support for dynamic code. It must have one
> or more safe, trusted code generation components and an API to use
> the components.
> 
> My goal is to introduce an API and start off by supporting simple, regular
> trampolines that are widely used. Then, evolve the feature over a period
> of time to include other forms of dynamic code such as JIT code.

I think that you're making a leap to this approach without sufficient
justification that it actually solves the problem, and I believe that
there will be ABI issues with this approach which can be sidestepped by
other potential approaches.

Taking a step back, I think it's necessary to better describe the
problem and constraints that you believe apply before attempting to
justify any potential solution.

[...]

> >> The kernel creates the trampoline mapping without any permissions. When
> >> the trampoline is executed by user code, a page fault happens and the
> >> kernel gets control. The kernel recognizes that this is a trampoline
> >> invocation. It sets up the user registers based on the specified
> >> register context, and/or pushes values on the user stack based on the
> >> specified stack context, and sets the user PC to the requested target
> >> PC. When the kernel returns, execution continues at the target PC.
> >> So, the kernel does the work of the trampoline on behalf of the
> >> application.
> >>
> >> In this case, the attack surface is the context buffer. A hacker may
> >> attack an application with a vulnerability and may be able to modify the
> >> context buffer. So, when the register or stack context is set for
> >> a trampoline, the values may have been tampered with. From an attack
> >> surface perspective, this is similar to Trampoline Emulation. But
> >> with trampfd, user code can retrieve a trampoline's context from the
> >> kernel and add defensive checks to see if the context has been
> >> tampered with.
> > Can you elaborate on this: what sort of checks would be applied, and
> > how?
> 
> So, an application that uses trampfd would do the following steps:
> 
> 1. Create a trampoline by calling trampfd_create()
> 2. Set the register and/or stack contexts for the trampoline.
> 3. mmap() the trampoline to get an address
> 4. Invoke the trampoline using the address
> 
> Let us say that the application has a vulnerability such as buffer overflow
> that allows a hacker to modify the data that is used to do step 2.
> 
> Potentially, a hacker could modify the following things:
>     - register values specified in the register context
>     - values specified in the stack context
>     - the target PC specified in the register context
> 
> When the trampoline is invoked in step 4, the kernel will gain control,
> load the registers, push stuff on the stack and transfer control to the target
> PC. Whatever the hacker had modified in step 2 will take effect in step 4.
> His values will get loaded and his PC is the one that will get control.
> 
> A paranoid application could add a step to this sequence. So, the steps
> would be:
> 
> 1. Create a trampoline by calling trampfd_create()
> 2. Set the register and/or stack contexts for the trampoline.
> 3. mmap() the trampoline to get an address
> 4a. Retrieve the register and stack context for the trampoline from the
>       kernel and check if anything has been altered. If yes, abort.
> 4b. Invoke the trampoline using the address

As above, you can also do this when using mprotect today, transitioning
the buffer RWX -> R-- -> R-X. If you're worried about subsequent
modification via an alias, a sealed memfd would work assuming that can
be mapped R-X.

This approach is applicable to trampfd, but it isn't a specific benefit
of trampfd.

[...] 

> >> - In the future, if the kernel can be enhanced to use a safe code
> >>   generation component, that code can be placed in the trampoline mapping
> >>   pages. Then, the trampoline invocation does not have to incur a trip
> >>   into the kernel.
> >>
> >> - Also, if the kernel can be enhanced to use a safe code generation
> >>   component, other forms of dynamic code such as JIT code can be
> >>   addressed by the trampfd framework.
> > I don't see why it's necessary for the kernel to generate code at all.
> > If the trampfd creation requests can be trusted, what prevents trusting
> > a sealed set of instructions generated in userspace?
> 
> Let us consider a system in which:
>     - a process is not permitted to have pages with both write and execute
>     - a process is not permitted to map any file as executable unless it
>       is properly signed. In other words, cryptographically verified.
> 
> Then, the process cannot execute any code that is runtime generated.
> That includes trampolines. Only trampoline code that is part of program
> text at build time would be permitted to execute.
> 
> In this scenario, trampfd requests are coming from signed code. So, they
> are trusted by the kernel. But trampoline code could be dynamically generated.
> The kernel will not trust it.

I think this a very hand-wavy argument, as it suggests that generated
code is not trusted, but what is effectively a generated bytecode is.

If certain codegen can be trusted, then we can add mechanisms to permit
the results of this to be mapped r-x. If that is not possible, then the
same argument says that trampfd requests cannot be trusted.

Thanks,
Mark.
