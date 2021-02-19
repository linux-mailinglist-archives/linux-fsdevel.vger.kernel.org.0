Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4AF31F362
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 01:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhBSAtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 19:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBSAtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 19:49:13 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05459C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 16:48:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c12so4817136ybf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 16:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=q7QaBlbWv3NBtuB+YOFPN9gQ4pVgSQPmk+IeoCyEehc=;
        b=lY5C+AMjOsJTtrHSNw9lEuZ1clFpr2Sj6NAk1tYvxaaRPvSTHDxF/tvtWd6DtDaDM0
         /xLHUOcotEX5P/8135vkoconjrVYDrEa/55z50JK48dw88dPavtUOW00L/nhpvTBoQM7
         bFQptRmC4EBVB2eunq/Eoh8q2BeUwrxXLpryC1l6wX+IimtsAYwgRIBSDpYfDmPF/0CY
         uJv9y97oxlkYYFjGHZHx/nwpl2k4fMYH6yXOyg3Nx4jF9xBzmCdNGT65aKoXH3lYPRG+
         Ey2/t/qR6Rp/YvAXYbW0YQqcwRlflB3kwNMmm+2C2GCJnO6irrK4NWROokl/hhV510wJ
         6xiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=q7QaBlbWv3NBtuB+YOFPN9gQ4pVgSQPmk+IeoCyEehc=;
        b=ZKFTvyQs7Jlq7SCgNdJ3sM6GjwwKQFvy66lW12sxEjH9YrbLhl2ss+iAzZKguhWmjI
         qkBsC3R53+w+gjdFKpqgRXMnTAkoY7QnCM7lxBNYZI7Dqzm6sxPm1yixNb3iKeCLLwA3
         +8lLDBjV/Kfb1JVQ2HZyI5dYGW/K0OQf6WZZ5cwzhzLvlGvxYWwYnzktDeaKQ/YmrzNH
         YaX3P+eEcXQKsVT8IU88o3aXP16M0joK4zXT35J4FwB2lZu6SP03c+Lr0iJDtMWQdW42
         X5jQHpjD8UIJ0gdCNm0oIgjo7NxiStN7TE0XtoA8OFYOhF+5Fv7nj7V0Ua0wlU0Xs5jP
         n8EA==
X-Gm-Message-State: AOAM532uq8zJRkClat5Qb/3P+DIMAcBCUlhS+MluF91yNpsMk9TqjTUd
        3GwjzfHehpQ2PYjyK0WQP4Mq8nPuPSZIZi0le+N8
X-Google-Smtp-Source: ABdhPJw20FVBP4ixaaeXhzgbyoyCXGqmssh5Md8lwOaflg/8VpV6GQUNH8eJkNM7/1yeBp0hsJnAYzSEBofQgPDc2cGF
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:e939:4cce:117:5af3])
 (user=axelrasmussen job=sendgmr) by 2002:a25:6e57:: with SMTP id
 j84mr11224786ybc.277.1613695712025; Thu, 18 Feb 2021 16:48:32 -0800 (PST)
Date:   Thu, 18 Feb 2021 16:48:18 -0800
Message-Id: <20210219004824.2899045-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v7 0/6] userfaultfd: add minor fault handling
From:   Axel Rasmussen <axelrasmussen@google.com>
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
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Base
====

This series is based on linux-next/akpm. Additionally, this series depends on
Peter Xu's series to allow disabling huge pmd sharing.

[1] https://lore.kernel.org/patchwork/cover/1382204/

Changelog
=========

v6->v7:
- Based upon discussion, switched back to the VM_* flags approach which was used
  in v5, instead of implementing this as an API feature. Switched to using a
  high bit (instead of brokenly conflicting with VM_LOCKED), which implies
  introducing CONFIG_HAVE_ARCH_USERFAULTFD_MINOR and selecting it only on 64-bit
  architectures (x86_64 and arm64 for now).

v5->v6:
- Fixed the condition guarding a second case where we unlock_page() in
  hugetlb_mcopy_atomic_pte().
- Significantly refactored how minor registration works. Because there are no
  VM_* flags available to use, it has to be a userfaultfd API feature, rather
  than a registration mode. This has a few knock on consequences worth calling
  out:
    - userfaultfd_minor() can no longer be inline, because we have to inspect
      the userfaultfd_ctx, which is only defined in fs/userfaultfd.c. This means
      slightly more overhead (1 function call) on all hugetlbfs minor faults.
    - vma_can_userfault() no longer changes. It seems valid to me to create an
      FD with the minor fault feature enabled, and then register e.g. some
      non-hugetlbfs region in MISSING mode, fully expecting to not get any minor
      faults for it, alongside some other region which you *do* want minor
      faults for. So, at registration time, either should be accepted.
    - Since I'm no longer adding a new registration mode, I'm no longer
      introducing __VM_UFFD_FLAGS or UFFD_API_REGISTER_MODES, and all the
      related cleanups have been reverted.

