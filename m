Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A39733E63
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 07:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjFQFbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jun 2023 01:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjFQFbA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jun 2023 01:31:00 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6E31FD7
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 22:30:54 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-340bd414eb5so12514285ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 22:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686979854; x=1689571854;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKSRELDmcJqxfwVUFKf+7p+z3BH0HyEe5s50qS4EyFg=;
        b=W2dl/888IhshwK65pCM5Hh0eRqUDevNGuabUVl5hpQbUCM1vvhDYEmeV5vEVbDUSaf
         1qcwKEB6xryZjmdBEBNOrXQv62IcR++5U1/AM5eIITJjaswzMrIDyRj1sBXnL4QgWevy
         hpZ55RQFrbID62mK0v7eSDsInzeFudsXJtMZ0duSatoAfSc0rYW3WKfBtH5qrxYYDF9M
         0mJTP8+70tYLvXl1AyJ/v9jDwXa/G0w8ZMV6QDLtz10cvF040IxSbuBVga00UzItPerE
         w0zXGQU0aPBq7fXtZqjnQphyzzxlS7SMj9kZIpvIpZ8yiGw+QdofMkiPdNy+sIGQUyut
         wYUA==
X-Gm-Message-State: AC+VfDwB0gmr26VejIS0VMB9D8WL9+GaSG2sXB93ybgam3nGpqCUs9f8
        0NRDuXgYZ0Q2tHIstO5tFDRtwj7xcX5cI0qdn5ssvNtWM5KV
X-Google-Smtp-Source: ACHHUZ4Nzq+tx2Y+JJKYx+8g11AgEgpHJN4CiJy9kJgbs4gHgb513dMIgEPDq2Za3oSFLnb5tc33baQicTxxDa/hf19lBxoGp/g1
MIME-Version: 1.0
X-Received: by 2002:a92:da48:0:b0:33b:f0ca:fd14 with SMTP id
 p8-20020a92da48000000b0033bf0cafd14mr1027014ilq.0.1686979853936; Fri, 16 Jun
 2023 22:30:53 -0700 (PDT)
Date:   Fri, 16 Jun 2023 22:30:53 -0700
In-Reply-To: <0000000000007d069905f284b9d9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000efee7905fe4c9a46@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfsplus_bnode_put
From:   syzbot <syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fmdefrancesco@gmail.com,
        ira.weiny@intel.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, slava@dubeyko.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10482ae3280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e
dashboard link: https://syzkaller.appspot.com/bug?extid=005d2a9ecd9fbf525f6a
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142e7287280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fd185b280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/073eea957569/disk-40f71e7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c8a97aaa4cdc/vmlinux-40f71e7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f536015eacbd/bzImage-40f71e7c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b5f1764cd64d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
------------[ cut here ]------------
kernel BUG at fs/hfsplus/bnode.c:618!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5068 Comm: syz-executor476 Not tainted 6.4.0-rc6-syzkaller-00195-g40f71e7cd3c6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:hfsplus_bnode_put+0x6b7/0x6d0 fs/hfsplus/bnode.c:618
Code: ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 6c fd ff ff 48 89 df e8 ca 5a 81 ff e9 5f fd ff ff e8 50 83 29 ff 0f 0b e8 49 83 29 ff <0f> 0b e8 42 83 29 ff 0f 0b e8 3b 83 29 ff 0f 0b 66 0f 1f 84 00 00
RSP: 0018:ffffc90003c1f510 EFLAGS: 00010293
RAX: ffffffff8261fc57 RBX: ffff888012ad7180 RCX: ffff888014385940
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8261f620 R09: ffffed100255ae31
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888012ad7100
R13: dffffc0000000000 R14: ffff8880283d4000 R15: dffffc0000000000
FS:  00007f26ad319700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f26ad31a000 CR3: 000000001fab8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hfsplus_bmap_alloc+0x590/0x640 fs/hfsplus/btree.c:414
 hfs_bnode_split+0xde/0x1110 fs/hfsplus/brec.c:245
 hfsplus_brec_insert+0x3a6/0xdd0 fs/hfsplus/brec.c:100
 hfsplus_create_cat+0xeee/0x1bb0 fs/hfsplus/catalog.c:308
 hfsplus_mknod+0x16a/0x2a0 fs/hfsplus/dir.c:494
 vfs_create+0x1e2/0x330 fs/namei.c:3194
 do_mknodat+0x3c6/0x6e0 fs/namei.c:4043
 __do_sys_mknodat fs/namei.c:4071 [inline]
 __se_sys_mknodat fs/namei.c:4068 [inline]
 __x64_sys_mknodat+0xa9/0xc0 fs/namei.c:4068
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f26ad36d769
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f26ad3192f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000103
RAX: ffffffffffffffda RBX: 00007f26ad3f27a0 RCX: 00007f26ad36d769
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 00000000ffffff9c
RBP: 00007f26ad3bf0c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000103 R11: 0000000000000246 R12: 00007f26ad3bf1c0
R13: 0073756c70736668 R14: e5652d70fedcf551 R15: 00007f26ad3f27a8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfsplus_bnode_put+0x6b7/0x6d0 fs/hfsplus/bnode.c:618
Code: ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 6c fd ff ff 48 89 df e8 ca 5a 81 ff e9 5f fd ff ff e8 50 83 29 ff 0f 0b e8 49 83 29 ff <0f> 0b e8 42 83 29 ff 0f 0b e8 3b 83 29 ff 0f 0b 66 0f 1f 84 00 00
RSP: 0018:ffffc90003c1f510 EFLAGS: 00010293
RAX: ffffffff8261fc57 RBX: ffff888012ad7180 RCX: ffff888014385940
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8261f620 R09: ffffed100255ae31
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888012ad7100
R13: dffffc0000000000 R14: ffff8880283d4000 R15: dffffc0000000000
FS:  00007f26ad319700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f26ad31a000 CR3: 000000001fab8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
