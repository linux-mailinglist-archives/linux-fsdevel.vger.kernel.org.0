Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ED87791BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 16:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbjHKOXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 10:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjHKOXW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:23:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C85E53;
        Fri, 11 Aug 2023 07:23:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9695665A33;
        Fri, 11 Aug 2023 14:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85887C433C8;
        Fri, 11 Aug 2023 14:23:14 +0000 (UTC)
Date:   Fri, 11 Aug 2023 15:23:12 +0100
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
Subject: Re: [PATCH v4 09/36] arm64/mm: Allocate PIE slots for EL0 guarded
 control stack
Message-ID: <ZNZEUEqJuHrdEa/c@arm.com>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-9-68cfa37f9069@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-arm64-gcs-v4-9-68cfa37f9069@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:00:14PM +0100, Mark Brown wrote:
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index eed814b00a38..b157ae0420ed 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -131,15 +131,23 @@ extern bool arm64_use_ng_mappings;
>  /* 6:                                PTE_PXN | PTE_WRITE            */
>  /* 7: PAGE_SHARED_EXEC               PTE_PXN | PTE_WRITE | PTE_USER */
>  /* 8: PAGE_KERNEL_ROX      PTE_UXN                                  */
> -/* 9:                      PTE_UXN |                       PTE_USER */
> +/* 9: PAGE_GCS_RO          PTE_UXN |                       PTE_USER */
>  /* a: PAGE_KERNEL_EXEC     PTE_UXN |           PTE_WRITE            */
> -/* b:                      PTE_UXN |           PTE_WRITE | PTE_USER */
> +/* b: PAGE_GCS             PTE_UXN |           PTE_WRITE | PTE_USER */
>  /* c: PAGE_KERNEL_RO       PTE_UXN | PTE_PXN                        */
>  /* d: PAGE_READONLY        PTE_UXN | PTE_PXN |             PTE_USER */
>  /* e: PAGE_KERNEL          PTE_UXN | PTE_PXN | PTE_WRITE            */
>  /* f: PAGE_SHARED          PTE_UXN | PTE_PXN | PTE_WRITE | PTE_USER */
>  
> +#define _PAGE_GCS	(_PAGE_DEFAULT | PTE_UXN | PTE_WRITE | PTE_USER)
> +#define _PAGE_GCS_RO	(_PAGE_DEFAULT | PTE_UXN | PTE_USER)
> +
> +#define PAGE_GCS	__pgprot(_PAGE_GCS)
> +#define PAGE_GCS_RO	__pgprot(_PAGE_GCS_RO)
> +
>  #define PIE_E0	( \
> +	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS),           PIE_GCS)  | \
> +	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS_RO),        PIE_R)   | \
>  	PIRx_ELx_PERM(pte_pi_index(_PAGE_EXECONLY),      PIE_X_O) | \
>  	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_RX)  | \
>  	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RWX) | \
> @@ -147,6 +155,8 @@ extern bool arm64_use_ng_mappings;
>  	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED),        PIE_RW))
>  
>  #define PIE_E1	( \
> +	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS),           PIE_RW)      | \
> +	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS_RO),        PIE_R)      | \

Had some thoughts on this. Why do we need the EL1 GCS attributes to map
to RW? The instructions we'd use to write the shadow stack are the GCS
'T' variants that run as user already.

The only instructions we have in the kernel that would run as EL1 on a
user address are the exclusives (futex code or the old deprecated
emulation but we don't care about them in this context). So I wonder
whether the kernel PIE entry could simply be PIE_NONE_O. Would this be
too restrictive for future uses? Given the coherency between a GCS
access and a standard data access, we may want to restrict it now until
we have a use-case.

-- 
Catalin
