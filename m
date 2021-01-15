Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB92C2F8504
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 20:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbhAOTFt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 14:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbhAOTFs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:05:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D44FC061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 11:05:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k7so7671028ybm.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 11:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=IkeNtsg12cSB50tpxqXIzuzk3XvZlj8L+XKyLiVN8wU=;
        b=MBEBxfpQEBqCIliIETaRaUKTZcbsd6Hcv0Mxbny7eTvEGyo2GPu0VZVvoktI+twx7J
         d3yx6e6TeRKPns4tt70az8tAnAZuK3/JcVYUq5r2yDdRXy/o+istYEJ/dI25/tYOuIja
         S/oamfLYkivtP8jXWhqL9COrBHog4tE1XqFn1aPzeQF6UKXQxZUZAvlTW66nriJyDTkt
         1RcVCAw8Gv8TeRZ/FU33lWrNZxKGPWlPT/kwA8fSCek0R0bANINBGPx8Gaz/EG2jenCV
         HzYP/T4cEsUNGHaWSRp15VcyzhZlatNxgvWHLQBapRX+ox5sXDO3lMy2rSO29iQ2YDef
         SZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=IkeNtsg12cSB50tpxqXIzuzk3XvZlj8L+XKyLiVN8wU=;
        b=Kb84lUAj4MXu/irS3ZVzr0CCBjJds9baGNE0laboB+Qn3E6b4Mv7l0n1d2hDlwgxz5
         gq7PvcDFRKQpl8e8jTA+phJspnoYyVkPvCoRBN4Imsz0YCraXF2Lw66UjTv7rv21r0rH
         A6iYikWyen9bmtSm4NrbFYME2lJVKZVgHl8G7YoQjI4Fu5eK2KEAeProiq1uVGefoo4F
         jDuZuUnPhBOUie4Z4NPPmttuS3Surjl/4ubqMH3DXOsU0wHKr3rwIYF+EC8uvpl2+aMt
         JU9FswwJ8Y1b0/FKCoEsNPSve7eJZTgp3NY5UTHSOIMGV1HcsqjrbAJMlE8ssJTpVSaW
         vLcA==
X-Gm-Message-State: AOAM533qdlWykbYowy51ip5Czwdwe4FWgRgJixOFnC9iJAdnnEVei4SY
        1Nt8O5hnlBPwpGedfWsjKMZJ3awtjs/5whPvdguf
X-Google-Smtp-Source: ABdhPJwQn2RWmM+M/ljSajZfXa9UgAS8xSA0e9GZGwniB7VIvvmgun3ucQ1PZYPd86SwKRym9WyD2xt7E4HR6Nf6Sxsd
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a25:6187:: with SMTP id
 v129mr20432937ybb.318.1610737507180; Fri, 15 Jan 2021 11:05:07 -0800 (PST)
Date:   Fri, 15 Jan 2021 11:04:42 -0800
Message-Id: <20210115190451.3135416-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 0/9] userfaultfd: add minor fault handling
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
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changelog
=========

RFC->v1:
- Rebased onto Peter Xu's patches for disabling huge PMD sharing for certain
  userfaultfd-registered areas.
- Added commits which update documentation, and add a self test which exercises
  the new feature.
- Fixed reporting CONTINUE as a supported ioctl even for non-MINOR ranges.

Overview
========

This series adds a new userfaultfd registration mode,
UFFDIO_REGISTER_MODE_MINOR. This allows userspace to intercept "minor" faults.
By "minor" fault, I mean the following situation:

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

Because it's possible to combine registration modes (e.g. a single VMA can be
userfaultfd-registered MINOR | MISSING), and because it's up to userspace how to
resolve faults once they are received, I spent some time thinking through how
the existing API interacts with the new feature.

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

Dependencies
============

I've included 4 commits from Peter Xu's larger series
(https://lore.kernel.org/patchwork/cover/1366017/) in this series. My changes
depend on his work, to disable huge PMD sharing for MINOR registered userfaultfd
areas. I included the 4 commits directly because a) it lets this series just be
applied and work as-is, and b) they are fairly standalone, and could potentially
be merged even without the rest of the larger series Peter submitted. Thanks
Peter!

Also, although it doesn't affect minor fault handling, I did notice that the
userfaultfd self test sometimes experienced memory corruption
(https://lore.kernel.org/patchwork/cover/1356755/). For anyone testing this
series, it may be useful to apply that series first to fix the selftest
flakiness. That series doesn't have to be merged into mainline / maintaner
branches before mine, though.

Future Work
===========

Currently the patchset only supports hugetlbfs. There is no reason it can't work
with shmem, but I expect hugetlbfs to be much more commonly used since we're
talking about backing guest memory for VMs. I plan to implement shmem support in
a follow-up patch series.

Axel Rasmussen (5):
  userfaultfd: add minor fault registration mode
  userfaultfd: disable huge PMD sharing for MINOR registered VMAs
  userfaultfd: add UFFDIO_CONTINUE ioctl
  userfaultfd: update documentation to describe minor fault handling
  userfaultfd/selftests: add test exercising minor fault handling

Peter Xu (4):
  hugetlb: Pass vma into huge_pte_alloc()
  hugetlb/userfaultfd: Forbid huge pmd sharing when uffd enabled
  mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h
  hugetlb/userfaultfd: Unshare all pmds for hugetlbfs when register wp

 Documentation/admin-guide/mm/userfaultfd.rst | 105 ++++++----
 arch/arm64/mm/hugetlbpage.c                  |   5 +-
 arch/ia64/mm/hugetlbpage.c                   |   3 +-
 arch/mips/mm/hugetlbpage.c                   |   4 +-
 arch/parisc/mm/hugetlbpage.c                 |   2 +-
 arch/powerpc/mm/hugetlbpage.c                |   3 +-
 arch/s390/mm/hugetlbpage.c                   |   2 +-
 arch/sh/mm/hugetlbpage.c                     |   2 +-
 arch/sparc/mm/hugetlbpage.c                  |   2 +-
 fs/proc/task_mmu.c                           |   1 +
 fs/userfaultfd.c                             | 190 ++++++++++++++++---
 include/linux/hugetlb.h                      |  22 ++-
 include/linux/mm.h                           |   1 +
 include/linux/mmu_notifier.h                 |   1 +
 include/linux/userfaultfd_k.h                |  29 ++-
 include/trace/events/mmflags.h               |   1 +
 include/uapi/linux/userfaultfd.h             |  36 +++-
 mm/hugetlb.c                                 |  61 ++++--
 mm/userfaultfd.c                             |  88 ++++++---
 tools/testing/selftests/vm/userfaultfd.c     | 147 +++++++++++++-
 20 files changed, 570 insertions(+), 135 deletions(-)

--
2.30.0.284.gd98b1dd5eaa7-goog

