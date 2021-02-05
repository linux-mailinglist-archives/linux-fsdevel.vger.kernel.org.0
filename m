Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B793105CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 08:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhBEH0R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 02:26:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12466 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhBEH0Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:26:16 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DX6Nr38k6zjKjh;
        Fri,  5 Feb 2021 15:24:12 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 15:25:25 +0800
Subject: Re: [PATCH v14 5/8] mm: hugetlb: add a kernel parameter
 hugetlb_free_vmemmap
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <duanxiongchun@bytedance.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <corbet@lwn.net>,
        <mike.kravetz@oracle.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <viro@zeniv.linux.org.uk>,
        <akpm@linux-foundation.org>, <paulmck@kernel.org>,
        <mchehab+huawei@kernel.org>, <pawan.kumar.gupta@linux.intel.com>,
        <rdunlap@infradead.org>, <oneukum@suse.com>,
        <anshuman.khandual@arm.com>, <jroedel@suse.de>,
        <almasrymina@google.com>, <rientjes@google.com>,
        <willy@infradead.org>, <osalvador@suse.de>, <mhocko@suse.com>,
        <song.bao.hua@hisilicon.com>, <david@redhat.com>,
        <naoya.horiguchi@nec.com>
References: <20210204035043.36609-1-songmuchun@bytedance.com>
 <20210204035043.36609-6-songmuchun@bytedance.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <75172dd1-8948-62b7-4ad8-f158785fd6b9@huawei.com>
Date:   Fri, 5 Feb 2021 15:25:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210204035043.36609-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi:
On 2021/2/4 11:50, Muchun Song wrote:
> Add a kernel parameter hugetlb_free_vmemmap to enable the feature of
> freeing unused vmemmap pages associated with each hugetlb page on boot.
> 
> We disables PMD mapping of vmemmap pages for x86-64 arch when this
> feature is enabled. Because vmemmap_remap_free() depends on vmemmap
> being base page mapped.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

Looks good to me. Thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
>  Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
>  arch/x86/mm/init_64.c                           |  8 ++++++--
>  include/linux/hugetlb.h                         | 19 +++++++++++++++++++
>  mm/hugetlb_vmemmap.c                            | 22 ++++++++++++++++++++++
>  5 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 5adf1e57e932..7db2591f3ad3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1577,6 +1577,20 @@
>  			Documentation/admin-guide/mm/hugetlbpage.rst.
>  			Format: size[KMG]
>  
> +	hugetlb_free_vmemmap=
> +			[KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
> +			this controls freeing unused vmemmap pages associated
> +			with each HugeTLB page. When this option is enabled,
> +			we disable PMD/huge page mapping of vmemmap pages which
> +			increase page table pages. So if a user/sysadmin only
> +			uses a small number of HugeTLB pages (as a percentage
> +			of system memory), they could end up using more memory
> +			with hugetlb_free_vmemmap on as opposed to off.
> +			Format: { on | off (default) }
> +
> +			on:  enable the feature
> +			off: disable the feature
> +
>  	hung_task_panic=
>  			[KNL] Should the hung task detector generate panics.
>  			Format: 0 | 1
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index f7b1c7462991..3a23c2377acc 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -145,6 +145,9 @@ default_hugepagesz
>  
>  	will all result in 256 2M huge pages being allocated.  Valid default
>  	huge page size is architecture dependent.
> +hugetlb_free_vmemmap
> +	When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this enables freeing
> +	unused vmemmap pages associated with each HugeTLB page.
>  
>  When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
>  indicates the current number of pre-allocated huge pages of the default size.
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 0435bee2e172..39f88c5faadc 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -34,6 +34,7 @@
>  #include <linux/gfp.h>
>  #include <linux/kcore.h>
>  #include <linux/bootmem_info.h>
> +#include <linux/hugetlb.h>
>  
>  #include <asm/processor.h>
>  #include <asm/bios_ebda.h>
> @@ -1557,7 +1558,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  {
>  	int err;
>  
> -	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
> +	if ((is_hugetlb_free_vmemmap_enabled()  && !altmap) ||
> +	    end - start < PAGES_PER_SECTION * sizeof(struct page))
>  		err = vmemmap_populate_basepages(start, end, node, NULL);
>  	else if (boot_cpu_has(X86_FEATURE_PSE))
>  		err = vmemmap_populate_hugepages(start, end, node, altmap);
> @@ -1585,6 +1587,8 @@ void register_page_bootmem_memmap(unsigned long section_nr,
>  	pmd_t *pmd;
>  	unsigned int nr_pmd_pages;
>  	struct page *page;
> +	bool base_mapping = !boot_cpu_has(X86_FEATURE_PSE) ||
> +			    is_hugetlb_free_vmemmap_enabled();
>  
>  	for (; addr < end; addr = next) {
>  		pte_t *pte = NULL;
> @@ -1610,7 +1614,7 @@ void register_page_bootmem_memmap(unsigned long section_nr,
>  		}
>  		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
>  
> -		if (!boot_cpu_has(X86_FEATURE_PSE)) {
> +		if (base_mapping) {
>  			next = (addr + PAGE_SIZE) & PAGE_MASK;
>  			pmd = pmd_offset(pud, addr);
>  			if (pmd_none(*pmd))
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 37fd248ce271..ad249e56ac49 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -854,6 +854,20 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
>  
>  void set_page_huge_active(struct page *page);
>  
> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +extern bool hugetlb_free_vmemmap_enabled;
> +
> +static inline bool is_hugetlb_free_vmemmap_enabled(void)
> +{
> +	return hugetlb_free_vmemmap_enabled;
> +}
> +#else
> +static inline bool is_hugetlb_free_vmemmap_enabled(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  #else	/* CONFIG_HUGETLB_PAGE */
>  struct hstate {};
>  
> @@ -1007,6 +1021,11 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
>  					pte_t *ptep, pte_t pte, unsigned long sz)
>  {
>  }
> +
> +static inline bool is_hugetlb_free_vmemmap_enabled(void)
> +{
> +	return false;
> +}
>  #endif	/* CONFIG_HUGETLB_PAGE */
>  
>  static inline spinlock_t *huge_pte_lock(struct hstate *h,
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 0bd6b8d7282d..224a3cb69bf9 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -183,6 +183,28 @@
>  #define RESERVE_VMEMMAP_NR		2U
>  #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
>  
> +bool hugetlb_free_vmemmap_enabled;
> +
> +static int __init early_hugetlb_free_vmemmap_param(char *buf)
> +{
> +	/* We cannot optimize if a "struct page" crosses page boundaries. */
> +	if ((!is_power_of_2(sizeof(struct page)))) {
> +		pr_warn("cannot free vmemmap pages because \"struct page\" crosses page boundaries\n");
> +		return 0;
> +	}
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	if (!strcmp(buf, "on"))
> +		hugetlb_free_vmemmap_enabled = true;
> +	else if (strcmp(buf, "off"))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
> +
>  /*
>   * How many vmemmap pages associated with a HugeTLB page that can be freed
>   * to the buddy allocator.
> 

