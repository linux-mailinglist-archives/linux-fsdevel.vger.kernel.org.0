Return-Path: <linux-fsdevel+bounces-74817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHd0K9mPcGkaYgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 09:35:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD9153A75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 09:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 370EC7C67C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5533815F3;
	Wed, 21 Jan 2026 08:28:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D951630E0F4
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984105; cv=none; b=g/b34WjtRZBhmK1EggUxrATOKx9CIoFQcFAQ4kWjkkq4X1UbfzAm+TY8urgDh1uRtUM5fAi2N1BOw69hXh1lRWvDUNkzZ8fUNssb/Ft+ooouBlsTr5xw8K/J0Dr5zt0VbZTL/BeroPn+FrNWTgA/qc38yeZHd9EK1c7vO7XLBxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984105; c=relaxed/simple;
	bh=rfRaJi4Tx7sKeA43SsqDEfWYiZRK/YUm+TAxsizoK9c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gcj0gLO1JHXmBrpPa4/X9FW8kd6toUOg9sFn4E+FvNGuSx9Dpren9Cq9IkxhZY3HBatCiSvOPrjdTZ3KrYVWtek1KQbibPCzIjekGrSeKzFaYp9i/uvrdGINekStroaindyQ/yRx7BQiE4SCVGvJ5BdIpZNdTnTk79+miVKxgQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-661125c8491so2837444eaf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 00:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768984103; x=1769588903;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxfWrgxPshYLoeiTcgY5TyfwM7o/XTnpVYAYtYI9tw8=;
        b=qnNFjZnfxaHL8aOFebCmHkojyQeA9+tBmiGtJOspn+9Y1NHdOkbggKzK0JSi4StcSW
         7NyCmONirxMPCAsf6Ger7a041pB8sFrp6KCtKJ47z8VSzwzWHKPoT1dtEH13elfCHYT3
         BECpXsxesha+s92nzcQxmfDQ2GabgHe5C8Pafq7oqqviHHhvCBPEtU6EjxsaxPMb0eNR
         qTQ7hFNansx37Md5j/+fYY742k0Pf0rjRy8EWKClH9XGYypNbdkwzPL0sUFqisda5bF5
         O29ny6QfC13jYImR2CjbuRzMlW1gDhPV6EhAufDSMn6U+FlF8mjnuJ+kcpRZcwj18Qxr
         l3KQ==
X-Gm-Message-State: AOJu0YybPcht1AxwzYO8GDNNUvpdpLLCy5dw0qK0oIFwZgwaHZo30EPy
	jyy7Lgxg9A8ETetyc7lXN3rAI5rBCcrQUXYTHyc//vyUFbJ/LRSKU+m3neN9n2FJI+hyAPalpvb
	s9ftjzTv7kvPDE3rAf8b8E9c5ewMdTvqZe3owW+dq9EW32myDQQYwOtg5ODYC0w==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c81:b0:659:9a49:8f04 with SMTP id
 006d021491bc7-662affaeebbmr1747663eaf.21.1768984102808; Wed, 21 Jan 2026
 00:28:22 -0800 (PST)
Date: Wed, 21 Jan 2026 00:28:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69708e26.050a0220.706b.000e.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in proc_invalidate_siblings_dcache
 (2)
From: syzbot <syzbot+e8b3520b53e78e90034e@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=88cadb2aebdef7ea];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-74817-lists,linux-fsdevel=lfdr.de,e8b3520b53e78e90034e];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,storage.googleapis.com:url,googlegroups.com:email,goo.gl:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Queue-Id: 1CD9153A75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    8f0b4cce4481 Linux 6.19-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1251239a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88cadb2aebdef7ea
dashboard link: https://syzkaller.appspot.com/bug?extid=e8b3520b53e78e90034e
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-8f0b4cce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4c3ed9ab2bac/vmlinux-8f0b4cce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e55c5b55f4c6/Image-8f0b4cce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8b3520b53e78e90034e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in proc_invalidate_siblings_dcache+0x6ae/0x6bc fs/proc/inode.c:114
Read of size 8 at addr ffffaf801aba9a18 by task sshd/3175

