Return-Path: <linux-fsdevel+bounces-70936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBA2CAA364
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 10:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AEBC301899C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0F62E093E;
	Sat,  6 Dec 2025 09:25:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E3D8003D
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Dec 2025 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765013112; cv=none; b=Jyo0npqmEhTa85DfSHXLMOixkLr8XJnJYE6IrvpPhQsuEE0oVa2GB6o6WQP8zcfraUaK9KO99ta+sFc7YlpYOawkJfo4EKsizbmajA5KofGHtqfsAfY9HMXEpwlnRJKjykG1z1wPTmlr0B3ESxPrEEMIAZWeqSbu9fqIL+vYe2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765013112; c=relaxed/simple;
	bh=QcvZDLCVyjRg8gsp2wZXanCuNWA2FSUfPlmxKhq7ocw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=GG6tbMa4RqtQnTM7Lh3Lh6oEASLmwAnwEJ+n24+yc76WfDApXd4ipVQqV2RwoL5KveVOw8WZr3vUxsRWiJwilJaypiNKj9AVQohwmY68xdQZWEcafqPu5zj4YfKBqKo7IB3PWL7Zz/pDSLqEWgRr8QRQaMWJ+0rv/mql2nQnork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7c7611165b3so3096084a34.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Dec 2025 01:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765013110; x=1765617910;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8a7fEXKJzITPGw0DCROhuDxNLpDH+76RLVx6ggVrXfg=;
        b=myKIl8VHOE8Hx/i/c0pGqlNkRQ5EsWfHcLZiHBXx6fnwoqnWtkf46SlQeRyjL9WQie
         h5o+YIqkpey5Kj64EvEjEUu1gWAXA2IeirN4pc+P88Pjgq0KWHrLcKqpE61779yxHzap
         5wwfQox11ehtVKWDB1fta4R2ktUYf2PMy7cQsMtunSQ66Ienr/Nv65A2Pmh3Y7lboS/5
         VFDPUZVwbeeozr//X38b281GFiZZxftwtE9uJEqlM/WTE/qoFg7A1nggBNStOu+q/R4v
         QTlrf1dhYVdcEWvC8FPQyskRM+EvTDHrRu9+r6Vnk7JeMdXy9LO/+KgtbrYhGbZ9obm1
         A7YA==
X-Forwarded-Encrypted: i=1; AJvYcCXgQoK3iLMzNfazgp+CvopEqNlklCD2YClwyKg4kI0M/+x3nRtNdD5+Pfa/ZkM7EX3sspnVtdxFOW1UWcu8@vger.kernel.org
X-Gm-Message-State: AOJu0YxisVyUGE6aXH4aWmXbYi2OuJt02p/dMkp7XwykOwLY/1uVVCYq
	h5Q2h39rF4cTwx7GdtNiIxViWBZXsJt8bGb6eLbUQGuBwa79eguyyQKtroiD83D48L5K1/zAreU
	Z9YeJWEnTdMMPha2ZQo4GQagwK4idK1ZBe3RwMmXOZCXS9lnh27d3ir+f83A=
X-Google-Smtp-Source: AGHT+IHpowSO5PzCr2+nN0iLOOI0GcO4TmTHayyplg/bShMKx+/qxQhHPrd70GuhB/lPjW1wSZ6mwymHnKoY2Msr4YQmvYHN27S3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:178a:b0:659:9a49:90ca with SMTP id
 006d021491bc7-6599a988a67mr849698eaf.73.1765013109749; Sat, 06 Dec 2025
 01:25:09 -0800 (PST)
Date: Sat, 06 Dec 2025 01:25:09 -0800
In-Reply-To: <20251206000902.71178-1-swarajgaikwad1925@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6933f675.a70a0220.38f243.001f.GAE@google.com>
Subject: [syzbot ci] Re: hfsplus: fix memory leak on mount failure
From: syzbot ci <syzbot+ciba1be8bde19c605d@syzkaller.appspotmail.com>
To: david.hunter.linux@gmail.com, frank.li@vivo.com, 
	glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, slava@dubeyko.com, 
	swarajgaikwad1925@gmail.com, syzbot@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] hfsplus: fix memory leak on mount failure
https://lore.kernel.org/all/20251206000902.71178-1-swarajgaikwad1925@gmail.com
* [PATCH v1] hfsplus: fix memory leak on mount failure

