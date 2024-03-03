Return-Path: <linux-fsdevel+bounces-13398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0DF86F6DF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 20:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6A11C209E8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 19:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B2679DB2;
	Sun,  3 Mar 2024 19:49:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD00979B6C
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Mar 2024 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709495361; cv=none; b=IGnNCEb4A6u6jlNAFPYrSg4Q+TkcQXNV4aUOba4Q5l4sw1bCeUJbuQuJXgcewPpU4vGfHdRUWdV/g4PpmkUG2ElC79tl7h7YX/bpyHd/F07qvSTd0go3/RBf32/+5hzfAuzzmX1sPJvUJ6xohdO1sdYCI+dXOjlJmiFjDzM0NFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709495361; c=relaxed/simple;
	bh=CUIYK2JRwZF6X6bTzSIwCoCJy3VT8YVF08oPfXtuyQQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R7hQs5CZqDAMbWYBUGfcDkohuamnAGjMEJlDkenNpKdpRRLVfDy2vh8agpEXbeLsCyfLf7mgOgk552cm4dq6wWTxah5/gqWx5DLSLbSKIpJNu+7ZQreHB5MrpNwzTvP7xZSJs5QzSwWLa3Vn32gW8qPSxDzxbBgVdf9kNX14QlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7857e6cb8so533489639f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Mar 2024 11:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709495357; x=1710100157;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/CpWopiUZXzP5OnuuSBHJBUJU1bVeyF7LLzSSkuRpk=;
        b=wCYE6S6f3mifggLcB0/8xWO7dNCXsJj4PgkFaNkCoq34NZVWA/q4iH1C3Sjlwv6OtC
         WE0MQ1JdIv4Hz9Wao3OaSA/gxP7WshGXBRgnpXyOVNZBMO4x3xzoYN4PXi1zV+OLpV5P
         cKD/yNvr3pHgWAp3Njb/UCl5BbOhFrjOYRK1bsopPQi7WntEexVd7Wii5msrsFtKBfMt
         uSy04YmJYFwNldrRf/fC3bucP2RZDTNXYQG8NQWbMXSkBcCK3ktmbjjgo16O9HAgjc+u
         IB+kAa2coTskfQMycKK1722so0xZJGIyKFrrf1/nWKo6RTfWT/A3GOEC7Vqy/obBsr7M
         2CmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVymZDD0QqKwkwrebHkZHyGZUwQCFkqRyOcO03JACilD6QA6iXi922dBAMLpp0UMak+6KaPLRmetm5SL4z1pe7W/a1cq1mX4Oq6N6XV2Q==
X-Gm-Message-State: AOJu0YzczRvOvKOhsKrRtX8e868CWvemsZSX4tQdBg9LOiUXCXOPszNs
	MomoMSSnTaOF/w/Xgfi/qNRQTBbhr+N8lI+U+X1R4YHDOPK4byET49+RdhMgwyrxfRjCWdJ6Ft2
	XOKQSFGmxrTwxEgrqldwef/Cau1Iikj96GdgLnKi6qxYwUr1ddftbpeE=
X-Google-Smtp-Source: AGHT+IEk2pk3ktIQIkVqpiRctW4/PaVyVGGCOR2Ztxsoh/C0MsH94s532cNl7LkovWZ34QEZROjIUXdXAfnSo9GNJ0Y+ZzVc4XR2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16ca:b0:474:c881:1bff with SMTP id
 g10-20020a05663816ca00b00474c8811bffmr263584jat.2.1709495357059; Sun, 03 Mar
 2024 11:49:17 -0800 (PST)
Date: Sun, 03 Mar 2024 11:49:17 -0800
In-Reply-To: <0000000000007779580602d67eba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080b6bc0612c6e74b@google.com>
Subject: Re: [syzbot] [ext4?] INFO: rcu detected stall in sys_unlink (3)
From: syzbot <syzbot+c4f62ba28cc1290de764@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, akpm@linux-foundation.org, brauner@kernel.org, 
	hdanton@sina.com, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has found a reproducer for the following issue on:

HEAD commit:    04b8076df253 Merge tag 'firewire-fixes-6.8-rc7' of git://g.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D10d0e374180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8a9dc475f1caec0=
d
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc4f62ba28cc1290de=
764
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1428f96a18000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D162b27ca180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/30059a8d8498/disk-=
04b8076d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/23ec353155a8/vmlinux-=
04b8076d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2144e90e6e77/bzI=
mage-04b8076d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+c4f62ba28cc1290de764@syzkaller.appspotmail.com

Total swap =3D 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
400165 pages reserved
0 pages cma reserved
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-...!: (146 ticks this GP) idle=3D1d14/1/0x4000000000000000 softirq=
=3D7999/7999 fqs=3D0
rcu: 	(t=3D10559 jiffies g=3D9069 q=3D106 ncpus=3D2)
rcu: rcu_preempt kthread starved for 10559 jiffies! g9069 f0x0 RCU_GP_WAIT_=
FQS(5) ->state=3D0x0 ->cpu=3D1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expec=
ted behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R
  running task     stack:26256 pid:17    tgid:17    ppid:2      flags:0x000=
