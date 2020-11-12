Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5842B09D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 17:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgKLQWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 11:22:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729070AbgKLQWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605198137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZW4Cjdd1Y3wnZ8yyT80IuYNIT2MC5nPP7PSwDghDV1Q=;
        b=NEZQgmYo85TTjpcF52kzhlxScWrst6z9esMx+i5EwXxrIS3msnsQjVGcL7tFMMqx4sIH3k
        tGNLm17SZpOM3NkWWalzbEYCG52owE8pc5rYln6ehsO5Js7yh6W78KCOi8zhCRiBlYUG2D
        CWOO5exy241iIVLe6zU3iz09mfPXtPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-hg3tEq1OPgmdqYl9GCjLuQ-1; Thu, 12 Nov 2020 11:22:13 -0500
X-MC-Unique: hg3tEq1OPgmdqYl9GCjLuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB783100F7A6;
        Thu, 12 Nov 2020 16:22:08 +0000 (UTC)
Received: from [10.36.115.61] (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6D5B6EF48;
        Thu, 12 Nov 2020 16:22:01 +0000 (UTC)
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
References: <20201110151444.20662-1-rppt@kernel.org>
 <20201110151444.20662-3-rppt@kernel.org>
 <9e2fafd7-abb0-aa79-fa66-cd8662307446@redhat.com>
 <20201110180648.GB4758@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3194b507-a85f-965a-e0eb-512a79ede6a9@redhat.com>
Date:   Thu, 12 Nov 2020 17:22:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201110180648.GB4758@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10.11.20 19:06, Mike Rapoport wrote:
> On Tue, Nov 10, 2020 at 06:17:26PM +0100, David Hildenbrand wrote:
>> On 10.11.20 16:14, Mike Rapoport wrote:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> It will be used by the upcoming secret memory implementation.
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>> ---
>>>    mm/internal.h | 3 +++
>>>    mm/mmap.c     | 5 ++---
>>>    2 files changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index c43ccdddb0f6..ae146a260b14 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -348,6 +348,9 @@ static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
>>>    extern void mlock_vma_page(struct page *page);
>>>    extern unsigned int munlock_vma_page(struct page *page);
>>> +extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
>>> +			      unsigned long len);
>>> +
>>>    /*
>>>     * Clear the page's PageMlocked().  This can be useful in a situation where
>>>     * we want to unconditionally remove a page from the pagecache -- e.g.,
>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>> index 61f72b09d990..c481f088bd50 100644
>>> --- a/mm/mmap.c
>>> +++ b/mm/mmap.c
>>> @@ -1348,9 +1348,8 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
>>>    	return hint;
>>>    }
>>> -static inline int mlock_future_check(struct mm_struct *mm,
>>> -				     unsigned long flags,
>>> -				     unsigned long len)
>>> +int mlock_future_check(struct mm_struct *mm, unsigned long flags,
>>> +		       unsigned long len)
>>>    {
>>>    	unsigned long locked, lock_limit;
>>>
>>
>> So, an interesting question is if you actually want to charge secretmem
>> pages against mlock now, or if you want a dedicated secretmem cgroup
>> controller instead?
> 
> Well, with the current implementation there are three limits an
> administrator can use to control secretmem limits: mlock, memcg and
> kernel parameter.
> 
> The kernel parameter puts a global upper limit for secretmem usage,
> memcg accounts all secretmem allocations, including the unused memory in
> large pages caching and mlock allows per task limit for secretmem
> mappings, well, like mlock does.
> 
> I didn't consider a dedicated cgroup, as it seems we already have enough
> existing knobs and a new one would be unnecessary.

To me it feels like the mlock() limit is a wrong fit for secretmem. But 
maybe there are other cases of using the mlock() limit without actually 
doing mlock() that I am not aware of (most probably :) )?

I mean, my concern is not earth shattering, this can be reworked later. 
As I said, it just feels wrong.

-- 
Thanks,

David / dhildenb

