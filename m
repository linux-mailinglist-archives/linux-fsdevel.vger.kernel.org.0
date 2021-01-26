Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF2B303C58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 13:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405146AbhAZMAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 07:00:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405288AbhAZL6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611662235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qjJ7EBIraH0kcBiHWVTNphRxbXFU8GNfvJrsoVivTWk=;
        b=V8WD8NCMWlFDx9o6YzcO4I4dENQNX15Lz56GUb71wwvfnEUCghoGq2WMCpCus3UksH4ryw
        zGNU8VB40n7JCwxI/iYewHuZuQskrP2EPqwOLVMVQm7Din2QT7woVj7CSLOVIA2dubHziT
        gr4NL1JD2oKEm1+KynWmZgRhW0U44EU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-Ryg-fxAdMkms-vm90M751Q-1; Tue, 26 Jan 2021 06:57:11 -0500
X-MC-Unique: Ryg-fxAdMkms-vm90M751Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F94E107ACF6;
        Tue, 26 Jan 2021 11:57:06 +0000 (UTC)
Received: from [10.36.114.192] (ovpn-114-192.ams2.redhat.com [10.36.114.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B16B65D751;
        Tue, 26 Jan 2021 11:56:49 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
Date:   Tue, 26 Jan 2021 12:56:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210126114657.GL827@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.01.21 12:46, Michal Hocko wrote:
> On Thu 21-01-21 14:27:19, Mike Rapoport wrote:
>> From: Mike Rapoport <rppt@linux.ibm.com>
>>
>> Removing a PAGE_SIZE page from the direct map every time such page is
>> allocated for a secret memory mapping will cause severe fragmentation of
>> the direct map. This fragmentation can be reduced by using PMD-size pages
>> as a pool for small pages for secret memory mappings.
>>
>> Add a gen_pool per secretmem inode and lazily populate this pool with
>> PMD-size pages.
>>
>> As pages allocated by secretmem become unmovable, use CMA to back large
>> page caches so that page allocator won't be surprised by failing attempt to
>> migrate these pages.
>>
>> The CMA area used by secretmem is controlled by the "secretmem=" kernel
>> parameter. This allows explicit control over the memory available for
>> secretmem and provides upper hard limit for secretmem consumption.
> 
> OK, so I have finally had a look at this closer and this is really not
> acceptable. I have already mentioned that in a response to other patch
> but any task is able to deprive access to secret memory to other tasks
> and cause OOM killer which wouldn't really recover ever and potentially
> panic the system. Now you could be less drastic and only make SIGBUS on
> fault but that would be still quite terrible. There is a very good
> reason why hugetlb implements is non-trivial reservation system to avoid
> exactly these problems.
> 
> So unless I am really misreading the code
> Nacked-by: Michal Hocko <mhocko@suse.com>
> 
> That doesn't mean I reject the whole idea. There are some details to
> sort out as mentioned elsewhere but you cannot really depend on
> pre-allocated pool which can fail at a fault time like that.

So, to do it similar to hugetlbfs (e.g., with CMA), there would have to 
be a mechanism to actually try pre-reserving (e.g., from the CMA area), 
at which point in time the pages would get moved to the secretmem pool, 
and a mechanism for mmap() etc. to "reserve" from these secretmem pool, 
such that there are guarantees at fault time?

What we have right now feels like some kind of overcommit (reading, as 
overcommiting huge pages, so we might get SIGBUS at fault time).

TBH, the SIGBUS thingy doesn't sound terrible to me - if this behavior 
is to be expected right now by applications using it and they can handle 
it - no guarantees. I fully agree that some kind of 
reservation/guarantee mechanism would be preferable.

-- 
Thanks,

David / dhildenb

