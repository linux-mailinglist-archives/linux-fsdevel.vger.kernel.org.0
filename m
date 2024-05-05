Return-Path: <linux-fsdevel+bounces-18762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2488BC284
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 18:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92643281847
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77DE3C466;
	Sun,  5 May 2024 16:25:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10365E54C
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714926337; cv=none; b=AutzX+zURNBrNCGqcntXqrCs5741M33UrMUPNa4uFyWWAXW7wUgHgav1p8ZlrblsQ5sB3LQAEk2VMq0o+0rBHcGdIAwSJhu17qIKnGWlAn4qDeHPPwwgSoeJymTKXJ7AMeSj/s+dKUuoI4QHkB4TG+5BDCoZLV5hMBA4aBe8zgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714926337; c=relaxed/simple;
	bh=WafGB8mtAUf+2X8KBmIjuQa4mX+SeYOhgrxiWof2nBM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aUP11vOW7Zw1XAHKK4TWepYryZVCTFdsL5f0/4fw6/XavtkkcL+AnUodmPRTC3H8kToqtpNr4l+XgE8vSGTsXi5GrGYQeIg/t9DqWPpmYAk9pKvoj2avWtBN8JnH9dbNSCP7Qm7VzlPlNwxk8bFeRwO50DV1hd8kbM88znIDYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7dece1fa472so124585539f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 09:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714926335; x=1715531135;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6aMqOmVbrVudevc56fwdC/dJHHqlQVWzywznXvcv84=;
        b=QnR2K40SXJ+9M44XXgdJVgK+uF0KNjfYPe4kTH5cdgQtLqzST0Kqwflt8sZ5vfDv+p
         Fj9qskq9QPxX6jsUzuK8JQLrdIkalQisNJTwNCVRVXYjLa54Df/zM0SmXTmcWMbSPWOh
         tBdDQmxt/PeHjfN6zDzC5LSya9T3Qki2COPJSdAOnzdDqoznapJVZ7DzHDalsx2QjjL/
         XqSNctM/ZmX23KFY9EellJls6MivjMHIRrA8TLPsGnGKyFc/UcIfKs7f3FwomA8Ccjwv
         6KYR9eyQbls2kK1b2AyhIK/hsKLwOzjQx29eRHwUpKDmRxpN7nVzqP3weUkxvS/cE004
         dKtg==
X-Forwarded-Encrypted: i=1; AJvYcCWeaxLP1rM/M3gqly7ZxPRvwrkY9m07JYAUSw6R2mJ7NFY9LelOdrdQwt5Kr+CPhb7fEKjTj9tOabg6ADLRUYFIpIbfhwZhKTf1ZdJsXA==
X-Gm-Message-State: AOJu0Yw9D+JI4na++NArlvxVALgcwO+PPRFzFGlTGwF0fPnsBEBwCk+R
	LbqSMm67JwEpq4KUGQHlpwMIKY3OOEn+bdqii5l/PfsfivcBjTTUwcRztdZm4UXWTyllCzA6VU+
	i1V/26D6Q9hy1BzzOhuFAPJ9vHWiq1ffIH5E3G4GzwKAzuVNt358eTRA=
X-Google-Smtp-Source: AGHT+IE0SEjwGli+eIPkr3STT2M1V1BaU+RlMwBZA0FgwEZac8R+O6+hyeirl9FzoZWVfDfrOwOC9TPJPBRm3psWHI+MM+xEdiVu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8716:b0:488:7f72:b3b0 with SMTP id
 iw22-20020a056638871600b004887f72b3b0mr114504jab.5.1714926335279; Sun, 05 May
 2024 09:25:35 -0700 (PDT)
