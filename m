Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267F52492DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 04:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHSCZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 22:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbgHSCZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:25:07 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4681CC061389;
        Tue, 18 Aug 2020 19:25:07 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w9so16752042qts.6;
        Tue, 18 Aug 2020 19:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PLLOaOgVNnID3QXM3kUkbmSP8c/OOIpuGrT3lZm4CqI=;
        b=nHgm/mJZEQRbeQELjDqcKlYJOVeRWDm0gLIN/z66tFQDdSWcn6yGPtwucT39Zf2/k6
         C3EU1wTh0XINSsyrOWGAut8y9T0It3+hnGIXO77Nb/jULGN7Wb2d+Jif56mA0sKM6HlU
         zJ8Q3m7xamfjeVyQloD44/Upbifl+9n49kaYtwnIApvm5lCaYUo0U9ZsdeiVejwTAcuT
         tbVZeZzefT+fskNEiUILsaJegLn42/aUPeJI8PB2v8ZazJ0/6yKswkz6zBPlm1DsGlUE
         Br2WLlpqhcGKjn6wd+Rz4We9Gq/60CNSb8VIbG8CRR9yiDH6BhrvgTNVf2HbyWXoO+SI
         kuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PLLOaOgVNnID3QXM3kUkbmSP8c/OOIpuGrT3lZm4CqI=;
        b=VZxIkw2fPL7yTfpyHvRp+rFjxmk9Xf2dN0UU46btBpGJaRFh1946TRhhuUBraYo37a
         eYKBs7MQelv3Mvz2hkRY1LFDaY+jS2s+yeu1t64GC8wNk11/eqRGp2dAbeSZETRJ3kds
         o1MW0YVZD7MqkiDVDUYbVn4c+7kEiEo4ESoUpGQ/DaYhRfRNPhKD2QpgnBxe7yzj2wt7
         FvUnGsIv1B4k/NUXpa/DnZeFxWm1nvA4GlD38X4Vkyk6TlIEemRzB0JQ2iujVcNGOTdO
         xByZDY6G/GlvUhXQc6yE7L2MAoDIZCowQrlQL8JJN6NdWmrZKoYZp57TL5ELVA5l4G4Q
         R3Ug==
X-Gm-Message-State: AOAM532CQcWLK04squvPJey527gtR9vl/AbWPaafVAB4VqziVWWCtDTN
        Ul+YBQPGpcB1pVIIPSJcuO0=
X-Google-Smtp-Source: ABdhPJxFjirsZc1zvcv45u2qvsH4ABMVQtT5B5aZp7o0nV/XgXIiE8i/cu/k4V7yT+3RMpReUh+rlQ==
X-Received: by 2002:ac8:581:: with SMTP id a1mr20889841qth.247.1597803906532;
        Tue, 18 Aug 2020 19:25:06 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id t12sm21988275qkt.56.2020.08.18.19.24.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2020 19:25:05 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        willy@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 0/2] avoid xfs transaction reservation recursion 
Date:   Wed, 19 Aug 2020 10:24:23 +0800
Message-Id: <20200819022425.25188-1-laoar.shao@gmail.com>
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
 include/linux/sched/mm.h  | 28 ++++++++++++++++++++++++++++
 mm/vmscan.c               | 16 +---------------
 9 files changed, 81 insertions(+), 39 deletions(-)

-- 
2.18.1

