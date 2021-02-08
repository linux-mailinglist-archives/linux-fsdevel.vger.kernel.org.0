Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B085E312FB3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 11:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhBHKyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 05:54:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:45882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232344AbhBHKuP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:50:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612781364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AoNPQu/CYREU8WklaThDeR8slY2WA4SdP9WlHLHnBzw=;
        b=jma/SuHJFiVwWmdQgxuuc5UeAWopcfBTEw8DCQRtoftzdON6/M5kdrXEyR3vdFiEHz5+3z
        +k49ofL8c4eTE7h3/Kadmh5PQ6WOsbRHozNCmH84n+jx2ZjkfHcB/bfE9B5UepeC/waV30
        P1KXrH4oDz6ocDZLYC+6hSCotDNBb+I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C2769AD62;
        Mon,  8 Feb 2021 10:49:23 +0000 (UTC)
Date:   Mon, 8 Feb 2021 11:49:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
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
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-8-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208084920.2884-8-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 08-02-21 10:49:17, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Introduce "memfd_secret" system call with the ability to create memory
> areas visible only in the context of the owning process and not mapped not
> only to other processes but in the kernel page tables as well.
> 
> The secretmem feature is off by default and the user must explicitly enable
> it at the boot time.
> 
> Once secretmem is enabled, the user will be able to create a file
> descriptor using the memfd_secret() system call. The memory areas created
> by mmap() calls from this file descriptor will be unmapped from the kernel
> direct map and they will be only mapped in the page table of the owning mm.

Is this really true? I guess you meant to say that the memory will
visible only via page tables to anybody who can mmap the respective file
descriptor. There is nothing like an owning mm as the fd is inherently a
shareable resource and the ownership becomes a very vague and hard to
define term.

> The file descriptor based memory has several advantages over the
> "traditional" mm interfaces, such as mlock(), mprotect(), madvise(). It
> paves the way for VMMs to remove the secret memory range from the process;

I do not understand how it helps to remove the memory from the process
as the interface explicitly allows to add a memory that is removed from
all other processes via direct map.

> there may be situations where sharing is useful and file descriptor based
> approach allows to seal the operations.

It would be great to expand on this some more.

> As secret memory implementation is not an extension of tmpfs or hugetlbfs,
> usage of a dedicated system call rather than hooking new functionality into
> memfd_create(2) emphasises that memfd_secret(2) has different semantics and
> allows better upwards compatibility.

What is this supposed to mean? What are differences?

> The secret memory remains accessible in the process context using uaccess
> primitives, but it is not exposed to the kernel otherwise; secret memory
> areas are removed from the direct map and functions in the
> follow_page()/get_user_page() family will refuse to return a page that
> belongs to the secret memory area.
> 
> Once there will be a use case that will require exposing secretmem to the
> kernel it will be an opt-in request in the system call flags so that user
> would have to decide what data can be exposed to the kernel.
>
> Removing of the pages from the direct map may cause its fragmentation on
> architectures that use large pages to map the physical memory which affects
> the system performance. However, the original Kconfig text for
> CONFIG_DIRECT_GBPAGES said that gigabyte pages in the direct map "... can
> improve the kernel's performance a tiny bit ..." (commit 00d1c5e05736
> ("x86: add gbpages switches")) and the recent report [1] showed that "...
> although 1G mappings are a good default choice, there is no compelling
> evidence that it must be the only choice". Hence, it is sufficient to have
> secretmem disabled by default with the ability of a system administrator to
> enable it at boot time.

OK, this looks like a reasonable compromise for the initial
implementation. Documentation of the command line parameter should be
very explicit about this though.

> The secretmem mappings are locked in memory so they cannot exceed
> RLIMIT_MEMLOCK. Since these mappings are already locked an attempt to
> mlock() secretmem range would fail and mlockall() will ignore secretmem
> mappings.

What about munlock?

> Pages in the secretmem regions are unevictable and unmovable to avoid
> accidental exposure of the sensitive data via swap or during page
> migration.
> 
> A page that was a part of the secret memory area is cleared when it is
> freed to ensure the data is not exposed to the next user of that page.
> 
> The following example demonstrates creation of a secret mapping (error
> handling is omitted):
> 
> 	fd = memfd_secret(0);
> 	ftruncate(fd, MAP_SIZE);
> 	ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE,
> 		   MAP_SHARED, fd, 0);

Please also list usecases which you are aware of as well.

I am also missing some more information about the implementation. E.g.
does this memory live on an unevictable LRU and therefore participates
into stats. What about memcg accounting. What is the cross fork (CoW)/exec
behavior. How is the memory reflected in OOM situation? Is a shared
mapping enforced?

Anyway, thanks for improving the changelog. This is definitely much more
informative.

> [1] https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/

I have only glanced through the implementation and it looks sane. I will
have a closer look later but this should be pretty simple with the
proposed semantic.
-- 
Michal Hocko
SUSE Labs
