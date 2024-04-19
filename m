Return-Path: <linux-fsdevel+bounces-17268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802B08AA674
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 03:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932C61C21391
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 01:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A86110A;
	Fri, 19 Apr 2024 01:14:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001D765F
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713489266; cv=none; b=AEo4d1IuAekTtFxV10U1OYTarBYxG9pRdZhl7DJucVYZty4Zmfojr3ulPVdYIKv0Ge4qkDViN+ZumgmVdmYUvgMhIRyuzGQhG+zO4KviH+KqCz9odyP2RDOtaO7x41cAKGHuy1uSnwROcKq+n+fLfce6EH9EtJ/hafRuPmq0KyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713489266; c=relaxed/simple;
	bh=zgcD3STrdhcqxM5bp0yWVai/jwybteQ4oI1Gqbdv5L4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NFXLp6s2bjKp6fKaL4NvLLAzKlgz9FLU0DkrRC6vTbMUGp0+Uoy/vsiJjXQfXxu7UFAgExvRRWlyX9RqhuQ0X5JFmsB751uKmWMuJbOF1P8wppzKGWSTGNdUpDBxvDVMAZ1RwlHfIfGI3gq0c23U4ZAO0y7niJbG8hbul+nEbNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc7a6a04d9so219084839f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 18:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713489263; x=1714094063;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94SU0Ogbh4daqRJ7kAikOt+kPouHVi8WF9sQf3+X4Sc=;
        b=E6BgGAlz/iQi4cea0z43HEPmJ/JAOMXyjAX/i0FrTqXmEiYb2drp5y8AGukHAr8Lf7
         maMLQzSwwoi6YtyZjU6If1Ger6GfYFT21wlLHGfGvxxeuv5nHC///48OnDBp7M26KacC
         rJMcCYHSA5fLmRSybSIYKKUOAazpIo6lrNKrEHe2+f+9gaAPurr67wtaw9xo/X4vGNfg
         hR5dqtdXmVVr+PYIp21wBFvQYBGLl5xenlgyjIHFplLs/1R4vONzwyEbEK80L8QOovcV
         8IwZ/Da9/mG7cHReYbhOIvG257cgfGNrze8Bd23tpRJs53gFGl7LgBsASrsLTfshKg2a
         GMIg==
X-Forwarded-Encrypted: i=1; AJvYcCW4YBV+BbmiF7u1vrGAQuidl7r4ylClnbgI5iYJPyKDsSr7EbgqxcYeaztbva2BCtcyCOshihXH3aILcI2x+XjcFfQD/UzVdisDMYT4VQ==
X-Gm-Message-State: AOJu0YwXSGY6jOQuQSobMG8iPqzB/0zLO7E8EkxcCRNYrCXplY+Gscyq
	qq3Q+ZhLHQPLtwVtkkc7yUFbherRzI5l4VluG8GRCtYChA4C8O70F3fLF5mwm+WxYcpAOWvk856
	Lx4pyZv5mRESZPxII87Dz0IvxNFNIygQSYPzUnxVr94T5zQF7IntTEvE=
X-Google-Smtp-Source: AGHT+IGdGFv94/EBOVNLD/RsjQ/LTHhzT/d2CE9+rPlPwj2891lUp5YmYHDPpo3wBMydAo4GWAeGrzIeFQ4nbZLKu4x0Dp3ICJDW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6384:b0:7da:18b8:2790 with SMTP id
 gb4-20020a056602638400b007da18b82790mr11626iob.3.1713489263117; Thu, 18 Apr
 2024 18:14:23 -0700 (PDT)
Date: Thu, 18 Apr 2024 18:14:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dad959061668cead@google.com>
Subject: [syzbot] [fs?] [usb?] [input?] INFO: rcu detected stall in sys_close (7)
From: syzbot <syzbot+393022c13d02e1f680e3@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    9ed46da14b9b Add linux-next specific files for 20240412
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=3D16fe1a57180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7ea0abc478c4985=
9
dashboard link: https://syzkaller.appspot.com/bug?extid=3D393022c13d02e1f68=
0e3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1572d74d18000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11f4ce2b180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fc649744d68c/disk-=
9ed46da1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/11eab7b9945d/vmlinux-=
9ed46da1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7885afd198d/bzI=
mage-9ed46da1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+393022c13d02e1f680e3@syzkaller.appspotmail.com

