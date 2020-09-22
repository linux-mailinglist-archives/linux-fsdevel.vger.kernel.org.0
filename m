Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C65A274BB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 23:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgIVVzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 17:55:02 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55544 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgIVVzC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:55:02 -0400
Received: from [192.168.254.38] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 78FF320B7179;
        Tue, 22 Sep 2020 14:54:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 78FF320B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600811700;
        bh=Ds0A3yh5WFFiRK4lNiBe4E2tRdH4+pbBOOSel58kNNM=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=hntey/jSJtudrQHOQSGYOJ8HVui9ldZpRRuuhj1UXXBAyNzyVuwGTFc+wvhx8Qo1e
         2Q4cczHH1nyEW5H4Rvhe0fnnklHYXF/CC5PQ+6KYou4uAbb2Q6NilXTYNeeJiGJBUo
         4LNKqHgRMXzGm9fMFQ+76ImO0YASxh3A2P0mGRpg=
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
To:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        fweimer@redhat.com, mark.rutland@arm.com, mic@digikod.net,
        pavel@ucw.cz
References: <210d7cd762d5307c2aa1676705b392bd445f1baa>
 <20200922215326.4603-1-madvenka@linux.microsoft.com>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <83bdacc2-09dc-6f44-fbfc-fc30b329e902@linux.microsoft.com>
Date:   Tue, 22 Sep 2020 16:54:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922215326.4603-1-madvenka@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I just resent the trampfd v2 RFC. I forgot to CC the reviewers who provided comments before.
So sorry.

Madhavan

