Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8857A401A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 06:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbjIREll (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 00:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239472AbjIRElQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 00:41:16 -0400
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEDDEA
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 21:41:09 -0700 (PDT)
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-573a7a3c405so6042611eaf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 21:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695012068; x=1695616868;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Njj1cFpFl6P5XczNJtRHj5unyeppmn930r6gY5zCeN0=;
        b=E4ehuWyQvNfyZMO2IX9/ZYN/h9b1qsHJA0hpneqI54xJa9eCk9BkOAZGn8gAaH/Nbm
         yTFS1nZNH1WeWqwbL/1PzKt3mV2etBNHV72//gYIre/OCrfrDFotzQsLHR8XNocyQMsv
         UKf1dvZ16A4tW2YRC7vqVBkBLl1d0pdksnvBvaPLVK5KxHdkwoRPdRl4G+mowrRKwBKm
         0eSlp/K0WJrKB2srCzHjWZPT4o4e04x1Pvmx1VP7iip9rUKJe1uAV8DqVFmDh6u2bMY3
         VJsULA1VivsktbcpnFEdFbab+JECpgIuP/+1ey1QQfc3nAAehGFvYKRipCfhiFp5lXx/
         HU/w==
X-Gm-Message-State: AOJu0Yw6BdtJaxVxijUv0ukb9ewVt7XCmKg3VueeG1MVIb2DpxzaQ2Sj
        rZpTgTZ3+ruVjf2j95qMAdjzwI+qukqGBuXXQulsPOky/wNo
X-Google-Smtp-Source: AGHT+IH36LNEUnGMAeMXmlQNVH5WxS7Mii7fn4raTyMmtgevC5fZjJjZojnKRU5aBVH1N1s8pW7OLTunfCts9ukRd1orioKhlr0A
MIME-Version: 1.0
X-Received: by 2002:a4a:4fd7:0:b0:571:1df7:c13f with SMTP id
 c206-20020a4a4fd7000000b005711df7c13fmr3109792oob.1.1695012068423; Sun, 17
 Sep 2023 21:41:08 -0700 (PDT)
Date:   Sun, 17 Sep 2023 21:41:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a7ffb06059ac0dd@google.com>
Subject: [syzbot] [fs?] [mm?] WARNING in page_copy_sane
From:   syzbot <syzbot+c225dea486da4d5592bd@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        sidhartha.kumar@oracle.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    98897dc735cf Add linux-next specific files for 20230914
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1548728c680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1502c503717ada5c
dashboard link: https://syzkaller.appspot.com/bug?extid=c225dea486da4d5592bd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171fffd8680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bbbf1c680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/00e4c0af5a8a/disk-98897dc7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b54a00eee56/vmlinux-98897dc7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/100094353b8e/bzImage-98897dc7.xz

The issue was bisected to:

commit 591a2520fbfd6565d9a5c732afa53f62228798e6
Author: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Date:   Mon Sep 11 21:53:19 2023 +0000

    mm/filemap: remove hugetlb special casing in filemap.c

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e15464680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17e15464680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e15464680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c225dea486da4d5592bd@syzkaller.appspotmail.com
Fixes: 591a2520fbfd ("mm/filemap: remove hugetlb special casing in filemap.c")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5040 at lib/iov_iter.c:463 page_copy_sane+0xc2/0x2c0 lib/iov_iter.c:463
Modules linked in:
CPU: 1 PID: 5040 Comm: syz-executor204 Not tainted 6.6.0-rc1-next-20230914-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:page_copy_sane+0xc2/0x2c0 lib/iov_iter.c:463
Code: e8 73 db 63 fd 66 90 e8 6c db 63 fd e8 67 db 63 fd 4c 89 ee 48 89 ef e8 6c d6 63 fd 49 39 ed 0f 83 eb 00 00 00 e8 4e db 63 fd <0f> 0b 31 db e8 45 db 63 fd 89 d8 5b 5d 41 5c 41 5d 41 5e 41 5f c3
RSP: 0018:ffffc90003eefa58 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88807a01d940 RSI: ffffffff84241482 RDI: 0000000000000006
RBP: 0000000000200000 R08: 0000000000000006 R09: 0000000000201000
R10: 0000000000200000 R11: 0000000000000000 R12: 0000000000000009
R13: 0000000000201000 R14: 0000000000000001 R15: ffffea0001fe0000
FS:  0000555556937380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200001c0 CR3: 000000002911d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 copy_page_to_iter+0x35/0x180 lib/iov_iter.c:472
 hugetlbfs_read_iter+0x3d7/0xa60 fs/hugetlbfs/inode.c:385
 call_read_iter include/linux/fs.h:1980 [inline]
 do_iter_readv_writev+0x2f2/0x3c0 fs/read_write.c:733
 do_iter_read+0x315/0x870 fs/read_write.c:795
 vfs_readv+0x12d/0x1a0 fs/read_write.c:915
 do_preadv fs/read_write.c:1007 [inline]
 __do_sys_preadv fs/read_write.c:1057 [inline]
 __se_sys_preadv fs/read_write.c:1052 [inline]
 __x64_sys_preadv+0x228/0x300 fs/read_write.c:1052
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f85cc7932e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda50bbbd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007ffda50bbdb8 RCX: 00007f85cc7932e9
RDX: 0000000000000002 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00007f85cc806610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffda50bbda8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
