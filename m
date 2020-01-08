Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C59013470E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 17:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgAHQEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 11:04:10 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46885 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgAHQEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:04:10 -0500
Received: by mail-pf1-f194.google.com with SMTP id n9so1827240pff.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2020 08:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O/59ll9BT7ySNAyq15TOWkguTOBtHDyowD0yF/qPhwU=;
        b=V0ueTeav00Zs/6apyRUEiouI7V7VQdeNi9qm1uF7B6dXOmHzeMSifF2Wbe2B+em4H4
         IPZSkJ5U/mlSerF+vo3V/oYquB4qLJciNUtk4bO8MUFFCkbKKmtIsYSS8WxDXJVDSzOd
         uh9TKc69b1U8PiM/wmJTrCobncfxTSOr4B/m8nBbS/Kmxz6+b7fuqMI4BUC0Sj0Qbiz2
         ngrxv9ODUkRJhWN/f7tnlME0n7pgitme9EsTbJ/+WZyf4gb9SRMwbFg7G0XwtRra27mG
         XCB07SczfWAL3E0XJJ6UhRTy/V60u1mRBO/04V4nnyzoGSB3+JqTc3451huS5XsJOnN1
         WGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O/59ll9BT7ySNAyq15TOWkguTOBtHDyowD0yF/qPhwU=;
        b=R1h7Ek0YzsMXGvshA20XWCGXhBcY9XnhfKUWBgof21iTRHHTYnZpXbdSIrVMJmJ2lo
         Tc0DwzqHrjcu/7j9VsBuxsFqlsbSMcn5kmImKDDZRjgYZXUg8x+wTprM7ciY5RcUdOZX
         FgTtlSycLQwnv3VMY3fXvjyuh7z2/n19C4B49CDG2BiakBlQe1a696eDpXMdFLjmnNlR
         LU+4PqrPyXQXFclBjwSCLTmWueyy5zcTdeFxE3cQAq1/gPCaRFrGnl+N2abRpnfDM/sa
         V5V9yhbKB566vj2qhg3Y7+UEZK3b9nA1FNpJgz/c0K58U2jHA4M/1rjePww3TUM/zXOM
         uPLQ==
X-Gm-Message-State: APjAAAXcZ5IiWn5IwicXnAnkBz6WPuX5hBWOPRwdskb6WtQV/z+t4pKd
        w9ePLLMgS6oas0oB3R+XSpQ=
X-Google-Smtp-Source: APXvYqxmWPSkt+NymFJi+Eutrvhzt1cCbXhQ5HnVUwWaqPPbFiA6jvhbvAmrbzV4S5I6IbOkvRr2gw==
X-Received: by 2002:a63:48d:: with SMTP id 135mr5925819pge.66.1578499449210;
        Wed, 08 Jan 2020 08:04:09 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id d22sm4079894pfo.187.2020.01.08.08.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 08:04:08 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     dchinner@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, guro@fb.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 0/3] protect page cache from freeing inode
Date:   Wed,  8 Jan 2020 11:03:54 -0500
Message-Id: <1578499437-1664-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On my server there're some running MEMCGs protected by memory.{min, low},
but I found the usage of these MEMCGs abruptly became very small, which
were far less than the protect limit. It confused me and finally I
found that was because of inode stealing.
Once an inode is freed, all its belonging page caches will be dropped as
well, no matter how may page caches it has. So if we intend to protect the
page caches in a memcg, we must protect their host (the inode) first.
Otherwise the memcg protection can be easily bypassed with freeing inode,
especially if there're big files in this memcg.
The inherent mismatch between memcg and inode is a trouble. One inode can
be shared by different MEMCGs, but it is a very rare case. If an inode is
shared, its belonging page caches may be charged to different MEMCGs.
Currently there's no perfect solution to fix this kind of issue, but the
inode majority-writer ownership switching can help it more or less.

- Changes against v2:
    1. Seperates memcg patches from this patchset, suggested by Roman.
       A separate patch is alreay ACKed by Roman, please the MEMCG
       maintianers help take a look at it[1].
    2. Improves code around the usage of for_each_mem_cgroup(), suggested
       by Dave
    3. Use memcg_low_reclaim passed from scan_control, instead of
       introducing a new member in struct mem_cgroup.
    4. Some other code improvement suggested by Dave.


- Changes against v1:
Use the memcg passed from the shrink_control, instead of getting it from
inode itself, suggested by Dave. That could make the laying better.

[1]
https://lore.kernel.org/linux-mm/CALOAHbBhPgh3WEuLu2B6e2vj1J8K=gGOyCKzb8tKWmDqFs-rfQ@mail.gmail.com/

Yafang Shao (3):
  mm, list_lru: make memcg visible to lru walker isolation function
  mm, shrinker: make memcg low reclaim visible to lru walker isolation
    function
  memcg, inode: protect page cache from freeing inode

 fs/inode.c                 | 78 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/memcontrol.h | 21 +++++++++++++
 include/linux/shrinker.h   |  3 ++
 mm/list_lru.c              | 47 +++++++++++++++++-----------
 mm/memcontrol.c            | 15 ---------
 mm/vmscan.c                | 27 +++++++++-------
 6 files changed, 143 insertions(+), 48 deletions(-)

-- 
1.8.3.1

