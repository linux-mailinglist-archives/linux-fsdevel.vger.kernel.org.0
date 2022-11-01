Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C7A6147FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 11:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiKAK4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 06:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKAK4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:56:12 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CF7C75B
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 03:56:11 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id k19so19996374lji.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Nov 2022 03:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mtc/NAES77D5Fjz8Rpzf2L9ukDeKPjuWwQ6+EwONCmI=;
        b=Eswz33D4pWLmKrOgD4QjBWy1l6/gTpppmNvExxWSfg7JCoWJdXzFyfNNEbq2qpO3hL
         BRJ1vdY+7rZCadmlY95JFJy5lZceGJnnpIumtgAJ/wbqodUxRANxkpnIftteUnvDqHVg
         mFW5X7NNj4RqjA+LQ/dQfSEb2/+s8mYFDPiiB1E/2wLxkCJNpLfkUrK85B1mJxeU5+0w
         EjgOKAsLHEieLK1vFUOcCj+qAWSEDjQnvWTcZbLsZ+MaFwNViqg18OAWUO8cNHCOB8wt
         uILBaU8xPtFhWNenw/8EKojA2Ed2aNNIR5gbDv2j//1igtwIwHdsX/njyEf51sG1bnxp
         ISIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mtc/NAES77D5Fjz8Rpzf2L9ukDeKPjuWwQ6+EwONCmI=;
        b=IUWmtCvbEdNzEQsSWIXlFfYqGdgfFBtHZtU4bTYGlaYx6plGZeXVdeALFAKSztDBlT
         yM2yiT+/aRPQJtRk0OZK/Pqtf88LY6u8pWwNeW3dJ3XOwOT/q0Zj2sdsHPIlTNdpCs2+
         H7GePWPRum7D0S2QmdO/eeqCPBh91+tmDxhlGuAn33QfmI3u4EA0EC+WPh2s/3/7IBNO
         mpOHXy9qLEM7o3jjcnFptsfPUY9kqR4H9I1VEwly8oJMzZxjOF0WHlnrCryUOdQ0Q+ZA
         2X9qLVS0NGH7z1S02zt7hRKpp8y6WfNwPtOJzNosvLNDsrOOhG5egbHSPQ/02GIduxJE
         71aQ==
X-Gm-Message-State: ACrzQf2VAdxN+bMGy8o6p1DSsOCn75n+iYic7vw1HgGz4s92Jn66zQir
        kaJxLADU5EVrb69mg3Rlb7uR5B3UXndltA==
X-Google-Smtp-Source: AMsMyM6VMZDp3u6S5NkijnaydrP7HsSypNnXiw/0aQTZptBX+HRP9fB667LjImSRayrtWKFctjRVvg==
X-Received: by 2002:a2e:9dce:0:b0:277:25a4:bc53 with SMTP id x14-20020a2e9dce000000b0027725a4bc53mr7233026ljj.36.1667300169729;
        Tue, 01 Nov 2022 03:56:09 -0700 (PDT)
Received: from pc636 (host-90-235-23-76.mobileonline.telia.com. [90.235.23.76])
        by smtp.gmail.com with ESMTPSA id v19-20020ac25933000000b00498f77cfa63sm1610171lfi.280.2022.11.01.03.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 03:56:09 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 1 Nov 2022 11:56:06 +0100
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Uladzislau Rezki <urezki@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 1/1] mm: Add folio_map_local()
Message-ID: <Y2D7RjajONlbR5Pm@pc636>
References: <20221028151526.319681-1-willy@infradead.org>
 <20221028151526.319681-2-willy@infradead.org>
 <Y2DxBf9Y35vylVon@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2DxBf9Y35vylVon@hyeyoo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 07:12:21PM +0900, Hyeonggon Yoo wrote:
