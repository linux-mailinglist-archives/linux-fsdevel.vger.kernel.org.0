Return-Path: <linux-fsdevel+bounces-17252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFFC8A9D53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 16:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F70F1C219BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 14:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD37165FC7;
	Thu, 18 Apr 2024 14:41:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76681DFD8
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451283; cv=none; b=M3JoHCgzMkwHq0rBkEeoxyARPLjNclJp7ZFuNWFEvm0hvyOIbC9jUmiCeuXeTX7fG0U/MqNQ1LI7NMOiK2p/VdVYQVV+gihTxA9PscObcf8eL/mtemw0oY59hwebwGssYrUYNNEqVY8HHmVtxgPz9VExY/8eMgnH+WtM3DueIpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451283; c=relaxed/simple;
	bh=cb8e64hTN+ciIfjJf2xgHxs+vQdw4/48ZtIbLXnFx74=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=axS4v5STxF6h9/UxYz0b5dSRsglq4CR0BiekGKeEp1dBaVIHzq3r+Dk8BqeUcW3s2oJmlAEKmXxThgxU32O03HXC1YyP6TXLZnSZPFxParl5W7VHsr7ablBHQSkTqnHlMxcXqOe+SmsOeT9DHg78Su2/wBmQaIolTBKHq3c7iKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36b31fda393so12541025ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 07:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713451281; x=1714056081;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p944Q1Jelj4Rnuk1KD0m4dCxzYg5EdGsKtMgGEjY+Qg=;
        b=cGZo0FSQYF7wiR0Ek5YfKrI430R6+VexNp+anQfojiobgygA33h3uR46mbnvd/Djhi
         n5tZ0UzUCkFaN/Mdja6zUiXnzk8okIrUZX9vXMuB9aLI9Tcs5GHJ0S8OB3faLarngoLI
         eVg4b1TqxHl2EHZWmNjV2MOtaOCBOxpbmOnIjLhLDAg+OSZ/rVYBmrIhOd1vn4PYEwg0
         ANcgYdrL01OIXrGHcF20gyV0HYptBrrScKUkzoPO15LNN7usPJaQG0PrMOmU3FTSokTl
         N6IUc1xksI8BbH1aqyOFyVN8y4Zin5XLKbdZ+QrKEg+ZfG2upFSoLzSVzZdGCcELXLH9
         O+oA==
X-Gm-Message-State: AOJu0YyCGR06rWSkSlYYJ2dePqyvaRS02OwPQkngrsgL3Tqcg9g8giaR
	Uwx+/o8FtC506vhtzD/2I1uE2vpxfMAglTpsPlfui+Gqa89nXZUGJol6W3ocb1ZJI3XtafkXedK
	FUuoxMG7FBiGYp+2rSCGbuuqqLGEp+ox2B5l1VOzWstzhvXjGmE3JynQ=
X-Google-Smtp-Source: AGHT+IGoS2S7omMqxq4HRfbb1lpmt8F3YvnvOHVAkcNBEeQI/MRKGHOBmBJvv6eLtRIVRTihvGzUElDsQoWE1zviw0knWT+W0SdJ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe6:b0:36b:f8:e87e with SMTP id
 dt6-20020a056e021fe600b0036b00f8e87emr86480ilb.1.1713451280917; Thu, 18 Apr
 2024 07:41:20 -0700 (PDT)
Date: Thu, 18 Apr 2024 07:41:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f07c2606165ff63a@google.com>
Subject: [syzbot] [hfs?] possible deadlock in hfs_extend_file (3)
From: syzbot <syzbot+2a62f58f1a4951a549bb@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1556f7cb180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/089e25869df5/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/423b1787914f/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c043e30c07d/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a62f58f1a4951a549bb@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
------------------------------------------------------
syz-executor.3/5818 is trying to acquire lock:
ffff888060dd1af8 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}, at: hfs_extend_file+0xa2/0xb10 fs/hfs/extent.c:397

but task is already holding lock:
ffff88802c4140b0 (&tree->tree_lock#2/1){+.+.}-{3:3}, at: hfs_find_init+0x183/0x220 fs/hfs/bfind.c:33

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&tree->tree_lock#2/1){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       hfs_find_init+0x183/0x220 fs/hfs/bfind.c:33
       hfs_ext_read_extent+0x19c/0x9e0 fs/hfs/extent.c:200
       hfs_extend_file+0x4e4/0xb10 fs/hfs/extent.c:401
       hfs_bmap_reserve+0x29c/0x380 fs/hfs/btree.c:234
       hfs_cat_create+0x22b/0x810 fs/hfs/catalog.c:104
       hfs_create+0x6b/0xf0 fs/hfs/dir.c:202
       lookup_open.isra.0+0x10a1/0x13c0 fs/namei.c:3497
       open_last_lookups fs/namei.c:3566 [inline]
       path_openat+0x92f/0x2990 fs/namei.c:3796
       do_filp_open+0x1dc/0x430 fs/namei.c:3826
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_openat fs/open.c:1437 [inline]
       __se_sys_openat fs/open.c:1432 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1432
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       hfs_extend_file+0xa2/0xb10 fs/hfs/extent.c:397
       hfs_bmap_reserve+0x29c/0x380 fs/hfs/btree.c:234
       __hfs_ext_write_extent+0x3cf/0x520 fs/hfs/extent.c:121
       __hfs_ext_cache_extent fs/hfs/extent.c:174 [inline]
       hfs_ext_read_extent+0x809/0x9e0 fs/hfs/extent.c:202
       hfs_extend_file+0x4e4/0xb10 fs/hfs/extent.c:401
       hfs_get_block+0x17f/0x830 fs/hfs/extent.c:353
       __block_write_begin_int+0x4fb/0x16e0 fs/buffer.c:2105
       __block_write_begin fs/buffer.c:2154 [inline]
       block_write_begin+0xb1/0x4a0 fs/buffer.c:2213
       cont_write_begin+0x53d/0x740 fs/buffer.c:2567
       hfs_write_begin+0x87/0x150 fs/hfs/inode.c:53
       generic_perform_write+0x272/0x620 mm/filemap.c:3930
       __generic_file_write_iter+0x1fd/0x240 mm/filemap.c:4025
       generic_file_write_iter+0xe7/0x350 mm/filemap.c:4051
       call_write_iter include/linux/fs.h:2108 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0x6db/0x1100 fs/read_write.c:590
       ksys_write+0x12f/0x260 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&tree->tree_lock#2/1);
                               lock(&HFS_I(tree->inode)->extents_lock);
                               lock(&tree->tree_lock#2/1);
  lock(&HFS_I(tree->inode)->extents_lock);

 *** DEADLOCK ***

5 locks held by syz-executor.3/5818:
 #0: ffff888011652348 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xeb/0x180 fs/file.c:1191
 #1: ffff88802ce58420 (sb_writers#16){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:643
 #2: ffff888060dd6aa8 (&sb->s_type->i_mutex_key#23){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
 #2: ffff888060dd6aa8 (&sb->s_type->i_mutex_key#23){+.+.}-{3:3}, at: generic_file_write_iter+0x92/0x350 mm/filemap.c:4048
 #3: ffff888060dd68f8 (&HFS_I(inode)->extents_lock#2){+.+.}-{3:3}, at: hfs_extend_file+0xa2/0xb10 fs/hfs/extent.c:397
 #4: ffff88802c4140b0 (&tree->tree_lock#2/1){+.+.}-{3:3}, at: hfs_find_init+0x183/0x220 fs/hfs/bfind.c:33

stack backtrace:
CPU: 0 PID: 5818 Comm: syz-executor.3 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
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
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 hfs_extend_file+0xa2/0xb10 fs/hfs/extent.c:397
 hfs_bmap_reserve+0x29c/0x380 fs/hfs/btree.c:234
 __hfs_ext_write_extent+0x3cf/0x520 fs/hfs/extent.c:121
 __hfs_ext_cache_extent fs/hfs/extent.c:174 [inline]
 hfs_ext_read_extent+0x809/0x9e0 fs/hfs/extent.c:202
 hfs_extend_file+0x4e4/0xb10 fs/hfs/extent.c:401
 hfs_get_block+0x17f/0x830 fs/hfs/extent.c:353
 __block_write_begin_int+0x4fb/0x16e0 fs/buffer.c:2105
 __block_write_begin fs/buffer.c:2154 [inline]
 block_write_begin+0xb1/0x4a0 fs/buffer.c:2213
 cont_write_begin+0x53d/0x740 fs/buffer.c:2567
 hfs_write_begin+0x87/0x150 fs/hfs/inode.c:53
 generic_perform_write+0x272/0x620 mm/filemap.c:3930
 __generic_file_write_iter+0x1fd/0x240 mm/filemap.c:4025
 generic_file_write_iter+0xe7/0x350 mm/filemap.c:4051
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6db/0x1100 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7efc4247de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efc41fff0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007efc425abf80 RCX: 00007efc4247de69
RDX: 000000000208e24b RSI: 00000000200004c0 RDI: 0000000000000005
RBP: 00007efc424ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007efc425abf80 R15: 00007ffea65dcd48
 </TASK>


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

