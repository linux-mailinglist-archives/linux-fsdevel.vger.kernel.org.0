Return-Path: <linux-fsdevel+bounces-34382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0248C9C4DB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 05:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53820B26A91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 04:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970B120820C;
	Tue, 12 Nov 2024 04:21:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9861A19F121
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 04:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731385290; cv=none; b=GcjiN6smlgrLcxiuTNrJefp/VuXuHKZVg+HYqdF9DaS7YcrkapcwFTg6lWyDAvO/jh6FErvU/XAmcHGVia2sgery/IElMeMfmf02pvjpyY+9g18SB7TGnTajUVPMEzBD4ixl+WWKBGipVIcAxR2MwsRptPVpzinvr14yYx/xCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731385290; c=relaxed/simple;
	bh=HNbDsgqENdOQrVPt533HjPfzASAX8obuI5/7h++d1I8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zdu9fRFUtpRSPUR8YX7LXBUG4hMoR9mvkYa41Q5GAnnca0AGZfiFzy8q2p5iNafdcfDLTUFMRFVPauNK/Onp7PapxrbZhGn7XrPB0flR+1ELCAgpv1UzUbUfolrj2YraKlaNBFAJqWAnKZ3tLI75FZtLy0SH/V2zkkB5Q57WhEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83abf723da3so553585139f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 20:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731385287; x=1731990087;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5PkOGvZritsIqLj7hzj3hQr0S/+IrIP0QsogAUMrSo=;
        b=PZG7TmMG3cxuIjrEw5jEkktGWhFqYlJVBeDayLClMkH9hbrmsRzj9d6Mg9ujWxg5GH
         3bbfIWjvD6nx2DshcHxyrqmZTp1+icnxrz318iR/IB78sqDVbYZSxqditMnqrunN0I83
         dmUywJ+4bLUFzvuLt1UwbvxwHuNYyYRtp/K8cUTkheZ8sY7TItVHNt9+zzil76QNLEka
         XRfZcipiCV+NL0Q5Wvxo+U8KNIACix9R5mmWJ0xGfDq9ZT4jxnaTftGWYCEQb2EXcidM
         1Q1BURsL/0J5F/xXUWuYW77ALUqKnMWcwSia1uvW5AuYwMcXKnuhXfohDPKifQTO0/K1
         eJNA==
X-Forwarded-Encrypted: i=1; AJvYcCWulf6lmJBA9hzQeokdKr08mIOGuflvWpMvXfMBYJ8i8J3ommtKZg5TBBepzksTwyiPlgXyRC92Fm81H0/r@vger.kernel.org
X-Gm-Message-State: AOJu0YwidBcylBoXFuPhQS1L+Z2wJmruq9jpDQFmyTY4qR76WhX9sMQm
	1cKDkqMJGFTTC+71/Ex6tSL4ZTfSz25u+oBgn4oMbu4MJXokEOBRfwG8w+a4YI2u1vFHXM+ZCN9
	vA4PaYrbZjaYwlaQl3LaU2s26Gmz85j6M78sE8o3DqcRoKKLZxF72nTg=
X-Google-Smtp-Source: AGHT+IHSP1FrcjbG9f+53arRrHzxZv/H8j5jQStzUDoqOK5ddPbgmU+15mTB2bKEbS843pdTOPiO82Iel+OiDYxKVfG1y9ELAbJS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:3a4:e9b3:2293 with SMTP id
 e9e14a558f8ab-3a6f19090aamr166636405ab.0.1731385287646; Mon, 11 Nov 2024
 20:21:27 -0800 (PST)
