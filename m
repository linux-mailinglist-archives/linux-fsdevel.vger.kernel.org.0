Return-Path: <linux-fsdevel+bounces-15993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFF28966F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7884D1F2519C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F10A6BB2F;
	Wed,  3 Apr 2024 07:45:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30502608ED
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130331; cv=none; b=ioyEmVqJZ6Hy2zponv4/KyaQFL8zPNfruf4xakGi4NTZUyshjb+MuGZMLT8/MwyLVpJWQdtFla6JJeItM//ePfV/kN+Qq7uxK3pPW7jMgpYPo/liQ9vo8qM+cmdQ1JGXUnWxrITZUGbx6Wm467Hd66WE+iLxtKTrA/3djCDLmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130331; c=relaxed/simple;
	bh=pWuz467CjJSWVxTNOZfQnY/x4aIclO9FZQFSkSMa9gA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=a8eCyiBr6hfWvq/LtiQ1j15BWcsaiEHg9TF0h1X5rCqEu4xVDeyw/RaCuvmErc8EcV8Ip2gZI8PlFA7WfE6fNyphJ2fe/8Ap4kQezNpnzns5ozRWzH64HJxkC5P6Qxx9EySxaOSMRn4TbSxyFBHOWbL/h41p0lCwMsz0yK+q3I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-368814a0181so54141725ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 00:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712130329; x=1712735129;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2M+8Zlt/7oWg+Ej7ANcfvSDt2vVUYRFfyU8+IioC+Q=;
        b=CWZtn2Mi1Y6D5y8CvfAl3ZFXnItGpV7ifQFc0FKp4qCEUcmn/DRPP8OWoOwWIFPGpj
         8qvV7VxYUUzZYaNvM4rXWEZyhBPTtVbg2YNhmOFQjj2be5DR1KonfQ+OJmo8sgtjcInD
         Ubx1YOvl0Jn8tj9PspvUtowY4y35zosL/i2sivEzqeS0ed21AIRbkTpY6MaRTaatYTzO
         en/5PN6l5JJJim5pfmJkBkXWwAxD3S+GxwsrWsoaSqclQM/jnn54KZxaHJlzatAs5P1P
         JqWW5+mswexbSQCPIGL9zssBnHzV9pNOVAXDVQBZrhTGAeqiAM6/jo9HfIOhtCnScSW/
         u+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSGFJhKJB2cDIzgMceV68EPUkwO+wPMKKN+y4fq5kTxmhQt07OtYm4aXC56gOeyRsdcAwgM+tGHevbfmUlKXkk8w3I+j933Qc1Ev492Q==
X-Gm-Message-State: AOJu0YywbOuUY9WcjXkvJlY/viF3/scTZXyFWApxyVaTmPLkVPso8FQ4
	d60e+d8DcB/KgT7GfT0ydAlkypeVdeJxhrRLdf5s3djwUuCfEAOONAMZj9S6tLcGEBFrQme4Llf
	pKHO60j3/OFVQaigguN2TdDfx5aMT1JcAU4bzwQtjjdCrF29h0K5aqLw=
X-Google-Smtp-Source: AGHT+IGXNzQ9scnHjWCWfluczGbPD1Us3zL7TVHdJn2HNIvSYo3wofDu76xzt8p7II4xXFfNWyDgkG02R+ZiVgR6Znb9JOeLvM6U
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1785:b0:368:c9e2:b372 with SMTP id
 y5-20020a056e02178500b00368c9e2b372mr889614ilu.0.1712130329291; Wed, 03 Apr
 2024 00:45:29 -0700 (PDT)
Date: Wed, 03 Apr 2024 00:45:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000163e1406152c6877@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_xattr_inode_iget (3)
From: syzbot <syzbot+ee72b9a7aad1e5a77c5c@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11a1e52d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a07d5da4eb21586
dashboard link: https://syzkaller.appspot.com/bug?extid=ee72b9a7aad1e5a77c5c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12407f45180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140d9db1180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b42ab0fd4947/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8a6e7231930/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fbf3e4ce6f8/bzImage-fe46a7dd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5d293cee060a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee72b9a7aad1e5a77c5c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
------------------------------------------------------
syz-executor545/5275 is trying to acquire lock:
ffff888077730400 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
ffff888077730400 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: ext4_xattr_inode_iget+0x173/0x440 fs/ext4/xattr.c:461

