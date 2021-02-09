Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73C2314D29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 11:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhBIKe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 05:34:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231894AbhBIKcg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612866669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l9NmyWsJuFC0/5JNGWNXSCR8ksDc6+RfyJhTiUXWtF4=;
        b=OZiBee4/hx+0WzQCZMLlGJRIFCiAD9X3KouUn1rReCunutViiArKTZnU/OexnZuFy204c/
        LYzC+rWAwbXUxsPTNOAI49XW3mGoED+KCRwulMrjPNhrcCRxrehQrJ+7vIdt/eBaDEf9et
        AgkqIvHPCXaP23isZybVF6BdD42+aWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-IIfTrpvSPlC2PvPZbsJlDQ-1; Tue, 09 Feb 2021 05:31:06 -0500
X-MC-Unique: IIfTrpvSPlC2PvPZbsJlDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C379C107ACE4;
        Tue,  9 Feb 2021 10:31:01 +0000 (UTC)
Received: from [10.36.113.141] (ovpn-113-141.ams2.redhat.com [10.36.113.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3559C17AE2;
        Tue,  9 Feb 2021 10:30:54 +0000 (UTC)
Subject: Re: [PATCH v17 00/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
From:   David Hildenbrand <david@redhat.com>
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
 <662b5871-b461-0896-697f-5e903c23d7b9@redhat.com>
 <YCJbmR11ikrWKaU8@dhcp22.suse.cz>
 <c1e5e7b6-3360-ddc4-2ff5-0e79515ee23a@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d733d2b5-bb9c-179d-82c2-3c07d7d97a9f@redhat.com>
Date:   Tue, 9 Feb 2021 11:30:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <c1e5e7b6-3360-ddc4-2ff5-0e79515ee23a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.02.21 11:23, David Hildenbrand wrote:
>>>> A lot of unevictable memory is a concern regardless of CMA/ZONE_MOVABLE.
>>>> As I've said it is quite easy to land at the similar situation even with
>>>> tmpfs/MAP_ANON|MAP_SHARED on swapless system. Neither of the two is
>>>> really uncommon. It would be even worse that those would be allowed to
>>>> consume both CMA/ZONE_MOVABLE.
>>>
>>> IIRC, tmpfs/MAP_ANON|MAP_SHARED memory
>>> a) Is movable, can land in ZONE_MOVABLE/CMA
>>> b) Can be limited by sizing tmpfs appropriately
>>>
>>> AFAIK, what you describe is a problem with memory overcommit, not with zone
>>> imbalances (below). Or what am I missing?
>>
>> It can be problem for both. If you have just too much of shm (do not
>> forget about MAP_SHARED|MAP_ANON which is much harder to size from an
>> admin POV) then migrateability doesn't really help because you need a
>> free memory to migrate. Without reclaimability this can easily become a
>> problem. That is why I am saying this is not really a new problem.
>> Swapless systems are not all that uncommon.
> 
> I get your point, it's similar but still different. "no memory in the
> system" vs. "plenty of unusable free memory available in the system".
> 
> In many setups, memory for user space applications can go to
> ZONE_MOVABLE just fine. ZONE_NORMAL etc. can be used for supporting user
> space memory (e.g., page tables) and other kernel stuff.
> 
> Like, have 4GB of ZONE_MOVABLE with 2GB of ZONE_NORMAL. Have an
> application (database) that allocates 4GB of memory. Works just fine.
> The zone ratio ends up being a problem for example with many processes
> (-> many page tables).
> 
> Not being able to put user space memory into the movable zone is a
> special case. And we are introducing yet another special case here
> (besides vfio, rdma, unmigratable huge pages like gigantic pages).
> 
> With plenty of secretmem, looking at /proc/meminfo Total vs. Free can be
> a big lie of how your system behaves.
> 
>>    
>>>> One has to be very careful when relying on CMA or movable zones. This is
>>>> definitely worth a comment in the kernel command line parameter
>>>> documentation. But this is not a new problem.
>>>
>>> I see the following thing worth documenting:
>>>
>>> Assume you have a system with 2GB of ZONE_NORMAL/ZONE_DMA and 4GB of
>>> ZONE_MOVABLE/CMA.
>>>
>>> Assume you make use of 1.5GB of secretmem. Your system might run into OOM
>>> any time although you still have plenty of memory on ZONE_MOVAVLE (and even
>>> swap!), simply because you are making excessive use of unmovable allocations
>>> (for user space!) in an environment where you should not make excessive use
>>> of unmovable allocations (e.g., where should page tables go?).
>>
>> yes, you are right of course and I am not really disputing this. But I
>> would argue that 2:1 Movable/Normal is something to expect problems
>> already. "Lowmem" allocations can easily trigger OOM even without secret
>> mem in the picture. It all just takes to allocate a lot of GFP_KERNEL or
>> even GFP_{HIGH}USER. Really, it is CMA/MOVABLE that are elephant in the
>> room and one has to be really careful when relying on them.
> 
> Right, it's all about what the setup actually needs. Sure, there are
> cases where you need significantly more GFP_KERNEL/GFP_{HIGH}USER such
> that a 2:1 ratio is not feasible. But I claim that these are corner cases.
> 
> Secretmem gives user space the option to allocate a lot of
> GFP_{HIGH}USER memory. If I am not wrong, "ulimit -a" tells me that each
> application on F33 can allocate 16 GiB (!) of secretmem.

Got to learn to do my math. It's 16 MiB - so as a default it's less 
dangerous than I thought!

-- 
Thanks,

David / dhildenb

