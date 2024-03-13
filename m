Return-Path: <linux-fsdevel+bounces-14371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A66087B46E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 23:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2651FB20C95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 22:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7344B5C8EC;
	Wed, 13 Mar 2024 22:37:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644DD5B669
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369440; cv=none; b=mcst/62q3sySxVK6uBr5BQCZf3yrBVezsK6HRsUX45jftuZ3tXxOgpIVYx2//yOMg01jTQc2jwXehzUAYFZUDhc3kj9YWaZPWK8p7OyuGTSQd4F1U4GUY1urIIoiYqwM1T3o8qtwDglfk0XDJUpZakpign1Af1nu4aN8U4VmzGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369440; c=relaxed/simple;
	bh=wfsp7zeRY7DNEE9JgmVTOMD+yPxGSvQDSM12CKhmRto=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QAFA+fNXtwuolynrypHgtvPsVQam0yDkXGYJva1pqvr+uKhPKE+wkB8LLM8hNcfzvTOB8Nx2fZfo0sjbeacL6WWn7MKabgjkqyWplLfBhwSPVPrT0DAb7F0cJ/cjTkrRYxQA2ezTgNjhDjyU2mbVGaisgTJRpOeDGIVhh+2CcqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c8b8a6f712so23880739f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 15:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369437; x=1710974237;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CiDwXR/cHCEfoxNula4QzlbbACj3pXP/VXn5m7A6WdE=;
        b=PSeR/LiYiaP89zwaoBAgLcB5F01fAl9QIMjVuI892FG0F7VTbMLPWZrJmro694MP6z
         y32G9Uw8MrxrxfahOvRI7VI0BIt8Ew+87Yhj2XCucSEjdW1wS1rG5jYgS8IsL596Erq+
         wua2PeEEEMAKbnc0EhHLuYO+wz7/okXjIeJhFos2SOCQgBkfn0grdWIL3TbKd28s1sGx
         fZNsYkLRGzlLHwl2pykVIOXc4ateANfloHf1I7TpUPcMxMnoGtOPvqNtXlLiraRTkz3H
         lGtpe4WZ73JE6hxbZdiQNQ/vvnhL7xAKCUzMOT9IDq1d+h9zw2OwT4qV/HSBK2+DqFDw
         YjgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKjevYBqKjWfW2CtkGiJOzUN0RiZhq6vFyy2Vx4yY48GaPZnuI3tgw35qmZjBxxpctPabUESuUGqlMfCV7BZvFisaEp8QRlcgJd4Q2Aw==
X-Gm-Message-State: AOJu0Yx7uSHTewSYp8ZQZGLXV9a9EoENwSChZoIzxqnJv0NbcvTDRzcv
	Fa9WLT9s82AvvIM+W29Bc0I+Chg6DpED2biEBfQ9VxodCbgP0ZnKK6Ks3MN6f0enVNysJxiCjdS
	Cuexm89zE+DzkIHbzwdcWlwDw5fytmGVm1t85jEGhY2/AiOs2yhAjz0A=
X-Google-Smtp-Source: AGHT+IHdLzy96Jh+QE5NrTcUWT6gDKvJvonB0/3sPz/by9GZHo5dXx3DmAFJRBheoOPq9uq9V/safCGBOBdkI7GEJ0EUtvm5maeE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14cb:b0:7c8:afc3:3f70 with SMTP id
 b11-20020a05660214cb00b007c8afc33f70mr5385iow.4.1710369437650; Wed, 13 Mar
 2024 15:37:17 -0700 (PDT)
Date: Wed, 13 Mar 2024 15:37:17 -0700
In-Reply-To: <0000000000009c31e605ee9c1a13@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4223e0613926aa6@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfsplus_block_allocate
From: syzbot <syzbot+b6ccd31787585244a855@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, fmdefrancesco@gmail.com, ira.weiny@intel.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    61387b8dcf1d Merge tag 'for-6.9/dm-vdo' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126d69d1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e30ff6b515606856
dashboard link: https://syzkaller.appspot.com/bug?extid=b6ccd31787585244a855
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129e58c9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154b15d6180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cab7c2663886/disk-61387b8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b9dd4f348b5/vmlinux-61387b8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/222aa1f905fd/bzImage-61387b8d.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/fead63abbb06/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/f46392d41e04/mount_3.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6ccd31787585244a855@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-05562-g61387b8dcf1d #0 Not tainted
------------------------------------------------------
syz-executor170/6261 is trying to acquire lock:
ffff88807f2b10f8 (&sbi->alloc_mutex){+.+.}-{3:3}, at: hfsplus_block_allocate+0x9e/0x8c0 fs/hfsplus/bitmap.c:35

