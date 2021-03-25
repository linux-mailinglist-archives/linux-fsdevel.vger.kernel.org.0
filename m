Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9975A348DD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 11:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCYKRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 06:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCYKRT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:17:19 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F27AC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 03:17:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so849490wmj.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 03:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LQYU7AshaChrIv5/sVzoGBNv4W3iyRIKQFQCOFPAGsA=;
        b=aDRT36p1kgh5L+6KKg2GcwiS2kGmCefS5501HJavEe4puOS1g2TQ0VuHvw36qpETS8
         LGn2FqE3X73sM00xuU4VxjOnZDlS8V5fM5my0l10nMJMTRvOVQ9Q8JkQinW7Fp34nsoO
         PXHDCVEJCtopx6frWA5kbIRLpvVq4jocMQA60C3Fu50GBgIPSuKoPp68yrHJs4dp1xUc
         Dv7Yzn9q/OEj4x807SfvFVg5NACM0Fx9evH07uuLQtREde+JgW4MQO2Jm8QWtFEWDNSy
         LoLRoewqMJyyuAT8VD03wG5ggvKkE8Fv1fHc+7GS98JX3699ko0naxQhd9XUoRqy8aI/
         DMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LQYU7AshaChrIv5/sVzoGBNv4W3iyRIKQFQCOFPAGsA=;
        b=EwPdf+FCvxK4TUuwKgEVt82YyAr19bIyMGdGQfqyXUgrIaA7H2Y//VOBKLpu/61Ho/
         vaPDHNzLc3Ow4hRXIqQDzqYjLjElLDEvxB7LnYFPX7kqpHW25lvWKfPIReesAHKp1Gc8
         MUAgfdZplVHl6tBHoY9B0pevhN6kw//VRVl/kFm551xRmdQpsA02pO+KUstWVgs6iLFD
         xeYBhTC14Za1cUG4DrkAuk30HhhQjORnYTtYSYnyeYVE8TlGMR2c3rbPoUGDSANyVxNb
         yeQZPhwsIqviaJtC8ZyAKCpe6ZdC/ZQgT8xsCPMBGVUWY33CkvXm2O3gv5MS9xzvQjcu
         dR4g==
X-Gm-Message-State: AOAM533kQQ2EoDd3KlZTvfli4bMl4LmodbDzfNm2PAFVAWHckQxOSGJP
        Wk6IXsTEed9/SBjNR68XgQWhKw==
X-Google-Smtp-Source: ABdhPJzVfCraC/WgVtFV9wV6xcx3lYTzd3E+tTXoWs6K3Ut/rJgJlgIbqTjqqc2nUr8HNm0Gfnrk2Q==
X-Received: by 2002:a1c:4986:: with SMTP id w128mr7098059wma.37.1616667436411;
        Thu, 25 Mar 2021 03:17:16 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:248e:270b:f7ab:435d])
        by smtp.gmail.com with ESMTPSA id 1sm5847116wmj.2.2021.03.25.03.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 03:17:15 -0700 (PDT)
Date:   Thu, 25 Mar 2021 11:17:09 +0100
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org
Cc:     alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, glider@google.com,
        viro@zeniv.linux.org.uk, arnd@arndb.de, christian@brauner.io,
        dvyukov@google.com, jannh@google.com, axboe@kernel.dk,
        mascasa@google.com, pcc@google.com, irogers@google.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 01/11] perf: Rework perf_event_exit_event()
Message-ID: <YFxjJam0ErVmk99i@elver.google.com>
References: <20210324112503.623833-1-elver@google.com>
 <20210324112503.623833-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324112503.623833-2-elver@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 12:24PM +0100, Marco Elver wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Make perf_event_exit_event() more robust, such that we can use it from
> other contexts. Specifically the up and coming remove_on_exec.
> 
> For this to work we need to address a few issues. Remove_on_exec will
> not destroy the entire context, so we cannot rely on TASK_TOMBSTONE to
> disable event_function_call() and we thus have to use
> perf_remove_from_context().
> 
> When using perf_remove_from_context(), there's two races to consider.
> The first is against close(), where we can have concurrent tear-down
> of the event. The second is against child_list iteration, which should
> not find a half baked event.
> 
> To address this, teach perf_remove_from_context() to special case
> !ctx->is_active and about DETACH_CHILD.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v3:
> * New dependency for series:
>   https://lkml.kernel.org/r/YFn/I3aKF+TOjGcl@hirez.programming.kicks-ass.net
> ---

syzkaller found a crash with stack trace pointing at changes in this
patch. Can't tell if this is an old issue or introduced in this series.

It looks like task_pid_ptr() wants to access task_struct::signal, but
the task_struct pointer is NULL.

Any ideas?

general protection fault, probably for non-canonical address 0xdffffc0000000103: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000818-0x000000000000081f]
CPU: 2 PID: 15084 Comm: syz-executor.1 Not tainted 5.12.0-rc4+ #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
RIP: 0010:task_pid_ptr kernel/pid.c:325 [inline]
RIP: 0010:__task_pid_nr_ns+0x137/0x3e0 kernel/pid.c:500
Code: 8b 75 00 eb 08 e8 59 28 29 00 45 31 f6 31 ff 44 89 fe e8 5c 2c 29 00 45 85 ff 74 49 48 81 c3 20 08 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 aa 03 6d 00 48 8b 2b 44 89 fb bf
RSP: 0018:ffffc9000c76f6d0 EFLAGS: 00010007
RAX: 0000000000000103 RBX: 000000000000081f RCX: ffff8880717d8000
RDX: ffff8880717d8000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff814fe814 R09: fffffbfff1f296b1
R10: fffffbfff1f296b1 R11: 0000000000000000 R12: dffffc0000000000
R13: 1ffff1100e6dfc5c R14: ffff888057fba108 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802cf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcc3b05bc0 CR3: 0000000040ac0000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
PKRU: 55555554
Call Trace:
 perf_event_pid_type kernel/events/core.c:1412 [inline]
 perf_event_pid kernel/events/core.c:1421 [inline]
 perf_event_read_event kernel/events/core.c:7511 [inline]
 sync_child_event kernel/events/core.c:12521 [inline]
 perf_child_detach kernel/events/core.c:2223 [inline]
 __perf_remove_from_context+0x569/0xd30 kernel/events/core.c:2359
 perf_remove_from_context+0x19d/0x220 kernel/events/core.c:2395
 perf_event_exit_event+0x76/0x950 kernel/events/core.c:12559
 perf_event_exit_task_context kernel/events/core.c:12640 [inline]
 perf_event_exit_task+0x715/0xa40 kernel/events/core.c:12673
 do_exit+0x6c2/0x2290 kernel/exit.c:834
 do_group_exit+0x168/0x2d0 kernel/exit.c:922
 get_signal+0x1734/0x1ef0 kernel/signal.c:2779
 arch_do_signal_or_restart+0x41/0x620 arch/x86/kernel/signal.c:789
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0xac/0x1e0 kernel/entry/common.c:208
 irqentry_exit_to_user_mode+0x6/0x40 kernel/entry/common.c:314
 exc_general_protection+0x222/0x370 arch/x86/kernel/traps.c:530
 asm_exc_general_protection+0x1e/0x30 arch/x86/include/asm/idtentry.h:571
