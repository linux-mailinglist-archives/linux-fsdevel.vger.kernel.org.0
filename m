Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FCC75948D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 13:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjGSLpL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 07:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGSLpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:45:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FC1D3;
        Wed, 19 Jul 2023 04:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC65361646;
        Wed, 19 Jul 2023 11:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F206C433C8;
        Wed, 19 Jul 2023 11:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689767108;
        bh=X193VsTHxd/qDbY1iwu9zyDcvx+RDZWX3xtpuMtgrvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CZgrXNM7PXs5djMhW97w3CedauBAIO7tJp4gD0qIPDeHSm5dCuZK/mfLTFNwLEbfA
         u/Sds+3iynFpc+ngWUYxVnc+zFYD4DzN/L5LLVP+ghbUyAA59K78pPPozod4KVG8fP
         A65lkT8yWYMBcq58Bc4M14IdRbh71Sq/FHB/SgH+5Y8jPFLgRm4YgYWHi/qxINYV5Y
         ToDcL0Z/YLJa/T2Deryyl39XzhIjmHJvCPhvLpPjvTe+NTZneejIxNLFmZlSs3o54Y
         T0vek5G+sRtvwgOfUrlpDVgvPmcjy2C8ccH9pVBAZP7wlMgP+WYBf3NTIL35kxcib0
         V8zRn5/OT1vyQ==
Date:   Wed, 19 Jul 2023 14:44:37 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 04/35] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Message-ID: <20230719114437.GJ1901145@kernel.org>
References: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
 <20230716-arm64-gcs-v1-4-bf567f93bba6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716-arm64-gcs-v1-4-bf567f93bba6@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 16, 2023 at 10:51:00PM +0100, Mark Brown wrote:
> Add some documentation of the userspace ABI for Guarded Control Stacks.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/arch/arm64/gcs.rst   | 216 +++++++++++++++++++++++++++++++++++++
>  Documentation/arch/arm64/index.rst |   1 +
>  2 files changed, 217 insertions(+)
> 
> diff --git a/Documentation/arch/arm64/gcs.rst b/Documentation/arch/arm64/gcs.rst
> new file mode 100644
> index 000000000000..27ba72d27952
> --- /dev/null
> +++ b/Documentation/arch/arm64/gcs.rst
> @@ -0,0 +1,216 @@
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
> +  performed the current PC is pushed onto the GCS and on RET the
> +  address in the LR is verified against that on the top of the GCS.
> +
> +* When active current GCS pointer is stored in the system register
> +  GCSPR_EL0.  This is readable by userspace but can only be updated
> +  via specific GCS instructions.
> +
> +* The architecture provides instructions for switching between guarded
> +  control stacks with checks to ensure that the new stack is a valid
> +  target for switching.
> +
> +* The functionality of GCS is similar to that provided by the x86 Shadow
> +  Stack feature, due to sharing of userspace interfaces the ABI refers to
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
> +  by Linux.
> +
> +* EL0 GCS entries with bit 63 set are reserved for use, one such use is defined
> +  below for signals and should be ignored when parsing the stack if not
> +  understood.
> +
> +
> +2.  Enabling and disabling Guarded Control Stacks
> +-------------------------------------------------
> +
> +* GCS is enabled and disabled for a thread via the PR_SET_SHADOW_STACK_STATUS
> +  prctl(), this takes a single flags argument specifying which GCS features
> +  should be used.
> +
> +* When set PR_SHADOW_STACK_ENABLE flag allocates a Guarded Control Stack for

                                                 'for' here looks excessive ^

