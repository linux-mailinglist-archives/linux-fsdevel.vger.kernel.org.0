Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0DF70CE0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 00:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjEVWgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 18:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjEVWgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 18:36:15 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486B4FE
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 15:36:12 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7636c775952so274982739f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 15:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684794971; x=1687386971;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GkcPTyai8fLKGWDOfLOHN9Xafg7Hw5fvduTOLXDbabE=;
        b=DOTVK88XgY5k/s2xKqW8Gox3NZre9DV65WvL+QiJsSPgOCG+JyVAkoTZQwfC0jGLyf
         f3i1s7IqII69qGZG48vD1pstZeWtZbMoH6xrL5h7PQMp3erD7P69KPU1jqzTMyshCyN0
         nQo+MsF0L34LQFMz6ybjZiYFDlez1SeTu4EL/7CoZaBFV0OZERHDkTiAHccjm2U8Mb8n
         EkBEvANwwUHS2Tg16oS1Nu0DkDUQCO+dklg6NV6sEfKy5z2sI7orb6PIMJM8EM9rTfoO
         BUpbRGqV6VmULapCQwWu8LNpAdgsbcNnfKoOiFev6UW7WOOa4+SdAOWdhHGsf886NGD+
         aO+A==
X-Gm-Message-State: AC+VfDwV1/rZsjDWiGORYdObKKMNkmVXk09adOFZF1jrKCnL0EQQuAe0
        FkzFpKroLHwSuFXJF6/GCH5pa3QU8LYSPvpYNBjRtlPVE/qM7NTT0g==
X-Google-Smtp-Source: ACHHUZ6A7OW3+C4d3KxiyFg7rBK4mtT8QvqxZA9bBUi0NV6FCyTyzJvgEQiyXEGl5G5PFH3O4Ho5BA0NfU7OshvByZVzvrTAGb6y
MIME-Version: 1.0
X-Received: by 2002:a05:6638:10c5:b0:416:7e77:bb5f with SMTP id
 q5-20020a05663810c500b004167e77bb5fmr6129956jad.0.1684794971452; Mon, 22 May
 2023 15:36:11 -0700 (PDT)
Date:   Mon, 22 May 2023 15:36:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cafb9305fc4fe588@google.com>
Subject: [syzbot] [fs?] KASAN: null-ptr-deref Write in get_block (2)
From:   syzbot <syzbot+aad58150cbc64ba41bdc@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    4d6d4c7f541d Merge tag 'linux-kselftest-fixes-6.4-rc3' of ..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17b34a5a280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94af80bb8ddd23c4
dashboard link: https://syzkaller.appspot.com/bug?extid=aad58150cbc64ba41bdc
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1615fbe9280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1282842e280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dcd8898335fc/disk-4d6d4c7f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a1f7abe57aa/vmlinux-4d6d4c7f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b485f41c18e6/bzImage-4d6d4c7f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/19be7546cd7d/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aad58150cbc64ba41bdc@syzkaller.appspotmail.com

memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=4996 'syz-executor412'
loop0: detected capacity change from 0 to 128
VFS: Found a Xenix FS (block size = 512) on device loop0
sysv_free_block: trying to free block not in datazone
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: null-ptr-deref in test_and_set_bit_lock include/asm-generic/bitops/instrumented-lock.h:57 [inline]
BUG: KASAN: null-ptr-deref in trylock_buffer include/linux/buffer_head.h:399 [inline]
BUG: KASAN: null-ptr-deref in lock_buffer include/linux/buffer_head.h:405 [inline]
BUG: KASAN: null-ptr-deref in alloc_branch fs/sysv/itree.c:148 [inline]
BUG: KASAN: null-ptr-deref in get_block+0x567/0x16a0 fs/sysv/itree.c:251
Write of size 8 at addr 0000000000000000 by task syz-executor412/4996

CPU: 1 PID: 4996 Comm: syz-executor412 Not tainted 6.4.0-rc2-syzkaller-00018-g4d6d4c7f541d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_report+0xe6/0x540 mm/kasan/report.c:465
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 test_and_set_bit_lock include/asm-generic/bitops/instrumented-lock.h:57 [inline]
 trylock_buffer include/linux/buffer_head.h:399 [inline]
 lock_buffer include/linux/buffer_head.h:405 [inline]
 alloc_branch fs/sysv/itree.c:148 [inline]
 get_block+0x567/0x16a0 fs/sysv/itree.c:251
 __block_write_begin_int+0x548/0x1a50 fs/buffer.c:2064
 __block_write_begin fs/buffer.c:2114 [inline]
 block_write_begin+0x9c/0x1f0 fs/buffer.c:2175
 sysv_write_begin+0x31/0x70 fs/sysv/itree.c:485
 generic_perform_write+0x300/0x5e0 mm/filemap.c:3923
 __generic_file_write_iter+0x17a/0x400 mm/filemap.c:4051
 generic_file_write_iter+0xaf/0x310 mm/filemap.c:4083
 do_iter_write+0x7b1/0xcb0 fs/read_write.c:860
 vfs_writev fs/read_write.c:933 [inline]
 do_pwritev+0x21a/0x360 fs/read_write.c:1030
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3233222b19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffecf15f268 EFLAGS: 00000246 ORIG_RAX: 0000000000000128
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007f3233222b19
RDX: 0000000000000005 RSI: 0000000020000480 RDI: 0000000000000004
RBP: 00007f32331e2150 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000007fff R11: 0000000000000246 R12: 00007f32331e21e0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
==================================================================


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
