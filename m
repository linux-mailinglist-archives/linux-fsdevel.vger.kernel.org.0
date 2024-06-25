Return-Path: <linux-fsdevel+bounces-22454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACAC917467
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 00:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED40DB23C55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 22:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D4F17F4E8;
	Tue, 25 Jun 2024 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BYMptfzB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C134C6E;
	Tue, 25 Jun 2024 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719355884; cv=none; b=VxP/k9MvIFDFBTs20GUGYoWCFHKlAIw6FJrjXCph1JpZwtpsIBd2TJvqVGunW8YpT2yfez/QYrs0lle8inW46gTMMVwvEmczMCEsZcVHZnQPo/wf1SghV5yAtSTHT66FvItBGXD6tWLTRSHW/gWgOJ4lMwZA0XpZeZcPOByM7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719355884; c=relaxed/simple;
	bh=jOC5BuT2HHTewdn8jPuMZWfvsb1rb1yFP38L5NhsBxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qN1gfJo8jMR2gEUl2b4igLJNYKe1L6We239X5g/LumvI/Wb/Y9PB/X//MQL0/O0MMfpMYKRa4Bnr+q+stgYV3j/6Xl4niI3sOvLD0R//VaLUIc712xMtrH0Rt6h4Fm8VzZS++oet1lzJxHjdV4PM4YQR1QT4BjrhFXwOAZY4yuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BYMptfzB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ltRiLnk6zO3kFfoDHJoE1aAUwOpZ78CBl4p6pAJ3GZc=; b=BYMptfzBaXn7jl+jDR8aHYmCN9
	ynJtLvUTxIIrIWHvetlODRKUGZ/z0oQpbIWrQsHY3qb9oxXMWH3AnlpRMM3SIUOzRj6n88XpxqzV2
	QIJN+GLxmi2UawP+ByMvGvHAe9yLQ3NDRSjWLQ/8g7+AsAn9w0hz0EwQtirrjc2cVuTMzoCIpfu/m
	IS8+lw2KttGxPFekEn+wGdMAcHsBiBgJ4Jsyly/8ByU9zmi2N65uI+rdtaYW36t0KOalQBP0I2DK4
	Z2Epfy4BR/tQErNirjYWVRlutku+tCPrgRZP2ZZ/vDdtWoHZ19oomBDg+G3R6bEf9/H/DbZTQbPp9
	VakeB6EA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMF0J-00000004jIo-2S55;
	Tue, 25 Jun 2024 22:51:11 +0000
Message-ID: <4cefa456-63a0-4e16-97bb-022c72c128c6@infradead.org>
Date: Tue, 25 Jun 2024 15:51:09 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/39] arm64/gcs: Document the ABI for Guarded Control
 Stacks
To: Mark Brown <broonie@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 Shuah Khan <shuah@kernel.org>, "Rick P. Edgecombe"
 <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>,
 Ard Biesheuvel <ardb@kernel.org>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
 Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Florian Weimer <fweimer@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
 Ross Burton <ross.burton@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
 <20240625-arm64-gcs-v9-5-0f634469b8f0@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240625-arm64-gcs-v9-5-0f634469b8f0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/25/24 7:57 AM, Mark Brown wrote:
> Add some documentation of the userspace ABI for Guarded Control Stacks.
> 
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/arch/arm64/gcs.rst   | 233 +++++++++++++++++++++++++++++++++++++
>  Documentation/arch/arm64/index.rst |   1 +
>  2 files changed, 234 insertions(+)
> 
> diff --git a/Documentation/arch/arm64/gcs.rst b/Documentation/arch/arm64/gcs.rst
> new file mode 100644
> index 000000000000..c45c0326836a
> --- /dev/null
> +++ b/Documentation/arch/arm64/gcs.rst
> @@ -0,0 +1,233 @@
> +===============================================
> +Guarded Control Stack support for AArch64 Linux
> +===============================================
> +
> +This document outlines briefly the interface provided to userspace by Linux in
> +order to support use of the ARM Guarded Control Stack (GCS) feature.
> +
> +This is an outline of the most important features and issues only and not
> +intended to be exhaustive.
> +
> +
> +
> +1.  General
> +-----------
> +
> +* GCS is an architecture feature intended to provide greater protection
> +  against return oriented programming (ROP) attacks and to simplify the
> +  implementation of features that need to collect stack traces such as
> +  profiling.
> +
> +* When GCS is enabled a separate guarded control stack is maintained by the
> +  PE which is writeable only through specific GCS operations.  This
> +  stores the call stack only, when a procedure call instruction is

                           only. When

