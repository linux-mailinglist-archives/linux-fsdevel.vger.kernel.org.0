Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE05E333AA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 11:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhCJKrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 05:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbhCJKrO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:47:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC789C061761
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 02:47:13 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 7so22788523wrz.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 02:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nv5QS+xqtLkXO++/mzKLWDcejAQMpU5pZVYc5oKYtQM=;
        b=fKD7rorzkx/h3PZQkt4HuecFZGoHoUZmGxN1E4HU/sb85kDSZeL/FlVZns60xwBfA0
         T5GXUOs8tPEKhXHxMN4g+PS4Osv+prSNLp26j/IUVfeJCKyuIphay13kI3Z+q6GWmnPn
         qrHu9vABAMFmi1UhHQRFUa0BBh15sG1VPPFZFKtLgQGRpy7NLHL4hiL7UkKoME76VHGg
         IEC9dWTh838sh7eeebfPDNbfM06XQ7rbr1riruRtPVE4w4WQwS5p3Nh+46zFuOaT52QT
         qrhXNLxsP450cdJYC1cDMLC2siFH4HRuX5ahj5VdDCQyzURRxks1XPgZ6Tmvz7xExNTs
         oSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nv5QS+xqtLkXO++/mzKLWDcejAQMpU5pZVYc5oKYtQM=;
        b=OUrYxxnW/YF+5rbHlLS2WmttRq71lMfyBe8kbJBQIOSaA/bHmQ0vUGScMoLr9hQH6W
         D9MjiS7PL8mqvc2NMJwSB77/nAefiODfRQlkBA0Yw3s2ybBpXTA572J87W5O3Lj4CASc
         rfsD3Mh4hGT9AEpNIzuZ4HEHDOj6bXA/tZr3atzCCaceWtjL81vHU1xurCaF5I0yN4hD
         YuPvThDrMnW14lHlLpeN8VpVdBHQT5Gbr39pUGcw9MdNTTyPQkNnfuFLu/xCDg1GmoY0
         lF32g6pdlSyC8TO6YKfnx+XHpwW7K7wwg78gCD1TC/wFX/m30of5qzCum0/335IIODIG
         D2DA==
X-Gm-Message-State: AOAM532Ssx4ByM0UCLygJjVG8kx1UTlf8TaaWvyF7B/+IgTw3ZMV+D6t
        5SSBMrsofLW6sjyBR5JTTx9gDQ==
X-Google-Smtp-Source: ABdhPJwQ6lwYvDGqywKmw6JyLBSHTjldEtp9e0F3o5czKXRj1wSyBuFx8p75k5z1x4fpakyUpHbZ3w==
X-Received: by 2002:a5d:4743:: with SMTP id o3mr2919947wrs.108.1615373232211;
        Wed, 10 Mar 2021 02:47:12 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:e995:ac0b:b57c:49a4])
        by smtp.gmail.com with ESMTPSA id 3sm32253425wry.72.2021.03.10.02.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 02:47:11 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:47:05 +0100
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, alexander.shishkin@linux.intel.com,
        acme@kernel.org, mingo@redhat.com, jolsa@redhat.com,
        mark.rutland@arm.com, namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/8] perf/core: Add support for event removal on
 exec
Message-ID: <YEijqQBq4nx7pSiw@elver.google.com>
References: <20210310104139.679618-1-elver@google.com>
 <20210310104139.679618-4-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310104139.679618-4-elver@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 11:41AM +0100, Marco Elver wrote:
> Adds bit perf_event_attr::remove_on_exec, to support removing an event
> from a task on exec.
> 
> This option supports the case where an event is supposed to be
> process-wide only, and should not propagate beyond exec, to limit
> monitoring to the original process image only.

[...]

