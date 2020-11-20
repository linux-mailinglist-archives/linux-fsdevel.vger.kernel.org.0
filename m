Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AEE2BA674
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 10:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgKTJn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 04:43:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727310AbgKTJn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605865435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwdHt+LWlPpn5AnW9j4bNwWOooSLgU3rF8T4LtW1bPs=;
        b=gajonlih1PfsaIPo4Cvp6gFZ92/HE4hF8wgzoGTLO86BRJ7dMFux8T0hh5Y+HP4TC98h0M
        Tmeul0jsO4FSBAvgqoQr3/3FH3ZxoUqTgr8SpOq4nVF9ZUYJ9FYIo7eo63EPkKog6NxznN
        XXluYjjfsO4l5Wh0nKTQE8BgNL0iMMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-fR3VtGVkMPKYU73JVMnOig-1; Fri, 20 Nov 2020 04:43:51 -0500
X-MC-Unique: fR3VtGVkMPKYU73JVMnOig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B6011835AA2;
        Fri, 20 Nov 2020 09:43:47 +0000 (UTC)
Received: from [10.36.114.78] (ovpn-114-78.ams2.redhat.com [10.36.114.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECAF619D9F;
        Fri, 20 Nov 2020 09:43:40 +0000 (UTC)
Subject: Re: [PATCH v5 00/21] Free some vmemmap pages of hugetlb page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120084202.GJ3200@dhcp22.suse.cz>
 <6b1533f7-69c6-6f19-fc93-c69750caaecc@redhat.com>
 <20201120093912.GM3200@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <eda50930-05b5-0ad9-2985-8b6328f92cec@redhat.com>
Date:   Fri, 20 Nov 2020 10:43:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201120093912.GM3200@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20.11.20 10:39, Michal Hocko wrote:
> On Fri 20-11-20 10:27:05, David Hildenbrand wrote:
>> On 20.11.20 09:42, Michal Hocko wrote:
>>> On Fri 20-11-20 14:43:04, Muchun Song wrote:
>>> [...]
>>>
>>> Thanks for improving the cover letter and providing some numbers. I have
>>> only glanced through the patchset because I didn't really have more time
>>> to dive depply into them.
>>>
>>> Overall it looks promissing. To summarize. I would prefer to not have
>>> the feature enablement controlled by compile time option and the kernel
>>> command line option should be opt-in. I also do not like that freeing
>>> the pool can trigger the oom killer or even shut the system down if no
>>> oom victim is eligible.
>>>
>>> One thing that I didn't really get to think hard about is what is the
>>> effect of vmemmap manipulation wrt pfn walkers. pfn_to_page can be
>>> invalid when racing with the split. How do we enforce that this won't
>>> blow up?
>>
>> I have the same concerns - the sections are online the whole time and
>> anybody with pfn_to_online_page() can grab them
>>
>> I think we have similar issues with memory offlining when removing the
>> vmemmap, it's just very hard to trigger and we can easily protect by
>> grabbing the memhotplug lock.
> 
> I am not sure we can/want to span memory hotplug locking out to all pfn
> walkers. But you are right that the underlying problem is similar but
> much harder to trigger because vmemmaps are only removed when the
> physical memory is hotremoved and that happens very seldom. Maybe it
> will happen more with virtualization usecases. But this work makes it
> even more tricky. If a pfn walker races with a hotremove then it would
> just blow up when accessing the unmapped physical address space. For
> this feature a pfn walker would just grab a real struct page re-used for
> some unpredictable use under its feet. Any failure would be silent and
> hard to debug.

Right, we don't want the memory hotplug locking, thus discussions 
regarding rcu. Luckily, for now I never saw a BUG report regarding this 
- maybe because the time between memory offlining (offline_pages()) and 
memory/vmemmap getting removed (try_remove_memory()) is just too long. 
Someone would have to sleep after pfn_to_online_page() for quite a while 
to trigger it.

> 
> [...]
>> To keep things easy, maybe simply never allow to free these hugetlb pages
>> again for now? If they were reserved during boot and the vmemmap condensed,
>> then just let them stick around for all eternity.
> 
> Not sure I understand. Do you propose to only free those vmemmap pages
> when the pool is initialized during boot time and never allow to free
> them up? That would certainly make it safer and maybe even simpler wrt
> implementation.

Exactly, let's keep it simple for now. I guess most use cases of this 
(virtualization, databases, ...) will allocate hugepages during boot and 
never free them.

-- 
Thanks,

David / dhildenb

