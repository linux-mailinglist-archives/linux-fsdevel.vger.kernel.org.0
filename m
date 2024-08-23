Return-Path: <linux-fsdevel+bounces-26918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283E95D094
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 17:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7ABD1C227D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD426188924;
	Fri, 23 Aug 2024 15:00:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC3186E4A
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425236; cv=none; b=CEBp1Iz84fDlGd7A7k/M1wCoBUnjHXzU/+NhcNtgFmSqtYXxCt8JjOqM+uV0njCfrFZwAIUuBcP721Yj1eT9XWXZvy4ZQFzL7gGhSbAowZLWK/nIm8rxTFbuUi8DDl1tQRNPIdRsW0fU9E1eRu54CWCxNGWqC7184/Kb0A535Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425236; c=relaxed/simple;
	bh=lTSYk0aSBm+RSaAVpLAUX1s/SyMt+z40moaxC4zmCn0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u7JAV9aakf9Z6VRJp/Z1IZtXjjqXeL+NGQVm3E5rvc6ooxCpZG8cxiZJK9GHC8JUqKmyajO7nex9NODDq+5FtN7ka4fFZaDDa9CRR00lA4YWM22DGrKmkVVxDl/r7dVgkFmb7I181hf8FirmU+zBop328kC0BYjnnbjws7XaUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d5537a62dso24196895ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 08:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724425234; x=1725030034;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RI3HAji1S8GHcEXYCAvXs5ujaFu4BOoJcjauiukabaE=;
        b=egQXQ2TOF2gsFZ/u38umo0yYCsrgSQOZ4XbCQQLTO7XhCpCxrJMI4ni5XWW2lyz+sy
         Z/ObyUlw0HtjhVILWQ/ISi3bwgRJXczjuqPhd+6/NC6pCyy4mYdEiB0whCrMwOUZoiq7
         wdoLIAWlhuWPa1fFhI15dYYrk0rwFIpBfiHed3IVkZBbV5mBlY2yBMpdH/zlQZZUyGJy
         VU+UwaFMfiu1RrlYLYO+A847M/8s8CDvokM5TANCgJiIhOexQ8qAmp0mwHMqYskAs6x9
         CDZbM8qTX1SJ5Hq8+glN15EufGN0j0BxVCVa70zDD1xNfPovq4Hh+BTbAKdcKPO9q3Gz
         hxzg==
X-Gm-Message-State: AOJu0Yxsodyc79R4Z05AIENHF/JZA3DDAde/q3tpbBzz9zPYHeVu/wYS
	BFNXF4SMYU8aTX9cy9UkYqVkw8o2g9eG589cBJxyY/rYnPukaTWgbIbB3sRUdcB+KOi0yoI47Ml
	/aS261VMEwGSwJBxM8+xlZnaXFOXW7xkNIeqqP3HHFhspaSGPmkoW/5I=
X-Google-Smtp-Source: AGHT+IEs6Coo4V5Nq4hy9dv4eQsH/oRKWFJmdi/tqT6t3qOb37rUi+gyzJGB77h6NA2LsVYl1rEUe1R5FgQEOI8nR3w3EePkrzrd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4c:b0:39a:e909:29f6 with SMTP id
 e9e14a558f8ab-39e3c8db574mr1907405ab.0.1724425233858; Fri, 23 Aug 2024
 08:00:33 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:00:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000819c1d06205b0926@google.com>
Subject: [syzbot] [fs?] KASAN: stack-out-of-bounds Read in proc_pid_stack (2)
From: syzbot <syzbot+f499adf92735b1da225e@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c562ba719df5 riscv: kexec: Avoid deadlock in kexec crash p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=1568d6e9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d1a27c56011377
dashboard link: https://syzkaller.appspot.com/bug?extid=f499adf92735b1da225e
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-c562ba71.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d9afe016b0e4/vmlinux-c562ba71.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cd6f9ae3bf94/Image-c562ba71.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f499adf92735b1da225e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in walk_stackframe+0x3f0/0x452 arch/riscv/kernel/stacktrace.c:66
Read of size 8 at addr ff20000002fab5e8 by task syz.0.1927/19558

