Return-Path: <linux-fsdevel+bounces-23316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C2B92A8C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 20:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DDFCB2196F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 18:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A36A149DF7;
	Mon,  8 Jul 2024 18:11:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148A71474A8
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jul 2024 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462291; cv=none; b=Rgn0ciS2rWFtmYHqopBdjFgZ0cItPZY2kIxkxLpZesNqdP4VatHs+LbRievmkrXY4KlJ6LHN4xQD9yiCZw7scfOKWqck4yIyRAc399bprtOBvajwC7MNcDNhFGvUcrCfJ2WQ4grqZ3eLBUJRrvBmG8Vzz84nG93T52rnk/sLu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462291; c=relaxed/simple;
	bh=LJomNTSistcKp7VN5HYkDgLTvIRz3gNT1AyHASJZtWw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eGoPfJDEmYR+8r2kl1rBlfCboqk7XYyEkKcDyr0ANbNw5bdKDcKIUdnEQsuUdb4CYocFTyWBMeYftIETspq9ryedJ1FvfYIGw4equnpoVUnq8hCp8Z/zsPpX1p+1yGU8J4b/1vSsvpupGRokRRlcdtRsmGsoKCC9s85w9/2x1nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f92912a614so248566939f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2024 11:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462289; x=1721067089;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZjqrcf9AbTsaVREKnVzsQvDlomXNppK92wZr0lymw8=;
        b=ExvWk2S+as3SS0r71MoX7KsZCnrJUJqGyBm5ure8uiBO3+M5n5J2RqhaxODN5nybaB
         FRjK3mvTjrNVuAAkRWg5hUcAb5XuETw65o2Grwu5tkXBGc5ZRjA4FU6X0LpiQc3XlT/9
         FIe5T9CcBYbgUtvLe+qMZHwd2P1DdUMPs6ApKPalwnyTbWbbImDAw7EaP3xCa9JduWGt
         1aNisJs5JhX1NHJGphVdv0NX4kGEbiEKSMN4H9p2nLKoMKeqLuM+uXZYZ8HbzqtTS4Hl
         0CiGdPKKjnCaLK1OSLLxPrKUgiCEbvJyeeok5QXWZ3azSngf0JeQxlNXbPvVTUPaiGAr
         BFYg==
X-Forwarded-Encrypted: i=1; AJvYcCVxcPDP764IPrtHZVqWuzMRmJ7aDQEoCgzYTGzD6Ovd8/tfPKj3KUs4rlEAsNlyhNYhWUK1WB0HlbrGatEg1Fs4dnlfaVWW4TnLzfz1fg==
X-Gm-Message-State: AOJu0YxS9qGZdq1E9+543WPPy6yedJSA4cjbPhDhJa2lf68/BWg+0HPL
	U4iAhcYnMdeirM1SzWPC9ewzZy4NdMN0a7oDw8WojlTas8XQVg+7lXFYhizoImkvlYdj89p84oI
	9C0jC2PKLlaLBrOWyN+lJUo9uPPpSJHTgrbaQxiMWGrl7ApT0TUgNb1w=
X-Google-Smtp-Source: AGHT+IF9gP/A7Gpq0tZ2CN6cST1gNYaYvyemHDCiWX0t6cpr4b1Iz37KKa8IeGYpvT1mTsXMTVen++1hUxLo+fLx98vcKqLx1WiM
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:831e:b0:4c0:73d0:3d77 with SMTP id
 8926c6da1cb9f-4c0b2b6b9damr11805173.5.1720462289292; Mon, 08 Jul 2024
 11:11:29 -0700 (PDT)
Date: Mon, 08 Jul 2024 11:11:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a62c9061cc05733@google.com>
Subject: [syzbot] [fs?] [mm?] INFO: task hung in remove_inode_hugepages
From: syzbot <syzbot+f1d7fb4f94764243d23e@syzkaller.appspotmail.com>
To: airlied@redhat.com, akpm@linux-foundation.org, kraxel@redhat.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com, 
	vivek.kasireddy@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0b58e108042b Add linux-next specific files for 20240703
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=150453b9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed034204f2e40e53
dashboard link: https://syzkaller.appspot.com/bug?extid=f1d7fb4f94764243d23e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130e0685980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16030e6e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d079762feae/disk-0b58e108.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e53996c8d8c2/vmlinux-0b58e108.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a0bf21cdd844/bzImage-0b58e108.xz

The issue was bisected to:

