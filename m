Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C9C3049CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbhAZFX1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:23:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726226AbhAYJRc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611566152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OHyRB4r9LsoAmUVFq/tMDsAJkKe9tgKuKFCVx0tyrGk=;
        b=KFDpfT9oXzepiiTqyJ8Ro4YjDVGY6Qcz5MNg/KN7luiIUC2OQ0f4oQVn4radYP7tOJDWoy
        xr+F1voT8jWWnWGAvdF6ca9RmoGCQ5Z1WR9vCIiF2PL/3Qdsgt4NToq56+l0ia4hjXNrqj
        9Gus1aQdUjdi1Ez+0dZX9DeVuSuCqM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-I5ZD6akYP2mVebhc7q7IgQ-1; Mon, 25 Jan 2021 04:15:50 -0500
X-MC-Unique: I5ZD6akYP2mVebhc7q7IgQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CC04879500;
        Mon, 25 Jan 2021 09:15:46 +0000 (UTC)
Received: from [10.36.115.13] (ovpn-115-13.ams2.redhat.com [10.36.115.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE6A65D9D7;
        Mon, 25 Jan 2021 09:15:37 +0000 (UTC)
Subject: Re: [External] Re: [PATCH v13 05/12] mm: hugetlb: allocate the
 vmemmap pages associated with each HugeTLB page
To:     Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>
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
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com>
 <6a68fde-583d-b8bb-a2c8-fbe32e03b@google.com>
 <CAMZfGtXpg30RhrPm836S6Tr09ynKRPG=_DXtXt9sVTTponnC-g@mail.gmail.com>
 <CAMZfGtX19x8m+Bkvj+8Ue31m5L_4DmgtZevp2fd++JL7nuSzWw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <552e8214-bc6f-8d90-0ed8-b3aff75d0e47@redhat.com>
Date:   Mon, 25 Jan 2021 10:15:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtX19x8m+Bkvj+8Ue31m5L_4DmgtZevp2fd++JL7nuSzWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25.01.21 08:41, Muchun Song wrote:
> On Mon, Jan 25, 2021 at 2:40 PM Muchun Song <songmuchun@bytedance.com> wrote:
>>
>> On Mon, Jan 25, 2021 at 8:05 AM David Rientjes <rientjes@google.com> wrote:
>>>
>>>
>>> On Sun, 17 Jan 2021, Muchun Song wrote:
>>>
>>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>>>> index ce4be1fa93c2..3b146d5949f3 100644
>>>> --- a/mm/sparse-vmemmap.c
>>>> +++ b/mm/sparse-vmemmap.c
>>>> @@ -29,6 +29,7 @@
>>>>  #include <linux/sched.h>
>>>>  #include <linux/pgtable.h>
>>>>  #include <linux/bootmem_info.h>
>>>> +#include <linux/delay.h>
>>>>
>>>>  #include <asm/dma.h>
>>>>  #include <asm/pgalloc.h>
>>>> @@ -40,7 +41,8 @@
>>>>   * @remap_pte:               called for each non-empty PTE (lowest-level) entry.
>>>>   * @reuse_page:              the page which is reused for the tail vmemmap pages.
>>>>   * @reuse_addr:              the virtual address of the @reuse_page page.
>>>> - * @vmemmap_pages:   the list head of the vmemmap pages that can be freed.
>>>> + * @vmemmap_pages:   the list head of the vmemmap pages that can be freed
>>>> + *                   or is mapped from.
>>>>   */
>>>>  struct vmemmap_remap_walk {
>>>>       void (*remap_pte)(pte_t *pte, unsigned long addr,
>>>> @@ -50,6 +52,10 @@ struct vmemmap_remap_walk {
>>>>       struct list_head *vmemmap_pages;
>>>>  };
>>>>
>>>> +/* The gfp mask of allocating vmemmap page */
>>>> +#define GFP_VMEMMAP_PAGE             \
>>>> +     (GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN | __GFP_THISNODE)
>>>> +
>>>
>>> This is unnecessary, just use the gfp mask directly in allocator.
>>
>> Will do. Thanks.
>>
>>>
>>>>  static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
>>>>                             unsigned long end,
>>>>                             struct vmemmap_remap_walk *walk)
>>>> @@ -228,6 +234,75 @@ void vmemmap_remap_free(unsigned long start, unsigned long end,
>>>>       free_vmemmap_page_list(&vmemmap_pages);
>>>>  }
>>>>
>>>> +static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
>>>> +                             struct vmemmap_remap_walk *walk)
>>>> +{
>>>> +     pgprot_t pgprot = PAGE_KERNEL;
>>>> +     struct page *page;
>>>> +     void *to;
>>>> +
>>>> +     BUG_ON(pte_page(*pte) != walk->reuse_page);
>>>> +
>>>> +     page = list_first_entry(walk->vmemmap_pages, struct page, lru);
>>>> +     list_del(&page->lru);
>>>> +     to = page_to_virt(page);
>>>> +     copy_page(to, (void *)walk->reuse_addr);
>>>> +
>>>> +     set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
>>>> +}
>>>> +
>>>> +static void alloc_vmemmap_page_list(struct list_head *list,
>>>> +                                 unsigned long start, unsigned long end)
>>>> +{
>>>> +     unsigned long addr;
>>>> +
>>>> +     for (addr = start; addr < end; addr += PAGE_SIZE) {
>>>> +             struct page *page;
>>>> +             int nid = page_to_nid((const void *)addr);
>>>> +
>>>> +retry:
>>>> +             page = alloc_pages_node(nid, GFP_VMEMMAP_PAGE, 0);
>>>> +             if (unlikely(!page)) {
>>>> +                     msleep(100);
>>>> +                     /*
>>>> +                      * We should retry infinitely, because we cannot
>>>> +                      * handle allocation failures. Once we allocate
>>>> +                      * vmemmap pages successfully, then we can free
>>>> +                      * a HugeTLB page.
>>>> +                      */
>>>> +                     goto retry;
>>>
>>> Ugh, I don't think this will work, there's no guarantee that we'll ever
>>> succeed and now we can't free a 2MB hugepage because we cannot allocate a
>>> 4KB page.  We absolutely have to ensure we make forward progress here.
>>
>> This can trigger a OOM when there is no memory and kill someone to release
>> some memory. Right?
>>
>>>
>>> We're going to be freeing the hugetlb page after this succeeeds, can we
>>> not use part of the hugetlb page that we're freeing for this memory
>>> instead?
>>
>> It seems a good idea. We can try to allocate memory firstly, if successful,
>> just use the new page to remap (it can reduce memory fragmentation).
>> If not, we can use part of the hugetlb page to remap. What's your opinion
>> about this?
> 
> If the HugeTLB page is a gigantic page which is allocated from
> CMA. In this case, we cannot use part of the hugetlb page to remap.
> Right?

Right; and I don't think the "reuse part of a huge page as vmemmap while
freeing, while that part itself might not have a proper vmemmap yet (or
might cover itself now)" is particularly straight forward. Maybe I'm
wrong :)

Also, watch out for huge pages on ZONE_MOVABLE, in that case you also
shouldn't allocate the vmemmap from there ...

-- 
Thanks,

David / dhildenb

