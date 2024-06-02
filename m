Return-Path: <linux-fsdevel+bounces-20732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B048D755B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 14:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25EB3B20D22
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 12:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABD93A1CA;
	Sun,  2 Jun 2024 12:31:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD403BBEB
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jun 2024 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717331487; cv=none; b=KbekSNcKUlwKXOJ4XUsDgavOBG929U9vckqv+tM0EbvR4MNniGKSzMuStX5gETfkh6X6NxGkiOQt3tuSCM+Z0LHtv4+r9A6SlAWdk6L3dBQaNL3Fz4AqVLfvYyLb0c8NjT0Q+sUIZlVJpeklHRQAMLK3B/JGrylSU8sox1EEaa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717331487; c=relaxed/simple;
	bh=A9POPEMOI2hOv6KhNrxKRUky5sbqU9G0A+VOkSZdbhw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qi8bbGmNS9ViDK1Hirk0YqhCAx426vAnLPSYSkUydmMdfGvbdXfxy8A4DGPTjf3fmyij1jYakrvCoAcaLCwXJ+Laz17qUKRauDSjAzR/Na1+NvIpPlXC2XefHB6Os7mIpivTdfuhGCv2UvgeQjWahT73IBKwjIzd4k8S6vt610Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3748cab6364so23733985ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jun 2024 05:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717331485; x=1717936285;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Axgb5HwW0MeFqTBJSUxMM2ecq6wuFJyN1Nrr1UDzhaI=;
        b=BrdNmo01bkTW6Zu3LNPndqygAtnSjQXeBIYAFsdSMqXHZIqW2VP/TGImWMWNhecFdA
         wk0g1F1QBYvscl0FUs/AwRImu8lyRZnqzflREIuudZYq2keSw1q8YainfaV1KYjp5CO+
         EQoCm77HMMNhCTgInul0+Y+EK+cKoLmHbsPEiX46aJ6ior7AJ0hnjW163IgvxgdRF6j0
         lfibZe578/qR1SgGhb+Biznzfcw0x86Ux8fnGBMiSf09g3F5zsB2I/aP6ex87IeCz9eJ
         sgNIh53SGXcCL9fi5RSYcrtQboTp3syJlkSDohrrHayQq26bLv6hmYU8iuIvdVMMpDJZ
         FitQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM0NLtEnzjK/BfD52ue7i2/WDrvPzqdowDC3RDwgvFi9z8Bb9BTTDJZFSE+od5++Nc/J343q3pGTtj5v836ktXgwX/IKm+k1X/9FC3jA==
X-Gm-Message-State: AOJu0YwBp0LeqMlkMKBw3go/0ldlvZTd9MHcz/tXiLeYuolceBUfPkRv
	cnct7Ad/wDhu8Ql+QAPuOr7UMmodzO8HZZy2ZaNj0OgsYbqTqtvQVIsQUjJ/47PYNNlFoLvfGlb
	OsaBOhfG05XTPAtG8WyfbXUStIRYmeg6fu2y+mo9oQEyEltLnbEPhc4c=
X-Google-Smtp-Source: AGHT+IFusq/so+Huzky5dv20oQXYGCtVqtCACRAnHLwlabdylF3kwFMgS42/jPoylVxsTW5Xtn90RXePy08DeOSxxh1rua5rYPk7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e08:b0:374:5eee:dc2f with SMTP id
 e9e14a558f8ab-3748b8f23b6mr6527585ab.0.1717331485057; Sun, 02 Jun 2024
 05:31:25 -0700 (PDT)
Date: Sun, 02 Jun 2024 05:31:25 -0700
In-Reply-To: <0000000000003d6c9d0611b9ea2d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020f6700619e765c8@google.com>
Subject: Re: [syzbot] [nilfs?] INFO: task hung in nilfs_segctor_thread (2)
From: syzbot <syzbot+c8166c541d3971bf6c87@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    89be4025b0db Merge tag '6.10-rc1-smb3-client-fixes' of git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17667026980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=c8166c541d3971bf6c87
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1164d8bc980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120ae206980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1b4c4cbe2fc3/disk-89be4025.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/992efea7573e/vmlinux-89be4025.xz
kernel image: https://storage.googleapis.com/syzbot-assets/40ebdc35acdd/bzImage-89be4025.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2d66f1d4455b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c8166c541d3971bf6c87@syzkaller.appspotmail.com

