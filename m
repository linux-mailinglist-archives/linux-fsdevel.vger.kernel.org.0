Return-Path: <linux-fsdevel+bounces-72163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98046CE675C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 12:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 670753019BED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 11:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB202FBDFF;
	Mon, 29 Dec 2025 11:09:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62622F6591
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767006564; cv=none; b=dypT0wnF6Lae9kTu26o6wdyVuV4h0QJrXENrpU7JWulOJrhN2SWwp1WmVKDhwipdunDi5Jr6AGIP7UyzwGF/DNDnohnz4pgFxezslh3JhGN64aG6gSHKeHSB40C2UWOjSt4cDrEkVmSaYBqBf8UF1sy7Y2zB0bs1uXR77Dc6Ooo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767006564; c=relaxed/simple;
	bh=ffji4RkeEvXMyw5J6CpXWv/+w1iXFRzib5UYcEaRJEc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PyqA1z6CordjyJox9Az1S/w4T0LVF6WTqMU06+YcHDanvjTXIHo8sxzooEtajUZRGkQYT6L2cr2pCRDfv+OW196OEp6FxFP5x2/VS5T+yBvCOi4d2Ch2r9GCPZRnj65ec8tZ1l2aTiiBb6i+1ZGsDjxcKSLn7r0P8BzbszMWXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-656cc4098f3so16009230eaf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 03:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767006560; x=1767611360;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hWtDHSOaZnbXA44WZjE9jD/N4CGXcyteHCp/hI3SICE=;
        b=JH2hCJAk8z0Z4LiFIA2JjvsN8kSnAcyijXpQUgThIZiuZosHui6aSAK+jdlrS2oXs3
         QUdQHZcOOSIomn3sIQIlwCVKzjAHysAL58gyQDiJEGiU6dpLvueZhh10+38vk/arWj04
         B5hIZtsqrOKLz4KzEm1JXIqeIn9wHVfQz12BXgX6hpeqdbFvroLXWyTtt5Xc5GKQkgVA
         J23DsBUeeJmUKDO/wjGYLRvZnlgqONGzBSVV0iyMf9fOvIohrKqDbOuT9LEmWGjrEKEn
         9NofvrCCg+LdyVFw98IO3kP0gNXP9mnVNaz7DAvjNU9rl6nL8b0boRAgobIzQC30HkrK
         x6HA==
X-Forwarded-Encrypted: i=1; AJvYcCXdZkJuqqy+eOI0sAWI5hH+i5a4vbtkIU2BoFCHeC6HQC6B+X3S0UNc4AEekDEsvf0WMfNMxmO/pAUn2lN7@vger.kernel.org
X-Gm-Message-State: AOJu0YxUbNmZx+q8hMK9Hj2zOnQnY6l+FeC2NF3LvQDhHraFSCyEJG44
	jzb3yhgadbagumOo3OqtjYgxcR55F+plC7kS4xBFbyVVTUaWzZUy6btM+qZ7Pe/YT26XHHqsEFZ
	LxB/6PX12ew3qWV472cHMCyY+feRTmSsO8RgchR+7DNSilurlPq5a3wMpXCo=
X-Google-Smtp-Source: AGHT+IGif7D/maghvOrfeZu95l0/oRBQpv/4Z5NihcBGGr5Q4tXjklBDtIAV4KmqChQtL45+pdWWvaLqsn4LC/3Sh8o84EsjU3mS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:22a6:b0:659:9a49:900c with SMTP id
 006d021491bc7-65d0eaa14d5mr14425801eaf.57.1767006560567; Mon, 29 Dec 2025
 03:09:20 -0800 (PST)
