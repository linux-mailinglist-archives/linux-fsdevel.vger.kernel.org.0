Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD87279D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 10:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjFHIVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 04:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbjFHIVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:21:10 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB512695
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 01:21:05 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-77a1335cf04so29208939f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 01:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686212464; x=1688804464;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFdbyfwK2zMGYrItzLYM26ey0ZOsA/HVPrlJVM9jIuY=;
        b=FjnLo2Z9r2tEBTWoqG9R7fwopKaHPzahZ4D7bjVvJrFJauqiAw63fAi0o7pQZ27lTQ
         mUMzX4yK+3XprVRXvjuDBkw8F6N7mu8n2VJ3NcV2Nw+ScXm5R7zvHcuBdI+JVMwaA6j8
         /4Dqa9ERpNqiWnjGibRITG1VXbnOkadE3JJptPlHor1V7Zbq9dDH0DRiuN9+cdMbCgol
         kX7IoHjcNUCQN+i8puZ89MGZxaXXa4P1c2xkrgM8WQCdcXxPcNFuV7QgkTUrtziat0FX
         U+ChtfCE+lnUH/5MBr7UjtdPmqm6TQP49S06Q9OrssWUdZJXvQ1aOQIl8GcTNQivSMQJ
         UYiQ==
X-Gm-Message-State: AC+VfDwElyLKwEwrAI9Dxg2wuuJRXcyS8BQXVg6Rkj9ReaddqKZIrkDM
        6gwz2+OCW0WfxYyQ9QSwrXDYnsXxm28ndpOaJJdXzh9j/pLE
X-Google-Smtp-Source: ACHHUZ7FXmOjWdl7KkEzBBg3I9xfBGy5q7PZjPFyCeGv1SBAIDyPW3jZ7shSbKEUUndJ9d1EbuVVsklnqcWxqLRKVGq6CVuKk+Tn
MIME-Version: 1.0
X-Received: by 2002:a6b:e603:0:b0:777:b713:22b5 with SMTP id
 g3-20020a6be603000000b00777b71322b5mr3912686ioh.4.1686212464773; Thu, 08 Jun
 2023 01:21:04 -0700 (PDT)
Date:   Thu, 08 Jun 2023 01:21:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa8ea705fd99ee81@google.com>
Subject: [syzbot] [ntfs3?] WARNING in iov_iter_revert (4)
From:   syzbot <syzbot+5e732e5de356b7242fb8@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a4d7d7011219 Merge tag 'spi-fix-v6.4-rc5' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16c28ab3280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
dashboard link: https://syzkaller.appspot.com/bug?extid=5e732e5de356b7242fb8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ab7393280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11697e1b280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d4c310c7a76/disk-a4d7d701.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/918b9286fb09/vmlinux-a4d7d701.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a1c1f51764b3/bzImage-a4d7d701.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/55b5173d0801/mount_0.gz

The issue was bisected to:

commit 6e5be40d32fb1907285277c02e74493ed43d77fe
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Aug 13 14:21:30 2021 +0000

    fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16af0359280000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15af0359280000
console output: https://syzkaller.appspot.com/x/log.txt?x=11af0359280000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5e732e5de356b7242fb8@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

RBP: 00007fff19f23f20 R08: 0000000000000002 R09: 00007fff19f23f30
R10: 0000000100000000 R11: 0000000000000246 R12: 0000000000000005
R13: 00007fff19f23f60 R14: 00007fff19f23f40 R15: 0000000000000001
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5001 at lib/iov_iter.c:970 iov_iter_revert+0x59/0x60 lib/iov_iter.c:970
Modules linked in:
CPU: 0 PID: 5001 Comm: syz-executor145 Not tainted 6.4.0-rc5-syzkaller-00016-ga4d7d7011219 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:iov_iter_revert+0x59/0x60 lib/iov_iter.c:970
Code: 1d 6a 73 fd 48 81 fd 00 f0 ff 7f 77 18 e8 cf 6d 73 fd 48 89 ee 4c 89 e7 e8 84 f8 ff ff 5d 41 5c e9 bc 6d 73 fd e8 b7 6d 73 fd <0f> 0b eb ef 0f 1f 00 41 54 49 89 fc 55 53 e8 a4 6d 73 fd 49 8d 7c
RSP: 0018:ffffc90003adf968 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88807d889dc0 RSI: ffffffff8410d889 RDI: 0000000000000007
RBP: ffffffffffff1000 R08: 0000000000000007 R09: 000000007ffff000
R10: ffffffffffff1000 R11: 0000000000000001 R12: ffffc90003adfa60
R13: ffffc90003adfa60 R14: ffff888078367a78 R15: ffff88807a84d400
FS:  0000555556f46300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f62af0bc138 CR3: 000000001e80f000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 generic_file_read_iter+0x2b2/0x5b0 mm/filemap.c:2820
 ntfs_file_read_iter+0x1b8/0x270 fs/ntfs3/file.c:744
 call_read_iter include/linux/fs.h:1862 [inline]
 generic_file_splice_read+0x182/0x4b0 fs/splice.c:419
 do_splice_to+0x1b9/0x240 fs/splice.c:902
 splice_direct_to_actor+0x2ab/0x8a0 fs/splice.c:973
 do_splice_direct+0x1ab/0x280 fs/splice.c:1082
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f62af02a9f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff19f23ef8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f62af02a9f9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
RBP: 00007fff19f23f20 R08: 0000000000000002 R09: 00007fff19f23f30
R10: 0000000100000000 R11: 0000000000000246 R12: 0000000000000005
R13: 00007fff19f23f60 R14: 00007fff19f23f40 R15: 0000000000000001
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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
