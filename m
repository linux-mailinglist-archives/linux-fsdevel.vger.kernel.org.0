Return-Path: <linux-fsdevel+bounces-38210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5987C9FDD9D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 07:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B538A3A1423
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 06:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB1B27462;
	Sun, 29 Dec 2024 06:29:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070E2594B2
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735453765; cv=none; b=Wakl3QzfFnIuHsRxS15xhY0Xp+AqqD+zUPgATHcqh2MbR+838NKFNE19oVKAv56YpUsG2gbhEprUm8lS83CER8NGhwtkUO2i0kXuR4NYe9xL34oB0julZMkAKFKKCh15KXL/hdBqdCcgrex/pOzHuU/o3Ox9f+kczXUXodsfdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735453765; c=relaxed/simple;
	bh=HcsBq3Rd83yEfSBC7t/SFV9X6zwCWGHNoajW40HJyfU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TFLs6HnoLn7ZkA0jCoZ7JYUopaP3nhNq5hpvz54JLFHlsPGkRisRQX1YjV9fki//mCLA9vCjSHAQjkSFFrNout9nrmzvBVBOvaIxvK/lxOpnAdInmwbRZP9wwSoLrQCUs4gSu7f/tFJh7ag+IkWQoGRCtMVXemZgWDrKcYKQXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a81684bac0so171967205ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2024 22:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735453762; x=1736058562;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3KyTnhK7aPEwdXWj+AMyBQApW0sWYeQLqMVUFmr5vI=;
        b=razkQXSlpzt8ujj360jMvskMEi2KNWY7yO8vvKwFzo78Ctj7pVUvcQn7gMWJhqFLuk
         5phG6mvaZjvVzeAkwJfEPcG3R8FRURb9J245O0DxToj5tp5iv81IBS4ek2Sy44a5TSiD
         LruuBe52BidePBhAoFlCIuaxYvo7/OWX+uBfos4oiUkvy4xrIQEzB3QtooKLNlorhm9b
         r3HGHmWYCg0TZwXZ0ipZvX1641Q1XPmTGQ9m1kIipeAyjYRwKGBHPNi984XS005AHKWJ
         9tJbCELtIlcclnrN38QhLJEW2rwJHqX5agDm40eZub4LNoobwevpPbfUNau4YTdnh5PS
         TniA==
X-Forwarded-Encrypted: i=1; AJvYcCVGggCX8glwL51gYsoLJi0Wn/3FxlRmMKN4G+vGmklqQSebdT9vDAJf8fBwns6KDhwzD1kjy4iYfbvW3hy5@vger.kernel.org
X-Gm-Message-State: AOJu0YymuOY5akjuZNpn3lvU65nUL6kkQPS40v9fmkamXTHo3yvtdxDM
	tHTG5npzC0O9FGvbsT2ISeBcu5iwiJxNy5z74GJq/vpFZzAeMBChywlVLH02XFR7LK53VT355bj
	Ek2xWvhOLX4Eb8q3lyM4YcrrwGAmiuEtknFfYFegrnZRcnfKn5RJEL+8=
X-Google-Smtp-Source: AGHT+IGFuvs3kP7MUlaeuS23hnocb6USE0Lkvpsq0qIwC4c2nQ/qsrsoJdwuIBxynzoesEiCoVDEtcGz40sst9tbxsm7u2mBWwMG
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ca:b0:3a7:e7bd:9f09 with SMTP id
 e9e14a558f8ab-3c2d1e7df64mr257417255ab.5.1735453762240; Sat, 28 Dec 2024
 22:29:22 -0800 (PST)
Date: Sat, 28 Dec 2024 22:29:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6770ec42.050a0220.2f3838.04a5.GAE@google.com>
Subject: [syzbot] [exfat?] INFO: task hung in exfat_lookup (3)
From: syzbot <syzbot+73c8cd74d6440aef4d6a@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, andy.wu@sony.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	wataru.aoyama@sony.com, x86@kernel.org, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16a122f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c4096b0d467a682
dashboard link: https://syzkaller.appspot.com/bug?extid=73c8cd74d6440aef4d6a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101d6adf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d100b0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/de1e2d4b88e8/disk-9b2ffa61.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5eacd6368afe/vmlinux-9b2ffa61.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7bb223e545d/bzImage-9b2ffa61.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/03d3f4e08070/mount_0.gz

The issue was bisected to:

commit f55c096f62f100aa9f5f48d86e1b6846ecbd67e7
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Tue May 30 09:35:00 2023 +0000

    exfat: do not zero the extended part

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17630018580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14e30018580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10e30018580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+73c8cd74d6440aef4d6a@syzkaller.appspotmail.com
Fixes: f55c096f62f1 ("exfat: do not zero the extended part")

