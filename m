Return-Path: <linux-fsdevel+bounces-8349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F968332BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 05:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45FDB1C217FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 04:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806DD137D;
	Sat, 20 Jan 2024 04:24:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF710FD
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jan 2024 04:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705724662; cv=none; b=Yk5JI9BAVDkidH809V/GDqaHd9o6Hq3HG9Lpvpx/aqFThCEj4Bam8KXxN81e1nYWkjz3TSRfPNDM/1BOR+h+Lz8quJN2dEJaLmp1LcdlJ6jHSVp3ZU/at/QmIwHBUUQHXeQ/HClykKJYzMSHd/BGYZhxy1/yrqXDwPfrLIlVhpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705724662; c=relaxed/simple;
	bh=KdyN9wEWdT0bQTjHqeYxfblMAfg3m/V16MYmKva9iCI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e4Q7uxJ0OWYVqCWvOIHdFprWs3BClmW+NXLaY4m1QUBb/O6I5GN7/6E0nFvVC7LlVoGDJ+zyYUA+WLGqWQyX6HsFjsJ5fMXHLszT0D/qSeVsxnFQVAQ0rgxr+mICmGBAUnz6CyL5k2uwwdoY7wXcmwhFlElf8+dTzFlxq5B7hNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-361a9198bffso6769825ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 20:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705724660; x=1706329460;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clA28dxhqBjfZna6TkPAQv2vWQ3aUV+gbVR8Z7FbiRo=;
        b=g+is0zYpvBq26guBcTDsG3Iyh7vF154jDualgcqot4IozUWTggiewKtdE7a5DcPiJ1
         yQMGi3TSyrZPxhyRq9Xsleq7kDKQqwtl8gVesBkt7HyBrhqDGuTUc1W4Z100qiBDxPQK
         c1A9d50sA3eE5b/2Pw9CMCHfVd0v36GGGYNmiFJEtzeN39dETzzwTUSC/M/akkDPQguc
         cKo/Wk7djB31mgRmsU3pk7Ibx2A6CdOcTksxYJ4LOIxesPs6Hy58DSm3L4BTGHS06kWc
         xvMrbW+v7nWKJMpJAWNZUWFVj5djN2UEtSsYiANhKUE+8hptMh0yvrpqCFmnm6OAgn1X
         g4Tg==
X-Gm-Message-State: AOJu0Yzbh+PNSoZ1epre/vCxpW2xro3hCDs3MKECjFk9spbTh0FTkQuF
	HCxQIOWO5fCr+hpcG3pKnCheHJVDcRslHQkodljyLXZiZqvCmA3QiXTPohkDDAk+qZYKDLJAzKE
	VP/W8j2SCjCQmCueVuhEYtnPrRrzKYKrG1hNoYP+9hpZk5C7A0WXpnaY=
X-Google-Smtp-Source: AGHT+IGBEm8SQEDghPOdC2w1LCYS7zrzicYx5qZ8AiUofe/QtWz/m8IfDs5/F2tooUKovge+FQPY0cDVrOSS7/yV1pY20vQl/gLv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1488:b0:360:290:902d with SMTP id
 n8-20020a056e02148800b003600290902dmr122450ilk.3.1705724659857; Fri, 19 Jan
 2024 20:24:19 -0800 (PST)
Date: Fri, 19 Jan 2024 20:24:19 -0800
In-Reply-To: <000000000000d7b6f405ee97d4a1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f83e0060f58f8fb@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfsplus_block_free
From: syzbot <syzbot+8fae81a1f77bf28ef3b5@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, fmdefrancesco@gmail.com, ira.weiny@intel.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9d1694dc91ce Merge tag 'for-6.8/block-2024-01-18' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ac11abe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5142c864fad2684b
dashboard link: https://syzkaller.appspot.com/bug?extid=8fae81a1f77bf28ef3b5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1519994fe80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138ba46fe80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4c0e4097a70a/disk-9d1694dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9b551b9fa3e4/vmlinux-9d1694dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6ecfef59fe31/bzImage-9d1694dc.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/2f9f30811e75/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/e5b402bef2f2/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8fae81a1f77bf28ef3b5@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.7.0-syzkaller-12377-g9d1694dc91ce #0 Not tainted
------------------------------------------------------
syz-executor275/5161 is trying to acquire lock:
ffff888029d7a8f8 (&sbi->alloc_mutex){+.+.}-{3:3}, at: hfsplus_block_free+0xbb/0x4d0 fs/hfsplus/bitmap.c:182

