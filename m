Return-Path: <linux-fsdevel+bounces-16857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD88A3C08
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 11:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440B71F21EFF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF7E376E2;
	Sat, 13 Apr 2024 09:52:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF442C6B3
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713001948; cv=none; b=GewMVWFwJrjZPCspuBJK5wO8Z0X24swPUankTcYnfFU9msEZ3jZsjboO9VGFYIpSRMBJOSBgzPgOUKwty65R1UizQj6//9W5SJh7Vce/Hf7y7h5NUGSQ4sqe9Qb/AMO4wk2p+QOjQ/fAjTwqGPd9zr4f+ODWIyn6eucaGDgjStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713001948; c=relaxed/simple;
	bh=7nc4wxB2nA4EX0zKmBVliAD7DhUNhf4H94lK8iv7iuA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pPBpML+ZMNCOeAFS3mGUVR/BNBYPYFL8IsyxNyOF+x9mhwmebH3Nr5vePZzFCqycXE/ropHFKK//lRBZVtPpIuzDQGOCdhXnS5hEL0RwMPK6xK0wRtixXp/t7Ai5MBE+LwMt//okaFhPDREwHctXwGOPyQG4Bvb7cc2iigwNOBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5dbc0e4b3so175594839f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 02:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713001946; x=1713606746;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Id0toMuvL7as7L5ZND3mqsNLDkmdYxu+k83p1dlJR14=;
        b=dbCKfSRONjl/k7+kvveHF8/rfBryn3rF/WYnKb26ddqim94SXQWwZ+WrNBPd2xVg0J
         muzd4GXc53nDhgns1oWn9x7++RII+lH0BhBSwjrkeP/ElJu1G8nalLFie1KheMPG+smT
         JbpE9e0WLo0nxWEHAA36A2btkOGRO11OoWltsTH0/Hm2ACd+aGyGq7Zgh3QKulS+gHDB
         ufyt0cQFfst9ojd2oFj21vgTPyZ1+ZS2/lDuyNBW5QMlHqFE7NccX+20joh1quEq0sCJ
         xRdLlLdM7uRCQNyx15BsZAHGqtkTm4k3/Q6yfovSTHEPDmoe1JYtUlYr7DnFOlVZ5mfK
         pjaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjDu9FG5tOhR2FibZA5clTVwBKKgI0vpWSaqpA3K0z1P9hS5wd/M5eshKVkvoTnBH8Ac1ibpOKl9b/3mgIIfK2Pxaea062uRoweF25Xw==
X-Gm-Message-State: AOJu0YwEhHIGsOPiAjXfCNEEJNp+Vk6lv3F8PNGPlnd+J1M4Ab5TNa/q
	uVEL/sHrxVZxT3EqOU9nUjHoJp9sUq4Ugo7FJvPxKjrGynsRYSgKDTos2wGCoWPECF04zSMm+Oh
	6jeQotijPrebwqX5Jx7/c8wEoaJb32BrCsgZkpyLd+qI13CgwfBhGrDM=
X-Google-Smtp-Source: AGHT+IGRsecqFpRXtTegGDI/g/U1QsDw+OTdMMQk1u8s00UWC5pHknrYQGLkApe6NpEisVI3+1oLVDiIvxoF+4l4ti2shO7ft0vT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:164a:b0:7d6:5f6:831b with SMTP id
 y10-20020a056602164a00b007d605f6831bmr116095iow.1.1713001946490; Sat, 13 Apr
 2024 02:52:26 -0700 (PDT)
Date: Sat, 13 Apr 2024 02:52:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085368e0615f7582f@google.com>
Subject: [syzbot] [jfs?] INFO: trying to register non-static key in txEnd (2)
From: syzbot <syzbot+5b27962d84feb4acb5c1@syzkaller.appspotmail.com>
To: arnd@arndb.de, dhowells@redhat.com, jfs-discussion@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11e238f3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=5b27962d84feb4acb5c1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cb7b55180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1717b623180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8b1302c5b3ec/mount_0.gz

The issue was bisected to:

