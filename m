Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48434768694
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jul 2023 19:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjG3RH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 13:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG3RH6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:07:58 -0400
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AE910DF
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 10:07:57 -0700 (PDT)
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-565893ef956so5214307eaf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 10:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690736877; x=1691341677;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9vqfGmyOwEWs7LNdvGwPbGUY0I/3aqKJVRSebRF0Hw=;
        b=fzacQmVzkJQtl2gQEV04ne6RXNeR/WmstMqNZQi5cSE3nIjZDexj81BbAYsshNnsQ4
         OprNtRQzUQT+Oh09HZmBRb94Q7bOoOGro5B9ztrC80narwYQOrsVTWXBxjuRxv13e5Jy
         bczWoSKMiTF6uIdsWfpijv9Wm1HaxJq5z6gq3Sh3jYrUKO6upfrKdYRqXlAstzm3MxwL
         VV5VM+m5x+9EMNrjIkSemGCZAFQwiMcLRUi1RKun//u5qRklSZpUiLBtCnNc1xha9P1T
         ZLdbQllSWbhwV7sU6G7TEJg11Z/H8UfK62XiN+XvZp+ZO1xo5WuBcBYSZ6la2O06FhZv
         VLlA==
X-Gm-Message-State: ABy/qLbNpWW+vcVBuORpUIRSMvmpf+PgKrAgTeXlVSxiaqTZy8W2t7fv
        iwH0HO6g8Ml+bTxGVlls3ZVoDxnHbmg0zEAtxxRQyLMlrks7
X-Google-Smtp-Source: APBJJlFEFPjxuV31812GyI4xDhE5rXq/ScX8K056ndvulUKc1AymUgQvC0H0TbZUGEz1hebbvWrJgmQwsYyN/se+4PTg5jOA3Je+
MIME-Version: 1.0
X-Received: by 2002:a05:6808:17a4:b0:39e:ced7:602b with SMTP id
 bg36-20020a05680817a400b0039eced7602bmr14547448oib.2.1690736876717; Sun, 30
 Jul 2023 10:07:56 -0700 (PDT)
Date:   Sun, 30 Jul 2023 10:07:56 -0700
In-Reply-To: <000000000000a3d67705ff730522@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f20fc00601b75a80@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
From:   syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    d31e3792919e Merge tag '6.5-rc3-smb3-client-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17afd745a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d670a4f6850b6f4
dashboard link: https://syzkaller.appspot.com/bug?extid=ae97a827ae1c3336bbb4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15278939a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14dd3f31a80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d31e3792.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c6c2342933c9/vmlinux-d31e3792.xz
kernel image: https://storage.googleapis.com/syzbot-assets/42df60b42886/bzImage-d31e3792.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/78ffd1ddff6c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com

BTRFS info (device loop1): relocating block group 5242880 flags data|metadata
assertion failed: root->reloc_root == reloc_root, in fs/btrfs/relocation.c:1919
------------[ cut here ]------------
kernel BUG at fs/btrfs/relocation.c:1919!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 12638 Comm: syz-executor311 Not tainted 6.5.0-rc3-syzkaller-00297-gd31e3792919e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:prepare_to_merge+0x9cc/0xcd0 fs/btrfs/relocation.c:1919
Code: c5 e9 81 fd ff ff e8 e3 59 00 fe b9 7f 07 00 00 48 c7 c2 40 d9 b6 8a 48 c7 c6 20 e6 b6 8a 48 c7 c7 a0 da b6 8a e8 54 bc e3 fd <0f> 0b 4c 8b 7c 24 38 48 8b 5c 24 10 44 8b 6c 24 0c e8 ae 59 00 fe
RSP: 0018:ffffc90023e176d0 EFLAGS: 00010282
RAX: 000000000000004f RBX: ffff88801e898560 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81698120 RDI: 0000000000000005
RBP: ffff88801e898558 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 6f69747265737361 R12: dffffc0000000000
R13: ffff88801e898000 R14: ffff88802d944000 R15: ffff888017616618
FS:  00007fb31aba26c0(0000) GS:ffff88806b600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb31ac3a758 CR3: 000000002e1dc000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 relocate_block_group+0x8d1/0xe70 fs/btrfs/relocation.c:3749
 btrfs_relocate_block_group+0x714/0xd90 fs/btrfs/relocation.c:4087
 btrfs_relocate_chunk+0x143/0x440 fs/btrfs/volumes.c:3283
 __btrfs_balance fs/btrfs/volumes.c:4018 [inline]
 btrfs_balance+0x20fc/0x3ef0 fs/btrfs/volumes.c:4395
 btrfs_ioctl_balance fs/btrfs/ioctl.c:3604 [inline]
 btrfs_ioctl+0x1362/0x5cf0 fs/btrfs/ioctl.c:4637
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb31abe6e49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb31aba2168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb31ac73728 RCX: 00007fb31abe6e49
RDX: 00000000200003c0 RSI: 00000000c4009420 RDI: 0000000000000005
RBP: 00007fb31ac73720 R08: 00007fb31aba26c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb31ac7372c
R13: 0000000000000006 R14: 00007ffe768d5660 R15: 00007ffe768d5748
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:prepare_to_merge+0x9cc/0xcd0 fs/btrfs/relocation.c:1919
Code: c5 e9 81 fd ff ff e8 e3 59 00 fe b9 7f 07 00 00 48 c7 c2 40 d9 b6 8a 48 c7 c6 20 e6 b6 8a 48 c7 c7 a0 da b6 8a e8 54 bc e3 fd <0f> 0b 4c 8b 7c 24 38 48 8b 5c 24 10 44 8b 6c 24 0c e8 ae 59 00 fe
RSP: 0018:ffffc90023e176d0 EFLAGS: 00010282
RAX: 000000000000004f RBX: ffff88801e898560 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81698120 RDI: 0000000000000005
RBP: ffff88801e898558 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 6f69747265737361 R12: dffffc0000000000
R13: ffff88801e898000 R14: ffff88802d944000 R15: ffff888017616618
FS:  00007fb31aba26c0(0000) GS:ffff88806b600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb31ac3a758 CR3: 000000002e1dc000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
