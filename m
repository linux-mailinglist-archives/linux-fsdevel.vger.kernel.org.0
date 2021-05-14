Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF25E38058C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 10:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhENIwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 04:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31055 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231809AbhENIwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 04:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620982261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A6IAZwI0xwEgxZkIPkaUDpjaSLTjanXMP6EohDn10+Y=;
        b=eDmPlB4ZidLGZMxAQ1alx5ZUBc3d/lvPkq03fZ9lChKsM+1s5P4GvBy3q2UHeX5VhapPA4
        zGmSKvNigepDz+IBW6AjsuJQFH9l80UwoxkdT3Lqc4qHN95zpL+L/iJKmbRSHQmg832S9T
        qImZuRwx/AreJMSpUERZpZ3gpd8nF+U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-VfIoa0LeOc-OJeFZgSO4AA-1; Fri, 14 May 2021 04:50:59 -0400
X-MC-Unique: VfIoa0LeOc-OJeFZgSO4AA-1
Received: by mail-ej1-f70.google.com with SMTP id m18-20020a1709062352b02903d2d831f9baso1203934eja.20
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 May 2021 01:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=A6IAZwI0xwEgxZkIPkaUDpjaSLTjanXMP6EohDn10+Y=;
        b=YtPYt2dG5DLWjrzq8KrJwPb/K9t4PYkHnOJRjqgoEg1UI4T8UzDxJWLVI1sJk5RnoQ
         LdqRhpmHGjCrlonYV4q2xqhqnfqMtXJC+dW3Ln+3Nnc0evMrN6H65nMI5rutOQMVvvlZ
         QGwlDc6MjBgnxCk9/9L2Aoh0sZ8usWngFDHoi4auciJriVGP1Of9CMMDKwvntUHHCt+T
         yeQIBv6zkATq/3j9qZD4zHDprwvv1DLJiNskzD7DhGXz4DVStDUCB06QzngoWzBh7+A+
         Rpqbua2xeHNiqGnpFIejNIsCJ19RtOw9zVa9OSzzStu0WPvNw68PPmS6Yf+957JvPS4j
         LBmQ==
X-Gm-Message-State: AOAM5308WbFuaN95rIpIf8jX/faID3CZnH0WDtBUZgO9vaKT9TcPm7TR
        WbnO4SbO8cvLPYdqghlYAzAKj5WrT5C7zRQXIWyxx/BgoDyhr7kkHjeXDvhBYNawmYsS4w0tqa+
        NWuxW6UWEisbGSAYw9H7PKgeN5A==
X-Received: by 2002:aa7:de02:: with SMTP id h2mr54907477edv.61.1620982258497;
        Fri, 14 May 2021 01:50:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbFV5SCx4C1Oa2Pq/TZ05TRM0enPIT1usIgqsxFBagAMreWK04a8ZIkxs0DNaI7qx1TZ7bmg==
X-Received: by 2002:aa7:de02:: with SMTP id h2mr54907444edv.61.1620982258235;
        Fri, 14 May 2021 01:50:58 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id yw9sm3241097ejb.91.2021.05.14.01.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 01:50:57 -0700 (PDT)
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-6-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v19 5/8] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <ea1ddcfa-f52d-9a7d-cb7b-8502b38a90da@redhat.com>
Date:   Fri, 14 May 2021 10:50:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513184734.29317-6-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13.05.21 20:47, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Introduce "memfd_secret" system call with the ability to create
> memory areas visible only in the context of the owning process and
> not mapped not only to other processes but in the kernel page tables
> as well.
> 
> The secretmem feature is off by default and the user must explicitly
> enable it at the boot time.
> 
> Once secretmem is enabled, the user will be able to create a file 
> descriptor using the memfd_secret() system call. The memory areas
> created by mmap() calls from this file descriptor will be unmapped
> from the kernel direct map and they will be only mapped in the page
> table of the processes that have access to the file descriptor.
> 
> The file descriptor based memory has several advantages over the 
> "traditional" mm interfaces, such as mlock(), mprotect(), madvise().
> File descriptor approach allows explict and controlled sharing of the
> memory

