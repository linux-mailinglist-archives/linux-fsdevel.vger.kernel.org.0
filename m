Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1406724F0ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 03:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgHXBnL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Aug 2020 21:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgHXBnK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Aug 2020 21:43:10 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBD0C061573;
        Sun, 23 Aug 2020 18:43:09 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id w2so3087172qvh.12;
        Sun, 23 Aug 2020 18:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7poD9i6PNH3g+ZtHM686iV1Jtq5EUPZ9/Xyx7mrF7Yc=;
        b=ihD/HJk/AWLQXGZbEG6PVIloI5Y4h7KmJPky2enRUpoHDaICBJrZyQXUrE1J4jSL0B
         YMJPsMGRh6nIYIbEtmtiFBx0OksjwKJxcKlfo/amkiFVMRAFhGSPFk6aDX4dTBf3G73Z
         xNgD1mjJl/r71k+rxE7Qs8Da7Ze6VB3NAfXxgcuzLmWhWuz0+QKp6/IBTCYx5s0/LvwH
         3SxEFvXs7BmIMJCHm2v85WHoyfUoMmrVfQKI4Rh0hzCV6/YQfzBzyyqABi7JNoR8yt2g
         kwgGVj3r/KdSEigELXOxp2Okg2cAVmiLOsgEhgpe1f8J5i0hP2NvWeUAeu3XsXyP4UWj
         jovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7poD9i6PNH3g+ZtHM686iV1Jtq5EUPZ9/Xyx7mrF7Yc=;
        b=iLrjHBdKKDMgJ0E6mSyoR9eMg/50KKHhi/vEatSQChGrpLHVMME/MT88t97b5TBl89
         TKY4c+nL7wRqn+7ANkSVFucYyRCmD9AlHieQHDXh68Zgj0LBeS/8JZGe5QeZI+bYqfRV
         Wa+OqMYgoS+NGb0u23Z9o8rriv8S0F3khKEwHB9WO3S9q7V789wisX3p37JQaBzd/8yf
         VYa6Zc2hBxeLaFgQ1kedcbocDxZ4FH5zNmLoIDQINCDrllG5CTC3gZrDWIGjAgXrFi3n
         yCrAk2TzZc4L577F9R4uahA4H39LwyNdPreV+B5wQzJOvQiefhwuqupDtTl0MnUY/IxA
         ybEw==
X-Gm-Message-State: AOAM532ucOXV54tE2E/lTD9I9CispWjj6lo8C0PirqLhoewoBUnEdKxq
        BRxusGB8o3sX+ZfwCHLfdLQ=
X-Google-Smtp-Source: ABdhPJwXmdjnfdpFg+xzLQ5icFJ2gyVNrZWz5WbZy81EL7DD8P7ion9qw6nf3P3MrFM3IqoPe+C0EA==
X-Received: by 2002:ad4:54d4:: with SMTP id j20mr2990069qvx.6.1598233387762;
        Sun, 23 Aug 2020 18:43:07 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id t8sm10205236qtc.50.2020.08.23.18.42.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Aug 2020 18:43:06 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        willy@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 0/2] avoid xfs transaction reservation recursion
Date:   Mon, 24 Aug 2020 09:42:32 +0800
Message-Id: <20200824014234.7109-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


This patchset avoids transaction reservation recursion by reintroducing
the discarded PF_FSTRANS in a new way, suggested by Dave. In this new
implementation, four new helpers are introduced, which are
xfs_trans_context_{set, clear, update} and fstrans_context_active,
suggested by Dave. And re-using the task->journal_info to indicates
whehter the task is in fstrans or not, suggested by Willy

Patch #1 is picked from Willy's patchset "Overhaul memalloc_no*"[1]

[1] https://lore.kernel.org/linux-mm/20200625113122.7540-1-willy@infradead.org/

v6:
- add Michal's ack and comment in patch #1.

v5:
- pick one of Willy's patch
- introduce four new helpers, per Dave

v4:
- retitle from "xfs: introduce task->in_fstrans for transaction reservation recursion protection"
- reuse current->journal_info, per Willy


Matthew Wilcox (Oracle) (1):
  mm: Add become_kswapd and restore_kswapd

Yafang Shao (1):
  xfs: avoid transaction reservation recursion

 fs/iomap/buffered-io.c    |  4 ++--
 fs/xfs/libxfs/xfs_btree.c | 14 ++++++++------
 fs/xfs/xfs_aops.c         |  5 +++--
 fs/xfs/xfs_linux.h        |  4 ----
 fs/xfs/xfs_trans.c        | 19 +++++++++----------
 fs/xfs/xfs_trans.h        | 23 +++++++++++++++++++++++
 include/linux/iomap.h     |  7 +++++++
 include/linux/sched/mm.h  | 23 +++++++++++++++++++++++
 mm/vmscan.c               | 16 +---------------
 9 files changed, 76 insertions(+), 39 deletions(-)

-- 
2.18.1

