Return-Path: <linux-fsdevel+bounces-15833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00531894253
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 18:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA25E28344D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACDA50A8F;
	Mon,  1 Apr 2024 16:51:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531724D59F
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990283; cv=none; b=SKlE8LRP9W2ym8EC45d4nt8BuIOH+MrSZCohvewxVM/Spzi0G16r7g3otoPXsZdFOwvNX8xL/xmsOs8Y6HzwW3wnw+IcKnvGaVsj7ymkOAB8QOmBy2VNAs8q7IAJ2SAc71NKzJWv+dLh/ALC0sQ8N/S1f7TfqoIDyEiGUGRqeKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990283; c=relaxed/simple;
	bh=yomIkOv1iNN25m2c71KHbCEQes+QXQ6arnsFTaT+REE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=grfXMvjMryv0ztZo1MF5G+d24jgCjtA6SSuBggm/ix2cap/f9nfSJh9PCNuzHoD4LgaWP8Wl5xEFpBLugmukYJJx2mTxTuGN46gGfgQtk1NveM6bCrbwGT5xEj7x6LNpmROBVrX2AS87JOiw+8vs+jSsdazbcY7kqW8jzKjhxac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbf1aea97fso467714939f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Apr 2024 09:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711990280; x=1712595080;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M8sRsX9oj8EYrJwx7cJqGn/qBC0J7akgWFj1v3Fd8Eo=;
        b=rqbJ1yuIJvn9rAcP4rwm06I4hmXH8ZZt+q6fgEIZK23eTQNsTnPfpFO3pTzJN+Ez0V
         aVHkBo1eeP7rVRIhCHbJ+csD0AyHnhJfzSurpwJqiY4TsyZsAMFo9UoQqE+0+Un6TXM4
         UjPKSTSMCZ5hv9hX0TrODeyI9if5xbI3kjaUf8C5p7/Bty2sKaN9R5lng1cSiyKoJFkE
         17T/7EBJElsMVLOPdvI5OekEZY1hr33+f5Rp4QZmsCWOm3cGRABMHm0TGZsi9aY+shyz
         sfIFs5g4MX52JRlZdHOVbbPfPiaTA3p4xgFRU5jIvVhi1lSrLwuog/UlrundbaI+244J
         7Vbw==
X-Forwarded-Encrypted: i=1; AJvYcCWqIJG3hnK1Beqbv1AxNY/wnaAofQvmAUeA4XHdTuJVYAyRAQFN+ZpMfl35cS0NI19MGoOJwZHSDlErGrjKFl7SPgF7GqMj68rQID9Gag==
X-Gm-Message-State: AOJu0YxyAyi9xQn43tP/vmY4DfFSy+sroAReZZ/rTsLir+yb5bPFg7ig
	8IWZBoquNYACaTL8NFECWLdUlST+P2OwiXqhxk20vnnoruyF14X4rcWfL81sgxFfHqOGYrV/8lT
	WH6Vr047Doja+NIctFwW5ogfs6rNY7KhwxNGkRyp7e3BlHIpzjEodXVo=
X-Google-Smtp-Source: AGHT+IGu3AQDPLjNZnSMBmnVNEi+JZEWBxvuzFBM38+Fg/OOsm/aVmYq31P5vrt6zv40vQj+/4oYMdAQvO2seircNwEmvWwqAHzC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35ab:b0:47e:db25:8eb7 with SMTP id
 v43-20020a05663835ab00b0047edb258eb7mr653579jal.2.1711990280582; Mon, 01 Apr
 2024 09:51:20 -0700 (PDT)
Date: Mon, 01 Apr 2024 09:51:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008886db06150bcc92@google.com>
Subject: [syzbot] [ntfs3?] INFO: trying to register non-static key in
 do_mpage_readpage (2)
From: syzbot <syzbot+6783b9aaa6a224fabde8@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4535e1a4174c x86/bugs: Fix the SRSO mitigation on Zen3/4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a4b3d9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f64ec427e98bccd7
dashboard link: https://syzkaller.appspot.com/bug?extid=6783b9aaa6a224fabde8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145213d9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11869af9180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-4535e1a4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/af9b780d5ab6/vmlinux-4535e1a4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca7710536ebc/bzImage-4535e1a4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8ba3546286ed/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6783b9aaa6a224fabde8@syzkaller.appspotmail.com

