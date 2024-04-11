Return-Path: <linux-fsdevel+bounces-16653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B8C8A0AE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 10:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F521C223BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 08:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A650613FD7B;
	Thu, 11 Apr 2024 08:11:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5839664DD
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823082; cv=none; b=eSC6meoIsXLadSTPcuEtaW4skIZXpv25RPm4Iu78jc6VKBJ1fejgnu425F12HaDjwDUbx4iWavntkBsR1UAhYcV2/GrK44yczin4jIC5GEHXFvV1RAhUcQ0XgjU0dvFLJaRhNq7AMQxzZzeBEWCkTFwuj1eAdJqHjJ+T+o6chrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823082; c=relaxed/simple;
	bh=pZu0N2XO4m9MHx9l8HNZ+0vsQUhszG81SH813IQDbUU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NOCLWAfIO4X6EENZKf76h7FfE82w/b20Ca5Vea+J0Jc8+8ZG6d3HjuzrqT3D55njn5KtdzMJdA+DrSejrkO3Y2eQfGh79LS0SJhn9O6gm+/oj3PAJ045BzNW4ZbbaZ+qQqnsy2TbZlvw1knlpv1wgTiTvMC2lfbfaaUPfa4wZsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5da88bb06so534259239f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 01:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712823080; x=1713427880;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aCYd2YyY9UcvJKM4skbKQMv9OLK5ufAlgPy/FgAoJp4=;
        b=N2luTAXJlbp2wDxli8zroYA8k0Ego5RuvxelRj69pTnaKkeoLTtRb7AG/1BoV0o7I/
         xPOC1AB+RJUvXKps2BomJDp4U38LFD2Cq/9a3qBRkX7BCu0PK329cM7lwG+lBfRYLgXR
         5gyuAYJEGWQKYT3GAEMdj5TclpCITKnlHusWQPi0tnmlqWpJU+MdytynQfciBeF3ogac
         BvhSIRSzbBT8v6h0tfbOuc0OyohgLoptLpdcehq8wMtWZvIABs1d0SYF/niD1vz044S/
         nRhWo95VzfK1UB7AP6by8Ti5hyVwCsi10lNLv73fDlrwZkkUVGwqH7jlOS7fqdE91h72
         9tgA==
X-Forwarded-Encrypted: i=1; AJvYcCUJe30VTPuqN148uPnAZ0bPgU8rlmZFJeJDrmtDQZiqYKuZCuzxtAGntQfeQR00cV0anOHy967mFOqJnGEyc7U3EIDjQH/H4xMW0LSXig==
X-Gm-Message-State: AOJu0YzWse6gRDaCAl0oTTao80lw4D0NM7IASKQaGfLgp0/x4lqZtWym
	urme6/K9FfRTvKAbOOjaJU8nEmI9ye7AABHQ4w//Y640qfrEdCoV59NN2WgkKn0wlmzt219asUu
	t1yYDrO7+iDSdlqMY1bgd1Q6IsQ3VTezRgQVXpKfJUpBJqTn6HqkSnZs=
X-Google-Smtp-Source: AGHT+IFXTSyLHOul+mPcd6KJzapopBciz8vsTqGwZwdkGrd8FHPC5Tc3EVg/RyZ8i8Jt7heTTxaaW8O9zUUFhN0esrsUXSPNXkvs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:379f:b0:482:83aa:16be with SMTP id
 w31-20020a056638379f00b0048283aa16bemr260856jal.5.1712823079975; Thu, 11 Apr
 2024 01:11:19 -0700 (PDT)
Date: Thu, 11 Apr 2024 01:11:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ecb1a0615cdb35c@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_xattr_set_entry (2)
From: syzbot <syzbot+4b03894b6ec5753ddf24@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a053fd3ca5d1 Add linux-next specific files for 20240409
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15b0af03180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cef4d00cd7fe38ca
dashboard link: https://syzkaller.appspot.com/bug?extid=4b03894b6ec5753ddf24
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143cd79d180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152e5d9d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/16fbf27c5977/disk-a053fd3c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cac2847d6c46/vmlinux-a053fd3c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c4f6c7891071/bzImage-a053fd3c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/134052cf6b8b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b03894b6ec5753ddf24@syzkaller.appspotmail.com

