Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88117BD3A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 08:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345306AbjJIGmj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 02:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345307AbjJIGmh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:42:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5625ADE
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Oct 2023 23:42:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81646fcf3eso5766266276.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Oct 2023 23:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696833754; x=1697438554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7zUUB2am9n9CKFAnT6nZ8XawbgT1VoZ44ZKp10n60qQ=;
        b=e4uqqOI/kMhj3oqOpwHWHl2dhFfOhTeUYy+IvEDgvhXL5DvHLtlYn3AJN97YbZaep/
         0XuU+r9qUGov98a2Ae9choukSs9E1FJrerpwyqtyq8G3h8asHBDqp45dMD1uZrVcl35o
         PIjmpKrWQhfROJjoZWOPabQW/An+uYz/U0rpEumjgstHxiqWfsw+vv5GIXyXaJoygBAX
         IxFuBOu+MkBJbvrNiO2b46hEacR9GVhqI8o4SdoMRFSLUvXolpCl6xgnWwaHhZ9Z0GGO
         7haTOw/g6oCg8gMyA4YE/AKOrb+jH8CtwO48erbJKr0P+jryH4+mjSDAlzDn7g8xq2+q
         nfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696833754; x=1697438554;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zUUB2am9n9CKFAnT6nZ8XawbgT1VoZ44ZKp10n60qQ=;
        b=BGII11zA4j2NUHm9MXxdbcSCcjjcf4v7BcSFhBau/S2hwg0RdE4GqDImI83b8/ky+M
         icunL3mDrit36bS8BoVsHtAQkXVgZh6HPV8kyzjMLqIWbM/i7KYswqTz6hFANhDUokDS
         FroMax7f+wAsfupkCkgpYJl8hsq+Y9qgdgJz840Mq74+1c92Gl8DzlCmlI9RSDl4bN7G
         LpMFcr+RsZZbE18kBeM7qLIGl5M0kwKG27yiZd8FD+RW+LEy2VDow1bMNbh4noKBuQI1
         vUf8GA5ME4eyKxcZJQoYnjtXagPilgqBL5jjYK9Z3OKvLLosCRW+HcxeDKTMNtu5Dk0H
         M39A==
X-Gm-Message-State: AOJu0YyEA+FU8GbQ2d4ZCpNvgf79nJ40YpQ4SqYRMsNByXV8/EVoWE5q
        Z54l5gRXxxibREoNkdPNaC+aWEgdNkU=
X-Google-Smtp-Source: AGHT+IFgAg9kuGpXCr3YUWTFgYRcSR2EjJOWKwvSOMrijuF0wKr/70tmErg8XwfV2RFmODsMhMgBsAEZSjM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3e83:601e:dc42:a455])
 (user=surenb job=sendgmr) by 2002:a25:ad50:0:b0:d78:2c3:e633 with SMTP id
 l16-20020a25ad50000000b00d7802c3e633mr204458ybe.2.1696833754494; Sun, 08 Oct
 2023 23:42:34 -0700 (PDT)
Date:   Sun,  8 Oct 2023 23:42:25 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231009064230.2952396-1-surenb@google.com>
Subject: [PATCH v3 0/3] userfaultfd move option
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        david@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series introduces UFFDIO_MOVE feature to userfaultfd, which
has long been implemented and maintained by Andrea in his local tree [1],
but was not upstreamed due to lack of use cases where this approach would
be better than allocating a new page and copying the contents. Previous
upstraming attempts could be found at [6] and [7].

UFFDIO_COPY performs ~20% better than UFFDIO_MOVE when the application
needs pages to be allocated [2]. However, with UFFDIO_MOVE, if pages are
available (in userspace) for recycling, as is usually the case in heap
compaction algorithms, then we can avoid the page allocation and memcpy
(done by UFFDIO_COPY). Also, since the pages are recycled in the
userspace, we avoid the need to release (via madvise) the pages back to
the kernel [3].
We see over 40% reduction (on a Google pixel 6 device) in the compacting
thread=E2=80=99s completion time by using UFFDIO_MOVE vs. UFFDIO_COPY. This=
 was
measured using a benchmark that emulates a heap compaction implementation
using userfaultfd (to allow concurrent accesses by application threads).
More details of the usecase are explained in [3].

Furthermore, UFFDIO_MOVE enables moving swapped-out pages without
touching them within the same vma. Today, it can only be done by mremap,
however it forces splitting the vma.

