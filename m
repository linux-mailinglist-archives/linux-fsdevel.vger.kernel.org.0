Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B52C74171E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 19:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjF1RZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjF1RZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:25:35 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2241D1FD7
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:25:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56fffdea2d0so628537b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687973133; x=1690565133;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hMZRtPRHvkkt7QqAFekeMTqeELkYPbEsxE5DbVGbAQw=;
        b=WJ1srCN4efbgzWv3Rm7jHxnLtnFQ2wC8rKhvLnebGnMmhfm1vwe75Fpp9qURntM6rK
         HXEFdZdpYeBoY0oo2q8NVYAYDB2Af2TBcc08grhsroRYbC4wgzxne2wT/iqImNvLju32
         boskIvVwSb4RiHLzq10iAh2+0lvX9vd5veraKc/6XEyYO5TBSlO3TEHmoa8itoh4h48s
         O2lr9wHEgZTwZdenimo4cU9XzUz/E9rtjJPoOH7wBjEFI+PW0EPeTkJKaDva9+T1pgpP
         EZAUMcpKGPzBanBAIx37EPdwB3MHQztoeF9Nyb+oN+m3+K7F9NvyBZr0epvPDK8hqfB/
         Nmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973133; x=1690565133;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMZRtPRHvkkt7QqAFekeMTqeELkYPbEsxE5DbVGbAQw=;
        b=ewZ0dEIM0e5S6m2gN5UxiLMh1WIhVb+xK2xLSsCiiY5YVGtWOhyBWCKdekNBZR2Kv0
         FzSWe+VL+ZKwGPo89KEbu7gjFfgoK0mlRnJG/uMTJ4bKotqH4NXCRMP4FK1lvo0pOcCt
         CUmvm2gyHDjHevEsxYLNtxbi7rkkc7g0UDcn1BQxaVL96GxNi9I9IrotYAluzOXKupoh
         K/nSVmz3JS9vSstdW0/DBwvbVEmfVe+5xyMd9+knkmds1NaxGuDofwgTW2hGYGOW7kck
         /1p4pZTVradSh1Yz3Grf7zZwJv5rBfXLxQu/ZNKlmjx6rLJlHE6mZ4Vd6hAfNCXvSLL5
         2KSQ==
X-Gm-Message-State: AC+VfDxCRclAbmBIB16a99YH6wEypdodYUCs8K79MA/OT6/IzTnfoCqs
        919nmbnaOMYAiPfyi+l+kCC4fT0sGs0=
X-Google-Smtp-Source: ACHHUZ4DvlNUYTACDbiNlaFJHL9tx6qnixg7xtHhlSbjHbe7y4H1JUre29eeW6meRLf/iFtOPgU9zt+em+E=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:eea3:e898:7d7a:1125])
 (user=surenb job=sendgmr) by 2002:a05:690c:701:b0:565:bd68:b493 with SMTP id
 bs1-20020a05690c070100b00565bd68b493mr15502484ywb.6.1687973133351; Wed, 28
 Jun 2023 10:25:33 -0700 (PDT)
Date:   Wed, 28 Jun 2023 10:25:23 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628172529.744839-1-surenb@google.com>
Subject: [PATCH v5 0/6] Per-VMA lock support for swap and userfaults
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When per-VMA locks were introduced in [1] several types of page faults
would still fall back to mmap_lock to keep the patchset simple. Among them
are swap and userfault pages. The main reason for skipping those cases was
the fact that mmap_lock could be dropped while handling these faults and
that required additional logic to be implemented.
Implement the mechanism to allow per-VMA locks to be dropped for these
cases.
First, change handle_mm_fault to drop per-VMA locks when returning
VM_FAULT_RETRY or VM_FAULT_COMPLETED to be consistent with the way
mmap_lock is handled. Then change folio_lock_or_retry to accept vm_fault
and return vm_fault_t which simplifies later patches. Finally allow swap
and uffd page faults to be handled under per-VMA locks by dropping per-VMA
and retrying, the same way it's done under mmap_lock.
Naturally, once VMA lock is dropped that VMA should be assumed unstable
and can't be used.

Changes since v4 posted at [2]
- 5/6 changed setting VM_FAULT_RETRY bit to an assignment, per Peter Xu
- 5/6 moved release_fault_lock to its final place, per Peter Xu
- 6/6 removed mm parameter in assert_fault_locked, per Peter Xu
- 6/6 replaced BUG_ON with WARN_ON_ONCE and moved the check for
FAULT_FLAG_RETRY_NOWAIT && FAULT_FLAG_VMA_LOCK into sanitize_fault_flags,
per Peter Xu

Note: patch 3/8 will cause a trivial merge conflict in arch/arm64/mm/fault.c
when applied over mm-unstable branch due to a patch from ARM64 tree [3]
which is missing in mm-unstable.

[1] https://lore.kernel.org/all/20230227173632.3292573-1-surenb@google.com/
[2] https://lore.kernel.org/all/20230628071800.544800-1-surenb@google.com/
[3] https://lore.kernel.org/all/20230524131305.2808-1-jszhang@kernel.org/

Suren Baghdasaryan (6):
  swap: remove remnants of polling from read_swap_cache_async
  mm: add missing VM_FAULT_RESULT_TRACE name for VM_FAULT_COMPLETED
  mm: drop per-VMA lock when returning VM_FAULT_RETRY or
    VM_FAULT_COMPLETED
  mm: change folio_lock_or_retry to use vm_fault directly
  mm: handle swap page faults under per-VMA lock
  mm: handle userfaults under VMA lock

 arch/arm64/mm/fault.c    |  3 ++-
 arch/powerpc/mm/fault.c  |  3 ++-
 arch/s390/mm/fault.c     |  3 ++-
 arch/x86/mm/fault.c      |  3 ++-
 fs/userfaultfd.c         | 34 ++++++++++++----------------
 include/linux/mm.h       | 39 ++++++++++++++++++++++++++++++++
 include/linux/mm_types.h |  3 ++-
 include/linux/pagemap.h  |  9 ++++----
 mm/filemap.c             | 37 +++++++++++++++---------------
 mm/madvise.c             |  4 ++--
 mm/memory.c              | 49 ++++++++++++++++++++++------------------
 mm/swap.h                |  1 -
 mm/swap_state.c          | 12 ++++------
 13 files changed, 120 insertions(+), 80 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog

