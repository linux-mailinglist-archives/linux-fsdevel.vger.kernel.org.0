Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C1156B45C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 10:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbiGHIWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 04:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbiGHIWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:22:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032AF8148C
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 01:22:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l12so10415930plk.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jul 2022 01:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TYvSfrHPstnzZJynd8muvpANEKz59daC1D9QhUGyBsM=;
        b=8S3yywRTtMIjxIbmB2flA4mlE78K7EBRrgf2m5In+lt0C+3X/5Vf/tTjj1izXHBalu
         AV0aGsKbi/7a+twTRdFq3yHJKSxcSScq9KBDF747wJ3mngNrnukrV5zIqZuVCjPC6R+L
         G+cXhQGev+W1XhTy+AG5a8ITD0yxuiWjYhpKqrYL3YMtW/19UueJ9ElQrZljBJbgU7TP
         BHxnHRGSJE1eNT3N49c/c8W93Unt6EWBX4Z00NySj+KqRC7STeodgQIsmeCdswiuMDKj
         6g/crwKcDMZBCB4I5tAjUyv0EUG7gEh+dOACEqIOqMdkORqq/ko7odDQiWx+9VBB6ZjM
         dplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TYvSfrHPstnzZJynd8muvpANEKz59daC1D9QhUGyBsM=;
        b=zBUhkg0W9BbrqahGtTyorNgQFmKOmnPpdFc87DMQNToBAwoRCrAJejEATHEZ7Pg47m
         ltaL1lHV1UUVPKUYwD47sCa5KnCsVS2foZmwZbw1fwdsjJO1qfeDTnBj6Ma9lgeJsO1Q
         ZxcY4+zyJE4cNpsWPDHsaQDTzAN6I/jQGzkBtWmZrTZyBwKHvbRQa4A6TJwGjpuj7rCr
         PD84SX+3Eek/VC1ro9uX70uOWyxjbXE0qrx00jYGul1k4/nJAhU7oqHLNTk/cGlNUqgR
         MyjkrDJ+IvsxYG1kNNNzMsYcUf/7iMBGFQ5V22nYgA/RmE+56ERAFniQswbSbd/3l+rE
         TGhQ==
X-Gm-Message-State: AJIora+AU6OW1NXSoiIRDZuw23Fa0FOe8ZkbmQ3ZAO9RSGBPpClNTggI
        j17QzmLLn5T4rB/YjI4MztIprg==
X-Google-Smtp-Source: AGRyM1tcEE95Ekpp4tq/jJm3aTC46fHNhCwmQGo2VLd2iQl+tjB6CnBUyJJtwF4xhqrjmqieK2tKVg==
X-Received: by 2002:a17:902:a502:b0:16b:fbd9:7fc5 with SMTP id s2-20020a170902a50200b0016bfbd97fc5mr2516757plq.112.1657268531484;
        Fri, 08 Jul 2022 01:22:11 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id x65-20020a636344000000b00412b1043f33sm3329291pgb.39.2022.07.08.01.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 01:22:10 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     mhocko@suse.com, akpm@linux-foundation.org, surenb@google.com
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, david@redhat.com, imbrenda@linux.ibm.com,
        adobriyan@gmail.com, yang.yang29@zte.com.cn, brauner@kernel.org,
        stephen.s.brennan@oracle.com, zhengqi.arch@bytedance.com,
        haolee.swjtu@gmail.com, xu.xin16@zte.com.cn,
        Liam.Howlett@Oracle.com, ohoono.kwon@samsung.com,
        peterx@redhat.com, arnd@arndb.de, shy828301@gmail.com,
        alex.sierra@amd.com, xianting.tian@linux.alibaba.com,
        willy@infradead.org, ccross@google.com, vbabka@suse.cz,
        sujiaxun@uniontech.com, sfr@canb.auug.org.au,
        vasily.averin@linux.dev, mgorman@suse.de, vvghjk1234@gmail.com,
        tglx@linutronix.de, luto@kernel.org, bigeasy@linutronix.de,
        fenghua.yu@intel.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH v2 0/5] mm, oom: Introduce per numa node oom for CONSTRAINT_{MEMORY_POLICY,CPUSET}
