Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036762A4616
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 14:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgKCNSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 08:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgKCNSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:18:22 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D644C0613D1;
        Tue,  3 Nov 2020 05:18:22 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id m143so8978859oig.7;
        Tue, 03 Nov 2020 05:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9UeKXLqEROkCIRleEW4NP4O88bOkp9F8082Wrul3qWg=;
        b=tTOigtHPF0PrG8+kN81ihGfYJxkuRjri2wpmWwfcbEVQ6XDCQcQYVTo/xkUiqB2lbr
         ieygPmQPOOzugKc5w2+JBDLYOehE6qeYvN8g5rksfeRf7JccJih7mjB1LHgW+BvtKNwg
         PN57zQk50YIsvH/w6NYV812J5SneXuHrU5EdCGDwR5UDPBw69RuCJE8Paf7W9d3IaTcd
         4TlWWBA3qSwMwy0JwVIDR1Nwwxn1NZy23AkV/RE8Hrs8niOg7ZeE1Dz+UI0Inlrz4LP3
         GcwNqWpBV2fVcy0RF/+jVsbmhYW/BCayzTbeG7SsVUpNjWyK954kTDA8WnyPujOUfHjN
         Iq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9UeKXLqEROkCIRleEW4NP4O88bOkp9F8082Wrul3qWg=;
        b=hIgl2+OUZW6KHO/8D9+VHhj6ESk+qHSlidGGNIM0iRG2kbHB8f8JRYHru0YY6glXAo
         BCRLQx+CvCT+O45mgQDwg3fN7yLOY5iamGAUy2jDr3vavMEs1OeXxrnpVFMeGm3EFJjh
         Zt+ww/YXcIrwKOkFdX9OGGMc0anssqlZwKc4AzcVJ9IovjMYtgzMVshGa88JMMGxg3jx
         f3q5D0hkbEm1NQkYRNbkoe3Lg5PTjOhFPf+QA/Q51sbo0ayUsEWB2zQbGo7fqsNJGw17
         4TiyBaSByF11uLIURgEr0biSw9pjjvywJsWjrt1i1Tb8bwERMP3e7Wgs9mtRWPQgQYa2
         IU8A==
X-Gm-Message-State: AOAM530mkhtJymeVDu5V662myn++zjuFG+N/l3sZrLRU37AbqEzmBypq
        u0M98qYcKTemIC9u8pJzRH8=
X-Google-Smtp-Source: ABdhPJyHumb6iPyGDVtgaFN1uX6Cr7u6PoFH0nLwJUw4VtW1UirICUj/tSOY/Anb9E3+kc5rJ6ub+A==
X-Received: by 2002:aca:f40c:: with SMTP id s12mr1779623oih.153.1604409502024;
        Tue, 03 Nov 2020 05:18:22 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id f18sm4396138otf.55.2020.11.03.05.18.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 05:18:21 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org
Cc:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 resend 0/2] avoid xfs transaction reservation recursion
Date:   Tue,  3 Nov 2020 21:17:52 +0800
Message-Id: <20201103131754.94949-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset avoids transaction reservation recursion by reintroducing
the discarded PF_FSTRANS in a new way, suggested by Dave. In this new
implementation, four new helpers are introduced, which are
xfs_trans_context_{set, clear, update, active},
suggested by Dave. And re-using the task->journal_info to indicates
whehter the task is in fstrans or not, suggested by Willy

Patch #1 is picked from Willy's patchset "Overhaul memalloc_no*"[1]

[1]
https://lore.kernel.org/linux-mm/20200625113122.7540-1-willy@infradead.org/

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
 fs/xfs/xfs_trans.c        | 19 +++++++++----------
 fs/xfs/xfs_trans.h        | 30 ++++++++++++++++++++++++++++++
 include/linux/sched/mm.h  | 23 +++++++++++++++++++++++
 mm/vmscan.c               | 16 +---------------
 8 files changed, 92 insertions(+), 44 deletions(-)

-- 
1.8.3.1

