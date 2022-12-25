Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A72655CD9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Dec 2022 11:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLYK2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Dec 2022 05:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYK2j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Dec 2022 05:28:39 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A05B93
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Dec 2022 02:28:35 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id z19-20020a921a53000000b0030b90211df1so5377215ill.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Dec 2022 02:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aqa+G0DpgeC4srfux6TxX0ntzkNkWgWwVjBhPxfNx/4=;
        b=Xf7xmZH4r7MYcSl5CpzpyQJ6t+aX365IVvE8h+NrgAf8XrV0OnJZtUSD1k6zkGXHDI
         26AhzZ/Iwzd1lvjVP6gIDbTQLmH0NPl0rH1r6ybN9uuxOqAUqMJwuEc8neVGwCQKZLIB
         X2jdhnaoXW4OaTmw2DcvIWBFou2tAnFxYyx2cGJXN3fCY6g6/ihuxNrJT6iTF9OuuZE5
         ea6aVbdge0AiMYH5t3sXydg7jsVfqDdA23AR68QedtL+Wruzkt+hx/0BtN3mNQT7d+Tc
         NGsDpSaKStAHKwCp8db3r322cSwHoXIx119OsP7Y/MxvESyT/yTct1URrE2cypGcHQZP
         1Gwg==
X-Gm-Message-State: AFqh2koGn0xmxdZ5VL+1eu1HerIh7rYuf01nRYZx36u2Eg/XVckf9yJh
        0eBJEyvcyqm7pK4PXaUAerHneNNfuRoWsPOviTk5DEXnQPPx
X-Google-Smtp-Source: AMrXdXuIcwHw7Vze9MGtZgyBJ2BBhtq5upPWJUNKw0Gdq3bluFWJssagpMNPFzo5bXE/oz1ktkU0Tk0I2/XWpc04povOCdY00pTi
MIME-Version: 1.0
X-Received: by 2002:a02:a513:0:b0:38a:1e93:c32f with SMTP id
 e19-20020a02a513000000b0038a1e93c32fmr927638jam.212.1671964114606; Sun, 25
 Dec 2022 02:28:34 -0800 (PST)
Date:   Sun, 25 Dec 2022 02:28:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020e31705f0a47bfa@google.com>
Subject: [syzbot] [hfs?] possible deadlock in list_lru_add
From:   syzbot <syzbot+ed5464bd00ae9d8b1995@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1232731b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=ed5464bd00ae9d8b1995
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13772e30480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1707e56f880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/784989852485/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed5464bd00ae9d8b1995@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
========================================================
WARNING: possible irq lock inversion dependency detected
6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0 Not tainted
--------------------------------------------------------
syz-executor305/3074 just changed the state of lock:
ffff0000cae7ad18 (tmpmask_lock){+...}-{2:2}, at: spin_lock include/linux/spinlock.h:350 [inline]
ffff0000cae7ad18 (tmpmask_lock){+...}-{2:2}, at: list_lru_add+0x78/0x1f4 mm/list_lru.c:126
but this lock was taken by another, HARDIRQ-safe lock in the past:
 (&irq_desc_lock_class){-.-.}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
Chain exists of:
  &irq_desc_lock_class --> tmp_mask_lock --> tmpmask_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tmpmask_lock);
                               local_irq_disable();
                               lock(&irq_desc_lock_class);
                               lock(tmp_mask_lock);
  <Interrupt>
    lock(&irq_desc_lock_class);

 *** DEADLOCK ***

1 lock held by syz-executor305/3074:
 #0: ffff0000c6d72f48 (&dentry->d_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:350 [inline]
 #0: ffff0000c6d72f48 (&dentry->d_lock){+.+.}-{2:2}, at: fast_dput fs/dcache.c:789 [inline]
 #0: ffff0000c6d72f48 (&dentry->d_lock){+.+.}-{2:2}, at: dput+0x1d4/0x2e0 fs/dcache.c:900

