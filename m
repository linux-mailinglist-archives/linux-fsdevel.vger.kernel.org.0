Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9461D728C9A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 02:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjFIAwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 20:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjFIAwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:52:05 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FFC1FD6
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 17:52:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5689bcc5f56so16045027b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 17:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686271923; x=1688863923;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TthVOGU5NBXTdUCbenudXv/zsuPKI5dT0elSKLsw5KY=;
        b=ImpLDGn3lmP9gv5tkN/NEWkOq1CUqj8TD3qghFzsulypsFg5z+NBVRVHcl4W+zs9NS
         a/AUxP3USFFEem5uKIozHHNBnxBibW9dCIUuyoz/7IPe89xOljWkVvW9V6osOlolfUne
         DQLjQqvvd5IXZIwOo9ZRrUtWG6YL+hMBO0XMhyX9ft2y5anTxTVz9LsrpUIxcTGwDtT+
         +rMTNXGaBaHLPmEulzNcpPMC8knZz8tOalmVU/5YVSXK0/OGPREjG3YZwobjrPaMaWCr
         SQOISk0fFfxmV88xE6geZP9//tFPMygeFZNtEH0SbRgZnobBVXTiCsqOvEWJz55HHPRP
         8ZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686271923; x=1688863923;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TthVOGU5NBXTdUCbenudXv/zsuPKI5dT0elSKLsw5KY=;
        b=d0DDrtO5Vwz/X/fzq2LDcI+qi68N5giDTRjxYN/H6sC3EFybds1fV03LYkPazYdHXp
         Uq5yMtd2FUV0uZ9/pPNygYJDi0Tc0U5+HSU3M/hPSKuJFVXCiIqRqJTjCl9n94eqIrsM
         y5CZvxxbUlMhFEpnC2oFPk5tZhlxH0ZeQ1Nz21RIzoox1d6/mDynGM/hlJqU/4kSXvzK
         uAxWsTPkISLlXQssVL5mnudPUbm47X411tE/ezkRXh8NsMHvqud/jmCXUbXDlrRLC6ta
         sQyrrofePrwqf9Blwucvkz67u4FHj4Kd+Q6PasPhFLcBrY+MAdBvMj0BcVjoSXQP/ccl
         ONQQ==
X-Gm-Message-State: AC+VfDxyRHkSab7OFpdhTkHehPVVryfPzhaQcGa9zrscPa7OjHZSyCHq
        XQkpbiRR8EpPJBEibBSjsGoeg+10fms=
X-Google-Smtp-Source: ACHHUZ5NZ4g1X3BYYVvHaQ5ca+C3geF48LesY4562DfpiKDGzLPRjCuGKlBWzQoWjUktyTRs7xzqWuvyq0c=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:c03e:d3b7:767a:9467])
 (user=surenb job=sendgmr) by 2002:a81:ac43:0:b0:568:9bcc:5e16 with SMTP id
 z3-20020a81ac43000000b005689bcc5e16mr712323ywj.2.1686271923250; Thu, 08 Jun
 2023 17:52:03 -0700 (PDT)
Date:   Thu,  8 Jun 2023 17:51:52 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230609005158.2421285-1-surenb@google.com>
Subject: [PATCH v2 0/6] Per-vma lock support for swap and userfaults
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

When per-vma locks were introduced in [1] several types of page faults
would still fall back to mmap_lock to keep the patchset simple. Among them
are swap and userfault pages. The main reason for skipping those cases was
the fact that mmap_lock could be dropped while handling these faults and
that required additional logic to be implemented.
Implement the mechanism to allow per-vma locks to be dropped for these
cases. When that happens handle_mm_fault returns new VM_FAULT_VMA_UNLOCKED
vm_fault_reason bit along with VM_FAULT_RETRY to indicate that VMA lock
was dropped. Naturally, once VMA lock is dropped that VMA should be
assumed unstable and can't be used.

Changes since v1 posted at [2]
- New patch 1/6 to remove do_poll parameter from read_swap_cache_async(),
per Huang Ying
- New patch 3/6 to separate VM_FAULT_COMPLETED addition,
per Alistair Popple
- Added comment for VM_FAULT_VMA_UNLOCKED in 4/6, per Alistair Popple
- New patch 6/6 to handle userfaults under VMA lock

Note: I tried implementing Matthew's suggestion in [3] to add vmf_end_read
but that gets quite messy since it would require changing code for every
architecture when we change handle_mm_fault interface.

Note: patch 4/6 will cause a trivial merge conflict in arch/arm64/mm/fault.c
when applied over mm-unstable branch due to a patch from ARM64 tree [4]
which is missing in mm-unstable.

[1] https://lore.kernel.org/all/20230227173632.3292573-1-surenb@google.com/
[2] https://lore.kernel.org/all/20230501175025.36233-1-surenb@google.com/
[3] https://lore.kernel.org/all/ZFEeHqzBJ6iOsRN+@casper.infradead.org/
[4] https://lore.kernel.org/all/20230524131305.2808-1-jszhang@kernel.org/

Suren Baghdasaryan (6):
  swap: remove remnants of polling from read_swap_cache_async
  mm: handle swap page faults under VMA lock if page is uncontended
  mm: add missing VM_FAULT_RESULT_TRACE name for VM_FAULT_COMPLETED
  mm: drop VMA lock before waiting for migration
  mm: implement folio wait under VMA lock
  mm: handle userfaults under VMA lock

 arch/arm64/mm/fault.c    |  3 ++-
 arch/powerpc/mm/fault.c  |  3 ++-
 arch/s390/mm/fault.c     |  3 ++-
 arch/x86/mm/fault.c      |  3 ++-
 fs/userfaultfd.c         | 42 ++++++++++++++++++-----------------
 include/linux/mm_types.h |  7 +++++-
 include/linux/pagemap.h  | 14 ++++++++----
 mm/filemap.c             | 37 +++++++++++++++++++------------
 mm/madvise.c             |  4 ++--
 mm/memory.c              | 48 ++++++++++++++++++++++------------------
 mm/swap.h                |  1 -
 mm/swap_state.c          | 12 +++++-----
 12 files changed, 103 insertions(+), 74 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog

