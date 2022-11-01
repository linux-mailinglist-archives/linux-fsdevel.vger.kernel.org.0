Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C2A614785
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 11:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiKAKMa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 06:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiKAKM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:12:29 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A550E11C3D
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 03:12:28 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g129so13015631pgc.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Nov 2022 03:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GwyjzJFQ6+6LSJfo59sGDVVoBjg7Wj7qITx6FoTZypg=;
        b=Z84stiEXx8XUpbvMxM3oV1DgPQBjBmZnQrkNya206IcbvZXdLQbf+zgoT2PX2nrrto
         E4Ph/gQYSd06xs7AC5c5T/h7q2no980hT0OjnY7FZljQAj0BhbVhoOFnX+oRug0z2NEN
         FO5WMyE8Ap8mQX0bGJRil+doYUvMYvgm7wu8zkiOPSi2B3Owy6e1pW7Y8aDVQF6+OMH4
         Is2pAhnxydvyuh4Znl1/wl0024hseHsKHcsEQUsQgqgdQDfglZuTxCziflwl2BqJUejk
         IV7q+kf/YHlCuMzb8TAoF7X9Mtni6XEoDe6YhEedE632R5z8YoMyFG/oTH7aX4e0WCKP
         ZH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwyjzJFQ6+6LSJfo59sGDVVoBjg7Wj7qITx6FoTZypg=;
        b=putQgT0fsQhwLo1QrUKFAZIcgOohwFBV7Cr1wCgHQs8/tsDjkjxW8nuuqTm+ArFBNd
         3TVsJzC17oR+GSl/Ky4TacWsm8dauO2SgCivSZtOGDdmjkp0IAFQ1hz0KB1vgSswgFWm
         BFdtCA08gtveTeF9x/+PrjB2ALiN0jnpsyzZSyDJ9gvuE7UQ7ogJyb5lEYk3ymL4ff/0
         w3St86CkjwrB9OQOdEw6JqJ1RcR6iwz/OPUwzXDOqeSQsED919HuFtWyNL9IZliptl2v
         5ylPuXw1z+lsQP8yZbAh9AAO8NMvj2fhx21hu/8zypZjmHK7OQLB2qpfoRKjcADdOjH8
         cB4w==
X-Gm-Message-State: ACrzQf0PVH+7fyM4US4YRjUS3quxP6B/I48aWJ20p4lhWYzh1vfAOhyV
        u/aNWxBJPvi3zLnqzdDxnPc=
X-Google-Smtp-Source: AMsMyM7lp0gh/pF8gLVEHXdoyjyr2Bi7qSyxK9zAlXVS+xbru3YAGv0aoFbXNi8VFJtgXJ9drw7BVQ==
X-Received: by 2002:aa7:859a:0:b0:56b:d76d:8c76 with SMTP id w26-20020aa7859a000000b0056bd76d8c76mr18612936pfn.77.1667297548120;
        Tue, 01 Nov 2022 03:12:28 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id ft10-20020a17090b0f8a00b00210c84b8ae5sm5661397pjb.35.2022.11.01.03.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 03:12:27 -0700 (PDT)
Date:   Tue, 1 Nov 2022 19:12:21 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Uladzislau Rezki <urezki@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 1/1] mm: Add folio_map_local()
Message-ID: <Y2DxBf9Y35vylVon@hyeyoo>
References: <20221028151526.319681-1-willy@infradead.org>
 <20221028151526.319681-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028151526.319681-2-willy@infradead.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 04:15:26PM +0100, Matthew Wilcox (Oracle) wrote:
> Some filesystems benefit from being able to map the entire folio.
> On 32-bit platforms with HIGHMEM, we fall back to using vmap, which
> will be slow.  If it proves to be a performance problem, we can look at
> optimising it in a number of ways.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/highmem.h | 40 ++++++++++++++++++++++++++++++++-
>  include/linux/vmalloc.h |  6 +++--
>  mm/vmalloc.c            | 50 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index e9912da5441b..e8159243d88d 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -10,6 +10,7 @@
>  #include <linux/mm.h>
>  #include <linux/uaccess.h>
>  #include <linux/hardirq.h>
> +#include <linux/vmalloc.h>
>  
>  #include "highmem-internal.h"
>  
> @@ -132,6 +133,44 @@ static inline void *kmap_local_page(struct page *page);
>   */
>  static inline void *kmap_local_folio(struct folio *folio, size_t offset);
>  
> +/**
> + * folio_map_local - Map an entire folio.
> + * @folio: The folio to map.
> + *
> + * Unlike kmap_local_folio(), map an entire folio.  This should be undone
> + * with folio_unmap_local().  The address returned should be treated as
> + * stack-based, and local to this CPU, like kmap_local_folio().
> + *
> + * Context: May allocate memory using GFP_KERNEL if it takes the vmap path.
> + * Return: A kernel virtual address which can be used to access the folio,
> + * or NULL if the mapping fails.
> + */
> +static inline __must_check void *folio_map_local(struct folio *folio)
> +{
> +	might_alloc(GFP_KERNEL);
> +
> +	if (!IS_ENABLED(CONFIG_HIGHMEM))
> +		return folio_address(folio);
> +	if (folio_test_large(folio))
> +		return vm_map_folio(folio);
> +	return kmap_local_page(&folio->page);
> +}
> +
> +/**
> + * folio_unmap_local - Unmap an entire folio.
> + * @addr: Address returned from folio_map_local()
> + *
> + * Undo the result of a previous call to folio_map_local().
> + */
> +static inline void folio_unmap_local(const void *addr)
> +{
> +	if (!IS_ENABLED(CONFIG_HIGHMEM))
> +		return;
> +	if (is_vmalloc_addr(addr))
> +		vunmap(addr);

I think it should be vm_unmap_ram(); (and pass number of pages to
folio_unmap_local()) as the vmap area might be allocated using
vb_alloc().

> +	kunmap_local(addr);
> +}

