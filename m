Return-Path: <linux-fsdevel+bounces-19636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7DC8C8099
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 07:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C419A1C21082
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 05:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AFE1118A;
	Fri, 17 May 2024 05:28:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957CB10A09
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 05:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715923702; cv=none; b=VT5fsABJ6+UskViW1fazriDrE3icv4mHh6qtP5UgjzImUlF2FovDHkTD9l2pyY1k68GLdvZ24fKKjintdzAfETHCVYJ9hCVfhtHd61VNSN5t/nwng9bwVne9s8wHzFo1u4lfljK+VOUWFi4fsERWABqRlAZCiVzpPFi6rZ4KNYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715923702; c=relaxed/simple;
	bh=WdPDTrPOYwIReFs/yP1Dk1hqdo/yDLeNtQnXTHtn0H8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V7fhJNHCMGv/dvtOIPZ3TM4Ojv/RrwXWmB1O4h01a8gaxB6IJR7Twuzc7TeapzgTd67FzxGxo6Ypy2AagCEVgmrCfXYsc2trMOc8DuShocNsN8RF3LMBpxlPO2adgCCi8jFZX0YXQEioonw8ms6URV5UtqG8fNC3Z64Q6WEm0mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e1c22e7280so848995039f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2024 22:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715923700; x=1716528500;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzxdQzRd67YyX5sYt9wLAcGm6uG/rusPbHHDRJfvy/M=;
        b=dGDugGzJpqRrVujI/Wxitn/JpkVbWsnIT5Ib4ORblfT2gifOXWJwT4S14c8ac+8kBk
         8+8sQRhVLZvRgP2lRR2DSzMx9wL7HHJrsGUVdLj7J00zMuktExnM7ZM75m2J/fyzHIjZ
         /TyzrQTFaGpH2wgDpQc3Jcx6C9qKjl2ZS3PtxvkEM0yhAUcm2zcE3e/fD68dLQz99OEA
         wLPWUQwA7soMrQFa/eKPJ0i0IuSB+Hj7l5t2nrxdvZIxy2cFMMgpJQC4Z92GqcZ5fEXK
         laAwCmmSeYqVY/HSD7oEKhmGp5YKHJMFEp9CtvBQpzsJpp2RDyI/RH9VIIvc57K+Rn+w
         eW6w==
X-Forwarded-Encrypted: i=1; AJvYcCXt0lbjWHbq0KahNmd5TNMTNIA4btfPmCuy1inDYauRfhKIBMrEoRuGvs/hLwNLHA4XbUWXfBC3kGpfo5PJL2qvzesJVZhcq5L5gf5lvA==
X-Gm-Message-State: AOJu0YzLeLdq5MG4XibNKvP2MJXCFEHkPFQT9C9iZv4Wu36ab1z8Jcgg
	9Y6fdki0NyUqqYBZRhxJh7tbK68MLrWCkyrChykPWu8UdJhzFlOIMdyEIFNV8yRHY32BOjU/Dpb
	q5J5N5csYKknK+mb/ROFBdaqDBXmpF6k9RGH2jH2JOFpSuyHFaefQmHs=
X-Google-Smtp-Source: AGHT+IGpaoA6Mn6vDc6NmzFiL4Q+Ag/NP0AVv0TDpxzoBeiUh5/XMofiTpJQ/iSbpQeTNeVYk8PQ4ty1tmWs4K5FKrg1bNtMmM//
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c0f:b0:7de:a1dc:bf36 with SMTP id
 ca18e2360f4ac-7e1b521c4dcmr97738939f.4.1715923699834; Thu, 16 May 2024
 22:28:19 -0700 (PDT)
Date: Thu, 16 May 2024 22:28:19 -0700
In-Reply-To: <0000000000001a94c3061747fabd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009731e206189f9e5b@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_mark_rec_free (2)
From: syzbot <syzbot+016b09736213e65d106e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fda5695d692c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15248fb8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95dc1de8407c7270
dashboard link: https://syzkaller.appspot.com/bug?extid=016b09736213e65d106e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13787684980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a93c92980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/07f3214ff0d9/disk-fda5695d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70e2e2c864e8/vmlinux-fda5695d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b259942a16dc/Image-fda5695d.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0c9ec56039c3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+016b09736213e65d106e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc7-syzkaller-gfda5695d692c #0 Not tainted
------------------------------------------------------
kworker/u8:7/652 is trying to acquire lock:
ffff0000d80fa128 (&wnd->rw_lock/1){+.+.}-{3:3}, at: ntfs_mark_rec_free+0x48/0x270 fs/ntfs3/fsntfs.c:742

