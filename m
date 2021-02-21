Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D24F3207F3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 02:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBUB1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Feb 2021 20:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhBUB1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Feb 2021 20:27:48 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CCFC061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Feb 2021 17:27:06 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id do6so23163454ejc.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Feb 2021 17:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=g2h9f/8a0IkAqxAEARcsR64Ig67aqQUO8tBj6+QC9HQ=;
        b=wDps8w2qaHlH4/UTMinMBIpfATR0EM1+xeOjC5KrTONIelvqQgrA+ocW0xWsZaAUNo
         euen5CqNGJCqsFSxTZ5i9/gmbQ9K6oFbgskzqmYN87AhiXEzR+Jinn0JXjxHVgQSmURf
         W9tgTopRC0pYLwtdzlbygZyqqWWJawA9G6qKEp/3eSLkduC33FxR2dNATMAyVulgPCmi
         Vaxy5iBl8jEW4Fw8FujZIPevF9t5etpVD6REjQR2oYv/xLj7DMg2vYj/XJ11nOKQBXfU
         aINJxZocJn7GvrdgH/bAgnjdc45SxRzk5T5NsuixqTEpPZoubPeSADAeeq/YH4WmJpXJ
         biag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=g2h9f/8a0IkAqxAEARcsR64Ig67aqQUO8tBj6+QC9HQ=;
        b=CSaeBZGGlHIAp0rs0RKcsXkJftM72k4vHX/8HJPVWGQ2/iCubvAy1xaE7n+36yHQPd
         dypW9vGGRc7WJ105SB6yDDxuggyP2DzQ5sSLB/kqSFEyhFurhViKPOhPvoiBCs54M3uf
         7MLOE2xitxm2554n3SiEwZSTb43N3SNPzJFu3otcDLrY398UT0GWbGAirsyppMoHPR1W
         kegm4BFvp9WM+KsKh0raVhlY0EE+pwOSc+1o9vVCQhi7AZO8qVvxIAsgu+2uftFzyGJL
         5BW4ScLUUxRu+Pmej64JxBINV/z6ulLtjB7kHXPLcNRkHw0K3hIdmaWVwHRm2jslEzJw
         rn2g==
X-Gm-Message-State: AOAM530c6pJai4xPMqoEls1uDtUJ6eHEjQz/of6qQLeiEB0UQCjFr5eE
        FxQ6x1e7RwMGWKc9iFbi9u2YNrIcBNUdZ6AI5u8WSxKtr6EiozII
X-Google-Smtp-Source: ABdhPJyk3sSbz6zbM4+wcENh7vdU24ElW3KN+2cpsNCHtGJQnXyaRF4FvGyE18LE/A8AglK3z6HPY/ZWqwfYXVPiLrI=
X-Received: by 2002:a17:906:12d2:: with SMTP id l18mr14563667ejb.308.1613870824898;
 Sat, 20 Feb 2021 17:27:04 -0800 (PST)
MIME-Version: 1.0
From:   Marios Makassikis <mmakassikis@freebox.fr>
Date:   Sun, 21 Feb 2021 02:26:54 +0100
Message-ID: <CAF6XXKWCwqSa72p+iQjg4QSBmAkX4Y5DxGrRR1tW1ar2uthd=w@mail.gmail.com>
Subject: [BUG] KASAN: global-out-of-bounds in __fuse_write_file_get.isra.0+0x81/0xe0
To:     linux-fsdevel@vger.kernel.org
Cc:     Marios Makassikis <mmakassikis@freebox.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I hope this is the correct list to report this bug I've been seeing.

Background: I am testing a kernel SMB server implementation
("ksmbd": https://github.com/cifsd-team/cifsd).

As part of my tests, I tried having a Windows client store a backup on a SMB
share that is backed by an NTFS formatted disk. In doing so, the kernel
reports a BUG and locks up (either immediately, or after a few minutes).

I can reliably reproduce the crash by rsync'ing a large directory (kernel git
tree for example) over ksmbd.

If I replace ksmbd with samba (which handles everything in userland), I can't
trigger the crash.

If I format the disk using ext4 or xfs I don't see any crashes either (whether
I use ksmbd or samba). This suggests there may be an issue in FUSE, or in
the in-kernel interaction between FUSE and KSMBD.

I have tried the latest stable kernel (5.10) as well as the LTS release (v5.4).
On the userland side, I am using:
 * libntfs-3g883 1:2017.3.23AR.3-3
 * ntfs-3g 1:2017.3.23AR.3-3
 * fuse 2.9.9-1+deb10u1
 * libfuse2 2.9.9-1+deb10u1

I have included two dmesg logs below from a KASAN enabled kernel, as
well as the addr2line output from a couple of symbols that appear in the
stacktrace.

I tried looking at what might be wrong in fuse_write_inode() but I came
up empty-handed. If anyone has a clue at what I might try to fix this,
let me know.

