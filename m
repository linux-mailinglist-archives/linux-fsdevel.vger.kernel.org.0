Return-Path: <linux-fsdevel+bounces-28192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7853D967CEE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 02:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4D31C20C4C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 00:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F82B23A0;
	Mon,  2 Sep 2024 00:15:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87110E5
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725236130; cv=none; b=VzgYSw0cOVNT96c4a5TvqQNZAAlzuMKKoTMuWPKu6AcR6DRjXzo86K5WcJNK6MqXOauD1h+if5mRI8uZHUkXKErmKBPfULm127CQt10N28+RXirSMEMZThNgPl7dTXo7KLEfKC/Xmgp+69V1PJduJTVY32G9OPAhHTuJtE/y+Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725236130; c=relaxed/simple;
	bh=xQgBzKOaeq74NKmwZmobYQL2MCvVKuotlGzIj3dcNa0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HRoX0227Vb/RYZuSb9s6RwAk7xrg2MAvllYxj4b0/YVuyVikjCuYZfnyY9sKZuFDF2b8xhNP5WzDMOcnrvs8rXC38WjJNE89rQT+XUEFUMizW4qusJMURXJ7s1C3FHIyguDQ0SQZkbDV7Wzu6GE55UI2U19D+Jcrw+QDV6r6OhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a492c9d88so101370139f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Sep 2024 17:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725236127; x=1725840927;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFU3o+O2SqIJPyf6/SB1yPaRcAxAeY3HhIRbEG7pvgI=;
        b=YSYE7juuAZF6+aA4cafAzl+pjwjOhUaVCLUvAoCzBAOQfzu10DR+lqiKgCDCBlcGxE
         KUfwMeltZbJnfVSR4vsMpIepqxanSDn0YKL4m/kkzysAapxHKvpoqTETnX5nwzS4Z346
         Re8wepyim+osLydIDDnapvRAdNydSn6TvjLvaSl42CogcvgsSEij65G9vT8hyU04bsmU
         aOi4uwRm7yFlc9/wMybmfSL/65KCrhmQ8NGEmrMFqFPM2ljPrdHVVQm+p2cdXoS7Ygp5
         3RWBib3+RrY35ANYPJ/q7ypAZqEtP/jv0dKhEczUdPOqgG2JI9hUPwRwv8JkgwVrPh9n
         Yx+w==
X-Forwarded-Encrypted: i=1; AJvYcCWK6Yycb3wYUabZ9higstXOFfjN3aLPC0xtD7StH0iO5AZ+CYaId+JsDLqcxwntU1heLSitmQE0sXyq+9P+@vger.kernel.org
X-Gm-Message-State: AOJu0YxxvfPlFqkbwyH0mJDdP8Q0Vg33JgY3ubG2zteA+bdp7WitC7Kv
	CxA7dkx+jd6Emf4WugaMNAHaCnLFfh3jmHzcFhum/W2r4tr19xkyaT5u1NSzUlQXI/akTGOir4D
	IYAWwu/dgO2s5YXXlZfIDxmc4VAwZ3KdDGaRUbMfhf3KVt7Q9++0nXiA=
X-Google-Smtp-Source: AGHT+IGf5VaUPA/OM6bzUnStC63yhhkYb7JpMOol9gz/x1QkmyS4Nk3xtQbuEF5qeNquYVYTWxf3Wm8ZDYUuRemEVt3roo7yS6YM
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:160e:b0:80a:2710:cba4 with SMTP id
 ca18e2360f4ac-82a26107a91mr18778639f.0.1725236127444; Sun, 01 Sep 2024
 17:15:27 -0700 (PDT)
Date: Sun, 01 Sep 2024 17:15:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087bd88062117d676@google.com>
Subject: [syzbot] [fs?] [mm?] INFO: task hung in page_cache_ra_unbounded (2)
From: syzbot <syzbot+265e1cae90f8fa08f14d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    431c1646e1f8 Linux 6.11-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1180c51f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f8f0fb980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c5410bf1e32/disk-431c1646.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/33cf738f4211/vmlinux-431c1646.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5219f1401ba0/bzImage-431c1646.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+265e1cae90f8fa08f14d@syzkaller.appspotmail.com

