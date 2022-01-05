Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BAC4858DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 20:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbiAETGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 14:06:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60600 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243317AbiAETGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:06:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2C65617E8;
        Wed,  5 Jan 2022 19:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047E5C36AE9;
        Wed,  5 Jan 2022 19:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641409568;
        bh=ztzxbkalbIPb30j4PLPt7jHsX6mRQuIWYMcP+uqwvmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aT67lFvl11sy9BIgecg0Kz380qFY+pYepVbhAUFLy7PEyjgor69LxPqBjXdayt/e/
         C0gyhb1wUPKgvkGTVI4wlxWQ0xGjkDpywELvRhkB9DFbL8AOD4IICNKTEu1t9Cq/dT
         m8vT7XHura2XbBcDoUeGm6pvUmST7COe5ziWW0RnfHuNGIRbMOrk0+o7K/MKqYi5k+
         22E5+yGJKj77XTFMfTMA6KXaHbTRZ1YGXU4K5SCFMpjrxKpDBpYPHgmv+19P2gFdtu
         vulXlgXM+O8G3YKkvsmeb/0lfNLRVJ8+MDt7tJIy4BSQc+OQ4AFZzM8/scBXZC8Rgc
         Zj01m1diKnDig==
Date:   Wed, 5 Jan 2022 11:06:07 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v9 04/10] pagemap,pmem: Introduce ->memory_failure()
Message-ID: <20220105190607.GF398655@magnolia>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-5-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226143439.3985960-5-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 26, 2021 at 10:34:33PM +0800, Shiyang Ruan wrote:
> When memory-failure occurs, we call this function which is implemented
> by each kind of devices.  For the fsdax case, pmem device driver
> implements it.  Pmem device driver will find out the filesystem in which
> the corrupted page located in.
> 
> With dax_holder notify support, we are able to notify the memory failure
> from pmem driver to upper layers.  If there is something not support in
> the notify routine, memory_failure will fall back to the generic hanlder.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvdimm/pmem.c    | 16 ++++++++++++++++
>  include/linux/memremap.h |  9 +++++++++
>  mm/memory-failure.c      | 14 ++++++++++++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 4190c8c46ca8..2114554358eb 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -386,6 +386,20 @@ static void pmem_release_disk(void *__pmem)
>  	blk_cleanup_disk(pmem->disk);
>  }
>  
> +static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
> +		unsigned long pfn, u64 len, int mf_flags)
> +{
> +	struct pmem_device *pmem =
> +			container_of(pgmap, struct pmem_device, pgmap);
> +	loff_t offset = PFN_PHYS(pfn) - pmem->phys_addr - pmem->data_offset;

Use u64 here ^^^ because this isn't a file offset, this is a physical
offset.  Also, loff_t is signed, which you probably don't want.

> +
> +	return dax_holder_notify_failure(pmem->dax_dev, offset, len, mf_flags);
> +}
> +
> +static const struct dev_pagemap_ops fsdax_pagemap_ops = {
> +	.memory_failure		= pmem_pagemap_memory_failure,
> +};
> +
>  static int pmem_attach_disk(struct device *dev,
>  		struct nd_namespace_common *ndns)
>  {
> @@ -448,6 +462,7 @@ static int pmem_attach_disk(struct device *dev,
>  	pmem->pfn_flags = PFN_DEV;
>  	if (is_nd_pfn(dev)) {
>  		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
> +		pmem->pgmap.ops = &fsdax_pagemap_ops;
>  		addr = devm_memremap_pages(dev, &pmem->pgmap);
>  		pfn_sb = nd_pfn->pfn_sb;
>  		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
> @@ -461,6 +476,7 @@ static int pmem_attach_disk(struct device *dev,
>  		pmem->pgmap.range.end = res->end;
>  		pmem->pgmap.nr_range = 1;
>  		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
> +		pmem->pgmap.ops = &fsdax_pagemap_ops;
>  		addr = devm_memremap_pages(dev, &pmem->pgmap);
>  		pmem->pfn_flags |= PFN_MAP;
>  		bb_range = pmem->pgmap.range;
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index c0e9d35889e8..820c2f33b163 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -87,6 +87,15 @@ struct dev_pagemap_ops {
>  	 * the page back to a CPU accessible page.
>  	 */
>  	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
> +
> +	/*
> +	 * Handle the memory failure happens on a range of pfns.  Notify the
> +	 * processes who are using these pfns, and try to recover the data on
> +	 * them if necessary.  The mf_flags is finally passed to the recover
> +	 * function through the whole notify routine.


Might want to state here that the generic implementation will be used if
->memory_failure is NULL or calling the function returns -EOPNOTSUPP.

--D

> +	 */
> +	int (*memory_failure)(struct dev_pagemap *pgmap, unsigned long pfn,
> +			      u64 len, int mf_flags);
>  };
>  
>  #define PGMAP_ALTMAP_VALID	(1 << 0)
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 1ee7d626fed7..3cc612b29f89 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1625,6 +1625,20 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  	if (!pgmap_pfn_valid(pgmap, pfn))
>  		goto out;
>  
> +	/*
> +	 * Call driver's implementation to handle the memory failure, otherwise
> +	 * fall back to generic handler.
> +	 */
> +	if (pgmap->ops->memory_failure) {
> +		rc = pgmap->ops->memory_failure(pgmap, pfn, PAGE_SIZE, flags);
> +		/*
> +		 * Fall back to generic handler too if operation is not
> +		 * supported inside the driver/device/filesystem.
> +		 */
> +		if (rc != -EOPNOTSUPP)
> +			goto out;
> +	}
> +
>  	rc = mf_generic_kill_procs(pfn, flags, pgmap);
>  out:
>  	/* drop pgmap ref acquired in caller */
> -- 
> 2.34.1
> 
> 
> 
