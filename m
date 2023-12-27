Return-Path: <linux-fsdevel+bounces-6951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEF581EE8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 12:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 673F4B22041
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 11:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034D4446B2;
	Wed, 27 Dec 2023 11:28:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FE844392
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Dec 2023 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b7aacf63b9so335522939f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Dec 2023 03:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703676499; x=1704281299;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hCzKtjrMmSOLXgvpcbdEvWgrhNwABub7UoNADAs1TuA=;
        b=fMx82NZMa4yP+ataw3gb3/lTkgcFI2rj9EvAvpUgHLnj6CCcYmnYemlUn+Fql57BS9
         GHH59jcNjY4isanz/0512E96C5RErO/nd64NG1wIoqDElc5KaEOLizHd+ByxoaSn72dv
         BQIckgfvBCGgxuEA3krvvLsfQZ8XV9CGorJuvmJDX+fQq1+1asKQIZJP6SW/CaxTq+9z
         ZIKRyNN66HzPDzq4SH3rdZmG6SPD2lLw8IWdBioYWX9NRTCFMtB0CTmCaOHVS93uveS6
         1hlBhXYiD3MsEyrus1GhttjWtyNjOnV4KE8mI58uiaN8/RlAOEYVR3E3oxRXUhcPT574
         Ir2Q==
X-Gm-Message-State: AOJu0Yw9xPAaOTwIHXITWT3/kajH2G1SV3Huc1xFrAJXKLC5y/DG4BN+
	/EeeEzrrOkA9gQet+3pihh10CIxKdT59z8aCQX9KJMu0oLDxvoM=
X-Google-Smtp-Source: AGHT+IG8bpFNRqIOlJTpKJDJmtYBMA06NAg8eOs9JIi4IvaO3qWJGZwxljhFSX+B/ZG/7ZJrGvJgEIuvp+H8/3/ssfjHJmuLhZnE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4c:b0:360:290:902d with SMTP id
 f12-20020a056e020b4c00b003600290902dmr755473ilu.3.1703676499564; Wed, 27 Dec
 2023 03:28:19 -0800 (PST)
Date: Wed, 27 Dec 2023 03:28:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091a123060d7c18fb@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_cat_case_cmp_key
From: syzbot <syzbot+50d8672fea106e5387bb@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17192f76e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b0a595e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140e23c9e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1520f7b6daa4/disk-fbafc3e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b490af009d5/vmlinux-fbafc3e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/202ca200f4a4/bzImage-fbafc3e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0fd11f6357c0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50d8672fea106e5387bb@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
=====================================================
BUG: KMSAN: uninit-value in hfsplus_cat_case_cmp_key+0xf1/0x190 fs/hfsplus/catalog.c:23
 hfsplus_cat_case_cmp_key+0xf1/0x190 fs/hfsplus/catalog.c:23
 hfs_find_rec_by_key+0xb0/0x240 fs/hfsplus/bfind.c:100
 __hfsplus_brec_find+0x26b/0x7b0 fs/hfsplus/bfind.c:135
 hfsplus_brec_find+0x445/0x970 fs/hfsplus/bfind.c:195
 hfsplus_brec_read+0x46/0x1a0 fs/hfsplus/bfind.c:222
 hfsplus_find_cat+0xdb/0x460 fs/hfsplus/catalog.c:202
 hfsplus_iget+0x740/0xaf0 fs/hfsplus/super.c:82
 hfsplus_fill_super+0x151b/0x26f0 fs/hfsplus/super.c:503
 mount_bdev+0x3d7/0x560 fs/super.c:1650
 hfsplus_mount+0x4d/0x60 fs/hfsplus/super.c:641
 legacy_get_tree+0x110/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa5/0x520 fs/super.c:1771
 do_new_mount+0x68d/0x1550 fs/namespace.c:3337
 path_mount+0x73d/0x1f20 fs/namespace.c:3664
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3863
 __x64_sys_mount+0xe4/0x140 fs/namespace.c:3863
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
 hfsplus_iget+0x3e1/0xaf0 fs/hfsplus/super.c:80
 hfsplus_fill_super+0x151b/0x26f0 fs/hfsplus/super.c:503
 mount_bdev+0x3d7/0x560 fs/super.c:1650
 hfsplus_mount+0x4d/0x60 fs/hfsplus/super.c:641
 legacy_get_tree+0x110/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa5/0x520 fs/super.c:1771
 do_new_mount+0x68d/0x1550 fs/namespace.c:3337
 path_mount+0x73d/0x1f20 fs/namespace.c:3664
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3863
 __x64_sys_mount+0xe4/0x140 fs/namespace.c:3863
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 4989 Comm: syz-executor165 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
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