On 9/22/20 4:53 PM, madvenka@linux.microsoft.com wrote:
> From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
> 
> Introduction
> ============
> 
> Dynamic code is used in many different user applications. Dynamic code is
> often generated at runtime. Dynamic code can also just be a pre-defined
> sequence of machine instructions in a data buffer. Examples of dynamic
> code are trampolines, JIT code, DBT code, etc.
> 
> Dynamic code is placed either in a data page or in a stack page. In order
> to execute dynamic code, the page it resides in needs to be mapped with
> execute permissions. Writable pages with execute permissions provide an
> attack surface for hackers. Attackers can use this to inject malicious
> code, modify existing code or do other harm.
> 
> To mitigate this, LSMs such as SELinux implement W^X. That is, they may not
> allow pages to have both write and execute permissions. This prevents
> dynamic code from executing and blocks applications that use it. To allow
> genuine applications to run, exceptions have to be made for them (by setting
> execmem, etc) which opens the door to security issues.
> 
> The W^X implementation today is not complete. There exist many user level
> tricks that can be used to load and execute dynamic code. E.g.,
> 
> - Load the code into a file and map the file with R-X.
> 
> - Load the code in an RW- page. Change the permissions to R--. Then,
>   change the permissions to R-X.
> 
> - Load the code in an RW- page. Remap the page with R-X to get a separate
>   mapping to the same underlying physical page.
> 
> IMO, these are all security holes as an attacker can exploit them to inject
> his own code.
> 
> In the future, these holes will definitely be closed. For instance, LSMs
> (such as the IPE proposal [1]) may only allow code in properly signed object
> files to be mapped with execute permissions. This will do two things:
> 
> 	- user level tricks using anonymous pages will fail as anonymous
> 	  pages have no file identity
> 
> 	- loading the code in a temporary file and mapping it with R-X
> 	  will fail as the temporary file would not have a signature
> 
> We need a way to execute such code without making security exceptions.
> Trampolines are a good example of dynamic code. A couple of examples
> of trampolines are given below. My first use case for this RFC is
> libffi.
> 
> Examples of trampolines
> =======================
> 
> libffi (A Portable Foreign Function Interface Library):
> 
> libffi allows a user to define functions with an arbitrary list of
> arguments and return value through a feature called "Closures".
> Closures use trampolines to jump to ABI handlers that handle calling
> conventions and call a target function. libffi is used by a lot
> of different applications. To name a few:
> 
> 	- Python
> 	- Java
> 	- Javascript
> 	- Ruby FFI
> 	- Lisp
> 	- Objective C
> 
> GCC nested functions:
> 
> GCC has traditionally used trampolines for implementing nested
> functions. The trampoline is placed on the user stack. So, the stack
> needs to be executable.
> 
> Currently available solution
> ============================
> 
> One solution that has been proposed to allow trampolines to be executed
> without making security exceptions is Trampoline Emulation. See:
> 
> https://pax.grsecurity.net/docs/emutramp.txt
> 
> In this solution, the kernel recognizes certain sequences of instructions
> as "well-known" trampolines. When such a trampoline is executed, a page
> fault happens because the trampoline page does not have execute permission.
> The kernel recognizes the trampoline and emulates it. Basically, the
> kernel does the work of the trampoline on behalf of the application.
> 
> Currently, the emulated trampolines are the ones used in libffi and GCC
> nested functions. To my knowledge, only X86 is supported at this time.
> 
> As noted in emutramp.txt, this is not a generic solution. For every new
> trampoline that needs to be supported, new instruction sequences need to
> be recognized by the kernel and emulated. And this has to be done for
> every architecture that needs to be supported.
> 
> emutramp.txt notes the following:
> 
> "... the real solution is not in emulation but by designing a kernel API
> for runtime code generation and modifying userland to make use of it."
> 
> Solution proposed in this RFC
> =============================
> 
>>From this RFC's perspective, there are two scenarios for dynamic code:
> 
> Scenario 1
> ----------
> 
> We know what code we need only at runtime. For instance, JIT code generated
> for frequently executed Java methods. Only at runtime do we know what
> methods need to be JIT compiled. Such code cannot be statically defined. It
> has to be generated at runtime.
> 
> Scenario 2
> ----------
> 
> We know what code we need in advance. User trampolines are a good example of
> this. It is possible to define such code statically with some help from the
> kernel.
> 
> This RFC addresses (2). (1) needs a general purpose trusted code generator
> and is out of scope for this RFC.
> 
> For (2), the solution is to convert dynamic code to static code and place it
> in a source file. The binary generated from the source can be signed. The
> kernel can use signature verification to authenticate the binary and
> allow the code to be mapped and executed.
> 
> The problem is that the static code has to be able to find the data that it
> needs when it executes. For functions, the ABI defines the way to pass
> parameters. But, for arbitrary dynamic code, there isn't a standard ABI
> compliant way to pass data to the code for most architectures. Each instance
> of dynamic code defines its own way. For instance, co-location of code and
> data and PC-relative data referencing are used in cases where the ISA
> supports it.
> 
> We need one standard way that would work for all architectures and ABIs.
> 
> The solution proposed here is:
> 
> 1. Write the static code assuming that the data needed by the code is already
>    pointed to by a designated register.
> 
> 2. Get the kernel to supply a small universal trampoline that does the
>    following:
> 
> 	- Load the address of the data in a designated register
> 	- Load the address of the static code in a designated register
> 	- Jump to the static code
> 
> User code would use a kernel supplied API to create and map the trampoline.
> The address values would be baked into the code so that no special ISA
> features are needed.
> 
> To conserve memory, the kernel will pack as many trampolines as possible in
> a page and provide a trampoline table to user code. The table itself is
> managed by the user.
> 
> Trampoline File Descriptor (trampfd)
> ==========================
> 
> I am proposing a kernel API using anonymous file descriptors that can be
> used to create the trampolines. The API is described in patch 1/4 of this
> patchset. I provide a summary here:
> 
> 	- Create a trampoline file object
> 
> 	- Write a code descriptor into the trampoline file and specify:
> 
> 		- the number of trampolines desired
> 		- the name of the code register
> 		- user pointer to a table of code addresses, one address
> 		  per trampoline
> 
> 	- Write a data descriptor into the trampoline file and specify:
> 
> 		- the name of the data register
> 		- user pointer to a table of data addresses, one address
> 		  per trampoline
> 
> 	- mmap() the trampoline file. The kernel generates a table of
> 	  trampolines in a page and returns the trampoline table address
> 
> 	- munmap() a trampoline file mapping
> 
> 	- Close the trampoline file
> 
> Each mmap() will only map a single base page. Large pages are not supported.
> 
> A trampoline file can only be mapped once in an address space.
> 
> Trampoline file mappings cannot be shared across address spaces. So,
> sending the trampoline file descriptor over a unix domain socket and
> mapping it in another process will not work.
> 
> It is recommended that the code descriptor and the code table be placed
> in the .rodata section so an attacker cannot modify them.
> 
> Trampoline use and reuse
> ========================
> 
> The code for trampoline X in the trampoline table is:
> 
> 	load	&code_table[X], code_reg
> 	load	(code_reg), code_reg
> 	load	&data_table[X], data_reg
> 	load	(data_reg), data_reg
> 	jump	code_reg
> 
> The addresses &code_table[X] and &data_table[X] are baked into the
> trampoline code. So, PC-relative data references are not needed. The user
> can modify code_table[X] and data_table[X] dynamically.
> 
> For instance, within libffi, the same trampoline X can be used for different
> closures at different times by setting:
> 
> 	data_table[X] = closure;
> 	code_table[X] = ABI handling code;
> 
> Advantages of the Trampoline File Descriptor approach
> =====================================================
> 
> - Using this support from the kernel, dynamic code can be converted to
>   static code with a little effort so applications and libraries can move to
>   a more secure model. In the simplest cases such as libffi, dynamic code can
>   even be eliminated.
> 
> - This initial work is targeted towards X86 and ARM. But it can be supported
>   easily on all architectures. We don't need any special ISA features such
>   as PC-relative data referencing.
> 
> - The only code generation needed is for this small, universal trampoline.
> 
> - The kernel does not have to deal with any ABI issues in the generation of
>   this trampoline.
> 
> - The kernel provides a trampoline table to conserve memory.
> 
> - An SELinux setting called "exectramp" can be implemented along the
>   lines of "execmem", "execstack" and "execheap" to selectively allow the
>   use of trampolines on a per application basis.
> 
> - In version 1, a trip to the kernel was required to execute the trampoline.
>   In version 2, that is not required. So, there are no performance
>   concerns in this approach.
> 
> libffi
> ======
> 
> I have implemented my solution for libffi and provided the changes for
> X86 and ARM, 32-bit and 64-bit. Here is the reference patch:
> 
> http://linux.microsoft.com/~madvenka/libffi/libffi.v2.txt
> 
> If the trampfd patchset gets accepted, I will send the libffi changes
> to the maintainers for a review. BTW, I have also successfully executed
> the libffi self tests.
> 
> Work that is pending
> ====================
> 
> - I am working on implementing the SELinux setting - "exectramp".
> 
> - I have a test program to test the kernel API. I am working on adding it
>   to selftests.
> 
> References
> ==========
> 
> [1] https://microsoft.github.io/ipe/
> ---
> 
> Changelog:
> 
> v1
> 	Introduced the Trampfd feature.
> 
> v2
> 	- Changed the system call. Version 2 does not support different
> 	  trampoline types and their associated type structures. It only
> 	  supports a kernel generated trampoline.
> 
> 	  The system call now returns information to the user that is
> 	  used to define trampoline descriptors. E.g., the maximum
> 	  number of trampolines that can be packed in a single page.
> 
> 	- Removed all the trampoline contexts such as register contexts
> 	  and stack contexts. This is based on the feedback that the kernel
> 	  should not have to worry about ABI issues and H/W features that
> 	  may deal with the context of a process.
> 
> 	- Removed the need to make a trip into the kernel on trampoline
> 	  invocation. This is based on the feedback about performance.
> 
> 	- Removed the ability to share trampolines across address spaces.
> 	  This would have made sense to different trampoline types based
> 	  on their semantics. But since I support only one specific
> 	  trampoline, sharing does not make sense.
> 
> 	- Added calls to specify trampoline descriptors that the kernel
> 	  uses to generate trampolines.
> 
> 	- Added architecture-specific code to generate the small, universal
> 	  trampoline for X86 32 and 64-bit, ARM 32 and 64-bit.
> 
> 	- Implemented the trampoline table in a page.
> Madhavan T. Venkataraman (4):
>   Implement the kernel API for the trampoline file descriptor.
>   Implement i386 and X86 support for the trampoline file descriptor.
>   Implement ARM64 support for the trampoline file descriptor.
>   Implement ARM support for the trampoline file descriptor.
> 
>  arch/arm/include/uapi/asm/ptrace.h     |  21 +++
>  arch/arm/kernel/Makefile               |   1 +
>  arch/arm/kernel/trampfd.c              | 124 +++++++++++++
>  arch/arm/tools/syscall.tbl             |   1 +
>  arch/arm64/include/asm/unistd.h        |   2 +-
>  arch/arm64/include/asm/unistd32.h      |   2 +
>  arch/arm64/include/uapi/asm/ptrace.h   |  59 ++++++
>  arch/arm64/kernel/Makefile             |   2 +
>  arch/arm64/kernel/trampfd.c            | 244 +++++++++++++++++++++++++
>  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  arch/x86/include/uapi/asm/ptrace.h     |  38 ++++
>  arch/x86/kernel/Makefile               |   1 +
>  arch/x86/kernel/trampfd.c              | 238 ++++++++++++++++++++++++
>  fs/Makefile                            |   1 +
>  fs/trampfd/Makefile                    |   5 +
>  fs/trampfd/trampfd_fops.c              | 241 ++++++++++++++++++++++++
>  fs/trampfd/trampfd_map.c               | 142 ++++++++++++++
>  include/linux/syscalls.h               |   2 +
>  include/linux/trampfd.h                |  49 +++++
>  include/uapi/asm-generic/unistd.h      |   4 +-
>  include/uapi/linux/trampfd.h           | 184 +++++++++++++++++++
>  init/Kconfig                           |   7 +
>  kernel/sys_ni.c                        |   3 +
>  24 files changed, 1371 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/kernel/trampfd.c
>  create mode 100644 arch/arm64/kernel/trampfd.c
>  create mode 100644 arch/x86/kernel/trampfd.c
>  create mode 100644 fs/trampfd/Makefile
>  create mode 100644 fs/trampfd/trampfd_fops.c
>  create mode 100644 fs/trampfd/trampfd_map.c
>  create mode 100644 include/linux/trampfd.h
>  create mode 100644 include/uapi/linux/trampfd.h
> 
