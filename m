Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7444A3187C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 11:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhBKKGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 05:06:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230029AbhBKKDy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613037747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HvJ6ODrJsIAiBu7p562Cs80l2ihUXPDYjoFL2LYVwNg=;
        b=c5bsa43y5sQynpuLaf58W8udP9TioovbETtznXBYnDpqOo7vbUhqusFFm1LoANvMehc4Gw
        1Y1etWtFBtVWQg853mc3msBQSMLulVOxUn0OQ3Re/yguwxptZcVcW48gILtkNtDjvHfYlr
        J1OMQrbL5c4ofJFAuXAt4PbQwJdAXTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-xjh0NtfMOp6y4PYLBjaekA-1; Thu, 11 Feb 2021 05:02:23 -0500
X-MC-Unique: xjh0NtfMOp6y4PYLBjaekA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79EADC73A0;
        Thu, 11 Feb 2021 10:02:18 +0000 (UTC)
Received: from [10.36.114.52] (ovpn-114-52.ams2.redhat.com [10.36.114.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2B4F5D9E8;
        Thu, 11 Feb 2021 10:02:08 +0000 (UTC)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
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
 <20210208084920.2884-8-rppt@kernel.org> <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org> <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com> <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
 <20210211071319.GF242749@kernel.org> <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
 <0d66baec-1898-987b-7eaf-68a015c027ff@redhat.com>
 <YCT6+9YW474IaKrm@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <e7f1b5eb-a4c8-2772-6333-0a72c22b0c51@redhat.com>
Date:   Thu, 11 Feb 2021 11:02:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YCT6+9YW474IaKrm@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11.02.21 10:38, Michal Hocko wrote:
> On Thu 11-02-21 10:01:32, David Hildenbrand wrote:
> [...]
>> AFAIKS, we would need MFD_SECRET and disallow
>> MFD_ALLOW_SEALING and MFD_HUGETLB.
> 
> Yes for an initial version. But I do expect a request to support both
> features is just a matter of time.
> 
>> In addition, we could add MFD_SECRET_NEVER_MAP, which could disallow any kind of
>> temporary mappings (eor migration). TBC.
> 
> I believe this is the mode Mike wants to have by default. A more relax
> one would be an opt-in. MFD_SECRET_RELAXED which would allow temporal
> mappings in the kernel for content copying (e.g. for migration).
> 
>> ---
>>
>> Some random thoughts regarding files.
>>
>> What is the page size of secretmem memory? Sometimes we use huge pages,
>> sometimes we fallback to 4k pages. So I assume huge pages in general?
> 
> Unless there is an explicit request for hugetlb I would say the page
> size is not really important like for any other fds. Huge pages can be
> used transparently.
>   
>> What are semantics of MADV()/FALLOCATE() etc on such files?
> 
> I would expect the same semantic as regular shmem (memfd_create) except
> the memory doesn't have _any_ backing storage which makes it
> unevictable. So the reclaim related madv won't work but there shouldn't
> be any real reason why e.g. MADV_DONTNEED, WILLNEED, DONT_FORK and
> others don't work.

Another thought regarding "doesn't have _any_ backing storage"

What are the right semantics when it comes to memory accounting/commit?

As secretmem does not have
a) any backing storage
b) cannot go to swap

The MAP_NORESERVE vs. !MAP_NORESERVE handling gets a little unclear. Why 
"reserve swap space" if the allocations cannot ever go to swap? Sure, we 
want to "reserve physical memory", but in contrast to other users that 
can go to swap.

Of course, this is only relevant for MAP_PRIVATE secretmem mappings. 
Other MAP_SHARED assumes there is no need for reserving swap space as it 
can just go to the backing storage. (yeah, tmpfs/shmem is weird in that 
regard as well, but again, it's a bit different)

-- 
Thanks,

David / dhildenb

