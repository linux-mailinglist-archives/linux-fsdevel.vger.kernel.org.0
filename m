Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30B12D3EE7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 10:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgLIJei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 04:34:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44803 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729350AbgLIJei (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607506390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0UNT/8TMZ8ny4MvkKmCzhZsa8wQOPrt6BmOD//JA3N0=;
        b=B8hL2F4QYRQYPomL4TAePbCIpWlCWkVEz9WcOjkJ0thGFLtV6rsSCWHRkE4ZodQOLbdkPs
        LHUkRn0apeI7gXZUWmwnnYPbkA+iXvQb//2fZGXeqJ6B5+RvfmaN5g8Z5nAz4CXBg5LH4V
        /CPJLHez8ICY8iNFXydnY1eiMz7WGLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-P4R9sx3DPdm8E67gIrKLoQ-1; Wed, 09 Dec 2020 04:33:06 -0500
X-MC-Unique: P4R9sx3DPdm8E67gIrKLoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8EC210054FF;
        Wed,  9 Dec 2020 09:33:02 +0000 (UTC)
Received: from [10.36.114.167] (ovpn-114-167.ams2.redhat.com [10.36.114.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0F586EF55;
        Wed,  9 Dec 2020 09:32:56 +0000 (UTC)
Subject: Re: [External] Re: [PATCH v7 05/15] mm/bootmem_info: Introduce
 {free,prepare}_vmemmap_page()
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
 <20201130151838.11208-6-songmuchun@bytedance.com>
 <17abb7bb-de39-7580-b020-faec58032de9@redhat.com>
 <CAMZfGtWepk0EXc_fCtS83gvhfKpMrXxP8k3oWwfhWKmPJ3jjwA@mail.gmail.com>
 <096ee806-b371-c22b-9066-8891935fbd5e@redhat.com>
 <CAMZfGtU-zpPRkSikcYZUhKvWhpwZ+cspXNhoaok9e6MCE2pk-g@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <73832edd-13ec-8032-d8d6-4afc53297fdb@redhat.com>
Date:   Wed, 9 Dec 2020 10:32:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtU-zpPRkSikcYZUhKvWhpwZ+cspXNhoaok9e6MCE2pk-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.12.20 10:25, Muchun Song wrote:
> On Wed, Dec 9, 2020 at 4:50 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 09.12.20 08:36, Muchun Song wrote:
>>> On Mon, Dec 7, 2020 at 8:39 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 30.11.20 16:18, Muchun Song wrote:
>>>>> In the later patch, we can use the free_vmemmap_page() to free the
>>>>> unused vmemmap pages and initialize a page for vmemmap page using
>>>>> via prepare_vmemmap_page().
>>>>>
>>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>>> ---
>>>>>  include/linux/bootmem_info.h | 24 ++++++++++++++++++++++++
>>>>>  1 file changed, 24 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
>>>>> index 4ed6dee1adc9..239e3cc8f86c 100644
>>>>> --- a/include/linux/bootmem_info.h
>>>>> +++ b/include/linux/bootmem_info.h
>>>>> @@ -3,6 +3,7 @@
>>>>>  #define __LINUX_BOOTMEM_INFO_H
>>>>>
>>>>>  #include <linux/mmzone.h>
>>>>> +#include <linux/mm.h>
>>>>>
>>>>>  /*
>>>>>   * Types for free bootmem stored in page->lru.next. These have to be in
>>>>> @@ -22,6 +23,29 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
>>>>>  void get_page_bootmem(unsigned long info, struct page *page,
>>>>>                     unsigned long type);
>>>>>  void put_page_bootmem(struct page *page);
>>>>> +
>>>>> +static inline void free_vmemmap_page(struct page *page)
>>>>> +{
>>>>> +     VM_WARN_ON(!PageReserved(page) || page_ref_count(page) != 2);
>>>>> +
>>>>> +     /* bootmem page has reserved flag in the reserve_bootmem_region */
>>>>> +     if (PageReserved(page)) {
>>>>> +             unsigned long magic = (unsigned long)page->freelist;
>>>>> +
>>>>> +             if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
>>>>> +                     put_page_bootmem(page);
>>>>> +             else
>>>>> +                     WARN_ON(1);
>>>>> +     }
>>>>> +}
>>>>> +
>>>>> +static inline void prepare_vmemmap_page(struct page *page)
>>>>> +{
>>>>> +     unsigned long section_nr = pfn_to_section_nr(page_to_pfn(page));
>>>>> +
>>>>> +     get_page_bootmem(section_nr, page, SECTION_INFO);
>>>>> +     mark_page_reserved(page);
>>>>> +}
>>>>
>>>> Can you clarify in the description when exactly these functions are
>>>> called and on which type of pages?
>>>>
>>>> Would indicating "bootmem" in the function names make it clearer what we
>>>> are dealing with?
>>>>
>>>> E.g., any memory allocated via the memblock allocator and not via the
>>>> buddy will be makred reserved already in the memmap. It's unclear to me
>>>> why we need the mark_page_reserved() here - can you enlighten me? :)
>>>
>>> Sorry for ignoring this question. Because the vmemmap pages are allocated
>>> from the bootmem allocator which is marked as PG_reserved. For those bootmem
>>> pages, we should call put_page_bootmem for free. You can see that we
>>> clear the PG_reserved in the put_page_bootmem. In order to be consistent,
>>> the prepare_vmemmap_page also marks the page as PG_reserved.
>>
>> I don't think that really makes sense.
>>
>> After put_page_bootmem() put the last reference, it clears PG_reserved
>> and hands the page over to the buddy via free_reserved_page(). From that
>> point on, further get_page_bootmem() would be completely wrong and
>> dangerous.
>>
>> Both, put_page_bootmem() and get_page_bootmem() rely on the fact that
>> they are dealing with memblock allcoations - marked via PG_reserved. If
>> prepare_vmemmap_page() would be called on something that's *not* coming
>> from the memblock allocator, it would be completely broken - or am I
>> missing something?
>>
>> AFAIKT, there should rather be a BUG_ON(!PageReserved(page)) in
>> prepare_vmemmap_page() - or proper handling to deal with !memblock
>> allocations.
>>
> 
> I want to allocate some pages as the vmemmap when
> we free a HugeTLB page to the buddy allocator. So I use
> the prepare_vmemmap_page() to initialize the page (which
> allocated from buddy allocator) and make it as the vmemmap
> of the freed HugeTLB page.
> 
> Any suggestions to deal with this case?

If you obtained pages via the buddy, there shouldn't be anything special
to handle, no? What speaks against


prepare_vmemmap_page():
if (!PageReserved(page))
	return;


put_page_bootmem():
if (!PageReserved(page))
	__free_page();


Or if we care about multiple references, get_page() and put_page().

> 
> I have a solution to address this. When the pages allocated
> from the buddy as vmemmap pages,  we do not call
> prepare_vmemmap_page().
> 
> When we free some vmemmap pages of a HugeTLB
> page, if the PG_reserved of the vmemmap page is set,
> we call free_vmemmap_page() to free it to buddy,
> otherwise call free_page(). What is your opinion?

That would also work. Then, please include "bootmem" as part of the
function name. If you plan on using my suggestion, you can drop
"bootmem" from the name as it works for both types of pages.


-- 
Thanks,

David / dhildenb

