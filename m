Return-Path: <linux-fsdevel+bounces-17413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FF28AD12F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 17:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D410B281E8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54500153585;
	Mon, 22 Apr 2024 15:46:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B4153561
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800787; cv=none; b=fmxwNfPuAXRkW7wcuWhLOraqbccgSNn5NTpgsjHm35OzxTzk9D805a52ZGVLsAP9k+6ItvIeaQOcHivlYdQ0r+y2FAnymG1/Pd/7AJHecYbfV1QfresQnJvNyHphcrfsR/bmZLvCzPyF9CqYX1G7OE3i8fecOn89DKgKp+XYAqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800787; c=relaxed/simple;
	bh=99jWSURdElXqjltBDycI0VysY0rM88Y/35jVpXhh56Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CL9LisjnSSYIj/LhXRZDNcJt1iCEetQHo5Zl6l42wxz1ZKDMrQhh45dH4JycElFOptHgTnP6W1boyhWUBeeW3uTJHi7EEEcM7hDskZbTMgkxdIgaHO9BZwOIInnQvEW+vbhnllVuhU+CAsR+OXfHi4DIsrf5MMX6fDIxF9LmLRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7dabcf2a2e8so145365039f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 08:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800785; x=1714405585;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HgSoz0wJSTmNhqMe2ut0HiEScT+ZiSLQfXLEB96LFJk=;
        b=AfQoyni7mZGagJKV5X0w9ISZ69PYZSCEme55OO08QbASaOsVH0GDtOwUNp52PvnAhs
         ZyG34yORQkueSfMIQR44rB1W/N/oxkYCJzFOF9KErFhppF5cVp5xkv8zatW6Wh9+qapf
         Rm2bmhx5cIshTBWgZPWmzDcusxSWHhByeEM+TNxsWIyK9wOcX5oVmUPVcPf5bvnjODqa
         tg5bjHU9jK6o26PjwCUIJ00gGRT21qEN0b7OMQY+p/6WA8RiEsRuMJduH8r4v6CSnjug
         4TT3KWal+VnRGItpsXOI2kWgzltvihm3HtBI+pV8W+3n98pp8FjofduHpGM27aPzTMy1
         DBHw==
X-Forwarded-Encrypted: i=1; AJvYcCUJinAnwPgJFtM/APUlYcUfFSJua0PzL9yBvgh3kekjBhiRRDljhO57KLi+dyh9U6S6g0blHncy0Opsar20wVFNMHit8l7dtskwuhp14g==
X-Gm-Message-State: AOJu0YyKPuQ9gkKieVkQ4aALtPBFCfK5iFGBKx6iD7YgIEiNKORNrmuW
	4j/VK+7eRaFL2H7knum7t5uJG83Mtsv7noJbQuCC70Hln1Vjdz9g5ljE7P+FKTgavUGVgK2ED79
	5H86E5lByGmOHhP7LM2iun+cE3tp9WtlC/4X7oDZsqF8z/zSFc6lkOfs=
X-Google-Smtp-Source: AGHT+IEvso29/YmG0tiGf7AAZJ58PHPb0owoJoqLxqQ2dtUfR7uhw83Q2jRn4tzrRpzK4h/BF3jLY6wbWa1fhAYLt7lrM3U0roFk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:238b:b0:485:67be:97d0 with SMTP id
 q11-20020a056638238b00b0048567be97d0mr64340jat.1.1713800785766; Mon, 22 Apr
 2024 08:46:25 -0700 (PDT)
Date: Mon, 22 Apr 2024 08:46:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d3cfa0616b1576a@google.com>
Subject: [syzbot] [fs?] WARNING in netdev_queue_update_kobjects (2)
From: syzbot <syzbot+41cf3f847df2c5f600a3@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=152c0d20980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=41cf3f847df2c5f600a3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d3d1fd180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141dd66f180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65d3f3eb786e/disk-f99c5f56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799cf7f28ff8/vmlinux-f99c5f56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab26c60c3845/bzImage-f99c5f56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41cf3f847df2c5f600a3@syzkaller.appspotmail.com

------------[ cut here ]------------
sysfs group 'byte_queue_limits' not found for kobject 'tx-0'
WARNING: CPU: 0 PID: 5073 at fs/sysfs/group.c:284 sysfs_remove_group+0x17f/0x2b0 fs/sysfs/group.c:282
Modules linked in:
CPU: 0 PID: 5073 Comm: kbnepd bnep0 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:sysfs_remove_group+0x17f/0x2b0 fs/sysfs/group.c:282
Code: 36 4c 89 e0 48 c1 e8 03 80 3c 28 00 74 08 4c 89 e7 e8 b5 f4 c2 ff 49 8b 14 24 48 c7 c7 c0 33 bb 8b 4c 89 f6 e8 b2 87 22 ff 90 <0f> 0b 90 90 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc
RSP: 0018:ffffc90003a3f8a0 EFLAGS: 00010246
RAX: 665251c6ceee3200 RBX: ffff888076fb7050 RCX: ffff88802254bc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff8157cc12 R09: 1ffff92000747e68
R10: dffffc0000000000 R11: fffff52000747e69 R12: ffff888076fb7020
R13: 1ffffffff1941fac R14: ffffffff8ca10560 R15: ffff88802d2fc740
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdbcd9e8a8 CR3: 000000002bf2a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netdev_queue_update_kobjects+0x532/0x5f0 net/core/net-sysfs.c:1852
 remove_queue_kobjects net/core/net-sysfs.c:1951 [inline]
 netdev_unregister_kobject+0x110/0x250 net/core/net-sysfs.c:2104
 unregister_netdevice_many_notify+0x11d4/0x16d0 net/core/dev.c:11129
 unregister_netdevice_many net/core/dev.c:11157 [inline]
 unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11036
 unregister_netdevice include/linux/netdevice.h:3115 [inline]
 unregister_netdev+0x1c/0x30 net/core/dev.c:11175
 bnep_session+0x2e09/0x3000 net/bluetooth/bnep/core.c:525
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
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

