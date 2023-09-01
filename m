Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC0778FBFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 12:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243003AbjIAK62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 06:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbjIAK62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:58:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCDF10CE
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Sep 2023 03:58:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26f51625d96so1295903a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Sep 2023 03:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693565903; x=1694170703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OJ2dXFmVQZDKYTCTqxGvL38WRbzk3NvjgnLsPgru5I=;
        b=EtxRq+bws1ukhjD1v9GzF+IcNroQopyYXzau4FjoHvX8DFZoudX8lGLvgiMm9B2vG7
         gkx4AijNpO86Z+xMf10vz5Wmavu58y63HKKeKRX8J8K7iIMzh35L4AEg5EGkWLC9SLlX
         r5p3GMaQKcUPehw3v1FXZay5v7Q5xTseO2PAsQIYNw1C6bhZZz+jn0eAWoehW5ThpJIS
         GVun8wDJ0HccKsTMpgKEbihI0iVNhX5p2ARfD2Oc2UVWvSgUWPK3F2Azhn/bqn8IgCHt
         WyprfZVPXyjYisHfN0BAEgviMdGxSIo8mZyCyEgVCiNSuqYErs0TPfKwMSqKQMN+wD5c
         Gsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693565903; x=1694170703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0OJ2dXFmVQZDKYTCTqxGvL38WRbzk3NvjgnLsPgru5I=;
        b=bk25XgjS9My57I7+8In3nMft+ifoZZlr5sdzkA63TouKY2vR7dv0iR0bf7R5f2QfFX
         Zr9347xso6qkuft236K232/OD2ZQNBJY/vXLpVbxQ7YgKDhI81UXTuOolF+JPbODevAX
         HzrnxapVHH+cdq0EO6y2QfFl+nzpts4cC8tfP9euBMKHUSf8FuJkmajDHOayrxKjGttk
         6JV0Os7hrxhUVoNAFjWS6UMhlPtfBq7BIhNMJ4FL5NNHkffZ9Ne+Jw1Jvffm9jsbQ+Jv
         EwMXNjJvKA/GZ/SlA0dPy9SLOjHbvHMgEdwscJ2LA8sTY/WvKrFDTd15nQq1BzCsthZ2
         A9Kw==
X-Gm-Message-State: AOJu0Yy3G/6POYzyQdBG9AAtaq33ulcPDd0b7k/q7xpMJ4k+VEBHS/ib
        wMoIcPkvq2DoWgcLxLTmgUhuUA==
X-Google-Smtp-Source: AGHT+IFGbfzgdwxEt/HnFveYKKdr+aD0fnh004mDvQW3jFYTFzXeSmwTJL/T/b9JwunOBQtUQUpHqw==
X-Received: by 2002:a17:90b:150:b0:263:43c6:69ac with SMTP id em16-20020a17090b015000b0026343c669acmr1761895pjb.44.1693565902618;
        Fri, 01 Sep 2023 03:58:22 -0700 (PDT)
