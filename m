Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD1D30F2A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 12:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbhBDLpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 06:45:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12075 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbhBDLpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:45:04 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DWc9W6SRBzMV3b;
        Thu,  4 Feb 2021 19:42:39 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 19:44:13 +0800
Subject: Re: [PATCH v14 2/8] mm: hugetlb: introduce a new config
 HUGETLB_PAGE_FREE_VMEMMAP
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <duanxiongchun@bytedance.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <corbet@lwn.net>,
        <mike.kravetz@oracle.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <viro@zeniv.linux.org.uk>,
        <akpm@linux-foundation.org>, <paulmck@kernel.org>,
        <mchehab+huawei@kernel.org>, <pawan.kumar.gupta@linux.intel.com>,
        <rdunlap@infradead.org>, <oneukum@suse.com>,
        <anshuman.khandual@arm.com>, <jroedel@suse.de>,
        <almasrymina@google.com>, <rientjes@google.com>,
        <willy@infradead.org>, <osalvador@suse.de>, <mhocko@suse.com>,
        <song.bao.hua@hisilicon.com>, <david@redhat.com>,
        <naoya.horiguchi@nec.com>
References: <20210204035043.36609-1-songmuchun@bytedance.com>
 <20210204035043.36609-3-songmuchun@bytedance.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7349db78-9eeb-86e2-b5de-9ebbcba85e1d@huawei.com>
Date:   Thu, 4 Feb 2021 19:44:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210204035043.36609-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi:
On 2021/2/4 11:50, Muchun Song wrote:
> The option HUGETLB_PAGE_FREE_VMEMMAP allows for the freeing of
> some vmemmap pages associated with pre-allocated HugeTLB pages.
> For example, on X86_64 6 vmemmap pages of size 4KB each can be
> saved for each 2MB HugeTLB page. 4094 vmemmap pages of size 4KB
> each can be saved for each 1GB HugeTLB page.
> 
> When a HugeTLB page is allocated or freed, the vmemmap array
> representing the range associated with the page will need to be
> remapped. When a page is allocated, vmemmap pages are freed
> after remapping. When a page is freed, previously discarded
> vmemmap pages must be allocated before remapping.
> 
> The config option is introduced early so that supporting code
> can be written to depend on the option. The initial version of
> the code only provides support for x86-64.
> 
> Like other code which frees vmemmap, this config option depends on
> HAVE_BOOTMEM_INFO_NODE. The routine register_page_bootmem_info() is
> used to register bootmem info. Therefore, make sure
> register_page_bootmem_info is enabled if HUGETLB_PAGE_FREE_VMEMMAP
> is defined.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

LGTM. Thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  arch/x86/mm/init_64.c | 2 +-
>  fs/Kconfig            | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
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
> index 97e7b77c9309..de87f234f1e9 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -237,6 +237,12 @@ config HUGETLBFS
>  config HUGETLB_PAGE
>  	def_bool HUGETLBFS
>  
> +config HUGETLB_PAGE_FREE_VMEMMAP
> +	def_bool HUGETLB_PAGE
> +	depends on X86_64
> +	depends on SPARSEMEM_VMEMMAP
> +	depends on HAVE_BOOTMEM_INFO_NODE
> +
>  config MEMFD_CREATE
>  	def_bool TMPFS || HUGETLBFS
>  
> 

