Return-Path: <linux-fsdevel+bounces-9046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BE383D6F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 10:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC8B1F2AD29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA9F604B1;
	Fri, 26 Jan 2024 09:05:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EAD6025E
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259931; cv=none; b=Jdc3wGQu5Fnc1PGSvTmFTdCBmaiD1GG3yoQ23ZrWcyYAwFw/jDtWBAetW1QRstV9trPj9KvUcm7rkj7uNytlWX6cT5uCZbHWyim/pKOWh8OqhnQ+1fWquQnq0FhPVnttkxNYqHirc7PqNa5eqa7GcTMvUzo4o8ElJq5SlituB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259931; c=relaxed/simple;
	bh=cvXAVg/QUHe1nP3xRlWWfO6myo8tRa+Jwh37Gu5r3NQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qewy2ef2QEe3+yOCv834LipNCBr/CvWhsODnzkwSDAaCJbaBi+cAb4+Jxz+b0xffSnuuY2oORSxLZsi3wuvF7zLHDfSzU3ox+iuG3ZsXb5e70r0cx52z+5DFRpl78hcNyq8fU273Nss+5ASmfBW/OfdScwsP1oC5ATW74qSdXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bf863c324dso83927339f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 01:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706259928; x=1706864728;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LXXRWhnVpg5s10wa8N0l8GPBmu/g4QOuL8LUz3mdrk=;
        b=wIt19CCoxGvUnYC22z5mOvpTpj+d/LTwCDIfQ5dMh0Byw6MpwMH/mCeyATJ3l6v3/m
         Qmkjhtog8z/0Dz/KA6lrlibwr0o8UYAs8Wy5GcJknC2veYiPzT4Lq8KyHMZB0FWEfHAT
         GcmrKrjIPGXerMt2Az9aaMrrIi/zmpoKUM+68icowflFXyxS+RaiNeThI4RUSI/8R0sh
         JwbeQYUys3FJqkTrkMV8EosYAnw1ysrGlUu3cp0IhHjfB/SDTVPqKNTyaZ8reyRsmK7A
         vR4L8fJci80+NakVB539/SNbkbHFLDSL1Fr43eBFa/k9U/Jtp8UQBdhACaVmBKXMwdLg
         A/6w==
X-Gm-Message-State: AOJu0Yw5iFc+vpisq4KJoJsue0L98ih/or98NJrtBySwRSy+NAxX7JeY
	jN5mVJlFArWUBsFvYVEzeiIUxum0WVvlSbfLw/vUTnxfil/ArTiHQ9Ls/El8BTqgib8ZrqMXT2w
	/Uyi2FLCj9T4Uab1Ul26sR2XUEqWwFDkdR18udGQdGfvipzMB+Ihl5ag=
X-Google-Smtp-Source: AGHT+IH1X+V4lAg0wlyhUZG76oDSzE4znywKlY8zf/gqHdqnP01hi4XluIcTXTFWC49pjGgRv1As2c8MxB6M+4dVQiGIRcF26KK0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa1:b0:361:9320:5b3d with SMTP id
 l1-20020a056e021aa100b0036193205b3dmr89644ilv.2.1706259928153; Fri, 26 Jan
 2024 01:05:28 -0800 (PST)
Date: Fri, 26 Jan 2024 01:05:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e98460060fd59831@google.com>
Subject: [syzbot] [ext4?] general protection fault in jbd2__journal_start
From: syzbot <syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7a396820222d Merge tag 'v6.8-rc-part2-smb-client' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fca78fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7059b09d0488022
dashboard link: https://syzkaller.appspot.com/bug?extid=cdee56dbcdf0096ef605
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/da73c2c8f5fe/disk-7a396820.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10d2d2be8831/vmlinux-7a396820.xz
kernel image: https://storage.googleapis.com/syzbot-assets/939406fd4919/bzImage-7a396820.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000a8a4829: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000054524148-0x000000005452414f]
CPU: 0 PID: 3394 Comm: syz-executor.5 Not tainted 6.7.0-syzkaller-12991-g7a396820222d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:jbd2__journal_start+0x87/0x5d0 fs/jbd2/transaction.c:496
Code: 74 63 48 8b 1b 48 85 db 74 79 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 23 46 8f ff 48 8b 2b 48 89 e8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 ef e8 0a 46 8f ff 4c 39 65 00 0f 85 1a
RSP: 0018:ffffc900154d65c8 EFLAGS: 00010203
RAX: 000000000a8a4829 RBX: ffff8880234e7618 RCX: 0000000000040000
RDX: ffffc9000a3a1000 RSI: 000000000000195c RDI: 000000000000195d
RBP: 000000005452414e R08: 0000000000000c40 R09: 0000000000000001
R10: dffffc0000000000 R11: ffffed1005541071 R12: ffff88802aa0a000
R13: dffffc0000000000 R14: 0000000000000c40 R15: 0000000000000002
FS:  00007fbf47a2a6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020020000 CR3: 0000000030c1a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __ext4_journal_start_sb+0x215/0x5b0 fs/ext4/ext4_jbd2.c:112
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_dirty_inode+0x92/0x110 fs/ext4/inode.c:5969
 __mark_inode_dirty+0x305/0xda0 fs/fs-writeback.c:2452
 generic_update_time fs/inode.c:1905 [inline]
 inode_update_time fs/inode.c:1918 [inline]
 __file_update_time fs/inode.c:2106 [inline]
 file_update_time+0x39b/0x3e0 fs/inode.c:2136
 ext4_page_mkwrite+0x207/0xdf0 fs/ext4/inode.c:6090
 do_page_mkwrite+0x197/0x470 mm/memory.c:2966
 wp_page_shared mm/memory.c:3353 [inline]
 do_wp_page+0x20e3/0x4c80 mm/memory.c:3493
 handle_pte_fault mm/memory.c:5160 [inline]
 __handle_mm_fault+0x26a3/0x72b0 mm/memory.c:5285
 handle_mm_fault+0x27e/0x770 mm/memory.c:5450
 do_user_addr_fault arch/x86/mm/fault.c:1415 [inline]
 handle_page_fault arch/x86/mm/fault.c:1507 [inline]
 exc_page_fault+0x2ad/0x870 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:rep_movs_alternative+0x4a/0x70 arch/x86/lib/copy_user_64.S:71