> +  performed the current PC is pushed onto the GCS and on RET the
> +  address in the LR is verified against that on the top of the GCS.
> +
> +* When active current GCS pointer is stored in the system register

     Cannot parse this incomplete sentence...

> +  GCSPR_EL0.  This is readable by userspace but can only be updated
> +  via specific GCS instructions.
> +
> +* The architecture provides instructions for switching between guarded
> +  control stacks with checks to ensure that the new stack is a valid
> +  target for switching.
> +
> +* The functionality of GCS is similar to that provided by the x86 Shadow
> +  Stack feature, due to sharing of userspace interfaces the ABI refers to

           feature. Due to

> +  shadow stacks rather than GCS.
> +
> +* Support for GCS is reported to userspace via HWCAP2_GCS in the aux vector
> +  AT_HWCAP2 entry.
> +
> +* GCS is enabled per thread.  While there is support for disabling GCS
> +  at runtime this should be done with great care.
> +
> +* GCS memory access faults are reported as normal memory access faults.
> +
> +* GCS specific errors (those reported with EC 0x2d) will be reported as
> +  SIGSEGV with a si_code of SEGV_CPERR (control protection error).
> +
> +* GCS is supported only for AArch64.
> +
> +* On systems where GCS is supported GCSPR_EL0 is always readable by EL0
> +  regardless of the GCS configuration for the thread.
> +
> +* The architecture supports enabling GCS without verifying that return values
> +  in LR match those in the GCS, the LR will be ignored.  This is not supported

                              GCS; the LR

> +  by Linux.
> +
> +* EL0 GCS entries with bit 63 set are reserved for use, one such use is defined

                                                  for use. One such

> +  below for signals and should be ignored when parsing the stack if not
> +  understood.
> +
> +
> +2.  Enabling and disabling Guarded Control Stacks
> +-------------------------------------------------
> +
> +* GCS is enabled and disabled for a thread via the PR_SET_SHADOW_STACK_STATUS
> +  prctl(), this takes a single flags argument specifying which GCS features

     prctl(). This takes

> +  should be used.
> +
> +* When set PR_SHADOW_STACK_ENABLE flag allocates a Guarded Control Stack
> +  and enables GCS for the thread, enabling the functionality controlled by
> +  GCSCRE0_EL1.{nTR, RVCHKEN, PCRSEL}.
> +
> +* When set the PR_SHADOW_STACK_PUSH flag enables the functionality controlled
> +  by GCSCRE0_EL1.PUSHMEn, allowing explicit GCS pushes.
> +
> +* When set the PR_SHADOW_STACK_WRITE flag enables the functionality controlled
> +  by GCSCRE0_EL1.STREn, allowing explicit stores to the Guarded Control Stack.
> +
> +* Any unknown flags will cause PR_SET_SHADOW_STACK_STATUS to return -EINVAL.
> +
> +* PR_LOCK_SHADOW_STACK_STATUS is passed a bitmask of features with the same
> +  values as used for PR_SET_SHADOW_STACK_STATUS.  Any future changes to the
> +  status of the specified GCS mode bits will be rejected.
> +
> +* PR_LOCK_SHADOW_STACK_STATUS allows any bit to be locked, this allows

                                                      locked; this allows

> +  userspace to prevent changes to any future features.
> +
> +* There is no support for a process to remove a lock that has been set for
> +  it.
> +
> +* PR_SET_SHADOW_STACK_STATUS and PR_LOCK_SHADOW_STACK_STATUS affect only the
> +  thread that called them, any other running threads will be unaffected.

                        them; any other

> +
> +* New threads inherit the GCS configuration of the thread that created them.
> +
> +* GCS is disabled on exec().
> +
> +* The current GCS configuration for a thread may be read with the
> +  PR_GET_SHADOW_STACK_STATUS prctl(), this returns the same flags that

                                prctl(). This

> +  are passed to PR_SET_SHADOW_STACK_STATUS.
> +
> +* If GCS is disabled for a thread after having previously been enabled then
> +  the stack will remain allocated for the lifetime of the thread.  At present
> +  any attempt to reenable GCS for the thread will be rejected, this may be

                                                        rejected; this

> +  revisited in future.
> +
> +* It should be noted that since enabling GCS will result in GCS becoming
> +  active immediately it is not normally possible to return from the function
> +  that invoked the prctl() that enabled GCS.  It is expected that the normal
> +  usage will be that GCS is enabled very early in execution of a program.
> +
> +
> +
> +3.  Allocation of Guarded Control Stacks
> +----------------------------------------
> +
> +* When GCS is enabled for a thread a new Guarded Control Stack will be
> +  allocated for it of size RLIMIT_STACK or 4 gigabytes, whichever is
> +  smaller.
> +
> +* When a new thread is created by a thread which has GCS enabled then a
> +  new Guarded Control Stack will be allocated for the new thread with
> +  half the size of the standard stack.
> +
> +* When a stack is allocated by enabling GCS or during thread creation then
> +  the top 8 bytes of the stack will be initialised to 0 and GCSPR_EL0 will
> +  be set to point to the address of this 0 value, this can be used to

                                              value. This can be