Total swap =3D 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
400839 pages reserved
0 pages cma reserved
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1):
 P5112/1:b..l

rcu: 	(detected by 1, t=3D10504 jiffies, g=3D5477, q=3D222 ncpus=3D2)
task:udevd           state:R
  running task     stack:23024 pid:5112  tgid:5112  ppid:4540   flags:0x000=
00002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x17e8/0x4a50 kernel/sched/core.c:6746
 preempt_schedule_notrace+0x100/0x140 kernel/sched/core.c:7018
 preempt_schedule_notrace_thunk+0x1a/0x30 arch/x86/entry/thunk.S:13
 rcu_is_watching+0x7e/0xb0 kernel/rcu/tree.c:726
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0xbf/0x9f0 kernel/locking/lockdep.c:5765
 rcu_lock_release include/linux/rcupdate.h:339 [inline]
 rcu_read_unlock include/linux/rcupdate.h:872 [inline]
 is_bpf_text_address+0x280/0x2a0 kernel/bpf/core.c:769
 kernel_text_address+0xa7/0xe0 kernel/extable.c:125
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address+0x5d/0xc0 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0x125/0x1b0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3897 [inline]
 slab_alloc_node mm/slub.c:3957 [inline]
 kmem_cache_alloc_noprof+0x135/0x290 mm/slub.c:3964
 getname_flags+0xbd/0x4f0 fs/namei.c:139
 user_path_at_empty+0x2c/0x60 fs/namei.c:2920
 do_readlinkat+0x118/0x3b0 fs/stat.c:499
 __do_sys_readlink fs/stat.c:532 [inline]
 __se_sys_readlink fs/stat.c:529 [inline]
 __x64_sys_readlink+0x7f/0x90 fs/stat.c:529
 do_syscall_x64 arch/x86/entry/common.c:74 [inline]
 do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb17ad17d47
RSP: 002b:00007ffec561b8e8 EFLAGS: 00000246
 ORIG_RAX: 0000000000000059
RAX: ffffffffffffffda RBX: 00007ffec561b8f8 RCX: 00007fb17ad17d47
RDX: 0000000000000400 RSI: 00007ffec561b8f8 RDI: 00007ffec561bdd8
RBP: 0000000000000400 R08: 00007ffec561c61c R09: 0000000000000000
R10: 0000000000000010 R11: 0000000000000246 R12: 00007ffec561bdd8
R13: 00007ffec561bd48 R14: 00005586f0f47910 R15: 00005586d5ea8a04
 </TASK>
rcu: rcu_preempt kthread starved for 10502 jiffies! g5477 f0x0 RCU_GP_WAIT_=
FQS(5) ->state=3D0x0 ->cpu=3D1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expec=
ted behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R
  running task     stack:24880 pid:17    tgid:17    ppid:2      flags:0x000=
04000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x17e8/0x4a50 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6838
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2582
 rcu_gp_fqs_loop+0x2df/0x1370 kernel/rcu/tree.c:2030
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2232
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 4540 Comm: udevd Not tainted 6.9.0-rc3-next-20240412-syzkaller =
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 03/27/2024
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152=
 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:=
194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 ae 28 6c f6 f6 44 24 =
21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 23 50 d6 f5 6=
5 8b 05 84 47 74 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc90000a18b20 EFLAGS: 00000206

RAX: 3fe8bac19e004400 RBX: 1ffff92000143168 RCX: ffffffff81731f5a
RDX: dffffc0000000000 RSI: ffffffff8bcad2a0 RDI: 0000000000000001
RBP: ffffc90000a18bb0 R08: ffffffff92f73677 R09: 1ffffffff25ee6ce
R10: dffffc0000000000 R11: fffffbfff25ee6cf R12: dffffc0000000000
R13: 1ffff92000143164 R14: ffffc90000a18b40 R15: 0000000000000246
FS:  00007fb17b114c80(0000) GS:ffff8880b9500000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005586d5ec3048 CR3: 0000000077262000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 call_timer_fn+0x18e/0x650 kernel/time/timer.c:1793
 expire_timers kernel/time/timer.c:1844 [inline]
 __run_timers kernel/time/timer.c:2418 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2429
 run_timer_base kernel/time/timer.c:2438 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2448
 __do_softirq+0x2c6/0x980 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline=
]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:=
702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152=
 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:=
