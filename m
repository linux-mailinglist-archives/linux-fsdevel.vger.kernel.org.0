Return-Path: <linux-fsdevel+bounces-72317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB61CEE032
	for <lists+linux-fsdevel@lfdr.de>; Fri, 02 Jan 2026 09:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27DD3300092E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jan 2026 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163792D0C78;
	Fri,  2 Jan 2026 08:20:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896779CD
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jan 2026 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767342022; cv=none; b=sLE2qliXyTbgGAzfHH6o/gpZ1zFJW2S57QdgfviL/UdQB5q0MaZX+oA+evXRvYh3CHcEQ30SwXorMS112kpQ/8q/gCSojnvm7oT+wD7+fhOA8skJJrMkK45+aKiSvZQm4JnCPTfrCMMW0lnZDy6Toayo4ktm/gdHYoAvAa/QyrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767342022; c=relaxed/simple;
	bh=+Zn0nqi/J3WFqe9TUHF3DgBxWQqaMimKHCI2vQTIMYM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NFozFlclI2RIZab8m9sRR2JDqrqkx36Je7f/qbrV8sN7CQ9ayj8kXgicsg07VB+8Qtco9X1ItcN+zCwLeyW0ukDakQ98aJGNll8pR/PcViKjglH6bkdBfVnr597PUC0UDbWATqXEbGQuHHhMn/AXttWC9jtcGEZztM+RS9hISQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-3fda122aeafso16861242fac.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jan 2026 00:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767342020; x=1767946820;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nb2s1T+eqGI9nUMg8wUZl7v4dPsr4zH30MDo1ewan34=;
        b=nXum70gfXpTqAdwtVAVkByXe0L5AYNkEClrAg2ZEmTLGhMJUGIuWFZConkNh59cCd5
         cclySP2XGIcg9UHYW9U5M0Aijyprn6hNohu8CLA5AInw40qX+utkjug9q328IAamcnH2
         2qoXu6hKE+y6s44fgDxyGwzSQLv7Tx5VUp5w16UhoYlgZxdPcXoxuvValc3KHbYoo7RB
         PA7VpSgyJA2fWQ/uKg9zZ4qUwt+JPS49baQq3GtoNK+DyTJq/JOgmMIGVbqxJNgvSFy1
         K0mUT0BMRSqvQgRwn/1qojAJWloh4XvbP08JZUFS0CYcgu5kw1Wq7+9ZSgVdU7xuIFuz
         ogmA==
X-Forwarded-Encrypted: i=1; AJvYcCXc8XZQfVYpWI+szdL6L0Z0bIYS0uDTk3YKVl3SZWtCHqivLqeOgwfFTf4u9DKNR/xUwFwhYsbdGfpRL0E5@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsf+/AsqnEv14/0ZLWiN6kBCM0DNUOm1A4PZHLhXC56tn2KAxi
	jrjn8ceoVIZNYGkXcWFFkI1MmNdwaaHIhIDBhlshwVUky8MlLFlJtga6YuMehFgZYy2J48SqBlU
	tAYlp11HcWvz9fymQCsn3PpA5aCpXt3i4XWuAvIl+MnCZlMVLsRNcnVxIW0M=
X-Google-Smtp-Source: AGHT+IFhQ/AmlYnzZaCpNZuI5onfvISn2xKXFcUZ64aE07hIp4yF4Nno/zcdYVgdHUJNi9KMxTv2D3HOLQghUeRCUuvndOigd1ci
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:82b:b0:65d:8eb:dc with SMTP id
 006d021491bc7-65d0e97ea4fmr20682905eaf.26.1767342019847; Fri, 02 Jan 2026
 00:20:19 -0800 (PST)
