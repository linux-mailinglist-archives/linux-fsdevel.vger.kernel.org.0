Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A674D2B87DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 23:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgKRWki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 17:40:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60434 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKRWkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:40:37 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIMYM2j053900;
        Wed, 18 Nov 2020 22:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=m6wLHiKM+bSFMHahGiYbPBVS/ny3WBpJuh+PlKd3o2U=;
 b=D1BdkFasMIku94ns2M0cLij1YVJ/AUsyuHjpByxuY3K7NNpPqjFU27m7AlAC6zFcRwNS
 5DmY6gn5Nq5E4RwAlUJ8jUcv/tKIlvY25MwSEPPdtF2RvDgzhcbb9L6W/hRRu9sErfkG
 dctIdofu4T1K0zHwKsfCt8NbEShzFS9ZCm4VQEx8oBnwl1U8iE5P50+uwWJ2/Eghj3jV
 P2BzV+zZjIn0nx42QuJzbavfOrZb6O+cxIcvaf376VpzLvQDnkvDyCjxnml1TJPU5LiQ
 VViITkvjCtSzFSTuDwDHFMwO3LvGsXh+csgYmdhAOkRRAJQ7kuy5QHKKQ43JypoOLNp+ fQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34t4rb2qwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 22:38:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIMVM0w007892;
        Wed, 18 Nov 2020 22:38:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34umd169mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 22:38:47 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AIMceTm025687;
        Wed, 18 Nov 2020 22:38:41 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Nov 2020 14:38:40 -0800
Subject: Re: [PATCH v4 03/21] mm/hugetlb: Introduce a new config
 HUGETLB_PAGE_FREE_VMEMMAP
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <20201113105952.11638-4-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <697ee4b7-edcc-e3b8-676c-935ec445c05d@oracle.com>
Date:   Wed, 18 Nov 2020 14:38:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201113105952.11638-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=2 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180155
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/13/20 2:59 AM, Muchun Song wrote:
> The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
> whether to enable the feature of freeing unused vmemmap associated
> with HugeTLB pages. Now only support x86.
> 
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
> index 976e8b9033c4..67e1bc99574f 100644
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
> +	  When using SPARSEMEM_VMEMMAP, the system can save up some memory

Should that read,

	When using HUGETLB_PAGE_FREE_VMEMMAP, ...

as the help message is for this config option.

-- 
Mike Kravetz
