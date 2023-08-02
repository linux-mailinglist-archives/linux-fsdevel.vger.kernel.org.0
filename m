Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E53376C36D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 05:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjHBDSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 23:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjHBDR6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:17:58 -0400
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109B91BC1
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 20:17:57 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6bc56f23c65so12073898a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 20:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690946276; x=1691551076;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzxFr6VpXvMxKNFLgx6TDRiLSMqJZ6TE1M1VLYF6do8=;
        b=JgEafGH5/KjNAiFJAeg+tR8L4gVMML1bQoIjeBp0kC3Zm6ZqXf6k5yJNAuOptGyWKm
         GmIRFYs6Epf8l/cYIcN1DaNLZ6P8FTHVckJxrMPzvTp9rblxQv4Ni0/oNVQOYUARTevW
         DpeANhNI9q2n8M1lNySfobuzv47axQHxyx9PCW2+221f3JUbWiIYYVOu70gpPNcf1VJi
         6xuB2u8HpyXkC5CLzOaj04Hu+N/+djv0R2UtG0AVEjlnPVhJgz6dGP2FsrQxBfFc7pDr
         Sm/F/CoyzQfEEHIHWO0m53JYy4EbDSENnCw3n6DQzIqM04CoXYAlXkfy+MSwT5GCCJNp
         ppRg==
X-Gm-Message-State: ABy/qLZz+3RQyGtY76HfIRTMSdyFdviv5tV0NVYtp2u+JXcEm74Hhqsx
        Iz2QVf+/+gPoNEZr9ONDTd1Q5BjOEQ2C+VCef5Lvk13FTYwV
X-Google-Smtp-Source: APBJJlHYSiWk1s84nzGXaiDRqCmJvLbWn9fU2bS1lPgH8xcVht8nfT5jDIjzaH939nXj/ITRs9MVHAI7XLRnYqy6fG3SqfgFHysL
MIME-Version: 1.0
X-Received: by 2002:a05:6830:138a:b0:6b8:c631:5c5a with SMTP id
 d10-20020a056830138a00b006b8c6315c5amr15549784otq.4.1690946276448; Tue, 01
 Aug 2023 20:17:56 -0700 (PDT)
Date:   Tue, 01 Aug 2023 20:17:56 -0700
In-Reply-To: <000000000000672c810601db3e84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000245f470601e81cbc@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_cancel_balance
From:   syzbot <syzbot+d6443e1f040e8d616e7b@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    5d0c230f1de8 Linux 6.5-rc4
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ccaa4da80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e3d5175079af5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=d6443e1f040e8d616e7b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1167e711a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a90161a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e60219ddf5b3/disk-5d0c230f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d843603af783/vmlinux-5d0c230f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a0a1cdcb2de2/bzImage-5d0c230f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6a80485ad7a0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6443e1f040e8d616e7b@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/btrfs/volumes.c:4642!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5103 Comm: syz-executor303 Not tainted 6.5.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:btrfs_cancel_balance+0x429/0x430 fs/btrfs/volumes.c:4641
Code: e8 1c 31 01 00 4c 89 ef 48 c7 c6 80 fa 4a 8b e8 2d 17 24 07 e9 ef fe ff ff e8 93 ab 25 07 e8 2e f2 f4 fd 0f 0b e8 27 f2 f4 fd <0f> 0b 0f 1f 44 00 00 f3 0f 1e fa 55 48 89 e5 41 57 41 56 41 55 41
RSP: 0018:ffffc90003edfdc0 EFLAGS: 00010293
RAX: ffffffff8396b559 RBX: ffff888072810010 RCX: ffff88801fa88000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffffc90003edfed0 R08: ffff8880728113d3 R09: 1ffff1100e50227a
R10: dffffc0000000000 R11: ffffed100e50227b R12: 1ffff920007dbfc0
R13: ffff888072811468 R14: dffffc0000000000 R15: ffff888072811460
FS:  00007faef2e626c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faef2a1a000 CR3: 000000001a7bc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_ioctl_balance_ctl+0x3f/0x70 fs/btrfs/ioctl.c:3632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faefa2c65f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faef2e62218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007faefa352618 RCX: 00007faefa2c65f9
RDX: 0000000000000002 RSI: 0000000040049421 RDI: 0000000000000004
RBP: 00007faefa352610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007faefa31f26c
R13: 0030656c69662f2e R14: 7573617461646f6e R15: 61635f7261656c63
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_cancel_balance+0x429/0x430 fs/btrfs/volumes.c:4641
Code: e8 1c 31 01 00 4c 89 ef 48 c7 c6 80 fa 4a 8b e8 2d 17 24 07 e9 ef fe ff ff e8 93 ab 25 07 e8 2e f2 f4 fd 0f 0b e8 27 f2 f4 fd <0f> 0b 0f 1f 44 00 00 f3 0f 1e fa 55 48 89 e5 41 57 41 56 41 55 41
RSP: 0018:ffffc90003edfdc0 EFLAGS: 00010293
RAX: ffffffff8396b559 RBX: ffff888072810010 RCX: ffff88801fa88000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffffc90003edfed0 R08: ffff8880728113d3 R09: 1ffff1100e50227a
R10: dffffc0000000000 R11: ffffed100e50227b R12: 1ffff920007dbfc0
R13: ffff888072811468 R14: dffffc0000000000 R15: ffff888072811460
FS:  00007faef2e626c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe38b00e58 CR3: 000000001a7bc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