Regards,

Marios

$ ./scripts/faddr2line vmlinux __fuse_write_file_get.isra.0+0x81/0xe0
__fuse_write_file_get.isra.0+0x81/0xe0:
arch_atomic_fetch_add at arch/x86/include/asm/atomic.h:184
(inlined by) atomic_fetch_add_relaxed at
include/asm-generic/atomic-instrumented.h:143
(inlined by) __refcount_add at include/linux/refcount.h:193
(inlined by) __refcount_inc at include/linux/refcount.h:250
(inlined by) refcount_inc at include/linux/refcount.h:267
(inlined by) fuse_file_get at fs/fuse/file.c:99
(inlined by) __fuse_write_file_get at fs/fuse/file.c:1798

$ ./scripts/faddr2line vmlinux fuse_write_inode+0x10/0x40
fuse_write_inode+0x10/0x40:
fuse_write_inode at fs/fuse/file.c:1821

[  652.650120] ==================================================================
[  652.651166] BUG: KASAN: global-out-of-bounds in
__fuse_write_file_get.isra.0+0x81/0xe0
[  652.652157] Write of size 4 at addr ffffffffaab233f8 by task kworker/u2:0/7
[  652.653003]
[  652.653221] CPU: 0 PID: 7 Comm: kworker/u2:0 Not tainted 5.10.0+ #57
[  652.654014] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  652.655120] Workqueue: writeback wb_workfn (flush-8:17-fuseblk)
[  652.655874] Call Trace:
[  652.656206]  dump_stack+0x9a/0xcc
[  652.656634]  ? __fuse_write_file_get.isra.0+0x81/0xe0
[  652.657261]  print_address_description.constprop.0+0x1e/0x220
[  652.658079]  ? __fuse_write_file_get.isra.0+0x81/0xe0
[  652.658705]  ? __fuse_write_file_get.isra.0+0x81/0xe0
[  652.659347]  kasan_report.cold+0x37/0x7c
[  652.659869]  ? __fuse_write_file_get.isra.0+0x81/0xe0
[  652.660513]  check_memory_region+0x17c/0x1e0
[  652.661055]  __fuse_write_file_get.isra.0+0x81/0xe0
[  652.661670]  fuse_write_inode+0x10/0x40
[  652.662165]  __writeback_single_inode+0x7e0/0xbc0
[  652.662858]  writeback_sb_inodes+0x49c/0xb20
[  652.663504]  ? __writeback_single_inode+0xbc0/0xbc0
[  652.664120]  ? down_read_trylock+0x19a/0x370
[  652.664650]  ? trylock_super+0x16/0xc0
[  652.665139]  ? rcu_read_lock_sched_held+0xaf/0xe0
[  652.665751]  __writeback_inodes_wb+0xb7/0x200
[  652.666372]  wb_writeback+0x585/0x870
[  652.666911]  ? __writeback_inodes_wb+0x200/0x200
[  652.667481]  ? cpumask_next+0x16/0x20
[  652.667933]  ? get_nr_dirty_inodes+0xc1/0x160
[  652.668445]  wb_workfn+0x776/0xcd0
[  652.668873]  ? inode_wait_for_writeback+0x30/0x30
[  652.669434]  ? lock_acquire+0x1e3/0x9e0
[  652.669901]  ? process_one_work+0x6f2/0x1410
[  652.670561]  ? rcu_read_lock_sched_held+0xaf/0xe0
[  652.671237]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  652.671787]  ? lockdep_hardirqs_on_prepare+0x286/0x400
[  652.672415]  process_one_work+0x79c/0x1410
[  652.672930]  ? check_flags+0x60/0x60
[  652.673368]  ? pwq_dec_nr_in_flight+0x320/0x320
[  652.673926]  ? rwlock_bug.part.0+0x90/0x90
[  652.674553]  worker_thread+0x8f/0xc70
[  652.675019]  ? trace_hardirqs_off+0x93/0x100
[  652.675539]  ? process_one_work+0x1410/0x1410
[  652.676077]  kthread+0x32b/0x3f0
[  652.676478]  ? _raw_spin_unlock_irq+0x24/0x30
[  652.677004]  ? kthread_mod_delayed_work+0x180/0x180
[  652.677607]  ret_from_fork+0x1f/0x30
[  652.678079]
[  652.678281] The buggy address belongs to the variable:
[  652.678825]  fscontext_fops+0x358/0x9c0
[  652.679236]
[  652.679487] Memory state around the buggy address:
[  652.680093]  ffffffffaab23280: f9 f9 f9 f9 00 00 00 03 f9 f9 f9 f9
00 00 05 f9
[  652.680846]  ffffffffaab23300: f9 f9 f9 f9 00 04 f9 f9 f9 f9 f9 f9
00 00 00 00
[  652.681728] >ffffffffaab23380: 00 00 00 07 f9 f9 f9 f9 00 00 00 01
f9 f9 f9 f9
[  652.682924]                                                                 ^
[  652.684149]  ffffffffaab23400: 00 00 00 00 00 00 05 f9 f9 f9 f9 f9
00 00 06 f9
[  652.685336]  ffffffffaab23480: f9 f9 f9 f9 00 00 00 00 00 03 f9 f9
f9 f9 f9 f9
[  652.686530] ==================================================================
[  652.687710] Disabling lock debugging due to kernel taint
[  652.688625] BUG: unable to handle page fault for address: ffffffffaab233f8
[  652.689787] #PF: supervisor write access in kernel mode
[  652.690667] #PF: error_code(0x0003) - permissions violation
[  652.691626] PGD 59a29067 P4D 59a29067 PUD 59a2a063 PMD 8000000058e001e1
[  652.692773] Oops: 0003 [#1] SMP KASAN NOPTI
[  652.693461] CPU: 0 PID: 7 Comm: kworker/u2:0 Tainted: G    B
     5.10.0+ #57
[  652.694722] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  652.696187] Workqueue: writeback wb_workfn (flush-8:17-fuseblk)
[  652.697102] RIP: 0010:__fuse_write_file_get.isra.0+0x86/0xe0
[  652.698014] Code: c1 ea 03 80 3c 02 00 75 6e 48 8b 9b 10 04 00 00
be 04 00 00 00 4c 8d 6b f8 4c 8d 63 d0 4c 89 ef 8
[  652.700983] RSP: 0018:ffffc9000007f820 EFLAGS: 00010246
[  652.701799] RAX: 0000000000000001 RBX: ffffffffaab23400 RCX: 1ffffffff5868337
[  652.702957] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffffaa484559
[  652.704131] RBP: ffff888021cb8ba8 R08: 0000000000000000 R09: 0000000000000000
[  652.705271] R10: ffffffffaba89aa3 R11: fffffbfff5751354 R12: ffffffffaab233d0
[  652.706360] R13: ffffffffaab233f8 R14: ffff888021cb86a8 R15: ffff888021cb8708
[  652.707507] FS:  0000000000000000(0000) GS:ffff88806ce00000(0000)
knlGS:0000000000000000
[  652.708826] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  652.709754] CR2: ffffffffaab233f8 CR3: 0000000007610000 CR4: 00000000000006f0
[  652.710845] Call Trace:
[  652.711259]  fuse_write_inode+0x10/0x40
[  652.711921]  __writeback_single_inode+0x7e0/0xbc0
[  652.712708]  writeback_sb_inodes+0x49c/0xb20
[  652.713429]  ? __writeback_single_inode+0xbc0/0xbc0
[  652.714215]  ? down_read_trylock+0x19a/0x370
[  652.714865]  ? trylock_super+0x16/0xc0
[  652.715471]  ? rcu_read_lock_sched_held+0xaf/0xe0
[  652.716257]  __writeback_inodes_wb+0xb7/0x200
[  652.716990]  wb_writeback+0x585/0x870
[  652.717611]  ? __writeback_inodes_wb+0x200/0x200
[  652.718384]  ? cpumask_next+0x16/0x20
[  652.718967]  ? get_nr_dirty_inodes+0xc1/0x160
[  652.719653]  wb_workfn+0x776/0xcd0
[  652.720229]  ? inode_wait_for_writeback+0x30/0x30
[  652.720991]  ? lock_acquire+0x1e3/0x9e0
[  652.721639]  ? process_one_work+0x6f2/0x1410
[  652.722359]  ? rcu_read_lock_sched_held+0xaf/0xe0
[  652.723130]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  652.723844]  ? lockdep_hardirqs_on_prepare+0x286/0x400
[  652.724647]  process_one_work+0x79c/0x1410
[  652.725319]  ? check_flags+0x60/0x60
[  652.725924]  ? pwq_dec_nr_in_flight+0x320/0x320
[  652.726682]  ? rwlock_bug.part.0+0x90/0x90
[  652.727373]  worker_thread+0x8f/0xc70
[  652.727981]  ? trace_hardirqs_off+0x93/0x100
[  652.728634]  ? process_one_work+0x1410/0x1410
[  652.729326]  kthread+0x32b/0x3f0
[  652.729870]  ? _raw_spin_unlock_irq+0x24/0x30
[  652.730597]  ? kthread_mod_delayed_work+0x180/0x180
[  652.731411]  ret_from_fork+0x1f/0x30
[  652.732034] Modules linked in:
[  652.732551] CR2: ffffffffaab233f8
[  652.733066] ---[ end trace 79aef9476ece9373 ]---
[  652.733808] RIP: 0010:__fuse_write_file_get.isra.0+0x86/0xe0
[  652.734733] Code: c1 ea 03 80 3c 02 00 75 6e 48 8b 9b 10 04 00 00
be 04 00 00 00 4c 8d 6b f8 4c 8d 63 d0 4c 89 ef 8
[  652.737745] RSP: 0018:ffffc9000007f820 EFLAGS: 00010246
[  652.738583] RAX: 0000000000000001 RBX: ffffffffaab23400 RCX: 1ffffffff5868337
[  652.739699] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffffaa484559
[  652.740515] RBP: ffff888021cb8ba8 R08: 0000000000000000 R09: 0000000000000000
[  652.741330] R10: ffffffffaba89aa3 R11: fffffbfff5751354 R12: ffffffffaab233d0
[  652.742146] R13: ffffffffaab233f8 R14: ffff888021cb86a8 R15: ffff888021cb8708
[  652.742962] FS:  0000000000000000(0000) GS:ffff88806ce00000(0000)
knlGS:0000000000000000
[  652.743900] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  652.744564] CR2: ffffffffaab233f8 CR3: 0000000007610000 CR4: 00000000000006f0
[  652.745385] note: kworker/u2:0[7] exited with preempt_count 1
[  679.621562] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  679.622369]  (detected by 0, t=26002 jiffies, g=539609, q=13)
[  679.623070] rcu: All QSes seen, last rcu_sched kthread activity
26002 (4295346524-4295320522), jiffies_till_next_f0
[  679.624560] rcu: rcu_sched kthread starved for 26002 jiffies!
g539609 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
[  679.625819] rcu:     Unless rcu_sched kthread gets sufficient CPU
time, OOM is now expected behavior.
[  679.626931] rcu: RCU grace-period kthread stack dump:
[  679.627616] task:rcu_sched       state:R  running task
stack:29664 pid:   10 ppid:     2 flags:0x00004000
[  679.628885] Call Trace:
[  679.629204]  __schedule+0x863/0x1df0
[  679.629782]  ? pci_mmcfg_check_reserved+0x150/0x150
[  679.630390]  ? internal_add_timer+0xb4/0x100
[  679.630930]  ? calc_wheel_index+0x420/0x420
[  679.631446]  schedule+0xd0/0x270
[  679.631859]  schedule_timeout+0x352/0x7d0
[  679.632334]  ? usleep_range+0x110/0x110
[  679.632791]  ? _raw_spin_unlock_irqrestore+0x39/0x40
[  679.633443]  ? trace_hardirqs_on+0x1c/0x110
[  679.634057]  ? __next_timer_interrupt+0x160/0x160
[  679.634716]  ? __note_gp_changes+0x2e9/0xc20
[  679.635362]  rcu_gp_kthread+0xc05/0x2ac0
[  679.635898]  ? lock_downgrade+0x6c0/0x6c0
[  679.636531]  ? note_gp_changes+0x150/0x150
[  679.637136]  ? _raw_spin_unlock_irqrestore+0x39/0x40
[  679.637729]  ? trace_hardirqs_on+0x1c/0x110
[  679.638227]  ? note_gp_changes+0x150/0x150
[  679.638711]  kthread+0x32b/0x3f0
[  679.639103]  ? _raw_spin_unlock_irq+0x24/0x30
[  679.639754]  ? kthread_mod_delayed_work+0x180/0x180
[  679.640370]  ret_from_fork+0x1f/0x30
[  704.526547] watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
[kworker/0:74:413]
[  704.527470] Modules linked in:
[  704.527872] irq event stamp: 3870620
[  704.528343] hardirqs last  enabled at (3870619):
[<ffffffffaa600b9e>] asm_common_interrupt+0x1e/0x40
[  704.529440] hardirqs last disabled at (3870620):
[<ffffffffaa473fe7>] __schedule+0xea7/0x1df0
[  704.530468] softirqs last  enabled at (3870618):
[<ffffffffaa80055c>] __do_softirq+0x55c/0x902
[  704.531505] softirqs last disabled at (3870573):
[<ffffffffaa600f6f>] asm_call_irq_on_stack+0xf/0x20
[  704.532637] CPU: 0 PID: 413 Comm: kworker/0:74 Tainted: G    B D
       5.10.0+ #57
