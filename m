Return-Path: <linux-fsdevel+bounces-36177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87399DEF2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 08:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1932818EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 07:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A256F148855;
	Sat, 30 Nov 2024 07:01:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9B49652
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732950064; cv=none; b=t8Mr3Ss6hFbjZ0ZGsszxABDsM/5vR9pUDz8amrWEBSkzQODfxWDJ1AE6YqFWXoP0fzo3oNqeLIlHf+DUv8I/2VqTZcr03AYIX4CNMXsRQBHBeiocmhwWPy0n2rodqViugAe6a7VgQVUq+mOkwcK07FzyOOYcwEapEPWpIHMtX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732950064; c=relaxed/simple;
	bh=OY1eKMfzylYTtl4grnVqMabv/V9aIK9uPXcUUo8Mm1I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EDNTmzdQAsOK4lg0qc34+x2ouCKFuekA+LaOwewUt7JF6iiRNcSxYQZzBTL9DtcjjZMsyZvbPeN8DB5ff+xc0tbnaKI/E3vGfhKAt4lbACPn+Q2UIm3Zuwms7XtR6l434qD90e1GSCflUw3khPODVsxReHYSKFr+dYdOtHuVinc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a76690f813so28693385ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 23:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732950062; x=1733554862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+zxhPd1B69/sIFMXZtn9rBj6FwpaUPCmD+eIHTPevA=;
        b=itqZiJZpfcIU4aK1onoXbxkJd5NRbWCgmWVZSEg+KzFPmHqmjk6cFndGx03BVmh1tQ
         h521mHoJgRjLhzywO0X/Sa9pSp+eTp4k2gO3hVIPP6s9IIeym2hL0AttOjxOKSba55XC
         suMMic7+zbWPM/8c1LS+aaX25s/x38Zmrxfmh8wWqICZ5lLweS6se9v/zAOrnm+vm3Kk
         hhWOqkv8t0DhCTcRdY8bdrXnLzh2deOF5jvRovLr3irpXgMbTuJU1j9SnjSRY6q6BQ+i
         6/jJ+06imSW+FOJoUHbzlEkDnMDvR4SOAFIitQWwLQJdIXLpZX2yiq6X8hF/B5ukhgnn
         zuqA==
X-Forwarded-Encrypted: i=1; AJvYcCU628mq3FuvdtA8vAVY8Os9c+ym8X17sAMJYI1rUI7GV5JKYHETKpO4o9dZIUftH9lrV2vex4fTGEqv7f/H@vger.kernel.org
X-Gm-Message-State: AOJu0Yywy3nyLTvIuliZjMZf3zhnUSmvydYxdYPZQ2M/rYHPjDUJT6d4
	x6PERbofluXoO910BGTiX66wMAUvZhAbVe8aSflXmfD6uo3HlDu9ZOAfNShB4BKRi7gER9P6y5E
	oXwqe6WssNo7fDuaiG+VP4qiGnb1dsxDz+0LJhLpIBv5CmiNFGmTCPyI=
X-Google-Smtp-Source: AGHT+IHeoGfoPkw3PRfOf8JHtKOi73u9Fp0HDvkM6xnHnj1HrU8duhBqWbHVCBhIBjL2qSoU8NcACDtbz5LDXUShrDGYkO3D2GnC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148e:b0:3a7:e047:733f with SMTP id
 e9e14a558f8ab-3a7e0477ab5mr40974295ab.1.1732950061919; Fri, 29 Nov 2024
 23:01:01 -0800 (PST)
Date: Fri, 29 Nov 2024 23:01:01 -0800
In-Reply-To: <7a8955d4-4283-426f-8bbf-8f81787fb08e@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674ab82d.050a0220.253251.00d8.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
From: syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, willy@infradead.org, 
	wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: MAX_LOCKDEP_KEYS too low!

BUG: MAX_LOCKDEP_KEYS too low!
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 18394 Comm: syz-executor388 Not tainted 6.12.0-rc7-syzkaller-00133-g17a4e91a431b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 register_lock_class+0x827/0x980 kernel/locking/lockdep.c:1328
 __lock_acquire+0xf3/0x2100 kernel/locking/lockdep.c:5077
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 touch_wq_lockdep_map+0xc7/0x170 kernel/workqueue.c:3880
 __flush_workqueue+0x14f/0x1600 kernel/workqueue.c:3922
 drain_workqueue+0xc9/0x3a0 kernel/workqueue.c:4086
 destroy_workqueue+0xba/0xc40 kernel/workqueue.c:5830
 btrfs_stop_all_workers+0xbb/0x2a0 fs/btrfs/disk-io.c:1782
 close_ctree+0x6bb/0xd60 fs/btrfs/disk-io.c:4360
 generic_shutdown_super+0x139/0x2d0 fs/super.c:642
 kill_anon_super+0x3b/0x70 fs/super.c:1237
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2112
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f378bf8c357
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd4c441108 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f378bf8c357
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd4c4411c0
RBP: 00007ffd4c4411c0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000202 R12: 00007ffd4c442280
R13: 00005555591197d0 R14: 431bde82d7b634db R15: 00007ffd4c442224
 </TASK>
BTRFS info (device loop2): last unmount of filesystem bf719321-eb1f-43c1-9145-be0044cdbc04
BTRFS info (device loop2): last unmount of filesystem 454c899b-20f1-4098-b6bd-9b424eb38c60
BTRFS info (device loop2): last unmount of filesystem e789dab4-7b2e-44bb-bb97-19a8dd7be099
BTRFS info (device loop2): last unmount of filesystem a11fd0de-3a92-4478-af85-4e70dfb2fb44
BTRFS info (device loop2): last unmount of filesystem 85ccfa0b-566f-4eb9-b1a6-ea2fe97ca044
BTRFS info (device loop2): last unmount of filesystem 5a8c012e-dba3-4ff5-a22f-46e4b5bb2f55
BTRFS info (device loop2): last unmount of filesystem 2fe685f2-8834-419b-bd91-466d40ccece7
BTRFS info (device loop2): last unmount of filesystem fc366aaa-c1c0-4d55-9034-d39fce006f22
BTRFS info (device loop2): last unmount of filesystem 364312bb-b5a2-487f-aaa2-e36f3a1b701f
BTRFS info (device loop2): last unmount of filesystem 14d642db-7b15-43e4-81e6-4b8fac6a25f8


Tested on:

commit:         17a4e91a btrfs: test if we need to wait the writeback ..
git tree:       https://github.com/adam900710/linux.git writeback_fix
console output: https://syzkaller.appspot.com/x/log.txt?x=1501b9e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4954ad2c62b915
dashboard link: https://syzkaller.appspot.com/bug?extid=aac7bff85be224de5156
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

