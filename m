Return-Path: <linux-fsdevel+bounces-44143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5527A634C8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 10:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261D83AE1E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 09:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB3319CD1D;
	Sun, 16 Mar 2025 09:28:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF7928F4
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Mar 2025 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742117316; cv=none; b=sDuDSc4OpdlUiZmJP8ioP6QbRQR+u4k2o1BjvZJ7804dvupFtdDZZPB7PWpLCoDrnLawfZO2iuAfnFpz49dTxWtuXWVD+WDtbPc2uuBzHW4UXmUqKxPm6qfs+Bw9tADZVSAhjWZLWh1WSZzY0r6uRVDWAVupWCI1M9LHBQuC+DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742117316; c=relaxed/simple;
	bh=npEo97OkWwmsOjj12vQUA8C0xCdoArZS2J95lYCnmLY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LakZzzjUwVzu/Fk81BwJzR705GcinFuxIX9kvQwulXoF4O6lhFB/bcAHcdHHPzzWd/ORpbFrzklXIPcrMbHrl4nK4XNOt7LV38mVPVlI1V/y+z6MWaf1secJx0hztVfBt+dp0D73yLavGj0MTj0FM1dm0J8gy3wwBogbEE50XzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d451ad5b2dso50763455ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Mar 2025 02:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742117313; x=1742722113;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5CJmg+rM+T5FQAaQfrCiTGVx530y/p3kHSU0H3K/pnI=;
        b=tZAzh7P3SXdsbmUToafAVnGwHoL4DHs9jTzIfsCfMXgfy6twb3gX6WfOfdU+SoiIUK
         RlesKO9DUdnHKs1h2VYngBrfNxWPqnpHmwNpLAZYctCOmVcsC6cijvAOQphsKSGev2Yl
         86ahF7v9yqFy65J5xrMkutLSBDGnyqwjdpnNnwDkt+t4pcLzgOhmo66wOUjJd6fOqe6g
         3uS+qaooSy/iGEUwdrDYn3BnpH3QE5e7ljhmvdkIbdtYwrwBCekj6z2CAmHrqt76GmJX
         C8+SOqvWD67M2kH5WiWAXa7MyGKchfQHFDVWPkqfTX6/e/54TH9dWtuHwYhWLHf3dlgA
         bSng==
X-Forwarded-Encrypted: i=1; AJvYcCWKIbRuccmfQEzuDVJ6usUtS1NqkSAj7dBEj3QzBWxdgchRSztBXoVzFnj4ad6CPFzySifaPPAvzIeZc8mV@vger.kernel.org
X-Gm-Message-State: AOJu0YyZlcg0EouhnD4YoJR6fnU8NMvt3HZg8gsjY9R73wM6MumQXwUe
	7N3ZH8mJVIBddLkezeHIuwnSUpqw8CVyw7q9ZPhQ3w7E9DRi/93zI1xE2OJnaCxGa+J6wp6YeWp
	qLyyPvlzdT26hg2Svp1bXbRi4Og/BnwZMxRtg8EJxRa/VCK4waC56IxY=
X-Google-Smtp-Source: AGHT+IF+vLuG4ESFCtQlkw9or7MiPGJqToOs7YoEjOdOaUc1P3Yt4LWywVESaKEplT6r84cqWmiWFFYVAU5N5UebphD7vUWGBhdm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:dc4b:0:b0:3d4:346e:8d49 with SMTP id
 e9e14a558f8ab-3d47a022860mr123079055ab.9.1742117313353; Sun, 16 Mar 2025
 02:28:33 -0700 (PDT)
Date: Sun, 16 Mar 2025 02:28:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d699c1.050a0220.14e108.0065.GAE@google.com>
Subject: [syzbot] [exfat?] INFO: task hung in __blockdev_direct_IO (4)
From: syzbot <syzbot+f7d147e6db52b1e09dba@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, andy.wu@sony.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	wataru.aoyama@sony.com, x86@kernel.org, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0b46b049d6ec Merge tag 'pinctrl-v6.14-3' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14705f8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77b023e9ae0dbb6a
dashboard link: https://syzkaller.appspot.com/bug?extid=f7d147e6db52b1e09dba
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fe8c78580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10856060580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/60a27e46c709/disk-0b46b049.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e5f60f8eafb/vmlinux-0b46b049.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fad7114eecc3/bzImage-0b46b049.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/734523858dc1/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=11fe8c78580000)

The issue was bisected to:

