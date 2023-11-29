Return-Path: <linux-fsdevel+bounces-4169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 345177FD47B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 11:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E18DB20AB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C9E1B277
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K+Kns9sT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAEA19A0;
	Wed, 29 Nov 2023 01:38:56 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231129093854epoutp030e270d45616d20f44fbd791bcf39b464~cDoeABaqa3077330773epoutp03o;
	Wed, 29 Nov 2023 09:38:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231129093854epoutp030e270d45616d20f44fbd791bcf39b464~cDoeABaqa3077330773epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701250734;
	bh=Z8o2k9/EcF1VwaVWhw4/dnlheLLiIA4Szcs5mQJeXOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K+Kns9sTLZ1yaK82WNjnA2z9vRKJ6pUzwc//6Oc6MHdmt1mSB2BPJbXvn50Br4GPP
	 mtEs+o9ARzQaXuApXWtTDJpSw7uLV/RoFqGAgkmKmldipyNwQEVhpMcNW1lU3jkBaL
	 HMv7iB6G8YbdZ6m+6KI6so0ouPDZM8g0E60OE0I0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20231129093852epcas2p2893c27458009bb21972108356f8b98bf~cDocoqHcr2330523305epcas2p2D;
	Wed, 29 Nov 2023 09:38:52 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SgDmD2Rlpz4x9Pp; Wed, 29 Nov
	2023 09:38:52 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	1E.20.10022.CA607656; Wed, 29 Nov 2023 18:38:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20231129093851epcas2p400f2cf157933f7161c264f5ae0380025~cDobgnAcv1408514085epcas2p4K;
	Wed, 29 Nov 2023 09:38:51 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231129093851epsmtrp2ade5d844bc6afc7b3c2827bea4d67978~cDobeMPnj0098500985epsmtrp2O;
	Wed, 29 Nov 2023 09:38:51 +0000 (GMT)
X-AuditID: b6c32a47-9a3ff70000002726-c6-656706acfe96
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	34.5D.08817.BA607656; Wed, 29 Nov 2023 18:38:51 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231129093851epsmtip10f07640abf5aed55f28560ca09088751~cDobFYNTO0165601656epsmtip1K;
	Wed, 29 Nov 2023 09:38:51 +0000 (GMT)
Date: Wed, 29 Nov 2023 18:27:25 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
	vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
	pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 19/27] mm: mprotect: Introduce
 PAGE_FAULT_ON_ACCESS for mprotect(PROT_MTE)
