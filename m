Return-Path: <linux-fsdevel+bounces-30922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F3498FB35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 01:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902B41F23197
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 23:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FD41CF5C2;
	Thu,  3 Oct 2024 23:54:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15312C473
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 23:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999663; cv=none; b=UzHmgTEvhcIAt+p1nwaKGzpzKIjRNrw/54A0zCea/DJzdZBZOH1evhfYHPoZL5kY3lnlep9qTKCl6zh46lWdWiHTcK6XtRkFKzydQPNHBScvQCtpYIkWq3HIX3EyNcsJZ8t+Jjl9YnypzIqIgEq4eYYPDN5xFc8uDOY8Meaf0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999663; c=relaxed/simple;
	bh=EBTlgwVBBS6NriTPzMmi40EY7nevtFqcaA+6abU1H3s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m4NKup83NdN4zxOIuQz/ykgR0P/Bt7lArcT6gSLpVFMAOBUh4uEpwDFjCgvNWBo4dRTIuakok8a/B2JbSXtdkNCuF7ihX7aBESpxs5AJEHPlGXWxC4WVWik/08D35Cey/sp1SY1wBmrOeh1PEeBm5IarKmSUsvNX8NWIN4rvETA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82d094a0010so157781439f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 16:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727999661; x=1728604461;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPzAya3GocO7JfeJnQAXfrQh4gmUQeWyOwRvOq/1IL0=;
        b=jYh+KuHWoBNDQa2mOkSjPQUB2gHVRQeEOw2xmX5zHOBBkqQZWd6sqCFHd+UeHCzuxl
         RsI4ACcseIaKgZZG3DJ52NhjkjAUTwObNZjrI/IQzrOljdg8ufcGUFDtUB01exfbUYns
         t+PuHsE+PqQjQD42up5i8ARFQNbl1EKAzYVwDBXe0HrMCuqeazFAwHxnLCNw6rucnlIl
         dlQVTZgqOsPkkUsK1mRuifDTxOhKp/1bxAkLCgdxyBAOzwVVFWUmMxvNFqwWhD8XpyLd
         +xz+e9IxAe0HuBLEQKX2b6rtP9520nPUatQihjcoyR81xPm365NwdDf4uobnk+ZvsmyK
         o5gw==
X-Forwarded-Encrypted: i=1; AJvYcCXkvbiUpg+eIaNsJ0bUbHa244AJL+nXxwAU/dUgrg3J76DSHzWjEqp5HBbcA318HT1zLUDpQh67q9Y9ga5c@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfcc/RUr/wqS2yKETSJJtYpaOGAKw4U6O3VXqAqvl7pfRJzZM2
	RIYNz5hlraRVWlvOFNIp1pq+Tq8GsLIA2opJ4TVuQ59y9dDGAcFUfQccR3yOg8COIoLnMGpfS3w
	bI7oAZtZMpcWUcst7hThCXWt6duLIvxFjp/i++vMVEwkOT8MTHvghRi4=
X-Google-Smtp-Source: AGHT+IEVziOjkGoW6cXj7TOtBJAQqN+jVrWhHpqc9rTg6FcQHIC8ph8kXd7Hdo0JzRdItf2ghQeGX2x7CcxXB8JIuhUuzdzxU42r
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6e:b0:3a0:ab71:ed38 with SMTP id
 e9e14a558f8ab-3a375b9afb2mr9061515ab.14.1727999661446; Thu, 03 Oct 2024
 16:54:21 -0700 (PDT)
Date: Thu, 03 Oct 2024 16:54:21 -0700
In-Reply-To: <0000000000000a78120620f2fc2b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ff2ead.050a0220.49194.03ec.GAE@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in lock_mm_and_find_vma (2)
From: syzbot <syzbot+b02bbe0ff80a09a08c1b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dhowells@redhat.com, hughd@google.com, 
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7ec462100ef9 Merge tag 'pull-work.unaligned' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152ef580580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3e4d87a80ed4297
dashboard link: https://syzkaller.appspot.com/bug?extid=b02bbe0ff80a09a08c1b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1783d527980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e9d3d0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9c2b32151d7c/disk-7ec46210.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3c213e4aefaf/vmlinux-7ec46210.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dba87bc205ec/bzImage-7ec46210.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b02bbe0ff80a09a08c1b@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc1-syzkaller-00046-g7ec462100ef9 #0 Not tainted
------------------------------------------------------
syz-executor224/5511 is trying to acquire lock:
ffff88802fabba98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable include/linux/mmap_lock.h:153 [inline]
ffff88802fabba98 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:6108 [inline]
ffff88802fabba98 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x3a9/0x6a0 mm/memory.c:6159