Date: Mon, 29 Dec 2025 03:09:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69526160.050a0220.3b1790.0006.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] possible deadlock in flush_end_io
From: syzbot <syzbot+56189401febf7b380090@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f0b4cce4481 Linux 6.19-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10f58422580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a8594efdc14f07a
dashboard link: https://syzkaller.appspot.com/bug?extid=56189401febf7b380090
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cd4f5f43efc8/disk-8f0b4cce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aafb35ac3a3c/vmlinux-8f0b4cce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d221fae4ab17/Image-8f0b4cce.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+56189401febf7b380090@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
syzkaller #0 Not tainted
-----------------------------------------------------
ksoftirqd/0/15 [HC0[0]:SC1[1]:HE0:SE0] is trying to acquire:
ffff0000f9020240 (&xa->xa_lock#10){..-.}-{3:3}, at: __folio_end_writeback+0x10c/0x6f8 mm/page-writeback.c:2990

and this task is already holding:
ffff0000c6004818 (&fq->mq_flush_lock){-.-.}-{3:3}, at: flush_end_io+0xb4/0xd68 block/blk-flush.c:211
which would create a new lock dependency:
 (&fq->mq_flush_lock){-.-.}-{3:3} -> (&xa->xa_lock#10){..-.}-{3:3}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&fq->mq_flush_lock){-.-.}-{3:3}

... which became HARDIRQ-irq-safe at:
  lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
  flush_end_io+0xb4/0xd68 block/blk-flush.c:211
  __blk_mq_end_request+0x37c/0x57c block/blk-mq.c:1159
  blk_mq_end_request+0x68/0x88 block/blk-mq.c:1171
  nvme_end_req drivers/nvme/host/core.c:454 [inline]
  nvme_complete_rq+0x150/0x464 drivers/nvme/host/core.c:-1
  nvme_pci_complete_rq drivers/nvme/host/pci.c:1343 [inline]
  nvme_handle_cqe drivers/nvme/host/pci.c:1407 [inline]
  nvme_poll_cq+0x644/0x1018 drivers/nvme/host/pci.c:1434
  nvme_irq+0x90/0x240 drivers/nvme/host/pci.c:1448
  __handle_irq_event_percpu+0x20c/0x8e4 kernel/irq/handle.c:211
  handle_irq_event_percpu kernel/irq/handle.c:248 [inline]
  handle_irq_event+0x9c/0x1d0 kernel/irq/handle.c:265
  handle_fasteoi_irq+0x328/0x8d8 kernel/irq/chip.c:764
  generic_handle_irq_desc include/linux/irqdesc.h:172 [inline]
  handle_irq_desc kernel/irq/irqdesc.c:669 [inline]
  generic_handle_domain_irq+0xe0/0x140 kernel/irq/irqdesc.c:725
  __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
  __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:876 [inline]
  gic_handle_irq+0x6c/0x18c drivers/irqchip/irq-gic-v3.c:920
  call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
  do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:135
  __el1_irq arch/arm64/kernel/entry-common.c:497 [inline]
  el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:510
  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
  el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
  __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline]
  arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline]
  raw_spin_rq_unlock_irq kernel/sched/sched.h:1570 [inline]
  finish_lock_switch+0xb4/0x1c0 kernel/sched/core.c:4995
  finish_task_switch+0x104/0x5dc kernel/sched/core.c:5112
  context_switch kernel/sched/core.c:5259 [inline]
  __schedule+0x1254/0x2a7c kernel/sched/core.c:6863
  __schedule_loop kernel/sched/core.c:6945 [inline]
  schedule+0xb4/0x230 kernel/sched/core.c:6960
  schedule_hrtimeout_range_clock+0x19c/0x2b4 kernel/time/sleep_timeout.c:207
  schedule_hrtimeout_range+0x38/0x4c kernel/time/sleep_timeout.c:263
  ep_poll+0xa70/0xd38 fs/eventpoll.c:2028
  do_epoll_wait+0x194/0x204 fs/eventpoll.c:2461
  do_epoll_pwait+0x70/0x18c fs/eventpoll.c:2491
  __do_sys_epoll_pwait fs/eventpoll.c:2504 [inline]
  __se_sys_epoll_pwait fs/eventpoll.c:2498 [inline]
  __arm64_sys_epoll_pwait+0x1e0/0x234 fs/eventpoll.c:2498
  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
  invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
  el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
  el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
  el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

