Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D71941F8CF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Oct 2021 02:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhJBAyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 20:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhJBAyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 20:54:24 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACECC0613E4
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Oct 2021 17:52:39 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id h2so23935354ybi.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Oct 2021 17:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8Rp4f/3LTcWcsABgUbxkyZKMylwzyOZ2rjywnv7e9g=;
        b=jtyw/jHSR3zJy3bp5sMcf1IJXYrh7wyktV14F4IKdliz3ggiVG6ZN1ln8h51IcBKbz
         NPMtSDrr4WDihVPG50rrLqSLZ1vnSLWEDoMCYuwQ7r2gyFik8prAJ/NR0RFqgFENuxBS
         YG6KIw8Txrfb+IyJTvuBCX0KqDWwTOzg264e5M20dZOy+ndO7XHyG4jOoZ7nW4lVk+Mj
         +WdVhS0UafcvGaiqTlmb8yoQQCoKsvf0fUb/gfZGRwbCf41L3suU5u+MUijdFXHH2X8I
         yyUmGMNXGTqKYifbq2/sP8fbEOhxtn/OSIOY8/xRirNWqkx9Hk4Ibx+SKRiq9QgTwDdT
         RNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8Rp4f/3LTcWcsABgUbxkyZKMylwzyOZ2rjywnv7e9g=;
        b=D4YI1vXAiO24VkRa8iIQDc6xtXmu/VACyDfswJITgJQsvdcevRvRMrWL+N+zqv3jB5
         A/adWy8nEFFng3DzLeyuOWv7hxqIOGFoqJEF1BgYcJBvRmHdCfR5cHjxmN76+/mFICMZ
         u1F2n/zRX3lPzqBgmaYyJS9eTJzgZBN3Qzvusj09jhU9gfJPrkFOv81SqC0LW/xlPaIt
         AFih1Dyh4NFfNoKnm9za8M9zmfPiG9uCnfR0J0sBEDGuhNUeQR7gxEDdOAIPrbfYc029
         RtdM5LyLtlwtwyPp7DjrvnuMqBjdz/zfsITVCMxhyW9c/jcnztpB9OevFRw6qChxHSF3
         Nedw==
X-Gm-Message-State: AOAM533eURVEYUANDGKyA787uSU1z4fv4MsBWMtek9lvbv4p3+p3pOUc
        IHBf9fpnNgKd6LaIuDucAbGigwvJu9DosJ5DmgVj5w==
X-Google-Smtp-Source: ABdhPJw2kFgqD0WRKR1BC6Gy8VGESSrssnKuvc2ZmTYYncVxGyWrTdGQfNZ7C5A5O5TLs7MMb2BHBhIufTQhiRkTuXk=
X-Received: by 2002:a25:3:: with SMTP id 3mr982859yba.418.1633135958226; Fri,
 01 Oct 2021 17:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211001205657.815551-1-surenb@google.com> <20211001205657.815551-2-surenb@google.com>
 <20211001160830.700c36b32b736478000b3420@linux-foundation.org>
