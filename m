Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BA842E20C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 21:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhJNTer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 15:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhJNTeq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:34:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79D2860EFF;
        Thu, 14 Oct 2021 19:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634239961;
        bh=rxi08ohLQ8FMRrydTQRximJyIVu+hc0/kt8nU4Fzuk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xu215UGyrAM2S57vEgW97n9nsfiNTBDoEl629EN6fyRULDDoc9kPGDHhrnYssM99h
         ZpZHHh9d1Tu9LVQmXfjfrcxAcJmB1ogLPFVtH9FQNyytpZ4N5qhQHQSp9JiTX5kgN6
         xM7ByubqqqGgLXoSNaLCfhrX9FTuAkGXQxHfOGoqjamr5kIaUcD5pruilVkyDhMgZN
         Z1JQIh+JfnqSdHuE1XKVKnz4j7aE/GcN+oXCg/7z5TEuSgCPXmBm8AKCC/N0q064JY
         xSqqV++YgMBWsyqECUTtmGvZMDgcpAgDPH3bz/QTbwZ7kTjjAp0ZXLBgG05eXLcgO0
         +YACOfIkQbM5Q==
Date:   Thu, 14 Oct 2021 12:32:41 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [PATCH v7 6/8] mm: Introduce mf_dax_kill_procs() for fsdax case
Message-ID: <20211014193241.GK24307@magnolia>
References: <20210924130959.2695749-1-ruansy.fnst@fujitsu.com>
 <20210924130959.2695749-7-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924130959.2695749-7-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 09:09:57PM +0800, Shiyang Ruan wrote:
