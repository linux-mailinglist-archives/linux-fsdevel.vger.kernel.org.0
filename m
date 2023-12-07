Return-Path: <linux-fsdevel+bounces-5167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B14E808D71
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 17:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C425F1F210E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 16:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A8D481AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 16:33:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF110125C5;
	Thu,  7 Dec 2023 15:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAFCC433C7;
	Thu,  7 Dec 2023 15:11:01 +0000 (UTC)
Date: Thu, 7 Dec 2023 15:10:58 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com, broonie@kernel.org,
	dave.hansen@linux.intel.com, maz@kernel.org, oliver.upton@linux.dev,
	shuah@kernel.org, will@kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v3 09/25] arm64: define VM_PKEY_BIT* for arm64
Message-ID: <ZXHggjY32Ypr5euK@arm.com>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-10-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124163510.1835740-10-joey.gouly@arm.com>

On Fri, Nov 24, 2023 at 04:34:54PM +0000, Joey Gouly wrote:
>  arch/arm64/include/asm/mman.h   |  8 +++++++-
>  arch/arm64/include/asm/page.h   | 10 ++++++++++
>  arch/arm64/mm/mmap.c            |  9 +++++++++
>  arch/powerpc/include/asm/page.h | 11 +++++++++++
>  arch/x86/include/asm/page.h     | 10 ++++++++++
>  fs/proc/task_mmu.c              |  2 ++
>  include/linux/mm.h              | 13 -------------
>  7 files changed, 49 insertions(+), 14 deletions(-)

It might be worth splitting out the powerpc/x86/generic parts into a
separate patch.

> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> index 5966ee4a6154..ecb2d18dc4d7 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -7,7 +7,7 @@
>  #include <uapi/asm/mman.h>
>  
>  static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> -	unsigned long pkey __always_unused)
> +	unsigned long pkey)
>  {
>  	unsigned long ret = 0;
>  
> @@ -17,6 +17,12 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>  	if (system_supports_mte() && (prot & PROT_MTE))
>  		ret |= VM_MTE;
>  
> +#if defined(CONFIG_ARCH_HAS_PKEYS)
> +	ret |= pkey & 0x1 ? VM_PKEY_BIT0 : 0;
> +	ret |= pkey & 0x2 ? VM_PKEY_BIT1 : 0;
> +	ret |= pkey & 0x4 ? VM_PKEY_BIT2 : 0;
> +#endif

Is there anywhere that rejects pkey & 8 on arm64? Because with 128-bit
PTEs, if we ever support them, we can have 4-bit pkeys.

>  #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> index 2312e6ee595f..aabfda2516d2 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -49,6 +49,16 @@ int pfn_is_map_memory(unsigned long pfn);
>  
>  #define VM_DATA_DEFAULT_FLAGS	(VM_DATA_FLAGS_TSK_EXEC | VM_MTE_ALLOWED)
>  
> +#if defined(CONFIG_ARCH_HAS_PKEYS)
> +/* A protection key is a 3-bit value */
> +# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_2
> +# define VM_PKEY_BIT0	VM_HIGH_ARCH_2
> +# define VM_PKEY_BIT1	VM_HIGH_ARCH_3
> +# define VM_PKEY_BIT2	VM_HIGH_ARCH_4
> +# define VM_PKEY_BIT3	0
> +# define VM_PKEY_BIT4	0
> +#endif

I think we should start from VM_HIGH_ARCH_BIT_0 and just move the
VM_MTE, VM_MTE_ALLOWED to VM_HIGH_ARCH_BIT_{4,5}.

> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index e5fcc79b5bfb..a5e75ec333ad 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -330,6 +330,17 @@ static inline unsigned long kaslr_offset(void)
>  }
>  
>  #include <asm-generic/memory_model.h>
> +
> +#if defined(CONFIG_ARCH_HAS_PKEYS)
> +# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
> +/* A protection key is a 5-bit value */
> +# define VM_PKEY_BIT0	VM_HIGH_ARCH_0
> +# define VM_PKEY_BIT1	VM_HIGH_ARCH_1
> +# define VM_PKEY_BIT2	VM_HIGH_ARCH_2
> +# define VM_PKEY_BIT3	VM_HIGH_ARCH_3
> +# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
> +#endif /* CONFIG_ARCH_HAS_PKEYS */
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_POWERPC_PAGE_H */
> diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
> index d18e5c332cb9..b770db1a21e7 100644
> --- a/arch/x86/include/asm/page.h
> +++ b/arch/x86/include/asm/page.h
> @@ -87,5 +87,15 @@ static __always_inline u64 __is_canonical_address(u64 vaddr, u8 vaddr_bits)
>  
>  #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
>  
> +#if defined(CONFIG_ARCH_HAS_PKEYS)
> +# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
> +/* A protection key is a 4-bit value */
> +# define VM_PKEY_BIT0	VM_HIGH_ARCH_0
> +# define VM_PKEY_BIT1	VM_HIGH_ARCH_1
> +# define VM_PKEY_BIT2	VM_HIGH_ARCH_2
> +# define VM_PKEY_BIT3	VM_HIGH_ARCH_3
> +# define VM_PKEY_BIT4	0
> +#endif /* CONFIG_ARCH_HAS_PKEYS */

Rather than moving these to arch code, we could instead keep the generic
definitions with some additional CONFIG_ARCH_HAS_PKEYS_{3,4,5}BIT
selected from the arch code.

-- 
Catalin

