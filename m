Return-Path: <linux-fsdevel+bounces-45147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8040AA736CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 17:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F48B1899CE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EA51A2658;
	Thu, 27 Mar 2025 16:26:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81F18A6DB
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092804; cv=none; b=hPF9KbUcEHynuYEdi7258qwrdAG8WYchPCIrAg4dnlcADxHcpMyDWHDKeph8EaPtHzVTbR212EnuZR6vCFyfXTfpe0VFVm+3WdOGOr39hqYcJU2XPTMnrLz0cVdXyku1ejUKPEFMjVe7PjPGPJA41eloZHZlFaNqqXL2XJs0mhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092804; c=relaxed/simple;
	bh=ApOhLeqivA61QF/K9wdPtCMCuqkYNKgtQpeRStzlzbY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CZyi1GwywrrY2za0iiFBLsvTw6BxC+9svP8JtI/si4pgsGE6uVNexiiTkfY6j1Ckm4Zp4ylI/oErnpPxSWKUfDSspdEDnegs/+lpLUdyDmaf61GhOvaBSXCSY2ffcW3ltNWUQl3xaMrMwtL6F2ewtlOFhiS+ocfE4JSYEstOKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d44dc8a9b4so11697335ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 09:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743092801; x=1743697601;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NtkTCDi0EFrXhjCDgkLJZwbb0bQvH3XpK0QTsRu1c90=;
        b=ZL84bpdFUso7M07/b1cmzbuMjHhRzIW637N+0dk2s3K0xnzD7MEHangYqKUEdt6P04
         s8vkcB17r+Nt0e/plXgGB8ydWEcBn3g8v15Q2hK98fy3upAzW8kF2yn9xFfkkXx8QbMC
         8KLnNIkASNJ4QmJMNkSJ/Sboe08s6DEzxqbhCGQmH6MAAIecsBwMUYmXyXo92QoXP/Q1
         z3+Km2htJjdCIEOT6yySAMlOZmh5mL0agfqpJaqlUDXKu6G+6Nx5cF8duAmEzm3aJydD
         dE+ZbrQ+V0tu4Qy9jilQck+fc3UMN0snbEfjUBQ3YrMhJXYHP797f3GcRn6cbFONJDw0
         ksVg==
X-Forwarded-Encrypted: i=1; AJvYcCXVv+wVOzJDY2hhdVKJHnlz26FHTb+s2HDQFVtPtCfiVrSHPHbnqK5ptDAIw034j28kIC7YVkONHTebbMd4@vger.kernel.org
X-Gm-Message-State: AOJu0YymvaTr1oguQ3fUElVtZq9eMpihHYJFBhLbiOUthNB9ET4kdgCh
	ykNgTvXHNwrrEvS7e35w3j0QI22TXBo/KrBNXSEfOfMyopdIwEwEkeW1mRlL4JSzbh35P8WgOUS
	hCGvi03s7ya5DoTlZJdH9qQVzLuZn4SYkNOfAHM7XsfO85WY2P8nlwT8=
X-Google-Smtp-Source: AGHT+IGhIfJiFkcZvl7410r5jh1+7KeAkt1DPscDK4CtvsWGBWv2373JLhxeq+6G72Jaw0Nt4GgF+7hXS6jEJvUgj/rAHnl+NSHk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2192:b0:3d3:ddb3:fe4e with SMTP id
 e9e14a558f8ab-3d5ccdd7400mr46330615ab.13.1743092801411; Thu, 27 Mar 2025
 09:26:41 -0700 (PDT)
Date: Thu, 27 Mar 2025 09:26:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e57c41.050a0220.2f068f.0033.GAE@google.com>
Subject: [syzbot] [mm?] [fs?] BUG: sleeping function called from invalid
 context in folio_mc_copy
From: syzbot <syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com>
To: brauner@kernel.org, hare@suse.de, joel.granados@kernel.org, 
	john.g.garry@oracle.com, kees@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mcgrof@kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3ba7dfb8da62 Merge tag 'rcu-next-v6.15' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112d4de4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=81ce17d4cab5b5b4
dashboard link: https://syzkaller.appspot.com/bug?extid=f3c6fda1297c748a7076
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1597d24c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152d4de4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/61886896d33d/disk-3ba7dfb8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e41306171182/vmlinux-3ba7dfb8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e056187afb19/bzImage-3ba7dfb8.xz

The issue was bisected to:

commit 3c20917120ce61f2a123ca0810293872f4c6b5a4
Author: Hannes Reinecke <hare@suse.de>
Date:   Fri Feb 21 22:38:21 2025 +0000

    block/bdev: enable large folio support for large logical block sizes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1393643f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1053643f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1793643f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Fixes: 3c20917120ce ("block/bdev: enable large folio support for large logical block sizes")

BUG: sleeping function called from invalid context at mm/util.c:742
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 7101, name: syz-executor140
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor140/7101:
 #0: ffff888032c2e420 (sb_writers#3){.+.+}-{0:0}, at: direct_splice_actor+0x49/0x220 fs/splice.c:1157
 #1: ffff888148ca65c8 (&mapping->i_private_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #1: ffff888148ca65c8 (&mapping->i_private_lock){+.+.}-{3:3}, at: __buffer_migrate_folio+0x241/0x5d0 mm/migrate.c:853
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 UID: 0 PID: 7101 Comm: syz-executor140 Not tainted 6.14.0-syzkaller-00685-g3ba7dfb8da62 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8764
 folio_mc_copy+0x13c/0x1d0 mm/util.c:742
 __migrate_folio mm/migrate.c:758 [inline]
 filemap_migrate_folio+0xb4/0x4c0 mm/migrate.c:943
 __buffer_migrate_folio+0x3ec/0x5d0 mm/migrate.c:874
 move_to_new_folio+0x2ac/0xc20 mm/migrate.c:1050
 migrate_folio_move mm/migrate.c:1358 [inline]
 migrate_folios_move mm/migrate.c:1710 [inline]
 migrate_pages_batch+0x1e84/0x30b0 mm/migrate.c:1957
 migrate_pages_sync mm/migrate.c:1987 [inline]
 migrate_pages+0x2007/0x3680 mm/migrate.c:2096
 compact_zone+0x33d5/0x4ae0 mm/compaction.c:2663
 compact_node mm/compaction.c:2932 [inline]
 compact_nodes mm/compaction.c:2954 [inline]
 sysctl_compaction_handler+0x496/0x990 mm/compaction.c:3005
 proc_sys_call_handler+0x5f3/0x950 fs/proc/proc_sysctl.c:601
 iter_file_splice_write+0xbce/0x1510 fs/splice.c:738
 do_splice_from fs/splice.c:935 [inline]
 direct_splice_actor+0x11b/0x220 fs/splice.c:1158
 splice_direct_to_actor+0x586/0xc80 fs/splice.c:1102
 do_splice_direct_actor fs/splice.c:1201 [inline]
 do_splice_direct+0x289/0x3e0 fs/splice.c:1227
 do_sendfile+0x564/0x8a0 fs/read_write.c:1368
 __do_sys_sendfile64 fs/read_write.c:1423 [inline]
 __se_sys_sendfile64+0x100/0x1e0 fs/read_write.c:1415
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f615c6e5599
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f615c67f218 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f615c76f358 RCX: 00007f615c6e5599
RDX: 00002000000000c0 RSI: 0000000000000006 RDI: 0000000000000007
RBP: 00007f615c76f350 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000009 R11: 0000000000000246 R12: 00007f615c73c074
R13: 0000200000000080 R14: 0000200000000040 R15: 00002000000000c0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

