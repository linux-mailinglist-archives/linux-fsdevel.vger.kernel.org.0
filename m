Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C534C63FF84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 05:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiLBEex (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 23:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiLBEew (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 23:34:52 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6C7D2D99
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 20:34:51 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id 13-20020a056e0216cd00b003023e8b7d03so4289646ilx.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Dec 2022 20:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mjOcm8yGinHOze3UymrcRt7aGjfvDo58Gv15I7hjwzA=;
        b=mWrouqTwE29YmmwkJC+2EcqEewglSj4jMeBlYDrRFxHAGSVX9Jehp67n1l9U5YT2Dj
         61qQK0Bj0PrB4Yx7vWn009Tk275ApVwOzLKjCsk/791De5QWiJ+RJSY8vuOPSUvjc1wP
         MA9zlvascuXOlCDwTnIRzFUrEdKvd+q5xefrneGrhacdYTfzkLP/teeraP2nC0AElJZa
         TFLGC2v8SRIbc3a7Qr7rrp4+1KUM0itbhxii6h2vXuoA7wMdlUjA4rme4aQm6Yk9zrN3
         +RO+IRnwFM0/VLNaAearkGM33nuHvgbAHM6jI/XhFUsWnOgszUmItO+CKIFWwg291CG0
         X3iA==
X-Gm-Message-State: ANoB5pl2vtuVmxphO/49aap6VWuH0hD3LAUSLM9In2oevuRcbSL1yv/k
        pbj5t2dROUIQ4IMzK/jhmA46ZglHexp3/6Mhapcmu3z6aB4x
X-Google-Smtp-Source: AA0mqf6Fd1voLCWecr34VJTbH5ryMsJgrPkzbegt5fxFDcuRzwYw1HQD1xb8RuY0Q37NMrJ4UAPLqHYseSIkf0l/0bkI0T1HrgKy
MIME-Version: 1.0
X-Received: by 2002:a92:ca8d:0:b0:302:de10:7ae1 with SMTP id
 t13-20020a92ca8d000000b00302de107ae1mr21652419ilo.15.1669955691220; Thu, 01
 Dec 2022 20:34:51 -0800 (PST)
Date:   Thu, 01 Dec 2022 20:34:51 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c41adb05eed0db7d@google.com>
Subject: [syzbot] WARNING in hfsplus_bnode_create
From:   syzbot <syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fmdefrancesco@gmail.com,
        ira.weiny@intel.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, slava@dubeyko.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ef4d3ea40565 afs: Fix server->active leak in afs_put_server
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=174b244d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e7e79f8a1e34200
dashboard link: https://syzkaller.appspot.com/bug?extid=1c8ff72d0cd8a50dfeaa
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165f624d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e7e55b880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef790e7777cd/disk-ef4d3ea4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2ed3c6bc9230/vmlinux-ef4d3ea4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f1dbd004fa88/bzImage-ef4d3ea4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ac35ccffd559/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
hfsplus: trying to free free bnode 0(1)
hfsplus: new node 0 already hashed?
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3631 at fs/hfsplus/bnode.c:573 hfsplus_bnode_create+0x3d4/0x460 fs/hfsplus/bnode.c:572
Modules linked in:
CPU: 0 PID: 3631 Comm: syz-executor306 Not tainted 6.1.0-rc7-syzkaller-00103-gef4d3ea40565 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:hfsplus_bnode_create+0x3d4/0x460 fs/hfsplus/bnode.c:573
Code: 31 c0 e8 41 9b 43 08 e9 5f fd ff ff e8 45 25 2b ff 4c 89 ff e8 7d fe 4e 08 48 c7 c7 c0 52 27 8b 44 89 e6 31 c0 e8 1e 9b 43 08 <0f> 0b eb b1 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 61 fc ff ff 48 89
RSP: 0018:ffffc90003bfedb0 EFLAGS: 00010246
RAX: 0000000000000023 RBX: ffff888017af7400 RCX: 99976e79c3affa00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff816fdabd R09: fffff5200077fd6d
R10: fffff5200077fd6d R11: 1ffff9200077fd6c R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88807bef8000 R15: ffff88807bef80e0
FS:  00005555558fc300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe4e739000 CR3: 000000007bbce000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hfsplus_bmap_alloc+0x5a5/0x640 fs/hfsplus/btree.c:415
 hfs_btree_inc_height+0x131/0xda0 fs/hfsplus/brec.c:475
 hfsplus_brec_insert+0x160/0xdf0 fs/hfsplus/brec.c:75
 hfsplus_create_attr+0x4b2/0x620 fs/hfsplus/attributes.c:252
 __hfsplus_setxattr+0x6e4/0x2270 fs/hfsplus/xattr.c:354
 hfsplus_initxattrs+0x15c/0x230 fs/hfsplus/xattr_security.c:59
 security_inode_init_security+0x3bf/0x3f0 security/security.c:1119
 hfsplus_mknod+0x1bd/0x290 fs/hfsplus/dir.c:498
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12e2/0x2e00 fs/namei.c:3711
 do_filp_open+0x275/0x500 fs/namei.c:3741
 do_sys_openat2+0x13b/0x500 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1396
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4788f48779
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe4e738698 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4788f48779
RDX: 00007f4788f48779 RSI: 0000000000000000 RDI: 0000000020000300
RBP: 00007f4788f08010 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000604 R11: 0000000000000246 R12: 00007f4788f080a0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
