Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E484741F80E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Oct 2021 01:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhJAXKT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 19:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230337AbhJAXKR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 19:10:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5963A61AAB;
        Fri,  1 Oct 2021 23:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633129712;
        bh=gmNmEk2Es85bCG0biHWq7eCspvRaRPibh9XEwD0ayBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zVkZLK3NraoWAk0s5/NVBlHzoIH1fg9tCOpS4WwnEp6Ikg06/rtOHGsbHfhVaeoxL
         EMTz1Fo3Ptf53Ulh1UerAZv99h0/wmdWuLuJA1cBo3ulrXK3mp3S9M/I2rTHQhXus3
         vWcpss3QBZqhut4Nhpkf/2SFScDWicbT0JrmTjeY=
Date:   Fri, 1 Oct 2021 16:08:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     ccross@google.com, sumit.semwal@linaro.org, mhocko@suse.com,
        dave.hansen@intel.com, keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com,
        rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, gorcunov@gmail.com, pavel@ucw.cz,
        songmuchun@bytedance.com, viresh.kumar@linaro.org,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Subject: Re: [PATCH v10 2/3] mm: add a field to store names for private
 anonymous memory
Message-Id: <20211001160830.700c36b32b736478000b3420@linux-foundation.org>
In-Reply-To: <20211001205657.815551-2-surenb@google.com>
References: <20211001205657.815551-1-surenb@google.com>
        <20211001205657.815551-2-surenb@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri,  1 Oct 2021 13:56:56 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> From: Colin Cross <ccross@google.com>
> 
> In many userspace applications, and especially in VM based applications
> like Android uses heavily, there are multiple different allocators in use.
>  At a minimum there is libc malloc and the stack, and in many cases there
> are libc malloc, the stack, direct syscalls to mmap anonymous memory, and
> multiple VM heaps (one for small objects, one for big objects, etc.).
> Each of these layers usually has its own tools to inspect its usage;
> malloc by compiling a debug version, the VM through heap inspection tools,
> and for direct syscalls there is usually no way to track them.
> 
> On Android we heavily use a set of tools that use an extended version of
> the logic covered in Documentation/vm/pagemap.txt to walk all pages mapped
> in userspace and slice their usage by process, shared (COW) vs.  unique
> mappings, backing, etc.  This can account for real physical memory usage
> even in cases like fork without exec (which Android uses heavily to share
> as many private COW pages as possible between processes), Kernel SamePage
> Merging, and clean zero pages.  It produces a measurement of the pages
> that only exist in that process (USS, for unique), and a measurement of
> the physical memory usage of that process with the cost of shared pages
> being evenly split between processes that share them (PSS).
> 
> If all anonymous memory is indistinguishable then figuring out the real
> physical memory usage (PSS) of each heap requires either a pagemap walking
> tool that can understand the heap debugging of every layer, or for every
> layer's heap debugging tools to implement the pagemap walking logic, in
> which case it is hard to get a consistent view of memory across the whole
> system.
> 
> Tracking the information in userspace leads to all sorts of problems.
> It either needs to be stored inside the process, which means every
> process has to have an API to export its current heap information upon
> request, or it has to be stored externally in a filesystem that
> somebody needs to clean up on crashes.  It needs to be readable while
> the process is still running, so it has to have some sort of
> synchronization with every layer of userspace.  Efficiently tracking
> the ranges requires reimplementing something like the kernel vma
> trees, and linking to it from every layer of userspace.  It requires
> more memory, more syscalls, more runtime cost, and more complexity to
> separately track regions that the kernel is already tracking.
> 
> This patch adds a field to /proc/pid/maps and /proc/pid/smaps to show a
> userspace-provided name for anonymous vmas.  The names of named anonymous
> vmas are shown in /proc/pid/maps and /proc/pid/smaps as [anon:<name>].
> 
> Userspace can set the name for a region of memory by calling
> prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, start, len, (unsigned long)name);

So this can cause a vma to be split, if [start,len] doesn't exactly
describe an existing vma?  If so, is this at all useful?  If not then
`len' isn't needed - just pass in some address within an existing vma?

> Setting the name to NULL clears it. The name length limit is 80 bytes
> including NUL-terminator and is checked to contain only printable ascii
> characters (including space), except '[',']','\','$' and '`'.
> 
> The name is stored in a pointer in the shared union in vm_area_struct
> that points to a null terminated string. Anonymous vmas with the same
> name (equivalent strings) and are otherwise mergeable will be merged.

So this can prevent vma merging if used incorrectly (or maliciously -
can't think how)?  What are the potential impacts of this?

> The name pointers are not shared between vmas even if they contain the
> same name. The name pointer is stored in a union with fields that are
> only used on file-backed mappings, so it does not increase memory usage.
> 
> The patch is based on the original patch developed by Colin Cross, more
> specifically on its latest version [1] posted upstream by Sumit Semwal.
> It used a userspace pointer to store vma names. In that design, name
> pointers could be shared between vmas. However during the last upstreaming
> attempt, Kees Cook raised concerns [2] about this approach and suggested
> to copy the name into kernel memory space, perform validity checks [3]
> and store as a string referenced from vm_area_struct.
> One big concern is about fork() performance which would need to strdup
> anonymous vma names. Dave Hansen suggested experimenting with worst-case
> scenario of forking a process with 64k vmas having longest possible names
> [4]. I ran this experiment on an ARM64 Android device and recorded a
> worst-case regression of almost 40% when forking such a process. This
> regression is addressed in the followup patch which replaces the pointer
> to a name with a refcounted structure that allows sharing the name pointer
> between vmas of the same name. Instead of duplicating the string during
> fork() or when splitting a vma it increments the refcount.

Generally, the patch adds a bunch of code which a lot of users won't
want.  Did we bust a gut to reduce this impact?  Was a standalone
config setting considered?

And what would be the impact of making this feature optional?  Is a
proliferation of formats in /proc/pid/maps going to make userspace
parsers harder to develop and test?

I do think that saying "The names of named anonymous vmas are shown in
/proc/pid/maps and /proc/pid/smaps as [anon:<name>]." is a bit thin. 
Please provide sample output so we can consider these things better.

What are the risks that existing parsers will be broken by such changes?


