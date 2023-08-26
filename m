Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7830F7893CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Aug 2023 06:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjHZEPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Aug 2023 00:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjHZEOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Aug 2023 00:14:52 -0400
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B228269E
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 21:14:48 -0700 (PDT)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-68bf47ff13cso1554527b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 21:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693023288; x=1693628088;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKmBgc+IBjMQrSvV0fsyKGk3qaeiNGQJpi8obyaOm0o=;
        b=gx9H2fmS8XdLqme+VPSMDoKUeTS4r+V39JVm7cxg9Dl/+FMqSF/rgj3jqZ3Z4LWhkR
         CnB7lZoZlp8cBabrA4TaZmBw10jQ0eBlUz/TpIYphELPNTWOTDCDYTztisYDG6tkkFOj
         yHeslzML8WclCbnuOCrZr2JagomiO8+VhUz7hfsyyCR2qQG4tItG/rf1+TfcYUrT5HTz
         BazG5yJxdAYdxSztsGd8JsuXwM2HrDRM7GJJIfwErcRlRMG48B8AG/dEZ5CFm4VXfMnQ
         mJuw4mQiAvZiEIj3OysQXuc7YR5MXm0col3VWAkqDtSU8aX5YuCQa0AMtmCO3RVr+xGp
         d4Dw==
X-Gm-Message-State: AOJu0YxuWkQUD8Z7E6QOyF4GKlv07xzrI1RLa5pfzs2JdVIFVu+wmEWZ
        XWCNxs6XlBRONtxetMlhNm2FKL+1OA14Lip59+gabNLWmB9X
X-Google-Smtp-Source: AGHT+IFgYAIfcyo5+vLGvve0oCSsH3Sb+KO4yU6tUiyrQhgh1OsjZjF6uUmsA0TU55ovU+KAJloZrHDUMLFrHdcVK42m1jEdEMFt
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:17a4:b0:68b:f529:a340 with SMTP id
 s36-20020a056a0017a400b0068bf529a340mr1530907pfg.4.1693023287936; Fri, 25 Aug
 2023 21:14:47 -0700 (PDT)
Date:   Fri, 25 Aug 2023 21:14:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac8cda0603cbb34c@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in insert_state (2)
From:   syzbot <syzbot+d21c74a99c319e88007a@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f7757129e3de Merge tag 'v6.5-p3' of git://git.kernel.org/p..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16cdc297a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=d21c74a99c319e88007a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1202e640680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e949f3a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea6db0533d44/disk-f7757129.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7fb38faa25d7/vmlinux-f7757129.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66c68cd610b3/bzImage-f7757129.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ab022f48d9c5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d21c74a99c319e88007a@syzkaller.appspotmail.com

RSP: 002b:00007fffa59319d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000005
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f85faecb839
RDX: 00007f85faeca9f0 RSI: 0000000020001300 RDI: 0000000000000006
RBP: 00007fffa5931ac0 R08: 00007fffa5931777 R09: 00007fffa5931a90
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f85faf0f319
R13: 00007fffa5931aa0 R14: 0000000000000001 R15: 00007fffa5931ac0
 </TASK>
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent-io-tree.c:379!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5017 Comm: syz-executor183 Not tainted 6.5.0-rc7-syzkaller-00004-gf7757129e3de #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:set_state_bits fs/btrfs/extent-io-tree.c:379 [inline]
RIP: 0010:insert_state+0x38d/0x390 fs/btrfs/extent-io-tree.c:401
Code: e0 32 fe e9 25 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 42 fd ff ff 48 89 df e8 1d e0 32 fe e9 35 fd ff ff e8 43 0e da fd <0f> 0b 90 66 0f 1f 00 55 41 57 41 56 41 55 41 54 53 48 83 ec 40 44
RSP: 0018:ffffc90003bbf038 EFLAGS: 00010293
RAX: ffffffff83b1a9ed RBX: 00000000fffffff4 RCX: ffff888020ac0000
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: ffff88807be47d80 R08: ffffffff83b1a7cb R09: 1ffffffff1a8407e
R10: dffffc0000000000 R11: fffffbfff1a8407f R12: 0000000000001000
R13: 0000000000000800 R14: 0000000000001fff R15: dffffc0000000000
FS:  00005555571d8380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001300 CR3: 0000000073f11000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __set_extent_bit+0x1106/0x1b00 fs/btrfs/extent-io-tree.c:1151
 set_record_extent_bits+0x51/0x90 fs/btrfs/extent-io-tree.c:1705
 qgroup_reserve_data+0x260/0x8e0 fs/btrfs/qgroup.c:3800
 btrfs_qgroup_reserve_data+0x2e/0xc0 fs/btrfs/qgroup.c:3843
 btrfs_check_data_free_space+0x149/0x240 fs/btrfs/delalloc-space.c:154
 btrfs_delalloc_reserve_space+0x37/0x200 fs/btrfs/delalloc-space.c:467
 btrfs_page_mkwrite+0x334/0xd10 fs/btrfs/inode.c:8272
 do_page_mkwrite+0x1a4/0x600 mm/memory.c:2942
 wp_page_shared mm/memory.c:3294 [inline]
 do_wp_page+0x559/0x3a70 mm/memory.c:3376
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault mm/memory.c:5079 [inline]
 handle_mm_fault+0x1c58/0x5410 mm/memory.c:5233
 do_user_addr_fault arch/x86/mm/fault.c:1392 [inline]
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x266/0x7c0 arch/x86/mm/fault.c:1542
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:rep_movs_alternative+0x4a/0xb0 arch/x86/lib/copy_user_64.S:71
Code: 75 f1 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb c9 <f3> a4 c3 0f 1f 00 4c 8b 06 4c 8b 4e 08 4c 8b 56 10 4c 8b 5e 18 4c
RSP: 0018:ffffc90003bbfc10 EFLAGS: 00050206
RAX: ffffffff8436f801 RBX: 0000000020001390 RCX: 0000000000000090
RDX: 0000000000000000 RSI: ffffc90003bbfc80 RDI: 0000000020001300
RBP: ffffc90003bbfdb0 R08: ffffc90003bbfd0f R09: 1ffff92000777fa1
R10: dffffc0000000000 R11: fffff52000777fa2 R12: 0000000000000090
R13: ffffc90003bbfdec R14: 0000000020001300 R15: ffffc90003bbfc80
 copy_user_generic arch/x86/include/asm/uaccess_64.h:112 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:133 [inline]
 _copy_to_user+0x86/0xa0 lib/usercopy.c:41
 copy_to_user include/linux/uaccess.h:191 [inline]
 cp_new_stat+0x544/0x6d0 fs/stat.c:412
 __do_sys_newfstat fs/stat.c:459 [inline]
 __se_sys_newfstat fs/stat.c:453 [inline]
 __x64_sys_newfstat+0xf7/0x140 fs/stat.c:453
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f85faecb839
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffa59319d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000005
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f85faecb839
RDX: 00007f85faeca9f0 RSI: 0000000020001300 RDI: 0000000000000006
RBP: 00007fffa5931ac0 R08: 00007fffa5931777 R09: 00007fffa5931a90
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f85faf0f319
R13: 00007fffa5931aa0 R14: 0000000000000001 R15: 00007fffa5931ac0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:set_state_bits fs/btrfs/extent-io-tree.c:379 [inline]
RIP: 0010:insert_state+0x38d/0x390 fs/btrfs/extent-io-tree.c:401
Code: e0 32 fe e9 25 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 42 fd ff ff 48 89 df e8 1d e0 32 fe e9 35 fd ff ff e8 43 0e da fd <0f> 0b 90 66 0f 1f 00 55 41 57 41 56 41 55 41 54 53 48 83 ec 40 44
RSP: 0018:ffffc90003bbf038 EFLAGS: 00010293
RAX: ffffffff83b1a9ed RBX: 00000000fffffff4 RCX: ffff888020ac0000
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: ffff88807be47d80 R08: ffffffff83b1a7cb R09: 1ffffffff1a8407e
R10: dffffc0000000000 R11: fffffbfff1a8407f R12: 0000000000001000
R13: 0000000000000800 R14: 0000000000001fff R15: dffffc0000000000
FS:  00005555571d8380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001300 CR3: 0000000073f11000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	75 f1                	jne    0xfffffff3
   2:	c3                   	ret
   3:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   a:	00 00 00
   d:	0f 1f 00             	nopl   (%rax)
  10:	48 8b 06             	mov    (%rsi),%rax
  13:	48 89 07             	mov    %rax,(%rdi)
  16:	48 83 c6 08          	add    $0x8,%rsi
  1a:	48 83 c7 08          	add    $0x8,%rdi
  1e:	83 e9 08             	sub    $0x8,%ecx
  21:	74 df                	je     0x2
  23:	83 f9 08             	cmp    $0x8,%ecx
  26:	73 e8                	jae    0x10
  28:	eb c9                	jmp    0xfffffff3
* 2a:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi) <-- trapping instruction
  2c:	c3                   	ret
  2d:	0f 1f 00             	nopl   (%rax)
  30:	4c 8b 06             	mov    (%rsi),%r8
  33:	4c 8b 4e 08          	mov    0x8(%rsi),%r9
  37:	4c 8b 56 10          	mov    0x10(%rsi),%r10
  3b:	4c 8b 5e 18          	mov    0x18(%rsi),%r11
  3f:	4c                   	rex.WR


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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
