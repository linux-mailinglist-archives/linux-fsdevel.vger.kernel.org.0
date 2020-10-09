Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19146288952
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 14:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387799AbgJIMvx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 08:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387792AbgJIMvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:51:49 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847F4C0613D2;
        Fri,  9 Oct 2020 05:51:49 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id c13so10069219oiy.6;
        Fri, 09 Oct 2020 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8fOXq+e8Q3qUvkqCfbrJcARvOZ9gZJoH7zIPzq8Gvzg=;
        b=RQzHlfvoOI/QVLRXucLrWfIVUWtm4cpVnGLkxI1eDV5ttT49jgQT520oAITBxK/uUh
         7heTOyU7jek5K2D5JToiQrZzEFRU6GsJLCTnWtLo0cLsOvFDDEt9P2hPvKWvBc5XcbAz
         xOmOBX2B7wopclEICJF8FkXwN2LXzXrgS6H+jzksNBEWZQABiNBZKYVyuL2n2Hpx2IWU
         SGfidHq6Ed0ZetxIq0+ez9eVJID+H5PY/A6xZCz+pebwp/LtcGVejfoi8819LVFGO+G9
         0YRL3IRt1zFQdcYsMvmRu3Ch8Wj+Al2js3osGsi4BglUUzAgiTXwo9UTDOrGO+MqKux3
         EIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8fOXq+e8Q3qUvkqCfbrJcARvOZ9gZJoH7zIPzq8Gvzg=;
        b=hxRrlfP2W9LRp55GJf+XyR8xC44Pn6QPw/vHAN1sYs0V3o2IWLjlZE9u2C1xDq5K4d
         bQY2rNT4dFHLONhH4fLxOypvvMuWaeCtXitS6TmlD6IOG6YYoNQpeVDoX1HKyUKjP5TM
         1Pl1GNKvN2kN42jNcahItNxFFNo8e618GnCpE7uOQa0ARBRVYzyZD2LtBNGmsVROJLAh
         Sv67dp3SObLgMyMGnLvoS9w5hA1a7ux2IseeiPrbqyd0U0Hr2h50bWq+Rv0nrlAgn1EK
         gqI3xUPLyVmMsOMwIl3aHp4BYoPq/dKS/TpiuNHRSFPI6VeMHyHntYoL4u6FFSVPZqfX
         C81Q==
X-Gm-Message-State: AOAM533T+QIrCssbtDpQJx2G2dH+jfSsu9uDj1i7kV8nojbRwYrkV2cr
        Ifq1InHw3X/5lZEP/2JMoho=
X-Google-Smtp-Source: ABdhPJxGsrm06i2I/qV/lMSAXI3+iYKhtb9rXqg+sZXxU00Rb1IKhFCUZBQWuBV9j+e4+kGoUdEX4g==
X-Received: by 2002:aca:bbc3:: with SMTP id l186mr2410876oif.112.1602247908986;
        Fri, 09 Oct 2020 05:51:48 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id l25sm6736861otb.4.2020.10.09.05.51.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2020 05:51:48 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        willy@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 0/2] avoid xfs transaction reservation recursion 
Date:   Fri,  9 Oct 2020 20:51:25 +0800
Message-Id: <20201009125127.37435-1-laoar.shao@gmail.com>
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

[1] https://lore.kernel.org/linux-mm/20200625113122.7540-1-willy@infradead.org/

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
- retitle from "xfs: introduce task->in_fstrans for transaction reservation recursion protection"
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
2.17.1