> This function is called at the end of RMAP routine, i.e. filesystem
> recovery function, to collect and kill processes using a shared page of
> DAX file.  The difference between mf_generic_kill_procs() is,
> it accepts file's mapping,offset instead of struct page.  Because
> different file's mappings and offsets may share the same page in fsdax
> mode.  So, it is called when filesystem RMAP results are found.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c            | 10 ------
>  include/linux/dax.h |  9 +++++
>  include/linux/mm.h  |  2 ++
>  mm/memory-failure.c | 83 ++++++++++++++++++++++++++++++++++++++++-----
>  4 files changed, 86 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 509b65e60478..2536c105ec7f 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -852,16 +852,6 @@ static void *dax_insert_entry(struct xa_state *xas,
>  	return entry;
>  }
>  
> -static inline
> -unsigned long pgoff_address(pgoff_t pgoff, struct vm_area_struct *vma)
> -{
> -	unsigned long address;
> -
> -	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> -	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
> -	return address;
> -}
> -
>  /* Walk all mappings of a given index of a file and writeprotect them */
>  static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
>  		unsigned long pfn)
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 65411bee4312..3d90becbd160 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -258,6 +258,15 @@ static inline bool dax_mapping(struct address_space *mapping)
>  {
>  	return mapping->host && IS_DAX(mapping->host);
>  }
> +static inline unsigned long pgoff_address(pgoff_t pgoff,
> +		struct vm_area_struct *vma)
> +{
> +	unsigned long address;
> +
> +	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> +	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
> +	return address;
> +}
>  
>  #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
>  void hmem_register_device(int target_nid, struct resource *r);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 73a52aba448f..d06af0051e53 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3114,6 +3114,8 @@ enum mf_flags {
>  	MF_MUST_KILL = 1 << 2,
>  	MF_SOFT_OFFLINE = 1 << 3,
>  };
> +extern int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
> +			     size_t size, int flags);
>  extern int memory_failure(unsigned long pfn, int flags);
>  extern void memory_failure_queue(unsigned long pfn, int flags);
>  extern void memory_failure_queue_kick(int cpu);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 85eab206b68f..a9d0d487d205 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -302,10 +302,9 @@ void shake_page(struct page *p)
>  }
>  EXPORT_SYMBOL_GPL(shake_page);
>  
> -static unsigned long dev_pagemap_mapping_shift(struct page *page,
> +static unsigned long dev_pagemap_mapping_shift(unsigned long address,
>  		struct vm_area_struct *vma)
>  {
> -	unsigned long address = vma_address(page, vma);
>  	pgd_t *pgd;
>  	p4d_t *p4d;
>  	pud_t *pud;
> @@ -345,7 +344,7 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
>   * Schedule a process for later kill.
>   * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
>   */
> -static void add_to_kill(struct task_struct *tsk, struct page *p,
> +static void add_to_kill(struct task_struct *tsk, struct page *p, pgoff_t pgoff,

Hm, so I guess you're passing the page and the pgoff now because
page->index is meaningless for shared dax pages?  Ok.

>  		       struct vm_area_struct *vma,
>  		       struct list_head *to_kill)
>  {
> @@ -358,9 +357,15 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>  	}
>  
>  	tk->addr = page_address_in_vma(p, vma);
> -	if (is_zone_device_page(p))
> -		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
> -	else
> +	if (is_zone_device_page(p)) {
> +		/*
> +		 * Since page->mapping is no more used for fsdax, we should
> +		 * calculate the address in a fsdax way.
> +		 */
> +		if (p->pgmap->type == MEMORY_DEVICE_FS_DAX)
> +			tk->addr = pgoff_address(pgoff, vma);
> +		tk->size_shift = dev_pagemap_mapping_shift(tk->addr, vma);
> +	} else
>  		tk->size_shift = page_shift(compound_head(p));
>  
>  	/*
> @@ -508,7 +513,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
>  			if (!page_mapped_in_vma(page, vma))
>  				continue;
>  			if (vma->vm_mm == t->mm)
> -				add_to_kill(t, page, vma, to_kill);
> +				add_to_kill(t, page, 0, vma, to_kill);
>  		}
>  	}
>  	read_unlock(&tasklist_lock);
> @@ -544,7 +549,32 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
>  			 * to be informed of all such data corruptions.
>  			 */
>  			if (vma->vm_mm == t->mm)
> -				add_to_kill(t, page, vma, to_kill);
> +				add_to_kill(t, page, 0, vma, to_kill);
> +		}
> +	}
> +	read_unlock(&tasklist_lock);
> +	i_mmap_unlock_read(mapping);
> +}
> +
> +/*
> + * Collect processes when the error hit a fsdax page.
> + */
> +static void collect_procs_fsdax(struct page *page, struct address_space *mapping,
> +		pgoff_t pgoff, struct list_head *to_kill)
> +{
> +	struct vm_area_struct *vma;
> +	struct task_struct *tsk;
> +
> +	i_mmap_lock_read(mapping);
> +	read_lock(&tasklist_lock);
> +	for_each_process(tsk) {
> +		struct task_struct *t = task_early_kill(tsk, true);
> +
> +		if (!t)
> +			continue;
> +		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
> +			if (vma->vm_mm == t->mm)
> +				add_to_kill(t, page, pgoff, vma, to_kill);
>  		}
>  	}
>  	read_unlock(&tasklist_lock);
> @@ -1503,6 +1533,43 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags,
>  	return 0;
>  }
>  
> +/**
> + * mf_dax_kill_procs - Collect and kill processes who are using this file range
> + * @mapping:	the file in use
> + * @index:	start offset of the range
> + * @size:	length of the range

It feels odd that one argument is in units of pgoff_t but the other is
in bytes.

> + * @flags:	memory failure flags
> + */
> +int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
> +		size_t size, int flags)
> +{
> +	LIST_HEAD(to_kill);
> +	dax_entry_t cookie;
> +	struct page *page;
> +	size_t end = (index << PAGE_SHIFT) + size;
> +
> +	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;

Hm.  What flags will we be passing to the xfs_dax_notify_failure_fn?
Does XFS itself have to care about what's in the flags values, or is it
really just a magic cookie to be passed from the mm layer into the fs
and back to mf_dax_kill_procs?

--D

> +
> +	for (; (index << PAGE_SHIFT) < end; index++) {
> +		page = NULL;
> +		cookie = dax_lock_mapping_entry(mapping, index, &page);
> +		if (!cookie)
> +			return -EBUSY;
> +		if (!page)
> +			goto unlock;
> +
> +		SetPageHWPoison(page);
> +
> +		collect_procs_fsdax(page, mapping, index, &to_kill);
> +		unmap_and_kill(&to_kill, page_to_pfn(page), mapping,
> +				index, flags);
> +unlock:
> +		dax_unlock_mapping_entry(mapping, index, cookie);
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
> +
>  static int memory_failure_hugetlb(unsigned long pfn, int flags)
>  {
>  	struct page *p = pfn_to_page(pfn);
> -- 
> 2.33.0
> 
> 
> 
