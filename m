Return-Path: <linux-fsdevel+bounces-12161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B585D85C190
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 17:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA8C282588
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA54768E7;
	Tue, 20 Feb 2024 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nnUyX4zJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rI3SHAvG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBC52E84E;
	Tue, 20 Feb 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447031; cv=none; b=Q5X4LkU+EnAfaVJc9utWXIwNSbc9Gy3SDjKMxUItzfh/og6ddc1vNuqe43AjQPVWIbl6/wagbiy3wE7B/IFU6JXKJ6Y9OuMyIVsmUqvBKiupTfS08YYukA/jNF3nt5jzk8MemnyYTPmtvzxwGPdUg1oz6D+BUJxwsGRSrNQVnc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447031; c=relaxed/simple;
	bh=XgkMZ+TivueSpVuf4TOJR9ln4ZnxZl6kLt4/Tdjc7/w=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=iliaMYH/eJ9OdcZMB56h16SnyThMigI9Cryu6GTpWBeMYvLp0tOSQIPSBVheRC40UxzgPV7abhs1BR+Cm8Y6hUaL4E23yDdFuNjDAqvnS7LiOjdzNao4FyDgny7vgiX/s4hEv10jKzb3HOH0wE99a/IqI3TR8qdxuTaNyvUmUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nnUyX4zJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rI3SHAvG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9B56B13800DC;
	Tue, 20 Feb 2024 11:37:07 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Tue, 20 Feb 2024 11:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708447027; x=1708533427; bh=SjzebPfbdP
	VRKXardHah2e1+lrVQBz4/v7Y0eblF+8M=; b=nnUyX4zJZdtr0Gl4d6duZmEu8T
	OdAlOr9lXQvvWu/4+hsawEOChMQdpuXiBiNKXtbKTfLLRlJbBrI+UGexH3p9cjDn
	QJUut3QvYGwqIfigl4+abwOrP037oRevyULOUuUNao3azpSF6rT1PKaICCW7NTUC
	OXIJVdt90ovEKg9gsCXv8VyNp7jQiWJarWCoHQkHLKUjm5pBV7ulXdG8ACPRArUv
	s+PxmmhAIT69HYj0PMZn4X3v5RZLJd+vHe4fRXngwCdyP12/x6+HOJFfQKm6f3qS
	PMtNCykI8gLujvF28WiL05DR6W0NPxxcswiZ2ODtHzumkjJxX7Cu6KL3RvWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708447027; x=1708533427; bh=SjzebPfbdPVRKXardHah2e1+lrVQ
	Bz4/v7Y0eblF+8M=; b=rI3SHAvG144lPZakxFECYhpGTG1bPbMcVYZJmvAuWFtK
	/90phOr9ZL+430PTcdvbvPZr0dhtmxDd20heMXeeAQ+dUFqxkEpFUViCfihyYVxV
	LkAQ0YkSjsJ4jqU2SA/+gW3ATK42mlwzQlP4S2rSk5I4Yuvr13/vh90HqHr+GxF6
	PKzpp1ydfqmL1/xNBwRxS6T1NVz6hkVU0h+ZxG0XVKoziLlDg795nS6VmB/EYtZc
	eF+4N18m/tHSmITqx63hpLUzq3mZspIoIQdUrgPSU2Cf/bPPUCzr+3ndyAWECXjz
	YByKDJN9bp/I6STsJcsZWCZOJ8Y3FT1gGgmbh5c1LQ==