ntfs3: loop0: Mark volume as dirty due to NTFS errors
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 5194 Comm: syz-executor221 Not tainted 6.9.0-rc1-syzkaller-00206-g4535e1a4174c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 assign_lock_key kernel/locking/lockdep.c:976 [inline]
 register_lock_class+0xc2a/0x1230 kernel/locking/lockdep.c:1289
 __lock_acquire+0x111/0x3b30 kernel/locking/lockdep.c:5014
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
 attr_data_get_block+0x18b/0x1b70 fs/ntfs3/attrib.c:902
 ntfs_get_block_vbo+0x288/0xec0 fs/ntfs3/inode.c:587
 do_mpage_readpage+0x660/0x17c0 fs/mpage.c:232
 mpage_readahead+0x34d/0x590 fs/mpage.c:381
 ntfs_readahead+0x1f7/0x250 fs/ntfs3/inode.c:755
 read_pages+0x1a8/0xda0 mm/readahead.c:160
 page_cache_ra_unbounded+0x450/0x5a0 mm/readahead.c:269
 do_page_cache_ra mm/readahead.c:299 [inline]
 page_cache_ra_order+0x64b/0x9a0 mm/readahead.c:539
 ondemand_readahead+0x520/0x1140 mm/readahead.c:661
 page_cache_sync_ra+0x174/0x1d0 mm/readahead.c:688
 page_cache_sync_readahead include/linux/pagemap.h:1300 [inline]
 filemap_get_pages+0xc09/0x1840 mm/filemap.c:2505
 filemap_read+0x3af/0xd10 mm/filemap.c:2601
 generic_file_read_iter+0x350/0x460 mm/filemap.c:2782
 ntfs_file_read_iter+0x258/0x330 fs/ntfs3/file.c:768
 __kernel_read+0x3ec/0xb20 fs/read_write.c:434
 integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm+0x2cf/0x3e0 security/integrity/ima/ima_crypto.c:485
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1c6/0x4a0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x7eb/0x950 security/integrity/ima/ima_api.c:291
 process_measurement+0x11ae/0x2100 security/integrity/ima/ima_main.c:359
 ima_file_check+0xc1/0x110 security/integrity/ima/ima_main.c:559
 security_file_post_open+0x6d/0xc0 security/security.c:2981
 do_open fs/namei.c:3644 [inline]
 path_openat+0x17ad/0x2990 fs/namei.c:3799
 do_file_open_root+0x2dd/0x5b0 fs/namei.c:3851
 file_open_root+0x2a8/0x450 fs/open.c:1386
 do_handle_open+0x3c9/0x5c0 fs/fhandle.c:235
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7f773274c6f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffea3fa8848 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 00007ffea3fa8a18 RCX: 00007f773274c6f9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 00007f77327de610 R08: 00007ffea3fa8a18 R09: 00007ffea3fa8a18
R10: 00007ffea3fa8a18 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffea3fa8a08 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x100, magic = 0x0, owner = 0xffff888025864881, curr 0xffff888025864880, list not empty
WARNING: CPU: 0 PID: 5194 at kernel/locking/rwsem.c:1342 __up_read+0x508/0x760 kernel/locking/rwsem.c:1342
Modules linked in:
CPU: 0 PID: 5194 Comm: syz-executor221 Not tainted 6.9.0-rc1-syzkaller-00206-g4535e1a4174c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__up_read+0x508/0x760 kernel/locking/rwsem.c:1342
Code: 24 10 80 3c 02 00 0f 85 21 02 00 00 48 8b 13 41 57 48 c7 c6 20 bf 2c 8b 48 c7 c7 60 bf 2c 8b 4c 8b 4c 24 08 e8 79 82 e5 ff 90 <0f> 0b 90 90 5f e9 c3 fe ff ff c6 05 46 38 60 0e 01 90 4c 8d 7b 58
RSP: 0018:ffffc900037de2a0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88803259efe0 RCX: ffffffff814fe149
RDX: ffff888025864880 RSI: ffffffff814fe156 RDI: 0000000000000001
RBP: ffffffff8fe14954 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 57525f4755424544 R12: ffff88803259efe8
R13: 1ffff920006fbc58 R14: ffff88803259f048 R15: ffffffff8b2cbee0
FS:  000055558a2df380(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f772a3ff000 CR3: 000000001e23e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 attr_data_get_block+0x1f9/0x1b70 fs/ntfs3/attrib.c:905
 ntfs_get_block_vbo+0x288/0xec0 fs/ntfs3/inode.c:587
 do_mpage_readpage+0x660/0x17c0 fs/mpage.c:232
 mpage_readahead+0x34d/0x590 fs/mpage.c:381
 ntfs_readahead+0x1f7/0x250 fs/ntfs3/inode.c:755
 read_pages+0x1a8/0xda0 mm/readahead.c:160
 page_cache_ra_unbounded+0x450/0x5a0 mm/readahead.c:269
 do_page_cache_ra mm/readahead.c:299 [inline]
 page_cache_ra_order+0x64b/0x9a0 mm/readahead.c:539
 ondemand_readahead+0x520/0x1140 mm/readahead.c:661
 page_cache_sync_ra+0x174/0x1d0 mm/readahead.c:688
 page_cache_sync_readahead include/linux/pagemap.h:1300 [inline]
 filemap_get_pages+0xc09/0x1840 mm/filemap.c:2505
 filemap_read+0x3af/0xd10 mm/filemap.c:2601
 generic_file_read_iter+0x350/0x460 mm/filemap.c:2782
 ntfs_file_read_iter+0x258/0x330 fs/ntfs3/file.c:768
 __kernel_read+0x3ec/0xb20 fs/read_write.c:434
 integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm+0x2cf/0x3e0 security/integrity/ima/ima_crypto.c:485
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1c6/0x4a0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x7eb/0x950 security/integrity/ima/ima_api.c:291
 process_measurement+0x11ae/0x2100 security/integrity/ima/ima_main.c:359
 ima_file_check+0xc1/0x110 security/integrity/ima/ima_main.c:559
 security_file_post_open+0x6d/0xc0 security/security.c:2981
 do_open fs/namei.c:3644 [inline]
 path_openat+0x17ad/0x2990 fs/namei.c:3799
 do_file_open_root+0x2dd/0x5b0 fs/namei.c:3851
 file_open_root+0x2a8/0x450 fs/open.c:1386
 do_handle_open+0x3c9/0x5c0 fs/fhandle.c:235
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7f773274c6f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffea3fa8848 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 00007ffea3fa8a18 RCX: 00007f773274c6f9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 00007f77327de610 R08: 00007ffea3fa8a18 R09: 00007ffea3fa8a18
R10: 00007ffea3fa8a18 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffea3fa8a08 R14: 0000000000000001 R15: 0000000000000001
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

