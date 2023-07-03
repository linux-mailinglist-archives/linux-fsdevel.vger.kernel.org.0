Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124F97454B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 07:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjGCFK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 01:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGCFK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:10:58 -0400
Received: from mail-pf1-f207.google.com (mail-pf1-f207.google.com [209.85.210.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8472F1B1
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jul 2023 22:10:56 -0700 (PDT)
Received: by mail-pf1-f207.google.com with SMTP id d2e1a72fcca58-66ca9ef7850so4495853b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jul 2023 22:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688361056; x=1690953056;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4YgwqQw+JpJISLuLYsEf1BHzE6jomArvjGBNVJo9gEw=;
        b=kbkWz+hjPBw+t/5LuQ2yW4+dmRaLmDOExcavN53PG4S90A4SVXc0x0UmvoKH+Wui/I
         UJ8N5mlLkLd9GoKOp2VdBU1b7ryFkWa/wkXgq0rR8AmjAEz9m23fSfugupF1a6yIn/wD
         7swIIRO0KS0pVLuAn9/iDRbhZY5Sh3TGqlB0+zOcDeKr08UY+VsdTfcIw9E/+fnZi58H
         U0l6rBkBqXnvopBWBzuFMNXX6V2hupU5jrgDfr4C2gJnIPDTznumxw79M8XKpjeXlxYl
         jcEmHLuRzrSaozpf9wZccFyAyewsN7lmDb+Mt7O5rP9eTx4HVCeQRPKpLVT2oPaBkYaE
         FvfA==
X-Gm-Message-State: ABy/qLacmb88XP13tAkewOxOtpj98HEaKdXE8hkWAXoIqwScMzAK4lG7
        GyHfWFYSNt2XGGBURF0Uf+ggXKvoXXBz6hNLQdRc7ZF4d22b
X-Google-Smtp-Source: APBJJlHBwi9RPXMmLxjnT6KJHIY23HB9A0FdNupuJFMKG/FcW3AAqKLalXHqDYx+a+POlQvaxhvcLXnn2aoWgmpdGK4JKYycIjwX
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d9a:b0:676:50ce:7a12 with SMTP id
 fb26-20020a056a002d9a00b0067650ce7a12mr11651720pfb.1.1688361055767; Sun, 02
 Jul 2023 22:10:55 -0700 (PDT)
Date:   Sun, 02 Jul 2023 22:10:55 -0700
In-Reply-To: <000000000000a3d67705ff730522@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb51b905ff8e301e@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
From:   syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    995b406c7e97 Merge tag 'csky-for-linus-6.5' of https://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1172e02ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71a52faf60231bc7
dashboard link: https://syzkaller.appspot.com/bug?extid=ae97a827ae1c3336bbb4
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e6ddf0a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/01122b567c73/disk-995b406c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75b7a37e981e/vmlinux-995b406c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/758b5afcf092/bzImage-995b406c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/96451b8f418b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com

assertion failed: root->reloc_root == reloc_root, in fs/btrfs/relocation.c:1919
------------[ cut here ]------------
kernel BUG at fs/btrfs/relocation.c:1919!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7760 Comm: syz-executor.5 Not tainted 6.4.0-syzkaller-10098-g995b406c7e97 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:prepare_to_merge+0xbb2/0xc40 fs/btrfs/relocation.c:1919
Code: fe e9 f5 f7 ff ff e8 9d ab eb fd 48 c7 c7 a0 67 4b 8b 48 c7 c6 40 77 4b 8b 48 c7 c2 20 68 4b 8b b9 7f 07 00 00 e8 0e 7a 17 07 <0f> 0b e8 57 b9 19 07 f3 0f 1e fa e8 6e ab eb fd 43 80 3c 2f 00 74
RSP: 0018:ffffc9000bf47760 EFLAGS: 00010246
RAX: 000000000000004f RBX: ffff88807b35e030 RCX: ab28d7f10bef9500
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000bf47870 R08: ffffffff816f481c R09: 1ffff920017e8ea0
R10: dffffc0000000000 R11: fffff520017e8ea1 R12: ffff88807b35e000
R13: ffff888021ffc000 R14: ffff888021ffc560 R15: ffff888021ffc558
FS:  00007fef4adf9700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f846a5fe000 CR3: 000000001ec2d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 relocate_block_group+0xa5d/0xcd0 fs/btrfs/relocation.c:3749
 btrfs_relocate_block_group+0x7ab/0xd70 fs/btrfs/relocation.c:4087
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3283
 __btrfs_balance+0x1b06/0x2690 fs/btrfs/volumes.c:4018
 btrfs_balance+0xbdb/0x1120 fs/btrfs/volumes.c:4402
 btrfs_ioctl_balance+0x496/0x7c0 fs/btrfs/ioctl.c:3604
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fef4a08c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fef4adf9168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fef4a1abf80 RCX: 00007fef4a08c389
RDX: 00000000200003c0 RSI: 00000000c4009420 RDI: 0000000000000005
RBP: 00007fef4a0d7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffec9c8752f R14: 00007fef4adf9300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:prepare_to_merge+0xbb2/0xc40 fs/btrfs/relocation.c:1919
Code: fe e9 f5 f7 ff ff e8 9d ab eb fd 48 c7 c7 a0 67 4b 8b 48 c7 c6 40 77 4b 8b 48 c7 c2 20 68 4b 8b b9 7f 07 00 00 e8 0e 7a 17 07 <0f> 0b e8 57 b9 19 07 f3 0f 1e fa e8 6e ab eb fd 43 80 3c 2f 00 74
RSP: 0018:ffffc9000bf47760 EFLAGS: 00010246
RAX: 000000000000004f RBX: ffff88807b35e030 RCX: ab28d7f10bef9500
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000bf47870 R08: ffffffff816f481c R09: 1ffff920017e8ea0
R10: dffffc0000000000 R11: fffff520017e8ea1 R12: ffff88807b35e000
R13: ffff888021ffc000 R14: ffff888021ffc560 R15: ffff888021ffc558
FS:  00007fef4adf9700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f22c0e44000 CR3: 000000001ec2d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
