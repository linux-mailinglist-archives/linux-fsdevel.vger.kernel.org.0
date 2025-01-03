Return-Path: <linux-fsdevel+bounces-38357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E76CA005AB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 09:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595E0162ADE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 08:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4C51C5F0F;
	Fri,  3 Jan 2025 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAYdFDt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C571B1AD3E5;
	Fri,  3 Jan 2025 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892390; cv=none; b=FiwA4mPEpZpC1ixUkFaAbyOfTpPUDpozNpICaXPK8I9IWMMFmpKV5vcGbTxumZWU4XzEA8RJjCyU+b4DI6NL078EhR1yEUQrcAdZNsNB++LyWrzzaWbo9SUuBCnPqOVoTyyftIdXZCVhXoPNLQqzZ5z1m2WTtoc06o+pzLCox8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892390; c=relaxed/simple;
	bh=azZgEyxUZ5yStL5qKwKklVZMW+QR5Yn42m5lZPo1ZNM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=s4pJO05MRG9FYY30jM4fPScK7pQsF3Yvmb+4p9hpNKtOJSNte1WcdcxzzgBv7sjeUdBQ7L9BQYhvUkQukqueYHzfwlz2/bbCLHf4zX5ONbBoXoQkfyyEy1EFJCiRCFbGbPYuZm9e3d/g4D27eNmFFqTG4tHK3f0YDUKyqZjUXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAYdFDt3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa679ad4265so2354395766b.0;
        Fri, 03 Jan 2025 00:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735892387; x=1736497187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=azZgEyxUZ5yStL5qKwKklVZMW+QR5Yn42m5lZPo1ZNM=;
        b=gAYdFDt3cpvMXTuxky+kEm958+Ob3NhD0sxwQZllYHcD7ykRjour9QORdobni0Rw4s
         FXnVrn1/YjipPN1pGW2GzrcTxGqRRZ86r6YgBciIostVHd3LF0WsMg0UeUH0Larpo+8y
         8PSHO/oRVKGYYXNPh1yeJDsCWmV36/PYkf78Bc5LI3aXZatOhpSPWEe9BJx4+zUcV60d
         bpjUwEUOBr8y/zzMqEwnmHfU+qYiJtXIYcUT7kxbaeQY941dcfreB/r5SrBhzGJc5hEr
         B4G+QMbptm5Y5rrRuDm6HyCaZdBaS09X+n39nSRinRXOE3Vmny0pigfasOy6JcPTRKml
         BT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735892387; x=1736497187;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azZgEyxUZ5yStL5qKwKklVZMW+QR5Yn42m5lZPo1ZNM=;
        b=TDDj0vfZRWevzYWlm5mo/WtfomKx9TYz4CjdY8AbOAqeC6amctybmYNQ5SLrXNrC+F
         bdCjoHlCKpk5OkI5DRBp8VmWVSB7syDbjTynsw/xbKLb539Cd6W+2LlX7PsllWO3XoHa
         MUeumywS6rSOQnorpxNmnDp54W9tzgMaO8zJrcQNqHYOiQjI74r9U4DnWt8nI9ceWdhQ
         vRuVImgi9eOnvry0y3WLwJsyXyhbvlhx+OqAGjV5kenOM+QVQI3FPTk4O+/h8nGL6px3
         Xpdri6Dt3ioX7Br2fFLibXddZie4RmyHNTu2XAog1mYMVpgkl1Gbpbyehch5wziejoHi
         NsKw==
