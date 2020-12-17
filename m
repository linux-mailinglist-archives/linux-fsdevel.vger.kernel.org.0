Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16ECC2DCA77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 02:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbgLQBSz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 20:18:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40154 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731297AbgLQBSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 20:18:55 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BH1EKnB145306;
        Thu, 17 Dec 2020 01:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=6cW3PbzDbry0llU9eTY8gId6hejJDbxxMIndbM3qNBI=;
 b=Nb8FoqHsqC+0ST0GsuhwKkrH6dqRS9FRgQ1qTM+7oasNBSnmagihbUkFYKPvlJoKVjr1
 e5bgN9Y5ztlnkeK9ohI0Jtmf3k5u5Psyzy5Xjfw3rUFa7I4Fea/B4wQc0X28r6JZgUkk
 BGOk5Kdqc/hV8VxqfGn9mCfJ/na8sMsRtG3C+n2GRXt1PSczE2GQylNu6M2B3cIb5gad
 pJDUH+G7Xrm3W7SQuOCA2PONqcc4BbITkS8LCGacv7ZQC0MKUtOfDVXLUXTyrz3ivYlY
 yphV6zgSYoNGElEv51F1n2iUGVADAM/gnd54pYnlsBQNaxqoGToKPot88EHuukEQ83KP hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 35cn9rk588-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Dec 2020 01:17:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BH1FB1K086960;
        Thu, 17 Dec 2020 01:17:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 35e6esnc5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 01:17:27 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BH1HHON006369;
        Thu, 17 Dec 2020 01:17:17 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Dec 2020 17:17:13 -0800
Subject: Re: [PATCH v9 05/11] mm/hugetlb: Allocate the vmemmap pages
 associated with each HugeTLB page
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-6-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <153c505c-d78f-42f2-9a56-04b2b4f6ae7c@oracle.com>
Date:   Wed, 16 Dec 2020 17:17:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201213154534.54826-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012170006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170006
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/13/20 7:45 AM, Muchun Song wrote:
> When we free a HugeTLB page to the buddy allocator, we should allocate the
> vmemmap pages associated with it. We can do that in the __free_hugepage()
> before freeing it to buddy.

...

> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 78c527617e8d..ffcf092c92ed 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -29,6 +29,7 @@
>  #include <linux/sched.h>
>  #include <linux/pgtable.h>
>  #include <linux/bootmem_info.h>
> +#include <linux/delay.h>
>  
>  #include <asm/dma.h>
>  #include <asm/pgalloc.h>
> @@ -39,7 +40,8 @@
>   *
>   * @rmap_pte:		called for each non-empty PTE (lowest-level) entry.
>   * @reuse:		the page which is reused for the tail vmemmap pages.
> - * @vmemmap_pages:	the list head of the vmemmap pages that can be freed.
> + * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
> + *			or is mapped from.
>   */
>  struct vmemmap_rmap_walk {
>  	void (*rmap_pte)(pte_t *pte, unsigned long addr,
> @@ -54,6 +56,9 @@ struct vmemmap_rmap_walk {
>   */
>  #define VMEMMAP_TAIL_PAGE_REUSE		-1
>  
> +/* The gfp mask of allocating vmemmap page */
> +#define GFP_VMEMMAP_PAGE	(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN)
> +
>  static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
>  			      unsigned long end, struct vmemmap_rmap_walk *walk)
>  {
> @@ -200,6 +205,68 @@ void vmemmap_remap_reuse(unsigned long start, unsigned long size)
>  	free_vmemmap_page_list(&vmemmap_pages);
>  }
>  
> +static void vmemmap_remap_restore_pte(pte_t *pte, unsigned long addr,
> +				      struct vmemmap_rmap_walk *walk)
> +{
> +	pgprot_t pgprot = PAGE_KERNEL;
> +	struct page *page;
> +	void *to;
> +
> +	BUG_ON(pte_page(*pte) != walk->reuse);
> +
> +	page = list_first_entry(walk->vmemmap_pages, struct page, lru);
> +	list_del(&page->lru);
> +	to = page_to_virt(page);
> +	copy_page(to, page_to_virt(walk->reuse));
> +
> +	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> +}
> +
> +static void alloc_vmemmap_page_list(struct list_head *list,
> +				    unsigned long nr_pages)
> +{
> +	while (nr_pages--) {
> +		struct page *page;
> +
> +retry:
> +		page = alloc_page(GFP_VMEMMAP_PAGE);

Should we try (or require) the vmemmap page be on the same node as the
pages they describe?  I imagine performance would be impacted if a
struct page and the page it describes are on different numa nodes.

> +		if (unlikely(!page)) {
> +			msleep(100);
> +			/*
> +			 * We should retry infinitely, because we cannot
> +			 * handle allocation failures. Once we allocate
> +			 * vmemmap pages successfully, then we can free
> +			 * a HugeTLB page.
> +			 */
> +			goto retry;
> +		}
> +		list_add_tail(&page->lru, list);
> +	}
> +}
> +

-- 
Mike Kravetz
