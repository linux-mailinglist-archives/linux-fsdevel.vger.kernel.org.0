Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F5F2B684A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 16:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgKQPKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 10:10:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728348AbgKQPJ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605625798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=avqgkPhMAEZAPZkBU6g1zM+EphNhv69bq0mDQ2MSyGE=;
        b=S8TAwo3s+rzbgiROW+UXpjWuAMeWLY0T/ao/dlLpi6P3/fzg/Cy+miIIhYAZUuSqIcENSN
        JWwM/sonGHJvetmLJA/OD2cFD8YmR/3UEHYlN3hUx2LzUobkeP+BViO5M+M3/JccFmehoQ
        ZJqn+FlptXuQGX05cWf+j/YCY8V4G1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-K75Q0U6RPOe3OPIwoMgYvA-1; Tue, 17 Nov 2020 10:09:53 -0500
X-MC-Unique: K75Q0U6RPOe3OPIwoMgYvA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87EF157090;
        Tue, 17 Nov 2020 15:09:49 +0000 (UTC)
Received: from [10.36.114.99] (ovpn-114-99.ams2.redhat.com [10.36.114.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF2366BF6B;
        Tue, 17 Nov 2020 15:09:40 +0000 (UTC)
Subject: Re: [PATCH v8 2/9] mmap: make mlock_future_check() global
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
References: <20201112190827.GP4758@kernel.org>
 <7A16CA44-782D-4ABA-8D93-76BDD0A90F94@redhat.com>
 <20201115082625.GT4758@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d47fdd2e-a8fa-6792-ca8f-e529be76340c@redhat.com>
Date:   Tue, 17 Nov 2020 16:09:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201115082625.GT4758@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15.11.20 09:26, Mike Rapoport wrote:
> On Thu, Nov 12, 2020 at 09:15:18PM +0100, David Hildenbrand wrote:
>>
>>> Am 12.11.2020 um 20:08 schrieb Mike Rapoport <rppt@kernel.org>:
>>>
>>> ﻿On Thu, Nov 12, 2020 at 05:22:00PM +0100, David Hildenbrand wrote:
>>>>> On 10.11.20 19:06, Mike Rapoport wrote:
>>>>> On Tue, Nov 10, 2020 at 06:17:26PM +0100, David Hildenbrand wrote:
>>>>>> On 10.11.20 16:14, Mike Rapoport wrote:
>>>>>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>>>>>
>>>>>>> It will be used by the upcoming secret memory implementation.
>>>>>>>
>>>>>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>>>>>> ---
>>>>>>>    mm/internal.h | 3 +++
>>>>>>>    mm/mmap.c     | 5 ++---
>>>>>>>    2 files changed, 5 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>>>>> index c43ccdddb0f6..ae146a260b14 100644
>>>>>>> --- a/mm/internal.h
>>>>>>> +++ b/mm/internal.h
>>>>>>> @@ -348,6 +348,9 @@ static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
>>>>>>>    extern void mlock_vma_page(struct page *page);
>>>>>>>    extern unsigned int munlock_vma_page(struct page *page);
>>>>>>> +extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
>>>>>>> +                  unsigned long len);
>>>>>>> +
>>>>>>>    /*
>>>>>>>     * Clear the page's PageMlocked().  This can be useful in a situation where
>>>>>>>     * we want to unconditionally remove a page from the pagecache -- e.g.,
>>>>>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>>>>>> index 61f72b09d990..c481f088bd50 100644
>>>>>>> --- a/mm/mmap.c
>>>>>>> +++ b/mm/mmap.c
>>>>>>> @@ -1348,9 +1348,8 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
>>>>>>>        return hint;
>>>>>>>    }
>>>>>>> -static inline int mlock_future_check(struct mm_struct *mm,
>>>>>>> -                     unsigned long flags,
>>>>>>> -                     unsigned long len)
>>>>>>> +int mlock_future_check(struct mm_struct *mm, unsigned long flags,
>>>>>>> +               unsigned long len)
>>>>>>>    {
>>>>>>>        unsigned long locked, lock_limit;
>>>>>>>
>>>>>>
>>>>>> So, an interesting question is if you actually want to charge secretmem
>>>>>> pages against mlock now, or if you want a dedicated secretmem cgroup
>>>>>> controller instead?
>>>>>
>>>>> Well, with the current implementation there are three limits an
>>>>> administrator can use to control secretmem limits: mlock, memcg and
>>>>> kernel parameter.
>>>>>
>>>>> The kernel parameter puts a global upper limit for secretmem usage,
>>>>> memcg accounts all secretmem allocations, including the unused memory in
>>>>> large pages caching and mlock allows per task limit for secretmem
>>>>> mappings, well, like mlock does.
>>>>>
>>>>> I didn't consider a dedicated cgroup, as it seems we already have enough
>>>>> existing knobs and a new one would be unnecessary.
>>>>
>>>> To me it feels like the mlock() limit is a wrong fit for secretmem. But
>>>> maybe there are other cases of using the mlock() limit without actually
>>>> doing mlock() that I am not aware of (most probably :) )?
>>>
>>> Secretmem does not explicitly calls to mlock() but it does what mlock()
>>> does and a bit more. Citing mlock(2):
>>>
>>>   mlock(),  mlock2(),  and  mlockall()  lock  part  or all of the calling
>>>   process's virtual address space into RAM, preventing that  memory  from
>>>   being paged to the swap area.
>>>
>>> So, based on that secretmem pages are not swappable, I think that
>>> RLIMIT_MEMLOCK is appropriate here.
>>>
>>
>> The page explicitly lists mlock() system calls.
> 
> Well, it's mlock() man page, isn't it? ;-)

;)

> 
> My thinking was that since secretmem does what mlock() does wrt
> swapability, it should at least obey the same limit, i.e.
> RLIMIT_MEMLOCK.

Right, but at least currently, it behaves like any other CMA allocation 
(IIRC they are all unmovable and, therefore, not swappable). In the 
future, if pages would be movable (but not swappable), I guess it might 
makes more sense. I assume we never ever want to swap secretmem.

"man getrlimit" states for RLIMIT_MEMLOCK:

"This is the maximum number of bytes of memory that may be
  locked into RAM.  [...] This limit affects
  mlock(2), mlockall(2), and the mmap(2) MAP_LOCKED operation.
  Since Linux 2.6.9, it also affects the shmctl(2) SHM_LOCK op‐
  eration [...]"

So that place has to be updated as well I guess? Otherwise this might 
come as a surprise for users.

> 
>> E.g., we also don‘t
>> account for gigantic pages - which might be allocated from CMA and are
>> not swappable.
>   
> Do you mean gigantic pages in hugetlbfs?

Yes

> It seems to me that hugetlbfs accounting is a completely different
> story.

I'd say it is right now comparable to secretmem - which is why I though 
similar accounting would make sense.


-- 
Thanks,

David / dhildenb

