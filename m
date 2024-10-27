Return-Path: <linux-fsdevel+bounces-33024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01CA9B1F0E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 16:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1E1281971
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 15:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3287E16FF45;
	Sun, 27 Oct 2024 15:16:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550934685
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Oct 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730042186; cv=none; b=cBzULO5wvey4PdrcXv6Rytc/DF6R/8BEsldQD6GEzgT95OSUrU57bMS8cFwFb+jHyz1Rvi+wgv0x9eHef7j660l5+RffgpWWopDmO1mDHRFo95dgQnx9rNp6qiqwc+wrowXscWrr+iBOjz74evbkQSllHxwzAJktl14WcgbWstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730042186; c=relaxed/simple;
	bh=1w+QdgW5+tnfcuyMFbfAqAPAABD99uPzumBc4ERDQMg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=stoG2SOYdfuUlM47CtL/Msl9spEkfy8aCmVsfzK3VOD+YUP1KJABAdtIYOF7P+ee8MS8T+YvgiWkshtkEVLqKfDIrvo/1TVe+sd0+F2qwu2L9Ykepa4andq9pkHI/uFrm7SyqaHkOOH9uNm0eBln2jMwXUZ0cJPFXsKLvk9/O2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c27c72d5so31829235ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Oct 2024 08:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730042183; x=1730646983;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WO6SL1+kOtOxyackvVQQXhFuorAZrAhP8R59IgGYG6Q=;
        b=pz1wCoeRDRjDJeNwRhjahkK/5FJapNrbTloHV4XsrTjzsC6PAt7be/Pz1e67UWWlNg
         lPPlMYOjSOfoU4uINXWlGYak8cxBnrzmzwyRibOF9tMoJDa1/9MimE43JDt3eDMD3pwD
         iWThDdlCZ3Y6UHWArSQx4x1qMOkZxvl2u7rC0hcxpxXjlCa+xkqturcLXHlABV1Ks1/w
         y/cOiWQGG75cfF2cCqwJqZjWi9W1JEpasTy6C7qDJ70vwvonOimHCSoQgLPPZDP7OWVk
         9q5A3xAf+TZGEBYibQPfrGdrg57m7mashUxocxgjWtDRUo9+BgDkb08UDJ/JsJajmb6e
         fTEg==
X-Forwarded-Encrypted: i=1; AJvYcCXrjbHJ7pE0XTCRLCgT/UDdHxY9M71tC2n1hZesI8icRNm97iCRryNO2eOZBLzxuqFKNRZPLnNL6CA7FsRt@vger.kernel.org
X-Gm-Message-State: AOJu0YwxMKogYzlA+jMuZ8IlfJgV6r2+Nw0IfFs2iva6RcMI4317MpT3
	dsQX6ijlJkGb52tHLEftBKTcZzY8YS6KUxD+9ODO4tpIXZha8TTBgYAqnn7wrFnrFPbOF1bunk9
	QGs4COAcl2YFBOsQGYfi8LbLFkjpcSbQ13fZtT3soEJx0khArcXirvpk=
X-Google-Smtp-Source: AGHT+IFZT9/k0VqRz4QULsr9e6pAQYJWS/X4UI8/ybpOyq5OfKXQMwRQeqqrSakc0yqLAmdWjlRue9hebWcclR0ZS3ehL2nEDusF
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa2:b0:3a0:a71b:75e5 with SMTP id
 e9e14a558f8ab-3a4ed295f6fmr44602575ab.7.1730042183459; Sun, 27 Oct 2024
 08:16:23 -0700 (PDT)
