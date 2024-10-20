Return-Path: <linux-fsdevel+bounces-32440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67A79A534E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 11:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D17281F89
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F7084D0E;
	Sun, 20 Oct 2024 09:30:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637463EA64
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Oct 2024 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729416627; cv=none; b=ZAWd2t2gQ4Zho8NmRzlIY1MAqemj0ODDdfk9iE5ppAPW+c3wkeWf132/XcVteau/irRETitcFhKScq3eUzPc9uYFNR+cLhsxvyiz4s84ulNn8wFTJpAsaSBXFGitqBCByXl8NzU3HPSFeq/PICmvHlMUuRbG0CdyPmecfgava7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729416627; c=relaxed/simple;
	bh=/9urwPjAj7eikyGICYXw9f7CxpOEirysIm60DnpPQuM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uf/XbHEPoY/CHG9wRi55XoV2u3ECzxLo7pucVfDkX0+hjFlFHj0HFRH3OkB5qutbQ2BF3rPq+kD53NLYDXd28hwUilnFL1wZEqleSuiWVVgWIMbLweAHUrcX6CjZnQ10ghFn85eFpeFvxXr2o0n6O73zKrM2jmaYlXMqQB+pv2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3a6afd01eso27876265ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Oct 2024 02:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729416624; x=1730021424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fIBojxIgxGt6eAn9pNCE6JAfkCcK56p1VeY7YIhXKmU=;
        b=H5xVMDUVhwbpuDbUsvNI/i4EmmR8WVSV1a9xN0GAeXVB4Zd9pHs5AqumdEBBdkmsXa
         +fwxcjIDbOsSUrEbWtSpuSL27NUEHt2Oh/a1pWTNQUDpgbn22G6FBlM6348oAAlXwyYQ
         FmEQnXU6W3Ooy7AUWuR4kxz2+Rh5R++AsORhFdQ8mLidF3xRWx83g9N6lwxrVSgaN1mO
         NGTflH5RB2W+mh/QN+XBAauRIwfLgfxgokHKXNYdhWNy1Rr8y4AY0eg8rHSd1CG3juqL
         pIGYZW01RXKE1D7PbSECFIjwGyhXmMs/xVdTI3QuaH38kQKi6Gl/kzgoKEdwEgXXjdAc
         h6zA==
X-Forwarded-Encrypted: i=1; AJvYcCW57jthy8/ZruvJewMepMNo1oG6CETXsESTnmfbkGJ8P8hmbt/1rAQST98Xykw73+x3Tz8SpeJqGzab8yOE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4nC3U/Uhdzi+QM0UrlhHLFrVWgK2d09F2ut5Vfb7taUTTOchd
	zvLhAAnACd5mGVQ49/gC+LN1Th+FzDXyCrqI11FEYyy6WwAm50rCjxT58akp5kDxTpDoSkH2vk7
	nejdlwhZz9IWIvFVW64xCEIeQMHljnvpyXGxn6IwgP5Oz8u9dtzC7KuY=
X-Google-Smtp-Source: AGHT+IH3flPPwyJ21LcEMelNjBcePGZ8dj9aMQVSUjbIXDJL0vh/c3ONWUeWYzg23tcHs8NqorUSoP62xWnthWtu7hkYwWyEsJ/9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d97:b0:3a0:a0bd:f92b with SMTP id
 e9e14a558f8ab-3a3f405e45dmr62381535ab.10.1729416624290; Sun, 20 Oct 2024
 02:30:24 -0700 (PDT)
Date: Sun, 20 Oct 2024 02:30:24 -0700
In-Reply-To: <6710d2a2.050a0220.d9b66.0189.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6714cdb0.050a0220.1e4b4d.003e.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] INFO: task hung in do_coredump (3)
From: syzbot <syzbot+a8cdfe2d8ad35db3a7fd@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    715ca9dd687f Merge tag 'io_uring-6.12-20241019' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1483825f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd54001fa72fa33d
dashboard link: https://syzkaller.appspot.com/bug?extid=a8cdfe2d8ad35db3a7fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11aa7240580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a3e72f8f3c4f/disk-715ca9dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b3548f5ba14/vmlinux-715ca9dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0d058d51ce5b/bzImage-715ca9dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a8cdfe2d8ad35db3a7fd@syzkaller.appspotmail.com

INFO: task syz.3.130:5664 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.130       state:D stack:28592 pid:5664  tgid:5660  ppid:5353   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3e1/0x600 kernel/sched/completion.c:116
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion_state+0x1c/0x40 kernel/sched/completion.c:264
 coredump_wait fs/coredump.c:418 [inline]
 do_coredump+0x82f/0x4160 fs/coredump.c:575
 get_signal+0x237c/0x26d0 kernel/signal.c:2902
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2af557dff9
RSP: 002b:00007f2af63aa0e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007f2af5736060 RCX: 00007f2af557dff9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f2af5736064
RBP: 00007f2af5736058 R08: 00007f2af63cc080 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2af5736064
R13: 0000000000000000 R14: 00007ffda02286a0 R15: 00007ffda0228788
 </TASK>
