Return-Path: <linux-fsdevel+bounces-58613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29EAB2FC10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 16:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A483C7230C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 14:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB325241690;
	Thu, 21 Aug 2025 14:08:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9A522069A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785315; cv=none; b=pLS62waG38Ob/0EgNx6RRisEvBBWFXLa3gAgruBkn6zKawv631RAqRlB28JX+uaXVq104FlvYZ3uGLKBeFx49nCREWkLC7LMrfNfPuD/Rx7Lht3v0eYJDlMzhRE8GaY6hicU+vkTcpbNRCbCF2ezYkSLlhpEqGWedI8ga4qBQWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785315; c=relaxed/simple;
	bh=znPykkbROliSjpvxuccxv6Ye409UsS8f7zOe/B+5JBQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dBPD+JED1cSTLQUO/mieDtmx8uMHneNrbxt8NwkFLAgp8t3ZvQ/C/ZAV0fDcvsW5dgOFhYLk/uL5cvSfgreOOeoLKs0N/zNw8PglY4H3fmhBhnN8ZETnO9IXb1f/aH7mxgsl6wbMFEb+zyVxHm0cedMWGOdDJ+MRjVnIQW2Qn70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3e56ff20434so8257475ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 07:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785313; x=1756390113;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/enU3klx7bfkpNDi5dMuC8pF4in7LDDV9JxB6hf48k=;
        b=dqgLsTfH51uc/YhSIYsNlhjgyNxELSxLxVDOkX/34N49cmdE60xevWfIb3i+16/I9/
         b36DAM8VO4V4o6quTfGwWcYGMu8uQcNwf2PvWGCAPUMNpXAO5OEGeWVaTyMW3yu1wQZU
         Kr9+qL4PKLVLRFX7l7OoJmXVMMd0QBFF0mdU2imqTrzrdVjct9VLu+LrCjyttOF53nvq
         g+n792DBlAY+cGYccIfbh1fpTEOfKG/xsEu4XlLup2p3GbRVoYVXBErKkAbEtMFu4C4z
         uyl+uKfxDn9n62irJgkgeR0mcIkZB0+cK1/ZGRUREi+SOG/tdi9goMP2sjQehH8IGVo4
         41sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNorAbO7i8ZB3CtzBJhnbnHjbwOlMwuskh8LB2SclKcHXdf2zGKQ9Fu0CU4/mOcbjo15t3hHl0FFi5GdWY@vger.kernel.org
X-Gm-Message-State: AOJu0YxW5tzdvEWLeVjYvyXagAxAmMXMCbk3/ua6Z1JQ7CMp76la/5Ba
	jVsYYJ8tUX75WvcZcN4SfZucfn783QaCW8mt6qVTnpWgB4s1OaF7nKlTfa565IPZli+NiTS9uF1
	iaBjvG7MT9Jgaag3+ORZeb3GpfhzlGn1qEkg7MZMNP0nEEt0Rz8raKSxpoFQ=
X-Google-Smtp-Source: AGHT+IFxlZweowjB6dvQbH/PChzOLYG9iOSjfbeXU6zgQTKb9IwQSUWLKbNDNnQXv6sY2dPdDJrPl/H3ZUDDbUxILYOJ9slBOF2D
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2703:b0:3e8:ec53:1e7a with SMTP id
 e9e14a558f8ab-3e8ec533da4mr5274285ab.15.1755785312942; Thu, 21 Aug 2025
 07:08:32 -0700 (PDT)
Date: Thu, 21 Aug 2025 07:08:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a72860.050a0220.3d78fd.002a.GAE@google.com>
Subject: [syzbot] [exfat?] [ext4?] WARNING in __rt_mutex_slowlock_locked
From: syzbot <syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, brauner@kernel.org, jack@suse.cz, 
	linkinjeon@kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    41cd3fd15263 Merge tag 'pci-v6.17-fixes-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ef37a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=a725ab460fc1def9896f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a857a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c916f0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bc397a2f4204/disk-41cd3fd1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5291086f4669/vmlinux-41cd3fd1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1099e6ad84b5/bzImage-41cd3fd1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c1980868ad6b/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=10e28fa2580000)

The issue was bisected to:

commit d2d6422f8bd17c6bb205133e290625a564194496
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Fri Sep 6 10:59:04 2024 +0000

    x86: Allow to enable PREEMPT_RT.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16cf8fa2580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15cf8fa2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11cf8fa2580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com
Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")

exFAT-fs (loop0): Medium has reported failures. Some data may be lost.
exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0xe5674ec2, utbl_chksum : 0xe619d30d)
------------[ cut here ]------------
rtmutex deadlock detected
WARNING: CPU: 0 PID: 6000 at kernel/locking/rtmutex.c:1674 rt_mutex_handle_deadlock kernel/locking/rtmutex.c:1674 [inline]
WARNING: CPU: 0 PID: 6000 at kernel/locking/rtmutex.c:1674 __rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
WARNING: CPU: 0 PID: 6000 at kernel/locking/rtmutex.c:1674 __rt_mutex_slowlock_locked+0xed2/0x25e0 kernel/locking/rtmutex.c:1760
Modules linked in:
CPU: 0 UID: 0 PID: 6000 Comm: syz.0.17 Tainted: G        W           syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:rt_mutex_handle_deadlock kernel/locking/rtmutex.c:1674 [inline]
RIP: 0010:__rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
RIP: 0010:__rt_mutex_slowlock_locked+0xed2/0x25e0 kernel/locking/rtmutex.c:1760
Code: 7c 24 20 dd 4c 8b b4 24 98 00 00 00 0f 85 fd 0a 00 00 48 8b 7c 24 10 e8 2c ee 5d 09 90 48 c7 c7 00 ed 0a 8b e8 df 89 e7 ff 90 <0f> 0b 90 90 48 8b 9c 24 80 00 00 00 43 80 3c 3e 00 74 08 4c 89 e7
RSP: 0018:ffffc900048df840 EFLAGS: 00010246
RAX: e12880a9366a4400 RBX: ffff8880324663e0 RCX: ffff888032465940
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900048dfa30 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1017104863 R12: ffff888032467060
R13: ffff888032465958 R14: 1ffff1100648ce0c R15: dffffc0000000000
FS:  0000555557981500(0000) GS:ffff8881268c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000035be0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rt_mutex_slowlock+0xb5/0x160 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 rwbase_write_lock+0x14f/0x750 kernel/locking/rwbase_rt.c:244
 inode_lock_nested include/linux/fs.h:914 [inline]
 vfs_rename+0x68f/0xf00 fs/namei.c:5092
 do_renameat2+0x6ce/0xa80 fs/namei.c:5278
 __do_sys_renameat2 fs/namei.c:5312 [inline]
 __se_sys_renameat2 fs/namei.c:5309 [inline]
 __x64_sys_renameat2+0xce/0xe0 fs/namei.c:5309
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc9cdd7ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe70cc6ad8 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 00007fc9cdfa5fa0 RCX: 00007fc9cdd7ebe9
RDX: 0000000000000004 RSI: 00002000000001c0 RDI: 0000000000000004
RBP: 00007fc9cde01e19 R08: 0000000000000004 R09: 0000000000000000
R10: 0000200000000140 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc9cdfa5fa0 R14: 00007fc9cdfa5fa0 R15: 0000000000000005
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

