Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA7E2D0138
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 07:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgLFGmB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 01:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgLFGmA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 01:42:00 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2A7C0613D0;
        Sat,  5 Dec 2020 22:41:20 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id x13so1985202oto.8;
        Sat, 05 Dec 2020 22:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uryp7VoMw6vTHsDBKmQdtkum5EctehoaGW3WLCaGdw=;
        b=QQDB33x0zV36M+SWfI5ES4b3YenolO4NNKo0ewT+qiFknDVGfmuh4X+HF/+k9nIsBB
         Qw6+Dm79b05DvtkibIyD+JGWwo5ztQ7buULpNdgoxujU3DDr3/dLFe51W/PW7BwySzoL
         iggGCjkNV3HAED90FHUpPM1b3MPQST+lxxez5ch9IwUbc0Hhlkd6Qy4fYmmMLJIBlj3/
         OaSdeHNG0T1Ngzr8T1R4aiS8n02roo3L14A20aMiBnvqeUpo9h6pomw/RWVSFA6ZYFkn
         F7I008yXRB9nzCFO96iv/RuX3swPZ8LZe8Vpca0AxoPPQPQ9DBAvqss6boDY9uAb2tDZ
         /BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uryp7VoMw6vTHsDBKmQdtkum5EctehoaGW3WLCaGdw=;
        b=JIYBtO3wUEm3NPIG6TS5eA47kvKuglYWHFQVLNwbfKd/WpAu0+yS2ZPeHbpg/7O2Xd
         SUEdOn9XckcT1cCsY3bdDwmpq0XbXjLXJuC8bcpmjU7Bh7JOTTcB2JsXBUvKZKixZed4
         NP6Z6AZ/v9iriamvlDnGCHMRv+8P+vhXhPl4sglFw1WS57AZl5aoBop5oHpME1NoE+Y6
         0otWir2ZBHccQMNLZ8JXf0IKgVP4yEsXKemFUx+NlVIwafGMLmS8LJMXE7x+cW86ZazJ
         2tlnHwcgqko0nX+uLPFq/nLuBWZtFn0mBzGw/DL46ZWdfp5SxroGBnFtlUXLuv07G41r
         qKvg==
X-Gm-Message-State: AOAM533rqweI3ZZtXmohU79JKMDTGkSa1fvN8geHnfh6f9SVKDKvr3kJ
        oY5z3gf5mqYKktYnwtn+LmE=
X-Google-Smtp-Source: ABdhPJz0zuQ/HHcKj74pAmZf49zndavOqXdbZx9Dmc3IsyKF1npPcXqG51F8231ukrl21NZjZd7usw==
X-Received: by 2002:a9d:708e:: with SMTP id l14mr9199595otj.87.1607236879898;
        Sat, 05 Dec 2020 22:41:19 -0800 (PST)
Received: from localhost.localdomain ([122.225.203.131])
        by smtp.gmail.com with ESMTPSA id y18sm1817553ooj.20.2020.12.05.22.41.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Dec 2020 22:41:19 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, hch@infradead.org,
        david@fromorbit.com, mhocko@kernel.org,
        000akpm@linux-foundation.org, dhowells@redhat.com,
        jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v9 0/2] avoid xfs transaction reservation recursion 
Date:   Sun,  6 Dec 2020 14:40:44 +0800
Message-Id: <20201206064046.2921-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset avoids transaction reservation recursion by reintroducing
the discarded PF_FSTRANS in a new way, suggested by Dave. In this new 
implementation, some new helpers are introduced, which are 
xfs_trans_context_{set, clear, active},
suggested by Dave. And re-using the task->journal_info to indicates
whehter the task is in fstrans or not, suggested by Willy

Darrick helped fix the error occurred in xfs/141.[2]

I rerun the xfstests again in my server, and no obvious error occurred.

Patch #1 is picked from Willy's patchset "Overhaul memalloc_no*"[1]

[1].
https://lore.kernel.org/linux-mm/20200625113122.7540-1-willy@infradead.org/
[2]. https://lore.kernel.org/linux-xfs/20201104001649.GN7123@magnolia/#t


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

Yafang Shao (1):
  xfs: avoid transaction reservation recursion

 fs/iomap/buffered-io.c    |  7 -------
 fs/xfs/libxfs/xfs_btree.c | 14 ++++++++------
 fs/xfs/xfs_aops.c         | 23 +++++++++++++++++++++--
 fs/xfs/xfs_linux.h        |  4 ----
 fs/xfs/xfs_trans.c        | 25 +++++++++++++------------
 fs/xfs/xfs_trans.h        | 23 +++++++++++++++++++++++
 include/linux/sched/mm.h  | 23 +++++++++++++++++++++++
 mm/vmscan.c               | 16 +---------------
 8 files changed, 89 insertions(+), 46 deletions(-)

-- 
2.18.4

