Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24696234AAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 20:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbgGaSKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 14:10:02 -0400
Received: from foss.arm.com ([217.140.110.172]:35830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730040AbgGaSKB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:10:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC48631B;
        Fri, 31 Jul 2020 11:10:00 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.4.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD9B03F71F;
        Fri, 31 Jul 2020 11:09:58 -0700 (PDT)
Date:   Fri, 31 Jul 2020 19:09:55 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     madvenka@linux.microsoft.com
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
Message-ID: <20200731180955.GC67415@C02TD0UTHF1T.local>
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728131050.24443-1-madvenka@linux.microsoft.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Tue, Jul 28, 2020 at 08:10:46AM -0500, madvenka@linux.microsoft.com wrote:
> From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
> Trampoline code is placed either in a data page or in a stack page. In
> order to execute a trampoline, the page it resides in needs to be mapped
> with execute permissions. Writable pages with execute permissions provide
> an attack surface for hackers. Attackers can use this to inject malicious
> code, modify existing code or do other harm.

For the purpose of below, IIUC this assumes the adversary has an
arbitrary write.

> To mitigate this, LSMs such as SELinux may not allow pages to have both
> write and execute permissions. This prevents trampolines from executing
> and blocks applications that use trampolines. To allow genuine applications
> to run, exceptions have to be made for them (by setting execmem, etc).
> In this case, the attack surface is just the pages of such applications.
> 
> An application that is not allowed to have writable executable pages
> may try to load trampoline code into a file and map the file with execute
> permissions. In this case, the attack surface is just the buffer that
> contains trampoline code. However, a successful exploit may provide the
> hacker with means to load his own code in a file, map it and execute it.

It's not clear to me what power the adversary is assumed to have here,
and consequently it's not clear to me how the proposal mitigates this.

For example, if the attack can control the arguments to syscalls, and
has an arbitrary write as above, what prevents them from creating a
trampfd of their own?

[...]

> GCC has traditionally used trampolines for implementing nested
> functions. The trampoline is placed on the user stack. So, the stack
> needs to be executable.

IIUC generally nested functions are avoided these days, specifically to
prevent the creation of gadgets on the stack. So I don't think those are
relevant as a cased to care about. Applications using them should move
to not using them, and would be more secure generally for doing so.

[...]

> Trampoline File Descriptor (trampfd)
> --------------------------
> 
> I am proposing a kernel API using anonymous file descriptors that
> can be used to create and execute trampolines with the help of the
> kernel. In this solution also, the kernel does the work of the trampoline.

What's the rationale for the kernel emulating the trampoline here?

In ther case of EMUTRAMP this was necessary to work with existing
application binaries and kernel ABIs which placed instructions onto the
stack, and the stack needed to remain RW for other reasons. That
restriction doesn't apply here.

Assuming trampfd creation is somehow authenticated, the code could be
placed in a r-x page (which the kernel could refuse to add write
permission), in order to prevent modification. If that's sufficient,
it's not much of a leap to allow userspace to generate the code.

> The kernel creates the trampoline mapping without any permissions. When
> the trampoline is executed by user code, a page fault happens and the
> kernel gets control. The kernel recognizes that this is a trampoline
> invocation. It sets up the user registers based on the specified
> register context, and/or pushes values on the user stack based on the
> specified stack context, and sets the user PC to the requested target
> PC. When the kernel returns, execution continues at the target PC.
> So, the kernel does the work of the trampoline on behalf of the
> application.
> 
> In this case, the attack surface is the context buffer. A hacker may
> attack an application with a vulnerability and may be able to modify the
> context buffer. So, when the register or stack context is set for
> a trampoline, the values may have been tampered with. From an attack
> surface perspective, this is similar to Trampoline Emulation. But
> with trampfd, user code can retrieve a trampoline's context from the
> kernel and add defensive checks to see if the context has been
> tampered with.

Can you elaborate on this: what sort of checks would be applied, and
how?

Why is this not possible in a r-x user page?

[...]

> - trampfd provides a basic framework. In the future, new trampoline types
>   can be implemented, new contexts can be defined, and additional rules
>   can be implemented for security purposes.

From a kernel developer perspective, this reads as "this ABI will become
more complex", which I think is worrisome.

I'm also worried that this is liable to have nasty interaction with HW
CFI mechanisms (e.g. PAC+BTI on arm64) either now or in future, and that
we bake incompatibility into ABI.

> - For instance, trampfd defines an "Allowed PCs" context in this initial
>   work. As an example, libffi can create a read-only array of all ABI
>   handlers for an architecture at build time. This array can be used to
>   set the list of allowed PCs for a trampoline. This will mean that a hacker
>   cannot hack the PC part of the register context and make it point to
>   arbitrary locations.

I'm not exactly sure what's meant here. Do you mean that this prevents
userspace from branching into the middle of a trampoline, or that the
trampfd code prevents where the trampoline itself can branch to?

Both x86 and arm64 have upcoming HW CFI (CET and BTI) to deal with the
former, and I believe the latter can also be implemented in userspace
with defensive checks in the trampolines, provided that they are
protected read-only.

> - An SELinux setting called "exectramp" can be implemented along the
>   lines of "execmem", "execstack" and "execheap" to selectively allow the
>   use of trampolines on a per application basis.
> 
> - User code can add defensive checks in the code before invoking a
>   trampoline to make sure that a hacker has not modified the context data.
>   It can do this by getting the trampoline context from the kernel and
>   double checking it.

As above, without examples it's not clear to me what sort of chacks are
possible nor where they wouild need to be made. So it's difficult to see
whether that's actually possible or subject to TOCTTOU races and
similar.

> - In the future, if the kernel can be enhanced to use a safe code
>   generation component, that code can be placed in the trampoline mapping
>   pages. Then, the trampoline invocation does not have to incur a trip
>   into the kernel.
> 
> - Also, if the kernel can be enhanced to use a safe code generation
>   component, other forms of dynamic code such as JIT code can be
>   addressed by the trampfd framework.

I don't see why it's necessary for the kernel to generate code at all.
If the trampfd creation requests can be trusted, what prevents trusting
a sealed set of instructions generated in userspace?

> - Trampolines can be shared across processes which can give rise to
>   interesting uses in the future.

This sounds like the use-case of a sealed memfd. Is a sealed executable
memfd not sufficient?

Thanks,
Mark.
