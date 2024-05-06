Return-Path: <linux-fsdevel+bounces-18787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0938BC59A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 03:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E681F20F17
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 01:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E813D55D;
	Mon,  6 May 2024 01:51:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDE93C064
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 01:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714960284; cv=none; b=toBnCZG1NOMg78Ex5l819lpuotNMS3mWzMEGGpXlit3XUtSJ4vazn7BUftM4oM7QiAACfM9C6X17tTDN3abqyTAHrxNC70SJe2m8lh3rbQfDpZK59zbVSRAH82zihbp8GQNNf8oR5bLpIDrAtzul4AqGVt+db4lDSY/YxuHPDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714960284; c=relaxed/simple;
	bh=r+GY4qw80E7wrMWgCTMwCcGDaGbZNk/LMdw7DtHQ8gI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LGpVBkQJdOj/KxTMSHW5u6f9hpWie/VOpRuLJqSdMZ4lirPm9hEu0xQuuN+jck04MGdGxuqCdwGEAzK6nNU+0mLDf67rQ9CBOoQ1toHf2QHL30tzulJZYyQ+mD/nz8ESQiyGDZByBfbJe5bdjPxh7bQrWWKrq6lAATta9R24n/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-36c5e4166cfso17894425ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 18:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714960281; x=1715565081;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QmCbw4tYucXOsZTssjL6XtAYeqQMLNBT9Ue1tbftr5Y=;
        b=aI4FgZWNdjFniwVyVurutRMDkGE3Xwp1XuKi7SNBtLWqImxeCWl24u22UIYYwf9Q56
         EjOsn4gtwqVf3p9U5Xfsq7EIywFxaP3qHiircVKUq/wUTtohUzaoBIcEwdhqGBxXMuJ5
         aHz5Zqjl+4bfdbb6Z80D2wVSIxK2SOr/0eFAq7bVtpABpv269GTDrReczatHtS4100J7
         rYgeuI9k9uZ9J9qndMdILDk+8/dw4sTvgZ1x27ycpr0n2hlmW9eC6sQ69XPMzZ/Na2Ji
         IsaOsIdMKCIok9S9p0pk6nCwS7d0TX3mlKydcL5cYJmtysf+Fgu8glXi9P2ZxAfv3X0O
         dh5w==
X-Forwarded-Encrypted: i=1; AJvYcCWwMrk946P0tT6NU2OJZJIjOR4EHknFy5o9V7ViLaAS/a2OwalTm6yeCTFwtrpP+bjhXlHP3VKl1mZWoWygstgrTzlAmeJy5FCMGPDaXA==
X-Gm-Message-State: AOJu0YzohXSaD+8QULP/18bR/7i1DgG2HqFf8VqGhX9zvoiftNq3ahOs
	uIUVyk2QTlAnI3VcFb0lBJJEDOy3XITs+gSO4ogw+r8HHGxl1FoNh4AyW6rRHkGw3GKAiJYVFcK
	wGmB4s0DZZ265BfzhRvdciZSd2m0LQT2qJNClhmZ6OAq/TbiOSeTmRfs=
X-Google-Smtp-Source: AGHT+IHDpwYfhghuZ8Oo4AwAQQgR7fTgVftvOSO6gQ5IedoYfRTgtJ3G8lo+Y+BRxmcfzNTbZkBNdwozqwLxjwDQ8X+FipoiJLEK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe1:b0:36c:5c1b:2051 with SMTP id
 dt1-20020a056e021fe100b0036c5c1b2051mr607539ilb.6.1714960281671; Sun, 05 May
 2024 18:51:21 -0700 (PDT)
Date: Sun, 05 May 2024 18:51:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064a9bf0617bf4ed8@google.com>
Subject: [syzbot] [bcachefs?] [kernfs?] INFO: task hung in do_renameat2 (2)
From: syzbot <syzbot+39a12f7473ed8066d2ca@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14eff86c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=39a12f7473ed8066d2ca
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/03bd77f8af70/disk-7367539a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb03a61f9582/vmlinux-7367539a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e4c5c654b571/bzImage-7367539a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39a12f7473ed8066d2ca@syzkaller.appspotmail.com

INFO: task syz-executor.4:6200 blocked for more than 143 seconds.
      Not tainted 6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:28336 pid:6200  tgid:6196  ppid:5093   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1796/0x4a00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6838
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6895
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 inode_lock_nested include/linux/fs.h:830 [inline]
 lock_rename fs/namei.c:3066 [inline]
 do_renameat2+0x62c/0x13f0 fs/namei.c:4972
 __do_sys_rename fs/namei.c:5084 [inline]
 __se_sys_rename fs/namei.c:5082 [inline]
 __x64_sys_rename+0x86/0xa0 fs/namei.c:5082
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f532ec7dca9
RSP: 002b:00007f532f9d30c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f532edac050 RCX: 00007f532ec7dca9
RDX: 0000000000000000 RSI: 00000000200003c0 RDI: 0000000020001400
RBP: 00007f532ecc947e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f532edac050 R15: 00007ffce639e8c8
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/1:0/24:
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3242 [inline]
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3348
 #1: ffffc900001e7d00 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3243 [inline]
 #1: ffffc900001e7d00 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3348
 #2: ffff888159e00240 (&data->fib_lock){+.+.}-{3:3}, at: nsim_fib_event_work+0x2d1/0x4130 drivers/net/netdevsim/fib.c:1489
1 lock held by khungtaskd/29:
 #0: ffffffff8e334da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e334da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e334da0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
