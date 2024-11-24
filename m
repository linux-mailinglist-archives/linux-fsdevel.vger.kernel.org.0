Return-Path: <linux-fsdevel+bounces-35702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 826419D731B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A0F283E51
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9B2215F69;
	Sun, 24 Nov 2024 13:45:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372B52144CC
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455921; cv=none; b=VawKm0p1wP2HXuKVenr/uW/rYcDcuKMzCNoVfIIWAtaZlu1HIGPE9vfoCIhXEBb1ZZJYnpANYPD5h0+0kSJOX4zgIXalm4J80coo3OrYNdvgW09AHFGKf4tIEGh13D20xzfLJKMehA8qOPSccr51TWXafoOiRhWitVlho1wrTVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455921; c=relaxed/simple;
	bh=gBCA6PvhsD68CM59+LDlo4RQBIZiH2mLYih1G5oOcD4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AHtWBwAF1Wa8KCMSs4nAl/dJYwLt/i+cNEmUGtAa5vlUp9sI2sdwxBnwIVT87psDwmUcFajpt8rsWhv4sDm3GhUHMigZ6BuAVxyup0OMOn+S3nABg651b+0eRFFtFi0CmSuGd9vTrEplyFm82k9hiXy8Dbn7AJs3Bb8oZac9xr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a777d47a8eso38314115ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 05:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732455918; x=1733060718;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a81M4efnjatMHVgJX7A227EncQOmk61XuBnuORvoZ3Y=;
        b=C0OQH3sUp37gYgIrC4dqJNtcSTax0bkVXsuTvf2KM2d/VvZOANfE4OQIY3XgE9JVYQ
         MrXjtFk1GpdS8pq+6h5vI1VF5cAzNQ1ANN9IGZ0dHgO4SUC77v1x9ZtVMqNg52W/RITi
         oLSEcXrIpawDEG52/KDTYE6P/ryn3Rbj0R/0DG9woMWdvk0j/0HMAibZkqsEyaH9o5X+
         zaYKjChKNvwsEK3Y0vmJHAG1pnANCIZWXcyQt6Fcz3/FgCQLc7VnmvPqTLTqoGduiWx7
         27o1Pd/KD6aX3DK2p7hXEAJwPk4nVO2+250+iAd2ey0ieYPMITQQiNmmYYrMvsU2rvX+
         jmVg==
X-Forwarded-Encrypted: i=1; AJvYcCUhKJ39HGcfmaChp4HIsWogjQld+IwEZeeddAmFNz943Oa31TF4xuvrzbkCR4loNlG5raZZF0tQ8gXcuASP@vger.kernel.org
X-Gm-Message-State: AOJu0YzjS6Bd21XuLmOjx91wfoACt+hbWD63tjhdBjtzYKsgjKSCtFa5
	9a4XPNcORGrL5lSF6I7jzoxFpzRwYrpc23/l7x8G+jr3RmR4+NMuxsUSV+p0S4fXleMg/oNbnsz
	aAX3gfB79ZO1cq75sif4tMBSqE/Mi0DfsWfiDjMkIHb2hjoFEF4l32x8=
X-Google-Smtp-Source: AGHT+IFpf92NeJYFxU9gLOtHQWOMGi4CPunFrp6hEzgy12y0qdbEpdXOPeIXOk5eDbM6qrzAD0q4COZzziVxCCKzXfh50C0PeRrs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164c:b0:3a7:15aa:3fcc with SMTP id
 e9e14a558f8ab-3a79acea4e0mr111445195ab.1.1732455918361; Sun, 24 Nov 2024
 05:45:18 -0800 (PST)
Date: Sun, 24 Nov 2024 05:45:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67432dee.050a0220.1cc393.0041.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
From: syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    228a1157fb9f Merge tag '6.13-rc-part1-SMB3-client-fixes' o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13820530580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=aac7bff85be224de5156
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13840778580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17840778580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d32a8e8c5aae/disk-228a1157.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/28d5c070092e/vmlinux-228a1157.xz
kernel image: https://storage.googleapis.com/syzbot-assets/45af4bfd9e8e/bzImage-228a1157.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/69603aa12e8f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com

 __fput+0x5ba/0xa50 fs/file_table.c:458
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
------------[ cut here ]------------
kernel BUG at mm/page-writeback.c:3119!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.12.0-syzkaller-08446-g228a1157fb9f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: btrfs-delalloc btrfs_work_helper
RIP: 0010:__folio_start_writeback+0xc06/0x1050 mm/page-writeback.c:3119
Code: 25 ff 0f 00 00 0f 84 d3 00 00 00 e8 14 ae c3 ff e9 ba f5 ff ff e8 0a ae c3 ff 4c 89 f7 48 c7 c6 00 2e 14 8c e8 8b 4f 0d 00 90 <0f> 0b e8 f3 ad c3 ff 4c 89 f7 48 c7 c6 60 34 14 8c e8 74 4f 0d 00
RSP: 0018:ffffc90000117500 EFLAGS: 00010246
RAX: ed413247a2060f00 RBX: 0000000000000002 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8c0ad620 RDI: 0000000000000001
RBP: ffffc90000117670 R08: ffffffff942b2967 R09: 1ffffffff285652c
R10: dffffc0000000000 R11: fffffbfff285652d R12: 0000000000000000
R13: 1ffff92000022eac R14: ffffea0001cab940 R15: ffff888077139710
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6661870000 CR3: 00000000792b2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_folio fs/btrfs/extent_io.c:187 [inline]
 __process_folios_contig+0x31c/0x540 fs/btrfs/extent_io.c:216
 submit_one_async_extent fs/btrfs/inode.c:1229 [inline]
 submit_compressed_extents+0xdb3/0x16e0 fs/btrfs/inode.c:1632
 run_ordered_work fs/btrfs/async-thread.c:245 [inline]
 btrfs_work_helper+0x56b/0xc50 fs/btrfs/async-thread.c:324
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__folio_start_writeback+0xc06/0x1050 mm/page-writeback.c:3119
Code: 25 ff 0f 00 00 0f 84 d3 00 00 00 e8 14 ae c3 ff e9 ba f5 ff ff e8 0a ae c3 ff 4c 89 f7 48 c7 c6 00 2e 14 8c e8 8b 4f 0d 00 90 <0f> 0b e8 f3 ad c3 ff 4c 89 f7 48 c7 c6 60 34 14 8c e8 74 4f 0d 00
RSP: 0018:ffffc90000117500 EFLAGS: 00010246
RAX: ed413247a2060f00 RBX: 0000000000000002 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8c0ad620 RDI: 0000000000000001
RBP: ffffc90000117670 R08: ffffffff942b2967 R09: 1ffffffff285652c
R10: dffffc0000000000 R11: fffffbfff285652d R12: 0000000000000000
R13: 1ffff92000022eac R14: ffffea0001cab940 R15: ffff888077139710
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ec8463e668 CR3: 000000007ed5e000 CR4: 00000000003526f0
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