> +static void perf_remove_from_owner(struct perf_event *event);
> +static void perf_event_exit_event(struct perf_event *child_event,
> +				  struct perf_event_context *child_ctx,
> +				  struct task_struct *child);
> +
> +/*
> + * Removes all events from the current task that have been marked
> + * remove-on-exec, and feeds their values back to parent events.
> + */
> +static void perf_event_remove_on_exec(void)
> +{
> +	int ctxn;
> +
> +	for_each_task_context_nr(ctxn) {
> +		struct perf_event_context *ctx;
> +		struct perf_event *event, *next;
> +
> +		ctx = perf_pin_task_context(current, ctxn);
> +		if (!ctx)
> +			continue;
> +		mutex_lock(&ctx->mutex);
> +
> +		list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
> +			if (!event->attr.remove_on_exec)
> +				continue;
> +
> +			if (!is_kernel_event(event))
> +				perf_remove_from_owner(event);
> +			perf_remove_from_context(event, DETACH_GROUP);
> +			/*
> +			 * Remove the event and feed back its values to the
> +			 * parent event.
> +			 */
> +			perf_event_exit_event(event, ctx, current);
> +		}
> +		mutex_unlock(&ctx->mutex);
> +		put_ctx(ctx);
> +	}
> +}

Yikes; it seems this is somehow broken. I just decided to run the
remove_on_exec kselftest in a loop like so:

	for x in {1..10}; do ( tools/testing/selftests/perf_events/remove_on_exec & ) ; done

While the kselftest runs pass, I see a number of kernel warnings (below).

Any suggestions?

I'll go and try to debug this...

Thanks,
-- Marco

------ >8 ------


hardirqs last disabled at (4150): [<ffffffffa633219b>] sysvec_call_function_single+0xb/0xc0 arch/x86/kernel/smp.c:243
softirqs last  enabled at (3846): [<ffffffffa566f621>] invoke_softirq kernel/softirq.c:221 [inline]
softirqs last  enabled at (3846): [<ffffffffa566f621>] __irq_exit_rcu kernel/softirq.c:422 [inline]
softirqs last  enabled at (3846): [<ffffffffa566f621>] irq_exit_rcu+0xe1/0x120 kernel/softirq.c:434
softirqs last disabled at (3839): [<ffffffffa566f621>] invoke_softirq kernel/softirq.c:221 [inline]
softirqs last disabled at (3839): [<ffffffffa566f621>] __irq_exit_rcu kernel/softirq.c:422 [inline]
softirqs last disabled at (3839): [<ffffffffa566f621>] irq_exit_rcu+0xe1/0x120 kernel/softirq.c:434
---[ end trace 74c79be9940ec2d1 ]---
------------[ cut here ]------------
WARNING: CPU: 3 PID: 1369 at kernel/events/core.c:247 event_function+0xef/0x100 kernel/events/core.c:249
Modules linked in:
CPU: 3 PID: 1369 Comm: exe Tainted: G        W         5.12.0-rc2+ #19
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
RIP: 0010:event_function+0xef/0x100 kernel/events/core.c:247
Code: 5b 5d 41 5c 41 5d 41 5e 41 5f c3 65 8b 05 a5 79 88 5a 85 c0 0f 84 6e ff ff ff 0f 0b e9 67 ff ff ff 4c 39 f5 74 a7 0f 0b eb a3 <0f> 0b eb 9f 0f 0b eb 96 41 bd fd ff ff ff eb ac 90 48 8b 47 10 48
RSP: 0000:ffff980880158f70 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffff98088111fde0 RCX: 944f9e9405e234a1
RDX: ffff8a5d4d2ac340 RSI: ffffffffa6b4ccef RDI: ffff8a606fcf0c08
RBP: ffff8a606fcf0c00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: ffff8a5d4d2accb8 R12: 0000000000000000
R13: ffff8a5d4e6db800 R14: ffff8a5d46534a00 R15: ffff8a606fcf0c08
FS:  0000000000000000(0000) GS:ffff8a606fcc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd2b331e225 CR3: 00000001e0e22006 CR4: 0000000000770ee0
DR0: 0000564596006388 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
PKRU: 55555554
Call Trace:
 <IRQ>
 remote_function kernel/events/core.c:91 [inline]
 remote_function+0x44/0x50 kernel/events/core.c:71
 flush_smp_call_function_queue+0x13a/0x1d0 kernel/smp.c:395
 __sysvec_call_function_single+0x3e/0x1c0 arch/x86/kernel/smp.c:248
 sysvec_call_function_single+0x89/0xc0 arch/x86/kernel/smp.c:243
 </IRQ>
 asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:640