194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 ae 28 6c f6 f6 44 24 =
21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 23 50 d6 f5 6=
5 8b 05 84 47 74 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc9000477fc60 EFLAGS: 00000206

RAX: 3fe8bac19e004400 RBX: 1ffff920008eff90 RCX: ffffffff9476b703
RDX: dffffc0000000000 RSI: ffffffff8bcad2a0 RDI: 0000000000000001
RBP: ffffc9000477fcf0 R08: ffffffff8fabe6af R09: 1ffffffff1f57cd5
R10: dffffc0000000000 R11: fffffbfff1f57cd6 R12: dffffc0000000000
R13: 1ffff920008eff8c R14: ffffc9000477fc80 R15: 0000000000000246
 __debug_check_no_obj_freed lib/debugobjects.c:998 [inline]
 debug_check_no_obj_freed+0x561/0x580 lib/debugobjects.c:1019
 slab_free_hook mm/slub.c:2162 [inline]
 slab_free mm/slub.c:4393 [inline]
 kmem_cache_free+0x10f/0x340 mm/slub.c:4468
 file_free+0x24/0x1f0 fs/file_table.c:65
 __do_sys_close fs/open.c:1556 [inline]
 __se_sys_close fs/open.c:1541 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1541
 do_syscall_x64 arch/x86/entry/common.c:74 [inline]
 do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb17ad170a8
Code: 48 8b 05 83 9d 0d 00 64 c7 00 16 00 00 00 83 c8 ff 48 83 c4 20 5b c3 =
64 8b 04 25 18 00 00 00 85 c0 75 20 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff f=
f 76 5b 48 8b 15 51 9d 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffec56214e8 EFLAGS: 00000246
 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00007fb17b114ae0 RCX: 00007fb17ad170a8
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000c
RBP: 000000000000000c R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: ffffffffffffffff R14: 00000000ffffffff R15: 00000000ffffffff
 </TASK>