Date:   Fri,  8 Jul 2022 16:21:24 +0800
Message-Id: <20220708082129.80115-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TLDR
----
If a mempolicy or cpuset is in effect, out_of_memory() will select victim
on specific node to kill. So that kernel can avoid accidental killing on
NUMA system.

Problem
-------
Before this patch series, oom will only kill the process with the highest 
memory usage by selecting process with the highest oom_badness on the
entire system.

This works fine on UMA system, but may have some accidental killing on NUMA
system.

As shown below, if process c.out is bind to Node1 and keep allocating pages
from Node1, a.out will be killed first. But killing a.out did't free any
mem on Node1, so c.out will be killed then.

A lot of AMD machines have 8 numa nodes. In these systems, there is a
greater chance of triggering this problem.

OOM before patches:
```
Per-node process memory usage (in MBs)
PID             Node 0        Node 1    Total
----------- ---------- ------------- --------
3095 a.out     3073.34          0.11  3073.45(Killed first. Max mem usage)
3199 b.out      501.35       1500.00  2001.35
3805 c.out        1.52 (grow)2248.00  2249.52(Killed then. Node1 is full)
----------- ---------- ------------- --------
Total          3576.21       3748.11  7324.31
```

Solution
--------
We store per node rss in mm_rss_stat for each process.

If a page allocation with mempolicy or cpuset in effect triger oom. We will
calculate oom_badness with rss counter for the corresponding node. Then
select the process with the highest oom_badness on the corresponding node
to kill.

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

Overhead
--------
CPU:

According to the result of Unixbench. There is less than one percent
performance loss in most cases.

On 40c512g machine.

40 parallel copies of tests:
+----------+----------+-----+----------+---------+---------+---------+
| numastat | FileCopy | ... |   Pipe   |  Fork   | syscall |  total  |
+----------+----------+-----+----------+---------+---------+---------+
| off      | 2920.24  | ... | 35926.58 | 6980.14 | 2617.18 | 8484.52 |
| on       | 2919.15  | ... | 36066.07 | 6835.01 | 2724.82 | 8461.24 |
| overhead | 0.04%    | ... | -0.39%   | 2.12%   | -3.95%  | 0.28%   |
+----------+----------+-----+----------+---------+---------+---------+

1 parallel copy of tests:
+----------+----------+-----+---------+--------+---------+---------+
| numastat | FileCopy | ... |  Pipe   |  Fork  | syscall |  total  |
+----------+----------+-----+---------+--------+---------+---------+
| off      | 1515.37  | ... | 1473.97 | 546.88 | 1152.37 | 1671.2  |
| on       | 1508.09  | ... | 1473.75 | 532.61 | 1148.83 | 1662.72 |
| overhead | 0.48%    | ... | 0.01%   | 2.68%  | 0.31%   | 0.51%   |
+----------+----------+-----+---------+--------+---------+---------+

MEM:

per task_struct:
sizeof(int) * num_possible_nodes() + sizeof(int*)
typically 4 * 2 + 8 bytes

per mm_struct:
sizeof(atomic_long_t) * num_possible_nodes() + sizeof(atomic_long_t*)
typically 8 * 2 + 8 bytes

zap_pte_range:
sizeof(int) * num_possible_nodes() + sizeof(int*)
typically 4 * 2 + 8 bytes 

Changelog
----------
v2:
  - enable per numa node oom for `CONSTRAINT_CPUSET`.
  - add benchmark result in cover letter.

Gang Li (5):
  mm: add a new parameter `node` to `get/add/inc/dec_mm_counter`
  mm: add numa_count field for rss_stat
  mm: add numa fields for tracepoint rss_stat
  mm: enable per numa node rss_stat count
  mm, oom: enable per numa node oom for
    CONSTRAINT_{MEMORY_POLICY,CPUSET}

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
 mm/memory.c                   | 119 ++++++++++++++++++++++++----------
 mm/migrate.c                  |   4 ++
 mm/migrate_device.c           |   2 +-
 mm/oom_kill.c                 |  69 +++++++++++++++-----
 mm/rmap.c                     |  19 +++---
 mm/swapfile.c                 |   6 +-
 mm/userfaultfd.c              |   2 +-
 21 files changed, 335 insertions(+), 113 deletions(-)

-- 
2.20.1