INFO: task syz.2.113:5685 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.113       state:D stack:26288 pid:5685  tgid:5684  ppid:5366   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 rwsem_down_read_slowpath kernel/locking/rwsem.c:1086 [inline]
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x705/0xa40 kernel/locking/rwsem.c:1528
 filemap_invalidate_lock_shared include/linux/fs.h:855 [inline]
 page_cache_ra_unbounded+0xf7/0x7f0 mm/readahead.c:225
 do_sync_mmap_readahead+0x49c/0x970
 filemap_fault+0x828/0x1760 mm/filemap.c:3314
 __do_fault+0x135/0x460 mm/memory.c:4655
 do_read_fault mm/memory.c:5061 [inline]
 do_fault mm/memory.c:5191 [inline]
 do_pte_missing mm/memory.c:3947 [inline]
 handle_pte_fault+0x321f/0x6fc0 mm/memory.c:5521
 __handle_mm_fault mm/memory.c:5664 [inline]
 handle_mm_fault+0x1109/0x1bc0 mm/memory.c:5832
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x2b9/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:do_strncpy_from_user lib/strncpy_from_user.c:41 [inline]
RIP: 0010:strncpy_from_user+0x110/0x2e0 lib/strncpy_from_user.c:139
Code: 00 00 00 4c 89 e6 e8 4f ea a7 fc 49 83 fc 07 0f 86 9a 00 00 00 48 89 6c 24 08 48 c7 44 24 10 f8 ff ff ff 45 31 ed 4c 89 3c 24 <4f> 8b 3c 2f 48 b8 ff fe fe fe fe fe fe fe 49 8d 1c 07 4c 89 fd 48
RSP: 0018:ffffc90002ecfca8 EFLAGS: 00050246
RAX: 0000000000000000 RBX: ffff8880123f9100 RCX: ffff888064d11e00
RDX: 0000000000000000 RSI: 0000000000000fe0 RDI: 0000000000000007
RBP: 0000000000000fe0 R08: ffffffff84eba6c1 R09: 1ffffffff2030de5
R10: dffffc0000000000 R11: fffffbfff2030de6 R12: 0000000000000fe0
R13: 0000000000000000 R14: ffff8880123f9120 R15: 0000000020001000
 getname_flags+0xf1/0x540 fs/namei.c:150
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1410
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4936579eb9
RSP: 002b:00007f4937376038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f4936715f80 RCX: 00007f4936579eb9
RDX: 0000000000048882 RSI: 0000000020001000 RDI: ffffffffffffff9c
RBP: 00007f49365e793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f4936715f80 R15: 00007ffe88d6c3d8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6626
2 locks held by getty/4993:
 #0: ffff8880334080a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ac/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by kworker/u8:3/5350:
1 lock held by syz.1.16/5487:
1 lock held by syz.2.113/5685:
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:855 [inline]
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: page_cache_ra_unbounded+0xf7/0x7f0 mm/readahead.c:225
1 lock held by syz.3.563/6608:
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:855 [inline]
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: page_cache_ra_unbounded+0xf7/0x7f0 mm/readahead.c:225
1 lock held by syz.4.969/7439:
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:855 [inline]
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: page_cache_ra_unbounded+0xf7/0x7f0 mm/readahead.c:225
1 lock held by syz.3.1736/9003:
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:855 [inline]
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: page_cache_ra_unbounded+0xf7/0x7f0 mm/readahead.c:225
1 lock held by syz.1.2635/10912:
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:855 [inline]
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: page_cache_ra_unbounded+0xf7/0x7f0 mm/readahead.c:225
3 locks held by syz-executor/11416:
1 lock held by syz.4.3267/12287:
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:855 [inline]
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: page_cache_ra_unbounded+0xf7/0x7f0 mm/readahead.c:225
1 lock held by syz.0.3382/12588:
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:855 [inline]
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: page_cache_ra_unbounded+0xf7/0x7f0 mm/readahead.c:225
5 locks held by syz-executor/12700:
1 lock held by syz.2.3654/13168:
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:855 [inline]
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: page_cache_ra_unbounded+0xf7/0x7f0 mm/readahead.c:225
1 lock held by syz.0.4112/14111:
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:855 [inline]
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: page_cache_ra_unbounded+0xf7/0x7f0 mm/readahead.c:225
7 locks held by syz-executor/14848:
 #0: ffff888035396420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2882 [inline]
 #0: ffff888035396420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x227/0xc90 fs/read_write.c:586
 #1: ffff88805844fc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1eb/0x500 fs/kernfs/file.c:325
 #2: ffff8880285c7788 (kn->active#56){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20f/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f526348 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 #4: ffff888011c460e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff888011c460e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1094 [inline]
 #4: ffff888011c460e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1292
 #5: ffff888011c42250 (&devlink->lock_key#16){+.+.}-{3:3}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8e93d5c0 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x4c/0x530 kernel/rcu/tree.c:4486
