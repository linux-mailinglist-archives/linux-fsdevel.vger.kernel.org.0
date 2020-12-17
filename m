Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC762DCA5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 02:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388988AbgLQBMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 20:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388983AbgLQBMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 20:12:51 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59240C061794;
        Wed, 16 Dec 2020 17:12:11 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id u67so6172092vkb.5;
        Wed, 16 Dec 2020 17:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmOnO3qjJFdw5qVil3tlbg5ItfTfI0GfT3/CX7O2nwg=;
        b=Lz1I9mhbPRe0AdEYaDsAYNeuJZtXudbhCvODGCuFk/k+r2nAFsGR8YOBZliy224d2M
         u4WQUXEjhdpKQhk/wVameqvT7hAN+kUZ32tQs7fjMm1odUgG+BdBwLLsH2IIoN2XBo8f
         9f36iraWi8Zt72D2uHv169v8ib6B7Bf4LtZ7KjB/P0u6h33WXiwSu2H9L4qaq5KNWX00
         6AXp8Ke4EziyMxwtEw0/2zfPotFOnF0NyOoAbb+Z8q43OfZ+ub4AFZu7F/+BdgoedtvZ
         oxHBW6wq/lLzGzFDrW13cmw4qui+UaAB6Hn9jLm9ncYsyFo5CVfrDj52r0iQamMzbz87
         a6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmOnO3qjJFdw5qVil3tlbg5ItfTfI0GfT3/CX7O2nwg=;
        b=irZrjDEV5mBVP/lexeyBjWsJ6PYKwJAo2fW8H6anbW7t2XsxwH3Ejc4VLvSR4apt1C
         ifT1CEfPf+ltR7IQg/jLUbxoaXHO6DjBwu/ll3tHlbKHaWLHhXshQDUp5U8Hr+XcDoys
         DrTwOTgHub3/BR4SAU4YNWSgJ+b7JzDqD5skRDBMaZXZPycZYWZiim8Wq621fQ6mlOad
         NmzNxxJZf84RTkkz5HLw+9soh/GVkCeT7HSo4GIG+7qom8rBImn9IRMZ8I/fWRWm1Dhz
         L7ivE3CdNLyurONLGdPmKj3nqiSNYKBE9fjRXDWcau+boHcc8mY8tZSz54s/hgwacqz8
         Hskg==
X-Gm-Message-State: AOAM533w1bSaG6MIqXDbgetB6nX4ztjjeFV5qMArZsScTHjuf5q2g4oO
        ECD+/MgTId62CAG8WZ0VF3s=
X-Google-Smtp-Source: ABdhPJwy0uTxmy5IZQfU7PF4u9B7yvz4bIGO/p5RVqbI6VwSx+pY2Dfn72dOIjRDpGS6eH747V9Djw==
X-Received: by 2002:a1f:2ecd:: with SMTP id u196mr36256109vku.19.1608167530611;
        Wed, 16 Dec 2020 17:12:10 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id i63sm2900760uad.4.2020.12.16.17.12.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 17:12:09 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v13 0/4] xfs: avoid transaction reservation recursion 
Date:   Thu, 17 Dec 2020 09:11:53 +0800
Message-Id: <20201217011157.92549-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PF_FSTRANS which is used to avoid transaction reservation recursion, is
dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
PF_MEMALLOC_NOFS") and commit 7dea19f9ee63 ("mm: introduce
memalloc_nofs_{save,restore} API"), and replaced by PF_MEMALLOC_NOFS which
means to avoid filesystem reclaim recursion.

As these two flags have different meanings, we'd better reintroduce
PF_FSTRANS back. To avoid wasting the space of PF_* flags in task_struct,
we can reuse the current->journal_info to do that, per Willy. As the 
check of transaction reservation recursion is used by XFS only, we can 
move the check into xfs_vm_writepage(s), per Dave.

Patch #1 and #2 are to use the memalloc_nofs_{save,restore} API 
Patch #1 is picked form Willy's patchset "Overhaul memalloc_no*"[1]

Patch #3 is the refactor of xfs_trans context, which is activated when
xfs_trans is allocated and deactivated when xfs_trans is freed.

Patch #4 is the implementation of reusing current->journal_info to
avoid transaction reservation recursion.

No obvious error occurred after running xfstests.

[1]. https://lore.kernel.org/linux-mm/20200625113122.7540-1-willy@infradead.org

v13:
- move xfs_trans_context_swap() into patch #3 and set NOFS to the old
  transaction

v12:
Per Darrick's suggestion,
- add the check before calling xfs_trans_context_clear() in
  xfs_trans_context_free().
- move t_pflags into xfs_trans_context_swap()

v11:
- add the warning at the callsite of xfs_trans_context_active()
- improve the commit log of patch #2

v10:
- refactor the code, per Dave.

v9:
- rebase it on xfs tree.
- Darrick fixed an error occurred in xfs/141
- run xfstests, and no obvious error occurred.

v8:
- check xfs_trans_context_active() in xfs_vm_writepage(s), per Dave.

v7:
- check fstrans recursion for XFS only, by introducing a new member in
  struct writeback_control.

v6:
- add Michal's ack and comment in patch #1.

v5:
- pick one of Willy's patch
- introduce four new helpers, per Dave

v4:
- retitle from "xfs: introduce task->in_fstrans for transaction reservation
  recursion protection"
- reuse current->journal_info, per Willy

Matthew Wilcox (Oracle) (1):
  mm: Add become_kswapd and restore_kswapd

Yafang Shao (3):
  xfs: use memalloc_nofs_{save,restore} in xfs transaction
  xfs: refactor the usage around xfs_trans_context_{set,clear}
  xfs: use current->journal_info to avoid transaction reservation
    recursion

 fs/iomap/buffered-io.c    |  7 -------
 fs/xfs/libxfs/xfs_btree.c | 14 ++++++++------
 fs/xfs/xfs_aops.c         | 21 +++++++++++++++++++--
 fs/xfs/xfs_linux.h        |  4 ----
 fs/xfs/xfs_trans.c        | 26 ++++++++++++--------------
 fs/xfs/xfs_trans.h        | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/sched/mm.h  | 23 +++++++++++++++++++++++
 mm/vmscan.c               | 16 +---------------
 8 files changed, 100 insertions(+), 48 deletions(-)

-- 
2.18.4