to a HARDIRQ-irq-unsafe lock:
 (&p->sequence){+.-.}-{0:0}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
  do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
  do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
  fprop_new_period+0x3b8/0x718 lib/flex_proportions.c:74
  writeout_period+0x94/0x11c mm/page-writeback.c:615
  call_timer_fn+0x19c/0x814 kernel/time/timer.c:1748
  expire_timers kernel/time/timer.c:1799 [inline]
  __run_timers kernel/time/timer.c:2373 [inline]
  __run_timer_base+0x51c/0x76c kernel/time/timer.c:2385
  run_timer_base kernel/time/timer.c:2394 [inline]
  run_timer_softirq+0x11c/0x194 kernel/time/timer.c:2405
  handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
  __do_softirq+0x14/0x20 kernel/softirq.c:656
  ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
  call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
  do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:73
  invoke_softirq kernel/softirq.c:503 [inline]
  __irq_exit_rcu+0x1b0/0x478 kernel/softirq.c:723
  irq_exit_rcu+0x14/0x84 kernel/softirq.c:739
  __el1_irq arch/arm64/kernel/entry-common.c:498 [inline]
  el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:510
  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
  el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
  __sanitizer_cov_trace_const_cmp4+0x4/0xa0 kernel/kcov.c:313
  d_absolute_path+0xa0/0x148 fs/d_path.c:234
  tomoyo_get_absolute_path security/tomoyo/realpath.c:101 [inline]
  tomoyo_realpath_from_path+0x258/0x4d4 security/tomoyo/realpath.c:271
  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
  tomoyo_path_perm+0x1c4/0x3dc security/tomoyo/file.c:822
  tomoyo_inode_getattr+0x28/0x38 security/tomoyo/tomoyo.c:123
  security_inode_getattr+0x118/0x300 security/security.c:1869
  vfs_getattr fs/stat.c:259 [inline]
  vfs_statx_path fs/stat.c:299 [inline]
  vfs_statx+0x178/0x4bc fs/stat.c:356
  vfs_fstatat+0x100/0x150 fs/stat.c:375
  __do_sys_newfstatat fs/stat.c:542 [inline]
  __se_sys_newfstatat fs/stat.c:536 [inline]
  __arm64_sys_newfstatat+0x100/0x180 fs/stat.c:536
  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
  invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
  el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
  el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
  el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

other info that might help us debug this:

