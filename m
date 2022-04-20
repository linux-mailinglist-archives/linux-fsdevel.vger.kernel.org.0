Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8F4508EC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 19:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381284AbiDTRsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 13:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380246AbiDTRss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:48:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7EC45AFD;
        Wed, 20 Apr 2022 10:46:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13B86B81EB6;
        Wed, 20 Apr 2022 17:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AFEC385A4;
        Wed, 20 Apr 2022 17:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650476758;
        bh=0IQpL7Wg9Mq/y7A3UKLbFuWQ6Lpmm0AsHYlcuGIKTnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hEaP/ZkMcPr/FLQVEXXLW8MN/yKztzZ2AiYNM2IuCxtEIh8aE8FNZ3D9GQWtp/fA5
         TtPGbmrGpjXaEQj0HRw62q8BxcaSVulsv02HdrUX47CkSufe2JmP4puPGvcpiaDQwP
         iMFChnjCgtnkZ2AGt8bfRw3xmml/dgWEwCZBtyAOGdGgFUi5IaUOVDcaSXI/IvXF3a
         k6pru5d2tI/zkEtjYUUr8OlID89SP74vaiAa/NntqvUSEHEoPl0WlWacSMoDKR5Rmn
         ukYkeuSrNQOulKMe49AKTTml9kUo6clqFab7LYnDX/AmShAKXwh50aNPa3zhWS91LD
         0A1CuoZzkbMVA==
Date:   Wed, 20 Apr 2022 10:45:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v13 3/7] pagemap,pmem: Introduce ->memory_failure()
Message-ID: <20220420174558.GW17025@magnolia>
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
 <20220419045045.1664996-4-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419045045.1664996-4-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 12:50:41PM +0800, Shiyang Ruan wrote:
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
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Looks good to me now that we've ironed out the earlier unit questions,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  drivers/nvdimm/pmem.c    | 17 +++++++++++++++++
>  include/linux/memremap.h | 12 ++++++++++++
>  mm/memory-failure.c      | 14 ++++++++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 58d95242a836..bd502957cfdf 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -366,6 +366,21 @@ static void pmem_release_disk(void *__pmem)
>  	blk_cleanup_disk(pmem->disk);
>  }
>  
> +static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
> +		unsigned long pfn, unsigned long nr_pages, int mf_flags)
> +{
> +	struct pmem_device *pmem =
> +			container_of(pgmap, struct pmem_device, pgmap);
> +	u64 offset = PFN_PHYS(pfn) - pmem->phys_addr - pmem->data_offset;
> +	u64 len = nr_pages << PAGE_SHIFT;
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
> @@ -427,6 +442,7 @@ static int pmem_attach_disk(struct device *dev,
>  	pmem->pfn_flags = PFN_DEV;
>  	if (is_nd_pfn(dev)) {
>  		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
> +		pmem->pgmap.ops = &fsdax_pagemap_ops;
>  		addr = devm_memremap_pages(dev, &pmem->pgmap);
>  		pfn_sb = nd_pfn->pfn_sb;
>  		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
> @@ -440,6 +456,7 @@ static int pmem_attach_disk(struct device *dev,
>  		pmem->pgmap.range.end = res->end;
>  		pmem->pgmap.nr_range = 1;
>  		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
> +		pmem->pgmap.ops = &fsdax_pagemap_ops;
>  		addr = devm_memremap_pages(dev, &pmem->pgmap);
>  		pmem->pfn_flags |= PFN_MAP;
>  		bb_range = pmem->pgmap.range;
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index ad6062d736cd..bcfb6bf4ce5a 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -79,6 +79,18 @@ struct dev_pagemap_ops {
>  	 * the page back to a CPU accessible page.
>  	 */
>  	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
> +
> +	/*
> +	 * Handle the memory failure happens on a range of pfns.  Notify the
> +	 * processes who are using these pfns, and try to recover the data on
> +	 * them if necessary.  The mf_flags is finally passed to the recover
> +	 * function through the whole notify routine.
> +	 *
> +	 * When this is not implemented, or it returns -EOPNOTSUPP, the caller
> +	 * will fall back to a common handler called mf_generic_kill_procs().
> +	 */
> +	int (*memory_failure)(struct dev_pagemap *pgmap, unsigned long pfn,
> +			      unsigned long nr_pages, int mf_flags);
>  };
>  
>  #define PGMAP_ALTMAP_VALID	(1 << 0)
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 7c8c047bfdc8..a40e79e634a4 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1741,6 +1741,20 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  	if (!pgmap_pfn_valid(pgmap, pfn))
>  		goto out;
>  
> +	/*
> +	 * Call driver's implementation to handle the memory failure, otherwise
> +	 * fall back to generic handler.
> +	 */
> +	if (pgmap->ops->memory_failure) {
> +		rc = pgmap->ops->memory_failure(pgmap, pfn, 1, flags);
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
> 2.35.1
> 
> 
> 
