Return-Path: <linux-fsdevel+bounces-43326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A865DA54624
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 10:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40683B095F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 09:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE7420967B;
	Thu,  6 Mar 2025 09:21:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F923D68
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252887; cv=none; b=Sd2wJft4fTc8QQ4k+32W2AF3TchVcMrnCl+qK0vZIqKB1oUL2Q3zwOU+335g9zCb81EbbGlE3ieehDIgPUeYiOgnBNUR6WyZKlM3J83rvj4Ev6mjUc5oRX7bAGY1IxO8RcBK2DV+/+V6QLpjeZp4oEHH2u9IQLbduKv/X77a1Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252887; c=relaxed/simple;
	bh=JjVu+7TRzz/OKxXUU/zMbsyjosOvmHWcyR9cGQBUbhg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UwpLnlpTwIsjJhUgRu8EQVWLr25M8LTCi4YWYCl7YnMIlm0QfQL4Z+hIuc7qbhLRwB3hv9AVDfNLeKlAokmK7D+PR9aZJ378n3rz1Q6EXFfP/Qfh/bDYwCK/VTU+eJPEhHtn86FZ4YyZdM1DDeCB6zuPFf2GoLrenTRwXOI1C2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d43355c250so5397125ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Mar 2025 01:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741252885; x=1741857685;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKh+qkgk//kD57cMJIkxDdTHAK9Ls+enC1HVwmYISvg=;
        b=K9POP3LaP5setntpbNb6xVpY4O2pm/3XIIxcNsh0Yoi8uMZUwTElkJvDcGGs17870b
         kHBc7ttb7Rs9e1BYpYctsqM3W8UAOpOMFfpUDvpfPVznlWvnGNziTk88l0kb1xt7NxEr
         zWRqUxVelC9CjPDBBbf1aFmw+CgAnrw5gTKmOnkdtqz+AmSOxL0e0+Ea0UJ+5q+9p210
         Bm69m3frResaYZh+cTTC8YjafBxO4hh/sgZ2EQQA2fYl0wyiG/gmqnGcukrDQsj8/EkI
         v4qsD2Poj2nu1c+7KHS3lG9t3m8oz1sAu8o9fORtoXxW3cXbwcjEMetwiIzjqvlooOav
         IN1A==
X-Forwarded-Encrypted: i=1; AJvYcCXtkrCgA2FGkVrnTQ0LfDkxzvQbSC4133q7cfnWEmLxB7le8o43j9I6hBim2aMkstbRM08eIiRJW0WdhQD6@vger.kernel.org
X-Gm-Message-State: AOJu0YzftMeJv1tL4Ah2TxTZwe5bOEGbrtcIwYURWIsBNPDC337Ol5ZD
	ZTZeU6+Qh0vk4IOC5abohvFO9LtPun0ZcOk2SEkvJsdTN8NYTP7pJ202mW9vqMYh9kMn/P07Rzh
	7zkyn+4PkQLtTD1LKycU0sgFZjYqmuf8qkzlKDjN1k8CwWALR7RvI9MI=
X-Google-Smtp-Source: AGHT+IFRPZRRMlfz4ASDFn56s/zN3T1ewWEqOHNPyuCNdiCSu+fLQHspg+HmoOzvEOSmeRVAsfBOeMW5xqoWmGPp+OwaTzcl2Z18
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc7:b0:3d0:4bce:cfa8 with SMTP id
 e9e14a558f8ab-3d42b873b36mr86092665ab.3.1741252885078; Thu, 06 Mar 2025
 01:21:25 -0800 (PST)
Date: Thu, 06 Mar 2025 01:21:25 -0800
In-Reply-To: <674db1c7.050a0220.ad585.0051.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c96915.050a0220.15b4b9.0031.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in vfs_unlink (5)
From: syzbot <syzbot+6983c03a6a28616e362f@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linkinjeon@kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    bb2281fb05e5 Merge tag 'x86_microcode_for_v6.14_rc6' of gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=159144b7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=523d3ff8e053340a
dashboard link: https://syzkaller.appspot.com/bug?extid=6983c03a6a28616e362f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cf7078580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10197da8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7f163a5da7e8/disk-bb2281fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6841e1105518/vmlinux-bb2281fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3295ae6e86c0/bzImage-bb2281fb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8d22fecc87c0/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17e97da8580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6983c03a6a28616e362f@syzkaller.appspotmail.com

