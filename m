Return-Path: <linux-fsdevel+bounces-28200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B661C967F51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 08:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735002824B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 06:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCD315B155;
	Mon,  2 Sep 2024 06:24:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD6F155747
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258262; cv=none; b=ehgMq4xT/q61EZrCYdp98gvL0SKrcuF84FIxsnbS37s1JOq5nn30xf86B0JXJ3kUjZo8vTeezb8+0T9uByLFQ9/DvNvm7p0B+i3nPMw/DBgasF5G5fhVnlBXyM0N1B4p0tDt8Uq3YYeFCiBLpjIKwBrPTr0MkW+uAxQQ2wy1za4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258262; c=relaxed/simple;
	bh=us0DGNXDrLF2vTAcATKdjmallMIjPKrgSf/B3yoOQfQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TToHac5cHCusjtEaXjaHFuy6Vb18xqu8Gs27D4vsQEBPEJraGpMfC0TCKP61ew3Ry8I6PJGLnx8KtBsxTOUW91vxV7Gj7MPZcGu66KoL4zmlqGSrkZ2o72jL/HQJ79/vN7cu97uT9Zr+TYKyBw5NvGsR7r5orXexQ+/G2oDnKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a20e57f6aso466490739f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Sep 2024 23:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725258260; x=1725863060;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcKlK/amcxXO9GQjH+AZuDivLwBdOIjvwn47dOF9fbI=;
        b=YRqpWqlyzT4y5dfjO+jJSgrLzXvzo7NYDoHQZMNutE6G7IN85HyHj5CO8ry0upe0zj
         j6Nm8NZ3UY6t69Te6iONXh5msTKZ9AaRyNofQQuJVkJymM7Lw+I5ZFejIOtDtIOog1xI
         4Kmn4056lmQ/28C8s25EfokQCVe5NeZGiIZk/j0kse3I9RpH4ybVDtutZGzQUVi8N2On
         pIevwjmwENd2kaTZB941efbjJ1kbIaK7+I0DYQG6U5ul/sTbhdfdUBdnng2+qjsVfTwa
         BjdGu434VEkfBagZJ4qoQ3e6/kCYalfsbtxcLPYFABqN6UQ/AbIV/KmAHq0b0MevlLtV
         pXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4FIkFzLD2JrpMr3KFd9KH33bfGTeOtoHHfpjSG/Wti80hiETb3Av2vdU5/VYmH6Ll+w2Wv5xdeaayu5nF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxda8SXbTN2NFzceYx5eukSTKullJsE9/hRc4/tlGdHWKWjN66p
	inq8JMFr699M5c87Nwx58DaCUKebqEFiy7Wz2fXC7yzf+grf/hkjVa+uPFd2mNMSJV5SYJgt673
	mg6/DEnExbMeKZcY41MoX/EspY1TifVczjudgbtO5hs1az3CEr2GvwFw=
X-Google-Smtp-Source: AGHT+IGT5cCsIhdn3wtPa5F5mhUrwoO4B5s7f1VPnIWfQbfTh9j13gVaF6TcFVo+z0nrE0KEWTxBfeZoxSRMPYuGMFDFOZLoqMMj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8624:b0:4c0:a8a5:81f5 with SMTP id
 8926c6da1cb9f-4d017e9b260mr543395173.4.1725258260323; Sun, 01 Sep 2024
 23:24:20 -0700 (PDT)
Date: Sun, 01 Sep 2024 23:24:20 -0700
In-Reply-To: <00000000000087bd88062117d676@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0ac1206211cfde5@google.com>
Subject: Re: [syzbot] [fs?] [mm?] INFO: task hung in page_cache_ra_unbounded (2)
From: syzbot <syzbot+265e1cae90f8fa08f14d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c9f016e72b5c Merge tag 'x86-urgent-2024-09-01' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e68963980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8926d683f62db53e
dashboard link: https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ec21b7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d50f33980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e47617e91522/disk-c9f016e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/69d8aef7dff1/vmlinux-c9f016e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd5392c61560/bzImage-c9f016e7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+265e1cae90f8fa08f14d@syzkaller.appspotmail.com