commit cbe81a753050f5d43ae62da77ff68dcf1d44f9b3
Author: Vivek Kasireddy <vivek.kasireddy@intel.com>
Date:   Mon Jun 24 06:36:16 2024 +0000

    udmabuf: pin the pages using memfd_pin_folios() API

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13fd687e980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1003687e980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17fd687e980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f1d7fb4f94764243d23e@syzkaller.appspotmail.com
Fixes: cbe81a753050 ("udmabuf: pin the pages using memfd_pin_folios() API")

INFO: task syz-executor263:5102 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc6-next-20240703-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor263 state:D stack:25984 pid:5102  tgid:5102  ppid:5101   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5248 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6600
 __schedule_loop kernel/sched/core.c:6677 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6692
 io_schedule+0x8d/0x110 kernel/sched/core.c:7477
 folio_wait_bit_common+0x882/0x12b0 mm/filemap.c:1307
 folio_lock include/linux/pagemap.h:1050 [inline]
 remove_inode_single_folio fs/hugetlbfs/inode.c:603 [inline]
 remove_inode_hugepages+0x508/0x1520 fs/hugetlbfs/inode.c:669
 hugetlbfs_evict_inode+0x23/0x70 fs/hugetlbfs/inode.c:689
 evict+0x2a8/0x630 fs/inode.c:669
 __dentry_kill+0x20d/0x630 fs/dcache.c:603
 dput+0x19f/0x2b0 fs/dcache.c:845
 __fput+0x5f8/0x8a0 fs/file_table.c:430
 task_work_run+0x24f/0x310 kernel/task_work.c:204
 exit_task_work include/linux/task_work.h:39 [inline]
 do_exit+0xa2f/0x27f0 kernel/exit.c:882
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x26e0/0x26e0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f816cea6c09
RSP: 002b:00007fffc0047be8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f816cea6c09
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f816cf212b0 R08: ffffffffffffffb8 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 00007f816cf212b0
R13: 0000000000000000 R14: 00007f816cf21d00 R15: 00007f816ce77e40
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e335860 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:333 [inline]
 #0: ffffffff8e335860 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:845 [inline]
 #0: ffffffff8e335860 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6704
2 locks held by getty/4858:
 #0: ffff88802abbc0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
1 lock held by syz-executor263/5102:
 #0: ffff88801b2e22a8 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: remove_inode_hugepages+0x38e/0x1520 fs/hugetlbfs/inode.c:664

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.10.0-rc6-next-20240703-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 953 Comm: kworker/u8:5 Not tainted 6.10.0-rc6-next-20240703-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:check_kcov_mode kernel/kcov.c:184 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:236 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp1+0x35/0x90 kernel/kcov.c:290
Code: 14 25 40 d7 03 00 65 8b 05 50 50 70 7e a9 00 01 ff 00 74 10 a9 00 01 00 00 74 5b 83 ba 1c 16 00 00 00 74 52 8b 82 f8 15 00 00 <83> f8 03 75 47 48 8b 8a 00 16 00 00 44 8b 8a fc 15 00 00 49 c1 e1
RSP: 0018:ffffc90003f677a8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: ffff888021200000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003f6794c R08: ffffffff8b8dde5e R09: ffffffff8b8db076
R10: 0000000000000002 R11: ffff888021200000 R12: 1ffff920007ecf29
R13: ffffc90003f67920 R14: 1ffff920007ecf2a R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056483a92b600 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 insn_get_sib arch/x86/lib/insn.c:447 [inline]
 insn_get_displacement+0x2de/0x9a0 arch/x86/lib/insn.c:484
 insn_get_immediate+0x62/0x11f0 arch/x86/lib/insn.c:650
 insn_get_length arch/x86/lib/insn.c:723 [inline]
 insn_decode+0x2d6/0x4c0 arch/x86/lib/insn.c:762
 arch_jump_entry_size arch/x86/kernel/jump_label.c:24 [inline]
 __jump_label_patch+0xe8/0x490 arch/x86/kernel/jump_label.c:45
 arch_jump_label_transform_queue+0x68/0x100 arch/x86/kernel/jump_label.c:137
 __jump_label_update+0x177/0x3a0 kernel/jump_label.c:493
 static_key_disable_cpuslocked+0xce/0x1c0 kernel/jump_label.c:240
 static_key_disable+0x1a/0x20 kernel/jump_label.c:248
 toggle_allocation_gate+0x1b8/0x250 mm/kfence/core.c:838
 process_one_work kernel/workqueue.c:3224 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3305
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3383
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.578 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

