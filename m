Return-Path: <linux-fsdevel+bounces-52842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE30AE7683
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 07:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8CF1BC4406
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 05:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2778C1EA7EC;
	Wed, 25 Jun 2025 05:55:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABF819E97A;
	Wed, 25 Jun 2025 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750830927; cv=none; b=UpcjjWV0y7rvUJQhtRKtECbD8NqVJI31ApnKHZ/Wd8BWtoR7pF4F13naZWoXdXj2lpUemrLHHuJW1cEsJY3eYv+i2F4R3jz2eyfhw7HSsi//QhKda7rCE2UxbLFaSMmCQsdirUZKfbGazVZyqlOvq3l8kKWiMv744clO50x21vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750830927; c=relaxed/simple;
	bh=cu6xkzOvGYDuMSqHyAyf6H7Pi7vFfczlgV4f5Tksb0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRh6qCbO0mcVUBbsNgYz7ZkC6+6bEaXT5iMv78nzxHPyrQp4pasevOo/dpa94cZWG/ySG62/Z7kxceqmLOgc5YhOGkcMI8zOYlvKpZOCnDwAFzhHvUbpIBVWwdj3T3HAhbEuOhK86n3Qkc4ef1ubPUJJxL8ef7oO+lCWCK1kEks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A60A106F;
	Tue, 24 Jun 2025 22:55:06 -0700 (PDT)
Received: from [10.164.146.16] (J09HK2D2RT.blr.arm.com [10.164.146.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2270F3F63F;
	Tue, 24 Jun 2025 22:55:04 -0700 (PDT)
Message-ID: <1a87887f-7c50-4412-91db-a5b4cf90e6db@arm.com>
Date: Wed, 25 Jun 2025 11:25:01 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: change vm_get_page_prot() to accept vm_flags_t
 argument
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <a12769720a2743f235643b158c4f4f0a9911daf0.1750274467.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <a12769720a2743f235643b158c4f4f0a9911daf0.1750274467.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/06/25 1:12 AM, Lorenzo Stoakes wrote:
> We abstract the type of the VMA flags to vm_flags_t, however in may places
> it is simply assumed this is unsigned long, which is simply incorrect.
> 
> At the moment this is simply an incongruity, however in future we plan to
> change this type and therefore this change is a critical requirement for
> doing so.
> 
> Overall, this patch does not introduce any functional change.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  arch/arm64/mm/mmap.c                       | 2 +-
>  arch/powerpc/include/asm/book3s/64/pkeys.h | 3 ++-
>  arch/sparc/mm/init_64.c                    | 2 +-
>  arch/x86/mm/pgprot.c                       | 2 +-
>  include/linux/mm.h                         | 4 ++--
>  include/linux/pgtable.h                    | 2 +-
>  tools/testing/vma/vma_internal.h           | 2 +-
>  7 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index c86c348857c4..08ee177432c2 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -81,7 +81,7 @@ static int __init adjust_protection_map(void)
>  }
>  arch_initcall(adjust_protection_map);
>  
> -pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
>  {
>  	ptdesc_t prot;
>  
> diff --git a/arch/powerpc/include/asm/book3s/64/pkeys.h b/arch/powerpc/include/asm/book3s/64/pkeys.h
> index 5b178139f3c0..6f2075636591 100644
> --- a/arch/powerpc/include/asm/book3s/64/pkeys.h
> +++ b/arch/powerpc/include/asm/book3s/64/pkeys.h
> @@ -4,8 +4,9 @@
>  #define _ASM_POWERPC_BOOK3S_64_PKEYS_H
>  
>  #include <asm/book3s/64/hash-pkey.h>
> +#include <linux/mm_types.h>
>  
> -static inline u64 vmflag_to_pte_pkey_bits(u64 vm_flags)
> +static inline u64 vmflag_to_pte_pkey_bits(vm_flags_t vm_flags)
>  {
>  	if (!mmu_has_feature(MMU_FTR_PKEY))
>  		return 0x0UL;
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 25ae4c897aae..7ed58bf3aaca 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -3201,7 +3201,7 @@ void copy_highpage(struct page *to, struct page *from)
>  }
>  EXPORT_SYMBOL(copy_highpage);
>  
> -pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
>  {
>  	unsigned long prot = pgprot_val(protection_map[vm_flags &
>  					(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
> diff --git a/arch/x86/mm/pgprot.c b/arch/x86/mm/pgprot.c
> index c84bd9540b16..dc1afd5c839d 100644
> --- a/arch/x86/mm/pgprot.c
> +++ b/arch/x86/mm/pgprot.c
> @@ -32,7 +32,7 @@ void add_encrypt_protection_map(void)
>  		protection_map[i] = pgprot_encrypted(protection_map[i]);
>  }
>  
> -pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
>  {
>  	unsigned long val = pgprot_val(protection_map[vm_flags &
>  				      (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 98a606908307..7a7cd2e1b2af 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3487,10 +3487,10 @@ static inline bool range_in_vma(struct vm_area_struct *vma,
>  }
>  
>  #ifdef CONFIG_MMU
> -pgprot_t vm_get_page_prot(unsigned long vm_flags);
> +pgprot_t vm_get_page_prot(vm_flags_t vm_flags);
>  void vma_set_page_prot(struct vm_area_struct *vma);
>  #else
> -static inline pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +static inline pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
>  {
>  	return __pgprot(0);
>  }
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 1d4439499503..cf1515c163e2 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -2001,7 +2001,7 @@ typedef unsigned int pgtbl_mod_mask;
>   *								x: (yes) yes
>   */
>  #define DECLARE_VM_GET_PAGE_PROT					\
> -pgprot_t vm_get_page_prot(unsigned long vm_flags)			\
> +pgprot_t vm_get_page_prot(vm_flags_t vm_flags)				\
>  {									\
>  		return protection_map[vm_flags &			\
>  			(VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)];	\
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index d7fea56e3bb3..4e3a2f1ac09e 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -581,7 +581,7 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
>  	return __pgprot(pgprot_val(oldprot) | pgprot_val(newprot));
>  }
>  
> -static inline pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +static inline pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
>  {
>  	return __pgprot(vm_flags);
>  }

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

