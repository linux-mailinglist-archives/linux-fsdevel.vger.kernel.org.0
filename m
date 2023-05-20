Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D73270A95E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 18:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjETQzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 12:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjETQzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 12:55:09 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6FCC9
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 09:55:07 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3385a30067fso23222155ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 09:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684601707; x=1687193707;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iR+Mev6mqwJYOKc7k8OaTu9UD8vOFEdqohU0fITChcA=;
        b=LMgbRBxmdPRc+uJDmEFBXa35lY85wwnY9EbbmajGtDWyaHpaWp9iZXoL10zuZsvi0v
         i2oZQdA+G5mJqpSxDB3W6ZN8ibrRYCWBPD8tPfNj2vWRZl9VGquSj0uiZpCZdg9h3gbg
         5V1HCYchNJQU0PjqgyIdBN7mS/YqvVi5HjPpNVZqTyKnKToRbrA3xMUGidpC9SccLAiw
         eORC1hUAvv59xv9bZSht5CAcUjZG3YFZBYf9EQ7kP3PGSn15n4vX2l0Z9uVAYuzcsZzv
         KeTmbll3PfyGFYGJ5ZNqCfn+FX/PtCNwtLOzSQMawLE1UQToBif6K43CW7oK5w+RVr0V
         P5UQ==
X-Gm-Message-State: AC+VfDzMlPUwYpC/SSQuLU3s5ChI0omGqfosUsxF5qKlNxQ/L0sQ4SUL
        FNnxVHuCzf/gGwf/OpDDqBwI+UpTWblpjITfQKqCThfd+XIr
X-Google-Smtp-Source: ACHHUZ7P72GS3ZpOe/xeExsK6LC3T14A1FN8ycKeUosRtvx1LZAsN0ujMYs/CXP496pUTNac0u+x3ZPI1lr5GRoFLTNuhkJih36l
MIME-Version: 1.0
X-Received: by 2002:a92:ce49:0:b0:331:4e48:32be with SMTP id
 a9-20020a92ce49000000b003314e4832bemr2825228ilr.4.1684601707056; Sat, 20 May
 2023 09:55:07 -0700 (PDT)
Date:   Sat, 20 May 2023 09:55:07 -0700
In-Reply-To: <0000000000007c47b505f909f71d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056580b05fc22e607@google.com>
Subject: Re: [syzbot] [f2fs?] general protection fault in __drop_extent_tree
From:   syzbot <syzbot+d015b6c2fbb5c383bf08@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    d635f6cc934b Merge tag 'drm-fixes-2023-05-20' of git://ano..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=177b7d29280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bda401fa9c6b4502
dashboard link: https://syzkaller.appspot.com/bug?extid=d015b6c2fbb5c383bf08
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157567a6280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d301f9280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8dcff8d58d55/disk-d635f6cc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b0fda3221672/vmlinux-d635f6cc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9541aa11c888/bzImage-d635f6cc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7626bc33593c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d015b6c2fbb5c383bf08@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
CPU: 1 PID: 5010 Comm: syz-executor252 Not tainted 6.4.0-rc2-syzkaller-00290-gd635f6cc934b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
RIP: 0010:__lock_acquire+0x69/0x2000 kernel/locking/lockdep.c:4942
Code: df 0f b6 04 30 84 c0 0f 85 5a 16 00 00 83 3d d1 e1 ea 0c 00 0f 84 02 11 00 00 83 3d 70 33 74 0b 00 74 2b 4c 89 f0 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 f7 e8 59 38 78 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90003a6faf8 EFLAGS: 00010006
RAX: 0000000000000009 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000048 R15: ffff88807d47d940
FS:  00007fcf413a3700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055664a01b058 CR3: 000000007ddb9000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
 __raw_write_lock include/linux/rwlock_api_smp.h:209 [inline]
 _raw_write_lock+0x2e/0x40 kernel/locking/spinlock.c:300
 __drop_extent_tree+0x3ac/0x660 fs/f2fs/extent_cache.c:1100
 f2fs_drop_extent_tree+0x17/0x30 fs/f2fs/extent_cache.c:1116
 f2fs_insert_range+0x2d5/0x3c0 fs/f2fs/file.c:1664
 f2fs_fallocate+0x4e4/0x6d0 fs/f2fs/file.c:1838
 vfs_fallocate+0x54b/0x6b0 fs/open.c:324
 ksys_fallocate fs/open.c:347 [inline]
 __do_sys_fallocate fs/open.c:355 [inline]
 __se_sys_fallocate fs/open.c:353 [inline]
 __x64_sys_fallocate+0xbd/0x100 fs/open.c:353
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcf413f7459
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcf413a32f8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007fcf414817a0 RCX: 00007fcf413f7459
RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000000000005
RBP: 00007fcf4144e7f8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000010000 R11: 0000000000000246 R12: 00007fcf4144e6c0
R13: 0030656c69662f2e R14: 4b55cd3db08b6c4e R15: 00007fcf414817a8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x69/0x2000 kernel/locking/lockdep.c:4942
Code: df 0f b6 04 30 84 c0 0f 85 5a 16 00 00 83 3d d1 e1 ea 0c 00 0f 84 02 11 00 00 83 3d 70 33 74 0b 00 74 2b 4c 89 f0 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 f7 e8 59 38 78 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90003a6faf8 EFLAGS: 00010006
RAX: 0000000000000009 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000048 R15: ffff88807d47d940
FS:  00007fcf413a3700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055664a01b058 CR3: 000000007ddb9000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	df 0f                	fisttps (%rdi)
   2:	b6 04                	mov    $0x4,%dh
   4:	30 84 c0 0f 85 5a 16 	xor    %al,0x165a850f(%rax,%rax,8)
   b:	00 00                	add    %al,(%rax)
   d:	83 3d d1 e1 ea 0c 00 	cmpl   $0x0,0xceae1d1(%rip)        # 0xceae1e5
  14:	0f 84 02 11 00 00    	je     0x111c
  1a:	83 3d 70 33 74 0b 00 	cmpl   $0x0,0xb743370(%rip)        # 0xb743391
  21:	74 2b                	je     0x4e
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1) <-- trapping instruction
  2e:	74 12                	je     0x42
  30:	4c 89 f7             	mov    %r14,%rdi
  33:	e8 59 38 78 00       	callq  0x783891
  38:	48                   	rex.W
  39:	be 00 00 00 00       	mov    $0x0,%esi
  3e:	00 fc                	add    %bh,%ah


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
