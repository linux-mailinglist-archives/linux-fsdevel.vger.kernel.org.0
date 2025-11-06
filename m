Return-Path: <linux-fsdevel+bounces-67266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D969DC39B94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 10:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B54A34F9898
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7443830AAC7;
	Thu,  6 Nov 2025 09:02:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB9A309EFE
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419771; cv=none; b=EmkIUx6zilL/OlOmmiREb2FjDVzRVVQrNPuxG/IWn1k69LOUh0mVYgNQTH18LAbxuLSSv96rkRBNZcMdzC+F5i0tl0VNJMOn0gcaIt0nn2oYNn431/iwKUaGemA8WiwLJjOcVgto2sHSJMrAiK1hIHDlE0cDR0Q1i6T7QVwN+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419771; c=relaxed/simple;
	bh=Rr7rNnPEzbOTdtYIuAcXQ36F1YEIBKRcDnXlgES33XM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=PtYn9NWP/bWl8kCAGKmZwDE6D7GUHIgxt6Tzai9CgTLI/Yd3nZENGB+eZZ8DMZcjse7sG04XTmNgt6zbWf/sDnUykOqGgmj9fZgg0lqXxtt02sxmLkA8UIqks9t6vgXFIiJ5ZOobh5ftslVrb5WpAAhnXT/ARUh5doTNwZVlpLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93bc56ebb0aso37466339f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 01:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419767; x=1763024567;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8E0+ouzlVdoTElswHiPK8yFC6riJLd5SyKVj4+Fe4w=;
        b=n+8SLmwk9YB6KpvTc3cA70Q9SgB9PStfFtyRX3P/KKcaDC65pGXmJ3B5k2JbDWQ+Tq
         ymsUUk6pC049ZibAfEtjo2Mp6rLghLPIlvWBf/gELMDBq0jedlBtSjIuvy8bkTecr/WU
         ydKH8mgqkY2/b2+MPRCTOq7KED8BAwjOoct+bEqKWQ9K0Pa2KSiHCj4PcGAq/Sidex4R
         G7BPJcq/5CoOi9reOvOxI4yqsCHr7TO4UC00ayH+0cQ7I2Tz7vUvP9N3dKJulnTpis6Q
         0XRoVcGrezKjOAgVf9X6A2WyEHqD1UI2jZYF63jLA9DzgfK5YTw01SJs4pyMQWbZTHSl
         BG6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWC2WALoq1OW26rqTRCllPtNNArxpT584Ewc2ubn7rG7tHjik4nvlDT4h0e7ONYkyNcHns7egP2r6k8KIzt@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi0K50KPPRhFmIVCAa3ErbQ6wsGg4Q78oKU1Ksg5qX2TVbIb4W
	YiUrKjqqop8h62UaecJMLEdRRGUDCigNxPyY3WzIaFAWaWD0m3pl01hdhn2gcbZB1tbTNfFwMwy
	8y4B1bo4C66169ZVTYgRsp4CItIV2n58tM/6feukm8kCMqeT6Inqkzw0YJDQ=
X-Google-Smtp-Source: AGHT+IG2+XO9mtVu991pXvlz+VZb8KzNDnm0wvskVW9qOHFFxk5SFup8IMdJP1K43vqqIYpPzRVA5JUpKoQ5O6f2XWPv7TKHUvKc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:330e:b0:430:c90d:10ae with SMTP id
 e9e14a558f8ab-433407dfcc7mr95789415ab.32.1762419767538; Thu, 06 Nov 2025
 01:02:47 -0800 (PST)
Date: Thu, 06 Nov 2025 01:02:47 -0800
In-Reply-To: <20251106005333.956321-1-neilb@ownmail.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690c6437.050a0220.baf87.0083.GAE@google.com>
Subject: [syzbot ci] Re: Create and use APIs to centralise locking for
 directory ops.
