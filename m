Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D3C314B67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 10:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBIJWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 04:22:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25549 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230339AbhBIJRJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612862138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uS7AnbSaMBJT+nB4CnATGQkmbCcT2ALwEDRI78KagxU=;
        b=DEQ9QfzRbiEiIfDxXiw6oIwNxllL3F82yeiFvH+ASc+u+8CyAhyXu6P7Et/QrPxzAOH0qf
        Z72DiRiCPSKFOBtLeqo+w+lZGu+jXn8aCrJjwQm/izBytK8VsTMSEwUPBV9tZ6qCzmKYCj
        k/0PII51pOVtcFIKIp01trDwJmBVTsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-NwZYbqYANyOm-qFvzH4vwA-1; Tue, 09 Feb 2021 04:15:34 -0500
X-MC-Unique: NwZYbqYANyOm-qFvzH4vwA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBB2C79EC5;
        Tue,  9 Feb 2021 09:15:29 +0000 (UTC)
Received: from [10.36.113.141] (ovpn-113-141.ams2.redhat.com [10.36.113.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 282C760CEC;
        Tue,  9 Feb 2021 09:15:18 +0000 (UTC)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
References: <20210208211326.GV242749@kernel.org>
 <1F6A73CF-158A-4261-AA6C-1F5C77F4F326@redhat.com>
 <YCJO8zLq8YkXGy8B@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v17 00/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <662b5871-b461-0896-697f-5e903c23d7b9@redhat.com>
Date:   Tue, 9 Feb 2021 10:15:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YCJO8zLq8YkXGy8B@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.02.21 09:59, Michal Hocko wrote:
> On Mon 08-02-21 22:38:03, David Hildenbrand wrote:
>>
>>> Am 08.02.2021 um 22:13 schrieb Mike Rapoport <rppt@kernel.org>:
>>>
>>> ﻿On Mon, Feb 08, 2021 at 10:27:18AM +0100, David Hildenbrand wrote:
>>>> On 08.02.21 09:49, Mike Rapoport wrote:
>>>>
>>>> Some questions (and request to document the answers) as we now allow to have
>>>> unmovable allocations all over the place and I don't see a single comment
>>>> regarding that in the cover letter:
>>>>
>>>> 1. How will the issue of plenty of unmovable allocations for user space be
>>>> tackled in the future?
>>>>
>>>> 2. How has this issue been documented? E.g., interaction with ZONE_MOVABLE
>>>> and CMA, alloc_conig_range()/alloc_contig_pages?.
>>>
>>> Secretmem sets the mappings gfp mask to GFP_HIGHUSER, so it does not
>>> allocate movable pages at the first place.
>>
>> That is not the point. Secretmem cannot go on CMA / ZONE_MOVABLE
>> memory and behaves like long-term pinnings in that sense. This is a
>> real issue when using a lot of sectremem.
> 
> A lot of unevictable memory is a concern regardless of CMA/ZONE_MOVABLE.
> As I've said it is quite easy to land at the similar situation even with
> tmpfs/MAP_ANON|MAP_SHARED on swapless system. Neither of the two is
> really uncommon. It would be even worse that those would be allowed to
> consume both CMA/ZONE_MOVABLE.

IIRC, tmpfs/MAP_ANON|MAP_SHARED memory
a) Is movable, can land in ZONE_MOVABLE/CMA
b) Can be limited by sizing tmpfs appropriately

AFAIK, what you describe is a problem with memory overcommit, not with 
zone imbalances (below). Or what am I missing?

> 
> One has to be very careful when relying on CMA or movable zones. This is
> definitely worth a comment in the kernel command line parameter
> documentation. But this is not a new problem.

I see the following thing worth documenting:

Assume you have a system with 2GB of ZONE_NORMAL/ZONE_DMA and 4GB of 
ZONE_MOVABLE/CMA.

Assume you make use of 1.5GB of secretmem. Your system might run into 
OOM any time although you still have plenty of memory on ZONE_MOVAVLE 
(and even swap!), simply because you are making excessive use of 
unmovable allocations (for user space!) in an environment where you 
should not make excessive use of unmovable allocations (e.g., where 
should page tables go?).

The existing controls (mlock limit) don't really match the current 
semantics of that memory. I repeat it once again: secretmem *currently* 
resembles long-term pinned memory, not mlocked memory. Things will 
change when implementing migration support for secretmem pages. Until 
then, the semantics are different and this should be spelled out.

For long-term pinnings this is kind of obvious, still we're now 
documenting it because it's dangerous to not be aware of. Secretmem 
behaves exactly the same and I think this is worth spelling out: 
secretmem has the potential of being used much more often than fairly 
special vfio/rdma/ ...

Looking at a cover letter that doesn't even mention the issue of 
unmovable allocations makes me thing that we are either trying to ignore 
the problem or are not aware of the problem.

-- 
Thanks,

David / dhildenb