but task is already holding lock:
ffff888079ada988 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_truncate+0x2da/0xb40 fs/hfsplus/extents.c:576

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}:
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:752
       hfsplus_get_block+0x383/0x14e0 fs/hfsplus/extents.c:260
       block_read_full_folio+0x422/0xe10 fs/buffer.c:2382
       filemap_read_folio+0x19c/0x780 mm/filemap.c:2324
       do_read_cache_folio+0x134/0x810 mm/filemap.c:3701
       do_read_cache_page+0x30/0x200 mm/filemap.c:3767
       read_mapping_page include/linux/pagemap.h:888 [inline]
       hfsplus_block_allocate+0xee/0x8b0 fs/hfsplus/bitmap.c:37
       hfsplus_file_extend+0xade/0x1b70 fs/hfsplus/extents.c:468
       hfsplus_get_block+0x406/0x14e0 fs/hfsplus/extents.c:245
       __block_write_begin_int+0x50b/0x1a70 fs/buffer.c:2103
       __block_write_begin fs/buffer.c:2152 [inline]
       block_write_begin+0x9b/0x1e0 fs/buffer.c:2211
       cont_write_begin+0x643/0x880 fs/buffer.c:2565
       hfsplus_write_begin+0x8a/0xd0 fs/hfsplus/inode.c:47
       page_symlink+0x2c5/0x4e0 fs/namei.c:5228
       hfsplus_symlink+0xca/0x260 fs/hfsplus/dir.c:449
       vfs_symlink+0x12f/0x2a0 fs/namei.c:4480
       do_symlinkat+0x222/0x3a0 fs/namei.c:4506
       __do_sys_symlink fs/namei.c:4527 [inline]
       __se_sys_symlink fs/namei.c:4525 [inline]
       __x64_sys_symlink+0x7e/0x90 fs/namei.c:4525
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #0 (&sbi->alloc_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x1909/0x5ab0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:752
       hfsplus_block_free+0xbb/0x4d0 fs/hfsplus/bitmap.c:182
       hfsplus_free_extents+0x17a/0xae0 fs/hfsplus/extents.c:363
       hfsplus_file_truncate+0x7d0/0xb40 fs/hfsplus/extents.c:591
       hfsplus_delete_inode+0x174/0x220
       hfsplus_unlink+0x512/0x790 fs/hfsplus/dir.c:405
       hfsplus_rename+0xc8/0x1c0 fs/hfsplus/dir.c:547
       vfs_rename+0xbd3/0xef0 fs/namei.c:4879
       do_renameat2+0xd94/0x13f0 fs/namei.c:5036
       __do_sys_renameat2 fs/namei.c:5070 [inline]
       __se_sys_renameat2 fs/namei.c:5067 [inline]
       __x64_sys_renameat2+0xd2/0xe0 fs/namei.c:5067
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&HFSPLUS_I(inode)->extents_lock);
                               lock(&sbi->alloc_mutex);
                               lock(&HFSPLUS_I(inode)->extents_lock);
  lock(&sbi->alloc_mutex);

 *** DEADLOCK ***

6 locks held by syz-executor275/5161:
 #0: ffff888029204420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff888079ad9740 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:837 [inline]
 #1: ffff888079ad9740 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: lock_rename fs/namei.c:3065 [inline]
 #1: ffff888079ad9740 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: do_renameat2+0x62c/0x13f0 fs/namei.c:4971
 #2: ffff888079ada4c0 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
 #2: ffff888079ada4c0 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: lock_two_nondirectories+0xe1/0x170 fs/inode.c:1109
 #3: ffff888079adab80 (&sb->s_type->i_mutex_key#14/4){+.+.}-{3:3}, at: vfs_rename+0x69e/0xef0 fs/namei.c:4850
 #4: ffff888029d7a998 (&sbi->vh_mutex){+.+.}-{3:3}, at: hfsplus_unlink+0x161/0x790 fs/hfsplus/dir.c:370
 #5: ffff888079ada988 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_truncate+0x2da/0xb40 fs/hfsplus/extents.c:576

stack backtrace:
CPU: 1 PID: 5161 Comm: syz-executor275 Not tainted 6.7.0-syzkaller-12377-g9d1694dc91ce #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x366/0x490 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x1909/0x5ab0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:752
 hfsplus_block_free+0xbb/0x4d0 fs/hfsplus/bitmap.c:182
 hfsplus_free_extents+0x17a/0xae0 fs/hfsplus/extents.c:363
 hfsplus_file_truncate+0x7d0/0xb40 fs/hfsplus/extents.c:591
 hfsplus_delete_inode+0x174/0x220
 hfsplus_unlink+0x512/0x790 fs/hfsplus/dir.c:405
 hfsplus_rename+0xc8/0x1c0 fs/hfsplus/dir.c:547
 vfs_rename+0xbd3/0xef0 fs/namei.c:4879
 do_renameat2+0xd94/0x13f0 fs/namei.c:5036
 __do_sys_renameat2 fs/namei.c:5070 [inline]
 __se_sys_renameat2 fs/namei.c:5067 [inline]
 __x64_sys_renameat2+0xd2/0xe0 fs/namei.c:5067
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f6db63c6e89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6db6383218 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 00007f6db644f6c8 RCX: 00007f6db63c6e89
RDX: 0000000000000004 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 00007f6db644f6c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000180 R11: 0000000000000246 R12: 00007f6db641c168
R13: 0032656c69662f2e R14: 0073756c70736668 R15: 0031656c69662f2e
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

