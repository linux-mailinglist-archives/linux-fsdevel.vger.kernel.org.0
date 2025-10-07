Return-Path: <linux-fsdevel+bounces-63565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBE3BC2BB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 23:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973C13C8202
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 21:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131E724634F;
	Tue,  7 Oct 2025 21:19:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83126229B1F
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759871972; cv=none; b=LJUfDt1RuGmSNnKmKXW/ji9WuQ1RqaUwEaQTg/x48oNdGT91IsMtBb4UsxI5LNzguT+I83gvZcuJM3zfUye0QsY19SPsF1vVap3l+qc0biY0B4m4Fd3Mx8ku1dfmvVqBzOUYby/twwtyDvJQnkhLRRI6y+Kkl5Q5wYNAnD3ugj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759871972; c=relaxed/simple;
	bh=DtOVuMEbxLgdnUrYvvT/xNfBvIuUijcJR91Q4DlGoSQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QJ1erR/VxGfPRbly7VJ67FEMhXNEXtwsteBnsqEq5mzNB4W0+9bt2pxNoX0vQ3HdzzN1+mDcOyNGc7qXdmA+jNesgF/RRz5hdEXiqKB3REuO4XbS6emjhUFCP+1EGKi+xkD55mCooYRakUGxTqBFi2BY8KAVZtAa6/U8qP4Wnoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-91e1d4d0976so1756495339f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 14:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759871969; x=1760476769;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShHCYOodBDNFzzMlGiRMqwNQ9s0/RlmoGajumCuww7s=;
        b=pdhf37Q7ytkrPdGwkKbWkjcAQf9H8GYgjd3RHuQ98HsSgTNsB6xACPDXgUnBMG+Y0h
         yFvaRMvLP9VZIsDXAc084ZDpmvPq3pfyccbnf6HR9YBdBF229SZIeTEfVsBMPLzjw32D
         fto70aPOX2KqJdX9j9vXeK1Olq07tOVpwwixE8vG5fC2kjdeY6Blx9eLuUQdiPVFnR+d
         O+zOVi1RYxtvzyTpt03dXvFMHKIDPQ+N7I330iWdD84OAFL+5tpJhldTMOZktnAd3dlm
         2P17YqwqhPJtngbUoVq8ecJUSmuowtqXnwpaZDZRsZm7eGpoUUcHDMZycc3835+4EGEX
         QKaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHjV/jTXqv8M7Slg0ev9s+HyV8VsBDm+g2OaS8ZlqKPz+YhOjbcHANCazQSQ6LT8rsAuwDOw1VYeWtU27k@vger.kernel.org
X-Gm-Message-State: AOJu0YxWOg1DT3vM/DFGAjEvl3d2lACDGSe8rSwaI1O2o7U79K8Pbiy/
	NXOPhC4VXGydSlxgzHw88oNFGBgxj0gJFeaC0be/z7F/GrBmoPt94RdrWnZFVsxt0zTL3hL429a
	PFpFsiv37B7OyP83pLEW0F3kvMu1L1n/V5f+i6s/+tHr8+P/d/lEINNDQRMs=
X-Google-Smtp-Source: AGHT+IGbOdYVTE9pQ+l4YTwccnYczhfj0d+/cf4vQhyeoaUCFXoiyc8eW5YS8slAosdn62Y2PEw1NPLX6l0M/GniQO0RmVdSTk4I
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d81:b0:8e3:2d3d:9a7d with SMTP id
 ca18e2360f4ac-93bd19a9a40mr98350239f.18.1759871969687; Tue, 07 Oct 2025
 14:19:29 -0700 (PDT)