commit 9c8ad7a2ff0bfe58f019ec0abc1fb965114dde7d
Author: David Howells <dhowells@redhat.com>
Date:   Thu May 16 11:52:27 2019 +0000

    uapi, x86: Fix the syscall numbering of the mount API syscalls [ver #2]

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1498c213180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1698c213180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1298c213180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b27962d84feb4acb5c1@syzkaller.appspotmail.com
Fixes: 9c8ad7a2ff0b ("uapi, x86: Fix the syscall numbering of the mount API syscalls [ver #2]")

ERROR: (device loop0): txCommit: 
 ... Log Wrap ... Log Wrap ... Log Wrap ...
 ... Log Wrap ... Log Wrap ... Log Wrap ...
ERROR: (device loop0): txBegin: read-only filesystem
jfs_dirty_inode called on read-only volume
Is remount racy?
jfs_dirty_inode called on read-only volume
Is remount racy?
jfs_dirty_inode called on read-only volume
Is remount racy?
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 5064 Comm: syz-executor231 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 assign_lock_key+0x238/0x270 kernel/locking/lockdep.c:976
 register_lock_class+0x1cf/0x980 kernel/locking/lockdep.c:1289
 __lock_acquire+0xda/0x1fd0 kernel/locking/lockdep.c:5014
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 __wake_up_common_lock+0x25/0x1e0 kernel/sched/wait.c:105
 txEnd+0x8c/0x560 fs/jfs/jfs_txnmgr.c:504
 jfs_create+0x371/0xb90 fs/jfs/namei.c:159
 lookup_open fs/namei.c:3497 [inline]
 open_last_lookups fs/namei.c:3566 [inline]
 path_openat+0x1425/0x3240 fs/namei.c:3796
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f55e8f6b739
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcc21e5d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f55e8f6b739
RDX: 000000000000275a RSI: 0000000020000080 RDI: 00000000ffffff9c
RBP: 00007f55e8fe4610 R08: 00007ffcc21e5f68 R09: 00007ffcc21e5f68
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffcc21e5f58 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 5064 Comm: syz-executor231 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__wake_up_common_lock+0xcf/0x1e0 kernel/sched/wait.c:106
Code: fb 0f 84 d1 00 00 00 8b 6c 24 04 eb 13 48 ba 00 00 00 00 00 fc ff df 4c 39 fb 0f 84 b8 00 00 00 49 89 de 48 89 d8 48 c1 e8 03 <80> 3c 10 00 74 12 4c 89 f7 e8 83 23 86 00 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc9000398f610 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffffc9000398f4e0
RBP: 0000000000000000 R08: 0000000000000003 R09: fffff52000731e9c
R10: dffffc0000000000 R11: fffff52000731e9c R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffc90002651070
FS:  0000555565493380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557a16608c70 CR3: 00000000683b8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 txEnd+0x8c/0x560 fs/jfs/jfs_txnmgr.c:504
 jfs_create+0x371/0xb90 fs/jfs/namei.c:159
 lookup_open fs/namei.c:3497 [inline]
 open_last_lookups fs/namei.c:3566 [inline]
 path_openat+0x1425/0x3240 fs/namei.c:3796
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f55e8f6b739
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcc21e5d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f55e8f6b739
RDX: 000000000000275a RSI: 0000000020000080 RDI: 00000000ffffff9c
RBP: 00007f55e8fe4610 R08: 00007ffcc21e5f68 R09: 00007ffcc21e5f68
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffcc21e5f58 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__wake_up_common_lock+0xcf/0x1e0 kernel/sched/wait.c:106
Code: fb 0f 84 d1 00 00 00 8b 6c 24 04 eb 13 48 ba 00 00 00 00 00 fc ff df 4c 39 fb 0f 84 b8 00 00 00 49 89 de 48 89 d8 48 c1 e8 03 <80> 3c 10 00 74 12 4c 89 f7 e8 83 23 86 00 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc9000398f610 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffffc9000398f4e0
RBP: 0000000000000000 R08: 0000000000000003 R09: fffff52000731e9c
R10: dffffc0000000000 R11: fffff52000731e9c R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffc90002651070
FS:  0000555565493380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557a16608c70 CR3: 00000000683b8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	fb                   	sti
   1:	0f 84 d1 00 00 00    	je     0xd8
   7:	8b 6c 24 04          	mov    0x4(%rsp),%ebp
   b:	eb 13                	jmp    0x20
   d:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  14:	fc ff df
  17:	4c 39 fb             	cmp    %r15,%rbx
  1a:	0f 84 b8 00 00 00    	je     0xd8
  20:	49 89 de             	mov    %rbx,%r14
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1) <-- trapping instruction
  2e:	74 12                	je     0x42
  30:	4c 89 f7             	mov    %r14,%rdi
  33:	e8 83 23 86 00       	call   0x8623bb
  38:	48                   	rex.W
  39:	ba 00 00 00 00       	mov    $0x0,%edx
  3e:	00 fc                	add    %bh,%ah


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