X-ME-Sender: <xms:MtXUZd075UBYvzZwn5vVjLvoU3GKRd137WYXGbzQUxBZoSBI76aF7w>
    <xme:MtXUZUEnFbMCfYmSva0hT5e1FlzAFOUYkvRPWQGaSeJvuBuVPiq3Y7oydJDMudJX8
    -eNe15uVSKabTzyKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuthgv
    fhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpefhveettefhteejgeejheejheeijedutdefveettddvtdduteff
    uddvgfegfeegueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhinhhfrhgruggvrg
    gurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepshhorhgvrghrsehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:MtXUZd50ksZzlW64c3MmMsGWfX2Zqh817UZmwHlmfiY9jt-bW_4R0g>
    <xmx:MtXUZa2i5qarbUVSvrhyfN31InJJcpOr0dGfsXMunUVXnXBCJsVBeQ>
    <xmx:MtXUZQF2GoBih2TZETt2yGjJ3DF2bqSusUfnqQUHTgG-d-YMD4wCjA>
    <xmx:M9XUZSmyE4dxFoARxgS05OJARrcnvM75fG6vCvATL6QpoG5sK_gW0A>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7564A17000A0; Tue, 20 Feb 2024 11:37:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
In-Reply-To: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
Date: Tue, 20 Feb 2024 11:36:33 -0500
From: "Stefan O'Rear" <sorear@fastmail.com>
To: "Mark Brown" <broonie@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Marc Zyngier" <maz@kernel.org>,
 "Oliver Upton" <oliver.upton@linux.dev>, "James Morse" <james.morse@arm.com>,
 "Suzuki K Poulose" <suzuki.poulose@arm.com>, "Arnd Bergmann" <arnd@arndb.de>,
 "Oleg Nesterov" <oleg@redhat.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "Kees Cook" <keescook@chromium.org>, "Shuah Khan" <shuah@kernel.org>,
 "Rick P Edgecombe" <rick.p.edgecombe@intel.com>, debug <debug@rivosinc.com>,
 "Ard Biesheuvel" <ardb@kernel.org>, "Szabolcs Nagy" <Szabolcs.Nagy@arm.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Florian Weimer" <fweimer@redhat.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Thiago Jung Bauermann" <thiago.bauermann@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, musl@lists.openwall.com
Subject: Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS in userspace
Content-Type: text/plain

On Sat, Feb 3, 2024, at 7:25 AM, Mark Brown wrote:
> The arm64 Guarded Control Stack (GCS) feature provides support for
> hardware protected stacks of return addresses, intended to provide
> hardening against return oriented programming (ROP) attacks and to make
> it easier to gather call stacks for applications such as profiling.
>
> When GCS is active a secondary stack called the Guarded Control Stack is
> maintained, protected with a memory attribute which means that it can
> only be written with specific GCS operations.  The current GCS pointer
> can not be directly written to by userspace.  When a BL is executed the
> value stored in LR is also pushed onto the GCS, and when a RET is
> executed the top of the GCS is popped and compared to LR with a fault
> being raised if the values do not match.  GCS operations may only be
> performed on GCS pages, a data abort is generated if they are not.
>
> The combination of hardware enforcement and lack of extra instructions
> in the function entry and exit paths should result in something which
> has less overhead and is more difficult to attack than a purely software
> implementation like clang's shadow stacks.
>
> This series implements support for use of GCS by userspace, along with
> support for use of GCS within KVM guests.  It does not enable use of GCS
> by either EL1 or EL2, this will be implemented separately.  Executables
> are started without GCS and must use a prctl() to enable it, it is
> expected that this will be done very early in application execution by
> the dynamic linker or other startup code.  For dynamic linking this will
> be done by checking that everything in the executable is marked as GCS
> compatible.
>
> x86 has an equivalent feature called shadow stacks, this series depends
> on the x86 patches for generic memory management support for the new
> guarded/shadow stack page type and shares APIs as much as possible.  As
> there has been extensive discussion with the wider community around the
> ABI for shadow stacks I have as far as practical kept implementation
> decisions close to those for x86, anticipating that review would lead to
> similar conclusions in the absence of strong reasoning for divergence.
>
> The main divergence I am concious of is that x86 allows shadow stack to
> be enabled and disabled repeatedly, freeing the shadow stack for the
> thread whenever disabled, while this implementation keeps the GCS
> allocated after disable but refuses to reenable it.  This is to avoid
> races with things actively walking the GCS during a disable, we do
> anticipate that some systems will wish to disable GCS at runtime but are
> not aware of any demand for subsequently reenabling it.
>
> x86 uses an arch_prctl() to manage enable and disable, since only x86
> and S/390 use arch_prctl() a generic prctl() was proposed[1] as part of a
> patch set for the equivalent RISC-V Zicfiss feature which I initially
> adopted fairly directly but following review feedback has been revised
> quite a bit.