RIP: 0010:lock_page_memcg+0xc7/0x170 mm/memcontrol.c:2157
Code: 00 00 e8 6c ae e9 ff 48 c7 c6 d3 07 83 a5 58 4c 89 f7 e8 6c ab e9 ff 48 85 db 74 06 e8 22 e1 f3 ff fb 41 8b 84 24 00 0b 00 00 <85> c0 7e a7 4d 8d b4 24 70 06 00 00 4c 89 f7 e8 85 b2 b0 00 48 89
RSP: 0000:ffff980881bc7b38 EFLAGS: 00000206
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000006
RDX: 0000000000000000 RSI: ffffffffa6c1a6ed RDI: ffffffffa6b9ab37
RBP: ffffccff47891b80 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: ffff8a5d4d2accb8 R12: ffff8a5d403e9000
R13: ffffffffa58307d3 R14: ffff8a5d403e9688 R15: ffff8a5d47067128
 page_remove_rmap+0xc/0xb0 mm/rmap.c:1348
 zap_pte_range mm/memory.c:1276 [inline]
 zap_pmd_range mm/memory.c:1380 [inline]
 zap_pud_range mm/memory.c:1409 [inline]
 zap_p4d_range mm/memory.c:1430 [inline]
 unmap_page_range+0x612/0xb00 mm/memory.c:1451
 unmap_vmas+0xbe/0x150 mm/memory.c:1528
 exit_mmap+0x8f/0x1d0 mm/mmap.c:3218
 __mmput kernel/fork.c:1082 [inline]
 mmput+0x3c/0xe0 kernel/fork.c:1103
 exit_mm kernel/exit.c:501 [inline]
 do_exit+0x369/0xb60 kernel/exit.c:812
 do_group_exit+0x34/0xb0 kernel/exit.c:922
 get_signal+0x170/0xc80 kernel/signal.c:2775
 arch_do_signal_or_restart+0xea/0x740 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x10f/0x190 kernel/entry/common.c:208
 irqentry_exit_to_user_mode+0x5/0x30 kernel/entry/common.c:314
 asm_sysvec_reschedule_ipi+0x12/0x20 arch/x86/include/asm/idtentry.h:637
RIP: 0033:0x5598fc00409b
Code: Unable to access opcode bytes at RIP 0x5598fc004071.
RSP: 002b:00007ffe94151cf0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f6db39331b0
RDX: 0000000000000004 RSI: 00007ffe94151cfc RDI: 0000000000000001
RBP: 00007ffe94151da0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000059 R11: 0000000000000246 R12: 00005598fc0010d0
R13: 00007ffe94151ea0 R14: 0000000000000000 R15: 0000000000000000
irq event stamp: 4150
hardirqs last  enabled at (4149): [<ffffffffa583080e>] lock_page_memcg+0xbe/0x170 mm/memcontrol.c:2154
hardirqs last disabled at (4150): [<ffffffffa633219b>] sysvec_call_function_single+0xb/0xc0 arch/x86/kernel/smp.c:243
softirqs last  enabled at (3846): [<ffffffffa566f621>] invoke_softirq kernel/softirq.c:221 [inline]
softirqs last  enabled at (3846): [<ffffffffa566f621>] __irq_exit_rcu kernel/softirq.c:422 [inline]
softirqs last  enabled at (3846): [<ffffffffa566f621>] irq_exit_rcu+0xe1/0x120 kernel/softirq.c:434
softirqs last disabled at (3839): [<ffffffffa566f621>] invoke_softirq kernel/softirq.c:221 [inline]
softirqs last disabled at (3839): [<ffffffffa566f621>] __irq_exit_rcu kernel/softirq.c:422 [inline]
softirqs last disabled at (3839): [<ffffffffa566f621>] irq_exit_rcu+0xe1/0x120 kernel/softirq.c:434
---[ end trace 74c79be9940ec2d2 ]---
------------[ cut here ]------------
WARNING: CPU: 3 PID: 1369 at kernel/events/core.c:2253 event_sched_out+0x4c/0x200 kernel/events/core.c:2253
Modules linked in:
CPU: 3 PID: 1369 Comm: exe Tainted: G        W         5.12.0-rc2+ #19
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
RIP: 0010:event_sched_out+0x4c/0x200 kernel/events/core.c:2253
Code: 92 01 85 c9 75 12 83 bb a8 00 00 00 01 74 26 5b 5d 41 5c 41 5d 41 5e c3 48 8d 7d 20 be ff ff ff ff e8 18 cd b9 00 85 c0 75 dc <0f> 0b 83 bb a8 00 00 00 01 75 da 48 8b 53 28 48 8b 4b 20 48 8d 43
RSP: 0000:ffff980880158f18 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8a5d4e6db800 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffffa6b4ccef RDI: ffffffffa6b9ab37
RBP: ffff8a5d46534a00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: ffff8a5d4d2accb8 R12: ffff8a606fcf0c00
R13: ffff8a606fcf0c00 R14: ffff8a5d46534a00 R15: ffff8a606fcf0c08
FS:  0000000000000000(0000) GS:ffff8a606fcc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd2b331e225 CR3: 00000001e0e22006 CR4: 0000000000770ee0
DR0: 0000564596006388 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
PKRU: 55555554
Call Trace:
 <IRQ>
 __perf_remove_from_context+0x29/0xd0 kernel/events/core.c:2333
 event_function+0xab/0x100 kernel/events/core.c:252
 remote_function kernel/events/core.c:91 [inline]
 remote_function+0x44/0x50 kernel/events/core.c:71
 flush_smp_call_function_queue+0x13a/0x1d0 kernel/smp.c:395
 __sysvec_call_function_single+0x3e/0x1c0 arch/x86/kernel/smp.c:248
 sysvec_call_function_single+0x89/0xc0 arch/x86/kernel/smp.c:243
 </IRQ>
 asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:640
