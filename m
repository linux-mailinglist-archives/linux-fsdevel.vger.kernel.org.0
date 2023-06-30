Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCA3743F04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjF3Pga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjF3PgN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:36:13 -0400
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1C644B5
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 08:35:59 -0700 (PDT)
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-1b7f2239a04so19360655ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 08:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688139359; x=1690731359;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dyyxruTMgopIXxdq7yS3dZbyVMmnSUAsRW7YyXZLY08=;
        b=OgaucRpFYarQf7jIC+o2LMfn4obHjhU2QDWCPlhDAjAeLImTaWHuvAH6KhpmKDrgP0
         Lt7H+Q92qvyxSAJ64FAl3JijwWLpeIK2LZRUgq546P+ZywedX9nmM1K5itQmgCenGi6+
         2YTWfcUoE6jCqjqZ3h4xW2zU8uy2n+t7rLxlC0IajrtZjO+4c23YKcFoDWxiFfBOAbTP
         eEC2x1WQdJWBrXybitqPsUXHmvjz5tzcmDI5H8sR8zYWPJcdOwjY0MPFZpsvDcWtWk4u
         KvQXwMYKWa9dFH0OZ8vo96V+8E5eIHraNFqL8JJxwvVKct84SZOPirXdF8xy2nQ2Jjux
         S92Q==
X-Gm-Message-State: ABy/qLaFkSKF6XDwiqnygSor+PPAw4Vavewjxq4QnD5LutaUqBBjZdZH
        R8oCkU98PpVK5CmGicHSMFT9ht3xxWpDxmqVB3FzecGzLJ1i
X-Google-Smtp-Source: APBJJlF3ebJXLQIKZoe1XjMHV+bDnSpB2G7tCRRVY0FsjVs3HnS8Mcfz1+mB+wK3rEHqq5cM7DZ096OzP8ks0MB2fk8QdFq9R3h+
MIME-Version: 1.0
X-Received: by 2002:a17:903:258b:b0:1b8:550f:9e8 with SMTP id
 jb11-20020a170903258b00b001b8550f09e8mr1723833plb.3.1688139359033; Fri, 30
 Jun 2023 08:35:59 -0700 (PDT)
Date:   Fri, 30 Jun 2023 08:35:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d39fe305ff5a928f@google.com>
Subject: [syzbot] [selinux?] [reiserfs?] KASAN: wild-memory-access Read in inode_doinit_with_dentry
From:   syzbot <syzbot+4cdfeccf2cf6f8ab36a4@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, eparis@parisplace.org, gpiccoli@igalia.com,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, reiserfs-devel@vger.kernel.org,
        selinux@vger.kernel.org, stephen.smalley.work@gmail.com,
        syzkaller-bugs@googlegroups.com, tony.luck@intel.com
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

HEAD commit:    6995e2de6891 Linux 6.4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d58757280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9536c93ce7915e58
dashboard link: https://syzkaller.appspot.com/bug?extid=4cdfeccf2cf6f8ab36a4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b33b57280000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-6995e2de.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/95b0ee5a267d/vmlinux-6995e2de.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0e7c613d4a73/bzImage-6995e2de.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/86bf2b608923/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4cdfeccf2cf6f8ab36a4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: wild-memory-access in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: wild-memory-access in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: wild-memory-access in __lock_acquire+0xf3d/0x5f30 kernel/locking/lockdep.c:5058
Read of size 8 at addr 1fffffff86b9d550 by task syz-executor.2/5155

CPU: 3 PID: 5155 Comm: syz-executor.2 Not tainted 6.4.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_report mm/kasan/report.c:465 [inline]
 kasan_report+0xec/0x130 mm/kasan/report.c:572
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0x141/0x190 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 __lock_acquire+0xf3d/0x5f30 kernel/locking/lockdep.c:5058
 lock_acquire kernel/locking/lockdep.c:5705 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 inode_doinit_with_dentry+0x1026/0x12d0 security/selinux/hooks.c:1510
 selinux_d_instantiate+0x27/0x30 security/selinux/hooks.c:6225
 security_d_instantiate+0x54/0xe0 security/security.c:3760
 d_instantiate fs/dcache.c:2034 [inline]
 d_instantiate+0x5e/0xa0 fs/dcache.c:2030
 __debugfs_create_file+0x20f/0x5e0 fs/debugfs/inode.c:445
 debugfs_hw_add+0x28b/0x370 net/mac80211/debugfs.c:670
 ieee80211_register_hw+0x23e3/0x40e0 net/mac80211/main.c:1395
 mac80211_hwsim_new_radio+0x26c1/0x4c10 drivers/net/wireless/virtual/mac80211_hwsim.c:5294
 hwsim_new_radio_nl+0xacf/0x1210 drivers/net/wireless/virtual/mac80211_hwsim.c:5974
 genl_family_rcv_msg_doit.isra.0+0x1e6/0x2d0 net/netlink/genetlink.c:968
 genl_family_rcv_msg net/netlink/genetlink.c:1048 [inline]
 genl_rcv_msg+0x4ff/0x7e0 net/netlink/genetlink.c:1065
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2546
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1913
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 __sys_sendto+0x23a/0x340 net/socket.c:2144
 __do_sys_sendto net/socket.c:2156 [inline]
 __se_sys_sendto net/socket.c:2152 [inline]
 __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2152
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f717603e2ac
Code: fa fa ff ff 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 20 fb ff ff 48 8b
RSP: 002b:00007ffe75814790 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f7176cd4620 RCX: 00007f717603e2ac
RDX: 0000000000000024 RSI: 00007f7176cd4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffe758147e4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007f7176cd4670 R14: 0000000000000003 R15: 0000000000000000
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
