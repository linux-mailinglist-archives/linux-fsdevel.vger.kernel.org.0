Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1F0303EA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 14:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391708AbhAZN0G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 08:26:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391731AbhAZJy5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611654809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IUod4ETbztcXWv5kUceZZzVauSHrXgAqLfR6bEGhJrw=;
        b=gcQISBwjC9oS0YagKFO5AQYmS2voSMsXxTmgFug/MdXAEeO+UtfevQrezyPmjZRnNIjrU7
        a0NZFSatD17LO+pv3X0tRSbKq4WIDT5+eqhfr6ZPUgIH5zPitvPXJ3fho8BRcRJfq6n0wc
        yA+HPGx1rQ05MgFs4176KyIBnTtq7lE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-Upuk_9QSN6-qAucf0rE94A-1; Tue, 26 Jan 2021 04:53:25 -0500
X-MC-Unique: Upuk_9QSN6-qAucf0rE94A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7562F107ACFB;
        Tue, 26 Jan 2021 09:53:19 +0000 (UTC)
Received: from [10.36.114.192] (ovpn-114-192.ams2.redhat.com [10.36.114.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 024AB19D80;
        Tue, 26 Jan 2021 09:53:09 +0000 (UTC)
Subject: Re: [PATCH v16 06/11] mm: introduce memfd_secret system call to
 create "secret" memory areas
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
 <20210121122723.3446-7-rppt@kernel.org> <20210125170122.GU827@dhcp22.suse.cz>
 <20210125213618.GL6332@kernel.org> <20210126071614.GX827@dhcp22.suse.cz>
 <20210126083311.GN6332@kernel.org> <20210126090013.GF827@dhcp22.suse.cz>
 <20210126092011.GP6332@kernel.org> <20210126094903.GI827@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <23850371-a19f-51fa-d813-6e78624ee8f8@redhat.com>
Date:   Tue, 26 Jan 2021 10:53:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210126094903.GI827@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.01.21 10:49, Michal Hocko wrote:
> On Tue 26-01-21 11:20:11, Mike Rapoport wrote:
>> On Tue, Jan 26, 2021 at 10:00:13AM +0100, Michal Hocko wrote:
>>> On Tue 26-01-21 10:33:11, Mike Rapoport wrote:
>>>> On Tue, Jan 26, 2021 at 08:16:14AM +0100, Michal Hocko wrote:
>>>>> On Mon 25-01-21 23:36:18, Mike Rapoport wrote:
>>>>>> On Mon, Jan 25, 2021 at 06:01:22PM +0100, Michal Hocko wrote:
>>>>>>> On Thu 21-01-21 14:27:18, Mike Rapoport wrote:
>>>>>>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>>>>>>
>>>>>>>> Introduce "memfd_secret" system call with the ability to create memory
>>>>>>>> areas visible only in the context of the owning process and not mapped not
>>>>>>>> only to other processes but in the kernel page tables as well.
>>>>>>>>
>>>>>>>> The user will create a file descriptor using the memfd_secret() system
>>>>>>>> call. The memory areas created by mmap() calls from this file descriptor
>>>>>>>> will be unmapped from the kernel direct map and they will be only mapped in
>>>>>>>> the page table of the owning mm.
>>>>>>>>
>>>>>>>> The secret memory remains accessible in the process context using uaccess
>>>>>>>> primitives, but it is not accessible using direct/linear map addresses.
>>>>>>>>
>>>>>>>> Functions in the follow_page()/get_user_page() family will refuse to return
>>>>>>>> a page that belongs to the secret memory area.
>>>>>>>>
>>>>>>>> A page that was a part of the secret memory area is cleared when it is
>>>>>>>> freed.
>>>>>>>>
>>>>>>>> The following example demonstrates creation of a secret mapping (error
>>>>>>>> handling is omitted):
>>>>>>>>
>>>>>>>> 	fd = memfd_secret(0);
>>>>>>>> 	ftruncate(fd, MAP_SIZE);
>>>>>>>> 	ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>>>>>>>
>>>>>>> I do not see any access control or permission model for this feature.
>>>>>>> Is this feature generally safe to anybody?
>>>>>>
>>>>>> The mappings obey memlock limit. Besides, this feature should be enabled
>>>>>> explicitly at boot with the kernel parameter that says what is the maximal
>>>>>> memory size secretmem can consume.
>>>>>
>>>>> Why is such a model sufficient and future proof? I mean even when it has
>>>>> to be enabled by an admin it is still all or nothing approach. Mlock
>>>>> limit is not really useful because it is per mm rather than per user.
>>>>>
>>>>> Is there any reason why this is allowed for non-privileged processes?
>>>>> Maybe this has been discussed in the past but is there any reason why
>>>>> this cannot be done by a special device which will allow to provide at
>>>>> least some permission policy?
>>>>  
>>>> Why this should not be allowed for non-privileged processes? This behaves
>>>> similarly to mlocked memory, so I don't see a reason why secretmem should
>>>> have different permissions model.
>>>
>>> Because appart from the reclaim aspect it fragments the direct mapping
>>> IIUC. That might have an impact on all others, right?
>>
>> It does fragment the direct map, but first it only splits 1G pages to 2M
>> pages and as was discussed several times already it's not that clear which
>> page size in the direct map is the best and this is very much workload
>> dependent.
> 
> I do appreciate this has been discussed but this changelog is not
> specific on any of that reasoning and I am pretty sure nobody will
> remember details in few years in the future. Also some numbers would be
> appropriate.
> 
>> These are the results of the benchmarks I've run with the default direct
>> mapping covered with 1G pages, with disabled 1G pages using "nogbpages" in
>> the kernel command line and with the entire direct map forced to use 4K
>> pages using a simple patch to arch/x86/mm/init.c.
>>
>> https://docs.google.com/spreadsheets/d/1tdD-cu8e93vnfGsTFxZ5YdaEfs2E1GELlvWNOGkJV2U/edit?usp=sharing
> 
> A good start for the data I am asking above.

I assume you've seen the benchmark results provided by Xing Zhengjun

https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/

-- 
Thanks,

David / dhildenb

