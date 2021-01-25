Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6333020C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 04:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbhAYDR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jan 2021 22:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbhAYDRX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jan 2021 22:17:23 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D325C061574;
        Sun, 24 Jan 2021 19:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ZUqPi0OWj6BgzQz6Zi6+RzVHjsn+jrTCQ3eqo/QeXVY=; b=hOSO+Ufz6IsHvJFkftt73kd70N
        vYqgGqNV+BX8Hffv/4DZ2wunS6kDtH0LAwo2sHBLnQsTy+A389E+mRB7MCxUzx0DwPoWbi7ReEsgF
        Az8guqG8iNvDFNq16yLnnctJuKRXhoKRyxg05smY8uMm5g6eDQTUl12A2bo3SXHSr/7PjElTwVrzf
        XnGfM+s3Kc/ojYEX3NlmfJjFd+WQS93Nlk7jlETuGRgQC4f+ZEc+WzEVOstlSVSI4bbp4yFKwMR3N
        YO7iXtgZpfjNc52VpLJ1XvmQ/B0FeLuITs4AqH8IzxXK46FzMRPBkm68O0JkzKAybjmhdUJ49/Ngf
        l3/xX+JQ==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l3sMk-0006h7-QA; Mon, 25 Jan 2021 03:16:35 +0000
Subject: Re: [PATCH v13 02/12] mm: hugetlb: introduce a new config
 HUGETLB_PAGE_FREE_VMEMMAP
To:     David Rientjes <rientjes@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de, almasrymina@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-3-songmuchun@bytedance.com>
 <472a58b9-12cb-3c3-d132-13dbae5174f0@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0a6446ca-2d99-0124-f433-7ce226422aa4@infradead.org>
Date:   Sun, 24 Jan 2021 19:16:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <472a58b9-12cb-3c3-d132-13dbae5174f0@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/24/21 3:58 PM, David Rientjes wrote:
> On Sun, 17 Jan 2021, Muchun Song wrote:
> 
>> The HUGETLB_PAGE_FREE_VMEMMAP option is used to enable the freeing
>> of unnecessary vmemmap associated with HugeTLB pages. The config
>> option is introduced early so that supporting code can be written
>> to depend on the option. The initial version of the code only
>> provides support for x86-64.
>>
>> Like other code which frees vmemmap, this config option depends on
>> HAVE_BOOTMEM_INFO_NODE. The routine register_page_bootmem_info() is
>> used to register bootmem info. Therefore, make sure
>> register_page_bootmem_info is enabled if HUGETLB_PAGE_FREE_VMEMMAP
>> is defined.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  arch/x86/mm/init_64.c |  2 +-
>>  fs/Kconfig            | 18 ++++++++++++++++++
>>  2 files changed, 19 insertions(+), 1 deletion(-)
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
>> index 976e8b9033c4..e7c4c2a79311 100644
>> --- a/fs/Kconfig
>> +++ b/fs/Kconfig
>> @@ -245,6 +245,24 @@ config HUGETLBFS
>>  config HUGETLB_PAGE
>>  	def_bool HUGETLBFS
>>  
>> +config HUGETLB_PAGE_FREE_VMEMMAP
>> +	def_bool HUGETLB_PAGE
> 
> I'm not sure I understand the rationale for providing this help text if 
> this is def_bool depending on CONFIG_HUGETLB_PAGE.  Are you intending that 
> this is actually configurable and we want to provide guidance to the admin 
> on when to disable it (which it currently doesn't)?  If not, why have the 
> help text?

It's good for the (non-user) Kconfig symbol's meaning to be documented somewhere,
preferably such that one does not have to go digging thru git commit logs
to find it.

>> +	depends on X86_64
>> +	depends on SPARSEMEM_VMEMMAP
>> +	depends on HAVE_BOOTMEM_INFO_NODE
>> +	help
>> +	  The option HUGETLB_PAGE_FREE_VMEMMAP allows for the freeing of
>> +	  some vmemmap pages associated with pre-allocated HugeTLB pages.
>> +	  For example, on X86_64 6 vmemmap pages of size 4KB each can be
>> +	  saved for each 2MB HugeTLB page.  4094 vmemmap pages of size 4KB
>> +	  each can be saved for each 1GB HugeTLB page.
>> +
>> +	  When a HugeTLB page is allocated or freed, the vmemmap array
>> +	  representing the range associated with the page will need to be
>> +	  remapped.  When a page is allocated, vmemmap pages are freed
>> +	  after remapping.  When a page is freed, previously discarded
>> +	  vmemmap pages must be allocated before remapping.
>> +
>>  config MEMFD_CREATE
>>  	def_bool TMPFS || HUGETLBFS
>>  
> 


-- 
~Randy

