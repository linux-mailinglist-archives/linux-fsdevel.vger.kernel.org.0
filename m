Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B588524479
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 06:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347977AbiELErp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 00:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348169AbiELErL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 00:47:11 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B5625296
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 21:47:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y41so3729369pfw.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 21:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/pTgPhGOi/9d6Q/oqwaxhfFkmjeH4PVid+OZ0dZHdSw=;
        b=HvhsyDv1TuH2yCE9PXc22mXXi4RP3ENuXk44vilMbhfXZAh3usDN+q7UYC4Qg+hkbD
         ZW2CKXaScrpCanbEd7qxTPf1kXPgl9QX8PbgfaG4a5jGRByg/9RvP66UvSti/F/eerne
         9zZlmrit2DsqjneYnmSf5DYy2mgQT4UVh++EH5K5BS7KJ8FBUg++vX3SFWV0debV1ZGZ
         hQulKyeZYRi6+uBqZiVSot2SpRBP/ubpK3I7T7r3VT5dOzEHe1FjUbIYr5VsapkkoWXL
         XKFqIcpMeCvJy5i5+IKJlG02P/U1Fg7p5E8+zKZGAkfwuK2GfX+G3gQbW7uvquoMjGln
         ZY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/pTgPhGOi/9d6Q/oqwaxhfFkmjeH4PVid+OZ0dZHdSw=;
        b=hqyCGGJ085kN0PuchwUT63wXrs2fd8plIgMecF2sLQlaU9T18X8pEMcfdfjnCpAmqj
         HH09eprERReY91mvNCcODqdBmm/FZQsxfHxj/5dXx3w9X4Y9+Pk/cwmoWTCqT6jRhCHO
         6at0GQKgTln2By9mz/CnLp4vPIdvCEduLlDR/YtopO4N52llt1H8wRh8Pj/OVe3SQ3Cs
         5AVzeI5odGQxLpqpg6Nl70V3TIRKTWCTrRGA8MqdQs/yl6+q3LkNsQ/0GezOHJQ97NrT
         9o/RhTKUymce18t6plr8gdihNmHh+qhzFmpvaijdBdv8ZDLmawk3FuoLqsk52bCuMoxF
         V+og==
X-Gm-Message-State: AOAM5312rlbuCRqgWNlFeoGJu5nsqv9pDx5DOAAfpfzYh2vhv3wuvC35
        yW2C956UKlpkxgG641h9btMu5g==
X-Google-Smtp-Source: ABdhPJxVJxgprVu7WxtZqidhH+r8VEa6XOk7al5eXrOJrdSve9mLiQ3pEAj3JyiqY7GAMCjs7fxFtg==
X-Received: by 2002:a63:d842:0:b0:3c6:ab6b:5f3c with SMTP id k2-20020a63d842000000b003c6ab6b5f3cmr16180665pgj.148.1652330829556;
        Wed, 11 May 2022 21:47:09 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902e9c500b0015edc07dcf3sm2790824plk.21.2022.05.11.21.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 21:47:08 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     songmuchun@bytedance.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ebiederm@xmission.com, keescook@chromium.org,
        viro@zeniv.linux.org.uk, rostedt@goodmis.org, mingo@redhat.com,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, david@redhat.com, imbrenda@linux.ibm.com,
        apopple@nvidia.com, adobriyan@gmail.com,
        stephen.s.brennan@oracle.com, ohoono.kwon@samsung.com,
        haolee.swjtu@gmail.com, kaleshsingh@google.com,
        zhengqi.arch@bytedance.com, peterx@redhat.com, shy828301@gmail.com,
        surenb@google.com, ccross@google.com, vincent.whitchurch@axis.com,
        tglx@linutronix.de, bigeasy@linutronix.de, fenghua.yu@intel.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH 0/5 v1] mm, oom: Introduce per numa node oom for CONSTRAINT_MEMORY_POLICY
Date:   Thu, 12 May 2022 12:46:29 +0800
Message-Id: <20220512044634.63586-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TLDR:
If a mempolicy is in effect(oc->constraint == CONSTRAINT_MEMORY_POLICY), out_of_memory() will
select victim on specific node to kill. So that kernel can avoid accidental killing on NUMA system.

Problem:
Before this patch series, oom will only kill the process with the highest memory usage.
by selecting process with the highest oom_badness on the entire system to kill.

This works fine on UMA system, but may have some accidental killing on NUMA system.

As shown below, if process c.out is bind to Node1 and keep allocating pages from Node1,
a.out will be killed first. But killing a.out did't free any mem on Node1, so c.out
will be killed then.

A lot of our AMD machines have 8 numa nodes. In these systems, there is a greater chance
of triggering this problem.

OOM before patches:
```
Per-node process memory usage (in MBs)
PID             Node 0        Node 1      Total
----------- ---------- ------------- ----------
3095 a.out     3073.34          0.11    3073.45(Killed first. Maximum memory consumption)
3199 b.out      501.35       1500.00    2001.35
3805 c.out        1.52 (grow)2248.00    2249.52(Killed then. Node1 is full)
----------- ---------- ------------- ----------
Total          3576.21       3748.11    7324.31
```

Solution:
We store per node rss in mm_rss_stat for each process.

If a page allocation with mempolicy in effect(oc->constraint == CONSTRAINT_MEMORY_POLICY)
triger oom. We will calculate oom_badness with rss counter for the corresponding node. Then
select the process with the highest oom_badness on the corresponding node to kill.

OOM after patches:
```
Per-node process memory usage (in MBs)
PID             Node 0        Node 1     Total
----------- ---------- ------------- ----------
3095 a.out     3073.34          0.11    3073.45
3199 b.out      501.35       1500.00    2001.35
3805 c.out        1.52 (grow)2248.00    2249.52(killed)
----------- ---------- ------------- ----------
Total          3576.21       3748.11    7324.31
```

Gang Li (5):
  mm: add a new parameter `node` to `get/add/inc/dec_mm_counter`
  mm: add numa_count field for rss_stat
  mm: add numa fields for tracepoint rss_stat
  mm: enable per numa node rss_stat count
  mm, oom: enable per numa node oom for CONSTRAINT_MEMORY_POLICY

 arch/s390/mm/pgtable.c        |   4 +-
 fs/exec.c                     |   2 +-
 fs/proc/base.c                |   6 +-
 fs/proc/task_mmu.c            |  14 ++--
 include/linux/mm.h            |  59 ++++++++++++-----
 include/linux/mm_types_task.h |  16 +++++
 include/linux/oom.h           |   2 +-
 include/trace/events/kmem.h   |  27 ++++++--
 kernel/events/uprobes.c       |   6 +-
 kernel/fork.c                 |  70 +++++++++++++++++++-
 mm/huge_memory.c              |  13 ++--
 mm/khugepaged.c               |   4 +-
 mm/ksm.c                      |   2 +-
 mm/madvise.c                  |   2 +-
 mm/memory.c                   | 116 ++++++++++++++++++++++++----------
 mm/migrate.c                  |   2 +
 mm/migrate_device.c           |   2 +-
 mm/oom_kill.c                 |  59 ++++++++++++-----
 mm/rmap.c                     |  16 ++---
 mm/swapfile.c                 |   4 +-
 mm/userfaultfd.c              |   2 +-
 21 files changed, 317 insertions(+), 111 deletions(-)

-- 
2.20.1

