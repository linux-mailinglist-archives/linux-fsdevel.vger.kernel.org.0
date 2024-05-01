Return-Path: <linux-fsdevel+bounces-18416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30958B86F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 10:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB9D1F23630
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 08:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16DE50283;
	Wed,  1 May 2024 08:36:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153321E4A1
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 May 2024 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714552586; cv=none; b=b9tqwhrL76fGBSLHv6KdhFW0FoZv9JA3/zwIff9NZc/XwG6oO7MamLoXNG6bPxtEFOcVPe8sOW7Cgu2V+rgLN7U2TNm82Ob3qdgX5PT4hKJL5B9NmZ7v3xAlxne5YYM3j3IfzROugsUFLuf9A7aW2s17VVPa/v13mWaBPWT/MUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714552586; c=relaxed/simple;
	bh=5vwp6LeS+InKkVJmVbD48z6EEpNvk7Na4UovYorBhwk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LhdTfDFLJDegxONrD1npd3diz5JaVIwJcAhTkrcHxqTXDrHGqnWr4EdJxw1It9iuOqDTu8j6ZNPawX6YBT5M0loZk9zkg8nWeUeJKJRvhL2owbS6esBK40V5Zxhv+4Fbe/9eBXjp3Lgvm2Ncl7+ZoIdGGPd/lK/vGd2ShA4RDIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ded1e919d2so49755139f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2024 01:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714552584; x=1715157384;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDQZsNtCQX/xSGP3zHzoLW1EYofYgs37kJqsg6TLsKw=;
        b=LN5nlxFpNrogjGdSxvYl3Zlv29Ot8iKMMmamAOHnKTugn0zoPWZzQbHqatfxZDBJdS
         c6lcJuX4bq6hSHp3s8Smb7nz+0W5I+C1CaY84Y+STSx7wTgZ+unT+CbD3BxKT78JxDcc
         8gKNdr9+1BXZ3VW6soR78IYV2/GTNmoNLW3PR8WpE40p4RvyyVLyEOpPFmO/z1euE4LE
         DtTYRDvBE8c6/PLZZRi7D6061yy/Mkw/BWU3Y2WoaV4QnpGB1uPTGr8RKMkHD1UO2GyO
         HicGvbXH0qN1FLQSk1Tsr6UpuL5KTtpySD9DK6aE2KLqEemr5jt4quH7QHHXCpjWycIS
         utrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhk4DennzkZ/3kXBZzRgCJw+uSoiH86yMDiZctBeHmtjbtBpE578Hb1PPU8Fzy6kMZoNhAOfCo/jmn9Xz0N6B8LZ2CSliHoSb/Vny+6w==
X-Gm-Message-State: AOJu0YzZRcdk0jc4wbUHqpJzQXVsuIcoXXXytMSiceDvKrqrW93OKzna
	KJo8NRRAeyeQCKtJPRLTgSPvqrR0QjuDDWKqKtL82sDjDuUouTC8nlEe/hbm1Jl777FCHHQq86T
	XCZMP33D4DCUmQTjzM6VNPSdleNYQxi2hiIU9j12EZRtFCtf9W/kQO48=
X-Google-Smtp-Source: AGHT+IFPEC9Ed6WfkUJm19XUVcN8J027PA+t7900I9LXMY7L6F3jetTdwDxo5pRaQiQceTAHsq5jy4qbU2GYZ5fpLSqf/1QQlTei
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d8a:b0:7de:da38:b7df with SMTP id
 k10-20020a0566022d8a00b007deda38b7dfmr67096iow.0.1714552584287; Wed, 01 May
 2024 01:36:24 -0700 (PDT)
Date: Wed, 01 May 2024 01:36:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc46690617606123@google.com>
Subject: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtReadFirst
From: syzbot <syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5eb4573ea63d Merge tag 'soc-fixes-6.9-2' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10d00af8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d46aa9d7a44f40d
dashboard link: https://syzkaller.appspot.com/bug?extid=65fa06e29859e41a83f3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103728a7180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b3c937180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7e4c1378cbb1/disk-5eb4573e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8e4487ecdd86/vmlinux-5eb4573e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d84518ee028f/bzImage-5eb4573e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8d252f0d561d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dtree.c:3087:20
index -1 is out of range for type 'struct dtslot[128]'
CPU: 0 PID: 5074 Comm: syz-executor356 Not tainted 6.9.0-rc5-syzkaller-00296-g5eb4573ea63d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 dtReadFirst+0x612/0xbe0 fs/jfs/jfs_dtree.c:3087
 jfs_readdir+0x81a/0x4660 fs/jfs/jfs_dtree.c:2818
 wrap_directory_iterator+0x94/0xe0 fs/readdir.c:67
 iterate_dir+0x539/0x6f0 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:409 [inline]
 __se_sys_getdents64+0x20d/0x4f0 fs/readdir.c:394
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3471781639
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcff008118 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007ffcff0082e8 RCX: 00007f3471781639
RDX: 0000000000001000 RSI: 0000000020002ec0 RDI: 0000000000000005
RBP: 00007f34717fa610 R08: 0000000000000000 R09: 00007ffcff0082e8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffcff0082d8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
---[ end trace ]---


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