04000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x177f/0x49a0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 schedule_timeout+0x1bd/0x310 kernel/time/timer.c:2183
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:1663
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:1862
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
(ME) 2*512kB=20
NMI backtrace for cpu 0
CPU: 0 PID: 5094 Comm: udevd Not tainted 6.8.0-rc6-syzkaller-00250-g04b8076=
df253 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 01/25/2024
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x2e/0x70 kernel/kcov.c:207
Code: 48 8b 04 24 65 48 8b 0d 60 52 70 7e 65 8b 15 61 52 70 7e f7 c2 00 01 =
ff 00 74 11 f7 c2 00 01 00 00 74 35 83 b9 fc 15 00 00 00 <74> 2c 8b 91 d8 1=
5 00 00 83 fa 02 75 21 48 8b 91 e0 15 00 00 48 8b
RSP: 0018:ffffc90000006b18 EFLAGS: 00000046
RAX: ffffffff8b578a2c RBX: 0000000000000018 RCX: ffff88801f155940
RDX: 0000000000000105 RSI: 0000000000000018 RDI: 0000000000000029
RBP: ffffc90000006c10 R08: ffffffff8b578a1d R09: ffffffff8b578384
R10: 0000000000000012 R11: ffff88801f155940 R12: ffffffff8bab760b
R13: dffffc0000000000 R14: ffff0a1000000609 R15: 1ffff92000000d90
FS:  00007f9105b73c80(0000) GS:ffff8880b9400000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5a3399698c CR3: 0000000023ce4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 vsnprintf+0x82c/0x1da0 lib/vsprintf.c:2857
 sprintf+0xda/0x120 lib/vsprintf.c:3028
 print_time kernel/printk/printk.c:1324 [inline]
 info_print_prefix+0x16b/0x310 kernel/printk/printk.c:1350
 record_print_text kernel/printk/printk.c:1399 [inline]
 printk_get_next_message+0x408/0xce0 kernel/printk/printk.c:2828
 console_emit_next_record kernel/printk/printk.c:2868 [inline]
 console_flush_all+0x42d/0xec0 kernel/printk/printk.c:2967
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3036
 vprintk_emit+0x508/0x720 kernel/printk/printk.c:2303
 _printk+0xd5/0x120 kernel/printk/printk.c:2328
 show_free_areas mm/show_mem.c:381 [inline]
 __show_mem+0x1dad/0x24a0 mm/show_mem.c:406
 kbd_keycode drivers/tty/vt/keyboard.c:1524 [inline]
 kbd_event+0x30fa/0x4910 drivers/tty/vt/keyboard.c:1543
 input_to_handler drivers/input/input.c:132 [inline]
 input_pass_values+0x945/0x1200 drivers/input/input.c:161
 input_event_dispose drivers/input/input.c:378 [inline]
 input_handle_event drivers/input/input.c:406 [inline]
 input_repeat_key+0x3fd/0x6c0 drivers/input/input.c:2263
 call_timer_fn+0x17e/0x600 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x621/0x830 kernel/time/timer.c:2038
 run_timer_softirq+0x67/0xf0 kernel/time/timer.c:2051
 __do_softirq+0x2bb/0x942 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu+0xf1/0x1c0 kernel/softirq.c:632
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x97/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:=
649
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152=
 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:=
194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 de 20 89 f6 f6 44 24 =
21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> d3 30 fb f5 6=
5 8b 05 14 a3 9a 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc900045b7640 EFLAGS: 00000206
RAX: ee357804744bd700 RBX: 1ffff920008b6ecc RCX: ffffffff8171883a
RDX: dffffc0000000000 RSI: ffffffff8baab660 RDI: 0000000000000001
RBP: ffffc900045b76d0 R08: ffffffff92c5847f R09: 1ffffffff258b08f
R10: dffffc0000000000 R11: fffffbfff258b090 R12: dffffc0000000000
R13: 1ffff920008b6ec8 R14: ffffc900045b7660 R15: 0000000000000246
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 unlock_page_lruvec_irqrestore include/linux/memcontrol.h:1672 [inline]
 folio_batch_move_lru+0x5bf/0x6e0 mm/swap.c:223
 lru_add_drain_cpu+0x10e/0x8c0 mm/swap.c:652
 lru_add_drain+0x122/0x3e0 mm/swap.c:752
 __folio_batch_release+0x55/0x100 mm/swap.c:1059
 folio_batch_release include/linux/pagevec.h:83 [inline]
 shmem_undo_range+0x6b5/0x1da0 mm/shmem.c:1005
 shmem_truncate_range mm/shmem.c:1114 [inline]
 shmem_evict_inode+0x29b/0xa60 mm/shmem.c:1242
 evict+0x2a8/0x630 fs/inode.c:665
 do_unlinkat+0x512/0x830 fs/namei.c:4409
 __do_sys_unlink fs/namei.c:4450 [inline]
 __se_sys_unlink fs/namei.c:4448 [inline]
 __x64_sys_unlink+0x49/0x60 fs/namei.c:4448
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f9105717da7
Code: f0 ff ff 73 01 c3 48 8b 0d 7e 90 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 =
66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 8b 0d 51 90 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe5654eff8 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00005652be82f120 RCX: 00007f9105717da7
RDX: 0000000000000000 RSI: 00005652c02de5b6 RDI: 00007ffe5654f008
RBP: 00007ffe5654f008 R08: 0000000000000000 R09: a2fe887a70a571ef
R10: 0000000000000010 R11: 0000000000000206 R12: 00005652c0302550
R13: 000000000aba9500 R14: 0000000003938700 R15: 00005652be82f160
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 3.624 m=
secs
CPU: 1 PID: 4510 Comm: udevd Not tainted 6.8.0-rc6-syzkaller-00250-g04b8076=
df253 #0
(UM) 3*1024kB=20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 01/25/2024
(UME) 3*2048kB=20
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152=
 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:=
194
(UME) 486*4096kB=20
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 de 20 89 f6 f6 44 24 =
21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> d3 30 fb f5 6=
5 8b 05 14 a3 9a 74 85 c0 74 43 48 c7 04 24 0e 36
(M) =3D 2022008kB
RSP: 0018:ffffc900001f0b20 EFLAGS: 00000206
Node 0 Normal:=20

RAX: a11e17df085f1d00 RBX: 1ffff9200003e168 RCX: ffffffff8171883a
1*4kB=20
RDX: dffffc0000000000 RSI: ffffffff8baab660 RDI: 0000000000000001
(M) 0*8kB=20
RBP: ffffc900001f0bb0 R08: ffffffff92c584ef R09: 1ffffffff258b09d
0*16kB=20
R10: dffffc0000000000 R11: fffffbfff258b09e R12: dffffc0000000000
0*32kB 0*64kB=20
R13: 1ffff9200003e164 R14: ffffc900001f0b40 R15: 0000000000000246
0*128kB=20
FS:  00007f9105b73c80(0000) GS:ffff8880b9500000(0000) knlGS:000000000000000=
0
0*256kB=20
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
0*512kB=20
CR2: 00007f5a33982ce8 CR3: 0000000021d0e000 CR4: 00000000003506f0
0*1024kB=20
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
0*2048kB=20
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
0*4096kB=20
Call Trace:
 <IRQ>
=3D 4kB
Node 1=20
Normal: 6*4kB=20
(UM) 5*8kB=20
(UM) 6*16kB=20
(UM) 8*32kB=20
(UM) 11*64kB=20
(UM) 6*128kB=20
(UM) 2*256kB=20
(U) 2*512kB=20
(UM) 7*1024kB=20
(U) 2*2048kB=20
(UM) 961*4096kB=20
(M)=20
=3D 3950944kB
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
 call_timer_fn+0x17e/0x600 kernel/time/timer.c:1700
