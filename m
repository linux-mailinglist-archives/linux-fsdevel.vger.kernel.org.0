Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B1F60959E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Oct 2022 20:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiJWSce (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 14:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJWScd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 14:32:33 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3BB74378
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 11:32:31 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id a14-20020a6b660e000000b006bd37975cdfso3314430ioc.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 11:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+0VgJ8Gbl95TmV6Bs0hyU7LlDiuG6XfQ/JBlPd6Jvw=;
        b=XNM2zrZwTbBLzTMOOYK4eYz2nS4yHtz2vHRtwVaBG9Ely8dc1ExU+32YfWdBTx4VLO
         9IvPn/UfwTD3PA4o/L2q8XpxucaqLfVZ5UanuRfyoPsbSEVmgbFDuKEWy4OtmCH3tx9X
         nTYJmMHNxClIni96V6jMMX/yMqUjN/7Tsc0aQKmSjvA9qvtxO90OjUfOy5ljB4XYTU+n
         /2MckIJS0n6RzCG4zGV+8KsfjFR6zK6fH240hlh2PIAbj7C39t6xyIPzdy+c6cw+Luci
         KlI4HQDQFJZD91jCeeKl+VOTiDX40rMTYoaoIXEsta7ByBW1W3nlhZ4Ayq/HUfwUf+t4
         7LxA==
X-Gm-Message-State: ACrzQf2Rx7I+n28lPFFYqXPtvtjcazOtuWlBzoLQmkK0thshmoprghVy
        bM6nH/9qbbj/9yvlvmh9e2TO87qONIAoFcRkk8JYDfM9rGHH
X-Google-Smtp-Source: AMsMyM4ufSOAB+H/L20zddLafaoC1ZpxxXva8ahIgQ9Ws/IbUXseWao9xhVbb/HWlrXMPerhwF0zb8yZatVy9xZAL6u8qCCnGRQ+
MIME-Version: 1.0
X-Received: by 2002:a02:c6d9:0:b0:373:e154:268e with SMTP id
 r25-20020a02c6d9000000b00373e154268emr1181868jan.291.1666549950546; Sun, 23
 Oct 2022 11:32:30 -0700 (PDT)
Date:   Sun, 23 Oct 2022 11:32:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd8af105ebb7e570@google.com>
Subject: [syzbot] inconsistent lock state in _atomic_dec_and_lock
From:   syzbot <syzbot+9c8140e9162432b9eb20@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14ee3b3c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=9c8140e9162432b9eb20
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150865d6880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ebd052ae1e7b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c8140e9162432b9eb20@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
syz-executor.3/9712 [HC0[0]:SC0[0]:HE1:SE1] takes:
ffff0000d10c2577 (&folio_wait_table[i]){?.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
ffff0000d10c2577 (&folio_wait_table[i]){?.-.}-{2:2}, at: _atomic_dec_and_lock+0xc8/0x130 lib/dec_and_lock.c:28
{IN-HARDIRQ-W} state was registered at:
  lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x6c/0xb4 kernel/locking/spinlock.c:162
  folio_wake_bit+0x88/0x254 mm/filemap.c:1143
  folio_unlock+0xb4/0x210 mm/filemap.c:1533
  unlock_page+0x38/0xb8 mm/folio-compat.c:20
  end_buffer_async_read+0x2a8/0x5f8 fs/buffer.c:290
  end_buffer_async_read_io+0x118/0x12c fs/buffer.c:335
  end_bio_bh_io_sync+0x5c/0xac fs/buffer.c:2672
  bio_endio+0x28c/0x2d8 block/bio.c:1564
  blk_complete_request block/blk-mq.c:755 [inline]
  blk_mq_end_request_batch+0x18c/0x5ec block/blk-mq.c:989
  nvme_complete_batch drivers/nvme/host/nvme.h:706 [inline]
  nvme_pci_complete_batch+0x130/0x14c drivers/nvme/host/pci.c:1040
  nvme_irq+0x64/0xa8 drivers/nvme/host/pci.c:1141
  __handle_irq_event_percpu+0xa8/0x294 kernel/irq/handle.c:158
  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
  handle_irq_event+0x4c/0xe8 kernel/irq/handle.c:210
  handle_fasteoi_irq+0x1b4/0x324 kernel/irq/chip.c:714
  generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
  handle_irq_desc kernel/irq/irqdesc.c:648 [inline]
  generic_handle_domain_irq+0x4c/0x6c kernel/irq/irqdesc.c:704
  __gic_handle_irq drivers/irqchip/irq-gic-v3.c:695 [inline]
  __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:746 [inline]
  gic_handle_irq+0x78/0x1b4 drivers/irqchip/irq-gic-v3.c:790
  call_on_irq_stack+0x2c/0x54 arch/arm64/kernel/entry.S:889
  do_interrupt_handler+0x7c/0xc0 arch/arm64/kernel/entry-common.c:274
  __el1_irq arch/arm64/kernel/entry-common.c:470 [inline]
  el1_interrupt+0x34/0x68 arch/arm64/kernel/entry-common.c:485
  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:490
  el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
  arch_local_irq_restore arch/arm64/include/asm/irqflags.h:122 [inline]
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
  _raw_spin_unlock_irqrestore+0x58/0x8c kernel/locking/spinlock.c:194
  debug_object_activate+0xb0/0x300 lib/debugobjects.c:692
  debug_rcu_head_queue kernel/rcu/rcu.h:189 [inline]
  call_rcu+0x40/0x484 kernel/rcu/tree.c:2778
  tlb_remove_table_free mm/mmu_gather.c:174 [inline]
  tlb_table_flush mm/mmu_gather.c:215 [inline]
  tlb_flush_mmu_free+0x298/0x3bc mm/mmu_gather.c:253
  tlb_flush_mmu+0x274/0x2f0 mm/mmu_gather.c:262
  tlb_finish_mmu+0x64/0xe4 mm/mmu_gather.c:353
  exit_mmap+0xe4/0x2e4 mm/mmap.c:3118
  __mmput+0x90/0x204 kernel/fork.c:1187
  mmput+0x64/0xa0 kernel/fork.c:1208
  free_bprm+0xac/0x19c fs/exec.c:1485
  kernel_execve+0x4ec/0x540 fs/exec.c:2004
  call_usermodehelper_exec_async+0x10c/0x214 kernel/umh.c:112
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
irq event stamp: 8353
hardirqs last  enabled at (8353): [<ffff800008161dac>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
hardirqs last  enabled at (8353): [<ffff800008161dac>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4942
hardirqs last disabled at (8352): [<ffff80000bfc0a34>] __schedule+0x84/0x5a0 kernel/sched/core.c:6393
softirqs last  enabled at (7378): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (7245): [<ffff800008017c14>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&folio_wait_table[i]);
  <Interrupt>
    lock(&folio_wait_table[i]);

 *** DEADLOCK ***

1 lock held by syz-executor.3/9712:
 #0: ffff0000d1a700e0 (&type->s_umount_key#46/1){+.+.}-{3:3}, at: alloc_super+0xf8/0x430 fs/super.c:228

stack backtrace:
CPU: 1 PID: 9712 Comm: syz-executor.3 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_usage_bug+0x39c/0x3cc kernel/locking/lockdep.c:3961
 mark_lock_irq+0x4a8/0x4b4
 mark_lock+0x154/0x1b4 kernel/locking/lockdep.c:4632
 mark_usage kernel/locking/lockdep.c:4541 [inline]
 __lock_acquire+0x5f8/0x30a4 kernel/locking/lockdep.c:5007
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 _atomic_dec_and_lock+0xc8/0x130 lib/dec_and_lock.c:28
 iput+0x50/0x324 fs/inode.c:1766
 ntfs_fill_super+0x1254/0x14a4 fs/ntfs3/super.c:1190
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
ntfs3: loop3: Mark volume as dirty due to NTFS errors


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
