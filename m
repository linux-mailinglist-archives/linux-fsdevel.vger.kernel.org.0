Return-Path: <linux-fsdevel+bounces-14807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8382187FB98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 11:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B548C1C20FD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 10:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41817E57F;
	Tue, 19 Mar 2024 10:13:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CEC7E564
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843203; cv=none; b=WuT2XQG9T+B4tEENLzqQyQpkdE/g/+QMCQ+YjSMQk7dXaJiUORtR2ynENuxTFo2PcoXbpBpupVelvJrWkz3B7BTkDKZr+q554XzzRX1sc4/WahkUw9hff43Hc8FPe7Y/d7SepFGh54ZBnI910Y32/fVerB44oZvbjSBygbVdbE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843203; c=relaxed/simple;
	bh=nGAGdpvdW20Osr3RxlFOnpoFW/e7JkxiDcGlxpHPrTQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u0WYN5Rib+dc86Phj2+PDN9E0eh+HXuf0YMz8H4P8fiQaR0R75/M5lSkymmR05LCBfdZuDweXxf25F9OF9BB0g7UBkLGjuDiyMDMt4b/u3TTDk6wdevvnXncCWctnRTmfNAXRLV5Cvro4V9r+WSekN8tl6U9eh8Jl/WLX5B+ku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cb806fc9f7so528927439f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 03:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843201; x=1711448001;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVWo3OW7v6RM8KpVjlOclZLMZCa5nPUC4vsLf0Mpl6Y=;
        b=ll8KYKU8ce9SwY7GWn9XeVFrRYOrXqs/vYlcV9+KzRpb0622BjrNvuqRFO5m8pUQgx
         XGxz5OcB7iWJtsjI06ttpHD5xuLS8aK28t0ZKekgOz3MhQajGW0uBMyeGv3Bo0T/M8gr
         9A39TtFesOovPooGiRSIu1PGLTdRIuk9e2/TPMGUm1cVbBfxt6721p7cy5pNCQhgQqBT
         lkJja3bEfo7WtBOD6wxEIqBCf9jRFG82LjvDZyfhw/5nh0M4eTQDIk1eDrt4YTtda/+2
         vJOHGR1VFbUqr/8QXRhjQtwYmNqR1YZ2tMXZETmksqOykblT1YJ6DXSOL6VpikePt7Q7
         gBhw==
X-Forwarded-Encrypted: i=1; AJvYcCWnCpKpsSrgkVqzWVlRZd/eCd5RPlZytKPxh0M0kiso6GB4YZ7dS4whybp8P45lNacXiY2oxebHumx4NZ4mV0UXSfVDWCETVk/r9HgCyg==
X-Gm-Message-State: AOJu0YwbU1EA2DhoxKU4CMghP/ZZh0uBVlpuLlsnCHYMjvR2TyByAMxa
	FPLiMNWWybAJDZKJSJK32AuY1JsCg4FQ3iMHzyi7oBCV9E70Da4X+Qjb3ao/LNswndIZR74vKkn
	/YDES6Jxu9oQA0NrTQ3ksxn3L7ZVQKhW28IR5AmifuKUi4Jb3EiMFpmY=
X-Google-Smtp-Source: AGHT+IFnYwDPpTN7Zf+grtyBlIIPEncHbUppHOcyRUbwdQF9ibbiDo8FPnl26e7BKuD66ggGekHqZ+eH8AquJ5YCpHnslbLSr5Xt
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3711:b0:47b:cbf1:9064 with SMTP id
 k17-20020a056638371100b0047bcbf19064mr77340jav.0.1710843200902; Tue, 19 Mar
 2024 03:13:20 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:13:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041ac86061400b95d@google.com>
Subject: [syzbot] [jfs?] INFO: task hung in lmLogClose (3)
From: syzbot <syzbot+c824290332add8067111@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=126c764e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=c824290332add8067111
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101e05be180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151ec2a5180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e14a3937c758/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c824290332add8067111@syzkaller.appspotmail.com