the shortest dependencies between 2nd lock and 1st lock:
  -> (&irq_desc_lock_class){-.-.}-{2:2} {
     IN-HARDIRQ-W at:
                        lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
                        __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                        _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
                        handle_fasteoi_irq+0x38/0x324 kernel/irq/chip.c:693
                        generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
                        handle_irq_desc kernel/irq/irqdesc.c:648 [inline]
                        generic_handle_domain_irq+0x4c/0x6c kernel/irq/irqdesc.c:704
                        __gic_handle_irq drivers/irqchip/irq-gic-v3.c:695 [inline]
                        __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:746 [inline]
                        gic_handle_irq+0x78/0x1b4 drivers/irqchip/irq-gic-v3.c:790
                        call_on_irq_stack+0x2c/0x54 arch/arm64/kernel/entry.S:892
                        do_interrupt_handler+0x7c/0xc0 arch/arm64/kernel/entry-common.c:274
                        __el1_irq arch/arm64/kernel/entry-common.c:471 [inline]
                        el1_interrupt+0x34/0x68 arch/arm64/kernel/entry-common.c:486
                        el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:491
                        el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:580
                        arch_local_irq_restore arch/arm64/include/asm/irqflags.h:122 [inline]
                        __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
                        _raw_spin_unlock_irqrestore+0x58/0x8c kernel/locking/spinlock.c:194
                        task_rq_unlock kernel/sched/sched.h:1621 [inline]
                        wake_up_new_task+0x26c/0x340 kernel/sched/core.c:4720
                        kernel_clone+0x290/0x380 kernel/fork.c:2702
                        user_mode_thread+0x74/0xa4 kernel/fork.c:2747
                        call_usermodehelper_exec_work+0x44/0x17c kernel/umh.c:175
                        process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
                        worker_thread+0x340/0x610 kernel/workqueue.c:2436
                        kthread+0x12c/0x158 kernel/kthread.c:376
                        ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
     IN-SOFTIRQ-W at:
                        lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
                        __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                        _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
                        handle_fasteoi_irq+0x38/0x324 kernel/irq/chip.c:693
                        generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
                        handle_irq_desc kernel/irq/irqdesc.c:648 [inline]
                        generic_handle_domain_irq+0x4c/0x6c kernel/irq/irqdesc.c:704
                        __gic_handle_irq drivers/irqchip/irq-gic-v3.c:695 [inline]
                        __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:746 [inline]
                        gic_handle_irq+0x78/0x1b4 drivers/irqchip/irq-gic-v3.c:790
                        do_interrupt_handler+0x88/0xc0 arch/arm64/kernel/entry-common.c:276
                        __el1_irq arch/arm64/kernel/entry-common.c:471 [inline]
                        el1_interrupt+0x34/0x68 arch/arm64/kernel/entry-common.c:486
                        el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:491
                        el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:580
                        arch_local_irq_restore arch/arm64/include/asm/irqflags.h:122 [inline]
                        __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
                        _raw_spin_unlock_irqrestore+0x58/0x8c kernel/locking/spinlock.c:194
                        debug_object_active_state+0x104/0x1dc lib/debugobjects.c:942
                        debug_rcu_head_unqueue kernel/rcu/rcu.h:198 [inline]
                        rcu_do_batch+0x180/0x584 kernel/rcu/tree.c:2243
                        rcu_core+0x2bc/0x5b4 kernel/rcu/tree.c:2510
                        rcu_core_si+0x10/0x1c kernel/rcu/tree.c:2527
                        _stext+0x168/0x37c
                        ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
                        call_on_irq_stack+0x2c/0x54 arch/arm64/kernel/entry.S:892
                        do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:85
                        invoke_softirq+0x70/0xbc kernel/softirq.c:452
                        __irq_exit_rcu+0xf0/0x140 kernel/softirq.c:650
                        irq_exit_rcu+0x10/0x40 kernel/softirq.c:662
                        __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
                        el1_interrupt+0x38/0x68 arch/arm64/kernel/entry-common.c:486
                        el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:491
                        el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:580
                        arch_local_irq_enable+0xc/0x18 arch/arm64/include/asm/irqflags.h:35
                        default_idle_call+0x48/0xb8 kernel/sched/idle.c:109
                        cpuidle_idle_call kernel/sched/idle.c:191 [inline]
                        do_idle+0x110/0x2d4 kernel/sched/idle.c:303
                        cpu_startup_entry+0x24/0x28 kernel/sched/idle.c:400
                        secondary_start_kernel+0x154/0x17c arch/arm64/kernel/smp.c:265
                        __secondary_switched+0xb0/0xb4 arch/arm64/kernel/head.S:621
     INITIAL USE at:
                       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
                       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                       _raw_spin_lock_irqsave+0x6c/0xb4 kernel/locking/spinlock.c:162
                       __irq_get_desc_lock+0xdc/0x10c kernel/irq/irqdesc.c:858
                       irq_get_desc_lock kernel/irq/internals.h:186 [inline]
                       irq_modify_status+0x50/0x200 kernel/irq/chip.c:1089
                       irq_set_status_flags include/linux/irq.h:767 [inline]
                       irq_set_percpu_devid_flags include/linux/irq.h:805 [inline]
                       irq_set_percpu_devid_partition kernel/irq/irqdesc.c:892 [inline]
                       irq_set_percpu_devid+0x90/0xb0 kernel/irq/irqdesc.c:898
                       gic_irq_domain_map+0x10c/0x1e4 drivers/irqchip/irq-gic-v3.c:1452
                       gic_irq_domain_alloc+0xd0/0x11c drivers/irqchip/irq-gic-v3.c:1567
                       irq_domain_alloc_irqs_hierarchy kernel/irq/irqdomain.c:1426 [inline]
                       __irq_domain_alloc_irqs+0x210/0x5d8 kernel/irq/irqdomain.c:1482
                       gic_smp_init+0x94/0xf4 drivers/irqchip/irq-gic-v3.c:1312
                       gic_init_bases+0x5a8/0x700 drivers/irqchip/irq-gic-v3.c:1888
                       gic_acpi_init+0x22c/0x278 drivers/irqchip/irq-gic-v3.c:2432
                       acpi_match_madt+0x60/0xb0 drivers/acpi/scan.c:2633
                       call_handler drivers/acpi/tables.c:290 [inline]
                       acpi_parse_entries_array+0x1a8/0x3e8 drivers/acpi/tables.c:348
                       acpi_table_parse_entries_array+0x12c/0x168 drivers/acpi/tables.c:407
                       __acpi_table_parse_entries drivers/acpi/tables.c:426 [inline]
                       acpi_table_parse_entries drivers/acpi/tables.c:445 [inline]
                       acpi_table_parse_madt+0x64/0x94 drivers/acpi/tables.c:452
                       __acpi_probe_device_table+0xc4/0x150 drivers/acpi/scan.c:2650
                       irqchip_init+0x44/0x50 drivers/irqchip/irqchip.c:32
                       init_IRQ+0xd4/0xf4 arch/arm64/kernel/irq.c:126
                       start_kernel+0x220/0x620 init/main.c:1041
                       __primary_switched+0xb4/0xbc arch/arm64/kernel/head.S:471
   }
   ... key      at: [<ffff80000ef0b470>] irq_desc_lock_class+0x0/0x10
   ... acquired at:
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
   irq_do_set_affinity+0x4c/0x284 kernel/irq/manage.c:226
   irq_startup+0x114/0x4b8 kernel/irq/chip.c:274
   __setup_irq+0x9dc/0xb50 kernel/irq/manage.c:1769
   request_threaded_irq+0x1c0/0x24c kernel/irq/manage.c:2198
   pci_request_irq+0xb4/0x118 drivers/pci/irq.c:48
   queue_request_irq+0xa8/0xc0
   nvme_create_queue+0x36c/0x434 drivers/nvme/host/pci.c:1705
   nvme_create_io_queues drivers/nvme/host/pci.c:1889 [inline]
   nvme_setup_io_queues+0x620/0x860 drivers/nvme/host/pci.c:2429
   nvme_reset_work+0x700/0xe78 drivers/nvme/host/pci.c:2902
   process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
   worker_thread+0x340/0x610 kernel/workqueue.c:2436
   kthread+0x12c/0x158 kernel/kthread.c:376
   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863

 -> (tmp_mask_lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
                     __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                     _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
                     irq_do_set_affinity+0x4c/0x284 kernel/irq/manage.c:226
                     irq_setup_affinity+0x1fc/0x210 kernel/irq/manage.c:625
                     irq_startup+0x3bc/0x4b8 kernel/irq/chip.c:271
                     __setup_irq+0x9dc/0xb50 kernel/irq/manage.c:1769
                     request_threaded_irq+0x1c0/0x24c kernel/irq/manage.c:2198
                     acpi_ged_request_interrupt+0x1fc/0x300 drivers/acpi/evged.c:130
                     acpi_walk_resource_buffer+0x88/0x148 drivers/acpi/acpica/rsxface.c:547
                     acpi_walk_resources+0x120/0x170 drivers/acpi/acpica/rsxface.c:623
                     ged_probe+0x98/0xe8 drivers/acpi/evged.c:152
                     platform_probe+0xd4/0x134 drivers/base/platform.c:1400
                     call_driver_probe+0x48/0x170
                     really_probe+0x13c/0x4c0 drivers/base/dd.c:639
                     __driver_probe_device+0x124/0x214 drivers/base/dd.c:778
                     driver_probe_device+0x54/0x2f0 drivers/base/dd.c:808
                     __driver_attach+0x250/0x374 drivers/base/dd.c:1190
                     bus_for_each_dev+0xa8/0x110 drivers/base/bus.c:301
                     driver_attach+0x30/0x40 drivers/base/dd.c:1207
                     bus_add_driver+0x14c/0x2e4 drivers/base/bus.c:618
                     driver_register+0x108/0x19c drivers/base/driver.c:246
                     __platform_driver_register+0x30/0x40 drivers/base/platform.c:867
                     ged_driver_init+0x20/0x2c drivers/acpi/evged.c:196
                     do_one_initcall+0x118/0x22c init/main.c:1303
                     do_initcall_level+0xac/0xe4 init/main.c:1376
                     do_initcalls+0x58/0xa8 init/main.c:1392
                     do_basic_setup+0x20/0x2c init/main.c:1411
                     kernel_init_freeable+0xb8/0x148 init/main.c:1631
                     kernel_init+0x24/0x290 init/main.c:1519
                     ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
  }
  ... key      at: [<ffff80000d4a3b08>] irq_do_set_affinity.tmp_mask_lock+0x18/0x40
  ... acquired at:
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x6c/0xb4 kernel/locking/spinlock.c:162
   its_select_cpu+0x48/0x44c drivers/irqchip/irq-gic-v3-its.c:1585
   its_set_affinity+0x1a4/0x418 drivers/irqchip/irq-gic-v3-its.c:1661
   msi_domain_set_affinity+0x54/0x198 kernel/irq/msi.c:500
   irq_do_set_affinity+0xfc/0x284
   irq_setup_affinity+0x1fc/0x210 kernel/irq/manage.c:625
   irq_startup+0x3bc/0x4b8 kernel/irq/chip.c:271
   __setup_irq+0x9dc/0xb50 kernel/irq/manage.c:1769
   request_threaded_irq+0x1c0/0x24c kernel/irq/manage.c:2198
   request_irq include/linux/interrupt.h:168 [inline]
   vp_request_msix_vectors drivers/virtio/virtio_pci_common.c:143 [inline]
   vp_find_vqs_msix+0x334/0x688 drivers/virtio/virtio_pci_common.c:309
   vp_find_vqs+0x68/0x26c drivers/virtio/virtio_pci_common.c:405
   virtio_find_single_vq include/linux/virtio_config.h:214 [inline]
   probe_common+0x180/0x2a8 drivers/char/hw_random/virtio-rng.c:156
   virtrng_probe+0x20/0x30 drivers/char/hw_random/virtio-rng.c:194
   virtio_dev_probe+0x460/0x590 drivers/virtio/virtio.c:305
   call_driver_probe+0x48/0x170
   really_probe+0x13c/0x4c0 drivers/base/dd.c:639
   __driver_probe_device+0x124/0x214 drivers/base/dd.c:778
   driver_probe_device+0x54/0x2f0 drivers/base/dd.c:808
   __driver_attach+0x250/0x374 drivers/base/dd.c:1190
   bus_for_each_dev+0xa8/0x110 drivers/base/bus.c:301
   driver_attach+0x30/0x40 drivers/base/dd.c:1207
   bus_add_driver+0x14c/0x2e4 drivers/base/bus.c:618
   driver_register+0x108/0x19c drivers/base/driver.c:246
   register_virtio_driver+0x54/0x6c drivers/virtio/virtio.c:357
   virtio_rng_driver_init+0x1c/0x28 drivers/char/hw_random/virtio-rng.c:262
   do_one_initcall+0x118/0x22c init/main.c:1303
   do_initcall_level+0xac/0xe4 init/main.c:1376
   do_initcalls+0x58/0xa8 init/main.c:1392
   do_basic_setup+0x20/0x2c init/main.c:1411
   kernel_init_freeable+0xb8/0x148 init/main.c:1631
   kernel_init+0x24/0x290 init/main.c:1519
   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863