4 locks held by kworker/u8:2/31:
 #0: ffff888015ecb148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3242 [inline]
 #0: ffff888015ecb148 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3348
 #1: ffffc90000a77d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3243 [inline]
 #1: ffffc90000a77d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3348
 #2: ffffffff8f587f90 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:591
 #3: ffffffff8f594688 (rtnl_mutex){+.+.}-{3:3}, at: fib6_rules_net_exit_batch+0x20/0xc0 net/ipv6/fib6_rules.c:506
3 locks held by kworker/u8:4/61:
 #0: ffff88802a629948 ((wq_completion)ipv6_addrconf
){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3242 [inline]
){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3348
 #1: ffffc900015c7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3243 [inline]
 #1: ffffc900015c7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3348
 #2: ffffffff8f594688 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4192
2 locks held by getty/4835:
 #0: ffff88802b1b50a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f0e2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
3 locks held by kworker/1:5/5143:
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3242 [inline]
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3348
 #1: ffffc9000411fd00 (fqdir_free_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3243 [inline]
 #1: ffffc9000411fd00 (fqdir_free_work){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3348
 #2: ffffffff8e33a000 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x4c/0x550 kernel/rcu/tree.c:4073
3 locks held by syz-executor.4/6197:
2 locks held by syz-executor.4/6200:
 #0: ffff88805904e420 (sb_writers#13){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff888061a8e380 (&type->i_mutex_dir_key#8/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:830 [inline]
 #1: ffff888061a8e380 (&type->i_mutex_dir_key#8/1){+.+.}-{3:3}, at: lock_rename fs/namei.c:3066 [inline]
 #1: ffff888061a8e380 (&type->i_mutex_dir_key#8/1){+.+.}-{3:3}, at: do_renameat2+0x62c/0x13f0 fs/namei.c:4972
1 lock held by syz-executor.2/8039:
 #0: ffffffff8f594688 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f594688 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x10d0 net/core/rtnetlink.c:6592
2 locks held by syz-executor.0/8179:
 #0: ffffffff8f594688 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f594688 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x10d0 net/core/rtnetlink.c:6592
 #1: ffffffff8e33a138 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:323 [inline]
 #1: ffffffff8e33a138 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x463/0x820 kernel/rcu/tree_exp.h:939
1 lock held by syz-executor.3/8193:
 #0: ffffffff8e33a138 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:323 [inline]
 #0: ffffffff8e33a138 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x463/0x820 kernel/rcu/tree_exp.h:939
2 locks held by syz-executor.4/8221:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:380
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 8225 Comm: udevadm Not tainted 6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:lock_is_held_type+0x13b/0x190
Code: 75 44 48 c7 04 24 00 00 00 00 9c 8f 04 24 f7 04 24 00 02 00 00 75 4c 41 f7 c4 00 02 00 00 74 01 fb 65 48 8b 04 25 28 00 00 00 <48> 3b 44 24 08 75 42 89 d8 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffffc9000a0872f8 EFLAGS: 00000206
RAX: dae9823298c33500 RBX: 0000000000000001 RCX: ffff8880230d0000
RDX: 0000000000000000 RSI: ffffffff8bcaca20 RDI: ffffffff8c1eaaa0
RBP: 0000000000000000 R08: ffffffff8b6d58a3 R09: fffffbfff2961170
R10: dffffc0000000000 R11: fffffbfff2961170 R12: 0000000000000246
R13: ffff8880230d0000 R14: 00000000ffffffff R15: ffff8880750227a0
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4217a34ba8 CR3: 00000001eed4c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_is_held include/linux/lockdep.h:231 [inline]
 mt_locked lib/maple_tree.c:781 [inline]
 mt_slot lib/maple_tree.c:788 [inline]
 mas_slot lib/maple_tree.c:821 [inline]
 mas_validate_parent_slot lib/maple_tree.c:7403 [inline]
 mt_validate+0x9a0/0x4aa0 lib/maple_tree.c:7592
 validate_mm+0xe7/0x530 mm/mmap.c:288
 __split_vma+0xb7b/0xd00 mm/mmap.c:2385
 do_vmi_align_munmap+0x451/0x1930 mm/mmap.c:2550
 do_vmi_munmap+0x24e/0x2d0 mm/mmap.c:2696
 mmap_region+0x6af/0x1e50 mm/mmap.c:2747
 do_mmap+0x7af/0xe60 mm/mmap.c:1385
 vm_mmap_pgoff+0x1e3/0x420 mm/util.c:573
 ksys_mmap_pgoff+0x504/0x6e0 mm/mmap.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4217aaab74
Code: 63 08 44 89 e8 5b 41 5c 41 5d c3 41 89 ca 41 f7 c1 ff 0f 00 00 74 0c c7 05 f5 46 01 00 16 00 00 00 eb 17 b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 0c f7 d8 89 05 dc 46 01 00 48 83 c8 ff c3 0f
RSP: 002b:00007ffe46f9c158 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007ffe46f9c1d0 RCX: 00007f4217aaab74
RDX: 0000000000000001 RSI: 0000000000005000 RDI: 00007f4217a0c000
RBP: 00007ffe46f9c4f0 R08: 0000000000000003 R09: 000000000000f000
R10: 0000000000000812 R11: 0000000000000246 R12: 00007f4217a87ac0
R13: 00007ffe46f9c578 R14: 000000000000e80a R15: 0000000000000000
 </TASK>


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

