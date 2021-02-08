Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CC33141B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 22:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbhBHV1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 16:27:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236260AbhBHV1F (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:27:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E27F164E6C;
        Mon,  8 Feb 2021 21:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612819582;
        bh=Y8G7gf2IwGjBXBF5ErxQfWKVOLSdVIOpGEIG67JA2AY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eerdn/7TBUJNWh5JSQGQanhkCbXO6r8i+07ORvc0kNlXTv/gMu3WAJsIb2RYRWrDl
         NzMmvcDn3iTmjaUTOACFOeq+fWRq6saXTmy51YQtoTk38Gte4b+P8L19Xbwx0L6ml+
         Ea3Z7Qd3D+MldYIlVvyh5Yb26npCORZwTE+3wJTir9k1lgaS6eZYPXQ4zFo0WChRGs
         fUiJgsx/cCeor6w8T2f3XtMihtpacVS0+tPYSqs4uM0k3MR4YWV+vaapoyzoPPxAl+
         yFpPIEmRq4D/vlPxshoMK56Hm/B9URPT2mlstPmtBfgreYHioAYDlS64KLgxO+QeoG
         FSPZy/knOHzIQ==
Date:   Mon, 8 Feb 2021 23:26:05 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <20210208212605.GX242749@kernel.org>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-8-rppt@kernel.org>
 <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 08, 2021 at 11:49:22AM +0100, Michal Hocko wrote:
> On Mon 08-02-21 10:49:17, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Introduce "memfd_secret" system call with the ability to create memory
> > areas visible only in the context of the owning process and not mapped not
> > only to other processes but in the kernel page tables as well.
> > 
> > The secretmem feature is off by default and the user must explicitly enable
> > it at the boot time.
> > 
> > Once secretmem is enabled, the user will be able to create a file
> > descriptor using the memfd_secret() system call. The memory areas created
> > by mmap() calls from this file descriptor will be unmapped from the kernel
> > direct map and they will be only mapped in the page table of the owning mm.
> 
> Is this really true? I guess you meant to say that the memory will
> visible only via page tables to anybody who can mmap the respective file
> descriptor. There is nothing like an owning mm as the fd is inherently a
> shareable resource and the ownership becomes a very vague and hard to
> define term.

Hmm, it seems I've been dragging this paragraph from the very first
mmap(MAP_EXCLUSIVE) rfc and nobody (including myself) noticed the
inconsistency.
 
> > The file descriptor based memory has several advantages over the
> > "traditional" mm interfaces, such as mlock(), mprotect(), madvise(). It
> > paves the way for VMMs to remove the secret memory range from the process;
> 
> I do not understand how it helps to remove the memory from the process
> as the interface explicitly allows to add a memory that is removed from
> all other processes via direct map.

The current implementation does not help to remove the memory from the
process, but using fd-backed memory seems a better interface to remove
guest memory from host mappings than mmap. As Andy nicely put it:

"Getting fd-backed memory into a guest will take some possibly major work in
the kernel, but getting vma-backed memory into a guest without mapping it
in the host user address space seems much, much worse."
 
> > As secret memory implementation is not an extension of tmpfs or hugetlbfs,
> > usage of a dedicated system call rather than hooking new functionality into
> > memfd_create(2) emphasises that memfd_secret(2) has different semantics and
> > allows better upwards compatibility.
> 
> What is this supposed to mean? What are differences?

Well, the phrasing could be better indeed. That supposed to mean that
they differ in the semantics behind the file descriptor: memfd_create
implements sealing for shmem and hugetlbfs while memfd_secret implements
memory hidden from the kernel.
 
> > The secretmem mappings are locked in memory so they cannot exceed
> > RLIMIT_MEMLOCK. Since these mappings are already locked an attempt to
> > mlock() secretmem range would fail and mlockall() will ignore secretmem
> > mappings.
> 
> What about munlock?

Isn't this implied? ;-)
I'll add a sentence about it.
 
-- 
Sincerely yours,
Mike.
