Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330752D42EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 14:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbgLINND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 08:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732235AbgLINMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:12:52 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0EAC0613D6;
        Wed,  9 Dec 2020 05:12:11 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id z3so807043qtw.9;
        Wed, 09 Dec 2020 05:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fp/zlSJNune866vhfPRgWPP0qPocE+vROnJvQxS4p80=;
        b=P4yu2gZjwQ7BXmLqB1JZ3qkiJbYEtFuaJl8HjjxK5CN+I/sWCRW6JOIyfz6IEZ0p/8
         Lhf8ypjVlgrBJejo6hrz26A5PFNlSIGDOcRoNKcyybruk/lyuVcButnaeo8bQqY//8bc
         0Fplfqejh7lX0qVqVRZ+t4R1f65B6E8AuVxNLhffd8qkbQw64b4gG18OhtVv8iCEpPvH
         HLy8GmwLbx9tjQrm214OM9THIUeTgkV2sOKQQRGXWS7oqF0VS0FOKrVc23fpVbPe8Vzg
         VBGw0xu5/ZRO1iVFjzG/qWhmptTtZm4dZuRllNyZRKX3/Pj9TB2H/i4JsxO68fIrAtqu
         /OhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fp/zlSJNune866vhfPRgWPP0qPocE+vROnJvQxS4p80=;
        b=B5WAJnk40yBxbdqKqNUkF23kc6EFD1Nxwg+qQ388jazngBfTjwuYyLvZ6kewVlXvcq
         J3vkUVh/EUBShA8NbJr0AJ/5i9QNsVaZihvboRcfPX5Y7u8F/jhG6nEIsNHKAFnp3RhI
         Ew6vHWyvjH+FIHJpHlW8n0Jj0Jal9WrxaahTHLJod+qZObFL961TncLiKOYD09daHbnR
         1zjre8jaLslduzgkukJ1oxgj415BprR1FDfPmWDSLNlR6acFT92M41IJZZmx/TeEZzBS
         YVgZyzhVXmZ5zw/pQ1JAfnpeyGe3G5WaU/nPI+3/kgXgMAPLg+2Xsh9yD84DlicMA1gt
         XvTw==
X-Gm-Message-State: AOAM530bZV2dE952mgqUemuPEOBm+bzX3fYbtuxU2bk4N2JdkXDhbL5l
        zNmvapVu5G7CDFL5bG0+rH0=
X-Google-Smtp-Source: ABdhPJwtyKiLT8mj11kfTalztFan4ZD94eHgt1nxgmaGAp//Gvty4tmLVaeIkkdgh0EHjqteRp+v3w==
X-Received: by 2002:ac8:5911:: with SMTP id 17mr3001559qty.218.1607519531161;
        Wed, 09 Dec 2020 05:12:11 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id u72sm938114qka.15.2020.12.09.05.12.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 05:12:10 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v12 0/4] xfs: avoid transaction reservation recursion
Date:   Wed,  9 Dec 2020 21:11:42 +0800
Message-Id: <20201209131146.67289-1-laoar.shao@gmail.com>
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
 fs/xfs/xfs_trans.c        | 33 +++++++++++++++++++--------------
 fs/xfs/xfs_trans.h        | 35 +++++++++++++++++++++++++++++++++++
 include/linux/sched/mm.h  | 23 +++++++++++++++++++++++
 mm/vmscan.c               | 16 +---------------
 8 files changed, 105 insertions(+), 48 deletions(-)

-- 
2.18.4

