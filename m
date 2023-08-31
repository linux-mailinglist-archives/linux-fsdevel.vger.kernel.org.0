Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ED778EFF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 17:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346494AbjHaPMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 11:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344701AbjHaPMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:12:06 -0400
Received: from mail-pj1-f77.google.com (mail-pj1-f77.google.com [209.85.216.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8DFE4F
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 08:12:01 -0700 (PDT)
Received: by mail-pj1-f77.google.com with SMTP id 98e67ed59e1d1-26d63b60934so1101843a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 08:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693494720; x=1694099520;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73T5VhzIYfyXx1BlIn+rQpmkj/AzBZfrfI73pg6gsRQ=;
        b=Qlk+RvMaDb4hMPPEJVkeBiGBhoTbhPA+MtZGMHdhQPy56F25X+ADgFCb/0tzKcY3M7
         8isGLtE26vPAC75ti+uvYZZvcGeVRkwyV8Y6OkNsxjycehjzobsH8y3j1SM9E2JXPeLP
         jK388GiD+6jxkgSswuG3zH7hBMnKw0snETn8MM8ENACPgIRkzwWZ2b/z/+RcR3n7RlpU
         VitkVZTE6ygE0djHUgueHSvnwHhyJwRERyPRShLL/o2nSDvzPAum61jQn7TGUEud2I1D
         HtqK5F7ov4fVR8i8iu3LzlzFN+iAej7ojjF31PZdz+5rXfGJs21ewHFBO+5Wtaw3y2Wq
         jmvw==
X-Gm-Message-State: AOJu0YxuJYybHhuo9W7cLLBcUixH7CHNXtAQYlPAU58wfFN3gTrZJwvg
        LAF4tkFrvowY+ONR+k0p/DSqZMYfnGKSPuqsya4gXBgLHK35
X-Google-Smtp-Source: AGHT+IE+n5U6gPEuIVgdvvqKVxBkdD8wzcdp0/xAS7Ek6WqWs2uLnTGexuh4H6dvyrUcZ1auiGkJDt2JAxYPCv1CaNRZoqOSuJDB
MIME-Version: 1.0
X-Received: by 2002:a17:90b:a08:b0:26d:2b05:4926 with SMTP id
 gg8-20020a17090b0a0800b0026d2b054926mr952109pjb.1.1693494720590; Thu, 31 Aug
 2023 08:12:00 -0700 (PDT)
Date:   Thu, 31 Aug 2023 08:12:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ffd3806043977e1@google.com>
Subject: [syzbot] [ext4?] general protection fault in inode_permission (2)
From:   syzbot <syzbot+f5b965c58efb9c510227@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, brauner@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    28f20a19294d Merge tag 'x86-urgent-2023-08-26' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153271dfa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4a882f77ed77bd
dashboard link: https://syzkaller.appspot.com/bug?extid=f5b965c58efb9c510227
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16aab870680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=175a687ba80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b7215a1c9ca/disk-28f20a19.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c5935df3c66a/vmlinux-28f20a19.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3974ee7fd77d/bzImage-28f20a19.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4d843a4575f5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f5b965c58efb9c510227@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xeeb017db1ffff112: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0x7580ded8ffff8890-0x7580ded8ffff8897]
CPU: 0 PID: 5055 Comm: syz-executor397 Not tainted 6.5.0-rc7-syzkaller-00185-g28f20a19294d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:do_inode_permission fs/namei.c:460 [inline]
RIP: 0010:inode_permission fs/namei.c:528 [inline]
RIP: 0010:inode_permission+0x35d/0x5e0 fs/namei.c:503
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 5d 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 73 20 49 8d 7e 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 30 02 00 00 4d 8b 76 10 4d 85 f6 0f 84 ab 01 00
RSP: 0000:ffffc90003caf5a0 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: ffff88807580dcb0 RCX: 0000000000000000
RDX: 0eb01bdb1ffff112 RSI: ffffffff81ec15b5 RDI: 7580ded8ffff8890
RBP: 0000000000000081 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff8cb84420
R13: 0000000000000000 R14: 7580ded8ffff8880 R15: ffff88807580dcb2
FS:  0000555555f8d3c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffc7 CR3: 000000002a981000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 may_lookup fs/namei.c:1716 [inline]
 link_path_walk.part.0.constprop.0+0x26f/0xce0 fs/namei.c:2267
 link_path_walk fs/namei.c:2250 [inline]
 path_parentat+0xaa/0x1b0 fs/namei.c:2526
 __filename_parentat+0x1f2/0x640 fs/namei.c:2550
 filename_parentat fs/namei.c:2568 [inline]
 do_unlinkat+0x109/0x6d0 fs/namei.c:4368
 do_coredump+0x18bd/0x3fc0 fs/coredump.c:675
 get_signal+0x2464/0x2770 kernel/signal.c:2867
 arch_do_signal_or_restart+0x89/0x5f0 arch/x86/kernel/signal.c:308
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7f96f653c143
Code: e8 46 45 00 00 66 0f 1f 44 00 00 48 83 ec 08 48 89 fa 48 89 f1 31 ff 31 f6 e8 4d 01 03 00 85 c0 75 09 48 83 c4 08 c3 0f 1f 40 <00> 48 c7 c2 b0 ff ff ff 64 89 02 b8 ff ff ff ff eb e6 66 2e 0f 1f
RSP: 002b:00007ffc5e7c7220 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 000000000006cd02 RCX: 00007f96f656c2b3
RDX: 00007ffc5e7c7230 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000066 R08: 00000000000001be R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc5e7c7300
R13: 0000000000000025 R14: 431bde82d7b634db R15: 00007ffc5e7c7284
 </TASK>
Modules linked in:
----------------
Code disassembly (best guess):
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	48 c1 ea 03          	shr    $0x3,%rdx
   7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   b:	0f 85 5d 02 00 00    	jne    0x26e
  11:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  18:	fc ff df
  1b:	4c 8b 73 20          	mov    0x20(%rbx),%r14
  1f:	49 8d 7e 10          	lea    0x10(%r14),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 30 02 00 00    	jne    0x264
  34:	4d 8b 76 10          	mov    0x10(%r14),%r14
  38:	4d 85 f6             	test   %r14,%r14
  3b:	0f                   	.byte 0xf
  3c:	84                   	.byte 0x84
  3d:	ab                   	stos   %eax,%es:(%rdi)
  3e:	01 00                	add    %eax,(%rax)


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
