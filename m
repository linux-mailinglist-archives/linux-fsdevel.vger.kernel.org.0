Return-Path: <linux-fsdevel+bounces-16661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0538A0CBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 11:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FE41C217C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 09:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E88145B0D;
	Thu, 11 Apr 2024 09:48:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786EE14534A
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828910; cv=none; b=i88av4yeFt7HrwnN/yndxNSvoSV5Bsl+KjDlb7RwliBYyNQENvagqRB7/2FV41X9iDbYUjqBUuX3pq6rLFR1wAsQ6W2QftZH2NmvUFx5gwe+uLkN0fK9eCc6onWdBaoCt1MLfOylwzUiOOWj4uFz5ItqEh3tb2kgqdUvaMo1ftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828910; c=relaxed/simple;
	bh=ETAy9kydqxrg8N+usjcKuIuww3eYpAwTXNNz7laF/18=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OrYufobdmKj2+566/kla5jbrk3S0NDgGjiseexYv/ojIBB7ryk24XAfeXL62reQVYQUDp+AdElEAb600UmsiJln2YYE4WOAAMvo207bHfo7txexuzgTzIscD0B0j6chZy7xhG1LILgGgqcVodg2BwuMWkp9kkB6QvtzNGinS6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d663e01e70so119934839f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 02:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712828907; x=1713433707;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxY3ThfzTOVgLza0iD4fys5v3cj7IHGn+rCsgDPuuvI=;
        b=e6vdhWhlj4qGSWYNQtDPepRCP5okwyfGbjHVqljAD24lCZp62v1jy0GYkGBmomKVpo
         EUmTpXTECYmGYGYZVRGqlHt5MABwd/xckjNFdMWaj+WPQgyIik8OJqZn03olLGrFZoYF
         VyGfnYljbo8KxuSY87rSmlDfoC2g/sRlxzRQ2tC6jzI60o3OdJybA0G8qzrYFZwyedXI
         6/q1ibh69qz0EaV+zUopNzE43YNBocL6GISypzNEP0flrc+nvGfVWINjrYsp6sr+bwjT
         0TO+oKiSRq1NKm9LRQ8EmIJLHIgfphLLF8ZlU5a0/iqxoUVlsbu9iSupnovHj463sBLe
         /vbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDMEh5LvM4UGBZUkJv/huyy+sSW9Ws2H5bfDy5R2u88hTeWRuBrlTEXXFwLgtg6w94bBvMfWTBNSIW8sxZPlSDRXPciDqfQuKUlrYcGQ==
X-Gm-Message-State: AOJu0YyskblheA3V3+trce3k3C8p2IQHDaZ7S2wKC4B3cA5vFJSfqVRS
	0xWuXCVAyMHxL3CqTEDSRGkKcE9q3HUvcMYdnH5ph7HleczTmTdhRUau0HSMR56fDxE7tpez2Je
	HKwPnKoDGko/QaHmLt9k/EDvp4cd/DDmHKS/MeKQLbOrmE3zJ3aY/jto=
X-Google-Smtp-Source: AGHT+IG9y+tUNYbixenLBF5gILNrr6MCXPVDw7JA+yzgAcOC0AlCI2oyis12hTaJhCFovjhCo8EArlcfCZJsKjZxOUX2NlaO9Is8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8329:b0:482:d033:89c5 with SMTP id
 io41-20020a056638832900b00482d03389c5mr9259jab.6.1712828907702; Thu, 11 Apr
 2024 02:48:27 -0700 (PDT)
Date: Thu, 11 Apr 2024 02:48:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009adc640615cf0ef7@google.com>
Subject: [syzbot] [ext4?] WARNING: locking bug in ext4_xattr_inode_update_ref (3)
From: syzbot <syzbot+3ca210b2c10e57015b3c@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f2f80ac80987 Merge tag 'nfsd-6.9-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1734efc5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=411644804960f423
dashboard link: https://syzkaller.appspot.com/bug?extid=3ca210b2c10e57015b3c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e7f79d180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1614c105180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-f2f80ac8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/226f497bcbfb/vmlinux-f2f80ac8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6cae4ca2cad5/bzImage-f2f80ac8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2780392925e4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ca210b2c10e57015b3c@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "&ea_inode->i_rwsem" with key ext4_fs_type, but found a different class "&sb->s_type->i_mutex_key" with the same key
WARNING: CPU: 0 PID: 5434 at kernel/locking/lockdep.c:932 look_up_lock_class+0x133/0x140 kernel/locking/lockdep.c:932
Modules linked in:
CPU: 0 PID: 5434 Comm: syz-executor760 Not tainted 6.9.0-rc2-syzkaller-00413-gf2f80ac80987 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:look_up_lock_class+0x133/0x140 kernel/locking/lockdep.c:932
Code: c7 c7 20 ca 2c 8b e8 dc 76 70 f6 90 0f 0b 90 90 90 31 db eb be c6 05 02 67 eb 04 01 90 48 c7 c7 40 cd 2c 8b e8 be 76 70 f6 90 <0f> 0b 90 90 e9 62 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003ef6ea0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffffffff942543e8 RCX: ffffffff814fe349
RDX: ffff8880259da440 RSI: ffffffff814fe356 RDI: 0000000000000001
RBP: ffffffff8de72ed8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000006b6f6f4c R12: ffff8880329db600
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff94af1aa0
FS:  00007fb2680336c0(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555582e00778 CR3: 0000000019d34000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0xb1/0x1230 kernel/locking/lockdep.c:1284
 __lock_acquire+0x111/0x3b30 kernel/locking/lockdep.c:5014
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
 inode_lock include/linux/fs.h:795 [inline]
 ext4_xattr_inode_update_ref+0xa6/0x5e0 fs/ext4/xattr.c:1042
 ext4_xattr_inode_inc_ref fs/ext4/xattr.c:1088 [inline]
 ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1583 [inline]
 ext4_xattr_set_entry+0x125f/0x3c70 fs/ext4/xattr.c:1718
 ext4_xattr_block_set+0xcc3/0x3100 fs/ext4/xattr.c:2037
 ext4_xattr_set_handle+0xdb6/0x1480 fs/ext4/xattr.c:2443
 ext4_xattr_set+0x149/0x380 fs/ext4/xattr.c:2545
 __vfs_setxattr+0x173/0x1e0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x127/0x5e0 fs/xattr.c:234
 __vfs_setxattr_locked+0x182/0x260 fs/xattr.c:295
 vfs_setxattr+0x146/0x350 fs/xattr.c:321
 do_setxattr+0x146/0x170 fs/xattr.c:629
 setxattr+0x15d/0x180 fs/xattr.c:652
 path_setxattr+0x179/0x1e0 fs/xattr.c:671
 __do_sys_setxattr fs/xattr.c:687 [inline]
 __se_sys_setxattr fs/xattr.c:683 [inline]
 __x64_sys_setxattr+0xc4/0x160 fs/xattr.c:683
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7fb26807cf79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb268033218 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fb26807cf79
RDX: 00000000200005c0 RSI: 0000000020000180 RDI: 0000000020000080
RBP: 00007fb2681056a8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000002000 R11: 0000000000000246 R12: 00007fb2681056a0
R13: 0072657070752e79 R14: 0030656c69662f2e R15: 2f30656c69662f2e
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

