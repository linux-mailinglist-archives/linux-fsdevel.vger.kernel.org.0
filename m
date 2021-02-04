Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1D930FBC5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 19:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhBDSli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 13:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbhBDSj0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:39:26 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8792EC06178C
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Feb 2021 10:38:40 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id f6so4317732ioz.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Feb 2021 10:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=weEyJ4NqUKzgrDe976axknYedIOOmssjDmQJevNBFW0=;
        b=MUIiQlwYWva12TZR2lmb+89nZsawdJbIyEf5ZHEPKW7k/wPQFjk5rV1/el4UOR1bOV
         bYc+0XomeAFpg2YafF+3e4DlCPvgUVUsypEQ/fr+gzccXl0TPvP32besn7Yme4+sV2nH
         oydU/scUWd1sYUZJRVbxgmINaSAIA2SEEdzSQzka1CoEy0VGDcnxshyVqXhRSefPIstL
         qS6ij5WOm5sMsx6NEboPMReyk/5XXocU10MM98Ve4kRlu4Nj71mrHOOS+4wFmHboApka
         0RYzs97mzQO5Q7u1HtnqTwtTc/bAs72cSxHVqhTtwVStPc6rBRSWzT2Szu8FweWMVXvV
         vjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=weEyJ4NqUKzgrDe976axknYedIOOmssjDmQJevNBFW0=;
        b=t4l+dKXXcouose6IhYxFlf8tZcscRGwrqyJvMXgAR8vYhcffGTQDLK8TVUqXO0ZX/3
         JbuupW4bXvbA85VR2n2Kn1izcDVf0dgYxjeIg9mw8/1/ripVF8GafQbzumQRhRxKyNVf
         7iXF5WNjoetRmCWnvyW2v6KKIQPB2xOIHJkVikr0BOAVnmi6h8xwqPTkuOuHEr+T4ny0
         PJSw/98MAUTrq5ZmG/cnReuPCxtAjWGXfOEvWACCFkBF5piuk2DBhCAq92w2D0wxxnsC
         r7Vfgr4CdQRAAfPWoLMRVr38ZlzirN6SN+18alL4UqtB3NOwaYoQbz+Sw4vhY8ryBjaK
         QJfA==
X-Gm-Message-State: AOAM5312DBIGI48KMwIX5QbpmLuW/ue127TurTIbSKnLD+jgjU1dzCmS
        80Vld+JOtwvU8HWkeL2u9z2Le3WSRfkmXVmKxtxlpg==
X-Google-Smtp-Source: ABdhPJzHF0Jnubl5GY5YpP/GzWfIKSnTzH6dLwGle8kQioNfx8oFy5GRcwMMftTxFXDx6s2/OYRkyxFjfaTKbPD8trM=
X-Received: by 2002:a6b:f112:: with SMTP id e18mr571110iog.57.1612463919646;
 Thu, 04 Feb 2021 10:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20210204183433.1431202-1-axelrasmussen@google.com>
In-Reply-To: <20210204183433.1431202-1-axelrasmussen@google.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 4 Feb 2021 10:38:02 -0800
Message-ID: <CAJHvVcjMkTC7=gca9EDoKxpadvfyHP73cF6znLvew-F1pNXCeg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] userfaultfd: add minor fault handling
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 4, 2021 at 10:34 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> Changelog
> =========
>
> v3->v4:
> - Reordered if() branches in hugetlb_mcopy_atomic_pte, so the conditions are
>   simpler and easier to read.
> - Reverted most of the mfill_atomic_pte change (the anon / shmem path). Just
>   return -EINVAL for CONTINUE, and set zeropage = (mode ==
>   MCOPY_ATOMIC_ZEROPAGE), so we can keep the delta small.
> - Split out adding #ifdef CONFIG_USERFAULTFD to a separate patch (instead of
>   lumping it together with adding UFFDIO_CONTINUE). Also, extended it to make
>   the same change for shmem as well as suggested by Hugh Dickins.
> - Fixed signature of hugetlb_mcopy_atomic_pte for !CONFIG_HUGETLB_PAGE
>   (signature must be the same in either case).
> - Rebased onto a newer version of Peter's patches to disable huge PMD sharing.

Apologies for the email noise, of course immediately after doing git
send-email I realized I forgot to document one item here:

- Relaxed restriction for minor registration to allow any hugetlb
VMAs, not just those with VM_SHARED. Fixed setting VM_WRITE flag in a
CONTINUE ioctl for non-VM_SHARED VMAs.