CPU: 1 PID: 19558 Comm: syz.0.1927 Not tainted 6.10.0-rc6-syzkaller-gc562ba719df5 #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8000f6fc>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:130
[<ffffffff85c33fac>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:136
[<ffffffff85c8ddfa>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff85c8ddfa>] dump_stack_lvl+0x122/0x196 lib/dump_stack.c:114
[<ffffffff85c3e31c>] print_address_description mm/kasan/report.c:377 [inline]
[<ffffffff85c3e31c>] print_report+0x288/0x596 mm/kasan/report.c:488
[<ffffffff8091ece8>] kasan_report+0xec/0x118 mm/kasan/report.c:601
[<ffffffff80920b80>] __asan_report_load8_noabort+0x12/0x1a mm/kasan/report_generic.c:381
[<ffffffff8000f5ec>] walk_stackframe+0x3f0/0x452 arch/riscv/kernel/stacktrace.c:66
[<ffffffff85c90236>] arch_stack_walk+0x1c/0x26 arch/riscv/kernel/stacktrace.c:163
[<ffffffff8030832e>] stack_trace_save_tsk+0x16c/0x1f6 kernel/stacktrace.c:150
[<ffffffff80bd1a68>] proc_pid_stack+0x176/0x27e fs/proc/base.c:458
[<ffffffff80bd2df8>] proc_single_show+0xf0/0x224 fs/proc/base.c:778
[<ffffffff80a61004>] seq_read_iter+0x454/0x1020 fs/seq_file.c:230
[<ffffffff80a61e5c>] seq_read+0x28c/0x350 fs/seq_file.c:162
[<ffffffff809becf6>] vfs_read+0x1b0/0x85c fs/read_write.c:474
[<ffffffff809c098e>] ksys_read+0x12a/0x270 fs/read_write.c:619
[<ffffffff809c0b42>] __do_sys_read fs/read_write.c:629 [inline]
[<ffffffff809c0b42>] __se_sys_read fs/read_write.c:627 [inline]
[<ffffffff809c0b42>] __riscv_sys_read+0x6e/0x94 fs/read_write.c:627
[<ffffffff8000e204>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:90
[<ffffffff85c900b4>] do_trap_ecall_u+0x14c/0x214 arch/riscv/kernel/traps.c:330
[<ffffffff85cb3264>] ret_from_exception+0x0/0x64 arch/riscv/kernel/entry.S:112

The buggy address belongs to the virtual mapping at
 [ff20000002fa8000, ff20000002fad000) created by:
 kernel_clone+0x11e/0x946 kernel/fork.c:2797

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xacd50
memcg:ff60000015c3cf82
flags: 0xffe000000000000(node=0|zone=0|lastcpupid=0x7ff)
raw: 0ffe000000000000 0000000000000000 0000000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff ff60000015c3cf82
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 19550, tgid 19550 (syz.0.1925), ts 6742314481100, free_ts 6709608225100
 __set_page_owner+0xa2/0x70c mm/page_owner.c:320
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xec/0x1e4 mm/page_alloc.c:1473
 prep_new_page mm/page_alloc.c:1481 [inline]
 get_page_from_freelist+0x123c/0x27e8 mm/page_alloc.c:3425
 __alloc_pages_noprof+0x1f0/0x213e mm/page_alloc.c:4683
 alloc_pages_mpol_noprof+0xf8/0x48c mm/mempolicy.c:2265
 alloc_pages_noprof+0x174/0x2f0 mm/mempolicy.c:2336
 vm_area_alloc_pages mm/vmalloc.c:3575 [inline]
 __vmalloc_area_node mm/vmalloc.c:3651 [inline]
 __vmalloc_node_range_noprof+0x99a/0x11d6 mm/vmalloc.c:3832
 alloc_thread_stack_node kernel/fork.c:309 [inline]
 dup_task_struct kernel/fork.c:1115 [inline]
 copy_process+0x2c3c/0x6b22 kernel/fork.c:2220
 kernel_clone+0x11e/0x946 kernel/fork.c:2797
 __do_sys_clone+0xe4/0x118 kernel/fork.c:2940
 __se_sys_clone kernel/fork.c:2908 [inline]
 __riscv_sys_clone+0xa0/0x10e kernel/fork.c:2908
 syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:90
 do_trap_ecall_u+0x14c/0x214 arch/riscv/kernel/traps.c:330
 ret_from_exception+0x0/0x64 arch/riscv/kernel/entry.S:112
page last free pid 19445 tgid 19439 stack trace:
 __reset_page_owner+0x8c/0x400 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_page+0x59c/0xe9c mm/page_alloc.c:2588
 __free_pages+0x13a/0x1ba mm/page_alloc.c:4770
 vfree+0x1c6/0xb9e mm/vmalloc.c:3355
 kcov_put kernel/kcov.c:429 [inline]
 kcov_put kernel/kcov.c:425 [inline]
 kcov_close+0x44/0x72 kernel/kcov.c:525
 __fput+0x37c/0xa12 fs/file_table.c:422
 ____fput+0x1a/0x24 fs/file_table.c:450
 task_work_run+0x16a/0x25e kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x9ee/0x2896 kernel/exit.c:874
 do_group_exit+0xd4/0x26c kernel/exit.c:1023
 get_signal+0x1e1c/0x232a kernel/signal.c:2909
 arch_do_signal_or_restart+0x8bc/0x1172 arch/riscv/kernel/signal.c:437
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x2a6/0x31e kernel/entry/common.c:218
 do_trap_ecall_u+0x8e/0x214 arch/riscv/kernel/traps.c:345
 ret_from_exception+0x0/0x64 arch/riscv/kernel/entry.S:112

Memory state around the buggy address:
 ff20000002fab480: f1 f1 f1 f1 00 00 00 00 00 00 00 00 00 00 00 f3
 ff20000002fab500: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
>ff20000002fab580: 00 00 00 00 f1 f1 f1 f1 f1 f1 00 00 00 00 00 f3
                                                          ^
 ff20000002fab600: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
 ff20000002fab680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

