Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5747466BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 03:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjGDBGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 21:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGDBGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 21:06:53 -0400
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA62184
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 18:06:52 -0700 (PDT)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-67c2f6fb908so5112979b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jul 2023 18:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688432812; x=1691024812;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqZVw5iy9wm+NL6G7zzWaylrTMrQYUH43hi2qTIk1Ts=;
        b=HvLOGL4tj3kM8RnDv2aidJ3j/VhSumh85cK3vsBMZ+be3xDFQ+bHhtICY3pcS5P3Tu
         IplFzwFvrcnR0mX9zroCe22DGNRG8RRjUHiNso8mHT8k3Dzfp03rDaiBcEX1tTYQeNos
         NsDLNGjSXc8lbD4fo/P3yq7qdcycTk3VbLBIn1KAExsoqXHOP64uGXaVyfqzKpJNwuL9
         EOctHu3TxCDCeuKPRv8WEckDnmtr9+h49v4hTEJtGt1HxTHyU3SBxjFBK2SKIerVDL5D
         rxTE5JGo7phxEMkJn/Xz+3AxHHT6UoeZbpOjExTOxPSxNTnrPwzWqVYj2xfwpQb1hRlz
         pErg==
X-Gm-Message-State: ABy/qLbIp/Oh9Nl1UnEhXYSenohtIQNYBu1OsahdufUni9G6b8Bev8B7
        4nVrRtUjdzMWFCD+jEc4dYaw+QRUX1uext0GHvkMs1ui0+4n
X-Google-Smtp-Source: APBJJlElPLL/AetUqQqU7MX319VXijTlocQI8/GI7xxAScL6T0rnQOgBUqOKuR7rqGuJ8dydi8La6krGKkGsJ7MVTMIITPun9/iU
MIME-Version: 1.0
X-Received: by 2002:aa7:88d6:0:b0:67a:fe8f:83f8 with SMTP id
 k22-20020aa788d6000000b0067afe8f83f8mr14610406pff.5.1688432811787; Mon, 03
 Jul 2023 18:06:51 -0700 (PDT)
Date:   Mon, 03 Jul 2023 18:06:51 -0700
In-Reply-To: <0000000000001b4f6505fd59fb12@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f94c8005ff9ee5c4@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in __ext4_ioctl
From:   syzbot <syzbot+a537ff48a9cb940d314c@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=131dbb80a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12d3428a307a1111
dashboard link: https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1489ffb8a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145c302ca80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d5b4ad8feb6a/disk-a901a356.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b59c91556f58/vmlinux-a901a356.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dcd583b21e5c/bzImage-a901a356.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/45e4aa281996/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a537ff48a9cb940d314c@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "&ei->i_data_sem" with key __key.0, but found a different class "&ei->i_data_sem" with the same key
WARNING: CPU: 1 PID: 5185 at kernel/locking/lockdep.c:940 look_up_lock_class+0xac/0x130 kernel/locking/lockdep.c:940
Modules linked in:
CPU: 1 PID: 5185 Comm: syz-executor404 Not tainted 6.4.0-syzkaller-10173-ga901a3568fd2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:look_up_lock_class+0xac/0x130 kernel/locking/lockdep.c:940
Code: 39 48 8b 55 00 48 81 fa a0 b9 48 90 74 2c 80 3d d3 f3 75 04 00 75 23 48 c7 c7 40 6e 6c 8a c6 05 c3 f3 75 04 01 e8 a4 2f 2e f7 <0f> 0b eb 0c e8 ab 5b f5 f9 85 c0 75 48 45 31 e4 48 83 c4 08 4c 89
RSP: 0018:ffffc90003e5f808 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffffffff92256381 RCX: 0000000000000000
RDX: ffff888021afd940 RSI: ffffffff814c24f7 RDI: 0000000000000001
RBP: ffff8880745ce688 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff918a84f0
R13: 0000000000000001 R14: ffff8880745ce688 R15: 0000000000000000
FS:  0000555557100300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9070243138 CR3: 0000000015297000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 register_lock_class+0xbe/0x1120 kernel/locking/lockdep.c:1292
 __lock_acquire+0x109/0x5e20 kernel/locking/lockdep.c:5021
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
 down_write_nested+0x96/0x200 kernel/locking/rwsem.c:1689
 ext4_double_down_write_data_sem+0x67/0x80 fs/ext4/move_extent.c:58
 swap_inode_boot_loader fs/ext4/ioctl.c:423 [inline]
 __ext4_ioctl+0x2942/0x4650 fs/ext4/ioctl.c:1427
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x19d/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f90701d1249
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdf78879a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 69662f7375622f2e RCX: 00007f90701d1249
RDX: 0000000000000000 RSI: 0000000000006611 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffdf78879d0 R09: 00007ffdf78879d0
R10: 00007ffdf7887420 R11: 0000000000000246 R12: 00007ffdf78879cc
R13: 00007ffdf7887a20 R14: 00007ffdf78879e0 R15: 000000000000003d
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
