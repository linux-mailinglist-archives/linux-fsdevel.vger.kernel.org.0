Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017AB7117CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 22:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjEYUD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 16:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjEYUD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 16:03:57 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73878B2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 13:03:55 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3318938ea0bso1216905ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 13:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685045034; x=1687637034;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOyGkFoZn20LeX23mewfkZotpLoPgdrgq2gxJUVaJOY=;
        b=AyfnTrWMaB1NsGEcmFe9fXB2GCKX621WF7fnU7OR2kxIxvZRD1id4NtNv5fMaQdEmc
         xI9SGdCV9o8YiDtDUbt8Z+VFDAmFnaDMlHJGJp0kTOqseoRz+7Nx1Fx0rKoD0YKL56zf
         rdRvWLCC4l+doRosZ3Yvc0HfL6YFEDw8aBCWVw6IFB+URWcVRQopQolYp9VPm2rrnWPW
         3GCQySxH8xILxSFx/hslkoqDcZYA1KOCZH0gUghkrxMC1sAYbDCx2vHXMQlwGZ52E9J/
         1fPjdr/aVqOZ6Fbhkpip/kyn2Jb4Q3BpuLzT7V+8ZTU5ey4on1eCfa/UzwUK9tsStZw0
         /7LQ==
X-Gm-Message-State: AC+VfDzddzTdE0SM1USeMy9SdvKT9svQ3yY85S+JMcMiYNDosrVsxN6x
        EkotOffPf4Cf9NzcJLEfzv4Aq5QdUF4ZXCYcurNTDK4bFD5pQigpPA==
X-Google-Smtp-Source: ACHHUZ6bwwg8XrzxjTSNmRHCXa4VcYcD2IJ9cqOt3fnT0Ni8umAcO3F7rGvp0rNy82hjWA7mm1FUHbzmvrI3Otgpvn69c87jJ0e9
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2f:b0:32b:fc:52b1 with SMTP id
 e15-20020a056e020b2f00b0032b00fc52b1mr3353775ilu.0.1685045034755; Thu, 25 May
 2023 13:03:54 -0700 (PDT)
Date:   Thu, 25 May 2023 13:03:54 -0700
In-Reply-To: <0000000000005cf71b05f9818cc2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba2ea605fc8a1e3e@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: wild-memory-access Read in hfsplus_bnode_dump
From:   syzbot <syzbot+f687659f3c2acfa34201@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    933174ae28ba Merge tag 'spi-fix-v6.4-rc3' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1716f189280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8067683055e3f5
dashboard link: https://syzkaller.appspot.com/bug?extid=f687659f3c2acfa34201
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13582a4d280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e6d339280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/189d556c105e/disk-933174ae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/498458304963/vmlinux-933174ae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/68bcd9d7c04c/bzImage-933174ae.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a584867d6b9f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f687659f3c2acfa34201@syzkaller.appspotmail.com

memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=4993 'syz-executor106'
loop0: detected capacity change from 0 to 1024
hfsplus: request for non-existent node 32768 in B*Tree
hfsplus: request for non-existent node 32768 in B*Tree
==================================================================
BUG: KASAN: wild-memory-access in memcpy_from_page include/linux/highmem.h:417 [inline]
BUG: KASAN: wild-memory-access in hfsplus_bnode_read fs/hfsplus/bnode.c:32 [inline]
BUG: KASAN: wild-memory-access in hfsplus_bnode_read_u16 fs/hfsplus/bnode.c:45 [inline]
BUG: KASAN: wild-memory-access in hfsplus_bnode_dump+0x403/0xba0 fs/hfsplus/bnode.c:305
Read of size 2 at addr 000508800000103e by task syz-executor106/4993

CPU: 0 PID: 4993 Comm: syz-executor106 Not tainted 6.4.0-rc3-syzkaller-00032-g933174ae28ba #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/16/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_report+0xe6/0x540 mm/kasan/report.c:465
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 memcpy_from_page include/linux/highmem.h:417 [inline]
 hfsplus_bnode_read fs/hfsplus/bnode.c:32 [inline]
 hfsplus_bnode_read_u16 fs/hfsplus/bnode.c:45 [inline]
 hfsplus_bnode_dump+0x403/0xba0 fs/hfsplus/bnode.c:305
 hfsplus_brec_remove+0x42c/0x4f0 fs/hfsplus/brec.c:229
 __hfsplus_delete_attr+0x275/0x450 fs/hfsplus/attributes.c:299
 hfsplus_delete_all_attrs+0x26b/0x3c0 fs/hfsplus/attributes.c:378
 hfsplus_delete_cat+0xb87/0xfc0 fs/hfsplus/catalog.c:425
 hfsplus_unlink+0x363/0x7f0 fs/hfsplus/dir.c:385
 vfs_unlink+0x35d/0x5f0 fs/namei.c:4327
 do_unlinkat+0x4a7/0x950 fs/namei.c:4393
 __do_sys_unlink fs/namei.c:4441 [inline]
 __se_sys_unlink fs/namei.c:4439 [inline]
 __x64_sys_unlink+0x49/0x50 fs/namei.c:4439
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5196975789
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc9b401ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5196975789
RDX: 00007f5196933e03 RSI: 0000000000000000 RDI: 0000000020000140
RBP: 00007f5196935020 R08: 0000000000000640 R09: 0000000000000000
R10: 00007ffc9b401bb0 R11: 0000000000000246 R12: 00007f51969350b0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
