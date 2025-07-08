Return-Path: <linux-fsdevel+bounces-54290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E446EAFD5B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 19:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805B23B3369
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 17:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B2B2E6D26;
	Tue,  8 Jul 2025 17:51:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006B23398B
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997089; cv=none; b=N4DhZUI2zNTKj/dPOgMwlbDcSgKSg4nzPgg3oSgq+SjMh3uip4FMcQq0ACOqWipIebmAkYP1GPb+xci1J+ZdxNDyNosexqno5WGYN0NeR3jic+0ulk8ZVego8GrVTQ1qMknAkh70vIc7G/fiTITPcNJWY6wKQUuTzLI76nuLEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997089; c=relaxed/simple;
	bh=hdC7r70RPgDlmwm1OAeL8pZtkckZQKLu01dxUvP+TxM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qWxmOq8zP5atf40ch2NSSAhr+bw9P7YyNojMcAfLQKqjUML9NgfXnFlO8ptYo/p/4XDwhvWE9yBH9hNJX5CXY4GvwopsXLpL3eFlcRSudirYxWv4MOKJjXVofhiv1Lo6mh6P7DRjRel3kr+QvMmigz5z3NKlUlbYyEeVwdy1QkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3df40226ab7so103055115ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 10:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997087; x=1752601887;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QivMVPmeSsL39G2UjlsKNrxjQDoPllG4tQvCw+AxOuI=;
        b=OcKSFqY5+WRdMk0v6sALbLpv23FNPF9uzaEqezM2ZqdZdij+OJHzDUjHmW9OVOM3V8
         TFFtegvFcKCl9OBqQKmQonLlOH+NOuyRqLsp8JVcollZEgZ9Ypqms6vgVIWSsOyM+Meu
         y0DClA6vtQzGA2ojFryZzM/cpi3vJ6ebT9H4TAo7+DM0AlPytcFCPVijJdsoicbxiru4
         XYpSIZIuzNIXU2NCzyEzFatn4+sCELccBUcBryywRUFEKqW3fBYhX/kiudaZheLUWaOn
         j5eDDDqCu47ok0O4qP8QOL/h0GkCVLY3t/5gCQZuU12npTxvcmyUFcxdEp2/e8IspeVw
         vbqw==
X-Forwarded-Encrypted: i=1; AJvYcCUGjEOKPK7rPV6Tcf9NiOxj70C9eqaebS6NkRYJPa0+nNTUsdCjn9ULhKPLPaXeI0dKV9OlEZhIiQm/LYTL@vger.kernel.org
X-Gm-Message-State: AOJu0YzvhjS2r46XeZKUsEFYmjsvQop9n4Kl2zAmlWNL5vDehJXuwNlf
	O3sk2UbaNlnLPCSyiTwHAWEmZ2Y4uG8dzSpJ46xxBRq0O1seKT9teX6og22pfi+9Dk2nHOEAYmS
	fyG83hGD0GoH+lG31ekVCVx0VgmK2qjTLa2IHhWt6+t1/eEaKxYdNLfaN5y0=
X-Google-Smtp-Source: AGHT+IFJ0ow357/KvIuZWI/drLIBdqi1OXbTPZEnOICSZU1YqbDRm2C7oA2VPpmOTEpP98i1pp4b0VheqTAHFjQ/EeanlAObkzxr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1787:b0:3dd:be49:9278 with SMTP id
 e9e14a558f8ab-3e1636d6289mr7374895ab.0.1751997087086; Tue, 08 Jul 2025
 10:51:27 -0700 (PDT)
Date: Tue, 08 Jul 2025 10:51:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686d5a9f.050a0220.1ffab7.0015.GAE@google.com>
Subject: [syzbot] [nilfs?] kernel BUG in may_open (2)
From: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, konishi.ryusuke@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, mjguzik@gmail.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=107e728c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=72aa0474e3c3b9ac
dashboard link: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11305582580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10952bd4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/605b3edeb031/disk-d7b8f8e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a3cb6f3ea4a9/vmlinux-d7b8f8e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cd9e0c6a9926/bzImage-d7b8f8e2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2a7ab270a8da/mount_0.gz

The issue was bisected to:

commit af153bb63a336a7ca0d9c8ef4ca98119c5020030
Author: Mateusz Guzik <mjguzik@gmail.com>
Date:   Sun Feb 9 18:55:21 2025 +0000

    vfs: catch invalid modes in may_open()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f94a8c580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14054a8c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10054a8c580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com
Fixes: af153bb63a33 ("vfs: catch invalid modes in may_open()")

VFS_BUG_ON_INODE(!IS_ANON_FILE(inode)) encountered for inode ffff8880724735b8
------------[ cut here ]------------
kernel BUG at fs/namei.c:3483!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 5842 Comm: syz-executor360 Not tainted 6.16.0-rc5-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:may_open+0x4b1/0x4c0 fs/namei.c:3483
Code: 38 c1 0f 8c 1e fd ff ff 4c 89 e7 e8 69 25 ec ff e9 11 fd ff ff e8 9f cd 8a ff 4c 89 f7 48 c7 c6 40 40 99 8b e8 70 cb f2 fe 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90003f87940 EFLAGS: 00010246
RAX: 000000000000004d RBX: dffffc0000000000 RCX: 158c895b4c6f3300
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000109042 R08: ffffc90003f87667 R09: 1ffff920007f0ecc
R10: dffffc0000000000 R11: fffff520007f0ecd R12: 0000000000000000
R13: ffffffff8e29ca80 R14: ffff8880724735b8 R15: 0000000000000006
FS:  000055555ad6e380(0000) GS:ffff888125c51000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f084598dd30 CR3: 0000000073c6a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 do_open fs/namei.c:3894 [inline]
 path_openat+0x2d91/0x3830 fs/namei.c:4055
 do_filp_open+0x1fa/0x410 fs/namei.c:4082
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_open fs/open.c:1460 [inline]
 __se_sys_open fs/open.c:1456 [inline]
 __x64_sys_open+0x11e/0x150 fs/open.c:1456
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffa1ddded59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcaa4b44f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffa1ddded59
RDX: 0000000000000000 RSI: 0000000000109042 RDI: 0000200000000000
RBP: 00007ffa1de725f0 R08: 000000000001f1b6 R09: 000055555ad6f4c0
R10: 00007ffcaa4b43c0 R11: 0000000000000246 R12: 00007ffcaa4b4520
R13: 00007ffcaa4b4748 R14: 431bde82d7b634db R15: 00007ffa1de2803b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:may_open+0x4b1/0x4c0 fs/namei.c:3483
Code: 38 c1 0f 8c 1e fd ff ff 4c 89 e7 e8 69 25 ec ff e9 11 fd ff ff e8 9f cd 8a ff 4c 89 f7 48 c7 c6 40 40 99 8b e8 70 cb f2 fe 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90003f87940 EFLAGS: 00010246
RAX: 000000000000004d RBX: dffffc0000000000 RCX: 158c895b4c6f3300
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000109042 R08: ffffc90003f87667 R09: 1ffff920007f0ecc
R10: dffffc0000000000 R11: fffff520007f0ecd R12: 0000000000000000
R13: ffffffff8e29ca80 R14: ffff8880724735b8 R15: 0000000000000006
FS:  000055555ad6e380(0000) GS:ffff888125c51000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f084598dd30 CR3: 0000000073c6a000 CR4: 00000000003526f0


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

