Return-Path: <linux-fsdevel+bounces-72093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8028CDDD79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 15:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB8D43014DBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF05314D07;
	Thu, 25 Dec 2025 14:06:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2312D8799
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766671588; cv=none; b=OjIc9t6eAwRHtYiDOL/oUgU49wHBmxEFD288FWdbGYDePmC5B0+x24amE6Lo5IFORSpR6XY60huyIw4HPomI7J3WSnWe4KmU7lD2vkBftIsNdC3bCEHKd1TOuj6E5JJivtI4gpRtiNMXhV/EBIaHp6ZNp3hBqM1GjbCsZEVMaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766671588; c=relaxed/simple;
	bh=yZEo88ICU+Oo+JpH2TyshegTTdDFWmeuzcNUG1Mk2Zo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tgPR0fhqpGzO9cVO1Bbj1VdB0s0mxxRogwhjIA00XYs/7UQArnD01HZykRYaXyqN5mcEV6lU16Anz+doAHg0JsXMp2ODMQpjIaaY4b8j6M9TrBRZi7AgcGNFldEhBhrCIRhD+PKdYQcrF6NsEfiSBQKwjr+cT7B8IOMHWtIhenA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-65703b66ebfso11309114eaf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 06:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766671585; x=1767276385;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+LtGzUEgQkpcQX0PsTQrwXYEs/GKKZLowfJnxsD0riY=;
        b=cbcLZ5+eThEsSgb00DFxj9B3hb7PEtH4sMw7jf3/LEKqWta7+sv+pPvMC1N89qhqaO
         4fPUIlKyCTGaa28ANw/lLdtyZMnfbV2sqADbSJaD4wCwyowdI8YH2hvKC7CcBtwCYOu4
         EFlTyufhFK02XpOvbE0dqpHIBLg113XaUt5Yy+EmG856NBujgJVphzoY72PSD9wrKk2b
         UPrOfQtRGFTBZcT6trhEK8pJewqZ8Ri4d9+wujYBOZ+lTmg7l3ex3ojKhKacc01lItnF
         maf1cArSjRI9jEUWbrZ8dAMBgUWiG+q+GpDmq6+c/HFdvwjjB2Vq9CQ6esJ9UutgDaOv
         m7BA==
X-Forwarded-Encrypted: i=1; AJvYcCX1nZ5Bo7+AIiQh3ULtUPXFFb61cIi0gx0bhCqsB2Kjd447P7Opttotd3uJCJguBIuM6DQMIe3iQtcImERp@vger.kernel.org
X-Gm-Message-State: AOJu0YxSHySuCFvwWCNgylSDwSbxhzenGzj91vn1WlLW5YgQv3a0vP3+
	aGPJasj23KB4sHKHXV+RXIzqPAXVvS9IXRvhgIzjTrqu3d2Dipm0SaEUxHwWd2YbKASv3r/z2PH
	AkYXDM+YJknr+7dyCV3RrjHHuPw0nZiw46E2of9NK9zOZUGbWaj3ZS8QluFE=
X-Google-Smtp-Source: AGHT+IGL7YFyjcgeyIa0tMkaVS20x/UVQe/jRyOl88Crr9hcWdzGgNffX9ms3yaS2L49FkEq1PfmLM1GP5UVYunghN32qezSZf4N
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4289:b0:659:9a49:8e21 with SMTP id
 006d021491bc7-65cfe748da1mr7332434eaf.19.1766671585267; Thu, 25 Dec 2025
 06:06:25 -0800 (PST)
Date: Thu, 25 Dec 2025 06:06:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694d44e1.050a0220.35954c.0041.GAE@google.com>
Subject: [syzbot] [jfs?] VFS: Busy inodes after unmount (use-after-free) (4)
From: syzbot <syzbot+d569e274f46ca86f78fa@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, jfs-discussion@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ccd1cdca5cd4 Merge tag 'nfsd-6.19-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1697109a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=d569e274f46ca86f78fa
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b1c8fc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1478e022580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f7b489f9e06c/disk-ccd1cdca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a3b40a08a43/vmlinux-ccd1cdca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/deb72d1923f7/bzImage-ccd1cdca.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6c19056fd03d/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16972f1a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d569e274f46ca86f78fa@syzkaller.appspotmail.com

tblock:ffffc900027792a0: 00000002 00000000 027793b8 ffffc900
tblock:ffffc900027792b0: 99a20540 ffffffff 00003ab0 00000000
tblock:ffffc900027792c0: 44b53100 ffff8881 00000003 00000ab0
tblock:ffffc900027792d0: 00000000 dead4ead ffffffff 00000000
tblock:ffffc900027792e0: ffffffff ffffffff 99a203c0 ffffffff
tblock:ffffc900027792f0: 00000000 00000000 00000000 00000000
tblock:ffffc90002779300: 8ba58f60 ffffffff 00000300 00000000
tblock:ffffc90002779310: 02779310 ffffc900 02779310 ffffc900
tblock:ffffc90002779320: 5a664d70 ffff8880 00000000 00000000
VFS: Busy inodes after unmount of loop0 (jfs)
------------[ cut here ]------------
kernel BUG at fs/super.c:653!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5960 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:generic_shutdown_super+0x2bc/0x2c0 fs/super.c:651
Code: 03 42 80 3c 28 00 74 08 4c 89 f7 e8 8e fa ed ff 49 8b 16 48 81 c3 68 06 00 00 48 c7 c7 e0 b2 79 8b 48 89 de e8 a5 8c ee fe 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
RSP: 0018:ffffc9000404fd00 EFLAGS: 00010246
RAX: 000000000000002d RBX: ffff8880318d6668 RCX: 29d16eab6a395c00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff1100631acf0 R08: ffff8880b86247d3 R09: 1ffff110170c48fa
R10: dffffc0000000000 R11: ffffed10170c48fb R12: 0000000000000000
R13: dffffc0000000000 R14: ffffffff8e38bea0 R15: ffff8880318d6780
FS:  00005555777b6500(0000) GS:ffff888125e1f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbab6082000 CR3: 0000000030db6000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 kill_block_super+0x44/0x90 fs/super.c:1722
 deactivate_locked_super+0xbc/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1318
 task_work_run+0x1d4/0x260 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
 exit_to_user_mode_loop+0xef/0x4e0 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x2b7/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb469390a77
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffc903b6258 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000064 RCX: 00007fb469390a77
RDX: 0000000000000200 RSI: 0000000000000009 RDI: 00007ffc903b7400
RBP: 00007fb469413d7d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000202 R12: 00007ffc903b7400
R13: 00007fb469413d7d R14: 00005555777b64a8 R15: 00007ffc903b84d0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:generic_shutdown_super+0x2bc/0x2c0 fs/super.c:651
Code: 03 42 80 3c 28 00 74 08 4c 89 f7 e8 8e fa ed ff 49 8b 16 48 81 c3 68 06 00 00 48 c7 c7 e0 b2 79 8b 48 89 de e8 a5 8c ee fe 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
RSP: 0018:ffffc9000404fd00 EFLAGS: 00010246
RAX: 000000000000002d RBX: ffff8880318d6668 RCX: 29d16eab6a395c00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff1100631acf0 R08: ffff8880b86247d3 R09: 1ffff110170c48fa
R10: dffffc0000000000 R11: ffffed10170c48fb R12: 0000000000000000
R13: dffffc0000000000 R14: ffffffff8e38bea0 R15: ffff8880318d6780
FS:  00005555777b6500(0000) GS:ffff888125f1f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005619d76b3a38 CR3: 0000000030db6000 CR4: 0000000000350ef0


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