INFO: task syz-executor394:6204 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor394 state:D stack:0     pid:6204  tgid:6204  ppid:6201   flags:0x0000000c
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:553
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x1498/0x24b4 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6817
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6874
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:684
 __mutex_lock kernel/locking/mutex.c:752 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
 lmLogClose+0xc8/0x4d4 fs/jfs/jfs_logmgr.c:1444
 jfs_umount+0x274/0x360 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x90/0x188 fs/jfs/super.c:194
 generic_shutdown_super+0x128/0x2b8 fs/super.c:641
 kill_block_super+0x44/0x90 fs/super.c:1675
 deactivate_locked_super+0xc4/0x12c fs/super.c:472
 deactivate_super+0xe0/0x100 fs/super.c:505
 cleanup_mnt+0x34c/0x3dc fs/namespace.c:1267
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1274
 task_work_run+0x230/0x2e0 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 do_notify_resume+0x178/0x1f4 arch/arm64/kernel/entry-common.c:151
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xac/0x168 arch/arm64/kernel/entry-common.c:713
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
INFO: task syz-executor394:6205 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor394 state:D stack:0     pid:6205  tgid:6205  ppid:6201   flags:0x0000000c
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:553
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x1498/0x24b4 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6817
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6874
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:684
 __mutex_lock kernel/locking/mutex.c:752 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
 lmLogClose+0xc8/0x4d4 fs/jfs/jfs_logmgr.c:1444
 jfs_umount+0x274/0x360 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x90/0x188 fs/jfs/super.c:194
 generic_shutdown_super+0x128/0x2b8 fs/super.c:641
 kill_block_super+0x44/0x90 fs/super.c:1675
 deactivate_locked_super+0xc4/0x12c fs/super.c:472
 deactivate_super+0xe0/0x100 fs/super.c:505
 cleanup_mnt+0x34c/0x3dc fs/namespace.c:1267
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1274
 task_work_run+0x230/0x2e0 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 do_notify_resume+0x178/0x1f4 arch/arm64/kernel/entry-common.c:151
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xac/0x168 arch/arm64/kernel/entry-common.c:713
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffff80008ee74ac0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:297
2 locks held by getty/5927:
 #0: ffff0000d2e810a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff800093fe02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x41c/0x1228 drivers/tty/n_tty.c:2201
2 locks held by syz-executor394/6202:
 #0: ffff0000d98900e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff0000d98900e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff0000d98900e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: deactivate_super+0xd8/0x100 fs/super.c:504
 #1: ffff80008f2586e8 (jfs_log_mutex){+.+.}-{3:3}, at: lmLogClose+0xc8/0x4d4 fs/jfs/jfs_logmgr.c:1444
1 lock held by syz-executor394/6203:
 #0: ffff0000c25c00e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff0000c25c00e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff0000c25c00e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: deactivate_super+0xd8/0x100 fs/super.c:504
2 locks held by syz-executor394/6204:
 #0: ffff0000d60740e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff0000d60740e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff0000d60740e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: deactivate_super+0xd8/0x100 fs/super.c:504
 #1: ffff80008f2586e8 (jfs_log_mutex){+.+.}-{3:3}, at: lmLogClose+0xc8/0x4d4 fs/jfs/jfs_logmgr.c:1444
2 locks held by syz-executor394/6205:
 #0: ffff0000d95420e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff0000d95420e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff0000d95420e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: deactivate_super+0xd8/0x100 fs/super.c:504
 #1: ffff80008f2586e8 (jfs_log_mutex){+.+.}-{3:3}, at: lmLogClose+0xc8/0x4d4 fs/jfs/jfs_logmgr.c:1444
2 locks held by syz-executor394/6206:
 #0: ffff0000d5cb80e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff0000d5cb80e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff0000d5cb80e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: deactivate_super+0xd8/0x100 fs/super.c:504
 #1: ffff80008f2586e8 (jfs_log_mutex){+.+.}-{3:3}, at: lmLogClose+0xc8/0x4d4 fs/jfs/jfs_logmgr.c:1444

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

