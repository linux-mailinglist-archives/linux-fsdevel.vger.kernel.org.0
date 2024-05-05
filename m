Return-Path: <linux-fsdevel+bounces-18768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1298BC303
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 20:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4636D2817C5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 18:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A2E6E5F6;
	Sun,  5 May 2024 18:25:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA1E6BFA3
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714933544; cv=none; b=A2OopH7bBAbwX+YaPP0QFhHFklnj8SriJmvAsoTbiV6JphA0TVr55e/TUcxtAgwK6zKAaGl+vPR6itzmDqN5C/K4LweCH8zRlgdoE2ofcWfOD7Cto7/ifD9aA5dBx4qGfwsk3h87jtGn/GYsXNvcg2smIQOb8GFGHruiIGQ6mxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714933544; c=relaxed/simple;
	bh=ZzSgvp0nlIOBuaqs35a/8LGRcP/X+936qGCxdo3OZZQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ptBvkBzpv3CRMTvjQkzT51wz85Vn0QR2ybDVccSmXzlsESi0nTHjM3PX8xAv2PwzAP895CtvT5XXWMj4i85DO5xcEN45HeOy3pBuYHv0kh8l+sp5JoIN3BfmoqLzp0jgph3sH5A9HZN0eozmiPia0rQ2eCITjVPUfa/ILAJ9m2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7de9c6b7a36so178972439f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 11:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714933542; x=1715538342;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6KFmZ+haFqkR91qWp69g+eZcxEdsTK+0zOSLAGUgMxg=;
        b=IoeRm26hbbwQm4JXgrAm50Q5RLgDY8yTpCjglYdAK9pflRRlnk5WJzc8CD9ar5Yb1M
         60uJtsuL/ggCJqP0nCzNA1/xPRWaJQxW1u9AFOoXlb2+TY9x1jrJ4ZK/ALfaAdZHYoRT
         xslFykVqaYmqcv8hdKthBfM37rCCfi8czJwwsC+Pfr5O90qQMxqYxl/6BsXjcar3gzAT
         mPJCVIWE3a8vxaRPvk01E95IZK23UX/Es3oOkE6Fsgf7iCR/XuIThWt6+K/vuHvzu+vq
         or1I8TT3pzGOV5D/BdlocOz8JAFxkCoDxQJLbrXMoYMkJKQmekX5cKS2P3lPGjIhE21M
         2lrg==
X-Forwarded-Encrypted: i=1; AJvYcCWfKingj2gTH2ROQ+u9UE+p14FEdOeC1JFF2Pp/KmQyUkY8uV6V28fmTmliDhKOJh1os3tbGc49FjsWfSRaoQUn3327g8782x5ocrdvWg==
X-Gm-Message-State: AOJu0YzJwueWj5n6ltbT7Ye9DJ2uTZUk3k4Hx5WRX029W+G9wSRNzrem
	qOsmWLl2s1e4ERIYCf77d53UC5PnM1/Yv/rLCgViniBIZzDf0T4W9JlQA2xoBIZLyZmlIWZ+yPk
	56mZk077IAZsthUg4eN9UOgkJ1nHSJ3O3/F/ulQAeM1M5iLhW/6NF8yo=
X-Google-Smtp-Source: AGHT+IEA+m2COvgwGUoWxn7H2ZMoa++bVwBRBmIYMqv45jh5hZmFDMkhB40cLnn8GHXPBPFk9Ya//jZZ5De2mPW/lKWyKdqQMbgY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:841e:b0:488:7bb2:c9fd with SMTP id
 iq30-20020a056638841e00b004887bb2c9fdmr143781jab.6.1714933541731; Sun, 05 May
 2024 11:25:41 -0700 (PDT)
Date: Sun, 05 May 2024 11:25:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000918c290617b914ba@google.com>
Subject: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in bch2_sb_clean_to_text
From: syzbot <syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11711898980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=c48865e11e7e893ec4ab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1043897f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145c078b180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/03bd77f8af70/disk-7367539a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb03a61f9582/vmlinux-7367539a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e4c5c654b571/bzImage-7367539a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2d31172220b2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
==================================================================
BUG: KASAN: slab-out-of-bounds in bch2_sb_clean_to_text+0x17f/0x230 fs/bcachefs/sb-clean.c:298
Read of size 1 at addr ffff888023ef6004 by task syz-executor493/5073

CPU: 0 PID: 5073 Comm: syz-executor493 Not tainted 6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 bch2_sb_clean_to_text+0x17f/0x230 fs/bcachefs/sb-clean.c:298
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
RIP: 0033:0x7f2a126618fa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe44de6bb8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe44de6bd0 RCX: 00007f2a126618fa
RDX: 0000000020011a00 RSI: 0000000020011a40 RDI: 00007ffe44de6bd0
RBP: 0000000000000004 R08: 00007ffe44de6c10 R09: 00000000000119fe
R10: 0000000003004000 R11: 0000000000000282 R12: 0000000003004000
R13: 00007ffe44de6c10 R14: 0000000000000003 R15: 0000000001000000
 </TASK>

Allocated by task 5073:
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

The buggy address belongs to the object at ffff888023ef4000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 4 bytes to the right of
 allocated 8192-byte region [ffff888023ef4000, ffff888023ef6000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x23ef0
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888015042280 ffffea0000910a00 0000000000000005
raw: 0000000000000000 0000000080020002 00000001ffffffff 0000000000000000
head: 00fff00000000840 ffff888015042280 ffffea0000910a00 0000000000000005
head: 0000000000000000 0000000080020002 00000001ffffffff 0000000000000000
head: 00fff00000000003 ffffea00008fbc01 ffffea00008fbc48 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4736, tgid 1480517225 (sh), ts 4736, free_ts 31493460772
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
 kmalloc_trace+0x269/0x360 mm/slub.c:3992
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 tomoyo_print_bprm security/tomoyo/audit.c:26 [inline]
 tomoyo_init_log+0x11ce/0x2050 security/tomoyo/audit.c:264
 tomoyo_supervisor+0x38a/0x11f0 security/tomoyo/common.c:2089
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x178/0x210 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0x1384/0x1cf0 security/tomoyo/domain.c:878
 tomoyo_bprm_check_security+0x115/0x180 security/tomoyo/tomoyo.c:102
 security_bprm_check+0x65/0x90 security/security.c:1191
 search_binary_handler fs/exec.c:1766 [inline]
 exec_binprm fs/exec.c:1820 [inline]
 bprm_execve+0xa56/0x17c0 fs/exec.c:1872
 do_execveat_common+0x553/0x700 fs/exec.c:1979
 do_execve fs/exec.c:2053 [inline]
 __do_sys_execve fs/exec.c:2129 [inline]
 __se_sys_execve fs/exec.c:2124 [inline]
 __x64_sys_execve+0x92/0xb0 fs/exec.c:2124
page last free pid 4734 tgid 4734 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x97b/0xaa0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 discard_slab mm/slub.c:2437 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2906
 put_cpu_partial+0x17c/0x250 mm/slub.c:2981
 __slab_free+0x2ea/0x3d0 mm/slub.c:4151
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc+0x174/0x340 mm/slub.c:3852
 getname_flags+0xbd/0x4f0 fs/namei.c:139
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1400
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888023ef5f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888023ef5f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888023ef6000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff888023ef6080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888023ef6100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