[  704.533567] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  704.534645] Workqueue: ksmbd-io handle_ksmbd_work
[  704.535217] RIP: 0010:queued_spin_lock_slowpath+0x28a/0x8e0
[  704.535983] Code: 00 85 c0 74 3d 8b 03 84 c0 74 37 48 b8 00 00 00
00 00 fc ff df 49 89 dd 48 89 dd 49 c1 ed 03 83 0
[  704.538130] RSP: 0018:ffffc90000967328 EFLAGS: 00000202
[  704.538744] RAX: 0000000000000101 RBX: ffff888021cb8ba8 RCX: ffffffffa8288b52
[  704.539580] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff888021cb8ba8
[  704.540423] RBP: 0000000000000003 R08: 0000000000000001 R09: ffffed1004397176
[  704.541239] R10: ffff888021cb8bab R11: ffffed1004397175 R12: 1ffff9200012ce67
[  704.542205] R13: ffffed1004397175 R14: ffffc900009674d8 R15: ffff888021cb8680
[  704.543046] FS:  0000000000000000(0000) GS:ffff88806ce00000(0000)
knlGS:0000000000000000
[  704.543999] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  704.544671] CR2: 000055b7ab2b0028 CR3: 0000000007610000 CR4: 00000000000006f0
[  704.545507] Call Trace:
[  704.545825]  ? lock_acquire+0x6a1/0x9e0
[  704.546293]  ? osq_unlock+0x1a0/0x1a0
[  704.546732]  ? lock_release+0x511/0x720
[  704.547192]  ? lock_acquire+0x6a1/0x9e0
[  704.547662]  ? check_flags+0x60/0x60
[  704.548095]  do_raw_spin_lock+0x1dd/0x290
[  704.548567]  ? rwlock_bug.part.0+0x90/0x90
[  704.549056]  ? _raw_spin_unlock+0x1f/0x30
[  704.549537]  fuse_dentry_revalidate+0x5b6/0x7c0
[  704.550117]  ? fuse_invalid_attr+0xc0/0xc0
[  704.550702]  ? lock_release+0x511/0x720
[  704.551228]  ? rwlock_bug.part.0+0x90/0x90
[  704.551796]  ? lockref_get_not_dead+0x4a/0x60
[  704.552394]  lookup_fast+0x47b/0x5d0
[  704.552892]  ? unlazy_child+0x370/0x370
[  704.553410]  ? lock_downgrade+0x6c0/0x6c0
[  704.553963]  walk_component+0xb6/0x5e0
[  704.554472]  ? handle_dots.part.0+0x1480/0x1480
[  704.555082]  ? set_root+0x29e/0x4f0
[  704.555497]  ? generic_permission+0x40/0x390
[  704.556008]  link_path_walk+0x4ed/0xa40
[  704.556472]  ? orc_find.part.0+0x330/0x330
[  704.556954]  ? walk_component+0x5e0/0x5e0
[  704.557429]  path_lookupat+0x119/0x3b0
[  704.557878]  filename_lookup+0x176/0x3a0
[  704.558344]  ? ret_from_fork+0x1f/0x30
[  704.558795]  ? may_linkat+0x180/0x180
[  704.559224]  ? _raw_spin_unlock_irqrestore+0x39/0x40
[  704.559820]  ? trace_hardirqs_on+0x1c/0x110
[  704.560316]  ? create_object+0x677/0xb30
[  704.560783]  ? __kasan_kmalloc.constprop.0+0xc2/0xd0
[  704.561365]  ? memcpy+0x39/0x60
[  704.561745]  ? getname_kernel+0xe2/0x330
[  704.562250]  ksmbd_vfs_fp_rename+0x131/0x270
[  704.562899]  ? ksmbd_vfs_link+0x1d0/0x1d0
[  704.563400]  ? dput+0x30/0x8c0
[  704.563840]  ? dput+0x1f0/0x8c0
[  704.564262]  ? do_raw_spin_unlock+0x54/0x250
[  704.564799]  smb2_set_info+0x1fac/0x31f0
[  704.565343]  ? smb2_echo+0x150/0x150
[  704.565799]  ? lock_release+0x511/0x720
[  704.566303]  ? memset+0x20/0x40
[  704.566765]  ? is_chained_smb2_message+0x617/0x1540
[  704.567435]  ? rwlock_bug.part.0+0x90/0x90
[  704.568013]  handle_ksmbd_work+0x316/0xfa0
[  704.568561]  process_one_work+0x79c/0x1410
[  704.569109]  ? check_flags+0x60/0x60
[  704.569538]  ? pwq_dec_nr_in_flight+0x320/0x320
[  704.570189]  ? rwlock_bug.part.0+0x90/0x90
[  704.571032]  worker_thread+0x8f/0xc70
[  704.571658]  ? trace_hardirqs_off+0x93/0x100
[  704.572308]  ? process_one_work+0x1410/0x1410
[  704.572907]  kthread+0x32b/0x3f0
[  704.573318]  ? _raw_spin_unlock_irq+0x24/0x30
[  704.573868]  ? kthread_mod_delayed_work+0x180/0x180
[  704.574448]  ret_from_fork+0x1f/0x30
[  732.526532] watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
[kworker/0:74:413]
[  732.527626] Modules linked in:
[  732.528103] irq event stamp: 3870620
[  732.528599] hardirqs last  enabled at (3870619):
[<ffffffffaa600b9e>] asm_common_interrupt+0x1e/0x40
[  732.529728] hardirqs last disabled at (3870620):
[<ffffffffaa473fe7>] __schedule+0xea7/0x1df0
[  732.530866] softirqs last  enabled at (3870618):
[<ffffffffaa80055c>] __do_softirq+0x55c/0x902
[  732.532019] softirqs last disabled at (3870573):
[<ffffffffaa600f6f>] asm_call_irq_on_stack+0xf/0x20
[  732.533266] CPU: 0 PID: 413 Comm: kworker/0:74 Tainted: G    B D
  L    5.10.0+ #57
