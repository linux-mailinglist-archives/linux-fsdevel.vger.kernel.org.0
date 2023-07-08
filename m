Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C86874C009
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 01:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjGHXqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jul 2023 19:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGHXqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jul 2023 19:46:00 -0400
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7006E44
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Jul 2023 16:45:59 -0700 (PDT)
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-262dc0bab18so4070038a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Jul 2023 16:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688859959; x=1691451959;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtGIOjjW0NK4w3zexyBx9C56ZQ6+kb4jWbUShbqUlEs=;
        b=IDDPquOxCjsxhkHSv3mW3o+19/+bqWg+TdRpOe+ZrV23a6rHDNWBJW/DlNxRoNSGgk
         /LONnjDU4tpniuKb0DknKg+ftl1tHmOD0EDFANp/YaVu7lRj74AIRSUjB/FH+q9UlQRW
         bUC7l0sCMZ5rahkCGEukvbesHle8oM3qG0XWkDOI8IxM+RkbOEugNbNqUq88Iz/A8UBt
         0V11klrSdzXcy/Vp8N8+UCxdkTEYdymo9LWTQnf4Lq/ZCFRI3MI4p/LfWy0tIi/lE0Zh
         Xfc58C+b1XQ8m0c/Lt9abHD4mElpDgBMN5F5seRs3/N8VQz6YwMV9yfe3qvGKv46JpR7
         KKTA==
X-Gm-Message-State: ABy/qLZMNlbwpW8/tNRanydrDiTzZFQRqjgrCcxBzmj0ChZ85TVYD9or
        iP5h7vZUCUdPZdyX6xT6MT+L42U1zMqZhHXd4OMFhQSCPuPR
X-Google-Smtp-Source: APBJJlGQUP49auuqAXQaBht7UDlZWHVNeTZG9s0OesZ/cG8P6Z3RmxVeiE6DcrfWQ79lOuqG2SUZ667FzxsdNuv2zJZ5urdOykr5
MIME-Version: 1.0
X-Received: by 2002:a17:90b:1283:b0:263:f16:3192 with SMTP id
 fw3-20020a17090b128300b002630f163192mr7675131pjb.3.1688859959177; Sat, 08 Jul
 2023 16:45:59 -0700 (PDT)
Date:   Sat, 08 Jul 2023 16:45:59 -0700
In-Reply-To: <00000000000099887f05fdfc6e10@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1378f0600025915@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_split_extent_at (2)
From:   syzbot <syzbot+0f4d9f68fb6632330c6c@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    8689f4f2ea56 Merge tag 'mmc-v6.5-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b9cb02a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ad417033279f15a
dashboard link: https://syzkaller.appspot.com/bug?extid=0f4d9f68fb6632330c6c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13977778a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1004666aa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/21b63023cf5a/disk-8689f4f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e04836fe057e/vmlinux-8689f4f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee05dfd52843/bzImage-8689f4f2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e2ab005f1edb/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0f4d9f68fb6632330c6c@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/ext4_extents.h:200!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5885 Comm: syz-executor219 Not tainted 6.4.0-syzkaller-12365-g8689f4f2ea56 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
RIP: 0010:ext4_ext_mark_unwritten fs/ext4/ext4_extents.h:200 [inline]
RIP: 0010:ext4_split_extent_at+0xd11/0xe10 fs/ext4/extents.c:3221
Code: e9 d2 f8 ff ff e8 1f 6d 5d ff 66 81 c5 00 80 e9 32 fd ff ff e8 10 6d 5d ff 44 8d bd 00 80 ff ff e9 d1 fc ff ff e8 ff 6c 5d ff <0f> 0b 48 8b 7c 24 18 e8 73 9d b0 ff e9 7f f3 ff ff 48 89 cf e8 46
RSP: 0018:ffffc900055ef268 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88807d9c0000 RSI: ffffffff82277271 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88807587d00c
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88807587d012
FS:  00007f4820ae9700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4820ae8fe8 CR3: 0000000028105000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 ext4_split_extent+0x3fc/0x530 fs/ext4/extents.c:3384
 ext4_ext_handle_unwritten_extents fs/ext4/extents.c:3874 [inline]
 ext4_ext_map_blocks+0x2e22/0x5bc0 fs/ext4/extents.c:4166
 ext4_map_blocks+0x760/0x1890 fs/ext4/inode.c:621
 ext4_iomap_alloc fs/ext4/inode.c:3276 [inline]
 ext4_iomap_begin+0x43d/0x7a0 fs/ext4/inode.c:3326
 iomap_iter+0x446/0x10e0 fs/iomap/iter.c:91
 __iomap_dio_rw+0x6e3/0x1d80 fs/iomap/direct-io.c:574
 iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:665
 ext4_dio_write_iter fs/ext4/file.c:609 [inline]
 ext4_file_write_iter+0x1102/0x1880 fs/ext4/file.c:720
 call_write_iter include/linux/fs.h:1871 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x981/0xda0 fs/read_write.c:584
 ksys_write+0x122/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4828f26cd9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4820ae9208 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000034 RCX: 00007f4828f26cd9
RDX: 0000000000000012 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007f4828fa4790 R08: 00007f4828fa4798 R09: 00007f4828fa4798
R10: 00007f4828fa4798 R11: 0000000000000246 R12: 00007f4828fa479c
R13: 00007ffef851f96f R14: 00007f4820ae9300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_ext_mark_unwritten fs/ext4/ext4_extents.h:200 [inline]
RIP: 0010:ext4_split_extent_at+0xd11/0xe10 fs/ext4/extents.c:3221
Code: e9 d2 f8 ff ff e8 1f 6d 5d ff 66 81 c5 00 80 e9 32 fd ff ff e8 10 6d 5d ff 44 8d bd 00 80 ff ff e9 d1 fc ff ff e8 ff 6c 5d ff <0f> 0b 48 8b 7c 24 18 e8 73 9d b0 ff e9 7f f3 ff ff 48 89 cf e8 46
RSP: 0018:ffffc900055ef268 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88807d9c0000 RSI: ffffffff82277271 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88807587d00c
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88807587d012
FS:  00007f4820ae9700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffef85799a0 CR3: 0000000028105000 CR4: 0000000000350ee0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