0 pages HighMem/MovableOnly
400165 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:251 inactive_anon:3139 isolated_anon:0
 active_file:3353 inactive_file:11233 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:8118 slab_unreclaimable:78394
 mapped:2037 shmem:1265 pagetables:621
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1497079 free_pcp:467 free_cma:0
Node 0 active_anon:1004kB inactive_anon:12556kB active_file:13332kB inactiv=
e_file:44932kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB map=
ped:8148kB dirty:0kB writeback:0kB shmem:3524kB shmem_thp:0kB shmem_pmdmapp=
ed:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8528kB pagetables:2484kB=
 sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:80kB inactive_file:0kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0=20
DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_highatom=
ic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB =
unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0k=
B bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x621/0x830 kernel/time/timer.c:2038
 2573 2574
 2574 2574

Node 0=20
DMA32 free:2022008kB boost:0kB min:35124kB low:43904kB high:52684kB reserve=
d_highatomic:0KB active_anon:1000kB inactive_anon:12520kB active_file:12820=
kB inactive_file:44880kB unevictable:1536kB writepending:0kB present:312933=
2kB managed:2662448kB mlocked:0kB bounce:0kB free_pcp:1860kB local_pcp:1196=
kB free_cma:0kB
 run_timer_softirq+0x67/0xf0 kernel/time/timer.c:2051
lowmem_reserve[]: 0
 __do_softirq+0x2bb/0x942 kernel/softirq.c:553
 0 0
 0
 0

Node 0=20
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu+0xf1/0x1c0 kernel/softirq.c:632
Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatomic:0KB =
active_anon:4kB inactive_anon:36kB active_file:512kB inactive_file:52kB une=
victable:0kB writepending:0kB present:1048576kB managed:616kB mlocked:0kB b=
ounce:0kB free_pcp:8kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:644
 0 0
 sysvec_apic_timer_interrupt+0x97/0xb0 arch/x86/kernel/apic/apic.c:1076
 0 0
 </IRQ>

Node 1=20
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:=
649
Normal free:3950944kB boost:0kB min:54772kB low:68464kB high:82156kB reserv=
ed_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:80kB inacti=
ve_file:0kB unevictable:1536kB writepending:0kB present:4194304kB managed:4=
109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
RIP: 0010:unwind_get_return_address+0x68/0xc0 arch/x86/kernel/unwind_orc.c:=
369
lowmem_reserve[]: 0
Code: 48 49 89 df 49 c1 ef 03 43 80 3c 37 00 74 08 48 89 df e8 8b f0 b1 00 =
48 8b 3b e8 83 a9 20 00 89 c5 31 ff 89 c6 e8 98 24 53 00 <85> ed 74 20 e8 4=
f 20 53 00 43 80 3c 37 00 74 08 48 89 df e8 60 f0
 0 0
RSP: 0018:ffffc9000315f0d8 EFLAGS: 00000293
 0

RAX: 0000000000000000 RBX: ffffc9000315f148 RCX: ffffffff90d55000
 0
RDX: ffff88807d45bb80 RSI: 0000000000000001 RDI: 0000000000000000
Node 0 DMA:=20
RBP: 0000000000000001 R08: ffffffff81404bf8 R09: ffffffff814066c0
0*4kB=20
R10: 0000000000000003 R11: ffff88807d45bb80 R12: ffff88807d45bb80
0*8kB=20
R13: ffffffff818043c0 R14: dffffc0000000000 R15: 1ffff9200062be29
0*16kB=20
0*32kB=20
0*64kB=20
0*128kB=20
0*256kB=20
0*512kB=20
1*1024kB=20
 arch_stack_walk+0x124/0x1b0 arch/x86/kernel/stacktrace.c:26
(U)=20
1*2048kB=20
 stack_trace_save+0x117/0x1d0 kernel/stacktrace.c:122
(M) 3*4096kB=20
(M) =3D 15360kB
Node 0 DMA32:=20
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
462*4kB=20
(UM) 1068*8kB=20
(UME) 110*16kB=20
(UME) 104*32kB=20
(UM) 54*64kB=20
(UME) 13*128kB=20
(UME) 2*256kB=20
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
(ME) 2*512kB=20
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3981 [inline]
 __kmalloc+0x22e/0x490 mm/slub.c:3994
(UM) 3*1024kB=20
(UME)=20
 kmalloc include/linux/slab.h:594 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
3*2048kB=20
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x255/0x500 security/tomoyo/file.c:771
(UME) 486*4096kB=20
(M) =3D 2022008kB
Node 0=20
Normal: 1*4kB=20
(M) 0*8kB=20
0*16kB=20
 security_file_open+0x69/0x570 security/security.c:2933
0*32kB=20
0*64kB=20
 do_dentry_open+0x327/0x15a0 fs/open.c:940
0*128kB=20
 do_open fs/namei.c:3645 [inline]
 path_openat+0x285f/0x3240 fs/namei.c:3802
0*256kB=20
0*512kB=20
0*1024kB=20
0*2048kB=20
0*4096kB=20
 do_filp_open+0x234/0x490 fs/namei.c:3829
=3D 4kB
Node 1=20
Normal: 6*4kB=20
(UM) 5*8kB=20
(UM) 6*16kB=20
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1404
(UM) 8*32kB=20
(UM) 11*64kB=20
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_openat fs/open.c:1435 [inline]
 __se_sys_openat fs/open.c:1430 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1430
(UM) 6*128kB=20
(UM) 2*256kB=20
(U) 2*512kB=20
(UM) 7*1024kB=20
 do_syscall_64+0xf9/0x240
(U) 2*2048kB=20
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
(UM) 961*4096kB=20
RIP: 0033:0x7f91057169a4
(M) =3D 3950944kB
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 =
2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff f=
f 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
RSP: 002b:00007ffe5654b000 EFLAGS: 00000246
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
 ORIG_RAX: 0000000000000101
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f91057169a4
Node 1 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
RDX: 0000000000080000 RSI: 00007ffe5654b138 RDI: 00000000ffffff9c
15851 total pagecache pages
RBP: 00007ffe5654b138 R08: 0000000000000008 R09: 0000000000000001
0 pages in swap cache
Free swap  =3D 0kB
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
Total swap =3D 0kB
2097051 pages RAM
R13: 00005652be813b42 R14: 0000000000000001 R15: 0000000000000000
0 pages HighMem/MovableOnly
 </TASK>
400165 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:251 inactive_anon:3139 isolated_anon:0
 active_file:3353 inactive_file:11233 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:8118 slab_unreclaimable:78394
 mapped:2037 shmem:1265 pagetables:621
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1497079 free_pcp:467 free_cma:0
Node 0 active_anon:1004kB inactive_anon:12556kB active_file:13332kB inactiv=
e_file:44932kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB map=
ped:8148kB dirty:0kB writeback:0kB shmem:3524kB shmem_thp:0kB shmem_pmdmapp=
ed:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8528kB pagetables:2484kB=
 sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:80kB inactive_file:0kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2573 2574 2574 2574
