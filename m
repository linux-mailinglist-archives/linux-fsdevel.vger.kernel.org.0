Return-Path: <linux-fsdevel+bounces-73905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACB3D23B50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 10:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A0AB302A066
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42C835F8AD;
	Thu, 15 Jan 2026 09:50:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40FC33B94A
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470627; cv=none; b=rqE/Ac8kAjxIONySOLHs+Qke4BginEPWlCeSZJuhkcV4pBsPQle2N0diuhiLSvRqG5jiJHajmCHOulFjP9QSiTCAN9mbitqs1LX8EVZLMaSFyye3L2obLzy0/bWNUTgiohZZeS4iMIUGH3Xh60RRNh7++s2c3Bw/0DsvDdSXyvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470627; c=relaxed/simple;
	bh=i9V7nCRsteQ2c6Ud0YfQl3GJGu2qflAQKbrUla3n4Y4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jl2kvBzxXRvxpS5rOTRSHHmZq+8skpdxbER8nIwdblOnAH28EZRXlff1RT8+LUhDlttvRb6SikFQeQLtBqW9tm/IRZO+hqm783ZpkynFVRqnXMA4KBKOZAcQ7TE0meX1NHj2i7FSLKa2crY0mXz3gNXowG4+0yBsZwGu7XwwK90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-66102e59148so2629073eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 01:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768470624; x=1769075424;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woi7PjhhmOxHXAjpapHFawYtVQAlcpnZ3t703HdDjRc=;
        b=Q5bEmsUfJXB3+LpQsf+9stXGOswFFcGlKqSR1746MkAnLNybGVSD76/HCKgWTPM0Sb
         sKiqA1ZLtc36JnAf4jqHLQlJMxNms1ziOlIu419mOkGW3sfnl0Ghh441mQh4H0oHwUs2
         Rp1FqSz32Jpx2fx+lES+acOp9O29SEFIqP3IJXwK2lTPJVX6ylso2+XCVBY0i0O6h1+y
         eDYmghpYzW6BoHMO6CMKGQhnYNeen8uSwEev0u+ECWUi0CcaebJ5avDWWkY2hnPt87J4
         A8t11/S6TR/PDl8LJHHgny/t/pC2gs2s819oemruw5G2hDAnYfAalzr3rWxL8fYlFnLR
         QbNg==
X-Forwarded-Encrypted: i=1; AJvYcCWAtZfiu2sdhhWKmJ2iHlohVaF+h8RDHDvamoELh1+YZbNw+0tTuONZSYcBrB1cvRWwHhz/0yj0W5UIPP4U@vger.kernel.org
X-Gm-Message-State: AOJu0YzgUU3DBnVKHqsjpxjnOqp37jCMNS96W9V0ltYO7TdK876GYpz4
	7pgQpN698T+aVxxjDzGDbx1RV0etVYLEKyak2j0dvToJbsI0uOPGEB8VNt4Cui3VffJZthizERC
	1P/l3qg3V2CmbfMKmfudnQ8yw/j65vvDmSt33H66XvkpPGCOj6PiJ9K3QTYU=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1694:b0:65f:64fa:172e with SMTP id
 006d021491bc7-661006e73demr3578307eaf.57.1768470624723; Thu, 15 Jan 2026
 01:50:24 -0800 (PST)
Date: Thu, 15 Jan 2026 01:50:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6968b860.050a0220.58bed.0018.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in put_mnt_ns
From: syzbot <syzbot+55fd613012e606d75d45@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0f853ca2a798 Add linux-next specific files for 20260113
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1386f99a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=789b351b8a4cafe1
dashboard link: https://syzkaller.appspot.com/bug?extid=55fd613012e606d75d45
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1482859a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13402052580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9c7778b6d6be/disk-0f853ca2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ea278b0d6aff/vmlinux-0f853ca2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/60b94236c918/bzImage-0f853ca2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+55fd613012e606d75d45@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fca229e5fa0 R14: 00007fca229e5fa0 R15: 0000000000000003
 </TASK>
============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.0.23/6026 is trying to acquire lock:
ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: namespace_lock fs/namespace.c:1730 [inline]
ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: class_namespace_excl_constructor fs/namespace.c:101 [inline]
ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: put_mnt_ns+0x170/0x2f0 fs/namespace.c:6241

but task is already holding lock:
ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: namespace_lock fs/namespace.c:1730 [inline]
ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: lock_mount_exact+0x89/0x630 fs/namespace.c:3852

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(namespace_sem);
  lock(namespace_sem);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.0.23/6026:
 #0: ffff888149040148 (&sb->s_type->i_mutex_key){++++}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #0: ffff888149040148 (&sb->s_type->i_mutex_key){++++}-{4:4}, at: lock_mount_exact+0x7d/0x630 fs/namespace.c:3851
 #1: ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: namespace_lock fs/namespace.c:1730 [inline]
 #1: ffffffff8e49efd0 (namespace_sem){++++}-{4:4}, at: lock_mount_exact+0x89/0x630 fs/namespace.c:3852

stack backtrace:
CPU: 1 UID: 0 PID: 6026 Comm: syz.0.23 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x2540/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x107/0x340 kernel/locking/lockdep.c:5868
 down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
 namespace_lock fs/namespace.c:1730 [inline]
 class_namespace_excl_constructor fs/namespace.c:101 [inline]
 put_mnt_ns+0x170/0x2f0 fs/namespace.c:6241
 prepare_anon_dentry fs/libfs.c:2167 [inline]
 path_from_stashed+0x40a/0x5c0 fs/libfs.c:2252
 open_namespace_file+0x8f/0x130 fs/nsfs.c:108
 open_new_namespace fs/namespace.c:3174 [inline]
 vfs_open_tree+0xa9d/0xf50 fs/namespace.c:3220
 __do_sys_open_tree fs/namespace.c:3230 [inline]
 __se_sys_open_tree fs/namespace.c:3228 [inline]
 __x64_sys_open_tree+0x96/0x110 fs/namespace.c:3228
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fca2278f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc7a04e728 EFLAGS: 00000246 ORIG_RAX: 00000000000001ac
RAX: ffffffffffffffda RBX: 00007fca229e5fa0 RCX: 00007fca2278f749
RDX: 0000000000001802 RSI: 0000200000000000 RDI: ffffffffffffffff
RBP: 00007ffc7a04e780 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fca229e5fa0 R14: 00007fca229e5fa0 R15: 0000000000000003
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

