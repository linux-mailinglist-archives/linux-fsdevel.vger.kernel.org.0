Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E66319BBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 10:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBLJUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 04:20:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229674AbhBLJUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613121519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=baunC+JA0c74vn12rH+deswOvAmvXs+9aRij2anuo18=;
        b=MkC/0aY1zksQt9Ga+cXM/PRFIKRMO4EnLeUU3QqKg7GmRmLysHxSNetWiWzHiU8v+hVny4
        G26gMeaq0/vudwx33BQ/H0qa4vHxajIBtuzpJkMdtzWfeRKQO46rrA/uRbwSj0wMv4jp97
        82KFQFfGEvTBkel+v3qfEpLKV4RDNbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-Led8hCyZOVOQcxBvYOphjw-1; Fri, 12 Feb 2021 04:18:35 -0500
X-MC-Unique: Led8hCyZOVOQcxBvYOphjw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA327192CC41;
        Fri, 12 Feb 2021 09:18:29 +0000 (UTC)
Received: from [10.36.114.178] (ovpn-114-178.ams2.redhat.com [10.36.114.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA5E310023AC;
        Fri, 12 Feb 2021 09:18:20 +0000 (UTC)
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>,
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
References: <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org> <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com> <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
 <20210211071319.GF242749@kernel.org> <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
 <0d66baec-1898-987b-7eaf-68a015c027ff@redhat.com>
 <20210211112702.GI242749@kernel.org>
 <05082284-bd85-579f-2b3e-9b1af663eb6f@redhat.com>
 <20210211230910.GL242749@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <a903338e-3d56-ff0a-4f4f-0f23db7ec0da@redhat.com>
Date:   Fri, 12 Feb 2021 10:18:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210211230910.GL242749@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.02.21 00:09, Mike Rapoport wrote:
> On Thu, Feb 11, 2021 at 01:07:10PM +0100, David Hildenbrand wrote:
>> On 11.02.21 12:27, Mike Rapoport wrote:
>>> On Thu, Feb 11, 2021 at 10:01:32AM +0100, David Hildenbrand wrote:
>>
>> So let's talk about the main user-visible differences to other memfd files
>> (especially, other purely virtual files like hugetlbfs). With secretmem:
>>
>> - File content can only be read/written via memory mappings.
>> - File content cannot be swapped out.
>>
>> I think there are still valid ways to modify file content using syscalls:
>> e.g., fallocate(PUNCH_HOLE). Things like truncate also seems to work just
>> fine.
>   
> These work perfectly with any file, so maybe we should have added
> memfd_create as a flag to open(2) back then and now the secretmem file
> descriptors?

I think open() vs memfd_create() makes sense: for open, the path 
specifies main properties (tmpfs, hugetlbfs, filesystem). On memfd, 
there is no such path and the "type" has to be specified differently.

Also, open() might open existing files - memfd always creates new files.

>   
>>>> AFAIKS, we would need MFD_SECRET and disallow
>>>> MFD_ALLOW_SEALING and MFD_HUGETLB.
>>>
>>> So here we start to multiplex.
>>
>> Yes. And as Michal said, maybe we can support combinations in the future.
> 
> Isn't there a general agreement that syscall multiplexing is not a good
> thing?

Looking at mmap(), madvise(), fallocate(), I think multiplexing is just 
fine and flags can be mutually exclusive - as long as we're not 
squashing completely unrelated things into a single system call.

As one example: we don't have mmap_private() vs. mmap_shared() vs. 
mmap_shared_validate(). E.g., MAP_SYNC is only available for 
MAP_SHARED_VALIDATE.


> memfd_create already has flags validation that does not look very nice.

I assume you're talking about the hugetlb size specifications, right? 
It's not nice but fairly compact.

> Adding there only MFD_SECRET will make it a bit less nice, but when we'll
> grow new functionality into secretmem that will become horrible.

What do you have in mind? A couple of MFD_SECRET_* flags that only work 
with MFD_SECRET won't hurt IMHO. Just like we allow MFD_HUGE_* only with 
MFD_HUGETLB.

Thanks,

David / dhildenb

