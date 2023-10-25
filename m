Return-Path: <linux-fsdevel+bounces-1127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BDC7D606C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 05:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFC11C20CB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 03:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6202A2572;
	Wed, 25 Oct 2023 03:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB41360
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 03:16:59 +0000 (UTC)
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9633C1737
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 20:16:49 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1c8c1f34aadso7143882fac.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 20:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698203809; x=1698808609;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e9QVC5H4vkyCeuiGpwFNYN03ir9tniFF2RawB0o4s0A=;
        b=GSH6T4rac/i3GdU8+m3GhMhMh/2/vyY17MdPI+JRWII1Me8wqNRq0RKZohcq9RCw+Y
         56EhZfpCTdnvr50xJetgNNrnAvLOzQ99hG/Z6Rmsa6Ewqo7bX3ovOY+Nj7Zjs+aIpHwC
         DsVb971LoYq7bu9VNuAM6S/KhaFACitaBgEDkPl78Ghfqyt0JhWm3/UHtKpeYpuv/SmW
         K3+uDaZ9RIGp9QuQmis9uHeoD1P3MkYdVBhxYB27vLpnMbphy/U+iXOwUYeuW5OwkpuF
         7FDHP0nTP5lf/oIkHtfcM77oCBSPI8znQXbptP4IEOBcEYX2WXseeL3kRHYNlhetjesk
         LbiQ==
X-Gm-Message-State: AOJu0YysUtTgG2fBRSKhyC1Pe+/KCy06iWUx0XuSOmTuTa0c9OOhpvEP
	2DslxkiDnvWtZSotCHiVsOZm08ELzzmbMJsf6DcJtxcxvb53
X-Google-Smtp-Source: AGHT+IHmWrlfanHyoztjRjoH3IuASudmYC42YG5zvsrOwCnvY9Rp/tctN/TY4Q6D2QnwOgFL69hmjmjHu5sXd6kug9GIOOLb6q/m
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:7181:b0:1ea:5659:8ed5 with SMTP id
 d1-20020a056870718100b001ea56598ed5mr6617458oah.6.1698203808778; Tue, 24 Oct
 2023 20:16:48 -0700 (PDT)
Date: Tue, 24 Oct 2023 20:16:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c750b0060881e20e@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in remove_ticket
From: syzbot <syzbot+532944658f9546cd0135@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2030579113a1 Add linux-next specific files for 20231020
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1370ea89680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37404d76b3c8840e
dashboard link: https://syzkaller.appspot.com/bug?extid=532944658f9546cd0135
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a99a981e5d78/disk-20305791.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/073a5ba6a2a6/vmlinux-20305791.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c7c1a7107f7b/bzImage-20305791.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+532944658f9546cd0135@syzkaller.appspotmail.com

assertion failed: space_info->reclaim_size >= ticket->bytes, in fs/btrfs/space-info.c:436
------------[ cut here ]------------
kernel BUG at fs/btrfs/space-info.c:436!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 18842 Comm: syz-executor.2 Not tainted 6.6.0-rc6-next-20231020-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:remove_ticket fs/btrfs/space-info.c:436 [inline]
RIP: 0010:remove_ticket+0x1cf/0x240 fs/btrfs/space-info.c:431
Code: 5f e9 f5 58 ed fd e8 f0 58 ed fd b9 b4 01 00 00 48 c7 c2 80 32 d9 8a 48 c7 c6 c0 32 d9 8a 48 c7 c7 20 33 d9 8a e8 a1 1c d0 fd <0f> 0b 48 89 ef e8 57 1f 44 fe e9 56 fe ff ff 48 89 ef e8 ea 1f 44
RSP: 0018:ffffc900142a75e8 EFLAGS: 00010282
RAX: 0000000000000059 RBX: ffffffffffffc000 RCX: ffffc900098f1000
RDX: 0000000000000000 RSI: ffffffff816c4d42 RDI: 0000000000000005
RBP: 000000000001c000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8880286da000
R13: ffff8880286da0e0 R14: ffffc900142c7738 R15: ffffc900133ef730
FS:  00007fd63d5966c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005556cb3e3668 CR3: 0000000020c93000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_try_granting_tickets+0x2c6/0x450 fs/btrfs/space-info.c:468
 btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:232 [inline]
 block_rsv_release_bytes fs/btrfs/block-rsv.c:154 [inline]
 btrfs_block_rsv_release+0x5b3/0x6c0 fs/btrfs/block-rsv.c:295
 btrfs_delayed_refs_rsv_release+0xbb/0x130 fs/btrfs/delayed-ref.c:75
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:2038 [inline]
 __btrfs_run_delayed_refs+0x6c3/0x4020 fs/btrfs/extent-tree.c:2106
 btrfs_run_delayed_refs+0x1a6/0x320 fs/btrfs/extent-tree.c:2218
 btrfs_commit_transaction+0x783/0x3b20 fs/btrfs/transaction.c:2237
 btrfs_sync_fs+0x13b/0x780 fs/btrfs/super.c:1185
 sync_filesystem fs/sync.c:66 [inline]
 sync_filesystem+0x1c5/0x280 fs/sync.c:30
 btrfs_remount+0x1ff/0x17b0 fs/btrfs/super.c:1649
 legacy_reconfigure+0x119/0x180 fs/fs_context.c:685
 reconfigure_super+0x44f/0xb10 fs/super.c:1143
 do_remount fs/namespace.c:2884 [inline]
 path_mount+0x16ed/0x1ed0 fs/namespace.c:3656
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount fs/namespace.c:3863 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3863
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fd63c87e1ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd63d595ee8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fd63d595f80 RCX: 00007fd63c87e1ea
RDX: 0000000020000180 RSI: 0000000020000140 RDI: 0000000000000000
RBP: 0000000020000180 R08: 00007fd63d595f80 R09: 00000000039600ac
R10: 00000000039600ac R11: 0000000000000206 R12: 0000000020000140
R13: 00007fd63d595f40 R14: 0000000000000000 R15: 0000000020000080
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:remove_ticket fs/btrfs/space-info.c:436 [inline]
RIP: 0010:remove_ticket+0x1cf/0x240 fs/btrfs/space-info.c:431
Code: 5f e9 f5 58 ed fd e8 f0 58 ed fd b9 b4 01 00 00 48 c7 c2 80 32 d9 8a 48 c7 c6 c0 32 d9 8a 48 c7 c7 20 33 d9 8a e8 a1 1c d0 fd <0f> 0b 48 89 ef e8 57 1f 44 fe e9 56 fe ff ff 48 89 ef e8 ea 1f 44
RSP: 0018:ffffc900142a75e8 EFLAGS: 00010282
RAX: 0000000000000059 RBX: ffffffffffffc000 RCX: ffffc900098f1000
RDX: 0000000000000000 RSI: ffffffff816c4d42 RDI: 0000000000000005
RBP: 000000000001c000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8880286da000
R13: ffff8880286da0e0 R14: ffffc900142c7738 R15: ffffc900133ef730
FS:  00007fd63d5966c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005556cb3e3668 CR3: 0000000020c93000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

