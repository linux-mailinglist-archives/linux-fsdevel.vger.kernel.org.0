Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139BA2ABDE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 14:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgKINwV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 08:52:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:39640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729939AbgKINwU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:52:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ABC11ABD1;
        Mon,  9 Nov 2020 13:52:18 +0000 (UTC)
Date:   Mon, 9 Nov 2020 14:52:15 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        mhocko@suse.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 03/21] mm/hugetlb: Introduce a new config
 HUGETLB_PAGE_FREE_VMEMMAP
Message-ID: <20201109135215.GA4778@localhost.localdomain>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108141113.65450-4-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 08, 2020 at 10:10:55PM +0800, Muchun Song wrote:
> The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
> whether to enable the feature of freeing unused vmemmap associated
> with HugeTLB pages. Now only support x86.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/x86/mm/init_64.c |  2 +-
>  fs/Kconfig            | 16 ++++++++++++++++
>  mm/bootmem_info.c     |  3 +--
>  3 files changed, 18 insertions(+), 3 deletions(-)
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
> index 976e8b9033c4..21b8d39a9715 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -245,6 +245,22 @@ config HUGETLBFS
>  config HUGETLB_PAGE
>  	def_bool HUGETLBFS
>  
> +config HUGETLB_PAGE_FREE_VMEMMAP
> +	bool "Free unused vmemmap associated with HugeTLB pages"
> +	default y
> +	depends on X86
> +	depends on HUGETLB_PAGE
> +	depends on SPARSEMEM_VMEMMAP
> +	depends on HAVE_BOOTMEM_INFO_NODE
> +	help
> +	  There are many struct page structures associated with each HugeTLB
> +	  page. But we only use a few struct page structures. In this case,
> +	  it wastes some memory. It is better to free the unused struct page
> +	  structures to buddy system which can save some memory. For
> +	  architectures that support it, say Y here.
> +
> +	  If unsure, say N.

I am not sure the above is useful for someone who needs to decide
whether he needs/wants to enable this or not.
I think the above fits better in a Documentation part.

I suck at this, but what about the following, or something along those
lines? 

"
When using SPARSEMEM_VMEMMAP, the system can save up some memory
from pre-allocated HugeTLB pages when they are not used.
6 pages per 2MB HugeTLB page and 4095 per 1GB HugeTLB page.
When the pages are going to be used or freed up, the vmemmap
array representing that range needs to be remapped again and
the pages we discarded earlier need to be rellocated again.
Therefore, this is a trade-off between saving memory and
increasing time in allocation/free path.
"

It would be also great to point out that this might be a
trade-off between saving up memory and increasing the cost
of certain operations on allocation/free path.
That is why I mentioned it there.

-- 
Oscar Salvador
SUSE L3