X-Forwarded-Encrypted: i=1; AJvYcCVRt1edI7wJHiKUkO0MUKR4aI02nW08qOU4uxLR+MTrEGJNrnqeBTwvn8OBLC0PE/auH+chQ3G9CaInDORq@vger.kernel.org, AJvYcCX5eU261FpLr6IwCZd5cUpL/idAPbuhqERc5WNxbVme2OB8WIQyupKYOXroO8aoUpFaS4v3I+jhDtUcqpnV@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOY6fzJ7PthM6lgw3rv9AtcQeZz3078HbS9GvslXFZhuv1Ad6
	tQAZR1E8I5G7Nzv16bwhhRGp5JgFDZnRTeqNz3wlBQ5+RKhOAcoOcrnRacovOKPWhAa4/5dUxkJ
	7P28Xh/+5HTN0UCVzAXSzy5ydNRDNG8/c
X-Gm-Gg: ASbGncs+3gvfh91pt+u8GrcuJi2Jy0DFZux6tHgSPAJuIRO+ZFCtOVh0XFuxYBYqi/k
	ZUPhZ8Yy11/hSpOUXZjmotCtjx1PU9vXHRxW6yE8=
X-Google-Smtp-Source: AGHT+IFAoUKPorYGUI4+Rocmu8JPMdQOdR7QPJSJAUnpegYGm55+Xbi0LRnryDD20TQSLvChEL6GhlkLn68KSdgJnHw=
X-Received: by 2002:a17:907:9443:b0:aab:7289:fcd4 with SMTP id
 a640c23a62f3a-aac0822b338mr3925102066b.19.1735892386968; Fri, 03 Jan 2025
 00:19:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Fri, 3 Jan 2025 16:19:35 +0800
Message-ID: <CAKHoSAu3D+s_jzquKrR2YXFd_gNMu5AfDg7_+HjYEtyCSwJ-4g@mail.gmail.com>
Subject: "WARNING in max_vclocks_store" in Linux kernel version 6.13.0-rc2
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 6.13.0-rc2. This issue was discovered using our
custom vulnerability discovery tool.

HEAD commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4 (tag: v6.13-rc2)

Detailed Call Stack:

------------[ cut here begin]------------

