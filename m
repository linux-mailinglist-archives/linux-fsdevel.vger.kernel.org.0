Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5385B313088
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 12:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhBHLSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 06:18:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60361 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233009AbhBHLPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612782847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rjBhYigDjL91xEreC6QyJ/Hq5Z8K5dAmnvBeKDYfa7U=;
        b=e90AczawJx8pSW1PeHpMoq3ukT7qvocx5SAyi7bZilzaBD2+GapsBSzr+5jIzeiGO87gMc
        tImXa2FZf6SvrSxbSwDNBwfEaPWR+q2teHGLN1TnmZfyoK2lwhFuDgL59kbcdXTVRxPmpv
        552bOAv72GVZDyPUUKuOb6wqI7SI6N4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-kXoN8HQDORu6M_4PkL4cIg-1; Mon, 08 Feb 2021 06:14:03 -0500
X-MC-Unique: kXoN8HQDORu6M_4PkL4cIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A00B801976;
        Mon,  8 Feb 2021 11:13:58 +0000 (UTC)
Received: from [10.36.113.240] (ovpn-113-240.ams2.redhat.com [10.36.113.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01D995C1D0;
        Mon,  8 Feb 2021 11:13:50 +0000 (UTC)
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
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-9-rppt@kernel.org> <YCEP/bmqm0DsvCYN@dhcp22.suse.cz>
 <38c0cad4-ac55-28e4-81c6-4e0414f0620a@redhat.com>
 <YCEXwUYepeQvEWTf@dhcp22.suse.cz>
 <a488a0bb-def5-0249-99e2-4643787cef69@redhat.com>
 <YCEZAWOv63KYglJZ@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v17 08/10] PM: hibernate: disable when there are active
 secretmem users
Message-ID: <770690dc-634a-78dd-0772-3aba1a3beba8@redhat.com>
Date:   Mon, 8 Feb 2021 12:13:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YCEZAWOv63KYglJZ@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.02.21 11:57, Michal Hocko wrote:
> On Mon 08-02-21 11:53:58, David Hildenbrand wrote:
>> On 08.02.21 11:51, Michal Hocko wrote:
>>> On Mon 08-02-21 11:32:11, David Hildenbrand wrote:
>>>> On 08.02.21 11:18, Michal Hocko wrote:
>>>>> On Mon 08-02-21 10:49:18, Mike Rapoport wrote:
>>>>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>>>>
>>>>>> It is unsafe to allow saving of secretmem areas to the hibernation
>>>>>> snapshot as they would be visible after the resume and this essentially
>>>>>> will defeat the purpose of secret memory mappings.
>>>>>>
>>>>>> Prevent hibernation whenever there are active secret memory users.
>>>>>
>>>>> Does this feature need any special handling? As it is effectivelly
>>>>> unevictable memory then it should behave the same as other mlock, ramfs
>>>>> which should already disable hibernation as those cannot be swapped out,
>>>>> no?
>>>>>
>>>>
>>>> Why should unevictable memory not go to swap when hibernating? We're merely
>>>> dumping all of our system RAM (including any unmovable allocations) to swap
>>>> storage and the system is essentially completely halted.
>>>>
>>> My understanding is that mlock is never really made visible via swap
>>> storage.
>>
>> "Using swap storage for hibernation" and "swapping at runtime" are two
>> different things. I might be wrong, though.
> 
> Well, mlock is certainly used to keep sensitive information, not only to
> protect from major/minor faults.
> 

I think you're right in theory, the man page mentions "Cryptographic 
security software often handles critical bytes like passwords or secret 
keys as data structures" ...

however, I am not aware of any such swap handling and wasn't able to 
spot it quickly. Let me take a closer look.


-- 
Thanks,

David / dhildenb

