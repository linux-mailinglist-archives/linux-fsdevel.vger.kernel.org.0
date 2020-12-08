Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1072D20A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 03:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgLHCQx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 21:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLHCQx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:16:53 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BFDC061749;
        Mon,  7 Dec 2020 18:16:12 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id f71so2808687vka.12;
        Mon, 07 Dec 2020 18:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N4iknFTA7A8PYDmVPmJNoru7g6pRjx8JJZWZP7DeZ3U=;
        b=XUDaGfRRpcXdW6Wmu+Uis/2d7Qqzhi0QVe8sjhUzIfAfAgzzpOqoSPXYuh6ie4tBa3
         VtCJWYdU/xnR+qdJOl64Rm3eGMA6/Q2hCK0AquXPoOkq2w1zHYaONVbt/cK2VXh/kFPE
         sTE7O1k+GpwjUuUKqIXcYgVAMMNKNDPGtQGxlRLhb1FecMADFJTpp73Gl0id/ZbFyD0L
         WEfuaLlL66qv5PZKIlA955rJxWWLej2vxj3fTH6EkKt1KFnLb+uGp0/prYTLyWULnzGk
         UmP+N7vU0Au5XZ1164/6XUkE/NddvsyigFd9TXXpKI++oTEE5sd110Osjalzg9hZW+uU
         33Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N4iknFTA7A8PYDmVPmJNoru7g6pRjx8JJZWZP7DeZ3U=;
        b=H7lG35QTVrSulnF1lxo9wbLOWtJosGocyt5yZIMFkjkkFhIK74d5qEqAaA0ytqFgx1
         20QAc9PbV5yROpWtBwoht7iyi5r6s1xXtr0Vt0D7NaNfRK30lvg1u3ztzTG6RW5a8bQK
         2PreMYm3v42pS8C5sb+oKpng2h414q4UYZmeWzY2R/PQp3jfsUtqEWQnB1CuxaAXqtER
         dWNbL7BDj3LG/MMgJ7QwTR88p3zwShCrw4OlSP7CkU4qZesNQLBhzaiHgRsTnzLRoEOK
         3ymqUPBD7PcBHTm5s8z+2Ard8cvx7Zv9Xwm8aPy5hj67hQ/wUw7fzhtwyPwGFfIPUkIm
         rRWw==
X-Gm-Message-State: AOAM531GCn3JE1a4E0zaePw7W3B/+Jmf+lUT2wIbe0yUbeQfhZUtAI6L
        IEgeWhlkKgqR4Zw8p/gZpNt9q/aeUjTq5g==
X-Google-Smtp-Source: ABdhPJx3PMfgbCqCB6rPTd5DamJ2UeJDaVGUaq3shuEg3TEJZiaBkppoCISMrKaL7MYLdiGJgHIYYA==
X-Received: by 2002:a1f:3411:: with SMTP id b17mr14936109vka.7.1607393771916;
        Mon, 07 Dec 2020 18:16:11 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id o192sm1936000vko.19.2020.12.07.18.16.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 18:16:11 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v10 0/4] xfs: avoid transaction reservation recursion
Date:   Tue,  8 Dec 2020 10:15:39 +0800
Message-Id: <20201208021543.76501-1-laoar.shao@gmail.com>
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

Patch #1 and #2 are to use the memalloc_nofs_{save,restore} API,
which is introduced in
commit 7dea19f9ee63 ("mm: introduce memalloc_nofs_{save,restore} API"),
instead of using PF_MEMALLOC_NOFS directly in XFS.
Patch #1 is picked form Willy's patchset "Overhaul memalloc_no*"[1]

Patch #3 is the refactor of xfs_trans context, which is activated when
xfs_trans is allocated and deactivated when xfs_trans is freed.

Patch #4 is the implementation of reussing current->journal_info to
avoid transaction reservation recursion.

No obvious error occurred after running xfstests.

[1]. https://lore.kernel.org/linux-mm/20200625113122.7540-1-willy@infradead.org

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
 fs/xfs/xfs_trans.c        | 24 +++++++++++-------------
 fs/xfs/xfs_trans.h        | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/sched/mm.h  | 23 +++++++++++++++++++++++
 mm/vmscan.c               | 16 +---------------
 8 files changed, 99 insertions(+), 47 deletions(-)

-- 
2.18.4

