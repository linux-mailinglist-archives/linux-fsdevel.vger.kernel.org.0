Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC06509AA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 10:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386640AbiDUI1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiDUI1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:27:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C581DA5C;
        Thu, 21 Apr 2022 01:24:25 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KkVtK5wCFzfYtX;
        Thu, 21 Apr 2022 16:23:37 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 16:24:23 +0800
Subject: Re: [PATCH v13 3/7] pagemap,pmem: Introduce ->memory_failure()
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>,
        Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
 <20220419045045.1664996-4-ruansy.fnst@fujitsu.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f173f091-d5ca-b049-a8ed-6616032ca83e@huawei.com>
Date:   Thu, 21 Apr 2022 16:24:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220419045045.1664996-4-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/4/19 12:50, Shiyang Ruan wrote:
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

Thanks for your patch. There are two questions:

1.Is dax_lock_page + dax_unlock_page pair needed here?
2.hwpoison_filter and SetPageHWPoison will be handled by the callback or they're just ignored deliberately?

Thanks!

>  	rc = mf_generic_kill_procs(pfn, flags, pgmap);
>  out:
>  	/* drop pgmap ref acquired in caller */
> 

