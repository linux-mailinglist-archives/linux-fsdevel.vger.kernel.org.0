Return-Path: <linux-fsdevel+bounces-38656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3595AA05B5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 13:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008B13A889F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 12:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168FB1F9ED1;
	Wed,  8 Jan 2025 12:17:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3B51DE895
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jan 2025 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736338644; cv=none; b=PdTZAB3i5fLBYYUXqlQGUn3Vs0RbNedUjoL1rTfixG5mYqWsTKgGYo081Ed6KLeYSIBUkEIkToSYZ/ciin4lInjWUTKzZ+MSwAuY/mzPcT8wdb+Q6TbRBCdT8Zo5e7V7xWzgaDavt4F7cqA17GIjg9mo/6E00XRwPdINEqU4VDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736338644; c=relaxed/simple;
	bh=Q+9uQxrXpihw3MD6R3XtE2fPrMpD4NUmpuB5KMufYp4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uHVNzDrH6iFL+2pVZ8KUlJeLE3sOeaRmoY48wwqE5mXoE/h9pc9J1NxBYwsDNoe/TRh78glyvm/HZLD6tfxz3xxFWovU767/d1PByyU373PCl//FK0qpXd3aRBZxLCSwlOodp4d1sdOw+0LtgeV7/QSZ3tstvdbNx03vUMtUMwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a9c9b37244so323775655ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2025 04:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736338642; x=1736943442;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/ml6B0pMxr4gHNtkbSBd0Eg/unwYv5YitEJahfz9OM=;
        b=Qilut/m/NdNbxmTeeaguSk0P+IbGYc40J2wNWkiVJGREYVzxAVQ0kAcqpl9nyE6EYZ
         1I94dYR4wi7TR0cKT0H3wOs9QHJewbQXdW5ehesk34uGB9Qmi/elvs3Hs917YST1YTys
         BtoL7LrHmF228CqWBHJH03w9YdspRbktH1hTjoNeELU9anp73VhHNwOQy9AweKGsuctF
         46LztBDt0WfXiRWQ3IVJrQHiQYY4tIWAY5KPFkMcANvKjQk+8ujSnaDiMDjjVzNNrXSA
         NMXlJ+Fb57phIACq93xMYjE+xspuD0rd/UF1yaIcUu1a0LgYEEL0FylUzxtv92L9IocA
         4RzA==
X-Gm-Message-State: AOJu0YwFR7svctpEbBBliAFhtZJglPGLMZUma6MexAeKV5rvLnHXoNu2
	iXqUuCL7OUemKrPA5mql/WG0gntSWQcsUYVZ3KuiuzAeRwUeXsRz8FyJKNLch/nRB1RKQVK7kOe
	JRuwzdYELhN2ET31IcfiW2UnWpa0t378uvSGbMeVX9i7fLOhwHKSVD5z3nw==
X-Google-Smtp-Source: AGHT+IHAB4hE4gEfLWJF6NOHUb5TBvkmyJG2DJfbCtIikg5iV6UndYBUiLONfJBe5saNxmWw0SF9n3UO7VpHgFvYRabyf+YIJy71
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f09:b0:3a7:e0c0:5f27 with SMTP id
 e9e14a558f8ab-3ce3a86a220mr21467045ab.2.1736338642365; Wed, 08 Jan 2025
 04:17:22 -0800 (PST)
Date: Wed, 08 Jan 2025 04:17:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677e6cd2.050a0220.3b3668.02e7.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in minix_rmdir
From: syzbot <syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8155b4ef3466 Add linux-next specific files for 20241220
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=115656f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c90bb7161a56c88
dashboard link: https://syzkaller.appspot.com/bug?extid=4e49728ec1cbaf3b91d2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16726edf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17535418580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98a974fc662d/disk-8155b4ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2dea9b72f624/vmlinux-8155b4ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/593a42b9eb34/bzImage-8155b4ef.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7d86236cea0c/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122c7418580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=112c7418580000
console output: https://syzkaller.appspot.com/x/log.txt?x=162c7418580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5830 at fs/inode.c:407 drop_nlink+0xc4/0x110 fs/inode.c:407
Modules linked in:
CPU: 0 UID: 0 PID: 5830 Comm: syz-executor235 Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:drop_nlink+0xc4/0x110 fs/inode.c:407
Code: bb 70 07 00 00 be 08 00 00 00 e8 87 15 e7 ff f0 48 ff 83 70 07 00 00 5b 41 5c 41 5e 41 5f 5d c3 cc cc cc cc e8 4d 97 80 ff 90 <0f> 0b 90 eb 83 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 5c ff ff ff
RSP: 0018:ffffc90003ecfd30 EFLAGS: 00010293
RAX: ffffffff823e8cd3 RBX: 1ffff1100ef7ca0c RCX: ffff88803493bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff823e8c53 R09: 1ffffffff203563e
R10: dffffc0000000000 R11: fffffbfff203563f R12: ffff888077be5060
R13: ffff8880792a5a70 R14: ffff888077be5018 R15: dffffc0000000000
FS:  0000555592c31380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe52599f9c CR3: 0000000076e2e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_dec_link_count include/linux/fs.h:2567 [inline]
 minix_rmdir+0xa5/0xc0 fs/minix/namei.c:170
 vfs_rmdir+0x3a3/0x510 fs/namei.c:4394
 do_rmdir+0x3b5/0x580 fs/namei.c:4453
 __do_sys_rmdir fs/namei.c:4472 [inline]
 __se_sys_rmdir fs/namei.c:4470 [inline]
 __x64_sys_rmdir+0x47/0x50 fs/namei.c:4470
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb0206e3d47
Code: 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 54 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe52599f88 EFLAGS: 00000207 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb0206e3d47
RDX: 0000000000008890 RSI: 0000000000000000 RDI: 00007ffe5259b130
RBP: 0000000000000065 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000207 R12: 00007ffe5259b130
R13: 0000555592c42740 R14: 431bde82d7b634db R15: 00007ffe5259d2b0
 </TASK>


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

