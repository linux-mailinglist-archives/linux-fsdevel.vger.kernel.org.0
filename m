Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F46D71FF66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 12:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbjFBKeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 06:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbjFBKeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:34:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2202D76;
        Fri,  2 Jun 2023 03:32:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685701891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=B7bPk3pUh4JwxyV+9d/1pqiC0xFJGdtFW+ceWYcdSZ4=;
        b=0MrXZZY7q1FDgx0xxjf84245j6AlVlXaRHDpThHi7XbnW3x1E6EX4Gu9nVGq7G9V4KD/nk
        eeBqEmepdfpOwimYS7N/P2rN9r7WHzLiJPMawzDIhtpqknX7/cyWsH75WPS0fgENR7zyeg
        4Bkn0B+KDs9/sK23Uv/1RH79ljXyYTmEZPAAbX2y00lNx3F7eXRCCBLvZQdGCbWhgI1UKb
        hSBHj+iMEwvvkBBqF+i9orKF4uvJWpB1hlp7o2LJ9bcykX1sHsAhRVqaXdfxSE7V6Nm4gw
        vu16Ke9dM2A6msNKc4Qbsn2DwMVTG3QTTKK7CP6Ps+VcS3cCuyUM2o6RpigorQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685701891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=B7bPk3pUh4JwxyV+9d/1pqiC0xFJGdtFW+ceWYcdSZ4=;
        b=4hXm0PteC8c+7Dh4r9Kak52TzCeqHsVIqz8eREdd7uJ9j2+eOsjiyvqrJJXQ5dxRHL6H42
        GdZ9IDogdyMFlgBw==
To:     syzbot <syzbot+5444b0cc48f4e1939d72@syzkaller.appspotmail.com>,
        frederic@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [reiserfs?] general protection fault in
 account_system_index_time (3)
In-Reply-To: <00000000000073d32c05fd1d4a6b@google.com>
Date:   Fri, 02 Jun 2023 12:31:31 +0200
Message-ID: <87zg5i88ak.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01 2023 at 20:38, syzbot wrote:
> general protection fault, probably for non-canonical address 0xdffffc0040000033: 0000 [#1] PREEMPT SMP KASAN
> KASAN: probably user-memory-access in range [0x0000000200000198-0x000000020000019f]
> CPU: 1 PID: 262216 Comm:  Not tainted 6.4.0-rc2-next-20230515-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
> RIP: 0010:get_running_cputimer include/linux/sched/cputime.h:79 [inline]
> RIP: 0010:account_group_system_time include/linux/sched/cputime.h:143 [inline]
> RIP: 0010:account_system_index_time+0x86/0x2f0 kernel/sched/cputime.c:173
> Code: 63 02 00 00 48 8b 9d f8 08 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d bb 98 01 00 00 4c 8d b3 38 01 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e e7 01 00 00 8b 83 98 01 00 00
> RSP: 0018:ffffc900001e0da0 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: 0000000200000001 RCX: 1ffffffff1827d41
> RDX: 0000000040000033 RSI: 000000000097fff6 RDI: 0000000200000199
> RBP: ffff88807638bb80 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: ffffffffffffffff R12: 000000000097fff6
> R13: 0000000000000002 R14: 0000000200000139 R15: ffffffff817770e0
> FS:  00005555556c1300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffca0efd000 CR3: 0000000019395000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  update_process_times+0x26/0x1a0 kernel/time/timer.c:2069
>  tick_sched_handle+0x8e/0x170 kernel/time/tick-sched.c:243
>  tick_sched_timer+0xee/0x110 kernel/time/tick-sched.c:1481
>  __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
>  __hrtimer_run_queues+0x1c0/0xa30 kernel/time/hrtimer.c:1749
>  hrtimer_interrupt+0x320/0x7b0 kernel/time/hrtimer.c:1811
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1095 [inline]
>  __sysvec_apic_timer_interrupt+0x14a/0x430 arch/x86/kernel/apic/apic.c:1112
>  sysvec_apic_timer_interrupt+0x92/0xc0 arch/x86/kernel/apic/apic.c:1106
>  </IRQ>

> RSP: 0018:ffffc900001e0da0 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: 0000000200000001 RCX: 1ffffffff1827d41
> RDX: 0000000040000033 RSI: 000000000097fff6 RDI: 0000000200000199
> RBP: ffff88807638bb80 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: ffffffffffffffff R12: 000000000097fff6
> R13: 0000000000000002 R14: 0000000200000139 R15: ffffffff817770e0
> FS:  00005555556c1300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffca0efd000 CR3: 0000000019395000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

> Code disassembly (best guess):

I built with that config and stared at the disassembly.

RBP contains the task pointer, which looks valid RBP: ffff88807638bb80

>    4:	48 8b 9d f8 08 00 00 	mov    0x8f8(%rbp),%rbx

struct signal_struct *     signal;               /*  2296     8 */

2296 == 0x8f8

So this loads tsk->signal into RBX

      RBX: 0000000200000001

which is clearly not a valid signal_struct pointer...

The rest is a consequence of this.

>    b:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   12:	fc ff df
>   15:	48 8d bb 98 01 00 00 	lea    0x198(%rbx),%rdi
>   1c:	4c 8d b3 38 01 00 00 	lea    0x138(%rbx),%r14
>   23:	48 89 fa             	mov    %rdi,%rdx
>   26:	48 c1 ea 03          	shr    $0x3,%rdx
> * 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
>   2e:	84 c0                	test   %al,%al
>   30:	74 08                	je     0x3a
>   32:	3c 03                	cmp    $0x3,%al
>   34:	0f 8e e7 01 00 00    	jle    0x221
>   3a:	8b 83 98 01 00 00    	mov    0x198(%rbx),%eax

Looks like good old memory corruption. tsk->comm looks weird too:

> CPU: 1 PID: 262216 Comm:  Not tainted 6.4.0-rc2-next-20230515-syzkaller #0

tsk>comm is at offset 0x898 so close enough to the corrupted
tsk->signal.

I let the reiserfs wizards decode the root cause :)

Thanks,

        tglx