loop3: detected capacity change from 0 to 128
rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
3-.... } 5 jiffies s: 1465 root: 0x8/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 1 to CPUs 3:
NMI backtrace for cpu 3
CPU: 3 UID: 0 PID: 15107 Comm: syz-executor.5 Tainted: G U
6.13.0-rc2-00159-gf932fb9b4074 #1
Tainted: [U]=USER
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:arch_static_branch arch/x86/include/asm/jump_label.h:36 [inline]
RIP: 0010:native_write_msr arch/x86/include/asm/msr.h:149 [inline]
RIP: 0010:wrmsrl arch/x86/include/asm/msr.h:264 [inline]
RIP: 0010:lapic_next_deadline+0x25/0x50 arch/x86/kernel/apic/apic.c:428
Code: 90 90 90 90 90 f3 0f 1e fa 66 0f 1f 44 00 00 0f 31 48 c1 e2 20
b9 e0 06 00 00 48 09 c2 48 8d 04 fa 48 89 c2 48 c1 ea 20 0f 30 <66> 90
31 c0 e9 52 78 f8 02 48 89 c6 31 d2 bf e0 06 00 00 e8 63 68
RSP: 0018:ffff88811b389780 EFLAGS: 00000012
RAX: 00000068262333d9 RBX: ffff88811b3a8280 RCX: 00000000000006e0
RDX: 0000000000000068 RSI: ffff88811b3a8280 RDI: 00000000000001c7
RBP: 00000000000001c7 R08: 0000000000000001 R09: ffffed10236712d2
R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000003 R14: ffff88811b3ac878 R15: ffff88811b3ac8b8
FS: 00007fbaec3f2640(0000) GS:ffff88811b380000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055804c171de8 CR3: 000000000489c000 CR4: 0000000000350ef0
Call Trace:
<NMI>
</NMI>
<IRQ>
clockevents_program_event+0x208/0x310 kernel/time/clockevents.c:334
tick_program_event+0x72/0x100 kernel/time/tick-oneshot.c:44
hrtimer_interrupt+0x335/0x770 kernel/time/hrtimer.c:1878
local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
__sysvec_apic_timer_interrupt+0x88/0x260 arch/x86/kernel/apic/apic.c:1055
instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
sysvec_apic_timer_interrupt+0x32/0x80 arch/x86/kernel/apic/apic.c:1049
asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:unwind_next_frame+0x451/0x2440 arch/x86/kernel/unwind_orc.c:505
Code: 48 85 c0 75 0c e9 1a 02 00 00 48 c7 c1 a0 ba aa a3 48 b8 00 00
00 00 00 fc ff df 4c 8d 79 05 4c 89 fa 48 c1 ea 03 0f b6 04 02 <4c> 89
fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 a1 16 00 00 0f b6 41 05
RSP: 0018:ffff88811b389958 EFLAGS: 00000216
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffffa4652644
RDX: 1ffffffff48ca4c9 RSI: 0000000000000000 RDI: ffffffffa432bcd8
RBP: ffff88811b389a20 R08: ffffffffa465267a R09: ffff88811b389a08
R10: ffff88811b3899c8 R11: 00000000000087a0 R12: ffff88811b389a28
R13: ffff88811b3899c8 R14: ffff88811b389a09 R15: ffffffffa4652649
arch_stack_walk+0x95/0x100 arch/x86/kernel/stacktrace.c:25
stack_trace_save+0x8f/0xc0 kernel/stacktrace.c:122
kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
kasan_save_track+0x14/0x30 mm/kasan/common.c:68
kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
poison_slab_object mm/kasan/common.c:247 [inline]
__kasan_slab_free+0x37/0x50 mm/kasan/common.c:264
kasan_slab_free include/linux/kasan.h:233 [inline]
slab_free_hook mm/slub.c:2338 [inline]
slab_free mm/slub.c:4598 [inline]
kfree+0xea/0x370 mm/slub.c:4746
slab_free_after_rcu_debug+0x6f/0x2a0 mm/slub.c:4635
rcu_do_batch kernel/rcu/tree.c:2567 [inline]
rcu_core+0x613/0x1a80 kernel/rcu/tree.c:2823
handle_softirqs+0x1b8/0x5c0 kernel/softirq.c:561
__do_softirq kernel/softirq.c:595 [inline]
invoke_softirq kernel/softirq.c:435 [inline]
__irq_exit_rcu kernel/softirq.c:662 [inline]
irq_exit_rcu+0xaf/0xe0 kernel/softirq.c:678
instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
sysvec_apic_timer_interrupt+0x6c/0x80 arch/x86/kernel/apic/apic.c:1049
</IRQ>
<TASK>
asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x15c/0x1b0 mm/kasan/generic.c:189
Code: c2 48 85 c0 75 ad 48 89 da 4c 89 d8 4c 29 da e9 46 ff ff ff 48
85 d2 74 18 48 01 ea eb 09 48 83 c0 01 48 39 d0 74 0a 80 38 00 <74> f2
e9 75 ff ff ff 5b b8 01 00 00 00 5d 41 5c e9 2f 13 91 02 b8
RSP: 0018:ffff8881078bf878 EFLAGS: 00000202
RAX: fffffbfff4ac2510 RBX: fffffbfff4ac2511 RCX: ffffffffa2a89bb1
RDX: fffffbfff4ac2511 RSI: 0000000000000004 RDI: ffffffffa5612880
RBP: fffffbfff4ac2510 R08: 0000000000000001 R09: fffffbfff4ac2510
R10: ffffffffa5612883 R11: 0000000000000176 R12: 0000000000000001
R13: ffff8881078bfa80 R14: ffff888009e2b800 R15: ffff8881078bfad0
instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
atomic_try_cmpxchg_acquire
include/linux/atomic/atomic-instrumented.h:1300 [inline]
queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
do_raw_spin_lock include/linux/spinlock.h:187 [inline]
__raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
_raw_spin_lock+0x71/0xe0 kernel/locking/spinlock.c:154
spin_lock include/linux/spinlock.h:351 [inline]
locks_start+0x8f/0xf0 fs/locks.c:2941
seq_read_iter+0x278/0x10c0 fs/seq_file.c:225
proc_reg_read_iter+0x1dd/0x2b0 fs/proc/inode.c:299
copy_splice_read+0x55f/0xa60 fs/splice.c:365
do_splice_read fs/splice.c:985 [inline]
do_splice_read+0x1ab/0x250 fs/splice.c:959
splice_direct_to_actor+0x26a/0x9f0 fs/splice.c:1089
do_splice_direct_actor fs/splice.c:1207 [inline]
do_splice_direct+0x15d/0x220 fs/splice.c:1233
do_sendfile+0x9ea/0xde0 fs/read_write.c:1363
__do_sys_sendfile64 fs/read_write.c:1424 [inline]
__se_sys_sendfile64 fs/read_write.c:1410 [inline]
__x64_sys_sendfile64+0x19f/0x1e0 fs/read_write.c:1410
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbaed37842d
Code: c3 e8 97 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbaec3f2038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fbaed56c1f0 RCX: 00007fbaed37842d
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 00007fbaed437922 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000400000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fbaed56c1f0 R15: 00007fbaec3d2000
</TASK>
rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
3-.... } 27 jiffies s: 1465 root: 0x8/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 1 to CPUs 3:
NMI backtrace for cpu 3
CPU: 3 UID: 0 PID: 15107 Comm: syz-executor.5 Tainted: G U
6.13.0-rc2-00159-gf932fb9b4074 #1
Tainted: [U]=USER
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:__read_once_word_nocheck+0x0/0x10 include/asm-generic/rwonce.h:67
Code: a6 fd ff ff e8 c1 e8 64 00 e9 5f fd ff ff 66 2e 0f 1f 84 00 00
00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <48> 8b
07 e9 d8 f5 f5 02 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
RSP: 0018:ffff88811b389908 EFLAGS: 00000202
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffff8881078c0000
RDX: ffff8881078bf801 RSI: ffff8881078bf878 RDI: ffff8881078bf878
RBP: ffff8881078bf878 R08: 0000000000000001 R09: ffff88811b3899c0
R10: ffff88811b389980 R11: 00000000000084b8 R12: ffff88811b3899e0
R13: ffff88811b389980 R14: ffff8881078bf888 R15: ffff8881078bf880
FS: 00007fbaec3f2640(0000) GS:ffff88811b380000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055804c171de8 CR3: 000000000489c000 CR4: 0000000000350ef0
Call Trace:
<NMI>
</NMI>
<IRQ>
deref_stack_reg arch/x86/kernel/unwind_orc.c:406 [inline]
unwind_next_frame+0xc42/0x2440 arch/x86/kernel/unwind_orc.c:648
arch_stack_walk+0x95/0x100 arch/x86/kernel/stacktrace.c:25
stack_trace_save+0x8f/0xc0 kernel/stacktrace.c:122
kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
__kasan_record_aux_stack+0x8e/0xa0 mm/kasan/generic.c:544
__call_rcu_common.constprop.0+0x6b/0xa90 kernel/rcu/tree.c:3086
kmemleak_free_recursive include/linux/kmemleak.h:49 [inline]
slab_free_hook mm/slub.c:2263 [inline]
slab_free mm/slub.c:4598 [inline]
kfree+0x1ef/0x370 mm/slub.c:4746
slab_free_after_rcu_debug+0x6f/0x2a0 mm/slub.c:4635
rcu_do_batch kernel/rcu/tree.c:2567 [inline]
rcu_core+0x613/0x1a80 kernel/rcu/tree.c:2823
handle_softirqs+0x1b8/0x5c0 kernel/softirq.c:561
__do_softirq kernel/softirq.c:595 [inline]
invoke_softirq kernel/softirq.c:435 [inline]
__irq_exit_rcu kernel/softirq.c:662 [inline]
irq_exit_rcu+0xaf/0xe0 kernel/softirq.c:678
instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
sysvec_apic_timer_interrupt+0x6c/0x80 arch/x86/kernel/apic/apic.c:1049
</IRQ>
<TASK>
asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__sanitizer_cov_trace_pc+0x56/0x80 kernel/kcov.c:222
Code: 00 f0 00 75 3c 8b 82 a4 0a 00 00 85 c0 74 32 8b 82 80 0a 00 00
83 f8 02 75 27 48 8b b2 88 0a 00 00 8b 92 84 0a 00 00 48 8b 06 <48> 83
c0 01 48 39 d0 73 0e 48 89 06 48 81 e9 00 00 a0 1e 48 89 0c
RSP: 0018:ffff8881078bf588 EFLAGS: 00000246
RAX: 00000000000001ae RBX: ffff88800d37c000 RCX: ffffffffa2a3ea2d
RDX: 0000000000040000 RSI: ffffc90003db9000 RDI: ffffffffa2facda1
RBP: ffff88800d37c001 R08: 0000000000000000 R09: ffff8881064bb230
R10: 0000000000000003 R11: 0000000000000176 R12: ffff88800d37d000
R13: 00000000fffffffc R14: ffff8881078bf628 R15: dffffc0000000000
number+0x66d/0x970 lib/vsprintf.c:565
vsnprintf+0x8d3/0x16e0 lib/vsprintf.c:2914
seq_vprintf fs/seq_file.c:391 [inline]
seq_printf+0x1a5/0x260 fs/seq_file.c:406
lock_get_status+0x187/0x760 fs/locks.c:2776
locks_show+0x208/0x3c0 fs/locks.c:2873
seq_read_iter+0x470/0x10c0 fs/seq_file.c:230
proc_reg_read_iter+0x1dd/0x2b0 fs/proc/inode.c:299
copy_splice_read+0x55f/0xa60 fs/splice.c:365
do_splice_read fs/splice.c:985 [inline]
do_splice_read+0x1ab/0x250 fs/splice.c:959
splice_direct_to_actor+0x26a/0x9f0 fs/splice.c:1089
do_splice_direct_actor fs/splice.c:1207 [inline]
do_splice_direct+0x15d/0x220 fs/splice.c:1233
do_sendfile+0x9ea/0xde0 fs/read_write.c:1363
__do_sys_sendfile64 fs/read_write.c:1424 [inline]
__se_sys_sendfile64 fs/read_write.c:1410 [inline]
__x64_sys_sendfile64+0x19f/0x1e0 fs/read_write.c:1410
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbaed37842d
Code: c3 e8 97 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbaec3f2038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fbaed56c1f0 RCX: 00007fbaed37842d
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 00007fbaed437922 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000400000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fbaed56c1f0 R15: 00007fbaec3d2000
</TASK>
loop7: detected capacity change from 0 to 1024
EXT4-fs: Journaled quota options ignored when QUOTA feature is enabled
loop2: detected capacity change from 0 to 1024
EXT4-fs error (device loop7): ext4_orphan_get:1415: comm
syz-executor.7: bad orphan inode 83886080
EXT4-fs (loop7): mounted filesystem
00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode:
writeback.
EXT4-fs (loop2): orphan cleanup on readonly fs
EXT4-fs error (device loop2): ext4_orphan_get:1415: comm
syz-executor.2: bad orphan inode 83886080
EXT4-fs (loop2): mounting with "discard" option, but the device does
not support discard
EXT4-fs (loop7): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs (loop2): mounted filesystem
00000000-0000-0000-0000-000000000000 ro without journal. Quota mode:
writeback.
EXT4-fs (loop2): unmounting filesystem 00000000-0000-0000-0000-000000000000.

------------[ cut here end]------------

Thank you for your time and attention.

Best regards

Wall