Date: Fri, 02 Jan 2026 00:20:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69577fc3.050a0220.a1b6.0354.GAE@google.com>
Subject: [syzbot] [fs?] INFO: rcu detected stall in pivot_root
From: syzbot <syzbot+4597bae61e400b570327@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cc3aa43b44bd Add linux-next specific files for 20251219
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17213b92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7a09bf3b9133d9d
dashboard link: https://syzkaller.appspot.com/bug?extid=4597bae61e400b570327
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c6c12a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b1b23d9783ee/disk-cc3aa43b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/07451939cf74/vmlinux-cc3aa43b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e5ddf385746f/bzImage-cc3aa43b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4597bae61e400b570327@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5968/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=12681, q=836 ncpus=2)
task:syz-executor    state:R  running task     stack:18792 pid:5968  tgid:5968  ppid:5963   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5258 [inline]
 __schedule+0x150e/0x5070 kernel/sched/core.c:6866
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7193
 irqentry_exit+0x5d8/0x660 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:kasan_check_range+0x1dd/0x2c0 mm/kasan/generic.c:200
Code: e4 49 0f 49 dc 48 83 e3 f8 49 29 dc 74 12 41 80 3b 00 0f 85 b8 00 00 00 49 ff c3 49 ff cc 75 ee 5b 41 5c 41 5d 41 5e 41 5f 5d <c3> cc cc cc cc cc 45 84 ff 75 63 41 f7 c7 00 ff 00 00 75 5f 41 f7
RSP: 0018:ffffc9000437f7d0 EFLAGS: 00000256
RAX: ffffc9000437f901 RBX: 0000000000000010 RCX: ffffffff81747d8e
RDX: 0000000000000001 RSI: 0000000000000010 RDI: ffffc9000437f978
RBP: 0000000000000000 R08: ffffc9000437f987 R09: 1ffff9200086ff30
R10: dffffc0000000000 R11: fffff5200086ff31 R12: ffffc9000437f978
R13: 1ffff9200086ff27 R14: ffffc9000437f978 R15: ffffc9000437f970
 __asan_memset+0x22/0x50 mm/kasan/shadow.c:84
 unwind_next_frame+0xeae/0x23d0 arch/x86/kernel/unwind_orc.c:607
 __unwind_start+0x5b9/0x760 arch/x86/kernel/unwind_orc.c:773
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xe4/0x150 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6674 [inline]
 kmem_cache_free+0x197/0x620 mm/slub.c:6785
 user_path_at+0x44/0x60 fs/namei.c:3569
 __do_sys_pivot_root fs/namespace.c:4543 [inline]
 __se_sys_pivot_root+0x1db/0xbf0 fs/namespace.c:4526
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f503cf8f749
RSP: 002b:00007ffcb3bcd538 EFLAGS: 00000246 ORIG_RAX: 000000000000009b
RAX: ffffffffffffffda RBX: 00007f503d0143a5 RCX: 00007f503cf8f749
RDX: 00007f503cf8de97 RSI: 00007f503d0145d9 RDI: 00007f503d0143a5
RBP: 00007f503d0145d9 R08: 0000000000000000 R09: 00007ffcb3bcd5b0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f503cfef400
R13: 00007f503cfef3d8 R14: 00007ffcb3bcd838 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread starved for 10438 jiffies! g12681 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27128 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5258 [inline]
 __schedule+0x150e/0x5070 kernel/sched/core.c:6866
 __schedule_loop kernel/sched/core.c:6948 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6963
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 0e 21 00 f3 0f 1e fa fb f4 <e9> 48 ee 02 00 cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197de0 EFLAGS: 000002c6
RAX: 50036b2c6c775500 RBX: ffffffff8197c6ba RCX: 50036b2c6c775500
RDX: 0000000000000001 RSI: ffffffff8daa9dc3 RDI: ffffffff8be247e0
RBP: ffffc90000197f10 R08: ffff8880b87336db R09: 1ffff110170e66db
R10: dffffc0000000000 R11: ffffed10170e66dc R12: ffffffff8fc3d070
R13: 1ffff11003adeb70 R14: 0000000000000001 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888125adc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000002 CR3: 00000000355f6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x73/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x1ea/0x520 kernel/sched/idle.c:332
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:430
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:312
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

