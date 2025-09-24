Return-Path: <linux-fsdevel+bounces-62546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA4AB98C88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 10:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADEE19C6C49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 08:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2333B280339;
	Wed, 24 Sep 2025 08:20:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD3C25A34F
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702037; cv=none; b=XEVzegr2iyuAzw3XLGFv+2DS95tulYBC15hPQT2K8r2eVhNT2JfploHocsaFNxJ+gqIG3umciUdr2XwAA9KWHzLVvNEQdFqJh6HxrnC7xvU2+5/zChUy6kxOWuxN2Dk0+x0PfDF9bYR/v2vtzUfdhN/+MqjxtGIcV9DGN1eQXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702037; c=relaxed/simple;
	bh=flOJLFL3xJk2PXNLmjIG+HPkaN/Q2kPZzbCwWQCrYWE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NiHTdWbcA85WDY9XEXmC+JHjuV+++hgke1WAfXbV+bfdyimzHU6ZHFZVjjNpxomEh6RIB02bRVkf/IGB0q5e6dnHSRVIAjzgaSyyeTzxNs1tdyMwm2+arTtZSN2bCnA1bFakUud3Rn7NDnmoM5hXxJ1nWI6M50YQsWANdtls1F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-893620de179so1436200039f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 01:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758702035; x=1759306835;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MNXjmEKdISx8T7B/Gd2AgAd/JGBrN2p3ir6T9+nHFp4=;
        b=wX2+k0UyPLMWn2EkdHzevkCtvUTmQLxPF9nhN9cDTs6bnqaYKgcF1VL/yRh8/w87G4
         fAXw0KGyUoTE8iwFJnHnUBqIFiA4GjfZkfQelsIRBcpZ0vLfZ8S5SBUKnFKLMQHB4e7r
         2iJXQlviQuc0Kpp90L6v0ol0GXr+O+pnclKdPvF8ku6zO3SnbIgtBt4yVQO1gP+cETcp
         xTHG/b1hz1fL+mUMmd9mm81c20XR3e6PcuX70bTYNh3zVLeP14NKTwoMVZ2xLdUltRid
         cSnzamLovqayLy2hmrjULihLbWI9nBTSaoJyDlrLuo9GCMuR7gV8AcX4kUlz1oDlSJsg
         E8wg==
X-Forwarded-Encrypted: i=1; AJvYcCXYzp9BRD/buFvWPFy4CJlKSOLbeGBPuR9H+nUTa83IuvzsNMxnf+LFzB0xJ+blzN8TPoj+QnoFn7DfA/Ot@vger.kernel.org
X-Gm-Message-State: AOJu0YzcpeTu7Tq3IHDAqJLEeKi5VARtVjVujvC7kKnKlwwYqgBrPRi3
	oOlvzy1psjxaq5z/gyJnuc/SiGM6oiiVjzFwxnp1zci61lNlC5vZuAA75FQJTOH9lGM1zOx4w2w
	vSopzIMVUj+HdTtjSTjOXUOMlCV4ho+dbF1fpDBvJ0Af0fsEZvVppyniR7os=
X-Google-Smtp-Source: AGHT+IHKEKhWxQ82TOyIHKlC68GGcLX1M2ncukPjXMVFkUbdIEB/2CONfnDZ1lsKwufG9TszvUa/UqU9By9A/mQVmMwvkXOXlKeK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2169:b0:424:7f5a:9423 with SMTP id
 e9e14a558f8ab-42581e6f594mr77178695ab.19.1758702035210; Wed, 24 Sep 2025
 01:20:35 -0700 (PDT)
Date: Wed, 24 Sep 2025 01:20:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3a9d3.a70a0220.4f78.0017.GAE@google.com>
Subject: [syzbot] [fs?] WARNING: bad unlock balance in namespace_unlock
From: syzbot <syzbot+0d671007a95cd2835e05@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ce7f1a983b07 Add linux-next specific files for 20250923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=151b8d34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91ae0b9529ab8226
dashboard link: https://syzkaller.appspot.com/bug?extid=0d671007a95cd2835e05
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131b8d34580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a194e2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f1b65edb63f/disk-ce7f1a98.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b132cb8d99cd/vmlinux-ce7f1a98.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80f316094043/bzImage-ce7f1a98.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d671007a95cd2835e05@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
syzkaller #0 Not tainted
-------------------------------------
syz.3.25/6203 is trying to release lock (namespace_sem) at:
[<ffffffff82401096>] namespace_unlock+0x486/0x760 fs/namespace.c:1705
but there are no more locks to release!

