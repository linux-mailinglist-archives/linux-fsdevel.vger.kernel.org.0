Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4058D2EC098
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 16:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbhAFPmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 10:42:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:55002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbhAFPmP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:42:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ECD4AAA35;
        Wed,  6 Jan 2021 15:41:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8FA231E0812; Wed,  6 Jan 2021 16:41:32 +0100 (CET)
Date:   Wed, 6 Jan 2021 16:41:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de,
        qi.fuli@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [PATCH 04/10] mm, fsdax: Refactor memory-failure handler for dax
 mapping
Message-ID: <20210106154132.GC29271@quack2.suse.cz>
References: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com>
 <20201230165601.845024-5-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230165601.845024-5-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 31-12-20 00:55:55, Shiyang Ruan wrote:
> The current memory_failure_dev_pagemap() can only handle single-mapped
> dax page for fsdax mode.  The dax page could be mapped by multiple files
> and offsets if we let reflink feature & fsdax mode work together.  So,
> we refactor current implementation to support handle memory failure on
> each file and offset.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>

Overall this looks OK to me, a few comments below.

> ---
>  fs/dax.c            | 21 +++++++++++
>  include/linux/dax.h |  1 +
>  include/linux/mm.h  |  9 +++++
>  mm/memory-failure.c | 91 ++++++++++++++++++++++++++++++++++-----------
>  4 files changed, 100 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 5b47834f2e1b..799210cfa687 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -378,6 +378,27 @@ static struct page *dax_busy_page(void *entry)
>  	return NULL;
>  }
>  
> +/*
> + * dax_load_pfn - Load pfn of the DAX entry corresponding to a page
> + * @mapping: The file whose entry we want to load
> + * @index:   The offset where the DAX entry located in
> + *
> + * Return:   pfn of the DAX entry
> + */
> +unsigned long dax_load_pfn(struct address_space *mapping, unsigned long index)
> +{
> +	XA_STATE(xas, &mapping->i_pages, index);
> +	void *entry;
> +	unsigned long pfn;
> +
> +	xas_lock_irq(&xas);
> +	entry = xas_load(&xas);
> +	pfn = dax_to_pfn(entry);
> +	xas_unlock_irq(&xas);
> +
> +	return pfn;
> +}
> +
>  /*
>   * dax_lock_mapping_entry - Lock the DAX entry corresponding to a page
>   * @page: The page whose entry we want to lock
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index b52f084aa643..89e56ceeffc7 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -150,6 +150,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
>  
>  struct page *dax_layout_busy_page(struct address_space *mapping);
>  struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
> +unsigned long dax_load_pfn(struct address_space *mapping, unsigned long index);
>  dax_entry_t dax_lock_page(struct page *page);
>  void dax_unlock_page(struct page *page, dax_entry_t cookie);
>  #else
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index db6ae4d3fb4e..db3059a1853e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1141,6 +1141,14 @@ static inline bool is_device_private_page(const struct page *page)
>  		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
>  }
>  
> +static inline bool is_device_fsdax_page(const struct page *page)
> +{
> +	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
> +		IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
> +		is_zone_device_page(page) &&
> +		page->pgmap->type == MEMORY_DEVICE_FS_DAX;
> +}
> +
>  static inline bool is_pci_p2pdma_page(const struct page *page)
>  {
>  	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
> @@ -3030,6 +3038,7 @@ enum mf_flags {
>  	MF_MUST_KILL = 1 << 2,
>  	MF_SOFT_OFFLINE = 1 << 3,
>  };
> +extern int mf_dax_mapping_kill_procs(struct address_space *mapping, pgoff_t index, int flags);
>  extern int memory_failure(unsigned long pfn, int flags);
>  extern void memory_failure_queue(unsigned long pfn, int flags);
>  extern void memory_failure_queue_kick(int cpu);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 5d880d4eb9a2..37bc6e2a9564 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -56,6 +56,7 @@
>  #include <linux/kfifo.h>
>  #include <linux/ratelimit.h>
>  #include <linux/page-isolation.h>
> +#include <linux/dax.h>
>  #include "internal.h"
>  #include "ras/ras_event.h"
>  
> @@ -120,6 +121,9 @@ static int hwpoison_filter_dev(struct page *p)
>  	if (PageSlab(p))
>  		return -EINVAL;
>  
> +	if (is_device_fsdax_page(p))
> +		return 0;
> +
>  	mapping = page_mapping(p);
>  	if (mapping == NULL || mapping->host == NULL)
>  		return -EINVAL;
> @@ -290,9 +294,8 @@ void shake_page(struct page *p, int access)
>  EXPORT_SYMBOL_GPL(shake_page);
>  
>  static unsigned long dev_pagemap_mapping_shift(struct page *page,
> -		struct vm_area_struct *vma)
> +		struct vm_area_struct *vma, unsigned long address)

The 'page' argument is now unused. Drop it?

>  {
> -	unsigned long address = vma_address(page, vma);
>  	pgd_t *pgd;
>  	p4d_t *p4d;
>  	pud_t *pud;
> @@ -333,8 +336,8 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
>   * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
>   */
>  static void add_to_kill(struct task_struct *tsk, struct page *p,
> -		       struct vm_area_struct *vma,
> -		       struct list_head *to_kill)
> +			struct address_space *mapping, pgoff_t pgoff,
> +			struct vm_area_struct *vma, struct list_head *to_kill)
>  {
>  	struct to_kill *tk;
>  
> @@ -345,9 +348,12 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>  	}
>  
>  	tk->addr = page_address_in_vma(p, vma);
> -	if (is_zone_device_page(p))
> -		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
> -	else
> +	if (is_zone_device_page(p)) {
> +		if (is_device_fsdax_page(p))
> +			tk->addr = vma->vm_start +
> +					((pgoff - vma->vm_pgoff) << PAGE_SHIFT);

It seems strange to use 'pgoff' for dax pages and not for any other page.
Why? I'd rather pass correct pgoff from all callers of add_to_kill() and
avoid this special casing...

> +		tk->size_shift = dev_pagemap_mapping_shift(p, vma, tk->addr);
> +	} else
>  		tk->size_shift = page_shift(compound_head(p));
>  
>  	/*
> @@ -495,7 +501,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
>  			if (!page_mapped_in_vma(page, vma))
>  				continue;
>  			if (vma->vm_mm == t->mm)
> -				add_to_kill(t, page, vma, to_kill);
> +				add_to_kill(t, page, NULL, 0, vma, to_kill);
>  		}
>  	}
>  	read_unlock(&tasklist_lock);
> @@ -505,24 +511,19 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
>  /*
>   * Collect processes when the error hit a file mapped page.
>   */
> -static void collect_procs_file(struct page *page, struct list_head *to_kill,
> -				int force_early)
> +static void collect_procs_file(struct page *page, struct address_space *mapping,
> +		pgoff_t pgoff, struct list_head *to_kill, int force_early)
>  {
>  	struct vm_area_struct *vma;
>  	struct task_struct *tsk;
> -	struct address_space *mapping = page->mapping;
> -	pgoff_t pgoff;
>  
>  	i_mmap_lock_read(mapping);
>  	read_lock(&tasklist_lock);
> -	pgoff = page_to_pgoff(page);
>  	for_each_process(tsk) {
>  		struct task_struct *t = task_early_kill(tsk, force_early);
> -
>  		if (!t)
>  			continue;
> -		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff,
> -				      pgoff) {
> +		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
>  			/*
>  			 * Send early kill signal to tasks where a vma covers
>  			 * the page but the corrupted page is not necessarily
> @@ -531,7 +532,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
>  			 * to be informed of all such data corruptions.
>  			 */
>  			if (vma->vm_mm == t->mm)
> -				add_to_kill(t, page, vma, to_kill);
> +				add_to_kill(t, page, mapping, pgoff, vma, to_kill);
>  		}
>  	}
>  	read_unlock(&tasklist_lock);
> @@ -550,7 +551,8 @@ static void collect_procs(struct page *page, struct list_head *tokill,
>  	if (PageAnon(page))
>  		collect_procs_anon(page, tokill, force_early);
>  	else
> -		collect_procs_file(page, tokill, force_early);
> +		collect_procs_file(page, page->mapping, page_to_pgoff(page),

Why not use page_mapping() helper here? It would be safer for THPs if they
ever get here...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
