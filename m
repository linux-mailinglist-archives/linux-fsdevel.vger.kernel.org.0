Return-Path: <linux-fsdevel+bounces-53491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0127BAEF88B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB4537AB418
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B422727E3;
	Tue,  1 Jul 2025 12:30:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E185C5E
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373030; cv=none; b=IMUAZFOJrZZYGjcIX5llVtnvXTqjyCQ8RzVNSh8GT4lHmSFMjtwZsJSjX96X7b6Vmo/d2TJJEYlTTp9TNgPfQMXKOviMSQ3dbtDo1K+LRJXDQEL32Ff5p5tAL6VWaCt2rEuVs6Iy2SGoH0p5wV/lvyA8YIlRtbE0/CRXG8LWyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373030; c=relaxed/simple;
	bh=kpA2ciu3Ka93Ok86leflif+v4PM3jren9a+lmBCYc3o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Mx4BP3Wc+2LdpxQJsFRh6IlvuteEtLkenot6nNLEIl4UWJ753IEysNZigYt76EGpeV+8B71WaCEbIggRCn1PtrL+j6BbyJZTYrWJXKVuseAV+PO48XVgUtF7ekzcZYVM4XMo2vFVbgkamVIbDK8PqbSNTnbrI2yOMMU3iPSymCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-87313ccba79so638206639f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 05:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751373028; x=1751977828;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cN9KWDOuzT7EKHnK6OkzJ66VwAcB0QwTMr9rV89pQOM=;
        b=qgsYffs0/deeNOqnewA/mgu3o3yVK+EXxzhcqGdrsWiaceX154FduWS71sY928Gz4z
         SBLBOk5Rc09yjqn/Duuxe2fmOTqJ/wA/mD4HK5q1EM15BsOpaH5xk9CBrlgLEvf6pWBu
         gGQqJ3S7n5Zh5DzHB5xDJ4sCWiNecNhPUtT78E1GxrOfLXEis1HrsxRzd7iwxP2MomB7
         PeQVezRomPpe1PzLyVn0W3DgTt/bv1JaU9A/eguHf26FEV/ejlo0Wnyyuib4muEeG76b
         3v77CGmaNRDM0z7c3ypy0hIFJ+D5W493cJN8zAVPFMM3DY83yoRaS2dTsc8GX+6drTdx
         J1jg==
X-Forwarded-Encrypted: i=1; AJvYcCXCF5qBBgNGzHmmuLTgi4Swpail6cBTC40bLCc+RonTOyYCcN+vYaDshXE1cR5kH5i1IPXixSc0PUfY0fQU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4EylHxGABfIU/e3ddAW6p8Nko1Rxkdq/+dF/atnLvPX2DfQKg
	4QfEPi7FhxPaJAfEuUkXydUvOU8QSQAgf6wevMWRrCLY2UnPT0AkFJa/pPd5P2ptXptxMVVkUQg
	GeFXhvxVDVyXODfwMxZWDcBIumU0FQ0kUy4CJ94Ah88NE6qf+4Kb68gq8E+4=
X-Google-Smtp-Source: AGHT+IERN3pxkDYMRbEkhigbfvZBzWzDLued9o0vB/EMrAVwvaA2COhWMpFzCQ4yoitiyN1h5iAIwdwDzJKrLz2UkyxfxkRnGA9t
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c08:b0:86d:1218:de96 with SMTP id
 ca18e2360f4ac-8768839ebd9mr1945168839f.12.1751373027931; Tue, 01 Jul 2025
 05:30:27 -0700 (PDT)
Date: Tue, 01 Jul 2025 05:30:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6863d4e3.a70a0220.3b7e22.1b12.GAE@google.com>
Subject: [syzbot] [fs?] linux-next test error: WARNING: suspicious RCU usage
 in proc_sys_compare
From: syzbot <syzbot+37d54f0f58ba8519cdbe@syzkaller.appspotmail.com>
To: joel.granados@kernel.org, kees@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3f804361f3b9 Add linux-next specific files for 20250701
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14e11770580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46111759e155f4cc
dashboard link: https://syzkaller.appspot.com/bug?extid=37d54f0f58ba8519cdbe
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c371987646a7/disk-3f804361.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/94a8f81e003e/vmlinux-3f804361.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a126fddf774b/bzImage-3f804361.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+37d54f0f58ba8519cdbe@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.16.0-rc4-next-20250701-syzkaller #0 Not tainted
-----------------------------
fs/proc/proc_sysctl.c:934 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by syz-executor/5832:
 #0: ffff888030574428 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:557
 #1: ffff8880230d8190 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:884 [inline]
 #1: ffff8880230d8190 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: open_last_lookups fs/namei.c:3806 [inline]
 #1: ffff8880230d8190 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: path_openat+0x8cb/0x3830 fs/namei.c:4043
 #2: ffff88807e2779c8 (&lockref->lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffff88807e2779c8 (&lockref->lock){+.+.}-{3:3}, at: d_wait_lookup fs/dcache.c:2537 [inline]
 #2: ffff88807e2779c8 (&lockref->lock){+.+.}-{3:3}, at: d_alloc_parallel+0xbe4/0x15e0 fs/dcache.c:2624

stack backtrace:
CPU: 0 UID: 0 PID: 5832 Comm: syz-executor Not tainted 6.16.0-rc4-next-20250701-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6871
 proc_sys_compare+0x27d/0x2c0 fs/proc/proc_sysctl.c:934
 d_same_name fs/dcache.c:2179 [inline]
 d_alloc_parallel+0x105d/0x15e0 fs/dcache.c:2637
 lookup_open fs/namei.c:3630 [inline]
 open_last_lookups fs/namei.c:3807 [inline]
 path_openat+0xa3b/0x3830 fs/namei.c:4043
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1434
 do_sys_open fs/open.c:1449 [inline]
 __do_sys_openat fs/open.c:1465 [inline]
 __se_sys_openat fs/open.c:1460 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1460
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa66218d211
Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d 3a 83 1f 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
RSP: 002b:00007ffe575748d0 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000080001 RCX: 00007fa66218d211
RDX: 0000000000080001 RSI: 00007fa66222ae2b RDI: 00000000ffffff9c
RBP: 00007fa66222ae2b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000009
R13: 00007ffe57574970 R14: 0000000000000009 R15: 0000000000000000
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