commit f55c096f62f100aa9f5f48d86e1b6846ecbd67e7
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Tue May 30 09:35:00 2023 +0000

    exfat: do not zero the extended part

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16cbe060580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15cbe060580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11cbe060580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f7d147e6db52b1e09dba@syzkaller.appspotmail.com
Fixes: f55c096f62f1 ("exfat: do not zero the extended part")

INFO: task syz-executor324:5847 blocked for more than 143 seconds.
      Not tainted 6.14.0-rc6-syzkaller-00007-g0b46b049d6ec #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor324 state:D stack:24944 pid:5847  tgid:5845  ppid:5844   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x18bc/0x4c40 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6914
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:877 [inline]
 __blockdev_direct_IO+0x31d/0x4890 fs/direct-io.c:1140
 blockdev_direct_IO include/linux/fs.h:3412 [inline]
 exfat_direct_IO+0x151/0x400 fs/exfat/inode.c:482
 generic_file_read_iter+0x341/0x550 mm/filemap.c:2860
 copy_splice_read+0x637/0xb40 fs/splice.c:365
 do_splice_read fs/splice.c:984 [inline]
 splice_direct_to_actor+0x4fa/0xc80 fs/splice.c:1089
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x289/0x3e0 fs/splice.c:1233
 do_sendfile+0x564/0x8a0 fs/read_write.c:1363
 __do_sys_sendfile64 fs/read_write.c:1424 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1410
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fac7257a489
RSP: 002b:00007fac72510218 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fac72602618 RCX: 00007fac7257a489
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
RBP: 00007fac72602610 R08: 00007ffe20f900a7 R09: 0000000000000000
R10: 0000000800000009 R11: 0000000000000246 R12: 00007fac725cf5cc
R13: 0031656c69662f2e R14: 0000400000000240 R15: 0000400000000140
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8eb393e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8eb393e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8eb393e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6746
2 locks held by getty/5583:
 #0: ffff8880353700a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x616/0x1770 drivers/tty/n_tty.c:2211
2 locks held by syz-executor324/5846:
1 lock held by syz-executor324/5847:
 #0: ffff8880738582a0 (&sb->s_type->i_mutex_key#14){++++}-{4:4}, at: inode_lock include/linux/fs.h:877 [inline]
 #0: ffff8880738582a0 (&sb->s_type->i_mutex_key#14){++++}-{4:4}, at: __blockdev_direct_IO+0x31d/0x4890 fs/direct-io.c:1140

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.14.0-rc6-syzkaller-00007-g0b46b049d6ec #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:236 [inline]
 watchdog+0x1058/0x10a0 kernel/hung_task.c:399
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5846 Comm: syz-executor324 Not tainted 6.14.0-rc6-syzkaller-00007-g0b46b049d6ec #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:__bread_gfp+0x3b0/0x400 fs/buffer.c:1489
Code: 00 e8 74 83 db ff f0 41 ff 0e eb 17 e8 19 c2 76 ff 90 48 c7 c7 20 5e 39 8c e8 2c 7e 36 ff 90 0f 0b 90 90 45 31 ff 4c 89 f8 5b <41> 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 ed c1 76 ff eb e4 89
RSP: 0018:ffffc9000414f8f8 EFLAGS: 00000293
RAX: ffff888078fdf2b8 RBX: ffff88807e5f4160 RCX: ffff88807e950000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff824b19c1 R09: 1ffff1100f1fbe57
R10: dffffc0000000000 R11: ffffed100f1fbe58 R12: 0000000000000008
R13: ffff888148c87300 R14: 0000000000000200 R15: ffff888078fdf2b8
FS:  00007fac725316c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555590db1738 CR3: 0000000076738000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 sb_bread include/linux/buffer_head.h:346 [inline]
 __exfat_ent_get fs/exfat/fatent.c:48 [inline]
 exfat_ent_get+0x14d/0x400 fs/exfat/fatent.c:97
 exfat_find_last_cluster+0x15d/0x380 fs/exfat/fatent.c:266
 exfat_cont_expand fs/exfat/file.c:40 [inline]
 exfat_setattr+0xa8d/0x1a90 fs/exfat/file.c:295
 notify_change+0xbca/0xe90 fs/attr.c:552
 do_truncate+0x220/0x310 fs/open.c:65
 vfs_truncate+0x492/0x530 fs/open.c:115
 do_sys_truncate+0xdb/0x190 fs/open.c:138
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fac7257a489
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fac72531218 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007fac72602608 RCX: 00007fac7257a489
RDX: 00007fac7257a489 RSI: 000000000000e4c8 RDI: 0000400000000140
RBP: 00007fac72602600 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fac725cf5cc
R13: 0031656c69662f2e R14: 0000400000000240 R15: 0000400000000140
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.283 msecs


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

