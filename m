Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032F12D3F8E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 11:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgLIKIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 05:08:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729713AbgLIKIU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607508414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4m7vcxbiJttn8QYkTQIy6cn6rx9Zw5Muq0IpNVCW1eU=;
        b=ddXww6i9ks1O9q20NPZvPQyq+0b2Z6mkhXGCUQYSmW+HIEx5R5e+34c2ZhpgNidt9NvEs3
        joGNmjVmLoNTcnw5HcU1u6Pmu2/SZ7SDP9bbHvZ4y6ooZhJ9szA5mrYwAgTetqulT0GvQg
        LeQPwXjeejFUjtlmaDyagA26a2JBZQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-KYNyJPTwP3ei1ybgJrgtcQ-1; Wed, 09 Dec 2020 05:06:49 -0500
X-MC-Unique: KYNyJPTwP3ei1ybgJrgtcQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D5848030AF;
        Wed,  9 Dec 2020 10:06:46 +0000 (UTC)
Received: from [10.36.114.167] (ovpn-114-167.ams2.redhat.com [10.36.114.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA1BF5D9D3;
        Wed,  9 Dec 2020 10:06:40 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4b8a9389-1704-4d8c-ec58-abd753814dd9@redhat.com>
Date:   Wed, 9 Dec 2020 11:06:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtV5200NZXH9Z_Z9qXo5FCd9E6JOTXjQtzcF0xGi-gCuPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.12.20 11:03, Muchun Song wrote:
> On Wed, Dec 9, 2020 at 5:57 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 30.11.20 16:18, Muchun Song wrote:
>>> We only can free the tail vmemmap pages of HugeTLB to the buddy allocator
>>> when the size of struct page is a power of two.
>>>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>>  mm/hugetlb_vmemmap.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>>> index 51152e258f39..ad8fc61ea273 100644
>>> --- a/mm/hugetlb_vmemmap.c
>>> +++ b/mm/hugetlb_vmemmap.c
>>> @@ -111,6 +111,11 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>>>       unsigned int nr_pages = pages_per_huge_page(h);
>>>       unsigned int vmemmap_pages;
>>>
>>> +     if (!is_power_of_2(sizeof(struct page))) {
>>> +             pr_info("disable freeing vmemmap pages for %s\n", h->name);
>>
>> I'd just drop that pr_info(). Users are able to observe that it's
>> working (below), so they are able to identify that it's not working as well.
> 
> The below is just a pr_debug. Do you suggest converting it to pr_info?

Good question. I wonder if users really have to know in most cases.
Maybe pr_debug() is good enough in environments where we want to debug
why stuff is not working as expected.

-- 
Thanks,

David / dhildenb