> +  detect the top of the stack.
> +
> +* Additional Guarded Control Stacks can be allocated using the
> +  map_shadow_stack() system call.
> +
> +* Stacks allocated using map_shadow_stack() can optionally have an end of
> +  stack marker and cap placed at the top of the stack.  If the flag
> +  SHADOW_STACK_SET_TOKEN is specified a cap will be placed on the stack,

                                                                     stack;

> +  if SHADOW_STACK_SET_MARKER is not specified the cap will be the top 8
> +  bytes of the stack and if it is specified then the cap will be the next
> +  8 bytes.  While specifying just SHADOW_STACK_SET_MARKER by itself is
> +  valid since the marker is all bits 0 it has no observable effect.
> +
> +* Stacks allocated using map_shadow_stack() must have a size which is a
> +  multiple of 8 bytes larger than 8 bytes and must be 8 bytes aligned.
> +
> +* An address can be specified to map_shadow_stack(), if one is provided then

                                    map_shadow_stack(). If one

> +  it must be aligned to a page boundary.
> +
> +* When a thread is freed the Guarded Control Stack initially allocated for
> +  that thread will be freed.  Note carefully that if the stack has been
> +  switched this may not be the stack currently in use by the thread.
> +
> +
> +4.  Signal handling
> +--------------------
> +
> +* A new signal frame record gcs_context encodes the current GCS mode and
> +  pointer for the interrupted context on signal delivery.  This will always
> +  be present on systems that support GCS.
> +
> +* The record contains a flag field which reports the current GCS configuration
> +  for the interrupted context as PR_GET_SHADOW_STACK_STATUS would.
> +
> +* The signal handler is run with the same GCS configuration as the interrupted
> +  context.
> +
> +* When GCS is enabled for the interrupted thread a signal handling specific
> +  GCS cap token will be written to the GCS, this is an architectural GCS cap

                                          GCS. This is

> +  token with bit 63 set and the token type (bits 0..11) all clear.  The
> +  GCSPR_EL0 reported in the signal frame will point to this cap token.
> +
> +* The signal handler will use the same GCS as the interrupted context.
> +
> +* When GCS is enabled on signal entry a frame with the address of the signal
> +  return handler will be pushed onto the GCS, allowing return from the signal
> +  handler via RET as normal.  This will not be reported in the gcs_context in
> +  the signal frame.
> +
> +
> +5.  Signal return
> +-----------------
> +
> +When returning from a signal handler:
> +
> +* If there is a gcs_context record in the signal frame then the GCS flags
> +  and GCSPR_EL0 will be restored from that context prior to further
> +  validation.
> +
> +* If there is no gcs_context record in the signal frame then the GCS
> +  configuration will be unchanged.
> +
> +* If GCS is enabled on return from a signal handler then GCSPR_EL0 must
> +  point to a valid GCS signal cap record, this will be popped from the

                                     record; this will be

> +  GCS prior to signal return.
> +
> +* If the GCS configuration is locked when returning from a signal then any
> +  attempt to change the GCS configuration will be treated as an error.  This
> +  is true even if GCS was not enabled prior to signal entry.
> +
> +* GCS may be disabled via signal return but any attempt to enable GCS via
> +  signal return will be rejected.
> +
> +
> +6.  ptrace extensions
> +---------------------
> +
> +* A new regset NT_ARM_GCS is defined for use with PTRACE_GETREGSET and
> +  PTRACE_SETREGSET.
> +
> +* Due to the complexity surrounding allocation and deallocation of stacks and
> +  lack of practical application it is not possible to enable GCS via ptrace.
> +  GCS may be disabled via the ptrace interface.
> +
> +* Other GCS modes may be configured via ptrace.
> +
> +* Configuration via ptrace ignores locking of GCS mode bits.
> +
> +
> +7.  ELF coredump extensions
> +---------------------------
> +
> +* NT_ARM_GCS notes will be added to each coredump for each thread of the
> +  dumped process.  The contents will be equivalent to the data that would
> +  have been read if a PTRACE_GETREGSET of the corresponding type were
> +  executed for each thread when the coredump was generated.
> +
> +
> +
> +8.  /proc extensions
> +--------------------
> +
> +* Guarded Control Stack pages will include "ss" in their VmFlags in
> +  /proc/<pid>/smaps.


-- 
~Randy

