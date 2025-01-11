Return-Path: <linux-fsdevel+bounces-38945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83077A0A299
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 11:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFBB167BAD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A81318FDB2;
	Sat, 11 Jan 2025 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSwrjeWW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B90C1632DF;
	Sat, 11 Jan 2025 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736590111; cv=none; b=tRntpy2NmPOAFCMosyPO/e+w9ROXeBeZpqnycw/KLHfs5wz9kwYvAEMjWgDWfOwW7U6nFL7xm0A8/dcVO5bcUJ3yLkDpf8i43/e2JYAFyk2QlLaUeJ+4gk475R+Mao5cQancm4qv+Qgsa2giPvmwT6A+Ilc0sju6TlUrhLJHw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736590111; c=relaxed/simple;
	bh=7CvLlMr5FTpbKruiiil2nPbXu43aMHXswT+J9fIsgjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fyPfAMGyVegcrRgN/6T/hrtpQ2gnHg1B4ygg0Dv7ZtHyVco55NKLQNJyktDm16ugd097I62K5jlTsURt7IDrA1bfaoXGPFmbZqcKP92+Zi9UbT51Et0rwuD3RNgOZWFDRfI4JRpoPXG3xlrAXBmxempgjh5NJSq/r/HfoTbqjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSwrjeWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9DCC4CEF6;
	Sat, 11 Jan 2025 10:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736590111;
	bh=7CvLlMr5FTpbKruiiil2nPbXu43aMHXswT+J9fIsgjw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qSwrjeWWFibVt+Hw58PQEuRO0zHH+6XMQFSWwQqHiagOzL26CsB0CRzDAFgoIxr1Q
	 3s3kRXMvooIP8Mi/pvon1Vb69zSynyUvszzzBOLSUcAlDncc3CD0JB47XqgTS2EYAh
	 4m7yGG59rF3EltaPADgi+llCses7rmSr2MvKPX5go++mKwiOS9JytY1NmqSH+KjNBB
	 hFcvv1fJZAdGze+vAc4HJwM/e5eGgdR0f3ZfHOZbTS0Y6ZcZhwb7TC9vdtKvGL2BUh
	 mindBO8E0Hr7M/mk73GsGDCL92SPLwwGQkC9oGvvfVRfHWLp2o6n1GGTtuZuNglVeP
	 zLl4ozHQAXS1w==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d7e527becaso4468166a12.3;
        Sat, 11 Jan 2025 02:08:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNv/pu4vrTH0MZn5oYH4njDM6acWXjciM+TK8Er0PGBVc1ETGpukO1hD9IrQyTlFOqygxUN5sLbvZ0@vger.kernel.org, AJvYcCUs7OD7zNoQhQHpnbAk0NhbY0gN2djg+t/EWBlCpYbdIlLAwhJ70GUtewJWoupovr025Co9YrjDcVDE@vger.kernel.org, AJvYcCUyNV1drW5ZuRhhTcKbTbmwGwTc4hGua2rhg+CVRzyQL/vys9kpDciLCsNqskzhe74QozePgghnjkk=@vger.kernel.org, AJvYcCW8kbRu2C42JLt844JjIBD0I1fEQitDEGDPxiDwa6C8Wm/mtHVDKELObAVFQjm8X/uE/87mI0VkBEG6j9ejOg==@vger.kernel.org, AJvYcCX+4eOf6rWOq+TvdlZewJbXk++NuK100Mx2UU5lCxiJ7WHfGXKtlZw541kDtpm80tdHQfSBmTaGSzmbObk0@vger.kernel.org, AJvYcCXTJJNjLcGsGVvYiqltzlMycodahFfubkq7htQ/COZD1jT4DNbAcsSs8QfZteiRsclAsykSbT7RciNE8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBNczO9SG0CqbNrglL/vQNzBsMpr7glaFND8fl2EoPaGw0q34m
	KykrDhM5oAgRfw6Z+YHXOQD0Hsh+yDqPqCWGy8Sr2/OE+6Brmuh9Ecq4MWbhOjQMEjdEGtYpOGM
	2RwApbrT+lEEfTt0a8iQfZxZ9GsA=
X-Google-Smtp-Source: AGHT+IH2DjthUgWblQXL49IJLOyIvFX0+ZRE+aMvDUmh2fZAI9l7QiaNXfzBiI4cZJ8UGOc61EGtT5RQ1owneATw+7g=
X-Received: by 2002:a05:6402:2814:b0:5d0:ced8:d22d with SMTP id
 4fb4d7f45d1cf-5d972e63dc9mr31289790a12.22.1736590108931; Sat, 11 Jan 2025
 02:08:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <42a318bcbb65931958e52ce4b1334f3d012cbd6f.1736488799.git-series.apopple@nvidia.com>
