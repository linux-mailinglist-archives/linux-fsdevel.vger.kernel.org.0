Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED3376424B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 00:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGZW4z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 18:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjGZW4y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:56:54 -0400
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1ED271B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 15:56:52 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6bc6e6390fcso1045762a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 15:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690412211; x=1691017011;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uww23Qzs/DVnAxeNoXGeyPDZ7ffs5XsS4ctwL03PTGk=;
        b=BbPGdH1BlFaJNZ6M2jEnsHKkOVu2sEBI2AVbHggOOc9rxZXxIHnhtBHn5yiBSsaOAQ
         lH/pPuvLuNSALvZV2wVYo4XledtU6qX14UM9S+BAFPLF2Cbs9nO+YNy8GGu7YUNvoG8T
         UKiUXkIB3WRuyhmQA4T54nqeBX98lwpq/us2V1OgO/kQQjJBpyQpwffXwkY1nZmic4uk
         NHnvAzTzG9JIxTRbr4EgZPx7TRwVHIQsLocA5qDo2y/bz2d75TvueQm8HWZb98bnM2dS
         lOLS88KtNCRgbX+FA7tPVpB7uyPQJfJyWvJYmRw7XiGB0pZRxM1uwtRML5rAhFQLOqzZ
         ZmGw==
X-Gm-Message-State: ABy/qLZH/NbHDAvknQLvlxMAKAhRqzZSEG6HHgCGtlN/SVvy2R+5opnL
        VM9Gdd+HEH7UtE9IY+sgtEYIOUune7BFptnykngHeCb7R1Vt
X-Google-Smtp-Source: APBJJlEQd75G8ckYWcJGWByqGONPqonvJAiFEoUpGtHmEJasooORdi52AgxtLDN020gIljlTOXeOhtynhXm2srMtBw14SRszlRTU
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1457:b0:6b7:2c41:710 with SMTP id
 w23-20020a056830145700b006b72c410710mr1215164otp.3.1690412211376; Wed, 26 Jul
 2023 15:56:51 -0700 (PDT)
Date:   Wed, 26 Jul 2023 15:56:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062174006016bc386@google.com>
Subject: [syzbot] [ntfs3?] WARNING: nested lock was not taken in ntfs_file_write_iter
From:   syzbot <syzbot+12dd1b7c210b98623391@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, viro@zeniv.linux.org.uk
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

HEAD commit:    ae867bc97b71 Add linux-next specific files for 20230721
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13e8efaea80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c403a6b36e7c85ac
dashboard link: https://syzkaller.appspot.com/bug?extid=12dd1b7c210b98623391
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f7744aa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e25e52a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a76b93f21f84/disk-ae867bc9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8eb30097a952/vmlinux-ae867bc9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7506a6b3ec38/bzImage-ae867bc9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/26e8694ec3f7/mount_2.gz

The issue was bisected to:

commit ad26a9c84510af7252e582e811de970433a9758f
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Oct 7 17:08:06 2022 +0000

    fs/ntfs3: Fixing wrong logic in attr_set_size and ntfs_fallocate

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149187d1a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=169187d1a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=129187d1a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+12dd1b7c210b98623391@syzkaller.appspotmail.com
Fixes: ad26a9c84510 ("fs/ntfs3: Fixing wrong logic in attr_set_size and ntfs_fallocate")

==================================
WARNING: Nested lock was not taken
6.5.0-rc2-next-20230721-syzkaller #0 Not tainted
----------------------------------
syz-executor992/5289 is trying to lock:
ffff888077f9f240 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_trylock include/linux/fs.h:791 [inline]
ffff888077f9f240 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: ntfs_file_write_iter+0x236/0x1c10 fs/ntfs3/file.c:1060

but this task is not holding:
general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 PID: 5289 Comm: syz-executor992 Not tainted 6.5.0-rc2-next-20230721-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:print_lock_nested_lock_not_held kernel/locking/lockdep.c:4974 [inline]
RIP: 0010:__lock_acquire+0x12bb/0x5de0 kernel/locking/lockdep.c:5135
Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 40 4a 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5d 18 48 8d 7b 18 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 13 4a 00 00 48 8b 73 18 48 c7 c7 20 b1 6c 8a e8
RSP: 0018:ffffc90004017368 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: ffffffff816acb50 RDI: 0000000000000018
RBP: ffff88801fc20ac8 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff88801fc20000
R13: ffff88801fc20af0 R14: 0000000000000001 R15: ffffed1003f84158
FS:  000055555625d380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555562666f8 CR3: 0000000029b9f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
 down_write_trylock kernel/locking/rwsem.c:1604 [inline]
 down_write_trylock+0x1ae/0x3d0 kernel/locking/rwsem.c:1599
 inode_trylock include/linux/fs.h:791 [inline]
 ntfs_file_write_iter+0x236/0x1c10 fs/ntfs3/file.c:1060
 call_write_iter include/linux/fs.h:1917 [inline]
 do_iter_readv_writev+0x21e/0x3c0 fs/read_write.c:735
 do_iter_write+0x17f/0x830 fs/read_write.c:860
 vfs_iter_write+0x7a/0xb0 fs/read_write.c:901
 iter_file_splice_write+0x698/0xbf0 fs/splice.c:738
 do_splice_from fs/splice.c:933 [inline]
 direct_splice_actor+0x118/0x180 fs/splice.c:1142
 splice_direct_to_actor+0x347/0xa30 fs/splice.c:1088
 do_splice_direct+0x1af/0x280 fs/splice.c:1194
 do_sendfile+0xb88/0x1390 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f906989afd9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1b 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff4bf5f198 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f906989afd9
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 0000000000000000 R08: 00007fff4bf5f1d0 R09: 00007fff4bf5f1d0
R10: 000000007fffffff R11: 0000000000000246 R12: 00007fff4bf5f1bc
R13: 00000000000000cd R14: 431bde82d7b634db R15: 00007fff4bf5f1f0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:print_lock_nested_lock_not_held kernel/locking/lockdep.c:4974 [inline]
RIP: 0010:__lock_acquire+0x12bb/0x5de0 kernel/locking/lockdep.c:5135
Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 40 4a 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5d 18 48 8d 7b 18 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 13 4a 00 00 48 8b 73 18 48 c7 c7 20 b1 6c 8a e8
RSP: 0018:ffffc90004017368 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: ffffffff816acb50 RDI: 0000000000000018
RBP: ffff88801fc20ac8 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff88801fc20000
R13: ffff88801fc20af0 R14: 0000000000000001 R15: ffffed1003f84158
FS:  000055555625d380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555562666f8 CR3: 0000000029b9f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 40 4a 00 00    	jne    0x4a4e
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df
  18:	49 8b 5d 18          	mov    0x18(%r13),%rbx
  1c:	48 8d 7b 18          	lea    0x18(%rbx),%rdi
  20:	48 89 fa             	mov    %rdi,%rdx
  23:	48 c1 ea 03          	shr    $0x3,%rdx
* 27:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2b:	0f 85 13 4a 00 00    	jne    0x4a44
  31:	48 8b 73 18          	mov    0x18(%rbx),%rsi
  35:	48 c7 c7 20 b1 6c 8a 	mov    $0xffffffff8a6cb120,%rdi
  3c:	e8                   	.byte 0xe8


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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
