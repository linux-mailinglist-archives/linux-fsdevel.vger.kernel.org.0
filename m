Return-Path: <linux-fsdevel+bounces-18007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200238B4A97
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 10:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4178B1C209DF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 08:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C733524AA;
	Sun, 28 Apr 2024 08:01:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7C6EED0
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714291289; cv=none; b=jdzDcInA7Ch+poyCZzy2StOpMrtxdAUq09gjAdr7ZZzGh1WQsmFftXLHZ2YiTLrGvI+NNFG+CBAy5p+zVEmeff0aSaqraTycpKZZVJim+q5M/ssqFdqfin1L/uttr7KHqia4K2YYgoZrsoNr+jLuouANhyaui/islgRYZdSTKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714291289; c=relaxed/simple;
	bh=JeQzpn0ojjt3L8YwXaNiLPthR1ef9kT2QpNtC2elcOY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Xjw5r5+nQRJIGmusP/eow42lTlqPN0+6TFUWkkiHSxmqvC5rhuSt+3cWQ5NFQGLYZiHX3YwBLOgQV6X/oPzXN3IYgONEIaIsdLMFgBHR5eS6xF2PGu6wJ1DNNXHHOHcQq27H3Wy/9vXz1AKz3nHxvsUOfcas3oS3IYeRz3AYAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36b2eee85edso40305505ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 01:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714291287; x=1714896087;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eq4m4QKg/wotWqf/VohvqPmmq7dtrBmgeSgxA368thg=;
        b=LsTSydKHR1V57NuTxdoiCIHydVu0NIfHtbhjaZnYHidBsBiSy3ifmEv90uExuskNss
         p4wv3YC6ZuRokIsE2bjbRpL/bNKYZu7EFxJWwlDwP9/YZrH23o1ayPV/gh+oc4Iz5kuG
         ley/lFd1gRjFdJ2Fvml2turebQo0mqVpWPUTRhZuf6tZNWCjhaXbgVqRUysmkrpiShBO
         Jwu4A/pBNtGIoRTLulE1yk7CxpzCK49MttGL60hbIjKb/KJiz+dkRn0T4Q1+5tx/rSbh
         tzL3LKjbI7XHU+RTyepnbHtCtNt0nPowyJiaAqTJW2XMCnH91rCCPOpSMxN0youbk4r5
         +VNw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ1fTWvNPbeaGFmjTVqLkBF6tRgfXaHutnq8xcFp3IT2lgheK5Nj3fVk3n6ok+V25XWCdekjgTwWD8KfZEQQGqmNGKaY4IvXq95W3big==
X-Gm-Message-State: AOJu0Yy/oSYCcm4GMu3+4Ul/xT6QfqTSpGQq1tuuWrKCp/M8/2ddSbbG
	JSBlfajnJFcikNl5ZqB9j0T4sbLjixalFLR3TEFFRTHxg8GD4CnyMnP5WlHuPb7DR5NIRR8+H81
	Tqk1oAbS63zrdLu5xX3EoRL0ZjqUWfQTzbr/pM+o/FXOgD4uxqq6QrLU=
X-Google-Smtp-Source: AGHT+IHIHjvMziOFJZk+Xpl1tYwnr0vrZFJhb+Yz6FMVAh7pZ0H7GtlwxLvPwKDi/IdW32yV0DWHjT61ZwU2SI0zLbwS1QqIiTjQ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154e:b0:36b:3c9c:558d with SMTP id
 j14-20020a056e02154e00b0036b3c9c558dmr120666ilu.1.1714291287606; Sun, 28 Apr
 2024 01:01:27 -0700 (PDT)
Date: Sun, 28 Apr 2024 01:01:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d5bc30617238b6d@google.com>
Subject: [syzbot] [overlayfs?] BUG: unable to handle kernel NULL pointer
 dereference in __lookup_slow (3)
From: syzbot <syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9d1ddab261f3 Merge tag '6.9-rc5-smb-client-fixes' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=131e4bf7180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=94891a5155abdf6821b7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1514c36f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13649630980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/de0722c51d76/disk-9d1ddab2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bbe188cbd737/vmlinux-9d1ddab2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/74cb740a2e68/bzImage-9d1ddab2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1ea7930b04fb/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=143e0f10980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=163e0f10980000
console output: https://syzkaller.appspot.com/x/log.txt?x=123e0f10980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com

overlayfs: fs on './file0' does not support file handles, falling back to index=off,nfs_export=off.
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 8000000022852067 P4D 8000000022852067 PUD 2dc51067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5070 Comm: syz-executor324 Not tainted 6.9.0-rc5-syzkaller-00036-g9d1ddab261f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000352f1b8 EFLAGS: 00010246
RAX: 1ffffffff17b0bc0 RBX: ffffffff8bd85e00 RCX: ffff88807ef35a00
RDX: 0000000000000000 RSI: ffff8880207f85e0 RDI: ffff88807ebf8018
RBP: ffffc9000352f2d0 R08: ffffffff820b2843 R09: 1ffffffff28ed13f
R10: dffffc0000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880207f85e0 R14: 1ffff110040ff0bc R15: 1ffff920006a5e3c
FS:  0000555558bc6380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000001cba8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __lookup_slow+0x28c/0x3f0 fs/namei.c:1692
 lookup_slow fs/namei.c:1709 [inline]
 lookup_one_unlocked+0x1a4/0x290 fs/namei.c:2817
 ovl_lookup_positive_unlocked fs/overlayfs/namei.c:210 [inline]
 ovl_lookup_single+0x200/0xbd0 fs/overlayfs/namei.c:240
 ovl_lookup_layer+0x417/0x510 fs/overlayfs/namei.c:333
 ovl_lookup+0xcf7/0x2a60 fs/overlayfs/namei.c:1124
 lookup_open fs/namei.c:3475 [inline]
 open_last_lookups fs/namei.c:3566 [inline]
 path_openat+0x1033/0x3240 fs/namei.c:3796
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd739fc9f39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc39adcc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6e69666e6f636e75 RCX: 00007fd739fc9f39
RDX: 0000000000001200 RSI: 0000000020000340 RDI: 0000000000000003
RBP: 646165725f78616d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 7269647265776f6c R14: 0079616c7265766f R15: 2f31656c69662f2e
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000352f1b8 EFLAGS: 00010246
RAX: 1ffffffff17b0bc0 RBX: ffffffff8bd85e00 RCX: ffff88807ef35a00
RDX: 0000000000000000 RSI: ffff8880207f85e0 RDI: ffff88807ebf8018
RBP: ffffc9000352f2d0 R08: ffffffff820b2843 R09: 1ffffffff28ed13f
R10: dffffc0000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880207f85e0 R14: 1ffff110040ff0bc R15: 1ffff920006a5e3c
FS:  0000555558bc6380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000001cba8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

