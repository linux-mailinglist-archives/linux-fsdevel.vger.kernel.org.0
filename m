Return-Path: <linux-fsdevel+bounces-2033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492D47E1856
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 02:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B0A2812ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 01:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BEB631;
	Mon,  6 Nov 2023 01:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E69395
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 01:31:29 +0000 (UTC)
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C2EE0
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 17:31:28 -0800 (PST)
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-58787094359so3061821eaf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Nov 2023 17:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699234287; x=1699839087;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ACzC2r7zSIZyvL7k4AzkVyO2tYbcPsg8sZREmNIxuw=;
        b=ZBQrEBa0AmwV0qteCmSP3rJquPt0e3rrUmGRvt2mvHMpXiVH9BCDCLEFLxHzIKp0UU
         m3X93m5c6LBFwsm3GdNVKc1AEqeuGPN3AbII8mperYMvmeWLux1roVQ5fEMOV7nT929e
         c/ELfy1rP+OkVtaDmLV57srz2yypyutlaZmzcYTiNR09Ck/gPbqimkNnbMDW9fG6rArO
         xa2JDzUd/BOqKR/NwtuQ2NGClSLKAtfgFLV+2Pkpa4nYYmkst0OPnlkqXt3JrBS6Ub+l
         aSdQvvIFWhlG05TcUrYdYcvq/BCOJuSgISovhU0Lp0iAT7xT9xYrm/SHUnAN0jRF+24q
         H+dw==
X-Gm-Message-State: AOJu0YwD4TLsQssxjdQAUND1tZUux0VyX6WMvkrGuEXIEkI6IaktRydE
	3N+Bjs2K3NWyslDnN13ApldLjAKGv4zrTGVRnUIZKb7x3ElD
X-Google-Smtp-Source: AGHT+IELEc93tLljM1jpfRmINghOacbezUeHUrksQefRedGqCp8gGmSighGs6Ca+vCU1eFLIQ5Giy/xxNEq2hwXi+tdK/NukGbdP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ea4a:0:b0:581:e2d5:a088 with SMTP id
 j10-20020a4aea4a000000b00581e2d5a088mr10292324ooe.0.1699234287356; Sun, 05
 Nov 2023 17:31:27 -0800 (PST)
Date: Sun, 05 Nov 2023 17:31:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000169326060971d07a@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io
From: syzbot <syzbot+06006fc4a90bff8e8f17@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8bc9e6515183 Merge tag 'devicetree-for-6.7' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e087a0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3aadb4391bbacce
dashboard link: https://syzkaller.appspot.com/bug?extid=06006fc4a90bff8e8f17
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6c9b9f6781b1/disk-8bc9e651.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44acae63a945/vmlinux-8bc9e651.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0058df8ab69/bzImage-8bc9e651.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+06006fc4a90bff8e8f17@syzkaller.appspotmail.com

assertion failed: block_start != EXTENT_MAP_HOLE, in fs/btrfs/extent_io.c:1351
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent_io.c:1351!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6580 Comm: syz-executor.3 Not tainted 6.6.0-syzkaller-06824-g8bc9e6515183 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:__extent_writepage_io+0xcce/0xcf0 fs/btrfs/extent_io.c:1351
Code: 18 83 70 07 0f 0b e8 a1 0c f2 fd 48 c7 c7 c0 b6 8b 8b 48 c7 c6 c0 c3 8b 8b 48 c7 c2 60 b6 8b 8b b9 47 05 00 00 e8 f2 82 70 07 <0f> 0b e8 7b 0c f2 fd 48 8b 3c 24 e8 82 2a 01 00 48 89 c7 48 c7 c6
RSP: 0018:ffffc90003eef3a0 EFLAGS: 00010246
RAX: 000000000000004e RBX: 0000000000000000 RCX: f5edcbbfef5d6800
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: fffffffffffffffd R08: ffffffff81717a4c R09: 1ffff920007dde14
R10: dffffc0000000000 R11: fffff520007dde15 R12: 0000000000002000
R13: 0000000000002000 R14: ffffea0000db97e8 R15: ffff88801ce9b4e0
FS:  00007f2d500396c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9b8a757f28 CR3: 0000000062c62000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __extent_writepage fs/btrfs/extent_io.c:1441 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2103 [inline]
 extent_writepages+0x149b/0x2e50 fs/btrfs/extent_io.c:2225
 do_writepages+0x3a6/0x670 mm/page-writeback.c:2553
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:390
 __filemap_fdatawrite_range mm/filemap.c:423 [inline]
 __filemap_fdatawrite mm/filemap.c:429 [inline]
 filemap_flush+0x11e/0x170 mm/filemap.c:456
 btrfs_release_file+0x117/0x130 fs/btrfs/file.c:1726
 __fput+0x3cc/0xa10 fs/file_table.c:394
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 get_signal+0x166e/0x1840 kernel/signal.c:2691
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
 do_syscall_64+0x50/0x110 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f2d4f27cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2d500390c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: fffffffffffffffc RBX: 00007f2d4f39c120 RCX: 00007f2d4f27cae9
RDX: 0000000000000000 RSI: 000000000014927e RDI: 0000000020000180
RBP: 00007f2d4f2c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f2d4f39c120 R15: 00007ffcbb50d888
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__extent_writepage_io+0xcce/0xcf0 fs/btrfs/extent_io.c:1351
Code: 18 83 70 07 0f 0b e8 a1 0c f2 fd 48 c7 c7 c0 b6 8b 8b 48 c7 c6 c0 c3 8b 8b 48 c7 c2 60 b6 8b 8b b9 47 05 00 00 e8 f2 82 70 07 <0f> 0b e8 7b 0c f2 fd 48 8b 3c 24 e8 82 2a 01 00 48 89 c7 48 c7 c6
RSP: 0018:ffffc90003eef3a0 EFLAGS: 00010246
RAX: 000000000000004e RBX: 0000000000000000 RCX: f5edcbbfef5d6800
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: fffffffffffffffd R08: ffffffff81717a4c R09: 1ffff920007dde14
R10: dffffc0000000000 R11: fffff520007dde15 R12: 0000000000002000
R13: 0000000000002000 R14: ffffea0000db97e8 R15: ffff88801ce9b4e0
FS:  00007f2d500396c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30c22000 CR3: 0000000062c62000 CR4: 00000000003506f0
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

