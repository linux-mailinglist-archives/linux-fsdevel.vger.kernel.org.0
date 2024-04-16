Return-Path: <linux-fsdevel+bounces-17006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597EF8A5F56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 02:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6AE1C20F1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 00:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46B9139E;
	Tue, 16 Apr 2024 00:37:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D536718D
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713227844; cv=none; b=ZvYMZLj37QsYXTgXircLz+J1HUquNcQKPVG2tAyAfgmorr6HJgHfDFS/4S2RbV96COQDo/a8SUBGthpnBEH73/BXJKrGONK9sPD4zF5xKslrC1ebrJgk1WiSK4XEEbnEB03pmWL95kN1xW1wQL2rQKswYohq5LVvCJ5C5DPQJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713227844; c=relaxed/simple;
	bh=JNkkdDIy3lkemITACCTcFkkkCArkVghs9IC3AmqEDMs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sl2jLrdsys0J/LFdbq99CZFRCGNuuDnyL97gv/W8aJ74g7t1HSG/VbwMCcS6f6sQ9n/Ag1KGvcAENjep6B/rAFiz6M6sR41CWvmQddBOsXbdQrBU6xTlUXtrOQbUrhrt9ZcQM9spS8MJbJGboAAZYaXlIYTFjc1cbRK4H1IAmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36aff59aba8so34594535ab.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 17:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713227842; x=1713832642;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vsXomMcnhq7SYroH/2EygvqzZQD3/BeyQ0lCJc+3FIw=;
        b=Q0lD8MwLq+eUuQUQcBBLFTV1MmH+GZQ2NU17r2p/C9VnKfy/LfUnM0/5CPKnQk05M+
         t560XbZFwbBKNQRkM0h4RRr/IKMbOsrJtKHSJbLiQEs0IGkqkU3a3U1IOKNlZrSarKRh
         Nq6oe35kfrFgr36SxNx1aHW6vgEiTojoQ0qvHon7Go+8bx5ipFtXRX9GMeuAcmZ5KgUC
         fEqx0oc1cdsKeuIQl931mccjML30so4E9Jkf2UxCo3X59CbSnunx4hOjUMeYAeBuBakt
         kUjZ4dGU6Q8NufNVrQpu/fjILJM3lqM2EMWTJXN3+LuPW0SxLMP0P+dqchdfKaEZSfjn
         +YNw==
X-Forwarded-Encrypted: i=1; AJvYcCXAvw6a09NwDjyeoEw7PIN1Ueq5FnMolbWtBdV0/Vhcse3/2V2DUthdHemL0MRGGVWFlOFN7NRk0fRFBCFzV+QkLLcqUhc1O8+VT+VYzA==
X-Gm-Message-State: AOJu0YxszIkNX/fi1reIx0oOILzQBo60A2mnO+f20QXOREilb7FVRSds
	q68o0w4xTIgEtu8pN1oSe2IUJDPx6Pl0JJwA2tKNSbEenEo7MJ7R6IBQr5BXvBL7AGSVS5Nl22/
	e54BVlBGAdafUHb4clEiSIoyk7Z2QDXZOBGIV7NADYZOUj1px3fuN6BU=
X-Google-Smtp-Source: AGHT+IG1C/E0nDcnt5ZRYeeKDgFmJM50ziEYZfZn+lPu4J7C62N5Lpqb6RIfKDKkQ7vYYgVmr8hSjFGatrrVFfJG6DGwrR2n2JHs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe2:b0:36a:1132:8bc5 with SMTP id
 dt2-20020a056e021fe200b0036a11328bc5mr943752ilb.3.1713227842075; Mon, 15 Apr
 2024 17:37:22 -0700 (PDT)
