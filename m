Return-Path: <linux-fsdevel+bounces-78716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEmSF/igoWnEvAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 14:49:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A901B7E30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 14:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9300030419EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3123F23BA;
	Fri, 27 Feb 2026 13:49:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1D26B777
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200174; cv=none; b=R6fKbT/vwE+HTDwHplgpqVKVsyTiIWiO2QGeBlPelAZOQGThee9CublaCEdULHKE0w5XkLbDeePW0sMXdHiKfsfKcZHE79sV2/LMM1zg2jcFKrr8eeijij/dcnvjFwUlvP7r3gy+qzdfcLKL4aWi029IIVWZwiA1oBrcSfzbBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200174; c=relaxed/simple;
	bh=YMDMC8FEVtqZlH7IsvBTLPfDjmYHZyM6F6jDfk2fB5w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E+mfOmahGZN0VoU0bYPBRLywrLfNGCXc+j4lph9YiaRInUiMci5fEirQph70xFYyZ57dKrdY9Q5Sp37I2gQlAGe6TFSiehJBPwR1PW9byCRPbucvfI4UVbzGgCSYMfuI+WApJtPaR90/rT5laViTbzP7yiVSpiCt73JHNOTEEGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679f6f264ceso20968748eaf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 05:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772200171; x=1772804971;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t9GvV4edThET8ZS8pVmyfj1XanVmMwu7Dpx+u7H+L3Q=;
        b=CIhi3+b6o3egyffkJtGXcVsz85fzeQujg6rEyJT61TGoc/v8DqCgIfhM5FEpNe/nBW
         RtS7VWj6Qv1CP9HLnx/fqb6HV5YJ7+gNAuio8LQtVUjGiulVIAa4UivHfrRCyf+uqZ1M
         dovnMrRcnC8kI4kvm28R2lYG5xqqSipd6hnPEXiRcZIC9IOlgnpA3sua/MYnLe56J9BR
         njwLSHcxmZiOzmBC5LoYN6ydepojJdhIDJctc6x7quGmAjDh+O3gjNBita9Gs7AsZkSL
         SZJV5kySB6wUWWpzxreO22cNgvXKIS3AinNjks5bMb8FDBP4LkAMHAQQPUktk1ZCmIn1
         xHWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwvwFlsvq72TEGfqRDhkUFzXdObJPnaWNb/yvHzW8BNOlrbZTM8JEYNynWDjXHN1TEzJJCh0yWYpjpC86U@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9rqarq19aVCLY2WJLuUADZmn7GASZhJFr8JkVMpv7/eYHDLI
	XbNOf2c0RuBYOvaDsC94+E44b7uVEi4Gd7qT/P+doL+lJiz9gZ9heH1DsgMPL5Af7W6o+tcbpGJ
	9Q/RqjY1iQ7MEM8ei0iSpSXOKvLaOJ/09Vdfqm57dAsuaUsU5sn8Glq96PRo=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4410:b0:679:8a47:abab with SMTP id
 006d021491bc7-679faf8a790mr1482868eaf.71.1772200171470; Fri, 27 Feb 2026
 05:49:31 -0800 (PST)
Date: Fri, 27 Feb 2026 05:49:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a1a0eb.050a0220.3a55be.0021.GAE@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in filename_rmdir
From: syzbot <syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d91443204e48b7a1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-78716-lists,linux-fsdevel=lfdr.de,512459401510e2a9a39f];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,goo.gl:url,storage.googleapis.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 86A901B7E30
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    6de23f81a5e0 Linux 7.0-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176ad9e6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d91443204e48b7a1
dashboard link: https://syzkaller.appspot.com/bug?extid=512459401510e2a9a39f
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14630202580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11dd4006580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a3fcd7d8bed6/disk-6de23f81.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4956764f8450/vmlinux-6de23f81.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9f8616ac66b/bzImage-6de23f81.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6c600d0e3ce2/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=1779655a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com

INFO: task syz.0.17:5981 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:29024 pid:5981  tgid:5976  ppid:5922   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x14fb/0x52c0 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7285
 rt_mutex_slowlock_block kernel/locking/rtmutex.c:1647 [inline]
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked+0x1f8f/0x25c0 kernel/locking/rtmutex.c:1760
 rt_mutex_slowlock+0xbd/0x170 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 rwbase_write_lock+0x14d/0x730 kernel/locking/rwbase_rt.c:244
 inode_lock_nested include/linux/fs.h:1073 [inline]
 __start_dirop fs/namei.c:2923 [inline]
 start_dirop fs/namei.c:2934 [inline]
 filename_rmdir+0x1cd/0x520 fs/namei.c:5386
 __do_sys_rmdir fs/namei.c:5416 [inline]
 __se_sys_rmdir+0x2e/0x140 fs/namei.c:5413
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd6182ac629
RSP: 002b:00007fd6178e5028 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 00007fd618526090 RCX: 00007fd6182ac629
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000000c0
RBP: 00007fd618342b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd618526128 R14: 00007fd618526090 R15: 00007fff2f2a73b8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/37:
 #0: ffffffff8ddcd780 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #0: ffffffff8ddcd780 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #0: ffffffff8ddcd780 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by kworker/u8:3/58:
3 locks held by kworker/1:2/863:
 #0: ffff888019c03d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3250 [inline]
 #0: ffff888019c03d38 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9ea/0x1830 kernel/workqueue.c:3358
 #1: ffffc90004ca7c40 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3251 [inline]
 #1: ffffc90004ca7c40 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_scheduled_works+0xa25/0x1830 kernel/workqueue.c:3358
 #2: ffff88805aa3e260 (&data->fib_lock){+.+.}-{4:4}, at: nsim_fib_event_work+0x222/0x3e0 drivers/net/netdevsim/fib.c:1490
2 locks held by getty/5552:
 #0: ffff8880370f50a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003e8b2e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x462/0x13c0 drivers/tty/n_tty.c:2211
6 locks held by syz.0.17/5977:
2 locks held by syz.0.17/5981:
 #0: ffff88803704c480 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:493
 #1: ffff8880445acbf0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff8880445acbf0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2923 [inline]
 #1: ffff8880445acbf0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2934 [inline]
 #1: ffff8880445acbf0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_rmdir+0x1cd/0x520 fs/namei.c:5386
5 locks held by syz.1.18/6004:
2 locks held by syz.1.18/6008:
 #0: ffff888027ddc480 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:493
 #1: ffff88805812b430 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff88805812b430 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2923 [inline]
 #1: ffff88805812b430 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2934 [inline]
 #1: ffff88805812b430 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_rmdir+0x1cd/0x520 fs/namei.c:5386
7 locks held by syz.2.19/6030:
2 locks held by syz.2.19/6034:
 #0: ffff888036f74480 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:493
 #1: ffff8880581c6f90 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff8880581c6f90 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2923 [inline]
 #1: ffff8880581c6f90 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2934 [inline]
 #1: ffff8880581c6f90 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_rmdir+0x1cd/0x520 fs/namei.c:5386
8 locks held by syz.3.20/6059:
2 locks held by syz.3.20/6063:
 #0: ffff88803c04c480 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:493
 #1: ffff88804005c010 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff88804005c010 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2923 [inline]
 #1: ffff88804005c010 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2934 [inline]
 #1: ffff88804005c010 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_rmdir+0x1cd/0x520 fs/namei.c:5386
7 locks held by syz.4.21/6098:
2 locks held by syz.4.21/6102:
 #0: ffff88803297c480 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:493
 #1: ffff88805812e3b0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff88805812e3b0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2923 [inline]
 #1: ffff88805812e3b0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2934 [inline]
 #1: ffff88805812e3b0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_rmdir+0x1cd/0x520 fs/namei.c:5386
7 locks held by syz.5.22/6133:
2 locks held by syz.5.22/6137:
 #0: ffff88805b0a8480 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:493
 #1: ffff888058311c70 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff888058311c70 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2923 [inline]
 #1: ffff888058311c70 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2934 [inline]
 #1: ffff888058311c70 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_rmdir+0x1cd/0x520 fs/namei.c:5386
2 locks held by syz.6.23/6167:
 #0: ffff88805e904480 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:493
 #1: ffff888044774bf0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff888044774bf0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2923 [inline]
 #1: ffff888044774bf0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2934 [inline]
 #1: ffff888044774bf0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_rmdir+0x1cd/0x520 fs/namei.c:5386
7 locks held by syz.6.23/6172:
2 locks held by syz-executor/6180:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 37 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:161 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
 watchdog+0xfd9/0x1030 kernel/hung_task.c:515
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 58 Comm: kworker/u8:3 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Workqueue: bat_events batadv_dat_purge
RIP: 0010:__lock_acquire+0x273/0x2cf0 kernel/locking/lockdep.c:-1
Code: e8 f2 93 39 03 4d 89 f1 48 8b 74 24 18 44 8b 74 24 20 48 83 bc 24 20 01 00 00 00 0f 85 ce fe ff ff 44 89 74 24 20 44 89 3c 24 <8b> bc 24 38 01 00 00 4c 8b 84 24 28 01 00 00 4c 8b 74 24 08 4d 8d
RSP: 0018:ffffc9000124f800 EFLAGS: 00000046
RAX: 0000000000000113 RBX: 0000000000000000 RCX: ffffffff92f693f0
RDX: 0000000000000005 RSI: 000000000000000b RDI: ffffffff8ddcd780
RBP: 0000000000000005 R08: 0000000000000000 R09: ffffffff8ddcd780
R10: dffffc0000000000 R11: fffffbfff1ed44b7 R12: 0000000000000000
R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888126443000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe67c399068 CR3: 0000000039862000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
 rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 rcu_read_lock include/linux/rcupdate.h:850 [inline]
 __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 rt_spin_lock+0x1fc/0x400 kernel/locking/spinlock_rt.c:57
 spin_lock_bh include/linux/spinlock_rt.h:90 [inline]
 __batadv_dat_purge+0x131/0x400 net/batman-adv/distributed-arp-table.c:173
 batadv_dat_purge+0x20/0x70 net/batman-adv/distributed-arp-table.c:204
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

