Return-Path: <linux-fsdevel+bounces-16319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A60689AEA6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 07:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA091F220B6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 05:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274EC539C;
	Sun,  7 Apr 2024 05:18:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04A17C9
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Apr 2024 05:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712467107; cv=none; b=hCrzwRE773Pa1Z7nv34ezS6W5LKHFoV0xAGMWHwDJQzOG0bVh4B4HagIJv+yeozaL4bZTsBfeAFaxlIDZaJyoMxrQnBux6zL3vuYt45GngXlYT1a1NjSsZRZV4FyWy4Na0IYtDKh2g77Z6kTAjKr4EP229UrtJnaLfyG8gWkOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712467107; c=relaxed/simple;
	bh=MlmTbqDCXZmzQ8g8iy/EAy7eKiq1xs3qaAP7fvLBjbA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G2pgroruhoZIHOEdXhwUe4M4xs9qZqlVQ3ofqdMiX4+yR45CoQUkJmePORP6+oyzstPETwAidVfBLzOWzmsc/a1OdGJVfgcIaUeLQDYTMgu4kI2+ZLjxtU3AWCkXriI5PTtcxSzeyJLkWXwp88VHNlcf0+RD+y7NkqpM/uYOa18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d5dbbc3e9fso26703939f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Apr 2024 22:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712467105; x=1713071905;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MH8LCDUm7YgevgRehOESoxCJDka7u1fwHf2mJqhbyBc=;
        b=dHr4CqAOWlfAukCGwwlqNgwP6yczxm77uCI/DsaxoNNukgUug1uA9XujOCyl4IO/+y
         pHL+Pvf2/wVucquZ54jaY/5e5LC493QiFzFKZdyyS6Y2momLxM5EyYjPghrcEjlu9emR
         WV0VUO9F2lVoZyqBoHieMS4ObONgW7Jy8fbZEFZ45BXZSXKiN8BvxK9EY537g62QDRdY
         EyC/1u7O1fZKT6NM5qJrZ6A7q+qrztdKLL/60Xtfbd674jUNPylQ4F+Hm3zoGBsoWtJl
         hCxrO+zJtYwbiokTWeVG+5VJovywxrG8b08agPmLStXz74h8G9cYQDW/F+99Ngjh1/Vi
         uUwA==
X-Forwarded-Encrypted: i=1; AJvYcCWocMkmvSopbk8b7kOm94nIOstR/w0g3AQHXoaWGkhmhl/MmnZSc52y3mdpKTXzYgWdd7oZUZF3JleolktQmIDQJ5W4eJzIpfrR4X8K3A==
X-Gm-Message-State: AOJu0YwMBOaofl6IW0XJkLF5MiSSZSYEUTlbqVAIE8x/7TVRZsaxEE2C
	PctAmySlGQ5CmOzZ7YH2qob4JOJgs/78yJ7+otbu64UwX6uAVrT1LWJKfr9LfG1syYfZBHYYT6K
	wP0fR4Msul/PY7vSk2IgwHnvDjm/X4gDQVx+5S6zeYikN5mQR6cR6IBY=
X-Google-Smtp-Source: AGHT+IFdLLzlKY5AWQR5Ou5hh1jTnjMqczmCfF4ygNKuMZt6ZcFQRq02Uqqt1yFcrxKtT7RhBzzpokKaDR0nflXrDWGZUH+1WzPL
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2999:b0:480:4e6a:bf00 with SMTP id
 eh25-20020a056638299900b004804e6abf00mr105863jab.2.1712467105172; Sat, 06 Apr
 2024 22:18:25 -0700 (PDT)
Date: Sat, 06 Apr 2024 22:18:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e66d506157ad1bc@google.com>
Subject: [syzbot] [gfs2?] possible deadlock in do_qc
From: syzbot <syzbot+8ef337b733667f9a7ec8@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15db6719180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=8ef337b733667f9a7ec8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ef337b733667f9a7ec8@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-rc7-syzkaller-g707081b61156 #0 Not tainted
------------------------------------------------------
syz-executor.3/6998 is trying to acquire lock:
ffff0000ccd04ae8 (&sdp->sd_quota_mutex){+.+.}-{3:3}, at: do_qc+0xac/0x5c8 fs/gfs2/quota.c:720