v4->v5:
- Typo fix in the documentation update.
- Removed comment in vma_can_userfault. The same information is better covered
  in the documentation update, so the comment is unnecessary (and slightly
  confusing as written).
- Reworded comment for MCOPY_ATOMIC_CONTINUE mode.
- For non-shared CONTINUE, only make the PTE(s) non-writable, don't change flags
  on the VMA.
- In hugetlb_mcopy_atomic_pte, always unlock the page in MCOPY_ATOMIC_CONTINUE,
  even if we don't have VM_SHARED.
- In hugetlb_mcopy_atomic_pte, introduce "bool is_continue" to make that kind of
  mode check more terse.
- Merged two nested if()s into a single expression in __mcopy_atomic_hugetlb.
- Moved "return -EINVAL if MCOPY_CONTINUE isn't supported for this vma type" up
  one level, into __mcopy_atomic.
- Rebased onto linux-next/akpm, instead of the latest 5.11 RC. Resolved
  conflicts with Mike's recent hugetlb changes.

v3->v4:
- Relaxed restriction for minor registration to allow any hugetlb VMAs, not
  just those with VM_SHARED. Fixed setting VM_WRITE flag in a CONTINUE ioctl
  for non-VM_SHARED VMAs.
- Reordered if() branches in hugetlb_mcopy_atomic_pte, so the conditions are
  simpler and easier to read.
- Reverted most of the mfill_atomic_pte change (the anon / shmem path). Just
  return -EINVAL for CONTINUE, and set zeropage = (mode ==
  MCOPY_ATOMIC_ZEROPAGE), so we can keep the delta small.
- Split out adding #ifdef CONFIG_USERFAULTFD to a separate patch (instead of
  lumping it together with adding UFFDIO_CONTINUE).
- Fixed signature of hugetlb_mcopy_atomic_pte for !CONFIG_HUGETLB_PAGE
  (signature must be the same in either case).
- Rebased onto a newer version of Peter's patches to disable huge PMD sharing.

v2->v3:
- Added #ifdef CONFIG_USERFAULTFD around hugetlb helper functions, to fix build
  errors when building without CONFIG_USERFAULTFD set.

v1->v2:
- Fixed a bug in the hugetlb_mcopy_atomic_pte retry case. We now plumb in the
  enum mcopy_atomic_mode, so we can differentiate between the three cases this
  function needs to handle:
  1) We're doing a COPY op, and need to allocate a page, add to cache, etc.
  2) We're doing a COPY op, but allocation in this function failed previously;
     we're in the retry path. The page was allocated, but not e.g. added to page
     cache, so that still needs to be done.
  3) We're doing a CONTINUE op, we need to look up an existing page instead of
     allocating a new one.
- Rebased onto a newer version of Peter's patches to disable huge PMD sharing,
  which fixes syzbot complaints on some non-x86 architectures.
- Moved __VM_UFFD_FLAGS into userfaultfd_k.h, so inline helpers can use it.
- Renamed UFFD_FEATURE_MINOR_FAULT_HUGETLBFS to UFFD_FEATURE_MINOR_HUGETLBFS,
  for consistency with other existing feature flags.
- Moved the userfaultfd_minor hook in hugetlb.c into the else block, so we don't
  have to explicitly check for !new_page.

RFC->v1:
- Rebased onto Peter Xu's patches for disabling huge PMD sharing for certain
  userfaultfd-registered areas.
- Added commits which update documentation, and add a self test which exercises
  the new feature.
- Fixed reporting CONTINUE as a supported ioctl even for non-MINOR ranges.

Overview
========

This series adds a new userfaultfd feature, UFFD_FEATURE_MINOR_HUGETLBFS. When
enabled (via the UFFDIO_API ioctl), this feature means that any hugetlbfs VMAs
registered with UFFDIO_REGISTER_MODE_MISSING will *also* get events for "minor"
faults. By "minor" fault, I mean the following situation:

Let there exist two mappings (i.e., VMAs) to the same page(s) (shared memory).
One of the mappings is registered with userfaultfd (in minor mode), and the
other is not. Via the non-UFFD mapping, the underlying pages have already been
allocated & filled with some contents. The UFFD mapping has not yet been
faulted in; when it is touched for the first time, this results in what I'm
calling a "minor" fault. As a concrete example, when working with hugetlbfs, we
have huge_pte_none(), but find_lock_page() finds an existing page.

