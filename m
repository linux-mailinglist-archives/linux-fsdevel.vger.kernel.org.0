Return-Path: <linux-fsdevel+bounces-9089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C09283E134
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 19:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDE428374C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 18:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396A520DC1;
	Fri, 26 Jan 2024 18:22:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF5920326
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293353; cv=none; b=kIRPCggVWg0HMDzL5GtrByW0/ds68jVv/s64rUml7CBA5YR5N62esAGWEokebzZbCS0giTbMKXebWIAJs8f+iaK5wyidDD8v4oFVzUF961DbXvCwveYU5gxHO/1+VKClsOCqsyUA9FC89yD5ieMKm9wqiripOiSryw1/jfQNz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293353; c=relaxed/simple;
	bh=lbYZqse5A2r0wmej3o/muSShPjIO2vTdu3JPxivc29s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jBvgLzVlTOnX6C2sE047vy7Aa3oRyuOuNqg5hctunSthqE0YKfNXQxPN9aHJEL8jrwI7IwU6SVFzUHsCRKV6a1Hal97rCNxwxOFmRWmsjBJyzPNdY+GQDYs7xIWimNpUsIkgGYdAhTfF996gwkxdWZ+bH32PMrypjXQyVL8RXbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-361b0f701c4so2112895ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 10:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293350; x=1706898150;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MrHzjykk2bLYCe3d6im839iujm3tLVuO8ZZkUDUnTOw=;
        b=lUAmXAngKRnQ0zC170laOw1P04B+brF1hdiRTNZhdmgOZAhh1DQ9YWvyverFLvVPXR
         UWk4MfVfCFQL9I8XaJUqyvgPNGs1RmrhaM2RULwParjaaw/E/Mm+3l6vTq/XrZl4b2QC
         zUUNh8cw0LlVCd+E7peJt7c2nvIiVWyzl/sr0G90iMdXUIkSvyv811tE+phOwWPfN4rF
         4nZkM8zxERU/K8IHgIKuTsbOlO699qOa0gbdrQix7kgv93/C5QzQNDS4bT6GhA6C3AVP
         N90bmFFsX8mMz75cGOIzg7O6m3N7VXZks8tvlUKh4hk1Vqtlz1QasuuktFCN7//++2l/
         fWJQ==
X-Gm-Message-State: AOJu0Yy/oKYxf70rn7/aqC1hLumwsIptuU8HQ7RKFYMxojNngJzRIQZs
	5AG164L3IhiGnBvaeG1E3CAuK1/wAE9SvpAssrk4BHUPUv37jYjwPlhmLnP4nk1ZEIKEuyWuM0X
	N5zWY4ZgsOzjqyKAkVCt+uf6LAxP877ED2arCHoFOsnVNMmYNCJTLthc=
X-Google-Smtp-Source: AGHT+IFCs4t9UGdtqhRludE1iMf+LO2H+jHoUJ1vfX7rX1jun+gqmWdfpKYyDKLiabMHbUYvanDQ9YlHqoWOS9HdDryY/neB9Uga
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1808:b0:35f:8652:5ce8 with SMTP id
 a8-20020a056e02180800b0035f86525ce8mr16317ilv.4.1706293350303; Fri, 26 Jan
 2024 10:22:30 -0800 (PST)
Date: Fri, 26 Jan 2024 10:22:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000711c1060fdd61f0@google.com>
Subject: [syzbot] [ntfs?] INFO: task hung in ntfs_evict_big_inode
From: syzbot <syzbot+826187129aa8a9eb81be@syzkaller.appspotmail.com>
To: anton@tuxera.com, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6613476e225e Linux 6.8-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118c81d7e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9804db253bdfc61
dashboard link: https://syzkaller.appspot.com/bug?extid=826187129aa8a9eb81be
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f0127de80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb2c4c0bff80/disk-6613476e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8243d7a3c960/vmlinux-6613476e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c964733b4579/bzImage-6613476e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e864c702c7ef/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+826187129aa8a9eb81be@syzkaller.appspotmail.com

