Return-Path: <linux-fsdevel+bounces-38403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CF4A01CFB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 02:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194B43A186C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 01:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDD670808;
	Mon,  6 Jan 2025 01:15:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821DE7080C
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 01:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736126126; cv=none; b=GOBOd2hjXF5zE2DZRlE6OhqZOrA+a05sSrEXMpK3bWLfzHyzIVXJlvKcF9WLZqTbaHDtnG65K3j5wSdoiDOgQNdo9LZiYv4lCLCVamRTGAU5wV3XCVFHQTbuDBabihxGt17CgLGxvRZ9n1WC+WctIrzbh0iajhTOdMcjZ7feEic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736126126; c=relaxed/simple;
	bh=1xjfKxZvqCmLacTNjvs/TfPlkQlPaf63liDJLgPAKG0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QBxiJ/rkJMMcAsIpYa+ARZ1AeEIEvwhJ5wJHoWkBcW8mhQOljXM51RCsX08z3jJo3rm49pgV8/SdyNmtKUBMhX+Jtp/IHUElCElm0eeMw9usEtdsN/GnvCgYphHx/qlytX+ZOdN6eWOzR/J5VRX/OXz5A7ruepY/3j8rQXYfm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3cca581135dso107202005ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jan 2025 17:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736126123; x=1736730923;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmZyVNagGsWBkLh62X+tvTSjd+mpUd721wmAceQ0YdA=;
        b=aOcqP9nSUaTxnS7r/3VkCcA38i07F9QcnNrAZSEjq4f87957bAm2faaIpMm4vu4yR6
         m/Acf/cxsuMuQF8J5zV/9JLnuo+lS8TXair5fcy8ZHJ2SlOffsrpr0tilj9BOFd0j976
         O7OptW5wHU9sXiXtMjj8u0KUQ9TRL93gX+s+Hg0Nm6FtVhLv1bYQElZ/SF1Fe7xUmuGH
         pz1tn8le0mwCQs58cUbHmRU+eko8p326u+Ewh32kg35BW1rqdHWv6OpxWpfCxtTRTp98
         I7DHIUjEYYR06TkkpqjyLxVli16NuTF/p5QlKiU6b6S+XR9sjIDTD7wzzPCwKqjSpRTf
         2fcQ==
X-Gm-Message-State: AOJu0YxcOceBdLVS2O/aEmDnpwcxFZd7Pbx57iNzwe49szxMIYoTeVo9
	2j/g5czvMECqAsUuWxMUI6DD7/LIWgFQr1AyhT215g8VUH4W0UTYzjs5j/S8ZUXNGE0zXk0cAdU
	YwXB8EpDIGoDdFWYFjxVEcY3+OsaoyH2nZjfhWLvNIKm7CgjBvYtDCAuQGg==
X-Google-Smtp-Source: AGHT+IFC1Fmp3yBG5ypV51A4hj8NhQo8TO9Vv+VVZs+LLfo/jFZt6K2NMqzZPdeoH/AEX5+lTblUBeBIHt++80kvoOgQy72JOcQG
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219c:b0:3a7:a2c6:e6d1 with SMTP id
 e9e14a558f8ab-3c2d5151ee6mr482293225ab.16.1736126123485; Sun, 05 Jan 2025
 17:15:23 -0800 (PST)
Date: Sun, 05 Jan 2025 17:15:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677b2eab.050a0220.3b53b0.0062.GAE@google.com>
Subject: [syzbot] [fuse?] KASAN: out-of-bounds Read in proc_pid_stack
From: syzbot <syzbot+2886d86a850adcd36196@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    21f1b85c8912 riscv: mm: Do not call pmd dtor on vmemmap pa..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=176939c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90afd41d36b4291d
dashboard link: https://syzkaller.appspot.com/bug?extid=2886d86a850adcd36196
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1281d6f8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-21f1b85c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/69f16f8d759e/vmlinux-21f1b85c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1e170e1b7a02/Image-21f1b85c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2886d86a850adcd36196@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: out-of-bounds in walk_stackframe+0x3f0/0x452 arch/riscv/kernel/stacktrace.c:66
Read of size 8 at addr ff20000001f17d68 by task syz.3.225/5073

