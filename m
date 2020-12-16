Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EAD2DB9D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 04:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgLPDre (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 22:47:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38376 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgLPDrd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:47:33 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG3ipRT163074;
        Wed, 16 Dec 2020 03:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/Yfr+yxyI8slca26A/7YE1XKDrj0vKDLNSf+osowAoY=;
 b=LR4L+vSG+o/flq89Ue+deK899Xl2cKrx8+C1Hz4BQ2olTIZeo9eXmFIWDg2/XQc2/UQ9
 peaduAyqzZrRhO1b/BkmoyqehxyeI0oxHaPWgC1KsMOMwZjRe8k2RJM8uqbmOH+3+QDO
 jMf6LPN2+W9KgKMaguHf5+MXynesFd4qDocUTTfszit2m6iq+DfLojBUxUOT8z18v3Dd
 DOHAWfzPZTXTjPKzZ+yhis7XyQzYKX/t4txXR9nPxnROkWc8N8xMhUldRncfutiKMGlR
 nCwLwLqAEvUycKur29Ax11sF9s1zRza2aGzgAY85XtXKsYFMh0hsmZfjUTCrMLJWdGT6 QA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 35cn9rdvq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 03:45:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG3jDsW123453;
        Wed, 16 Dec 2020 03:45:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 35d7enyw48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 03:45:45 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BG3jUGJ030163;
        Wed, 16 Dec 2020 03:45:31 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Dec 2020 19:45:30 -0800
Subject: Re: [PATCH v9 02/11] mm/hugetlb: Introduce a new config
 HUGETLB_PAGE_FREE_VMEMMAP
From:   Mike Kravetz <mike.kravetz@oracle.com>
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
 <7cfe44aa-3753-82d9-6630-194f1532e186@oracle.com>
Message-ID: <e9abb112-7654-6157-6782-9ccb4a9cd87e@oracle.com>
Date:   Tue, 15 Dec 2020 19:45:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <7cfe44aa-3753-82d9-6630-194f1532e186@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160022
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/15/20 5:03 PM, Mike Kravetz wrote:
> On 12/13/20 7:45 AM, Muchun Song wrote:
>> diff --git a/fs/Kconfig b/fs/Kconfig
>> index 976e8b9033c4..4c3a9c614983 100644
>> --- a/fs/Kconfig
>> +++ b/fs/Kconfig
>> @@ -245,6 +245,21 @@ config HUGETLBFS
>>  config HUGETLB_PAGE
>>  	def_bool HUGETLBFS
>>  
>> +config HUGETLB_PAGE_FREE_VMEMMAP
>> +	def_bool HUGETLB_PAGE
>> +	depends on X86_64
>> +	depends on SPARSEMEM_VMEMMAP
>> +	depends on HAVE_BOOTMEM_INFO_NODE
>> +	help
>> +	  When using HUGETLB_PAGE_FREE_VMEMMAP, the system can save up some
>> +	  memory from pre-allocated HugeTLB pages when they are not used.
>> +	  6 pages per HugeTLB page of the pmd level mapping and (PAGE_SIZE - 2)
>> +	  pages per HugeTLB page of the pud level mapping.
>> +
>> +	  When the pages are going to be used or freed up, the vmemmap array
>> +	  representing that range needs to be remapped again and the pages
>> +	  we discarded earlier need to be rellocated again.
> 
> I see the previous discussion with David about wording here.  How about
> leaving the functionality description general, and provide a specific
> example for x86_64?  As mentioned we can always update when new arch support
> is added.  Suggested text?
> 
> 	The option HUGETLB_PAGE_FREE_VMEMMAP allows for the freeing of
> 	some vmemmap pages associated with pre-allocated HugeTLB pages.
> 	For example, on X86_64 6 vmemmap pages of size 4KB each can be
> 	saved for each 2MB HugeTLB page.  4094 vmemmap pages of size 4KB
> 	each can be saved for each 1GB HugeTLB page.
> 
> 	When a HugeTLB page is allocated or freed, the vmemmap array
> 	representing the range associated with the page will need to be
> 	remapped.  When a page is allocated, vmemmap pages are freed
> 	after remapping.  When a page is freed, previously discarded
> 	vmemmap pages must be allocated before before remapping.

Sorry, I am slowly coming up to speed with discussions when I was away.

It appears vmemmap is not being mapped with huge pages if the boot option
hugetlb_free_vmemmap is on.   Is that correct?

If that is correct, we should document the trade off of increased page
table pages needed to map vmemmap vs the savings from freeing struct page
pages.  If a user/sysadmin only uses a small number of hugetlb pages (as
a percentage of system memory) they could end up using more memory with
hugetlb_free_vmemmap on as opposed to off.  Perhaps, it should be part of
the documentation for hugetlb_free_vmemmap?  If this is true, and people
think this should be documented, I can try to come up with something.

-- 
Mike Kravetz