> On Fri, Oct 28, 2022 at 04:15:26PM +0100, Matthew Wilcox (Oracle) wrote:
> > Some filesystems benefit from being able to map the entire folio.
> > On 32-bit platforms with HIGHMEM, we fall back to using vmap, which
> > will be slow.  If it proves to be a performance problem, we can look at
> > optimising it in a number of ways.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  include/linux/highmem.h | 40 ++++++++++++++++++++++++++++++++-
> >  include/linux/vmalloc.h |  6 +++--
> >  mm/vmalloc.c            | 50 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 93 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> > index e9912da5441b..e8159243d88d 100644
> > --- a/include/linux/highmem.h
> > +++ b/include/linux/highmem.h
> > @@ -10,6 +10,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/hardirq.h>
> > +#include <linux/vmalloc.h>
> >  
> >  #include "highmem-internal.h"
> >  
> > @@ -132,6 +133,44 @@ static inline void *kmap_local_page(struct page *page);
> >   */
> >  static inline void *kmap_local_folio(struct folio *folio, size_t offset);
> >  
> > +/**
> > + * folio_map_local - Map an entire folio.
> > + * @folio: The folio to map.
> > + *
> > + * Unlike kmap_local_folio(), map an entire folio.  This should be undone
> > + * with folio_unmap_local().  The address returned should be treated as
> > + * stack-based, and local to this CPU, like kmap_local_folio().
> > + *
> > + * Context: May allocate memory using GFP_KERNEL if it takes the vmap path.
> > + * Return: A kernel virtual address which can be used to access the folio,
> > + * or NULL if the mapping fails.
> > + */
> > +static inline __must_check void *folio_map_local(struct folio *folio)
> > +{
> > +	might_alloc(GFP_KERNEL);
> > +
> > +	if (!IS_ENABLED(CONFIG_HIGHMEM))
> > +		return folio_address(folio);
> > +	if (folio_test_large(folio))
> > +		return vm_map_folio(folio);
> > +	return kmap_local_page(&folio->page);
> > +}
> > +
> > +/**
> > + * folio_unmap_local - Unmap an entire folio.
> > + * @addr: Address returned from folio_map_local()
> > + *
> > + * Undo the result of a previous call to folio_map_local().
> > + */
> > +static inline void folio_unmap_local(const void *addr)
> > +{
> > +	if (!IS_ENABLED(CONFIG_HIGHMEM))
> > +		return;
> > +	if (is_vmalloc_addr(addr))
> > +		vunmap(addr);
> 
> I think it should be vm_unmap_ram(); (and pass number of pages to
> folio_unmap_local()) as the vmap area might be allocated using
> vb_alloc().
> 
> > +	kunmap_local(addr);
> > +}
> 
> missing else statement?
> 
> > +
> >  /**
> >   * kmap_atomic - Atomically map a page for temporary usage - Deprecated!
> >   * @page:	Pointer to the page to be mapped
> > @@ -426,5 +465,4 @@ static inline void folio_zero_range(struct folio *folio,
> >  {
> >  	zero_user_segments(&folio->page, start, start + length, 0, 0);
> >  }
> > -
> >  #endif /* _LINUX_HIGHMEM_H */
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index 096d48aa3437..4bb34c939c01 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -13,6 +13,7 @@
> >  #include <asm/vmalloc.h>
> >  
> >  struct vm_area_struct;		/* vma defining user mapping in mm_types.h */
> > +struct folio;			/* also mm_types.h */
> >  struct notifier_block;		/* in notifier.h */
> >  
> >  /* bits in flags of vmalloc's vm_struct below */
> > @@ -163,8 +164,9 @@ extern void *vcalloc(size_t n, size_t size) __alloc_size(1, 2);
> >  extern void vfree(const void *addr);
> >  extern void vfree_atomic(const void *addr);
> >  
> > -extern void *vmap(struct page **pages, unsigned int count,
> > -			unsigned long flags, pgprot_t prot);
> > +void *vmap(struct page **pages, unsigned int count, unsigned long flags,
> > +		pgprot_t prot);
> > +void *vm_map_folio(struct folio *folio);
> >  void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot);
> >  extern void vunmap(const void *addr);
> >  
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index ccaa461998f3..265b860c9550 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2283,6 +2283,56 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
> >  }
> >  EXPORT_SYMBOL(vm_map_ram);
> >  
> > +#ifdef CONFIG_HIGHMEM
> > +/**
> > + * vm_map_folio() - Map an entire folio into virtually contiguous space.
> > + * @folio: The folio to map.
> > + *
> > + * Maps all pages in @folio into contiguous kernel virtual space.  This
> > + * function is only available in HIGHMEM builds; for !HIGHMEM, use
> > + * folio_address().  The pages are mapped with PAGE_KERNEL permissions.
> > + *
> > + * Return: The address of the area or %NULL on failure
> > + */
> > +void *vm_map_folio(struct folio *folio)
> > +{
> > +	size_t size = folio_size(folio);
> > +	unsigned long addr;
> > +	void *mem;
> > +
> > +	might_sleep();
> > +
> > +	if (likely(folio_nr_pages(folio) <= VMAP_MAX_ALLOC)) {
> > +		mem = vb_alloc(size, GFP_KERNEL);
> > +		if (IS_ERR(mem))
> > +			return NULL;
> > +		addr = (unsigned long)mem;
> > +	} else {
> > +		struct vmap_area *va;
> > +		va = alloc_vmap_area(size, PAGE_SIZE, VMALLOC_START,
> > +				VMALLOC_END, NUMA_NO_NODE, GFP_KERNEL);
> > +		if (IS_ERR(va))
> > +			return NULL;
> > +
> > +		addr = va->va_start;
> > +		mem = (void *)addr;
> > +	}
> > +
> > +	if (vmap_range_noflush(addr, addr + size,
> > +				folio_pfn(folio) << PAGE_SHIFT,
> > +				PAGE_KERNEL, folio_shift(folio))) {
> > +		vm_unmap_ram(mem, folio_nr_pages(folio));
> > +		return NULL;
> > +	}
> > +	flush_cache_vmap(addr, addr + size);
> > +
> > +	mem = kasan_unpoison_vmalloc(mem, size, KASAN_VMALLOC_PROT_NORMAL);
> > +
> > +	return mem;
> > +}
> > +EXPORT_SYMBOL(vm_map_folio);
> > +#endif
> 
> it's a bit of copy & paste but yeah, it seems unavoidable at this point.
> 
Agree.

It is worth to rework the void *vm_map_folio(struct folio *folio) function.
All the rest looks reasonable.

--
Uladzislau Rezki
