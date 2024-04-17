Return-Path: <linux-fsdevel+bounces-17200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D83848A8AD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 20:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D93A1F219D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 18:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88619173335;
	Wed, 17 Apr 2024 18:09:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69F6172BD0
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377370; cv=none; b=p+0hSnZqRLw9B5CVPdohpW+Z+S5hC9bas4dQRmPCde5Ed+8yVYfLtjcqVxf/0NaRc35P5Lnag/4YVdW8viOXaQFRyH0UUfHE9KBUliCj8bq4DmcMTnnZX+OviyOAcCyM5c0IJzxHldqikLLN+cS802oaCL27bLZy6Dx0m417IYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377370; c=relaxed/simple;
	bh=uJZvxmFKtLbzPHlrk0I977kVT1m7O4GOnTK9btIiG0o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=im6ChH9nECiWeSgiUebwCFOlLya59x0tDTml+7Im5eRIJlkCcr9eRPpMdPaLnsCBee0YWw27PjDG4sS/vzlbo0uQN6L9O4kzxHrM3PnlD7x8YyMF5MSgcMhX4QniQTVlZ7sOwJWWsuDFkQTZiIzVxEQHDah9jEJS+k+2sTxkCi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc78077032so249739f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 11:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713377368; x=1713982168;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgoOlL2fESOvBxvRK7t4PjZmp7cUv/sb40qUsKsVrjs=;
        b=J2M6Zd5P8bqU/C6RvoQTIWsJ2kUU8u/OLgOb9n92gVm7OWqO0wiqWYyxE6Q1G048KW
         JJKlYoMtUv8iQvyoPv9FDbsdeROE7lLXjwRIWDPSTI3wDQhCadPNTO3Jr6g9MXrsXaif
         aHUtJXJNSsRILE3/6rNGEaaxs/jCiYOs9E4xZ9u7NIQtuHiuYD5N0a9XqSVvtCisYdY5
         wF0+oM0XddXQrXoD3vw4wq2aGmSfutUN3O2kVH+jmZkUHPIkw5zxGVifuf90Beo5zSge
         MWGz3XbCiRexpyzzKbflhVHsjnNS/KpfNw4qFPAnLhYgnybPiPi9qAZM7MZFo7rRo5gS
         hMMA==
X-Forwarded-Encrypted: i=1; AJvYcCXd537SHaq85egTfCzIiM7niEc9VOCZ/1OpsxrcGr+TN3GTu+iRtECG0AVN4R6QbMUM5YBQ58NE7YDfO1OYxOvtjP67ddffCahdhLdfYQ==
X-Gm-Message-State: AOJu0YxAZKcrkY6lKYsXq6E10wqCoqJUam0g4p3rHEr3cUJQw5v+U68+
	P6Nxs4I0v/bMFFdpB8/dCRFuRnpCGSB9e1j1Yy3Kip61hpBUG/6yMJGvRBe5ahlaI8qtErfJ5g3
	wlLUv9boRxe5MUw1ndi9FjAUjR2sbTeXRhbEfRFZhtdkr/dyo6SIXCCU=
X-Google-Smtp-Source: AGHT+IFJ0rbZ1nZ8kzNKwTqY8QhyPCOoX/AZHwAz/dcDC4F0HtQtGuzwLK00qAhr+xFduzLQTrRaD8T6w5qZKmBF8UPXmP7pQkFo
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13cf:b0:476:d09e:478 with SMTP id
 i15-20020a05663813cf00b00476d09e0478mr902386jaj.5.1713377367961; Wed, 17 Apr
 2024 11:09:27 -0700 (PDT)
Date: Wed, 17 Apr 2024 11:09:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006249a406164ec138@google.com>
Subject: [syzbot] [fs?] WARNING: ODEBUG bug in bdev_super_lock (2)
From: syzbot <syzbot+3acccbed6f1454bf337c@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10572a93180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=3acccbed6f1454bf337c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151a9857180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1184b7db180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz

The issue was bisected to:

commit f3a608827d1f8de0dd12813e8d9c6803fe64e119
Author: Christian Brauner <brauner@kernel.org>
Date:   Thu Feb 8 17:47:35 2024 +0000

    bdev: open block device as files

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12a83eaf180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11a83eaf180000
console output: https://syzkaller.appspot.com/x/log.txt?x=16a83eaf180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3acccbed6f1454bf337c@syzkaller.appspotmail.com
Fixes: f3a608827d1f ("bdev: open block device as files")

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: ffff88807c80a880 object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 7353 at lib/debugobjects.c:517 debug_print_object+0x17a/0x1f0 lib/debugobjects.c:514
Modules linked in:
CPU: 0 PID: 7353 Comm: syz-executor265 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:debug_print_object+0x17a/0x1f0 lib/debugobjects.c:514
Code: e8 ab 36 50 fd 4c 8b 0b 48 c7 c7 c0 08 fe 8b 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f8 ff 34 24 e8 cb 09 b3 fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 4c 82 e1 0a 48 83 c4 10 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc90009877938 EFLAGS: 00010282
RAX: 82e222ecc4018000 RBX: ffffffff8babd760 RCX: ffff88807cf28000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff8bfe0a40 R08: ffffffff8157cb22 R09: 1ffff9200130eec4
R10: dffffc0000000000 R11: fffff5200130eec5 R12: 0000000000000001
R13: ffffffff8bfe0958 R14: dffffc0000000000 R15: ffff88807c80a880
FS:  00007f71121a16c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f71121a1d58 CR3: 0000000015ac6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_object_activate+0x357/0x510 lib/debugobjects.c:732
 debug_rcu_head_queue kernel/rcu/rcu.h:227 [inline]
 __call_rcu_common kernel/rcu/tree.c:2719 [inline]
 call_rcu+0x97/0xa70 kernel/rcu/tree.c:2838
 put_super fs/super.c:424 [inline]
 bdev_super_lock+0x1ea/0x360 fs/super.c:1384
 fs_bdev_mark_dead+0x1e/0xe0 fs/super.c:1401
 bdev_mark_dead+0x89/0x1b0 block/bdev.c:1109
 disk_force_media_change+0x145/0x1c0 block/disk-events.c:298
 nbd_clear_sock_ioctl drivers/block/nbd.c:1477 [inline]
 __nbd_ioctl drivers/block/nbd.c:1504 [inline]
 nbd_ioctl+0x47d/0xf40 drivers/block/nbd.c:1564
 blkdev_ioctl+0x5e5/0x740 block/ioctl.c:640
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:890
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f711220b419
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f71121a1168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f71122923d8 RCX: 00007f711220b419
RDX: 0000000000000003 RSI: 000000000000ab04 RDI: 0000000000000004
RBP: 00007f71122923d0 R08: 00007ffc232c4387 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f71122923dc
R13: 000000000000006e R14: 00007ffc232c42a0 R15: 00007ffc232c4388
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