>
> v2->v3:
> - Added #ifdef CONFIG_USERFAULTFD around hugetlb helper functions, to fix build
>   errors when building without CONFIG_USERFAULTFD set.
>
> v1->v2:
> - Fixed a bug in the hugetlb_mcopy_atomic_pte retry case. We now plumb in the
>   enum mcopy_atomic_mode, so we can differentiate between the three cases this
>   function needs to handle:
>   1) We're doing a COPY op, and need to allocate a page, add to cache, etc.
>   2) We're doing a COPY op, but allocation in this function failed previously;
>      we're in the retry path. The page was allocated, but not e.g. added to page
>      cache, so that still needs to be done.
>   3) We're doing a CONTINUE op, we need to look up an existing page instead of
>      allocating a new one.
> - Rebased onto a newer version of Peter's patches to disable huge PMD sharing,
>   which fixes syzbot complaints on some non-x86 architectures.
> - Moved __VM_UFFD_FLAGS into userfaultfd_k.h, so inline helpers can use it.
> - Renamed UFFD_FEATURE_MINOR_FAULT_HUGETLBFS to UFFD_FEATURE_MINOR_HUGETLBFS,
>   for consistency with other existing feature flags.
> - Moved the userfaultfd_minor hook in hugetlb.c into the else block, so we don't
>   have to explicitly check for !new_page.
>
> RFC->v1:
> - Rebased onto Peter Xu's patches for disabling huge PMD sharing for certain
>   userfaultfd-registered areas.
> - Added commits which update documentation, and add a self test which exercises
>   the new feature.
> - Fixed reporting CONTINUE as a supported ioctl even for non-MINOR ranges.
>
> Overview
> ========
>
> This series adds a new userfaultfd registration mode,
> UFFDIO_REGISTER_MODE_MINOR. This allows userspace to intercept "minor" faults.
> By "minor" fault, I mean the following situation:
>
> Let there exist two mappings (i.e., VMAs) to the same page(s) (shared memory).
> One of the mappings is registered with userfaultfd (in minor mode), and the
> other is not. Via the non-UFFD mapping, the underlying pages have already been
> allocated & filled with some contents. The UFFD mapping has not yet been
> faulted in; when it is touched for the first time, this results in what I'm
> calling a "minor" fault. As a concrete example, when working with hugetlbfs, we
> have huge_pte_none(), but find_lock_page() finds an existing page.
>
> We also add a new ioctl to resolve such faults: UFFDIO_CONTINUE. The idea is,
> userspace resolves the fault by either a) doing nothing if the contents are
> already correct, or b) updating the underlying contents using the second,
> non-UFFD mapping (via memcpy/memset or similar, or something fancier like RDMA,
> or etc...). In either case, userspace issues UFFDIO_CONTINUE to tell the kernel
> "I have ensured the page contents are correct, carry on setting up the mapping".
>
> Use Case
> ========
>
> Consider the use case of VM live migration (e.g. under QEMU/KVM):
>
> 1. While a VM is still running, we copy the contents of its memory to a
>    target machine. The pages are populated on the target by writing to the
>    non-UFFD mapping, using the setup described above. The VM is still running
>    (and therefore its memory is likely changing), so this may be repeated
>    several times, until we decide the target is "up to date enough".
>
> 2. We pause the VM on the source, and start executing on the target machine.
>    During this gap, the VM's user(s) will *see* a pause, so it is desirable to
>    minimize this window.
>
> 3. Between the last time any page was copied from the source to the target, and
>    when the VM was paused, the contents of that page may have changed - and
>    therefore the copy we have on the target machine is out of date. Although we
>    can keep track of which pages are out of date, for VMs with large amounts of
>    memory, it is "slow" to transfer this information to the target machine. We
>    want to resume execution before such a transfer would complete.
>
> 4. So, the guest begins executing on the target machine. The first time it
>    touches its memory (via the UFFD-registered mapping), userspace wants to
>    intercept this fault. Userspace checks whether or not the page is up to date,
>    and if not, copies the updated page from the source machine, via the non-UFFD
>    mapping. Finally, whether a copy was performed or not, userspace issues a
>    UFFDIO_CONTINUE ioctl to tell the kernel "I have ensured the page contents
>    are correct, carry on setting up the mapping".
>
> We don't have to do all of the final updates on-demand. The userfaultfd manager
> can, in the background, also copy over updated pages once it receives the map of
> which pages are up-to-date or not.
>
> Interaction with Existing APIs
> ==============================
>
> Because it's possible to combine registration modes (e.g. a single VMA can be
> userfaultfd-registered MINOR | MISSING), and because it's up to userspace how to
> resolve faults once they are received, I spent some time thinking through how
> the existing API interacts with the new feature.
>
> UFFDIO_CONTINUE cannot be used to resolve non-minor faults, as it does not
> allocate a new page. If UFFDIO_CONTINUE is used on a non-minor fault:
>
> - For non-shared memory or shmem, -EINVAL is returned.
> - For hugetlb, -EFAULT is returned.
>
> UFFDIO_COPY and UFFDIO_ZEROPAGE cannot be used to resolve minor faults. Without
> modifications, the existing codepath assumes a new page needs to be allocated.
> This is okay, since userspace must have a second non-UFFD-registered mapping
> anyway, thus there isn't much reason to want to use these in any case (just
> memcpy or memset or similar).
>
> - If UFFDIO_COPY is used on a minor fault, -EEXIST is returned.
> - If UFFDIO_ZEROPAGE is used on a minor fault, -EEXIST is returned (or -EINVAL
>   in the case of hugetlb, as UFFDIO_ZEROPAGE is unsupported in any case).
> - UFFDIO_WRITEPROTECT simply doesn't work with shared memory, and returns
>   -ENOENT in that case (regardless of the kind of fault).
>
> Dependencies
> ============
>
> I've included 4 commits from Peter Xu's larger series
> (https://lore.kernel.org/patchwork/cover/1366017/) in this series. My changes
> depend on his work, to disable huge PMD sharing for MINOR registered userfaultfd
> areas. I included the 4 commits directly because a) it lets this series just be
> applied and work as-is, and b) they are fairly standalone, and could potentially
> be merged even without the rest of the larger series Peter submitted. Thanks
> Peter!
>
> Also, although it doesn't affect minor fault handling, I did notice that the
> userfaultfd self test sometimes experienced memory corruption
> (https://lore.kernel.org/patchwork/cover/1356755/). For anyone testing this
> series, it may be useful to apply that series first to fix the selftest
> flakiness. That series doesn't have to be merged into mainline / maintaner
> branches before mine, though.
>
> Future Work
> ===========
>
> Currently the patchset only supports hugetlbfs. There is no reason it can't work
> with shmem, but I expect hugetlbfs to be much more commonly used since we're
> talking about backing guest memory for VMs. I plan to implement shmem support in
> a follow-up patch series.
>
> Axel Rasmussen (6):
>   userfaultfd: add minor fault registration mode
>   userfaultfd: disable huge PMD sharing for MINOR registered VMAs
>   userfaultfd: hugetlbfs: only compile UFFD helpers if config enabled
>   userfaultfd: add UFFDIO_CONTINUE ioctl
>   userfaultfd: update documentation to describe minor fault handling
>   userfaultfd/selftests: add test exercising minor fault handling
>
> Peter Xu (4):
>   hugetlb: Pass vma into huge_pte_alloc() and huge_pmd_share()
>   hugetlb/userfaultfd: Forbid huge pmd sharing when uffd enabled
>   mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h
>   hugetlb/userfaultfd: Unshare all pmds for hugetlbfs when register wp
>
>  Documentation/admin-guide/mm/userfaultfd.rst | 107 ++++++----
>  arch/arm64/mm/hugetlbpage.c                  |   7 +-
>  arch/ia64/mm/hugetlbpage.c                   |   3 +-
>  arch/mips/mm/hugetlbpage.c                   |   4 +-
>  arch/parisc/mm/hugetlbpage.c                 |   2 +-
>  arch/powerpc/mm/hugetlbpage.c                |   3 +-
>  arch/s390/mm/hugetlbpage.c                   |   2 +-
>  arch/sh/mm/hugetlbpage.c                     |   2 +-
>  arch/sparc/mm/hugetlbpage.c                  |   6 +-
>  fs/proc/task_mmu.c                           |   1 +
>  fs/userfaultfd.c                             | 196 ++++++++++++++++---
>  include/linux/hugetlb.h                      |  22 ++-
>  include/linux/mm.h                           |   1 +
>  include/linux/mmu_notifier.h                 |   1 +
>  include/linux/userfaultfd_k.h                |  49 ++++-
>  include/trace/events/mmflags.h               |   1 +
>  include/uapi/linux/userfaultfd.h             |  36 +++-
>  mm/hugetlb.c                                 | 113 +++++++----
>  mm/userfaultfd.c                             |  51 +++--
>  tools/testing/selftests/vm/userfaultfd.c     | 147 +++++++++++++-
>  20 files changed, 601 insertions(+), 153 deletions(-)
>
> --
> 2.30.0.365.g02bc693789-goog
>
