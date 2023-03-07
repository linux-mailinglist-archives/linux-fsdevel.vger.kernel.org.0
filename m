Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAD76AF6F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 21:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjCGUu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 15:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCGUu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:50:57 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE99AA739
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 12:50:56 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id t16-20020a92c0d0000000b00319bb6f4282so7561402ilf.20
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 12:50:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678222255;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2TaVkmzoFnbidPsxAEaZiPwl2GKYJdrifj1ZuLmWyE=;
        b=x6RYVG869b2u9BXpmoUCjPPAaBDnT4zAi+88piCIoKcHbVs7p8wUnhqI+qIhwuMFce
         W28R+dJbiBsT4nVdHDOZwpHFrlUPmrA8Dvp8GMAmpjx8ChEc61cSpdcxrdgcLlmTfV89
         rURicxBe/XVaFOO5mkOoKW7H9fD5v/DfQUDpkui+Q+1AWfs2Wg/V0QbTzUY4X90h6Fsb
         QvOpdmcBTOmrOaaDk8BRDG5xKAFL/SFTwhUR8SwbU+o+2vCSpVFKwVCHQyq1+QSiAc9I
         1R7/u1+iCOiqMgfw9RDYJEP3gm5n4kp/fgW7yVsHZp27mhiEzD3NfcjeX2A3B9MNxZhP
         wutQ==
X-Gm-Message-State: AO0yUKU7moQDnwxAuBe7RSUHYUgiWukf6Y3NpJHPmzapjCWFB//JSXcE
        WsOLl9g1YoZNyikRAh58qCLzLhtlmA90JtTUhlRG2v2OV/49
X-Google-Smtp-Source: AK7set9Q3fQ7QaebeZqWPyLaB4izydi5rzt3N6zz4x1KYKQBL2nLH7IYDELTuCVnn9h+Bb+GOTRlBr6Fa6b2pcs9kZQi6Wq5+kxF
MIME-Version: 1.0
X-Received: by 2002:a02:7310:0:b0:3e0:6875:f5e2 with SMTP id
 y16-20020a027310000000b003e06875f5e2mr7593499jab.6.1678222255359; Tue, 07 Mar
 2023 12:50:55 -0800 (PST)
Date:   Tue, 07 Mar 2023 12:50:55 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062913f05f655919e@google.com>
Subject: [syzbot] [9p?] KASAN: wild-memory-access Write in v9fs_get_acl
From:   syzbot <syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, ericvh@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux_oss@crudebyte.com, lucho@ionkov.net,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    596b6b709632 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12ce3de4c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3519974f3f27816d
dashboard link: https://syzkaller.appspot.com/bug?extid=cb1d16facb3cc90de5fb
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b2e204c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e74fb0c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/06e2210b88a3/disk-596b6b70.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/79e6930ab577/vmlinux-596b6b70.xz
kernel image: https://storage.googleapis.com/syzbot-assets/56b95e6bcb5c/Image-596b6b70.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e12043e9faac/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 256
MINIX-fs: mounting unchecked file system, running fsck is recommended
==================================================================
BUG: KASAN: wild-memory-access in instrument_atomic_read_write include/linux/instrumented.h:102 [inline]
BUG: KASAN: wild-memory-access in atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:176 [inline]
BUG: KASAN: wild-memory-access in __refcount_sub_and_test include/linux/refcount.h:272 [inline]
BUG: KASAN: wild-memory-access in __refcount_dec_and_test include/linux/refcount.h:315 [inline]
BUG: KASAN: wild-memory-access in refcount_dec_and_test include/linux/refcount.h:333 [inline]
BUG: KASAN: wild-memory-access in posix_acl_release include/linux/posix_acl.h:57 [inline]
BUG: KASAN: wild-memory-access in v9fs_get_acl+0x1a4/0x390 fs/9p/acl.c:102
Write of size 4 at addr 9fffeb37f97f1c00 by task syz-executor798/5923

