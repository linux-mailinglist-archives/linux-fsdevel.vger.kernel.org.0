Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A2A779460
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 18:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjHKQ0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 12:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHKQ0M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:26:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAF418F;
        Fri, 11 Aug 2023 09:26:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87FA464ED5;
        Fri, 11 Aug 2023 16:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFF3C433C7;
        Fri, 11 Aug 2023 16:26:05 +0000 (UTC)
Date:   Fri, 11 Aug 2023 17:26:03 +0100
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
Subject: Re: [PATCH v4 19/36] arm64/gcs: Allocate a new GCS for threads with
 GCS enabled
Message-ID: <ZNZhG/4rBpTenYVH@arm.com>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-19-68cfa37f9069@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-arm64-gcs-v4-19-68cfa37f9069@kernel.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:00:24PM +0100, Mark Brown wrote:
> diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
> index b0a67efc522b..1e059c37088d 100644
> --- a/arch/arm64/mm/gcs.c
> +++ b/arch/arm64/mm/gcs.c
> @@ -8,6 +8,62 @@
>  #include <asm/cpufeature.h>
>  #include <asm/page.h>
>  
> +static unsigned long alloc_gcs(unsigned long addr, unsigned long size,
> +			       unsigned long token_offset, bool set_res_tok)
> +{
> +	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
> +	struct mm_struct *mm = current->mm;
> +	unsigned long mapped_addr, unused;
> +
> +	if (addr)
> +		flags |= MAP_FIXED_NOREPLACE;
> +
> +	mmap_write_lock(mm);
> +	mapped_addr = do_mmap(NULL, addr, size, PROT_READ, flags,
> +			      VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);

Why not PROT_WRITE as well? I guess I need to check the x86 patches
since the do_mmap() called here has a different prototype than what's in
mainline.

This gets confusing since currently the VM_* flags are derived from the
PROT_* flags passed to mmap(). But you skip the PROT_WRITE in favour of
adding VM_WRITE directly.

I haven't followed the x86 discussion but did we run out of PROT_* bits
for a PROT_SHADOW_STACK?

> +	mmap_write_unlock(mm);
> +
> +	return mapped_addr;
> +}
> +
> +static unsigned long gcs_size(unsigned long size)
> +{
> +	if (size)
> +		return PAGE_ALIGN(size);
> +
> +	/* Allocate RLIMIT_STACK with limits of PAGE_SIZE..4G */
> +	size = PAGE_ALIGN(min_t(unsigned long long,
> +				rlimit(RLIMIT_STACK), SZ_4G));
> +	return max(PAGE_SIZE, size);
> +}

I saw Szabolcs commenting on the default size as well. Maybe we should
go for RLIMIT_STACK/2 but let's see how the other sub-thread is going.

> +
> +unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
> +				     unsigned long clone_flags, size_t size)
> +{
> +	unsigned long addr;
> +
> +	if (!system_supports_gcs())
> +		return 0;
> +
> +	if (!task_gcs_el0_enabled(tsk))
> +		return 0;
> +
> +	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM)
> +		return 0;

Is it safe for CLONE_VFORK not to get a new shadow stack? A syscall for
exec could push something to the stack. I guess the GCS pointer in the
parent stays the same, so it wouldn't matter.

That said, I think this check should be somewhere higher up in the
caller of gcs_alloc_thread_stack(). The copy_thread_gcs() function
already does most of the above checks. Is the GCS allocation called from
elsewhere as well?

-- 
Catalin
