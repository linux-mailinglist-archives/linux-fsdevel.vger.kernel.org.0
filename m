Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0712DB836
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 02:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgLPBFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 20:05:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60698 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgLPBFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 20:05:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG11Buc071723;
        Wed, 16 Dec 2020 01:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=vCsOIns9Vm+ZWMPHM06Fv0bekoUZLP1odtheFhtyDdU=;
 b=Glgs9eTk05dIRYGx5O5GG5CThH94Df+WuCRH6BJTawNchhe4LetJXrqfoAPvBGbBZgy+
 1mm1F+B9NNlTCeKq8ax9tFy4RnAnSKv1JgvOHJ0VJthFe0r2HrRNyGiVoOh4H42TGqgD
 jQUHWCqBDi0nh9JZv65Lk6e3exeOjoL9XJhq7nadiXs/iAUGv/N23WOYC6IfG3meR+Mt
 qxqkdABYj186nUgNKVDEGtVOYbDHvMuO2a95j1XJCbA9N8l9wG1va7xwFEJFRmf8KlFU
 XqAtDQHab2HbMn0hc3hxxZRP8Hh/GuJwB8oN/MUe2TPGtqv0rNL0HXPZgL6sMC6MVOCC fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 35cn9rdjf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 01:03:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG11S6F043831;
        Wed, 16 Dec 2020 01:03:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 35d7ent36a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 01:03:46 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BG13b9S007993;
        Wed, 16 Dec 2020 01:03:38 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Dec 2020 17:03:36 -0800
Subject: Re: [PATCH v9 02/11] mm/hugetlb: Introduce a new config
 HUGETLB_PAGE_FREE_VMEMMAP
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-3-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7cfe44aa-3753-82d9-6630-194f1532e186@oracle.com>
Date:   Tue, 15 Dec 2020 17:03:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201213154534.54826-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160002
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/13/20 7:45 AM, Muchun Song wrote:
> The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
> whether to enable the feature of freeing unused vmemmap associated with
> HugeTLB pages. And this is just for dependency check. Now only support
> x86-64.
> 
> Because this config depends on HAVE_BOOTMEM_INFO_NODE. And the function
> of the register_page_bootmem_info() is aimed to register bootmem info.
> So we should register bootmem info when this config is enabled.

Suggested commit message rewording?

The HUGETLB_PAGE_FREE_VMEMMAP option is used to enable the freeing of
unnecessary vmemmap associated with HugeTLB pages.  The config option is
introduced early so that supporting code can be written to depend on the
option.  The initial version of the code only provides support for x86-64.

Like other code which frees vmemmap, this config option depends on
HAVE_BOOTMEM_INFO_NODE.  The routine register_page_bootmem_info() is used
to register bootmem info.  Therefore, make sure register_page_bootmem_info
is enabled if HUGETLB_PAGE_FREE_VMEMMAP is defined.

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/x86/mm/init_64.c |  2 +-
>  fs/Kconfig            | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
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
> index 976e8b9033c4..4c3a9c614983 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -245,6 +245,21 @@ config HUGETLBFS
>  config HUGETLB_PAGE
>  	def_bool HUGETLBFS
>  
> +config HUGETLB_PAGE_FREE_VMEMMAP
> +	def_bool HUGETLB_PAGE
> +	depends on X86_64
> +	depends on SPARSEMEM_VMEMMAP
> +	depends on HAVE_BOOTMEM_INFO_NODE
> +	help
> +	  When using HUGETLB_PAGE_FREE_VMEMMAP, the system can save up some
> +	  memory from pre-allocated HugeTLB pages when they are not used.
> +	  6 pages per HugeTLB page of the pmd level mapping and (PAGE_SIZE - 2)
> +	  pages per HugeTLB page of the pud level mapping.
> +
> +	  When the pages are going to be used or freed up, the vmemmap array
> +	  representing that range needs to be remapped again and the pages
> +	  we discarded earlier need to be rellocated again.

I see the previous discussion with David about wording here.  How about
leaving the functionality description general, and provide a specific
example for x86_64?  As mentioned we can always update when new arch support
is added.  Suggested text?

	The option HUGETLB_PAGE_FREE_VMEMMAP allows for the freeing of
	some vmemmap pages associated with pre-allocated HugeTLB pages.
	For example, on X86_64 6 vmemmap pages of size 4KB each can be
	saved for each 2MB HugeTLB page.  4094 vmemmap pages of size 4KB
	each can be saved for each 1GB HugeTLB page.

	When a HugeTLB page is allocated or freed, the vmemmap array
	representing the range associated with the page will need to be
	remapped.  When a page is allocated, vmemmap pages are freed
	after remapping.  When a page is freed, previously discarded
	vmemmap pages must be allocated before before remapping.

-- 
Mike Kravetz
	
> +
>  config MEMFD_CREATE
>  	def_bool TMPFS || HUGETLBFS
>  
> 
