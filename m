Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBC22E03CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 02:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgLVBWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 20:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVBWl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 20:22:41 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FDCC0613D3;
        Mon, 21 Dec 2020 17:22:01 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id p72so2634721oop.4;
        Mon, 21 Dec 2020 17:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zfyd8+tCEuNHXvryEXCzCH9GQPnu047cakpfMip3n1U=;
        b=p80XqYZkEluA9Fxrf3nI5e6MMvRJMeT1+yJnONO/ywrNuYRPDweJhgyoB2MMdu2a8f
         L3CVtl6jTjyOfM+9zJ8eilUn+rKPIMeJoFJoFS8cBz7Sjha9eT5HKFk/fC5TOaGzhP26
         I/nkP0tNkZiWsLdAoQ7RSfpCj9mI6RjsUOcLXd9nhb9SkGBayJFp9yOIGPiXRwZD8piU
         8mWFxdSQqCtP99ZmIycirFdk0kdYDhff7GLJJvTJfYzeVFHcTzWZzladVJ8BD6ju75Ys
         5hcEOSyAMucAB6wru27exc9OpJzZic6eL8ukZ93Xht/Lz7/mZig09c2mrf6dcnIBIZ0t
         XcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zfyd8+tCEuNHXvryEXCzCH9GQPnu047cakpfMip3n1U=;
        b=PDvtjSqO1mmGzHz2X/fol/1DAye7yFMk8641PN3FwVDz3hvxCqZDKLguCIhyxBPIR3
         9Zlnq89f7Sw+HVRxY17Xi7XPkFF2S36GnXxSwcMGBLxAFuBEuov/5sJQeYSUb7FNBXTp
         DcDyZeS0GI5ChODKy/Ac5M9jnV6pRlmc33VDulyan3EuM5xYDf48lOUMmmuJXVz5pCDG
         UKmkBcz9xhxUMHRTK8aeL7hdzLAJ9IzC+op4IM6IFP/fCdiEJiwrodEDcKGhUonHcjyU
         ybVJoxZb0H/bosNY0mbRxNi4zHDMyXAWDROHmEB/Q+qwom7027Vo5hNMfochCEoAF2fd
         biUA==
X-Gm-Message-State: AOAM531YIgwbopJjX2fwzNKxYMUvw16otwZ2zXpXUfTLgdY1zFlrbqJi
        knnGHQLitUHsMWPOAbtmxEo=
X-Google-Smtp-Source: ABdhPJxHbyNtUyWl/WAzlJIE1qh8PdfS5Lc7Wnsu58XQtOTCmiUcs7dFLLap8LrPisiuzgB49qLBoQ==
X-Received: by 2002:a4a:d118:: with SMTP id k24mr13348179oor.8.1608600120359;
        Mon, 21 Dec 2020 17:22:00 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id x20sm4070098oov.33.2020.12.21.17.21.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 17:21:59 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v14 0/4] xfs: avoid transaction reservation recursion 
Date:   Tue, 22 Dec 2020 09:21:27 +0800
Message-Id: <20201222012131.47020-1-laoar.shao@gmail.com>
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

Patch #3 introduces xfs_trans_context_swap() for rolling transaction.

Patch #4 is the implementation of reusing current->journal_info to
avoid transaction reservation recursion.

No obvious error occurred after running xfstests.

[1]. https://lore.kernel.org/linux-mm/20200625113122.7540-1-willy@infradead.org

v14:
- minor optimze in restore_kswapd(), per Dave.
- don't need to refactor xfs_trans_context_{set,clear} 
- remove redundant comments in patch #4

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
  xfs: introduce xfs_trans_context_swap() for rolling transaction
  xfs: use current->journal_info to avoid transaction reservation
    recursion

 fs/iomap/buffered-io.c    |  7 -------
 fs/xfs/libxfs/xfs_btree.c | 14 ++++++++------
 fs/xfs/xfs_aops.c         | 14 ++++++++++++--
 fs/xfs/xfs_linux.h        |  4 ----
 fs/xfs/xfs_trans.c        | 17 ++++++++++-------
 fs/xfs/xfs_trans.h        | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/sched/mm.h  | 22 ++++++++++++++++++++++
 mm/vmscan.c               | 16 +---------------
 8 files changed, 89 insertions(+), 41 deletions(-)

-- 
2.18.4

