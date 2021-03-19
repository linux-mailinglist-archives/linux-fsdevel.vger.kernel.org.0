Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD1F341D02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 13:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhCSMgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 08:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229805AbhCSMge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616157393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTBdIvYVKxivTQZ4/xumg0qxwF0ioqcJs62QwTk4pVg=;
        b=dA28z0i7DM9ag+n4WnV+BjqsOqeEUTV9jAEoO98N+wIeiZDFW67NminjWOV3xNMuBNxtun
        MP+CpULci1NLQKkKImlpWNZxrKP/IlKIsSXof6GyI5lWsALKjL0hglgHnS1r7x16kpr+rM
        t8DOKCrS0Hyet24zXwkZHe7vRbmGycg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-pJqJ1ligM1iGru6-v09lpA-1; Fri, 19 Mar 2021 08:36:30 -0400
X-MC-Unique: pJqJ1ligM1iGru6-v09lpA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A944107ACCA;
        Fri, 19 Mar 2021 12:36:26 +0000 (UTC)
Received: from [10.36.112.11] (ovpn-112-11.ams2.redhat.com [10.36.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F4095DAA5;
        Fri, 19 Mar 2021 12:36:19 +0000 (UTC)
Subject: Re: [External] Re: [PATCH v19 7/8] mm: hugetlb: add a kernel
 parameter hugetlb_free_vmemmap
To:     Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        X86 ML <x86@kernel.org>, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
References: <20210315092015.35396-1-songmuchun@bytedance.com>
 <20210315092015.35396-8-songmuchun@bytedance.com>
 <20210319085948.GA5695@linux>
 <CAMZfGtXAgcJQp59AVuieqLT+1Qb3RGQmFK-SGNZH-T6K83Y=HQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e9af16bb-2296-c9fb-976f-f99472490940@redhat.com>
Date:   Fri, 19 Mar 2021 13:36:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtXAgcJQp59AVuieqLT+1Qb3RGQmFK-SGNZH-T6K83Y=HQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19.03.21 13:15, Muchun Song wrote:
> On Fri, Mar 19, 2021 at 4:59 PM Oscar Salvador <osalvador@suse.de> wrote:
>>
>> On Mon, Mar 15, 2021 at 05:20:14PM +0800, Muchun Song wrote:
>>> --- a/arch/x86/mm/init_64.c
>>> +++ b/arch/x86/mm/init_64.c
>>> @@ -34,6 +34,7 @@
>>>   #include <linux/gfp.h>
>>>   #include <linux/kcore.h>
>>>   #include <linux/bootmem_info.h>
>>> +#include <linux/hugetlb.h>
>>>
>>>   #include <asm/processor.h>
>>>   #include <asm/bios_ebda.h>
>>> @@ -1557,7 +1558,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>>   {
>>>        int err;
>>>
>>> -     if (end - start < PAGES_PER_SECTION * sizeof(struct page))
>>> +     if ((is_hugetlb_free_vmemmap_enabled()  && !altmap) ||
>>> +         end - start < PAGES_PER_SECTION * sizeof(struct page))
>>>                err = vmemmap_populate_basepages(start, end, node, NULL);
>>>        else if (boot_cpu_has(X86_FEATURE_PSE))
>>>                err = vmemmap_populate_hugepages(start, end, node, altmap);
>>
>> I've been thinking about this some more.
>>
>> Assume you opt-in the hugetlb-vmemmap feature, and assume you pass a valid altmap
>> to vmemmap_populate.
>> This will lead to use populating the vmemmap array with hugepages.
> 
> Right.
> 
>>
>> What if then, a HugeTLB gets allocated and falls within that memory range (backed
>> by hugetpages)?
> 
> I am not sure whether we can allocate the HugeTLB pages from there.
> Will only device memory pass a valid altmap parameter to
> vmemmap_populate()? If yes, can we allocate HugeTLB pages from
> device memory? Sorry, I am not an expert on this.

I think, right now, yes. System RAM that's applicable for HugePages 
never uses an altmap. But Oscar's patch will change that, maybe before 
your series might get included from what I've been reading. [1]

[1] https://lkml.kernel.org/r/20210319092635.6214-1-osalvador@suse.de

> 
> 
>> AFAIK, this will get us in trouble as currently the code can only operate on memory
>> backed by PAGE_SIZE pages, right?
>>
>> I cannot remember, but I do not think nothing prevents that from happening?
>> Am I missing anything?
> 
> Maybe David H is more familiar with this.
> 
> Hi David,
> 
> Do you have some suggestions on this?

There has to be some way to identify whether we can optimize specific 
vmemmap pages or should just leave them alone. altmap vs. !altmap.

Unfortunately, there is no easy way to detect that - e.g., 
PageReserved() applies also to boot memory.

We could go back to setting a special PageType for these vmemmap pages, 
indicating "this is a page allocated from an altmap, don't touch it".

-- 
Thanks,

David / dhildenb

