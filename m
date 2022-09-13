Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66A45B7B90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 21:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiIMTvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 15:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIMTvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:51:45 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CBF6BCCD
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 12:51:42 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id d7-20020a056e02214700b002f3cbbcc8cbso5325495ilv.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 12:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=7S0v9HXpkYT9zH8YjpmOOMJrTOndmWA1loFnUsoP6kk=;
        b=aQmddGEKQ2EIcN/+8fNvzB2BTxVmI7qY/j0w6a3yxa5iaTLMKt3rvBTUtzflCnImAu
         /WjVothyPYurBYETPtjwMcBEWMZ9qRSUAUkEGvTkqAu0dZLAj35pUl1nf2QzN2kixQB7
         K7Doqr2nebWkotO//P8R+rmEZwO/OzDJPAP0nbNsiV3LQSLXOIE0UAVv2k9nAS2wGlXJ
         5CKDzvu7+eE6gRpls3M6G2nA+F7YsLk4/92DAjA+IVfjPBPr14t24vuAeB7l67QVWnfY
         TPnxBABXVUnMwL48MzPPVI+zFm5r9DBozV1zkYNvsXzSuKhH1AYFEaAxYXsKKCUEvJZK
         68Gw==
X-Gm-Message-State: ACgBeo2fAZZ29zjAqDGxzkV/oJcDvm8zcjJy9ca/vBMWjlMqpcuKpn7t
        AtqN/VzuC3Gdrd0LvQbFb6tTYOMt7EL3aqLSRXwMRNElmoql
X-Google-Smtp-Source: AA6agR5WqIUuaej2dCGt4CnV3+/Q4ZLjM0p09HHZSy1HniIRoD+P7nEsG1M/+4E02x7RGXIULLXEZg6r2ZY4SqV6ZlcFaHYAFk8X
MIME-Version: 1.0
X-Received: by 2002:a92:d0ca:0:b0:2eb:33e4:7734 with SMTP id
 y10-20020a92d0ca000000b002eb33e47734mr12670354ila.42.1663098702012; Tue, 13
 Sep 2022 12:51:42 -0700 (PDT)
Date:   Tue, 13 Sep 2022 12:51:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c2d1f05e8945724@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in __d_instantiate
From:   syzbot <syzbot+29dc75ed37be943c610e@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    a6b443748715 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16271d4f080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e79d82586727c5df
dashboard link: https://syzkaller.appspot.com/bug?extid=29dc75ed37be943c610e
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162474a7080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119b6b78880000

Downloadable assets:
disk image: https://storage.googleapis.com/1436897f0dc0/disk-a6b44374.raw.xz
vmlinux: https://storage.googleapis.com/68c4de151fbb/vmlinux-a6b44374.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29dc75ed37be943c610e@syzkaller.appspotmail.com

ntfs3: loop0: Different NTFS' sector size (1024) and media sector size (512)
ntfs3: loop0: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
ntfs3: loop0: Failed to load $Extend.
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000109094000
[0000000000000008] pgd=080000010aed9003, p4d=080000010aed9003, pud=080000010738d003, pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3027 Comm: syz-executor119 Not tainted 6.0.0-rc4-syzkaller-17255-ga6b443748715 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : d_flags_for_inode fs/dcache.c:1980 [inline]
pc : __d_instantiate+0x2a0/0x2e4 fs/dcache.c:1998
lr : d_flags_for_inode fs/dcache.c:1979 [inline]
lr : __d_instantiate+0x80/0x2e4 fs/dcache.c:1998
sp : ffff8000126f3ac0
x29: ffff8000126f3ac0 x28: 0000000040000000 x27: ffff0000cd3a0000
x26: ffff80000cf0e000 x25: fffffc0000000000 x24: 000000000001f000
x23: ffff0000cd3a0000 x22: 0000000000000008 x21: 0000000000000000
x20: ffff0000ca50ce48 x19: ffff0000c7732750 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c4f13500
x14: 00000000000000b8 x13: 00000000ffffffff x12: ffff0000c4f13500
x11: ff808000085e2a88 x10: 0000000000000000 x9 : ffff0000c4f13500
x8 : 0000000000000000 x7 : ffff8000085e2e0c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 d_flags_for_inode fs/dcache.c:1980 [inline]
 __d_instantiate+0x2a0/0x2e4 fs/dcache.c:1998
 d_instantiate fs/dcache.c:2036 [inline]
 d_make_root+0x64/0xa8 fs/dcache.c:2071
 ntfs_fill_super+0x1420/0x14a4 fs/ntfs/super.c:180
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: 79000688 52a00417 17ffff83 f9401288 (f9400508) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	79000688 	strh	w8, [x20, #2]
   4:	52a00417 	mov	w23, #0x200000              	// #2097152
   8:	17ffff83 	b	0xfffffffffffffe14
   c:	f9401288 	ldr	x8, [x20, #32]
* 10:	f9400508 	ldr	x8, [x8, #8] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
