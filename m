Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6A170ADBD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 13:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjEULrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 07:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjEULqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 07:46:50 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C414710E4
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 04:45:51 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-772e344fde5so76673739f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 04:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684669551; x=1687261551;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ciCej22Li57RuBEc5bXi3KWiKyrm/4CVswzAFj2Mx84=;
        b=Nd5yQ27sGsf4ySAuxrVCBEAMXKXik6y2/H/rq8Aj57Auk6MG+Nb2+8la96fGj0yBeq
         smeva5zwceCtivrwTsECIntq55WZfuwzMJEvI4nekc2zldK6l+DtNtD7nygQd/X1bdWb
         Bt5VaGNTVk9jpyicpxE2hMZaBOQvGblSlFiA7GFUAXT5oSuE+vgBTuEOQmFccNxY0NpX
         PWZfbNML3I+o4zNC7rcEoc5l/ZjDjXZL8mfXnFHR1sqaHQ+9kLB17DNLUPkiS+e11n6J
         fqoPfUVKFioQgw1ZO8ckStAHdPAw982yaar3O9WR/OCUT9xG7L7t3vjJMQi8ZAUedlhT
         m06Q==
X-Gm-Message-State: AC+VfDyTI0fgna+167etxyWL5mE9Ppt0RuOImVzNhqM9XvUSf5upz/Gy
        L3Inwt8Ob4TN8pfz6a/ZHF6hRwBnrlpwbh+T5N0PZNP/3b3M
X-Google-Smtp-Source: ACHHUZ5ELVJS5WU5X56hf7kUNQ34I9eGMIEl5P/B4NQQTcEV3N4bcMRW4lpVi80V6NH+InGbDMG/vxZ3ViGm5CVHw7Fn/f1YCRkZ
MIME-Version: 1.0
X-Received: by 2002:a02:298e:0:b0:40f:7de9:c379 with SMTP id
 p136-20020a02298e000000b0040f7de9c379mr3283916jap.5.1684669551159; Sun, 21
 May 2023 04:45:51 -0700 (PDT)
Date:   Sun, 21 May 2023 04:45:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002930a705fc32b231@google.com>
Subject: [syzbot] [nilfs?] general protection fault in folio_create_empty_buffers
From:   syzbot <syzbot+0ad741797f4565e7e2d2@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0dd2a6fb1e34 Merge tag 'tty-6.4-rc3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14343765280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9afc9b1b9107cdcd
dashboard link: https://syzkaller.appspot.com/bug?extid=0ad741797f4565e7e2d2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1746d572280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/df4d9c4d67a3/disk-0dd2a6fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/76f164dda927/vmlinux-0dd2a6fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f4f63ee8d7e/bzImage-0dd2a6fb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/420107162e49/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ad741797f4565e7e2d2@syzkaller.appspotmail.com

NILFS (loop1): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
general protection fault, probably for non-canonical address 0xdffffc000000003d: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000001e8-0x00000000000001ef]
CPU: 0 PID: 5383 Comm: segctord Not tainted 6.4.0-rc2-syzkaller-00330-g0dd2a6fb1e34 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
RIP: 0010:__lock_acquire+0xdce/0x5df0 kernel/locking/lockdep.c:4942
Code: 00 00 3b 05 04 82 59 0f 0f 87 42 0a 00 00 41 be 01 00 00 00 e9 83 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 19 32 00 00 48 81 3b 20 08 16 90 0f 84 06 f3 ff
RSP: 0018:ffffc9000549f618 EFLAGS: 00010012
RAX: dffffc0000000000 RBX: 00000000000001e8 RCX: 0000000000000000
RDX: 000000000000003d RSI: 0000000000000000 RDI: 00000000000001e8
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88802009bb80 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000016b15000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5691 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 folio_create_empty_buffers+0xb0/0x470 fs/buffer.c:1615
 nilfs_lookup_dirty_data_buffers+0x580/0x6f0 fs/nilfs2/segment.c:730
 nilfs_segctor_scan_file+0x1b1/0x6f0 fs/nilfs2/segment.c:1075
 nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1197 [inline]
 nilfs_segctor_collect fs/nilfs2/segment.c:1524 [inline]
 nilfs_segctor_do_construct+0x267f/0x7200 fs/nilfs2/segment.c:2070
 nilfs_segctor_construct+0x8e3/0xb30 fs/nilfs2/segment.c:2404
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2512 [inline]
 nilfs_segctor_thread+0x3c7/0xf30 fs/nilfs2/segment.c:2595
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xdce/0x5df0 kernel/locking/lockdep.c:4942
Code: 00 00 3b 05 04 82 59 0f 0f 87 42 0a 00 00 41 be 01 00 00 00 e9 83 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 19 32 00 00 48 81 3b 20 08 16 90 0f 84 06 f3 ff
RSP: 0018:ffffc9000549f618 EFLAGS: 00010012
RAX: dffffc0000000000 RBX: 00000000000001e8 RCX: 0000000000000000
RDX: 000000000000003d RSI: 0000000000000000 RDI: 00000000000001e8
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88802009bb80 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000016b15000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	3b 05 04 82 59 0f    	cmp    0xf598204(%rip),%eax        # 0xf59820c
   8:	0f 87 42 0a 00 00    	ja     0xa50
   e:	41 be 01 00 00 00    	mov    $0x1,%r14d
  14:	e9 83 00 00 00       	jmpq   0x9c
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 da             	mov    %rbx,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 19 32 00 00    	jne    0x324d
  34:	48 81 3b 20 08 16 90 	cmpq   $0xffffffff90160820,(%rbx)
  3b:	0f                   	.byte 0xf
  3c:	84 06                	test   %al,(%rsi)
  3e:	f3                   	repz
  3f:	ff                   	.byte 0xff


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