but task is already holding lock:
ffff88807f19df88 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_extend+0x21b/0x1b70 fs/hfsplus/extents.c:457

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hfsplus_get_block+0x383/0x14f0 fs/hfsplus/extents.c:260
       block_read_full_folio+0x42e/0xe10 fs/buffer.c:2384
       filemap_read_folio+0x1a0/0x790 mm/filemap.c:2324
       do_read_cache_folio+0x134/0x820 mm/filemap.c:3694
       do_read_cache_page+0x30/0x200 mm/filemap.c:3760
       read_mapping_page include/linux/pagemap.h:888 [inline]
       hfsplus_block_allocate+0xee/0x8c0 fs/hfsplus/bitmap.c:37
       hfsplus_file_extend+0xade/0x1b70 fs/hfsplus/extents.c:468
       hfsplus_get_block+0x406/0x14f0 fs/hfsplus/extents.c:245
       __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2105
       __block_write_begin fs/buffer.c:2154 [inline]
       block_write_begin+0x9b/0x1e0 fs/buffer.c:2213
       cont_write_begin+0x645/0x890 fs/buffer.c:2567
       hfsplus_write_begin+0x8a/0xd0 fs/hfsplus/inode.c:47
       cont_expand_zero fs/buffer.c:2527 [inline]
       cont_write_begin+0x6ee/0x890 fs/buffer.c:2557
       hfsplus_write_begin+0x8a/0xd0 fs/hfsplus/inode.c:47
       generic_cont_expand_simple+0x18f/0x2b0 fs/buffer.c:2458
       hfsplus_setattr+0x178/0x280 fs/hfsplus/inode.c:259
       notify_change+0xb9d/0xe70 fs/attr.c:497
       do_truncate fs/open.c:65 [inline]
       do_ftruncate+0x46b/0x590 fs/open.c:181
       do_sys_ftruncate fs/open.c:199 [inline]
       __do_sys_ftruncate fs/open.c:207 [inline]
       __se_sys_ftruncate fs/open.c:205 [inline]
       __x64_sys_ftruncate+0x95/0xf0 fs/open.c:205
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (&sbi->alloc_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hfsplus_block_allocate+0x9e/0x8c0 fs/hfsplus/bitmap.c:35
       hfsplus_file_extend+0xade/0x1b70 fs/hfsplus/extents.c:468
       hfsplus_get_block+0x406/0x14f0 fs/hfsplus/extents.c:245
       __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2105
       __block_write_begin fs/buffer.c:2154 [inline]
       block_write_begin+0x9b/0x1e0 fs/buffer.c:2213
       cont_write_begin+0x645/0x890 fs/buffer.c:2567
       hfsplus_write_begin+0x8a/0xd0 fs/hfsplus/inode.c:47
       cont_expand_zero fs/buffer.c:2494 [inline]
       cont_write_begin+0x319/0x890 fs/buffer.c:2557
       hfsplus_write_begin+0x8a/0xd0 fs/hfsplus/inode.c:47
       generic_perform_write+0x322/0x640 mm/filemap.c:3921
       generic_file_write_iter+0xaf/0x310 mm/filemap.c:4042
       do_iter_readv_writev+0x5a4/0x800
       vfs_writev+0x395/0xbb0 fs/read_write.c:971
       do_pwritev fs/read_write.c:1072 [inline]
       __do_sys_pwritev2 fs/read_write.c:1131 [inline]
       __se_sys_pwritev2+0x1ca/0x2d0 fs/read_write.c:1122
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&HFSPLUS_I(inode)->extents_lock);
                               lock(&sbi->alloc_mutex);
                               lock(&HFSPLUS_I(inode)->extents_lock);
  lock(&sbi->alloc_mutex);

 *** DEADLOCK ***

3 locks held by syz-executor170/6261:
 #0: ffff88806d1ea420 (sb_writers#11){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2853 [inline]
 #0: ffff88806d1ea420 (sb_writers#11){.+.+}-{0:0}, at: vfs_writev+0x2d9/0xbb0 fs/read_write.c:969
 #1: ffff88807f19e180 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
 #1: ffff88807f19e180 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: generic_file_write_iter+0x83/0x310 mm/filemap.c:4039
 #2: ffff88807f19df88 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_extend+0x21b/0x1b70 fs/hfsplus/extents.c:457

stack backtrace:
CPU: 1 PID: 6261 Comm: syz-executor170 Not tainted 6.8.0-syzkaller-05562-g61387b8dcf1d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 hfsplus_block_allocate+0x9e/0x8c0 fs/hfsplus/bitmap.c:35
 hfsplus_file_extend+0xade/0x1b70 fs/hfsplus/extents.c:468
 hfsplus_get_block+0x406/0x14f0 fs/hfsplus/extents.c:245
 __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2105
 __block_write_begin fs/buffer.c:2154 [inline]
 block_write_begin+0x9b/0x1e0 fs/buffer.c:2213
 cont_write_begin+0x645/0x890 fs/buffer.c:2567
 hfsplus_write_begin+0x8a/0xd0 fs/hfsplus/inode.c:47
 cont_expand_zero fs/buffer.c:2494 [inline]
 cont_write_begin+0x319/0x890 fs/buffer.c:2557
 hfsplus_write_begin+0x8a/0xd0 fs/hfsplus/inode.c:47
 generic_perform_write+0x322/0x640 mm/filemap.c:3921
 generic_file_write_iter+0xaf/0x310 mm/filemap.c:4042
 do_iter_readv_writev+0x5a4/0x800
 vfs_writev+0x395/0xbb0 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2+0x1ca/0x2d0 fs/read_write.c:1122
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fe7ed3c9299
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd9249b938 EFLAGS: 00000216 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fe7ed3c9299
RDX: 0000000000000001 RSI: 00000000200001c0 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000007fff R11: 0000000000000216 R12: 00007ffd9249b978
R13: 0000000000000473 R14: 00007ffd9249b9b0 R15: 431bde82d7b634db
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