Mem-Info:
active_anon:3219 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:14600 isolated_file:0
 unevictable:768 dirty:215 writeback:0
 slab_reclaimable:7620 slab_unreclaimable:77925
 mapped:2039 shmem:1251 pagetables:497
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1496034 free_pcp:915 free_cma:0
Node 0 active_anon:12876kB inactive_anon:0kB active_file:0kB inactive_file:=
58332kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:815=
6kB dirty:856kB writeback:0kB shmem:3468kB shmem_thp:0kB shmem_pmdmapped:0k=
B anon_thp:0kB writeback_tmp:0kB kernel_stack:8544kB pagetables:1988kB sec_=
pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:68kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2571 2571 0 0
Node 0 DMA32 free:2022004kB boost:0kB min:35108kB low:43884kB high:52660kB =
reserved_highatomic:0KB active_anon:12840kB inactive_anon:0kB active_file:0=
kB inactive_file:58008kB unevictable:1536kB writepending:852kB present:3129=
332kB managed:2660008kB mlocked:0kB bounce:0kB free_pcp:3660kB local_pcp:12=
20kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB boost:0kB min:4kB low:4kB high:4kB reserved_highatom=
ic:0KB active_anon:36kB inactive_anon:0kB active_file:0kB inactive_file:324=
kB unevictable:0kB writepending:4kB present:1048576kB managed:360kB mlocked=
:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3946772kB boost:0kB min:54788kB low:68484kB high:82180kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:68kB unevictable:1536kB writepending:4kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 73*4kB (UM) 66*8kB (UM) 1*16kB (E) 11*32kB (UM) 0*64kB 1*128k=
B (M) 1*256kB (M) 2*512kB (UM) 2*1024kB (ME) 1*2048kB (U) 492*4096kB (M) =
=3D 2021924kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1=
024kB 0*2048kB 0*4096kB =3D 0kB
Node 1 Normal: 5*4kB (U) 4*8kB (U) 4*16kB (U) 5*32kB (U) 8*64kB (UM) 4*128k=
B (U) 2*256kB (UM) 3*512kB (UM) 1*1024kB (U) 3*2048kB (UM) 961*4096kB (M) =
=3D 3946772kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
15851 total pagecache pages
0 pages in swap cache
Free swap  =3D 0kB
Total swap =3D 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
400839 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3219 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:14600 isolated_file:0
 unevictable:768 dirty:215 writeback:0
 slab_reclaimable:7620 slab_unreclaimable:77925
 mapped:2039 shmem:1251 pagetables:497
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1496034 free_pcp:915 free_cma:0
Node 0 active_anon:12876kB inactive_anon:0kB active_file:0kB inactive_file:=
58332kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:815=
6kB dirty:856kB writeback:0kB shmem:3468kB shmem_thp:0kB shmem_pmdmapped:0k=
B anon_thp:0kB writeback_tmp:0kB kernel_stack:8544kB pagetables:1988kB sec_=
pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:68kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2571 2571 0 0
Node 0 DMA32 free:2022004kB boost:0kB min:35108kB low:43884kB high:52660kB =
reserved_highatomic:0KB active_anon:12840kB inactive_anon:0kB active_file:0=
kB inactive_file:58008kB unevictable:1536kB writepending:852kB present:3129=
332kB managed:2660008kB mlocked:0kB bounce:0kB free_pcp:3660kB local_pcp:12=
20kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB boost:0kB min:4kB low:4kB high:4kB reserved_highatom=
ic:0KB active_anon:36kB inactive_anon:0kB active_file:0kB inactive_file:324=
kB unevictable:0kB writepending:4kB present:1048576kB managed:360kB mlocked=
:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3946772kB boost:0kB min:54788kB low:68484kB high:82180kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:68kB unevictable:1536kB writepending:4kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 73*4kB (UM) 66*8kB (UM) 1*16kB (E) 11*32kB (UM) 0*64kB 1*128k=
B (M) 1*256kB (M) 2*512kB (UM) 2*1024kB (ME) 1*2048kB (U) 492*4096kB (M) =
=3D 2021924kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1=
024kB 0*2048kB 0*4096kB =3D 0kB
Node 1 Normal: 5*4kB (U) 4*8kB (U) 4*16kB (U) 5*32kB (U) 8*64kB (UM) 4*128k=
B (U) 2*256kB (UM) 3*512kB (UM) 1*1024kB (U) 3*2048kB (UM) 961*4096kB (M) =
=3D 3946772kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
15851 total pagecache pages
0 pages in swap cache
Free swap  =3D 0kB
Total swap =3D 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
400839 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3223 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:14602 isolated_file:0
 unevictable:768 dirty:15 writeback:200
 slab_reclaimable:7637 slab_unreclaimable:77900
 mapped:2039 shmem:1253 pagetables:508
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1495958 free_pcp:992 free_cma:0
Node 0 active_anon:12892kB inactive_anon:0kB active_file:0kB inactive_file:=
58340kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:815=
6kB dirty:56kB writeback:800kB shmem:3476kB shmem_thp:0kB shmem_pmdmapped:0=
kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8560kB pagetables:2032kB sec=
_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:68kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2571 2571 0 0
Node 0 DMA32 free:2021700kB boost:0kB min:35108kB low:43884kB high:52660kB =
reserved_highatomic:0KB active_anon:12856kB inactive_anon:0kB active_file:0=
kB inactive_file:58016kB unevictable:1536kB writepending:852kB present:3129=
332kB managed:2660008kB mlocked:0kB bounce:0kB free_pcp:3968kB local_pcp:12=
72kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB boost:0kB min:4kB low:4kB high:4kB reserved_highatom=
ic:0KB active_anon:36kB inactive_anon:0kB active_file:0kB inactive_file:324=
kB unevictable:0kB writepending:4kB present:1048576kB managed:360kB mlocked=
:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3946772kB boost:0kB min:54788kB low:68484kB high:82180kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:68kB unevictable:1536kB writepending:4kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 73*4kB (UM) 66*8kB (UM) 1*16kB (E) 4*32kB (UM) 0*64kB 1*128kB=
 (M) 1*256kB (M) 2*512kB (UM) 2*1024kB (ME) 1*2048kB (U) 492*4096kB (M) =3D=
 2021700kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1=
