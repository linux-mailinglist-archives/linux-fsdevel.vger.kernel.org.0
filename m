Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92CA721E1D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 08:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjFEG35 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 02:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjFEG3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:29:51 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84456E9
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jun 2023 23:29:49 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7773997237cso292864939f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jun 2023 23:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685946589; x=1688538589;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUHCYHCQGFfhYTTdvTw67xUh6Ra/HASzGHnIUUBVZvs=;
        b=hhTeokAdw4pH6jjXXRLGBNFw5PwKeVUy7koPMvHrIgoKwaQ8lXB1u7YCObXMCc/HiB
         rWi/2mqNDi0Ns/Evfv8nmCH1cJtUi28G+vIi1w8v8qoFtYJDwvxVp9Dhz4hvkMwQnqFx
         xbCmu3ILvzYmrpDIRAAArTi8offcrJ9wBYCkApQ1ap+GNwfj7XPCglP30sGaIw8lh0Z9
         eTmAAPpsTKfiDaGswlqFS965+/mN/xSp8T5sthT97w0iFAdPEZIxZdeh3vCtMKTxjUCd
         vpN25/5/qaWLHrrDx4T/BNh3PHQLKXioVzOJeOlXJGUQxXJs5yfDqs+mZI7gHT3pJTpu
         tMpQ==
X-Gm-Message-State: AC+VfDza1sPyhPduVo81jFQXkAAootVL3Yrr9x9GQf5RWig7sQP4GZU6
        JriuWw43ZUV76GhR9XpBgw4knwlIShOfaKG+hv8hIetK0BVL
X-Google-Smtp-Source: ACHHUZ6CpQY6/nhpixHKSUJP4bvunSWx3RsiYuFZIR7iX/hnDnOK6q7XuRjQ13FMlGfCQy6b/y+IhedI9iGS3qWZbOXdgfTDiAmG
MIME-Version: 1.0
X-Received: by 2002:a92:d3c7:0:b0:335:de72:23c7 with SMTP id
 c7-20020a92d3c7000000b00335de7223c7mr6895308ilh.5.1685946588865; Sun, 04 Jun
 2023 23:29:48 -0700 (PDT)
Date:   Sun, 04 Jun 2023 23:29:48 -0700
In-Reply-To: <000000000000d1149605fd5b0c0d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a2bc505fd5c07a0@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in ext4_ioctl
From:   syzbot <syzbot+a3c8e9ac9f9d77240afd@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    9561de3a55be Linux 6.4-rc5
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=146868c9280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ff6e93280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11824101280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7890258233e8/disk-9561de3a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/693d68681275/vmlinux-9561de3a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0f62a882fdf3/bzImage-9561de3a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3fc2f5d70218/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3c8e9ac9f9d77240afd@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "&ei->i_data_sem" with key init_once.__key.780, but found a different class "&ei->i_data_sem" with the same key
WARNING: CPU: 1 PID: 5249 at kernel/locking/lockdep.c:941 look_up_lock_class+0xc2/0x140 kernel/locking/lockdep.c:938
Modules linked in:
CPU: 1 PID: 5249 Comm: syz-executor251 Not tainted 6.4.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:look_up_lock_class+0xc2/0x140 kernel/locking/lockdep.c:938
Code: 8b 16 48 c7 c0 60 91 1e 90 48 39 c2 74 46 f6 05 5d 02 92 03 01 75 3d c6 05 54 02 92 03 01 48 c7 c7 a0 ae ea 8a e8 de 8a a3 f6 <0f> 0b eb 26 e8 f5 d0 80 f9 48 c7 c7 e0 ad ea 8a 89 de e8 37 ca fd
RSP: 0018:ffffc900041bf590 EFLAGS: 00010046
RAX: 30aff147e011a400 RBX: ffffffff9006b360 RCX: ffff8880177bd940
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900041bf698 R08: ffffffff81530142 R09: ffffed1017325163
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000001
R13: 1ffff92000837ec0 R14: ffff888075bfc888 R15: ffffffff91cac681
FS:  0000555555be9300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc6cdfc6138 CR3: 000000002b756000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0x104/0x990 kernel/locking/lockdep.c:1290
 __lock_acquire+0xd3/0x2070 kernel/locking/lockdep.c:4965
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5705
 down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1689
 swap_inode_boot_loader fs/ext4/ioctl.c:423 [inline]
 __ext4_ioctl fs/ext4/ioctl.c:1418 [inline]
 ext4_ioctl+0x453c/0x5b60 fs/ext4/ioctl.c:1608
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc6cdf53a19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb4dc9718 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 69662f7375622f2e RCX: 00007fc6cdf53a19
RDX: 0000000000000000 RSI: 0000000000006611 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffdb4dc9740 R09: 00007ffdb4dc9740
R10: 00007ffdb4dc9190 R11: 0000000000000246 R12: 00007ffdb4dc973c
R13: 00007ffdb4dc9770 R14: 00007ffdb4dc9750 R15: 0000000000000052
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
