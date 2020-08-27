Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96BF253B6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 03:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgH0Be6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 21:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgH0Be6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:34:58 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE58C0617BB;
        Wed, 26 Aug 2020 18:34:57 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k20so3454660qtq.11;
        Wed, 26 Aug 2020 18:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wLy+bW88Yt+UeLAJkekbjwnN6inFO2kqTqlou1glKoo=;
        b=sfCu3w1t9MRqXxPwApt7NbPjCmgvic/WoFwplUThrnXHZxTuFSoKmcVXKIBrk8xGxy
         +K74kZqxqV18vRwuC3NsZRaTHf0vZO5i/MhY//17v2R2L5cI59TDTMvNM7ipmUQPIzTR
         BIrlxMdgZYm7BEMeTTMX6yLfNIJZ/2JY4cNuXDJ9DPCBonHQTHdF/NDXDlE+Dzw3nplf
         mM9umZGH0RRG4FXwXovsjwOLC02g3zzSclmBs80E62UVbx0BuAaLcUOfVgb+VYuZD4Ab
         f8kvp1P421lbs4PjOwF1NT73qKOC8iVdD42wGVP55xAeOmpi1Hz2eD05yetYKVSZ8Zlo
         n2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wLy+bW88Yt+UeLAJkekbjwnN6inFO2kqTqlou1glKoo=;
        b=Q6n88xeg+6ic4X1q7GDikn9URL7sOsN3OiKZhS4HbDA+fIqUOqNTM5FHJi92cfpoM2
         KuAqjfGgVil6yG3N4mX2PvZEnJBqRWLd3pjMLs8Vo6XljxOy6XaPvLNjODRghjh1KYTO
         63y2vi/pjGYsbfWHAByrE2R7SWWjULOgjOk3v4C2KHthkNBQJSjskFJ77LqUJcvq8yrG
         oyQiVOk9XYKI5nrk4RZOcuyUD6dOmjWGFfPL8zKFeDoCUarCNnJ63Zk7wOBCIjpv3Lbx
         4zPlX1TS4OM0OBreLiC+t0FM1aJ/qSQneUaTUbsy4pUcPHm8FyjE8PRY/cvjucJiExeA
         VO7Q==
X-Gm-Message-State: AOAM533wwbZ2j3Z1z8O/Ew1OGEH7+uxte9ZV/m+yQN50NfwKnIhVDNCH
        fzuWfyKPkyWsWL5W8kabxd4=
X-Google-Smtp-Source: ABdhPJyevdcgqqfc3h+7QKmmzaFxNkVoDTNXHTujj3mA88GdzVfRlB5F2vgLQeXJQJ8iZGGdcEt0CA==
X-Received: by 2002:aed:3bb3:: with SMTP id r48mr16515536qte.328.1598492096784;
        Wed, 26 Aug 2020 18:34:56 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id i18sm631846qtv.39.2020.08.26.18.34.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 18:34:55 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        willy@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 0/2] avoid xfs transaction reservation recursion 
Date:   Thu, 27 Aug 2020 09:34:42 +0800
Message-Id: <20200827013444.24270-1-laoar.shao@gmail.com>
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

v7:
- check fstrans recursion for XFS only, by introducing a new member in
  struct writeback_control.

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
 fs/xfs/xfs_aops.c         | 11 +++++++++--
 fs/xfs/xfs_linux.h        |  4 ----
 fs/xfs/xfs_trans.c        | 19 +++++++++----------
 fs/xfs/xfs_trans.h        | 30 ++++++++++++++++++++++++++++++
 include/linux/sched/mm.h  | 23 +++++++++++++++++++++++
 include/linux/writeback.h |  3 +++
 mm/vmscan.c               | 16 +---------------
 9 files changed, 85 insertions(+), 39 deletions(-)

-- 
2.18.4

