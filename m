Return-Path: <linux-fsdevel+bounces-38004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FB69FA4F3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2024 10:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05843164F8F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2024 09:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5241B1885BD;
	Sun, 22 Dec 2024 09:16:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD7D158DC4
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Dec 2024 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734858990; cv=none; b=XxPqZFhIw+xUaNAu28/RQpxiF/mIpkhmGDK7NCBQp0eJybgCrWABpYYWGC/3/7PaNCZ61NsqVzbOPQgKQvXxmfen4kjdSuVnEB7rK1D/zCM5FW6Oaq3PPRQE88/mYVPcYY+Vc7nLHCfawriU3RRhqKIOx3VZJ+/AqKUfZQELO64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734858990; c=relaxed/simple;
	bh=UpTgE/KHbgZypYQiTPKrOzhdoJUfOYj8WU3v0sq7dx4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XVYSF20/q0XURl34ZKBwPDZwxDC8U+vblejysVXJKQEgJLlgZFIJHCCuiB72ODxOtM+Er9180Sw1E1YlOPrrIrfbyA32OFmDmCBXzQVcVDEUo6+juk9m45ZISGmUSsGO5kb6ibKBb78FI+w1k1D9KjtfmjSkfkOYyxpyVhAiyaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-844d54c3e62so542236539f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Dec 2024 01:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734858986; x=1735463786;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJSd28AyTs65hxxmvbdunhxJVpZejSM+51vnQ3kQNRA=;
        b=gHfys1KhlkL4HutyZstXOFuXpX0rm2Jz5REUNHzJqbSfKh8Ln4VorFMV9CPWJ3bPSH
         5xCXLWMLZoX2GE02oPSqDwoE7lxywj7t/TR8cd1LTLsN2F/gwev80Ak3UvLBW5CLl2AP
         imnxhns/cXZjEAGd1Jt4ORFGxzbsG/i112W3vZjvnyAhsn8A0e4Csh/6eG1Xiva1zwAk
         r1h4UxckIXjdNFOlAaqVc1wRfruzKn2cCa6Pfdq4A2mbJs0WSTpWxKVI5iEy9P47B5xd
         BLKblXqatwDoQRbvcs0AS7rdzQvIysHXUjS7VNQyFxb1myRtHcqQQ05MKrckdI0NK8SF
         hK6g==
X-Forwarded-Encrypted: i=1; AJvYcCVGVxUasHqHh/9PA0P9wCbKvZgUrkeTjMusePxYSGb0ZfmFcWwWbPckB5sCCF0MozCU7McGqw63Eoeb2fiZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzTrX2stq7xaXjwm8H04zwZg0s+FAETcjnKiWI9oJGIw44cXcIj
	xAPJELYcxpZAL0cO054Oa8SPzHt28qC0ozCuOCF/PalPz+8o5sZrB0T30hqLhoBZVgEyfsmnam4
	10OB9qKWwcfEG1zN5nZrEJweuY3bkhA053IeS0HTF51EDn/q0k5FEJdQ=
X-Google-Smtp-Source: AGHT+IFzwFKUZneLADmaaQjQhs6PRdb9XQlvfDqaLdsck6ViA1dVne2Md7VUyYU+GbX6cmOmeO7eQvbIn3lc3JhP8iUXgQyHmknP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4a:0:b0:3a7:7d26:4ce4 with SMTP id
 e9e14a558f8ab-3c2d268133fmr86042625ab.9.1734858986094; Sun, 22 Dec 2024
 01:16:26 -0800 (PST)
Date: Sun, 22 Dec 2024 01:16:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6767d8ea.050a0220.226966.0021.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in __configfs_open_file
From: syzbot <syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com>
To: hch@lst.de, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eabcdba3ad40 Merge tag 'for-6.13-rc3-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17791f44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
dashboard link: https://syzkaller.appspot.com/bug?extid=f6e8174215573a84b797
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1449ccf8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a37730580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a9904ed2be77/disk-eabcdba3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fb8d571e1cb3/vmlinux-eabcdba3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/76349070db25/bzImage-eabcdba3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.13.0-rc3-syzkaller-00073-geabcdba3ad40 #0 Not tainted
--------------------------------------------
syz-executor381/5829 is trying to acquire lock:
ffff8880268ded78 (&p->frag_sem){.+.+}-{4:4}, at: __configfs_open_file+0xe8/0x9c0 fs/configfs/file.c:304

but task is already holding lock:
ffff8880268ded78 (&p->frag_sem){.+.+}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
ffff8880268ded78 (&p->frag_sem){.+.+}-{4:4}, at: configfs_write_iter+0x216/0x4b0 fs/configfs/file.c:229

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&p->frag_sem);
  lock(&p->frag_sem);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by syz-executor381/5829:
 #0: ffff88801e7f0420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #1: ffff888026d52688 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x75/0x4b0 fs/configfs/file.c:226
 #2: ffff8880268ded78 (&p->frag_sem){.+.+}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
 #2: ffff8880268ded78 (&p->frag_sem){.+.+}-{4:4}, at: configfs_write_iter+0x216/0x4b0 fs/configfs/file.c:229
 #3: ffffffff8ee089c8 (target_devices_lock){+.+.}-{4:4}, at: target_core_item_dbroot_store+0x23/0x2e0 drivers/target/target_core_configfs.c:114

stack backtrace:
CPU: 1 UID: 0 PID: 5829 Comm: syz-executor381 Not tainted 6.13.0-rc3-syzkaller-00073-geabcdba3ad40 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_deadlock_bug+0x2e3/0x410 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain kernel/locking/lockdep.c:3891 [inline]
 __lock_acquire+0x2117/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 down_read+0x9a/0x330 kernel/locking/rwsem.c:1524
 __configfs_open_file+0xe8/0x9c0 fs/configfs/file.c:304
 do_dentry_open+0xf59/0x1ea0 fs/open.c:945
 vfs_open+0x82/0x3f0 fs/open.c:1075
 do_open fs/namei.c:3828 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3987
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 file_open_name+0x2a4/0x450 fs/open.c:1347
 filp_open+0x4b/0x80 fs/open.c:1367
 target_core_item_dbroot_store+0x10d/0x2e0 drivers/target/target_core_configfs.c:134
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x2f6/0x4b0 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f70a1169979
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcb84c8f08 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f70a11b3300 RCX: 00007f70a1169979
RDX: 0000000000000080 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007f70a11b30fd R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 00007f70a11b817c


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