Date: Sun, 27 Oct 2024 08:16:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671e5947.050a0220.2b8c0f.01dd.GAE@google.com>
Subject: [syzbot] [netfs?] possible deadlock in netfs_start_io_direct
From: syzbot <syzbot+d0dec022ac98c352d543@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1739c287980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1673a5aaa7e19b23
dashboard link: https://syzkaller.appspot.com/bug?extid=d0dec022ac98c352d543
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e981ceb16ec2/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/777a1688b884/bzImage-c2ee9f59.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d0dec022ac98c352d543@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0 Not tainted
------------------------------------------------------
syz.0.1732/11608 is trying to acquire lock:
ffff8880650834c8 (&sb->s_type->i_mutex_key#23){++++}-{3:3}, at: netfs_start_io_direct+0x25/0x260 fs/netfs/locking.c:174

but task is already holding lock:
ffff888049aeec18 (&ima_iint_mutex_key[depth]#3){+.+.}-{3:3}, at: process_measurement+0x885/0x2370 security/integrity/ima/ima_main.c:269

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ima_iint_mutex_key[depth]#3){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       process_measurement+0x885/0x2370 security/integrity/ima/ima_main.c:269
       ima_file_mmap+0x1b1/0x1d0 security/integrity/ima/ima_main.c:462
       security_mmap_file+0x8bd/0x990 security/security.c:2979
       __do_sys_remap_file_pages+0x526/0x900 mm/mmap.c:1702
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       gup_fast_fallback+0x1201/0x2690 mm/gup.c:3364
       pin_user_pages_fast+0xa8/0x100 mm/gup.c:3488
       iov_iter_extract_user_pages lib/iov_iter.c:1815 [inline]
       iov_iter_extract_pages+0x397/0x1f30 lib/iov_iter.c:1878
       netfs_extract_user_iter+0x21a/0x620 fs/netfs/iterator.c:67
       netfs_unbuffered_read_iter_locked+0xcef/0x19b0 fs/netfs/direct_read.c:202
       netfs_unbuffered_read_iter+0xc5/0x100 fs/netfs/direct_read.c:256
       v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
       new_sync_read fs/read_write.c:488 [inline]
       vfs_read+0x86e/0xbd0 fs/read_write.c:569
       ksys_read+0x12f/0x260 fs/read_write.c:712
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (&sb->s_type->i_mutex_key#23){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x250b/0x3ce0 kernel/locking/lockdep.c:5202
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
       down_read_interruptible+0x9d/0x380 kernel/locking/rwsem.c:1533
       netfs_start_io_direct+0x25/0x260 fs/netfs/locking.c:174
       netfs_unbuffered_read_iter+0xa3/0x100 fs/netfs/direct_read.c:254
       v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
       do_iter_readv_writev+0x614/0x7f0 fs/read_write.c:832
       vfs_iter_read+0x321/0x480 fs/read_write.c:923
       backing_file_read_iter+0x564/0x750 fs/backing-file.c:183
       ovl_read_iter+0x26c/0x300 fs/overlayfs/file.c:280
       do_iter_readv_writev+0x614/0x7f0 fs/read_write.c:832
       vfs_iter_read+0x321/0x480 fs/read_write.c:923
       backing_file_read_iter+0x564/0x750 fs/backing-file.c:183
       ovl_read_iter+0x26c/0x300 fs/overlayfs/file.c:280
       __kernel_read+0x3f1/0xb50 fs/read_write.c:527
       integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm+0x2c9/0x3e0 security/integrity/ima/ima_crypto.c:480
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
       ima_calc_file_hash+0x1ba/0x490 security/integrity/ima/ima_crypto.c:568
       ima_collect_measurement+0x8a7/0xa10 security/integrity/ima/ima_api.c:293
       process_measurement+0x1271/0x2370 security/integrity/ima/ima_main.c:372
       ima_file_check+0xc1/0x110 security/integrity/ima/ima_main.c:572
       security_file_post_open+0x8e/0x210 security/security.c:3129
       do_open fs/namei.c:3776 [inline]
       path_openat+0x1419/0x2d60 fs/namei.c:3933
       do_filp_open+0x1dc/0x430 fs/namei.c:3960
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
       do_sys_open fs/open.c:1430 [inline]
       __do_compat_sys_open fs/open.c:1483 [inline]
       __se_compat_sys_open fs/open.c:1481 [inline]
       __ia32_compat_sys_open+0x147/0x1e0 fs/open.c:1481
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

Chain exists of:
  &sb->s_type->i_mutex_key#23 --> &mm->mmap_lock --> &ima_iint_mutex_key[depth]#3

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ima_iint_mutex_key[depth]#3);
                               lock(&mm->mmap_lock);
                               lock(&ima_iint_mutex_key[depth]#3);
  rlock(&sb->s_type->i_mutex_key#23);

 *** DEADLOCK ***

1 lock held by syz.0.1732/11608:
 #0: ffff888049aeec18 (&ima_iint_mutex_key[depth]#3){+.+.}-{3:3}, at: process_measurement+0x885/0x2370 security/integrity/ima/ima_main.c:269

stack backtrace:
CPU: 3 UID: 0 PID: 11608 Comm: syz.0.1732 Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
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
 down_read_interruptible+0x9d/0x380 kernel/locking/rwsem.c:1533
 netfs_start_io_direct+0x25/0x260 fs/netfs/locking.c:174
 netfs_unbuffered_read_iter+0xa3/0x100 fs/netfs/direct_read.c:254
 v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
 do_iter_readv_writev+0x614/0x7f0 fs/read_write.c:832
 vfs_iter_read+0x321/0x480 fs/read_write.c:923
 backing_file_read_iter+0x564/0x750 fs/backing-file.c:183
 ovl_read_iter+0x26c/0x300 fs/overlayfs/file.c:280
 do_iter_readv_writev+0x614/0x7f0 fs/read_write.c:832
 vfs_iter_read+0x321/0x480 fs/read_write.c:923
 backing_file_read_iter+0x564/0x750 fs/backing-file.c:183
 ovl_read_iter+0x26c/0x300 fs/overlayfs/file.c:280
 __kernel_read+0x3f1/0xb50 fs/read_write.c:527
 integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm+0x2c9/0x3e0 security/integrity/ima/ima_crypto.c:480
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1ba/0x490 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x8a7/0xa10 security/integrity/ima/ima_api.c:293
 process_measurement+0x1271/0x2370 security/integrity/ima/ima_main.c:372
 ima_file_check+0xc1/0x110 security/integrity/ima/ima_main.c:572
 security_file_post_open+0x8e/0x210 security/security.c:3129
 do_open fs/namei.c:3776 [inline]
 path_openat+0x1419/0x2d60 fs/namei.c:3933
 do_filp_open+0x1dc/0x430 fs/namei.c:3960
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_compat_sys_open fs/open.c:1483 [inline]
 __se_compat_sys_open fs/open.c:1481 [inline]
 __ia32_compat_sys_open+0x147/0x1e0 fs/open.c:1481
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7ff3579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f575556c EFLAGS: 00000296 ORIG_RAX: 0000000000000005
RAX: ffffffffffffffda RBX: 0000000020000500 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