1 lock held by syz.4.4645/15192:
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:855 [inline]
 #0: ffff888023142040 (mapping.invalidate_lock#2){++++}-{3:3}, at: page_cache_ra_unbounded+0xf7/0x7f0 mm/readahead.c:225
1 lock held by syz.1.4651/15207:
1 lock held by syz.3.4652/15213:
 #0: ffff8880b883e9d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 15219 Comm: syz.2.4658 Not tainted 6.11.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:check_kcov_mode kernel/kcov.c:193 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x37/0x70 kernel/kcov.c:216
Code: 00 d7 03 00 65 8b 15 c0 4a 70 7e 81 e2 00 01 ff 00 74 11 81 fa 00 01 00 00 75 35 83 b9 1c 16 00 00 00 74 2c 8b 91 f8 15 00 00 <83> fa 02 75 21 48 8b 91 00 16 00 00 48 8b 32 48 8d 7e 01 8b 89 fc
RSP: 0000:ffffc9000b01f0e0 EFLAGS: 00000246
RAX: ffffffff81412c81 RBX: ffffffff90310d08 RCX: ffff88805902da00
RDX: 0000000000000000 RSI: ffffffff81facfcf RDI: ffffffff81facf80
RBP: ffffffff81facf80 R08: ffffffff81412c60 R09: ffffc9000b01f2b0
R10: 0000000000000003 R11: ffffffff817f2f00 R12: ffffffff90310d0c
R13: ffffffff90310d0c R14: ffffffff81facfcf R15: ffffffff90310d08
FS:  000055556a623500(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30b20000 CR3: 000000007c78e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __orc_find arch/x86/kernel/unwind_orc.c:99 [inline]
 orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
 unwind_next_frame+0x531/0x2a00 arch/x86/kernel/unwind_orc.c:494
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4548
 jbd2_free_handle include/linux/jbd2.h:1608 [inline]
 jbd2_journal_stop+0x902/0xd80 fs/jbd2/transaction.c:1958
 __ext4_journal_stop+0xfd/0x1a0 fs/ext4/ext4_jbd2.c:134
 __mark_inode_dirty+0x325/0xe20 fs/fs-writeback.c:2486
 generic_update_time fs/inode.c:2004 [inline]
 inode_update_time fs/inode.c:2017 [inline]
 __file_update_time fs/inode.c:2206 [inline]
 file_update_time+0x3ad/0x430 fs/inode.c:2236
 ext4_page_mkwrite+0x207/0xdf0 fs/ext4/inode.c:6132
 do_page_mkwrite+0x19b/0x480 mm/memory.c:3142
 do_shared_fault mm/memory.c:5133 [inline]
 do_fault mm/memory.c:5195 [inline]
 do_pte_missing mm/memory.c:3947 [inline]
 handle_pte_fault+0x126b/0x6fc0 mm/memory.c:5521
 __handle_mm_fault mm/memory.c:5664 [inline]
 handle_mm_fault+0x1109/0x1bc0 mm/memory.c:5832
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7fd06384da54
Code: 20 00 48 89 df 74 e7 e8 4a c4 ff ff 84 c0 74 d7 80 3d 48 a0 2c 00 00 48 8b 83 a8 00 00 00 75 be 8b 00 89 83 9c 00 00 00 eb bd <89> 32 e9 dc f1 ff ff 64 f0 83 04 25 90 ff ff ff 01 64 48 8b 04 25
RSP: 002b:00007ffc184e8510 EFLAGS: 00010246
RAX: 000000000003fdf0 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000001b30b20000 RSI: 0000000000040000 RDI: 00007fd063a68bd0
RBP: 00007ffc184e876c R08: 000000000000000a R09: 00007ffc184e8254
R10: 0000000000000001 R11: 0000000000000293 R12: 0000000000000032
R13: 00000000000895cf R14: 00000000000895ac R15: 00007ffc184e87c0
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

