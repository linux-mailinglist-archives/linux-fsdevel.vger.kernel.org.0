Return-Path: <linux-fsdevel+bounces-54891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9539B0492E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 23:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2DE1AA06F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 21:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A19267B7F;
	Mon, 14 Jul 2025 21:11:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABD583CD1
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 21:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527500; cv=none; b=aRoFOcsALjBQCJErCh+VWHCx6cH3iiamJ0R+pJ0wFK0a/M2z6h6AM3kejVkvc2tq/luQ+9SPxGVcTvAqshGctLsExdZazUyp6CJJhLZP2EMIMXu0xJgAfqDqRSYtZwTshrPdgU68xHtHuy+MbHYGjl7p3QlIOg3eTin953C+4Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527500; c=relaxed/simple;
	bh=+ctVWatCu7lgPfwHkdPKCaqXaZhAmGu3JQJ8Ne63Ljw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y2v2qFsNsQJI/Ltyw/XtfvhbfAFY7NXO5SUghJGTVlxd3y86JH0HFqQEldxniRmY1NO4TwY5vJDhJeF+nfZuEeXNVzdyFd/Oz4HNRJUUpOZ5SKtOTxgvUiz0MN/WDiqEo99IWvTlD2d0Qj85/zQ5IizKeQJd7sxgpbfNuK7XwPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-87632a0275dso420181639f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 14:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752527496; x=1753132296;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5yOpjMiDG72er6VPMXxsfpav3LwFE3KOyDhO2auBsg=;
        b=XyqKy78j8/3AiyaMMAI4n8LcelCYZ95XZhAPaaRK0l+eJATY64TJz8xShO9+1lRan+
         7iRqCBcz0nwdFuSJiJyXClNLoTQ+ZafqONtRLBK2+UUgQFqmuYreftOXH/O7yeYPoFOP
         IYyl0Lst3WdOie6NGEfuh2+oHiexQn2gAfvtEwWyi/Ib8yVB2ilI7KR40r7JcuQTig4h
         DJxrrp35HHjhwcUu7oRkrorw8YuZyeqdwd0PCJVNfCEZq893hCfjeNjrSYhKUJ3q9y2F
         a5PrPwiScvPvnl2dBU65VI5neGjY7Gp1LDiGHiJKEZY82nBJce5b8VygbIFygroBkxlC
         Kohw==
X-Gm-Message-State: AOJu0YwSnS3WMpXXp5QE/ZBWEZGVgm271yLIz/Ysv7HwoV9UxoaWb4Al
	xF+cp8V1ijSpgGGH2VJAJau1/iv4sFfFN9whSGeSr0xz73Kyd17I/gElmLpUeLYQZhXUNSNa+v0
	Yz8Q7zbdGLSI72tphMBvJqjaZJX3bqFgKE6E5KQ7ICWS2Xe2+ZFBloB9lBeGqwA==
X-Google-Smtp-Source: AGHT+IEbm+gvwuXrO5B9bMoUZ7tpUzQKFMn94FvpdcvDyzwLrp+i/VTJ1q4Oc8Jrnytjb4I6P5UWpEjWqhBMGBfk7t2X+5IMPr9t
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15c7:b0:876:a8dc:96cc with SMTP id
 ca18e2360f4ac-87977f8234emr1765274739f.6.1752527496489; Mon, 14 Jul 2025
 14:11:36 -0700 (PDT)
Date: Mon, 14 Jul 2025 14:11:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68757288.a70a0220.5f69f.0003.GAE@google.com>
Subject: [syzbot] [fs?] WARNING: bad unlock balance in query_matching_vma
From: syzbot <syzbot+d4316c39e84f412115c9@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a62b7a37e6fc Add linux-next specific files for 20250711
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1422dd82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d42120e19faaef
dashboard link: https://syzkaller.appspot.com/bug?extid=d4316c39e84f412115c9
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1222dd82580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1205d0f0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/691b5f8ab5b1/disk-a62b7a37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/47d1a209784d/vmlinux-a62b7a37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eb70d73c9e55/bzImage-a62b7a37.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4316c39e84f412115c9@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
6.16.0-rc5-next-20250711-syzkaller #0 Not tainted
-------------------------------------
syz.0.32/6076 is trying to release lock (vm_lock) at:
[<ffffffff825aa9e7>] get_next_vma fs/proc/task_mmu.c:181 [inline]
[<ffffffff825aa9e7>] query_vma_find_by_addr fs/proc/task_mmu.c:512 [inline]
[<ffffffff825aa9e7>] query_matching_vma+0x2f7/0x5c0 fs/proc/task_mmu.c:544
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz.0.32/6076:
 #0: ffffffff8e53c5a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e53c5a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e53c5a0 (rcu_read_lock){....}-{1:3}, at: query_vma_find_by_addr fs/proc/task_mmu.c:510 [inline]
 #0: ffffffff8e53c5a0 (rcu_read_lock){....}-{1:3}, at: query_matching_vma+0x141/0x5c0 fs/proc/task_mmu.c:544

stack backtrace:
CPU: 1 UID: 0 PID: 6076 Comm: syz.0.32 Not tainted 6.16.0-rc5-next-20250711-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_unlock_imbalance_bug+0xdc/0xf0 kernel/locking/lockdep.c:5301
 __lock_release kernel/locking/lockdep.c:5540 [inline]
 lock_release+0x269/0x3e0 kernel/locking/lockdep.c:5892
 vma_refcount_put include/linux/mmap_lock.h:141 [inline]
 vma_end_read include/linux/mmap_lock.h:237 [inline]
 unlock_vma+0x70/0x180 fs/proc/task_mmu.c:135
 get_next_vma fs/proc/task_mmu.c:181 [inline]
 query_vma_find_by_addr fs/proc/task_mmu.c:512 [inline]
 query_matching_vma+0x2f7/0x5c0 fs/proc/task_mmu.c:544
 do_procmap_query fs/proc/task_mmu.c:629 [inline]
 procfs_procmap_ioctl+0x3f9/0xd50 fs/proc/task_mmu.c:747
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f667ed8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f667fb27038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f667efb6080 RCX: 00007f667ed8e929
RDX: 0000200000000180 RSI: 00000000c0686611 RDI: 0000000000000003
RBP: 00007f667ee10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f667efb6080 R15: 00007fff4a18d328
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

