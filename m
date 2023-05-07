Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2447F6F96F4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 07:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjEGFRm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 01:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjEGFRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 01:17:40 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F4E6598
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 22:17:39 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-32b5ec09cffso20442595ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 22:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683436658; x=1686028658;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQEIoXH7rI2rkjwK+Q3rGkXe8qUJqhRvHYWEBWQWkwQ=;
        b=NyRxmMZwq/qIGFt9JM3QqwxUfYji/aGQBINTT3rRLWRPy1h6DpfD0QHE0Q9m6D5LGK
         +6gMuDTcMYGC6Hrn4ay0T4kcAAWvw2IsU9rkP7sB9NudJtGC3J4JEGwBiC9uEXxxRuTc
         RMFkhh+N+y/Qiz9qM8U9T/j4HorOcmGHxbIUWWm9eMrFcb4ls4o6EfMOCpgr+Y8cnZSj
         nxPWaKXiqFtSexbJpzHOEHfDXQTbmTvhKrIyJVt/zBA1xAlPyO2hLVK3jv3ZeSD0eHzD
         0Eu+MQlmWELWSPraT9v0neoKvCKCx5bf86+EUeQsFx8v1fv6N/0r4V4+AC7Nc3FegoTV
         iY8g==
X-Gm-Message-State: AC+VfDxbvKDyULhyFhKeuBvDtanSA6lQls2T7lErXmZ5ZxlrO+VPyeEA
        rpzq1Hxpq8bQJRkihp1Kbh3msgFcbg9dSwuSL6E2GYQqK8Ib
X-Google-Smtp-Source: ACHHUZ6q0fO6ZGps2gW9lc74ojab2R1y51uBFIbGNd0dwIWcAhHZZNiEPiixMxE4UQxQ5JZv4TxmdO/W5HdhDIibMNHfJDx+nfvQ
MIME-Version: 1.0
X-Received: by 2002:a02:2a89:0:b0:40b:c2f7:1ef9 with SMTP id
 w131-20020a022a89000000b0040bc2f71ef9mr2863548jaw.0.1683436658534; Sat, 06
 May 2023 22:17:38 -0700 (PDT)
Date:   Sat, 06 May 2023 22:17:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008aee505fb13a425@google.com>
Subject: [syzbot] [mm?] [ntfs3?] kernel panic: stack is corrupted in save_stack
From:   syzbot <syzbot+b58594b2f7f31155af24@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org,
        almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    92e815cf07ed Add linux-next specific files for 20230428
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1732ed8c280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8c8ae4d47d23592
dashboard link: https://syzkaller.appspot.com/bug?extid=b58594b2f7f31155af24
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122a8fdbc80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ed8e2c280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c9e94856e6c9/disk-92e815cf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4c1c05a548a7/vmlinux-92e815cf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a1bff6a133b/bzImage-92e815cf.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/91d376f7ef76/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b58594b2f7f31155af24@syzkaller.appspotmail.com

Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: save_stack+0x1c8/0x1e0 mm/page_owner.c:135
CPU: 1 PID: 5038 Comm: syz-executor216 Not tainted 6.3.0-next-20230428-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 panic+0x686/0x730 kernel/panic.c:340
 __stack_chk_fail+0x19/0x20 kernel/panic.c:759
 save_stack+0x1c8/0x1e0 mm/page_owner.c:135
 __set_page_owner+0x1f/0x60 mm/page_owner.c:192
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0xf7c/0x2aa0 mm/page_alloc.c:3502
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2277
 push_anon lib/iov_iter.c:245 [inline]
 append_pipe+0x19a/0x660 lib/iov_iter.c:302
 copy_pipe_to_iter lib/iov_iter.c:479 [inline]
 _copy_to_iter+0x463/0x1370 lib/iov_iter.c:533
 copy_page_to_iter lib/iov_iter.c:740 [inline]
 copy_page_to_iter+0xe8/0x170 lib/iov_iter.c:727
 copy_folio_to_iter include/linux/uio.h:197 [inline]
 filemap_read+0x682/0xc70 mm/filemap.c:2742
 generic_file_read_iter+0x3ad/0x5b0 mm/filemap.c:2837
 ntfs_file_read_iter+0x1b8/0x270 fs/ntfs3/file.c:744
 call_read_iter include/linux/fs.h:1862 [inline]
 generic_file_splice_read+0x182/0x4b0 fs/splice.c:422
 do_splice_to+0x1b9/0x240 fs/splice.c:905
 splice_direct_to_actor+0x2ab/0x8a0 fs/splice.c:976
 do_splice_direct+0x1ab/0x280 fs/splice.c:1085
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5c56defc49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff58272038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 000000000001419a RCX: 00007f5c56defc49
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007fff58272060 R09: 00007fff58272060
R10: 00008400fffffffa R11: 0000000000000246 R12: 00007fff5827205c
R13: 00007fff58272090 R14: 00007fff58272070 R15: 0000000000000004
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


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