While discussing the ABI implications of shadow stacks in the context of
Zicfiss and musl a few days ago, I had the following idea for how to solve
the source compatibility problems with shadow stacks in POSIX.1-2004 and
POSIX.1-2017:

1. Introduce a "flexible shadow stack handling" option.  For what follows,
   it doesn't matter if this is system-wide, per-mm, or per-vma.

2. Shadow stack faults on non-shadow stack pages, if flexible shadow stack
   handling is in effect, cause the affected page to become a shadow stack
   page.  When this happens, the page filled with invalid address tokens.

   Faults from non-shadow-stack accesses to a shadow-stack page which was
   created by the previous paragraph will cause the page to revert to
   non-shadow-stack usage, with or without clearing.

   Important: a shadow stack operation can only load a valid address from
   a page if that page has been in continuous shadow stack use since the
   address was written by another shadow stack operation; the flexibility
   delays error reporting in cases of stray writes but it never allows for
   corruption of shadow stack operation.

3. Standards-defined operations which use a user-provided stack
   (makecontext, sigaltstack, pthread_attr_setstack) use a subrange of the
   provided stack for shadow stack storage.  I propose to use a shadow
   stack size of 1/32 of the provided stack size, rounded up to a positive
   integer number of pages, and place the shadow stack allocation at the
   lowest page-aligned address inside the provided stack region.

   Since page usage is flexible, no change in page permissions is
   immediately needed; this merely sets the initial shadow stack pointer for
   the new context.

   If the shadow stack grew in the opposite direction to the architectural
   stack, it would not be necessary to pick a fixed direction.

4. SIGSTKSZ and MINSIGSTKSZ are increased by 2 pages to provide sufficient
   space for a minimum-sized shadow stack region and worst case alignment.

_Without_ doing this, sigaltstack cannot be used to recover from stack
overflows if the shadow stack limit is reached first, and makecontext
cannot be supported without memory leaks and unreportable error conditions.

Kernel-allocated shadow stacks with a unique VM type are still useful since
they allows stray writes to crash at the time the stray write is performed,
rather than delaying the crash until the next shadow stack read.

The pthread and makecontext changes could be purely libc side, but we would
need kernel support for sigaltstack and page usage changes.

Luckily, there is no need to support stacks which are simultaneously used
from more than one process, so "is this a shadow stack page" can be tracked
purely at the vma/pte level without any need to involve the inode.  POSIX
explicitly allows using mmap to obtain stack memory and does not forbid
MAP_SHARED; I consider this sufficiently perverse application behavior that
it is not necessary to ensure exclusive use of the underlying pages while
a shadow stack pte exists.  (Applications that use MAP_SHARED for stacks
do not get the full benefit of the shadow stack but they keep POSIX.1-2004
conformance, applications that allocate stacks exclusively in MAP_PRIVATE
memory lose no security.)

The largest complication of this scheme is likely to be that the shadow
stack usage property of a page needs to survive the page being swapped out
and back in, which likely means that it must be present in the swap PTE.

I am substantially less familiar with GCS and SHSTK than with Zicfiss.
It is likely that a syscall or other mechanism is needed to initialize the
shadow stack in flexible memory for makecontext.

Is there interest on the kernel side on having mechanisms to fully support
POSIX.1-2004 with GCS or Zicfiss enabled?

-s

