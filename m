Return-Path: <linux-fsdevel+bounces-55891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 665E2B0F8D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 19:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F131E1CC0577
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 17:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEB2218596;
	Wed, 23 Jul 2025 17:19:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5DA1FE47B
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291171; cv=none; b=Av1TozRGDWHK3TLF7ZrD7A2VylkSmNH3BClBu+xj/4BGTKz2mHK6n6jd61dklEYy9lrpb2Cx6mMSqNwezFH9UNvMBlgiu4+zmcUNQ4UD6hYitoCznda9TsBz+rio6cgLLpSIhs2zg5jxo/EVaH3JVZB/WiRd99oVSDX9u+Pe+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291171; c=relaxed/simple;
	bh=KBC/rTGDvGK+TPIpMxOkhR4RjlAUAVRHpnVIEHGjI/Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HtL6pO6gnOig+366NoS5UdHptrIUhI+7k/xez2b0QUSUCbA/3RfkbtyaTJLouYL0Y8xjzpUg33KfeNjVhQ/WgZAUwxHRBwqFFTB5XK/Wp9lYpNE6Hx4NifF0WmvRIX9JZNiZZeZ60A13NX3iHN0sRcehIBM2/fk24LBwqk2fsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-87c1cc3c42aso12247039f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 10:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753291168; x=1753895968;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LETkx7CVH83zD4M4cUDXo3lvqXJWw4t3iCSMVC8drac=;
        b=bb/P4CWWR+fcq4kYRHSzPahBCwIPqES78LBoNPrISup/fUcfk54vXIwXPGkqOawRZ3
         lwBcPkpKmtdHHE/6eBjA05aseWh9KNPajo4zXS3lzIKzcrzoDWzIA23RLJ2ipJMbEln4
         fD8hr5wXZrBwAiEFueplktOaK6YXVjYmiSIOn6REC6wvWUzIS3dDmyUqwrCWuz2OuV4o
         3SYlAZfCbU2u+YyQvtNev0EYa9ngON/VEaVJYqicqQN+ecPaYT+J+6U/0GZDCueABOtT
         ug4Hnd5KvCVwFmlKJjp1Jh3FmKm7z0btXoZxjje+8rveeWcui4G8j0/cG2GNlmbh3d0v
         /MgA==
X-Forwarded-Encrypted: i=1; AJvYcCXu+O/ltyMpotJcf8O6EUm2tM7w+eKdI3+HtjwTVjDlgpUdcDIqQs91afnQQSfPw3TdlB0dEWll23qPd4nB@vger.kernel.org
X-Gm-Message-State: AOJu0YzeKOPAfTvT3GxgpcnCnQEZBh2W6MIxAvWtqGSeNG2TVwpgsjbc
	c5uUeGXSytEK09mhQP0xV4+TsM8BXD81cJdqda0RHE6YfBd7+G6YuIGu3exiirbThdFpeEqLfvp
	Xs2O8V5sdIRLfcJM3W3lBF20blH2HrQJEt88x7JpFp/lMCMHUrl3qiwUi23Y=
X-Google-Smtp-Source: AGHT+IF8gAJsK0U1ptptS6UBVaRziAt7UZcVX/lLpudEgilcLQ6Zr5ZDcBYL39GaXR5IdHc2wFknCXfxuWMWvD8gVRmO5tWqquWD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3421:b0:87c:4496:329d with SMTP id
 ca18e2360f4ac-87c64f64aafmr689931339f.5.1753291168476; Wed, 23 Jul 2025
 10:19:28 -0700 (PDT)
Date: Wed, 23 Jul 2025 10:19:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688119a0.050a0220.248954.0007.GAE@google.com>
Subject: [syzbot] [fs?] [wireless?] general protection fault in
 simple_recursive_removal (5)
From: syzbot <syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com>
To: dakr@kernel.org, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89be9a83ccf1 Linux 6.16-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b42fd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8adfe52da0de2761
dashboard link: https://syzkaller.appspot.com/bug?extid=d6ccd49ae046542a0641
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134baf22580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d5a4f0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-89be9a83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a3f5f507f252/vmlinux-89be9a83.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a8f9b92c57a6/bzImage-89be9a83.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com

wlan1: send auth to aa:09:b7:99:c0:d7 (try 2/3)
wlan1: send auth to aa:09:b7:99:c0:d7 (try 3/3)
wlan1: authentication with aa:09:b7:99:c0:d7 timed out
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000029: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000148-0x000000000000014f]
CPU: 0 UID: 0 PID: 171 Comm: kworker/u4:4 Not tainted 6.16.0-rc7-syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:199
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 c3 cc cc cc cc cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc90001977400 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffffff8b713286 RCX: ca5c1933e35f3700
RDX: 0000000000000000 RSI: ffffffff8b713286 RDI: 0000000000000029
RBP: ffffffff824067f0 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed10085cf24c R12: 0000000000000000
R13: 0000000000000148 R14: 0000000000000148 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88808d218000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f55ffff CR3: 000000005030a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __kasan_check_byte+0x12/0x40 mm/kasan/common.c:556
 kasan_check_byte include/linux/kasan.h:399 [inline]
 lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5845
 down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
 inode_lock include/linux/fs.h:869 [inline]
 simple_recursive_removal+0x90/0x690 fs/libfs.c:616
 debugfs_remove+0x5b/0x70 fs/debugfs/inode.c:805
 ieee80211_sta_debugfs_remove+0x40/0x70 net/mac80211/debugfs_sta.c:1279
 __sta_info_destroy_part2+0x352/0x450 net/mac80211/sta_info.c:1501
 __sta_info_destroy net/mac80211/sta_info.c:1517 [inline]
 sta_info_destroy_addr+0xf5/0x140 net/mac80211/sta_info.c:1529
 ieee80211_destroy_auth_data+0x12d/0x260 net/mac80211/mlme.c:4597
 ieee80211_sta_work+0x11cf/0x3600 net/mac80211/mlme.c:8310
 cfg80211_wiphy_work+0x2df/0x460 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:199
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 c3 cc cc cc cc cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc90001977400 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffffff8b713286 RCX: ca5c1933e35f3700
RDX: 0000000000000000 RSI: ffffffff8b713286 RDI: 0000000000000029
RBP: ffffffff824067f0 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed10085cf24c R12: 0000000000000000
R13: 0000000000000148 R14: 0000000000000148 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88808d218000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f55ffff CR3: 0000000011601000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   7:	00
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	66 0f 1f 00          	nopw   (%rax)
  1c:	48 c1 ef 03          	shr    $0x3,%rdi
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	0f b6 04 07          	movzbl (%rdi,%rax,1),%eax <-- trapping instruction
  2e:	3c 08                	cmp    $0x8,%al
  30:	0f 92 c0             	setb   %al
  33:	c3                   	ret
  34:	cc                   	int3
  35:	cc                   	int3
  36:	cc                   	int3
  37:	cc                   	int3
  38:	cc                   	int3
  39:	66                   	data16
  3a:	66                   	data16
  3b:	66                   	data16
  3c:	66                   	data16
  3d:	66                   	data16
  3e:	66                   	data16
  3f:	2e                   	cs


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

