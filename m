Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689A6776260
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjHIOYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 10:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjHIOYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:24:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDC01FD8;
        Wed,  9 Aug 2023 07:24:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2042063A1D;
        Wed,  9 Aug 2023 14:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDFEC433CA;
        Wed,  9 Aug 2023 14:24:16 +0000 (UTC)
Date:   Wed, 9 Aug 2023 15:24:14 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v4 03/36] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Message-ID: <ZNOhjrYleGBR6Pbs@arm.com>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-3-68cfa37f9069@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-arm64-gcs-v4-3-68cfa37f9069@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:00:08PM +0100, Mark Brown wrote:
> +2.  Enabling and disabling Guarded Control Stacks
> +-------------------------------------------------
> +
> +* GCS is enabled and disabled for a thread via the PR_SET_SHADOW_STACK_STATUS
> +  prctl(), this takes a single flags argument specifying which GCS features
> +  should be used.
> +
> +* When set PR_SHADOW_STACK_ENABLE flag allocates a Guarded Control Stack for

The 'for' at the end of the line above is not needed.

> +  and enables GCS for the thread, enabling the functionality controlled by
> +  GCSPRE0_EL1.{nTR, RVCHKEN, PCRSEL}.

This should be GCSCRE0_EL1.

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
> +  userspace to prevent changes to any future features.

I presume a new lock prctl() won't allow unlocking but can only extend
the lock. I haven't looked at the patches yet but it may be worth
spelling this out.

> +* PR_SET_SHADOW_STACK_STATUS and PR_LOCK_SHADOW_STACK_STATUS affect only the
> +  thread the called them, any other running threads will be unaffected.

s/the called/that called/

> +* New threads inherit the GCS configuration of the thread that created them.
> +
> +* GCS is disabled on exec().
> +
> +* The current GCS configuration for a thread may be read with the
> +  PR_GET_SHADOW_STACK_STATUS prctl(), this returns the same flags that
> +  are passed to PR_SET_SHADOW_STACK_STATUS.
> +
> +* If GCS is disabled for a thread after having previously been enabled then
> +  the stack will remain allocated for the lifetime of the thread.

Sorry if this has been discussed in other threads. What is the issue
with unmapping/freeing of the shadow stack?

> At present
> +  any attempt to reenable GCS for the thread will be rejected, this may be
> +  revisited in future.

What's the rationale here? Is it that function returns won't work?

> +3.  Allocation of Guarded Control Stacks
> +----------------------------------------
> +
> +* When GCS is enabled for a thread a new Guarded Control Stack will be
> +  allocated for it of size RLIMIT_STACK / 2 or 2 gigabytes, whichever is
> +  smaller.

Is this number based on the fact that a function call would only push
the LR to GCS while standard function prologue pushes at least two
registers?

> +* When GCS is disabled for a thread the Guarded Control Stack initially
> +  allocated for that thread will be freed.  Note carefully that if the
> +  stack has been switched this may not be the stack currently in use by
> +  the thread.

Does this not contradict an earlier statement that the GCS is not freed
for a thread when disabled?

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

I lost track of the GCS spec versions. Has the valid cap token format
been updated? What I have in my spec (though most likely old) is:

  An entry in the Guarded control stack is defined as a Valid cap entry,
  if bits [63:12] of the value are same as bits [63:12] of the address
  where the entry is stored and bits [11:0] contain a Valid cap token.


The other bits in the code look fine to me so far but I haven't looked
at the code yet.

-- 
Catalin