In-Reply-To: <42a318bcbb65931958e52ce4b1334f3d012cbd6f.1736488799.git-series.apopple@nvidia.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 11 Jan 2025 18:08:10 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6j-V1xbDH7nCZkgp8uRa3+5Ate2Mw+EbjRa=TBGAYEDg@mail.gmail.com>
X-Gm-Features: AbW1kvaO0l9wl3TWuYnrtqx17PqgRbqFI5p6Hrih4ChYWaKFbhqGuS9sAlUt3_0
Message-ID: <CAAhV-H6j-V1xbDH7nCZkgp8uRa3+5Ate2Mw+EbjRa=TBGAYEDg@mail.gmail.com>
Subject: Re: [PATCH v6 24/26] mm: Remove devmap related functions and page
 table bits
To: Alistair Popple <apopple@nvidia.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, linux-mm@kvack.org, 
	alison.schofield@intel.com, lina@asahilina.net, zhang.lyra@gmail.com, 
	gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, dave.jiang@intel.com, 
	logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, 
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, 
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com, 
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, 
	david@redhat.com, peterx@redhat.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jhubbard@nvidia.com, 
	hch@lst.de, david@fromorbit.com, kernel@xen0n.name, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Alistair,

I think the last two patches can be squashed into this one.


Huacai

On Fri, Jan 10, 2025 at 2:03=E2=80=AFPM Alistair Popple <apopple@nvidia.com=
> wrote:
>
> Now that DAX and all other reference counts to ZONE_DEVICE pages are
> managed normally there is no need for the special devmap PTE/PMD/PUD
> page table bits. So drop all references to these, freeing up a
> software defined page table bit on architectures supporting it.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Acked-by: Will Deacon <will@kernel.org> # arm64
> ---
>  Documentation/mm/arch_pgtable_helpers.rst     |  6 +--
>  arch/arm64/Kconfig                            |  1 +-
>  arch/arm64/include/asm/pgtable-prot.h         |  1 +-
>  arch/arm64/include/asm/pgtable.h              | 24 +--------
>  arch/powerpc/Kconfig                          |  1 +-
>  arch/powerpc/include/asm/book3s/64/hash-4k.h  |  6 +--
>  arch/powerpc/include/asm/book3s/64/hash-64k.h |  7 +--
>  arch/powerpc/include/asm/book3s/64/pgtable.h  | 53 +------------------
>  arch/powerpc/include/asm/book3s/64/radix.h    | 14 +-----
>  arch/x86/Kconfig                              |  1 +-
>  arch/x86/include/asm/pgtable.h                | 51 +-----------------
>  arch/x86/include/asm/pgtable_types.h          |  5 +--
>  include/linux/mm.h                            |  7 +--
>  include/linux/pfn_t.h                         | 20 +-------
>  include/linux/pgtable.h                       | 19 +------
>  mm/Kconfig                                    |  4 +-
>  mm/debug_vm_pgtable.c                         | 59 +--------------------
>  mm/hmm.c                                      |  3 +-
>  18 files changed, 11 insertions(+), 271 deletions(-)
>
> diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm=
/arch_pgtable_helpers.rst
> index af24516..c88c7fa 100644
> --- a/Documentation/mm/arch_pgtable_helpers.rst
> +++ b/Documentation/mm/arch_pgtable_helpers.rst
> @@ -30,8 +30,6 @@ PTE Page Table Helpers
>  +---------------------------+-------------------------------------------=
-------+
>  | pte_protnone              | Tests a PROT_NONE PTE                     =
       |
>  +---------------------------+-------------------------------------------=
-------+
> -| pte_devmap                | Tests a ZONE_DEVICE mapped PTE            =
       |
> -+---------------------------+-------------------------------------------=
-------+
>  | pte_soft_dirty            | Tests a soft dirty PTE                    =
       |
>  +---------------------------+-------------------------------------------=
-------+
>  | pte_swp_soft_dirty        | Tests a soft dirty swapped PTE            =
       |
> @@ -104,8 +102,6 @@ PMD Page Table Helpers
>  +---------------------------+-------------------------------------------=
-------+
>  | pmd_protnone              | Tests a PROT_NONE PMD                     =
       |