024kB 0*2048kB 0*4096kB =3D 0kB
Node 1 Normal: 5*4kB (U) 4*8kB (U) 4*16kB (U) 5*32kB (U) 8*64kB (UM) 4*128k=
B (U) 2*256kB (UM) 3*512kB (UM) 1*1024kB (U) 3*2048kB (UM) 961*4096kB (M) =
=3D 3946772kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
15855 total pagecache pages
0 pages in swap cache
Free swap  =3D 0kB
Total swap =3D 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
400839 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3223 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:14602 isolated_file:0
 unevictable:768 dirty:15 writeback:200
 slab_reclaimable:7637 slab_unreclaimable:77900
 mapped:2039 shmem:1253 pagetables:508
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1495958 free_pcp:992 free_cma:0
Node 0 active_anon:12892kB inactive_anon:0kB active_file:0kB inactive_file:=
58340kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:815=
6kB dirty:56kB writeback:800kB shmem:3476kB shmem_thp:0kB shmem_pmdmapped:0=
kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8560kB pagetables:2032kB sec=
_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:68kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2571 2571 0 0
Node 0 DMA32 free:2021700kB boost:0kB min:35108kB low:43884kB high:52660kB =
reserved_highatomic:0KB active_anon:12856kB inactive_anon:0kB active_file:0=
kB inactive_file:58016kB unevictable:1536kB writepending:852kB present:3129=
332kB managed:2660008kB mlocked:0kB bounce:0kB free_pcp:3968kB local_pcp:12=
72kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB boost:0kB min:4kB low:4kB high:4kB reserved_highatom=
ic:0KB active_anon:36kB inactive_anon:0kB active_file:0kB inactive_file:324=
kB unevictable:0kB writepending:4kB present:1048576kB managed:360kB mlocked=
:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3946772kB boost:0kB min:54788kB low:68484kB high:82180kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:68kB unevictable:1536kB writepending:4kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 73*4kB (UM) 66*8kB (UM) 1*16kB (E) 4*32kB (UM) 0*64kB 1*128kB=
 (M) 1*256kB (M) 2*512kB (UM) 2*1024kB (ME) 1*2048kB (U) 492*4096kB (M) =3D=
 2021700kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1=
024kB 0*2048kB 0*4096kB =3D 0kB
Node 1 Normal: 5*4kB (U) 4*8kB (U) 4*16kB (U) 5*32kB (U) 8*64kB (UM) 4*128k=
B (U) 2*256kB (UM) 3*512kB (UM) 1*1024kB (U) 3*2048kB (UM) 961*4096kB (M) =
=3D 3946772kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
15855 total pagecache pages
0 pages in swap cache
Free swap  =3D 0kB
Total swap =3D 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
400839 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3223 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:14602 isolated_file:0
 unevictable:768 dirty:15 writeback:200
 slab_reclaimable:7637 slab_unreclaimable:77900
 mapped:2039 shmem:1253 pagetables:508
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1495958 free_pcp:992 free_cma:0
Node 0 active_anon:12892kB inactive_anon:0kB active_file:0kB inactive_file:=
58340kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:815=
6kB dirty:56kB writeback:800kB shmem:3476kB shmem_thp:0kB shmem_pmdmapped:0=
kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8560kB pagetables:2032kB sec=
_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:68kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2571 2571 0 0
Node 0 DMA32 free:2021700kB boost:0kB min:35108kB low:43884kB high:52660kB =
reserved_highatomic:0KB active_anon:12856kB inactive_anon:0kB active_file:0=
kB inactive_file:58016kB unevictable:1536kB writepending:852kB present:3129=
332kB managed:2660008kB mlocked:0kB bounce:0kB free_pcp:3968kB local_pcp:12=
72kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB boost:0kB min:4kB low:4kB high:4kB reserved_highatom=
ic:0KB active_anon:36kB inactive_anon:0kB active_file:0kB inactive_file:324=
kB unevictable:0kB writepending:4kB present:1048576kB managed:360kB mlocked=
:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3946772kB boost:0kB min:54788kB low:68484kB high:82180kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:68kB unevictable:1536kB writepending:4kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 73*4kB (UM) 66*8kB (UM) 1*16kB (E) 4*32kB (UM) 0*64kB 1*128kB=
 (M) 1*256kB (M) 2*512kB (UM) 2*1024kB (ME) 1*2048kB (U) 492*4096kB (M) =3D=
 2021700kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1=
