Return-Path: <linux-fsdevel+bounces-2896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB757EC5B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 15:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311671F273FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 14:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B933FB03;
	Wed, 15 Nov 2023 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3742F506
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 14:40:42 +0000 (UTC)
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040D01737
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 06:40:29 -0800 (PST)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1cc502d401eso81722565ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 06:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700059229; x=1700664029;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oEFvRgy5pAtuhdPFXYj4A7+HkV4kDjQBHjX1AjUkCXM=;
        b=egURgI/fRVXc9pbVHV2a9ULtS0sGSeYMmGPJxbnuWq4fTcp12eU3OdFyI+8lPDa8XQ
         PwFrJKLqXWgVz4uoa+gvL43UqVy38n0gAayDvnz3zm0fDEGfsmEe1m00xSX+6Ne262pC
         rcAwj8duRG/S3w2N+Wpde2AxUFEFl8oDiAeKHmChyEYU87j4xvTivZqEjvff4kLVCSQ/
         OXeXhIFtgcdZ677Pfngx1p+8ZStjO1NML7dfTAuYiZZh7NSdYmc7mj+ZXNGBg82BTfFE
         0sPnTR25Ai8D9glZx0WW6zziAHPXqmRyUW2VWPwvvi4/fbd5Cx5ydtDBHvD760kX2PpT
         x7zg==
X-Gm-Message-State: AOJu0YyS8esuL9Le1cTGrPXoFU0eCV6Nm5uNQHZ4Xi+cqNI2aO8z2LgL
	pomdZDk/xCAkTap8UeEKCGnbB9Cey+pf6hCml6CYc4lJ+x6QsECANQ==
X-Google-Smtp-Source: AGHT+IGLc7m1yEbfAUEMCdLKgxDm3tiT5Un2/hM0ApLc3Nza/jXXEq9SIN7ymbNR/0S9++JoxuzDrY6/RE4XvCGQkpgVLKwff0W+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:d4cd:b0:1cc:3c52:1b0e with SMTP id
 o13-20020a170902d4cd00b001cc3c521b0emr1753855plg.1.1700059229403; Wed, 15 Nov
 2023 06:40:29 -0800 (PST)
Date: Wed, 15 Nov 2023 06:40:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000773fa7060a31e2cc@google.com>
Subject: [syzbot] [fs?] WARNING in pagemap_scan_pmd_entry
From: syzbot <syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c42d9eeef8e5 Merge tag 'hardening-v6.7-rc2' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13626650e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84217b7fc4acdc59
dashboard link: https://syzkaller.appspot.com/bug?extid=e94c5aaf7890901ebf9b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d73be0e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13670da8e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a595d90eb9af/disk-c42d9eee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1e726fedb94/vmlinux-c42d9eee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cb43ae262d09/bzImage-c42d9eee.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5071 at arch/x86/include/asm/pgtable.h:403 pte_uffd_wp arch/x86/include/asm/pgtable.h:403 [inline]
WARNING: CPU: 1 PID: 5071 at arch/x86/include/asm/pgtable.h:403 pagemap_scan_pmd_entry+0x1d27/0x23f0 fs/proc/task_mmu.c:2146
Modules linked in:
CPU: 1 PID: 5071 Comm: syz-executor182 Not tainted 6.7.0-rc1-syzkaller-00019-gc42d9eeef8e5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:pte_uffd_wp arch/x86/include/asm/pgtable.h:403 [inline]
RIP: 0010:pagemap_scan_pmd_entry+0x1d27/0x23f0 fs/proc/task_mmu.c:2146
Code: ff ff e8 5c 23 76 ff 48 89 e8 31 ff 83 e0 02 48 89 c6 48 89 04 24 e8 d8 1e 76 ff 48 8b 04 24 48 85 c0 74 25 e8 3a 23 76 ff 90 <0f> 0b 90 e9 71 ff ff ff 4c 89 74 24 68 4c 8b 74 24 10 c7 44 24 28
RSP: 0018:ffffc9000392f870 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000020001000 RCX: ffffffff82116da8
RDX: ffff88801aae8000 RSI: ffffffff82116db6 RDI: 0000000000000007
RBP: 0000000012c7ac67 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000002 R12: dffffc0000000000
R13: 0000000000000400 R14: 0000000000000000 R15: ffff8880745f4000
FS:  00005555557a8380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000d60 CR3: 0000000074627000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 walk_pmd_range mm/pagewalk.c:143 [inline]
 walk_pud_range mm/pagewalk.c:221 [inline]
 walk_p4d_range mm/pagewalk.c:256 [inline]
 walk_pgd_range+0xa48/0x1870 mm/pagewalk.c:293
 __walk_page_range+0x630/0x770 mm/pagewalk.c:395
 walk_page_range+0x626/0xa80 mm/pagewalk.c:521
 do_pagemap_scan+0x40d/0xcd0 fs/proc/task_mmu.c:2437
 do_pagemap_cmd+0x5e/0x80 fs/proc/task_mmu.c:2478
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f9c3ea93669
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe1d95e918 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffe1d95e920 RCX: 00007f9c3ea93669
RDX: 0000000020000d40 RSI: 00000000c0606610 RDI: 0000000000000003
RBP: 00007f9c3eb06610 R08: 65732f636f72702f R09: 65732f636f72702f
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe1d95eb58 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

