Return-Path: <linux-fsdevel+bounces-63126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9289EBAE829
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 22:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0420E1923A0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 20:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FCC24678F;
	Tue, 30 Sep 2025 20:17:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D91946AA
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759263457; cv=none; b=cTllEQJgMGLTq5WxpMQ3i1fZ7rmXw14DkIpUVTFdIKzkhRJgp1a2Oinz0DD1GTc83egtWn1VvhmErLHFpz6vgaFcSWtUmRdAKLN2bp9XaHKyr+tpeF23+x/Obe1iD3U909/9+xNRu+XakLD1IaFs2kkPm3TvTHVq9Xede1e5wlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759263457; c=relaxed/simple;
	bh=TDH8vzFsIMP+FaLjeKsxVQ8JrIFaIwg82WMRO0n46Is=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=os2ELWK0+1kO91yFbIPmtsQor7YuV4vDHTtqbKCrZzfzeDKThJ2fxTsm0Nf4jMBxrtyFoC549uJeRw9dzfSHCO0KJBDYZmJ0ELB00q4fYDZ6FTbpYTHc/M3q0K3fbxTCvI4wGULX+Okc8tzNWjaDzHB6ERwvDzP2P3X7xj34T50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-9143e8a4c5eso1208827739f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 13:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759263454; x=1759868254;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LGrzJ6TsXsD4qZJxnOtOJPRd2gsGL0hMKZMMty4R1hw=;
        b=JHQ1MWahQ1ZnIHcGAOWwaDAL8KTAdLHuhgnu7ddwGfUaNwffi2n4IzJWesKxkt7e1j
         2UR674fNVlLrfbdLniVH91FVT+9ps4lBUD78RTBc23YRNHm5wkOzEyVDsm+ZXAXqno4Z
         0wFrUZnMxqXjNJtB/7tUxTxSEFXeCua2udyh8znziuXI4FgphHwErylRiyagVxwG5RU3
         JabrFE9Z55JxeWl/QOnmBfagcThrzIOT43PO0N84a8g6fKZQ7XHrA7g4gBKrh/VJXbWW
         ZysdV+jGcQple5FkLc1+qbP63K0HhYRuhQmgW5JlDl7QjEGxqrBFuopSU2WaVPunpTF/
         e4rw==
X-Forwarded-Encrypted: i=1; AJvYcCXwNqxFoYHTRnYPVWmnkn+V+AXRwAMn2qzsol09CSbgLjmH3iO5ycdGL+kWQls0t4U9WDeD3Hz523mKLeqy@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/gVeMTKKOZvULj4Qvfa5KtUUPgNGOed/Stm9yPyhBePANA6y
	s4UuBTd7s7JEMkPatkhkrJkv6T8873F0ax1DtwnuG7WHA6sPUHQGW+Cv/lw97mYs3bH4zRNxIgI
	aE+ZIHhPgm3doVIKl4eFY/Ze5LvSWXvim2sDPAGneTiiD7GRSqURM1vXK24I=
X-Google-Smtp-Source: AGHT+IHIF7h447lb4NOR0bEvL5jEo3qx5Gy/t+7sjkLJjjoo7TxArWm1exNmogDkZgcACqCgR+3UluJFFNB1t/ywcjQtYM+ytjYF
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aad:b0:426:a2d3:28d3 with SMTP id
 e9e14a558f8ab-42d815f51a5mr19496315ab.13.1759263454583; Tue, 30 Sep 2025
 13:17:34 -0700 (PDT)
Date: Tue, 30 Sep 2025 13:17:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc3ade.a70a0220.10c4b.015c.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in free_mnt_ns
From: syzbot <syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    449c2b302c8e Merge tag 'vfs-6.18-rc1.async' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b43858580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=595e5938a1dd5b4e
dashboard link: https://syzkaller.appspot.com/bug?extid=7d23dc5cd4fa132fb9f3
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c9ad04580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160bf27c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ddc1ff1fc7e3/disk-449c2b30.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/92fc60e0e9d5/vmlinux-449c2b30.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e50a03ce90e3/bzImage-449c2b30.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com

------------[ cut here ]------------
ida_free called for id=1125 which is not allocated.
WARNING: CPU: 1 PID: 6109 at lib/idr.c:592 ida_free+0x1f9/0x2e0 lib/idr.c:592
Modules linked in:
CPU: 1 UID: 0 PID: 6109 Comm: syz.1.23 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ida_free+0x1f9/0x2e0 lib/idr.c:592
Code: 33 f6 41 83 fe 3e 76 72 e8 14 31 33 f6 48 8b 7c 24 28 4c 89 ee e8 57 65 0d 00 90 48 c7 c7 e0 17 16 8d 89 ee e8 78 13 f2 f5 90 <0f> 0b 90 90 e8 ee 30 33 f6 48 b8 00 00 00 00 00 fc ff df 48 01 c3
RSP: 0018:ffffc90003037980 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 1ffff92000606f31 RCX: ffffffff817a02f8
RDX: ffff88802c8ebc00 RSI: ffffffff817a0305 RDI: 0000000000000001
RBP: 0000000000000465 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8880791f7f00
R13: 0000000000000293 R14: 0000000000000065 R15: ffff8880791f7f08
FS:  0000000000000000(0000) GS:ffff8881247b3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe8d5f156c0 CR3: 000000007680c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 free_mnt_ns+0xe0/0x110 fs/namespace.c:4096
 namespace_unlock+0x542/0x920 fs/namespace.c:1701
 put_mnt_ns fs/namespace.c:6135 [inline]
 put_mnt_ns+0xf5/0x120 fs/namespace.c:6126
 free_nsproxy+0x3a/0x400 kernel/nsproxy.c:188
 put_nsproxy include/linux/nsproxy.h:107 [inline]
 switch_task_namespaces+0xeb/0x100 kernel/nsproxy.c:241
 do_exit+0x86a/0x2bf0 kernel/exit.c:960
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 get_signal+0x2673/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x41c/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5cffd8eec9
Code: Unable to access opcode bytes at 0x7f5cffd8ee9f.
RSP: 002b:00007f5d00ba0038 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: fffffffffffffff4 RBX: 00007f5cfffe5fa0 RCX: 00007f5cffd8eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000020000
RBP: 00007f5cffe11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5cfffe6038 R14: 00007f5cfffe5fa0 R15: 00007ffee87a9438
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

