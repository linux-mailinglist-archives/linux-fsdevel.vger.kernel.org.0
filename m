Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E3A76B822
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 16:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjHAO6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjHAO6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:58:46 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1EC1BC7
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 07:58:44 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a3b86821fcso9551094b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 07:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690901923; x=1691506723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eD2DE6Q5xR8gtuxafv2Kboi3j35MZYfHhwZE2hkFuqY=;
        b=QSFd0AyzX0MMhxY8xcPn/LPe8zNP1ABAe2Cf4+bT+rqmR4IgGjKxJ5m4SVTL71u1Uj
         ph8ONGco9eBnv2dzeOu5g4OJh/3GizfZ3d/0Lapso2Nj1fzShap/Yl+lYHGZsl+7xOg6
         SOZ1U5TU7/LryQ6zJ35SrHCu+SaYdj9VigB1/VOQUq0WFaEQSA5ICauBpcIDeRgyqCUR
         MVarEnVP5aLeFEf6WVSjcJIzid1dKXddsjq7IUFMJhWMIfQ+XGi4iZd3w/XSSFK/wlAa
         NC+Xu/yPdjc2esxOiARvoM24NSZVf2m0PInygycbgSdZ0q6z4ceJr75n4aDcKtg1KD1X
         fU9Q==
X-Gm-Message-State: ABy/qLbzsZb2ZXW7tZxyo0DdbfUCPJ+n82zTehUdUQUcLbzhV3AzGZ8z
        M59Tj9SVSXuCw9W0P9/yOjiWwYrh08fIBn3NLWCfULGI+ze+
X-Google-Smtp-Source: APBJJlGTVitSuEggKreVcl3ASkKPycDrxtzIs36wr2DufsQEr/KD7r4NjQE0aQPLxQQM0MVGeo8kKWwWk5oqK8YPuWDZ1shQmGo3
MIME-Version: 1.0
X-Received: by 2002:a05:6808:228f:b0:3a7:57:1c26 with SMTP id
 bo15-20020a056808228f00b003a700571c26mr17418951oib.2.1690901923570; Tue, 01
 Aug 2023 07:58:43 -0700 (PDT)
Date:   Tue, 01 Aug 2023 07:58:43 -0700
In-Reply-To: <CANp29Y5vZZN0a3NOhk6N2HR89dzQ30xJYdhqZO5C0fsC+C0sKA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000812c200601ddc8de@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
From:   syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nogikh@google.com,
        quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in prepare_to_merge

BTRFS error (device loop3): reloc tree mismatch, root 8 has no reloc root, expect reloc root key (-8, 132, 8) gen 17
------------[ cut here ]------------
BTRFS: Transaction aborted (error -117)
WARNING: CPU: 1 PID: 10413 at fs/btrfs/relocation.c:1946 prepare_to_merge+0x10e0/0x1460 fs/btrfs/relocation.c:1946
Modules linked in:
CPU: 1 PID: 10413 Comm: syz-executor.3 Not tainted 6.5.0-rc3-syzkaller-g9f2c8c9193cc #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:prepare_to_merge+0x10e0/0x1460 fs/btrfs/relocation.c:1946
Code: 8b 7e 50 44 89 e2 48 c7 c6 20 d8 b6 8a e8 58 1b 10 00 eb c1 e8 d1 83 00 fe be 8b ff ff ff 48 c7 c7 80 d7 b6 8a e8 f0 4b c7 fd <0f> 0b e9 bf fe ff ff 48 8b 7c 24 28 e8 af 93 53 fe e9 3e f5 ff ff
RSP: 0018:ffffc90003ebf6b0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8880478f2b78 RCX: 0000000000000000
RDX: ffff8880466c9300 RSI: ffffffff814c5346 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000046525442 R12: 0000000000000000
R13: 0000000000000084 R14: ffff8880478f2b28 R15: ffff888030e28000
FS:  00007fcc9098a6c0(0000) GS:ffff88806b700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc90968f28 CR3: 000000001fa0c000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 relocate_block_group+0x8d1/0xe70 fs/btrfs/relocation.c:3782
 btrfs_relocate_block_group+0x714/0xd90 fs/btrfs/relocation.c:4120
 btrfs_relocate_chunk+0x143/0x440 fs/btrfs/volumes.c:3277
 __btrfs_balance fs/btrfs/volumes.c:4012 [inline]
 btrfs_balance+0x20fc/0x3ef0 fs/btrfs/volumes.c:4389
 btrfs_ioctl_balance fs/btrfs/ioctl.c:3604 [inline]
 btrfs_ioctl+0x1362/0x5cf0 fs/btrfs/ioctl.c:4637
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcc8fc7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcc9098a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fcc8fd9bf80 RCX: 00007fcc8fc7cae9
RDX: 00000000200003c0 RSI: 00000000c4009420 RDI: 0000000000000005
RBP: 00007fcc8fcc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fcc8fd9bf80 R15: 00007ffd6ad55508
 </TASK>


Tested on:

commit:         9f2c8c91 btrfs: exit gracefully if reloc roots don't m..
git tree:       https://github.com/adam900710/linux graceful_reloc_mismatch
console output: https://syzkaller.appspot.com/x/log.txt?x=173afb31a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23c579cf0ae1addd
dashboard link: https://syzkaller.appspot.com/bug?extid=ae97a827ae1c3336bbb4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
