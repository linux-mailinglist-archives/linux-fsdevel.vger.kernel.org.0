Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F57B2D72F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 10:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437486AbgLKJgd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 04:36:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:37926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405660AbgLKJgL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:36:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24555AC10;
        Fri, 11 Dec 2020 09:35:28 +0000 (UTC)
Date:   Fri, 11 Dec 2020 10:35:23 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        mhocko@suse.com, song.bao.hua@hisilicon.com, david@redhat.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 06/12] mm/hugetlb: Allocate the vmemmap pages
 associated with each HugeTLB page
Message-ID: <20201211093517.GA22210@linux>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-7-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210035526.38938-7-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:55:20AM +0800, Muchun Song wrote:
> When we free a HugeTLB page to the buddy allocator, we should allocate the
> vmemmap pages associated with it. We can do that in the __free_hugepage()
"vmemmap pages that describe the range" would look better to me, but it is ok.

> +#define GFP_VMEMMAP_PAGE		\
> +	(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_HIGH | __GFP_NOWARN)
>  
>  #ifndef VMEMMAP_HPAGE_SHIFT
>  #define VMEMMAP_HPAGE_SHIFT		HPAGE_SHIFT
> @@ -197,6 +200,11 @@
>  	(__boundary - 1 < (end) - 1) ? __boundary : (end);		 \
>  })
>  
> +typedef void (*vmemmap_remap_pte_func_t)(struct page *reuse, pte_t *pte,
> +					 unsigned long start, unsigned long end,
> +					 void *priv);

Any reason to not have defined GFP_VMEMMAP_PAGE and the new typedef into
hugetlb_vmemmap.h?

  
> +static void vmemmap_restore_pte_range(struct page *reuse, pte_t *pte,
> +				      unsigned long start, unsigned long end,
> +				      void *priv)
> +{
> +	pgprot_t pgprot = PAGE_KERNEL;
> +	void *from = page_to_virt(reuse);
> +	unsigned long addr;
> +	struct list_head *pages = priv;
[...]
> +
> +		/*
> +		 * Make sure that any data that writes to the @to is made
> +		 * visible to the physical page.
> +		 */
> +		flush_kernel_vmap_range(to, PAGE_SIZE);

Correct me if I am wrong, but flush_kernel_vmap_range is a NOOP under arches which
do not have ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE.
Since we only enable support for x86_64, and x86_64 is one of those arches,
could we remove this, and introduced later on in case we enable this feature
on an arch that needs it?

I am not sure if you need to flush the range somehow, as you did in
vmemmap_remap_range.

> +retry:
> +		page = alloc_page(GFP_VMEMMAP_PAGE);
> +		if (unlikely(!page)) {
> +			msleep(100);
> +			/*
> +			 * We should retry infinitely, because we cannot
> +			 * handle allocation failures. Once we allocate
> +			 * vmemmap pages successfully, then we can free
> +			 * a HugeTLB page.
> +			 */
> +			goto retry;

I think this is the trickiest part.
With 2MB HugeTLB pages we only need 6 pages, but with 1GB, the number of pages
we need to allocate increases significantly (4088 pages IIRC).
And you are using __GFP_HIGH, which will allow us to use more memory (by
cutting down the watermark), but it might lead to putting the system
on its knees wrt. memory.
And yes, I know that once we allocate the 4088 pages, 1GB gets freed, but
still.

I would like to hear Michal's thoughts on this one, but I wonder if it makes
sense to not let 1GB-HugeTLB pages be freed.

-- 
Oscar Salvador
SUSE L3