Chain exists of:
  &fq->mq_flush_lock --> &xa->xa_lock#10 --> &p->sequence

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&p->sequence);
                               local_irq_disable();
                               lock(&fq->mq_flush_lock);
                               lock(&xa->xa_lock#10);
  <Interrupt>
    lock(&fq->mq_flush_lock);

 *** DEADLOCK ***

1 lock held by ksoftirqd/0/15:
 #0: ffff0000c6004818 (&fq->mq_flush_lock){-.-.}-{3:3}, at: flush_end_io+0xb4/0xd68 block/blk-flush.c:211

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&fq->mq_flush_lock){-.-.}-{3:3} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
                    flush_end_io+0xb4/0xd68 block/blk-flush.c:211
                    __blk_mq_end_request+0x37c/0x57c block/blk-mq.c:1159
                    blk_mq_end_request+0x68/0x88 block/blk-mq.c:1171
                    nvme_end_req drivers/nvme/host/core.c:454 [inline]
                    nvme_complete_rq+0x150/0x464 drivers/nvme/host/core.c:-1
                    nvme_pci_complete_rq drivers/nvme/host/pci.c:1343 [inline]
                    nvme_handle_cqe drivers/nvme/host/pci.c:1407 [inline]
                    nvme_poll_cq+0x644/0x1018 drivers/nvme/host/pci.c:1434
                    nvme_irq+0x90/0x240 drivers/nvme/host/pci.c:1448
                    __handle_irq_event_percpu+0x20c/0x8e4 kernel/irq/handle.c:211
                    handle_irq_event_percpu kernel/irq/handle.c:248 [inline]
                    handle_irq_event+0x9c/0x1d0 kernel/irq/handle.c:265
                    handle_fasteoi_irq+0x328/0x8d8 kernel/irq/chip.c:764
                    generic_handle_irq_desc include/linux/irqdesc.h:172 [inline]
                    handle_irq_desc kernel/irq/irqdesc.c:669 [inline]
                    generic_handle_domain_irq+0xe0/0x140 kernel/irq/irqdesc.c:725
                    __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
                    __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:876 [inline]
                    gic_handle_irq+0x6c/0x18c drivers/irqchip/irq-gic-v3.c:920
                    call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
                    do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:135
                    __el1_irq arch/arm64/kernel/entry-common.c:497 [inline]
                    el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:510
                    el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
                    el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
                    __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline]
                    arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline]
                    raw_spin_rq_unlock_irq kernel/sched/sched.h:1570 [inline]
                    finish_lock_switch+0xb4/0x1c0 kernel/sched/core.c:4995
                    finish_task_switch+0x104/0x5dc kernel/sched/core.c:5112
                    context_switch kernel/sched/core.c:5259 [inline]
                    __schedule+0x1254/0x2a7c kernel/sched/core.c:6863
                    __schedule_loop kernel/sched/core.c:6945 [inline]
                    schedule+0xb4/0x230 kernel/sched/core.c:6960
                    schedule_hrtimeout_range_clock+0x19c/0x2b4 kernel/time/sleep_timeout.c:207
                    schedule_hrtimeout_range+0x38/0x4c kernel/time/sleep_timeout.c:263
                    ep_poll+0xa70/0xd38 fs/eventpoll.c:2028
                    do_epoll_wait+0x194/0x204 fs/eventpoll.c:2461
                    do_epoll_pwait+0x70/0x18c fs/eventpoll.c:2491
                    __do_sys_epoll_pwait fs/eventpoll.c:2504 [inline]
                    __se_sys_epoll_pwait fs/eventpoll.c:2498 [inline]
                    __arm64_sys_epoll_pwait+0x1e0/0x234 fs/eventpoll.c:2498
                    __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
                    invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
                    el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
                    do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
                    el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
                    el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
                    el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
   IN-SOFTIRQ-W at:
                    lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
                    mq_flush_data_end_io+0x270/0x480 block/blk-flush.c:355
                    __blk_mq_end_request+0x37c/0x57c block/blk-mq.c:1159
                    blk_mq_end_request+0x68/0x88 block/blk-mq.c:1171
                    lo_complete_rq+0x124/0x274 drivers/block/loop.c:314
                    blk_complete_reqs block/blk-mq.c:1244 [inline]
                    blk_done_softirq+0x11c/0x168 block/blk-mq.c:1249
                    handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
                    run_ksoftirqd+0x70/0xc0 kernel/softirq.c:1063
                    smpboot_thread_fn+0x4d8/0x9cc kernel/smpboot.c:160
                    kthread+0x5fc/0x75c kernel/kthread.c:463
                    ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
   INITIAL USE at:
                   lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0x58/0x70 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:376 [inline]
                   blk_insert_flush+0x360/0x4b8 block/blk-flush.c:454
                   blk_mq_submit_bio+0x1668/0x21e8 block/blk-mq.c:3229
                   __submit_bio+0x1d8/0x4d8 block/blk-core.c:637
                   __submit_bio_noacct_mq block/blk-core.c:724 [inline]
                   submit_bio_noacct_nocheck+0x274/0x990 block/blk-core.c:755
                   submit_bio_noacct+0xdc0/0x186c block/blk-core.c:879
                   submit_bio+0x3b4/0x550 block/blk-core.c:921
                   submit_bio_wait+0x104/0x208 block/bio.c:1391
                   blkdev_issue_flush+0xb4/0x100 block/blk-flush.c:473
                   ext4_init_inode_table+0x420/0x780 fs/ext4/ialloc.c:1602
                   ext4_run_li_request fs/ext4/super.c:3732 [inline]
                   ext4_lazyinit_thread+0x6dc/0x1730 fs/ext4/super.c:3827
                   kthread+0x5fc/0x75c kernel/kthread.c:463
                   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
 }
 ... key      at: [<ffff8000977c83c0>] blk_alloc_flush_queue.__key+0x0/0x20

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
 -> (&p->sequence){+.-.}-{0:0} {
    HARDIRQ-ON-W at:
                      lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
                      do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
                      do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
                      fprop_new_period+0x3b8/0x718 lib/flex_proportions.c:74
                      writeout_period+0x94/0x11c mm/page-writeback.c:615
                      call_timer_fn+0x19c/0x814 kernel/time/timer.c:1748
                      expire_timers kernel/time/timer.c:1799 [inline]
                      __run_timers kernel/time/timer.c:2373 [inline]
                      __run_timer_base+0x51c/0x76c kernel/time/timer.c:2385
                      run_timer_base kernel/time/timer.c:2394 [inline]
                      run_timer_softirq+0x11c/0x194 kernel/time/timer.c:2405
                      handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
                      __do_softirq+0x14/0x20 kernel/softirq.c:656
                      ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
                      call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
                      do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:73
                      invoke_softirq kernel/softirq.c:503 [inline]
                      __irq_exit_rcu+0x1b0/0x478 kernel/softirq.c:723
                      irq_exit_rcu+0x14/0x84 kernel/softirq.c:739
                      __el1_irq arch/arm64/kernel/entry-common.c:498 [inline]
                      el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:510
                      el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
                      el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
                      __sanitizer_cov_trace_const_cmp4+0x4/0xa0 kernel/kcov.c:313
                      d_absolute_path+0xa0/0x148 fs/d_path.c:234
                      tomoyo_get_absolute_path security/tomoyo/realpath.c:101 [inline]
                      tomoyo_realpath_from_path+0x258/0x4d4 security/tomoyo/realpath.c:271
                      tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
                      tomoyo_path_perm+0x1c4/0x3dc security/tomoyo/file.c:822
                      tomoyo_inode_getattr+0x28/0x38 security/tomoyo/tomoyo.c:123
                      security_inode_getattr+0x118/0x300 security/security.c:1869
                      vfs_getattr fs/stat.c:259 [inline]
                      vfs_statx_path fs/stat.c:299 [inline]
                      vfs_statx+0x178/0x4bc fs/stat.c:356
                      vfs_fstatat+0x100/0x150 fs/stat.c:375
                      __do_sys_newfstatat fs/stat.c:542 [inline]
                      __se_sys_newfstatat fs/stat.c:536 [inline]
                      __arm64_sys_newfstatat+0x100/0x180 fs/stat.c:536
                      __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
                      invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
                      el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
                      do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
                      el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
                      el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
                      el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
    IN-SOFTIRQ-W at:
                      lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
                      do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
                      do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
                      fprop_new_period+0x3b8/0x718 lib/flex_proportions.c:74
                      writeout_period+0x94/0x11c mm/page-writeback.c:615
                      call_timer_fn+0x19c/0x814 kernel/time/timer.c:1748
                      expire_timers kernel/time/timer.c:1799 [inline]
                      __run_timers kernel/time/timer.c:2373 [inline]
                      __run_timer_base+0x51c/0x76c kernel/time/timer.c:2385
                      run_timer_base kernel/time/timer.c:2394 [inline]
                      run_timer_softirq+0x11c/0x194 kernel/time/timer.c:2405
                      handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
                      __do_softirq+0x14/0x20 kernel/softirq.c:656
                      ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
                      call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
                      do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:73
                      invoke_softirq kernel/softirq.c:503 [inline]
                      __irq_exit_rcu+0x1b0/0x478 kernel/softirq.c:723
                      irq_exit_rcu+0x14/0x84 kernel/softirq.c:739
                      __el1_irq arch/arm64/kernel/entry-common.c:498 [inline]
                      el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:510
                      el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
                      el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
                      __sanitizer_cov_trace_const_cmp4+0x4/0xa0 kernel/kcov.c:313
                      d_absolute_path+0xa0/0x148 fs/d_path.c:234
                      tomoyo_get_absolute_path security/tomoyo/realpath.c:101 [inline]
                      tomoyo_realpath_from_path+0x258/0x4d4 security/tomoyo/realpath.c:271
                      tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
                      tomoyo_path_perm+0x1c4/0x3dc security/tomoyo/file.c:822
                      tomoyo_inode_getattr+0x28/0x38 security/tomoyo/tomoyo.c:123
                      security_inode_getattr+0x118/0x300 security/security.c:1869
                      vfs_getattr fs/stat.c:259 [inline]
                      vfs_statx_path fs/stat.c:299 [inline]
                      vfs_statx+0x178/0x4bc fs/stat.c:356
                      vfs_fstatat+0x100/0x150 fs/stat.c:375
                      __do_sys_newfstatat fs/stat.c:542 [inline]
                      __se_sys_newfstatat fs/stat.c:536 [inline]
                      __arm64_sys_newfstatat+0x100/0x180 fs/stat.c:536
                      __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
                      invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
                      el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
                      do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
                      el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
                      el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
                      el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
    INITIAL USE at:
                     lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
                     do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
                     do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
                     fprop_new_period+0x3b8/0x718 lib/flex_proportions.c:74
                     writeout_period+0x94/0x11c mm/page-writeback.c:615
                     call_timer_fn+0x19c/0x814 kernel/time/timer.c:1748
                     expire_timers kernel/time/timer.c:1799 [inline]
                     __run_timers kernel/time/timer.c:2373 [inline]
                     __run_timer_base+0x51c/0x76c kernel/time/timer.c:2385
                     run_timer_base kernel/time/timer.c:2394 [inline]
                     run_timer_softirq+0x11c/0x194 kernel/time/timer.c:2405
                     handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
                     __do_softirq+0x14/0x20 kernel/softirq.c:656
                     ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
                     call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
                     do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:73
                     invoke_softirq kernel/softirq.c:503 [inline]
                     __irq_exit_rcu+0x1b0/0x478 kernel/softirq.c:723
                     irq_exit_rcu+0x14/0x84 kernel/softirq.c:739
                     __el1_irq arch/arm64/kernel/entry-common.c:498 [inline]
                     el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:510
                     el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
                     el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
                     __sanitizer_cov_trace_const_cmp4+0x4/0xa0 kernel/kcov.c:313
                     d_absolute_path+0xa0/0x148 fs/d_path.c:234
                     tomoyo_get_absolute_path security/tomoyo/realpath.c:101 [inline]
                     tomoyo_realpath_from_path+0x258/0x4d4 security/tomoyo/realpath.c:271
                     tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
                     tomoyo_path_perm+0x1c4/0x3dc security/tomoyo/file.c:822
                     tomoyo_inode_getattr+0x28/0x38 security/tomoyo/tomoyo.c:123
                     security_inode_getattr+0x118/0x300 security/security.c:1869
                     vfs_getattr fs/stat.c:259 [inline]
                     vfs_statx_path fs/stat.c:299 [inline]
                     vfs_statx+0x178/0x4bc fs/stat.c:356
                     vfs_fstatat+0x100/0x150 fs/stat.c:375
                     __do_sys_newfstatat fs/stat.c:542 [inline]
                     __se_sys_newfstatat fs/stat.c:536 [inline]
                     __arm64_sys_newfstatat+0x100/0x180 fs/stat.c:536
                     __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
                     invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
                     el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
                     do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
                     el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
                     el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
                     el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
    INITIAL READ USE at:
                          lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
                          seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
                          fprop_fraction_percpu+0xac/0x270 lib/flex_proportions.c:155
                          __wb_calc_thresh+0xfc/0x3b0 mm/page-writeback.c:913
                          wb_bg_dirty_limits mm/page-writeback.c:2130 [inline]
                          domain_over_bg_thresh+0xb8/0x1f0 mm/page-writeback.c:2144
                          wb_over_bg_thresh+0xf8/0x17c mm/page-writeback.c:2165
                          wb_check_background_flush fs/fs-writeback.c:2278 [inline]
                          wb_do_writeback fs/fs-writeback.c:2376 [inline]
                          wb_workfn+0xa30/0xdc0 fs/fs-writeback.c:2403
                          process_one_work+0x7c0/0x1558 kernel/workqueue.c:3257
                          process_scheduled_works kernel/workqueue.c:3340 [inline]
                          worker_thread+0x958/0xed8 kernel/workqueue.c:3421
                          kthread+0x5fc/0x75c kernel/kthread.c:463
                          ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
  }
  ... key      at: [<ffff800097b99300>] fprop_global_init.__key.1+0x0/0x20
  ... acquired at:
   seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
   fprop_fraction_percpu+0xf0/0x270 lib/flex_proportions.c:155
   __fprop_add_percpu_max+0x130/0x1f4 lib/flex_proportions.c:186
   wb_domain_writeout_add mm/page-writeback.c:562 [inline]
   __wb_writeout_add+0xbc/0x27c mm/page-writeback.c:586
   __folio_end_writeback+0x380/0x6f8 mm/page-writeback.c:2997
   folio_end_writeback_no_dropbehind+0xd0/0x204 mm/filemap.c:1661
   folio_end_writeback+0xd8/0x248 mm/filemap.c:1687
   iomap_finish_folio_write+0x1c0/0x2a4 fs/iomap/buffered-io.c:1713
   fuse_writepage_finish fs/fuse/file.c:1903 [inline]
   fuse_send_writepage fs/fuse/file.c:1954 [inline]
   fuse_flush_writepages+0x578/0x788 fs/fuse/file.c:1979
   fuse_writepages_send fs/fuse/file.c:2158 [inline]
   fuse_iomap_writeback_submit+0x188/0x220 fs/fuse/file.c:2260
   iomap_writepages+0x1dc/0x25c fs/iomap/buffered-io.c:1916
   fuse_writepages+0x208/0x2bc fs/fuse/file.c:2295
   do_writepages+0x270/0x468 mm/page-writeback.c:2598
   filemap_writeback mm/filemap.c:387 [inline]
   filemap_fdatawrite_range mm/filemap.c:412 [inline]
   file_write_and_wait_range+0x1d0/0x2c4 mm/filemap.c:786
   fuse_fsync+0x100/0x2b8 fs/fuse/file.c:547
   vfs_fsync_range+0x160/0x19c fs/sync.c:188
   generic_write_sync include/linux/fs.h:2616 [inline]
   fuse_cache_write_iter fs/fuse/file.c:1527 [inline]
   fuse_file_write_iter+0xa20/0xb88 fs/fuse/file.c:1849
   do_iter_readv_writev+0x4bc/0x720 fs/read_write.c:-1
   vfs_writev+0x29c/0x7cc fs/read_write.c:1057
   do_writev+0x128/0x290 fs/read_write.c:1103
   __do_sys_writev fs/read_write.c:1171 [inline]
   __se_sys_writev fs/read_write.c:1168 [inline]
   __arm64_sys_writev+0x80/0x94 fs/read_write.c:1168
   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
   invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
   el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
   do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
   el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
   el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
   el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