In-Reply-To: <20211001160830.700c36b32b736478000b3420@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 1 Oct 2021 17:52:27 -0700
Message-ID: <CAJuCfpGpMru4z=ZMezRQW56tHNjrWHU3jWhG3qzuXvuUytq-3w@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] mm: add a field to store names for private
 anonymous memory
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        John Hubbard <jhubbard@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 1, 2021 at 4:08 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri,  1 Oct 2021 13:56:56 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > From: Colin Cross <ccross@google.com>
> >
> > In many userspace applications, and especially in VM based applications
> > like Android uses heavily, there are multiple different allocators in use.
> >  At a minimum there is libc malloc and the stack, and in many cases there
> > are libc malloc, the stack, direct syscalls to mmap anonymous memory, and
> > multiple VM heaps (one for small objects, one for big objects, etc.).
> > Each of these layers usually has its own tools to inspect its usage;
> > malloc by compiling a debug version, the VM through heap inspection tools,
> > and for direct syscalls there is usually no way to track them.
> >
> > On Android we heavily use a set of tools that use an extended version of
> > the logic covered in Documentation/vm/pagemap.txt to walk all pages mapped
> > in userspace and slice their usage by process, shared (COW) vs.  unique
> > mappings, backing, etc.  This can account for real physical memory usage
> > even in cases like fork without exec (which Android uses heavily to share
> > as many private COW pages as possible between processes), Kernel SamePage
> > Merging, and clean zero pages.  It produces a measurement of the pages
> > that only exist in that process (USS, for unique), and a measurement of
> > the physical memory usage of that process with the cost of shared pages
> > being evenly split between processes that share them (PSS).
> >
> > If all anonymous memory is indistinguishable then figuring out the real
> > physical memory usage (PSS) of each heap requires either a pagemap walking
> > tool that can understand the heap debugging of every layer, or for every
> > layer's heap debugging tools to implement the pagemap walking logic, in
> > which case it is hard to get a consistent view of memory across the whole
> > system.
> >
> > Tracking the information in userspace leads to all sorts of problems.
> > It either needs to be stored inside the process, which means every
> > process has to have an API to export its current heap information upon
> > request, or it has to be stored externally in a filesystem that
> > somebody needs to clean up on crashes.  It needs to be readable while
> > the process is still running, so it has to have some sort of
> > synchronization with every layer of userspace.  Efficiently tracking
> > the ranges requires reimplementing something like the kernel vma
> > trees, and linking to it from every layer of userspace.  It requires
> > more memory, more syscalls, more runtime cost, and more complexity to
> > separately track regions that the kernel is already tracking.
> >
> > This patch adds a field to /proc/pid/maps and /proc/pid/smaps to show a
> > userspace-provided name for anonymous vmas.  The names of named anonymous
> > vmas are shown in /proc/pid/maps and /proc/pid/smaps as [anon:<name>].
> >
> > Userspace can set the name for a region of memory by calling
> > prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, start, len, (unsigned long)name);
>
> So this can cause a vma to be split, if [start,len] doesn't exactly
> describe an existing vma?  If so, is this at all useful?  If not then
> `len' isn't needed - just pass in some address within an existing vma?

Technically one could mmap a large chunk of memory and then assign
different names to its parts to use for different purposes, which
would cause the vma to split. I don't think Android uses it that way
but I'll have to double-check. I think one advantage of doing this
could be to minimize the number of mmap syscalls.

> > Setting the name to NULL clears it. The name length limit is 80 bytes
> > including NUL-terminator and is checked to contain only printable ascii
> > characters (including space), except '[',']','\','$' and '`'.
> >
> > The name is stored in a pointer in the shared union in vm_area_struct
> > that points to a null terminated string. Anonymous vmas with the same
> > name (equivalent strings) and are otherwise mergeable will be merged.
>
> So this can prevent vma merging if used incorrectly (or maliciously -
> can't think how)?  What are the potential impacts of this?

Potential impact would be that otherwise mergeable vmas would not be
merged due to the name difference. This is a known downside of naming
an anon vma which I documented in my manual pages description as "Note
that assigning an  attribute to a virtual memory area might prevent it
from being merged with adjacent virtual memory areas due to the
difference in that attribute's value.". In Android we see an increase
in the number of VMAs due to this feature but it was not significant.
I'll try to dig up the numbers or will rerun the test to get them.
If a process maliciously wants to increase the number of vmas in the
system it could generate lots of vmas with different names in its
address space, however this can be done even without this feature by
mapping vmas while toggling a protection bit. Something like this:

int prot = PROT_WRITE;
for (i = 0; i < count; i++) {
    mmap(NULL, size_bytes, prot, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
    prot = (prot ^ PROT_READ) & (PROT_READ | PROT_WRITE);
}

> > The name pointers are not shared between vmas even if they contain the
> > same name. The name pointer is stored in a union with fields that are
> > only used on file-backed mappings, so it does not increase memory usage.
> >
> > The patch is based on the original patch developed by Colin Cross, more
> > specifically on its latest version [1] posted upstream by Sumit Semwal.
> > It used a userspace pointer to store vma names. In that design, name
> > pointers could be shared between vmas. However during the last upstreaming
> > attempt, Kees Cook raised concerns [2] about this approach and suggested
> > to copy the name into kernel memory space, perform validity checks [3]
> > and store as a string referenced from vm_area_struct.
> > One big concern is about fork() performance which would need to strdup
> > anonymous vma names. Dave Hansen suggested experimenting with worst-case
> > scenario of forking a process with 64k vmas having longest possible names
> > [4]. I ran this experiment on an ARM64 Android device and recorded a
> > worst-case regression of almost 40% when forking such a process. This
> > regression is addressed in the followup patch which replaces the pointer
> > to a name with a refcounted structure that allows sharing the name pointer
> > between vmas of the same name. Instead of duplicating the string during
> > fork() or when splitting a vma it increments the refcount.
>
> Generally, the patch adds a bunch of code which a lot of users won't
> want.  Did we bust a gut to reduce this impact?  Was a standalone
> config setting considered?

I didn't consider a standalone config for this feature because when
not used it has no memory impact at runtime. As for the image size, I
built Linus' ToT with and without this patchset with allmodconfig and
the sizes are:
Without the patchset:
$ size vmlinux
   text    data     bss     dec     hex filename
40763556 58424519 29016228 128204303 7a43e0f vmlinux

With the patchset:
$ size vmlinux
   text    data     bss     dec     hex filename
40765068 58424671 29016228 128205967 7a4448f vmlinux

The increase seems quite small, so I'm not sure if it warrants a
separate config option.

> And what would be the impact of making this feature optional?  Is a
> proliferation of formats in /proc/pid/maps going to make userspace
> parsers harder to develop and test?

I'm guessing having one format is simpler and therefore preferable?

> I do think that saying "The names of named anonymous vmas are shown in
> /proc/pid/maps and /proc/pid/smaps as [anon:<name>]." is a bit thin.
> Please provide sample output so we can consider these things better.

Sure. Here is a sample /proc/$pid/maps output (partial):

6ffacb6000-6ffacd6000 r--s 00000000 00:10 361
  /dev/__properties__/properties_serial
6ffacd6000-6ffacd9000 rw-p 00000000 00:00 0
  [anon:System property context nodes]
6ffacd9000-6ffaceb000 r--s 00000000 00:10 79
  /dev/__properties__/property_info
6ffaceb000-6ffad4f000 r--p 00000000 00:00 0
  [anon:linker_alloc]
6ffad4f000-6ffad51000 rw-p 00000000 00:00 0
  [anon:bionic_alloc_small_objects]
6ffad51000-6ffad52000 r--p 00000000 00:00 0
  [anon:atexit handlers]
6ffad52000-6ffbc2c000 ---p 00000000 00:00 0
6ffbc2c000-6ffbc2e000 rw-p 00000000 00:00 0
6ffbc2e000-6ffbd52000 ---p 00000000 00:00 0
6ffbd52000-6ffbd53000 ---p 00000000 00:00 0
6ffbd53000-6ffbd5b000 rw-p 00000000 00:00 0
  [anon:thread signal stack]
6ffbd5b000-6ffbd5c000 rw-p 00000000 00:00 0
  [anon:arc4random data]
6ffbd5c000-6ffbd5d000 r--p 0000d000 07:90 59
  /apex/com.android.art/javalib/arm64/boot-okhttp.art
6ffbd5d000-6ffbd5e000 r--p 00014000 07:90 56
  /apex/com.android.art/javalib/arm64/boot-core-libart.art
6ffbd5e000-6ffbd5f000 rw-p 00000000 00:00 0
  [anon:arc4random data]
6ffbd5f000-6ffbd61000 r--p 00000000 00:00 0                              [vvar]
6ffbd61000-6ffbd62000 r-xp 00000000 00:00 0                              [vdso]

and sample /proc/$pid/smaps output (partial):

6ffad4f000-6ffad51000 rw-p 00000000 00:00 0
  [anon:bionic_alloc_small_objects]
Size:                  8 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   0 kB
Pss:                   0 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:            0 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  8 kB
SwapPss:               8 kB
Locked:                0 kB
THPeligible:    0
VmFlags: rd wr mr mw me ac

>
> What are the risks that existing parsers will be broken by such changes?

That I can't really answer. It would depend on how the parser is
written. The implementation follows the same pattern as [stack],
[vdso] and other non-filebacked sections are named, however if a
parser is written so that it does not ignore an unknown entry then it
would fail to parse [anon:...] name if some process decides to name
its anonymous vmas.
