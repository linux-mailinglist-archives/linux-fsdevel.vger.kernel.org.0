Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0B236CECF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 00:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbhD0Wxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 18:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbhD0Wxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 18:53:34 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE13C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 15:52:49 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id h15-20020a37de0f0000b029029a8ada2e18so23981824qkj.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 15:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GgqGGuzhD1zikc9evrYl3z4nS9mGZ4LkConMOTm6ZnM=;
        b=RBJA083nV0OwINFNbZGzFGvPxx8spYk0EhYWMYJjUQekeiV2tnozD5ATAQvLC3Aw0Y
         s3r0dw++jFKmmmH6YzlHyEPtNfjJZWTahD8R8FZ+dU0Y8l0ueE7r5xSlOuUu8Sh0pqgf
         z+p/ojuOj6LshOHPmJJbAG1lIEx43QHtOn5iJlyVFIl/0CDJr/NjZNDf+JTx0Nu0sRa0
         ASAamH6+N8tQg8BESQQoOEZoUhdOc8AxwkjsOHlsYssIhlI6VdN6PvFk7cizZqNKWMDQ
         vAsOQRBda6jzTdwRhgtRgmUSOMHGkX5JU/0AqlGh/6Gyr4mfEZ8XRu1M2mCM+vG+VGVy
         FnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GgqGGuzhD1zikc9evrYl3z4nS9mGZ4LkConMOTm6ZnM=;
        b=NZ5AjyUHnTigVGeshvSHaNH34hHlY+guY2DEcNn2mbG1pYD5z6gsvnwA7eytQgJId+
         rmvAF4a16MFzt+PWA/NQFHlunPe96KX5edE6VNUm6G57W64bbx5brLTjgJUUI9+PYZKl
         VPrOk2KZr+tCS1ztaWedXylPOBCbBjVwWxBi0m6FBVfbDrSNKUv3tgJn1qUkKKahM8N9
         cwS10BG6od9gT/I3TJBGAilIJ9aGzE29B9OG5AJk1mLBwGTkSyFzL6SopEUzwFpwnjVn
         3FL+wvCOq7kpNJvTCuJv6yBGqNoGc03Ezb8WCi8/0UR2bzbiRdkA0jqC8QGpvxv6BK/n
         SyKQ==
X-Gm-Message-State: AOAM533vAZ4iAS5f3/s2bKBWZmMGp0YyrdsIvkrwy4c/7+UUFCsHjpeh
        5AFOv1d7mnOlovD7DXaYhXLDldDHJGNM9OVOC4ag
X-Google-Smtp-Source: ABdhPJzWk7/bz6EFjkPuzPGnL4EMqbxsyH1FZDrCRO9bnagCEpw9VzGysBb09TezIgiIujvfqVKWkwlCzN9XYP5Jzc60
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c423:570b:b823:c33e])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:fcc8:: with SMTP id
 i8mr14210581qvq.31.1619563968524; Tue, 27 Apr 2021 15:52:48 -0700 (PDT)
Date:   Tue, 27 Apr 2021 15:52:34 -0700
Message-Id: <20210427225244.4326-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 00/10] userfaultfd: add minor fault handling for shmem
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Base
====

This series is based on (and therefore should apply cleanly to) the tag
"v5.12-rc7-mmots-2021-04-11-20-49", additionally with Peter's selftest cleanup
series applied first:

https://lore.kernel.org/patchwork/cover/1412450/

Changelog
=========

v4->v5:
- Picked up {Reviewed,Acked}-by's.
- Fix cleanup in error path in shmem_mcopy_atomic_pte(). [Hugh, Peter]
- Mention switching to lru_cache_add() in the commit message of 9/10. [Hugh]
- Split + reorder commits, so now we 1) implement the faulting path, 2)
  implement the CONTINUE ioctl, and 3) advertise the feature. Squash the
  documentation update into step (3). [Hugh, Peter]
- Reorder install_pte() cleanup to come before selftest changes. [Hugh]

v3->v4:
- Fix handling of the shmem private mcopy case. Previously, I had (incorrectly)
  assumed that !vma_is_anonymous() was equivalent to "the page will be in the
  page cache". But, in this case we have an optimization where we allocate a new
  *anonymous* page. So, use a new "bool page_in_cache" instead, which checks if
  page->mapping is set. Correct several places with this new check. [Hugh]
- Fix calling mm_counter() before page_add_..._rmap(). [Hugh]
- When modifying shmem_mcopy_atomic_pte() to use the new install_pte() helper,
  just use lru_cache_add_inactive_or_unevictable(), no need to branch and maybe
  use lru_cache_add(). [Hugh]
- De-pluralize mcopy_atomic_install_pte(s). [Hugh]
- Make "writable" a bool, and initialize consistently. [Hugh]

v2->v3:
- Picked up {Reviewed,Acked}-by's.
- Reorder commits: introduce CONTINUE before MINOR registration. [Hugh, Peter]
- Don't try to {unlock,put}_page an xarray value in shmem_getpage_gfp. [Hugh]
- Move enum mcopy_atomic_mode forward declare out of CONFIG_HUGETLB_PAGE. [Hugh]
- Keep mistakenly removed UFFD_USER_MODE_ONLY in selftest. [Peter]
- Cleanup context management in self test (make clear implicit, remove unneeded
  return values now that we have err()). [Peter]