s/explict/explicit/

> areas, it allows to seal the operations. Besides, file descriptor
> based memory paves the way for VMMs to remove the secret memory range
> from the userpace hipervisor process, for instance QEMU. Andy
> Lutomirski says:

s/userpace hipervisor/userspace hypervisor/

> 
> "Getting fd-backed memory into a guest will take some possibly major
> work in the kernel, but getting vma-backed memory into a guest
> without mapping it in the host user address space seems much, much
> worse."
> 
> memfd_secret() is made a dedicated system call rather than an
> extention to

s/extention/extension/

> memfd_create() because it's purpose is to allow the user to create
> more secure memory mappings rather than to simply allow file based
> access to the memory. Nowadays a new system call cost is negligible
> while it is way simpler for userspace to deal with a clear-cut system
> calls than with a multiplexer or an overloaded syscall. Moreover, the
> initial implementation of memfd_secret() is completely distinct from
> memfd_create() so there is no much sense in overloading
> memfd_create() to begin with. If there will be a need for code
> sharing between these implementation it can be easily achieved
> without a need to adjust user visible APIs.
> 
> The secret memory remains accessible in the process context using
> uaccess primitives, but it is not exposed to the kernel otherwise;
> secret memory areas are removed from the direct map and functions in
> the follow_page()/get_user_page() family will refuse to return a page
> that belongs to the secret memory area.
> 
> Once there will be a use case that will require exposing secretmem to
> the kernel it will be an opt-in request in the system call flags so
> that user would have to decide what data can be exposed to the
> kernel.

Maybe spell out an example: like page migration.

> 
> Removing of the pages from the direct map may cause its fragmentation
> on architectures that use large pages to map the physical memory
> which affects the system performance. However, the original Kconfig
> text for CONFIG_DIRECT_GBPAGES said that gigabyte pages in the direct
> map "... can improve the kernel's performance a tiny bit ..." (commit
> 00d1c5e05736 ("x86: add gbpages switches")) and the recent report [1]
> showed that "... although 1G mappings are a good default choice,
> there is no compelling evidence that it must be the only choice".
> Hence, it is sufficient to have secretmem disabled by default with
> the ability of a system administrator to enable it at boot time.

Maybe add a link to the Intel performance evaluation.

> 
> Pages in the secretmem regions are unevictable and unmovable to
> avoid accidental exposure of the sensitive data via swap or during
> page migration.
> 
> Since the secretmem mappings are locked in memory they cannot exceed 
> RLIMIT_MEMLOCK. Since these mappings are already locked independently
> from mlock(), an attempt to mlock()/munlock() secretmem range would
> fail and mlockall()/munlockall() will ignore secretmem mappings.

Maybe add something like "similar to pages pinned by VFIO".

> 
> However, unlike mlock()ed memory, secretmem currently behaves more
> like long-term GUP: secretmem mappings are unmovable mappings
> directly consumed by user space. With default limits, there is no
> excessive use of secretmem and it poses no real problem in
> combination with ZONE_MOVABLE/CMA, but in the future this should be
> addressed to allow balanced use of large amounts of secretmem along
> with ZONE_MOVABLE/CMA.
> 
> A page that was a part of the secret memory area is cleared when it
> is freed to ensure the data is not exposed to the next user of that
> page.

You could skip that with init_on_free (and eventually also with 
init_on_alloc) set to avoid double clearing.

> 
> The following example demonstrates creation of a secret mapping
> (error handling is omitted):
> 
> fd = memfd_secret(0); ftruncate(fd, MAP_SIZE); ptr = mmap(NULL,
> MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> 
> [1]
> https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/

[my mail client messed up the remainder of the mail for whatever reason, 
will comment in a separate mail if there is anything to comment :) ]

-- 
Thanks,

David / dhildenb