Node 0 DMA32 free:2022008kB boost:0kB min:35124kB low:43904kB high:52684kB =
reserved_highatomic:0KB active_anon:1000kB inactive_anon:12520kB active_fil=
e:12820kB inactive_file:44880kB unevictable:1536kB writepending:0kB present=
:3129332kB managed:2662448kB mlocked:0kB bounce:0kB free_pcp:1860kB local_p=
cp:664kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatom=
ic:0KB active_anon:4kB inactive_anon:36kB active_file:512kB inactive_file:5=
2kB unevictable:0kB writepending:0kB present:1048576kB managed:616kB mlocke=
d:0kB bounce:0kB free_pcp:8kB local_pcp:8kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3950944kB boost:0kB min:54772kB low:68464kB high:82156kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:80kB=
 inactive_file:0kB unevictable:1536kB writepending:0kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 462*4kB (UM) 1068*8kB (UME) 110*16kB (UME) 104*32kB (UM) 54*6=
4kB (UME) 13*128kB (UME) 2*256kB (ME) 2*512kB (UM) 3*1024kB (UME) 3*2048kB =
(UME) 486*4096kB (M) =3D 2022008kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB=
 0*1024kB 0*2048kB 0*4096kB =3D 4kB
Node 1 Normal: 6*4kB (UM) 5*8kB (UM) 6*16kB (UM) 8*32kB (UM) 11*64kB (UM) 6=
*128kB (UM) 2*256kB (U) 2*512kB (UM) 7*1024kB (U) 2*2048kB (UM) 961*4096kB =
(M) =3D 3950944kB
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
400165 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:251 inactive_anon:3139 isolated_anon:0
 active_file:3353 inactive_file:11233 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:8118 slab_unreclaimable:78394
 mapped:2037 shmem:1265 pagetables:621
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1497079 free_pcp:467 free_cma:0
Node 0 active_anon:1004kB inactive_anon:12556kB active_file:13332kB inactiv=
e_file:44932kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB map=
ped:8148kB dirty:0kB writeback:0kB shmem:3524kB shmem_thp:0kB shmem_pmdmapp=
ed:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8528kB pagetables:2484kB=
 sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:80kB inactive_file:0kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2573 2574 2574 2574
Node 0 DMA32 free:2022008kB boost:0kB min:35124kB low:43904kB high:52684kB =
reserved_highatomic:0KB active_anon:1000kB inactive_anon:12520kB active_fil=
e:12820kB inactive_file:44880kB unevictable:1536kB writepending:0kB present=
:3129332kB managed:2662448kB mlocked:0kB bounce:0kB free_pcp:1860kB local_p=
cp:1196kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatom=
ic:0KB active_anon:4kB inactive_anon:36kB active_file:512kB inactive_file:5=
2kB unevictable:0kB writepending:0kB present:1048576kB managed:616kB mlocke=
d:0kB bounce:0kB free_pcp:8kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3950944kB boost:0kB min:54772kB low:68464kB high:82156kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:80kB=
 inactive_file:0kB unevictable:1536kB writepending:0kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 462*4kB (UM) 1068*8kB (UME) 110*16kB (UME) 104*32kB (UM) 54*6=
4kB (UME) 13*128kB (UME) 2*256kB (ME) 2*512kB (UM) 3*1024kB (UME) 3*2048kB =
(UME) 486*4096kB (M) =3D 2022008kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB=
 0*1024kB 0*2048kB 0*4096kB =3D 4kB
Node 1 Normal: 6*4kB (UM) 5*8kB (UM) 6*16kB (UM) 8*32kB (UM) 11*64kB (UM) 6=
*128kB (UM) 2*256kB (U) 2*512kB (UM) 7*1024kB (U) 2*2048kB (UM) 961*4096kB =
(M) =3D 3950944kB
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
400165 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:251 inactive_anon:3139 isolated_anon:0
 active_file:3353 inactive_file:11233 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:8118 slab_unreclaimable:78394
 mapped:2037 shmem:1265 pagetables:621
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1497079 free_pcp:467 free_cma:0
Node 0 active_anon:1004kB inactive_anon:12556kB active_file:13332kB inactiv=
e_file:44932kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB map=
ped:8148kB dirty:0kB writeback:0kB shmem:3524kB shmem_thp:0kB shmem_pmdmapp=
ed:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8528kB pagetables:2484kB=
 sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:80kB inactive_file:0kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2573 2574 2574 2574
Node 0 DMA32 free:2022008kB boost:0kB min:35124kB low:43904kB high:52684kB =
reserved_highatomic:0KB active_anon:1000kB inactive_anon:12520kB active_fil=
e:12820kB inactive_file:44880kB unevictable:1536kB writepending:0kB present=
:3129332kB managed:2662448kB mlocked:0kB bounce:0kB free_pcp:1860kB local_p=
cp:664kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatom=
ic:0KB active_anon:4kB inactive_anon:36kB active_file:512kB inactive_file:5=
2kB unevictable:0kB writepending:0kB present:1048576kB managed:616kB mlocke=
d:0kB bounce:0kB free_pcp:8kB local_pcp:8kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3950944kB boost:0kB min:54772kB low:68464kB high:82156kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:80kB=
 inactive_file:0kB unevictable:1536kB writepending:0kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 462*4kB (UM) 1068*8kB (UME) 110*16kB (UME) 104*32kB (UM) 54*6=
4kB (UME) 13*128kB (UME) 2*256kB (ME) 2*512kB (UM) 3*1024kB (UME) 3*2048kB =
(UME) 486*4096kB (M) =3D 2022008kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB=
 0*1024kB 0*2048kB 0*4096kB =3D 4kB
Node 1 Normal: 6*4kB (UM) 5*8kB (UM) 6*16kB (UM) 8*32kB (UM) 11*64kB (UM) 6=
*128kB (UM) 2*256kB (U) 2*512kB (UM) 7*1024kB (U) 2*2048kB (UM) 961*4096kB =
(M) =3D 3950944kB
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
400165 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:251 inactive_anon:3139 isolated_anon:0
 active_file:3353 inactive_file:11233 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:8118 slab_unreclaimable:78394
 mapped:2037 shmem:1265 pagetables:621
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1497079 free_pcp:467 free_cma:0
Node 0 active_anon:1004kB inactive_anon:12556kB active_file:13332kB inactiv=
e_file:44932kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB map=
ped:8148kB dirty:0kB writeback:0kB shmem:3524kB shmem_thp:0kB shmem_pmdmapp=
ed:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8528kB pagetables:2484kB=
 sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:80kB inactive_file:0kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2573 2574 2574 2574