Date: Tue, 07 Oct 2025 14:19:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e583e1.a00a0220.298cc0.0485.GAE@google.com>
Subject: [syzbot] [fuse?] possible deadlock in __folio_end_writeback
From: syzbot <syzbot+27727256237e6bdd3649@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cbf33b8e0b36 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a25ee2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b4263e12240e6e1
dashboard link: https://syzkaller.appspot.com/bug?extid=27727256237e6bdd3649
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14eaea7c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134c4304580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-cbf33b8e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/54786e46ef23/vmlinux-cbf33b8e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd6f88ce083b/bzImage-cbf33b8e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27727256237e6bdd3649@syzkaller.appspotmail.com

wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
syzkaller #0 Not tainted
-----------------------------------------------------
kworker/u4:0/12 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffffffff995aa110 (&p->sequence){+.-.}-{0:0}, at: __fprop_add_percpu_max+0x10d/0x210 lib/flex_proportions.c:186

and this task is already holding:
ffff888040a24240 (&xa->xa_lock#12){-...}-{3:3}, at: __folio_end_writeback+0x1da/0x950 mm/page-writeback.c:2996
which would create a new lock dependency:
 (&xa->xa_lock#12){-...}-{3:3} -> (&p->sequence){+.-.}-{0:0}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&xa->xa_lock#12){-...}-{3:3}

... which became HARDIRQ-irq-safe at:
  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
  __folio_end_writeback+0x1da/0x950 mm/page-writeback.c:2996
  folio_end_writeback_no_dropbehind+0x151/0x290 mm/filemap.c:1668
  folio_end_writeback+0xea/0x220 mm/filemap.c:1694
  end_bio_bh_io_sync+0xba/0x120 fs/buffer.c:2776
  blk_update_request+0x57e/0xe60 block/blk-mq.c:998
  scsi_end_request+0x7c/0x830 drivers/scsi/scsi_lib.c:637
  scsi_io_completion+0x131/0x390 drivers/scsi/scsi_lib.c:1078
  ata_qc_complete_multiple+0x1ae/0x280 drivers/ata/libata-sata.c:789
  ahci_qc_complete drivers/ata/libahci.c:1887 [inline]
  ahci_handle_port_interrupt+0x3d5/0x610 drivers/ata/libahci.c:1954
  ahci_port_intr drivers/ata/libahci.c:1965 [inline]
  ahci_handle_port_intr+0x19f/0x2e0 drivers/ata/libahci.c:1996
  ahci_single_level_irq_intr+0x9b/0xe0 drivers/ata/libahci.c:2030
  __handle_irq_event_percpu+0x295/0xab0 kernel/irq/handle.c:203
  handle_irq_event_percpu kernel/irq/handle.c:240 [inline]
  handle_irq_event+0x8b/0x1e0 kernel/irq/handle.c:257
  handle_edge_irq+0x23b/0xa10 kernel/irq/chip.c:855
  generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
  handle_irq arch/x86/kernel/irq.c:254 [inline]
  call_irq_handler arch/x86/kernel/irq.c:-1 [inline]
  __common_interrupt+0x141/0x1f0 arch/x86/kernel/irq.c:325
  common_interrupt+0xb6/0xe0 arch/x86/kernel/irq.c:318
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
  _raw_spin_unlock_irqrestore+0xa8/0x110 kernel/locking/spinlock.c:194
  spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
  ata_scsi_queuecmd+0x3f0/0x5c0 drivers/ata/libata-scsi.c:4398
  scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1626 [inline]
  scsi_queue_rq+0x1c91/0x2cc0 drivers/scsi/scsi_lib.c:1868
  blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2129
  __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
  blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
  __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
  blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
  blk_mq_run_hw_queue+0x404/0x4f0 block/blk-mq.c:2367
  blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
  blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2976
  __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
  blk_finish_plug+0x5e/0x90 block/blk-core.c:1252
  wb_writeback+0xa80/0xaf0 fs/fs-writeback.c:2233
  wb_check_old_data_flush fs/fs-writeback.c:2301 [inline]
  wb_do_writeback fs/fs-writeback.c:2354 [inline]
  wb_workfn+0xaef/0xef0 fs/fs-writeback.c:2382
  process_one_work kernel/workqueue.c:3263 [inline]
  process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3346
  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
  kthread+0x70e/0x8a0 kernel/kthread.c:463
  ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

to a HARDIRQ-irq-unsafe lock:
 (&p->sequence){+.-.}-{0:0}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
  do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
  do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
  fprop_new_period+0x1a3/0x3a0 lib/flex_proportions.c:74
  writeout_period+0x8b/0x130 mm/page-writeback.c:615
  call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
  expire_timers kernel/time/timer.c:1798 [inline]
  __run_timers kernel/time/timer.c:2372 [inline]
  __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
  run_timer_base kernel/time/timer.c:2393 [inline]
  run_timer_softirq+0x103/0x180 kernel/time/timer.c:2404
  handle_softirqs+0x283/0x870 kernel/softirq.c:622
  run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
  smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
  kthread+0x70e/0x8a0 kernel/kthread.c:463
  ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&p->sequence);
                               local_irq_disable();
                               lock(&xa->xa_lock#12);
                               lock(&p->sequence);
  <Interrupt>
    lock(&xa->xa_lock#12);

 *** DEADLOCK ***

5 locks held by kworker/u4:0/12:
 #0: ffff888030f92948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff888030f92948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc900001e7bc0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc900001e7bc0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
 #2: ffff888000a240e0 (&type->s_umount_key#54){.+.+}-{4:4}, at: super_trylock_shared+0x20/0xf0 fs/super.c:562
 #3: ffff888040a24638 (&fi->lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #3: ffff888040a24638 (&fi->lock){+.+.}-{3:3}, at: fuse_writepages_send fs/fuse/file.c:2089 [inline]
 #3: ffff888040a24638 (&fi->lock){+.+.}-{3:3}, at: fuse_iomap_writeback_range+0x818/0x1800 fs/fuse/file.c:2150
 #4: ffff888040a24240 (&xa->xa_lock#12){-...}-{3:3}, at: __folio_end_writeback+0x1da/0x950 mm/page-writeback.c:2996

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&xa->xa_lock#12){-...}-{3:3} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
                    __folio_end_writeback+0x1da/0x950 mm/page-writeback.c:2996
                    folio_end_writeback_no_dropbehind+0x151/0x290 mm/filemap.c:1668
                    folio_end_writeback+0xea/0x220 mm/filemap.c:1694
                    end_bio_bh_io_sync+0xba/0x120 fs/buffer.c:2776
                    blk_update_request+0x57e/0xe60 block/blk-mq.c:998
                    scsi_end_request+0x7c/0x830 drivers/scsi/scsi_lib.c:637
                    scsi_io_completion+0x131/0x390 drivers/scsi/scsi_lib.c:1078
                    ata_qc_complete_multiple+0x1ae/0x280 drivers/ata/libata-sata.c:789
                    ahci_qc_complete drivers/ata/libahci.c:1887 [inline]
                    ahci_handle_port_interrupt+0x3d5/0x610 drivers/ata/libahci.c:1954
                    ahci_port_intr drivers/ata/libahci.c:1965 [inline]
                    ahci_handle_port_intr+0x19f/0x2e0 drivers/ata/libahci.c:1996
                    ahci_single_level_irq_intr+0x9b/0xe0 drivers/ata/libahci.c:2030
                    __handle_irq_event_percpu+0x295/0xab0 kernel/irq/handle.c:203
                    handle_irq_event_percpu kernel/irq/handle.c:240 [inline]
                    handle_irq_event+0x8b/0x1e0 kernel/irq/handle.c:257
                    handle_edge_irq+0x23b/0xa10 kernel/irq/chip.c:855
                    generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
                    handle_irq arch/x86/kernel/irq.c:254 [inline]
                    call_irq_handler arch/x86/kernel/irq.c:-1 [inline]
                    __common_interrupt+0x141/0x1f0 arch/x86/kernel/irq.c:325
                    common_interrupt+0xb6/0xe0 arch/x86/kernel/irq.c:318
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
                    __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
                    _raw_spin_unlock_irqrestore+0xa8/0x110 kernel/locking/spinlock.c:194
                    spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
                    ata_scsi_queuecmd+0x3f0/0x5c0 drivers/ata/libata-scsi.c:4398
                    scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1626 [inline]
                    scsi_queue_rq+0x1c91/0x2cc0 drivers/scsi/scsi_lib.c:1868
                    blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2129
                    __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
                    blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
                    __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
                    blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
                    blk_mq_run_hw_queue+0x404/0x4f0 block/blk-mq.c:2367
                    blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
                    blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2976
                    __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
                    blk_finish_plug+0x5e/0x90 block/blk-core.c:1252
                    wb_writeback+0xa80/0xaf0 fs/fs-writeback.c:2233
                    wb_check_old_data_flush fs/fs-writeback.c:2301 [inline]
                    wb_do_writeback fs/fs-writeback.c:2354 [inline]
                    wb_workfn+0xaef/0xef0 fs/fs-writeback.c:2382
                    process_one_work kernel/workqueue.c:3263 [inline]
                    process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3346
                    worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
                    kthread+0x70e/0x8a0 kernel/kthread.c:463
                    ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   INITIAL USE at:
                   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0xa2/0xf0 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:376 [inline]
                   shmem_add_to_page_cache+0x72d/0xba0 mm/shmem.c:887
                   shmem_alloc_and_add_folio+0x846/0xf60 mm/shmem.c:1936
                   shmem_get_folio_gfp+0x59d/0x1660 mm/shmem.c:2533
                   shmem_read_folio_gfp+0x8a/0xe0 mm/shmem.c:5931
                   drm_gem_get_pages+0x223/0xa20 drivers/gpu/drm/drm_gem.c:656
                   drm_gem_shmem_get_pages_locked+0x201/0x440 drivers/gpu/drm/drm_gem_shmem_helper.c:200
                   drm_gem_shmem_pin_locked+0x22c/0x460 drivers/gpu/drm/drm_gem_shmem_helper.c:261
                   drm_gem_shmem_vmap_locked+0x46b/0x790 drivers/gpu/drm/drm_gem_shmem_helper.c:365
                   drm_gem_vmap_locked drivers/gpu/drm/drm_gem.c:1279 [inline]
                   drm_gem_vmap+0x10a/0x1d0 drivers/gpu/drm/drm_gem.c:1321
                   drm_client_buffer_vmap+0x43/0x80 drivers/gpu/drm/drm_client.c:312
                   drm_fbdev_shmem_driver_fbdev_probe+0x258/0x900 drivers/gpu/drm/drm_fbdev_shmem.c:160
                   drm_fb_helper_single_fb_probe drivers/gpu/drm/drm_fb_helper.c:1650 [inline]
                   __drm_fb_helper_initial_config_and_unlock+0x1236/0x18a0 drivers/gpu/drm/drm_fb_helper.c:1830
                   drm_fbdev_client_hotplug+0x16c/0x230 drivers/gpu/drm/clients/drm_fbdev_client.c:52
                   drm_client_register+0x172/0x210 drivers/gpu/drm/drm_client.c:141
                   drm_fbdev_client_setup+0x19f/0x3f0 drivers/gpu/drm/clients/drm_fbdev_client.c:159
                   drm_client_setup+0x107/0x220 drivers/gpu/drm/clients/drm_client_setup.c:46
                   vkms_create drivers/gpu/drm/vkms/vkms_drv.c:201 [inline]
                   vkms_init+0x3e0/0x4b0 drivers/gpu/drm/vkms/vkms_drv.c:221
                   do_one_initcall+0x233/0x820 init/main.c:1283
                   do_initcall_level+0x104/0x190 init/main.c:1345
                   do_initcalls+0x59/0xa0 init/main.c:1361
                   kernel_init_freeable+0x334/0x4b0 init/main.c:1593
                   kernel_init+0x1d/0x1d0 init/main.c:1483
                   ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 }
 ... key      at: [<ffffffff995cb060>] xa_init_flags.__key+0x0/0x20

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&p->sequence){+.-.}-{0:0} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                    do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
                    do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
                    fprop_new_period+0x1a3/0x3a0 lib/flex_proportions.c:74
                    writeout_period+0x8b/0x130 mm/page-writeback.c:615
                    call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
                    expire_timers kernel/time/timer.c:1798 [inline]
                    __run_timers kernel/time/timer.c:2372 [inline]
                    __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
                    run_timer_base kernel/time/timer.c:2393 [inline]
                    run_timer_softirq+0x103/0x180 kernel/time/timer.c:2404
                    handle_softirqs+0x283/0x870 kernel/softirq.c:622
                    run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
                    smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
                    kthread+0x70e/0x8a0 kernel/kthread.c:463
                    ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   IN-SOFTIRQ-W at:
                    lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                    do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
                    do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
                    fprop_new_period+0x1a3/0x3a0 lib/flex_proportions.c:74
                    writeout_period+0x8b/0x130 mm/page-writeback.c:615
                    call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
                    expire_timers kernel/time/timer.c:1798 [inline]
                    __run_timers kernel/time/timer.c:2372 [inline]
                    __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
                    run_timer_base kernel/time/timer.c:2393 [inline]
                    run_timer_softirq+0x103/0x180 kernel/time/timer.c:2404
                    handle_softirqs+0x283/0x870 kernel/softirq.c:622
                    run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
                    smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
                    kthread+0x70e/0x8a0 kernel/kthread.c:463
                    ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   INITIAL USE at:
                   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                   do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
                   do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
                   fprop_new_period+0x1a3/0x3a0 lib/flex_proportions.c:74
                   writeout_period+0x8b/0x130 mm/page-writeback.c:615
                   call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
                   expire_timers kernel/time/timer.c:1798 [inline]
                   __run_timers kernel/time/timer.c:2372 [inline]
                   __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
                   run_timer_base kernel/time/timer.c:2393 [inline]
                   run_timer_softirq+0x103/0x180 kernel/time/timer.c:2404
                   handle_softirqs+0x283/0x870 kernel/softirq.c:622
                   run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
                   smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
                   kthread+0x70e/0x8a0 kernel/kthread.c:463
                   ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   INITIAL READ USE at:
                        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                        seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
                        fprop_fraction_percpu+0x170/0x400 lib/flex_proportions.c:155
                        __wb_calc_thresh+0x119/0x4a0 mm/page-writeback.c:913
                        wb_bg_dirty_limits mm/page-writeback.c:2130 [inline]
                        domain_over_bg_thresh mm/page-writeback.c:2144 [inline]
                        wb_over_bg_thresh+0x154/0x3d0 mm/page-writeback.c:2165
                        wb_check_background_flush fs/fs-writeback.c:2257 [inline]
                        wb_do_writeback fs/fs-writeback.c:2355 [inline]
                        wb_workfn+0xb1c/0xef0 fs/fs-writeback.c:2382
                        process_one_work kernel/workqueue.c:3263 [inline]
                        process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3346
                        worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
                        kthread+0x70e/0x8a0 kernel/kthread.c:463
                        ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
                        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 }
 ... key      at: [<ffffffff99ac9760>] fprop_global_init.__key.1+0x0/0x20
 ... acquired at:
   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
   seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
   fprop_fraction_percpu+0x130/0x400 lib/flex_proportions.c:155
   __fprop_add_percpu_max+0x10d/0x210 lib/flex_proportions.c:186
   wb_domain_writeout_add mm/page-writeback.c:562 [inline]
   __wb_writeout_add+0xa5/0x290 mm/page-writeback.c:586
   __folio_end_writeback+0x4d5/0x950 mm/page-writeback.c:3003
   folio_end_writeback_no_dropbehind+0x151/0x290 mm/filemap.c:1668
   folio_end_writeback+0xea/0x220 mm/filemap.c:1694
   fuse_writepage_finish fs/fuse/file.c:1837 [inline]
   fuse_send_writepage fs/fuse/file.c:1887 [inline]
   fuse_flush_writepages+0x6c8/0x900 fs/fuse/file.c:1912
   fuse_writepages_send fs/fuse/file.c:2091 [inline]
   fuse_iomap_writeback_range+0x923/0x1800 fs/fuse/file.c:2150
   iomap_writeback_range fs/iomap/buffered-io.c:1593 [inline]
   iomap_writeback_folio+0xe72/0x1c80 fs/iomap/buffered-io.c:1718
   iomap_writepages+0x162/0x2d0 fs/iomap/buffered-io.c:1770
   fuse_writepages+0x2ad/0x380 fs/fuse/file.c:2220
   do_writepages+0x32b/0x550 mm/page-writeback.c:2604
   __writeback_single_inode+0x145/0xff0 fs/fs-writeback.c:1719
   writeback_sb_inodes+0x6c7/0x1010 fs/fs-writeback.c:2015
   __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2086
   wb_writeback+0x44f/0xaf0 fs/fs-writeback.c:2197
   wb_check_background_flush fs/fs-writeback.c:2267 [inline]
   wb_do_writeback fs/fs-writeback.c:2355 [inline]
   wb_workfn+0xb63/0xef0 fs/fs-writeback.c:2382
   process_one_work kernel/workqueue.c:3263 [inline]
   process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3346
   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
   kthread+0x70e/0x8a0 kernel/kthread.c:463
   ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245