but task is already holding lock:
ffff888077730c88 (&ei->i_data_sem/3){++++}-{3:3}, at: ext4_setattr+0x1ba0/0x29d0 fs/ext4/inode.c:5417

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ei->i_data_sem/3){++++}-{3:3}:
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       ext4_update_i_disksize fs/ext4/ext4.h:3383 [inline]
       ext4_xattr_inode_write fs/ext4/xattr.c:1446 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1594 [inline]
       ext4_xattr_set_entry+0x3a14/0x3cf0 fs/ext4/xattr.c:1719
       ext4_xattr_ibody_set+0x126/0x380 fs/ext4/xattr.c:2287
       ext4_xattr_set_handle+0x98d/0x1480 fs/ext4/xattr.c:2444
       ext4_xattr_set+0x149/0x380 fs/ext4/xattr.c:2558
       __vfs_setxattr+0x176/0x1e0 fs/xattr.c:200
       __vfs_setxattr_noperm+0x127/0x5e0 fs/xattr.c:234
       __vfs_setxattr_locked+0x182/0x260 fs/xattr.c:295
       vfs_setxattr+0x146/0x350 fs/xattr.c:321
       do_setxattr+0x146/0x170 fs/xattr.c:629
       setxattr+0x15d/0x180 fs/xattr.c:652
       path_setxattr+0x179/0x1e0 fs/xattr.c:671
       __do_sys_lsetxattr fs/xattr.c:694 [inline]
       __se_sys_lsetxattr fs/xattr.c:690 [inline]
       __x64_sys_lsetxattr+0xc1/0x160 fs/xattr.c:690
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:793 [inline]
       ext4_xattr_inode_iget+0x173/0x440 fs/ext4/xattr.c:461
       ext4_xattr_inode_get+0x16c/0x870 fs/ext4/xattr.c:535
       ext4_xattr_move_to_block fs/ext4/xattr.c:2640 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2742 [inline]
       ext4_expand_extra_isize_ea+0x1367/0x1ae0 fs/ext4/xattr.c:2834
       __ext4_expand_extra_isize+0x346/0x480 fs/ext4/inode.c:5789
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:5832 [inline]
       __ext4_mark_inode_dirty+0x55a/0x860 fs/ext4/inode.c:5910
       ext4_setattr+0x1c14/0x29d0 fs/ext4/inode.c:5420
       notify_change+0x745/0x11c0 fs/attr.c:497
       do_truncate+0x15c/0x220 fs/open.c:65
       handle_truncate fs/namei.c:3300 [inline]
       do_open fs/namei.c:3646 [inline]
       path_openat+0x24b9/0x2990 fs/namei.c:3799
       do_filp_open+0x1dc/0x430 fs/namei.c:3826
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_openat fs/open.c:1437 [inline]
       __se_sys_openat fs/open.c:1432 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1432
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->i_data_sem/3);
                               lock(&ea_inode->i_rwsem#8/1);
                               lock(&ei->i_data_sem/3);
  lock(&ea_inode->i_rwsem#8/1);

 *** DEADLOCK ***

5 locks held by syz-executor545/5275:
 #0: ffff888022da6420 (sb_writers#4){.+.+}-{0:0}, at: do_open fs/namei.c:3635 [inline]
 #0: ffff888022da6420 (sb_writers#4){.+.+}-{0:0}, at: path_openat+0x1fba/0x2990 fs/namei.c:3799
 #1: ffff888077730e00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
 #1: ffff888077730e00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: do_truncate+0x14b/0x220 fs/open.c:63
 #2: ffff888077730fa0 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:838 [inline]
 #2: ffff888077730fa0 (mapping.invalidate_lock){++++}-{3:3}, at: ext4_setattr+0xdfd/0x29d0 fs/ext4/inode.c:5378
 #3: ffff888077730c88 (&ei->i_data_sem/3){++++}-{3:3}, at: ext4_setattr+0x1ba0/0x29d0 fs/ext4/inode.c:5417
 #4: ffff888077730ac8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:162 [inline]
 #4: ffff888077730ac8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:5829 [inline]
 #4: ffff888077730ac8 (&ei->xattr_sem){++++}-{3:3}, at: __ext4_mark_inode_dirty+0x4cf/0x860 fs/ext4/inode.c:5910

stack backtrace:
CPU: 1 PID: 5275 Comm: syz-executor545 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
 inode_lock include/linux/fs.h:793 [inline]
 ext4_xattr_inode_iget+0x173/0x440 fs/ext4/xattr.c:461
 ext4_xattr_inode_get+0x16c/0x870 fs/ext4/xattr.c:535
 ext4_xattr_move_to_block fs/ext4/xattr.c:2640 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2742 [inline]
 ext4_expand_extra_isize_ea+0x1367/0x1ae0 fs/ext4/xattr.c:2834
 __ext4_expand_extra_isize+0x346/0x480 fs/ext4/inode.c:5789
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5832 [inline]
 __ext4_mark_inode_dirty+0x55a/0x860 fs/ext4/inode.c:5910
 ext4_setattr+0x1c14/0x29d0 fs/ext4/inode.c:5420
 notify_change+0x745/0x11c0 fs/attr.c:497
 do_truncate+0x15c/0x220 fs/open.c:65
 handle_truncate fs/namei.c:3300 [inline]
 do_open fs/namei.c:3646 [inline]
 path_openat+0x24b9/0x2990 fs/namei.c:3799
 do_filp_open+0x1dc/0x430 fs/namei.c:3826
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1432
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fc7c030b2e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc3c4a0608 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007fc7c030b2e9
RDX: 0000000000143362 RSI: 00000000200000c0 RDI: 00000000ffffff9c
RBP: 6c6c616c65646f6e R08: 00007ffc3c4a0640 R09: 00007ffc3c4a0640
R10: 000000000a000000 R11: 0000000000000246 R12: 00007ffc3c4a062c
R13: 0000000000000040 R14: 431bde82d7b634db R15: 00007ffc3c4a0660
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

