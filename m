Return-Path: <linux-fsdevel+bounces-70039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B195C8EF3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 15:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0AD30354C2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F8E334691;
	Thu, 27 Nov 2025 14:55:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E3334364
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255327; cv=none; b=riJBaURruFSNVOje4Af9sidu5EG3leflZ2GA3V0AkSEYgTyZG9862vmodrBWVPf7Kanp1cJ1ilc072+JgsowDq4PluCyl9yOuM5Cx84u4nUozHel7v98Mji/eNRB/ll5ah6/sMyl/a2fgLNSUOowaU/L3BDQN0s9N/2JxMRXd2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255327; c=relaxed/simple;
	bh=astQzhTI9C/hsh59wtzNs2arXWbfcbsTEJ/7GsXTzQo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZtGdiJxsl6xHTyB+ldb/gB2Mdsz9bnJZc7zfv1k4K9U5acNnPO8I8L7Hgc7cYjLLwRPtNHOCNkR5/Jklyb0thkFDC9BZORD9br70GImJrq9LRLsYyB3MWqBVnEAnm2khhua14hhS/46J4qeO030syc5OnDxdbFoVdIwxnmj282c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-434a83cd402so9427705ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 06:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764255324; x=1764860124;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hCAVKRSWAFgcmFuKzO2EIexdVb24ue0/wi6M2luph+c=;
        b=Bf96OU9kBZfU0OnZvLLyjqIFXJAwdUq0zulzbKUY81NwcXijp9AQotC4HdoR0v65qH
         GAVc+zWbV/3rjSsyA3bpxsV7+6ZJyuf1Ta70GgkMG4HFFxjn4c1TATZzhsdq87nuLuSp
         G/ErOsl5f8n03CC1FuzmIJgmNvrnrC/tyrYSImATeXFjCp4Ix3/t6FkLMHCp0ryriTnw
         uchOCy1dPbrzkaYUFhMQhK5PsGPc8Pb5HpGTsyT0v7JhKlJQm6T2/mxcC/7JR7BQLJiy
         upoMC0uBJuQO2ZAeik+8Crz0lQKQVCaMmxg2xvpGAudBESCZl3DFUetjzneB+Fh4yYQq
         4v2w==
X-Forwarded-Encrypted: i=1; AJvYcCWq4OVsTz8lVo4WYd4cVTzKtwMZvKIpvbCruK7ScPJl/EoZVWOi2t0z1ZYSjzuihZFnGtm6c8Emc/c3DLwU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6GDWUQChObuW6CQrJkbfnlvACKPw9CLXoxxVbjDZXVCZ5cf0
	APRCO4kVD72zxKAP0tR5se7fys4VNeuxnJOCWJzinDKxniQK8bxLBiJH3JWPz0XQsd10qrzn7UY
	A7ayImV9qmIQjUB/myaeqRdK4Q1I5iXCIKu5helJ8wkjg3ETkiVVor+W1g30=
X-Google-Smtp-Source: AGHT+IGhIQGX5rt1wjhEHu9BD/rsM//hmN5/8B3l8Epz9R5tqBC367cGCoVCcNYa5DDUZ82w1uKgPSJykbyy/R9ut3AvVifiylgh
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd44:0:b0:433:68e3:7679 with SMTP id
 e9e14a558f8ab-435dd043b29mr76588715ab.8.1764255324606; Thu, 27 Nov 2025
 06:55:24 -0800 (PST)
Date: Thu, 27 Nov 2025 06:55:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6928665c.a70a0220.d98e3.0109.GAE@google.com>
Subject: [syzbot] [udf?] INFO: rcu detected stall in call_usermodehelper_exec_async
 (4)
From: syzbot <syzbot+be81254ae29faa71cdfe@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.com, jack@suse.cz, kees@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d724c6f85e80 Add linux-next specific files for 20251121
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16f1f742580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68d11c703cf8e4a0
dashboard link: https://syzkaller.appspot.com/bug?extid=be81254ae29faa71cdfe
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c3ea12580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1064d8b4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ccfc806f65a/disk-d724c6f8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2ec31ffb05e/vmlinux-d724c6f8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c25d9c0c1917/bzImage-d724c6f8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9174536af225/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be81254ae29faa71cdfe@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P6121/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=13961, q=394 ncpus=2)
task:modprobe        state:R  running task     stack:26056 pid:6121  tgid:6121  ppid:13     task_flags:0x400000 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5257 [inline]
 __schedule+0x14bc/0x5030 kernel/sched/core.c:6864
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7191
 irqentry_exit+0x5d8/0x660 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:unwind_next_frame+0xaa5/0x2390 arch/x86/kernel/unwind_orc.c:581
Code: 00 49 89 df 49 c1 ef 03 41 0f b6 04 2f 84 c0 0f 85 88 13 00 00 0f b6 76 01 83 e6 07 83 fe 04 4c 89 64 24 10 0f 84 49 04 00 00 <83> fe 03 0f 84 f3 01 00 00 83 fe 02 0f 85 a1 07 00 00 4c 89 7c 24
RSP: 0018:ffffc90003287898 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffffffff900ba31f RCX: ffffffff8f90e4cc
RDX: ffffffff900ba31a RSI: 0000000000000002 RDI: ffffffff8bbf8180
RBP: dffffc0000000000 R08: 0000000000000003 R09: ffffffff81745035
R10: ffffc900032879b8 R11: ffffffff81adcc20 R12: ffffc90003287f48
R13: ffffc900032879b8 R14: ffffc90003287968 R15: 1ffffffff2017463
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6663 [inline]
 kfree+0x1c0/0x680 mm/slub.c:6871
 kernel_execve+0x3c7/0x9f0 fs/exec.c:1922
 call_usermodehelper_exec_async+0x210/0x360 kernel/umh.c:109
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: rcu_preempt kthread starved for 10537 jiffies! g13961 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27064 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5257 [inline]
 __schedule+0x14bc/0x5030 kernel/sched/core.c:6864
 __schedule_loop kernel/sched/core.c:6946 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6961
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 70 0c 00 f3 0f 1e fa fb f4 <e9> c8 f2 02 00 cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffffff8dc07d80 EFLAGS: 000002c6
RAX: 9d3ae734e5c61000 RBX: ffffffff8197acb7 RCX: 9d3ae734e5c61000
RDX: 0000000000000001 RSI: ffffffff8d78f71d RDI: ffffffff8bbf81e0
RBP: ffffffff8dc07ea8 R08: ffff8880b86336db R09: 1ffff110170c66db
R10: dffffc0000000000 R11: ffffed10170c66dc R12: ffffffff8f7deb70
R13: 0000000000000000 R14: 0000000000000000 R15: 1ffffffff1b92a60
FS:  0000000000000000(0000) GS:ffff888125eba000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc4b4703020 CR3: 000000002998e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x73/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x1e7/0x510 kernel/sched/idle.c:330
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:428
 rest_init+0x2de/0x300 init/main.c:757
 start_kernel+0x3a7/0x410 init/main.c:1206
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x147
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

