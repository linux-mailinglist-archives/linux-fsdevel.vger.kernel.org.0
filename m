Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B2A66139C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 05:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjAHEvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Jan 2023 23:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjAHEvk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Jan 2023 23:51:40 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1331A237
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Jan 2023 20:51:39 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id l3-20020a056e021aa300b00304be32e9e5so3620857ilv.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Jan 2023 20:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbFd39ngrFpRMqyekThyz3zElZJUT2Ew/ay9zgHXVA8=;
        b=jV/XtyIsfaJhs/uhzRBBO2gdnHpn605qwyCTUnboRZiUV6wdVC7RW3MhCiZ+yZ8DSY
         LG6vbIPRfL4pCLjB+iXQYPpa+Qgn4Jc/sKCMPEX9M7rhktEKfM3GBc3gPWiP2XSCyIcY
         5nv95yIctn60CaMX6/93LLle0qPu/mIXNFYEcP4fsIEQzyJvN0lrGIcXm51+iVVKsEvf
         6QIzmfjRkVzZO7SgBbNLhgQx0GPkm85rZdf4VbK8dXEvO4rKT9DUXjQZon0CXySxpBTw
         00hLCl3QG1CoYbQx8PPtL0mhw588CkDASqpgSKZYmfHDPhURwvKyW2v/YA6XQCHEBT8L
         MC/w==
X-Gm-Message-State: AFqh2kq38PAc+ryCYd/H/9fVoRQU82Ca9tl1EBhZeApJm0jYwlx+itet
        WjJIwUGGKejAOoP7hNhzST2hWb4e6LGDKPF2l6GwkN84skfL
X-Google-Smtp-Source: AMrXdXszQvO80kN+MXUAMYHImEwu3N8KRoM9cwX8fB5ZM3jcqcsJAcGvihkyaQhnX+FNbVTmMXSlnT7cAIkhCb62aMQvNQWLOULM
MIME-Version: 1.0
X-Received: by 2002:a05:6638:441a:b0:38a:b1dd:85e9 with SMTP id
 bp26-20020a056638441a00b0038ab1dd85e9mr3555033jab.25.1673153498757; Sat, 07
 Jan 2023 20:51:38 -0800 (PST)
Date:   Sat, 07 Jan 2023 20:51:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2c33c05f1b967dc@google.com>
Subject: [syzbot] [reiserfs?] WARNING: locking bug in lockref_put_or_lock
From:   syzbot <syzbot+12a2ecec8db1d853fc33@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    69b41ac87e4a Merge tag 'for-6.2-rc2-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1386ac9a480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0
dashboard link: https://syzkaller.appspot.com/bug?extid=12a2ecec8db1d853fc33
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10256734480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d3aac1573b20/disk-69b41ac8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/31f5a860f3b3/vmlinux-69b41ac8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d4a7091814ba/bzImage-69b41ac8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d2780fe6fae0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+12a2ecec8db1d853fc33@syzkaller.appspotmail.com

REISERFS (device loop5): Created .reiserfs_priv - reserved for xattr storage.
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 5314 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4729 [inline]
WARNING: CPU: 0 PID: 5314 at kernel/locking/lockdep.c:231 __lock_acquire+0xac2/0x1f60 kernel/locking/lockdep.c:5005
Modules linked in:
CPU: 0 PID: 5314 Comm: syz-executor.5 Not tainted 6.2.0-rc2-syzkaller-00010-g69b41ac87e4a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:hlock_class kernel/locking/lockdep.c:231 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4729 [inline]
RIP: 0010:__lock_acquire+0xac2/0x1f60 kernel/locking/lockdep.c:5005
Code: 2b 0d 00 0f 85 2b fa ff ff 31 db 48 c7 c7 80 ba ed 8a 48 c7 c6 20 bd ed 8a 31 c0 e8 08 b0 e7 ff 48 ba 00 00 00 00 00 fc ff df <0f> 0b e9 25 fa ff ff e8 12 f2 cf 02 85 c0 0f 84 b1 06 00 00 48 c7
RSP: 0018:ffffc900058a7628 EFLAGS: 00010046
RAX: 3bc84842428cc400 RBX: 0000000000000000 RCX: ffff888027ef0000
RDX: dffffc0000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff816f2c9d R09: ffffed1017304f5b
R10: ffffed1017304f5b R11: 1ffff11017304f5a R12: 0000000000040000
R13: ffff888027ef0000 R14: 0000000000041770 R15: ffff888027ef0a80
FS:  00007f1c2429f700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000280 CR3: 000000002195c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 lockref_put_or_lock+0x22/0xb0 lib/lockref.c:148
 fast_dput fs/dcache.c:775 [inline]
 dput+0x20e/0x410 fs/dcache.c:900
 path_put fs/namei.c:558 [inline]
 terminate_walk+0x1b1/0x5d0 fs/namei.c:680
 path_openat+0x24c9/0x2dd0 fs/namei.c:3715
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1c2348c0a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1c2429f168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f1c235abf80 RCX: 00007f1c2348c0a9


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