INFO: task syz-executor.0:5122 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:23936 pid:5122  tgid:5122  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 io_schedule+0xbe/0x130 kernel/sched/core.c:9023
 folio_wait_bit_common+0x3dc/0x9c0 mm/filemap.c:1274
 __folio_lock mm/filemap.c:1612 [inline]
 folio_lock include/linux/pagemap.h:1048 [inline]
 folio_lock include/linux/pagemap.h:1044 [inline]
 __filemap_get_folio+0x633/0xaa0 mm/filemap.c:1865
 truncate_inode_pages_range+0x3a0/0xf00 mm/truncate.c:367
 ntfs_evict_big_inode+0x32/0x530 fs/ntfs/inode.c:2251
 evict+0x2ed/0x6b0 fs/inode.c:665
 dispose_list+0x117/0x1e0 fs/inode.c:698
 evict_inodes+0x34f/0x450 fs/inode.c:748
 generic_shutdown_super+0xb5/0x3d0 fs/super.c:631
 kill_block_super+0x3b/0x90 fs/super.c:1680
 deactivate_locked_super+0xbc/0x1a0 fs/super.c:477
 deactivate_super+0xde/0x100 fs/super.c:510
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:108 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x281/0x2b0 kernel/entry/common.c:212
 do_syscall_64+0xe0/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fe0cbc7e0d7
RSP: 002b:00007ffd97c22638 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fe0cbc7e0d7
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffd97c226f0
RBP: 00007ffd97c226f0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd97c237b0
R13: 00007fe0cbcc83b9 R14: 00000000000ffd2a R15: 0000000000000005
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8d1acba0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8d1acba0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8d1acba0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
2 locks held by klogd/4498:
 #0: ffff8880b983ccd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
 #1: ffff8880b9828a08 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:988
2 locks held by getty/4810:
 #0: ffff88802965f0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000311b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
1 lock held by syz-executor.0/5122:
 #0: ffff88805f1800e0 (&type->s_umount_key#48){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88805f1800e0 (&type->s_umount_key#48){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88805f1800e0 (&type->s_umount_key#48){+.+.}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:509

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf87/0x1210 kernel/hung_task.c:379
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5143 Comm: kworker/u4:0 Not tainted 6.8.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:check_preemption_disabled+0x4/0xe0 lib/smp_processor_id.c:13
Code: 85 c0 74 1a 65 8b 05 73 73 74 75 85 c0 75 0f 65 8b 05 7c 70 74 75 85 c0 74 04 90 0f 0b 90 e9 83 fc ff ff 0f 1f 00 41 54 55 53 <48> 83 ec 08 65 8b 1d 8d aa 75 75 65 8b 05 82 aa 75 75 a9 ff ff ff
RSP: 0018:ffffc900048af8f8 EFLAGS: 00000046
RAX: a6d04142908fb997 RBX: ffff888028e93b80 RCX: 1ffffffff242ab72
RDX: 0000000000000000 RSI: ffffffff8accade0 RDI: ffffffff8b2fd140
RBP: ffffffff817c6a23 R08: 0000000000000001 R09: fffffbfff242a9e8
R10: ffffffff92154f47 R11: 0000000000000006 R12: 0000000000000002
R13: ffffffff817c6e50 R14: ffffffff812ff380 R15: ffff8880b983de80
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe6542c2f8 CR3: 000000000cf78000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lockdep_hardirqs_on+0x7d/0x110 kernel/locking/lockdep.c:4421
 smp_call_function_many_cond+0x1223/0x1550 kernel/smp.c:847
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2087 [inline]
 text_poke_bp_batch+0x22b/0x750 arch/x86/kernel/alternative.c:2297
 text_poke_flush arch/x86/kernel/alternative.c:2488 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2485 [inline]
 text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2495
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x1d7/0x400 kernel/jump_label.c:829
 static_key_disable_cpuslocked+0x154/0x1c0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate mm/kfence/core.c:831 [inline]
 toggle_allocation_gate+0x13f/0x250 mm/kfence/core.c:818
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


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