INFO: task syz-executor399:5826 blocked for more than 143 seconds.
      Not tainted 6.14.0-rc5-syzkaller-00023-gbb2281fb05e5 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor399 state:D stack:27224 pid:5826  tgid:5823  ppid:5821   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x18bc/0x4c40 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6914
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:877 [inline]
 vfs_unlink+0xe4/0x650 fs/namei.c:4514
 do_unlinkat+0x4ae/0x830 fs/namei.c:4589
 __do_sys_unlink fs/namei.c:4637 [inline]
 __se_sys_unlink fs/namei.c:4635 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4635
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb1339de6f9
RSP: 002b:00007fb133974218 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007fb133a665f8 RCX: 00007fb1339de6f9
RDX: 00007fb1339b7dc6 RSI: 0000000000000000 RDI: 0000400000000100
RBP: 00007fb133a665f0 R08: 00007ffcb7766927 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0031656c69662f2e
R13: 0000400000000100 R14: 0000400000000080 R15: 0000400000000240
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8eb392e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8eb392e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8eb392e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6746
2 locks held by getty/5580:
 #0: ffff88814e4bb0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900033332f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x616/0x1770 drivers/tty/n_tty.c:2211
2 locks held by syz-executor399/5825:
3 locks held by syz-executor399/5826:
 #0: ffff888076078420 (sb_writers#10){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:547
 #1: ffff888073c182a0 (&sb->s_type->i_mutex_key#14/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:912 [inline]
 #1: ffff888073c182a0 (&sb->s_type->i_mutex_key#14/1){+.+.}-{4:4}, at: do_unlinkat+0x26a/0x830 fs/namei.c:4576
 #2: ffff888073c18910 (&sb->s_type->i_mutex_key#14){++++}-{4:4}, at: inode_lock include/linux/fs.h:877 [inline]
 #2: ffff888073c18910 (&sb->s_type->i_mutex_key#14){++++}-{4:4}, at: vfs_unlink+0xe4/0x650 fs/namei.c:4514

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.14.0-rc5-syzkaller-00023-gbb2281fb05e5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:236 [inline]
 watchdog+0x1058/0x10a0 kernel/hung_task.c:399
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5825 Comm: syz-executor399 Not tainted 6.14.0-rc5-syzkaller-00023-gbb2281fb05e5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:210
Code: 89 fb e8 23 00 00 00 48 8b 3d a4 04 92 0c 48 89 de 5b e9 23 5e 59 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 04 24 65 48 8b 0c 25 00 d5 03 00 65 8b 15 30 06
RSP: 0018:ffffc900040c78e8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888023a2ce00 RCX: ffffffff824af6cf
RDX: ffff8880330e5a00 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff824af6f1 R09: 1ffff1100f76b200
R10: dffffc0000000000 R11: ffffed100f76b201 R12: 0000000000000008
R13: ffff888023a2c500 R14: 0000000000000200 R15: ffff88807bb59000
FS:  00007fb1339956c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005592141bc600 CR3: 0000000035948000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __bread_gfp+0xca/0x400 fs/buffer.c:1487
 sb_bread include/linux/buffer_head.h:346 [inline]
 __exfat_ent_get fs/exfat/fatent.c:48 [inline]
 exfat_ent_get+0x14d/0x400 fs/exfat/fatent.c:97
 exfat_find_last_cluster+0x15d/0x380 fs/exfat/fatent.c:263
 exfat_cont_expand fs/exfat/file.c:40 [inline]
 exfat_setattr+0xa8d/0x1a90 fs/exfat/file.c:295
 notify_change+0xbca/0xe90 fs/attr.c:552
 do_truncate+0x220/0x310 fs/open.c:65
 vfs_truncate+0x492/0x530 fs/open.c:115
 do_sys_truncate+0xdb/0x190 fs/open.c:138
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb1339de6f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb133995218 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007fb133a665e8 RCX: 00007fb1339de6f9
RDX: ffffffffffffffb0 RSI: 000000000000f000 RDI: 0000400000000080
RBP: 00007fb133a665e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0031656c69662f2e
R13: 0000400000000100 R14: 0000400000000080 R15: 0000400000000240
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

