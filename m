Return-Path: <linux-fsdevel+bounces-53619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48040AF10FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 12:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368B07B745D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AC624DCF7;
	Wed,  2 Jul 2025 09:59:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485271F3FF4
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450369; cv=none; b=V9cAKymj5bdw+yt9AseBf/nCq0SRs0mjqoGI/OGkpPWYIbhm3lj3xd2jvVgp3N2TwBo8/uvGnW21n6JFgh5suuk60I+XN0K63i5WTU5Z8v8Ki6/HFaaw2knI7i8uh2TMIR577OF+6T2TA6Wtoar4w6e8Hw6Uew1UOXMtdCBUI4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450369; c=relaxed/simple;
	bh=v8wHHAg3wUEAUXBnxb/LPiRFe/A2Ca+XGxdCnLvpkBs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c+4GrZdqsFdHEzCL9u4bWSwBBUvfnOtNoQDgKtyFFSBk/G/sm50dx9DChZHw/CqTGOKgSqc87Yk2juBukKOz2U6CzNac04iOLRl2mZx2IuJ1TMWTaT7le3cjQ0KF72FJQdhjBaPtgbEsE4kxLPzqbVej6MYIxBPjAG+pJoeF40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86cfccca327so1338088439f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 02:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751450367; x=1752055167;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8RaBvFayfwXcYBfnTATfUpC02Gn1aI1y3WW84NlTtyk=;
        b=FbdtQKZZaOgsl56t1R7l/tMFSfd9Eo6kmT5n0I/LNI4KVQz/NnjVGiS+P43sSaCDGd
         gsEoY9AkkEWNC6aZwm5iWFBAOOFfw9QZbO+SHEB990q8xYdHN007QU7VJMBrVspB7tBW
         njWKMwJgpEfVsu+t63F7qaZfcpdn1ifJ4SPJxrRPszlXGcy3DG5s74f8xw6gc0JcLEDp
         w2Z6nNVS9C/3jP91HPy3lIP0yIkP/zwrwTmbo/VotkNbAzFWwl3xINTdQFLLXEoVE5fK
         ei3xj6DS+GWSzxN0j9WNU5gqP78wppLqoKr4rTYAbwlZNa68+TzYzrG1pTZor3GYs/8X
         prsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPKB2S5pC6bMJm9KkYfQK4rMKD+Yb1+MUJPV2zTiLC7kfwDavYRAz5RewCvL349oEFmbEoybqWNcuQ0UcJ@vger.kernel.org
X-Gm-Message-State: AOJu0YycrDrmbIRF3+/IQDBLRy87uEgNnEhv9tzn+1espIRNbNtY1LLt
	o7fuSWqnmnguX+s3yhscmuJEjn50c/QOswTyXueNYeqDpwkxzrCeiCsVvZt4jm1CQgflnvAwnm1
	ERAUqDpJkvmZVNOTfQtGWypkTybFxgDXfDB0debulgXHGkU9Rd3XegVRaBwA=
X-Google-Smtp-Source: AGHT+IGpE9WpTeFmhervoumHh4OLvdGoHuY8jUVhFr1PjJpe8t72eca2VJLnXVVhmi4qCUlsuVcqgPjtOfRJsGVDJYm6n/y7WfdO
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2b:b0:3df:3a4f:c884 with SMTP id
 e9e14a558f8ab-3e05496bd83mr29413895ab.8.1751450367399; Wed, 02 Jul 2025
 02:59:27 -0700 (PDT)
Date: Wed, 02 Jul 2025 02:59:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686502ff.a70a0220.3b7e22.22bb.GAE@google.com>
Subject: [syzbot] [fs?] BUG: sleeping function called from invalid context in procfs_procmap_ioctl
From: syzbot <syzbot+6246a83e7bd9f8a3e239@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andrii@kernel.org, david@redhat.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	surenb@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1343433ed389 Add linux-next specific files for 20250630
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1243e3d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1ce97baf6bd6397
dashboard link: https://syzkaller.appspot.com/bug?extid=6246a83e7bd9f8a3e239
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b1b88c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c3387c64e9ec/disk-1343433e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/abf15e85d8dd/vmlinux-1343433e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/081c344403bc/bzImage-1343433e.xz

The issue was bisected to:

commit 8b877c5aaaaf9b5170928d0e033ea9b0c538fc94
Author: Suren Baghdasaryan <surenb@google.com>
Date:   Tue Jun 24 19:33:59 2025 +0000

    mm/maps: execute PROCMAP_QUERY ioctl under per-vma locks

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16095770580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15095770580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11095770580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6246a83e7bd9f8a3e239@syzkaller.appspotmail.com
Fixes: 8b877c5aaaaf ("mm/maps: execute PROCMAP_QUERY ioctl under per-vma locks")

BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:321
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 6032, name: syz.0.16
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
2 locks held by syz.0.16/6032:
 #0: ffffffff8e13bee0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13bee0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e13bee0 (rcu_read_lock){....}-{1:3}, at: query_vma_setup+0x18/0x110 fs/proc/task_mmu.c:499
 #1: ffff888076dbe308 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x146/0xdc0 mm/mmap_lock.c:220
CPU: 1 UID: 0 PID: 6032 Comm: syz.0.16 Not tainted 6.16.0-rc4-next-20250630-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x495/0x610 kernel/sched/core.c:8687
 might_alloc include/linux/sched/mm.h:321 [inline]
 slab_pre_alloc_hook mm/slub.c:4131 [inline]
 slab_alloc_node mm/slub.c:4209 [inline]
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_noprof+0xbc/0x4f0 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 do_procmap_query fs/proc/task_mmu.c:690 [inline]
 procfs_procmap_ioctl+0x877/0xd10 fs/proc/task_mmu.c:748
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f107ed8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd594c468 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f107efb5fa0 RCX: 00007f107ed8e929
RDX: 0000200000000180 RSI: 00000000c0686611 RDI: 0000000000000003
RBP: 00007f107ee10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f107efb5fa0 R14: 00007f107efb5fa0 R15: 0000000000000003
 </TASK>


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

