Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B18B30C24A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 15:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbhBBOq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 09:46:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234777AbhBBOoU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612276974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p9WVcjtJGSRM6w7F2m39UE8iZCliMcHMPGNuV986qrI=;
        b=OQo3i10NkK88wXMNXEXmca0BBgYvMgB4aFbJSf0m52DHmfo1XJm2rYtfET6sk+Vc4FE8bC
        dw8U/PVY0/csMZsHyU3g1o+hhwBOxQAAIT51769OIMxg5xCAw2KRFVBDHOP0s+PC4M6iUr
        65LJvmG5s0DHRvV5gms9g+KHUTiST+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-8AQi4yF_NHCuVEWiuakmOQ-1; Tue, 02 Feb 2021 09:42:42 -0500
X-MC-Unique: 8AQi4yF_NHCuVEWiuakmOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46BB9184DBED;
        Tue,  2 Feb 2021 14:42:36 +0000 (UTC)
Received: from [10.36.114.148] (ovpn-114-148.ams2.redhat.com [10.36.114.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36D6560916;
        Tue,  2 Feb 2021 14:42:28 +0000 (UTC)
To:     Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>
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
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-8-rppt@kernel.org> <20210126114657.GL827@dhcp22.suse.cz>
 <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
 <20210126120823.GM827@dhcp22.suse.cz> <20210128092259.GB242749@kernel.org>
 <YBK1kqL7JA7NePBQ@dhcp22.suse.cz> <20210129072128.GD242749@kernel.org>
 <YBPMg/C5Sb78gFEB@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <f1f65516-e222-6543-aeae-9a1dc9920de8@redhat.com>
Date:   Tue, 2 Feb 2021 15:42:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YBPMg/C5Sb78gFEB@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29.01.21 09:51, Michal Hocko wrote:
> On Fri 29-01-21 09:21:28, Mike Rapoport wrote:
>> On Thu, Jan 28, 2021 at 02:01:06PM +0100, Michal Hocko wrote:
>>> On Thu 28-01-21 11:22:59, Mike Rapoport wrote:
>>>
>>>> And hugetlb pools may be also depleted by anybody by calling
>>>> mmap(MAP_HUGETLB) and there is no any limiting knob for this, while
>>>> secretmem has RLIMIT_MEMLOCK.
>>>
>>> Yes it can fail. But it would fail at the mmap time when the reservation
>>> fails. Not during the #PF time which can be at any time.
>>
>> It may fail at $PF time as well:
>>
>> hugetlb_fault()
>>          hugeltb_no_page()
>>                  ...
>>                  alloc_huge_page()
>>                          alloc_gigantic_page()
>>                                  cma_alloc()
>>                                          -ENOMEM;
> 
> I would have to double check. From what I remember cma allocator is an
> optimization to increase chances to allocate hugetlb pages when
> overcommiting because pages should be normally pre-allocated in the pool
> and reserved during mmap time. But even if a hugetlb page is not pre
> allocated then this will get propagated as SIGBUS unless that has
> changed.

It's an optimization to allocate gigantic pages dynamically later (so 
not using memblock during boot). Not just for overcommit, but for any 
kind of allocation.

The actual allocation from cma should happen when setting nr_pages:

nr_hugepages_store_common()->set_max_huge_pages()->alloc_pool_huge_page()...->alloc_gigantic_page()

The path described above seems to be trying to overcommit gigantic 
pages, something that can be expected to SIGBUS. Reservations are 
handled via the pre-allocated pool.

-- 
Thanks,

David / dhildenb

