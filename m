Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E79754BDF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jul 2023 21:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjGOTzB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jul 2023 15:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjGOTzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jul 2023 15:55:00 -0400
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFE010D0
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jul 2023 12:54:57 -0700 (PDT)
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-56662adc40bso4208158eaf.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jul 2023 12:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689450897; x=1692042897;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFv0/MCAgWYbwzr1AKVJ7Am8jiOtEnsgKi71vMY8H/U=;
        b=bgNQt/lDUzaH1I88rp5qF1oYuCzMBf0kUhAAt2Eoag5LZREhDC44b816oRO2MwIG2N
         h9DL6c73uJl3LWfZ50xasPcJ8NJ9jOZEWdDCTSuOH50fXtaKKny3MMcP8IziRlOljtYA
         k5KE17YEDoNtVYYN/cy+ybdsXSh/e55w+d0/0/0Z0k/+nIhNecajO5Cg4UQ5bfOi5CkC
         zctEKkS7jKi8oI6XtKKReE5R4Xap4XzqzmO6j4c2BT7nJ8plHmQLnHt0Kscnb2eY998G
         h7YxrLxhSXKqspGn1E0G4BxHxgeK7aU9pJpJgFlOZkac/F67hsbMEgZf7x+0UNfPUA44
         +fUA==
X-Gm-Message-State: ABy/qLZE3LhjW06bl9iarno1BR/ETJFGY7pzqb2GotLyN4eAOPDR80ko
        sU7vtW0RpY7ziMMJKnBZlubD9N1zodvIDX9zJrFRgCuBpCcK
X-Google-Smtp-Source: APBJJlHuY2LNRCk3xLW9DVN/E1ALINkKR6qSnqp86Gy9fLvMeVbI9W5yuzHtrEbZYrjwdx30U7mR1R0ebrftv5VL/3HFBK+a8kq3
MIME-Version: 1.0
X-Received: by 2002:a05:6808:189a:b0:3a3:b8ab:c211 with SMTP id
 bi26-20020a056808189a00b003a3b8abc211mr10570514oib.4.1689450897018; Sat, 15
 Jul 2023 12:54:57 -0700 (PDT)
Date:   Sat, 15 Jul 2023 12:54:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095141106008bf0b5@google.com>
Subject: [syzbot] [ext4?] [reiserfs?] kernel BUG in __phys_addr (2)
From:   syzbot <syzbot+daa1128e28d3c3961cb2@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    8e4b7f2f3d60 Add linux-next specific files for 20230711
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=132602caa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eaa6217eed71d333
dashboard link: https://syzkaller.appspot.com/bug?extid=daa1128e28d3c3961cb2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11605074a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f723e2a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/52debf037744/disk-8e4b7f2f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b4580012911/vmlinux-8e4b7f2f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/79b0de8a559f/bzImage-8e4b7f2f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c865e2933fcf/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+daa1128e28d3c3961cb2@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5041 Comm: syz-executor387 Not tainted 6.5.0-rc1-next-20230711-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
RIP: 0010:__phys_addr+0xd7/0x140 arch/x86/mm/physaddr.c:28
Code: e3 44 89 e9 31 ff 48 d3 eb 48 89 de e8 02 ec 4a 00 48 85 db 75 0f e8 b8 ef 4a 00 4c 89 e0 5b 5d 41 5c 41 5d c3 e8 a9 ef 4a 00 <0f> 0b e8 a2 ef 4a 00 48 c7 c0 10 e0 79 8c 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc900039feeb0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 06100164000013b6 RCX: 0000000000000000
RDX: ffff88807e7f1dc0 RSI: ffffffff813a2f67 RDI: 0000000000000006
RBP: 06100164800013b6 R08: 0000000000000006 R09: 06100164800013b6
R10: 061078e4000013b6 R11: 0000000000000001 R12: 061078e4000013b6
R13: ffffc900039fef18 R14: 06100164000013b6 R15: 0000000000000000
FS:  000055555695c480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055fb6fc92f18 CR3: 0000000074063000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 virt_to_folio include/linux/mm.h:1263 [inline]
 virt_to_slab mm/kasan/../slab.h:213 [inline]
 qlink_to_cache mm/kasan/quarantine.c:129 [inline]
 qlist_free_all+0x86/0x170 mm/kasan/quarantine.c:182
 kasan_quarantine_reduce+0x195/0x220 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3470 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x173/0x390 mm/slub.c:3494
 kmem_cache_zalloc include/linux/slab.h:693 [inline]
 jbd2_alloc_handle include/linux/jbd2.h:1602 [inline]
 new_handle fs/jbd2/transaction.c:476 [inline]
 jbd2__journal_start+0x190/0x850 fs/jbd2/transaction.c:503
 __ext4_journal_start_sb+0x411/0x5d0 fs/ext4/ext4_jbd2.c:111
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_dirty_inode+0xa5/0x130 fs/ext4/inode.c:5919
 __mark_inode_dirty+0x1e0/0xd60 fs/fs-writeback.c:2430
 mark_inode_dirty include/linux/fs.h:2150 [inline]
 generic_write_end+0x354/0x440 fs/buffer.c:2317
 ext4_da_write_end+0x1f9/0xb50 fs/ext4/inode.c:2988
 generic_perform_write+0x331/0x5d0 mm/filemap.c:3936
 ext4_buffered_write_iter+0x123/0x3d0 fs/ext4/file.c:299
 ext4_file_write_iter+0x8f2/0x1880 fs/ext4/file.c:722
 __kernel_write_iter+0x262/0x7e0 fs/read_write.c:517
 dump_emit_page fs/coredump.c:888 [inline]
 dump_user_range+0x23c/0x710 fs/coredump.c:915
 elf_core_dump+0x27f4/0x3790 fs/binfmt_elf.c:2142
 do_coredump+0x2f44/0x4050 fs/coredump.c:764
 get_signal+0x1c16/0x2650 kernel/signal.c:2875
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310
 exc_page_fault+0xc0/0x170 arch/x86/mm/fault.c:1568
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7f92da04d4f3
Code: 3f 00 00 77 02 c3 90 48 89 77 20 31 c0 c3 66 0f 1f 84 00 00 00 00 00 41 55 41 54 55 53 48 83 ec 08 64 48 8b 04 25 10 00 00 00 <4c> 8b a0 98 06 00 00 4c 03 a0 90 06 00 00 4c 29 e6 64 48 8b 1c 25
RSP: 002b:00007fffbd381320 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 00007f92da0a4af5
RDX: 0000000000000006 RSI: 00007fffbd381348 RDI: 00007f92da1025b0
RBP: 00007f92da1025b0 R08: 0000000000000000 R09: 00007fffbd588080
R10: 0000000000000000 R11: 0000000000000293 R12: 00007fffbd47ebf0
R13: 000000000001ef5f R14: 00007fffbd47ec30 R15: 0000000000000004
 </TASK>
Modules linked in:


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
