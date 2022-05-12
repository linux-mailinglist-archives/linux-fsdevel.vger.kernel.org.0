Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4EA5257CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 00:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359180AbiELWbu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 18:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359179AbiELWbs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 18:31:48 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED945909D
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 15:31:46 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2f7d621d1caso72533607b3.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 15:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AJGrVRrH+dOEhiElDtPJnom+nsrzVSlx3m1P3MXcyt8=;
        b=HKHBQnUdowSNLBhbkOBsBEX5C+iK1w0Yf+bcFPhOqlRiMP6A0Mz5ltaYanBi+i05iG
         cin6l4liXxnPvewh1T7T7VdF/b2gZubu8BFpF1WFRdvGC4vbHWLBnyEHMDVH+/ycYupI
         sjKR4L02x/5+BSW+jam05AzZ2NmQlqkBhti6Uq78H0zr3uNSRVTWjzYDMTHeVMumdU/f
         6Swv4843WGA/Mnd9MNpjok50X0vmtCH9JqfJWCHJy2aQ5P6XU2iRMYw+xQW3GDRas9BS
         PaouOeajWzpDJoWV+wRBWGsBQvWe3KgQtzreixaQBUYxzKZaZERpu/imjAsk5CAWC9cB
         OUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJGrVRrH+dOEhiElDtPJnom+nsrzVSlx3m1P3MXcyt8=;
        b=jr726GemCv0IHdd87cRgs9DhB+sXD9QmQeOto7Cu35hz18ERBowcfHNxZAx4vvPbXT
         auqgeDViWXLTPNa+gMOX0/2/M6XWF7xCddM9JXPwuhg1+oswZ4NbVhUBt01KhcH+lcFe
         xEbTVRdtdbUGgwpLc28hGjYTo7gR4PDRdZMJmNkjZZ8nuigIInYfq5myzsYCdlg2SisE
         7k5FFRbsV0X/JRTIh7oMktPIdwaz199PXrXrwwqR9ZSjaZ/n7O1gBRPFyNeJRR14hWEe
         HwDDZrk6+2il5G42zadmzk7c1RpCHKHViByT8d2GSKG7Gqyfeuuhdr5ijV+LcsPjY8cd
         9icQ==
X-Gm-Message-State: AOAM531iz4Yh8Vio6dN7IitGaM0gD5ihQF7nfadxLUmZUlByOfgVc8mO
        HxzioPWLULsjXtD94sHh80iTYMlYNN7uURi0XHmuNA==
X-Google-Smtp-Source: ABdhPJwzefOUbhnD4vlu7+gan+V9STOahhU9EhcwGhhFaV8YI/mjlx7OYk8OXREHs4uUiLanalOYjb8ajWHHjC3d7gc=
X-Received: by 2002:a81:4fd0:0:b0:2fb:2c3e:6cbc with SMTP id
 d199-20020a814fd0000000b002fb2c3e6cbcmr2716004ywb.180.1652394705360; Thu, 12
 May 2022 15:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220512044634.63586-1-ligang.bdlg@bytedance.com>
In-Reply-To: <20220512044634.63586-1-ligang.bdlg@bytedance.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 12 May 2022 15:31:34 -0700
Message-ID: <CAJuCfpGDamD6P6Tgz=Y59fpj1NgFL0wjKe+y42-mCQ2x-asx3A@mail.gmail.com>
Subject: Re: [PATCH 0/5 v1] mm, oom: Introduce per numa node oom for CONSTRAINT_MEMORY_POLICY
To:     Gang Li <ligang.bdlg@bytedance.com>, Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        David Hildenbrand <david@redhat.com>, imbrenda@linux.ibm.com,
        apopple@nvidia.com, Alexey Dobriyan <adobriyan@gmail.com>,
        stephen.s.brennan@oracle.com, ohoono.kwon@samsung.com,
        haolee.swjtu@gmail.com, Kalesh Singh <kaleshsingh@google.com>,
        zhengqi.arch@bytedance.com, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Colin Cross <ccross@google.com>, vincent.whitchurch@axis.com,
        Thomas Gleixner <tglx@linutronix.de>, bigeasy@linutronix.de,
        fenghua.yu@intel.com, linux-s390@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 9:47 PM Gang Li <ligang.bdlg@bytedance.com> wrote:
