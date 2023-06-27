Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB8B73F345
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjF0EX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0EX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:23:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6B5DC
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bff1f2780ebso4143174276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687839805; x=1690431805;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JWV/DPfsr/X1EdWkyMfUvUzcNXJIr36UfbN56sh3Nho=;
        b=x2iMPg4XRNf8vHFsb9oj4O2ZELGqekijMqu5JGOH1XL1vViWwwWC9MBkqH9HHe4btJ
         c19XM2XqaHIdWyVgEShFN+FKhTNvVvVMcM9KPGdA2PpIKlKOFfjWIxX/FTRQ+Egzz2Xk
         iDOHnC+luY1cdNvUBatfG4vVVioTEVkMxkAuGqGmuEGGYxJfP+4hqSMSdMsuJhdGFwBo
         ha0yY/DE1KDekc0YbbEhrbK/ZfuDdaU+y21gTEGJNm3OiwsK0/m5w1uhZ73NmyB1jFRp
         VEn2awGEL5+iVwgxI+McDtpysZ6sRcaia6mf8ZdScFiYwaVc51h/mR4Ayui/LnJG+dff
         b0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687839805; x=1690431805;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWV/DPfsr/X1EdWkyMfUvUzcNXJIr36UfbN56sh3Nho=;
        b=gbl4CvyWJ1rnhPZFAOBcIHyREp3gTAxjoC1cT7e63D+v19ptXNoEsKr+Vt+txggc7N
         zOzmeHY1m5h0OBjaQVABbIrJs+mK2njDlX+dCD8/xcPBfT55HlBslb6i2+cqrgke6+h3
         ldsKUVEuD1OEVa0UI2+Gg953LalumgaJbmwLdWqcT+S4pe6kP/ghCqV3pR9SnUvd6T9t
         opZD9O5vkpMA9YIGulHYbBr4lBqRA1+zG0BGn9OVPP/miY0+SA0+T0cFMs/Z0Rr/cdcN
         EF8pIuFuKaH31OqEN2+G2S0i1XEFl7BFgET0kkT5qTsJug0PtTHIZYIXHGOEt4e18r1g
         kf/w==
X-Gm-Message-State: AC+VfDw2qIbZ3O03ykD2T5rgEZKMM6qdXupe1zl/9uHQflXdA9RCAOyl
        k5y7LNm7Z3qXZytEu8XpnkWwzwWHoqI=
X-Google-Smtp-Source: ACHHUZ4u6ae4giQurDsZzes45mdptlCJHkYuWzppgrpk7yqVJyIQ6870iCQnB4NEEH0e6arLfrBAiMgLNp0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5075:f38d:ce2f:eb1b])
 (user=surenb job=sendgmr) by 2002:a5b:ccd:0:b0:bd1:7934:b4fe with SMTP id
 e13-20020a5b0ccd000000b00bd17934b4femr13504050ybr.13.1687839804822; Mon, 26
 Jun 2023 21:23:24 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:23:13 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627042321.1763765-1-surenb@google.com>
Subject: [PATCH v3 0/8] Per-VMA lock support for swap and userfaults
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
mmap_lock is handled. Then change folio_lock_or_retry (and rename it to
folio_lock_fault) to accept vm_fault, which will be used to indicate
mmap_lock/per-VMA lock's state upon exit. Finally allow swap and uffd
page faults to be handled under per-VMA locks by dropping per-VMA locks
when waiting for a folio, the same way it's done under mmap_lock.
Naturally, once VMA lock is dropped that VMA should be assumed unstable
and can't be used.

Changes since v2 posted at [2]
- Moved prerequisite patches to the beginning (first 2 patches)
- Added a new patch 3/8 to make per-VMA locks consistent with mmap_locks
by dropping it on VM_FAULT_RETRY or VM_FAULT_COMPLETED.
- Implemented folio_lock_fault in 4/8, per Matthew Wilcox
- Replaced VM_FAULT_VMA_UNLOCKED with FAULT_FLAG_LOCK_DROPPED vmf_flag in
5/8.
- Merged swap page fault handling patch with the one implementing wait for
a folio into 6/8, per Peter Xu

Note: patch 3/8 will cause a trivial merge conflict in arch/arm64/mm/fault.c
when applied over mm-unstable branch due to a patch from ARM64 tree [3]
which is missing in mm-unstable.

[1] https://lore.kernel.org/all/20230227173632.3292573-1-surenb@google.com/
[2] https://lore.kernel.org/all/20230609005158.2421285-1-surenb@google.com/
[3] https://lore.kernel.org/all/20230524131305.2808-1-jszhang@kernel.org/

Suren Baghdasaryan (8):
  swap: remove remnants of polling from read_swap_cache_async
  mm: add missing VM_FAULT_RESULT_TRACE name for VM_FAULT_COMPLETED
  mm: drop per-VMA lock in handle_mm_fault if retrying or when finished
  mm: replace folio_lock_or_retry with folio_lock_fault
  mm: make folio_lock_fault indicate the state of mmap_lock upon return
  mm: handle swap page faults under per-VMA lock
  mm: drop VMA lock before waiting for migration
  mm: handle userfaults under VMA lock

 arch/arm64/mm/fault.c    |  3 +-
 arch/powerpc/mm/fault.c  |  3 +-
 arch/s390/mm/fault.c     |  3 +-
 arch/x86/mm/fault.c      |  3 +-
 fs/userfaultfd.c         | 42 +++++++++++++------------
 include/linux/mm_types.h |  4 ++-
 include/linux/pagemap.h  | 13 ++++----
 mm/filemap.c             | 55 +++++++++++++++++++--------------
 mm/madvise.c             |  4 +--
 mm/memory.c              | 66 +++++++++++++++++++++++++---------------
 mm/swap.h                |  1 -
 mm/swap_state.c          | 12 +++-----
 12 files changed, 120 insertions(+), 89 deletions(-)

-- 
2.41.0.178.g377b9f9a00-goog