> +  and enables GCS for the thread, enabling the functionality controlled by
> +  GCSPRE0_EL1.{nTR, RVCHKEN, PCRSEL}.
> +
> +* When set the PR_SHADOW_STACK_PUSH flag enables the functionality controlled
> +  by GCSCRE0_EL1.PUSHMEn, allowing explicit GCS push and pops.
> +
> +* When set the PR_SHADOW_STACK_WRITE flag enables the functionality controlled
> +  by GCSCRE0_EL1.STREn, allowing explicit stores to the Guarded Control Stack.
> +
> +* When set the PR_SHADOW_STACK_LOCK flag prevents any further configuration of
> +  the GCS settings for the thread, further attempts to configure GCS will
> +  return -EBUSY.
> +
> +* Any unknown flags will cause PR_SET_SHADOW_STACK_STATUS to return -EINVAL.
> +
> +* PR_SET_SHADOW_STACK_STATUS affects only the thread the called it, any
> +  other running threads will be unaffected.
> +
> +* New threads inherit the GCS configuration of the thread that created them.
> +
> +* GCS is disabled on exec().
> +
> +* The current GCS configuration for a thread may be read with the
> +  PR_GET_SHADOW_STACK_STATUS prctl(), this returns the same flags that
> +  are passed to PR_SET_SHADOW_STACK_STATUS.
> +
> +* If GCS is disabled for a thread after having previously been enabled then
> +  the stack will remain allocated for the lifetime of the thread.  At present
> +  any attempt to reenable GCS for the thread will be rejected, this may be
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
> +  allocated for it of size RLIMIT_STACK / 2 or 2 gigabytes, whichever is
> +  smaller.
> +
> +* When a new thread is created by a thread which has GCS enabled then a
> +  new Guarded Control Stack will be allocated for the new thread with
> +  half the size of the standard stack.
> +
> +* When a stack is allocated by enabling GCS or during thread creation then
> +  the top 8 bytes of the stack will be initialised to 0 and GCSPR_EL0 will
> +  be set to point to the address of this 0 value, this can be used to
> +  detect the top of the stack.
> +
> +* Additional Guarded Control Stacks can be allocated using the
> +  map_shadow_stack() system call.
> +
> +* Stacks allocated using map_shadow_stack() will have the top 8 bytes
> +  set to 0 and the 8 bytes below that initialised with an architecturally
> +  valid GCS cap value, this allows switching to these stacks using the
> +  stack switch instructions provided by the architecture.
> +
> +* When GCS is disabled for a thread the Guarded Control Stack initially
> +  allocated for that thread will be freed.  Note carefully that if the
> +  stack has been switched this may not be the stack currently in use by
> +  the thread.
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
> +  token with bit 63 set.  The GCSPR_EL0 reported in the signal frame will
> +  point to this cap token.
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
> +7.  ptrace extensions
> +---------------------
> +
> +* A new regset NT_ARM_GCS is defined for use with PTRACE_GETREGSET and
> +  PTRACE_SETREGSET.
> +
> +* Due to the complexity surrounding allocation and deallocation of stakcs and
> +  lack of practical application changes to the GCS configuration via ptrace
> +  are not supported.

On x86 CRIU needed to be able to temporarily unlock shadow stack features
to recreate the shadow stack of the thread being restored. I presume CRIU
will need something like that on arm64 as well.

> +
> +
> +
> +8.  ELF coredump extensions
> +---------------------------
> +
> +* NT_ARM_GCS notes will be added to each coredump for each thread of the
> +  dumped process.  The contents will be equivalent to the data that would
> +  have been read if a PTRACE_GETREGSET of the corresponding type were
> +  executed for each thread when the coredump was generated.
> +
> +
> +
> +9.  /proc extensions
> +--------------------
> +
> +* Guarded Control Stack pages will include "ss" in their VmFlags in
> +  /proc/<pid>/smaps.
> diff --git a/Documentation/arch/arm64/index.rst b/Documentation/arch/arm64/index.rst
> index d08e924204bf..dcf3ee3eb8c0 100644
> --- a/Documentation/arch/arm64/index.rst
> +++ b/Documentation/arch/arm64/index.rst
> @@ -14,6 +14,7 @@ ARM64 Architecture
>      booting
>      cpu-feature-registers
>      elf_hwcaps
> +    gcs
>      hugetlbpage
>      kdump
>      legacy_instructions
> 
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