024kB 0*2048kB 0*4096kB =3D 0kB
Node 1 Normal: 5*4kB (U) 4*8kB (U) 4*16kB (U) 5*32kB (U) 8*64kB (UM) 4*128k=
B (U) 2*256kB (UM) 3*512kB (UM) 1*1024kB (U) 3*2048kB (UM) 961*4096kB (M) =
=3D 3946772kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
15855 total pagecache pages
0 pages in swap cache
Free swap  =3D 0kB
Total swap =3D 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
400839 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3223 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:14602 isolated_file:0
 unevictable:768 dirty:15 writeback:200
 slab_reclaimable:7637 slab_unreclaimable:77900
 mapped:2039 shmem:1253 pagetables:508
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1495958 free_pcp:991 free_cma:0
Node 0 active_anon:12892kB inactive_anon:0kB active_file:0kB inactive_file:=
58340kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:815=
6kB dirty:56kB writeback:800kB shmem:3476kB shmem_thp:0kB shmem_pmdmapped:0=
kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8560kB pagetables:2032kB sec=
_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:68kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2571 2571 0 0
Node 0 DMA32 free:2021700kB boost:0kB min:35108kB low:43884kB high:52660kB =
reserved_highatomic:0KB active_anon:12856kB inactive_anon:0kB active_file:0=
kB inactive_file:58016kB unevictable:1536kB writepending:852kB present:3129=
332kB managed:2660008kB mlocked:0kB bounce:0kB free_pcp:3964kB local_pcp:12=
72kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB boost:0kB min:4kB low:4kB high:4kB reserved_highatom=
ic:0KB active_anon:36kB inactive_anon:0kB active_file:0kB inactive_file:324=
kB unevictable:0kB writepending:4kB present:1048576kB managed:360kB mlocked=
:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3946772kB boost:0kB min:54788kB low:68484kB high:82180kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:68kB unevictable:1536kB writepending:4kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 73*4kB (UM) 66*8kB (UM) 1*16kB (E) 4*32kB (UM) 0*64kB 1*128kB=
 (M) 1*256kB (M) 2*512kB (UM) 2*1024kB (ME) 1*2048kB (U) 492*4096kB (M) =3D=
 2021700kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1=
024kB 0*2048kB 0*4096kB =3D 0kB
Node 1 Normal: 5*4kB (U) 4*8kB (U) 4*16kB (U) 5*32kB (U) 8*64kB (UM) 4*128k=
B (U) 2*256kB (UM) 3*512kB (UM) 1*1024kB (U) 3*2048kB (UM) 961*4096kB (M) =
=3D 3946772kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
15855 total pagecache pages
0 pages in swap cache
Free swap  =3D 0kB
Total swap =3D 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
400839 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3223 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:14602 isolated_file:0
 unevictable:768 dirty:15 writeback:200
 slab_reclaimable:7637 slab_unreclaimable:77900
 mapped:2039 shmem:1253 pagetables:508
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1495958 free_pcp:991 free_cma:0
Node 0 active_anon:12892kB inactive_anon:0kB active_file:0kB inactive_file:=
58340kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:815=
6kB dirty:56kB writeback:800kB shmem:3476kB shmem_thp:0kB shmem_pmdmapped:0=
kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8560kB pagetables:2032kB sec=
_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:68kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2571 2571 0 0
Node 0 DMA32 free:2021700kB boost:0kB min:35108kB low:43884kB high:52660kB =
reserved_highatomic:0KB active_anon:12856kB inactive_anon:0kB active_file:0=
kB inactive_file:58016kB unevictable:1536kB writepending:852kB present:3129=
332kB managed:2660008kB mlocked:0kB bounce:0kB free_pcp:3964kB local_pcp:12=
72kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB boost:0kB min:4kB low:4kB high:4kB reserved_highatom=
ic:0KB active_anon:36kB inactive_anon:0kB active_file:0kB inactive_file:324=
kB unevictable:0kB writepending:4kB present:1048576kB managed:360kB mlocked=
:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3946772kB boost:0kB min:54788kB low:68484kB high:82180kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:68kB unevictable:1536kB writepending:4kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 73*4kB (UM) 66*8kB (UM) 1*16kB (E) 4*32kB (UM) 0*64kB 1*128kB=
 (M) 1*256kB (M) 2*512kB (UM) 2*1024kB (ME) 1*2048kB (U) 492*4096kB (M) =3D=
 2021700kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1=
