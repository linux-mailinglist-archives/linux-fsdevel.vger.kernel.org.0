Return-Path: <linux-fsdevel+bounces-18813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1B58BC7EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 09:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF2128175C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 07:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65257580E;
	Mon,  6 May 2024 07:01:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA00524AE
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714978885; cv=none; b=IGQ6tDwECUGM5ZlYTZrDG/tHmapI2iRIjbhwuHlhXM5MUtbc98ZohJrImqivVr1cny+7X8B+teZSDEgr93l9vNAW9HTCmbstSniMO3+0CHtzMxSG9MHLozxWJdNhkdoZV9x57wHMHtAfJ+esULvc/UiCffySnN+mRkF2tTcx5Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714978885; c=relaxed/simple;
	bh=U4XPExsheKTvSlPaXmvI+7KaDOXPBcEqiTf2cA+J+04=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pAQ49sQjA/iOXHmHE//Q/XGcCj2Yzr2atibjXulYsGvAOUruratyKihKYeGH82nl8zfhu1oLXHqvJr5h0OcfLb51/92pJKkuD/Cfa+FvKQHzXf0nwjA+yezUqsl1N8Ktb1GxFeZUBSRHXIqAu1fp8OTMig3dWmNocJvwgwL1Y4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7deb999eea4so201413239f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2024 00:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714978881; x=1715583681;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7Ap8fjiMma13zjjiL5OD5EracVQQFFvbF9WW7+9o3o=;
        b=UUvOxBEgqUdw3Xl8f5b9PavnLiAgvwRhUFI+oYmOtbKsWWcQ4iPOAjDhpeBHDFQgfd
         SEiYmtTZeJkwORcjCOnsQnwo8jCjh36Hs/VLVqKcXc9pFaTM6JFMjZdeBYHBb2qk246r
         7+lb+mBYJYEylaJl8IxdAI1+xIXFwd356udru8Q9H6xpsJdMhqLPHr5QxosqIdznKNs7
         FBzGbVXaNscgNWMa0kwqjCu6F6NTkEjKnncbXH8lnBMcIyfCPFSlhDNjCViyyHFMKaq9
         JykH7hCVctkVC8q4F0s1ylTLWeUTYRI793oT2S0EGOWlmYn53qOxVZC1TP8JiyedcfGE
         sr4w==
X-Forwarded-Encrypted: i=1; AJvYcCWlcdlWsLPsV/2cTDo1W+k7EdioQmViTl4oT757UjR1/Le7BUkB/0hqUtWALfArGy+T/hggvivxAecJ2JldfJJAoMyuqIFXtCf1YmCDIg==
X-Gm-Message-State: AOJu0Yzp9OJNTrwZf4hW+rPuT2TPnrk7Z2m5GXLs8K2+EqUQ9ckJdtep
	xWUk5+8wh/7dWkJqlwvFxo08xf0icMWfBtWmuxxNUWk0iTFIrf6VME1ggnqvEHKrkZDmJa6Ent0
	/q+ROqgPMz5cTlknnrqenEhr0gjlJ8g0wS9I5mDjm9EA7Mdub+T3K4RI=
X-Google-Smtp-Source: AGHT+IEmvJdDUbaAUzNvPTTEQP+Sw0d8WwsuzJvvdbwEtMOiWC8L/p9V2YbiNvddok2WC9JOJ/TwZUL5cDJcRg2cjCGbAEeUu/li
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cac8:0:b0:488:59cc:eb5b with SMTP id
 f8-20020a02cac8000000b0048859cceb5bmr186092jap.3.1714978881050; Mon, 06 May
 2024 00:01:21 -0700 (PDT)
Date: Mon, 06 May 2024 00:01:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000a8d60617c3a3dc@google.com>
Subject: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in bch2_sb_downgrade_to_text
From: syzbot <syzbot+e49ccab73449180bc9be@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=123b0470980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=e49ccab73449180bc9be
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16510b54980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c419ff180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4ba2285864ac/disk-7367539a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/256ceea532d5/vmlinux-7367539a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4ae5205eefc3/bzImage-7367539a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/701c52578739/mount_0.gz

The issue was bisected to:

