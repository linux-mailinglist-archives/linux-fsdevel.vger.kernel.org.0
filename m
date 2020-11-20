Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBA72BB1E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 19:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgKTSAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 13:00:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727215AbgKTSAf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605895233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JxskEXwutt4P1nZSKgawl/xEgyUPfquuR5hR5qwSjZM=;
        b=YAofb6qXRZb424IaniSlwERtCoNEUtaY7B5h73IDegWhCecykWHJKmr0i/bJPGtBYiFc24
        wCKHF4rwNgVk0RMWjBdVXK+uLZumMhWmzgirwZ/n4hzgfRdRT1EO0rfTE9CZ097NtwLmZw
        MGdEvpKqaQKTdXltp/K68k08lKT3N54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-KXpfjzaZNAWdTW2OD65koQ-1; Fri, 20 Nov 2020 13:00:27 -0500
X-MC-Unique: KXpfjzaZNAWdTW2OD65koQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C42D100C601;
        Fri, 20 Nov 2020 18:00:23 +0000 (UTC)
Received: from [10.36.114.78] (ovpn-114-78.ams2.redhat.com [10.36.114.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCE8260862;
        Fri, 20 Nov 2020 18:00:16 +0000 (UTC)
Subject: Re: [PATCH v5 00/21] Free some vmemmap pages of hugetlb page
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, song.bao.hua@hisilicon.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120084202.GJ3200@dhcp22.suse.cz>
 <6b1533f7-69c6-6f19-fc93-c69750caaecc@redhat.com>
 <20201120093912.GM3200@dhcp22.suse.cz>
 <eda50930-05b5-0ad9-2985-8b6328f92cec@redhat.com>
 <55e53264-a07a-a3ec-4253-e72c718b4ee6@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <af95bcad-80dd-d2a4-0178-b9d2869e97cf@redhat.com>
Date:   Fri, 20 Nov 2020 19:00:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <55e53264-a07a-a3ec-4253-e72c718b4ee6@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20.11.20 18:45, Mike Kravetz wrote:
> On 11/20/20 1:43 AM, David Hildenbrand wrote:
>> On 20.11.20 10:39, Michal Hocko wrote:
>>> On Fri 20-11-20 10:27:05, David Hildenbrand wrote:
>>>> On 20.11.20 09:42, Michal Hocko wrote:
>>>>> On Fri 20-11-20 14:43:04, Muchun Song wrote:
>>>>> [...]
>>>>>
>>>>> Thanks for improving the cover letter and providing some numbers. I have
>>>>> only glanced through the patchset because I didn't really have more time
>>>>> to dive depply into them.
>>>>>
>>>>> Overall it looks promissing. To summarize. I would prefer to not have
>>>>> the feature enablement controlled by compile time option and the kernel
>>>>> command line option should be opt-in. I also do not like that freeing
>>>>> the pool can trigger the oom killer or even shut the system down if no
>>>>> oom victim is eligible.
>>>>>
>>>>> One thing that I didn't really get to think hard about is what is the
>>>>> effect of vmemmap manipulation wrt pfn walkers. pfn_to_page can be
>>>>> invalid when racing with the split. How do we enforce that this won't
>>>>> blow up?
>>>>
>>>> I have the same concerns - the sections are online the whole time and
>>>> anybody with pfn_to_online_page() can grab them
>>>>
>>>> I think we have similar issues with memory offlining when removing the
>>>> vmemmap, it's just very hard to trigger and we can easily protect by
>>>> grabbing the memhotplug lock.
>>>
>>> I am not sure we can/want to span memory hotplug locking out to all pfn
>>> walkers. But you are right that the underlying problem is similar but
>>> much harder to trigger because vmemmaps are only removed when the
>>> physical memory is hotremoved and that happens very seldom. Maybe it
>>> will happen more with virtualization usecases. But this work makes it
>>> even more tricky. If a pfn walker races with a hotremove then it would
>>> just blow up when accessing the unmapped physical address space. For
>>> this feature a pfn walker would just grab a real struct page re-used for
>>> some unpredictable use under its feet. Any failure would be silent and
>>> hard to debug.
>>
>> Right, we don't want the memory hotplug locking, thus discussions regarding rcu. Luckily, for now I never saw a BUG report regarding this - maybe because the time between memory offlining (offline_pages()) and memory/vmemmap getting removed (try_remove_memory()) is just too long. Someone would have to sleep after pfn_to_online_page() for quite a while to trigger it.
>>
>>>
>>> [...]
>>>> To keep things easy, maybe simply never allow to free these hugetlb pages
>>>> again for now? If they were reserved during boot and the vmemmap condensed,
>>>> then just let them stick around for all eternity.
>>>
>>> Not sure I understand. Do you propose to only free those vmemmap pages
>>> when the pool is initialized during boot time and never allow to free
>>> them up? That would certainly make it safer and maybe even simpler wrt
>>> implementation.
>>
>> Exactly, let's keep it simple for now. I guess most use cases of this (virtualization, databases, ...) will allocate hugepages during boot and never free them.
> 
> Not sure if I agree with that last statement.  Database and virtualization
> use cases from my employer allocate allocate hugetlb pages after boot.  It
> is shortly after boot, but still not from boot/kernel command line.

Right, but the ones that care about this optimization for now could be 
converted, I assume? I mean we are talking about "opt-in" from 
sysadmins, so requiring to specify a different cmdline parameter does 
not sound to weird to me. And it should simplify a first version quite a 
lot.

The more I think about this, the more I believe doing these vmemmap 
modifications after boot are very dangerous.

> 
> Somewhat related, but not exactly addressing this issue ...
> 
> One idea discussed in a previous patch set was to disable PMD/huge page
> mapping of vmemmap if this feature was enabled.  This would eliminate a bunch
> of the complex code doing page table manipulation.  It does not address
> the issue of struct page pages going away which is being discussed here,
> but it could be a way to simply the first version of this code.  If this
> is going to be an 'opt in' feature as previously suggested, then eliminating
> the  PMD/huge page vmemmap mapping may be acceptable.  My guess is that
> sysadmins would only 'opt in' if they expect most of system memory to be used
> by hugetlb pages.  We certainly have database and virtualization use cases
> where this is true.

It sounds like a hack to me, which does not fully solve the problem. But 
yeah, it's a simplification.

-- 
Thanks,

David / dhildenb