RIP: 0010:lock_page_memcg+0xc7/0x170 mm/memcontrol.c:2157
Code: 00 00 e8 6c ae e9 ff 48 c7 c6 d3 07 83 a5 58 4c 89 f7 e8 6c ab e9 ff 48 85 db 74 06 e8 22 e1 f3 ff fb 41 8b 84 24 00 0b 00 00 <85> c0 7e a7 4d 8d b4 24 70 06 00 00 4c 89 f7 e8 85 b2 b0 00 48 89
RSP: 0000:ffff980881bc7b38 EFLAGS: 00000206
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000006
RDX: 0000000000000000 RSI: ffffffffa6c1a6ed RDI: ffffffffa6b9ab37
RBP: ffffccff47891b80 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: ffff8a5d4d2accb8 R12: ffff8a5d403e9000
R13: ffffffffa58307d3 R14: ffff8a5d403e9688 R15: ffff8a5d47067128
 page_remove_rmap+0xc/0xb0 mm/rmap.c:1348
 zap_pte_range mm/memory.c:1276 [inline]
 zap_pmd_range mm/memory.c:1380 [inline]
 zap_pud_range mm/memory.c:1409 [inline]
 zap_p4d_range mm/memory.c:1430 [inline]
 unmap_page_range+0x612/0xb00 mm/memory.c:1451
 unmap_vmas+0xbe/0x150 mm/memory.c:1528
 exit_mmap+0x8f/0x1d0 mm/mmap.c:3218
 __mmput kernel/fork.c:1082 [inline]
 mmput+0x3c/0xe0 kernel/fork.c:1103
 exit_mm kernel/exit.c:501 [inline]
 do_exit+0x369/0xb60 kernel/exit.c:812
 do_group_exit+0x34/0xb0 kernel/exit.c:922
 get_signal+0x170/0xc80 kernel/signal.c:2775
 arch_do_signal_or_restart+0xea/0x740 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x10f/0x190 kernel/entry/common.c:208
 irqentry_exit_to_user_mode+0x5/0x30 kernel/entry/common.c:314
 asm_sysvec_reschedule_ipi+0x12/0x20 arch/x86/include/asm/idtentry.h:637
