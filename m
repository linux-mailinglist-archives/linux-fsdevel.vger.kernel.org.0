Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D086359066
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 01:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhDHXnp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 19:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDHXno (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 19:43:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87852C061761
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 16:43:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k199so846264ybf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 16:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MMnSfhCYkJZSRWP1+VLEqWOrqNUR73/DviRG9AOZLYg=;
        b=LhtDACmTgYbILTXL6/+EJFHaBuo+F2p051TBe72ztRCJ/XuVlbOpF83dWSLIbhG0oQ
         GGmcsOgA+kZKXmwoFtXhjQTwzOcRfi4NmApAdGqItqYY3p++w2Lc8PEkxLQzNAHVFDRZ
         Zu62dFCr11fqBsLN9jtEqkEX/RBHZ8OSUys346b0rqnQVvQx3YGb+p8dbGTrpgW5sqRO
         /MPBCQgKAKarc4pQ62sMIrf20lQE6Cy0CZdxWXfuPVVA6KjaILStlTn/OyHIq59gQsLh
         3X6pANiICUh8jPl3ZM0H6y/ZyR9wuYc/YpF7zeWO9c5muLoNzZfoallNAUjAx4LUS3x4
         ReYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MMnSfhCYkJZSRWP1+VLEqWOrqNUR73/DviRG9AOZLYg=;
        b=YWKTIgZHMs81tkFUPBK6jdvBWe/hmkmDJ1Jfltm4emv0trCniSm/frR11rv3WeKUiS
         rBIlV63vCNUyc5PIUCKmvmPcA85i1zF7wUgTyfB4E+J2gC6gWYlejAqOaBn7NvM4W2Vw
         ufhwNQVwmtrcbnHPkM5C3QORhNWhprWBXwI3YV3ampo+bTlPQaheGpYyrbOrFLjRHWpP
         xdizjH5Ra3glCHlxcJcrSAcyopUEbOO0lSPuVaxwg7yD7gFRCEQHIkcMCg1efzmCg9rC
         U3X6UmgBlqMorG1BdDPHka5AJZJse+RdiMn/tUfzxiVbPaUqRKGb4jKz7iZv4KVYuV50
         W8ww==
X-Gm-Message-State: AOAM5325HgyxTrz9KtOtRTRkNuduSDQf12aMZF3LK21y/Pt3bn0KOIEB
        uu3DgwfRpRsWfS8UZiHNbJEdMH4Qe4YpOAjW4FfF
X-Google-Smtp-Source: ABdhPJzkp9CEYUxHFGCgud8buw3fO/a/mBZ0krmDrBQMygLKQty7cBNK28FOPd8XyjX019sQC1OyXtn3hc4fzeu703AT
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d06:d00f:a626:675a])
 (user=axelrasmussen job=sendgmr) by 2002:a25:adc2:: with SMTP id
 d2mr16351457ybe.334.1617925411786; Thu, 08 Apr 2021 16:43:31 -0700 (PDT)
Date:   Thu,  8 Apr 2021 16:43:18 -0700
Message-Id: <20210408234327.624367-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 0/9] userfaultfd: add minor fault handling for shmem
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
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

Since the original series [1] was merged into Andrew's tree, some issues were
noticed. Up to this point, we had been working on fixing what's in Andrew's
tree [2], but at this point we've changed direction enough that a lot of the
fix's delta is undoing what was done in the original series, thereby making it
hard to review.

As suggested by Hugh Dickins and Peter Xu, this series takes a step back. It can
be considered a v3 of the original series [1] - it combines those patches with
the fixes, reordered / broken up to allow for easier review.

The idea is that it will apply cleanly to akpm's tree, *replacing* the following
patches (i.e., drop these first, and then apply this series):

userfaultfd-support-minor-fault-handling-for-shmem.patch
userfaultfd-support-minor-fault-handling-for-shmem-fix.patch
userfaultfd-support-minor-fault-handling-for-shmem-fix-2.patch
userfaultfd-support-minor-fault-handling-for-shmem-fix-3.patch
userfaultfd-support-minor-fault-handling-for-shmem-fix-4.patch
userfaultfd-selftests-use-memfd_create-for-shmem-test-type.patch
userfaultfd-selftests-create-alias-mappings-in-the-shmem-test.patch
userfaultfd-selftests-reinitialize-test-context-in-each-test.patch
userfaultfd-selftests-exercise-minor-fault-handling-shmem-support.patch

Changelog
=========

Changes since the most recent fixup patch [2]:
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
 include/linux/hugetlb.h                  |   5 +-
 include/linux/shmem_fs.h                 |  15 +-
 include/linux/userfaultfd_k.h            |   5 +
 include/uapi/linux/userfaultfd.h         |   7 +-
 mm/hugetlb.c                             |   1 +
 mm/memory.c                              |   8 +-
 mm/shmem.c                               | 122 ++++------
 mm/userfaultfd.c                         | 183 ++++++++++-----
 tools/testing/selftests/vm/userfaultfd.c | 280 +++++++++++++++--------
 10 files changed, 387 insertions(+), 245 deletions(-)

--
2.31.1.295.g9ea45b61b8-goog