and found the following issues:
* SYZFAIL: failed to recv rpc
* WARNING: ODEBUG bug in hfsplus_kill_sb
* general protection fault in __timer_delete
* general protection fault in hfsplus_sync_fs

Full report is available here:
https://ci.syzbot.org/series/ea775ab1-67a5-4497-b4d6-8c7b2b7d90aa

***

SYZFAIL: failed to recv rpc

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      2061f18ad76ecaddf8ed17df81b8611ea88dbddd
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/591f3943-d010-4b2d-a026-67cc75802376/config
C repro:   https://ci.syzbot.org/findings/53a2b5e3-41ae-4650-9300-ec3fdd87f47a/c_repro
syz repro: https://ci.syzbot.org/findings/53a2b5e3-41ae-4650-9300-ec3fdd87f47a/syz_repro

SYZFAIL: failed to recv rpc


***

WARNING: ODEBUG bug in hfsplus_kill_sb

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      2061f18ad76ecaddf8ed17df81b8611ea88dbddd
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/591f3943-d010-4b2d-a026-67cc75802376/config
C repro:   https://ci.syzbot.org/findings/3c918e05-49e7-4855-bee1-5aafc9a5b5a4/c_repro
syz repro: https://ci.syzbot.org/findings/3c918e05-49e7-4855-bee1-5aafc9a5b5a4/syz_repro

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff88810a17ea38 object type: timer_list hint: delayed_sync_fs+0x0/0xf0 fs/hfsplus/super.c:-1
WARNING: lib/debugobjects.c:615 at 0x0, CPU#1: syz-executor/5946
Modules linked in:
CPU: 1 UID: 0 PID: 5946 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:debug_print_object lib/debugobjects.c:612 [inline]
RIP: 0010:__debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
RIP: 0010:debug_check_no_obj_freed+0x44a/0x550 lib/debugobjects.c:1129
Code: 89 44 24 20 e8 47 4a 92 fd 48 8b 44 24 20 4c 8b 4d 00 4c 89 ef 48 c7 c6 20 02 c0 8b 48 c7 c2 40 07 c0 8b 8b 0c 24 4d 89 f8 50 <67> 48 0f b9 3a 48 83 c4 08 4c 8b 6c 24 18 48 b9 00 00 00 00 00 fc
RSP: 0018:ffffc900032b7c18 EFLAGS: 00010246
RAX: ffffffff829ca540 RBX: ffffffff99a849a0 RCX: 0000000000000000
RDX: ffffffff8bc00740 RSI: ffffffff8bc00220 RDI: ffffffff8f8b7a70
RBP: ffffffff8b6d2540 R08: ffff88810a17ea38 R09: ffffffff8b6d36a0
R10: dffffc0000000000 R11: ffffffff81ae6210 R12: ffff88810a17ec00
R13: ffffffff8f8b7a70 R14: ffff88810a17e000 R15: ffff88810a17ea38
FS:  0000555587657500(0000) GS:ffff8882a9e8e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b55b316738 CR3: 0000000175d56000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 slab_free_hook mm/slub.c:2471 [inline]
 slab_free mm/slub.c:6663 [inline]
 kfree+0x13b/0x660 mm/slub.c:6871
 hfsplus_kill_sb+0x72/0xb0 fs/hfsplus/super.c:717
 deactivate_locked_super+0xbc/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1318
 task_work_run+0x1d4/0x260 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
 exit_to_user_mode_loop+0xff/0x4f0 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x2e3/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f540cf90af7
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffc80b82ab8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f540cfee72f RCX: 00007f540cf90af7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffc80b82b70
RBP: 00007ffc80b82b70 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffc80b83c00
R13: 00007f540cfee72f R14: 000000000001120e R15: 00007ffc80b83c40
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 44 24 20          	mov    %eax,0x20(%rsp)
   4:	e8 47 4a 92 fd       	call   0xfd924a50
   9:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
   e:	4c 8b 4d 00          	mov    0x0(%rbp),%r9
  12:	4c 89 ef             	mov    %r13,%rdi
  15:	48 c7 c6 20 02 c0 8b 	mov    $0xffffffff8bc00220,%rsi
  1c:	48 c7 c2 40 07 c0 8b 	mov    $0xffffffff8bc00740,%rdx
  23:	8b 0c 24             	mov    (%rsp),%ecx
  26:	4d 89 f8             	mov    %r15,%r8
  29:	50                   	push   %rax
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 83 c4 08          	add    $0x8,%rsp
  33:	4c 8b 6c 24 18       	mov    0x18(%rsp),%r13
  38:	48                   	rex.W
  39:	b9 00 00 00 00       	mov    $0x0,%ecx
  3e:	00 fc                	add    %bh,%ah


