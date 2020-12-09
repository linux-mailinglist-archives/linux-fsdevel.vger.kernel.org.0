Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C492D3DF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 09:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgLIIwV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 03:52:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21507 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727899AbgLIIwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607503845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LdLylCpNHPguVJcRn3o1EL6W44butEOXO57bu4FDAhM=;
        b=YgT3ipJxPh0MU7DkyJF3eq8W7Ytuf5o4j3Qp+9O13tSZxdojtkdINqg3WEtke5S7tIeuql
        zDk6XsGyJb95+NCJVfTEFmBMdoKygtAc93kzAIfnhSahs7hlA2cyytQ38Du8u/rvUE9VDn
        UQcLCatbyNeQUiOdl3843XEH7bRaDg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-uMFA1StQO_6Hp9sFhmU8gQ-1; Wed, 09 Dec 2020 03:50:41 -0500
X-MC-Unique: uMFA1StQO_6Hp9sFhmU8gQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A20E11065F8E;
        Wed,  9 Dec 2020 08:50:02 +0000 (UTC)
Received: from [10.36.114.167] (ovpn-114-167.ams2.redhat.com [10.36.114.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6688A6F139;
        Wed,  9 Dec 2020 08:49:55 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <096ee806-b371-c22b-9066-8891935fbd5e@redhat.com>
Date:   Wed, 9 Dec 2020 09:49:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtWepk0EXc_fCtS83gvhfKpMrXxP8k3oWwfhWKmPJ3jjwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.12.20 08:36, Muchun Song wrote:
> On Mon, Dec 7, 2020 at 8:39 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 30.11.20 16:18, Muchun Song wrote:
>>> In the later patch, we can use the free_vmemmap_page() to free the
>>> unused vmemmap pages and initialize a page for vmemmap page using
>>> via prepare_vmemmap_page().
>>>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>>  include/linux/bootmem_info.h | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
>>> index 4ed6dee1adc9..239e3cc8f86c 100644
>>> --- a/include/linux/bootmem_info.h
>>> +++ b/include/linux/bootmem_info.h
>>> @@ -3,6 +3,7 @@
>>>  #define __LINUX_BOOTMEM_INFO_H
>>>
>>>  #include <linux/mmzone.h>
>>> +#include <linux/mm.h>
>>>
>>>  /*
>>>   * Types for free bootmem stored in page->lru.next. These have to be in
>>> @@ -22,6 +23,29 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
>>>  void get_page_bootmem(unsigned long info, struct page *page,
>>>                     unsigned long type);
>>>  void put_page_bootmem(struct page *page);
>>> +
>>> +static inline void free_vmemmap_page(struct page *page)
>>> +{
>>> +     VM_WARN_ON(!PageReserved(page) || page_ref_count(page) != 2);
>>> +
>>> +     /* bootmem page has reserved flag in the reserve_bootmem_region */
>>> +     if (PageReserved(page)) {
>>> +             unsigned long magic = (unsigned long)page->freelist;
>>> +
>>> +             if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
>>> +                     put_page_bootmem(page);
>>> +             else
>>> +                     WARN_ON(1);
>>> +     }
>>> +}
>>> +
>>> +static inline void prepare_vmemmap_page(struct page *page)
>>> +{
>>> +     unsigned long section_nr = pfn_to_section_nr(page_to_pfn(page));
>>> +
>>> +     get_page_bootmem(section_nr, page, SECTION_INFO);
>>> +     mark_page_reserved(page);
>>> +}
>>
>> Can you clarify in the description when exactly these functions are
>> called and on which type of pages?
>>
>> Would indicating "bootmem" in the function names make it clearer what we
>> are dealing with?
>>
>> E.g., any memory allocated via the memblock allocator and not via the
>> buddy will be makred reserved already in the memmap. It's unclear to me
>> why we need the mark_page_reserved() here - can you enlighten me? :)
> 
> Sorry for ignoring this question. Because the vmemmap pages are allocated
> from the bootmem allocator which is marked as PG_reserved. For those bootmem
> pages, we should call put_page_bootmem for free. You can see that we
> clear the PG_reserved in the put_page_bootmem. In order to be consistent,
> the prepare_vmemmap_page also marks the page as PG_reserved.

I don't think that really makes sense.

After put_page_bootmem() put the last reference, it clears PG_reserved
and hands the page over to the buddy via free_reserved_page(). From that
point on, further get_page_bootmem() would be completely wrong and
dangerous.

Both, put_page_bootmem() and get_page_bootmem() rely on the fact that
they are dealing with memblock allcoations - marked via PG_reserved. If
prepare_vmemmap_page() would be called on something that's *not* coming
from the memblock allocator, it would be completely broken - or am I
missing something?

AFAIKT, there should rather be a BUG_ON(!PageReserved(page)) in
prepare_vmemmap_page() - or proper handling to deal with !memblock
allocations.


And as I said, indicating "bootmem" as part of the function names might
make it clearer that this is not for getting any vmemmap pages (esp.
allocated when hotplugging memory).

-- 
Thanks,

David / dhildenb