Main changes since Andrea's last version [1]:
- Trivial translations from page to folio, mmap_sem to mmap_lock
- Replace pmd_trans_unstable() with pte_offset_map_nolock() and handle its
possible failure
- Move pte mapping into remap_pages_pte to allow for retries when source
page or anon_vma is contended. Since pte_offset_map_nolock() start RCU
read section, we can't block anymore after mapping a pte, so have to unmap
the ptesm do the locking and retry.
- Add and use anon_vma_trylock_write()  to avoid blocking while in RCU
read section.
- Accommodate changes in mmu_notifier_range_init() API, switch to
mmu_notifier_invalidate_range_start_nonblock() to avoid blocking while in
RCU read section.
- Open-code now removed __swp_swapcount()
- Replace pmd_read_atomic() with pmdp_get_lockless()
- Add new selftest for UFFDIO_MOVE

Changes since v1 [4]:
- add mmget_not_zero in userfaultfd_remap, per Jann Horn
- removed extern from function definitions, per Matthew Wilcox
- converted to folios in remap_pages_huge_pmd, per Matthew Wilcox
- use PageAnonExclusive in remap_pages_huge_pmd, per David Hildenbrand
- handle pgtable transfers between MMs, per Jann Horn
- ignore concurrent A/D pte bit changes, per Jann Horn
- split functions into smaller units, per David Hildenbrand
- test for folio_test_large in remap_anon_pte, per Matthew Wilcox
- use pte_swp_exclusive for swapcount check, per David Hildenbrand
- eliminated use of mmu_notifier_invalidate_range_start_nonblock,
per Jann Horn
- simplified THP alignment checks, per Jann Horn
- refactored the loop inside remap_pages, per Jann Horn
- additional clarifying comments, per Jann Horn

Changes since v2 [5]:
- renamed UFFDIO_REMAP to UFFDIO_MOVE, per David Hildenbrand
- rebase over mm-unstable to use folio_move_anon_rmap(),
per David Hildenbrand=20
- added text for manpage explaining DONTFORK and KSM requirements for this
feature, per David Hildenbrand=20
- check for anon_vma changes in the fast path of folio_lock_anon_vma_read,
per Peter Xu
- updated the title and description of the first patch,
per David Hildenbrand
- updating comments in folio_lock_anon_vma_read() explaining the need for
anon_vma checks, per David Hildenbrand
- changed all mapcount checks to PageAnonExclusive, per Jann Horn and
David Hildenbrand
- changed counters in remap_swap_pte() from MM_ANONPAGES to MM_SWAPENTS,
per Jann Horn
- added a check for PTE change after folio is locked in remap_pages_pte(),
per Jann Horn
- added handling of PMD migration entries and bailout when pmd_devmap(),
per Jann Horn
- added checks to ensure both src and dst VMAs are writable, per Peter Xu
- added UFFD_FEATURE_MOVE, per Peter Xu
- removed obsolete comments, per Peter Xu
- renamed remap_anon_pte to remap_present_pte, per Peter Xu
- added a comment for folio_get_anon_vma() explaining the need for
anon_vma checks, per Peter Xu
- changed error handling in remap_pages() to make it more clear,
per Peter Xu
- changed EFAULT to EAGAIN to retry when a hugepage appears or disappears
from under us, per Peter Xu
- added links to previous upstreaming attempts, per David Hildenbrand

[1] https://gitlab.com/aarcange/aa/-/commit/2aec7aea56b10438a3881a20a411aa4=
b1fc19e92
[2] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aarcange@r=
edhat.com/
[3] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqx=
RCyjniNVjp0Aw@mail.gmail.com/
[4] https://lore.kernel.org/all/20230914152620.2743033-1-surenb@google.com/
[5] https://lore.kernel.org/all/20230923013148.1390521-1-surenb@google.com/
[6] https://lore.kernel.org/all/1425575884-2574-21-git-send-email-aarcange@=
redhat.com/
[7] https://lore.kernel.org/all/cover.1547251023.git.blake.caldwell@colorad=
o.edu/

The patchset applies over mm-unstable.

Andrea Arcangeli (2):
  mm/rmap: support move to different root anon_vma in
    folio_move_anon_rmap()
  userfaultfd: UFFDIO_MOVE uABI

Suren Baghdasaryan (1):
  selftests/mm: add UFFDIO_MOVE ioctl test

 Documentation/admin-guide/mm/userfaultfd.rst |   3 +
 fs/userfaultfd.c                             |  63 ++
 include/linux/rmap.h                         |   5 +
 include/linux/userfaultfd_k.h                |  12 +
 include/uapi/linux/userfaultfd.h             |  29 +-
 mm/huge_memory.c                             | 138 +++++
 mm/khugepaged.c                              |   3 +
 mm/rmap.c                                    |  30 +
 mm/userfaultfd.c                             | 602 +++++++++++++++++++
 tools/testing/selftests/mm/uffd-common.c     |  41 +-
 tools/testing/selftests/mm/uffd-common.h     |   1 +
 tools/testing/selftests/mm/uffd-unit-tests.c |  62 ++
 12 files changed, 986 insertions(+), 3 deletions(-)

--=20
2.42.0.609.gbb76f46606-goog