***

general protection fault in __timer_delete

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      2061f18ad76ecaddf8ed17df81b8611ea88dbddd
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/591f3943-d010-4b2d-a026-67cc75802376/config
syz repro: https://ci.syzbot.org/findings/58118c78-00cf-40ba-b5b2-a878d7311794/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000048: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000240-0x0000000000000247]
CPU: 1 UID: 0 PID: 5944 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:timer_is_static_object+0x26/0x80 kernel/time/timer.c:691
Code: 90 90 90 90 f3 0f 1e fa 41 57 41 56 53 48 89 fb 49 bf 00 00 00 00 00 fc ff df e8 95 e8 12 00 4c 8d 73 08 4c 89 f0 48 c1 e8 03 <42> 80 3c 38 00 74 08 4c 89 f7 e8 8b e0 78 00 49 83 3e 00 74 09 e8
RSP: 0018:ffffc900044279a8 EFLAGS: 00010006
RAX: 0000000000000048 RBX: 0000000000000238 RCX: ffff88817417d7c0
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000238
RBP: ffffffff99a2bcc0 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: ffffffff81ae62d0 R12: ffffffff8b6d2550
R13: fffffffffffffffe R14: 0000000000000240 R15: dffffc0000000000
FS:  000055555c51f500(0000) GS:ffff8882a9e8e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd2077ec08 CR3: 00000001138de000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 lookup_object_or_alloc lib/debugobjects.c:679 [inline]
 debug_object_assert_init+0x16f/0x380 lib/debugobjects.c:1008
 debug_timer_assert_init kernel/time/timer.c:803 [inline]
 debug_assert_init kernel/time/timer.c:848 [inline]
 __timer_delete+0x31/0x390 kernel/time/timer.c:1366
 try_to_grab_pending kernel/workqueue.c:2061 [inline]
 work_grab_pending+0x121/0x990 kernel/workqueue.c:2154
 __cancel_work+0x85/0x2c0 kernel/workqueue.c:4368
 __cancel_work_sync+0x1f/0x110 kernel/workqueue.c:4385
 hfsplus_put_super+0x56/0x3e0 fs/hfsplus/super.c:328
 generic_shutdown_super+0x135/0x2c0 fs/super.c:643
 kill_block_super+0x44/0x90 fs/super.c:1730
 deactivate_locked_super+0xbc/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1318
 task_work_run+0x1d4/0x260 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
 exit_to_user_mode_loop+0xff/0x4f0 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x2e3/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3b71f90af7
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd2077f3b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f3b71fee72f RCX: 00007f3b71f90af7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd2077f470
RBP: 00007ffd2077f470 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd20780500
R13: 00007f3b71fee72f R14: 000000000000f9eb R15: 00007ffd20780540
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:timer_is_static_object+0x26/0x80 kernel/time/timer.c:691
Code: 90 90 90 90 f3 0f 1e fa 41 57 41 56 53 48 89 fb 49 bf 00 00 00 00 00 fc ff df e8 95 e8 12 00 4c 8d 73 08 4c 89 f0 48 c1 e8 03 <42> 80 3c 38 00 74 08 4c 89 f7 e8 8b e0 78 00 49 83 3e 00 74 09 e8
RSP: 0018:ffffc900044279a8 EFLAGS: 00010006
RAX: 0000000000000048 RBX: 0000000000000238 RCX: ffff88817417d7c0
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000238
RBP: ffffffff99a2bcc0 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: ffffffff81ae62d0 R12: ffffffff8b6d2550
R13: fffffffffffffffe R14: 0000000000000240 R15: dffffc0000000000
FS:  000055555c51f500(0000) GS:ffff8882a9e8e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd2077ec08 CR3: 00000001138de000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	f3 0f 1e fa          	endbr64
   8:	41 57                	push   %r15
   a:	41 56                	push   %r14
   c:	53                   	push   %rbx
   d:	48 89 fb             	mov    %rdi,%rbx
  10:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  17:	fc ff df
  1a:	e8 95 e8 12 00       	call   0x12e8b4
  1f:	4c 8d 73 08          	lea    0x8(%rbx),%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 8b e0 78 00       	call   0x78e0c4
  39:	49 83 3e 00          	cmpq   $0x0,(%r14)
  3d:	74 09                	je     0x48
  3f:	e8                   	.byte 0xe8


