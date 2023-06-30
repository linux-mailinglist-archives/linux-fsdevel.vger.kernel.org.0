Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFF5743273
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 04:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjF3CEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 22:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjF3CEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:04:42 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91632707
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:04:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-576d63dfc1dso12323977b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688090680; x=1690682680;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GPwwDnKV3zLsafzwT78L/ly5VBmF6yg5GTSdgrnhrkg=;
        b=kfu4pQEacyKKHj9b/2HiXqrRq9FshER4qY3suCOAtPq6+5e5lG4n35E9cJBLZ1bKYZ
         RbfY0xOZmqANZpHbwlHjy5y8qWKF98CV1clCDfR5WzRrby/lWJRpQa4LlrMlj28jbsNI
         ltNIusl/Ne+jF0KZ5IPryUdJU11jGiyAhj2znXrFGKQTkisMzxD/R1rebP6yb1KWUDSR
         2ADGw9E6PU4cO3hLHRB8xbSvP0y1wd5sYL4E3pbPQ2qoNsbpfgOALFrv+LHeZ5VR5pTg
         ntc6D8SUq0XZRsOh3u9F8ajl86QckBCaSKw+uTmZ/fnnxBmS7P3yyGeWylNLPLTJpm0q
         cmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688090680; x=1690682680;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GPwwDnKV3zLsafzwT78L/ly5VBmF6yg5GTSdgrnhrkg=;
        b=OXQZPTjay3pjevqrWz7/wc0X7xPG295qUiHcha5iDrS3kM1AZrb8j+nbA+FBPlA0ap
         +QyUkPVlquWjLIJAO6wkc1+GnDJO6whwcvnn7GwgGv7s28EMyDgsf2iuOhO5XuyE9Hi9
         2szWbkIGG6aW9PG13Zd66fo9w83ssoJrAuOcVNBY7UjkyFIS+Sh/zn82pe/IEbxJJsIL
         38E0ugRMuJjB+qIbA5X6Zkn1DQmEB1RjWJ+eU8uFblD9HLkadfc+RC15hrmejkteENN8
         XQpBEdYd0ad/dnJnq5ra8HXLZ3MHDJ2Oy6HQpVW9lJUfKukqE9kZ3nGyaKQlrn7kwOO0
         O48Q==
X-Gm-Message-State: ABy/qLbu62fgxQrbozQSqIEe9sFOOvmmu9uiEkBmFK0JkMVDJXXDE4kA
        C0GOqcmObuaBt/fkp36thRIQ0YyFyng=
X-Google-Smtp-Source: APBJJlG3yK/4SAhx4gxDQI0ZWRIfNvm139giJ2STexbUqk9qFqQjDK5gzi78T9+ZkFmf7uZf5UkwRTC4Hvo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:1f11:a3d0:19a9:16e5])
 (user=surenb job=sendgmr) by 2002:a25:a249:0:b0:c39:d6f6:481f with SMTP id
 b67-20020a25a249000000b00c39d6f6481fmr11525ybi.10.1688090679885; Thu, 29 Jun
 2023 19:04:39 -0700 (PDT)
Date:   Thu, 29 Jun 2023 19:04:29 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630020436.1066016-1-surenb@google.com>
Subject: [PATCH v6 0/6] Per-VMA lock support for swap and userfaults
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Changes since v5 posted at [2]
- 6/6 moved changes in sanitize_fault_flags into 3/6, per Peter Xu
- rebased over Linus' ToT

Note: patch 3/6 will cause a trivial merge conflict in arch/arm64/mm/fault.c
when applied over mm-unstable branch due to a patch from ARM64 tree [3]
which is missing in mm-unstable.

[1] https://lore.kernel.org/all/20230227173632.3292573-1-surenb@google.com/
[2] https://lore.kernel.org/all/20230628172529.744839-1-surenb@google.com/
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
 include/linux/mm.h       | 37 ++++++++++++++++++++++++++++++
 include/linux/mm_types.h |  3 ++-
 include/linux/pagemap.h  |  9 ++++----
 mm/filemap.c             | 37 +++++++++++++++---------------
 mm/madvise.c             |  4 ++--
 mm/memory.c              | 49 ++++++++++++++++++++++------------------
 mm/swap.h                |  1 -
 mm/swap_state.c          | 12 ++++------
 13 files changed, 118 insertions(+), 80 deletions(-)

-- 
2.41.0.255.g8b1d071c50-goog

