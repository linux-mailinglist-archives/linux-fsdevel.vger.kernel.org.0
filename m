Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FFB29DB23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 00:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbgJ1Xnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 19:43:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34422 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390638AbgJ1Xnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:43:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SNYZAX095523;
        Wed, 28 Oct 2020 23:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=tD+BzO2oU1/lvfSIbpKJkUT8M8vBrwQP8fXwH1PMfFo=;
 b=pzQYSwlsBT2Zk9/rjAHlffumhXb6A/331dQo+dJwBCMGTc7W31KSXMlGmgrAU6c8L6Ha
 +5T7MtukGlxjZwtRvsstf/mHqS2FA2DZxIbcJatSzIYyGIDdAmNsb3zYv0XkxpZ2P3Jc
 LdrhK2UpG1nj/KtbCLiaVZC9mIt2USd6xON2qgfUAxFE82szKprT8gB0HWc/f8bg7oVJ
 2/h3iH/OJVdhBFJeIK4QiMJ07NOh4k5N3ZLX2ktPNvpQtRF4EBGY+KUfMBiL/APJsdaI
 jyTXiLxAj8qb/+bMMx7hBc6rsbrioOD9Y/zx09AqVZDldsBF/XZknjdFsAZy7RvAgFWM QQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34dgm47tgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 23:42:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SNe7oD041499;
        Wed, 28 Oct 2020 23:42:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34cx5ywku9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 23:42:37 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09SNgW8J032360;
        Wed, 28 Oct 2020 23:42:32 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 16:42:32 -0700
Subject: Re: [PATCH v2 07/19] mm/hugetlb: Free the vmemmap pages associated
 with each hugetlb page
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201026145114.59424-1-songmuchun@bytedance.com>
 <20201026145114.59424-8-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8658f431-56c4-9774-861a-9c3b54d1910a@oracle.com>
Date:   Wed, 28 Oct 2020 16:42:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201026145114.59424-8-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=2 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=2 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280146
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/26/20 7:51 AM, Muchun Song wrote:
> When we allocate a hugetlb page from the buddy, we should free the
> unused vmemmap pages associated with it. We can do that in the
> prep_new_huge_page().
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/x86/include/asm/hugetlb.h          |   7 +
>  arch/x86/include/asm/pgtable_64_types.h |   8 +
>  include/linux/hugetlb.h                 |   7 +
>  mm/hugetlb.c                            | 190 ++++++++++++++++++++++++
>  4 files changed, 212 insertions(+)
> 
> diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> index f5e882f999cd..7c3eb60c2198 100644
> --- a/arch/x86/include/asm/hugetlb.h
> +++ b/arch/x86/include/asm/hugetlb.h
> @@ -4,10 +4,17 @@
>  
>  #include <asm/page.h>
>  #include <asm-generic/hugetlb.h>
> +#include <asm/pgtable.h>
>  
>  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
>  #define VMEMMAP_HPAGE_SHIFT			PMD_SHIFT
>  #define arch_vmemmap_support_huge_mapping()	boot_cpu_has(X86_FEATURE_PSE)
> +
> +#define vmemmap_pmd_huge vmemmap_pmd_huge
> +static inline bool vmemmap_pmd_huge(pmd_t *pmd)
> +{
> +	return pmd_large(*pmd);
> +}
>  #endif
>  
>  #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
> diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
> index 52e5f5f2240d..bedbd2e7d06c 100644
> --- a/arch/x86/include/asm/pgtable_64_types.h
> +++ b/arch/x86/include/asm/pgtable_64_types.h
> @@ -139,6 +139,14 @@ extern unsigned int ptrs_per_p4d;
>  # define VMEMMAP_START		__VMEMMAP_BASE_L4
>  #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
>  
> +/*
> + * VMEMMAP_SIZE - allows the whole linear region to be covered by
> + *                a struct page array.
> + */
> +#define VMEMMAP_SIZE		(1UL << (__VIRTUAL_MASK_SHIFT - PAGE_SHIFT - \
> +					 1 + ilog2(sizeof(struct page))))
> +#define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)
> +
>  #define VMALLOC_END		(VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
>  
>  #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ace304a6196c..919f47d77117 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -601,6 +601,13 @@ static inline bool arch_vmemmap_support_huge_mapping(void)
>  }
>  #endif
>  
> +#ifndef vmemmap_pmd_huge

Let's add
#define vmemmap_pmd_huge vmemmap_pmd_huge
just in case code gets moved around in header file.

> +static inline bool vmemmap_pmd_huge(pmd_t *pmd)
> +{
> +	return pmd_huge(*pmd);
> +}
> +#endif
> +
>  #ifndef VMEMMAP_HPAGE_SHIFT
>  #define VMEMMAP_HPAGE_SHIFT		PMD_SHIFT
>  #endif
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d6ae9b6876be..aa012d603e06 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1293,10 +1293,20 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>  #endif
>  
>  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +#include <linux/bootmem_info.h>
> +
>  #define RESERVE_VMEMMAP_NR	2U
> +#define RESERVE_VMEMMAP_SIZE	(RESERVE_VMEMMAP_NR << PAGE_SHIFT)

Since RESERVE_VMEMMAP_SIZE is not used here, perhaps it should be added
in the patch where it is first used.

>  
>  #define page_huge_pte(page)	((page)->pmd_huge_pte)
>  
> +#define vmemmap_hpage_addr_end(addr, end)				\
> +({									\
> +	unsigned long __boundary;					\
> +	__boundary = ((addr) + VMEMMAP_HPAGE_SIZE) & VMEMMAP_HPAGE_MASK;\
> +	(__boundary - 1 < (end) - 1) ? __boundary : (end);		\
> +})
> +
>  static inline unsigned int nr_free_vmemmap(struct hstate *h)
>  {
>  	return h->nr_free_vmemmap_pages;
> @@ -1416,6 +1426,181 @@ static void __init hugetlb_vmemmap_init(struct hstate *h)
>  	pr_info("HugeTLB: can free %d vmemmap pages for %s\n",
>  		h->nr_free_vmemmap_pages, h->name);
>  }
> +
> +static inline spinlock_t *vmemmap_pmd_lockptr(pmd_t *pmd)
> +{
> +	static DEFINE_SPINLOCK(pgtable_lock);
> +
> +	return &pgtable_lock;
> +}

This is just a global lock.  Correct?  And hugetlb specific?

It should be OK as the page table entries for huegtlb pages will not
overlap with other entries.

> +
> +/*
> + * Walk a vmemmap address to the pmd it maps.
> + */
> +static pmd_t *vmemmap_to_pmd(const void *page)
> +{
> +	unsigned long addr = (unsigned long)page;
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +
> +	if (addr < VMEMMAP_START || addr >= VMEMMAP_END)
> +		return NULL;
> +
> +	pgd = pgd_offset_k(addr);
> +	if (pgd_none(*pgd))
> +		return NULL;
> +	p4d = p4d_offset(pgd, addr);
> +	if (p4d_none(*p4d))
> +		return NULL;
> +	pud = pud_offset(p4d, addr);
> +
> +	WARN_ON_ONCE(pud_bad(*pud));
> +	if (pud_none(*pud) || pud_bad(*pud))
> +		return NULL;
> +	pmd = pmd_offset(pud, addr);
> +
> +	return pmd;
> +}

That routine is not really hugetlb specific.  Perhaps we could move it
to sparse-vmemmap.c?  Or elsewhere?

-- 
Mike Kravetz
