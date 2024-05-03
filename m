Return-Path: <linux-fsdevel+bounces-18662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C78928BB178
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 19:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8281F23330
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 17:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFD5157E61;
	Fri,  3 May 2024 17:09:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838856FDC
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756194; cv=none; b=lLPbDEoh8mDLXRByoHyYi0T0c8Q3HsHeNqfzFaIsiBDl8TCSB+hTatddFHI6hUol38TRCOLtt8q6dhUvSAYP0Te3h6k1P4zgrMYyULRd155crouv1LaIy1Q/h6elY815FEcKUZ7fTT4+qno4P1iLHaFAcmkoZQD9Jri60RHWlv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756194; c=relaxed/simple;
	bh=oYvLlAeSKD1ToLbva0WKmZmZmIQt8CXXHhtPcGZatdo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HfEj7FZenu36VdgTwDYXz3c9XoIc/QWNad3QYtxHQ7lQ8CeFJRAF+SVeMHZNbnjrBVPixDgvduCWSqfvokbBY+tu7L3pSCuGwVRWG1xyafQXcw6+bR8VdQPAF+/mEUTeF3Hrk8l1J0X9/kxI01LmssIwMZkPS0Ks2X+CZCEIjEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ddf0219685so991572039f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 10:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714756192; x=1715360992;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICVcUESg+fMhAvf0c9alYcYQ0Fp09UV2b119s2qZbFY=;
        b=orozWSjYrpJP/9sa3XUhNsFV+ecWyT8GiFrdIyEPEf/3d+20nj7248vLSsBW85OE/M
         dc3JD0l+OV4NIbEVO5tPRwGvOvLR36NE6qbP4+G0nmGVJbseY4I4lW9DXqFtvT4e7fdg
         t1CXbwCkHtVtPqClcbARiRUdpbD9Agi/WqjEB462YpNsRbRtE8j5CAHV4o7yNakdghm/
         d2aj5CgR+KklaDK3I8aMcLsmiyXjXFwzQRLYvn5aYzvm0tNTOm/OS7dlu2aD5UcL0Z7v
         Rv00yDsXuxv/MOx2iyhyDLr0kxIKhoU1M4hAEgSmxuFjKQ4WESaVo4O3+J4VJpJHVAJ1
         JJbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy/B/TlZXN7+4uC8DQ4Ps8VFKjFCRUOYIaJi9v+TIx2+vb+O39nuvUHtjrVHINNGNCotEkSKFkkLZhzVQ9tsaXkiXkSJAsodlqpWOpAQ==
X-Gm-Message-State: AOJu0YwI6C+pm57lbCiC0oQsF50q6KZYQWObvir0AppCjfCJimSqlLDa
	uAUwFukDQqFfhHedFmzE3/5EOgwwk2yc+O4mquPhfk0Yf1GHsz1Up+wOhDSPvqkWac2DeKLK25f
	B+f8uJGg9ZZlzCFG/pLecarrVkjstlOQqHGcPsYiLhVG9IZz/DtoMqS4=
X-Google-Smtp-Source: AGHT+IGTDxWirenmFJgByBWzNigPUKmi5W0WiRwiEA2Q8+rKXEjHYvP+T26CAxC+VtLRzzhIx3lahTYxBT0xHaSaa9DJK+jZ2mfD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:158f:b0:7de:e20c:cd3d with SMTP id
 e15-20020a056602158f00b007dee20ccd3dmr178201iow.0.1714756191873; Fri, 03 May
 2024 10:09:51 -0700 (PDT)
Date: Fri, 03 May 2024 10:09:51 -0700
In-Reply-To: <000000000000636fa106178cd1e4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b17eb906178fc94b@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in bch2_varint_decode_fast
From: syzbot <syzbot+66b9b74f6520068596a9@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    6a71d2909427 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=116a9d74980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fca646cf17cc616b
dashboard link: https://syzkaller.appspot.com/bug?extid=66b9b74f6520068596a9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12221898980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16758560980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c77d21fa1405/disk-6a71d290.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/429fcd369816/vmlinux-6a71d290.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d3d8a4b85112/Image-6a71d290.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3a2e4c986182/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+66b9b74f6520068596a9@syzkaller.appspotmail.com

bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): going read-write
bcachefs (loop0): done starting filesystem
==================================================================
BUG: KASAN: slab-out-of-bounds in get_unaligned_le64 include/asm-generic/unaligned.h:37 [inline]
BUG: KASAN: slab-out-of-bounds in bch2_varint_decode_fast+0x138/0x184 fs/bcachefs/varint.c:114
Read of size 8 at addr ffff0000d35a5286 by task syz-executor424/6243

