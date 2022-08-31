Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CB25A7685
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 08:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiHaG2Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 02:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiHaG2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:28:22 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE734BD097;
        Tue, 30 Aug 2022 23:28:19 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id y17so1804187ilb.4;
        Tue, 30 Aug 2022 23:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=hcIa37Xf7EwW+XE8+Vkth60yB4bScOmKY0IEvZzw3IE=;
        b=JC5rtzXYytUo/q+Yk1E7S6aUqLoztoq7gBz5QF6YD5TpzmPKjT19dYHFon6cGcF/iX
         E5eGJkWmEOHqTVBO1W/DYb9vui9OjnwshGFszg5R8r8BHJCMQmlWrbsE6qWiqg2deBdM
         XQPcSGuVj56xeRuXRqIQ14jD5PC1llCcenL6pCklHxJy7vzrxgPrbpkqoHwut8wfMbTr
         OQZ89qhOTXGW2S3HGjKTlCBxHmq+pe5+5gwMYYFFR/5IwflxmHUSOTu9ieN0Uvq27GO4
         9FCeYvZNr2ZJpbLt6V61DHGGxCsM88Wx+HLk2f1XBOkzmL+NHWLN13+KaolQT/c9phDA
         pxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=hcIa37Xf7EwW+XE8+Vkth60yB4bScOmKY0IEvZzw3IE=;
        b=fHODg/gIgfWvThtLU9YWuShmfbce990bkw5Pfd+x2LmcnW/LjHSTMIHsW2cFNmdkqa
         +hXA5QdhZpETXLlfiiIjfTG4k7jyBKFzfX2cka19tJ4dw8mMu7SZUKCmJa0VQeqFMaEQ
         xt5UXcsISUrFY9D0sEOpx5moU4PPQed4EvV3/+ImvaLWTDPRZowUVE03b72qFx1jkxbd
         8VralJSquzIdAFJ9dKpdrSUhMRHZat3p1LDkwZeJQYdjuzUMEAP/8bY1xx+WnhDnQ9me
         aThw3iKVHoNDR+eOTFiSSRIdD+RYVkJXcq2yI4fbfYF8gdlGHRoId+sL9ey97mYszOk4
         PNgA==
X-Gm-Message-State: ACgBeo0z+JMpPtXQ74Yk64G0YixUe0lzhu8l2PxuXPauvDd5XsViy85V
        WStcNY0MrHZTtblmV6CiyxLS9AF5C9NrNEtTLkMXt4nXBW+EQw==
X-Google-Smtp-Source: AA6agR5DxGXC8tnCYCpU0dGR9dtpB+tRZjvLFeZcqReEP7iUOMpe5P600xkNdJegKuvmUpRo+BvjwBC+NF1Zu0WLPRA=
X-Received: by 2002:a05:6e02:1b8f:b0:2ea:2d7d:9d5c with SMTP id
 h15-20020a056e021b8f00b002ea2d7d9d5cmr13575771ili.218.1661927298853; Tue, 30
 Aug 2022 23:28:18 -0700 (PDT)
MIME-Version: 1.0
From:   Jiacheng Xu <578001344xu@gmail.com>
Date:   Wed, 31 Aug 2022 14:28:07 +0800
Message-ID: <CAO4S-meaS3Oa3WZggmO2tDfvuKCxsXb5HJot3bHq+m_dLeCJmg@mail.gmail.com>
Subject: HARDIRQ-safe - HARDIRQ-unsafe lock order detected
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, chuck.lever@oracle.com
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

When using modified Syzkaller to fuzz the Linux kernel-5.19, the
following crash was triggered. Though the issue seems to get fixed on
syzbot, it could still be triggered with the following repro.
We would appreciate a CVE ID if this is a security issue.

HEAD commit: 3d7cb6b04c3f Linux-5.19
git tree: upstream

kernel config: https://drive.google.com/file/d/1wgIUDwP5ho29AM-K7HhysSTfWFpfXYkG/view?usp=sharing
syz repro: https://drive.google.com/file/d/1w96wKldLL-p22lpv4k0IfenVwQWcSIIj/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1qSEQ7cYmEh8t5e72E5D6gPtu4aA5tvmq/view?usp=sharing