-> (tmpmask_lock){+...}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:350 [inline]
                    list_lru_add+0x78/0x1f4 mm/list_lru.c:126
                    d_lru_add+0x144/0x1a4 fs/dcache.c:431
                    retain_dentry+0x124/0x144 fs/dcache.c:685
                    dput+0x188/0x2e0 fs/dcache.c:908
                    handle_mounts fs/namei.c:1548 [inline]
                    step_into+0x164/0x54c fs/namei.c:1831
                    open_last_lookups fs/namei.c:3504 [inline]
                    path_openat+0xa04/0x11c4 fs/namei.c:3711
                    do_filp_open+0xdc/0x1b8 fs/namei.c:3741
                    do_sys_openat2+0xb8/0x22c fs/open.c:1310
                    do_sys_open fs/open.c:1326 [inline]
                    __do_sys_openat fs/open.c:1342 [inline]
                    __se_sys_openat fs/open.c:1337 [inline]
                    __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
                    __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
                    invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
                    el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
                    do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
                    el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
                    el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
                    el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
   INITIAL USE at:
                   lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0x6c/0xb4 kernel/locking/spinlock.c:162
                   its_select_cpu+0x48/0x44c drivers/irqchip/irq-gic-v3-its.c:1585
                   its_irq_domain_activate+0x50/0x1d4 drivers/irqchip/irq-gic-v3-its.c:3592
                   __irq_domain_activate_irq+0x98/0xf4 kernel/irq/irqdomain.c:1767
                   __irq_domain_activate_irq+0x3c/0xf4 kernel/irq/irqdomain.c:1764
                   irq_domain_activate_irq+0x44/0x98 kernel/irq/irqdomain.c:1790
                   msi_init_virq kernel/irq/msi.c:841 [inline]
                   __msi_domain_alloc_irqs+0x4b0/0x8cc kernel/irq/msi.c:902
                   msi_domain_alloc_irqs_descs_locked+0xdc/0x1c0 kernel/irq/msi.c:952
                   pci_msi_setup_msi_irqs+0x6c/0x80 drivers/pci/msi/irqdomain.c:17
                   msix_setup_interrupts drivers/pci/msi/msi.c:580 [inline]
                   msix_capability_init drivers/pci/msi/msi.c:640 [inline]
                   __pci_enable_msix drivers/pci/msi/msi.c:827 [inline]
                   __pci_enable_msix_range+0x6cc/0xa0c drivers/pci/msi/msi.c:952
                   pci_alloc_irq_vectors_affinity+0xb0/0x1e0 drivers/pci/msi/msi.c:1021
                   vp_request_msix_vectors drivers/virtio/virtio_pci_common.c:133 [inline]
                   vp_find_vqs_msix+0x2c8/0x688 drivers/virtio/virtio_pci_common.c:309
                   vp_find_vqs+0x68/0x26c drivers/virtio/virtio_pci_common.c:405
                   virtio_find_single_vq include/linux/virtio_config.h:214 [inline]
                   probe_common+0x180/0x2a8 drivers/char/hw_random/virtio-rng.c:156
                   virtrng_probe+0x20/0x30 drivers/char/hw_random/virtio-rng.c:194
                   virtio_dev_probe+0x460/0x590 drivers/virtio/virtio.c:305
                   call_driver_probe+0x48/0x170
                   really_probe+0x13c/0x4c0 drivers/base/dd.c:639
                   __driver_probe_device+0x124/0x214 drivers/base/dd.c:778
                   driver_probe_device+0x54/0x2f0 drivers/base/dd.c:808
                   __driver_attach+0x250/0x374 drivers/base/dd.c:1190
                   bus_for_each_dev+0xa8/0x110 drivers/base/bus.c:301
                   driver_attach+0x30/0x40 drivers/base/dd.c:1207
                   bus_add_driver+0x14c/0x2e4 drivers/base/bus.c:618
                   driver_register+0x108/0x19c drivers/base/driver.c:246
                   register_virtio_driver+0x54/0x6c drivers/virtio/virtio.c:357
                   virtio_rng_driver_init+0x1c/0x28 drivers/char/hw_random/virtio-rng.c:262
                   do_one_initcall+0x118/0x22c init/main.c:1303
                   do_initcall_level+0xac/0xe4 init/main.c:1376
                   do_initcalls+0x58/0xa8 init/main.c:1392
                   do_basic_setup+0x20/0x2c init/main.c:1411
                   kernel_init_freeable+0xb8/0x148 init/main.c:1631
                   kernel_init+0x24/0x290 init/main.c:1519
                   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
 }
 ... key      at: [<ffff80000d6639c0>] its_select_cpu.tmpmask_lock+0x18/0x40
 ... acquired at:
   mark_lock+0x154/0x1b4 kernel/locking/lockdep.c:4634
   mark_usage kernel/locking/lockdep.c:4543 [inline]
   __lock_acquire+0x5f8/0x3084 kernel/locking/lockdep.c:5009
   lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:350 [inline]
   list_lru_add+0x78/0x1f4 mm/list_lru.c:126
   d_lru_add+0x144/0x1a4 fs/dcache.c:431
   retain_dentry+0x124/0x144 fs/dcache.c:685
   dput+0x188/0x2e0 fs/dcache.c:908
   handle_mounts fs/namei.c:1548 [inline]
   step_into+0x164/0x54c fs/namei.c:1831
   open_last_lookups fs/namei.c:3504 [inline]
   path_openat+0xa04/0x11c4 fs/namei.c:3711
   do_filp_open+0xdc/0x1b8 fs/namei.c:3741
   do_sys_openat2+0xb8/0x22c fs/open.c:1310
   do_sys_open fs/open.c:1326 [inline]
   __do_sys_openat fs/open.c:1342 [inline]
   __se_sys_openat fs/open.c:1337 [inline]
   __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
   __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
   invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
   el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
   do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
   el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
   el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
   el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584


