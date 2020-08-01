Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCBF23530F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Aug 2020 17:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgHAPrG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 11:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgHAPrF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 11:47:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7436CC06174A;
        Sat,  1 Aug 2020 08:47:05 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k1so8712189pjt.5;
        Sat, 01 Aug 2020 08:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1/LIK5z8LpEjaiV5PgdQN/TGYlLzQCzLQ9WZxCYRT3M=;
        b=ISt6b5CO+PgBxTFtNQZKUWC+4k97ipOTgJP3Xr/eVnzsbq4L6hMsMXl1Atk76btI+B
         +IdfvHkDp3mPAE/l3Z7o+F42/kAeIDELcyohqWtbNROo53RP+LJjHV9gbtM0voE+9fRp
         1UYLlVhNa6i8j/BPMtiaK+7dpe1lMfRk+z2JFbFseCQakIGEEaojWlnSo0DQhDo9TfPk
         xrCf3szjilwKlr0osaUlR0hyNlj43xJtpniMp2SSBP/2IHRd1hWJugfkWTxHoJXDT8tC
         D+aKPfvpr479steWWD4v5mdds/D06f4g0XeJ2K1a8q7L0towXtGDs6cdyz/KxkKBbkap
         Ck0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1/LIK5z8LpEjaiV5PgdQN/TGYlLzQCzLQ9WZxCYRT3M=;
        b=ptqdyvj53F+Ew0bsyq0Eie8fnUrSRL+LXU0qWwy1o2AIAO2bjBgBNgEzW7lvDGhM6F
         MrTD715EDw3NB+WneRwV8cPMBpjj2zIkt3ixhK8uAvqsrLaqJQVQH5WsPED3u4unZwhM
         rjplBjSmMhLlpSArb5beKDGmf9IINmCkRXiw83DjdNxExTB1jlXVDPFJPwWw8/CNEvZi
         UheQkklT6D1bpxjg5Hi3xOe+hgSxF1/M36919QXBBJBtjkwk7WSNNMcw4mFq6yfTELer
         ILBnGFDNFoeDaJWrVFBea+bC1iZ5W/YYEtrzctIam9LXvbe8cgXbgrUGz4dmVZYzeQ1Z
         00Tw==
X-Gm-Message-State: AOAM530MH1j01/Aotl166ouJRRrU9/4OdM9C11vI4eDkUP82BM16TW36
        NWMXTUr2rR8mhX60rwGqI/U=
X-Google-Smtp-Source: ABdhPJzqUrDCi4cOXpwbQuNP60rIW0VC6lAm2NgSe1BZqzk6DL+PHJTL+GDRC+TI2aJCSxqBKHSK4A==
X-Received: by 2002:a17:90b:20d1:: with SMTP id ju17mr6082268pjb.219.1596296824919;
        Sat, 01 Aug 2020 08:47:04 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id j26sm13717331pfe.200.2020.08.01.08.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 08:47:04 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        mhocko@kernel.org, willy@infradead.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <shaoyafang@didiglobal.com>
Subject: [PATCH v4 0/2] void xfs transaction reservation recursion 
Date:   Sat,  1 Aug 2020 11:46:30 -0400
Message-Id: <20200801154632.866356-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yafang Shao <shaoyafang@didiglobal.com>

This patchset avoids transaction reservation recursion by reintroducing
the discarded PF_FSTRANS in a new way, suggested by Dave. In this new
implementation, two new helpers are introduced, which are
xfs_trans_context_{begin, end}, suggested by Christoph. And re-using the
task->journal_info to indicates whehter the task is in fstrans or not,
suggested by Willy. 

v4:
- retitle from "xfs: introduce task->in_fstrans for transaction reservation recursion protection"
- reuse current->journal_info, per Willy

Yafang Shao (2):
  xfs: avoid double restore PF_MEMALLOC_NOFS if transaction reservation
    fails
  xfs: avoid transaction reservation recursion

Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>

 fs/iomap/buffered-io.c    |  4 ++--
 fs/xfs/libxfs/xfs_btree.c |  2 ++
 fs/xfs/xfs_aops.c         |  3 +++
 fs/xfs/xfs_linux.h        | 19 +++++++++++++++++++
 fs/xfs/xfs_trans.c        | 21 +++++++++++++++------
 5 files changed, 41 insertions(+), 8 deletions(-)

-- 
2.18.1