>  +---------------------------+-------------------------------------------=
-------+
> -| pmd_devmap                | Tests a ZONE_DEVICE mapped PMD            =
       |
> -+---------------------------+-------------------------------------------=
-------+
>  | pmd_soft_dirty            | Tests a soft dirty PMD                    =
       |
>  +---------------------------+-------------------------------------------=
-------+
>  | pmd_swp_soft_dirty        | Tests a soft dirty swapped PMD            =
       |
> @@ -177,8 +173,6 @@ PUD Page Table Helpers
>  +---------------------------+-------------------------------------------=
-------+
>  | pud_write                 | Tests a writable PUD                      =
       |
>  +---------------------------+-------------------------------------------=
-------+
> -| pud_devmap                | Tests a ZONE_DEVICE mapped PUD            =
       |
> -+---------------------------+-------------------------------------------=
-------+
>  | pud_mkyoung               | Creates a young PUD                       =
       |
>  +---------------------------+-------------------------------------------=
-------+
>  | pud_mkold                 | Creates an old PUD                        =
       |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 39310a4..81855d1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -41,7 +41,6 @@ config ARM64
>         select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>         select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>         select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
> -       select ARCH_HAS_PTE_DEVMAP
>         select ARCH_HAS_PTE_SPECIAL
>         select ARCH_HAS_HW_PTE_YOUNG
>         select ARCH_HAS_SETUP_DMA_OPS
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/a=
sm/pgtable-prot.h
> index 9f9cf13..49b51df 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -17,7 +17,6 @@
>  #define PTE_SWP_EXCLUSIVE      (_AT(pteval_t, 1) << 2)  /* only for swp =
ptes */
>  #define PTE_DIRTY              (_AT(pteval_t, 1) << 55)
>  #define PTE_SPECIAL            (_AT(pteval_t, 1) << 56)
> -#define PTE_DEVMAP             (_AT(pteval_t, 1) << 57)
>
>  /*
>   * PTE_PRESENT_INVALID=3D1 & PTE_VALID=3D0 indicates that the pte's fiel=
ds should be
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
> index f8dac66..ea34e51 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -108,7 +108,6 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t =
phys)
>  #define pte_user(pte)          (!!(pte_val(pte) & PTE_USER))
>  #define pte_user_exec(pte)     (!(pte_val(pte) & PTE_UXN))
>  #define pte_cont(pte)          (!!(pte_val(pte) & PTE_CONT))
> -#define pte_devmap(pte)                (!!(pte_val(pte) & PTE_DEVMAP))
>  #define pte_tagged(pte)                ((pte_val(pte) & PTE_ATTRINDX_MAS=
K) =3D=3D \
>                                  PTE_ATTRINDX(MT_NORMAL_TAGGED))
>
> @@ -290,11 +289,6 @@ static inline pmd_t pmd_mkcont(pmd_t pmd)
>         return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
>  }
>
> -static inline pte_t pte_mkdevmap(pte_t pte)
> -{
> -       return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
> -}
> -
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>  static inline int pte_uffd_wp(pte_t pte)
>  {
> @@ -587,14 +581,6 @@ static inline int pmd_trans_huge(pmd_t pmd)
>
>  #define pmd_mkhuge(pmd)                (__pmd(pmd_val(pmd) & ~PMD_TABLE_=
BIT))
>
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -#define pmd_devmap(pmd)                pte_devmap(pmd_pte(pmd))
> -#endif
> -static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> -{
> -       return pte_pmd(set_pte_bit(pmd_pte(pmd), __pgprot(PTE_DEVMAP)));
> -}
> -
>  #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
>  #define pmd_special(pte)       (!!((pmd_val(pte) & PTE_SPECIAL)))
>  static inline pmd_t pmd_mkspecial(pmd_t pmd)
> @@ -1195,16 +1181,6 @@ static inline int pmdp_set_access_flags(struct vm_=
area_struct *vma,
>         return __ptep_set_access_flags(vma, address, (pte_t *)pmdp,
>                                                         pmd_pte(entry), d=
irty);
>  }
> -
> -static inline int pud_devmap(pud_t pud)
> -{
> -       return 0;
> -}
> -
> -static inline int pgd_devmap(pgd_t pgd)
> -{
> -       return 0;
> -}
>  #endif
>
>  #ifdef CONFIG_PAGE_TABLE_CHECK
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index da0ac66..3e85f89 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -147,7 +147,6 @@ config PPC
>         select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>         select ARCH_HAS_PHYS_TO_DMA
>         select ARCH_HAS_PMEM_API
> -       select ARCH_HAS_PTE_DEVMAP              if PPC_BOOK3S_64
>         select ARCH_HAS_PTE_SPECIAL
>         select ARCH_HAS_SCALED_CPUTIME          if VIRT_CPU_ACCOUNTING_NA=
TIVE && PPC_BOOK3S_64
>         select ARCH_HAS_SET_MEMORY
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/=
include/asm/book3s/64/hash-4k.h
> index c3efaca..b0546d3 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> @@ -160,12 +160,6 @@ extern pmd_t hash__pmdp_huge_get_and_clear(struct mm=
_struct *mm,
>  extern int hash__has_transparent_hugepage(void);
>  #endif
>
> -static inline pmd_t hash__pmd_mkdevmap(pmd_t pmd)
> -{
> -       BUG();
> -       return pmd;
> -}
> -
>  #endif /* !__ASSEMBLY__ */
>
>  #endif /* _ASM_POWERPC_BOOK3S_64_HASH_4K_H */
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc=
/include/asm/book3s/64/hash-64k.h
> index 0bf6fd0..0fb5b7d 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -259,7 +259,7 @@ static inline void mark_hpte_slot_valid(unsigned char=
 *hpte_slot_array,
>   */
>  static inline int hash__pmd_trans_huge(pmd_t pmd)
>  {
> -       return !!((pmd_val(pmd) & (_PAGE_PTE | H_PAGE_THP_HUGE | _PAGE_DE=
VMAP)) =3D=3D
> +       return !!((pmd_val(pmd) & (_PAGE_PTE | H_PAGE_THP_HUGE)) =3D=3D
>                   (_PAGE_PTE | H_PAGE_THP_HUGE));
>  }
>
> @@ -281,11 +281,6 @@ extern pmd_t hash__pmdp_huge_get_and_clear(struct mm=
_struct *mm,
>  extern int hash__has_transparent_hugepage(void);
>  #endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
>
> -static inline pmd_t hash__pmd_mkdevmap(pmd_t pmd)
> -{
> -       return __pmd(pmd_val(pmd) | (_PAGE_PTE | H_PAGE_THP_HUGE | _PAGE_=
DEVMAP));
> -}
> -
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_POWERPC_BOOK3S_64_HASH_64K_H */
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/=
include/asm/book3s/64/pgtable.h
> index 6d98e6f..1d98d0a 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -88,7 +88,6 @@
>
>  #define _PAGE_SOFT_DIRTY       _RPAGE_SW3 /* software: software dirty tr=
acking */
>  #define _PAGE_SPECIAL          _RPAGE_SW2 /* software: special page */
> -#define _PAGE_DEVMAP           _RPAGE_SW1 /* software: ZONE_DEVICE page =
*/
>
>  /*
>   * Drivers request for cache inhibited pte mapping using _PAGE_NO_CACHE
> @@ -109,7 +108,7 @@
>   */
>  #define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | =
\
>                          _PAGE_ACCESSED | H_PAGE_THP_HUGE | _PAGE_PTE | \
> -                        _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
> +                        _PAGE_SOFT_DIRTY)
>  /*
>   * user access blocked by key
>   */
> @@ -123,7 +122,7 @@
>   */
>  #define _PAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
>                          _PAGE_ACCESSED | _PAGE_SPECIAL | _PAGE_PTE |   \
> -                        _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
> +                        _PAGE_SOFT_DIRTY)
>
>  /*
>   * We define 2 sets of base prot bits, one for basic pages (ie,
> @@ -609,24 +608,6 @@ static inline pte_t pte_mkhuge(pte_t pte)
>         return pte;
>  }
>
> -static inline pte_t pte_mkdevmap(pte_t pte)
> -{
> -       return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_SPECIAL | _PAGE=
_DEVMAP));
> -}
> -
> -/*
> - * This is potentially called with a pmd as the argument, in which case =
it's not
> - * safe to check _PAGE_DEVMAP unless we also confirm that _PAGE_PTE is s=
et.
> - * That's because the bit we use for _PAGE_DEVMAP is not reserved for so=
ftware
> - * use in page directory entries (ie. non-ptes).
> - */
> -static inline int pte_devmap(pte_t pte)
> -{
> -       __be64 mask =3D cpu_to_be64(_PAGE_DEVMAP | _PAGE_PTE);
> -
> -       return (pte_raw(pte) & mask) =3D=3D mask;
> -}
> -
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  {
>         /* FIXME!! check whether this need to be a conditional */
> @@ -1380,36 +1361,6 @@ static inline bool arch_needs_pgtable_deposit(void=
)
>  }
>  extern void serialize_against_pte_lookup(struct mm_struct *mm);
>
> -
> -static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> -{
> -       if (radix_enabled())
> -               return radix__pmd_mkdevmap(pmd);
> -       return hash__pmd_mkdevmap(pmd);
> -}
> -
> -static inline pud_t pud_mkdevmap(pud_t pud)
> -{
> -       if (radix_enabled())
> -               return radix__pud_mkdevmap(pud);
> -       BUG();
> -       return pud;
> -}
> -
> -static inline int pmd_devmap(pmd_t pmd)
> -{
> -       return pte_devmap(pmd_pte(pmd));
> -}
> -
> -static inline int pud_devmap(pud_t pud)
> -{
> -       return pte_devmap(pud_pte(pud));
> -}
> -
> -static inline int pgd_devmap(pgd_t pgd)
> -{
> -       return 0;
> -}
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
>  #define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/in=
clude/asm/book3s/64/radix.h
> index 8f55ff7..df23a82 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -264,7 +264,7 @@ static inline int radix__p4d_bad(p4d_t p4d)
>
>  static inline int radix__pmd_trans_huge(pmd_t pmd)
>  {
> -       return (pmd_val(pmd) & (_PAGE_PTE | _PAGE_DEVMAP)) =3D=3D _PAGE_P=
TE;
> +       return (pmd_val(pmd) & _PAGE_PTE) =3D=3D _PAGE_PTE;
>  }
>
>  static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
> @@ -274,7 +274,7 @@ static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
>
>  static inline int radix__pud_trans_huge(pud_t pud)
>  {
> -       return (pud_val(pud) & (_PAGE_PTE | _PAGE_DEVMAP)) =3D=3D _PAGE_P=
TE;
> +       return (pud_val(pud) & _PAGE_PTE) =3D=3D _PAGE_PTE;
>  }
>
>  static inline pud_t radix__pud_mkhuge(pud_t pud)
> @@ -315,16 +315,6 @@ static inline int radix__has_transparent_pud_hugepag=
e(void)
>  }
>  #endif
>
> -static inline pmd_t radix__pmd_mkdevmap(pmd_t pmd)
> -{
> -       return __pmd(pmd_val(pmd) | (_PAGE_PTE | _PAGE_DEVMAP));
> -}
> -
> -static inline pud_t radix__pud_mkdevmap(pud_t pud)
> -{
> -       return __pud(pud_val(pud) | (_PAGE_PTE | _PAGE_DEVMAP));
> -}
> -
>  struct vmem_altmap;
>  struct dev_pagemap;
>  extern int __meminit radix__vmemmap_create_mapping(unsigned long start,
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 77f001c..acac373 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -97,7 +97,6 @@ config X86
>         select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>         select ARCH_HAS_PMEM_API                if X86_64
>         select ARCH_HAS_PREEMPT_LAZY
> -       select ARCH_HAS_PTE_DEVMAP              if X86_64
>         select ARCH_HAS_PTE_SPECIAL
>         select ARCH_HAS_HW_PTE_YOUNG
>         select ARCH_HAS_NONLEAF_PMD_YOUNG       if PGTABLE_LEVELS > 2
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtabl=
e.h
> index 593f10a..77705be 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -308,16 +308,15 @@ static inline bool pmd_leaf(pmd_t pte)
>  }
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -/* NOTE: when predicate huge page, consider also pmd_devmap, or use pmd_=
leaf */
>  static inline int pmd_trans_huge(pmd_t pmd)
>  {
> -       return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) =3D=3D _PAGE_PSE=
;
> +       return (pmd_val(pmd) & _PAGE_PSE) =3D=3D _PAGE_PSE;
>  }
>
>  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>  static inline int pud_trans_huge(pud_t pud)
>  {
> -       return (pud_val(pud) & (_PAGE_PSE|_PAGE_DEVMAP)) =3D=3D _PAGE_PSE=
;
> +       return (pud_val(pud) & _PAGE_PSE) =3D=3D _PAGE_PSE;
>  }
>  #endif
>
> @@ -327,24 +326,6 @@ static inline int has_transparent_hugepage(void)
>         return boot_cpu_has(X86_FEATURE_PSE);
>  }
>
> -#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
> -static inline int pmd_devmap(pmd_t pmd)
> -{
> -       return !!(pmd_val(pmd) & _PAGE_DEVMAP);
> -}
> -
> -#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> -static inline int pud_devmap(pud_t pud)
> -{
> -       return !!(pud_val(pud) & _PAGE_DEVMAP);
> -}
> -#else
> -static inline int pud_devmap(pud_t pud)
> -{
> -       return 0;
> -}
> -#endif
> -
>  #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
>  static inline bool pmd_special(pmd_t pmd)
>  {
> @@ -368,12 +349,6 @@ static inline pud_t pud_mkspecial(pud_t pud)
>         return pud_set_flags(pud, _PAGE_SPECIAL);
>  }
>  #endif /* CONFIG_ARCH_SUPPORTS_PUD_PFNMAP */
> -
> -static inline int pgd_devmap(pgd_t pgd)
> -{
> -       return 0;
> -}
> -#endif
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
>  static inline pte_t pte_set_flags(pte_t pte, pteval_t set)
> @@ -534,11 +509,6 @@ static inline pte_t pte_mkspecial(pte_t pte)
>         return pte_set_flags(pte, _PAGE_SPECIAL);
>  }
>
> -static inline pte_t pte_mkdevmap(pte_t pte)
> -{
> -       return pte_set_flags(pte, _PAGE_SPECIAL|_PAGE_DEVMAP);
> -}
> -
>  /* See comments above mksaveddirty_shift() */
>  static inline pmd_t pmd_mksaveddirty(pmd_t pmd)
>  {
> @@ -610,11 +580,6 @@ static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
>         return pmd_set_flags(pmd, _PAGE_DIRTY);
>  }
>
> -static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> -{
> -       return pmd_set_flags(pmd, _PAGE_DEVMAP);
> -}
> -
>  static inline pmd_t pmd_mkhuge(pmd_t pmd)
>  {
>         return pmd_set_flags(pmd, _PAGE_PSE);
> @@ -680,11 +645,6 @@ static inline pud_t pud_mkdirty(pud_t pud)
>         return pud_mksaveddirty(pud);
>  }
>
> -static inline pud_t pud_mkdevmap(pud_t pud)
> -{
> -       return pud_set_flags(pud, _PAGE_DEVMAP);
> -}
> -
>  static inline pud_t pud_mkhuge(pud_t pud)
>  {
>         return pud_set_flags(pud, _PAGE_PSE);
> @@ -1012,13 +972,6 @@ static inline int pte_present(pte_t a)
>         return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
>  }
>
> -#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
> -static inline int pte_devmap(pte_t a)
> -{
> -       return (pte_flags(a) & _PAGE_DEVMAP) =3D=3D _PAGE_DEVMAP;
> -}
> -#endif
> -
>  #define pte_accessible pte_accessible
>  static inline bool pte_accessible(struct mm_struct *mm, pte_t a)
>  {
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/=
pgtable_types.h
> index 4b80453..e4c7b51 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -33,7 +33,6 @@
>  #define _PAGE_BIT_CPA_TEST     _PAGE_BIT_SOFTW1
>  #define _PAGE_BIT_UFFD_WP      _PAGE_BIT_SOFTW2 /* userfaultfd wrprotect=
ed */
>  #define _PAGE_BIT_SOFT_DIRTY   _PAGE_BIT_SOFTW3 /* software dirty tracki=
ng */
> -#define _PAGE_BIT_DEVMAP       _PAGE_BIT_SOFTW4
>
>  #ifdef CONFIG_X86_64
>  #define _PAGE_BIT_SAVED_DIRTY  _PAGE_BIT_SOFTW5 /* Saved Dirty bit (leaf=
) */
> @@ -119,11 +118,9 @@
>
>  #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
>  #define _PAGE_NX       (_AT(pteval_t, 1) << _PAGE_BIT_NX)
> -#define _PAGE_DEVMAP   (_AT(u64, 1) << _PAGE_BIT_DEVMAP)
>  #define _PAGE_SOFTW4   (_AT(pteval_t, 1) << _PAGE_BIT_SOFTW4)
>  #else
>  #define _PAGE_NX       (_AT(pteval_t, 0))
> -#define _PAGE_DEVMAP   (_AT(pteval_t, 0))
>  #define _PAGE_SOFTW4   (_AT(pteval_t, 0))
>  #endif
>
> @@ -152,7 +149,7 @@
>  #define _COMMON_PAGE_CHG_MASK  (PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT | \
>                                  _PAGE_SPECIAL | _PAGE_ACCESSED |       \
>                                  _PAGE_DIRTY_BITS | _PAGE_SOFT_DIRTY |  \
> -                                _PAGE_DEVMAP | _PAGE_CC | _PAGE_UFFD_WP)
> +                                _PAGE_CC | _PAGE_UFFD_WP)
>  #define _PAGE_CHG_MASK (_COMMON_PAGE_CHG_MASK | _PAGE_PAT)
>  #define _HPAGE_CHG_MASK (_COMMON_PAGE_CHG_MASK | _PAGE_PSE | _PAGE_PAT_L=
ARGE)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a734278..23c4e9b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2769,13 +2769,6 @@ static inline pud_t pud_mkspecial(pud_t pud)
>  }
>  #endif /* CONFIG_ARCH_SUPPORTS_PUD_PFNMAP */
>
> -#ifndef CONFIG_ARCH_HAS_PTE_DEVMAP
> -static inline int pte_devmap(pte_t pte)
> -{
> -       return 0;
> -}
> -#endif
> -
>  extern pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
>                                spinlock_t **ptl);
>  static inline pte_t *get_locked_pte(struct mm_struct *mm, unsigned long =
addr,
> diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
> index 2d91482..0100ad8 100644
> --- a/include/linux/pfn_t.h
> +++ b/include/linux/pfn_t.h
> @@ -97,26 +97,6 @@ static inline pud_t pfn_t_pud(pfn_t pfn, pgprot_t pgpr=
ot)
>  #endif
>  #endif
>
> -#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
> -static inline bool pfn_t_devmap(pfn_t pfn)
> -{
> -       const u64 flags =3D PFN_DEV|PFN_MAP;
> -
> -       return (pfn.val & flags) =3D=3D flags;
> -}
> -#else
> -static inline bool pfn_t_devmap(pfn_t pfn)
> -{
> -       return false;
> -}
> -pte_t pte_mkdevmap(pte_t pte);
> -pmd_t pmd_mkdevmap(pmd_t pmd);
> -#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
> -       defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
> -pud_t pud_mkdevmap(pud_t pud);
> -#endif
> -#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
> -
>  #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>  static inline bool pfn_t_special(pfn_t pfn)
>  {
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 00e4a06..1c377de 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1606,21 +1606,6 @@ static inline int pud_write(pud_t pud)
>  }
>  #endif /* pud_write */
>
> -#if !defined(CONFIG_ARCH_HAS_PTE_DEVMAP) || !defined(CONFIG_TRANSPARENT_=
HUGEPAGE)
> -static inline int pmd_devmap(pmd_t pmd)
> -{
> -       return 0;
> -}
> -static inline int pud_devmap(pud_t pud)
> -{
> -       return 0;
> -}
> -static inline int pgd_devmap(pgd_t pgd)
> -{
> -       return 0;
> -}
> -#endif
> -
>  #if !defined(CONFIG_TRANSPARENT_HUGEPAGE) || \
>         !defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
>  static inline int pud_trans_huge(pud_t pud)
> @@ -1875,8 +1860,8 @@ typedef unsigned int pgtbl_mod_mask;
>   * - It should contain a huge PFN, which points to a huge page larger th=
an
>   *   PAGE_SIZE of the platform.  The PFN format isn't important here.
>   *
> - * - It should cover all kinds of huge mappings (e.g., pXd_trans_huge(),
> - *   pXd_devmap(), or hugetlb mappings).
> + * - It should cover all kinds of huge mappings (i.e. pXd_trans_huge()
> + *   or hugetlb mappings).
>   */
>  #ifndef pgd_leaf
>  #define pgd_leaf(x)    false
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 7949ab1..e1d0981 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1044,9 +1044,6 @@ config ARCH_HAS_CURRENT_STACK_POINTER
>           register alias named "current_stack_pointer", this config can b=
e
>           selected.
>
> -config ARCH_HAS_PTE_DEVMAP
> -       bool
> -
>  config ARCH_HAS_ZONE_DMA_SET
>         bool
>
> @@ -1064,7 +1061,6 @@ config ZONE_DEVICE
>         depends on MEMORY_HOTPLUG
>         depends on MEMORY_HOTREMOVE
>         depends on SPARSEMEM_VMEMMAP
> -       depends on ARCH_HAS_PTE_DEVMAP
>         select XARRAY_MULTI
>
>         help
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index bc748f7..cf5ff92 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -348,12 +348,6 @@ static void __init pud_advanced_tests(struct pgtable=
_debug_args *args)
>         vaddr &=3D HPAGE_PUD_MASK;
>
>         pud =3D pfn_pud(args->pud_pfn, args->page_prot);
> -       /*
> -        * Some architectures have debug checks to make sure
> -        * huge pud mapping are only found with devmap entries
> -        * For now test with only devmap entries.
> -        */
> -       pud =3D pud_mkdevmap(pud);
>         set_pud_at(args->mm, vaddr, args->pudp, pud);
>         flush_dcache_page(page);
>         pudp_set_wrprotect(args->mm, vaddr, args->pudp);
> @@ -366,7 +360,6 @@ static void __init pud_advanced_tests(struct pgtable_=
debug_args *args)
>         WARN_ON(!pud_none(pud));
>  #endif /* __PAGETABLE_PMD_FOLDED */
>         pud =3D pfn_pud(args->pud_pfn, args->page_prot);
> -       pud =3D pud_mkdevmap(pud);
>         pud =3D pud_wrprotect(pud);
>         pud =3D pud_mkclean(pud);
>         set_pud_at(args->mm, vaddr, args->pudp, pud);
> @@ -384,7 +377,6 @@ static void __init pud_advanced_tests(struct pgtable_=
debug_args *args)
>  #endif /* __PAGETABLE_PMD_FOLDED */
>
>         pud =3D pfn_pud(args->pud_pfn, args->page_prot);
> -       pud =3D pud_mkdevmap(pud);
>         pud =3D pud_mkyoung(pud);
>         set_pud_at(args->mm, vaddr, args->pudp, pud);
>         flush_dcache_page(page);
> @@ -693,53 +685,6 @@ static void __init pmd_protnone_tests(struct pgtable=
_debug_args *args)
>  static void __init pmd_protnone_tests(struct pgtable_debug_args *args) {=
 }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
