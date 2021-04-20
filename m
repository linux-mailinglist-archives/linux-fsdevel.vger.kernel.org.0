Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF63365643
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 12:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhDTKgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 06:36:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:58584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231388AbhDTKgL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 06:36:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE038AFC8;
        Tue, 20 Apr 2021 10:35:38 +0000 (UTC)
Date:   Tue, 20 Apr 2021 12:35:33 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 8/9] mm: memory_hotplug: disable memmap_on_memory
 when hugetlb_free_vmemmap enabled
Message-ID: <YH6udU5rKmDcx5dY@localhost.localdomain>
References: <20210415084005.25049-1-songmuchun@bytedance.com>
 <20210415084005.25049-9-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415084005.25049-9-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 15, 2021 at 04:40:04PM +0800, Muchun Song wrote:
>  bool mhp_supports_memmap_on_memory(unsigned long size)
>  {
> +	bool supported;
>  	unsigned long nr_vmemmap_pages = size / PAGE_SIZE;
>  	unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
>  	unsigned long remaining_size = size - vmemmap_size;
> @@ -1011,11 +1012,18 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
>  	 *	 altmap as an alternative source of memory, and we do not exactly
>  	 *	 populate a single PMD.
>  	 */
> -	return memmap_on_memory &&
> -	       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
> -	       size == memory_block_size_bytes() &&
> -	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
> -	       IS_ALIGNED(remaining_size, pageblock_nr_pages << PAGE_SHIFT);
> +	supported = memmap_on_memory &&
> +		    IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
> +		    size == memory_block_size_bytes() &&
> +		    IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
> +		    IS_ALIGNED(remaining_size, pageblock_nr_pages << PAGE_SHIFT);
> +
> +	if (supported && is_hugetlb_free_vmemmap_enabled()) {
> +		pr_info("Cannot enable memory_hotplug.memmap_on_memory, it is not compatible with hugetlb_free_vmemmap\n");
> +		supported = false;
> +	}

I would not print anything and rather have

return memmap_on_memory &&
       !is_hugetlb_free_vmemmap_enabled &&
       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
       size == memory_block_size_bytes() &&
       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
       IS_ALIGNED(remaining_size, pageblock_nr_pages << PAGE_SHIFT);

Documentation/admin-guide/kernel-parameters.txt already provides an
explanation on memory_hotplug.memmap_on_memory parameter that states
that the feature cannot be enabled when using hugetlb-vmemmap
optimization.

Users can always check whether the feature is enabled via
/sys/modules/memory_hotplug/parameters/memmap_on_memory.

Also, I did not check if it is, but if not, the fact about hugetlb-vmemmmap vs
hotplug-vmemmap should also be called out in the hugetlb-vmemmap kernel
parameter.

Thanks

-- 
Oscar Salvador
SUSE L3