but task is already holding lock:
ffff0000db995688 (&ip->i_rw_mutex){++++}-{3:3}, at: sweep_bh_for_rgrps fs/gfs2/bmap.c:1529 [inline]
ffff0000db995688 (&ip->i_rw_mutex){++++}-{3:3}, at: punch_hole+0x1f58/0x2f7c fs/gfs2/bmap.c:1852

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ip->i_rw_mutex){++++}-{3:3}:
       down_read+0x58/0x2fc kernel/locking/rwsem.c:1526
       __gfs2_iomap_get+0x138/0x1058 fs/gfs2/bmap.c:859
       gfs2_iomap_get+0xd8/0x154 fs/gfs2/bmap.c:1413
       bh_get+0x1ec/0x690 fs/gfs2/quota.c:417
       qdsb_get+0x1c8/0x30c fs/gfs2/quota.c:566
       gfs2_quota_hold+0x16c/0x560 fs/gfs2/quota.c:646
       punch_hole+0xc10/0x2f7c fs/gfs2/bmap.c:1813
       gfs2_iomap_end+0x448/0x618 fs/gfs2/bmap.c:1174
       iomap_iter+0x1f4/0x1018 fs/iomap/iter.c:79
       iomap_file_buffered_write+0x968/0xb30 fs/iomap/buffered-io.c:976
       gfs2_file_buffered_write+0x468/0x76c fs/gfs2/file.c:1059
       gfs2_file_write_iter+0x79c/0xdb0 fs/gfs2/file.c:1163
       call_write_iter include/linux/fs.h:2087 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0x968/0xc3c fs/read_write.c:590
       ksys_write+0x15c/0x26c fs/read_write.c:643
       __do_sys_write fs/read_write.c:655 [inline]
       __se_sys_write fs/read_write.c:652 [inline]
       __arm64_sys_write+0x7c/0x90 fs/read_write.c:652
       __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

-> #0 (&sdp->sd_quota_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
       lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5754
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
       __mutex_lock kernel/locking/mutex.c:752 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
       do_qc+0xac/0x5c8 fs/gfs2/quota.c:720
       gfs2_quota_change+0x238/0x728 fs/gfs2/quota.c:1315
       punch_hole+0x2a30/0x2f7c fs/gfs2/bmap.c:1953
       gfs2_iomap_end+0x448/0x618 fs/gfs2/bmap.c:1174
       iomap_iter+0x1f4/0x1018 fs/iomap/iter.c:79
       iomap_file_buffered_write+0x968/0xb30 fs/iomap/buffered-io.c:976
       gfs2_file_buffered_write+0x468/0x76c fs/gfs2/file.c:1059
       gfs2_file_write_iter+0x79c/0xdb0 fs/gfs2/file.c:1163
       call_write_iter include/linux/fs.h:2087 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0x968/0xc3c fs/read_write.c:590
       ksys_write+0x15c/0x26c fs/read_write.c:643
       __do_sys_write fs/read_write.c:655 [inline]
       __se_sys_write fs/read_write.c:652 [inline]
       __arm64_sys_write+0x7c/0x90 fs/read_write.c:652
       __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ip->i_rw_mutex);
                               lock(&sdp->sd_quota_mutex);
                               lock(&ip->i_rw_mutex);
  lock(&sdp->sd_quota_mutex);

 *** DEADLOCK ***

6 locks held by syz-executor.3/6998:
 #0: ffff0000d5936348 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x218/0x2a4 fs/file.c:1191
 #1: ffff0000f2b02420 (sb_writers#24){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2794 [inline]
 #1: ffff0000f2b02420 (sb_writers#24){.+.+}-{0:0}, at: vfs_write+0x368/0xc3c fs/read_write.c:586
 #2: ffff0000db9951f0 (&sb->s_type->i_mutex_key#27){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:804 [inline]
 #2: ffff0000db9951f0 (&sb->s_type->i_mutex_key#27){+.+.}-{3:3}, at: gfs2_file_write_iter+0x2ac/0xdb0 fs/gfs2/file.c:1114
 #3: ffff0000f2b02610 (sb_internal#6){.+.+}-{0:0}, at: gfs2_trans_begin+0x8c/0x100 fs/gfs2/trans.c:118
 #4: ffff0000ccd05060 (&sdp->sd_log_flush_lock){++++}-{3:3}, at: __gfs2_trans_begin+0x510/0x908 fs/gfs2/trans.c:87
 #5: ffff0000db995688 (&ip->i_rw_mutex){++++}-{3:3}, at: sweep_bh_for_rgrps fs/gfs2/bmap.c:1529 [inline]
 #5: ffff0000db995688 (&ip->i_rw_mutex){++++}-{3:3}, at: punch_hole+0x1f58/0x2f7c fs/gfs2/bmap.c:1852

stack backtrace:
CPU: 0 PID: 6998 Comm: syz-executor.3 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2060
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5754
 __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
 __mutex_lock kernel/locking/mutex.c:752 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
 do_qc+0xac/0x5c8 fs/gfs2/quota.c:720
 gfs2_quota_change+0x238/0x728 fs/gfs2/quota.c:1315
 punch_hole+0x2a30/0x2f7c fs/gfs2/bmap.c:1953
 gfs2_iomap_end+0x448/0x618 fs/gfs2/bmap.c:1174
 iomap_iter+0x1f4/0x1018 fs/iomap/iter.c:79
 iomap_file_buffered_write+0x968/0xb30 fs/iomap/buffered-io.c:976
 gfs2_file_buffered_write+0x468/0x76c fs/gfs2/file.c:1059
 gfs2_file_write_iter+0x79c/0xdb0 fs/gfs2/file.c:1163
 call_write_iter include/linux/fs.h:2087 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x968/0xc3c fs/read_write.c:590
 ksys_write+0x15c/0x26c fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:652
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598


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

