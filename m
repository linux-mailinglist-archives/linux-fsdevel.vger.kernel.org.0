Return-Path: <linux-fsdevel+bounces-22200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FF291394C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 11:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF7D2815BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAC977105;
	Sun, 23 Jun 2024 09:36:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58F38C
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jun 2024 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719135386; cv=none; b=fmVCQ9J2SxHFqovJ/gUyiTo+1VpydnlcCQIUunrLhROZcyIS7NWNZPRKgZzd/egQNYiC8M5F+68Ac6wkMv1Yg+4s5Yf5d+ww+FI2V9uf2nzGfHjcahchlvFxznCPqQKuzt5QR3IOB4bq4Cj/UUDC+lRRUKBhYdE6Es2g2mbxBls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719135386; c=relaxed/simple;
	bh=GDIuO3zgeL7Kl5+WuVPVtaND6Qt/YJy91wrUY8RBGIg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Sfy425PoIIuuZ2VLTatJHt8PKWpbipleib86GSjB9RAkRRQRXGFGStL7n4EmJ1PJwYtrsV55mpXymhGmsyV35Jmr7Nq1tlw0a1bkSF7rTVw1e4o4V6Jl5MNNi4InLlCCnWeFoXdwbIHwNXqirJy7KTRPTYdtM6Fcv1GH81Ezdrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3745fb76682so40994735ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jun 2024 02:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719135384; x=1719740184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NG1N8DyUmAHaYDrPPVdDaQoJNaPIoWzGqw/9+ysBFKE=;
        b=jsFVzg2AvFstQNFFmbE3gp2IJ1NNinrQ8DPQg8SxXwIne+PVgufbQjM8XscSeHY1Vf
         XeKvjYiQbkaEbg+i46ll3m4uakMVP29ZmzJ8mY3LWHLnIxLdfEy/VSTIB3w3ySms/7de
         EgJOzCrKZdHKAQYo5a8WpjthCvxWNjClY+YB67ykZA8WstZwi7H8nvIZxWFFI3epsD2D
         f37OnIe6CGAm1qVuf3bxD3Tow6iA+QKTZwe5Bs8q0xCH49BlMtSqbu89WfN4GsW4mGOf
         zf5avDD7Sh9xzoZeSdSW74m1TxnbpXXdiRb1ZAe/mEfGW73P8XTeKzaMAQHXUBDRS2VJ
         TV+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7AGRT26AhOS697RrtnaIt9bk2hcYJ2O6sW2Bkag8i9z8JVQeh6Z4yD8ZsIPeQBlBJgdkLUQmCNXxe8744VBykTKy3Bd1MGXaJPMKILA==
X-Gm-Message-State: AOJu0Ywz346hi8K6OywHVnNkKHjzek5RKWhEYgBTHHjp3tH/ULm8amZy
	ZyqvYk0lGce/tm5ikCIJl5M14utj4F1Vyruw92SPJHNj9YZXvgYlU0kgfYNUnx1tNYdxepBjSJh
	sQQUhHrdjU4mTNyKXLC1ulshX7vzTK67ugKpoSzf+n2g1GzjL8tYGifU=
X-Google-Smtp-Source: AGHT+IFaQDUeiIT8h4iwC3zXY0mqgOwPCVIekKrLrDxlj2j0GMhy5IG1+eVpAUt8lSuZd5adyMlELI3bVpg8q6wjKd0ZM7IlScgh
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54b:0:b0:375:a50d:7f2d with SMTP id
 e9e14a558f8ab-3763f5c9fc5mr2100025ab.1.1719135383768; Sun, 23 Jun 2024
 02:36:23 -0700 (PDT)
Date: Sun, 23 Jun 2024 02:36:23 -0700
In-Reply-To: <000000000000f07c2606165ff63a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dee3cc061b8b6538@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfs_extend_file (3)
From: syzbot <syzbot+2a62f58f1a4951a549bb@syzkaller.appspotmail.com>
To: aha310510@gmail.com, jack@suse.cz, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    563a50672d8a Merge tag 'xfs-6.10-fixes-4' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ca148e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12f98862a3c0c799
dashboard link: https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1287d83e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cb8151980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8f92c1547793/disk-563a5067.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21bb27a22e67/vmlinux-563a5067.xz
kernel image: https://storage.googleapis.com/syzbot-assets/168847d060c0/bzImage-563a5067.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/048c1910668d/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/097a7c874267/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a62f58f1a4951a549bb@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc4-syzkaller-00283-g563a50672d8a #0 Not tainted
------------------------------------------------------
syz-executor283/5110 is trying to acquire lock:
ffff88805ee675f8 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}, at: hfs_extend_file+0xff/0x1450 fs/hfs/extent.c:397

but task is already holding lock:
ffff88802992a0b0 (&tree->tree_lock/1){+.+.}-{3:3}, at: hfs_find_init+0x16e/0x1f0

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&tree->tree_lock/1){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hfs_find_init+0x16e/0x1f0
       hfs_ext_read_extent fs/hfs/extent.c:200 [inline]
       hfs_extend_file+0x31b/0x1450 fs/hfs/extent.c:401
       hfs_bmap_reserve+0xd9/0x400 fs/hfs/btree.c:234
       hfs_cat_create+0x1e0/0x970 fs/hfs/catalog.c:104
       hfs_create+0x66/0xe0 fs/hfs/dir.c:202
       lookup_open fs/namei.c:3505 [inline]
       open_last_lookups fs/namei.c:3574 [inline]
       path_openat+0x1425/0x3280 fs/namei.c:3804
       do_filp_open+0x235/0x490 fs/namei.c:3834
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
       do_sys_open fs/open.c:1420 [inline]
       __do_sys_openat fs/open.c:1436 [inline]
       __se_sys_openat fs/open.c:1431 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hfs_extend_file+0xff/0x1450 fs/hfs/extent.c:397
       hfs_bmap_reserve+0xd9/0x400 fs/hfs/btree.c:234
       __hfs_ext_write_extent+0x22e/0x4f0 fs/hfs/extent.c:121
       __hfs_ext_cache_extent+0x6a/0x990 fs/hfs/extent.c:174
       hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
       hfs_extend_file+0x344/0x1450 fs/hfs/extent.c:401
       hfs_get_block+0x3e4/0xb60 fs/hfs/extent.c:353
       __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2128
       __block_write_begin fs/buffer.c:2177 [inline]
       block_write_begin+0x9b/0x1e0 fs/buffer.c:2236
       cont_write_begin+0x645/0x890 fs/buffer.c:2590
       hfs_write_begin+0x8a/0xd0 fs/hfs/inode.c:53
       generic_perform_write+0x322/0x640 mm/filemap.c:4015
       generic_file_write_iter+0xaf/0x310 mm/filemap.c:4136
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa72/0xc90 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&tree->tree_lock/1);
                               lock(&HFS_I(tree->inode)->extents_lock);
                               lock(&tree->tree_lock/1);
  lock(&HFS_I(tree->inode)->extents_lock);

 *** DEADLOCK ***

4 locks held by syz-executor283/5110:
 #0: ffff888029a14420 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2854 [inline]
 #0: ffff888029a14420 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x227/0xc90 fs/read_write.c:586
 #1: ffff8880784d0fa8 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
 #1: ffff8880784d0fa8 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: generic_file_write_iter+0x83/0x310 mm/filemap.c:4133
 #2: ffff8880784d0df8 (&HFS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfs_extend_file+0xff/0x1450 fs/hfs/extent.c:397
 #3: ffff88802992a0b0 (&tree->tree_lock/1){+.+.}-{3:3}, at: hfs_find_init+0x16e/0x1f0

stack backtrace:
CPU: 1 PID: 5110 Comm: syz-executor283 Not tainted 6.10.0-rc4-syzkaller-00283-g563a50672d8a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 hfs_extend_file+0xff/0x1450 fs/hfs/extent.c:397
 hfs_bmap_reserve+0xd9/0x400 fs/hfs/btree.c:234
 __hfs_ext_write_extent+0x22e/0x4f0 fs/hfs/extent.c:121
 __hfs_ext_cache_extent+0x6a/0x990 fs/hfs/extent.c:174
 hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
 hfs_extend_file+0x344/0x1450 fs/hfs/extent.c:401
 hfs_get_block+0x3e4/0xb60 fs/hfs/extent.c:353
 __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2128
 __block_write_begin fs/buffer.c:2177 [inline]
 block_write_begin+0x9b/0x1e0 fs/buffer.c:2236
 cont_write_begin+0x645/0x890 fs/buffer.c:2590
 hfs_write_begin+0x8a/0xd0 fs/hfs/inode.c:53
 generic_perform_write+0x322/0x640 mm/filemap.c:4015
 generic_file_write_iter+0xaf/0x310 mm/filemap.c:4136
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe0c6fea2e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffefba1b208 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fe0c6fea2e9
RDX: 000000000000fea7 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00000000200005c0 R09: 00007ffefba1b240
R10: 0000000000000280 R11: 0000000000000246 R12: 00007ffefba1b22c
R13: 000000000000000b R14: 431bde82d7b634db R15: 00007ffefba1b260
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

