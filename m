Return-Path: <linux-fsdevel+bounces-48717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18262AB32C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC513A3D0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61A825A345;
	Mon, 12 May 2025 09:11:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C22E25A2CB
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041083; cv=none; b=LL4edf+/70KAR0nQRIg+XxosYIpDFtY+JmEEdvGZ7SUQ7TlKbvgP+2qmWPE4k9N/SFYXy5vXm1P03prSpWGYXw2+q3DvcWjPDaNMtoYjq+6Ft4IcZATG8jz+McilZrc8Vopx9ck3sFeiT/OqVVmTZu4RGkKF/J0bM64AzA8BdnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041083; c=relaxed/simple;
	bh=lYVHLSFZ30uPD9HCKWzeRsxqM7TREbjRmxECdkqqcV4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QpZI5QE3EuJ08RCp8C4jmz8utIADA4qS6KNYc+ExODadmX31h40SEBAPk8cjiaTaBQWLPjWTDeVG8CrSYAz0OJVR/cO72DNkdriuhWcaTXtA6/YJ94m2ZGhgeCx+qu4ec6xWADii6HPhcRUDCVx/PeMcOnV2bW5eemKZqAp4zmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85e310ba2f9so313469839f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 02:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747041080; x=1747645880;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+uzMLrjggZhRqmqQSIictD5XwFtooJPv3otZj8Vyzk=;
        b=aye1Eb65NseMmBznZhw2Q/maJsyiZN2m5lhXS+AEuYQ5xInF5+CNFKm3y6vcPh0Ynh
         CPiKS4ObfQUHw64OprfkV5dkDtM36IoiJkVUgcbiEeHrD2R+I54SUvxek95TdXtE+zzl
         a9zo7+1B4AOE5jkZG54pGUKGbL/1ojngZaKgciSP+K0n+Cwt5OHTSZVQalKUSBTOczaW
         XjTYtWxBFqzAZr0jfHB44PlIi5Xc5gNDWIOmkkxciIu9/Euho7lqH6Eq+WsBqeDDgzQc
         Qkb6RDcRogkB1NdYB10PUmy9tUg5hiufY8ltgs46/mbAlzXHT1961G7+f+6NqXLkgX5N
         p0hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwxTTZrz0c058i1xPnZ9DEunvvsenSD4foZcwkQQ3eMoZb3XSv4nZKtE6oQyr95vkSeaeGghbVoHDR+xxi@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWQkkpuVBFpyE2pArv0X9TyeJTI1BOGWtahD+hQS/Z/LW22rE
	IZWHIls6t8rsaxVszoORVi94P6b8roWC+CV73M993+n7S/vmQU/tppR2UtohtZBPyEWy6Gfcbr7
	VASJcfE78HM/aFm5Z13Fw/4zZVQrxVX+LzkgipIhLPiLLH2+pr6Q89Lg=
X-Google-Smtp-Source: AGHT+IGMn4kHfoXlb0gHYMU6NGzwSXl9HDa5qUR8JrxhkCiq40wtClztX121VRsQGqdrm2gz/wLoGEWpUT+A2YxlmLMpznVphnxe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29d3:b0:862:fe54:df4e with SMTP id
 ca18e2360f4ac-867635af384mr1265132339f.7.1747041080644; Mon, 12 May 2025
 02:11:20 -0700 (PDT)
Date: Mon, 12 May 2025 02:11:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6821bb38.050a0220.f2294.0056.GAE@google.com>
Subject: [syzbot] [mm?] [ext4?] INFO: rcu detected stall in
 ext4_end_io_rsv_work (3)
From: syzbot <syzbot+bb842a51b5abbae5a245@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    707df3375124 Merge tag 'media/v6.15-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c2a82f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b39cb28b0a399ed3
dashboard link: https://syzkaller.appspot.com/bug?extid=bb842a51b5abbae5a245
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1050b8f4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a169b3980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1920aeaaff98/disk-707df337.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5a54d789a59a/vmlinux-707df337.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e40767312770/bzImage-707df337.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb842a51b5abbae5a245@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (3 ticks this GP) idle=1d3c/1/0x4000000000000000 softirq=14732/14732 fqs=0
rcu: 	(detected by 1, t=10502 jiffies, g=6677, q=10638 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 3557 Comm: kworker/u8:8 Not tainted 6.15.0-rc5-syzkaller-00038-g707df3375124 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work
RIP: 0010:__kasan_check_write+0x8/0x20 mm/kasan/shadow.c:37
Code: f0 ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 0c 24 <89> f6 ba 01 00 00 00 e9 4c f0 ff ff 66 66 2e 0f 1f 84 00 00 00 00
RSP: 0018:ffffc90000007da0 EFLAGS: 00000086
RAX: 0000000000000000 RBX: ffff8880b8427840 RCX: ffffffff81985b4d
RDX: 00000000ffffffff RSI: 0000000000000004 RDI: ffff8880b8427840
RBP: 1ffff92000000fb6 R08: 4d4df099ab2b819a R09: 0000000000000001
R10: 0000000000000002 R11: 0000000000000000 R12: ffff8880b8427848
R13: ffff8880b8427850 R14: ffff888070874340 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8881249df000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558c02f650 CR3: 000000000e180000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1300 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
 do_raw_spin_lock+0x11d/0x2b0 kernel/locking/spinlock_debug.c:116
 __run_hrtimer kernel/time/hrtimer.c:1765 [inline]
 __hrtimer_run_queues+0x2bc/0xad0 kernel/time/hrtimer.c:1825
 hrtimer_interrupt+0x397/0x8e0 kernel/time/hrtimer.c:1887
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x108/0x3f0 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x9f/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:folio_zone include/linux/mm.h:1967 [inline]
RIP: 0010:zone_stat_mod_folio include/linux/vmstat.h:432 [inline]
RIP: 0010:__folio_end_writeback+0x186/0xe60 mm/page-writeback.c:3068
Code: 89 e2 be 15 00 00 00 48 89 df e8 05 0b 33 00 9c 5d 81 e5 00 02 00 00 31 ff 48 89 ee e8 73 50 c5 ff 48 85 ed 0f 85 90 07 00 00 <e8> f5 54 c5 ff 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03
RSP: 0018:ffffc9000cea7950 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffffea0001f6ec40 RCX: ffffffff81f5e1a4
RDX: ffff888032bb2440 RSI: ffffffff81f5e1b2 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00000000ffffffff
R13: 0000000000000001 R14: ffffffffffffffff R15: ffffea0001f6ec00
 folio_end_writeback+0x18f/0x560 mm/filemap.c:1648
 ext4_finish_bio+0x78f/0xa20 fs/ext4/page-io.c:144
 ext4_release_io_end+0x119/0x3a0 fs/ext4/page-io.c:159
 ext4_end_io_end+0x13e/0x4a0 fs/ext4/page-io.c:210
 ext4_do_flush_completed_IO fs/ext4/page-io.c:287 [inline]
 ext4_end_io_rsv_work+0x205/0x380 fs/ext4/page-io.c:302
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10501 jiffies! g6677 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=0 timer-softirq=4991
rcu: rcu_preempt kthread starved for 10502 jiffies! g6677 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:28728 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x116f/0x5de0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6860
 schedule_timeout+0x123/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x1ea/0xb00 kernel/rcu/tree.c:2046
 rcu_gp_kthread+0x270/0x380 kernel/rcu/tree.c:2248
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
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