stack backtrace:
CPU: 0 UID: 0 PID: 12 Comm: kworker/u4:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-0:42)
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_bad_irq_dependency kernel/locking/lockdep.c:2616 [inline]
 check_irq_usage kernel/locking/lockdep.c:2857 [inline]
 check_prev_add kernel/locking/lockdep.c:3169 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0x1f05/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
 fprop_fraction_percpu+0x130/0x400 lib/flex_proportions.c:155
 __fprop_add_percpu_max+0x10d/0x210 lib/flex_proportions.c:186
 wb_domain_writeout_add mm/page-writeback.c:562 [inline]
 __wb_writeout_add+0xa5/0x290 mm/page-writeback.c:586
 __folio_end_writeback+0x4d5/0x950 mm/page-writeback.c:3003
 folio_end_writeback_no_dropbehind+0x151/0x290 mm/filemap.c:1668
 folio_end_writeback+0xea/0x220 mm/filemap.c:1694
 fuse_writepage_finish fs/fuse/file.c:1837 [inline]
 fuse_send_writepage fs/fuse/file.c:1887 [inline]
 fuse_flush_writepages+0x6c8/0x900 fs/fuse/file.c:1912
 fuse_writepages_send fs/fuse/file.c:2091 [inline]
 fuse_iomap_writeback_range+0x923/0x1800 fs/fuse/file.c:2150
 iomap_writeback_range fs/iomap/buffered-io.c:1593 [inline]
 iomap_writeback_folio+0xe72/0x1c80 fs/iomap/buffered-io.c:1718
 iomap_writepages+0x162/0x2d0 fs/iomap/buffered-io.c:1770
 fuse_writepages+0x2ad/0x380 fs/fuse/file.c:2220
 do_writepages+0x32b/0x550 mm/page-writeback.c:2604
 __writeback_single_inode+0x145/0xff0 fs/fs-writeback.c:1719
 writeback_sb_inodes+0x6c7/0x1010 fs/fs-writeback.c:2015
 __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2086
 wb_writeback+0x44f/0xaf0 fs/fs-writeback.c:2197
 wb_check_background_flush fs/fs-writeback.c:2267 [inline]
 wb_do_writeback fs/fs-writeback.c:2355 [inline]
 wb_workfn+0xb63/0xef0 fs/fs-writeback.c:2382
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

