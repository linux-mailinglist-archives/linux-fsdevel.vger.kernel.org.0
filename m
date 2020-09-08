Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E396A260E58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 11:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgIHJJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 05:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728564AbgIHJJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599556175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=cRDtdR6wTLU9IRX/JjyB2JuVfrGlE34QbR2ewYFxEPM=;
        b=c8AONDqfBEFhqHR3fFEZqF8IGwQe3LOjOy2jDXV5MSFS/s9rYfr25tNf2k9qhukvT0002u
        UnCB5zyidGcS5eF/Dcr8h59hXVWZs8ECzR61ErfxuXYbydqmJlvnQRsdPFQ7Q1ONeViOei
        jfcfIetbO4F8C6QIIt6ClBFBkgKHgGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-teqCorgwNEqDKSqOOWZICA-1; Tue, 08 Sep 2020 05:09:31 -0400
X-MC-Unique: teqCorgwNEqDKSqOOWZICA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A96501007465;
        Tue,  8 Sep 2020 09:09:27 +0000 (UTC)
Received: from [10.36.115.46] (ovpn-115-46.ams2.redhat.com [10.36.115.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FD335C1BB;
        Tue,  8 Sep 2020 09:09:20 +0000 (UTC)
Subject: Re: [PATCH v4 6/6] mm: secretmem: add ability to reserve memory at
 boot
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
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
References: <20200818141554.13945-1-rppt@kernel.org>
 <20200818141554.13945-7-rppt@kernel.org>
 <03ec586d-c00c-c57e-3118-7186acb7b823@redhat.com>
 <20200819115335.GU752365@kernel.org>
 <10bf57a9-c3c2-e13c-ca50-e872b7a2db0c@redhat.com>
 <20200819173347.GW752365@kernel.org>
 <6c8b30fb-1b6c-d446-0b09-255b79468f7c@redhat.com>
 <20200820155228.GZ752365@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <fdda6ba7-9418-2b52-eee8-ce5e9bfdb6ad@redhat.com>
Date:   Tue, 8 Sep 2020 11:09:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820155228.GZ752365@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20.08.20 17:52, Mike Rapoport wrote:
> On Wed, Aug 19, 2020 at 07:45:29PM +0200, David Hildenbrand wrote:
>> On 19.08.20 19:33, Mike Rapoport wrote:
>>> On Wed, Aug 19, 2020 at 02:10:43PM +0200, David Hildenbrand wrote:
>>>> On 19.08.20 13:53, Mike Rapoport wrote:
>>>>> On Wed, Aug 19, 2020 at 12:49:05PM +0200, David Hildenbrand wrote:
>>>>>> On 18.08.20 16:15, Mike Rapoport wrote:
>>>>>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>>>>>
>>>>>>> Taking pages out from the direct map and bringing them back may create
>>>>>>> undesired fragmentation and usage of the smaller pages in the direct
>>>>>>> mapping of the physical memory.
>>>>>>>
>>>>>>> This can be avoided if a significantly large area of the physical memory
>>>>>>> would be reserved for secretmem purposes at boot time.
>>>>>>>
>>>>>>> Add ability to reserve physical memory for secretmem at boot time using
>>>>>>> "secretmem" kernel parameter and then use that reserved memory as a global
>>>>>>> pool for secret memory needs.
>>>>>>
>>>>>> Wouldn't something like CMA be the better fit? Just wondering. Then, the
>>>>>> memory can actually be reused for something else while not needed.
>>>>>
>>>>> The memory allocated as secret is removed from the direct map and the
>>>>> boot time reservation is intended to reduce direct map fragmentatioan
>>>>> and to avoid splitting 1G pages there. So with CMA I'd still need to
>>>>> allocate 1G chunks for this and once 1G page is dropped from the direct
>>>>> map it still cannot be reused for anything else until it is freed.
>>>>>
>>>>> I could use CMA to do the boot time reservation, but doing the
>>>>> reservesion directly seemed simpler and more explicit to me.
>>>>
>>>> Well, using CMA would give you the possibility to let the memory be used
>>>> for other purposes until you decide it's the right time to take it +
>>>> remove the direct mapping etc.
>>>
>>> I still can't say I follow you here. If I reseve a CMA area as a pool
>>> for secret memory 1G pages, it is still reserved and it still cannot be
>>> used for other purposes, right?
>>
>> So, AFAIK, if you create a CMA pool it can be used for any MOVABLE
>> allocations (similar to ZONE_MOVABLE) until you actually allocate CMA
>> memory from that region. Other allocations on that are will then be
>> migrated away (using alloc_contig_range()).
>>
>> For example, if you have a 1~GiB CMA area, you could allocate 4~MB pages
>> from that CMA area on demand (removing the direct mapping, etc ..), and
>> free when no longer needed (instantiating the direct mapping). The free
>> memory in that area could used for MOVABLE allocations.
> 
> The boot time resrvation is intended to avoid splitting 1G pages in the
> direct map. Without the boot time reservation, we maintain a pool of 2M
> pages so the 1G pages are split and 2M pages remain unsplit.
> 
> If I scale your example to match the requirement to avoid splitting 1G
> pages in the direct map, that would mean creating a CMA area of several
> tens of gigabytes and then doing cma_alloc() of 1G each time we need to
> refill the secretmem pool. 
> 
> It is quite probable that we won't be able to get 1G from CMA after the
> system worked for some time.

Why? It should only contain movable pages, and if that is not the case,
it's a bug we have to fix. It should behave just as ZONE_MOVABLE.
(although I agree that in corner cases, alloc_contig_pages() might
temporarily fail on some chunks - e.g., with long/short-term page
pinnings - in contrast to memory offlining, it won't retry forever)

> 
> With boot time reservation we won't need physcally contiguous 1G to
> satisfy smaller allocation requests for secretmem because we don't need
> to maintain 1G mappings in the secretmem pool.

You can allocate within your CMA area however you want - doesn't need to
be whole gigabytes in case there is no need for it.

Again, the big benefit of CMA is that the reserved memory can be reused
for other purpose while nobody is actually making use of it.

> 
> That said, I believe the addition of the boot time reservation, either
> direct or with CMA, can be added as an incrememntal patch after the
> "core" functionality is merged.

I am not convinced that we want to let random processes to do
alloc_pages() in the range of tens of gigabytes. It's not just mlocked
memory. I prefer either using CMA or relying on the boot time
reservations. But let's see if there are other opinions and people just
don't care.

Having that said, I have no further comments.

-- 
Thanks,

David / dhildenb

