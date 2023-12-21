Return-Path: <linux-fsdevel+bounces-6738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B8A81B8AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9555A1C2134B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B176DAD;
	Thu, 21 Dec 2023 13:35:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1EF7608B
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b7fe6d256eso105572539f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 05:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703165724; x=1703770524;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A9PxSjYP0rDRuNLT7k6jrNvuC4Up53pyn+x1KpRL05I=;
        b=vEX/M1ZzXDJMzdc2EQgwFJXocYooegJAdeFv27CPQpCRSOWngNKXRiQ+8NjCd5/lbH
         vh+/T82O8rTf0gGekEbvGvyjw3sOTMnMEnpU60XRF536PdM+bs3aKlMex6eLGzJH9YTx
         15TVylw0JTVs24a2uOjDMIViu6/PTuZslbcIMBh2VB2oV5/43h3CZgEe1uiQuq+hpaLa
         Zfk9tAHJPR2oqKLLGRL6JFoF6loWuHAkac/MJ3YNuEr0Ti0tdBYQrf2rDVLhz7cGZ6kb
         VMqYWRqfgkavDWoMO1Jr22n0sb43JNNmjS9p4mgrH6jq/lz4n23p0v9hrng3YnKvmDXj
         hf0w==
X-Gm-Message-State: AOJu0YzjuKLVeCSd904qOW7Pz+vwcEAM1tbNYawrqfbvkkDq0jIsbsKb
	O9VuDFXkSDLtcg4xaMWtJLwFFGvbB7Bb8enTDW8i72sEYySE
X-Google-Smtp-Source: AGHT+IFavJ1J52T+Z0uMBCNJ4lTcjFFaA8fHTXSUhb4qBTxtcKc/Z5lJg3R1mCvAOjMQZD6RKYcg+ztLVFPTTAw7kho5wZLbTHJ3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:810c:b0:46b:e82:4120 with SMTP id
 hl12-20020a056638810c00b0046b0e824120mr562614jab.5.1703165724207; Thu, 21 Dec
 2023 05:35:24 -0800 (PST)
Date: Thu, 21 Dec 2023 05:35:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc306f060d052b5f@google.com>
Subject: [syzbot] [fs?] INFO: trying to register non-static key in debugfs_file_get
From: syzbot <syzbot+fb20af23d0671a82c9a2@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b10a3ccaf6e3 Merge tag 'loongarch-fixes-6.7-2' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1278f06ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70dcde26e6b912e5
dashboard link: https://syzkaller.appspot.com/bug?extid=fb20af23d0671a82c9a2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ee4bb72d1747/disk-b10a3cca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/35219c49fd40/vmlinux-b10a3cca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d3c8dc8aa792/bzImage-b10a3cca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb20af23d0671a82c9a2@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 5078 Comm: syz-executor.0 Not tainted 6.7.0-rc4-syzkaller-00384-gb10a3ccaf6e3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 assign_lock_key+0x234/0x270 kernel/locking/lockdep.c:976
 register_lock_class+0x1cf/0x970 kernel/locking/lockdep.c:1289
 __lock_acquire+0xd9/0x1fd0 kernel/locking/lockdep.c:5014
 lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
 debugfs_file_get+0x545/0x6d0 fs/debugfs/file.c:135
 open_proxy_open+0x56/0x490 fs/debugfs/file.c:269
 do_dentry_open+0x8ff/0x1590 fs/open.c:948
 do_open fs/namei.c:3622 [inline]
 path_openat+0x2849/0x3290 fs/namei.c:3779
 do_filp_open+0x234/0x490 fs/namei.c:3809
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f8cf7a7b721
Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d ea 17 10 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
RSP: 002b:00007ffe0eccf310 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f8cf7a7b721
RDX: 0000000000000002 RSI: 00007f8cf7ac7551 RDI: 00000000ffffff9c
RBP: 00007f8cf7ac7551 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe0eccfa68
R13: 0000000000000003 R14: 00007f8cf7b9c018 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

