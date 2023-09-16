Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A97A2E45
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 08:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238798AbjIPGwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Sep 2023 02:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbjIPGwB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Sep 2023 02:52:01 -0400
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE811BC7
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 23:51:55 -0700 (PDT)
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-57352a27980so4027972eaf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 23:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694847114; x=1695451914;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJGvlfgw7TNHd0h3ACkY6TxHvXPd27j4aXkbbUSsrkQ=;
        b=bk+sAUkbIpCCv4Cy6/T7CxDCBTQhlMPTqCDNKsv6qDX8Enn/wTdVi9jPfGR2qv/sUv
         IBz8u7tnL97NQxiF0laImP6nU8NEEegRF0w3luTGmFuShtiClAYJOa0rC/3GFfddzFQC
         HhO7NStdjTIhQdgRmG+dKHEhSaocXWXUltFV/jN6jK6cUWx8iSu9UeYWgoiI0fRk7Vu9
         Vfxg5EReM8wzxsyLr+qOkSg5pk73GJx67fJrcYmDVT8/kN6YujTCZ7P8FJxJnQAsU4pT
         +BTeCXCa6WQOC1dc0OuBetjuRplIYTvHGC4XZcj8utRNjCh8volHbo9rnOI2KswCoeuQ
         oHqw==
X-Gm-Message-State: AOJu0YwfuaA6PkeaI9a2P/dQB25IgtjF0ZzOWMw6xcF+R22a6uc9pcuP
        rGgnrrg0XaCf0Wx+ViIGg81wgF6/fF+VHVJhHDGKdAs/XHd8
X-Google-Smtp-Source: AGHT+IEw9yD3FZr20zageWerz5sOz/v4+MPuxems2c8WQJNxUEJVjeGGdd3RUPCsYN3plpJPkewbzVROeMJSAz4SoMZmuuewcCJO
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2006:b0:3ac:ab4f:ee6 with SMTP id
 q6-20020a056808200600b003acab4f0ee6mr1508692oiw.1.1694847114399; Fri, 15 Sep
 2023 23:51:54 -0700 (PDT)
Date:   Fri, 15 Sep 2023 23:51:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033d44706057458b3@google.com>
Subject: [syzbot] [ext4?] WARNING in setattr_copy
From:   syzbot <syzbot+450a6d7e0a2db0d8326a@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, brauner@kernel.org, jlayton@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3c13c772fc23 Add linux-next specific files for 20230912
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15b02b0c680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7149cbda1664bc5
dashboard link: https://syzkaller.appspot.com/bug?extid=450a6d7e0a2db0d8326a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155b32b4680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cf6028680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb6fbc71f83a/disk-3c13c772.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d671ade67d9/vmlinux-3c13c772.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b2b7190a3a61/bzImage-3c13c772.xz

The issue was bisected to:

commit d6f106662147d78e9a439608e8deac7d046ca0fa
Author: Jeff Layton <jlayton@kernel.org>
Date:   Wed Aug 30 18:28:43 2023 +0000

    fs: have setattr_copy handle multigrain timestamps appropriately

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1419f8d8680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1619f8d8680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1219f8d8680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+450a6d7e0a2db0d8326a@syzkaller.appspotmail.com
Fixes: d6f106662147 ("fs: have setattr_copy handle multigrain timestamps appropriately")

overlayfs: fs on './file0' does not support file handles, falling back to index=off,nfs_export=off.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5042 at fs/attr.c:298 setattr_copy_mgtime fs/attr.c:298 [inline]
WARNING: CPU: 0 PID: 5042 at fs/attr.c:298 setattr_copy+0x84c/0x950 fs/attr.c:355
Modules linked in:
CPU: 0 PID: 5042 Comm: syz-executor172 Not tainted 6.6.0-rc1-next-20230912-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:setattr_copy_mgtime fs/attr.c:298 [inline]
RIP: 0010:setattr_copy+0x84c/0x950 fs/attr.c:355
Code: 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 66 83 3c 02 00 0f 85 ff 00 00 00 4c 89 73 68 4c 89 7b 70 e9 9d fd ff ff e8 74 a8 92 ff <0f> 0b e9 91 fd ff ff 4c 89 ff e8 b5 93 e8 ff e9 69 f8 ff ff e8 ab
RSP: 0018:ffffc900038cf268 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888076c766b0 RCX: 0000000000000000
RDX: ffff88807926d940 RSI: ffffffff81f54afc RDI: 0000000000000005
RBP: ffffc900038cf2a0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000030 R11: ffffffff81ddb7d3 R12: ffffc900038cf420
R13: 0000000000000030 R14: 0000000000000000 R15: ffff888076c766d8
FS:  00005555574de380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 000000001fdba000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_setattr+0x36f/0x2990 fs/ext4/inode.c:5479
 notify_change+0x742/0x11c0 fs/attr.c:539
 ovl_do_notify_change fs/overlayfs/overlayfs.h:188 [inline]
 ovl_set_timestamps.isra.0+0x168/0x1e0 fs/overlayfs/copy_up.c:345
 ovl_set_attr.part.0+0x1c8/0x210 fs/overlayfs/copy_up.c:369
 ovl_set_attr+0x1c9/0x200 fs/overlayfs/copy_up.c:372
 ovl_copy_up_metadata+0x471/0x6c0 fs/overlayfs/copy_up.c:668
 ovl_copy_up_workdir fs/overlayfs/copy_up.c:747 [inline]
 ovl_do_copy_up fs/overlayfs/copy_up.c:905 [inline]
 ovl_copy_up_one+0xb10/0x2f10 fs/overlayfs/copy_up.c:1091
 ovl_copy_up_flags+0x189/0x200 fs/overlayfs/copy_up.c:1146
 ovl_setattr+0x109/0x520 fs/overlayfs/inode.c:45
 notify_change+0x742/0x11c0 fs/attr.c:539
 chown_common+0x596/0x660 fs/open.c:783
 do_fchownat+0x140/0x1f0 fs/open.c:814
 __do_sys_lchown fs/open.c:839 [inline]
 __se_sys_lchown fs/open.c:837 [inline]
 __x64_sys_lchown+0x7e/0xc0 fs/open.c:837
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9f835ef429
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffbe3679e8 EFLAGS: 00000246 ORIG_RAX: 000000000000005e
RAX: ffffffffffffffda RBX: 69662f7375622f2e RCX: 00007f9f835ef429
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200002c0
RBP: 0079616c7265766f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffbe367bc8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
