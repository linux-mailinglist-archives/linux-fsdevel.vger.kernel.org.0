Return-Path: <linux-fsdevel+bounces-15911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4953895B2D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 19:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D31285377
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B628015AAB2;
	Tue,  2 Apr 2024 17:54:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4EE15AAAF
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080467; cv=none; b=Kh2Jlu7ky6EuIoN9pe58jlw9zKZieSuVvnD0FeTUdytqsTZ/5QhPphz1yOpQf+kTcr3XjGlknIa43+j+BXImiszxQ1Ncotwm1NUR9ARICnX9zKJfMqDIfPsiwHhr00DuUC0oL0oljQnX0cpdeXdEhigw1ZeBUeln/VJuLMVOhUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080467; c=relaxed/simple;
	bh=BvcGdeJteBOLOX1oOponlp3funCNbMEDcBeIfS00kdM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Kq2EoIMjlW2ElnWVa4E3KvVUnxBKLfn7EjQyHD1BaVC/1dysZBGNXfrED10yyeLD2WiMcsySwEVs4fgl7rpSJZS0HiDu+4egSYLv1nalLCr7LD+jXSiJm7PWE1OaGEsObA3sQ4Z2MY/CzixtWdujUU3QRnf9vkFUzrmFQRwNvzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36660582091so64966675ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 10:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712080465; x=1712685265;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bqwX2k12K/PELVfeSN5iaYFxTi2XuvDYeBtzhME6iis=;
        b=pAwxnVL/51kRn6QcWIBGkgEYLbV8kBZdCqKn/1J4wrrSxeJ2HWxowUScrDzn0xzc+i
         1uXAwrROADiekbX2vTkHlpITR5C/uFDbSr7N3AaqE3D463Cz6C6wydp0VGqOJwu5PFAq
         XYdhvjqSxeiFAsIFXIocH0dg/hthwkJj7/d9g9wv7o+0/MKbMHIT+8YDNVUNXpAR/4eA
         gSg9X6CEUHGnmqW/98U3JuFyS+r/5vydcYWRhMjd3R0G07Z6iuSJkHHX53Cr58m9X5QB
         kWh+T01ZM368WTBVvkEAy6qqpv4VIUL77VDHHbwB8lrWjoPMdV2ZFXYpC/2sNuXIrkq6
         aa8g==
X-Forwarded-Encrypted: i=1; AJvYcCUdLPbbeJFtEWY6jZWSgOkKoelKCa8DVDfOrSLhRHjSz6elZtcSopuPNDNh7A82hasJ3xF0Qi15ud8C/asy8qcDXSWd4kFg8tSZQwjVPg==
X-Gm-Message-State: AOJu0YyAuRw3TsH2SwMWB7jUMUCrZBq5sNMVM9lXLh9AiZRTRrAZZYUY
	TfHiTQEWg8K0tN/FJQpPjmkfI290aDwHOvh4xH5F22oQKum2M2zSTjQGJbZx3Q9JTm9fvh6ExK5
	oEfQh07E2OzMU91yCQnms8dhP1j0nkA4rdbFd+VSHkovEImLJSCjSQnM=
X-Google-Smtp-Source: AGHT+IHM31JjmcOZVS1gaDLlBTeVG31c+t5aITaT+lE7n4CNFd+XVQacxDMTDNF8jII5FyZcXfOidezTGLMliCHQ5BLFF+DKruZ/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:221a:b0:368:79b4:dd11 with SMTP id
 j26-20020a056e02221a00b0036879b4dd11mr1006424ilf.6.1712080464930; Tue, 02 Apr
 2024 10:54:24 -0700 (PDT)
Date: Tue, 02 Apr 2024 10:54:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f075b9061520cbbe@google.com>
Subject: [syzbot] [nfs?] KASAN: slab-out-of-bounds Write in do_handle_open
From: syzbot <syzbot+4139435cb1b34cf759c2@syzkaller.appspotmail.com>
To: amir73il@gmail.com, brauner@kernel.org, chuck.lever@oracle.com, 
	jack@suse.cz, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=148b0003180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
dashboard link: https://syzkaller.appspot.com/bug?extid=4139435cb1b34cf759c2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1547f529180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e22f0d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4139435cb1b34cf759c2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in instrument_copy_from_user_before include/linux/instrumented.h:129 [inline]
BUG: KASAN: slab-out-of-bounds in _copy_from_user+0x7b/0xe0 lib/usercopy.c:22
Write of size 36 at addr ffff8880203f2e88 by task syz-executor205/5086