RIP: 0033:0x5598fc00409b
Code: Unable to access opcode bytes at RIP 0x5598fc004071.
RSP: 002b:00007ffe94151cf0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f6db39331b0
RDX: 0000000000000004 RSI: 00007ffe94151cfc RDI: 0000000000000001
RBP: 00007ffe94151da0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000059 R11: 0000000000000246 R12: 00005598fc0010d0
R13: 00007ffe94151ea0 R14: 0000000000000000 R15: 0000000000000000
irq event stamp: 4150
hardirqs last  enabled at (4149): [<ffffffffa583080e>] lock_page_memcg+0xbe/0x170 mm/memcontrol.c:2154
hardirqs last disabled at (4150): [<ffffffffa633219b>] sysvec_call_function_single+0xb/0xc0 arch/x86/kernel/smp.c:243
softirqs last  enabled at (3846): [<ffffffffa566f621>] invoke_softirq kernel/softirq.c:221 [inline]
softirqs last  enabled at (3846): [<ffffffffa566f621>] __irq_exit_rcu kernel/softirq.c:422 [inline]
softirqs last  enabled at (3846): [<ffffffffa566f621>] irq_exit_rcu+0xe1/0x120 kernel/softirq.c:434
softirqs last disabled at (3839): [<ffffffffa566f621>] invoke_softirq kernel/softirq.c:221 [inline]
softirqs last disabled at (3839): [<ffffffffa566f621>] __irq_exit_rcu kernel/softirq.c:422 [inline]
softirqs last disabled at (3839): [<ffffffffa566f621>] irq_exit_rcu+0xe1/0x120 kernel/softirq.c:434
---[ end trace 74c79be9940ec2d3 ]---
------------[ cut here ]------------
WARNING: CPU: 3 PID: 1369 at kernel/events/core.c:2152 perf_group_detach+0xe1/0x300 kernel/events/core.c:2152
Modules linked in:
CPU: 3 PID: 1369 Comm: exe Tainted: G        W         5.12.0-rc2+ #19
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
RIP: 0010:perf_group_detach+0xe1/0x300 kernel/events/core.c:2152
Code: 41 5c 41 5d 41 5e 41 5f e9 bc 54 ff ff 48 8b 87 20 02 00 00 be ff ff ff ff 48 8d 78 20 e8 27 88 b9 00 85 c0 0f 85 41 ff ff ff <0f> 0b e9 3a ff ff ff 48 8b 45 10 4c 8b 28 48 8d 58 f0 49 83 ed 10
RSP: 0000:ffff980880158f10 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8a5d4e6db800 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffffa6b4ccef RDI: ffffffffa6b9ab37
RBP: ffff8a5d4e6db800 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: ffff8a5d4d2accb8 R12: ffff8a606fcf0c00
R13: 0000000000000001 R14: ffff8a5d46534a00 R15: ffff8a606fcf0c08
FS:  0000000000000000(0000) GS:ffff8a606fcc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd2b331e225 CR3: 00000001e0e22006 CR4: 0000000000770ee0
DR0: 0000564596006388 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
PKRU: 55555554
Call Trace:
 <IRQ>
 __perf_remove_from_context+0x91/0xd0 kernel/events/core.c:2335
 event_function+0xab/0x100 kernel/events/core.c:252
 remote_function kernel/events/core.c:91 [inline]
 remote_function+0x44/0x50 kernel/events/core.c:71
 flush_smp_call_function_queue+0x13a/0x1d0 kernel/smp.c:395
 __sysvec_call_function_single+0x3e/0x1c0 arch/x86/kernel/smp.c:248
 sysvec_call_function_single+0x89/0xc0 arch/x86/kernel/smp.c:243
 </IRQ>
 asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:640
RIP: 0010:lock_page_memcg+0xc7/0x170 mm/memcontrol.c:2157
Code: 00 00 e8 6c ae e9 ff 48 c7 c6 d3 07 83 a5 58 4c 89 f7 e8 6c ab e9 ff 48 85 db 74 06 e8 22 e1 f3 ff fb 41 8b 84 24 00 0b 00 00 <85> c0 7e a7 4d 8d b4 24 70 06 00 00 4c 89 f7 e8 85 b2 b0 00 48 89
RSP: 0000:ffff980881bc7b38 EFLAGS: 00000206
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000006
RDX: 0000000000000000 RSI: ffffffffa6c1a6ed RDI: ffffffffa6b9ab37
RBP: ffffccff47891b80 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: ffff8a5d4d2accb8 R12: ffff8a5d403e9000
R13: ffffffffa58307d3 R14: ffff8a5d403e9688 R15: ffff8a5d47067128
 page_remove_rmap+0xc/0xb0 mm/rmap.c:1348
 zap_pte_range mm/memory.c:1276 [inline]
 zap_pmd_range mm/memory.c:1380 [inline]
 zap_pud_range mm/memory.c:1409 [inline]
 zap_p4d_range mm/memory.c:1430 [inline]
 unmap_page_range+0x612/0xb00 mm/memory.c:1451
 unmap_vmas+0xbe/0x150 mm/memory.c:1528
 exit_mmap+0x8f/0x1d0 mm/mmap.c:3218
 __mmput kernel/fork.c:1082 [inline]
 mmput+0x3c/0xe0 kernel/fork.c:1103
 exit_mm kernel/exit.c:501 [inline]
 do_exit+0x369/0xb60 kernel/exit.c:812
 do_group_exit+0x34/0xb0 kernel/exit.c:922
 get_signal+0x170/0xc80 kernel/signal.c:2775
 arch_do_signal_or_restart+0xea/0x740 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x10f/0x190 kernel/entry/common.c:208
 irqentry_exit_to_user_mode+0x5/0x30 kernel/entry/common.c:314
 asm_sysvec_reschedule_ipi+0x12/0x20 arch/x86/include/asm/idtentry.h:637