INFO: task syz-executor317:17764 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc6-syzkaller-00017-gc9f016e72b5c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor317 state:D stack:26976 pid:17764 tgid:17761 ppid:5248   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 rwsem_down_read_slowpath kernel/locking/rwsem.c:1086 [inline]
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x705/0xa40 kernel/locking/rwsem.c:1528
 filemap_invalidate_lock_shared include/linux/fs.h:855 [inline]
 page_cache_ra_unbounded+0xf7/0x7f0 mm/readahead.c:225
 do_sync_mmap_readahead+0x49c/0x970
 filemap_fault+0x828/0x1760 mm/filemap.c:3314
 __do_fault+0x135/0x460 mm/memory.c:4655
 do_shared_fault mm/memory.c:5121 [inline]
 do_fault mm/memory.c:5195 [inline]
 do_pte_missing mm/memory.c:3947 [inline]
 handle_pte_fault+0x1176/0x6fc0 mm/memory.c:5521
 __handle_mm_fault mm/memory.c:5664 [inline]
 handle_mm_fault+0x1056/0x1ad0 mm/memory.c:5832
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x2b9/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f07b1048f2a
RSP: 002b:00007f07b1035170 EFLAGS: 00010246
RAX: 6c756e2f7665642f RBX: 00007f07b11151c8 RCX: 00007f07b1063d36
RDX: 3ef326170ff63611 RSI: 0000000000000000 RDI: 00007f07b10355a0
RBP: 00007f07b11151c0 R08: 0000000000000000 R09: 00007ffd34428c27
R10: 0000000000000008 R11: 0000000000000246 R12: 00007f07b11151cc
R13: 000000000000000b R14: 00007ffd34428b40 R15: 00007ffd34428c28
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e738320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e738320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e738320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6626
2 locks held by getty/4975:
 #0: ffff88802fe640a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ac/0x1e00 drivers/tty/n_tty.c:2211
2 locks held by syz-executor317/5250:
 #0: ffff8880b893e998 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560
 #1: ffffe8ffffd6e488 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x3a7/0x770 kernel/sched/psi.c:977
1 lock held by syz-executor317/5313:
 #0: ffff888022ca7c40 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:845 [inline]
 #0: ffff888022ca7c40 (mapping.invalidate_lock#2){++++}-{3:3}, at: blkdev_fallocate+0x1fc/0x530 block/fops.c:807
1 lock held by syz-executor317/17764:
 #0: ffff888022ca7c40 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:855 [inline]
 #0: ffff888022ca7c40 (mapping.invalidate_lock#2){++++}-{3:3}, at: page_cache_ra_unbounded+0xf7/0x7f0 mm/readahead.c:225

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc6-syzkaller-00017-gc9f016e72b5c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 4237 Comm: syz-executor317 Not tainted 6.11.0-rc6-syzkaller-00017-gc9f016e72b5c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x82/0x290 mm/kasan/generic.c:189
Code: 01 00 00 00 00 fc ff df 4f 8d 3c 31 4c 89 fd 4c 29 dd 48 83 fd 10 7f 29 48 85 ed 0f 84 3e 01 00 00 4c 89 cd 48 f7 d5 48 01 dd <41> 80 3b 00 0f 85 c9 01 00 00 49 ff c3 48 ff c5 75 ee e9 1e 01 00
RSP: 0000:ffffc90002defd90 EFLAGS: 00000286
RAX: 1ffff920005bdf01 RBX: 1ffff920005bdfcb RCX: ffffffff81df1a50
RDX: 0000000000000001 RSI: 0000000000000010 RDI: ffffc90002defe58
RBP: ffffffffffffffff R08: ffffc90002defe67 R09: 1ffff920005bdfcc
R10: dffffc0000000000 R11: fffff520005bdfcc R12: ffffc90002defe40
R13: 0000000000000255 R14: dffffc0000000001 R15: fffff520005bdfcd
FS:  0000555577e59480(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555577e5a8d8 CR3: 00000000322a6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __asan_memset+0x23/0x50 mm/kasan/shadow.c:84
 lock_vma_under_rcu+0xf0/0x6e0 mm/memory.c:5989
 do_user_addr_fault arch/x86/mm/fault.c:1329 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x17b/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f07b106b42b
Code: 81 0a 00 48 8d 34 19 48 39 d5 48 89 75 60 0f 95 c2 48 29 d8 48 83 c1 10 0f b6 d2 48 83 c8 01 48 c1 e2 02 48 09 da 48 83 ca 01 <48> 89 51 f8 48 89 46 08 eb 80 48 8d 0d c1 21 07 00 48 8d 15 c5 33
RSP: 002b:00007ffd34428b20 EFLAGS: 00010206
RAX: 0000000000020611 RBX: 0000000000000120 RCX: 0000555577e5a8e0
RDX: 0000000000000121 RSI: 0000555577e5a9f0 RDI: 0000000000000004
RBP: 00007f07b11135e0 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000021000 R11: 0000000000000010 R12: 0000000000000110
R13: 0000000000000012 R14: 00007f07b1113640 R15: 0000000000000120
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

