Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 774468A6C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 21:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfHLTCa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 15:02:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:63529 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfHLTC3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:02:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 12:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="scan'208";a="194025844"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga001.fm.intel.com with ESMTP; 12 Aug 2019 12:01:58 -0700
Date:   Mon, 12 Aug 2019 12:01:58 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>, Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 11/19] mm/gup: Pass follow_page_context further
 down the call stack
Message-ID: <20190812190158.GA20634@iweiny-DESK2.sc.intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-12-ira.weiny@intel.com>
 <57000521-cc09-9c33-9fa4-1fae5a3972c2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57000521-cc09-9c33-9fa4-1fae5a3972c2@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 09, 2019 at 05:18:31PM -0700, John Hubbard wrote:
> On 8/9/19 3:58 PM, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > In preparation for passing more information (vaddr_pin) into
> > follow_page_pte(), follow_devmap_pud(), and follow_devmap_pmd().
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>

[snip]

> > @@ -786,7 +782,8 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
> >  static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
> >  		unsigned long start, unsigned long nr_pages,
> >  		unsigned int gup_flags, struct page **pages,
> > -		struct vm_area_struct **vmas, int *nonblocking)
> > +		struct vm_area_struct **vmas, int *nonblocking,
> > +		struct vaddr_pin *vaddr_pin)
> 
> I didn't expect to see more vaddr_pin arg passing, based on the commit
> description. Did you want this as part of patch 9 or 10 instead? If not,
> then let's mention it in the commit description.

Yea that does seem out of place now that I look at it.  I'll add to the commit
message because this is really getting vaddr_pin into the context _and_ passing
it down the stack.  With all the rebasing I may have squashed something I did
not mean to.  But I think this patch is ok because it is not to complicated to
see what is going on.

Thanks,
Ira

> 
> >  {
> >  	long ret = 0, i = 0;
> >  	struct vm_area_struct *vma = NULL;
> > @@ -797,6 +794,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
> >  
> >  	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
> >  
> > +	ctx.vaddr_pin = vaddr_pin;
> > +
> >  	/*
> >  	 * If FOLL_FORCE is set then do not force a full fault as the hinting
> >  	 * fault information is unrelated to the reference behaviour of a task
> > @@ -1025,7 +1024,7 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
> >  	lock_dropped = false;
> >  	for (;;) {
> >  		ret = __get_user_pages(tsk, mm, start, nr_pages, flags, pages,
> > -				       vmas, locked);
> > +				       vmas, locked, vaddr_pin);
> >  		if (!locked)
> >  			/* VM_FAULT_RETRY couldn't trigger, bypass */
> >  			return ret;
> > @@ -1068,7 +1067,7 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
> >  		lock_dropped = true;
> >  		down_read(&mm->mmap_sem);
> >  		ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
> > -				       pages, NULL, NULL);
> > +				       pages, NULL, NULL, vaddr_pin);
> >  		if (ret != 1) {
> >  			BUG_ON(ret > 1);
> >  			if (!pages_done)
> > @@ -1226,7 +1225,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
> >  	 * not result in a stack expansion that recurses back here.
> >  	 */
> >  	return __get_user_pages(current, mm, start, nr_pages, gup_flags,
> > -				NULL, NULL, nonblocking);
> > +				NULL, NULL, nonblocking, NULL);
> >  }
> >  
> >  /*
> > @@ -1311,7 +1310,7 @@ struct page *get_dump_page(unsigned long addr)
> >  
> >  	if (__get_user_pages(current, current->mm, addr, 1,
> >  			     FOLL_FORCE | FOLL_DUMP | FOLL_GET, &page, &vma,
> > -			     NULL) < 1)
> > +			     NULL, NULL) < 1)
> >  		return NULL;
> >  	flush_cache_page(vma, addr, page_to_pfn(page));
> >  	return page;
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index bc1a07a55be1..7e09f2f17ed8 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -916,8 +916,9 @@ static void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
> >  }
> >  
> >  struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
> > -		pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
> > +		pmd_t *pmd, int flags, struct follow_page_context *ctx)
> >  {
> > +	struct dev_pagemap **pgmap = &ctx->pgmap;
> >  	unsigned long pfn = pmd_pfn(*pmd);
> >  	struct mm_struct *mm = vma->vm_mm;
> >  	struct page *page;
> > @@ -1068,8 +1069,9 @@ static void touch_pud(struct vm_area_struct *vma, unsigned long addr,
> >  }
> >  
> >  struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
> > -		pud_t *pud, int flags, struct dev_pagemap **pgmap)
> > +		pud_t *pud, int flags, struct follow_page_context *ctx)
> >  {
> > +	struct dev_pagemap **pgmap = &ctx->pgmap;
> >  	unsigned long pfn = pud_pfn(*pud);
> >  	struct mm_struct *mm = vma->vm_mm;
> >  	struct page *page;
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 0d5f720c75ab..46ada5279856 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -12,6 +12,34 @@
> >  #include <linux/pagemap.h>
> >  #include <linux/tracepoint-defs.h>
> >  
> > +struct follow_page_context {
> > +	struct dev_pagemap *pgmap;
> > +	unsigned int page_mask;
> > +	struct vaddr_pin *vaddr_pin;
> > +};
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
> > +		pmd_t *pmd, int flags, struct follow_page_context *ctx);
> > +struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
> > +		pud_t *pud, int flags, struct follow_page_context *ctx);
> > +#else
> > +static inline struct page *follow_devmap_pmd(struct vm_area_struct *vma,
> > +	unsigned long addr, pmd_t *pmd, int flags,
> > +	struct follow_page_context *ctx)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static inline struct page *follow_devmap_pud(struct vm_area_struct *vma,
> > +	unsigned long addr, pud_t *pud, int flags,
> > +	struct follow_page_context *ctx)
> > +{
> > +	return NULL;
> > +}
> > +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > +
> > +
> >  /*
> >   * The set of flags that only affect watermark checking and reclaim
> >   * behaviour. This is used by the MM to obey the caller constraints
> > 
> 
> 
> 
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
