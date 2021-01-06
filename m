Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3802EC0B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 16:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbhAFP4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 10:56:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:34760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbhAFP4P (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:56:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73352AA35;
        Wed,  6 Jan 2021 15:55:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DAFDD1E0812; Wed,  6 Jan 2021 16:55:32 +0100 (CET)
Date:   Wed, 6 Jan 2021 16:55:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de,
        qi.fuli@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [PATCH 05/10] mm, pmem: Implement ->memory_failure() in pmem
 driver
Message-ID: <20210106155532.GD29271@quack2.suse.cz>
References: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com>
 <20201230165601.845024-6-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230165601.845024-6-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 31-12-20 00:55:56, Shiyang Ruan wrote:
> Call the ->memory_failure() which is implemented by pmem driver, in
> order to finally notify filesystem to handle the corrupted data.  The
> old collecting and killing processes are moved into
> mf_dax_mapping_kill_procs(), which will be called by filesystem.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>

I understand the intent but this patch breaks DAX hwpoison handling for
everybody at this point in the series (nobody implements ->memory_failure()
handler yet) so it is bisection unfriendly. This should really be the last
step in the series once all the other infrastructure is implemented.
Furthermore AFAIU it breaks DAX hwpoison handling terminally for all
filesystems which don't implement ->corrupted_range() - e.g. for ext4.
Your series needs to implement ->corrupted_range() for all filesystems
supporting DAX so that we don't regress current functionality...

								Honza

> ---
>  drivers/nvdimm/pmem.c | 24 +++++++++++++++++++++
>  mm/memory-failure.c   | 50 +++++--------------------------------------
>  2 files changed, 29 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 875076b0ea6c..4a114937c43b 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -363,9 +363,33 @@ static void pmem_release_disk(void *__pmem)
>  	put_disk(pmem->disk);
>  }
>  
> +static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
> +		unsigned long pfn, int flags)
> +{
> +	struct pmem_device *pdev;
> +	struct gendisk *disk;
> +	loff_t disk_offset;
> +	int rc = 0;
> +	unsigned long size = page_size(pfn_to_page(pfn));
> +
> +	pdev = container_of(pgmap, struct pmem_device, pgmap);
> +	disk = pdev->disk;
> +	if (!disk)
> +		return -ENXIO;
> +
> +	disk_offset = PFN_PHYS(pfn) - pdev->phys_addr - pdev->data_offset;
> +	if (disk->fops->corrupted_range) {
> +		rc = disk->fops->corrupted_range(disk, NULL, disk_offset, size, &flags);
> +		if (rc == -ENODEV)
> +			rc = -ENXIO;
> +	}
> +	return rc;
> +}
> +
>  static const struct dev_pagemap_ops fsdax_pagemap_ops = {
>  	.kill			= pmem_pagemap_kill,
>  	.cleanup		= pmem_pagemap_cleanup,
> +	.memory_failure		= pmem_pagemap_memory_failure,
>  };
>  
>  static int pmem_attach_disk(struct device *dev,
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 37bc6e2a9564..0109ad607fb8 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1269,28 +1269,11 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  		struct dev_pagemap *pgmap)
>  {
>  	struct page *page = pfn_to_page(pfn);
> -	const bool unmap_success = true;
> -	unsigned long size = 0;
> -	struct to_kill *tk;
> -	LIST_HEAD(to_kill);
>  	int rc = -EBUSY;
> -	loff_t start;
> -	dax_entry_t cookie;
> -
> -	/*
> -	 * Prevent the inode from being freed while we are interrogating
> -	 * the address_space, typically this would be handled by
> -	 * lock_page(), but dax pages do not use the page lock. This
> -	 * also prevents changes to the mapping of this pfn until
> -	 * poison signaling is complete.
> -	 */
> -	cookie = dax_lock_page(page);
> -	if (!cookie)
> -		goto out;
>  
>  	if (hwpoison_filter(page)) {
>  		rc = 0;
> -		goto unlock;
> +		goto out;
>  	}
>  
>  	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
> @@ -1298,7 +1281,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  		 * TODO: Handle HMM pages which may need coordination
>  		 * with device-side memory.
>  		 */
> -		goto unlock;
> +		goto out;
>  	}
>  
>  	/*
> @@ -1307,33 +1290,10 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  	 */
>  	SetPageHWPoison(page);
>  
> -	/*
> -	 * Unlike System-RAM there is no possibility to swap in a
> -	 * different physical page at a given virtual address, so all
> -	 * userspace consumption of ZONE_DEVICE memory necessitates
> -	 * SIGBUS (i.e. MF_MUST_KILL)
> -	 */
> -	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
> -	collect_procs_file(page, page->mapping, page->index, &to_kill,
> -			   flags & MF_ACTION_REQUIRED);
> +	/* call driver to handle the memory failure */
> +	if (pgmap->ops->memory_failure)
> +		rc = pgmap->ops->memory_failure(pgmap, pfn, flags);
>  
> -	list_for_each_entry(tk, &to_kill, nd)
> -		if (tk->size_shift)
> -			size = max(size, 1UL << tk->size_shift);
> -	if (size) {
> -		/*
> -		 * Unmap the largest mapping to avoid breaking up
> -		 * device-dax mappings which are constant size. The
> -		 * actual size of the mapping being torn down is
> -		 * communicated in siginfo, see kill_proc()
> -		 */
> -		start = (page->index << PAGE_SHIFT) & ~(size - 1);
> -		unmap_mapping_range(page->mapping, start, start + size, 0);
> -	}
> -	kill_procs(&to_kill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
> -	rc = 0;
> -unlock:
> -	dax_unlock_page(page, cookie);
>  out:
>  	/* drop pgmap ref acquired in caller */
>  	put_dev_pagemap(pgmap);
> -- 
> 2.29.2
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