024kB 0*2048kB 0*4096kB =3D 0kB
Node 1 Normal: 5*4kB (U) 4*8kB (U) 4*16kB (U) 5*32kB (U) 8*64kB (UM) 4*128k=
B (U) 2*256kB (UM) 3*512kB (UM) 1*1024kB (U) 3*2048kB (UM) 961*4096kB (M) =
=3D 3946772kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
15855 total pagecache pages
0 pages in swap cache
Free swap  =3D 0kB
Total swap =3D 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
400839 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3223 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:14602 isolated_file:0
 unevictable:768 dirty:15 writeback:200
 slab_reclaimable:7637 slab_unreclaimable:77900
 mapped:2039 shmem:1253 pagetables:508
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1495958 free_pcp:991 free_cma:0
Node 0 active_anon:12892kB inactive_anon:0kB active_file:0kB inactive_file:=
58340kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:815=
6kB dirty:56kB writeback:800kB shmem:3476kB shmem_thp:0kB shmem_pmdmapped:0=
kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8560kB pagetables:2032kB sec=
_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:68kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2571 2571 0 0
Node 0 DMA32 free:2021700kB boost:0kB min:35108kB low:43884kB high:52660kB =
reserved_highatomic:0KB active_anon:12856kB inactive_anon:0kB active_file:0=
kB inactive_file:58016kB unevictable:1536kB writepending:852kB present:3129=
332kB managed:2660008kB mlocked:0kB bounce:0kB free_pcp:3964kB local_pcp:12=
72kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB boost:0kB min:4kB low:4kB high:4kB reserved_highatom=
ic:0KB active_anon:36kB inactive_anon:0kB active_file:0kB inactive_file:324=
kB unevictable:0kB writepending:4kB present:1048576kB managed:360kB mlocked=
:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3946772kB boost:0kB min:54788kB low:68484kB high:82180kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:68kB unevictable:1536kB writepending:4kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 73*4kB (UM) 66*8kB (UM) 1*16kB (E) 4*32kB (UM) 0*64kB 1*128kB=
 (M) 1*256kB (M) 2*512kB (UM) 2*1024kB (ME) 1*2048kB (U) 492*4096kB (M) =3D=
 2021700kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1=