> -#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
> -static void __init pte_devmap_tests(struct pgtable_debug_args *args)
> -{
> -       pte_t pte =3D pfn_pte(args->fixed_pte_pfn, args->page_prot);
> -
> -       pr_debug("Validating PTE devmap\n");
> -       WARN_ON(!pte_devmap(pte_mkdevmap(pte)));
> -}
> -
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -static void __init pmd_devmap_tests(struct pgtable_debug_args *args)
> -{
> -       pmd_t pmd;
> -
> -       if (!has_transparent_hugepage())
> -               return;
> -
> -       pr_debug("Validating PMD devmap\n");
> -       pmd =3D pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
> -       WARN_ON(!pmd_devmap(pmd_mkdevmap(pmd)));
> -}
> -
> -#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> -static void __init pud_devmap_tests(struct pgtable_debug_args *args)
> -{
> -       pud_t pud;
> -
> -       if (!has_transparent_pud_hugepage())
> -               return;
> -
> -       pr_debug("Validating PUD devmap\n");
> -       pud =3D pfn_pud(args->fixed_pud_pfn, args->page_prot);
> -       WARN_ON(!pud_devmap(pud_mkdevmap(pud)));
> -}
> -#else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
> -static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
> -#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
> -#else  /* CONFIG_TRANSPARENT_HUGEPAGE */
> -static void __init pmd_devmap_tests(struct pgtable_debug_args *args) { }
> -static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
> -#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> -#else
> -static void __init pte_devmap_tests(struct pgtable_debug_args *args) { }
> -static void __init pmd_devmap_tests(struct pgtable_debug_args *args) { }
> -static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
> -#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
> -
>  static void __init pte_soft_dirty_tests(struct pgtable_debug_args *args)
>  {
>         pte_t pte =3D pfn_pte(args->fixed_pte_pfn, args->page_prot);
> @@ -1341,10 +1286,6 @@ static int __init debug_vm_pgtable(void)
>         pte_protnone_tests(&args);
>         pmd_protnone_tests(&args);
>
> -       pte_devmap_tests(&args);
> -       pmd_devmap_tests(&args);
> -       pud_devmap_tests(&args);
> -
>         pte_soft_dirty_tests(&args);
>         pmd_soft_dirty_tests(&args);
>         pte_swap_soft_dirty_tests(&args);
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 285578e..2a12879 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -395,8 +395,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>         return 0;
>  }
>
> -#if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && \
> -    defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
> +#if defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
>  static inline unsigned long pud_to_hmm_pfn_flags(struct hmm_range *range=
,
>                                                  pud_t pud)
>  {
> --
> git-series 0.9.1

