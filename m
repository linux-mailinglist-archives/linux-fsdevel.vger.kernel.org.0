Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BC32D2ACE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 13:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgLHM3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 07:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgLHM3f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:29:35 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D9AC0613D6;
        Tue,  8 Dec 2020 04:28:48 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id p2so830683uac.3;
        Tue, 08 Dec 2020 04:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggW586a4wUXgxsMLIE+kWjuZOeFFSfzFi9tuTrNvuLA=;
        b=mXihHLRx+k1GUWlpHXN+BctZxk/fxPMq7eOdtSSe4QsgFqcrNtDlnPFq896ihJahxa
         1jLb1Y63s9RYJeqOBdDzwxGddSdL0oaWFHJUlVSnL7YIM0QZIV/n+fNkHzeTmSn0TlYV
         HeSM8DwNCuTinmzF+YEFnySuMtPlbOt/xzWdnX9F9LZGClzdTcbWNcrKkohGxkoT3HX7
         tUWtiMDIGf6DuIz2VBNAD983pD+N5h25gCDliJwXooJz2EKwqLq6G9TO1IEiiK52VLwG
         FF2g7grvKvIlFNIMWa+wQ9vUocC3jfXT9KC0AnYryum6QuJfVMbQpTPujGNtADbld5k+
         p+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggW586a4wUXgxsMLIE+kWjuZOeFFSfzFi9tuTrNvuLA=;
        b=imIC3aJnrrVfLtVElrfG+j4cvBgYsAGP2GaDDH6DzYerrcOUiruEPuyrsfyHQKDnVJ
         03d8b++gMLMZhkTTgc3Z9agCp2y6pIvaMTWdpq84uSh9jZSSPvapDnhngsR0sirUtAjB
         /1rAOKiMcgmKPGIlnGPU+Al2xOlfJ/ijh/+ldrNlVztmnQXpXJ7tblb6LZPYe084PXBi
         H4MHnjzyPUCQGHLbU15Ome415zQtJXus+JMqmN3UCDwsyqbP25cH/MVAiX+EBjh0VriQ
         enAmz/C4Czm3LwbSEXxsmWhoYmQbRo8laACs/tt2U1aNj0qdj7JtAcZq48/XmglaLRnw
         lVvg==
X-Gm-Message-State: AOAM532qp3Rjfo1E0CcdQSlAswqMzlEYwngwLV0Y2/562oas1/5+SeJh
        qtVcMtElzEvSBwAMBH6o0EskDVm3X2UqOg==
X-Google-Smtp-Source: ABdhPJyxuVcP3EAAfgDF0k0PlxjPW5b2sr3eVAqYL2ivJdprEi8LWozDz8k8uYq2GIccXIuIm4krlA==
X-Received: by 2002:ab0:26a:: with SMTP id 97mr13411872uas.110.1607430528055;
        Tue, 08 Dec 2020 04:28:48 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id w202sm2001106vkd.25.2020.12.08.04.28.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 04:28:47 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v11 0/4] xfs: avoid transaction reservation recursion 
Date:   Tue,  8 Dec 2020 20:28:20 +0800
Message-Id: <20201208122824.16118-1-laoar.shao@gmail.com>
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

Patch #4 is the implementation of reussing current->journal_info to
avoid transaction reservation recursion.

No obvious error occurred after running xfstests.

[1]. https://lore.kernel.org/linux-mm/20200625113122.7540-1-willy@infradead.org

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
 fs/xfs/xfs_trans.c        | 24 +++++++++++-------------
 fs/xfs/xfs_trans.h        | 34 ++++++++++++++++++++++++++++++++++
 include/linux/sched/mm.h  | 23 +++++++++++++++++++++++
 mm/vmscan.c               | 16 +---------------
 8 files changed, 96 insertions(+), 47 deletions(-)

-- 
2.18.4

