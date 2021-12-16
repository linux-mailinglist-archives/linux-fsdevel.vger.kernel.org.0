Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADAB477518
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 15:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbhLPO5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 09:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbhLPO5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:57:14 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EFFC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Dec 2021 06:57:14 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e136so65211324ybc.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Dec 2021 06:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lulanwG+A5JAL3xQCFNVjbLKzAgLtNz5V19bludNqIs=;
        b=SzdtLi0IuKeee2Yj0Oj0WYBvbxz5uRe7IzYpJ6iZnQ13r2w/wmamIlao1Pozbbhrck
         LST2F1W1PoUbyv6I23z1SK3PbpESgDHB2ee8R9LgZ8TvjGVNB45gXYyGecpRsDqt/vFZ
         gjb+oS7XpSDLMmqSOYmASK8ILCZD1aEqVdfcv37B5NHQwrobqA2cQrVWNP/B0V33nkIH
         9wNeJUyj+SSL38KveDHJaz5cmAF5guNoMXZOA5wIRkqLal8xnb2LCluVYm59Q6ryfSYZ
         z+nBIG+5AyXvRxVNt+bVaQXRL6JUlCMcFrWTrwIni82NoB0FyRCyZo8tGqSKAAUHM307
         NORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lulanwG+A5JAL3xQCFNVjbLKzAgLtNz5V19bludNqIs=;
        b=xjLgqEHTxM/pE+iExK0+HT1MvakB//r/s1Nu2dn8Cqmgr9WCNljilx51E8Z5TTXcDz
         fqdJFZjDC0/kqblxi8fpnqUOaCpPgYZjm1lAUkVdwdxMJQpDhP0ArFhaedkcJILf0Drp
         +Q5q+LwKywj+j6EUrDUAZ7xXZjRDRCCYrpMRkgmeOeoBhjv+HQxGfPrMyIUx5O2YVFsp
         UZrtV3xpbEfaMcimjph8eXyd67fDxivW8PFoJEzFeUIWeJ8mqYdC3AoAQyv7KQZo4eBb
         4j+Raoz1vDBwN5sMw7fDhTXduzAs+fb0oMbUrSwXTzxrU9+1D94SmCbSxgKQK38jNaKQ
         Vd8g==
X-Gm-Message-State: AOAM531oj6pFpsdxfo+/iBlw7azzDIpysvy5GF5a2CkEjfU/UPb7/FzX
        sMVNqwZo1bQNdUiKcJdkkk/kJnjB/XaBxLA5movvsw==
X-Google-Smtp-Source: ABdhPJzYeQMUUARZJBbO6PTOx54PIlWKKuY7ZV++iWN0NFXdp7DjEmoFpv1n1p0impJjhfvPCYi3Vhl4GJBy4iMFMuQ=
X-Received: by 2002:a25:b285:: with SMTP id k5mr13984870ybj.132.1639666633294;
 Thu, 16 Dec 2021 06:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20211213165342.74704-12-songmuchun@bytedance.com> <20211216130102.GE10708@xsang-OptiPlex-9020>
In-Reply-To: <20211216130102.GE10708@xsang-OptiPlex-9020>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 16 Dec 2021 22:56:36 +0800
Message-ID: <CAMZfGtVgmudUJWtmA68h3fVD3ThHP_Rq70Dj7h7hGx74ZCUFcQ@mail.gmail.com>
Subject: Re: [External] [mm] 86cda95957: BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, willy@infradead.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        shakeelb@google.com, guro@fb.com, shy828301@gmail.com,
        alexs@kernel.org, richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, zhengqi.arch@bytedance.com,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 16, 2021 at 9:01 PM kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 86cda9595796e709c444b93df1f27a2343c5fa06 ("[PATCH v4 11/17] mm: list_lru: allocate list_lru_one only when needed")
> url: https://github.com/0day-ci/linux/commits/Muchun-Song/Optimize-list-lru-memory-consumption/20211214-010208
> base: https://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git dev-test
> patch link: https://lore.kernel.org/linux-fsdevel/20211213165342.74704-12-songmuchun@bytedance.com
>
> in testcase: xfstests
> version: xfstests-x86_64-972d710-1_20211215
> with following parameters:
>
>         disk: 4HDD
>         fs: xfs
>         test: xfs-reflink-25
>         ucode: 0x28
>
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
>
> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz with 6G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> erial console /d[   14.815233][  T356] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:230
> [   14.827152][  T356] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 356, name: useradd
> [   14.835607][  T356] preempt_count: 1, expected: 0
> [   14.840274][  T356] CPU: 4 PID: 356 Comm: useradd Not tainted 5.16.0-rc1-00032-g86cda9595796 #1
> ev/ttyS0
> [   14.848903][  T356] Hardware name: Dell Inc. OptiPlex 9020/03CPWF, BIOS A11 04/01/2015
> [   14.857606][  T356] Call Trace:
> [   14.860732][  T356]  <TASK>
> [ 14.863515][ T356] dump_stack_lvl (lib/dump_stack.c:107)
> [ 14.867859][ T356] __might_resched.cold (kernel/sched/core.c:9543 kernel/sched/core.c:9496)
> [ 14.872889][ T356] ? memcg_list_lru_alloc (include/linux/slab.h:598 mm/list_lru.c:354 mm/list_lru.c:586)
> [ 14.878083][ T356] __kmalloc (include/linux/sched/mm.h:230 mm/slab.h:509 mm/slub.c:3148 mm/slub.c:3242 mm/slub.c:4433)
> [ 14.882177][ T356] ? is_bpf_text_address (arch/x86/include/asm/preempt.h:85 include/linux/rcupdate.h:73 include/linux/rcupdate.h:720 kernel/bpf/core.c:717)
> [ 14.887129][ T356] memcg_list_lru_alloc (include/linux/slab.h:598 mm/list_lru.c:354 mm/list_lru.c:586)
> [ 14.892166][ T356] ? xas_alloc (lib/xarray.c:374)
> [ 14.896421][ T356] kmem_cache_alloc_lru (include/linux/cgroup.h:403 mm/slab.h:295 mm/slab.h:514 mm/slub.c:3148 mm/slub.c:3242 mm/slub.c:3249 mm/slub.c:3266)
> [ 14.901367][ T356] xas_alloc (lib/xarray.c:374)

Thanks for reporting this. It was caused when rebasing the code.
Will fix.
