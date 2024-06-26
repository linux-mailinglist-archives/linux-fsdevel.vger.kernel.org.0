Return-Path: <linux-fsdevel+bounces-22523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53A79185E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 17:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B33B2B19B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5497C18C358;
	Wed, 26 Jun 2024 15:27:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AE518C34D
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415648; cv=none; b=NfHJitWHUmmuy8SN4hNcNhcmVm5OcIJNA1NlOhSaTh3jzLP6eaxkFLuHiBJjCdcfCsLLpeSorAvcviY054Xpa3U1N7+OkoKFPg/20sRNqxaVneTXZFcivxGgcPn5S4jD2Xz9x29gtGvky3SONs+/gPnwuQXNj5sYzVMthlOt+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415648; c=relaxed/simple;
	bh=BleCr8Mhu+R2zsdCbIvZ23wKYL4W8NBBCOEQ5yWtMi8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Yq/qUKPZLTXr1Q80tb71ky9b3mTXhDBV8p0+mYxtxV4oZeEyxg1VS7yIiI+XmNaDERhQFp22//LmYzayNNwEK9dEncj6mydqSOq3TinoxaV0U5ve9raxjQ3ZO5aruLiooDAhz7GpsT4H00Sq54bjFAAvRxiNnJip28fE1fgMmdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7eee4ffd19eso978674039f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 08:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719415645; x=1720020445;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=muFjIliOCSevMBNmjRAbmoaEq6b90Bcb5SmnFYYXYFk=;
        b=OjqQoMZvLkSWSj/HGzMQBmluxCDAQq1tlbuWTJIJxxGe4QwIhcZLOwy3YGcakBqRIF
         vLrBdvnFKI3DxEVeIKaS60DOFjKDQXZ5GeZxXS6sl1vyuKg9Z5RYD2RQLQLK1p9F1x1z
         mbuBlJ4V3l4+bwr/Bty0Tdl+YRGVfxLVR7oIM7F3uiueSHmHVt67OtJPkS9qOyEedn+J
         1/Bs7VSbPi6F/pF1RQDq1eSfB7wO9dVuLYTg74Ms9W3F+jGLvC8HLHhT1+EDp7zwgf8v
         fmlmDzwvwoUoB/dvcOJerndLHRnyypX9jCs7GEaExtqayrU7R+A6NPFPR+8RJx+RVk1U
         LGHw==
X-Forwarded-Encrypted: i=1; AJvYcCW/fxguRrj8Wgz9irQjC94lemwJuVKEJ7xNzdAmcwp9CMZVwRe+Cu2Oy+gR7AdQum+H+uZmErz8miexc2z2fZeFWqzjX/gSWjbSxdDo6A==
X-Gm-Message-State: AOJu0YyXb4UOVbCfK2KM96PFB3m3OzHKWPYbwNAayyfpYpVrEjB+hYuV
	KK5e68HTNLjxeYKJwbbcMAvrgCwx9V5SKGOQGK2UDO3RB2XoKNNvvlF3y5pzbw1XS495HyWxirC
	SOuHSZ3xDJuSN06Tshze/yytv6xPnQQsn2IV198JJyapt8bFMLLodFro=
X-Google-Smtp-Source: AGHT+IEEOn46GmPzIxcvI3oueipDiyudUO/wN+BmtrD/3uGY/zkrVbOhscGYR+fTax/ksuVCyOi7sYIwZ+o8D7kTf2NJdceQ9R3a
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3424:b0:7f3:80a7:9ca6 with SMTP id
 ca18e2360f4ac-7f3a15669cdmr45293239f.3.1719415645698; Wed, 26 Jun 2024
 08:27:25 -0700 (PDT)
Date: Wed, 26 Jun 2024 08:27:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c88c57061bcca691@google.com>
Subject: [syzbot] [fs?] linux-next test error: BUG: sleeping function called
 from invalid context in mas_alloc_nodes
From: syzbot <syzbot+2e16d05f747636051a3e@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0fc4bfab2cd4 Add linux-next specific files for 20240625
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11294561980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df444fac2868e4e3
dashboard link: https://syzkaller.appspot.com/bug?extid=2e16d05f747636051a3e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/16d20f206142/disk-0fc4bfab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4ced1cf03d35/vmlinux-0fc4bfab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/68553962499b/bzImage-0fc4bfab.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e16d05f747636051a3e@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:337
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5093, name: udevd
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by udevd/5093:
 #0: ffff88805c08e420 (sb_writers#5){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff88807d7a5128 (&type->i_mutex_dir_key#5){++++}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
 #1: ffff88807d7a5128 (&type->i_mutex_dir_key#5){++++}-{3:3}, at: open_last_lookups fs/namei.c:3582 [inline]
 #1: ffff88807d7a5128 (&type->i_mutex_dir_key#5){++++}-{3:3}, at: path_openat+0x7e9/0x35e0 fs/namei.c:3821
 #2: ffff88807d7a4ed8 (&simple_offset_lock_class){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffff88807d7a4ed8 (&simple_offset_lock_class){+.+.}-{2:2}, at: mtree_alloc_cyclic+0x217/0x330 lib/maple_tree.c:6586
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 UID: 0 PID: 5093 Comm: udevd Tainted: G        W          6.10.0-rc5-next-20240625-syzkaller #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8520
 might_alloc include/linux/sched/mm.h:337 [inline]
 slab_pre_alloc_hook mm/slub.c:3926 [inline]
 slab_alloc_node mm/slub.c:4017 [inline]
 kmem_cache_alloc_noprof+0x5d/0x2a0 mm/slub.c:4044
 mt_alloc_one lib/maple_tree.c:162 [inline]
 mas_alloc_nodes+0x26c/0x840 lib/maple_tree.c:1242
 mas_node_count_gfp lib/maple_tree.c:1322 [inline]
 mas_wr_preallocate+0x4ca/0x6b0 lib/maple_tree.c:4351
 mas_insert lib/maple_tree.c:4389 [inline]
 mas_alloc_cyclic+0x3f7/0xae0 lib/maple_tree.c:4451
 mtree_alloc_cyclic+0x239/0x330 lib/maple_tree.c:6587
 simple_offset_add+0x105/0x1b0 fs/libfs.c:289
 shmem_mknod+0xfa/0x1e0 mm/shmem.c:3438
 lookup_open fs/namei.c:3516 [inline]
 open_last_lookups fs/namei.c:3585 [inline]
 path_openat+0x1aaf/0x35e0 fs/namei.c:3821
 do_filp_open+0x235/0x490 fs/namei.c:3851
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1417
 do_sys_open fs/open.c:1432 [inline]
 __do_sys_openat fs/open.c:1448 [inline]
 __se_sys_openat fs/open.c:1443 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1443
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd6237169a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffd504c9180 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fd6237169a4
RDX: 0000000000080241 RSI: 00007ffd504c96c8 RDI: 00000000ffffff9c
RBP: 00007ffd504c96c8 R08: 0000000


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