From: syzbot ci <syzbot+ci853f3070c3383748@syzkaller.appspotmail.com>
To: amir73il@gmail.com, brauner@kernel.org, cem@kernel.org, 
	chuck.lever@oracle.com, clm@fb.com, code@tyhicks.com, dai.ngo@oracle.com, 
	dakr@kernel.org, dhowells@redhat.com, djwong@kernel.org, dsterba@suse.com, 
	ecryptfs@vger.kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	jlayton@kernel.org, jmorris@namei.org, john.johansen@canonical.com, 
	linkinjeon@kernel.org, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, miklos@szeredi.hu, mjguzik@gmail.com, 
	neilb@ownmail.net, netfs@lists.linux.dev, okorniev@redhat.com, 
	omosnace@redhat.com, paul@paul-moore.com, rafael@kernel.org, 
	selinux@vger.kernel.org, senozhatsky@chromium.org, serge@hallyn.com, 
	smfrench@gmail.com, stefanb@linux.ibm.com, stephen.smalley.work@gmail.com, 
	viro@zeniv.linux.org.uk
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v5] Create and use APIs to centralise locking for directory ops.
https://lore.kernel.org/all/20251106005333.956321-1-neilb@ownmail.net
* [PATCH v5 01/14] debugfs: rename end_creating() to debugfs_end_creating()
* [PATCH v5 02/14] VFS: introduce start_dirop() and end_dirop()
* [PATCH v5 03/14] VFS: tidy up do_unlinkat()
* [PATCH v5 04/14] VFS/nfsd/cachefiles/ovl: add start_creating() and end_creating()
* [PATCH v5 05/14] VFS/nfsd/cachefiles/ovl: introduce start_removing() and end_removing()
* [PATCH v5 06/14] VFS: introduce start_creating_noperm() and start_removing_noperm()
* [PATCH v5 07/14] VFS: introduce start_removing_dentry()
* [PATCH v5 08/14] VFS: add start_creating_killable() and start_removing_killable()
* [PATCH v5 09/14] VFS/nfsd/ovl: introduce start_renaming() and end_renaming()
* [PATCH v5 10/14] VFS/ovl/smb: introduce start_renaming_dentry()
* [PATCH v5 11/14] Add start_renaming_two_dentries()
* [PATCH v5 12/14] ecryptfs: use new start_creating/start_removing APIs
* [PATCH v5 13/14] VFS: change vfs_mkdir() to unlock on failure.
* [PATCH v5 14/14] VFS: introduce end_creating_keep()

and found the following issues:
* WARNING: lock held when returning to user space in start_creating
* possible deadlock in mnt_want_write

Full report is available here:
https://ci.syzbot.org/series/4f406e4d-6aba-457a-b9c1-21f4407176a0

***

WARNING: lock held when returning to user space in start_creating

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      6146a0f1dfae5d37442a9ddcba012add260bceb0
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/49013fb4-56ed-423c-8e15-252d65d5c1b4/config
C repro:   https://ci.syzbot.org/findings/403597e5-81d3-4a9e-8d43-cf15c00b3265/c_repro
syz repro: https://ci.syzbot.org/findings/403597e5-81d3-4a9e-8d43-cf15c00b3265/syz_repro

UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
overlayfs: upper fs needs to support d_type.
overlayfs: upper fs does not support tmpfile.
================================================
WARNING: lock held when returning to user space!
syzkaller #0 Not tainted
------------------------------------------------
syz.0.17/5964 is leaving the kernel with locks still held!
1 lock held by syz.0.17/5964:
 #0: ffff888119a282a0 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1025 [inline]
 #0: ffff888119a282a0 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2794 [inline]
 #0: ffff888119a282a0 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2805 [inline]
 #0: ffff888119a282a0 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: start_creating+0xbe/0x100 fs/namei.c:3261


***