Date: Mon, 11 Nov 2024 20:21:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6732d7c7.050a0220.5088e.0004.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in fanotify_handle_event (2)
From: syzbot <syzbot+318aab2cf26bb7d40228@syzkaller.appspotmail.com>
To: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, repnop@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    906bd684e4b1 Merge tag 'spi-fix-v6.12-rc6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=177d4ea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64aa0d9945bd5c1
dashboard link: https://syzkaller.appspot.com/bug?extid=318aab2cf26bb7d40228
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1168dd87980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fd4ea7980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-906bd684.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88c5c4ba7e33/vmlinux-906bd684.xz
kernel image: https://storage.googleapis.com/syzbot-assets/07094e69f47b/bzImage-906bd684.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/643aa6b4830a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+318aab2cf26bb7d40228@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 128
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5308 at fs/notify/fanotify/fanotify.h:216 fanotify_info_copy_name fs/notify/fanotify/fanotify.h:216 [inline]
WARNING: CPU: 0 PID: 5308 at fs/notify/fanotify/fanotify.h:216 fanotify_alloc_name_event fs/notify/fanotify/fanotify.c:646 [inline]
WARNING: CPU: 0 PID: 5308 at fs/notify/fanotify/fanotify.h:216 fanotify_alloc_event fs/notify/fanotify/fanotify.c:810 [inline]
WARNING: CPU: 0 PID: 5308 at fs/notify/fanotify/fanotify.h:216 fanotify_handle_event+0x2eba/0x3c50 fs/notify/fanotify/fanotify.c:936
Modules linked in:
CPU: 0 UID: 0 PID: 5308 Comm: syz-executor207 Not tainted 6.12.0-rc6-syzkaller-00169-g906bd684e4b1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:fanotify_info_copy_name fs/notify/fanotify/fanotify.h:216 [inline]
RIP: 0010:fanotify_alloc_name_event fs/notify/fanotify/fanotify.c:646 [inline]
RIP: 0010:fanotify_alloc_event fs/notify/fanotify/fanotify.c:810 [inline]
RIP: 0010:fanotify_handle_event+0x2eba/0x3c50 fs/notify/fanotify/fanotify.c:936
Code: f6 ff ff e8 58 a4 6e ff 90 0f 0b 90 e9 c0 f7 ff ff e8 4a a4 6e ff 90 0f 0b 90 4c 8b 6c 24 10 e9 e7 f8 ff ff e8 37 a4 6e ff 90 <0f> 0b 90 4c 8b 6c 24 10 e9 04 fb ff ff e8 24 a4 6e ff 90 0f 0b 90
RSP: 0018:ffffc9000d0473e0 EFLAGS: 00010293
RAX: ffffffff82263629 RBX: ffffc9000d047844 RCX: ffff888000848000
RDX: 0000000000000000 RSI: 0000000000000ffd RDI: 00000000000000ff
RBP: ffffc9000d0475e0 R08: ffffffff82262f60 R09: 0000000000000000
R10: ffff888043bd8038 R11: ffffffff821d7890 R12: ffff888043bd8000
R13: 0000000000000ffd R14: ffff888043bd8000 R15: dffffc0000000000
FS:  0000555581eb6380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020004000 CR3: 000000003600e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 send_to_group fs/notify/fsnotify.c:394 [inline]
 fsnotify+0x1657/0x1f60 fs/notify/fsnotify.c:607
 __fsnotify_parent+0x4f5/0x5e0 fs/notify/fsnotify.c:264
 fsnotify_parent include/linux/fsnotify.h:96 [inline]
 fsnotify_file include/linux/fsnotify.h:131 [inline]
 fsnotify_open include/linux/fsnotify.h:401 [inline]
 vfs_open+0x28d/0x330 fs/open.c:1095
 do_open fs/namei.c:3774 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_creat fs/open.c:1508 [inline]
 __se_sys_creat fs/open.c:1502 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1502
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fde2034f6b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3d0c3658 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fff3d0c3828 RCX: 00007fde2034f6b9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020003500
RBP: 00007fde203c3610 R08: 00007fff3d0c3828 R09: 00007fff3d0c3828
R10: 00007fff3d0c3828 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff3d0c3818 R14: 0000000000000001 R15: 0000000000000001
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

