Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3C57443CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 23:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjF3VUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 17:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjF3VUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:20:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B902680
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 14:20:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-569e7aec37bso22916227b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 14:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688160001; x=1690752001;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H9gcN3gNFu1WTtBUtpC0M4aYh2b9oslK18bWcyLDHdo=;
        b=oNIgkcP+Rm1zkUVn4t5u68ESvpgQIXbrcYw29/gRzdkE5UaATbVPes4z0XxKc6K6/p
         Jw15ZeO2phUHjjdXkz/Fm6vKj6Kxg45Foww+zGK4uOAGQqqs1BrsHBYIMr41Xjj7veyP
         /7nxOF0o6KW7tDm6OUT6bmkpjra0/KYvwtRBjY/lE/5NTj9I0EuMyZRtDufv8j+YeJo4
         BurycZxKQ3Kva49nwAun+2C6w+cBong6Laauu/NCOZuov5J3VnHB+mmdeOgOOJr4/dpD
         PbfVskXqe6CffLh9wmpPLX7R5GUurnXto1SNVVdCYTODhlgKHpIMPgLptoHhfPs82CSh
         M/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688160001; x=1690752001;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9gcN3gNFu1WTtBUtpC0M4aYh2b9oslK18bWcyLDHdo=;
        b=WtF8yFZcte33vsTpDe2F/QACRMjMsL7FbU70IXmbFrjXfiDy8kNNwi+kpEeaADhn0F
         wl16XYvgy457aZ1E6+hnvb104ibPA/h+zYUR+mgLhbn76LK5H7rZWa9uhqNae6GsbJWK
         NDdfwdbC4b/gav6XvE7EjlP8Cc7pUyUqNfmoXZoqga+kP1e3pqo70SYD79HoBiplSvev
         lhXygVNrsVSW4AkO2Oi7OskO5a1693mcXP6X5aQAiaNmfxGIxkdCQ7ZBTAwOvmh2TvNK
         nyldQ/mtHBOU5S9dZFee8HqgPnumpeASII/SEbC5ORQM05MAJpX4tjRXWJ8+JgqrzUGz
         T+xQ==
X-Gm-Message-State: ABy/qLYOXWxoT9uSi2mYIDz7K/RyDSRtevpZtpaniZRm273t9NznpMk3
        cY2bLNFAuWEbnwiJuzjCHlvKP+0KdI4=
X-Google-Smtp-Source: APBJJlFxz+5qjMtbjV4jvSAgVZ7fFk8uY3skGFQMChHy9vo8oYp4UdiT1As/B8NsDi05V0mv39s2UQ7kX1g=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b54c:4d64:f00a:1b67])
 (user=surenb job=sendgmr) by 2002:a81:bd01:0:b0:56c:e585:8b17 with SMTP id
 b1-20020a81bd01000000b0056ce5858b17mr27432ywi.5.1688160001126; Fri, 30 Jun
 2023 14:20:01 -0700 (PDT)
Date:   Fri, 30 Jun 2023 14:19:51 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630211957.1341547-1-surenb@google.com>
Subject: [PATCH v7 0/6] Per-VMA lock support for swap and userfaults
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

Changes since v6 posted at [2]
- 4/6 replaced the ternary operation in folio_lock_or_retry,
per Matthew Wilcox
- 4/6 changed return code description for __folio_lock_or_retry
per Matthew Wilcox

Note: patch 3/6 will cause a trivial merge conflict in arch/arm64/mm/fault.c
when applied over mm-unstable branch due to a patch from ARM64 tree [3]
which is missing in mm-unstable.

[1] https://lore.kernel.org/all/20230227173632.3292573-1-surenb@google.com/
[2] https://lore.kernel.org/all/20230630020436.1066016-1-surenb@google.com/
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
 include/linux/pagemap.h  | 11 +++++----
 mm/filemap.c             | 37 +++++++++++++++---------------
 mm/madvise.c             |  4 ++--
 mm/memory.c              | 49 ++++++++++++++++++++++------------------
 mm/swap.h                |  1 -
 mm/swap_state.c          | 12 ++++------
 13 files changed, 120 insertions(+), 80 deletions(-)

-- 
2.41.0.255.g8b1d071c50-goog