but task is already holding lock:
ffff88802ff17858 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
ffff88802ff17858 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: shmem_file_write_iter+0x86/0x140 mm/shmem.c:3211

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}:
       down_write+0x93/0x200 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:815 [inline]
       process_measurement+0x39c/0x2370 security/integrity/ima/ima_main.c:250
       ima_file_mmap+0x146/0x1d0 security/integrity/ima/ima_main.c:455
       security_mmap_file+0x8bd/0x990 security/security.c:2977
       __do_sys_remap_file_pages+0x526/0x900 mm/mmap.c:1692
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x250b/0x3ce0 kernel/locking/lockdep.c:5202
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
       down_read_killable+0x9d/0x380 kernel/locking/rwsem.c:1547
       mmap_read_lock_killable include/linux/mmap_lock.h:153 [inline]
       get_mmap_lock_carefully mm/memory.c:6108 [inline]
       lock_mm_and_find_vma+0x3a9/0x6a0 mm/memory.c:6159
       do_user_addr_fault+0x2b5/0x13f0 arch/x86/mm/fault.c:1361
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       fault_in_readable+0x126/0x230 mm/gup.c:2235
       fault_in_iov_iter_readable+0x101/0x2c0 lib/iov_iter.c:94
       generic_perform_write+0x21b/0x920 mm/filemap.c:4044
       shmem_file_write_iter+0x10e/0x140 mm/shmem.c:3221
       new_sync_write fs/read_write.c:590 [inline]
       vfs_write+0x6b5/0x1140 fs/read_write.c:683
       ksys_write+0x12f/0x260 fs/read_write.c:736
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#12);
                               lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#12);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

3 locks held by syz-executor224/5511:
 #0: ffff888029a570b8 (&f->f_pos_lock){+.+.}-{3:3}, at: fdget_pos+0x24c/0x360 fs/file.c:1187
 #1: ffff8880126a6420 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #2: ffff88802ff17858 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #2: ffff88802ff17858 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: shmem_file_write_iter+0x86/0x140 mm/shmem.c:3211

stack backtrace:
CPU: 1 UID: 0 PID: 5511 Comm: syz-executor224 Not tainted 6.12.0-rc1-syzkaller-00046-g7ec462100ef9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x419/0x5d0 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x250b/0x3ce0 kernel/locking/lockdep.c:5202
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 down_read_killable+0x9d/0x380 kernel/locking/rwsem.c:1547
 mmap_read_lock_killable include/linux/mmap_lock.h:153 [inline]
 get_mmap_lock_carefully mm/memory.c:6108 [inline]
 lock_mm_and_find_vma+0x3a9/0x6a0 mm/memory.c:6159
 do_user_addr_fault+0x2b5/0x13f0 arch/x86/mm/fault.c:1361
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:fault_in_readable+0x126/0x230 mm/gup.c:2235
Code: 38 ba ff 48 39 dd 0f 84 f0 00 00 00 45 31 f6 eb 11 e8 1e 38 ba ff 48 81 c3 00 10 00 00 48 39 eb 74 1d e8 0d 38 ba ff 45 89 f7 <8a> 03 31 ff 44 89 fe 88 44 24 28 e8 3a 3a ba ff 45 85 ff 74 d2 e8
RSP: 0018:ffffc90003bb7b18 EFLAGS: 00050293
RAX: 0000000000000000 RBX: 0000000000004000 RCX: ffffffff81d27776
RDX: ffff888011ecda00 RSI: ffffffff81d27763 RDI: 0000000000000005
RBP: 0000000000101000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000100082
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 fault_in_iov_iter_readable+0x101/0x2c0 lib/iov_iter.c:94
 generic_perform_write+0x21b/0x920 mm/filemap.c:4044
 shmem_file_write_iter+0x10e/0x140 mm/shmem.c:3221
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0x6b5/0x1140 fs/read_write.c:683
 ksys_write+0x12f/0x260 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f04d812ac19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f04d80ba228 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f04d81b4198 RCX: 00007f04d812ac19
RDX: 0000000000100082 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f04d81b4190 R08: 00007f04d80ba6c0 R09: 00007f04d80ba6c0
R10: 00007f04d80ba6c0 R11: 0000000000000246 R12: 00007f04d81b419c
R13: 00007f04d817a4ac R14: 0030656c69662f2e R15: 00007ffe59ac37d8
 </TASK>
----------------
Code disassembly (best guess):
   0:	38 ba ff 48 39 dd    	cmp    %bh,-0x22c6b701(%rdx)
   6:	0f 84 f0 00 00 00    	je     0xfc
   c:	45 31 f6             	xor    %r14d,%r14d
   f:	eb 11                	jmp    0x22
  11:	e8 1e 38 ba ff       	call   0xffba3834
  16:	48 81 c3 00 10 00 00 	add    $0x1000,%rbx
  1d:	48 39 eb             	cmp    %rbp,%rbx
  20:	74 1d                	je     0x3f
  22:	e8 0d 38 ba ff       	call   0xffba3834
  27:	45 89 f7             	mov    %r14d,%r15d
* 2a:	8a 03                	mov    (%rbx),%al <-- trapping instruction
  2c:	31 ff                	xor    %edi,%edi
  2e:	44 89 fe             	mov    %r15d,%esi
  31:	88 44 24 28          	mov    %al,0x28(%rsp)
  35:	e8 3a 3a ba ff       	call   0xffba3a74
  3a:	45 85 ff             	test   %r15d,%r15d
  3d:	74 d2                	je     0x11
  3f:	e8                   	.byte 0xe8


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