-> (&xa->xa_lock#10){..-.}-{3:3} {
   IN-SOFTIRQ-W at:
                    lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
                    __folio_end_writeback+0x10c/0x6f8 mm/page-writeback.c:2990
                    folio_end_writeback_no_dropbehind+0xd0/0x204 mm/filemap.c:1661
                    folio_end_writeback+0xd8/0x248 mm/filemap.c:1687
                    end_buffer_async_write+0x20c/0x350 fs/buffer.c:419
                    end_bio_bh_io_sync+0xb0/0x184 fs/buffer.c:2776
                    bio_endio+0x8d4/0x910 block/bio.c:1675
                    blk_update_request+0x474/0xba8 block/blk-mq.c:1007
                    blk_mq_end_request+0x54/0x88 block/blk-mq.c:1169
                    lo_complete_rq+0x124/0x274 drivers/block/loop.c:314
                    blk_complete_reqs block/blk-mq.c:1244 [inline]
                    blk_done_softirq+0x11c/0x168 block/blk-mq.c:1249
                    handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
                    run_ksoftirqd+0x70/0xc0 kernel/softirq.c:1063
                    smpboot_thread_fn+0x4d8/0x9cc kernel/smpboot.c:160
                    kthread+0x5fc/0x75c kernel/kthread.c:463
                    ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
   INITIAL USE at:
                   lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0x58/0x70 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:376 [inline]
                   shmem_add_to_page_cache+0x564/0xa24 mm/shmem.c:904
                   shmem_alloc_and_add_folio+0x758/0x10c4 mm/shmem.c:1958
                   shmem_get_folio_gfp+0x4d4/0x159c mm/shmem.c:2556
                   shmem_read_folio_gfp+0x8c/0xf0 mm/shmem.c:5974
                   drm_gem_get_pages+0x1cc/0x7c0 drivers/gpu/drm/drm_gem.c:654
                   drm_gem_shmem_get_pages_locked+0x1d4/0x364 drivers/gpu/drm/drm_gem_shmem_helper.c:239
                   drm_gem_shmem_pin_locked+0x1f8/0x410 drivers/gpu/drm/drm_gem_shmem_helper.c:300
                   drm_gem_shmem_vmap_locked+0x3cc/0x658 drivers/gpu/drm/drm_gem_shmem_helper.c:404
                   drm_gem_shmem_object_vmap+0x28/0x38 include/drm/drm_gem_shmem_helper.h:245
                   drm_gem_vmap_locked drivers/gpu/drm/drm_gem.c:1269 [inline]
                   drm_gem_vmap+0x104/0x1d8 drivers/gpu/drm/drm_gem.c:1311
                   drm_client_buffer_vmap+0x68/0xb0 drivers/gpu/drm/drm_client.c:355
                   drm_fbdev_shmem_driver_fbdev_probe+0x1f4/0x700 drivers/gpu/drm/drm_fbdev_shmem.c:159
                   drm_fb_helper_single_fb_probe drivers/gpu/drm/drm_fb_helper.c:1562 [inline]
                   __drm_fb_helper_initial_config_and_unlock+0x108c/0x1728 drivers/gpu/drm/drm_fb_helper.c:1741
                   drm_fb_helper_initial_config+0x3c/0x58 drivers/gpu/drm/drm_fb_helper.c:1828
                   drm_fbdev_client_hotplug+0x154/0x22c drivers/gpu/drm/clients/drm_fbdev_client.c:66
                   drm_client_register+0x13c/0x1d4 drivers/gpu/drm/drm_client.c:143
                   drm_fbdev_client_setup+0x194/0x3d0 drivers/gpu/drm/clients/drm_fbdev_client.c:168
                   drm_client_setup+0x114/0x228 drivers/gpu/drm/clients/drm_client_setup.c:46
                   vkms_create+0x370/0x420 drivers/gpu/drm/vkms/vkms_drv.c:211
                   vkms_init+0x64/0x9c drivers/gpu/drm/vkms/vkms_drv.c:239
                   do_one_initcall+0x248/0x9b4 init/main.c:1378
                   do_initcall_level+0x128/0x1c4 init/main.c:1440
                   do_initcalls+0x70/0xd0 init/main.c:1456
                   do_basic_setup+0x78/0x8c init/main.c:1475
                   kernel_init_freeable+0x268/0x39c init/main.c:1688
                   kernel_init+0x24/0x1dc init/main.c:1578
                   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
 }
 ... key      at: [<ffff800097649620>] xa_init_flags.__key+0x0/0x20
 ... acquired at:
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
   __folio_end_writeback+0x10c/0x6f8 mm/page-writeback.c:2990
   folio_end_writeback_no_dropbehind+0xd0/0x204 mm/filemap.c:1661
   folio_end_writeback+0xd8/0x248 mm/filemap.c:1687
   f2fs_write_end_io+0x6c0/0xa78 fs/f2fs/data.c:362
   bio_endio+0x8d4/0x910 block/bio.c:1675
   blk_update_request+0x474/0xba8 block/blk-mq.c:1007
   blk_mq_end_request+0x54/0x88 block/blk-mq.c:1169
   blk_flush_complete_seq+0x57c/0xad4 block/blk-flush.c:191
   flush_end_io+0x9e8/0xd68 block/blk-flush.c:250
   __blk_mq_end_request+0x37c/0x57c block/blk-mq.c:1159
   blk_mq_end_request+0x68/0x88 block/blk-mq.c:1171
   lo_complete_rq+0x124/0x274 drivers/block/loop.c:314
   blk_complete_reqs block/blk-mq.c:1244 [inline]
   blk_done_softirq+0x11c/0x168 block/blk-mq.c:1249
   handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
   run_ksoftirqd+0x70/0xc0 kernel/softirq.c:1063
   smpboot_thread_fn+0x4d8/0x9cc kernel/smpboot.c:160
   kthread+0x5fc/0x75c kernel/kthread.c:463
   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844