Message-ID: <20231129092725.GD2988384@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231119165721.9849-20-alexandru.elisei@arm.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaVBbVRj15r28BCT6gFqv1KmYigojkLBeOkA7FfGJLaJMHac/wEheAxKS
	mASnpSPLNDaUqZJSqWWRAUEoDBRM2AolRUiFsKlAirK1QkHEAkILDDBFs7n8O9+559zz3e+b
	y8Zchlhu7CSJkpZLBGIu4Yg3d3sGetcSIpo3etkJFdfXEujL6hEC6XsT0KO871loeNZkpn7P
	wtFK5QWA1uu3MTSnacLQd6XLOJpb+xxHd/RVDDSVm4+jlvklBlps7MZRdts6jrSzt5noRocR
	RyNtxQSarv2LiQz1gzi6XmxkokvL8wCVV72IhjtLGSh/6z6BcifHCNTzWScD6bPvMszaFgbK
	MqwQqGBiAqBswwaGOna3cNR0a5OFVJOB6JdvGliHPajaklpA7WznAUqlH2dRpdpUSmVYYlK6
	q16UtuY8QWnX8ljU5O0bBNV7ZQenyjLzMUpXkUEt6AoAtaI3EZSu/wz1QLs/hjyRHJpIC4S0
	3J2WJEiFSRJRGPfN2PhX4wODeHxvfggK5rpLBCl0GDfiaIx3ZJLYPEyu+8cCcaqZihEoFFzf
	8FC5NFVJuydKFcowLi0TimXBMh+FIEWRKhH5SGjlQT6P5xdoFr6fnFi0eRXIts+cKtZ1sDJB
	tTAHsNmQDIDqGbcc4Mh2IVsBHJspx23FGoAFhkx7sQFgfZWWkQMcrA7TzipmO+gAcODaqL2Y
	AzBrtQ+3qHDSA5YZDVYHQb4EexsrgQXvIX3hTNMisBgwso+AU0UDVpErKYIT3xbhlqY4pA9c
	/znFQnNIZ2gsuGe904EMhwvnqxkWLyRzHKFmykDYWoqAbde7mTbsChd7Glk27AYfLHfYNclw
	alVjx0p4bSDTrvGHhfNqYMnFyESoqnrXNpcD0DBujcXIJ2B29yOWjebA7HMuNuMBeLOyBLfh
	Z+BMndreAAU1WZaROJhHYgDQaAjQgP2F/3tM4X9ZhdaAV2Bp+xpho/fBql22DXrC+jbfUsCs
	AXtpmSJFRCv8ZP7/bjdBmqIF1o/l9XoruLL0p08XYLBBF4BsjLuH47OaQLtwhILTabRcGi9P
	FdOKLhBoXsxFzO2pBKn5Z0qU8fyAEF5AUBA/2C+QF8x9mjP96VdCF1IkUNLJNC2j5f/4GGwH
	t0yGinEzZXSFi8VR4tY4+mFz20mxriS9XTIzyBo39Ud9UjExdyTKlF5jejv2xPSxl59PO7bT
	0BmlmTJVxq/kvfB1bl/l8aEtp7u7VYdScaeYyg8cz0Xv+wPzF7dnsD9sSNIHGfM7u56NBWNz
	r11cDJ3klLqcZjpffmxrsHshQpHbwT+rWnY+NBrdUPzGySJVTPRx9b2iU/DWc+OePeX1e+vG
	Rn64cCS2r+5wukgaveZlPCp879fHi4bV6h8jx1r2rz75VnV0maLfdD9qduCduD6nNMctk2gz
	8je1Tu06pK6IKHa71HQ262FItVOzx8ZHAkoj/Gku5I6+NSEiPO4LrnBse/1gBhdXJAr4Xphc
	IfgbYojQrOEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0wbdRjH97u7Xq/EhhPQ/WBumCa4WbVsg8WHxZEZnTlfzGjMXEo2paOX
	bkoBr/zr1IzNmrBGYIMQaEUDwRXpulVbKqzSZsAhFOeM60C2FlE6FmBjDAjDDWVSiHHvPvl+
	P9/n1cOQcXWSJOZIXiEv5GlyFXQM9X2PYtMLZ2kdv/WX1qegwemgoa41SIO/Pwf+qf5RClci
	gyvR5HEKZmyfI1hwPiBh/JSHhK7GOxSMz1VSMOpvIWCkqpaC9pvTBEy19VBQ7l2gwBUZkkCn
	L0BB0NtAw++OhxIQnT9TcKEhIIGaOzcRNLc8A1cuNhJQe/82DVXh32joq7hIgL/8D2LFbSfg
	uDhDgyUUQlAu3iPBt3yfAk/vohRM4R1w7cy30t0pnOMrB+KWHlQjzuS/LuUaXUWcSZyWcO5v
	lJzLfpLmXHPVUi481Elz/fVLFNdUVkty7q+PcRNuC+Jm/IM05/7pI27etelNNivmJS2fe6SY
	F1Izs2MOd43YpAVeY+lsZbm0DJ04ZEYyBrPpeHBploxyHPsDwo7Jo2t5IrbOB4g1jsejJlFi
	RjErTgThzt7F1YJiU3BTQFxlmt2M+9tsKMoJbCoe80yh6IBkL9G48qxVEi3iWR0OffcFZUYM
	I2dVeGFYv3ZURDgUGqOjjpx9HAcsN6gok6wSDy9PElGfZDfglmUmGsvYTDxxspU4hVjrIwvr
	Iwvr/4tGRNpRIl9g0Ov0hm0F2/P4EpVBozcU5elUOfl6F1r9HaWyA3Xa76q6EcGgboQZUpEg
	V83m8HFyrcZ4lBfy3xOKcnlDN9rAUIr18nu3KrRxrE5TyH/A8wW88F9LMLKkMiL5r3rn3Ogr
	n66jZFdfjU8e8PREMoqH8K6XL4XVJdmegHnn7vmg9Mvm2DcMbDETTEOWg1WelOky/+y+moSk
	cw9RppC815RonLBdj92+9e4579SxisseYcxbSgrrfj1UvPjsx1V1W5wltw9etnfwT6drhQP7
	m+0ObdpC/emsJz588q2wb+OFvex4TrCvQ2w4/ZxaZjsQeL+SMZo30uPDQ6m7dr7rzXhRUfp2
	5Fbgnef3tVuIATE9K83VHJEvz6nTS1p8zIkd+w1FULh+z2uQdK1pc9eWmquxj/kqZAOvq8U6
	yD/jnh6xtMlvGDM61H86pHvyPOe953uFz/qyx/7+JFdBGQ5rtilJwaD5F9S6W56qAwAA