Date: Sun, 05 May 2024 09:25:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007d2e50617b767a3@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_alloc_v4_invalid
From: syzbot <syzbot+10827fa6b176e1acf1d0@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9221b2819b8a Add linux-next specific files for 20240503
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13187c70980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ab537f51a6a0d98
dashboard link: https://syzkaller.appspot.com/bug?extid=10827fa6b176e1acf1d0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1250b9ff180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117ea590980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e67dbdc3c37/disk-9221b281.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ade618fa19f8/vmlinux-9221b281.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df12e5073c97/bzImage-9221b281.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/54baa53b5879/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10827fa6b176e1acf1d0@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
bcachefs (loop0): mounting version 1.7: mi_btree_bitmap opts=metadata_checksum=none,data_checksum=xxhash,str_hash=crc32c,nojournal_transaction_names
bcachefs (loop0): recovering from clean shutdown, journal seq 10
------------[ cut here ]------------
kernel BUG at fs/bcachefs/alloc_background.h:166!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 5088 Comm: syz-executor107 Not tainted 6.9.0-rc6-next-20240503-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:alloc_v4_u64s fs/bcachefs/alloc_background.h:166 [inline]
RIP: 0010:bch2_alloc_v4_invalid+0x9af/0x9c0 fs/bcachefs/alloc_background.c:247
Code: 47 cf f6 fd e9 d7 fb ff ff 44 89 e9 80 e1 07 38 c1 0f 8c 23 fc ff ff 4c 89 ef e8 cc ce f6 fd e9 16 fc ff ff e8 62 20 91 fd 90 <0f> 0b e8 5a 20 91 fd 90 0f 0b 0f 1f 80 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc900035be618 EFLAGS: 00010293
RAX: ffffffff8404f57e RBX: 00000000000000fd RCX: ffff88807c78bc00
RDX: 0000000000000000 RSI: 00000000000000fd RDI: 00000000000000fa
RBP: 000000000000002d R08: ffffffff8404eca5 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8404ebd0 R12: 000000005770f4b6
R13: ffffc900035beaa0 R14: ffff8880778c06e8 R15: 1ffff920006b7d45
FS:  000055559514f380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd24b68da8 CR3: 000000002de70000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_btree_node_read_done+0x3e7d/0x5ed0 fs/bcachefs/btree_io.c:1234
 btree_node_read_work+0x665/0x1300 fs/bcachefs/btree_io.c:1345
 bch2_btree_node_read+0x2637/0x2c80 fs/bcachefs/btree_io.c:1730
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1769 [inline]
 bch2_btree_root_read+0x61e/0x970 fs/bcachefs/btree_io.c:1793
 read_btree_roots+0x22d/0x7b0 fs/bcachefs/recovery.c:472
 bch2_fs_recovery+0x2334/0x36e0 fs/bcachefs/recovery.c:800
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1030
 bch2_fs_open+0xa8d/0xdf0 fs/bcachefs/super.c:2105
 bch2_mount+0x71d/0x1320 fs/bcachefs/fs.c:1917
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff34d527a3a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd7ed56fe8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd7ed57000 RCX: 00007ff34d527a3a
RDX: 0000000020011a00 RSI: 0000000020011a40 RDI: 00007ffd7ed57000
RBP: 0000000000000004 R08: 00007ffd7ed57040 R09: 00000000000119ee
R10: 0000000000200014 R11: 0000000000000282 R12: 0000000000200014
R13: 00007ffd7ed57040 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:alloc_v4_u64s fs/bcachefs/alloc_background.h:166 [inline]
RIP: 0010:bch2_alloc_v4_invalid+0x9af/0x9c0 fs/bcachefs/alloc_background.c:247
Code: 47 cf f6 fd e9 d7 fb ff ff 44 89 e9 80 e1 07 38 c1 0f 8c 23 fc ff ff 4c 89 ef e8 cc ce f6 fd e9 16 fc ff ff e8 62 20 91 fd 90 <0f> 0b e8 5a 20 91 fd 90 0f 0b 0f 1f 80 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc900035be618 EFLAGS: 00010293
RAX: ffffffff8404f57e RBX: 00000000000000fd RCX: ffff88807c78bc00
RDX: 0000000000000000 RSI: 00000000000000fd RDI: 00000000000000fa
RBP: 000000000000002d R08: ffffffff8404eca5 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8404ebd0 R12: 000000005770f4b6
R13: ffffc900035beaa0 R14: ffff8880778c06e8 R15: 1ffff920006b7d45
FS:  000055559514f380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd24b68da8 CR3: 000000002de70000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