Node 0 DMA32 free:2022008kB boost:0kB min:35124kB low:43904kB high:52684kB =
reserved_highatomic:0KB active_anon:1000kB inactive_anon:12520kB active_fil=
e:12820kB inactive_file:44880kB unevictable:1536kB writepending:0kB present=
:3129332kB managed:2662448kB mlocked:0kB bounce:0kB free_pcp:1860kB local_p=
cp:1196kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatom=
ic:0KB active_anon:4kB inactive_anon:36kB active_file:512kB inactive_file:5=
2kB unevictable:0kB writepending:0kB present:1048576kB managed:616kB mlocke=
d:0kB bounce:0kB free_pcp:8kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3950944kB boost:0kB min:54772kB low:68464kB high:82156kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:80kB=
 inactive_file:0kB unevictable:1536kB writepending:0kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 462*4kB (UM) 1068*8kB (UME) 110*16kB (UME) 104*32kB (UM) 54*6=
4kB (UME) 13*128kB (UME) 2*256kB (ME) 2*512kB (UM) 3*1024kB (UME) 3*2048kB =
(UME) 486*4096kB (M) =3D 2022008kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB=
 0*1024kB 0*2048kB 0*4096kB =3D 4kB
Node 1 Normal: 6*4kB (UM) 5*8kB (UM) 6*16kB (UM) 8*32kB (UM) 11*64kB (UM) 6=
*128kB (UM) 2*256kB (U) 2*512kB (UM) 7*1024kB (U) 2*2048kB (UM) 961*4096kB =
(M) =3D 3950944kB
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
400165 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:251 inactive_anon:3139 isolated_anon:0
 active_file:3353 inactive_file:11233 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:8118 slab_unreclaimable:78394
 mapped:2037 shmem:1265 pagetables:621
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1497079 free_pcp:467 free_cma:0
Node 0 active_anon:1004kB inactive_anon:12556kB active_file:13332kB inactiv=
e_file:44932kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB map=
ped:8148kB dirty:0kB writeback:0kB shmem:3524kB shmem_thp:0kB shmem_pmdmapp=
ed:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8528kB pagetables:2484kB=
 sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:80kB inactive_file:0kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2573 2574 2574 2574
Node 0 DMA32 free:2022008kB boost:0kB min:35124kB low:43904kB high:52684kB =
reserved_highatomic:0KB active_anon:1000kB inactive_anon:12520kB active_fil=
e:12820kB inactive_file:44880kB unevictable:1536kB writepending:0kB present=
:3129332kB managed:2662448kB mlocked:0kB bounce:0kB free_pcp:1860kB local_p=
cp:664kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatom=
ic:0KB active_anon:4kB inactive_anon:36kB active_file:512kB inactive_file:5=
2kB unevictable:0kB writepending:0kB present:1048576kB managed:616kB mlocke=
d:0kB bounce:0kB free_pcp:8kB local_pcp:8kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3950944kB boost:0kB min:54772kB low:68464kB high:82156kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:80kB=
 inactive_file:0kB unevictable:1536kB writepending:0kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 462*4kB (UM) 1068*8kB (UME) 110*16kB (UME) 104*32kB (UM) 54*6=
4kB (UME) 13*128kB (UME) 2*256kB (ME) 2*512kB (UM) 3*1024kB (UME) 3*2048kB =
(UME) 486*4096kB (M) =3D 2022008kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB=
 0*1024kB 0*2048kB 0*4096kB =3D 4kB
Node 1 Normal: 6*4kB (UM) 5*8kB (UM) 6*16kB (UM) 8*32kB (UM) 11*64kB (UM) 6=
*128kB (UM) 2*256kB (U) 2*512kB (UM) 7*1024kB (U) 2*2048kB (UM) 961*4096kB =
(M) =3D 3950944kB
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
400165 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:251 inactive_anon:3139 isolated_anon:0
 active_file:3353 inactive_file:11233 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:8118 slab_unreclaimable:78394
 mapped:2037 shmem:1265 pagetables:621
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1497079 free_pcp:467 free_cma:0
Node 0 active_anon:1004kB inactive_anon:12556kB active_file:13332kB inactiv=
e_file:44932kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB map=
ped:8148kB dirty:0kB writeback:0kB shmem:3524kB shmem_thp:0kB shmem_pmdmapp=
ed:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8528kB pagetables:2484kB=
 sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:80kB inactive_file:0kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2573 2574 2574 2574
Node 0 DMA32 free:2022008kB boost:0kB min:35124kB low:43904kB high:52684kB =
reserved_highatomic:0KB active_anon:1000kB inactive_anon:12520kB active_fil=
e:12820kB inactive_file:44880kB unevictable:1536kB writepending:0kB present=
:3129332kB managed:2662448kB mlocked:0kB bounce:0kB free_pcp:1860kB local_p=
cp:1196kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatom=
ic:0KB active_anon:4kB inactive_anon:36kB active_file:512kB inactive_file:5=
2kB unevictable:0kB writepending:0kB present:1048576kB managed:616kB mlocke=
d:0kB bounce:0kB free_pcp:8kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3950944kB boost:0kB min:54772kB low:68464kB high:82156kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:80kB=
 inactive_file:0kB unevictable:1536kB writepending:0kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 462*4kB (UM) 1068*8kB (UME) 110*16kB (UME) 104*32kB (UM) 54*6=
4kB (UME) 13*128kB (UME) 2*256kB (ME) 2*512kB (UM) 3*1024kB (UME) 3*2048kB =
(UME) 486*4096kB (M) =3D 2022008kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB=
 0*1024kB 0*2048kB 0*4096kB =3D 4kB
Node 1 Normal: 6*4kB (UM) 5*8kB (UM) 6*16kB (UM) 8*32kB (UM) 11*64kB (UM) 6=
*128kB (UM) 2*256kB (U) 2*512kB (UM) 7*1024kB (U) 2*2048kB (UM) 961*4096kB =
(M) =3D 3950944kB
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
400165 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:251 inactive_anon:3139 isolated_anon:0
 active_file:3353 inactive_file:11233 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:8118 slab_unreclaimable:78394
 mapped:2037 shmem:1265 pagetables:621
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1497079 free_pcp:467 free_cma:0
Node 0 active_anon:1004kB inactive_anon:12556kB active_file:13332kB inactiv=
e_file:44932kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB map=
ped:8148kB dirty:0kB writeback:0kB shmem:3524kB shmem_thp:0kB shmem_pmdmapp=
ed:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8528kB pagetables:2484kB=
 sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:80kB inactive_file:0kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2573 2574 2574 2574