Date: Mon, 15 Apr 2024 17:37:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2500206162bf05e@google.com>
Subject: [syzbot] [kernfs?] BUG: using __this_cpu_add() in preemptible code in kernfs_fop_write_iter
From: syzbot <syzbot+ef8020e2f85fb6335ed1@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c96661180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a07d5da4eb21586
dashboard link: https://syzkaller.appspot.com/bug?extid=ef8020e2f85fb6335ed1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b42ab0fd4947/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8a6e7231930/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fbf3e4ce6f8/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef8020e2f85fb6335ed1@syzkaller.appspotmail.com

BUG: using __this_cpu_add() in preemptible [00000000] code: syz-executor.1/5775
caller is __pv_queued_spin_lock_slowpath+0x272/0xc80 kernel/locking/qspinlock.c:565
CPU: 1 PID: 5775 Comm: syz-executor.1 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:114
 check_preemption_disabled+0xd0/0xe0 lib/smp_processor_id.c:49
 __pv_queued_spin_lock_slowpath+0x272/0xc80 kernel/locking/qspinlock.c:565
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 lockdep_lock+0x1b8/0x200 kernel/locking/lockdep.c:144
 graph_lock kernel/locking/lockdep.c:170 [inline]
 lookup_chain_cache_add kernel/locking/lockdep.c:3804 [inline]
 validate_chain kernel/locking/lockdep.c:3837 [inline]
 __lock_acquire+0x15a8/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
 __might_fault mm/memory.c:6080 [inline]
 __might_fault+0x11b/0x190 mm/memory.c:6073
 _copy_from_iter+0x1c4/0x1110 lib/iov_iter.c:259
 copy_from_iter include/linux/uio.h:204 [inline]
 kernfs_fop_write_iter+0x1a3/0x500 fs/kernfs/file.c:315
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6de/0x1100 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f2e4ea7de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2e4f7ab0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2e4ebabf80 RCX: 00007f2e4ea7de69
RDX: 0000000000000012 RSI: 0000000020000380 RDI: 0000000000000004
RBP: 00007f2e4eaca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f2e4ebabf80 R15: 00007ffd0de416f8
 </TASK>
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(!irqs_disabled())
WARNING: CPU: 1 PID: 5775 at kernel/locking/lockdep.c:150 lockdep_unlock+0x1c1/0x290 kernel/locking/lockdep.c:150
Modules linked in:
CPU: 1 PID: 5775 Comm: syz-executor.1 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:lockdep_unlock+0x1c1/0x290 kernel/locking/lockdep.c:150
Code: d0 7c 08 84 d2 0f 85 cc 00 00 00 8b 35 8c d2 33 0e 85 f6 75 19 90 48 c7 c6 e0 c7 0c 8b 48 c7 c7 60 c7 0c 8b e8 10 4e e5 ff 90 <0f> 0b 90 90 90 e9 80 fe ff ff 90 0f 0b 90 e8 0c b6 0a 03 85 c0 74
RSP: 0018:ffffc9000329f940 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff9469aaa0 RCX: ffffc9000996a000
RDX: 0000000000040000 RSI: ffffffff8150f3f6 RDI: 0000000000000001
RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888020288000
R13: ffffffff9400a9b8 R14: ffff888020288b28 R15: 0000000000000001
FS:  00007f2e4f7ab6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2e4eada5b2 CR3: 0000000062612000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 graph_unlock kernel/locking/lockdep.c:186 [inline]
 validate_chain kernel/locking/lockdep.c:3873 [inline]
 __lock_acquire+0x1fb0/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
 __might_fault mm/memory.c:6080 [inline]
 __might_fault+0x11b/0x190 mm/memory.c:6073
 _copy_from_iter+0x1c4/0x1110 lib/iov_iter.c:259
 copy_from_iter include/linux/uio.h:204 [inline]
 kernfs_fop_write_iter+0x1a3/0x500 fs/kernfs/file.c:315
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6de/0x1100 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f2e4ea7de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2e4f7ab0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2e4ebabf80 RCX: 00007f2e4ea7de69
RDX: 0000000000000012 RSI: 0000000020000380 RDI: 0000000000000004
RBP: 00007f2e4eaca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f2e4ebabf80 R15: 00007ffd0de416f8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

