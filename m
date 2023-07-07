Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F0674B07B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 14:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjGGMKB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 08:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGGMKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:10:01 -0400
Received: from mail-pj1-f78.google.com (mail-pj1-f78.google.com [209.85.216.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5388210C
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 05:09:59 -0700 (PDT)
Received: by mail-pj1-f78.google.com with SMTP id 98e67ed59e1d1-262cf62e9b4so2743479a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 05:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688731799; x=1691323799;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PI5ApXs2ZsjZ5d4mdhTHU0eytxqvGV+WP25cKrMce9g=;
        b=icsyfPR3w8tCeG7yJF19n/BkVaBEQ/hCSBILjJDv8ePdEo10Z/PfBcXOgpRxu03mE3
         oFcaMWALefGVkw6cgeny6iMxY+68tRtwdI0QXy6WOmn+WSXdxomrnU/cWBWdq4y4GrsI
         Y214IuKm9DOANpbdoNrunFmnA0JhaMZB4YYt7h06ZUXBRWmjbSY4hGqNDean998hla1h
         R/+StRQDw1st1K8yogRMmCrhOqrx+0Nze1Vf6cdH4rug74KekkT0kUcOZKRiO3gm3KWU
         Kn5wON+3n2fhhDCTjYlu9qBQjoMVHmbg78OTjRWdUQC6NPvQpM2kckUPQXj8WuVR4VVh
         6xYw==
X-Gm-Message-State: ABy/qLZ3QiOHPqJOV1FB6Lwsjqo2CGHzt99UQfy0qSaFi7rX513Wh6QA
        8JFdhmlCPMtnbAq1528atFc6X7+9/LMoeSW+otZ5I3SKpy54
X-Google-Smtp-Source: APBJJlEkPiPGEAwT1NW5Be+lY9WbmPdCS+Em6ZYAz1iNcqNoXt84xdvqCKDYoj+oEntwbFaTKXS9KvFls1sND9+Lo0JyWiicbB0C
MIME-Version: 1.0
X-Received: by 2002:a17:90b:a4a:b0:263:c6b4:5267 with SMTP id
 gw10-20020a17090b0a4a00b00263c6b45267mr4122522pjb.7.1688731798795; Fri, 07
 Jul 2023 05:09:58 -0700 (PDT)
Date:   Fri, 07 Jul 2023 05:09:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fcfb4a05ffe48213@google.com>
Subject: [syzbot] [tomoyo?] [hfs?] general protection fault in
 tomoyo_check_acl (3)
From:   syzbot <syzbot+28aaddd5a3221d7fd709@syzkaller.appspotmail.com>
To:     jmorris@namei.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp,
        tomoyo-dev-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15e4c8a4a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7406f415f386e786
dashboard link: https://syzkaller.appspot.com/bug?extid=28aaddd5a3221d7fd709
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b5bb80a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10193ee7280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/119fd918f733/disk-a901a356.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/79f9ac119639/vmlinux-a901a356.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8bd8662e2869/bzImage-a901a356.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8e36b52190bc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+28aaddd5a3221d7fd709@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
hfs: unable to locate alternate MDB
hfs: continuing without an alternate MDB
general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 PID: 5189 Comm: syz-executor307 Not tainted 6.4.0-syzkaller-10173-ga901a3568fd2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:tomoyo_check_acl+0xb0/0x440 security/tomoyo/domain.c:173
Code: 00 0f 85 64 03 00 00 49 8b 5d 00 49 39 dd 0f 84 fa 01 00 00 e8 71 fc b1 fd 48 8d 7b 18 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <0f> b6 04 28 38 d0 7f 08 84 c0 0f 85 f2 02 00 00 44 0f b6 73 18 31
RSP: 0018:ffffc90003caf790 EFLAGS: 00010246
RAX: 0000000000000003 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff83d2d25f RDI: 0000000000000018
RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffc90003caf880
R13: ffff888016f31410 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555556ffa300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc16e620c80 CR3: 0000000075643000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 tomoyo_path_permission security/tomoyo/file.c:586 [inline]
 tomoyo_path_permission+0x1ff/0x3a0 security/tomoyo/file.c:573
 tomoyo_check_open_permission+0x366/0x3a0 security/tomoyo/file.c:777
 tomoyo_file_open security/tomoyo/tomoyo.c:332 [inline]
 tomoyo_file_open+0xaa/0xd0 security/tomoyo/tomoyo.c:327
 security_file_open+0x49/0xb0 security/security.c:2797
 do_dentry_open+0x57a/0x17b0 fs/open.c:901
 do_open fs/namei.c:3636 [inline]
 path_openat+0x1b65/0x2710 fs/namei.c:3793
 do_filp_open+0x1ba/0x410 fs/namei.c:3820
 do_sys_openat2+0x160/0x1c0 fs/open.c:1407
 do_sys_open fs/open.c:1422 [inline]
 __do_sys_openat fs/open.c:1438 [inline]
 __se_sys_openat fs/open.c:1433 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1433
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc16e647a19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcc752e608 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000000000000e483 RCX: 00007fc16e647a19
RDX: 0000000000141842 RSI: 0000000020000380 RDI: 00000000ffffff9c
RBP: 0000000000000000 R08: 0000000000000260 R09: 00007ffcc752e630
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffcc752e62c
R13: 00007ffcc752e660 R14: 00007ffcc752e640 R15: 00000000000000be
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:tomoyo_check_acl+0xb0/0x440 security/tomoyo/domain.c:173
Code: 00 0f 85 64 03 00 00 49 8b 5d 00 49 39 dd 0f 84 fa 01 00 00 e8 71 fc b1 fd 48 8d 7b 18 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <0f> b6 04 28 38 d0 7f 08 84 c0 0f 85 f2 02 00 00 44 0f b6 73 18 31
RSP: 0018:ffffc90003caf790 EFLAGS: 00010246
RAX: 0000000000000003 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff83d2d25f RDI: 0000000000000018
RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffc90003caf880
R13: ffff888016f31410 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555556ffa300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d594f5c028 CR3: 0000000075643000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	00 0f                	add    %cl,(%rdi)
   2:	85 64 03 00          	test   %esp,0x0(%rbx,%rax,1)
   6:	00 49 8b             	add    %cl,-0x75(%rcx)
   9:	5d                   	pop    %rbp
   a:	00 49 39             	add    %cl,0x39(%rcx)
   d:	dd 0f                	fisttpll (%rdi)
   f:	84 fa                	test   %bh,%dl
  11:	01 00                	add    %eax,(%rax)
  13:	00 e8                	add    %ch,%al
  15:	71 fc                	jno    0x13
  17:	b1 fd                	mov    $0xfd,%cl
  19:	48 8d 7b 18          	lea    0x18(%rbx),%rdi
  1d:	48 89 f8             	mov    %rdi,%rax
  20:	48 89 fa             	mov    %rdi,%rdx
  23:	48 c1 e8 03          	shr    $0x3,%rax
  27:	83 e2 07             	and    $0x7,%edx
* 2a:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax <-- trapping instruction
  2e:	38 d0                	cmp    %dl,%al
  30:	7f 08                	jg     0x3a
  32:	84 c0                	test   %al,%al
  34:	0f 85 f2 02 00 00    	jne    0x32c
  3a:	44 0f b6 73 18       	movzbl 0x18(%rbx),%r14d
  3f:	31                   	.byte 0x31


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
