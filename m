Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5ABA33CC0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 04:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhCPDWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 23:22:10 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:59263 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbhCPDVr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:21:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=zhongjiang-ali@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0US4IWG9_1615864901;
Received: from L-X1DSLVDL-1420.local(mailfrom:zhongjiang-ali@linux.alibaba.com fp:SMTPD_---0US4IWG9_1615864901)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Mar 2021 11:21:42 +0800
Message-ID: <e1be1767-f9c0-e17a-5c14-22bb2f0ca5aa@linux.alibaba.com>
Date:   Tue, 16 Mar 2021 11:21:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:87.0)
 Gecko/20100101 Thunderbird/87.0
Subject: Re: [PATCH v3 05/11] mm, fsdax: Refactor memory-failure handler for
 dax mapping
Content-Language: en-US
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com
Cc:     darrick.wong@oracle.com, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, agk@redhat.com,
        snitzer@redhat.com, rgoldwyn@suse.de, qi.fuli@fujitsu.com,
        y-goto@fujitsu.com
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-6-ruansy.fnst@cn.fujitsu.com>
From:   zhong jiang <zhongjiang-ali@linux.alibaba.com>
In-Reply-To: <20210208105530.3072869-6-ruansy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2021/2/8 6:55 下午, Shiyang Ruan wrote:
> The current memory_failure_dev_pagemap() can only handle single-mapped
> dax page for fsdax mode.  The dax page could be mapped by multiple files
> and offsets if we let reflink feature & fsdax mode work together.  So,
> we refactor current implementation to support handle memory failure on
> each file and offset.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>   fs/dax.c            | 21 ++++++++++
>   include/linux/dax.h |  1 +
>   include/linux/mm.h  |  9 +++++
>   mm/memory-failure.c | 98 ++++++++++++++++++++++++++++++++++-----------
>   4 files changed, 105 insertions(+), 24 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 26d5dcd2d69e..c64c3a0e76a6 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -378,6 +378,27 @@ static struct page *dax_busy_page(void *entry)
>   	return NULL;
>   }
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
>   /*
>    * dax_lock_mapping_entry - Lock the DAX entry corresponding to a page
>    * @page: The page whose entry we want to lock
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index b52f084aa643..89e56ceeffc7 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -150,6 +150,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
>   
>   struct page *dax_layout_busy_page(struct address_space *mapping);
>   struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
> +unsigned long dax_load_pfn(struct address_space *mapping, unsigned long index);
>   dax_entry_t dax_lock_page(struct page *page);
>   void dax_unlock_page(struct page *page, dax_entry_t cookie);
>   #else
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ecdf8a8cd6ae..ab52bc633d84 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1157,6 +1157,14 @@ static inline bool is_device_private_page(const struct page *page)
>   		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
>   }
>   
> +static inline bool is_device_fsdax_page(const struct page *page)
> +{
> +	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
> +		IS_ENABLED(CONFIG_FS_DAX) &&
> +		is_zone_device_page(page) &&
> +		page->pgmap->type == MEMORY_DEVICE_FS_DAX;
> +}
> +
>   static inline bool is_pci_p2pdma_page(const struct page *page)
>   {
>   	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
> @@ -3045,6 +3053,7 @@ enum mf_flags {
>   	MF_MUST_KILL = 1 << 2,
>   	MF_SOFT_OFFLINE = 1 << 3,
>   };
> +extern int mf_dax_mapping_kill_procs(struct address_space *mapping, pgoff_t index, int flags);
>   extern int memory_failure(unsigned long pfn, int flags);
>   extern void memory_failure_queue(unsigned long pfn, int flags);
>   extern void memory_failure_queue_kick(int cpu);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index e9481632fcd1..158fe0c8e602 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -56,6 +56,7 @@
>   #include <linux/kfifo.h>
>   #include <linux/ratelimit.h>
>   #include <linux/page-isolation.h>
> +#include <linux/dax.h>
>   #include "internal.h"
>   #include "ras/ras_event.h"
>   
> @@ -120,6 +121,13 @@ static int hwpoison_filter_dev(struct page *p)
>   	if (PageSlab(p))
>   		return -EINVAL;
>   
> +	if (pfn_valid(page_to_pfn(p))) {
> +		if (is_device_fsdax_page(p))
> +			return 0;
> +		else
> +			return -EINVAL;
> +	}
> +
>   	mapping = page_mapping(p);
>   	if (mapping == NULL || mapping->host == NULL)
>   		return -EINVAL;
> @@ -286,10 +294,9 @@ void shake_page(struct page *p, int access)
>   }
>   EXPORT_SYMBOL_GPL(shake_page);
>   
> -static unsigned long dev_pagemap_mapping_shift(struct page *page,
> -		struct vm_area_struct *vma)
> +static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
> +					       unsigned long address)
>   {
> -	unsigned long address = vma_address(page, vma);
>   	pgd_t *pgd;
>   	p4d_t *p4d;
>   	pud_t *pud;
> @@ -329,9 +336,8 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
>    * Schedule a process for later kill.
>    * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
>    */
> -static void add_to_kill(struct task_struct *tsk, struct page *p,
> -		       struct vm_area_struct *vma,
> -		       struct list_head *to_kill)
> +static void add_to_kill(struct task_struct *tsk, struct page *p, pgoff_t pgoff,
> +			struct vm_area_struct *vma, struct list_head *to_kill)
>   {
>   	struct to_kill *tk;
>   
> @@ -342,9 +348,12 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>   	}
>   
>   	tk->addr = page_address_in_vma(p, vma);
> -	if (is_zone_device_page(p))
> -		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
> -	else
> +	if (is_zone_device_page(p)) {
> +		if (is_device_fsdax_page(p))
> +			tk->addr = vma->vm_start +
> +					((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> +		tk->size_shift = dev_pagemap_mapping_shift(vma, tk->addr);
> +	} else
>   		tk->size_shift = page_shift(compound_head(p));
>   
>   	/*
> @@ -492,7 +501,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
>   			if (!page_mapped_in_vma(page, vma))
>   				continue;
>   			if (vma->vm_mm == t->mm)
> -				add_to_kill(t, page, vma, to_kill);
> +				add_to_kill(t, page, 0, vma, to_kill);
>   		}
>   	}
>   	read_unlock(&tasklist_lock);
> @@ -502,24 +511,19 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
>   /*
>    * Collect processes when the error hit a file mapped page.
>    */
> -static void collect_procs_file(struct page *page, struct list_head *to_kill,
> -				int force_early)
> +static void collect_procs_file(struct page *page, struct address_space *mapping,
> +		pgoff_t pgoff, struct list_head *to_kill, int force_early)
>   {
>   	struct vm_area_struct *vma;
>   	struct task_struct *tsk;
> -	struct address_space *mapping = page->mapping;
> -	pgoff_t pgoff;
>   
>   	i_mmap_lock_read(mapping);
>   	read_lock(&tasklist_lock);
> -	pgoff = page_to_pgoff(page);
>   	for_each_process(tsk) {
>   		struct task_struct *t = task_early_kill(tsk, force_early);
> -
>   		if (!t)
>   			continue;
> -		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff,
> -				      pgoff) {
> +		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
>   			/*
>   			 * Send early kill signal to tasks where a vma covers
>   			 * the page but the corrupted page is not necessarily
> @@ -528,7 +532,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
>   			 * to be informed of all such data corruptions.
>   			 */
>   			if (vma->vm_mm == t->mm)
> -				add_to_kill(t, page, vma, to_kill);
> +				add_to_kill(t, page, pgoff, vma, to_kill);
>   		}
>   	}
>   	read_unlock(&tasklist_lock);
> @@ -547,7 +551,8 @@ static void collect_procs(struct page *page, struct list_head *tokill,
>   	if (PageAnon(page))
>   		collect_procs_anon(page, tokill, force_early);
>   	else
> -		collect_procs_file(page, tokill, force_early);
> +		collect_procs_file(page, page_mapping(page), page_to_pgoff(page),
> +				   tokill, force_early);
>   }
>   
>   static const char *action_name[] = {
> @@ -1214,6 +1219,50 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
>   	return 0;
>   }
>   
> +int mf_dax_mapping_kill_procs(struct address_space *mapping, pgoff_t index, int flags)
> +{
> +	const bool unmap_success = true;
> +	unsigned long pfn, size = 0;
> +	struct to_kill *tk;
> +	LIST_HEAD(to_kill);
> +	int rc = -EBUSY;
> +	loff_t start;
> +
> +	/* load the pfn of the dax mapping file */
> +	pfn = dax_load_pfn(mapping, index);
> +	if (!pfn)
> +		return rc;
> +	/*
> +	 * Unlike System-RAM there is no possibility to swap in a
> +	 * different physical page at a given virtual address, so all
> +	 * userspace consumption of ZONE_DEVICE memory necessitates
> +	 * SIGBUS (i.e. MF_MUST_KILL)
> +	 */
> +	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;

MF_ACTION_REQUIRED only kill the current execution context. A page can be shared
when reflink file be mapped by different process. We can not kill all process
shared the page.  Other process still can access the posioned page ?

Thanks,
zhong jiang

> +	collect_procs_file(pfn_to_page(pfn), mapping, index, &to_kill,
> +			   flags & MF_ACTION_REQUIRED);
> +
> +	list_for_each_entry(tk, &to_kill, nd)
> +		if (tk->size_shift)
> +			size = max(size, 1UL << tk->size_shift);
> +	if (size) {
> +		/*
> +		 * Unmap the largest mapping to avoid breaking up
> +		 * device-dax mappings which are constant size. The
> +		 * actual size of the mapping being torn down is
> +		 * communicated in siginfo, see kill_proc()
> +		 */
> +		start = (index << PAGE_SHIFT) & ~(size - 1);
> +		unmap_mapping_range(mapping, start, start + size, 0);
> +	}
> +
> +	kill_procs(&to_kill, flags & MF_MUST_KILL, !unmap_success,
> +		   pfn, flags);
> +	rc = 0;
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(mf_dax_mapping_kill_procs);
> +
>   static int memory_failure_hugetlb(unsigned long pfn, int flags)
>   {
>   	struct page *p = pfn_to_page(pfn);
> @@ -1297,7 +1346,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>   	const bool unmap_success = true;
>   	unsigned long size = 0;
>   	struct to_kill *tk;
> -	LIST_HEAD(tokill);
> +	LIST_HEAD(to_kill);
>   	int rc = -EBUSY;
>   	loff_t start;
>   	dax_entry_t cookie;
> @@ -1345,9 +1394,10 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>   	 * SIGBUS (i.e. MF_MUST_KILL)
>   	 */
>   	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
> -	collect_procs(page, &tokill, flags & MF_ACTION_REQUIRED);
> +	collect_procs_file(page, page->mapping, page->index, &to_kill,
> +			   flags & MF_ACTION_REQUIRED);
>   
> -	list_for_each_entry(tk, &tokill, nd)
> +	list_for_each_entry(tk, &to_kill, nd)
>   		if (tk->size_shift)
>   			size = max(size, 1UL << tk->size_shift);
>   	if (size) {
> @@ -1360,7 +1410,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>   		start = (page->index << PAGE_SHIFT) & ~(size - 1);
>   		unmap_mapping_range(page->mapping, start, start + size, 0);
>   	}
> -	kill_procs(&tokill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
> +	kill_procs(&to_kill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
>   	rc = 0;
>   unlock:
>   	dax_unlock_page(page, cookie);
