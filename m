Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9363341AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 16:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhCJPhf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 10:37:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:51142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232913AbhCJPhO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:37:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615390633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ek7QUkaAmi5C+C6ZBMnIeD647GlkKkIXowQZxyRv+lI=;
        b=CnP90l4b0Nb10SRhkfwzCmXQpNNGZRpK4jeHd7hZxHH7MqRqzZYhZmlQd9qQVvXcqX7ZfX
        KJzR6ZG5UnxE75VRinEx2AcFLF0XlnKYSYmFUeNLZ9mAafKJTlkv9WL8uBQSANVAEn5PXP
        oFVf6LpAcH33335O0IczazA+8/ODTeE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 19479AC1F;
        Wed, 10 Mar 2021 15:37:13 +0000 (UTC)
Date:   Wed, 10 Mar 2021 16:37:11 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: Re: [PATCH v18 6/9] mm: hugetlb: add a kernel parameter
 hugetlb_free_vmemmap
Message-ID: <YEjnpwN8eDlyc08+@dhcp22.suse.cz>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-7-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308102807.59745-7-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 08-03-21 18:28:04, Muchun Song wrote:
> Add a kernel parameter hugetlb_free_vmemmap to enable the feature of
> freeing unused vmemmap pages associated with each hugetlb page on boot.
> 
> We disables PMD mapping of vmemmap pages for x86-64 arch when this
> feature is enabled. Because vmemmap_remap_free() depends on vmemmap
> being base page mapped.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Tested-by: Chen Huang <chenhuang5@huawei.com>
> Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
>  Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
>  arch/x86/mm/init_64.c                           |  8 ++++++--
>  include/linux/hugetlb.h                         | 19 +++++++++++++++++++
>  mm/hugetlb_vmemmap.c                            | 24 ++++++++++++++++++++++++
>  5 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..de91d54573c4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1557,6 +1557,20 @@
>  			Documentation/admin-guide/mm/hugetlbpage.rst.
>  			Format: size[KMG]
>  
> +	hugetlb_free_vmemmap=
> +			[KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
> +			this controls freeing unused vmemmap pages associated
> +			with each HugeTLB page. When this option is enabled,
> +			we disable PMD/huge page mapping of vmemmap pages which
> +			increase page table pages. So if a user/sysadmin only
> +			uses a small number of HugeTLB pages (as a percentage
> +			of system memory), they could end up using more memory
> +			with hugetlb_free_vmemmap on as opposed to off.
> +			Format: { on | off (default) }

Please note this is an admin guide and for those this seems overly low
level. I would use something like the following
			[KNL] Reguires CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
			enabled.
			Allows heavy hugetlb users to free up some more
			memory (6 * PAGE_SIZE for each 2MB hugetlb
			page).
			This feauture is not free though. Large page
			tables are not use to back vmemmap pages which
			can lead to a performance degradation for some
			workloads. Also there will be memory allocation
			required when hugetlb pages are freed from the
			pool which can lead to corner cases under heavy
			memory pressure.
> +
> +			on:  enable the feature
> +			off: disable the feature
> +
>  	hung_task_panic=
>  			[KNL] Should the hung task detector generate panics.
>  			Format: 0 | 1
-- 
Michal Hocko
SUSE Labs