CPU: 0 PID: 5923 Comm: syz-executor798 Not tainted 6.2.0-syzkaller-18302-g596b6b709632 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Call trace:
 dump_backtrace+0x1c8/0x1f4 arch/arm64/kernel/stacktrace.c:158
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:165
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_report+0xe4/0x4c0 mm/kasan/report.c:420
 kasan_report+0xd4/0x130 mm/kasan/report.c:517
 kasan_check_range+0x264/0x2a4 mm/kasan/generic.c:189
 __kasan_check_write+0x2c/0x3c mm/kasan/shadow.c:37
 instrument_atomic_read_write include/linux/instrumented.h:102 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:176 [inline]
 __refcount_sub_and_test include/linux/refcount.h:272 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 posix_acl_release include/linux/posix_acl.h:57 [inline]
 v9fs_get_acl+0x1a4/0x390 fs/9p/acl.c:102
 v9fs_mount+0x77c/0xa5c fs/9p/vfs_super.c:183
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:610
 vfs_get_tree+0x90/0x274 fs/super.c:1489
 do_new_mount+0x25c/0x8c8 fs/namespace.c:3145
 path_mount+0x590/0xe58 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3674
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x168 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
==================================================================
Unable to handle kernel paging request at virtual address 9fffeb37f97f1c00
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[9fffeb37f97f1c00] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 5923 Comm: syz-executor798 Tainted: G    B              6.2.0-syzkaller-18302-g596b6b709632 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lse_atomic_fetch_add_release arch/arm64/include/asm/atomic_lse.h:62 [inline]
pc : __lse_atomic_fetch_sub_release arch/arm64/include/asm/atomic_lse.h:76 [inline]
pc : arch_atomic_fetch_sub_release arch/arm64/include/asm/atomic.h:51 [inline]
pc : atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:177 [inline]
pc : __refcount_sub_and_test include/linux/refcount.h:272 [inline]
pc : __refcount_dec_and_test include/linux/refcount.h:315 [inline]
pc : refcount_dec_and_test include/linux/refcount.h:333 [inline]
pc : posix_acl_release include/linux/posix_acl.h:57 [inline]
pc : v9fs_get_acl+0x1b0/0x390 fs/9p/acl.c:102
lr : arch_atomic_fetch_sub_release arch/arm64/include/asm/atomic.h:51 [inline]
lr : atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:177 [inline]
lr : __refcount_sub_and_test include/linux/refcount.h:272 [inline]
lr : __refcount_dec_and_test include/linux/refcount.h:315 [inline]
lr : refcount_dec_and_test include/linux/refcount.h:333 [inline]
lr : posix_acl_release include/linux/posix_acl.h:57 [inline]
lr : v9fs_get_acl+0x1ac/0x390 fs/9p/acl.c:102
sp : ffff80001e607970
x29: ffff80001e607970 x28: dfff800000000000 x27: 1ffff00003cc0f3c
x26: 1ffff00003cc0f38 x25: ffff0000ddbe4648 x24: ffff0000ddbe45e0
x23: ffff0000de2a0000 x22: dfff800000000000 x21: 9fffeb37f97f1c00
x20: 00000000fffffffb x19: fffffffffffffffb x18: 1fffe0003689b776
x17: ffff800015b8d000 x16: ffff80001235d16c x15: 0000000000000000
x14: 0000000040000000 x13: 0000000000000002 x12: 0000000000000001
x11: ff80800009d500bc x10: 0000000000000000 x9 : ffff800009d500bc
x8 : 00000000ffffffff x7 : 1fffe0003689b777 x6 : ffff800008288c58
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000081b9ce8
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 arch_atomic_fetch_sub_release arch/arm64/include/asm/atomic.h:51 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:177 [inline]
 __refcount_sub_and_test include/linux/refcount.h:272 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 posix_acl_release include/linux/posix_acl.h:57 [inline]
 v9fs_get_acl+0x1b0/0x390 fs/9p/acl.c:102
 v9fs_mount+0x77c/0xa5c fs/9p/vfs_super.c:183
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:610
 vfs_get_tree+0x90/0x274 fs/super.c:1489
 do_new_mount+0x25c/0x8c8 fs/namespace.c:3145
 path_mount+0x590/0xe58 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3674
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x168 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: 97b08d5c d503201f 979ee91f 12800008 (b86802b6) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97b08d5c 	bl	0xfffffffffec23570
   4:	d503201f 	nop
   8:	979ee91f 	bl	0xfffffffffe7ba484
   c:	12800008 	mov	w8, #0xffffffff            	// #-1
* 10:	b86802b6 	ldaddl	w8, w22, [x21] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