X-CMS-MailID: 20231129093851epcas2p400f2cf157933f7161c264f5ae0380025
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----zEYbV4Bg4FKIkr-2JlR4_dQo1NeIGsqd3oq_s_gyE-d-pa17=_37d02_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231119165921epcas2p3dce0532847d59a9c3973b4e41102e27d
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
	<CGME20231119165921epcas2p3dce0532847d59a9c3973b4e41102e27d@epcas2p3.samsung.com>
	<20231119165721.9849-20-alexandru.elisei@arm.com>

------zEYbV4Bg4FKIkr-2JlR4_dQo1NeIGsqd3oq_s_gyE-d-pa17=_37d02_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Sun, Nov 19, 2023 at 04:57:13PM +0000, Alexandru Elisei wrote:
> To enable tagging on a memory range, userspace can use mprotect() with the
> PROT_MTE access flag. Pages already mapped in the VMA don't have the
> associated tag storage block reserved, so mark the PTEs as
> PAGE_FAULT_ON_ACCESS to trigger a fault next time they are accessed, and
> reserve the tag storage on the fault path.
> 
> This has several benefits over reserving the tag storage as part of the
> mprotect() call handling:
> 
> - Tag storage is reserved only for those pages in the VMA that are
>   accessed, instead of for all the pages already mapped in the VMA.
> - Reduces the latency of the mprotect() call.
> - Eliminates races with page migration.
> 
> But all of this is at the expense of an extra page fault per page until the
> pages being accessed all have their corresponding tag storage reserved.
> 
> For arm64, the PAGE_FAULT_ON_ACCESS protection is created by defining a new
> page table entry software bit, PTE_TAG_STORAGE_NONE. Linux doesn't set any
> of the PBHA bits in entries from the last level of the translation table
> and it doesn't use the TCR_ELx.HWUxx bits; also, the first PBHA bit, bit
> 59, is already being used as a software bit for PMD_PRESENT_INVALID.
> 
> This is only implemented for PTE mappings; PMD mappings will follow.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  arch/arm64/Kconfig                       |   1 +
>  arch/arm64/include/asm/mte.h             |   4 +-
>  arch/arm64/include/asm/mte_tag_storage.h |   2 +
>  arch/arm64/include/asm/pgtable-prot.h    |   2 +
>  arch/arm64/include/asm/pgtable.h         |  40 ++++++---
>  arch/arm64/kernel/mte.c                  |  12 ++-
>  arch/arm64/mm/fault.c                    | 101 +++++++++++++++++++++++
>  include/linux/pgtable.h                  |  17 ++++
>  mm/Kconfig                               |   3 +
>  mm/memory.c                              |   3 +
>  10 files changed, 170 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index efa5b7958169..3b9c435eaafb 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2066,6 +2066,7 @@ if ARM64_MTE
>  config ARM64_MTE_TAG_STORAGE
>  	bool "Dynamic MTE tag storage management"
>  	depends on ARCH_KEEP_MEMBLOCK
> +	select ARCH_HAS_FAULT_ON_ACCESS
>  	select CONFIG_CMA
>  	help
>  	  Adds support for dynamic management of the memory used by the hardware
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 6457b7899207..70dc2e409070 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -107,7 +107,7 @@ static inline bool try_page_mte_tagging(struct page *page)
>  }
>  
>  void mte_zero_clear_page_tags(void *addr);
> -void mte_sync_tags(pte_t pte, unsigned int nr_pages);
> +void mte_sync_tags(pte_t *pteval, unsigned int nr_pages);
>  void mte_copy_page_tags(void *kto, const void *kfrom);
>  void mte_thread_init_user(void);
>  void mte_thread_switch(struct task_struct *next);
> @@ -139,7 +139,7 @@ static inline bool try_page_mte_tagging(struct page *page)
>  static inline void mte_zero_clear_page_tags(void *addr)
>  {
>  }
> -static inline void mte_sync_tags(pte_t pte, unsigned int nr_pages)
> +static inline void mte_sync_tags(pte_t *pteval, unsigned int nr_pages)
>  {
>  }
>  static inline void mte_copy_page_tags(void *kto, const void *kfrom)
> diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
> index 6e5d28e607bb..c70ced60a0cd 100644
> --- a/arch/arm64/include/asm/mte_tag_storage.h
> +++ b/arch/arm64/include/asm/mte_tag_storage.h
> @@ -33,6 +33,8 @@ int reserve_tag_storage(struct page *page, int order, gfp_t gfp);
>  void free_tag_storage(struct page *page, int order);
>  
>  bool page_tag_storage_reserved(struct page *page);
> +
> +vm_fault_t handle_page_missing_tag_storage(struct vm_fault *vmf);
>  #else
>  static inline bool tag_storage_enabled(void)
>  {
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index e9624f6326dd..85ebb3e352ad 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -19,6 +19,7 @@
>  #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
>  #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
>  #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
> +#define PTE_TAG_STORAGE_NONE	(_AT(pteval_t, 1) << 60) /* only when PTE_PROT_NONE */
>  
>  /*
>   * This bit indicates that the entry is present i.e. pmd_page()
> @@ -94,6 +95,7 @@ extern bool arm64_use_ng_mappings;
>  	 })
>  
>  #define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
> +#define PAGE_FAULT_ON_ACCESS	__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_TAG_STORAGE_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
>  /* shared+writable pages are clean by default, hence PTE_RDONLY|PTE_WRITE */
>  #define PAGE_SHARED		__pgprot(_PAGE_SHARED)
>  #define PAGE_SHARED_EXEC	__pgprot(_PAGE_SHARED_EXEC)
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 20e8de853f5d..8cc135f1c112 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -326,10 +326,10 @@ static inline void __check_safe_pte_update(struct mm_struct *mm, pte_t *ptep,
>  		     __func__, pte_val(old_pte), pte_val(pte));
>  }
>  
> -static inline void __sync_cache_and_tags(pte_t pte, unsigned int nr_pages)
> +static inline void __sync_cache_and_tags(pte_t *pteval, unsigned int nr_pages)
>  {
> -	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
> -		__sync_icache_dcache(pte);
> +	if (pte_present(*pteval) && pte_user_exec(*pteval) && !pte_special(*pteval))
> +		__sync_icache_dcache(*pteval);
>  
>  	/*
>  	 * If the PTE would provide user space access to the tags associated
> @@ -337,9 +337,9 @@ static inline void __sync_cache_and_tags(pte_t pte, unsigned int nr_pages)
>  	 * pte_access_permitted() returns false for exec only mappings, they
>  	 * don't expose tags (instruction fetches don't check tags).
>  	 */
> -	if (system_supports_mte() && pte_access_permitted(pte, false) &&
> -	    !pte_special(pte) && pte_tagged(pte))
> -		mte_sync_tags(pte, nr_pages);
> +	if (system_supports_mte() && pte_access_permitted(*pteval, false) &&
> +	    !pte_special(*pteval) && pte_tagged(*pteval))
> +		mte_sync_tags(pteval, nr_pages);
>  }
>  
>  static inline void set_ptes(struct mm_struct *mm,
> @@ -347,7 +347,7 @@ static inline void set_ptes(struct mm_struct *mm,
>  			    pte_t *ptep, pte_t pte, unsigned int nr)
>  {
>  	page_table_check_ptes_set(mm, ptep, pte, nr);
> -	__sync_cache_and_tags(pte, nr);
> +	__sync_cache_and_tags(&pte, nr);
>  
>  	for (;;) {
>  		__check_safe_pte_update(mm, ptep, pte);
> @@ -459,6 +459,26 @@ static inline int pmd_protnone(pmd_t pmd)
>  }
>  #endif
>  
> +#ifdef CONFIG_ARCH_HAS_FAULT_ON_ACCESS
> +static inline bool fault_on_access_pte(pte_t pte)
> +{
> +	return (pte_val(pte) & (PTE_PROT_NONE | PTE_TAG_STORAGE_NONE | PTE_VALID)) ==
> +		(PTE_PROT_NONE | PTE_TAG_STORAGE_NONE);
> +}
> +
> +static inline bool fault_on_access_pmd(pmd_t pmd)
> +{
> +	return fault_on_access_pte(pmd_pte(pmd));
> +}
> +
> +static inline vm_fault_t arch_do_page_fault_on_access(struct vm_fault *vmf)
> +{
> +	if (tag_storage_enabled())
> +		return handle_page_missing_tag_storage(vmf);
> +	return VM_FAULT_SIGBUS;
> +}
> +#endif /* CONFIG_ARCH_HAS_FAULT_ON_ACCESS */
> +
>  #define pmd_present_invalid(pmd)     (!!(pmd_val(pmd) & PMD_PRESENT_INVALID))
>  
>  static inline int pmd_present(pmd_t pmd)
> @@ -533,7 +553,7 @@ static inline void __set_pte_at(struct mm_struct *mm,
>  				unsigned long __always_unused addr,
>  				pte_t *ptep, pte_t pte, unsigned int nr)
>  {
> -	__sync_cache_and_tags(pte, nr);
> +	__sync_cache_and_tags(&pte, nr);
>  	__check_safe_pte_update(mm, ptep, pte);
>  	set_pte(ptep, pte);
>  }
> @@ -828,8 +848,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  	 * in MAIR_EL1. The mask below has to include PTE_ATTRINDX_MASK.
>  	 */
>  	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
> -			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE | PTE_GP |
> -			      PTE_ATTRINDX_MASK;
> +			      PTE_PROT_NONE | PTE_TAG_STORAGE_NONE | PTE_VALID |
> +			      PTE_WRITE | PTE_GP | PTE_ATTRINDX_MASK;
>  	/* preserve the hardware dirty information */
>  	if (pte_hw_dirty(pte))
>  		pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index a41ef3213e1e..5962bab1d549 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -21,6 +21,7 @@
>  #include <asm/barrier.h>
>  #include <asm/cpufeature.h>
>  #include <asm/mte.h>
> +#include <asm/mte_tag_storage.h>
>  #include <asm/ptrace.h>
>  #include <asm/sysreg.h>
>  
> @@ -35,13 +36,18 @@ DEFINE_STATIC_KEY_FALSE(mte_async_or_asymm_mode);
>  EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
>  #endif
>  
> -void mte_sync_tags(pte_t pte, unsigned int nr_pages)
> +void mte_sync_tags(pte_t *pteval, unsigned int nr_pages)
>  {
> -	struct page *page = pte_page(pte);
> +	struct page *page = pte_page(*pteval);
>  	unsigned int i;
>  
> -	/* if PG_mte_tagged is set, tags have already been initialised */
>  	for (i = 0; i < nr_pages; i++, page++) {
> +		if (tag_storage_enabled() && unlikely(!page_tag_storage_reserved(page))) {
> +			*pteval = pte_modify(*pteval, PAGE_FAULT_ON_ACCESS);
> +			continue;
> +		}
> +
> +		/* if PG_mte_tagged is set, tags have already been initialised */
>  		if (try_page_mte_tagging(page)) {
>  			mte_clear_page_tags(page_address(page));
>  			set_page_mte_tagged(page);
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index acbc7530d2b2..f5fa583acf18 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -19,6 +19,7 @@
>  #include <linux/kprobes.h>
>  #include <linux/uaccess.h>
>  #include <linux/page-flags.h>
> +#include <linux/page-isolation.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/debug.h>
>  #include <linux/highmem.h>
> @@ -953,3 +954,103 @@ void tag_clear_highpage(struct page *page)
>  	mte_zero_clear_page_tags(page_address(page));
>  	set_page_mte_tagged(page);
>  }
> +
> +#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> +vm_fault_t handle_page_missing_tag_storage(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct page *page = NULL;
> +	pte_t new_pte, old_pte;
> +	bool writable = false;
> +	vm_fault_t err;
> +	int ret;
> +
> +	spin_lock(vmf->ptl);
> +	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
> +		pte_unmap_unlock(vmf->pte, vmf->ptl);
> +		return 0;
> +	}
> +
> +	/* Get the normal PTE  */
> +	old_pte = ptep_get(vmf->pte);
> +	new_pte = pte_modify(old_pte, vma->vm_page_prot);
> +
> +	/*
> +	 * Detect now whether the PTE could be writable; this information
> +	 * is only valid while holding the PT lock.
> +	 */
> +	writable = pte_write(new_pte);
> +	if (!writable && vma_wants_manual_pte_write_upgrade(vma) &&
> +	    can_change_pte_writable(vma, vmf->address, new_pte))
> +		writable = true;
> +
> +	page = vm_normal_page(vma, vmf->address, new_pte);
> +	if (!page || is_zone_device_page(page))
> +		goto out_map;
> +
> +	/*
> +	 * This should never happen, once a VMA has been marked as tagged, that
> +	 * cannot be changed.
> +	 */
> +	if (!(vma->vm_flags & VM_MTE))
> +		goto out_map;
> +
> +	/* Prevent the page from being unmapped from under us. */
> +	get_page(page);
> +	vma_set_access_pid_bit(vma);
> +
> +	/*
> +	 * Pairs with pte_offset_map_nolock(), which takes the RCU read lock,
> +	 * and spin_lock() above which takes the ptl lock. Both locks should be
> +	 * balanced after this point.
> +	 */
> +	pte_unmap_unlock(vmf->pte, vmf->ptl);
> +
> +	/*
> +	 * Probably the page is being isolated for migration, replay the fault
> +	 * to give time for the entry to be replaced by a migration pte.
> +	 */
> +	if (unlikely(is_migrate_isolate_page(page)))
> +		goto out_retry;
> +
> +	ret = reserve_tag_storage(page, 0, GFP_HIGHUSER_MOVABLE);
> +	if (ret)
> +		goto out_retry;
> +
> +	put_page(page);
> +
> +	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address, &vmf->ptl);
> +	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
> +		pte_unmap_unlock(vmf->pte, vmf->ptl);
> +		return 0;
> +	}
> +
> +out_map:
> +	/*
> +	 * Make it present again, depending on how arch implements
> +	 * non-accessible ptes, some can allow access by kernel mode.
> +	 */
> +	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
> +	new_pte = pte_modify(old_pte, vma->vm_page_prot);
> +	new_pte = pte_mkyoung(new_pte);
> +	if (writable)
> +		new_pte = pte_mkwrite(new_pte, vma);
> +	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, new_pte);
> +	update_mmu_cache(vma, vmf->address, vmf->pte);
> +	pte_unmap_unlock(vmf->pte, vmf->ptl);
> +
> +	return 0;
> +
> +out_retry:
> +	put_page(page);
> +	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> +		vma_end_read(vma);
> +	if (fault_flag_allow_retry_first(vmf->flags)) {
> +		err = VM_FAULT_RETRY;
> +	} else {
> +		/* Replay the fault. */
> +		err = 0;

Hello!

Unfortunately, if the page continues to be pinned, it seems like fault will continue to occur.
I guess it makes system stability issue. (but I'm not familiar with that, so please let me know if I'm mistaken!)

How about migrating the page when migration problem repeats.

Thanks,
Regards.

> +	}
> +	return err;
> +}
> +#endif
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index ffdb9b6bed6c..e2c761dd6c41 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1458,6 +1458,23 @@ static inline int pmd_protnone(pmd_t pmd)
>  }
>  #endif /* CONFIG_NUMA_BALANCING */
>  
> +#ifndef CONFIG_ARCH_HAS_FAULT_ON_ACCESS
> +static inline bool fault_on_access_pte(pte_t pte)
> +{
> +	return false;
> +}
> +
> +static inline bool fault_on_access_pmd(pmd_t pmd)
> +{
> +	return false;
> +}
> +
> +static inline vm_fault_t arch_do_page_fault_on_access(struct vm_fault *vmf)
> +{
> +	return VM_FAULT_SIGBUS;
> +}
> +#endif
> +
>  #endif /* CONFIG_MMU */
>  
>  #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 89971a894b60..a90eefc3ee80 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1019,6 +1019,9 @@ config IDLE_PAGE_TRACKING
>  config ARCH_HAS_CACHE_LINE_SIZE
>  	bool
>  
> +config ARCH_HAS_FAULT_ON_ACCESS
> +	bool
> +
>  config ARCH_HAS_CURRENT_STACK_POINTER
>  	bool
>  	help
> diff --git a/mm/memory.c b/mm/memory.c
> index e137f7673749..a04a971200b9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5044,6 +5044,9 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>  	if (!pte_present(vmf->orig_pte))
>  		return do_swap_page(vmf);
>  
> +	if (fault_on_access_pte(vmf->orig_pte) && vma_is_accessible(vmf->vma))
> +		return arch_do_page_fault_on_access(vmf);
> +
>  	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
>  		return do_numa_page(vmf);
>  
> -- 
> 2.42.1
> 
> 

------zEYbV4Bg4FKIkr-2JlR4_dQo1NeIGsqd3oq_s_gyE-d-pa17=_37d02_
Content-Type: text/plain; charset="utf-8"


------zEYbV4Bg4FKIkr-2JlR4_dQo1NeIGsqd3oq_s_gyE-d-pa17=_37d02_--

