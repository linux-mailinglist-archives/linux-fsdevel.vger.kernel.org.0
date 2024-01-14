Return-Path: <linux-fsdevel+bounces-7913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA6682D03D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jan 2024 11:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBDD1C20F86
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jan 2024 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D5E2116;
	Sun, 14 Jan 2024 10:14:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1961FB5
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jan 2024 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36037f2de0aso69866155ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jan 2024 02:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705227256; x=1705832056;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrvREBUnMEJS2CzujDbDhJ4E9qQTed9wyaoazMHtiC0=;
        b=j8fxu71IkmiF9YBuYKGz0wj76mAog41huHMDoYgqXNIQIS/9rU0iz+ZQvZf0LSBYmq
         gmzBeZLdkQEKO71VaGTlbxJ7hivu6ZSrSqjBT2PjXOrTclgxolKPd6qdRLZ3v2gAItV9
         083yQhjk/IGL4GdyPLEqAWjV+cAS04MDPyGI9tumrE89TsCYP9IFz0CgwJvgKy/NDlgs
         WbhAjvZ9MrVH8oReN+I+kIkb5boQW2Np6rDR3+F5PIGjZBl6QBEPts11afsFf32gyLdI
         7geQTvJiQGg1XG6sGfQvljnIGan7pLUsCg8upd/gmUFsTl5mwl1K2lFBqpnbryAth5Mg
         M7Gg==
X-Gm-Message-State: AOJu0Yzk62TqTSpIS/IGUzLIO6coBPaB1CQahUvba74c1BUs2mS5Ir6U
	F5M+EgUamD6QWBZptiNwP2ha04XlpQaJdwDviW7+6ObdlWSf
X-Google-Smtp-Source: AGHT+IEgqMBYvqGrYA24w+LW96Eta29eUzTxngRiauLZkHYbupaUjAMNNmp2DbmjfBY+orf8/b96du/cdCjl19nOaL2LA2roXyq5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180d:b0:35f:9ada:73a8 with SMTP id
 a13-20020a056e02180d00b0035f9ada73a8mr551115ilv.2.1705227256582; Sun, 14 Jan
 2024 02:14:16 -0800 (PST)
Date: Sun, 14 Jan 2024 02:14:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3d83a060ee5285a@google.com>
Subject: [syzbot] [nfs?] KMSAN: kernel-infoleak in sys_name_to_handle_at (4)
From: syzbot <syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com>
To: amir73il@gmail.com, brauner@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    861deac3b092 Linux 6.7-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=155d9131e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=09b349b3066c2e0b1e96
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cefdc9e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164fe7e9e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ea60ee8ed32/disk-861deac3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d69fdc33021/vmlinux-861deac3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0158750d452/bzImage-861deac3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bb450f076a10/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com

         option from the mount to silence this warning.
=======================================================
=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x100 lib/usercopy.c:40
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _copy_to_user+0xbc/0x100 lib/usercopy.c:40
 copy_to_user include/linux/uaccess.h:191 [inline]
 do_sys_name_to_handle fs/fhandle.c:73 [inline]
 __do_sys_name_to_handle_at fs/fhandle.c:112 [inline]
 __se_sys_name_to_handle_at+0x949/0xb10 fs/fhandle.c:94
 __x64_sys_name_to_handle_at+0xe4/0x140 fs/fhandle.c:94
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x5c9/0x970 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc+0x121/0x3c0 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 do_sys_name_to_handle fs/fhandle.c:39 [inline]
 __do_sys_name_to_handle_at fs/fhandle.c:112 [inline]
 __se_sys_name_to_handle_at+0x441/0xb10 fs/fhandle.c:94
 __x64_sys_name_to_handle_at+0xe4/0x140 fs/fhandle.c:94
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Bytes 18-19 of 20 are uninitialized
Memory access of size 20 starts at ffff888128a46380
Data copied to user address 0000000020000240

CPU: 0 PID: 5006 Comm: syz-executor975 Not tainted 6.7.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


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