other info that might help us debug this:
no locks held by syz.3.25/6203.

stack backtrace:
CPU: 0 UID: 0 PID: 6203 Comm: syz.3.25 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_unlock_imbalance_bug+0xdc/0xf0 kernel/locking/lockdep.c:5298
 __lock_release kernel/locking/lockdep.c:5527 [inline]
 lock_release+0x212/0x3e0 kernel/locking/lockdep.c:5889
 up_write+0x2d/0x420 kernel/locking/rwsem.c:1642
 namespace_unlock+0x486/0x760 fs/namespace.c:1705
 class_namespace_excl_destructor fs/namespace.c:96 [inline]
 copy_mnt_ns+0x6e5/0x880 fs/namespace.c:4176
 create_new_namespaces+0xd1/0x720 kernel/nsproxy.c:78
 unshare_nsproxy_namespaces+0x11c/0x170 kernel/nsproxy.c:218
 ksys_unshare+0x4c8/0x8c0 kernel/fork.c:3198
 __do_sys_unshare kernel/fork.c:3269 [inline]
 __se_sys_unshare kernel/fork.c:3267 [inline]
 __x64_sys_unshare+0x38/0x50 kernel/fork.c:3267
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7cd618eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7cd6feb038 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f7cd63e6180 RCX: 00007f7cd618eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040020000
RBP: 00007f7cd6211f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7cd63e6218 R14: 00007f7cd63e6180 R15: 00007ffc3db53b78
 </TASK>
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x3, magic = 0xffffffff8e48df00, owner = 0xffff88803389dac0, curr 0xffff88803408dac0, list not empty
WARNING: kernel/locking/rwsem.c:1381 at __up_write kernel/locking/rwsem.c:1380 [inline], CPU#0: syz.3.25/6203
WARNING: kernel/locking/rwsem.c:1381 at up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643, CPU#0: syz.3.25/6203
Modules linked in:
CPU: 0 UID: 0 PID: 6203 Comm: syz.3.25 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__up_write kernel/locking/rwsem.c:1380 [inline]
RIP: 0010:up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Code: d0 48 c7 c7 80 ff aa 8b 48 c7 c6 a0 01 ab 8b 48 8b 14 24 4c 89 f1 4d 89 e0 4c 8b 4c 24 08 41 52 e8 83 37 e6 ff 48 83 c4 08 90 <0f> 0b 90 90 e9 6d fd ff ff 48 c7 c1 74 37 c3 8f 80 e1 07 80 c1 03
RSP: 0018:ffffc90003d2faf0 EFLAGS: 00010296
RAX: 4aab14382228fb00 RBX: ffffffff8e48df00 RCX: ffff88803408dac0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1c3a654 R12: ffff88803389dac0
R13: ffffffff8e48df58 R14: ffffffff8e48df00 R15: 1ffffffff1c91be1
FS:  00007f7cd6feb6c0(0000) GS:ffff888125a0a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33163fff CR3: 0000000027b4e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 namespace_unlock+0x486/0x760 fs/namespace.c:1705
 class_namespace_excl_destructor fs/namespace.c:96 [inline]
 copy_mnt_ns+0x6e5/0x880 fs/namespace.c:4176
 create_new_namespaces+0xd1/0x720 kernel/nsproxy.c:78
 unshare_nsproxy_namespaces+0x11c/0x170 kernel/nsproxy.c:218
 ksys_unshare+0x4c8/0x8c0 kernel/fork.c:3198
 __do_sys_unshare kernel/fork.c:3269 [inline]
 __se_sys_unshare kernel/fork.c:3267 [inline]
 __x64_sys_unshare+0x38/0x50 kernel/fork.c:3267
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7cd618eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7cd6feb038 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f7cd63e6180 RCX: 00007f7cd618eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040020000
RBP: 00007f7cd6211f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7cd63e6218 R14: 00007f7cd63e6180 R15: 00007ffc3db53b78
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

