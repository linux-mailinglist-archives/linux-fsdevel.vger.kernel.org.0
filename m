Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AA92F4894
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 11:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbhAMKXs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 05:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbhAMKXr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:23:47 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ACDC061575;
        Wed, 13 Jan 2021 02:23:07 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id i6so1434642otr.2;
        Wed, 13 Jan 2021 02:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EZdWjEiE6JU4dDIJ/Pyi7n34O5hqZ+ARLNb+PckQnXM=;
        b=ietyQfRtI0nge5UQtyiDTZ4uIxLua/JTSqhCwmUcofLsKnXoXIqW4xcVZLIkvMQlhh
         dw+gB7uRVgSVbdYO06x/2BoZSXSB7UDAQjy0Js/U/MC2nHXmT1IJ0KkUB+Zq8cyyrEmv
         xnoyDbBoPyJXaaKf53GCftPPJLk+qYPS9qzGTvZhBnMARFBkU1IaoHjdebJY3b7pClZE
         CtYtzSnXlL6/ya7ETA2RymcBQRNaqNmXNqR33Bp6fdy4BXkkOnlEUzA7z0qLzb0r/sdC
         Vm2ticv8iP8sgApOKjBBbpbvJahWeqnX1sfLeYDbOi8ynZtpK7GQ1zcf+3BkrPdfy+lt
         iPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EZdWjEiE6JU4dDIJ/Pyi7n34O5hqZ+ARLNb+PckQnXM=;
        b=tFaNob8tKCYm5iHXB9upvX2gSoDs0JomC7Q1DyOJmntKOO2k8QiMAqqYbZMrw/AU2u
         CAnWaPsJwNVRq2X6FCa4mT9qaI1EJq2hgVeJkK83sWXUg8uSFZnPkSgi3lVoJg88xcBX
         6/aLwwySukX/c185kwo9PO43QW3BNvtOOstO9gVxjo+HLJEwBPW+Dpg4RbZYyvTc7W4k
         bpmYysHeKsqAi2QkNRUqlZHtrSh/uaCkuax6sRbYYdcH94dVxmxYsZdzLUYNQmZpjcAR
         IVAtXEYpuMJsxJpiVnQl7Wspc69IubLDTcJnvGiyUvBs6aCo+OQwCkOzZGijBoREuMMq
         kYKA==
X-Gm-Message-State: AOAM5319jg7fsQjhuCfjP9HbNCtQhV8phL7QFQgEUGM3lLLVJ9Dw9Qag
        b3o/JgVclzCHGKAnj7jklzM=
X-Google-Smtp-Source: ABdhPJxzpcZ6oajkxTk/IqALwgCtGfZtB6bXMnDlhxhsoNwGNY4Zv4RvzAHa0fEt2VE6pimAVRh7CA==
X-Received: by 2002:a9d:19cb:: with SMTP id k69mr732136otk.75.1610533386389;
        Wed, 13 Jan 2021 02:23:06 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id z8sm335571oon.10.2021.01.13.02.22.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2021 02:23:05 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        oliver.sang@intel.com, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v15 0/4] xfs: avoid transaction reservation recursion
Date:   Wed, 13 Jan 2021 18:22:20 +0800
Message-Id: <20210113102224.13655-1-laoar.shao@gmail.com>
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

No obvious error occurred after running xfstests
(with CONFIG_XFS_ASSERT_FATAL enabled).

[1]. https://lore.kernel.org/linux-mm/20200625113122.7540-1-willy@infradead.org

v15:
- fix Assertion_failed reported by kernel test robot
- run xfstests with CONFIG_XFS_ASSERT_FATAL enabled

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
  xfs: refactor the usage around xfs_trans_context_{set,clear}
  xfs: use current->journal_info to avoid transaction reservation
    recursion

 fs/iomap/buffered-io.c    |  7 -------
 fs/xfs/libxfs/xfs_btree.c | 14 ++++++++------
 fs/xfs/xfs_aops.c         | 14 ++++++++++++--
 fs/xfs/xfs_linux.h        |  4 ----
 fs/xfs/xfs_trans.c        | 26 ++++++++++++--------------
 fs/xfs/xfs_trans.h        | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/sched/mm.h  | 22 ++++++++++++++++++++++
 mm/vmscan.c               | 16 +---------------
 8 files changed, 91 insertions(+), 48 deletions(-)

-- 
2.17.1