stack backtrace:
CPU: 0 PID: 3074 Comm: syz-executor305 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_irq_inversion_bug+0x2f8/0x300 kernel/locking/lockdep.c:4042
 mark_lock_irq+0x3ec/0x4b4
 mark_lock+0x154/0x1b4 kernel/locking/lockdep.c:4634
 mark_usage kernel/locking/lockdep.c:4543 [inline]
 __lock_acquire+0x5f8/0x3084 kernel/locking/lockdep.c:5009
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 list_lru_add+0x78/0x1f4 mm/list_lru.c:126
 d_lru_add+0x144/0x1a4 fs/dcache.c:431
 retain_dentry+0x124/0x144 fs/dcache.c:685
 dput+0x188/0x2e0 fs/dcache.c:908
 handle_mounts fs/namei.c:1548 [inline]
 step_into+0x164/0x54c fs/namei.c:1831
 open_last_lookups fs/namei.c:3504 [inline]
 path_openat+0xa04/0x11c4 fs/namei.c:3711
 do_filp_open+0xdc/0x1b8 fs/namei.c:3741
 do_sys_openat2+0xb8/0x22c fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Unable to handle kernel paging request at virtual address ffff80000d2e2c80
Mem abort info:
  ESR = 0x0000000096000047
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x07: level 3 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000047
  CM = 0, WnR = 1
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001c54dc000
[ffff80000d2e2c80] pgd=100000023ffff003, p4d=100000023ffff003, pud=100000023fffe003, pmd=100000023fffa003, pte=0000000000000000
Internal error: Oops: 0000000096000047 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3074 Comm: syz-executor305 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : queued_spin_lock_slowpath+0x198/0x394 kernel/locking/qspinlock.c:474
lr : queued_spin_lock_slowpath+0x114/0x394 kernel/locking/qspinlock.c:405
sp : ffff80000fc5b8f0
x29: ffff80000fc5b8f0 x28: ffff80000d95b000 x27: ffff0000cae7ad00
x26: 00000000000800e0 x25: 0000000000000000 x24: ffff0001fefd0c80
x23: 0000000000000000 x22: ffff80000d37d050 x21: ffff80000d2e2c80
x20: 0000000000000000 x19: ffff0000cae7ad00 x18: 00000000000000c0
x17: 6e69676e45206574 x16: 0000000000000003 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000003030 x12: 0000000000000000
x11: ffff80000d2e2c80 x10: 0000000000040000 x9 : ffff0001fefd0c88
x8 : ffff0001fefd0c80 x7 : 205b5d3336343637 x6 : ffff80000c091ebc
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : ffff80000ce893cb x0 : 0000000000000001
Call trace:
 decode_tail kernel/locking/qspinlock.c:131 [inline]
 queued_spin_lock_slowpath+0x198/0x394 kernel/locking/qspinlock.c:471
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x10c/0x110 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
 _raw_spin_lock+0x5c/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 list_lru_add+0x78/0x1f4 mm/list_lru.c:126
 d_lru_add+0x144/0x1a4 fs/dcache.c:431
 retain_dentry+0x124/0x144 fs/dcache.c:685
 dput+0x188/0x2e0 fs/dcache.c:908
 handle_mounts fs/namei.c:1548 [inline]
 step_into+0x164/0x54c fs/namei.c:1831
 open_last_lookups fs/namei.c:3504 [inline]
 path_openat+0xa04/0x11c4 fs/namei.c:3711
 do_filp_open+0xdc/0x1b8 fs/namei.c:3741
 do_sys_openat2+0xb8/0x22c fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 8b2c4ecc f85f818c 1200056b 8b2b52ab (f82b6988) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	8b2c4ecc 	add	x12, x22, w12, uxtw #3
   4:	f85f818c 	ldur	x12, [x12, #-8]
   8:	1200056b 	and	w11, w11, #0x3
   c:	8b2b52ab 	add	x11, x21, w11, uxtw #4
* 10:	f82b6988 	str	x8, [x12, x11] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
