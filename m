Return-Path: <linux-fsdevel+bounces-18511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EDF8B9E7E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 18:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9041C22A35
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 16:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2E615F3E6;
	Thu,  2 May 2024 16:24:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E655A15E1EF
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667073; cv=none; b=uDB/XF+fqRPhxwQ6v4VI34d+vPkDCDifdv0LBLDj8oFcYQBEh9fO6IYWFWyog+AjXYxXlxe+AhlWWu2YAf/F1wue1tScGCtTIkr4hvHeZ3Fti5dZPXGOwANSuSefX2MSCibC4oIF1DxAfUPGbNDZMnXj+kf111FyZs8tI5t1W8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667073; c=relaxed/simple;
	bh=0/ZunkJEpZN/4OPSGwOcBxhrTmPptZAmWRgi2vQAPZI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HhxnfD7uZii03koyyi8BkV3xIeZpi21rOcxkIjpo9veM3YKZ7eT5u9qi+q5w3zfWSjD05OMwe6BF7chFyqm0ZuCXVw7zRKn1qjxNtS+3LAU2gLitvCPj7D9iuYOMjc/IGFZIODU/X6oo+0uIbpX270YuQM05meX5fFD2fZKy4Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dee502fae6so243804739f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2024 09:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714667070; x=1715271870;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFyj694V0D/vLHEgtWStUV4YFzhNaN+kM0JlKVVUeBY=;
        b=TCcKh6tEZ0Q6/UcQJivE0PrZo179O0CLZB7ACZxRZXv6kjl5GvWrhDvWr/3It3Jma0
         89hYNCP5XWgHDMAwAJOYYV3KBJpQMeM0ULsi7gOcrLcluE4fzmeS22d5QpSrK7qHP0YV
         lO2vM99xZg/Azdv61uR2cwlEw2LwjS4A4xoCDPwLiJiyswiIZJG33luZ8t0Xf0KS/xuy
         ND2mNKD3JH9qLGO3pgMpC8qmqUlIeZ6x5hR6fleDyql/NuH9HXHY/TUXvxcGFIgWcdzu
         P4NA31VPJBvoHAlCPT87c5j5ZIAhxFHdIUInFI1WAmI1SWgvhS3bm/eHZgFh3cn2BGoi
         A2KA==
X-Forwarded-Encrypted: i=1; AJvYcCXDyeMykEzU2DCVdt9LJ3l5AVq7q7DPR3t2GqB+nvyDhdO89IokE8aH/0PRJmSlHTMYnmIbelj77Yv61fby8iNDFabf11/eQpnyRzUS1w==
X-Gm-Message-State: AOJu0YzoX1b1Y8SWTBtfvuYZ/gThSUwVyCHnqCRTCjnfJQYa+D+izUJU
	qd2tFSxfgPY5ua5kIWQC2nT0qUk37FlOPA/Y4NuK88CDrgLeMc8toPZC3rqhQu/kzKFU8VoLQi/
	7YyMK9v3b1SPQ+MIS9peILMrb3FHn+iRVRT/7G8fyBUgBdhZuGLtufpw=
X-Google-Smtp-Source: AGHT+IE15CgMIlFF9wAA/PYoqD8Aqqy1VC0nYZW13rmvitrAHILPCstERAbY5qc8J0+/EEWv+okVnWRojEdKGl94DKkZqxVwFRJH
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:448f:b0:487:31da:eaf1 with SMTP id
 bv15-20020a056638448f00b0048731daeaf1mr127840jab.1.1714667070047; Thu, 02 May
 2024 09:24:30 -0700 (PDT)