[  732.534360] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  732.535708] Workqueue: ksmbd-io handle_ksmbd_work
[  732.536404] RIP: 0010:queued_spin_lock_slowpath+0x28a/0x8e0
[  732.537154] Code: 00 85 c0 74 3d 8b 03 84 c0 74 37 48 b8 00 00 00
00 00 fc ff df 49 89 dd 48 89 dd 49 c1 ed 03 83 0
[  732.539708] RSP: 0018:ffffc90000967328 EFLAGS: 00000202
[  732.540451] RAX: 0000000000000101 RBX: ffff888021cb8ba8 RCX: ffffffffa8288b52
[  732.541431] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff888021cb8ba8
[  732.542456] RBP: 0000000000000003 R08: 0000000000000001 R09: ffffed1004397176
[  732.543346] R10: ffff888021cb8bab R11: ffffed1004397175 R12: 1ffff9200012ce67
[  732.544618] R13: ffffed1004397175 R14: ffffc900009674d8 R15: ffff888021cb8680
[  732.545784] FS:  0000000000000000(0000) GS:ffff88806ce00000(0000)
knlGS:0000000000000000
[  732.546906] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  732.547706] CR2: 000055b7ab2b0028 CR3: 0000000007610000 CR4: 00000000000006f0
[  732.548686] Call Trace:
[  732.549054]  ? lock_acquire+0x6a1/0x9e0
[  732.549552]  ? osq_unlock+0x1a0/0x1a0
[  732.550062]  ? lock_release+0x511/0x720
[  732.550596]  ? lock_acquire+0x6a1/0x9e0
[  732.551121]  ? check_flags+0x60/0x60
[  732.551591]  do_raw_spin_lock+0x1dd/0x290
[  732.552143]  ? rwlock_bug.part.0+0x90/0x90
[  732.552719]  ? _raw_spin_unlock+0x1f/0x30
[  732.553306]  fuse_dentry_revalidate+0x5b6/0x7c0
[  732.553939]  ? fuse_invalid_attr+0xc0/0xc0
[  732.554513]  ? lock_release+0x511/0x720
[  732.555028]  ? rwlock_bug.part.0+0x90/0x90
[  732.555599]  ? lockref_get_not_dead+0x4a/0x60
[  732.556216]  lookup_fast+0x47b/0x5d0
[  732.556736]  ? unlazy_child+0x370/0x370
[  732.557258]  ? lock_downgrade+0x6c0/0x6c0
[  732.557797]  walk_component+0xb6/0x5e0
[  732.558275]  ? handle_dots.part.0+0x1480/0x1480
[  732.558874]  ? set_root+0x29e/0x4f0
[  732.559362]  ? generic_permission+0x40/0x390
[  732.559924]  link_path_walk+0x4ed/0xa40
[  732.560440]  ? orc_find.part.0+0x330/0x330
[  732.561113]  ? walk_component+0x5e0/0x5e0
[  732.561854]  path_lookupat+0x119/0x3b0
[  732.562424]  filename_lookup+0x176/0x3a0
[  732.562923]  ? ret_from_fork+0x1f/0x30
[  732.563379]  ? may_linkat+0x180/0x180
[  732.563830]  ? _raw_spin_unlock_irqrestore+0x39/0x40
[  732.564431]  ? trace_hardirqs_on+0x1c/0x110
[  732.564933]  ? create_object+0x677/0xb30
[  732.565400]  ? __kasan_kmalloc.constprop.0+0xc2/0xd0
[  732.565988]  ? memcpy+0x39/0x60
[  732.566369]  ? getname_kernel+0xe2/0x330
[  732.566849]  ksmbd_vfs_fp_rename+0x131/0x270
[  732.567383]  ? ksmbd_vfs_link+0x1d0/0x1d0
[  732.567867]  ? dput+0x30/0x8c0
[  732.568231]  ? dput+0x1f0/0x8c0
[  732.568608]  ? do_raw_spin_unlock+0x54/0x250
[  732.569138]  smb2_set_info+0x1fac/0x31f0
[  732.569616]  ? smb2_echo+0x150/0x150
[  732.570045]  ? lock_release+0x511/0x720
[  732.570498]  ? memset+0x20/0x40
[  732.570875]  ? is_chained_smb2_message+0x617/0x1540
[  732.571449]  ? rwlock_bug.part.0+0x90/0x90
[  732.571936]  handle_ksmbd_work+0x316/0xfa0
[  732.572425]  process_one_work+0x79c/0x1410
[  732.572932]  ? check_flags+0x60/0x60
[  732.573346]  ? pwq_dec_nr_in_flight+0x320/0x320
[  732.573855]  ? rwlock_bug.part.0+0x90/0x90
[  732.574325]  worker_thread+0x8f/0xc70
[  732.574794]  ? trace_hardirqs_off+0x93/0x100
[  732.575545]  ? process_one_work+0x1410/0x1410
[  732.576246]  kthread+0x32b/0x3f0
[  732.576781]  ? _raw_spin_unlock_irq+0x24/0x30
[  732.577307]  ? kthread_mod_delayed_work+0x180/0x180
[  732.577851]  ret_from_fork+0x1f/0x30