CPU: 0 PID: 6243 Comm: syz-executor424 Not tainted 6.9.0-rc4-syzkaller-g6a71d2909427 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x198/0x538 mm/kasan/report.c:488
 kasan_report+0xd8/0x138 mm/kasan/report.c:601
 __asan_report_load_n_noabort+0x1c/0x28 mm/kasan/report_generic.c:391
 get_unaligned_le64 include/asm-generic/unaligned.h:37 [inline]
 bch2_varint_decode_fast+0x138/0x184 fs/bcachefs/varint.c:114
 bch2_inode_unpack_v3 fs/bcachefs/inode.c:270 [inline]
 bch2_inode_unpack+0x604/0x1fd0 fs/bcachefs/inode.c:323
 __bch2_inode_invalid+0x118/0x4d0 fs/bcachefs/inode.c:449
 bch2_inode_v3_invalid+0x114/0x1f4 fs/bcachefs/inode.c:529
 bch2_bkey_val_invalid fs/bcachefs/bkey_methods.c:140 [inline]
 bch2_bkey_invalid+0x130/0x1d8 fs/bcachefs/bkey_methods.c:227
 __bch2_trans_commit+0x77c/0x55c4 fs/bcachefs/btree_trans_commit.c:1006
 bch2_trans_commit fs/bcachefs/btree_update.h:168 [inline]
 bch2_extent_update+0x3d0/0x9b4 fs/bcachefs/io_write.c:318
 bch2_write_index_default fs/bcachefs/io_write.c:366 [inline]
 __bch2_write_index+0x6b4/0x1324 fs/bcachefs/io_write.c:520
 bch2_write_data_inline fs/bcachefs/io_write.c:1538 [inline]
 bch2_write+0xd74/0x1520 fs/bcachefs/io_write.c:1606
 closure_queue include/linux/closure.h:257 [inline]
 closure_call include/linux/closure.h:390 [inline]
 bch2_writepage_do_io fs/bcachefs/fs-io-buffered.c:468 [inline]
 bch2_writepages+0x224/0x304 fs/bcachefs/fs-io-buffered.c:660
 do_writepages+0x2f8/0x7c4 mm/page-writeback.c:2612
 filemap_fdatawrite_wbc+0x124/0x174 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 filemap_write_and_wait_range+0x158/0x23c mm/filemap.c:685
 bch2_symlink+0x118/0x1d0 fs/bcachefs/fs.c:584
 vfs_symlink+0x138/0x260 fs/namei.c:4481
 do_symlinkat+0x1bc/0x45c fs/namei.c:4507
 __do_sys_symlinkat fs/namei.c:4523 [inline]
 __se_sys_symlinkat fs/namei.c:4520 [inline]
 __arm64_sys_symlinkat+0xa4/0xbc fs/namei.c:4520
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Allocated by task 6243:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:565
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc_node_track_caller+0x2e4/0x544 mm/slub.c:3986
 __do_krealloc mm/slab_common.c:1192 [inline]
 krealloc+0x94/0x148 mm/slab_common.c:1225
 __bch2_trans_kmalloc+0x1dc/0xb28 fs/bcachefs/btree_iter.c:2831
 bch2_trans_kmalloc_nomemzero fs/bcachefs/btree_iter.h:532 [inline]
 __bch2_bkey_make_mut_noupdate fs/bcachefs/btree_update.h:223 [inline]
 __bch2_bkey_get_mut_noupdate fs/bcachefs/btree_update.h:282 [inline]
 bch2_bkey_get_mut_noupdate fs/bcachefs/btree_update.h:293 [inline]
 bch2_extent_update_i_size_sectors+0x5fc/0x854 fs/bcachefs/io_write.c:219
 bch2_extent_update+0x338/0x9b4 fs/bcachefs/io_write.c:314
 bch2_write_index_default fs/bcachefs/io_write.c:366 [inline]
 __bch2_write_index+0x6b4/0x1324 fs/bcachefs/io_write.c:520
 bch2_write_data_inline fs/bcachefs/io_write.c:1538 [inline]
 bch2_write+0xd74/0x1520 fs/bcachefs/io_write.c:1606
 closure_queue include/linux/closure.h:257 [inline]
 closure_call include/linux/closure.h:390 [inline]
 bch2_writepage_do_io fs/bcachefs/fs-io-buffered.c:468 [inline]
 bch2_writepages+0x224/0x304 fs/bcachefs/fs-io-buffered.c:660
 do_writepages+0x2f8/0x7c4 mm/page-writeback.c:2612
 filemap_fdatawrite_wbc+0x124/0x174 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 filemap_write_and_wait_range+0x158/0x23c mm/filemap.c:685
 bch2_symlink+0x118/0x1d0 fs/bcachefs/fs.c:584
 vfs_symlink+0x138/0x260 fs/namei.c:4481
 do_symlinkat+0x1bc/0x45c fs/namei.c:4507
 __do_sys_symlinkat fs/namei.c:4523 [inline]
 __se_sys_symlinkat fs/namei.c:4520 [inline]
 __arm64_sys_symlinkat+0xa4/0xbc fs/namei.c:4520
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

The buggy address belongs to the object at ffff0000d35a5200
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 6 bytes to the right of
 allocated 128-byte region [ffff0000d35a5200, ffff0000d35a5280)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1135a5
flags: 0x5ffe00000000800(slab|node=0|zone=2|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 05ffe00000000800 ffff0000c00018c0 fffffdffc33e9200 dead000000000004
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000d35a5180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000d35a5200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff0000d35a5280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff0000d35a5300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000d35a5380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