INFO: task syz.2.131:5669 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.131       state:D stack:28592 pid:5669  tgid:5668  ppid:5349   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3e1/0x600 kernel/sched/completion.c:116
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion_state+0x1c/0x40 kernel/sched/completion.c:264
 coredump_wait fs/coredump.c:418 [inline]
 do_coredump+0x82f/0x4160 fs/coredump.c:575
 get_signal+0x237c/0x26d0 kernel/signal.c:2902
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa3c517dff9
RSP: 002b:00007fa3c5fb30e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007fa3c5335f88 RCX: 00007fa3c517dff9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007fa3c5335f8c
RBP: 00007fa3c5335f80 R08: 00007fa3c5fb4080 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa3c5335f8c
R13: 0000000000000000 R14: 00007fffdf878150 R15: 00007fffdf878238
 </TASK>
INFO: task syz.1.159:5736 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.159       state:D stack:28592 pid:5736  tgid:5734  ppid:5342   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3e1/0x600 kernel/sched/completion.c:116
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion_state+0x1c/0x40 kernel/sched/completion.c:264
 coredump_wait fs/coredump.c:418 [inline]
 do_coredump+0x82f/0x4160 fs/coredump.c:575
 get_signal+0x237c/0x26d0 kernel/signal.c:2902
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fac9cf7dff9
RSP: 002b:00007fac9dd3b0e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007fac9d136060 RCX: 00007fac9cf7dff9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007fac9d136064
RBP: 00007fac9d136058 R08: 00007fac9dd5d080 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fac9d136064
R13: 0000000000000000 R14: 00007fff5f308c60 R15: 00007fff5f308d48
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8ddb7840 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8ddb7840 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ddb7840 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
2 locks held by getty/4985:
 #0: ffff88814c5240a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
1 lock held by syz.3.130/5667:
1 lock held by syz.2.131/5673:
1 lock held by syz.1.159/5737:
3 locks held by kworker/u8:9/5768:
3 locks held by dhcpcd/5920:
1 lock held by syz.3.181/6065:
5 locks held by syz.1.189/6169:
2 locks held by syz.2.190/6173:
2 locks held by syz.0.191/6175:
2 locks held by dhcpcd-run-hook/6176:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf0c/0x1240 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5860 Comm: syz-executor Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:stack_access_ok+0xc/0x200 arch/x86/kernel/unwind_orc.c:389
Code: ff e9 b0 fe ff ff 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 b8 00 00 00 00 00 fc ff df 41 57 <41> 56 4c 8d 77 08 41 55 41 54 49 89 d4 4c 89 f2 55 48 c1 ea 03 48
RSP: 0018:ffffc90002d8f328 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff90b840e0
RDX: 0000000000000008 RSI: ffffc90002d8fb68 RDI: ffffc90002d8f3a8
RBP: ffffc90002d8f3f0 R08: ffffffff90b840e6 R09: ffffffff90b840e4
R10: ffffc90002d8f3a8 R11: 000000000000ccb0 R12: ffffc90002d8f3f8
R13: ffffc90002d8f3a8 R14: ffffc90002d8fb70 R15: ffffc90002d8fb68
FS:  00005555721e0500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5f0ee9c000 CR3: 0000000028c4e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 deref_stack_reg arch/x86/kernel/unwind_orc.c:403 [inline]
 unwind_next_frame+0xac7/0x20c0 arch/x86/kernel/unwind_orc.c:585
 arch_stack_walk+0x95/0x100 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 save_stack+0x162/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x8d/0x400 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0x956/0x1310 mm/page_alloc.c:2686
 folios_put_refs+0x551/0x750 mm/swap.c:1007
 folio_batch_release include/linux/pagevec.h:101 [inline]
 shmem_undo_range+0x586/0x1170 mm/shmem.c:1032
 shmem_truncate_range mm/shmem.c:1144 [inline]
 shmem_evict_inode+0x3a3/0xba0 mm/shmem.c:1272
 evict+0x409/0x970 fs/inode.c:725
 iput_final fs/inode.c:1877 [inline]
 iput fs/inode.c:1903 [inline]
 iput+0x530/0x890 fs/inode.c:1889
 do_unlinkat+0x5c3/0x760 fs/namei.c:4540
 __do_sys_unlink fs/namei.c:4581 [inline]
 __se_sys_unlink fs/namei.c:4579 [inline]
 __x64_sys_unlink+0xc5/0x110 fs/namei.c:4579
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f341997d5a7
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff8c61fa08 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f341997d5a7
RDX: 00007fff8c61fa30 RSI: 00007fff8c61fac0 RDI: 00007fff8c61fac0
RBP: 00007fff8c61fac0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 00007fff8c620b40
R13: 00007f34199f0134 R14: 0000000000064daa R15: 00007fff8c620b80
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

