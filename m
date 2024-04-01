Return-Path: <linux-fsdevel+bounces-15826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994E8893BBE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 16:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C78F1C20AE8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 14:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FAF40BFD;
	Mon,  1 Apr 2024 14:07:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725D17580
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980448; cv=none; b=orvG/zMNgzSEWHquIIVGgQg+OSF/dZ98D9pA75L2oXC0NApxJ9vew/ZYaAxFeofqpt0ozVkeZcztPSeb6Mm2kQXoQrPXerprvzTp1bBsvZKRSg6S3E8uyCBjApxohfPWP9Bp74ZXHAdcjnukkrrS6cw3HMStJiO9OPaZbJa6pDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980448; c=relaxed/simple;
	bh=SPtxXi5PvRjsqoDPT9n1bJFZlmK8nVXtA21jNRCVXyw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h7Ew+yvwGbkqc70mKdmEbVRCAq9z0+QDQR4knQ2+1ypclDPBl+Yu+iUZLFN0XBtfWzixuoEshZM4QGwTf4TQmMWdg5UMdcIjOqS3+9hPYxAbqcq4irJD2cOBBTvBX+LXGavsBtv9OjFfpWK9vZDEt9jpfzrHJVnkBmLAETFuXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbf092a502so430664439f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Apr 2024 07:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711980445; x=1712585245;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YpErK9qu/PGde2topRn8Sa+4f9zoUj4OqVEyctoEVTw=;
        b=CqA4FDklFNxsJUqRG6w4csukSdxKe/6rXaqFzqQn80OtPi7YIrnlG7zYL+nR1oTTqR
         AyvNsCNt8yCyZXHLTtbCbO6wCnzv3THq6AMqgjmJUdKeSl/bE6a7i1XqMn8/9sQxEFyk
         EeoXn2+xKVVci1dRE5n67IqzjHiUnvwXefFF8B+87+jRcoqBq6Q9OL4PdZHypsZaQ7TB
         sWJwBH/Gmzcc/yQAs72vOe8MEiZWTxElEntWJtNMaabmqSi9GhkEZ1AzJSk++5MV4dKg
         OMvKo3H4rBOSbzT4tqmG+JEiPSs2qNODy3OcykSsYJWehCePz8VXqAEee3mnJW8uVgrT
         jCfg==
X-Forwarded-Encrypted: i=1; AJvYcCVku/zWXFzMeDsy1oXZOqEW/7enFocH0lHwi3zTIGLuIooPwd7aDayV13b3VjudKhGOYy9imEBT8tHZg/JvCeXw07qtPMlH3G3rqtSWCA==
X-Gm-Message-State: AOJu0Yzbsyod+WEpwgJPg1TV2jLy3dlzgpQ8pGoUhY8dKIHJ4/TPZYKq
	er68+FFrcHbSz27WSH582o7B+O5nDS72gbJ9VW2rFD4YoLaYeVkhLGfRswfeX+6mBHBqdDiPg7b
	PNQvoqgZNcjIWfn0s3/AOKfORBSLjnJC4aJ/X4XMAn94ZmwCkLL0W3WY=
X-Google-Smtp-Source: AGHT+IF3/sFIb0CAoEg9PV13WObAPYgrnxhGisLBb2Iw7Ia2ohijMls29S/WYYpz18hhx+m+vvgnktUoDi10I4OnzaGoOq07x6+i
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4b:b0:369:98a3:6f7b with SMTP id
 u11-20020a056e021a4b00b0036998a36f7bmr437628ilv.4.1711980445526; Mon, 01 Apr
 2024 07:07:25 -0700 (PDT)
Date: Mon, 01 Apr 2024 07:07:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000518bc10615098296@google.com>
Subject: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in jfs_readdir
From: syzbot <syzbot+0315f8fe99120601ba88@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1723f529180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=0315f8fe99120601ba88
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1574d855180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d95219180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fe45a050e301/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f6203d180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11f6203d180000
console output: https://syzkaller.appspot.com/x/log.txt?x=16f6203d180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0315f8fe99120601ba88@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dtree.c:2892:30
index -1 is out of range for type 'struct dtslot[128]'
CPU: 0 PID: 5057 Comm: syz-executor163 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:415
 jfs_readdir+0x1cb4/0x4660 fs/jfs/jfs_dtree.c:2892
 wrap_directory_iterator+0x94/0xe0 fs/readdir.c:67
 iterate_dir+0x539/0x6f0 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:409 [inline]
 __se_sys_getdents64+0x20d/0x4f0 fs/readdir.c:394
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f00e0f665f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffdc32b878 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007fffdc32ba48 RCX: 00007f00e0f665f9
RDX: 000000000000102a RSI: 0000000020002280 RDI: 0000000000000004
RBP: 00007f00e0fdf610 R08: 0000000000000000 R09: 00007fffdc32ba48
R10: 00000000000060cc R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffdc32ba38 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
---[ end trace ]---


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