INFO: task segctord:5081 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00296-g89be4025b0db #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:segctord        state:D stack:28088 pid:5081  tgid:5081  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 nilfs_transaction_lock+0x25d/0x4f0 fs/nilfs2/segment.c:357
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2512 [inline]
 nilfs_segctor_thread+0x551/0x11b0 fs/nilfs2/segment.c:2598
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
6 locks held by kworker/u8:0/11:
1 lock held by khungtaskd/30:
 #0: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by getty/4833:
 #0: ffff88802a5840a0 (
&tty->ldisc_sem){++++}-{0:0}
, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: 
ffffc900031432f0
 (&ldata->atomic_read_lock){+.+.}-{3:3}
, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
9 locks held by syz-executor240/5078:
1 lock held by segctord/5081:
 #0: 
ffff888020ff52a0 (&nilfs->ns_segctor_sem){++++}-{3:3}, at: nilfs_transaction_lock+0x25d/0x4f0 fs/nilfs2/segment.c:357

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 30 Comm: khungtaskd Not tainted 6.10.0-rc1-syzkaller-00296-g89be4025b0db #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5078 Comm: syz-executor240 Not tainted 6.10.0-rc1-syzkaller-00296-g89be4025b0db #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:_raw_spin_unlock_irqrestore+0x5/0x140 kernel/locking/spinlock.c:193
Code: 58 78 f5 5b c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 <48> 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48 83 ec 60 49 89
RSP: 0018:ffffc90000007ea8 EFLAGS: 00000006
RAX: 0000000000000000 RBX: ffff8880b942c8e0 RCX: ffff888023b41e00
RDX: 0000000000010002 RSI: 0000000000000046 RDI: ffff8880b942c880
RBP: ffff8880b942ca68 R08: ffffffff81836780 R09: 0000000000000000
R10: ffff8880b942d1a8 R11: ffffed1017285a37 R12: 000000430d8aa980
R13: ffff8880b942c880 R14: dffffc0000000000 R15: ffff8880b942cc68
FS:  0000555585626380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007facfac43580 CR3: 000000007fff0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 hrtimer_interrupt+0x540/0x990 kernel/time/hrtimer.c:1823
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:console_trylock_spinning kernel/printk/printk.c:2007 [inline]
RIP: 0010:vprintk_emit+0x576/0x770 kernel/printk/printk.c:2344
Code: 0a 20 00 4c 21 e3 0f 85 3a 01 00 00 e8 13 05 20 00 4d 89 ec 4d 85 ff 75 07 e8 06 05 20 00 eb 06 e8 ff 04 20 00 fb 44 8b 3c 24 <48> c7 c7 20 fa 20 8e 31 f6 ba 01 00 00 00 31 c9 41 b8 01 00 00 00
RSP: 0018:ffffc9000342f740 EFLAGS: 00000293
RAX: ffffffff81761091 RBX: 0000000000000000 RCX: ffff888023b41e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000342f830 R08: ffffffff8176106f R09: 1ffffffff25ee4c9
R10: dffffc0000000000 R11: fffffbfff25ee4ca R12: dffffc0000000000
R13: dffffc0000000000 R14: ffffffff81760eef R15: 000000000000009c
 _printk+0xd5/0x120 kernel/printk/printk.c:2370
 __nilfs_error+0x193/0x730 fs/nilfs2/super.c:131
 nilfs_check_folio+0x423/0x660 fs/nilfs2/dir.c:164
 nilfs_get_folio+0x13f/0x240 fs/nilfs2/dir.c:192
 nilfs_empty_dir+0x127/0x660 fs/nilfs2/dir.c:608
 nilfs_rmdir+0x10e/0x250 fs/nilfs2/namei.c:326
 vfs_rmdir+0x3a3/0x510 fs/namei.c:4214
 do_rmdir+0x3b5/0x580 fs/namei.c:4273
 __do_sys_rmdir fs/namei.c:4292 [inline]
 __se_sys_rmdir fs/namei.c:4290 [inline]
 __x64_sys_rmdir+0x49/0x60 fs/namei.c:4290
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faa1dacbdc7
Code: 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 54 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd03552de8 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 0000555585626338 RCX: 00007faa1dacbdc7
RDX: 0000555585657fff RSI: 0000000000000009 RDI: 00007ffd03553f90
RBP: 0000000000000064 R08: 000055558563f7db R09: 0000000000000000
R10: 0000000000001000 R11: 0000000000000246 R12: 00007ffd03553f90
R13: 0000555585637740 R14: 431bde82d7b634db R15: 00007ffd03556110
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.567 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