CPU: 0 UID: 0 PID: 5073 Comm: syz.3.225 Not tainted 6.13.0-rc2-syzkaller-g21f1b85c8912 #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff80071bae>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:130
[<ffffffff8000325c>] show_stack+0x30/0x3c arch/riscv/kernel/stacktrace.c:136
[<ffffffff8005e1f4>] __dump_stack lib/dump_stack.c:94 [inline]
[<ffffffff8005e1f4>] dump_stack_lvl+0x12e/0x1a6 lib/dump_stack.c:120
[<ffffffff8000d250>] print_address_description mm/kasan/report.c:378 [inline]
[<ffffffff8000d250>] print_report+0x28e/0x5a8 mm/kasan/report.c:489
[<ffffffff80a1a0fe>] kasan_report+0xec/0x118 mm/kasan/report.c:602
[<ffffffff80a1bf64>] __asan_report_load8_noabort+0x12/0x1a mm/kasan/report_generic.c:381
[<ffffffff8007178a>] walk_stackframe+0x3f0/0x452 arch/riscv/kernel/stacktrace.c:66
[<ffffffff861c20d4>] arch_stack_walk+0x1c/0x24 arch/riscv/kernel/stacktrace.c:163
[<ffffffff803a7e92>] stack_trace_save_tsk+0x16c/0x1f6 kernel/stacktrace.c:150
[<ffffffff80cfbfc2>] proc_pid_stack+0x176/0x27e fs/proc/base.c:492
[<ffffffff80cfd524>] proc_single_show+0xf0/0x20e fs/proc/base.c:812
[<ffffffff80b80784>] traverse.part.0.constprop.0+0x126/0x530 fs/seq_file.c:111
[<ffffffff80b81372>] traverse fs/seq_file.c:98 [inline]
[<ffffffff80b81372>] seq_read_iter+0x7e4/0x101e fs/seq_file.c:195
[<ffffffff80b81e4a>] seq_read+0x29e/0x360 fs/seq_file.c:162
[<ffffffff80ac99b6>] do_loop_readv_writev fs/read_write.c:840 [inline]
[<ffffffff80ac99b6>] do_loop_readv_writev fs/read_write.c:828 [inline]
[<ffffffff80ac99b6>] vfs_readv+0x520/0x70c fs/read_write.c:1013
[<ffffffff80aca05c>] do_preadv+0x1b4/0x250 fs/read_write.c:1125
[<ffffffff80ad0718>] __do_sys_preadv fs/read_write.c:1172 [inline]
[<ffffffff80ad0718>] __se_sys_preadv fs/read_write.c:1167 [inline]
[<ffffffff80ad0718>] __riscv_sys_preadv+0x88/0xc4 fs/read_write.c:1167
[<ffffffff80070302>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:90
[<ffffffff861c1fae>] do_trap_ecall_u+0x1aa/0x216 arch/riscv/kernel/traps.c:331
[<ffffffff861e652a>] _new_vmalloc_restore_context_a0+0xc2/0xce

The buggy address belongs to the virtual mapping at
 [ff20000001f10000, ff20000001f19000) created by:
 kernel_clone+0x11e/0xc3c kernel/fork.c:2807

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9d543
memcg:ff6000001926ed82
flags: 0xffe000000000000(node=0|zone=0|lastcpupid=0x7ff)
raw: 0ffe000000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff ff6000001926ed82
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 5065, tgid 5065 (syz.3.222), ts 1917899182200, free_ts 1915638108000
 __set_page_owner+0xa2/0x70c mm/page_owner.c:320
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xf0/0x1e8 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xdb2/0x2c12 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x1e8/0x1fc0 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0xf8/0x488 mm/mempolicy.c:2269
 alloc_pages_noprof+0x174/0x2f0 mm/mempolicy.c:2348
 vm_area_alloc_pages mm/vmalloc.c:3589 [inline]
 __vmalloc_area_node mm/vmalloc.c:3667 [inline]
 __vmalloc_node_range_noprof+0x642/0x120c mm/vmalloc.c:3844
 alloc_thread_stack_node kernel/fork.c:314 [inline]
 dup_task_struct kernel/fork.c:1121 [inline]
 copy_process+0x2c04/0x6c90 kernel/fork.c:2225
 kernel_clone+0x11e/0xc3c kernel/fork.c:2807
 __do_sys_clone+0xe4/0x118 kernel/fork.c:2950
 __se_sys_clone kernel/fork.c:2918 [inline]
 __riscv_sys_clone+0xa0/0x10e kernel/fork.c:2918
 syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:90
 do_trap_ecall_u+0x1aa/0x216 arch/riscv/kernel/traps.c:331
 _new_vmalloc_restore_context_a0+0xc2/0xce
page last free pid 4315 tgid 4315 stack trace:
 __reset_page_owner+0x8c/0x400 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x61e/0x11d6 mm/page_alloc.c:2657
 __free_pages+0x13a/0x1ba mm/page_alloc.c:4838
 bpf_ringbuf_free kernel/bpf/ringbuf.c:226 [inline]
 ringbuf_map_free+0xc8/0x134 kernel/bpf/ringbuf.c:235
 bpf_map_free kernel/bpf/syscall.c:839 [inline]
 bpf_map_free_deferred+0x21e/0x46a kernel/bpf/syscall.c:863
 process_one_work+0x968/0x1f38 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x5be/0xdc6 kernel/workqueue.c:3391
 kthread+0x28c/0x3a4 kernel/kthread.c:389
 ret_from_fork+0xe/0x18 arch/riscv/kernel/entry.S:326

Memory state around the buggy address:
 ff20000001f17c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ff20000001f17c80: f1 f1 f1 f1 04 f3 f3 f3 00 00 00 00 00 00 00 00
>ff20000001f17d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                                                             ^
 ff20000001f17d80: f1 f1 f1 f1 00 f2 f2 f2 00 00 f3 f3 00 00 00 00
 ff20000001f17e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


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

