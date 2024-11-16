Return-Path: <linux-fsdevel+bounces-35012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C12799CFD79
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 10:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34275B24442
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921B319343E;
	Sat, 16 Nov 2024 09:33:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC6C1392
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Nov 2024 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731749617; cv=none; b=cXJMIE0eSWsurOxQsacQnccp9gXf6UAU+FK9bPSVJ42AUOGb9o04TOBDOPoEbZA2ECszGJGM19w8qYZgSvQlbc4E49QX8Xanmjdqa80EEIWHv5H/04wsprpExWAGuK+5zKyHod8BbLeJ3rBiURUcGSzYY2XdyP0jO+joSRVZg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731749617; c=relaxed/simple;
	bh=3d9QK3NBavMT5R7BD/H+tQDJRXWAgbk6wcoEVgyMP+E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ucMEASDdisMaH9nZg6eYrQwpi3QRcPVZwP0r8VJxTxqrPTuYfJOlfl7r0LaeMpnxAEmMgmPf3BiL3THxcsgLaWfBC9kNPJ6tcHcSnilkoZ+T7PlziJ8tRtyvfLgI1jIWMF4k7zUM9LikDEgMB8aSJxfBpJZe9tHs5zIIvq2fSfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83ac1f28d2bso278910139f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Nov 2024 01:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731749615; x=1732354415;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZGjyFqZ15gaSUNElFDCLW+fSmoAeakbgt0BfAIds3sI=;
        b=seMecahQiCG5Id3nbPLR5EHWKZnOIi2mrE9rRoFNCy5VKqi55WHBd12VyrcAGcb31+
         mHGSSvl0A1ViYb95ogvqXpPVqKPLODO0ky0mnYgaquDC/sF2vQr3xRQDqc8MldIH+zUn
         3JEhfqaaVteUBrdk3z1E+JkpNatqkV0x0Ewz222/VITKKgnlTfXQd4gq54hO6he56yPM
         wg7dplVBboLjXaXa9TL5mv8IXtb/nCkh2fynRKMBgba6SU65+jrq/wcg5p4zoAdslAwB
         dEEJWWzyXce2Ehe4OM+TgBFs3KMY9zShj0cIsSumKSwbnHI3vQzFrpOMBX2f0Of9CB6T
         dkcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu+0YtuZbZVHZ9vl1qxcVDmPHJ7/XFNFZ/tc+R8b91GJf34HQyu4LKFuFECTbjuiYj+JfPJ3FK9Sy30/LY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+QY2WcyTUl4Z99h5AiOuPNfYayFyUMaBvI1qUR74pA/X1VAZ
	wXw/ptc1DPV6zHVsK6Y3hC93cJmNdaztx6Gfm4zB1B9sXfWL7ZCGiXsNyTIgPbgR/Axt0hPqCW0
	9DLcCe2Zdu3Q+6LtRznrv1z9LWGtQ0gjADDHyPLNRFDNioWatiUy9ijo=
X-Google-Smtp-Source: AGHT+IH7SwUqClR7Wwpy94hNZP7bmwFHpVWWQIIL/zggp668bzWTff8j2K7NUewVHM2I5DENjcyIU81P6mIZ9zJaN+sRny4125eJ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe3:b0:3a7:42f8:76c2 with SMTP id
 e9e14a558f8ab-3a74808715bmr56798905ab.15.1731749614906; Sat, 16 Nov 2024
 01:33:34 -0800 (PST)
Date: Sat, 16 Nov 2024 01:33:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673866ee.050a0220.85a0.0013.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in rcu_sync_dtor (2)
From: syzbot <syzbot+823cd0d24881f21ab9f1@syzkaller.appspotmail.com>
To: brauner@kernel.org, dongliang.cui@unisoc.com, jack@suse.cz, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, zhiguo.niu@unisoc.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2d5404caa8c7 Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f7b35f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=823cd0d24881f21ab9f1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f7b35f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12188ce8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a2d329b82126/disk-2d5404ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/37a04ca225dd/vmlinux-2d5404ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f837ce9d9dc/bzImage-2d5404ca.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/6696bb7d0ad1/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/c4373413d8ae/mount_5.gz

The issue was bisected to:

commit f761fcdd289d07e8547fef7ac76c3760fc7803f2
Author: Dongliang Cui <dongliang.cui@unisoc.com>
Date:   Tue Sep 17 22:40:05 2024 +0000

    exfat: Implement sops->shutdown and ioctl

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129df35f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=119df35f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=169df35f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+823cd0d24881f21ab9f1@syzkaller.appspotmail.com
Fixes: f761fcdd289d ("exfat: Implement sops->shutdown and ioctl")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 9 at kernel/rcu/sync.c:177 rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
Modules linked in:
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.12.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: events destroy_super_work
RIP: 0010:rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
Code: 74 19 e8 96 dd 00 00 43 0f b6 44 25 00 84 c0 0f 85 82 00 00 00 41 83 3f 00 75 1d 5b 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 90 <0f> 0b 90 e9 66 ff ff ff 90 0f 0b 90 eb 89 90 0f 0b 90 eb dd 44 89
RSP: 0018:ffffc900000e7b30 EFLAGS: 00010246

RAX: 0000000000000002 RBX: 1ffff1100fba4077 RCX: ffff88801d2b8000
RDX: 0000000000000000 RSI: ffffffff8c603640 RDI: ffff88807dd20350
RBP: 00000000000001e4 R08: ffffffff820ee1c4 R09: 1ffffffff1cfbc21
R10: dffffc0000000000 R11: fffffbfff1cfbc22 R12: dffffc0000000000
R13: 1ffff1100fba406a R14: ffff88807dd20350 R15: ffff88807dd20350
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555567cdece8 CR3: 0000000030508000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 percpu_free_rwsem+0x41/0x80 kernel/locking/percpu-rwsem.c:42
 destroy_super_work+0xef/0x130 fs/super.c:282
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
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