- Correct dst_pte argument to dst_pmd in shmem_mcopy_atomic_pte macro. [Hugh]
- Mention the new shmem support feature in documentation. [Hugh]

v1->v2:
- Pick up Reviewed-by's.
- Don't swapin page when a minor fault occurs. Notice that it needs to be
  swapped in, and just immediately fire the minor fault. Let a future CONTINUE
  deal with swapping in the page. [Peter]
- Clarify comment about i_size checks in mm/userfaultfd.c. [Peter]
- Only forward declare once (out of #ifdef) in hugetlb.h. [Peter]

Changes since [2]:
- Squash the fixes ([2]) in with the original series ([1]). This makes reviewing
  easier, as we no longer have to sift through deltas undoing what we had done
  before. [Hugh, Peter]
- Modify shmem_mcopy_atomic_pte() to use the new mcopy_atomic_install_ptes()
  helper, reducing code duplication. [Hugh]
- Properly trigger handle_userfault() in the shmem_swapin_page() case. [Hugh]
- Use shmem_getpage() instead of find_lock_page() to lookup the existing page in
  for continue. This properly deals with swapped-out pages. [Hugh]
- Unconditionally pte_mkdirty() for anon memory (as before). [Peter]
- Don't include userfaultfd_k.h in either hugetlb.h or shmem_fs.h. [Hugh]
- Add comment for UFFD_FEATURE_MINOR_SHMEM (to match _HUGETLBFS). [Hugh]
- Fix some small cleanup issues (parens, reworded conditionals, reduced plumbing
  of some parameters, simplify labels/gotos, ...). [Hugh, Peter]

Overview
========

See the series which added minor faults for hugetlbfs [3] for a detailed
overview of minor fault handling in general. This series adds the same support
for shmem-backed areas.

This series is structured as follows:

- Commits 1 and 2 are cleanups.
- Commits 3 and 4 implement the new feature (minor fault handling for shmem).
- Commit 5 advertises that the feature is now available since at this point it's
  fully implemented.
- Commit 6 is a final cleanup, modifying an existing code path to re-use a new
  helper we've introduced.
- Commits 7, 8, 9, 10 update the userfaultfd selftest to exercise the feature.

Use Case
========

In some cases it is useful to have VM memory backed by tmpfs instead of
hugetlbfs. So, this feature will be used to support the same VM live migration
use case described in my original series.

Additionally, Android folks (Lokesh Gidra <lokeshgidra@google.com>) hope to
optimize the Android Runtime garbage collector using this feature:

"The plan is to use userfaultfd for concurrently compacting the heap. With
this feature, the heap can be shared-mapped at another location where the
GC-thread(s) could continue the compaction operation without the need to
invoke userfault ioctl(UFFDIO_COPY) each time. OTOH, if and when Java threads
get faults on the heap, UFFDIO_CONTINUE can be used to resume execution.
Furthermore, this feature enables updating references in the 'non-moving'
portion of the heap efficiently. Without this feature, uneccessary page
copying (ioctl(UFFDIO_COPY)) would be required."

[1] https://lore.kernel.org/patchwork/cover/1388144/
[2] https://lore.kernel.org/patchwork/patch/1408161/
[3] https://lore.kernel.org/linux-fsdevel/20210301222728.176417-1-axelrasmussen@google.com/T/#t

Axel Rasmussen (10):
  userfaultfd/hugetlbfs: avoid including userfaultfd_k.h in hugetlb.h
  userfaultfd/shmem: combine shmem_{mcopy_atomic,mfill_zeropage}_pte
  userfaultfd/shmem: support minor fault registration for shmem
  userfaultfd/shmem: support UFFDIO_CONTINUE for shmem
  userfaultfd/shmem: advertise shmem minor fault support
  userfaultfd/shmem: modify shmem_mcopy_atomic_pte to use install_pte()
  userfaultfd/selftests: use memfd_create for shmem test type
  userfaultfd/selftests: create alias mappings in the shmem test
  userfaultfd/selftests: reinitialize test context in each test
  userfaultfd/selftests: exercise minor fault handling shmem support

 Documentation/admin-guide/mm/userfaultfd.rst |   3 +-
 fs/userfaultfd.c                             |   6 +-
 include/linux/hugetlb.h                      |   4 +-
 include/linux/shmem_fs.h                     |  17 +-
 include/linux/userfaultfd_k.h                |   5 +
 include/uapi/linux/userfaultfd.h             |   7 +-
 mm/hugetlb.c                                 |   1 +
 mm/memory.c                                  |   8 +-
 mm/shmem.c                                   | 110 +++-----
 mm/userfaultfd.c                             | 175 ++++++++----
 tools/testing/selftests/vm/userfaultfd.c     | 274 ++++++++++++-------
 11 files changed, 360 insertions(+), 250 deletions(-)

--
2.31.1.498.g6c1eba8ee3d-goog