process 'syz-executor225' launched '/dev/fd/4/./file1' with NULL argv: empty string added
EXT4-fs warning (device loop0): ext4_xattr_inode_create:1471: refuse to create EA inode when umounting
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5089 at fs/ext4/xattr.c:1472 ext4_xattr_inode_create fs/ext4/xattr.c:1472 [inline]
WARNING: CPU: 1 PID: 5089 at fs/ext4/xattr.c:1472 ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1590 [inline]
WARNING: CPU: 1 PID: 5089 at fs/ext4/xattr.c:1472 ext4_xattr_set_entry+0x162c/0x4330 fs/ext4/xattr.c:1718
Modules linked in:
CPU: 1 PID: 5089 Comm: syz-executor225 Not tainted 6.9.0-rc3-next-20240409-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:ext4_xattr_inode_create fs/ext4/xattr.c:1472 [inline]
RIP: 0010:ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1590 [inline]
RIP: 0010:ext4_xattr_set_entry+0x162c/0x4330 fs/ext4/xattr.c:1718
Code: 00 00 e8 57 50 2a ff eb 30 e8 50 50 2a ff 4c 89 ff 48 c7 c6 e9 5d b7 8d ba bf 05 00 00 48 c7 c1 00 aa df 8b e8 75 12 fc ff 90 <0f> 0b 90 49 c7 c4 ea ff ff ff 4c 8b 7c 24 70 48 8b 44 24 40 42 80
RSP: 0018:ffffc9000337efa0 EFLAGS: 00010246
RAX: aa755dc17bf17f00 RBX: 0000000000000000 RCX: aa755dc17bf17f00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000337f230 R08: ffffffff8176bb7c R09: 1ffff9200066fd6c
R10: dffffc0000000000 R11: fffff5200066fd6d R12: ffff88807a280cd8
R13: dffffc0000000000 R14: ffffc9000337f150 R15: ffff888060b68000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 0000000060608000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_xattr_block_set+0x6a2/0x3480 fs/ext4/xattr.c:1968
 ext4_xattr_move_to_block fs/ext4/xattr.c:2654 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2729 [inline]
 ext4_expand_extra_isize_ea+0x12d7/0x1cf0 fs/ext4/xattr.c:2821
 __ext4_expand_extra_isize+0x2fb/0x3e0 fs/ext4/inode.c:5789
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5832 [inline]
 __ext4_mark_inode_dirty+0x524/0x880 fs/ext4/inode.c:5910
 ext4_dirty_inode+0xce/0x110 fs/ext4/inode.c:5942
 __mark_inode_dirty+0x325/0xe20 fs/fs-writeback.c:2486
 mark_inode_dirty_sync include/linux/fs.h:2406 [inline]
 iput+0x1fe/0x930 fs/inode.c:1764
 __dentry_kill+0x20d/0x630 fs/dcache.c:603
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1048
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1075
 shrink_dcache_parent+0xcb/0x3b0
 do_one_tree+0x23/0xe0 fs/dcache.c:1538
 shrink_dcache_for_umount+0x7d/0x130 fs/dcache.c:1555
 generic_shutdown_super+0x6a/0x2d0 fs/super.c:619
 kill_block_super+0x44/0x90 fs/super.c:1675
 ext4_kill_sb+0x68/0xa0 fs/ext4/super.c:7323
 deactivate_locked_super+0xc4/0x130 fs/super.c:472
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7f0fe6f95c49
Code: Unable to access opcode bytes at 0x7f0fe6f95c1f.
RSP: 002b:00007ffc0a1edef8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f0fe6f95c49
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007f0fe7012390 R08: ffffffffffffffb8 R09: 00007ffc0a1edfd0
R10: 0000000000000381 R11: 0000000000000246 R12: 00007f0fe7012390
R13: 0000000000000000 R14: 00007f0fe7013100 R15: 00007f0fe6f63f20
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