commit 84f1638795da1ff2084597de4251e9054f1ad728
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Fri Dec 29 20:25:07 2023 +0000

    bcachefs: bch_sb_field_downgrade

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10bceec0980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12bceec0980000
console output: https://syzkaller.appspot.com/x/log.txt?x=14bceec0980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e49ccab73449180bc9be@syzkaller.appspotmail.com
Fixes: 84f1638795da ("bcachefs: bch_sb_field_downgrade")

loop0: detected capacity change from 0 to 32768
==================================================================
BUG: KASAN: slab-out-of-bounds in bch2_sb_downgrade_to_text+0x15ab/0x1f70 fs/bcachefs/sb-downgrade.c:185
Read of size 2 at addr ffff88802fd26000 by task syz-executor167/5069

CPU: 0 PID: 5069 Comm: syz-executor167 Not tainted 6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 bch2_sb_downgrade_to_text+0x15ab/0x1f70 fs/bcachefs/sb-downgrade.c:185
 bch2_sb_field_validate+0x1f7/0x2d0 fs/bcachefs/super-io.c:1211
 bch2_sb_validate+0xa79/0xe10 fs/bcachefs/super-io.c:468
 __bch2_read_super+0xc9a/0x1460 fs/bcachefs/super-io.c:822
 bch2_fs_open+0x246/0xdf0 fs/bcachefs/super.c:2049
 bch2_mount+0x71d/0x1320 fs/bcachefs/fs.c:1903
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5baac41b4a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda21bbff8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffda21bc010 RCX: 00007f5baac41b4a
RDX: 0000000020011a00 RSI: 0000000020000000 RDI: 00007ffda21bc010
RBP: 0000000000000004 R08: 00007ffda21bc050 R09: 00000000000119fe
R10: 0000000003a04000 R11: 0000000000000282 R12: 0000000003a04000
R13: 00007ffda21bc050 R14: 0000000000000003 R15: 0000000001000000
 </TASK>

Allocated by task 5069:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc_node_track_caller+0x24e/0x4e0 mm/slub.c:3986
 __do_krealloc mm/slab_common.c:1192 [inline]
 krealloc+0x7d/0x120 mm/slab_common.c:1225
 bch2_sb_realloc+0x2fc/0x660 fs/bcachefs/super-io.c:189
 read_one_super+0x7d7/0x3a10 fs/bcachefs/super-io.c:659
 __bch2_read_super+0x65a/0x1460 fs/bcachefs/super-io.c:750
 bch2_fs_open+0x246/0xdf0 fs/bcachefs/super.c:2049
 bch2_mount+0x71d/0x1320 fs/bcachefs/fs.c:1903
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802fd24000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 0 bytes to the right of
 allocated 8192-byte region [ffff88802fd24000, ffff88802fd26000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2fd20
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888015042280 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000020002 00000001ffffffff 0000000000000000
head: 00fff00000000840 ffff888015042280 0000000000000000 dead000000000001
head: 0000000000000000 0000000000020002 00000001ffffffff 0000000000000000
head: 00fff00000000003 ffffea0000bf4801 ffffea0000bf4848 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid -1302780373 (swapper/0), ts 1, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc_node+0x2db/0x4e0 mm/slub.c:3973
 kmalloc_node include/linux/slab.h:648 [inline]
 kvmalloc_node+0x72/0x190 mm/util.c:634
 kvmalloc include/linux/slab.h:766 [inline]
 lzo_alloc_workspace+0xe3/0x220 fs/btrfs/lzo.c:93
 btrfs_init_workspace_manager+0xf8/0x270 fs/btrfs/compression.c:784
 btrfs_init_compress+0x90/0x190 fs/btrfs/compression.c:1072
 init_btrfs_fs+0x83/0x250 fs/btrfs/super.c:2555
 do_one_initcall+0x248/0x880 init/main.c:1245
 do_initcall_level+0x157/0x210 init/main.c:1307
 do_initcalls+0x3f/0x80 init/main.c:1323
 kernel_init_freeable+0x435/0x5d0 init/main.c:1555
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802fd25f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802fd25f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88802fd26000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88802fd26080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802fd26100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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

