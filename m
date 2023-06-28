Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B8F740BB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjF1Iit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjF1Ie7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:34:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB3A30F4
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 01:26:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c361777c7f7so891440276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 01:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687940797; x=1690532797;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gPRmZ26IBsiMsbW2DFKvtKQmDaUZH2fHIbrEB332iB8=;
        b=d4GsvcpArTq4cOSSqDc1G3ZabrkTVtq5Ele2LQel7Jaxf2jQMm0bgDwijxXdMx7KXj
         eeoI3JWwNruCT3xu+4DZhYXFNl2pRHWb79kBJl1BhNnqH1Do5KrBv2H31gqCK5GMn4Bs
         82P9DfNEJ26VULghxbwg6p8Uj8/gWvbk47qzYJQF6X2BNBQAKhpM3Tz7ZZ64rkpcNzeL
         B/gWvQmIw9CCfEjp8quxQ+oxQuw5/18ufjWYMKr7B46yZKhVH3w+0MdsNEZwDy+SXxSa
         7G5vkbnH7yGT/x4TzAKeo/+MoXVi/75NRT4EI0dQrCyRAPsyJCkXNJY/TIf99eBceLax
         LZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940797; x=1690532797;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gPRmZ26IBsiMsbW2DFKvtKQmDaUZH2fHIbrEB332iB8=;
        b=BRk/PEVnzMumb6qwPRVU27cqANgoEI33g2C4+OQ0sNW3GyHThne5u2dx6D8mk9RCkv
         udzYJdIW+gDip+0Vt+zPfHRCTJJz6ndyLtw26Z5oN6UmizsPpQC+72W2mrwGfaHzjCPR
         WDsMXdb9uAU6cQFmxtszob+Ex+lVr8oZfv7CPb9Y5ggsxd/617svpCybhH4zgi4K8LBO
         GQf0d9DTOst9UgJ/mWB/+SwxYa4yma5qdjNv8cLY1Cm01ycrDjxAokEWVnx49jzneC0s
         PzjLsGWeImwnvBUtZxuUPZHuoVZ3CahZOyaNIER+S7entsZZW170Qhn3Jr1KBh5IUoDT
         s64g==
X-Gm-Message-State: ABy/qLbY6mr5HrBPL+9HFOEbj5WcfQo47+Hlbzxzf3ik2IhGDQ0kd79k
        lrDNYx703IwMBR3hWUCH/xCRxHH0lls=
X-Google-Smtp-Source: APBJJlEpYSp8he1DXAXVpI2wIb6u5ggZR99ctstsOjVLxfgRvzgDR0H3VpIWbi4McUwp9/ln4tUqhFGOd9A=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6664:8bd3:57fd:c83a])
 (user=surenb job=sendgmr) by 2002:a05:690c:2f82:b0:56d:5db:2f07 with SMTP id
 ew2-20020a05690c2f8200b0056d05db2f07mr7658ywb.5.1687936684846; Wed, 28 Jun
 2023 00:18:04 -0700 (PDT)
Date:   Wed, 28 Jun 2023 00:17:54 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628071800.544800-1-surenb@google.com>
Subject: [PATCH v4 0/6] Per-VMA lock support for swap and userfaults
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

Changes since v3 posted at [2]
- Renamed folio_lock_or_retry back to folio_lock_fault, per Peter Xu
- Moved per-VMA lock release to where VM_FAULT_RETRY is returned,
per Peter Xu
- Dropped FAULT_FLAG_LOCK_DROPPED usage, per Peter Xu
- Introduced release_fault_lock() helper function, per Peter Xu
- Dropped the patch releasing per-VMA lock before migration_entry_wait,
per Peter Xu
- Introduced assert_fault_locked() helper function, per Peter Xu
- Added BUG_ON to prevent FAULT_FLAG_RETRY_NOWAIT usage with per-VMA locks

Note: patch 3/8 will cause a trivial merge conflict in arch/arm64/mm/fault.c
when applied over mm-unstable branch due to a patch from ARM64 tree [3]
which is missing in mm-unstable.

[1] https://lore.kernel.org/all/20230227173632.3292573-1-surenb@google.com/
[2] https://lore.kernel.org/all/20230627042321.1763765-1-surenb@google.com/
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
 fs/userfaultfd.c         | 39 ++++++++++++++++++---------------------
 include/linux/mm.h       | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h |  3 ++-
 include/linux/pagemap.h  |  9 ++++-----
 mm/filemap.c             | 37 +++++++++++++++++++------------------
 mm/madvise.c             |  4 ++--
 mm/memory.c              | 38 ++++++++++++++++----------------------
 mm/swap.h                |  1 -
 mm/swap_state.c          | 12 +++++-------
 13 files changed, 113 insertions(+), 81 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog

