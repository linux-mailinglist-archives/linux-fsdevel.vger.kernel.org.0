Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FCF3344FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhCJRTy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 12:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhCJRTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:19:21 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124D2C061760;
        Wed, 10 Mar 2021 09:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=/5w/2w1U8IalsF0nNy9P7Ug7r+ohzPQSbTLCV/ACYAw=; b=SgflWwuG7rlwczSiA89xk50EeO
        oOTWd+PU5g5gxSejQlyIkVaSdnDwj4o3CRFn7UuX1oWDYc8DryelbfSw2YlzFTJlbsgnDDuDdMvTq
        Kr+y0BQQ7khb13jHIkAL3SXgaSJv6IxdWu4FKUC+XIMTYurthG8XZEn28i55KvcnBjltFjWPKcEIq
        lG0rpF9QX8Ur4hgel0bnSWWUzOo7LTG2q2cQN2bq60O+QJq9p3pA+/8MlTAvtktiOPna7xOl57jpb
        v2N1TFYFrgGEYT74Cjsv+7O7nVCcMq2dqyUpK6GSVvEfYwIah8F9K8TawEuWuEGMim2cMrZurOZtk
        D80YgH9g==;
Received: from merlin.infradead.org ([2001:8b0:10b:1234::107])
        by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
        id 1lK2UR-007K8B-16; Wed, 10 Mar 2021 17:19:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/5w/2w1U8IalsF0nNy9P7Ug7r+ohzPQSbTLCV/ACYAw=; b=m7XtJ6F6ba4xYYPrTIE4xsUsws
        WPYx3ooWq+b5Tccj8O+pI2kaWneGjqXek6MU3N6LHiXGQ2l7KLVB8iJ+tDyWFrPn7FFic2vKIc4da
        563khCrBGqrXdg+ZdhEh3i0qvRbLEU79QNpJ6dO+0Nyok39hJkxOQDivFihPYwf6ITidfUfzkYikH
        SKZpwQyK1iZggwZkU2sVXGEd386ZAeBWSWK4wgPM+oVILE5dwQYFhfhHQKMsrfnDmNjMm+o35mCBW
        oSxtfSsHX5ooAlE0EoVj/4loLabM5x/K/T9luZlD6bNIdeDVwcSV83EoEHkACGo4ApWncrBosyaHh
        E3kafvcQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lK2RB-000pW0-Os; Wed, 10 Mar 2021 17:15:59 +0000
Subject: Re: [PATCH v18 6/9] mm: hugetlb: add a kernel parameter
 hugetlb_free_vmemmap
To:     Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de, almasrymina@google.com,
        rientjes@google.com, willy@infradead.org, osalvador@suse.de,
        song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-7-songmuchun@bytedance.com>
 <YEjnpwN8eDlyc08+@dhcp22.suse.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4ed29af1-1114-a085-d47d-21d646963ab7@infradead.org>
Date:   Wed, 10 Mar 2021 09:15:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YEjnpwN8eDlyc08+@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/10/21 7:37 AM, Michal Hocko wrote:
> On Mon 08-03-21 18:28:04, Muchun Song wrote:
>> Add a kernel parameter hugetlb_free_vmemmap to enable the feature of
>> freeing unused vmemmap pages associated with each hugetlb page on boot.
>>
>> We disables PMD mapping of vmemmap pages for x86-64 arch when this
>> feature is enabled. Because vmemmap_remap_free() depends on vmemmap
>> being base page mapped.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>> Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
>> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
>> Tested-by: Chen Huang <chenhuang5@huawei.com>
>> Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
>>  Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
>>  arch/x86/mm/init_64.c                           |  8 ++++++--
>>  include/linux/hugetlb.h                         | 19 +++++++++++++++++++
>>  mm/hugetlb_vmemmap.c                            | 24 ++++++++++++++++++++++++
>>  5 files changed, 66 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 04545725f187..de91d54573c4 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1557,6 +1557,20 @@
>>  			Documentation/admin-guide/mm/hugetlbpage.rst.
>>  			Format: size[KMG]
>>  
>> +	hugetlb_free_vmemmap=
>> +			[KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
>> +			this controls freeing unused vmemmap pages associated
>> +			with each HugeTLB page. When this option is enabled,
>> +			we disable PMD/huge page mapping of vmemmap pages which
>> +			increase page table pages. So if a user/sysadmin only
>> +			uses a small number of HugeTLB pages (as a percentage
>> +			of system memory), they could end up using more memory
>> +			with hugetlb_free_vmemmap on as opposed to off.
>> +			Format: { on | off (default) }
> 
> Please note this is an admin guide and for those this seems overly low
> level. I would use something like the following
> 			[KNL] Reguires CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> 			enabled.
> 			Allows heavy hugetlb users to free up some more
> 			memory (6 * PAGE_SIZE for each 2MB hugetlb
> 			page).
> 			This feauture is not free though. Large page
> 			tables are not use to back vmemmap pages which

			       are not used

> 			can lead to a performance degradation for some
> 			workloads. Also there will be memory allocation
> 			required when hugetlb pages are freed from the
> 			pool which can lead to corner cases under heavy
> 			memory pressure.
>> +
>> +			on:  enable the feature
>> +			off: disable the feature
>> +
>>  	hung_task_panic=
>>  			[KNL] Should the hung task detector generate panics.
>>  			Format: 0 | 1


-- 
~Randy