but task is already holding lock:
ffff0000decb6fa0 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1143 [inline]
ffff0000decb6fa0 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_write_inode+0x168/0xda4 fs/ntfs3/frecord.c:3265

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ni->ni_lock#3){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
       __mutex_lock kernel/locking/mutex.c:752 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
       ntfs_set_state+0x1a4/0x5c0 fs/ntfs3/fsntfs.c:947
       mi_read+0x3e0/0x4d8 fs/ntfs3/record.c:185
       mi_format_new+0x174/0x514 fs/ntfs3/record.c:420
       ni_add_subrecord+0xd0/0x3c4 fs/ntfs3/frecord.c:372
       ntfs_look_free_mft+0x4c8/0xd1c fs/ntfs3/fsntfs.c:715
       ni_create_attr_list+0x764/0xf54 fs/ntfs3/frecord.c:876
       ni_ins_attr_ext+0x300/0xa0c fs/ntfs3/frecord.c:974
       ni_insert_attr fs/ntfs3/frecord.c:1141 [inline]
       ni_insert_resident fs/ntfs3/frecord.c:1525 [inline]
       ni_add_name+0x658/0xc14 fs/ntfs3/frecord.c:3047
       ni_rename+0xc8/0x1d8 fs/ntfs3/frecord.c:3087
       ntfs_rename+0x610/0xae0 fs/ntfs3/namei.c:334
       vfs_rename+0x9bc/0xc84 fs/namei.c:4880
       do_renameat2+0x9c8/0xe40 fs/namei.c:5037
       __do_sys_renameat2 fs/namei.c:5071 [inline]
       __se_sys_renameat2 fs/namei.c:5068 [inline]
       __arm64_sys_renameat2+0xe0/0xfc fs/namei.c:5068
       __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

-> #0 (&wnd->rw_lock/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
       lock_acquire+0x248/0x73c kernel/locking/lockdep.c:5754
       down_write_nested+0x58/0xcc kernel/locking/rwsem.c:1695
       ntfs_mark_rec_free+0x48/0x270 fs/ntfs3/fsntfs.c:742
       ni_write_inode+0xa28/0xda4 fs/ntfs3/frecord.c:3365
       ntfs3_write_inode+0x70/0x98 fs/ntfs3/inode.c:1046
       write_inode fs/fs-writeback.c:1498 [inline]
       __writeback_single_inode+0x5f0/0x1548 fs/fs-writeback.c:1715
       writeback_sb_inodes+0x700/0x101c fs/fs-writeback.c:1941
       wb_writeback+0x404/0x1048 fs/fs-writeback.c:2117
       wb_do_writeback fs/fs-writeback.c:2264 [inline]
       wb_workfn+0x394/0x104c fs/fs-writeback.c:2304
       process_one_work+0x7b8/0x15d4 kernel/workqueue.c:3267
       process_scheduled_works kernel/workqueue.c:3348 [inline]
       worker_thread+0x938/0xef4 kernel/workqueue.c:3429
       kthread+0x288/0x310 kernel/kthread.c:388
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->ni_lock#3);
                               lock(&wnd->rw_lock/1);
                               lock(&ni->ni_lock#3);
  lock(&wnd->rw_lock/1);

 *** DEADLOCK ***

3 locks held by kworker/u8:7/652:
 #0: ffff0000c20c6948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x668/0x15d4 kernel/workqueue.c:3241
 #1: ffff800098d87c20 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x6b4/0x15d4 kernel/workqueue.c:3241
 #2: ffff0000decb6fa0 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1143 [inline]
 #2: ffff0000decb6fa0 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_write_inode+0x168/0xda4 fs/ntfs3/frecord.c:3265

stack backtrace:
CPU: 1 PID: 652 Comm: kworker/u8:7 Not tainted 6.9.0-rc7-syzkaller-gfda5695d692c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: writeback wb_workfn (flush-7:0)
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 dump_stack+0x1c/0x28 lib/dump_stack.c:123
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2060
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
 lock_acquire+0x248/0x73c kernel/locking/lockdep.c:5754
 down_write_nested+0x58/0xcc kernel/locking/rwsem.c:1695
 ntfs_mark_rec_free+0x48/0x270 fs/ntfs3/fsntfs.c:742
 ni_write_inode+0xa28/0xda4 fs/ntfs3/frecord.c:3365
 ntfs3_write_inode+0x70/0x98 fs/ntfs3/inode.c:1046
 write_inode fs/fs-writeback.c:1498 [inline]
 __writeback_single_inode+0x5f0/0x1548 fs/fs-writeback.c:1715
 writeback_sb_inodes+0x700/0x101c fs/fs-writeback.c:1941
 wb_writeback+0x404/0x1048 fs/fs-writeback.c:2117
 wb_do_writeback fs/fs-writeback.c:2264 [inline]
 wb_workfn+0x394/0x104c fs/fs-writeback.c:2304
 process_one_work+0x7b8/0x15d4 kernel/workqueue.c:3267
 process_scheduled_works kernel/workqueue.c:3348 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:3429
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