stack backtrace:
CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_bad_irq_dependency kernel/locking/lockdep.c:2616 [inline]
 check_irq_usage kernel/locking/lockdep.c:2857 [inline]
 check_prev_add kernel/locking/lockdep.c:3169 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x3058/0x30a4 kernel/locking/lockdep.c:5237
 lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
 __folio_end_writeback+0x10c/0x6f8 mm/page-writeback.c:2990
 folio_end_writeback_no_dropbehind+0xd0/0x204 mm/filemap.c:1661
 folio_end_writeback+0xd8/0x248 mm/filemap.c:1687
 f2fs_write_end_io+0x6c0/0xa78 fs/f2fs/data.c:362
 bio_endio+0x8d4/0x910 block/bio.c:1675
 blk_update_request+0x474/0xba8 block/blk-mq.c:1007
 blk_mq_end_request+0x54/0x88 block/blk-mq.c:1169
 blk_flush_complete_seq+0x57c/0xad4 block/blk-flush.c:191
 flush_end_io+0x9e8/0xd68 block/blk-flush.c:250
 __blk_mq_end_request+0x37c/0x57c block/blk-mq.c:1159
 blk_mq_end_request+0x68/0x88 block/blk-mq.c:1171
 lo_complete_rq+0x124/0x274 drivers/block/loop.c:314
 blk_complete_reqs block/blk-mq.c:1244 [inline]
 blk_done_softirq+0x11c/0x168 block/blk-mq.c:1249
 handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
 run_ksoftirqd+0x70/0xc0 kernel/softirq.c:1063
 smpboot_thread_fn+0x4d8/0x9cc kernel/smpboot.c:160
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

