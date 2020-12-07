Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077162D10DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 13:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgLGMtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 07:49:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgLGMtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607345262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gj9yTnv0pMQFcNLl2DqcFbB30RkjtniH8pQgiWQVvag=;
        b=IaeCR2sJifCHM2pujPmFWEz6EpeBPm7k9VNo9UvcSTI9MwLj3n0diBsYBX/QV72prI3D7K
        HoVF6w+vMxa1tbx4zuTxqLJW/OxKS/2SBCyW3KGnzUFimNB+funPB8krThmXHopVXh9GAZ
        OXl2/QQLV7nZxkJ5MWL+e+k0LKsEB7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32--5iskghnOymQqZzHpw-H-w-1; Mon, 07 Dec 2020 07:47:38 -0500
X-MC-Unique: -5iskghnOymQqZzHpw-H-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 646D9800D55;
        Mon,  7 Dec 2020 12:47:34 +0000 (UTC)
Received: from [10.36.114.33] (ovpn-114-33.ams2.redhat.com [10.36.114.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 357EB5D9DE;
        Mon,  7 Dec 2020 12:47:27 +0000 (UTC)
Subject: Re: [External] Re: [PATCH v7 03/15] mm/hugetlb: Introduce a new
 config HUGETLB_PAGE_FREE_VMEMMAP
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-4-songmuchun@bytedance.com>
 <2ec1d360-c8c8-eb7b-2afe-b75ee61cfcea@redhat.com>
 <CAMZfGtVnw8aJWceLM1UerkAZzcjkObb-ZrCE_Jj6w3EUR=UN3Q@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ebff035a-a32b-cd7b-f4c1-332ddc1ceaa4@redhat.com>
Date:   Mon, 7 Dec 2020 13:47:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtVnw8aJWceLM1UerkAZzcjkObb-ZrCE_Jj6w3EUR=UN3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07.12.20 13:42, Muchun Song wrote:
> On Mon, Dec 7, 2020 at 8:19 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 30.11.20 16:18, Muchun Song wrote:
>>> The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
>>> whether to enable the feature of freeing unused vmemmap associated
>>> with HugeTLB pages. And this is just for dependency check. Now only
>>> support x86.
>>
>> x86 - i386 and x86-64? (I assume the latter only ;) )
> 
> Yeah, you are right. Only the latter support SPARSEMEM_VMEMMAP.
> 
>>
>>>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>>  arch/x86/mm/init_64.c |  2 +-
>>>  fs/Kconfig            | 14 ++++++++++++++
>>>  2 files changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>>> index 0a45f062826e..0435bee2e172 100644
>>> --- a/arch/x86/mm/init_64.c
>>> +++ b/arch/x86/mm/init_64.c
>>> @@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
>>>
>>>  static void __init register_page_bootmem_info(void)
>>>  {
>>> -#ifdef CONFIG_NUMA
>>> +#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
>>>       int i;
>>>
>>
>> Why does this hunk belong into this patch? Looks like this should go
>> into another patch.
> 
> Of course can. But Mike suggests that it is better to use it when
> introducing a new config. Because this config depends on
> HAVE_BOOTMEM_INFO_NODE. And register_page_bootmem_info
> is aimed to register bootmem info. So maybe it is reasonable from
> this point of view. What is your opinion?
>

Ah, I see. Maybe mention in the patch description, because the
"Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP" part left me
clueless. Stumbling over this change only left me rather clueless.

>>
>>>       for_each_online_node(i)
>>> diff --git a/fs/Kconfig b/fs/Kconfig
>>> index 976e8b9033c4..4961dd488444 100644
>>> --- a/fs/Kconfig
>>> +++ b/fs/Kconfig
>>> @@ -245,6 +245,20 @@ config HUGETLBFS
>>>  config HUGETLB_PAGE
>>>       def_bool HUGETLBFS
>>>
>>> +config HUGETLB_PAGE_FREE_VMEMMAP
>>> +     def_bool HUGETLB_PAGE
>>> +     depends on X86
>>> +     depends on SPARSEMEM_VMEMMAP
>>> +     depends on HAVE_BOOTMEM_INFO_NODE
>>> +     help
>>> +       When using HUGETLB_PAGE_FREE_VMEMMAP, the system can save up some
>>> +       memory from pre-allocated HugeTLB pages when they are not used.
>>> +       6 pages per 2MB HugeTLB page and 4094 per 1GB HugeTLB page.
>>
>> Calculations only apply to 4k base pages, no?
> 
> No, if the base page is not 4k, we also can free 6 pages.
> 
> For example:
> 
> If the base page size is 64k, the PMD huge page size is 512MB. We also

Note that 2MB huge pages on arm64 with 64k base pages are possible as
well. Also, I think powerpc always has 16MB huge pages, independent of
base page sizes.


-- 
Thanks,

David / dhildenb

