Return-Path: <linux-fsdevel+bounces-23989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D710D9376C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 12:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5996A1F218BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 10:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4732D86277;
	Fri, 19 Jul 2024 10:48:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D4D77107
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721386106; cv=none; b=qsliY4ibo+Wb4ICPQWdmyE5jOKJDfUeG+wI/TSBeR/2kzoYZGXJesjD2dnQsp5Lgc1t8UcoSU0m/CMTqnEB5quU45W/ajL+rKYddJuah3vYO95Y3hbDPOTkgPcuOjMA5/Z5K82rKqjXguLqK+MjAu4T/8/7l/bdUxxAzs0vNFtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721386106; c=relaxed/simple;
	bh=02FH24jrTBYKtRTAr43pBQ9eN8OwDgj7jhIU3s1Xvuw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=haPkJLw9hnxattCnmRidRGX414wBpfxA+m4HJECtjG8iOLSb/5qa9fEqjIOYZ4oZnEL+6IqEXJF+ardKuSZJ8Q+CP/DeEmdvmiVA882Mq/y6ko9LTfo2Ucp4gc6Hn7CgkXocZYS/Bsjc+HSYOwLsAhF+lA0C/CewhoBNQF0xLYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39858681a32so4649745ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 03:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721386104; x=1721990904;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjd0HawvlrmmXjmsT0jPDTjlvuL96xs/zcnGiggrvQs=;
        b=ASUKi7+MvJ9Stkuds7to0tlDWOFVjILtzkYjp1kQql8PhedQknD6Fci2b7OaOEXeBr
         vnTSmvXw/T2hY8fZeQekQ+2kUmbCnDr2QVKAwlhBiRf0w2EtG0b+T1eFuCBmfSzFD9lG
         HE5b0eZfcJw6BI255n1RtdYysVdb+bjILEzEsrw7Jima1zhZZzKyCrKEY5faQgKOqvay
         h+F2KjxaUfH2jJpYdWNn9wW98VtN+E97xzHnCyZI8WGFrPvqhL76JhQF195m5weEknXv
         j6m38hR1ZX+JfDLgLQUxjyCOHXUsKtdSLKIIIy0HAdu8X6ZKv5wvOlP01w2kwXp3YkEI
         7tfA==
X-Gm-Message-State: AOJu0YwyzwrhMWnaaHPVpvZLErYWBgFqrSZ/MJQTqYv/Gpeztb/OLQ1r
	V2VYrome0mUJ0hLFjhkAl7+0W2NHtcTOlSeS2Je9Kak1MfZL9kE6JEBFp2HPeFkIz7S1s3mLy7z
	NR5SxEEEKyPCI92DhmrJS4LzH0Vzrhbr2Gbe6CVOMYQyyc7BVa21sEZ0=
X-Google-Smtp-Source: AGHT+IHdE/A9JzwF9cRaA+p5kudeLkFC4WzOLCTi/jzjtYopUZwBKcqXHw9T8FdWBiqfdkrer/4mgx4rh7tc/JeBIZZ/kJed+bv4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ea:b0:397:5d37:622e with SMTP id
 e9e14a558f8ab-3975d376423mr2217495ab.2.1721386104500; Fri, 19 Jul 2024
 03:48:24 -0700 (PDT)
Date: Fri, 19 Jul 2024 03:48:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047bf6a061d976fdb@google.com>
Subject: [syzbot] [hfs?] WARNING: ODEBUG bug in hfsplus_fill_super (3)
From: syzbot <syzbot+dd02382b022192737ea3@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    68b59730459e Merge tag 'perf-tools-for-v6.11-2024-07-16' o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d065e9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b6230d83d52af231
dashboard link: https://syzkaller.appspot.com/bug?extid=dd02382b022192737ea3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8229997a3dbb/disk-68b59730.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd51823e0836/vmlinux-68b59730.xz
kernel image: https://storage.googleapis.com/syzbot-assets/01811b27f987/bzImage-68b59730.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd02382b022192737ea3@syzkaller.appspotmail.com

hfsplus: b-tree write err: -5, ino 8
------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff88807bf16a38 object type: timer_list hint: delayed_sync_fs+0x0/0xf0
WARNING: CPU: 0 PID: 21527 at lib/debugobjects.c:518 debug_print_object+0x17a/0x1f0 lib/debugobjects.c:515
Modules linked in:
CPU: 0 PID: 21527 Comm: syz.2.2751 Not tainted 6.10.0-syzkaller-08280-g68b59730459e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:debug_print_object+0x17a/0x1f0 lib/debugobjects.c:515
Code: e8 eb 1b 44 fd 4c 8b 0b 48 c7 c7 e0 64 20 8c 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f8 ff 34 24 e8 db fc 9f fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 1c 78 f6 0a 48 83 c4 10 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc900038275b8 EFLAGS: 00010286
RAX: 07a674bbf3926400 RBX: ffffffff8bccb7a0 RCX: 0000000000040000
RDX: ffffc9000e1eb000 RSI: 000000000002ed85 RDI: 000000000002ed86
RBP: ffffffff8c206660 R08: ffffffff81588142 R09: fffffbfff1c39da0
R10: dffffc0000000000 R11: fffffbfff1c39da0 R12: 0000000000000000
R13: ffffffff8c206578 R14: dffffc0000000000 R15: ffff88807bf16a38
FS:  00007f99cdb5a6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007eff0195d430 CR3: 000000005761c000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:990 [inline]
 debug_check_no_obj_freed+0x45b/0x580 lib/debugobjects.c:1020
 slab_free_hook mm/slub.c:2163 [inline]
 slab_free mm/slub.c:4438 [inline]
 kfree+0x10f/0x360 mm/slub.c:4559
 hfsplus_fill_super+0xf25/0x1ca0 fs/hfsplus/super.c:618
 mount_bdev+0x20c/0x2d0 fs/super.c:1668
 legacy_get_tree+0xf0/0x190 fs/fs_context.c:662
 vfs_get_tree+0x92/0x2a0 fs/super.c:1789
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f99ccd7725a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f99cdb59e78 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f99cdb59f00 RCX: 00007f99ccd7725a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f99cdb59ec0
RBP: 0000000020000000 R08: 00007f99cdb59f00 R09: 0000000002000010
R10: 0000000002000010 R11: 0000000000000206 R12: 0000000020000100
R13: 00007f99cdb59ec0 R14: 00000000000006b5 R15: 0000000020000140
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

