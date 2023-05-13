Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748F070180F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 May 2023 17:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239560AbjEMPdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 May 2023 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbjEMPdm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 May 2023 11:33:42 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1481930C4
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 May 2023 08:33:40 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-331514f5626so73809815ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 May 2023 08:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683992019; x=1686584019;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAgvi+hKTLEvn6404KesPduiFToAEOmz//Bkp7rH+nU=;
        b=eWFTfxmt2SsrbWFqeibDc3gK92kqVV0aWau8hunB+MT6XjynwH5PQz9CyAcL4bppEx
         WVElBCIjzI3rm0RSVQpbCbQiws9YnP5v+ebL25V/gSZB8ZTETGBSt6egyr1W+p3OEKhC
         kkpMr8r/eseCyYuOwMly2BbTlihT4PXdUx9wkQjsiAq6nQkDgTrqGXNWK+JubO2Rz/GA
         Cq1qlgFWL5k4CP4Ws193S/pala/NkoHSk80pJq2mO3fhrXmgqb+/fyhAt9vszgYfPHj2
         L1HVOIn2mEZuBRsGCNOO8F5Lr6BOfxb9L6g2lFUr68W4xWBAeKZwLt6+8LMpIW6/B/5L
         Nb1A==
X-Gm-Message-State: AC+VfDzoCVsJ7LHX+SiMveLLRYaWGDdyfQWG7LtJIB0qlPrpYfx7rqdO
        Edz862tkfUhFKUSoLZ33SUcKAgI4McPLwOTFJykTBzuB+Gnn
X-Google-Smtp-Source: ACHHUZ7WytFWQeobYVerIwdatJX6lGAhpMCO3F93mqFX77Q584A1/EoJwZsBLR6NU652JTvQTVBGlBEyM2Q/pNhB7E0NLqW9KtKB
MIME-Version: 1.0
X-Received: by 2002:a92:b106:0:b0:335:ba2a:c3d with SMTP id
 t6-20020a92b106000000b00335ba2a0c3dmr6483049ilh.5.1683992019328; Sat, 13 May
 2023 08:33:39 -0700 (PDT)
Date:   Sat, 13 May 2023 08:33:39 -0700
In-Reply-To: <00000000000013dee605f4fedf8b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001de64005fb94f2f1@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: null-ptr-deref Read in txBegin
From:   syzbot <syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mirimmad17@gmail.com, mirimmad@outlook.com, shaggy@kernel.org,
        skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    14f8db1c0f9a Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12f5764e280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a837a8ba7e88bb45
dashboard link: https://syzkaller.appspot.com/bug?extid=f1faa20eec55e0c8644c
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b9e24e280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105d3e46280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad6ce516eed3/disk-14f8db1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f38c2cc7667/vmlinux-14f8db1c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d795115eee39/Image-14f8db1c.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/014681b264cc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com

WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
Unable to handle kernel paging request at virtual address dfff800000000008
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
[dfff800000000008] address between user and kernel address ranges
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 5926 Comm: syz-executor228 Not tainted 6.3.0-rc7-syzkaller-g14f8db1c0f9a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : generic_test_bit include/asm-generic/bitops/generic-non-atomic.h:128 [inline]
pc : txBegin+0x138/0x5e0 fs/jfs/jfs_txnmgr.c:366
lr : txBegin+0x104/0x5e0 fs/jfs/jfs_txnmgr.c:357
sp : ffff80001eb37660
x29: ffff80001eb37680 x28: dfff800000000000 x27: dfff800000000000
x26: ffff800016308bc8 x25: 0000000000000040 x24: 0000000000000000
x23: ffff800016306520 x22: ffff0000d6a57c30 x21: 0000000000000150
x20: 0000000000000008 x19: 0000000000000000 x18: ffff80001eb37360
x17: ffff800008ad82e4 x16: ffff80000831ae40 x15: 000000000000bb8c
x14: 000000003eb35159 x13: dfff800000000000 x12: ffff700003d66eb4
x11: 0000000000000001 x10: 0000000000000000 x9 : 0000000000000000
x8 : 1ffff00002c5f670 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff800019238f80 x4 : 0000000000000008 x3 : ffff80000831af70
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 txBegin+0x138/0x5e0 fs/jfs/jfs_txnmgr.c:362
 __jfs_xattr_set+0xc8/0x190 fs/jfs/xattr.c:915
 jfs_xattr_set+0x58/0x70 fs/jfs/xattr.c:941
 __vfs_setxattr+0x3d8/0x400 fs/xattr.c:203
 __vfs_setxattr_noperm+0x110/0x528 fs/xattr.c:237
 __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:298
 vfs_setxattr+0x1a8/0x344 fs/xattr.c:324
 do_setxattr fs/xattr.c:609 [inline]
 setxattr+0x208/0x29c fs/xattr.c:632
 path_setxattr+0x17c/0x258 fs/xattr.c:651
 __do_sys_setxattr fs/xattr.c:667 [inline]
 __se_sys_setxattr fs/xattr.c:663 [inline]
 __arm64_sys_setxattr+0xbc/0xd8 fs/xattr.c:663
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: 9400012e aa1703e0 95954bf6 350002f8 (387c6a88) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	9400012e 	bl	0x4b8
   4:	aa1703e0 	mov	x0, x23
   8:	95954bf6 	bl	0x6552fe0
   c:	350002f8 	cbnz	w24, 0x68
* 10:	387c6a88 	ldrb	w8, [x20, x28] <-- trapping instruction


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
