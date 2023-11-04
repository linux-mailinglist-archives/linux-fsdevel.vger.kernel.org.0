Return-Path: <linux-fsdevel+bounces-1978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3574A7E11D4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 00:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E5B9B20F07
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 23:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC963250FA;
	Sat,  4 Nov 2023 23:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419411732
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Nov 2023 23:58:26 +0000 (UTC)
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2983D6E
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Nov 2023 16:58:24 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3b51e0bd5c0so5121403b6e.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Nov 2023 16:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699142304; x=1699747104;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJcDmPdSGpB8slt2WoDpkuUtenpE1KuCjVriKZ4u9vQ=;
        b=DNTRol57qx/qxHzW1HtQBC3QEkGRS263v8N4fqe3OlnX5aws9x0/FR2+k/63dgx8KP
         LqWfiPjka6a+MxtRyNLDYAskFCNstvYPLA7ogKAZ+Ab4mxJzDWLB5HNhFVL71f5dGWi2
         wTV4M9u5JeKwjxEsBciax036cDyvdOnFSzmdxYcrMcnuiDcb5yDf2sFjRzaxopetC89m
         XKcGPKZDyymRdbipvSC0FcGqC3H0/ItrcoPy9lMbCaw5BDYsJAiy2gbVBoabMcwtF+6A
         4lIHDWH+JLv6bCW/W9ZkloNSBImo2qXsuoM8WUg4uTAa8uKrOfojSwH50Xp2UZDRez+c
         3EZA==
X-Gm-Message-State: AOJu0Yx4iPo58MNGu1oruBGzs03HCNLUAaalTaLy1f6P36e9JCjeoihn
	D3dwJ9MF6UjZJA1V5p0IKzTS0gk7R2XDDmBs75OzDckbkawM
X-Google-Smtp-Source: AGHT+IHBgY529NBiG2E+zwRJkXajwOzTjTdlwv4Z0a/euWkBcziDTp8wvQIFVrOVXNMS57IncmZM9dsDrHEKGltCsb2UZvYwuLzv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:19a8:b0:3a7:3737:60fd with SMTP id
 bj40-20020a05680819a800b003a7373760fdmr9386750oib.7.1699142304046; Sat, 04
 Nov 2023 16:58:24 -0700 (PDT)
Date: Sat, 04 Nov 2023 16:58:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074a35e06095c6558@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_try_granting_tickets
From: syzbot <syzbot+42e831f5d4d8616b0e8f@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5a6a09e97199 Merge tag 'cgroup-for-6.7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132ed3e3680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=414f578e7f8d77a7
dashboard link: https://syzkaller.appspot.com/bug?extid=42e831f5d4d8616b0e8f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bd30039dd1a9/disk-5a6a09e9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7dac0c0db854/vmlinux-5a6a09e9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d1318c50c57/bzImage-5a6a09e9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+42e831f5d4d8616b0e8f@syzkaller.appspotmail.com

assertion failed: space_info->reclaim_size >= ticket->bytes, in fs/btrfs/space-info.c:436
------------[ cut here ]------------
kernel BUG at fs/btrfs/space-info.c:436!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 25603 Comm: syz-executor.2 Not tainted 6.6.0-syzkaller-03860-g5a6a09e97199 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:remove_ticket fs/btrfs/space-info.c:436 [inline]
RIP: 0010:btrfs_try_granting_tickets+0x59f/0x5d0 fs/btrfs/space-info.c:468
Code: fe e9 ca fa ff ff e8 a0 ca d8 fd 48 c7 c7 e0 16 8d 8b 48 c7 c6 a0 1d 8d 8b 48 c7 c2 60 17 8d 8b b9 b4 01 00 00 e8 11 02 54 07 <0f> 0b e8 7a ca d8 fd 48 c7 c7 e0 16 8d 8b 48 c7 c6 40 17 8d 8b 48
RSP: 0018:ffffc90015f07188 EFLAGS: 00010246
RAX: 0000000000000059 RBX: ffffffffffff2000 RCX: 7562ac8ccb7a8d00
RDX: ffffc9000bd65000 RSI: 000000000000a0ff RDI: 000000000000a100
RBP: 0000000000060000 R08: ffffffff81716b8c R09: 1ffff92002be0dd0
R10: dffffc0000000000 R11: fffff52002be0dd1 R12: ffff8880293b90f0
R13: ffffc9000ac0f6e0 R14: dffffc0000000000 R15: 1ffff1100527721e
FS:  00007fca38d826c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f27f6881000 CR3: 00000000365f7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:232 [inline]
 block_rsv_release_bytes fs/btrfs/block-rsv.c:154 [inline]
 btrfs_block_rsv_release+0x506/0x5f0 fs/btrfs/block-rsv.c:295
 btrfs_delayed_refs_rsv_release+0x9f/0x110 fs/btrfs/delayed-ref.c:75
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:2038 [inline]
 __btrfs_run_delayed_refs+0x1e34/0x4810 fs/btrfs/extent-tree.c:2106
 btrfs_run_delayed_refs+0xe3/0x2c0 fs/btrfs/extent-tree.c:2218
 btrfs_commit_transaction+0x4ba/0x3730 fs/btrfs/transaction.c:2237
 sync_filesystem+0x1c0/0x220 fs/sync.c:66
 btrfs_remount+0x231/0x14b0 fs/btrfs/super.c:1649
 reconfigure_super+0x440/0x870 fs/super.c:1140
 do_remount fs/namespace.c:2884 [inline]
 path_mount+0xc24/0xfa0 fs/namespace.c:3656
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3863
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fca3807e1ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fca38d81ee8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fca38d81f80 RCX: 00007fca3807e1ea
RDX: 0000000020000180 RSI: 0000000020000140 RDI: 0000000000000000
RBP: 0000000020000180 R08: 00007fca38d81f80 R09: 00000000039600ac
R10: 00000000039600ac R11: 0000000000000202 R12: 0000000020000140
R13: 00007fca38d81f40 R14: 0000000000000000 R15: 0000000020000080
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:remove_ticket fs/btrfs/space-info.c:436 [inline]
RIP: 0010:btrfs_try_granting_tickets+0x59f/0x5d0 fs/btrfs/space-info.c:468
Code: fe e9 ca fa ff ff e8 a0 ca d8 fd 48 c7 c7 e0 16 8d 8b 48 c7 c6 a0 1d 8d 8b 48 c7 c2 60 17 8d 8b b9 b4 01 00 00 e8 11 02 54 07 <0f> 0b e8 7a ca d8 fd 48 c7 c7 e0 16 8d 8b 48 c7 c6 40 17 8d 8b 48
RSP: 0018:ffffc90015f07188 EFLAGS: 00010246
RAX: 0000000000000059 RBX: ffffffffffff2000 RCX: 7562ac8ccb7a8d00
RDX: ffffc9000bd65000 RSI: 000000000000a0ff RDI: 000000000000a100
RBP: 0000000000060000 R08: ffffffff81716b8c R09: 1ffff92002be0dd0
R10: dffffc0000000000 R11: fffff52002be0dd1 R12: ffff8880293b90f0
R13: ffffc9000ac0f6e0 R14: dffffc0000000000 R15: 1ffff1100527721e
FS:  00007fca38d826c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f27f6881000 CR3: 00000000365f7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