Received: from [10.254.254.90] ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id ck18-20020a17090afe1200b00262d662c9adsm4344759pjb.53.2023.09.01.03.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 03:58:22 -0700 (PDT)
Message-ID: <0e9a87d9-410f-a906-e95c-976a141f24f0@bytedance.com>
Date:   Fri, 1 Sep 2023 18:58:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 5/6] maple_tree: Update check_forking() and
 bench_forking()
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        avagin@gmail.com, linux-doc@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <202308312115.cad34fed-oliver.sang@intel.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <202308312115.cad34fed-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/8/31 21:40, kernel test robot 写道:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:possible_recursive_locking_detected" on:
> 
> commit: 2730245bd6b13a94a67e84c10832a9f52fad0aa5 ("[PATCH v2 5/6] maple_tree: Update check_forking() and bench_forking()")
> url: https://github.com/intel-lab-lkp/linux/commits/Peng-Zhang/maple_tree-Add-two-helpers/20230830-205847
> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
> patch link: https://lore.kernel.org/all/20230830125654.21257-6-zhangpeng.00@bytedance.com/
> patch subject: [PATCH v2 5/6] maple_tree: Update check_forking() and bench_forking()
> 
> in testcase: boot
> 
> compiler: clang-16
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202308312115.cad34fed-oliver.sang@intel.com
> 
> 
> [   25.146957][    T1] WARNING: possible recursive locking detected
> [   25.147110][    T1] 6.5.0-rc4-00632-g2730245bd6b1 #1 Tainted: G                TN
> [   25.147110][    T1] --------------------------------------------
> [   25.147110][    T1] swapper/1 is trying to acquire lock:
> [ 25.147110][ T1] ffffffff86485058 (&mt->ma_lock){+.+.}-{2:2}, at: check_forking (include/linux/spinlock.h:? lib/test_maple_tree.c:1854)
> [   25.147110][    T1]
> [   25.147110][    T1] but task is already holding lock:
> [ 25.147110][ T1] ffff888110847a30 (&mt->ma_lock){+.+.}-{2:2}, at: check_forking (include/linux/spinlock.h:351 lib/test_maple_tree.c:1854)
Thanks for the test. I checked that these are two different locks, why
is this warning reported? Did I miss something?
> [   25.147110][    T1]
> [   25.147110][    T1] other info that might help us debug this:
> [   25.147110][    T1]  Possible unsafe locking scenario:
> [   25.147110][    T1]
> [   25.147110][    T1]        CPU0
> [   25.147110][    T1]        ----
> [   25.147110][    T1]   lock(&mt->ma_lock);
> [   25.147110][    T1]
> [   25.147110][    T1]  *** DEADLOCK ***
> [   25.147110][    T1]
> [   25.147110][    T1]  May be due to missing lock nesting notation
> [   25.147110][    T1]
> [   25.147110][    T1] 1 lock held by swapper/1:
> [ 25.147110][ T1] #0: ffff888110847a30 (&mt->ma_lock){+.+.}-{2:2}, at: check_forking (include/linux/spinlock.h:351 lib/test_maple_tree.c:1854)
> [   25.147110][    T1]
> [   25.147110][    T1] stack backtrace:
> [   25.147110][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                TN 6.5.0-rc4-00632-g2730245bd6b1 #1
> [   25.147110][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   25.147110][    T1] Call Trace:
> [   25.147110][    T1]  <TASK>
> [ 25.147110][ T1] dump_stack_lvl (lib/dump_stack.c:? lib/dump_stack.c:106)
> [ 25.147110][ T1] validate_chain (kernel/locking/lockdep.c:?)
> [ 25.147110][ T1] ? look_up_lock_class (kernel/locking/lockdep.c:926)
> [ 25.147110][ T1] ? mark_lock (arch/x86/include/asm/bitops.h:228 arch/x86/include/asm/bitops.h:240 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228 kernel/locking/lockdep.c:4655)
> [ 25.147110][ T1] __lock_acquire (kernel/locking/lockdep.c:?)
> [ 25.147110][ T1] lock_acquire (kernel/locking/lockdep.c:5753)
> [ 25.147110][ T1] ? check_forking (include/linux/spinlock.h:? lib/test_maple_tree.c:1854)
> [ 25.147110][ T1] _raw_spin_lock (include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:154)
> [ 25.147110][ T1] ? check_forking (include/linux/spinlock.h:? lib/test_maple_tree.c:1854)
> [ 25.147110][ T1] check_forking (include/linux/spinlock.h:? lib/test_maple_tree.c:1854)
> [ 25.147110][ T1] maple_tree_seed (lib/test_maple_tree.c:3583)
> [ 25.147110][ T1] do_one_initcall (init/main.c:1232)
> [ 25.147110][ T1] ? __cfi_maple_tree_seed (lib/test_maple_tree.c:3508)
> [ 25.147110][ T1] do_initcall_level (init/main.c:1293)
> [ 25.147110][ T1] do_initcalls (init/main.c:1307)
> [ 25.147110][ T1] kernel_init_freeable (init/main.c:1550)
> [ 25.147110][ T1] ? __cfi_kernel_init (init/main.c:1429)
> [ 25.147110][ T1] kernel_init (init/main.c:1439)
> [ 25.147110][ T1] ? __cfi_kernel_init (init/main.c:1429)
> [ 25.147110][ T1] ret_from_fork (arch/x86/kernel/process.c:151)
> [ 25.147110][ T1] ? __cfi_kernel_init (init/main.c:1429)
> [ 25.147110][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)
> [   25.147110][    T1]  </TASK>
> [   28.697241][   T32] clocksource_wdtest: --- Verify jiffies-like uncertainty margin.
> [   28.698316][   T32] clocksource: wdtest-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
> [   29.714980][   T32] clocksource_wdtest: --- Verify tsc-like uncertainty margin.
> [   29.716387][   T32] clocksource: wdtest-ktime: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> [   29.721896][   T32] clocksource_wdtest: --- tsc-like times: 1693478138832947444 - 1693478138832945950 = 1494.
> [   29.723570][   T32] clocksource_wdtest: --- Watchdog with 0x error injection, 2 retries.
> [   31.898906][   T32] clocksource_wdtest: --- Watchdog with 1x error injection, 2 retries.
> [   34.043415][   T32] clocksource_wdtest: --- Watchdog with 2x error injection, 2 retries, expect message.
> [   34.512462][    C0] clocksource: timekeeping watchdog on CPU0: kvm-clock retried 2 times before success
> [   36.169157][   T32] clocksource_wdtest: --- Watchdog with 3x error injection, 2 retries, expect clock skew.
> [   36.513464][    C0] clocksource: timekeeping watchdog on CPU0: wd-wdtest-ktime-wd excessive read-back delay of 1000880ns vs. limit of 125000ns, wd-wd read-back delay only 46ns, attempt 3, marking wdtest-ktime unstable
> [   36.516829][    C0] clocksource_wdtest: --- Marking wdtest-ktime unstable due to clocksource watchdog.
> [   38.412889][   T32] clocksource: wdtest-ktime: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> [   38.421249][   T32] clocksource_wdtest: --- Watchdog clock-value-fuzz error injection, expect clock skew and per-CPU mismatches.
> [   38.990462][    C0] clocksource: timekeeping watchdog on CPU0: Marking clocksource 'wdtest-ktime' as unstable because the skew is too large:
> [   38.992698][    C0] clocksource:                       'kvm-clock' wd_nsec: 479996388 wd_now: 9454aecf2 wd_last: 928aec30e mask: ffffffffffffffff
> [   38.994924][    C0] clocksource:                       'wdtest-ktime' cs_nsec: 679996638 cs_now: 17807167426ff864 cs_last: 1780716719e80b86 mask: ffffffffffffffff
> [   38.997374][    C0] clocksource:                       Clocksource 'wdtest-ktime' skewed 200000250 ns (200 ms) over watchdog 'kvm-clock' interval of 479996388 ns (479 ms)
> [   38.999919][    C0] clocksource:                       'kvm-clock' (not 'wdtest-ktime') is current clocksource.
> [   39.001696][    C0] clocksource_wdtest: --- Marking wdtest-ktime unstable due to clocksource watchdog.
> [   40.441815][   T32] clocksource: Not enough CPUs to check clocksource 'wdtest-ktime'.
> [   40.443303][   T32] clocksource_wdtest: --- Done with test.
> [  293.673815][    T1] swapper invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
> [  293.675628][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                TN 6.5.0-rc4-00632-g2730245bd6b1 #1
> [  293.677082][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  293.677082][    T1] Call Trace:
> [  293.677082][    T1]  <TASK>
> [ 293.677082][ T1] dump_stack_lvl (lib/dump_stack.c:107)
> [ 293.677082][ T1] dump_header (mm/oom_kill.c:?)
> [ 293.677082][ T1] out_of_memory (mm/oom_kill.c:1159)
> [ 293.677082][ T1] __alloc_pages_slowpath (mm/page_alloc.c:3372 mm/page_alloc.c:4132)
> [ 293.677082][ T1] __alloc_pages (mm/page_alloc.c:4469)
> [ 293.677082][ T1] alloc_slab_page (mm/slub.c:1866)
> [ 293.677082][ T1] new_slab (mm/slub.c:2017 mm/slub.c:2062)
> [ 293.677082][ T1] ? mas_alloc_nodes (lib/maple_tree.c:1282)
> [ 293.677082][ T1] ___slab_alloc (arch/x86/include/asm/preempt.h:80 mm/slub.c:3216)
> [ 293.677082][ T1] ? mas_alloc_nodes (lib/maple_tree.c:1282)
> [ 293.677082][ T1] kmem_cache_alloc_bulk (mm/slub.c:? mm/slub.c:4041)
> [ 293.677082][ T1] mas_alloc_nodes (lib/maple_tree.c:1282)
> [ 293.677082][ T1] mas_nomem (lib/maple_tree.c:?)
> [ 293.677082][ T1] mtree_store_range (lib/maple_tree.c:6191)
> [ 293.677082][ T1] check_dup_gaps (lib/test_maple_tree.c:2623)
> [ 293.677082][ T1] check_dup (lib/test_maple_tree.c:2707)
> [ 293.677082][ T1] maple_tree_seed (lib/test_maple_tree.c:3766)
> [ 293.677082][ T1] do_one_initcall (init/main.c:1232)
> [ 293.677082][ T1] ? __cfi_maple_tree_seed (lib/test_maple_tree.c:3508)
> [ 293.677082][ T1] do_initcall_level (init/main.c:1293)
> [ 293.677082][ T1] do_initcalls (init/main.c:1307)
> [ 293.677082][ T1] kernel_init_freeable (init/main.c:1550)
> [ 293.677082][ T1] ? __cfi_kernel_init (init/main.c:1429)
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20230831/202308312115.cad34fed-oliver.sang@intel.com
> 
> 
> 