Node 0 DMA32 free:2022008kB boost:0kB min:35124kB low:43904kB high:52684kB =
reserved_highatomic:0KB active_anon:1000kB inactive_anon:12520kB active_fil=
e:12820kB inactive_file:44880kB unevictable:1536kB writepending:0kB present=
:3129332kB managed:2662448kB mlocked:0kB bounce:0kB free_pcp:1860kB local_p=
cp:664kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatom=
ic:0KB active_anon:4kB inactive_anon:36kB active_file:512kB inactive_file:5=
2kB unevictable:0kB writepending:0kB present:1048576kB managed:616kB mlocke=
d:0kB bounce:0kB free_pcp:8kB local_pcp:8kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3950944kB boost:0kB min:54772kB low:68464kB high:82156kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:80kB=
 inactive_file:0kB unevictable:1536kB writepending:0kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 462*4kB (UM) 1068*8kB (UME) 110*16kB (UME) 104*32kB (UM) 54*6=
4kB (UME) 13*128kB (UME) 2*256kB (ME) 2*512kB (UM) 3*1024kB (UME) 3*2048kB =
(UME) 486*4096kB (M) =3D 2022008kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB=
 0*1024kB 0*2048kB 0*4096kB =3D 4kB
Node 1 Normal: 6*4kB (UM) 5*8kB (UM) 6*16kB (UM) 8*32kB (UM) 11*64kB (UM) 6=
*128kB (UM) 2*256kB (U) 2*512kB (UM) 7*1024kB (U) 2*2048kB (UM) 961*4096kB =
(M) =3D 3950944kB
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
400165 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:251 inactive_anon:3139 isolated_anon:0
 active_file:3353 inactive_file:11233 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:8118 slab_unreclaimable:78394
 mapped:2037 shmem:1265 pagetables:621
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1497079 free_pcp:467 free_cma:0
Node 0 active_anon:1004kB inactive_anon:12556kB active_file:13332kB inactiv=
e_file:44932kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB map=
ped:8148kB dirty:0kB writeback:0kB shmem:3524kB shmem_thp:0kB shmem_pmdmapp=
ed:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8528kB pagetables:2484kB=
 sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:80kB inactive_file:0kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2573 2574 2574 2574
Node 0 DMA32 free:2022008kB boost:0kB min:35124kB low:43904kB high:52684kB =
reserved_highatomic:0KB active_anon:1000kB inactive_anon:12520kB active_fil=
e:12820kB inactive_file:44880kB unevictable:1536kB writepending:0kB present=
:3129332kB managed:2662448kB mlocked:0kB bounce:0kB free_pcp:1860kB local_p=
cp:1196kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatom=
ic:0KB active_anon:4kB inactive_anon:36kB active_file:512kB inactive_file:5=
2kB unevictable:0kB writepending:0kB present:1048576kB managed:616kB mlocke=
d:0kB bounce:0kB free_pcp:8kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3950944kB boost:0kB min:54772kB low:68464kB high:82156kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:80kB=
 inactive_file:0kB unevictable:1536kB writepending:0kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 462*4kB (UM) 1068*8kB (UME) 110*16kB (UME) 104*32kB (UM) 54*6=
4kB (UME) 13*128kB (UME) 2*256kB (ME) 2*512kB (UM) 3*1024kB (UME) 3*2048kB =
(UME) 486*4096kB (M) =3D 2022008kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB=
 0*1024kB 0*2048kB 0*4096kB =3D 4kB
Node 1 Normal: 6*4kB (UM) 5*8kB (UM) 6*16kB (UM) 8*32kB (UM) 11*64kB (UM) 6=
*128kB (UM) 2*256kB (U) 2*512kB (UM) 7*1024kB (U) 2*2048kB (UM) 961*4096kB =
(M) =3D 3950944kB
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
400165 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:251 inactive_anon:3139 isolated_anon:0
 active_file:3353 inactive_file:11233 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:8118 slab_unreclaimable:78394
 mapped:2037 shmem:1265 pagetables:621
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1497079 free_pcp:467 free_cma:0
Node 0 active_anon:1004kB inactive_anon:12556kB active_file:13332kB inactiv=
e_file:44932kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB map=
ped:8148kB dirty:0kB writeback:0kB shmem:3524kB shmem_thp:0kB shmem_pmdmapp=
ed:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8528kB pagetables:2484kB=
 sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:80kB inactive_file:0kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2573 2574 2574 2574
Node 0 DMA32 free:2022008kB boost:0kB min:35124kB low:43904kB high:52684kB =
reserved_highatomic:0KB active_anon:1000kB inactive_anon:12520kB active_fil=
e:12820kB inactive_file:44880kB unevictable:1536kB writepending:0kB present=
:3129332kB managed:2662448kB mlocked:0kB bounce:0kB free_pcp:1860kB local_p=
cp:664kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatom=
ic:0KB active_anon:4kB inactive_anon:36kB active_file:512kB inactive_file:5=
2kB unevictable:0kB writepending:0kB present:1048576kB managed:616kB mlocke=
d:0kB bounce:0kB free_pcp:8kB local_pcp:8kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3950944kB boost:0kB min:54772kB low:68464kB high:82156kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:80kB=
 inactive_file:0kB unevictable:1536kB writepending:0kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 462*4kB (UM) 1068*8kB (UME) 110*16kB (UME) 104*32kB (UM) 54*6=
4kB (UME) 13*128kB (UME) 2*256kB (ME) 2*512kB (UM) 3*1024kB (UME) 3*2048kB =
(UME) 486*4096kB (M) =3D 2022008kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB=
 0*1024kB 0*2048kB 0*4096kB =3D 4kB
Node 1 Normal: 6*4kB (UM) 5*8kB (UM) 6*16kB (UM) 8*32kB (UM) 11*64kB (UM) 6=
*128kB (UM) 2*256kB (U) 2*512kB (UM) 7*1024kB (U) 2*2048kB (UM) 961*4096kB =
(M) =3D 3950944kB
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
400165 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:251 inactive_anon:3139 isolated_anon:0
 active_file:3353 inactive_file:11233 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:8118 slab_unreclaimable:78394
 mapped:2037 shmem:1265 pagetables:621
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1497079 free_pcp:467 free_cma:0
Node 0 active_anon:1004kB inactive_anon:12556kB active_file:13332kB inactiv=
e_file:44932kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB map=
ped:8148kB dirty:0kB writeback:0kB shmem:3524kB shmem_thp:0kB shmem_pmdmapp=
ed:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8528kB pagetables:2484kB=
 sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:80kB inactive_file:0kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2573 2574 2574 2574