INFO: task syz-executor306:5831 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc4-syzkaller-00012-g9b2ffa6148b1 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor306 state:D stack:25784 pid:5831  tgid:5828  ppid:5827   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x17fb/0x4be0 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 __mutex_lock_common kernel/locking/mutex.c:665 [inline]
 __mutex_lock+0x7e7/0xee0 kernel/locking/mutex.c:735
 exfat_lookup+0x143/0x1e70 fs/exfat/namei.c:726
 __lookup_slow+0x28c/0x3f0 fs/namei.c:1791
 lookup_slow+0x53/0x70 fs/namei.c:1808
 walk_component+0x2e1/0x410 fs/namei.c:2112
 lookup_last fs/namei.c:2610 [inline]
 path_lookupat+0x16f/0x450 fs/namei.c:2634
 filename_lookup+0x2a3/0x670 fs/namei.c:2663
 user_path_at+0x3a/0x60 fs/namei.c:3070
 do_fchownat+0xed/0x240 fs/open.c:803
 __do_sys_lchown fs/open.c:834 [inline]
 __se_sys_lchown fs/open.c:832 [inline]
 __x64_sys_lchown+0x85/0xa0 fs/open.c:832
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f02ec6df409
RSP: 002b:00007f02ec675218 EFLAGS: 00000246 ORIG_RAX: 000000000000005e
RAX: ffffffffffffffda RBX: 00007f02ec7675f8 RCX: 00007f02ec6df409
RDX: 00000000ffffffff RSI: 000000000000ee00 RDI: 0000000020000140
RBP: 00007f02ec7675f0 R08: 00007ffd57b68e47 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0032656c69662f2e
R13: 00007f02ec7330c0 R14: 00000000200002c0 R15: 0030656c69662f2e
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6744
2 locks held by getty/5584:
 #0: ffff8880322ee0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
5 locks held by syz-executor306/5830:
2 locks held by syz-executor306/5831:
 #0: ffff8880775582a0 (&sb->s_type->i_mutex_key#14){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:828 [inline]
 #0: ffff8880775582a0 (&sb->s_type->i_mutex_key#14){++++}-{4:4}, at: lookup_slow+0x45/0x70 fs/namei.c:1807
 #1: ffff8880341aa0e8 (&sbi->s_lock){+.+.}-{4:4}, at: exfat_lookup+0x143/0x1e70 fs/exfat/namei.c:726

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-rc4-syzkaller-00012-g9b2ffa6148b1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:234 [inline]
 watchdog+0xff6/0x1040 kernel/hung_task.c:397
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5830 Comm: syz-executor306 Not tainted 6.13.0-rc4-syzkaller-00012-g9b2ffa6148b1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__exfat_free_cluster+0x685/0x990
Code: ff 44 89 e9 41 d3 ee 8b 5c 24 0c 89 df 44 89 f6 e8 70 4a 26 ff 44 39 f3 0f 85 b1 00 00 00 e8 a2 48 26 ff 31 db 44 89 74 24 0c <49> bd 00 00 00 00 00 fc ff df eb 2d e8 8a 48 26 ff 48 8b 5c 24 48
RSP: 0018:ffffc90003dbf3a0 EFLAGS: 00000246
RAX: ffffffff82792b3e RBX: 0000000000000000 RCX: ffff888035a00000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003dbf4b8 R08: ffffffff82792b30 R09: ffffffff827920e7
R10: 0000000000000003 R11: ffff888035a00000 R12: 000000000000000d
R13: 0000000000000009 R14: 0000000000000000 R15: ffff8880775e8180
FS:  00007f02ec6966c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005646d01f3600 CR3: 0000000035264000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 exfat_free_cluster+0x77/0xd0 fs/exfat/fatent.c:232
 __exfat_truncate+0x745/0xa60 fs/exfat/file.c:235
 exfat_truncate fs/exfat/file.c:257 [inline]
 exfat_setattr+0x10fa/0x1a90 fs/exfat/file.c:353
 notify_change+0xbca/0xe90 fs/attr.c:552
 do_truncate+0x220/0x310 fs/open.c:65
 handle_truncate fs/namei.c:3449 [inline]
 do_open fs/namei.c:3832 [inline]
 path_openat+0x2e1e/0x3590 fs/namei.c:3987
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_creat fs/open.c:1495 [inline]
 __se_sys_creat fs/open.c:1489 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1489
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f02ec6df409
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f02ec696218 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f02ec7675e8 RCX: 00007f02ec6df409
RDX: 00007f02ec6df409 RSI: 0000000000000020 RDI: 0000000020000200
RBP: 00007f02ec7675e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0032656c69662f2e
R13: 00007f02ec7330c0 R14: 00000000200002c0 R15: 0030656c69662f2e
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.489 msecs


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

