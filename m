Return-Path: <linux-fsdevel+bounces-6993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6785381F6DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 11:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 114BBB22E6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 10:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA2C6ABD;
	Thu, 28 Dec 2023 10:23:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3191363CD
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7018c9476so498753239f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 02:23:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703759003; x=1704363803;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hd+YFMq5UU4QGqfb69wCvN3j30ey5zlrqHKEHPW8tDE=;
        b=BeZFb5NlnKSOAiUOVEngvkz6FB9TVCzhJH8L8x9KYNW0v4rgVSMwY7lw4BEEDNeih0
         Vjfov8kewWM0Vrl/EvG/ctrmIq7C5KJdmtGU6c1pRVV3iZcu/0Iy64ftw2xroYTkmhbH
         Sb8QL7gT8rc83O6ugWMZl9itfg2y/++qIOlbuntNbiHr1w9JR873+mZICMDKfocJ2Cxn
         2zCqLqKlfLEDQZVYf8dKW+LREp65/XCk8h5F1n1XqfCCqeOTSALXKPkKBwE3JP6Q8urA
         VNTJZ4hcSt4ngRj/R385coq7Fb20UrvXDlD2p7Z8W1/+Dd56yHKUkQ2VoJjwSNnEHVHO
         O62A==
X-Gm-Message-State: AOJu0YzOOSmIEa6Zd3gjoJnmO5/Ke+VDft/l1d+Mico2ehL6k1pKzc5T
	SQXSM83NBp5yO0t0AJYDMdeunUnDy1nEZlSOlJqLXR2UUL0K7ts=
X-Google-Smtp-Source: AGHT+IFZL3WXQVtpSwFyljomHaI30dycfxKs37yqitf9206NQdx2yMJXJXes72Euj1DoshoVlghsnRXuRrJZ825zDOu7pEGBxPYT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410b:b0:46b:4319:59cc with SMTP id
 ay11-20020a056638410b00b0046b431959ccmr668539jab.1.1703759003316; Thu, 28 Dec
 2023 02:23:23 -0800 (PST)
Date: Thu, 28 Dec 2023 02:23:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002cf943060d8f4e3c@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in __hfsplus_ext_cache_extent
From: syzbot <syzbot+55ad87f38795d6787521@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1770ee26e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=55ad87f38795d6787521
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ea9be9e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149e8179e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1520f7b6daa4/disk-fbafc3e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b490af009d5/vmlinux-fbafc3e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/202ca200f4a4/bzImage-fbafc3e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/78ed00b58340/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+55ad87f38795d6787521@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __hfsplus_ext_read_extent fs/hfsplus/extents.c:167 [inline]
BUG: KMSAN: uninit-value in __hfsplus_ext_cache_extent+0x82a/0x960 fs/hfsplus/extents.c:191
 __hfsplus_ext_read_extent fs/hfsplus/extents.c:167 [inline]
 __hfsplus_ext_cache_extent+0x82a/0x960 fs/hfsplus/extents.c:191
 hfsplus_ext_read_extent fs/hfsplus/extents.c:218 [inline]
 hfsplus_file_extend+0x775/0x1b90 fs/hfsplus/extents.c:461
 hfsplus_get_block+0xe99/0x1690 fs/hfsplus/extents.c:245
 __block_write_begin_int+0x946/0x2c70 fs/buffer.c:2119
 __block_write_begin fs/buffer.c:2168 [inline]
 block_write_begin+0x143/0x450 fs/buffer.c:2227
 cont_write_begin+0xd5c/0x12f0 fs/buffer.c:2582
 hfsplus_write_begin+0x9a/0x130 fs/hfsplus/inode.c:52
 generic_perform_write+0x3f5/0xc40 mm/filemap.c:3918
 __generic_file_write_iter+0x20a/0x460 mm/filemap.c:4013
 generic_file_write_iter+0x103/0x5b0 mm/filemap.c:4039
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x8ef/0x1490 fs/read_write.c:584
 ksys_write+0x20f/0x4c0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:646
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
 hfsplus_find_init+0x91/0x250 fs/hfsplus/bfind.c:21
 hfsplus_ext_read_extent fs/hfsplus/extents.c:216 [inline]
 hfsplus_file_extend+0x6d8/0x1b90 fs/hfsplus/extents.c:461
 hfsplus_get_block+0xe99/0x1690 fs/hfsplus/extents.c:245
 __block_write_begin_int+0x946/0x2c70 fs/buffer.c:2119
 __block_write_begin fs/buffer.c:2168 [inline]
 block_write_begin+0x143/0x450 fs/buffer.c:2227
 cont_write_begin+0xd5c/0x12f0 fs/buffer.c:2582
 hfsplus_write_begin+0x9a/0x130 fs/hfsplus/inode.c:52
 generic_perform_write+0x3f5/0xc40 mm/filemap.c:3918
 __generic_file_write_iter+0x20a/0x460 mm/filemap.c:4013
 generic_file_write_iter+0x103/0x5b0 mm/filemap.c:4039
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x8ef/0x1490 fs/read_write.c:584
 ksys_write+0x20f/0x4c0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5003 Comm: syz-executor371 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
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

