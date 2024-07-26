Return-Path: <linux-fsdevel+bounces-24296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E2393CF16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 09:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16DCF1F22B4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 07:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC0E176AB9;
	Fri, 26 Jul 2024 07:54:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17E2F50A
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980464; cv=none; b=pYfG/C5SS3rfqsW8469fOpuNTMtsdROZ3To2T/N2GemFj87dpzYKj9l+fxNvi1cYhQ1rvORUUM07Fla45IwkL5N3K9eX8sMs4U/YhJH+psoMTqbvdoN0lUKogySWgGqmW8A1gnwyh2PpY2j2T13rJW6LZzYKxoz29WIyj06OrQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980464; c=relaxed/simple;
	bh=ZCM57uE+kaICz9B53NmIJzwrlcJS0QVtr24NFyAUYTg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MIlojGEbgt9F+zZDok4dIe9uVhhDEYVbOcmDKsWT9W+RhJB4ie5Y+YqIxZtmWIjYAQRNpVD1JmMu0ikyd6Nl4xChsIb0AtKGS8uIPsrOl3e4EIaDEIc64qJudZgJIWSS4ff2BtEcPPHDxF+5wTVE+oWlYN93esyR3fPwv9BdGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-804b8301480so144189439f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 00:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721980462; x=1722585262;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnDCOOC3UV8dc6a0qIuJGgDHn4oMM4I2MKMhtLQV5q8=;
        b=E9trnitdjdyfXlJWL0+1uP7/0P8jX7J15UBj0uoAoTYIU7ekjz3z/WjLvV2owKSq8X
         LP+XSj7+vBsBwssXEi1ipC5PN+GQscG0OPG5Hr+ABCvPDTuJi9kYhoc11Q2a9B0T7VYQ
         Guy1q/V/BHtGUBTM2Ebvk34uQSZ3q4WFMZqTRWq5+UpcA/A1G523atA4ARGUABcCB3PI
         Pg/qL8hv+yqsRdHTggJAXZvEp62BdluhnxXyxCKMsENfkgaYULpF4d4gaRCi2l5cTqGi
         gNCbEqQg7LdHcv+R3vWXJcHwlPuCmeKsGj845UIyNkBbxu8CHvNV9V1IEgsqnGi5eW44
         I4VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFyQJKjv83tJA76C6lE9UcHaHWDffNiBLUfRr4/8DGEyRIQMASqqztGc4rso+s+2jwELKZ+Ctr+iNJ/7HraKFKlJNMUHyvcsQjE4YbMA==
X-Gm-Message-State: AOJu0YwiX/0vt5f7sYwQMzDI0HQQBA0L19AYKawz6DarJOl9+UtTWCN6
	7Oi55Ze7KjaevRFhWHBKm5A7JKRM8gfbJDzV/AFMWVjC83CdnE+iYM+ul9rrBEQk5xzf3+5Q/oN
	pw8Ee0t2y8xpNQK1uX46ME9StXyzHB/DLPT6B+CpZOOpOx532+UqI2f0=
X-Google-Smtp-Source: AGHT+IGTiaIgqckHaA2GQY4sMfSe0y7Ns330nWXc2INezDOpG2bIu9XyNhnlvPD25B2z0rB2cIya/K7ELlJjF4im0Ag3ixXSpARU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2184:b0:39a:e800:eec9 with SMTP id
 e9e14a558f8ab-39ae8010c08mr539575ab.4.1721980461578; Fri, 26 Jul 2024
 00:54:21 -0700 (PDT)
Date: Fri, 26 Jul 2024 00:54:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b90a8e061e21d12f@google.com>
Subject: [syzbot] [f2fs?] WARNING in rcu_sync_dtor
From: syzbot <syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, jack@suse.cz, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1722389b0d86 Merge tag 'net-6.11-rc1' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14955423980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b698a1b2fcd7ef5f
dashboard link: https://syzkaller.appspot.com/bug?extid=20d7e439f76bbbd863a7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1237a1f1980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115edac9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e3f4ec8ccf7c/disk-1722389b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f19bcd908282/vmlinux-1722389b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d93604974a98/bzImage-1722389b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e0d10e1258f5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 58 at kernel/rcu/sync.c:177 rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
Modules linked in:
CPU: 1 UID: 0 PID: 58 Comm: kworker/1:2 Not tainted 6.10.0-syzkaller-12562-g1722389b0d86 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: events destroy_super_work
RIP: 0010:rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
Code: 74 19 e8 86 d5 00 00 43 0f b6 44 25 00 84 c0 0f 85 82 00 00 00 41 83 3f 00 75 1d 5b 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 90 <0f> 0b 90 e9 66 ff ff ff 90 0f 0b 90 eb 89 90 0f 0b 90 eb dd 44 89
RSP: 0018:ffffc9000133fb30 EFLAGS: 00010246
RAX: 0000000000000002 RBX: 1ffff11005324477 RCX: ffff8880163f5a00
RDX: 0000000000000000 RSI: ffffffff8c3f9540 RDI: ffff888029922350
RBP: 0000000000000167 R08: ffffffff82092061 R09: 1ffffffff1cbbbd4
R10: dffffc0000000000 R11: fffffbfff1cbbbd5 R12: dffffc0000000000
R13: 1ffff1100532446a R14: ffff888029922350 R15: ffff888029922350
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557c167738 CR3: 000000007ada8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 percpu_free_rwsem+0x41/0x80 kernel/locking/percpu-rwsem.c:42
 destroy_super_work+0xec/0x130 fs/super.c:282
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

