Return-Path: <linux-fsdevel+bounces-63447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBBABBCDE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 01:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576573B183D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Oct 2025 23:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165A223507C;
	Sun,  5 Oct 2025 23:30:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A8639ACF
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Oct 2025 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759707027; cv=none; b=fulw1OWyW/iEluxylbyytvprWpIJFxElncqynEOVhVdjY2R4hj4uEcOEDOQxBDGUBotHB09tsxehURa367gCX8VoAf7L7blNf+wKbSYwCJHwn7dj9QgYSlYOyFYgdZnitT3DuQoi4CGM2eAvCcgucVG2r4aHYB+EpBUtDmji2fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759707027; c=relaxed/simple;
	bh=wCYRZ+b9ItOQBq3sdB2ghpr5blX7YoBVZ648ziiMy80=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hu3Aip+dlRQKbbnrwK0k50FVu/RpyPBHj/EDhbXvlp5AK23i+9Mk1hhejAKMTTK77jfcGKQ2GKwAiptHOWqfRYsZcbgSnJKEtXYRvO4t/jZPYzlj7n7R+hDW+wVbCE//fVphjsdR2n9DP9PonVOEgG0s2uoEpcgzu3RkX2q9zt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-42f639d6e02so58629985ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Oct 2025 16:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759707025; x=1760311825;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HHhsaKc/mdM3GNUzwySN/o4bsPauVNhRx2KSq6AZsrU=;
        b=pKb0dOd/u5IW3hkO23YCOHpp3i2ZyxNmPP4PzdrnqfHuo5ELZxqnjKF/dSm8QCkNPI
         8Xlm09fhuMX+Xas8pIw3AWNyXMJhWISHLPE1A8z5Wr0NcDAcwIXv2qulOymVWrlsGZRb
         QHN8DkrPPJyAJEo5QQ/2vhx/rUJy8Hkv0uKBRM0+xn1+87WpWMTZD1YiZ7gnI2zcqDTa
         zFl14h/IqZFZanP8OBTb31J+C4vb1jx9EEz/ktc3lFWzNZmdA1tDkyMrd7iMeZIl+gmc
         8TgpTtU2n9LCETjCdniKMXctZy+l/DJ015nrWkxFTPVJ8ujFR0Av0RcfGEkIeaz3A5HG
         rorQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuP/nnGqIH5bA0ajJeiUUr6NjkzPn5vb1QpLe1c3H/cuOnY4j04Y/i6+Ra9qXG4XpHBPtxgSRuYsKQZXV0@vger.kernel.org
X-Gm-Message-State: AOJu0YznkQdnP/q3bDeIVBNcPWmh4K+jzjBXzS9r7gBUuLmFD0niE2t1
	VaGHK2tMqD9gNJY2nkurp/cLGEvXFLGh6S7anv0NNYxT+sWJe7INc7677yOvMGW4XQ10K1N/EV7
	MQY4pb2i/YuvKqLGWpG+TqffeTGPMzy/Pj8Rg7/VgbEzrl33Eetr61u88L10=
X-Google-Smtp-Source: AGHT+IHKYaiDUGNAMaKqvWapeMds655HteR2aAVQuYrZ2+6aewTEDC7vYhZCXMFuXr64IvHVpWdlPb/9awerS1kl5J0XvQXYDV1y
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1748:b0:42e:452f:5321 with SMTP id
 e9e14a558f8ab-42e7ad0a7d0mr156883805ab.9.1759707024971; Sun, 05 Oct 2025
 16:30:24 -0700 (PDT)
Date: Sun, 05 Oct 2025 16:30:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e2ff90.050a0220.2c17c1.0039.GAE@google.com>
Subject: [syzbot] [exfat?] KASAN: stack-out-of-bounds Read in exfat_nls_to_utf16
From: syzbot <syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6093a688a07d Merge tag 'char-misc-6.18-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1149dee2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2b03b8b7809165e
dashboard link: https://syzkaller.appspot.com/bug?extid=98cc76a76de46b3714d4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12451a7c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aa7942580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/15a8a043eb77/disk-6093a688.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2e5dfeaf5d0e/vmlinux-6093a688.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3d11ec676d6d/bzImage-6093a688.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0204bf2eab84/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=142895cd980000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com

exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0xe3865569, utbl_chksum : 0xe619d30d)
==================================================================
BUG: KASAN: stack-out-of-bounds in exfat_nls_to_ucs2 fs/exfat/nls.c:619 [inline]
BUG: KASAN: stack-out-of-bounds in exfat_nls_to_utf16+0xac8/0xc10 fs/exfat/nls.c:647
Read of size 1 at addr ff[  114.258372][ T5975] Read of size 1 at addr ffffc90003c37710 by task syz.0.17/5975

CPU: 1 UID: 0 PID: 5975 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 exfat_nls_to_ucs2 fs/exfat/nls.c:619 [inline]
 exfat_nls_to_utf16+0xac8/0xc10 fs/exfat/nls.c:647
 exfat_ioctl_set_volume_label fs/exfat/file.c:524 [inline]
 exfat_ioctl+0x818/0x1100 fs/exfat/file.c:554
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fed7375eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff5eae5808 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fed739b5fa0 RCX: 00007fed7375eec9
RDX: 00002000000007c0 RSI: 0000000041009432 RDI: 0000000000000004
RBP: 00007fed737e1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fed739b5fa0 R14: 00007fed739b5fa0 R15: 0000000000000003
 </TASK>

The buggy address belongs to stack of task syz.0.17/5975
 and is located at offset 304 in frame:
 exfat_ioctl+0x0/0x1100 fs/exfat/file.c:33

This frame has 7 objects:
 [32, 36) 'lossy.i'
 [48, 304) 'label.i50'
 [368, 888) 'uniname.i51'
 [1024, 1280) 'label.i'
 [1344, 1864) 'uniname.i'
 [2000, 2024) 'range.i'
 [2064, 2144) 'ia.i'

The buggy address belongs to a 8-page vmalloc region starting at 0xffffc90003c30000 allocated at copy_process+0x545/0x3ae0 kernel/fork.c:2012
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888026a18f00 pfn:0x26a18
memcg:ffff888022f68802
flags: 0x80000000000000(node=0|zone=1)
raw: 0080000000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff888026a18f00 0000000000000000 00000001ffffffff ffff888022f68802
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_ZERO|__GFP_NOWARN), pid 3634, tgid 3634 (kworker/u8:13), ts 113475141729, free_ts 113296085908
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x28c0/0x2960 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 alloc_frozen_pages_noprof mm/mempolicy.c:2487 [inline]
 alloc_pages_noprof+0xcf/0x1e0 mm/mempolicy.c:2507
 vm_area_alloc_pages mm/vmalloc.c:3647 [inline]
 __vmalloc_area_node mm/vmalloc.c:3724 [inline]
 __vmalloc_node_range_noprof+0x96c/0x12d0 mm/vmalloc.c:3897
 __vmalloc_node_noprof+0xc2/0x110 mm/vmalloc.c:3960
 alloc_thread_stack_node kernel/fork.c:311 [inline]
 dup_task_struct+0x3d4/0x830 kernel/fork.c:881
 copy_process+0x545/0x3ae0 kernel/fork.c:2012
 kernel_clone+0x224/0x7c0 kernel/fork.c:2609
 user_mode_thread+0xdd/0x140 kernel/fork.c:2685
 call_usermodehelper_exec_sync kernel/umh.c:132 [inline]
 call_usermodehelper_exec_work+0x9c/0x230 kernel/umh.c:163
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:158
page last free pid 28 tgid 28 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xfb6/0x1140 mm/page_alloc.c:2906
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core kernel/rcu/tree.c:2861 [inline]
 rcu_cpu_kthread+0xbf3/0x1b50 kernel/rcu/tree.c:2949
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffffc90003c37600: 04 f2 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90003c37680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90003c37700: 00 00 f2 f2 f2 f2 f2 f2 f2 f2 00 00 00 00 00 00
                         ^
 ffffc90003c37780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90003c37800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