RIP: 0033:0x5598fc00409b
Code: Unable to access opcode bytes at RIP 0x5598fc004071.
RSP: 002b:00007ffe94151cf0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f6db39331b0
RDX: 0000000000000004 RSI: 00007ffe94151cfc RDI: 0000000000000001
RBP: 00007ffe94151da0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000059 R11: 0000000000000246 R12: 00005598fc0010d0
R13: 00007ffe94151ea0 R14: 0000000000000000 R15: 0000000000000000
irq event stamp: 4150
hardirqs last  enabled at (4149): [<ffffffffa583080e>] lock_page_memcg+0xbe/0x170 mm/memcontrol.c:2154
hardirqs last disabled at (4150): [<ffffffffa633219b>] sysvec_call_function_single+0xb/0xc0 arch/x86/kernel/smp.c:243
softirqs last  enabled at (3846): [<ffffffffa566f621>] invoke_softirq kernel/softirq.c:221 [inline]
softirqs last  enabled at (3846): [<ffffffffa566f621>] __irq_exit_rcu kernel/softirq.c:422 [inline]
softirqs last  enabled at (3846): [<ffffffffa566f621>] irq_exit_rcu+0xe1/0x120 kernel/softirq.c:434
softirqs last disabled at (3839): [<ffffffffa566f621>] invoke_softirq kernel/softirq.c:221 [inline]
softirqs last disabled at (3839): [<ffffffffa566f621>] __irq_exit_rcu kernel/softirq.c:422 [inline]
softirqs last disabled at (3839): [<ffffffffa566f621>] irq_exit_rcu+0xe1/0x120 kernel/softirq.c:434
---[ end trace 74c79be9940ec2d4 ]---
------------[ cut here ]------------
WARNING: CPU: 3 PID: 1369 at kernel/events/core.c:1993 list_del_event+0xaf/0x110 kernel/events/core.c:1993
Modules linked in:
CPU: 3 PID: 1369 Comm: exe Tainted: G        W         5.12.0-rc2+ #19
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
RIP: 0010:list_del_event+0xaf/0x110 kernel/events/core.c:1993
Code: 00 00 01 eb ba be ff ff ff ff 48 89 ef e8 b9 fe ff ff eb db 48 8d 7b 20 be ff ff ff ff e8 39 1d ba 00 85 c0 0f 85 72 ff ff ff <0f> 0b e9 6b ff ff ff 48 8d 83 e8 00 00 00 f6 85 08 01 00 00 04 48
RSP: 0000:ffff980880158f28 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8a5d46534a00 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffffa6b4ccef RDI: ffffffffa6b9ab37
RBP: ffff8a5d4e6db800 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: ffff8a5d4d2accb8 R12: ffff8a606fcf0c00
R13: 0000000000000001 R14: ffff8a5d46534a00 R15: ffff8a606fcf0c08
FS:  0000000000000000(0000) GS:ffff8a606fcc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd2b331e225 CR3: 00000001e0e22006 CR4: 0000000000770ee0
DR0: 0000564596006388 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
PKRU: 55555554
Call Trace:
 <IRQ>
 __perf_remove_from_context+0x3a/0xd0 kernel/events/core.c:2336
 event_function+0xab/0x100 kernel/events/core.c:252
 remote_function kernel/events/core.c:91 [inline]
 remote_function+0x44/0x50 kernel/events/core.c:71
 flush_smp_call_function_queue+0x13a/0x1d0 kernel/smp.c:395
 __sysvec_call_function_single+0x3e/0x1c0 arch/x86/kernel/smp.c:248
 sysvec_call_function_single+0x89/0xc0 arch/x86/kernel/smp.c:243
 </IRQ>
 asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:640