Code: 75 f1 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb c9 <f3> a4 c3 48 89 c8 48 c1 e9 03 83 e0 07 f3 48 a5 89 c1 85 c9 75 b3
RSP: 0018:ffffc900154d70f8 EFLAGS: 00050202
RAX: ffffffff848bfd01 RBX: 0000000020020040 RCX: 0000000000000040
RDX: 0000000000000000 RSI: ffff88802cded190 RDI: 0000000020020000
RBP: 1ffff92002a9af26 R08: ffff88802cded1cf R09: 1ffff110059bda39
R10: dffffc0000000000 R11: ffffed10059bda3a R12: 00000000000000c0
R13: dffffc0000000000 R14: 000000002001ff80 R15: ffff88802cded110
 copy_user_generic arch/x86/include/asm/uaccess_64.h:112 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:133 [inline]
 _copy_to_user+0x86/0xa0 lib/usercopy.c:41
 copy_to_user include/linux/uaccess.h:191 [inline]
 xfs_bulkstat_fmt+0x4f/0x120 fs/xfs/xfs_ioctl.c:744
 xfs_bulkstat_one_int+0xd8b/0x12e0 fs/xfs/xfs_itable.c:161
 xfs_bulkstat_iwalk+0x72/0xb0 fs/xfs/xfs_itable.c:239
 xfs_iwalk_ag_recs+0x4c3/0x820 fs/xfs/xfs_iwalk.c:220
 xfs_iwalk_run_callbacks+0x25b/0x490 fs/xfs/xfs_iwalk.c:376
 xfs_iwalk_ag+0xad6/0xbd0 fs/xfs/xfs_iwalk.c:482
 xfs_iwalk+0x360/0x6f0 fs/xfs/xfs_iwalk.c:584
 xfs_bulkstat+0x4f8/0x6c0 fs/xfs/xfs_itable.c:308
 xfs_ioc_bulkstat+0x3d0/0x450 fs/xfs/xfs_ioctl.c:867
 xfs_file_ioctl+0x6a5/0x1980 fs/xfs/xfs_ioctl.c:1994
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fbf46c7cda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbf47a2a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbf46dabf80 RCX: 00007fbf46c7cda9
RDX: 000000002001fc40 RSI: 000000008040587f RDI: 0000000000000006
RBP: 00007fbf46cc947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fbf46dabf80 R15: 00007ffee39fcd08
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jbd2__journal_start+0x87/0x5d0 fs/jbd2/transaction.c:496
Code: 74 63 48 8b 1b 48 85 db 74 79 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 23 46 8f ff 48 8b 2b 48 89 e8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 ef e8 0a 46 8f ff 4c 39 65 00 0f 85 1a
RSP: 0018:ffffc900154d65c8 EFLAGS: 00010203
RAX: 000000000a8a4829 RBX: ffff8880234e7618 RCX: 0000000000040000
RDX: ffffc9000a3a1000 RSI: 000000000000195c RDI: 000000000000195d
RBP: 000000005452414e R08: 0000000000000c40 R09: 0000000000000001
R10: dffffc0000000000 R11: ffffed1005541071 R12: ffff88802aa0a000
R13: dffffc0000000000 R14: 0000000000000c40 R15: 0000000000000002
FS:  00007fbf47a2a6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020020000 CR3: 0000000030c1a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	74 63                	je     0x65
   2:	48 8b 1b             	mov    (%rbx),%rbx
   5:	48 85 db             	test   %rbx,%rbx
   8:	74 79                	je     0x83
   a:	48 89 d8             	mov    %rbx,%rax
   d:	48 c1 e8 03          	shr    $0x3,%rax
  11:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  16:	74 08                	je     0x20
  18:	48 89 df             	mov    %rbx,%rdi
  1b:	e8 23 46 8f ff       	call   0xff8f4643
  20:	48 8b 2b             	mov    (%rbx),%rbp
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 0a 46 8f ff       	call   0xff8f4643
  39:	4c 39 65 00          	cmp    %r12,0x0(%rbp)
  3d:	0f                   	.byte 0xf
  3e:	85 1a                	test   %ebx,(%rdx)


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