missing else statement?

> +
>  /**
>   * kmap_atomic - Atomically map a page for temporary usage - Deprecated!
>   * @page:	Pointer to the page to be mapped
> @@ -426,5 +465,4 @@ static inline void folio_zero_range(struct folio *folio,
>  {
>  	zero_user_segments(&folio->page, start, start + length, 0, 0);
>  }
> -
>  #endif /* _LINUX_HIGHMEM_H */
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 096d48aa3437..4bb34c939c01 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -13,6 +13,7 @@
>  #include <asm/vmalloc.h>
>  
>  struct vm_area_struct;		/* vma defining user mapping in mm_types.h */
> +struct folio;			/* also mm_types.h */
>  struct notifier_block;		/* in notifier.h */
>  
>  /* bits in flags of vmalloc's vm_struct below */
> @@ -163,8 +164,9 @@ extern void *vcalloc(size_t n, size_t size) __alloc_size(1, 2);
>  extern void vfree(const void *addr);
>  extern void vfree_atomic(const void *addr);
>  
> -extern void *vmap(struct page **pages, unsigned int count,
> -			unsigned long flags, pgprot_t prot);
> +void *vmap(struct page **pages, unsigned int count, unsigned long flags,
> +		pgprot_t prot);
> +void *vm_map_folio(struct folio *folio);
>  void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot);
>  extern void vunmap(const void *addr);
>  
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ccaa461998f3..265b860c9550 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2283,6 +2283,56 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
>  }
>  EXPORT_SYMBOL(vm_map_ram);
>  
> +#ifdef CONFIG_HIGHMEM
> +/**
> + * vm_map_folio() - Map an entire folio into virtually contiguous space.
> + * @folio: The folio to map.
> + *
> + * Maps all pages in @folio into contiguous kernel virtual space.  This
> + * function is only available in HIGHMEM builds; for !HIGHMEM, use
> + * folio_address().  The pages are mapped with PAGE_KERNEL permissions.
> + *
> + * Return: The address of the area or %NULL on failure
> + */
> +void *vm_map_folio(struct folio *folio)
> +{
> +	size_t size = folio_size(folio);
> +	unsigned long addr;
> +	void *mem;
> +
> +	might_sleep();
> +
> +	if (likely(folio_nr_pages(folio) <= VMAP_MAX_ALLOC)) {
> +		mem = vb_alloc(size, GFP_KERNEL);
> +		if (IS_ERR(mem))
> +			return NULL;
> +		addr = (unsigned long)mem;
> +	} else {
> +		struct vmap_area *va;
> +		va = alloc_vmap_area(size, PAGE_SIZE, VMALLOC_START,
> +				VMALLOC_END, NUMA_NO_NODE, GFP_KERNEL);
> +		if (IS_ERR(va))
> +			return NULL;
> +
> +		addr = va->va_start;
> +		mem = (void *)addr;
> +	}
> +
> +	if (vmap_range_noflush(addr, addr + size,
> +				folio_pfn(folio) << PAGE_SHIFT,
> +				PAGE_KERNEL, folio_shift(folio))) {
> +		vm_unmap_ram(mem, folio_nr_pages(folio));
> +		return NULL;
> +	}
> +	flush_cache_vmap(addr, addr + size);
> +
> +	mem = kasan_unpoison_vmalloc(mem, size, KASAN_VMALLOC_PROT_NORMAL);
> +
> +	return mem;
> +}
> +EXPORT_SYMBOL(vm_map_folio);
> +#endif

it's a bit of copy & paste but yeah, it seems unavoidable at this point.

>  static struct vm_struct *vmlist __initdata;
>  
>  static inline unsigned int vm_area_page_order(struct vm_struct *vm)
> -- 
> 2.35.1

-- 
Thanks,
Hyeonggon