> We currently maintain the x86 pattern of implicitly allocating a shadow
> stack for threads started with shadow stack enabled, there has been some
> discussion of removing this support and requiring the use of clone3()
> with explicit allocation of shadow stacks instead.  I have no strong
> feelings either way, implicit allocation is not really consistent with
> anything else we do and creates the potential for errors around thread
> exit but on the other hand it is existing ABI on x86 and minimises the
> changes needed in userspace code.
>
> There is an open issue with support for CRIU, on x86 this required the
> ability to set the GCS mode via ptrace.  This series supports
> configuring mode bits other than enable/disable via ptrace but it needs
> to be confirmed if this is sufficient.
>
> The series depends on support for shadow stacks in clone3(), that series
> includes the addition of ARCH_HAS_USER_SHADOW_STACK.
>
>    
> https://lore.kernel.org/r/20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org
>
> It also depends on the addition of more waitpid() flags to nolibc:
>
>    
> https://lore.kernel.org/r/20231023-nolibc-waitpid-flags-v2-1-b09d096f091f@kernel.org
>
> You can see a branch with the full set of dependencies against Linus'
> tree at:
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git arm64-gcs
>
> [1] https://lore.kernel.org/lkml/20230213045351.3945824-1-debug@rivosinc.com/
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v8:
> - Invalidate signal cap token on stack when consuming.
> - Typo and other trivial fixes.
> - Don't try to use process_vm_write() on GCS, it intentionally does not
>   work.
> - Fix leak of thread GCSs.
> - Rebase onto latest clone3() series.
> - Link to v7: 
> https://lore.kernel.org/r/20231122-arm64-gcs-v7-0-201c483bd775@kernel.org
>
> Changes in v7:
> - Rebase onto v6.7-rc2 via the clone3() patch series.
> - Change the token used to cap the stack during signal handling to be
>   compatible with GCSPOPM.
> - Fix flags for new page types.
> - Fold in support for clone3().
> - Replace copy_to_user_gcs() with put_user_gcs().
> - Link to v6: 
> https://lore.kernel.org/r/20231009-arm64-gcs-v6-0-78e55deaa4dd@kernel.org
>
> Changes in v6:
> - Rebase onto v6.6-rc3.
> - Add some more gcsb_dsync() barriers following spec clarifications.
> - Due to ongoing discussion around clone()/clone3() I've not updated
>   anything there, the behaviour is the same as on previous versions.
> - Link to v5: 
> https://lore.kernel.org/r/20230822-arm64-gcs-v5-0-9ef181dd6324@kernel.org
>
> Changes in v5:
> - Don't map any permissions for user GCSs, we always use EL0 accessors
>   or use a separate mapping of the page.
> - Reduce the standard size of the GCS to RLIMIT_STACK/2.
> - Enforce a PAGE_SIZE alignment requirement on map_shadow_stack().
> - Clarifications and fixes to documentation.
> - More tests.
> - Link to v4: 
> https://lore.kernel.org/r/20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org
>
> Changes in v4:
> - Implement flags for map_shadow_stack() allowing the cap and end of
>   stack marker to be enabled independently or not at all.
> - Relax size and alignment requirements for map_shadow_stack().
> - Add more blurb explaining the advantages of hardware enforcement.
> - Link to v3: 
> https://lore.kernel.org/r/20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org
>
> Changes in v3:
> - Rebase onto v6.5-rc4.
> - Add a GCS barrier on context switch.
> - Add a GCS stress test.
> - Link to v2: 
> https://lore.kernel.org/r/20230724-arm64-gcs-v2-0-dc2c1d44c2eb@kernel.org
>
> Changes in v2:
> - Rebase onto v6.5-rc3.
> - Rework prctl() interface to allow each bit to be locked independently.
> - map_shadow_stack() now places the cap token based on the size
>   requested by the caller not the actual space allocated.
> - Mode changes other than enable via ptrace are now supported.
> - Expand test coverage.
> - Various smaller fixes and adjustments.
> - Link to v1: 
> https://lore.kernel.org/r/20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org
>
> ---
> Mark Brown (38):
>       arm64/mm: Restructure arch_validate_flags() for extensibility
>       prctl: arch-agnostic prctl for shadow stack
>       mman: Add map_shadow_stack() flags
>       arm64: Document boot requirements for Guarded Control Stacks
>       arm64/gcs: Document the ABI for Guarded Control Stacks
>       arm64/sysreg: Add definitions for architected GCS caps
>       arm64/gcs: Add manual encodings of GCS instructions
>       arm64/gcs: Provide put_user_gcs()
>       arm64/cpufeature: Runtime detection of Guarded Control Stack (GCS)
>       arm64/mm: Allocate PIE slots for EL0 guarded control stack
>       mm: Define VM_SHADOW_STACK for arm64 when we support GCS
>       arm64/mm: Map pages for guarded control stack
>       KVM: arm64: Manage GCS registers for guests
>       arm64/gcs: Allow GCS usage at EL0 and EL1
>       arm64/idreg: Add overrride for GCS
>       arm64/hwcap: Add hwcap for GCS
>       arm64/traps: Handle GCS exceptions
>       arm64/mm: Handle GCS data aborts
>       arm64/gcs: Context switch GCS state for EL0
>       arm64/gcs: Ensure that new threads have a GCS
>       arm64/gcs: Implement shadow stack prctl() interface
>       arm64/mm: Implement map_shadow_stack()
>       arm64/signal: Set up and restore the GCS context for signal handlers
>       arm64/signal: Expose GCS state in signal frames
>       arm64/ptrace: Expose GCS via ptrace and core files
>       arm64: Add Kconfig for Guarded Control Stack (GCS)
>       kselftest/arm64: Verify the GCS hwcap
>       kselftest/arm64: Add GCS as a detected feature in the signal tests
>       kselftest/arm64: Add framework support for GCS to signal handling tests
>       kselftest/arm64: Allow signals tests to specify an expected si_code
>       kselftest/arm64: Always run signals tests with GCS enabled
>       kselftest/arm64: Add very basic GCS test program
>       kselftest/arm64: Add a GCS test program built with the system libc
>       kselftest/arm64: Add test coverage for GCS mode locking
>       selftests/arm64: Add GCS signal tests
>       kselftest/arm64: Add a GCS stress test
>       kselftest/arm64: Enable GCS for the FP stress tests
>       kselftest: Provide shadow stack enable helpers for arm64
>
>  Documentation/admin-guide/kernel-parameters.txt    |   6 +
>  Documentation/arch/arm64/booting.rst               |  22 +
>  Documentation/arch/arm64/elf_hwcaps.rst            |   3 +
>  Documentation/arch/arm64/gcs.rst                   | 233 +++++++
>  Documentation/arch/arm64/index.rst                 |   1 +
>  Documentation/filesystems/proc.rst                 |   2 +-
>  arch/arm64/Kconfig                                 |  20 +
>  arch/arm64/include/asm/cpufeature.h                |   6 +
>  arch/arm64/include/asm/el2_setup.h                 |  17 +
>  arch/arm64/include/asm/esr.h                       |  28 +-
>  arch/arm64/include/asm/exception.h                 |   2 +
>  arch/arm64/include/asm/gcs.h                       | 107 +++
>  arch/arm64/include/asm/hwcap.h                     |   1 +
>  arch/arm64/include/asm/kvm_arm.h                   |   4 +-
>  arch/arm64/include/asm/kvm_host.h                  |  12 +
>  arch/arm64/include/asm/mman.h                      |  23 +-
>  arch/arm64/include/asm/pgtable-prot.h              |  14 +-
>  arch/arm64/include/asm/processor.h                 |   7 +
>  arch/arm64/include/asm/sysreg.h                    |  20 +
>  arch/arm64/include/asm/uaccess.h                   |  40 ++
>  arch/arm64/include/uapi/asm/hwcap.h                |   1 +
>  arch/arm64/include/uapi/asm/ptrace.h               |   8 +
>  arch/arm64/include/uapi/asm/sigcontext.h           |   9 +
>  arch/arm64/kernel/cpufeature.c                     |  19 +
>  arch/arm64/kernel/cpuinfo.c                        |   1 +
>  arch/arm64/kernel/entry-common.c                   |  23 +
>  arch/arm64/kernel/idreg-override.c                 |   2 +
>  arch/arm64/kernel/process.c                        |  85 +++
>  arch/arm64/kernel/ptrace.c                         |  59 ++
>  arch/arm64/kernel/signal.c                         | 242 ++++++-
>  arch/arm64/kernel/traps.c                          |  11 +
>  arch/arm64/kvm/emulate-nested.c                    |   4 +
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |  17 +
>  arch/arm64/kvm/sys_regs.c                          |  22 +
>  arch/arm64/mm/Makefile                             |   1 +
>  arch/arm64/mm/fault.c                              |  79 ++-
>  arch/arm64/mm/gcs.c                                | 300 +++++++++
>  arch/arm64/mm/mmap.c                               |  13 +-
>  arch/arm64/tools/cpucaps                           |   1 +
>  arch/x86/include/uapi/asm/mman.h                   |   3 -
>  fs/proc/task_mmu.c                                 |   3 +
>  include/linux/mm.h                                 |  16 +-
>  include/uapi/asm-generic/mman.h                    |   4 +
>  include/uapi/linux/elf.h                           |   1 +
>  include/uapi/linux/prctl.h                         |  22 +
>  kernel/sys.c                                       |  30 +
>  tools/testing/selftests/arm64/Makefile             |   2 +-
>  tools/testing/selftests/arm64/abi/hwcap.c          |  19 +
>  tools/testing/selftests/arm64/fp/assembler.h       |  15 +
>  tools/testing/selftests/arm64/fp/fpsimd-test.S     |   2 +
>  tools/testing/selftests/arm64/fp/sve-test.S        |   2 +
>  tools/testing/selftests/arm64/fp/za-test.S         |   2 +
>  tools/testing/selftests/arm64/fp/zt-test.S         |   2 +
>  tools/testing/selftests/arm64/gcs/.gitignore       |   5 +
>  tools/testing/selftests/arm64/gcs/Makefile         |  24 +
>  tools/testing/selftests/arm64/gcs/asm-offsets.h    |   0
>  tools/testing/selftests/arm64/gcs/basic-gcs.c      | 428 ++++++++++++
>  tools/testing/selftests/arm64/gcs/gcs-locking.c    | 200 ++++++
>  .../selftests/arm64/gcs/gcs-stress-thread.S        | 311 +++++++++
>  tools/testing/selftests/arm64/gcs/gcs-stress.c     | 532 +++++++++++++++
>  tools/testing/selftests/arm64/gcs/gcs-util.h       | 100 +++
>  tools/testing/selftests/arm64/gcs/libc-gcs.c       | 736 +++++++++++++++++++++
>  tools/testing/selftests/arm64/signal/.gitignore    |   1 +
>  .../testing/selftests/arm64/signal/test_signals.c  |  17 +-
>  .../testing/selftests/arm64/signal/test_signals.h  |   6 +
>  .../selftests/arm64/signal/test_signals_utils.c    |  32 +-
>  .../selftests/arm64/signal/test_signals_utils.h    |  39 ++
>  .../arm64/signal/testcases/gcs_exception_fault.c   |  62 ++
>  .../selftests/arm64/signal/testcases/gcs_frame.c   |  88 +++
>  .../arm64/signal/testcases/gcs_write_fault.c       |  67 ++
>  .../selftests/arm64/signal/testcases/testcases.c   |   7 +
>  .../selftests/arm64/signal/testcases/testcases.h   |   1 +
>  tools/testing/selftests/ksft_shstk.h               |  37 ++
>  73 files changed, 4241 insertions(+), 40 deletions(-)
> ---
> base-commit: 50abefbf1bc07f5c4e403fd28f71dcee855100f7
> change-id: 20230303-arm64-gcs-e311ab0d8729
>
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

