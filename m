Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572492BA3D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 08:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgKTHty (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 02:49:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:40334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgKTHty (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:49:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605858593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JFvwpWs+I7VuMZUnQ/M4/DdrXRj39dZAkTCNQ3+7/8A=;
        b=MSBzqEZLMEN+gaZEtO/cfHVZBm5k4R1ZQbopfPyPqkDcH0wFI9n0P2DeIJpYxBDGgW5g6p
        U6YUsrEPzs3nG68yJDBPvGIcynTAGESGi0tDZKxWWXEIQaJyfcUN9vGfT8MHzudXCzfgAS
        UOmJnox8Zr4nNsFQMlCv31/N2sC7lQQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5A8BAC0C;
        Fri, 20 Nov 2020 07:49:52 +0000 (UTC)
Date:   Fri, 20 Nov 2020 08:49:50 +0100
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
        osalvador@suse.de, song.bao.hua@hisilicon.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 03/21] mm/hugetlb: Introduce a new config
 HUGETLB_PAGE_FREE_VMEMMAP
Message-ID: <20201120074950.GB3200@dhcp22.suse.cz>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120064325.34492-4-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 20-11-20 14:43:07, Muchun Song wrote:
> The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
> whether to enable the feature of freeing unused vmemmap associated
> with HugeTLB pages. Now only support x86.

Why is the config option necessary? Are code savings with the feature
disabled really worth it? I can see that your later patch adds a kernel
command line option. I believe that is a more reasonable way to control
the feature. I would argue that this should be an opt-in rather than
opt-out though. Think of users of pre-built (e.g. distribution kernels)
who might be interested in the feature. Yet you cannot assume that such
a kernel would enable the feature with its overhead to all hugetlb
users.

That being said, unless there are huge advantages to introduce a
config option I would rather not add it because our config space is huge
already and the more we add the more future code maintainance that will
add. If you want the config just for dependency checks then fine by me.
 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/x86/mm/init_64.c |  2 +-
>  fs/Kconfig            | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 0a45f062826e..0435bee2e172 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
>  
>  static void __init register_page_bootmem_info(void)
>  {
> -#ifdef CONFIG_NUMA
> +#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
>  	int i;
>  
>  	for_each_online_node(i)
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 976e8b9033c4..4961dd488444 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -245,6 +245,20 @@ config HUGETLBFS
>  config HUGETLB_PAGE
>  	def_bool HUGETLBFS
>  
> +config HUGETLB_PAGE_FREE_VMEMMAP
> +	def_bool HUGETLB_PAGE
> +	depends on X86
> +	depends on SPARSEMEM_VMEMMAP
> +	depends on HAVE_BOOTMEM_INFO_NODE
> +	help
> +	  When using HUGETLB_PAGE_FREE_VMEMMAP, the system can save up some
> +	  memory from pre-allocated HugeTLB pages when they are not used.
> +	  6 pages per 2MB HugeTLB page and 4094 per 1GB HugeTLB page.
> +
> +	  When the pages are going to be used or freed up, the vmemmap array
> +	  representing that range needs to be remapped again and the pages
> +	  we discarded earlier need to be rellocated again.
> +
>  config MEMFD_CREATE
>  	def_bool TMPFS || HUGETLBFS
>  
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