Environment:
Ubuntu 20.04 on Linux 5.4.0
QEMU 4.2.1:
qemu-system-x86_64 \
  -m 2G \
  -smp 2 \
  -kernel /home/workdir/bzImage \
  -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
  -drive file=/home/workdir/stretch.img,format=raw \
  -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
  -net nic,model=e1000 \
  -enable-kvm \
  -nographic \
  -pidfile vm.pid \
  2>&1 | tee vm.log

If you fix this issue, please add the following tag to the commit:
Reported-by Jiacheng Xu<578001344xu@gmail.com>

 =====================================================
 WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
 5.19.0 #1 Not tainted
 -----------------------------------------------------
 is trying to acquire:
 ffff88801b918630 (&f->f_owner.lock){....}-{2:2}, at:
send_sigio+0x24/0x380 (fs/fcntl.c:777).

 and this task is already holding:
 ffff88804616c018 (&new->fa_lock){....}-{2:2}, at:
kill_fasync+0x136/0x470 (fs/fcntl.c:995).
 which would create a new lock dependency:
  (&new->fa_lock){....}-{2:2} -> (&f->f_owner.lock){....}-{2:2}

 but this new dependency connects a HARDIRQ-irq-safe lock:
  (&dev->event_lock#2){-...}-{2:2}

 ... which became HARDIRQ-irq-safe at:
   lock_acquire+0x1ab/0x580
   _raw_spin_lock_irqsave+0x39/0x50
   input_event+0x7b/0xb0
   psmouse_report_standard_buttons+0x2c/0x80
   psmouse_process_byte+0x1e1/0x890
   psmouse_handle_byte+0x41/0x1b0
   psmouse_interrupt+0x304/0xf00
   serio_interrupt+0x88/0x150
   i8042_interrupt+0x270/0x520
   __handle_irq_event_percpu+0x236/0x880
   handle_irq_event_percpu+0x14/0xd0
   handle_irq_event+0xa1/0x130
   handle_edge_irq+0x24a/0x8a0
   __common_interrupt+0x9d/0x210
   common_interrupt+0xa4/0xc0
   asm_common_interrupt+0x22/0x40
   nohz_run_idle_balance+0x2/0x1c0
   do_idle+0x7a/0x570
   cpu_startup_entry+0x14/0x20
   start_secondary+0x21d/0x2b0
   secondary_startup_64_no_verify+0xce/0xdb

 to a HARDIRQ-irq-unsafe lock:
  (tasklist_lock){.+.+}-{2:2}

 ... which became HARDIRQ-irq-unsafe at:
 ...
   lock_acquire+0x1ab/0x580
   _raw_read_lock+0x5b/0x70
   do_wait+0x28c/0xce0
   kernel_wait+0x9c/0x150
   call_usermodehelper_exec_work+0xf5/0x180
   process_one_work+0x9cc/0x1650
   worker_thread+0x623/0x1070
   kthread+0x2e9/0x3a0
   ret_from_fork+0x1f/0x30

 other info that might help us debug this:

 Chain exists of:
   &dev->event_lock#2 --> &new->fa_lock --> tasklist_lock

  Possible interrupt unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(tasklist_lock);
                                local_irq_disable();
                                lock(&dev->event_lock#2);
                                lock(&new->fa_lock);
   <Interrupt>
     lock(&dev->event_lock#2);

  *** DEADLOCK ***

 8 locks held by repro/6439:
  #0: ffff888045e74110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_write+0x1d3/0x760
  #1: ffff888014fb4230 (&dev->event_lock#2){-...}-{2:2}, at:
input_inject_event+0xa6/0x320
  #2: ffffffff8bd86e60 (rcu_read_lock){....}-{1:2}, at:
input_inject_event+0x92/0x320
  #3: ffffffff8bd86e60 (rcu_read_lock){....}-{1:2}, at:
input_pass_values.part.0+0x0/0x710
  #4: ffffffff8bd86e60 (rcu_read_lock){....}-{1:2}, at: evdev_events+0x59/0x3e0
  #5: ffff888046c55028 (&client->buffer_lock){....}-{2:2}, at:
evdev_pass_values.part.0+0xf7/0x920
  #6: ffffffff8bd86e60 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x41/0x470
  #7: ffff88804616c018 (&new->fa_lock){....}-{2:2}, at: kill_fasync+0x136/0x470

 the dependencies between HARDIRQ-irq-safe lock and the holding lock:
   -> (&dev->event_lock#2){-...}-{2:2} {
      IN-HARDIRQ-W at:
                         lock_acquire+0x1ab/0x580
                         _raw_spin_lock_irqsave+0x39/0x50
                         input_event+0x7b/0xb0
                         psmouse_report_standard_buttons+0x2c/0x80
                         psmouse_process_byte+0x1e1/0x890
                         psmouse_handle_byte+0x41/0x1b0
                         psmouse_interrupt+0x304/0xf00
                         serio_interrupt+0x88/0x150
                         i8042_interrupt+0x270/0x520
                         __handle_irq_event_percpu+0x236/0x880
                         handle_irq_event_percpu+0x14/0xd0
                         handle_irq_event+0xa1/0x130
                         handle_edge_irq+0x24a/0x8a0
                         __common_interrupt+0x9d/0x210
                         common_interrupt+0xa4/0xc0
                         asm_common_interrupt+0x22/0x40
                         nohz_run_idle_balance+0x2/0x1c0
                         do_idle+0x7a/0x570
                         cpu_startup_entry+0x14/0x20
                         start_secondary+0x21d/0x2b0
                         secondary_startup_64_no_verify+0xce/0xdb
      INITIAL USE at:
                        lock_acquire+0x1ab/0x580
                        _raw_spin_lock_irqsave+0x39/0x50
                        input_inject_event+0xa6/0x320
                        led_set_brightness_nopm+0x48/0xf0
                        led_set_brightness+0x11c/0x240
                        led_trigger_event+0xb0/0x200
                        kbd_led_trigger_activate+0xc9/0x100
                        led_trigger_set+0x5d7/0xaf0
                        led_trigger_set_default+0x1a6/0x230
                        led_classdev_register_ext+0x56c/0x760
                        input_leds_connect+0x4bd/0x860
                        input_attach_handler+0x182/0x1f0
                        input_register_device.cold+0xfc/0x312
                        atkbd_connect+0x6bd/0x930
                        serio_connect_driver+0x46/0x70
                        really_probe+0x23e/0xa80
                        __driver_probe_device+0x338/0x4d0
                        driver_probe_device+0x4c/0x1a0
                        __driver_attach+0x1da/0x420
                        bus_for_each_dev+0x147/0x1d0
                        serio_handle_event+0x54c/0x850
                        process_one_work+0x9cc/0x1650
                        worker_thread+0x623/0x1070
                        kthread+0x2e9/0x3a0
                        ret_from_fork+0x1f/0x30
    }
 __key.38226+0x0/0x40
  -> (&client->buffer_lock){....}-{2:2} {
     INITIAL USE at:
                      lock_acquire+0x1ab/0x580
                      _raw_spin_lock+0x2a/0x40
                      evdev_pass_values.part.0+0xf7/0x920
                      evdev_events+0x359/0x3e0
                      input_to_handler+0x2a0/0x4c0
                      input_pass_values.part.0+0x230/0x710
                      input_handle_event+0x37a/0x1460
                      input_inject_event+0x1bd/0x320
                      evdev_write+0x430/0x760
                      vfs_write+0x269/0xab0
                      ksys_write+0x1e8/0x250
                      do_syscall_64+0x35/0xb0
                      entry_SYSCALL_64_after_hwframe+0x63/0xcd
   }
 __key.39514+0x0/0x40
   ... acquired at:
    lock_acquire+0x1ab/0x580
    _raw_spin_lock+0x2a/0x40
    evdev_pass_values.part.0+0xf7/0x920
    evdev_events+0x359/0x3e0
    input_to_handler+0x2a0/0x4c0
    input_pass_values.part.0+0x230/0x710
    input_handle_event+0x37a/0x1460
    input_inject_event+0x1bd/0x320
    evdev_write+0x430/0x760
    vfs_write+0x269/0xab0
    ksys_write+0x1e8/0x250
    do_syscall_64+0x35/0xb0
    entry_SYSCALL_64_after_hwframe+0x63/0xcd

 -> (&new->fa_lock){....}-{2:2} {
    INITIAL READ USE at:
                         lock_acquire+0x1ab/0x580
                         _raw_read_lock_irqsave+0x70/0x90
                         kill_fasync+0x136/0x470
                         evdev_pass_values.part.0+0x59d/0x920
                         evdev_events+0x359/0x3e0
                         input_to_handler+0x2a0/0x4c0
                         input_pass_values.part.0+0x230/0x710
                         input_handle_event+0x37a/0x1460
                         input_inject_event+0x1bd/0x320
                         evdev_write+0x430/0x760
                         vfs_write+0x269/0xab0
                         ksys_write+0x1e8/0x250
                         do_syscall_64+0x35/0xb0
                         entry_SYSCALL_64_after_hwframe+0x63/0xcd
  }
 __key.46908+0x0/0x40
  ... acquired at:
    lock_acquire+0x1ab/0x580
    _raw_read_lock_irqsave+0x70/0x90
    kill_fasync+0x136/0x470
    evdev_pass_values.part.0+0x59d/0x920
    evdev_events+0x359/0x3e0
    input_to_handler+0x2a0/0x4c0
    input_pass_values.part.0+0x230/0x710
    input_handle_event+0x37a/0x1460
    input_inject_event+0x1bd/0x320
    evdev_write+0x430/0x760
    vfs_write+0x269/0xab0
    ksys_write+0x1e8/0x250
    do_syscall_64+0x35/0xb0
    entry_SYSCALL_64_after_hwframe+0x63/0xcd


 the dependencies between the lock to be acquired
  and HARDIRQ-irq-unsafe lock:
  -> (tasklist_lock){.+.+}-{2:2} {
     HARDIRQ-ON-R at:
                       lock_acquire+0x1ab/0x580
                       _raw_read_lock+0x5b/0x70
                       do_wait+0x28c/0xce0
                       kernel_wait+0x9c/0x150
                       call_usermodehelper_exec_work+0xf5/0x180
                       process_one_work+0x9cc/0x1650
                       worker_thread+0x623/0x1070
                       kthread+0x2e9/0x3a0
                       ret_from_fork+0x1f/0x30
     SOFTIRQ-ON-R at:
                       lock_acquire+0x1ab/0x580
                       _raw_read_lock+0x5b/0x70
                       do_wait+0x28c/0xce0
                       kernel_wait+0x9c/0x150
                       call_usermodehelper_exec_work+0xf5/0x180
                       process_one_work+0x9cc/0x1650
                       worker_thread+0x623/0x1070
                       kthread+0x2e9/0x3a0
                       ret_from_fork+0x1f/0x30
     INITIAL USE at:
                      lock_acquire+0x1ab/0x580
                      _raw_write_lock_irq+0x32/0x50
                      copy_process+0x3362/0x6ec0
                      kernel_clone+0xe7/0x1040
                      user_mode_thread+0xad/0xe0
                      rest_init+0x23/0x2b0
                      arch_call_rest_init+0xf/0x14
                      start_kernel+0x46e/0x48f
                      secondary_startup_64_no_verify+0xce/0xdb
     INITIAL READ USE at:
                           lock_acquire+0x1ab/0x580
                           _raw_read_lock+0x5b/0x70
                           do_wait+0x28c/0xce0
                           kernel_wait+0x9c/0x150
                           call_usermodehelper_exec_work+0xf5/0x180
                           process_one_work+0x9cc/0x1650
                           worker_thread+0x623/0x1070
                           kthread+0x2e9/0x3a0
                           ret_from_fork+0x1f/0x30
   }
 tasklist_lock+0x18/0x40
   ... acquired at:
    lock_acquire+0x1ab/0x580
    _raw_read_lock+0x5b/0x70
    send_sigio+0xab/0x380
    dnotify_handle_event+0x148/0x280
    fsnotify_handle_inode_event.isra.0+0x22e/0x360
    fsnotify+0xe7a/0x13a0
    path_openat+0xf57/0x2890
    do_filp_open+0x1c1/0x290
    do_sys_openat2+0x61b/0x990
    do_sys_open+0xc3/0x140
    do_syscall_64+0x35/0xb0
    entry_SYSCALL_64_after_hwframe+0x63/0xcd

 -> (&f->f_owner.lock){....}-{2:2} {
    INITIAL USE at:
                    lock_acquire+0x1ab/0x580
                    _raw_write_lock_irq+0x32/0x50
                    f_modown+0x2a/0x390
                    f_setown+0xd7/0x230
                    do_fcntl+0x6e0/0x1040
                    __x64_sys_fcntl+0x15f/0x1d0
                    do_syscall_64+0x35/0xb0
                    entry_SYSCALL_64_after_hwframe+0x63/0xcd
    INITIAL READ USE at:
                         lock_acquire+0x1ab/0x580
                         _raw_read_lock_irqsave+0x70/0x90
                         send_sigio+0x24/0x380
                         dnotify_handle_event+0x148/0x280
                         fsnotify_handle_inode_event.isra.0+0x22e/0x360
                         fsnotify+0xe7a/0x13a0
                         path_openat+0xf57/0x2890
                         do_filp_open+0x1c1/0x290
                         do_sys_openat2+0x61b/0x990
                         do_sys_open+0xc3/0x140
                         do_syscall_64+0x35/0xb0
                         entry_SYSCALL_64_after_hwframe+0x63/0xcd
  }
 __key.49376+0x0/0x40
  ... acquired at:
    __lock_acquire+0x2e06/0x5840
    lock_acquire+0x1ab/0x580
    _raw_read_lock_irqsave+0x70/0x90
    send_sigio+0x24/0x380
    kill_fasync+0x1f8/0x470
    evdev_pass_values.part.0+0x59d/0x920
    evdev_events+0x359/0x3e0
    input_to_handler+0x2a0/0x4c0
    input_pass_values.part.0+0x230/0x710
    input_handle_event+0x37a/0x1460
    input_inject_event+0x1bd/0x320
    evdev_write+0x430/0x760
    vfs_write+0x269/0xab0
    ksys_write+0x1e8/0x250
    do_syscall_64+0x35/0xb0
    entry_SYSCALL_64_after_hwframe+0x63/0xcd

 stack backtrace:
 CPU: 1 PID: 6439 Comm: repro Not tainted 5.19.0 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0xcd/0x134
  check_irq_usage.cold+0x54a/0x7a1
  ? print_shortest_lock_dependencies_backwards+0x80/0x80
  ? SOFTIRQ_verbose+0x10/0x10
  ? __kernel_text_address+0x9/0x30
  ? create_prof_cpu_mask+0x20/0x20
  ? check_path.constprop.0+0x24/0x50
  ? check_noncircular+0x142/0x310
  ? print_circular_bug.isra.0+0x480/0x480
  ? check_prev_add+0x177/0x24f0
  check_prev_add+0x177/0x24f0
  ? alloc_list_entry+0x46/0x2e0
  ? __sanitizer_cov_trace_pc+0x1a/0x40
  __lock_acquire+0x2e06/0x5840
  ? lockdep_hardirqs_on_prepare+0x400/0x400
  ? rcu_read_lock_sched_held+0x9c/0xd0
  lock_acquire+0x1ab/0x580
  ? send_sigio+0x24/0x380
  ? lock_release+0x6d0/0x6d0
  ? lock_release+0x6d0/0x6d0
  _raw_read_lock_irqsave+0x70/0x90
  ? send_sigio+0x24/0x380
  send_sigio+0x24/0x380
  kill_fasync+0x1f8/0x470
  evdev_pass_values.part.0+0x59d/0x920
  ? evdev_open+0x540/0x540
  ? rcu_read_lock_held+0x9c/0xb0
  ? rcu_read_lock_sched_held+0xd0/0xd0
  evdev_events+0x359/0x3e0
  ? evdev_pass_values.part.0+0x920/0x920
  input_to_handler+0x2a0/0x4c0
  input_pass_values.part.0+0x230/0x710
  ? write_comp_data+0x1c/0x70
  input_handle_event+0x37a/0x1460
  input_inject_event+0x1bd/0x320
  evdev_write+0x430/0x760
  ? evdev_read+0xe40/0xe40
  ? __sanitizer_cov_trace_pc+0x1a/0x40
  ? security_file_permission+0x490/0x6b0
  ? evdev_read+0xe40/0xe40
  vfs_write+0x269/0xab0
  ksys_write+0x1e8/0x250
  ? __ia32_sys_read+0xb0/0xb0
  ? syscall_enter_from_user_mode+0x21/0x70
  ? syscall_enter_from_user_mode+0x21/0x70
  do_syscall_64+0x35/0xb0
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
 RIP: 0033:0x7f47878e4469
 Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 8
 RSP: 002b:00007ffff5cee4a8 EFLAGS: 00000217 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f47878e4469
 RDX: 000000000000fc57 RSI: 0000000020000080 RDI: 0000000000000005
 RBP: 00007ffff5cee4c0 R08: 00007ffff5cee5a0 R09: 00007ffff5cee5a0
 R10: 00007ffff5cee5a0 R11: 0000000000000217 R12: 000055c454c00710
 R13: 00007ffff5cee5a0 R14: 0000000000000000 R15: 0000000000000000
  </TASK>