***

general protection fault in hfsplus_sync_fs

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      2061f18ad76ecaddf8ed17df81b8611ea88dbddd
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/591f3943-d010-4b2d-a026-67cc75802376/config
C repro:   https://ci.syzbot.org/findings/990368ba-5843-438f-bf7c-132c134aa1f3/c_repro
syz repro: https://ci.syzbot.org/findings/990368ba-5843-438f-bf7c-132c134aa1f3/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 UID: 0 PID: 5946 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:hfsplus_sync_fs+0x70/0x3d0 fs/hfsplus/super.c:255
Code: 31 ff 89 ee e8 31 a9 24 ff 85 ed 0f 84 71 01 00 00 4c 89 24 24 0f 1f 44 00 00 e8 db a4 24 ff 4d 8d 7e 28 4c 89 f8 48 c1 e8 03 <80> 3c 18 00 74 08 4c 89 ff e8 d2 9c 8a ff 4d 8b 3f 49 83 c7 08 4c
RSP: 0018:ffffc900036e7a48 EFLAGS: 00010206
RAX: 0000000000000005 RBX: dffffc0000000000 RCX: ffff88810bbc57c0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffc900036e78a7 R09: 1ffff920006dcf14
R10: dffffc0000000000 R11: ffffffff829ca640 R12: ffff88811624e000
R13: ffff88811624e158 R14: 0000000000000000 R15: 0000000000000028
FS:  0000555564915500(0000) GS:ffff88818ea8e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00003e720 CR3: 0000000011796000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 sync_filesystem+0x1cf/0x230 fs/sync.c:66
 generic_shutdown_super+0x6f/0x2c0 fs/super.c:622
 kill_block_super+0x44/0x90 fs/super.c:1730
 deactivate_locked_super+0xbc/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1318
 task_work_run+0x1d4/0x260 kernel/task_work.c:233
 get_signal+0x11ec/0x1340 kernel/signal.c:2807
 arch_do_signal_or_restart+0x9a/0x7a0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
 exit_to_user_mode_loop+0x87/0x4f0 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x2e3/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdd6ef90af7
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd2aacb428 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fdd6efee72f RCX: 00007fdd6ef90af7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd2aacb4e0
RBP: 00007ffd2aacb4e0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd2aacc570
R13: 00007fdd6efee72f R14: 000000000000febb R15: 00007ffd2aacc5b0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfsplus_sync_fs+0x70/0x3d0 fs/hfsplus/super.c:255
Code: 31 ff 89 ee e8 31 a9 24 ff 85 ed 0f 84 71 01 00 00 4c 89 24 24 0f 1f 44 00 00 e8 db a4 24 ff 4d 8d 7e 28 4c 89 f8 48 c1 e8 03 <80> 3c 18 00 74 08 4c 89 ff e8 d2 9c 8a ff 4d 8b 3f 49 83 c7 08 4c
RSP: 0018:ffffc900036e7a48 EFLAGS: 00010206
RAX: 0000000000000005 RBX: dffffc0000000000 RCX: ffff88810bbc57c0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffc900036e78a7 R09: 1ffff920006dcf14
R10: dffffc0000000000 R11: ffffffff829ca640 R12: ffff88811624e000
R13: ffff88811624e158 R14: 0000000000000000 R15: 0000000000000028
FS:  0000555564915500(0000) GS:ffff8882a9e8e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ccfe37e9e0 CR3: 0000000011796000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	31 ff                	xor    %edi,%edi
   2:	89 ee                	mov    %ebp,%esi
   4:	e8 31 a9 24 ff       	call   0xff24a93a
   9:	85 ed                	test   %ebp,%ebp
   b:	0f 84 71 01 00 00    	je     0x182
  11:	4c 89 24 24          	mov    %r12,(%rsp)
  15:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1a:	e8 db a4 24 ff       	call   0xff24a4fa
  1f:	4d 8d 7e 28          	lea    0x28(%r14),%r15
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 ff             	mov    %r15,%rdi
  33:	e8 d2 9c 8a ff       	call   0xff8a9d0a
  38:	4d 8b 3f             	mov    (%r15),%r15
  3b:	49 83 c7 08          	add    $0x8,%r15
  3f:	4c                   	rex.WR


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

