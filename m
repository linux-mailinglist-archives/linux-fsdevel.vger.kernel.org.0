Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9172D5D54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 15:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389694AbgLJORA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 09:17:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:35140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389607AbgLJOQu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:16:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2CC44AE95;
        Thu, 10 Dec 2020 14:16:04 +0000 (UTC)
Date:   Thu, 10 Dec 2020 15:15:47 +0100
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
Subject: Re: [PATCH v8 03/12] mm/bootmem_info: Introduce free_bootmem_page
 helper
Message-ID: <20201210141547.GA8538@localhost.localdomain>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210035526.38938-4-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:55:17AM +0800, Muchun Song wrote:
> Any memory allocated via the memblock allocator and not via the buddy
> will be makred reserved already in the memmap. For those pages, we can
         marked
> call free_bootmem_page() to free it to buddy allocator.
> 
> Becasue we wan to free some vmemmap pages of the HugeTLB to the buddy
Because     want
> allocator, we can use this helper to do that in the later patchs.
                                                           patches

To be honest, I think if would be best to introduce this along with
patch#4, so we get to see where it gets used.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/bootmem_info.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
> index 4ed6dee1adc9..20a8b0df0c39 100644
> --- a/include/linux/bootmem_info.h
> +++ b/include/linux/bootmem_info.h
> @@ -3,6 +3,7 @@
>  #define __LINUX_BOOTMEM_INFO_H
>  
>  #include <linux/mmzone.h>
> +#include <linux/mm.h>

<linux/mm.h> already includes <linux/mmzone.h>

> +static inline void free_bootmem_page(struct page *page)
> +{
> +	unsigned long magic = (unsigned long)page->freelist;
> +
> +	/* bootmem page has reserved flag in the reserve_bootmem_region */
reserve_bootmem_region sets the reserved flag on bootmem pages?

> +	VM_WARN_ON(!PageReserved(page) || page_ref_count(page) != 2);

We do check for PageReserved in patch#4 before calling in here.
Do we need yet another check here? IOW, do we need to be this paranoid?

> +	if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
> +		put_page_bootmem(page);
> +	else
> +		WARN_ON(1);

Lately, some people have been complaining about using WARN_ON as some
systems come with panic_on_warn set.

I would say that in this case it does not matter much as if the vmemmap
pages are not either SECTION_INFO or MIX_SECTION_INFO it means that a
larger corruption happened elsewhere.

But I think I would align the checks here.
It does not make sense to me to only scream under DEBUG_VM if page's
refcount differs from 2, and have a WARN_ON if the page we are trying
to free was not used for the memmap array.
Both things imply a corruption, so I would set the checks under the same
configurations.

-- 
Oscar Salvador
SUSE L3