Node 0 DMA32 free:2022008kB boost:0kB min:35124kB low:43904kB high:52684kB =
reserved_highatomic:0KB active_anon:1000kB inactive_anon:12520kB active_fil=
e:12820kB inactive_file:44880kB unevictable:1536kB writepending:0kB present=
:3129332kB managed:2662448kB mlocked:0kB bounce:0kB free_pcp:1860kB local_p=
cp:1196kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatom=
ic:0KB active_anon:4kB inactive_anon:36kB active_file:512kB inactive_file:5=
2kB unevictable:0kB writepending:0kB present:1048576kB managed:616kB mlocke=
d:0kB bounce:0kB free_pcp:8kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3950944kB boost:0kB min:54772kB low:68464kB high:82156kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:80kB=
 inactive_file:0kB unevictable:1536kB writepending:0kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 462*4kB (UM) 1068*8kB (UME) 110*16kB (UME) 104*32kB (UM) 54*6=
4kB (UME) 13*128kB (UME) 2*256kB (ME) 2*512kB (UM) 3*1024kB (UME) 3*2048kB =
(UME) 486*4096kB (M) =3D 2022008kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB=
 0*1024kB 0*2048kB 0*4096kB =3D 4kB
Node 1 Normal: 6*4kB (UM) 5*8kB (UM) 6*16kB (UM) 8*32kB (UM) 11*64kB (UM) 6=
*128kB (UM) 2*256kB (U) 2*512kB (UM) 7*1024kB (U) 2*2048kB (UM) 961*4096kB =
(M) =3D 3950944kB
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
400165 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:251 inactive_anon:3139 isolated_anon:0
 active_file:3353 inactive_file:11233 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:8118 slab_unreclaimable:78394
 mapped:2037 shmem:1265 pagetables:621
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1497079 free_pcp:467 free_cma:0
Node 0 active_anon:1004kB inactive_anon:12556kB active_file:13332kB inactiv=
e_file:44932kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB map=
ped:8148kB dirty:0kB writeback:0kB shmem:3524kB shmem_thp:0kB shmem_pmdmapp=
ed:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8528kB pagetables:2484kB=
 sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:80kB inactive_file:0kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2573 2574 2574 2574
Node 0 DMA32 free:2022008kB boost:0kB min:35124kB low:43904kB high:52684kB =
reserved_highatomic:0KB active_anon:1000kB inactive_anon:12520kB active_fil=
e:12820kB inactive_file:44880kB unevictable:1536kB writepending:0kB present=
:3129332kB managed:2662448kB mlocked:0kB bounce:0kB free_pcp:1860kB local_p=
cp:664kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatom=
ic:0KB active_anon:4kB inactive_anon:36kB active_file:512kB inactive_file:5=
2kB unevictable:0kB writepending:0kB present:1048576kB managed:616kB mlocke=
d:0kB bounce:0kB free_pcp:8kB local_pcp:8kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3950944kB boost:0kB min:54772kB low:68464kB high:82156kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:80kB=
 inactive_file:0kB unevictable:1536kB writepending:0kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 462*4kB (UM) 1068*8kB (UME) 110*16kB (UME) 104*32kB (UM) 54*6=
4kB (UME) 13*128kB (UME) 2*256kB (ME) 2*512kB (UM) 3*1024kB (UME) 3*2048kB =
(UME) 486*4096kB (M) =3D 2022008kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB=
 0*1024kB 0*2048kB 0*4096kB =3D 4kB
Node 1 Normal: 6*4kB (UM) 5*8kB (UM) 6*16kB (UM) 8*32kB (UM) 11*64kB (UM) 6=
*128kB (UM) 2*256kB (U) 2*512kB (UM) 7*1024kB (U) 2*2048kB (UM) 961*4096kB =
(M) =3D 3950944kB
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
400165 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:251 inactive_anon:3139 isolated_anon:0
 active_file:3353 inactive_file:11233 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:8118 slab_unreclaimable:78394
 mapped:2037 shmem:1265 pagetables:621
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1497079 free_pcp:467 free_cma:0
Node 0 active_anon:1004kB inactive_anon:12556kB active_file:13332kB inactiv=
e_file:44932kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB map=
ped:8148kB dirty:0kB writeback:0kB shmem:3524kB shmem_thp:0kB shmem_pmdmapp=
ed:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8528kB pagetables:2484kB=
 sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:80kB inactive_file:0kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2573 2574 2574 2574
Node 0 DMA32 free:2022008kB boost:0kB min:35124kB low:43904kB high:52684kB =
reserved_highatomic:0KB active_anon:1000kB inactive_anon:12520kB active_fil=
e:12820kB inactive_file:44880kB unevictable:1536kB writepending:0kB present=
:3129332kB managed:2662448kB mlocked:0kB bounce:0kB free_pcp:1860kB local_p=
cp:1196kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatom=
ic:0KB active_anon:4kB inactive_anon:36kB active_file:512kB inactive_file:5=
2kB unevictable:0kB writepending:0kB present:1048576kB managed:616kB mlocke=
d:0kB bounce:0kB free_pcp:8kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3950944kB boost:0kB min:54772kB low:68464kB high:82156kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:80kB=
 inactive_file:0kB unevictable:1536kB writepending:0kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 462*4kB (UM) 1068*8kB (UME) 110*16kB (UME) 104*32kB (UM) 54*6=
4kB (UME) 13*128kB (UME) 2*256kB (ME) 2*512kB (UM) 3*1024kB (UME) 3*2048kB =
(UME) 486*4096kB (M) =3D 2022008kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB=
 0*1024kB 0*2048kB 0*4096kB =3D 4kB
Node 1 Normal: 6*4kB (UM) 5*8kB (UM) 6*16kB (UM) 8*32kB (UM) 11*64kB (UM) 6=
*128kB (UM) 2*256kB (U) 2*512kB (UM) 7*1024kB (U) 2*2048kB (UM) 961*4096kB =
(M) =3D 3950944kB
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
400165 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:251 inactive_anon:3139 isolated_anon:0
 active_file:3353 inactive_file:11233 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:8118 slab_unreclaimable:78394
 mapped:2037 shmem:1265 pagetables:621
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1497079 free_pcp:467 free_cma:0
Node 0 active_anon:1004kB inactive_anon:12556kB active_file:13332kB inactiv=
e_file:44932kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB map=
ped:8148kB dirty:0kB writeback:0kB shmem:3524kB shmem_thp:0kB shmem_pmdmapp=
ed:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8528kB pagetables:2484kB=
 sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:80kB inactive_file:0kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2573 2574 2574 2574
