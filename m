Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E42E744E50
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 17:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGBPZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 11:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGBPZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 11:25:03 -0400
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF8FE67
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jul 2023 08:25:01 -0700 (PDT)
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-262f7a3bc80so4751493a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jul 2023 08:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688311501; x=1690903501;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVi90bVdhDhHrv1hOyRkeWClh+SrPWe4I4jxHii48pI=;
        b=OOsoCeYdYYl8o+laRBagjOtu3RXqFuNywczJtREpLCKXl/TXPgVxF+y7rxfsD3THuE
         R0O12HI6GD/+mhDz1gVcRcmfRMt3u32FUROnPX+AwzFNVHTB6+MR4IXnzrw8MPgRay9O
         VCMyhSW9P2zds6ZvGJ/deiy4HaB1Tth2KIDorJW6vyE1aj+zXO+E0tXTQZwS9nc3yflS
         Z7NapP5cNpAxGdli2CbZ8ntke5a4VN0Ttxd0Wjgkht8yoYl1B2w4MKcZGg1rMnqsGAav
         9uqOtigH2yxBfdrHl64lQ+B/7NOjM7KcUx5tRpVRyHJPxfn+6bP5ksaR70nu4N+Tf/MR
         s/Aw==
X-Gm-Message-State: ABy/qLatr5E4jrv6I1r1r2pfjZbEFMSAPxFyPMhSutYb8uKcKfRU7ehl
        MIac/tcWUep+TFwX8wBDksS6pZYKfqUN62TQzj/it2jbMEBg
X-Google-Smtp-Source: APBJJlGlo52aN0k88SOj5tWHpgSVkGmHRxkoy9lHKvk3R/YTSqO426XHN7xWBwwvpOs0MoDnCE26pHnQJF4EgsTwkPzZ7gDD4DzF
MIME-Version: 1.0
X-Received: by 2002:a17:90a:13c8:b0:263:2f09:20c3 with SMTP id
 s8-20020a17090a13c800b002632f0920c3mr5595730pjf.9.1688311501333; Sun, 02 Jul
 2023 08:25:01 -0700 (PDT)
Date:   Sun, 02 Jul 2023 08:25:01 -0700
In-Reply-To: <00000000000046238c05f69776ab@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004eab7a05ff82a700@google.com>
Subject: Re: [syzbot] [ntfs?] kernel BUG in ntfs_end_buffer_async_read
From:   syzbot <syzbot+72ba5fe5556d82ad118b@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    dfab92f27c60 Merge tag 'nfs-for-6.5-1' of git://git.linux-..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=137d57bf280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71a52faf60231bc7
dashboard link: https://syzkaller.appspot.com/bug?extid=72ba5fe5556d82ad118b
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c987eca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144a738f280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/32f183ec0f2c/disk-dfab92f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e8f47f491184/vmlinux-dfab92f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad90306c0fe6/bzImage-dfab92f2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bcae16df5190/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72ba5fe5556d82ad118b@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ntfs/aops.c:130!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 21 Comm: ksoftirqd/1 Not tainted 6.4.0-syzkaller-10096-gdfab92f27c60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:ntfs_end_buffer_async_read+0xc7f/0x1540 fs/ntfs/aops.c:130
Code: ff e8 95 97 c8 fe 4c 89 ff 48 c7 c6 e0 6b 3a 8b e8 86 3b 09 ff 0f 0b e8 7f 97 c8 fe 0f 0b e8 78 97 c8 fe 0f 0b e8 71 97 c8 fe <0f> 0b e8 6a 97 c8 fe 4c 89 ff e8 b2 99 ff ff 48 89 c7 48 c7 c6 20
RSP: 0018:ffffc900001b7b10 EFLAGS: 00010246
RAX: ffffffff82c35a7f RBX: 0000000000000010 RCX: ffff888014e59dc0
RDX: 0000000080000100 RSI: 0000000000020211 RDI: 0000000000001000
RBP: ffff8880771e8270 R08: ffffffff82c3547a R09: 1ffff1100ee3d00a
R10: dffffc0000000000 R11: ffffed100ee3d00b R12: 0000000000000000
R13: 0000000000020211 R14: 0000000000000001 R15: ffffea0001d76500
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc42b480940 CR3: 00000000219c3000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 end_bio_bh_io_sync+0xb7/0x110 fs/buffer.c:2794
 req_bio_endio block/blk-mq.c:766 [inline]
 blk_update_request+0x53f/0x1020 block/blk-mq.c:911
 blk_mq_end_request+0x50/0x310 block/blk-mq.c:1032
 blk_complete_reqs block/blk-mq.c:1110 [inline]
 blk_done_softirq+0x103/0x150 block/blk-mq.c:1115
 __do_softirq+0x2ab/0x908 kernel/softirq.c:553
 run_ksoftirqd+0xc5/0x120 kernel/softirq.c:921
 smpboot_thread_fn+0x533/0x9f0 kernel/smpboot.c:164
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ntfs_end_buffer_async_read+0xc7f/0x1540 fs/ntfs/aops.c:130
Code: ff e8 95 97 c8 fe 4c 89 ff 48 c7 c6 e0 6b 3a 8b e8 86 3b 09 ff 0f 0b e8 7f 97 c8 fe 0f 0b e8 78 97 c8 fe 0f 0b e8 71 97 c8 fe <0f> 0b e8 6a 97 c8 fe 4c 89 ff e8 b2 99 ff ff 48 89 c7 48 c7 c6 20
RSP: 0018:ffffc900001b7b10 EFLAGS: 00010246
RAX: ffffffff82c35a7f RBX: 0000000000000010 RCX: ffff888014e59dc0
RDX: 0000000080000100 RSI: 0000000000020211 RDI: 0000000000001000
RBP: ffff8880771e8270 R08: ffffffff82c3547a R09: 1ffff1100ee3d00a
R10: dffffc0000000000 R11: ffffed100ee3d00b R12: 0000000000000000
R13: 0000000000020211 R14: 0000000000000001 R15: ffffea0001d76500
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc42b480940 CR3: 00000000219c3000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
