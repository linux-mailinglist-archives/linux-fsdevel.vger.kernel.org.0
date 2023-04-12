Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048B46DF800
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 16:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjDLOHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 10:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjDLOHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:07:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17ED9027
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 07:07:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id kh6so9933631plb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681308440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ezr0Pa2G5CPCejRpgTKWLJ2fU/GGW7Xz3oIM+nnVa98=;
        b=RUfxf6kD6IVsna+AcdeGpsOuyFBveZCvq4fj5TUDZEDOJMqYKtchhmzLkACtgRjcoG
         c0nrY2rl7Jpm6mc9ZXCH7XpVnXkhQfAfisiZ6Q37g31KcI5eAclqRq0msdxE6vgM/P45
         cdt6u3/iHu/QmUG9QPGq5X0oVet0CBytzJF0SMywaFud+I6Sao1MeFWBRHd6r/QlYysH
         Ex3SZ1TNSlbeb110UJuhky/8YxGowIYvNxfyWc/iS6bkGkXoYmjKiFCgC/roxlytfFFL
         PAzLy2MWPeGu1FWblrPfZGPiuqCrXQXxMl+jZGrZL0xQnHVt1ezlNytEn6Pb99sKTvBF
         tLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681308440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezr0Pa2G5CPCejRpgTKWLJ2fU/GGW7Xz3oIM+nnVa98=;
        b=U6pKT4nqp5GCB+YnyqsZtGlIXkxDyPQWQt+fHqdKmfEQmUQEJNgdz75j3tb//DFHrD
         eravMHs3REy8weKe1KmbmtdqUAPNQS1cCodiOXBvP2LcwX7zh43QR1pWl09v3ay0l9DT
         Dx+LVwePWcbZNZGO7Ub+bruGyqlNtezZ2ozTzzdZYo8kcxS0VaWWIBpLMdE6fkf5MGiG
         FbsFMXZq0dpeh0/dvTzETlRsyqYdzD/KL9G711yLQd2+a7FGtA647csUFI4F8Lko/kIk
         qT/iDM1pa/9ZfiG+qDWDKcXC0vnzI83TQXOM4cEjIy9OrvYc/G8SbSncH77SY17pzlzI
         VRSQ==
X-Gm-Message-State: AAQBX9egjPomxeffaoXgHW4JaroikxBJ/cBdZcaY1W9QBVKLnCCOPROa
        UeY47O/7iDYBt/8U2CXicxC6pg==
X-Google-Smtp-Source: AKy350aoVZivfdOILzQNFOY/Kl0qh9fiQnQGPIoXOeaWxhUQeXzRzX7ejWwCul5FRJunZAWmCLAiSg==
X-Received: by 2002:a05:6a20:7a90:b0:da:f525:e629 with SMTP id u16-20020a056a207a9000b000daf525e629mr19924239pzh.53.1681308439909;
        Wed, 12 Apr 2023 07:07:19 -0700 (PDT)
Received: from C02FT5A6MD6R.lan ([111.201.131.102])
        by smtp.gmail.com with ESMTPSA id f9-20020a63de09000000b00502e6bfedc0sm10473613pgg.0.2023.04.12.07.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:07:19 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH v6 0/2] sched/numa: add per-process numa_balancing
Date:   Wed, 12 Apr 2023 22:06:58 +0800
Message-Id: <20230412140701.58337-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

# Introduce
Add PR_NUMA_BALANCING in prctl.

A large number of page faults will cause performance loss when numa
balancing is performing. Thus those processes which care about worst-case
performance need numa balancing disabled. Others, on the contrary, allow a
temporary performance loss in exchange for higher average performance, so
enable numa balancing is better for them.

Numa balancing can only be controlled globally by
/proc/sys/kernel/numa_balancing. Due to the above case, we want to
disable/enable numa_balancing per-process instead.

Set per-process numa balancing:
	prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING_DISABLE); //disable
	prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING_ENABLE);  //enable
	prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING_DEFAULT); //follow global
Get numa_balancing state:
	prctl(PR_NUMA_BALANCING, PR_GET_NUMA_BALANCING, &ret);
	cat /proc/<pid>/status | grep NumaB_mode

# Unixbench
This is overhead of this patch, not performance improvement.
+-------------------+----------+
|       NAME        | OVERHEAD |
+-------------------+----------+
| Pipe_Throughput   |  0.98%   |
| Context_Switching | -0.96%   |
| Process_Creation  |  1.18%   |
+-------------------+----------+

# Changes
Changes in v6:
- rebase on top of next-20230411
- run Unixbench on physical machine
- acked by John Hubbard <jhubbard@nvidia.com>

Changes in v5:
- replace numab_enabled with numa_balancing_mode (Peter Zijlstra)
- make numa_balancing_enabled and numa_balancing_mode inline (Peter Zijlstra)
- use static_branch_inc/dec instead of static_branch_enable/disable (Peter Zijlstra)
- delete CONFIG_NUMA_BALANCING in task_tick_fair (Peter Zijlstra)
- reword commit, use imperative mood (Bagas Sanjaya)
- Unixbench overhead result

Changes in v4:
- code clean: add wrapper function `numa_balancing_enabled`

Changes in v3:
- Fix compile error.

Changes in v2:
- Now PR_NUMA_BALANCING support three states: enabled, disabled, default.
  enabled and disabled will ignore global setting, and default will follow
  global setting.

Gang Li (2):
  sched/numa: use static_branch_inc/dec for sched_numa_balancing
  sched/numa: add per-process numa_balancing

 Documentation/filesystems/proc.rst   |  2 ++
 fs/proc/task_mmu.c                   | 20 ++++++++++++
 include/linux/mm_types.h             |  3 ++
 include/linux/sched/numa_balancing.h | 45 ++++++++++++++++++++++++++
 include/uapi/linux/prctl.h           |  8 +++++
 kernel/fork.c                        |  4 +++
 kernel/sched/core.c                  | 26 +++++++--------
 kernel/sched/fair.c                  |  9 +++---
 kernel/sys.c                         | 47 ++++++++++++++++++++++++++++
 mm/mprotect.c                        |  6 ++--
 10 files changed, 151 insertions(+), 19 deletions(-)

-- 
2.20.1