024kB 0*2048kB 0*4096kB =3D 0kB
Node 1 Normal: 5*4kB (U) 4*8kB (U) 4*16kB (U) 5*32kB (U) 8*64kB (UM) 4*128k=
B (U) 2*256kB (UM) 3*512kB (UM) 1*1024kB (U) 3*2048kB (UM) 961*4096kB (M) =
=3D 3946772kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
15855 total pagecache pages
0 pages in swap cache
Free swap  =3D 0kB
Total swap =3D 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
400839 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3223 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:14602 isolated_file:0
 unevictable:768 dirty:15 writeback:200
 slab_reclaimable:7637 slab_unreclaimable:77900
 mapped:2039 shmem:1253 pagetables:508
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1495958 free_pcp:991 free_cma:0
Node 0 active_anon:12892kB inactive_anon:0kB active_file:0kB inactive_file:=
58340kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:815=
6kB dirty:56kB writeback:800kB shmem:3476kB shmem_thp:0kB shmem_pmdmapped:0=
kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8560kB pagetables:2032kB sec=
_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:68kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2571 2571 0 0
Node 0 DMA32 free:2021700kB boost:0kB min:35108kB low:43884kB high:52660kB =
reserved_highatomic:0KB active_anon:12856kB inactive_anon:0kB active_file:0=
kB inactive_file:58016kB unevictable:1536kB writepending:852kB present:3129=
332kB managed:2660008kB mlocked:0kB bounce:0kB free_pcp:3964kB local_pcp:12=
72kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB boost:0kB min:4kB low:4kB high:4kB reserved_highatom=
ic:0KB active_anon:36kB inactive_anon:0kB active_file:0kB inactive_file:324=
kB unevictable:0kB writepending:4kB present:1048576kB managed:360kB mlocked=
:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3946772kB boost:0kB min:54788kB low:68484kB high:82180kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:68kB unevictable:1536kB writepending:4kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 73*4kB (UM) 66*8kB (UM) 1*16kB (E) 4*32kB (UM) 0*64kB 1*128kB=
 (M) 1*256kB (M) 2*512kB (UM) 2*1024kB (ME) 1*2048kB (U) 492*4096kB (M) =3D=
 2021700kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1=
024kB 0*2048kB 0*4096kB =3D 0kB
Node 1 Normal: 5*4kB (U) 4*8kB (U) 4*16kB (U) 5*32kB (U) 8*64kB (UM) 4*128k=
B (U) 2*256kB (UM) 3*512kB (UM) 1*1024kB (U) 3*2048kB (UM) 961*4096kB (M) =
=3D 3946772kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
15855 total pagecache pages
0 pages in swap cache
Free swap  =3D 0kB
Total swap =3D 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
400839 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3223 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:14602 isolated_file:0
 unevictable:768 dirty:15 writeback:200
 slab_reclaimable:7637 slab_unreclaimable:77900
 mapped:2039 shmem:1253 pagetables:508
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1495958 free_pcp:991 free_cma:0
Node 0 active_anon:12892kB inactive_anon:0kB active_file:0kB inactive_file:=
58340kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:815=
6kB dirty:56kB writeback:800kB shmem:3476kB shmem_thp:0kB shmem_pmdmapped:0=
kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8560kB pagetables:2032kB sec=
_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:68kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2571 2571 0 0
Node 0 DMA32 free:2021700kB boost:0kB min:35108kB low:43884kB high:52660kB =
reserved_highatomic:0KB active_anon:12856kB inactive_anon:0kB active_file:0=
kB inactive_file:58016kB unevictable:1536kB writepending:852kB present:3129=
332kB managed:2660008kB mlocked:0kB bounce:0kB free_pcp:3964kB local_pcp:12=
72kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:0kB boost:0kB min:4kB low:4kB high:4kB reserved_highatom=
ic:0KB active_anon:36kB inactive_anon:0kB active_file:0kB inactive_file:324=
kB unevictable:0kB writepending:4kB present:1048576kB managed:360kB mlocked=
:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3946772kB boost:0kB min:54788kB low:68484kB high:82180kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB =
inactive_file:68kB unevictable:1536kB writepending:4kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 73*4kB (UM) 66*8kB (UM) 1*16kB (E) 4*32kB (UM) 0*64kB 1*128kB=
 (M) 1*256kB (M) 2*512kB (UM) 2*1024kB (ME) 1*2048kB (U) 492*4096kB (M) =3D=
 2021700kB
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1=
024kB 0*2048kB 0*4096kB =3D 0kB
Node 1 Normal: 5*4kB (U) 4*8kB (U) 4*16kB (U) 5*32kB (U) 8*64kB (UM) 4*128k=
B (U) 2*256kB (UM) 3*512kB (UM) 1*1024kB (U) 3*2048kB (UM) 961*4096kB (M) =
=3D 3946772kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
15855 total pagecache pages
0 pages in swap cache
Free swap  =3D 0kB
Total swap =3D 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
400839 pages reserved
0 pages cma reserved


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