>
> TLDR:
> If a mempolicy is in effect(oc->constraint == CONSTRAINT_MEMORY_POLICY), out_of_memory() will
> select victim on specific node to kill. So that kernel can avoid accidental killing on NUMA system.
>
> Problem:
> Before this patch series, oom will only kill the process with the highest memory usage.
> by selecting process with the highest oom_badness on the entire system to kill.
>
> This works fine on UMA system, but may have some accidental killing on NUMA system.
>
> As shown below, if process c.out is bind to Node1 and keep allocating pages from Node1,
> a.out will be killed first. But killing a.out did't free any mem on Node1, so c.out
> will be killed then.
>
> A lot of our AMD machines have 8 numa nodes. In these systems, there is a greater chance
> of triggering this problem.
>
> OOM before patches:
> ```
> Per-node process memory usage (in MBs)
> PID             Node 0        Node 1      Total
> ----------- ---------- ------------- ----------
> 3095 a.out     3073.34          0.11    3073.45(Killed first. Maximum memory consumption)
> 3199 b.out      501.35       1500.00    2001.35
> 3805 c.out        1.52 (grow)2248.00    2249.52(Killed then. Node1 is full)
> ----------- ---------- ------------- ----------
> Total          3576.21       3748.11    7324.31
> ```
>
> Solution:
> We store per node rss in mm_rss_stat for each process.
>
> If a page allocation with mempolicy in effect(oc->constraint == CONSTRAINT_MEMORY_POLICY)
> triger oom. We will calculate oom_badness with rss counter for the corresponding node. Then
> select the process with the highest oom_badness on the corresponding node to kill.
>
> OOM after patches:
> ```
> Per-node process memory usage (in MBs)
> PID             Node 0        Node 1     Total
> ----------- ---------- ------------- ----------
> 3095 a.out     3073.34          0.11    3073.45
> 3199 b.out      501.35       1500.00    2001.35
> 3805 c.out        1.52 (grow)2248.00    2249.52(killed)
> ----------- ---------- ------------- ----------
> Total          3576.21       3748.11    7324.31
> ```

You included lots of people but missed Michal Hocko. CC'ing him and
please include him in the future postings.

>
> Gang Li (5):
>   mm: add a new parameter `node` to `get/add/inc/dec_mm_counter`
>   mm: add numa_count field for rss_stat
>   mm: add numa fields for tracepoint rss_stat
>   mm: enable per numa node rss_stat count
>   mm, oom: enable per numa node oom for CONSTRAINT_MEMORY_POLICY
>
>  arch/s390/mm/pgtable.c        |   4 +-
>  fs/exec.c                     |   2 +-
>  fs/proc/base.c                |   6 +-
>  fs/proc/task_mmu.c            |  14 ++--
>  include/linux/mm.h            |  59 ++++++++++++-----
>  include/linux/mm_types_task.h |  16 +++++
>  include/linux/oom.h           |   2 +-
>  include/trace/events/kmem.h   |  27 ++++++--
>  kernel/events/uprobes.c       |   6 +-
>  kernel/fork.c                 |  70 +++++++++++++++++++-
>  mm/huge_memory.c              |  13 ++--
>  mm/khugepaged.c               |   4 +-
>  mm/ksm.c                      |   2 +-
>  mm/madvise.c                  |   2 +-
>  mm/memory.c                   | 116 ++++++++++++++++++++++++----------
>  mm/migrate.c                  |   2 +
>  mm/migrate_device.c           |   2 +-
>  mm/oom_kill.c                 |  59 ++++++++++++-----
>  mm/rmap.c                     |  16 ++---
>  mm/swapfile.c                 |   4 +-
>  mm/userfaultfd.c              |   2 +-
>  21 files changed, 317 insertions(+), 111 deletions(-)
>
> --
> 2.20.1
>