In a different run, KASAN reported a 'user-memory-access' rather than a
'global out-of-bounds' error, as seen below:

[ 9226.447921] ==================================================================
[ 9226.448560] BUG: KASAN: user-memory-access in
__fuse_write_file_get.isra.0+0x81/0xe0
[ 9226.448560] Write of size 4 at addr 0000000001e12cf8 by task
kworker/u2:0/1308
[ 9226.448560]
[ 9226.448560] CPU: 0 PID: 1308 Comm: kworker/u2:0 Not tainted 5.10.0+ #57
[ 9226.448560] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[ 9226.448560] Workqueue: writeback wb_workfn (flush-0:33)
[ 9226.448560] Call Trace:
[ 9226.448560]  dump_stack+0x9a/0xcc
[ 9226.448560]  ? __fuse_write_file_get.isra.0+0x81/0xe0
[ 9226.448560]  kasan_report.cold+0x6a/0x7c
[ 9226.448560]  ? __fuse_write_file_get.isra.0+0x81/0xe0
[ 9226.448560]  check_memory_region+0x17c/0x1e0
[ 9226.448560]  __fuse_write_file_get.isra.0+0x81/0xe0
[ 9226.448560]  fuse_write_inode+0x10/0x40
[ 9226.448560]  __writeback_single_inode+0x7e0/0xbc0
[ 9226.448560]  writeback_sb_inodes+0x49c/0xb20
[ 9226.448560]  ? __writeback_single_inode+0xbc0/0xbc0
[ 9226.448560]  ? down_read_trylock+0x19a/0x370
[ 9226.448560]  ? trylock_super+0x16/0xc0
[ 9226.448560]  ? rcu_read_lock_sched_held+0xaf/0xe0
[ 9226.448560]  __writeback_inodes_wb+0xb7/0x200
[ 9226.448560]  wb_writeback+0x585/0x870
[ 9226.448560]  ? __writeback_inodes_wb+0x200/0x200
[ 9226.448560]  ? cpumask_next+0x16/0x20
[ 9226.448560]  ? get_nr_dirty_inodes+0xc1/0x160
[ 9226.448560]  wb_workfn+0x776/0xcd0
[ 9226.448560]  ? inode_wait_for_writeback+0x30/0x30
[ 9226.448560]  ? lock_acquire+0x1e3/0x9e0
[ 9226.448560]  ? process_one_work+0x6f2/0x1410
[ 9226.448560]  ? rcu_read_lock_sched_held+0xaf/0xe0
[ 9226.448560]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 9226.448560]  ? lockdep_hardirqs_on_prepare+0x286/0x400
[ 9226.448560]  process_one_work+0x79c/0x1410
[ 9226.448560]  ? check_flags+0x60/0x60
[ 9226.448560]  ? pwq_dec_nr_in_flight+0x320/0x320
[ 9226.448560]  ? rwlock_bug.part.0+0x90/0x90
[ 9226.448560]  worker_thread+0x8f/0xc70
[ 9226.448560]  ? process_one_work+0x1410/0x1410
[ 9226.448560]  kthread+0x32b/0x3f0
[ 9226.448560]  ? _raw_spin_unlock_irq+0x24/0x30
[ 9226.448560]  ? kthread_mod_delayed_work+0x180/0x180
[ 9226.448560]  ret_from_fork+0x1f/0x30
[ 9226.448560] ==================================================================
[ 9226.448560] Disabling lock debugging due to kernel taint
[ 9226.475717] BUG: unable to handle page fault for address: 0000000001e12cf8
[ 9226.476540] #PF: supervisor write access in kernel mode
[ 9226.476665] #PF: error_code(0x0002) - not-present page
[ 9226.476665] PGD 0 P4D 0
[ 9226.476665] Oops: 0002 [#1] SMP KASAN NOPTI
[ 9226.476665] CPU: 0 PID: 1308 Comm: kworker/u2:0 Tainted: G    B
        5.10.0+ #57
[ 9226.476665] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[ 9226.476665] Workqueue: writeback wb_workfn (flush-0:33)
[ 9226.476665] RIP: 0010:__fuse_write_file_get.isra.0+0x86/0xe0
[ 9226.476665] Code: c1 ea 03 80 3c 02 00 75 6e 48 8b 9b 10 04 00 00
be 04 00 00 00 4c 8d 6b f8 4c 8d 63 d0 4c 89 ef 8
[ 9226.476665] RSP: 0018:ffffc90000457820 EFLAGS: 00010246
[ 9226.476665] RAX: 0000000000000001 RBX: 0000000001e12d00 RCX: 1ffffffff7b28337
[ 9226.476665] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffffbba84559
[ 9226.476665] RBP: ffff88806418a5a8 R08: 0000000000000000 R09: 0000000000000000
[ 9226.476665] R10: ffffffffbd089aa3 R11: fffffbfff7a11354 R12: 0000000001e12cd0
[ 9226.476665] R13: 0000000001e12cf8 R14: ffff88806418a0a8 R15: ffff88806418a108
[ 9226.476665] FS:  0000000000000000(0000) GS:ffff88806ce00000(0000)
knlGS:0000000000000000
[ 9226.476665] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9226.476665] CR2: 0000000001e12cf8 CR3: 000000000285a000 CR4: 00000000000006f0
[ 9226.476665] Call Trace:
[ 9226.476665]  fuse_write_inode+0x10/0x40
[ 9226.476665]  __writeback_single_inode+0x7e0/0xbc0
[ 9226.476665]  writeback_sb_inodes+0x49c/0xb20
[ 9226.476665]  ? __writeback_single_inode+0xbc0/0xbc0
[ 9226.476665]  ? down_read_trylock+0x19a/0x370
[ 9226.476665]  ? trylock_super+0x16/0xc0
[ 9226.476665]  ? rcu_read_lock_sched_held+0xaf/0xe0
[ 9226.476665]  __writeback_inodes_wb+0xb7/0x200
[ 9226.476665]  wb_writeback+0x585/0x870
[ 9226.476665]  ? __writeback_inodes_wb+0x200/0x200
[ 9226.476665]  ? cpumask_next+0x16/0x20
[ 9226.476665]  ? get_nr_dirty_inodes+0xc1/0x160
[ 9226.476665]  wb_workfn+0x776/0xcd0
[ 9226.476665]  ? inode_wait_for_writeback+0x30/0x30
[ 9226.476665]  ? lock_acquire+0x1e3/0x9e0
[ 9226.476665]  ? process_one_work+0x6f2/0x1410
[ 9226.476665]  ? rcu_read_lock_sched_held+0xaf/0xe0
[ 9226.476665]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 9226.476665]  ? lockdep_hardirqs_on_prepare+0x286/0x400
[ 9226.476665]  process_one_work+0x79c/0x1410
[ 9226.476665]  ? check_flags+0x60/0x60
[ 9226.476665]  ? pwq_dec_nr_in_flight+0x320/0x320
[ 9226.476665]  ? rwlock_bug.part.0+0x90/0x90
[ 9226.476665]  worker_thread+0x8f/0xc70
[ 9226.476665]  ? process_one_work+0x1410/0x1410
[ 9226.476665]  kthread+0x32b/0x3f0
[ 9226.476665]  ? _raw_spin_unlock_irq+0x24/0x30
[ 9226.476665]  ? kthread_mod_delayed_work+0x180/0x180
[ 9226.476665]  ret_from_fork+0x1f/0x30
[ 9226.476665] Modules linked in:
[ 9226.476665] CR2: 0000000001e12cf8
[ 9226.476665] ---[ end trace 8f64996c5041af07 ]---
[ 9226.476665] RIP: 0010:__fuse_write_file_get.isra.0+0x86/0xe0
[ 9226.476665] Code: c1 ea 03 80 3c 02 00 75 6e 48 8b 9b 10 04 00 00
be 04 00 00 00 4c 8d 6b f8 4c 8d 63 d0 4c 89 ef 8
[ 9226.476665] RSP: 0018:ffffc90000457820 EFLAGS: 00010246
[ 9226.476665] RAX: 0000000000000001 RBX: 0000000001e12d00 RCX: 1ffffffff7b28337
[ 9226.476665] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffffbba84559
[ 9226.476665] RBP: ffff88806418a5a8 R08: 0000000000000000 R09: 0000000000000000
[ 9226.476665] R10: ffffffffbd089aa3 R11: fffffbfff7a11354 R12: 0000000001e12cd0
[ 9226.476665] R13: 0000000001e12cf8 R14: ffff88806418a0a8 R15: ffff88806418a108
[ 9226.476665] FS:  0000000000000000(0000) GS:ffff88806ce00000(0000)
knlGS:0000000000000000
[ 9226.476665] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9226.476665] CR2: 0000000001e12cf8 CR3: 000000000285a000 CR4: 00000000000006f0
[ 9226.476665] note: kworker/u2:0[1308] exited with preempt_count 1
