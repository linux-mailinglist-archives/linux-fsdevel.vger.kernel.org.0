Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBB335D703
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 07:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244259AbhDMFRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 01:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243984AbhDMFRp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 01:17:45 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC97C06175F
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 22:17:26 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c7so10416632qka.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 22:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wrbaVOYVgCtHDmQ7j5oVc9kHRwzikE6fRM9DNAMARAs=;
        b=ZGD2PSv90bQPpcK7ImkqdxJeL3mh0oBpLqIRyzGn3TPamps4ADC6Ha6Z1lp3ZChArz
         FYE4L8Ygcgoc7zV3RgtZSAewQqWFefjPu3FBOyCcqJyPh9TAjxvxQxMKXKe4MhWXiPL9
         QlTF3H3CT0tkjpPIqB33NvonB1G43LMnC/p9UCQdAEaTlaFwukIB8uyn0RkFOwGoWvdW
         F6opuB/CEyRc1du8vcR2QCriYNIi+qI4CLa5f635Jtc8Qs8dRMEJZekk5JPSdlB9NDsP
         Hab2N4VkNBHBEqH4yI/6UJz7A6LzW+BohwZtJWT7nBSM1/lQJNewPX8yHrH6i4FdegNV
         gfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wrbaVOYVgCtHDmQ7j5oVc9kHRwzikE6fRM9DNAMARAs=;
        b=BbSho2KNCNEzE3IjwDaTN5lwd+DdUYdqlrEereiAl3TWQsQsbn0KK9painOh7JbZGf
         1gWwpOgwIzrjE2qDg6Xykos4A54UtwxkDRZyZcPrRYPPdfq7B5l6PSOVj1I3Ri/IGCm4
         wwW8zNvIZGsgNOV+JSLgS1QgbcEsauDSmBUDL0JQYTOdWQNOQwZxFMTxw8SY7gZoU8Np
         M9U8w1YghDJqb0PsowQnyw0VgV/HdIRhu/FjNy6eefB+CmA5KvQoR/5oUGTOmlibXjoq
         BiAqZ3eVYjXGvDUVw5/RHGYvawrd2RprD2MuIwj7woY14wyC2lJxaP8DQstQ55hdSp35
         jqPA==
X-Gm-Message-State: AOAM533UZ3YCFpeNxtoaaWEORPuJ8b6Gnm9HTCXRE1O9k2k+vuNsWSX0
        I3SrBdNRIupPwVYK2iwxSc6xZL5binnwFdRqIUFL
X-Google-Smtp-Source: ABdhPJwpXWWVE6i6ZWio5ETUunQ5fX9pAV/e48HAXSa7RcyZWuQ4usmUgDe2/6lisFP49TmDPqMTfjVY+n212CLoIqm+
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:d508:eee5:2d57:3e32])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:8d44:: with SMTP id
 s4mr31548867qvb.53.1618291045176; Mon, 12 Apr 2021 22:17:25 -0700 (PDT)
Date:   Mon, 12 Apr 2021 22:17:12 -0700
Message-Id: <20210413051721.2896915-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2 0/9] userfaultfd: add minor fault handling for shmem
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
series applied *first*:

https://lore.kernel.org/patchwork/cover/1412450/

Changelog
=========

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
- Commits 5, 6, 7, 8 update the userfaultfd selftest to exercise the feature.
- Commit 9 is one final cleanup, modifying an existing code path to re-use a new
  helper we've introduced. We rely on the selftest to show that this change
  doesn't break anything.

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

Axel Rasmussen (9):
  userfaultfd/hugetlbfs: avoid including userfaultfd_k.h in hugetlb.h
  userfaultfd/shmem: combine shmem_{mcopy_atomic,mfill_zeropage}_pte
  userfaultfd/shmem: support minor fault registration for shmem
  userfaultfd/shmem: support UFFDIO_CONTINUE for shmem
  userfaultfd/selftests: use memfd_create for shmem test type
  userfaultfd/selftests: create alias mappings in the shmem test
  userfaultfd/selftests: reinitialize test context in each test
  userfaultfd/selftests: exercise minor fault handling shmem support
  userfaultfd/shmem: modify shmem_mcopy_atomic_pte to use install_ptes

 fs/userfaultfd.c                         |   6 +-
 include/linux/hugetlb.h                  |   4 +-
 include/linux/shmem_fs.h                 |  15 +-
 include/linux/userfaultfd_k.h            |   5 +
 include/uapi/linux/userfaultfd.h         |   7 +-
 mm/hugetlb.c                             |   1 +
 mm/memory.c                              |   8 +-
 mm/shmem.c                               | 112 +++------
 mm/userfaultfd.c                         | 183 ++++++++++-----
 tools/testing/selftests/vm/userfaultfd.c | 280 +++++++++++++++--------
 10 files changed, 377 insertions(+), 244 deletions(-)

--
2.31.1.295.g9ea45b61b8-goog