We also add a new ioctl to resolve such faults: UFFDIO_CONTINUE. The idea is,
userspace resolves the fault by either a) doing nothing if the contents are
already correct, or b) updating the underlying contents using the second,
non-UFFD mapping (via memcpy/memset or similar, or something fancier like RDMA,
or etc...). In either case, userspace issues UFFDIO_CONTINUE to tell the kernel
"I have ensured the page contents are correct, carry on setting up the mapping".

Use Case
========

Consider the use case of VM live migration (e.g. under QEMU/KVM):

1. While a VM is still running, we copy the contents of its memory to a
   target machine. The pages are populated on the target by writing to the
   non-UFFD mapping, using the setup described above. The VM is still running
   (and therefore its memory is likely changing), so this may be repeated
   several times, until we decide the target is "up to date enough".

2. We pause the VM on the source, and start executing on the target machine.
   During this gap, the VM's user(s) will *see* a pause, so it is desirable to
   minimize this window.

3. Between the last time any page was copied from the source to the target, and
   when the VM was paused, the contents of that page may have changed - and
   therefore the copy we have on the target machine is out of date. Although we
   can keep track of which pages are out of date, for VMs with large amounts of
   memory, it is "slow" to transfer this information to the target machine. We
   want to resume execution before such a transfer would complete.

4. So, the guest begins executing on the target machine. The first time it
   touches its memory (via the UFFD-registered mapping), userspace wants to
   intercept this fault. Userspace checks whether or not the page is up to date,
   and if not, copies the updated page from the source machine, via the non-UFFD
   mapping. Finally, whether a copy was performed or not, userspace issues a
   UFFDIO_CONTINUE ioctl to tell the kernel "I have ensured the page contents
   are correct, carry on setting up the mapping".

We don't have to do all of the final updates on-demand. The userfaultfd manager
can, in the background, also copy over updated pages once it receives the map of
which pages are up-to-date or not.

Interaction with Existing APIs
==============================

Because this is a feature, a registered VMA could potentially receive both
missing and minor faults. I spent some time thinking through how the existing
API interacts with the new feature:

UFFDIO_CONTINUE cannot be used to resolve non-minor faults, as it does not
allocate a new page. If UFFDIO_CONTINUE is used on a non-minor fault:

- For non-shared memory or shmem, -EINVAL is returned.
- For hugetlb, -EFAULT is returned.

UFFDIO_COPY and UFFDIO_ZEROPAGE cannot be used to resolve minor faults. Without
modifications, the existing codepath assumes a new page needs to be allocated.
This is okay, since userspace must have a second non-UFFD-registered mapping
anyway, thus there isn't much reason to want to use these in any case (just
memcpy or memset or similar).

- If UFFDIO_COPY is used on a minor fault, -EEXIST is returned.
- If UFFDIO_ZEROPAGE is used on a minor fault, -EEXIST is returned (or -EINVAL
  in the case of hugetlb, as UFFDIO_ZEROPAGE is unsupported in any case).
- UFFDIO_WRITEPROTECT simply doesn't work with shared memory, and returns
  -ENOENT in that case (regardless of the kind of fault).

Future Work
===========

Currently the patchset only supports hugetlbfs. There is no reason it can't work
with shmem, but I expect hugetlbfs to be much more commonly used since we're
talking about backing guest memory for VMs. I plan to implement shmem support in
a follow-up patch series.

Axel Rasmussen (6):
  userfaultfd: add minor fault registration mode
  userfaultfd: disable huge PMD sharing for MINOR registered VMAs
  userfaultfd: hugetlbfs: only compile UFFD helpers if config enabled
  userfaultfd: add UFFDIO_CONTINUE ioctl
  userfaultfd: update documentation to describe minor fault handling
  userfaultfd/selftests: add test exercising minor fault handling

 Documentation/admin-guide/mm/userfaultfd.rst | 107 +++++++-----
 arch/arm64/Kconfig                           |   1 +
 arch/x86/Kconfig                             |   1 +
 fs/proc/task_mmu.c                           |   3 +
 fs/userfaultfd.c                             | 146 +++++++++++++----
 include/linux/hugetlb.h                      |   7 +
 include/linux/mm.h                           |   7 +
 include/linux/userfaultfd_k.h                |  46 +++++-
 include/trace/events/mmflags.h               |   9 +-
 include/uapi/linux/userfaultfd.h             |  36 +++-
 init/Kconfig                                 |   5 +
 mm/hugetlb.c                                 |  75 +++++++--
 mm/userfaultfd.c                             |  37 +++--
 tools/testing/selftests/vm/userfaultfd.c     | 164 ++++++++++++++++++-
 14 files changed, 529 insertions(+), 115 deletions(-)

--
2.30.0.617.g56c4b15f3c-goog

