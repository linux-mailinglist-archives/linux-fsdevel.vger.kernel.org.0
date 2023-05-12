Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9AD7008EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 15:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbjELNQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 09:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241158AbjELNQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 09:16:11 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F110E14E48
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 06:15:44 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-331632be774so364406775ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 06:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683897344; x=1686489344;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dG2eApiQtw6EgBiB77e39j8L4/16nv2XSt+vqnLbeIk=;
        b=SPo5SITBauaTrkjJWVQzHV+cBNtvcbIxGMsBsx3J/cNQz5dtdfYOG7gdu2YAV1la+b
         JkMS4uoW2j98to42k86zfjYTn9FYsjmXRRVXamGcCPANoXgjeLS1CMVzmZfnJDxzsjsQ
         hRyAdgwfBPuM9eeqJgGJ+CqXWhEZ8SUeQlXeZra7hdSDhknfTeVRV0rCPr8/GvF//Z+C
         +fcHLTvO7S4e3e/980dEyj20XNJM98bdksXmfK1nb8s33n1ViU13TvXsRMs/bfygfKYS
         nva+dMODtsAr1m+S3NCwbvRO1Y6qZ518XShRdLSGHcn3FYB0RyinSbCe59mUBasGu8Qg
         wg6g==
X-Gm-Message-State: AC+VfDxLqeSFlFkXtfAFKeBNA3NxcNNgbJ7pYElNCogFvAy23NFVrmgN
        GzMKlTbDNVlosugNTx4yr4RE//tZEGKbHeoiWajFoK+ke2co
X-Google-Smtp-Source: ACHHUZ6lHUXFAvY3XmXJ5lxtlioqhGUNNrWs+dFObehrOfT4vuBYpMN/DzDPG77CXi7LeNN4wM01Cqu2bMych2sAdQHDkH0TnZ0F
MIME-Version: 1.0
X-Received: by 2002:a02:3546:0:b0:40f:8f07:e28e with SMTP id
 y6-20020a023546000000b0040f8f07e28emr7462886jae.1.1683897344175; Fri, 12 May
 2023 06:15:44 -0700 (PDT)
Date:   Fri, 12 May 2023 06:15:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009b58d05fb7ee7ad@google.com>
Subject: [syzbot] [ext4?] general protection fault in ext4_acquire_dquot
From:   syzbot <syzbot+e633c79ceaecbf479854@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
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

Hello,

syzbot found the following issue on:

HEAD commit:    14f8db1c0f9a Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13c79eca280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a837a8ba7e88bb45
dashboard link: https://syzkaller.appspot.com/bug?extid=e633c79ceaecbf479854
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130464fa280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13134234280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad6ce516eed3/disk-14f8db1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f38c2cc7667/vmlinux-14f8db1c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d795115eee39/Image-14f8db1c.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/aa1d3602f38e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e633c79ceaecbf479854@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address dfff800000000005
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
[dfff800000000005] address between user and kernel address ranges
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 6080 Comm: syz-executor747 Not tainted 6.3.0-rc7-syzkaller-g14f8db1c0f9a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ext4_acquire_dquot+0x1d4/0x398 fs/ext4/super.c:6766
lr : dquot_to_inode fs/ext4/super.c:6740 [inline]
lr : ext4_acquire_dquot+0x1ac/0x398 fs/ext4/super.c:6766
sp : ffff80001eb27280
x29: ffff80001eb27280 x28: 1fffe0001c3c01fc x27: ffff800015d705b0
x26: ffff0000dd93c000 x25: ffff0000dd93e000 x24: 1fffe0001c3c021c
x23: dfff800000000000 x22: 0000000000000049 x21: 0000000000000028
x20: 0000000000000000 x19: ffff0000e1e00fc0 x18: ffff0001b426cca8
x17: 0000000000000000 x16: ffff8000089669b0 x15: 0000000000000001
x14: 1ffff00002bae0b0 x13: dfff800000000000 x12: 0000000000000001
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : 0000000000000005 x7 : ffff800008c11f68 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800012441b4c
x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000003
Call trace:
 ext4_acquire_dquot+0x1d4/0x398 fs/ext4/super.c:6766
 dqget+0x844/0xc48 fs/quota/dquot.c:914
 __dquot_initialize+0x2cc/0xb54 fs/quota/dquot.c:1492
 dquot_initialize fs/quota/dquot.c:1550 [inline]
 dquot_file_open+0x90/0xc8 fs/quota/dquot.c:2181
 ext4_file_open+0x230/0x590 fs/ext4/file.c:903
 do_dentry_open+0x724/0xf90 fs/open.c:920
 vfs_open+0x7c/0x90 fs/open.c:1051
 do_open fs/namei.c:3560 [inline]
 path_openat+0x1f2c/0x27f8 fs/namei.c:3715
 do_filp_open+0x1bc/0x3cc fs/namei.c:3742
 do_sys_openat2+0x128/0x3d8 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_openat fs/open.c:1380 [inline]
 __se_sys_openat fs/open.c:1375 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1375
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: 97e8a7df f94002a8 9100a115 d343fea8 (38776908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97e8a7df 	bl	0xffffffffffa29f7c
   4:	f94002a8 	ldr	x8, [x21]
   8:	9100a115 	add	x21, x8, #0x28
   c:	d343fea8 	lsr	x8, x21, #3
* 10:	38776908 	ldrb	w8, [x8, x23] <-- trapping instruction


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
