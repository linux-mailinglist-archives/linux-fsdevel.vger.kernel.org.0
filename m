Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86D5639456
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Nov 2022 09:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKZIGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Nov 2022 03:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKZIGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Nov 2022 03:06:50 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B5C28E07
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Nov 2022 00:06:48 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id m11-20020a056e021c2b00b00302c7ea7e16so4382873ilh.22
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Nov 2022 00:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hf1+Fehhz/H1JEVUJs24AkCyEZpNxj0B6On7BtSmv4=;
        b=zmyc9d8aLr/FWt8Yn92p7gEDKzN7EZFfOb5SHbn6fBrAe/IEXK/3l0vCINLpUK43WY
         jHFob/A+MZCUd/v427ymrReCMH47fdqkSZXvBUF2o5m3Vueo5SHJwekb9g6vwh0Mbzwc
         HLGajCJ+lwtxv2NnLIeu+CiDX6CdBfXKs/UHkjfnv9kB9C2guIeQtYaJOiPjfVYXrvyM
         WX8wdiPNu49gFSZQIHui+qPt0y2aBgUw5aL2tf/6F8IHu2JUFZHZKrPEs4lTyCS3nY/2
         7zckrUiEXVoZo9e5733u1lUdflkhArD5BoSHby+dxjCN4Vp78t8iB1WXRtxl/YG0avhZ
         3blg==
X-Gm-Message-State: ANoB5plkVagDKLMBJY85EPzZwe0ic0O4AknccPFjdfxQwfq4SE6ROQkn
        nZBdYhvPK6iX+wSlo6nU/4pErOzlBQIgZFp0THrwFuxbYcgT
X-Google-Smtp-Source: AA0mqf4VIxrnaGG98gpeAorR5qIhVA0tr6kd8EfTvNJVnkdMqLyQvDP+KHM2aIRPplYSfcFqOf30KsXpH6fawaUeneiVL9B6xYpq
MIME-Version: 1.0
X-Received: by 2002:a92:ca89:0:b0:302:385e:eeb4 with SMTP id
 t9-20020a92ca89000000b00302385eeeb4mr13012905ilo.66.1669450007581; Sat, 26
 Nov 2022 00:06:47 -0800 (PST)
Date:   Sat, 26 Nov 2022 00:06:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac1c0605ee5b1e1b@google.com>
Subject: [syzbot] kernel BUG in __hfsplus_setxattr
From:   syzbot <syzbot+1107451c16b9eb9d29e6@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    0b1dcc2cf55a Merge tag 'mm-hotfixes-stable-2022-11-24' of ..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=111598ad880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca997ea105bc6faa
dashboard link: https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a3558d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1347da4b880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a8060ec729a5/disk-0b1dcc2c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/288bcf3c7e00/vmlinux-0b1dcc2c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/972187e4ca22/bzImage-0b1dcc2c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b45d6b75c2c2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1107451c16b9eb9d29e6@syzkaller.appspotmail.com

         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
------------[ cut here ]------------
kernel BUG at fs/hfsplus/xattr.c:175!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3633 Comm: syz-executor292 Not tainted 6.1.0-rc6-syzkaller-00251-g0b1dcc2cf55a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:hfsplus_create_attributes_file fs/hfsplus/xattr.c:175 [inline]
RIP: 0010:__hfsplus_setxattr+0x226c/0x2270 fs/hfsplus/xattr.c:331
Code: 07 80 c1 03 38 c1 0f 8c e1 f7 ff ff 4c 89 ff e8 ca 0a 7f ff e9 d4 f7 ff ff e8 c0 65 44 08 e8 2b 11 2a ff 0f 0b e8 24 11 2a ff <0f> 0b 66 90 55 53 89 f5 48 89 fb e8 14 11 2a ff 48 8d 7b 90 be 08
RSP: 0018:ffffc90003d1f2a0 EFLAGS: 00010293
RAX: ffffffff8262830c RBX: 0000000000010000 RCX: ffff888024dcd7c0
RDX: 0000000000000000 RSI: 0000000000010000 RDI: 0000000000000000
RBP: ffffc90003d1f748 R08: ffffffff82626a7a R09: ffffed1004ea9558
R10: ffffed1004ea9558 R11: 1ffff11004ea9557 R12: dffffc0000000000
R13: ffff8880281fa038 R14: 0000000000000001 R15: 1ffff1100503f407
FS:  000055555558e300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7649dcf5f0 CR3: 0000000074aad000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hfsplus_initxattrs+0x15c/0x230 fs/hfsplus/xattr_security.c:59
 security_inode_init_security+0x3bf/0x3f0 security/security.c:1119
 hfsplus_mknod+0x1bd/0x290 fs/hfsplus/dir.c:498
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12e2/0x2e00 fs/namei.c:3711
 do_filp_open+0x275/0x500 fs/namei.c:3741
 do_sys_openat2+0x13b/0x500 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7649dcf7a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc008516c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7649dcf7a9
RDX: 00000000000026e1 RSI: 00000000200000c0 RDI: 00000000ffffff9c
RBP: 00007f7649d8f040 R08: 00000000000005eb R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7649d8f0d0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfsplus_create_attributes_file fs/hfsplus/xattr.c:175 [inline]
RIP: 0010:__hfsplus_setxattr+0x226c/0x2270 fs/hfsplus/xattr.c:331
Code: 07 80 c1 03 38 c1 0f 8c e1 f7 ff ff 4c 89 ff e8 ca 0a 7f ff e9 d4 f7 ff ff e8 c0 65 44 08 e8 2b 11 2a ff 0f 0b e8 24 11 2a ff <0f> 0b 66 90 55 53 89 f5 48 89 fb e8 14 11 2a ff 48 8d 7b 90 be 08
RSP: 0018:ffffc90003d1f2a0 EFLAGS: 00010293
RAX: ffffffff8262830c RBX: 0000000000010000 RCX: ffff888024dcd7c0
RDX: 0000000000000000 RSI: 0000000000010000 RDI: 0000000000000000
RBP: ffffc90003d1f748 R08: ffffffff82626a7a R09: ffffed1004ea9558
R10: ffffed1004ea9558 R11: 1ffff11004ea9557 R12: dffffc0000000000
R13: ffff8880281fa038 R14: 0000000000000001 R15: 1ffff1100503f407
FS:  000055555558e300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7649dcf5f0 CR3: 0000000074aad000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