Date: Thu, 02 May 2024 09:24:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e614206177b0968@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in folio_unlock (2)
From: syzbot <syzbot+9e39ac154d8781441e60@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9c6ecb3cb6e2 Add linux-next specific files for 20240502
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17418c40980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25ba1e5e9c955f1a
dashboard link: https://syzkaller.appspot.com/bug?extid=9e39ac154d8781441e60
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e4117f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10efe5f8980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dc32e924f570/disk-9c6ecb3c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7bc65d787cc9/vmlinux-9c6ecb3c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/19096ecded11/bzImage-9c6ecb3c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/45e18da02dc2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9e39ac154d8781441e60@syzkaller.appspotmail.com

 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2601
 free_contig_range+0x9e/0x160 mm/page_alloc.c:6655
 destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1037
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1417
 do_one_initcall+0x248/0x880 init/main.c:1265
 do_initcall_level+0x157/0x210 init/main.c:1327
 do_initcalls+0x3f/0x80 init/main.c:1343
 kernel_init_freeable+0x435/0x5d0 init/main.c:1576
 kernel_init+0x1d/0x2b0 init/main.c:1465
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
------------[ cut here ]------------
kernel BUG at mm/filemap.c:1507!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5109 Comm: syz-executor359 Not tainted 6.9.0-rc6-next-20240502-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:folio_unlock+0x18b/0x2f0 mm/filemap.c:1507
Code: 4c 89 f0 48 25 ff 0f 00 00 74 62 e8 bf df c9 ff e9 eb fe ff ff e8 b5 df c9 ff 4c 89 f7 48 c7 c6 a0 85 d3 8b e8 96 95 13 00 90 <0f> 0b e8 9e df c9 ff 4c 89 f7 48 c7 c6 a0 8e d3 8b e8 7f 95 13 00
RSP: 0018:ffffc900036b6b48 EFLAGS: 00010246
RAX: 85f60d17a1306500 RBX: 1ffffd40003a3d50 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8bcab340 RDI: 0000000000000001
RBP: 00fff4000000402c R08: ffffffff92faa657 R09: 1ffffffff25f54ca
R10: dffffc0000000000 R11: fffffbfff25f54cb R12: ffffea0001d1ea88
R13: 1ffffd40003a3d51 R14: ffffea0001d1ea80 R15: dffffc0000000000
FS:  00007f5d709cb6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5d70a710d0 CR3: 000000002e66e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __extent_writepage fs/btrfs/extent_io.c:1519 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2173 [inline]
 btrfs_writepages+0x1fab/0x26f0 fs/btrfs/extent_io.c:2294
 do_writepages+0x359/0x870 mm/page-writeback.c:2633
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 filemap_fdatawrite_range+0x120/0x180 mm/filemap.c:448
 btrfs_fdatawrite_range fs/btrfs/file.c:4050 [inline]
 start_ordered_ops fs/btrfs/file.c:1753 [inline]
 btrfs_sync_file+0x2b4/0xf80 fs/btrfs/file.c:1828
 generic_write_sync include/linux/fs.h:2793 [inline]
 btrfs_do_write_iter+0xb84/0x10a0 fs/btrfs/file.c:1705
 iter_file_splice_write+0xbd7/0x14e0 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11e/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x58e/0xc90 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x28c/0x3e0 fs/splice.c:1233
 vfs_copy_file_range+0xd37/0x1510 fs/read_write.c:1558
 __do_sys_copy_file_range fs/read_write.c:1612 [inline]
 __se_sys_copy_file_range+0x3f2/0x5d0 fs/read_write.c:1575
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5d70a356c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5d709cb208 EFLAGS: 00000246 ORIG_RAX: 0000000000000146
RAX: ffffffffffffffda RBX: 00007f5d70ac1618 RCX: 00007f5d70a356c9
RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f5d70ac1610 R08: ffffffffa003e45b R09: 0700000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5d70a8e1b0
R13: 007570637265705f R14: 6f6f6c2f7665642f R15: 0700000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_unlock+0x18b/0x2f0 mm/filemap.c:1507
Code: 4c 89 f0 48 25 ff 0f 00 00 74 62 e8 bf df c9 ff e9 eb fe ff ff e8 b5 df c9 ff 4c 89 f7 48 c7 c6 a0 85 d3 8b e8 96 95 13 00 90 <0f> 0b e8 9e df c9 ff 4c 89 f7 48 c7 c6 a0 8e d3 8b e8 7f 95 13 00
RSP: 0018:ffffc900036b6b48 EFLAGS: 00010246
RAX: 85f60d17a1306500 RBX: 1ffffd40003a3d50 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8bcab340 RDI: 0000000000000001
RBP: 00fff4000000402c R08: ffffffff92faa657 R09: 1ffffffff25f54ca
R10: dffffc0000000000 R11: fffffbfff25f54cb R12: ffffea0001d1ea88
R13: 1ffffd40003a3d51 R14: ffffea0001d1ea80 R15: dffffc0000000000
FS:  00007f5d709cb6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5d70a710d0 CR3: 000000002e66e000 CR4: 00000000003506f0
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