CPU: 0 UID: 0 PID: 3175 Comm: sshd Not tainted syzkaller #0 PREEMPT 
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8007b93e>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:149
[<ffffffff80003346>] show_stack+0x30/0x3c arch/riscv/kernel/stacktrace.c:155
[<ffffffff80061ac0>] __dump_stack lib/dump_stack.c:94 [inline]
[<ffffffff80061ac0>] dump_stack_lvl+0x12a/0x1a2 lib/dump_stack.c:120
[<ffffffff8000d85c>] print_address_description mm/kasan/report.c:378 [inline]
[<ffffffff8000d85c>] print_report+0x28c/0x59e mm/kasan/report.c:482
[<ffffffff80b7b6f8>] kasan_report+0xf0/0x218 mm/kasan/report.c:595
[<ffffffff80b7d70e>] __asan_report_load8_noabort+0x12/0x1a mm/kasan/report_generic.c:381
[<ffffffff80edbd4c>] proc_invalidate_siblings_dcache+0x6ae/0x6bc fs/proc/inode.c:114
[<ffffffff80ef0fe0>] proc_flush_pid+0x20/0x2a fs/proc/base.c:3478
[<ffffffff8015b7f6>] release_task+0xc26/0x1908 kernel/exit.c:291
[<ffffffff8015dc9c>] wait_task_zombie kernel/exit.c:1274 [inline]
[<ffffffff8015dc9c>] wait_consider_task+0x17c4/0x3922 kernel/exit.c:1501
[<ffffffff8016375c>] do_wait_thread kernel/exit.c:1564 [inline]
[<ffffffff8016375c>] __do_wait+0x1b2/0x7ba kernel/exit.c:1682
[<ffffffff80163f7c>] do_wait+0x218/0x6d0 kernel/exit.c:1716
[<ffffffff801658ae>] kernel_wait4+0x188/0x5b6 kernel/exit.c:1875
[<ffffffff80165e32>] __do_sys_wait4+0x156/0x162 kernel/exit.c:1903
[<ffffffff801661b2>] __se_sys_wait4 kernel/exit.c:1899 [inline]
[<ffffffff801661b2>] __riscv_sys_wait4+0x8a/0xd6 kernel/exit.c:1899
[<ffffffff800789d8>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
[<ffffffff86662f6e>] do_trap_ecall_u+0x3d8/0x56c arch/riscv/kernel/traps.c:343
[<ffffffff8668cf0e>] handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:198

Allocated by task 3175:
 stack_trace_save+0xa0/0xd2 kernel/stacktrace.c:122
 kasan_save_stack+0x3e/0x6a mm/kasan/common.c:56
 kasan_save_track+0x16/0x28 mm/kasan/common.c:77
 kasan_save_alloc_info+0x30/0x3e mm/kasan/generic.c:570
 unpoison_slab_object mm/kasan/common.c:339 [inline]
 __kasan_slab_alloc+0x7c/0x82 mm/kasan/common.c:365
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_noprof+0x1f6/0x80e mm/slub.c:5270
 alloc_pid+0xd8/0x12fe kernel/pid.c:183
 copy_process+0x408e/0x748e kernel/fork.c:2237
 kernel_clone+0x128/0xdb0 kernel/fork.c:2651
 __do_sys_clone+0xfe/0x13e kernel/fork.c:2792
 __se_sys_clone kernel/fork.c:2760 [inline]
 __riscv_sys_clone+0xa0/0x10e kernel/fork.c:2760
 syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
 do_trap_ecall_u+0x3d8/0x56c arch/riscv/kernel/traps.c:343
 handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:198

Freed by task 3190:
 stack_trace_save+0xa0/0xd2 kernel/stacktrace.c:122
 kasan_save_stack+0x3e/0x6a mm/kasan/common.c:56
 kasan_save_track+0x16/0x28 mm/kasan/common.c:77
 kasan_save_free_info+0x40/0x5a mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5e/0x7e mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6668 [inline]
 kmem_cache_free+0x300/0x882 mm/slub.c:6779
 put_pid.part.0+0x104/0x144 kernel/pid.c:100
 put_pid+0x24/0x36 kernel/pid.c:94
 proc_free_inode+0x4a/0xbc fs/proc/inode.c:76
 i_callback+0x42/0x8e fs/inode.c:325
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xa36/0x1ed2 kernel/rcu/tree.c:2857
 rcu_core_si+0xc/0x14 kernel/rcu/tree.c:2874
 handle_softirqs+0x4b6/0x1336 kernel/softirq.c:622
 __do_softirq+0x12/0x1a kernel/softirq.c:656

Last potentially related work creation:
 stack_trace_save+0xa0/0xd2 kernel/stacktrace.c:122
 kasan_save_stack+0x3e/0x6a mm/kasan/common.c:56
 kasan_record_aux_stack+0x114/0x160 mm/kasan/generic.c:556
 __call_rcu_common.constprop.0+0x9e/0x9de kernel/rcu/tree.c:3119
 call_rcu+0xc/0x14 kernel/rcu/tree.c:3239
 free_pid+0x278/0x354 kernel/pid.c:147
 free_pids+0x4c/0x8a kernel/pid.c:159
 release_task+0xc3e/0x1908 kernel/exit.c:295
 wait_task_zombie kernel/exit.c:1274 [inline]
 wait_consider_task+0x17c4/0x3922 kernel/exit.c:1501
 do_wait_thread kernel/exit.c:1564 [inline]
 __do_wait+0x1b2/0x7ba kernel/exit.c:1682
 do_wait+0x218/0x6d0 kernel/exit.c:1716
 kernel_wait4+0x188/0x5b6 kernel/exit.c:1875
 __do_sys_wait4+0x156/0x162 kernel/exit.c:1903
 __se_sys_wait4 kernel/exit.c:1899 [inline]
 __riscv_sys_wait4+0x8a/0xd6 kernel/exit.c:1899
 syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
 do_trap_ecall_u+0x3d8/0x56c arch/riscv/kernel/traps.c:343
 handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:198

The buggy address belongs to the object at ffffaf801aba9980
 which belongs to the cache pid of size 272
The buggy address is located 152 bytes inside of
 freed 272-byte region [ffffaf801aba9980, ffffaf801aba9a90)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9aba8
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xffe000000000040(head|node=0|zone=0|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 0ffe000000000040 ffffaf8012293780 ffff8d80006ec800 dead000000000002
raw: 0000000000000000 0000000000150015 00000000f5000000 0000000000000000
head: 0ffe000000000040 ffffaf8012293780 ffff8d80006ec800 dead000000000002
head: 0000000000000000 0000000000150015 00000000f5000000 0000000000000000
head: 0ffe000000000001 ffff8d80006aea01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 12, tgid 12 (kworker/u8:0), ts 64693088700, free_ts 0
 __set_page_owner+0x94/0x4c4 mm/page_owner.c:341
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfc/0x1c4 mm/page_alloc.c:1846
 prep_new_page mm/page_alloc.c:1854 [inline]
 get_page_from_freelist+0x8e0/0x36b0 mm/page_alloc.c:3915
 __alloc_frozen_pages_noprof+0x22e/0x211a mm/page_alloc.c:5210
 alloc_pages_mpol+0x1fa/0x5be mm/mempolicy.c:2486
 alloc_frozen_pages_noprof+0x174/0x2f0 mm/mempolicy.c:2557
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab mm/slub.c:3248 [inline]
 new_slab+0x370/0x438 mm/slub.c:3302
 ___slab_alloc+0xda6/0x1a3c mm/slub.c:4656
 __slab_alloc.constprop.0+0x72/0x118 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 kmem_cache_alloc_noprof+0x334/0x80e mm/slub.c:5270
 alloc_pid+0xd8/0x12fe kernel/pid.c:183
 copy_process+0x408e/0x748e kernel/fork.c:2237
 kernel_clone+0x128/0xdb0 kernel/fork.c:2651
 user_mode_thread+0xd0/0x10c kernel/fork.c:2727
 call_usermodehelper_exec_work kernel/umh.c:171 [inline]
 call_usermodehelper_exec_work+0xd4/0x1ac kernel/umh.c:157
 process_one_work+0x96a/0x1f3a kernel/workqueue.c:3257
page_owner free stack trace missing

Memory state around the buggy address:
 ffffaf801aba9900: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffffaf801aba9980: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffffaf801aba9a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffffaf801aba9a80: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffffaf801aba9b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


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