CPU: 1 PID: 5086 Comm: syz-executor205 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_copy_from_user_before include/linux/instrumented.h:129 [inline]
 _copy_from_user+0x7b/0xe0 lib/usercopy.c:22
 copy_from_user include/linux/uaccess.h:183 [inline]
 handle_to_path fs/fhandle.c:203 [inline]
 do_handle_open+0x204/0x660 fs/fhandle.c:226
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7f81f2e5f269
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcde6f13c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 00007ffcde6f15a8 RCX: 00007f81f2e5f269
RDX: 0000000000000000 RSI: 00000000200091c0 RDI: 00000000ffffffff
RBP: 00007f81f2ed2610 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffcde6f1598 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5086:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4048 [inline]
 __kmalloc_noprof+0x200/0x410 mm/slub.c:4061
 kmalloc_noprof include/linux/slab.h:664 [inline]
 handle_to_path fs/fhandle.c:195 [inline]
 do_handle_open+0x162/0x660 fs/fhandle.c:226
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

The buggy address belongs to the object at ffff8880203f2e80
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 8 bytes inside of
 allocated 36-byte region [ffff8880203f2e80, ffff8880203f2ea4)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x203f2
ksm flags: 0xfff80000000000(node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffefff(slab)
raw: 00fff80000000000 ffff888015041640 ffffea0000869bc0 dead000000000003
raw: 0000000000000000 0000000080200020 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 4542, tgid -909298647 (udevd), ts 4542, free_ts 33444169271
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1490
 prep_new_page mm/page_alloc.c:1498 [inline]
 get_page_from_freelist+0x2e7e/0x2f40 mm/page_alloc.c:3454
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4712
 __alloc_pages_node_noprof include/linux/gfp.h:244 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:271 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2249
 allocate_slab+0x5a/0x2e0 mm/slub.c:2412
 new_slab mm/slub.c:2465 [inline]
 ___slab_alloc+0xea8/0x1430 mm/slub.c:3599
 __slab_alloc+0x58/0xa0 mm/slub.c:3684
 __slab_alloc_node mm/slub.c:3737 [inline]
 slab_alloc_node mm/slub.c:3915 [inline]
 __do_kmalloc_node mm/slub.c:4047 [inline]
 __kmalloc_noprof+0x25e/0x410 mm/slub.c:4061
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:775 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x59e/0x5e0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x2b7/0x740 security/tomoyo/file.c:822
 security_inode_getattr+0xd8/0x130 security/security.c:2269
 vfs_getattr+0x45/0x430 fs/stat.c:173
 vfs_fstat fs/stat.c:198 [inline]
 vfs_fstatat+0xd6/0x190 fs/stat.c:300
 __do_sys_newfstatat fs/stat.c:468 [inline]
 __se_sys_newfstatat fs/stat.c:462 [inline]
 __x64_sys_newfstatat+0x125/0x1b0 fs/stat.c:462
 do_syscall_64+0xfb/0x240
page last free pid 4548 tgid 4548 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1110 [inline]
 free_unref_page+0xd3c/0xec0 mm/page_alloc.c:2617
 __slab_free+0x31b/0x3d0 mm/slub.c:4274
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3867 [inline]
 slab_alloc_node mm/slub.c:3927 [inline]
 __do_kmalloc_node mm/slub.c:4047 [inline]
 __kmalloc_noprof+0x1a9/0x410 mm/slub.c:4061
 kmalloc_noprof include/linux/slab.h:664 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path2_perm+0x3eb/0xbb0 security/tomoyo/file.c:923
 tomoyo_path_rename+0x198/0x1e0 security/tomoyo/tomoyo.c:300
 security_path_rename+0x179/0x220 security/security.c:1918
 do_renameat2+0x94a/0x13f0 fs/namei.c:5027
 __do_sys_rename fs/namei.c:5087 [inline]
 __se_sys_rename fs/namei.c:5085 [inline]
 __x64_sys_rename+0x86/0xa0 fs/namei.c:5085
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

Memory state around the buggy address:
 ffff8880203f2d80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880203f2e00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff8880203f2e80: 00 00 00 00 04 fc fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff8880203f2f00: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
 ffff8880203f2f80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
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