RIP: 0010:lock_page_memcg+0xc7/0x170 mm/memcontrol.c:2157
Code: 00 00 e8 6c ae e9 ff 48 c7 c6 d3 07 83 a5 58 4c 89 f7 e8 6c ab e9 ff 48 85 db 74 06 e8 22 e1 f3 ff fb 41 8b 84 24 00 0b 00 00 <85> c0 7e a7 4d 8d b4 24 70 06 00 00 4c 89 f7 e8 85 b2 b0 00 48 89
RSP: 0000:ffff980881bc7b38 EFLAGS: 00000206
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000006
RDX: 0000000000000000 RSI: ffffffffa6c1a6ed RDI: ffffffffa6b9ab37
RBP: ffffccff47891b80 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: ffff8a5d4d2accb8 R12: ffff8a5d403e9000
R13: ffffffffa58307d3 R14: ffff8a5d403e9688 R15: ffff8a5d47067128
 page_remove_rmap+0xc/0xb0 mm/rmap.c:1348
 zap_pte_range mm/memory.c:1276 [inline]
 zap_pmd_range mm/memory.c:1380 [inline]
 zap_pud_range mm/memory.c:1409 [inline]
 zap_p4d_range mm/memory.c:1430 [inline]
 unmap_page_range+0x612/0xb00 mm/memory.c:1451
 unmap_vmas+0xbe/0x150 mm/memory.c:1528
 exit_mmap+0x8f/0x1d0 mm/mmap.c:3218
 __mmput kernel/fork.c:1082 [inline]
 mmput+0x3c/0xe0 kernel/fork.c:1103
 exit_mm kernel/exit.c:501 [inline]
 do_exit+0x369/0xb60 kernel/exit.c:812
 do_group_exit+0x34/0xb0 kernel/exit.c:922
 get_signal+0x170/0xc80 kernel/signal.c:2775
 arch_do_signal_or_restart+0xea/0x740 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x10f/0x190 kernel/entry/common.c:208
 irqentry_exit_to_user_mode+0x5/0x30 kernel/entry/common.c:314
 asm_sysvec_reschedule_ipi+0x12/0x20 arch/x86/include/asm/idtentry.h:637
RIP: 0033:0x5598fc00409b
Code: Unable to access opcode bytes at RIP 0x5598fc004071.
RSP: 002b:00007ffe94151cf0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f6db39331b0
RDX: 0000000000000004 RSI: 00007ffe94151cfc RDI: 0000000000000001
RBP: 00007ffe94151da0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000059 R11: 0000000000000246 R12: 00005598fc0010d0
R13: 00007ffe94151ea0 R14: 0000000000000000 R15: 0000000000000000
irq event stamp: 4150
hardirqs last  enabled at (4149): [<ffffffffa583080e>] lock_page_memcg+0xbe/0x170 mm/memcontrol.c:2154
hardirqs last disabled at (4150): [<ffffffffa633219b>] sysvec_call_function_single+0xb/0xc0 arch/x86/kernel/smp.c:243
softirqs last  enabled at (3846): [<ffffffffa566f621>] invoke_softirq kernel/softirq.c:221 [inline]
softirqs last  enabled at (3846): [<ffffffffa566f621>] __irq_exit_rcu kernel/softirq.c:422 [inline]
softirqs last  enabled at (3846): [<ffffffffa566f621>] irq_exit_rcu+0xe1/0x120 kernel/softirq.c:434
softirqs last disabled at (3839): [<ffffffffa566f621>] invoke_softirq kernel/softirq.c:221 [inline]
softirqs last disabled at (3839): [<ffffffffa566f621>] __irq_exit_rcu kernel/softirq.c:422 [inline]
softirqs last disabled at (3839): [<ffffffffa566f621>] irq_exit_rcu+0xe1/0x120 kernel/softirq.c:434
---[ end trace 74c79be9940ec2d5 ]---