possible deadlock in mnt_want_write

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      6146a0f1dfae5d37442a9ddcba012add260bceb0
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/49013fb4-56ed-423c-8e15-252d65d5c1b4/config
syz repro: https://ci.syzbot.org/findings/7d1f626d-9979-4c5b-b36b-5616a983b0ac/syz_repro

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/6011 is trying to acquire lock:
ffff88810943c420
 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:508

but task is already holding lock:
ffff888169f40940 (&type->i_mutex_dir_key#5/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1025 [inline]
ffff888169f40940 (&type->i_mutex_dir_key#5/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2794 [inline]
ffff888169f40940 (&type->i_mutex_dir_key#5/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2805 [inline]
ffff888169f40940 (&type->i_mutex_dir_key#5/1){+.+.}-{4:4}, at: start_creating+0xbe/0x100 fs/namei.c:3261

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&type->i_mutex_dir_key#5/1){+.+.}-{4:4}:
       reacquire_held_locks+0x127/0x1d0 kernel/locking/lockdep.c:5385
       __lock_release kernel/locking/lockdep.c:5574 [inline]
       lock_release+0x1b4/0x3e0 kernel/locking/lockdep.c:5889
       up_write+0x2d/0x420 kernel/locking/rwsem.c:1642
       inode_unlock include/linux/fs.h:990 [inline]
       end_dirop fs/namei.c:2818 [inline]
       end_creating include/linux/namei.h:125 [inline]
       vfs_mkdir+0x111/0x570 fs/namei.c:5037
       do_mkdirat+0x247/0x5e0 fs/namei.c:5058
       __do_sys_mkdir fs/namei.c:5080 [inline]
       __se_sys_mkdir fs/namei.c:5078 [inline]
       __x64_sys_mkdir+0x6c/0x80 fs/namei.c:5078
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_writers#12){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs.h:1916 [inline]
       sb_start_write+0x4d/0x1c0 include/linux/fs.h:2052
       mnt_want_write+0x41/0x90 fs/namespace.c:508
       filename_create+0x14f/0x360 fs/namei.c:4785
       do_mkdirat+0x32c/0x5e0 fs/namei.c:5050
       __do_sys_mkdir fs/namei.c:5080 [inline]
       __se_sys_mkdir fs/namei.c:5078 [inline]
       __x64_sys_mkdir+0x6c/0x80 fs/namei.c:5078
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&type->i_mutex_dir_key#5/1);
                               lock(sb_writers#12);
                               lock(&type->i_mutex_dir_key#5/1);
  rlock(sb_writers#12);

 *** DEADLOCK ***

1 lock held by syz.0.17/6011:
 #0: ffff888169f40940 (&type->i_mutex_dir_key#5/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1025 [inline]
 #0: ffff888169f40940 (&type->i_mutex_dir_key#5/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2794 [inline]
 #0: ffff888169f40940 (&type->i_mutex_dir_key#5/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2805 [inline]
 #0: ffff888169f40940 (&type->i_mutex_dir_key#5/1){+.+.}-{4:4}, at: start_creating+0xbe/0x100 fs/namei.c:3261

stack backtrace:
CPU: 1 UID: 0 PID: 6011 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
 percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 __sb_start_write include/linux/fs.h:1916 [inline]
 sb_start_write+0x4d/0x1c0 include/linux/fs.h:2052
 mnt_want_write+0x41/0x90 fs/namespace.c:508
 filename_create+0x14f/0x360 fs/namei.c:4785
 do_mkdirat+0x32c/0x5e0 fs/namei.c:5050
 __do_sys_mkdir fs/namei.c:5080 [inline]
 __se_sys_mkdir fs/namei.c:5078 [inline]
 __x64_sys_mkdir+0x6c/0x80 fs/namei.c:5078
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdc9a98efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdc9b79b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007fdc9abe5fa0 RCX: 00007fdc9a98efc9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000008c0
RBP: 00007fdc9aa11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdc9abe6038 R14: 00007fdc9abe5fa0 R15: 00007ffe4d481c38
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

