Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7E67A7209
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 07:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjITF1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 01:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjITF0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:26:51 -0400
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6815D19C
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 22:25:23 -0700 (PDT)
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-1d64a196d4dso8688254fac.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 22:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695187522; x=1695792322;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9KXy0AJ1mYB9AziY09pUyMt0lMzZfTdF9nxAspCdED4=;
        b=ByDwlgeKUmOih+nZ+x8AuTvR4A43J/awmdTjItmVA4pvACnFVTGCZf3pSHkU91LimB
         imAwbmCAVxv/YPsFa87F++BHVkcABlLBveOVx/xqWSX43x7sixT1pcc8/U0mDMl+bksG
         Isl/24pUhPOHWGDWsY+Y5kpxndodlD6FCisP+Yrke0SSr3uzB6RcHGzVUtovxEkfGicc
         zzrgN2P6/Na4qlWqSgE+jkO1KF//ovNeksBI/rOUqILQ7KC5rFzFM7XAw0+ckI+XMO5j
         heOrA4nw92Zy2pCarviNIXqV861b2Nt7I8g+j51OlHT3bdgxV0nDbEhefN8i4oSw5o9P
         faGg==
X-Gm-Message-State: AOJu0Yy4Xi60sKQ7/iZvDrWM1byyT1XJb9YncW5cVAxIzQt4GEqifW6H
        qlNGlv7cYgGpZz18Va9OVbtTT1hvcGvp4gvDi/g4KFRbo2Yn
X-Google-Smtp-Source: AGHT+IEzMkNZvhI++UjBWI7bQnFSZAMLfY4s77C5sQQs68tyFvsYAQRLx9e3bpv9lwJYE4enc6Rdqj66fS5zYa/devFaZh1o/5C4
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b7a8:b0:1d5:8fab:adf9 with SMTP id
 ed40-20020a056870b7a800b001d58fabadf9mr597593oab.6.1695187522749; Tue, 19 Sep
 2023 22:25:22 -0700 (PDT)
Date:   Tue, 19 Sep 2023 22:25:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f0b970605c39a7e@google.com>
Subject: [syzbot] [ext4?] general protection fault in utf8nlookup
From:   syzbot <syzbot+9cf75dc581fb4307d6dd@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, ebiggers@google.com,
        krisman@collabora.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    e42bebf6db29 Merge tag 'efi-fixes-for-v6.6-1' of git://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=179f4a38680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
dashboard link: https://syzkaller.appspot.com/bug?extid=9cf75dc581fb4307d6dd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1374a174680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b12928680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/14a6a5d23944/disk-e42bebf6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/98cc4c220388/vmlinux-e42bebf6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6a1d09cf21bf/bzImage-e42bebf6.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/37e5beb24789/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/f219a9e665e9/mount_8.gz

The issue was bisected to:

commit b81427939590450172716093dafdda8ef52e020f
Author: Eric Biggers <ebiggers@google.com>
Date:   Mon Aug 14 18:29:02 2023 +0000

    ext4: remove redundant checks of s_encoding

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10852352680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12852352680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14852352680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9cf75dc581fb4307d6dd@syzkaller.appspotmail.com
Fixes: b81427939590 ("ext4: remove redundant checks of s_encoding")

EXT4-fs error (device loop0): ext4_do_update_inode:5097: inode #2: comm syz-executor379: corrupted inode contents
EXT4-fs error (device loop0): __ext4_ext_dirty:202: inode #2: comm syz-executor379: mark_inode_dirty error
general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 PID: 5031 Comm: syz-executor379 Not tainted 6.6.0-rc1-syzkaller-00125-ge42bebf6db29 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:utf8nlookup+0x39/0xaa0 fs/unicode/utf8-norm.c:306
Code: 89 c4 48 89 4c 24 08 48 89 14 24 89 f5 49 89 fd 49 be 00 00 00 00 00 fc ff df e8 22 a5 ea fe 49 8d 5d 18 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 c8 93 44 ff 48 8b 1b 48 83 c3 30
RSP: 0018:ffffc90003e0f800 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: ffff88801be79dc0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: ffffc90003e0f998 R11: fffff520007c1f36 R12: 0000000000000005
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff8880792de070
FS:  0000555556220480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa9b1ff3870 CR3: 000000002a7f4000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 utf8byte+0x334/0x1350
 utf8_casefold+0x125/0x220 fs/unicode/utf8-core.c:109
 ext4_fname_setup_ci_filename+0x1b0/0x430 fs/ext4/namei.c:1458
 ext4_fname_prepare_lookup+0x2f7/0x4e0 fs/ext4/crypto.c:55
 ext4_lookup_entry fs/ext4/namei.c:1760 [inline]
 ext4_lookup+0x121/0x750 fs/ext4/namei.c:1835
 lookup_one_qstr_excl+0x11b/0x250 fs/namei.c:1608
 filename_create+0x297/0x530 fs/namei.c:3890
 do_mkdirat+0xb7/0x520 fs/namei.c:4135
 __do_sys_mkdir fs/namei.c:4163 [inline]
 __se_sys_mkdir fs/namei.c:4161 [inline]
 __x64_sys_mkdir+0x6e/0x80 fs/namei.c:4161
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4bdc54d557
Code: ff ff 77 07 31 c0 c3 0f 1f 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffbf49c838 EFLAGS: 00000286 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f4bdc54d557
RDX: 0000000000000040 RSI: 00000000000001ff RDI: 0000000020000540
RBP: 00007fffbf49c8d0 R08: 00000000000000fd R09: 0000000000000000
R10: 0000000000000249 R11: 0000000000000286 R12: 0000000020000540
R13: 00000000200000c0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:utf8nlookup+0x39/0xaa0 fs/unicode/utf8-norm.c:306
Code: 89 c4 48 89 4c 24 08 48 89 14 24 89 f5 49 89 fd 49 be 00 00 00 00 00 fc ff df e8 22 a5 ea fe 49 8d 5d 18 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 c8 93 44 ff 48 8b 1b 48 83 c3 30
RSP: 0018:ffffc90003e0f800 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: ffff88801be79dc0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: ffffc90003e0f998 R11: fffff520007c1f36 R12: 0000000000000005
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff8880792de070
FS:  0000555556220480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005650cf4460b8 CR3: 000000002a7f4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 c4                	mov    %eax,%esp
   2:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
   7:	48 89 14 24          	mov    %rdx,(%rsp)
   b:	89 f5                	mov    %esi,%ebp
   d:	49 89 fd             	mov    %rdi,%r13
  10:	49 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%r14
  17:	fc ff df
  1a:	e8 22 a5 ea fe       	call   0xfeeaa541
  1f:	49 8d 5d 18          	lea    0x18(%r13),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 c8 93 44 ff       	call   0xff449401
  39:	48 8b 1b             	mov    (%rbx),%rbx
  3c:	48 83 c3 30          	add    $0x30,%rbx


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