Node 0 DMA32 free:2022008kB boost:0kB min:35124kB low:43904kB high:52684kB =
reserved_highatomic:0KB active_anon:1000kB inactive_anon:12520kB active_fil=
e:12820kB inactive_file:44880kB unevictable:1536kB writepending:0kB present=
:3129332kB managed:2662448kB mlocked:0kB bounce:0kB free_pcp:1860kB local_p=
cp:664kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatom=
ic:0KB active_anon:4kB inactive_anon:36kB active_file:512kB inactive_file:5=
2kB unevictable:0kB writepending:0kB present:1048576kB managed:616kB mlocke=
d:0kB bounce:0kB free_pcp:8kB local_pcp:8kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3950944kB boost:0kB min:54772kB low:68464kB high:82156kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:80kB=
 inactive_file:0kB unevictable:1536kB writepending:0kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 462*4kB (UM) 1068*8kB (UME) 110*16kB (UME) 104*32kB (UM) 54*6=
4kB (UME) 13*128kB (UME) 2*256kB (ME) 2*512kB (UM) 3*1024kB (UME) 3*2048kB =
(UME) 486*4096kB (M) =3D 2022008kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB=
 0*1024kB 0*2048kB 0*4096kB =3D 4kB
Node 1 Normal: 6*4kB (UM) 5*8kB (UM) 6*16kB (UM) 8*32kB (UM) 11*64kB (UM) 6=
*128kB (UM) 2*256kB (U) 2*512kB (UM) 7*1024kB (U) 2*2048kB (UM) 961*4096kB =
(M) =3D 3950944kB
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
400165 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:251 inactive_anon:3139 isolated_anon:0
 active_file:3353 inactive_file:11233 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:8118 slab_unreclaimable:78394
 mapped:2037 shmem:1265 pagetables:621
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1497079 free_pcp:467 free_cma:0
Node 0 active_anon:1004kB inactive_anon:12556kB active_file:13332kB inactiv=
e_file:44932kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB map=
ped:8148kB dirty:0kB writeback:0kB shmem:3524kB shmem_thp:0kB shmem_pmdmapp=
ed:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8528kB pagetables:2484kB=
 sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:80kB inactive_file:0kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2573 2574 2574 2574
Node 0 DMA32 free:2022008kB boost:0kB min:35124kB low:43904kB high:52684kB =
reserved_highatomic:0KB active_anon:1000kB inactive_anon:12520kB active_fil=
e:12820kB inactive_file:44880kB unevictable:1536kB writepending:0kB present=
:3129332kB managed:2662448kB mlocked:0kB bounce:0kB free_pcp:1860kB local_p=
cp:1196kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatom=
ic:0KB active_anon:4kB inactive_anon:36kB active_file:512kB inactive_file:5=
2kB unevictable:0kB writepending:0kB present:1048576kB managed:616kB mlocke=
d:0kB bounce:0kB free_pcp:8kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3950944kB boost:0kB min:54772kB low:68464kB high:82156kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:80kB=
 inactive_file:0kB unevictable:1536kB writepending:0kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 462*4kB (UM) 1068*8kB (UME) 110*16kB (UME) 104*32kB (UM) 54*6=
4kB (UME) 13*128kB (UME) 2*256kB (ME) 2*512kB (UM) 3*1024kB (UME) 3*2048kB =
(UME) 486*4096kB (M) =3D 2022008kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB=
 0*1024kB 0*2048kB 0*4096kB =3D 4kB
Node 1 Normal: 6*4kB (UM) 5*8kB (UM) 6*16kB (UM) 8*32kB (UM) 11*64kB (UM) 6=
*128kB (UM) 2*256kB (U) 2*512kB (UM) 7*1024kB (U) 2*2048kB (UM) 961*4096kB =
(M) =3D 3950944kB
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
400165 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:251 inactive_anon:3139 isolated_anon:0
 active_file:3353 inactive_file:11233 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:8118 slab_unreclaimable:78394
 mapped:2037 shmem:1265 pagetables:621
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1497079 free_pcp:467 free_cma:0
Node 0 active_anon:1004kB inactive_anon:12556kB active_file:13332kB inactiv=
e_file:44932kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB map=
ped:8148kB dirty:0kB writeback:0kB shmem:3524kB shmem_thp:0kB shmem_pmdmapp=
ed:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8528kB pagetables:2484kB=
 sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:80kB inactive_file:0kB=
 unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:=
0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0=
kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB al=
l_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:204kB low:252kB high:300kB reserved_h=
ighatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fi=
le:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlo=
cked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2573 2574 2574 2574
Node 0 DMA32 free:2022008kB boost:0kB min:35124kB low:43904kB high:52684kB =
reserved_highatomic:0KB active_anon:1000kB inactive_anon:12520kB active_fil=
e:12820kB inactive_file:44880kB unevictable:1536kB writepending:0kB present=
:3129332kB managed:2662448kB mlocked:0kB bounce:0kB free_pcp:1860kB local_p=
cp:664kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatom=
ic:0KB active_anon:4kB inactive_anon:36kB active_file:512kB inactive_file:5=
2kB unevictable:0kB writepending:0kB present:1048576kB managed:616kB mlocke=
d:0kB bounce:0kB free_pcp:8kB local_pcp:8kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3950944kB boost:0kB min:54772kB low:68464kB high:82156kB=
 reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:80kB=
 inactive_file:0kB unevictable:1536kB writepending:0kB present:4194304kB ma=
naged:4109120kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:=
0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024=
kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
Node 0 DMA32: 462*4kB (UM) 1068*8kB (UME) 110*16kB (UME) 104*32kB (UM) 54*6=
4kB (UME) 13*128kB (UME) 2*256kB (ME) 2*512kB (UM) 3*1024kB (UME) 3*2048kB =
(UME) 486*4096kB (M) =3D 2022008kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB=
 0*1024kB 0*2048kB 0*4096kB =3D 4kB
Node 1 Normal: 6*4kB (UM) 5*8kB (UM) 6*16kB (UM) 8*32kB (UM) 11*64kB (UM) 6=
*128kB (UM) 2*256kB (U) 2*512kB (UM) 7*1024kB (U) 2*2048kB (UM) 961*4096kB =
(M) =3D 3950944kB
Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node 0 hugepages_total=3D2 hugepages_free=3D2 hugepages_surp=3D0 hugepages_=
size=3D2048kB
Node 1 hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 hugepages_=
size=3D1048576kB
Node=20

---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

