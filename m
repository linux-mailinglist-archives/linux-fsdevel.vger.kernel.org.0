Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55FC31C72B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 09:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhBPIO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 03:14:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59430 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229764AbhBPIOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 03:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613463206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrBI3gmDGE4IcqlEPbbLaR/5KOLeuQUWrbl5wiK6Nv8=;
        b=Pf0V6udfHXXGDunQ80myyXhHP0Hcn//ApuGHWaGGGxenr8T76TvDLHnCuNbyukz//1DQD5
        zGHjuL9Y501bp28DSl+dfs1RMD7a6Uxw9ZSBO3eU56t7mcDs7FXdfO3og4pjyYLtmdwzFc
        rfjMYbl8YuN3FaufPuJZzw7GrFToNv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-7mnurP3rNQGA5ySur9Yqbw-1; Tue, 16 Feb 2021 03:13:22 -0500
X-MC-Unique: 7mnurP3rNQGA5ySur9Yqbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02480189CD2E;
        Tue, 16 Feb 2021 08:13:18 +0000 (UTC)
Received: from [10.36.114.70] (ovpn-114-70.ams2.redhat.com [10.36.114.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0FB57216B;
        Tue, 16 Feb 2021 08:13:09 +0000 (UTC)
Subject: Re: [External] Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
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
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAMZfGtXgVUvCejpxu1o5WDvmQ7S88rWqGi3DAGM6j5NHJgtdcg@mail.gmail.com>
 <YCpN38i75olgispI@dhcp22.suse.cz>
 <CAMZfGtUXJTaMo36aB4nTFuYFy3qfWW69o=4uUo-FjocO8obDgw@mail.gmail.com>
 <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com>
 <YCpmlGuoTakPJs1u@dhcp22.suse.cz>
 <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
 <YCp04NVBZpZZ5k7G@dhcp22.suse.cz>
 <CAMZfGtV8-yJa_eGYtSXc0YY8KhYpgUo=pfj6TZ9zMo8fbz8nWA@mail.gmail.com>
 <YCqhDZ0EAgvCz+wX@dhcp22.suse.cz>
 <CAMZfGtW6n_YUbZOPFbivzn-HP4Q2yi0DrUoQ3JAjSYy5m17VWw@mail.gmail.com>
 <YCrFY4ODu/O9KSND@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4f8664fb-0d65-b7d6-39d6-2ce5fc86623a@redhat.com>
Date:   Tue, 16 Feb 2021 09:13:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCrFY4ODu/O9KSND@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15.02.21 20:02, Michal Hocko wrote:
> On Tue 16-02-21 01:48:29, Muchun Song wrote:
>> On Tue, Feb 16, 2021 at 12:28 AM Michal Hocko <mhocko@suse.com> wrote:
>>>
>>> On Mon 15-02-21 23:36:49, Muchun Song wrote:
>>> [...]
>>>>> There shouldn't be any real reason why the memory allocation for
>>>>> vmemmaps, or handling vmemmap in general, has to be done from within the
>>>>> hugetlb lock and therefore requiring a non-sleeping semantic. All that
>>>>> can be deferred to a more relaxed context. If you want to make a
>>>>
>>>> Yeah, you are right. We can put the freeing hugetlb routine to a
>>>> workqueue. Just like I do in the previous version (before v13) patch.
>>>> I will pick up these patches.
>>>
>>> I haven't seen your v13 and I will unlikely have time to revisit that
>>> version. I just wanted to point out that the actual allocation doesn't
>>> have to happen from under the spinlock. There are multiple ways to go
>>> around that. Dropping the lock would be one of them. Preallocation
>>> before the spin lock is taken is another. WQ is certainly an option but
>>> I would take it as the last resort when other paths are not feasible.
>>>
>>
>> "Dropping the lock" and "Preallocation before the spin lock" can limit
>> the context of put_page to non-atomic context. I am not sure if there
>> is a page puted somewhere under an atomic context. e.g. compaction.
>> I am not an expert on this.
> 
> Then do a due research or ask for a help from the MM community. Do
> not just try to go around harder problems and somehow duct tape a
> solution. I am sorry for sounding harsh here but this is a repetitive
> pattern.
> 
> Now to the merit. put_page can indeed be called from all sorts of
> contexts. And it might be indeed impossible to guarantee that hugetlb
> pages are never freed up from an atomic context. Requiring that would be
> even hard to maintain longterm. There are ways around that, I believe,
> though.
> 
> The most simple one that I can think of right now would be using
> in_atomic() rather than in_task() check free_huge_page. IIRC recent
> changes would allow in_atomic to be reliable also on !PREEMPT kernels
> (via RCU tree, not sure where this stands right now). That would make
> __free_huge_page always run in a non-atomic context which sounds like an
> easy enough solution.
> Another way would be to keep a pool of ready pages to use in case of
> GFP_NOWAIT allocation fails and have means to keep that pool replenished
> when needed. Would it be feasible to reused parts of the freed page in
> the worst case?

As already discussed, this is only possible when the huge page does not 
reside on ZONE_MOVABLE/CMA.

In addition, we can no longer form a huge page at that memory location ever.

-- 
Thanks,

David / dhildenb

