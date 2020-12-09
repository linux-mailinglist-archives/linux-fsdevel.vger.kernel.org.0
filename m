Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C3A2D45C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 16:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgLIPuO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 10:50:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbgLIPuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607528922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FAsAkjC0ZKqfT8nIOeG7vx7V2m4q/wdL4+UBTIQYf7s=;
        b=FziFlAmK6XZkalhobYFVEbjNC7YAdwga/RmZLWU0WRP4dLa30sFJZUyYdt5LSwa/VTKdC3
        gRlI/pDqrQDbbvmQjzZH2ZPc1KWN+PgNZr7gM9VrzU75u38939VAh0lWKNuPS5hnJzank8
        69TL7NZX7051rCAb7Yo2Yn2M0W1ThgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-qPQfirWWMnaXvDC8Ww-bRQ-1; Wed, 09 Dec 2020 10:48:38 -0500
X-MC-Unique: qPQfirWWMnaXvDC8Ww-bRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D4748049F8;
        Wed,  9 Dec 2020 15:47:31 +0000 (UTC)
Received: from [10.36.113.30] (ovpn-113-30.ams2.redhat.com [10.36.113.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 731295D9D3;
        Wed,  9 Dec 2020 15:47:23 +0000 (UTC)
Subject: Re: [External] Re: [PATCH v7 06/15] mm/hugetlb: Disable freeing
 vmemmap if struct page size is not power of two
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
 <20201130151838.11208-7-songmuchun@bytedance.com>
 <ba57ea7d-709b-bf36-d48a-cc72a26012cc@redhat.com>
 <CAMZfGtV5200NZXH9Z_Z9qXo5FCd9E6JOTXjQtzcF0xGi-gCuPg@mail.gmail.com>
 <4b8a9389-1704-4d8c-ec58-abd753814dd9@redhat.com>
 <a6d11bc6-033d-3a0b-94ce-cbd556120b6d@redhat.com>
 <CAMZfGtWfz8DcwKBLdf3j0x9Dt6ZvOd+MvjX6yXrAoKDeXxW95w@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <33779de1-7a7a-aa5c-e756-92925d4b097d@redhat.com>
Date:   Wed, 9 Dec 2020 16:47:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtWfz8DcwKBLdf3j0x9Dt6ZvOd+MvjX6yXrAoKDeXxW95w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.12.20 16:13, Muchun Song wrote:
> On Wed, Dec 9, 2020 at 6:10 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 09.12.20 11:06, David Hildenbrand wrote:
>>> On 09.12.20 11:03, Muchun Song wrote:
>>>> On Wed, Dec 9, 2020 at 5:57 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 30.11.20 16:18, Muchun Song wrote:
>>>>>> We only can free the tail vmemmap pages of HugeTLB to the buddy allocator
>>>>>> when the size of struct page is a power of two.
>>>>>>
>>>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>>>> ---
>>>>>>  mm/hugetlb_vmemmap.c | 5 +++++
>>>>>>  1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>>>>>> index 51152e258f39..ad8fc61ea273 100644
>>>>>> --- a/mm/hugetlb_vmemmap.c
>>>>>> +++ b/mm/hugetlb_vmemmap.c
>>>>>> @@ -111,6 +111,11 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>>>>>>       unsigned int nr_pages = pages_per_huge_page(h);
>>>>>>       unsigned int vmemmap_pages;
>>>>>>
>>>>>> +     if (!is_power_of_2(sizeof(struct page))) {
>>>>>> +             pr_info("disable freeing vmemmap pages for %s\n", h->name);
>>>>>
>>>>> I'd just drop that pr_info(). Users are able to observe that it's
>>>>> working (below), so they are able to identify that it's not working as well.
>>>>
>>>> The below is just a pr_debug. Do you suggest converting it to pr_info?
>>>
>>> Good question. I wonder if users really have to know in most cases.
>>> Maybe pr_debug() is good enough in environments where we want to debug
>>> why stuff is not working as expected.
>>>
>>
>> Oh, another thought, can we glue availability of
>> HUGETLB_PAGE_FREE_VMEMMAP (or a new define based on the config and the
>> size of a stuct page) to the size of struct page somehow?
>>
>> I mean, it's known at compile time that this will never work.
> 
> I want to define a macro which indicates the size of the
> struct page. There is place (kernel/bounds.c) where can
> do similar things. When I added the following code in
> that file.
> 
>         DEFINE(STRUCT_PAGE_SIZE, sizeof(struct page));
> 
> Then the compiler will output a message like:
> 

Hm, from what I understand you cannot use sizeof() in #if etc. So it
might not be possible after all. At least the compiler should optimize
code like

if (!is_power_of_2(sizeof(struct page))) {
	// either this
} else {
	// or that
}

that can never be reached

-- 
Thanks,

David / dhildenb

