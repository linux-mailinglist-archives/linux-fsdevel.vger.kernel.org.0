Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42B52ADF8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 20:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbgKJTcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 14:32:25 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41410 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731760AbgKJTcT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:32:19 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAJTr53035259;
        Tue, 10 Nov 2020 19:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=vnHHyzn7CTdDGwMxubv24/voTJaEj+320EKJk/GHU6Y=;
 b=Sw7Fw6OFgDxOpTCuzKSjGPvD2GN0moz3c7QOrC+W7kLJGAA7JCd9o1kOBc1Nx9omCKdD
 onji+tLWR6XVNO9UIS0Fzn9dzlYsEKgCQXU3zgYUNEzQOps7hQ2TGjkp8g99n6AifZxU
 n1LMsspGcJOw5WlCtwZZmOEmrErRbOXY9nFX/WjK3oTKrHD9tOeZUlAfB22CD3Y5oyXg
 RyYKrX2XvcdYK5Emd5labG0rMNQT9fYSa9CXjUzwdTipFFcRDMloRKTXkh+Nn8VM+glI
 BgzmC05K4t7HKuaiJtX9wC0YeGUrG5JmukbULwy72EOuDopX2tuVoeWVP9QgQgM/1WYR Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34nh3awphr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 19:31:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAJU9bm123971;
        Tue, 10 Nov 2020 19:31:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34p5gxdrv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 19:31:36 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AAJVYjW002398;
        Tue, 10 Nov 2020 19:31:34 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Nov 2020 11:31:33 -0800
Subject: Re: [PATCH v3 03/21] mm/hugetlb: Introduce a new config
 HUGETLB_PAGE_FREE_VMEMMAP
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, mhocko@suse.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-4-songmuchun@bytedance.com>
 <20201109135215.GA4778@localhost.localdomain>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ef564084-ea73-d579-9251-ec0440df2b48@oracle.com>
Date:   Tue, 10 Nov 2020 11:31:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201109135215.GA4778@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=2
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100133
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/9/20 5:52 AM, Oscar Salvador wrote:
> On Sun, Nov 08, 2020 at 10:10:55PM +0800, Muchun Song wrote:
>> The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
>> whether to enable the feature of freeing unused vmemmap associated
>> with HugeTLB pages. Now only support x86.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>  arch/x86/mm/init_64.c |  2 +-
>>  fs/Kconfig            | 16 ++++++++++++++++
>>  mm/bootmem_info.c     |  3 +--
>>  3 files changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>> index 0a45f062826e..0435bee2e172 100644
>> --- a/arch/x86/mm/init_64.c
>> +++ b/arch/x86/mm/init_64.c
>> @@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
>>  
>>  static void __init register_page_bootmem_info(void)
>>  {
>> -#ifdef CONFIG_NUMA
>> +#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
>>  	int i;
>>  
>>  	for_each_online_node(i)
>> diff --git a/fs/Kconfig b/fs/Kconfig
>> index 976e8b9033c4..21b8d39a9715 100644
>> --- a/fs/Kconfig
>> +++ b/fs/Kconfig
>> @@ -245,6 +245,22 @@ config HUGETLBFS
>>  config HUGETLB_PAGE
>>  	def_bool HUGETLBFS
>>  
>> +config HUGETLB_PAGE_FREE_VMEMMAP
>> +	bool "Free unused vmemmap associated with HugeTLB pages"
>> +	default y
>> +	depends on X86
>> +	depends on HUGETLB_PAGE
>> +	depends on SPARSEMEM_VMEMMAP
>> +	depends on HAVE_BOOTMEM_INFO_NODE
>> +	help
>> +	  There are many struct page structures associated with each HugeTLB
>> +	  page. But we only use a few struct page structures. In this case,
>> +	  it wastes some memory. It is better to free the unused struct page
>> +	  structures to buddy system which can save some memory. For
>> +	  architectures that support it, say Y here.
>> +
>> +	  If unsure, say N.
> 
> I am not sure the above is useful for someone who needs to decide
> whether he needs/wants to enable this or not.
> I think the above fits better in a Documentation part.
> 
> I suck at this, but what about the following, or something along those
> lines? 
> 
> "
> When using SPARSEMEM_VMEMMAP, the system can save up some memory
> from pre-allocated HugeTLB pages when they are not used.
> 6 pages per 2MB HugeTLB page and 4095 per 1GB HugeTLB page.
> When the pages are going to be used or freed up, the vmemmap
> array representing that range needs to be remapped again and
> the pages we discarded earlier need to be rellocated again.
> Therefore, this is a trade-off between saving memory and
> increasing time in allocation/free path.
> "
> 
> It would be also great to point out that this might be a
> trade-off between saving up memory and increasing the cost
> of certain operations on allocation/free path.
> That is why I mentioned it there.

Yes, this is somewhat a trade-off.

As a config option, this is something that would likely be decided by
distros.  I almost hate to suggest this, but is it something that an
end user would want to decide?  Is this something that perhaps should
be a boot/kernel command line option?

-- 
Mike Kravetz
