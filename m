Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0334652CC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 07:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLUGRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 01:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiLUGRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:17:39 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899091EC78
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Dec 2022 22:17:38 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id n15-20020a056e021baf00b0030387c2e1d3so9564440ili.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Dec 2022 22:17:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5Z6uDln6PJoe7rNTnxmI3R8lSkwe0kCcWiLF8U3Gss=;
        b=HjxUb7nkuuf+RllVDI5ORV++pwELPGFnBWtdGmonymAJHrecOXU+6RV6RY5thXn6EE
         ToAZXOZePbDcJhKMbsDQbqUHpxKjjWFQw5xQphqY2H8Z636oFWUX5LBuKS23cyLnMuQK
         pRDkTn9cm3IZlZFc9J/RnW9q3kbx4nJbUxlEFGDhlQDXHP34Fe2Wd3OB9CyFa6UwGtii
         I82dBeXT8+wv7gyhmjZXWGrypE9ZfNPdb31FRVMDuXM8ICU65oGNM3UKtgkWbrb+nBwK
         aN+8jLQtqI3cNyZza1rIOJ3lZ/rmOxHhEKyN8tVZAMk0Q7KfIvA9xU3eeqJ2sWRqH7Fz
         d7sg==
X-Gm-Message-State: AFqh2kqpTESBuL1IzVMVOExSsd6JEg8Oe7s/iR4D13hoNkSKE4tZmFiP
        xGnXhdjGQQYSevPhOrArnuh60pUNJV4kvERZdb9vFZ9Toxdw
X-Google-Smtp-Source: AMrXdXsNFsrBcb7bWBINU6gjh2wdPG1+BM///6FtQulv5NhUR7OzRJiQQTm0GvSzkrqcC6EslDQD6atqE1Sr86d19cjhCL6qXdHA
MIME-Version: 1.0
X-Received: by 2002:a92:cb07:0:b0:30b:bba2:e59d with SMTP id
 s7-20020a92cb07000000b0030bbba2e59dmr85792ilo.259.1671603457892; Tue, 20 Dec
 2022 22:17:37 -0800 (PST)
Date:   Tue, 20 Dec 2022 22:17:37 -0800
In-Reply-To: <00000000000033295305ea370bb5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005028ac05f05082d4@google.com>
Subject: Re: [syzbot] [exfat?] possible deadlock in exfat_iterate
From:   syzbot <syzbot+38655f1298fefc58a904@syzkaller.appspotmail.com>
To:     linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    6feb57c2fd7c Merge tag 'kbuild-v6.2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135ef9f0480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3fb546de56fbf8d
dashboard link: https://syzkaller.appspot.com/bug?extid=38655f1298fefc58a904
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1295765f880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1309bb20480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/81556e491789/disk-6feb57c2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/065c943ec9de/vmlinux-6feb57c2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66e98c522c1f/bzImage-6feb57c2.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/e130cbdf95f5/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/33763b071115/mount_6.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38655f1298fefc58a904@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-syzkaller-13822-g6feb57c2fd7c #0 Not tainted
------------------------------------------------------
syz-executor102/5793 is trying to acquire lock:
ffff88802bd68158 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock+0x17/0x50 include/linux/mmap_lock.h:117

but task is already holding lock:
ffff8880291240e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_iterate+0x1cc/0x34c0 fs/exfat/dir.c:226

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->s_lock){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       exfat_get_block+0x191/0x1e20 fs/exfat/inode.c:281
       do_mpage_readpage+0x970/0x1c50 fs/mpage.c:208
       mpage_readahead+0x210/0x380 fs/mpage.c:361
       read_pages+0x169/0x9c0 mm/readahead.c:161
       page_cache_ra_unbounded+0x703/0x820 mm/readahead.c:270
       page_cache_sync_readahead include/linux/pagemap.h:1210 [inline]
       filemap_get_pages+0x465/0x10d0 mm/filemap.c:2600
       filemap_read+0x3cf/0xea0 mm/filemap.c:2694
       __kernel_read+0x3fc/0x830 fs/read_write.c:428
       integrity_kernel_read+0xac/0xf0 security/integrity/iint.c:199
       ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
       ima_calc_file_hash+0x178f/0x1ca0 security/integrity/ima/ima_crypto.c:573
       ima_collect_measurement+0x444/0x8c0 security/integrity/ima/ima_api.c:292
       process_measurement+0xf41/0x1bc0 security/integrity/ima/ima_main.c:339
       ima_file_check+0xd8/0x130 security/integrity/ima/ima_main.c:519
       do_open fs/namei.c:3559 [inline]
       path_openat+0x2600/0x2dd0 fs/namei.c:3714
       do_filp_open+0x264/0x4f0 fs/namei.c:3741
       do_sys_openat2+0x124/0x4e0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_open fs/open.c:1334 [inline]
       __se_sys_open fs/open.c:1330 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1330
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (mapping.invalidate_lock#3){.+.+}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_read+0x39/0x50 kernel/locking/rwsem.c:1509
       filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
       filemap_fault+0x2fb/0x1060 mm/filemap.c:3146
       __do_fault+0x136/0x4f0 mm/memory.c:4163
       do_read_fault mm/memory.c:4514 [inline]
       do_fault mm/memory.c:4643 [inline]
       handle_pte_fault mm/memory.c:4931 [inline]
       __handle_mm_fault mm/memory.c:5073 [inline]
       handle_mm_fault+0x2066/0x26b0 mm/memory.c:5219
       do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
       handle_page_fault arch/x86/mm/fault.c:1519 [inline]
       exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
       asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
       strncpy_from_user+0x150/0x330 lib/strncpy_from_user.c:139
       getname_flags+0xf5/0x4e0 fs/namei.c:150
       do_sys_openat2+0xba/0x4e0 fs/open.c:1304
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_open fs/open.c:1334 [inline]
       __se_sys_open fs/open.c:1330 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1330
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_read+0x39/0x50 kernel/locking/rwsem.c:1509
       mmap_read_lock+0x17/0x50 include/linux/mmap_lock.h:117
       do_user_addr_fault+0x4b7/0xcb0 arch/x86/mm/fault.c:1379
       handle_page_fault arch/x86/mm/fault.c:1519 [inline]
       exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
       asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
       filldir64+0x2df/0x660 fs/readdir.c:331
       dir_emit_dot include/linux/fs.h:3568 [inline]
       dir_emit_dots include/linux/fs.h:3579 [inline]
       exfat_iterate+0x2e4/0x34c0 fs/exfat/dir.c:229
       iterate_dir+0x257/0x5f0
       __do_sys_getdents64 fs/readdir.c:369 [inline]
       __se_sys_getdents64+0x1db/0x4c0 fs/readdir.c:354
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> mapping.invalidate_lock#3 --> &sbi->s_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->s_lock);
                               lock(mapping.invalidate_lock#3);
                               lock(&sbi->s_lock);
  lock(&mm->mmap_lock);

 *** DEADLOCK ***

3 locks held by syz-executor102/5793:
 #0: ffff888012b5e0e8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x242/0x2e0 fs/file.c:1046
 #1: ffff8880731d5730 (&sb->s_type->i_mutex_key#20){++++}-{3:3}, at: iterate_dir+0x147/0x5f0 fs/readdir.c:57
 #2: ffff8880291240e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_iterate+0x1cc/0x34c0 fs/exfat/dir.c:226

stack backtrace:
CPU: 0 PID: 5793 Comm: syz-executor102 Not tainted 6.1.0-syzkaller-13822-g6feb57c2fd7c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 down_read+0x39/0x50 kernel/locking/rwsem.c:1509
 mmap_read_lock+0x17/0x50 include/linux/mmap_lock.h:117
 do_user_addr_fault+0x4b7/0xcb0 arch/x86/mm/fault.c:1379
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:filldir64+0x2df/0x660 fs/readdir.c:335
Code: 5c 24 20 48 89 de e8 10 79 95 ff 83 7c 24 18 00 0f 88 4b 02 00 00 48 39 dd 0f 82 42 02 00 00 0f 01 cb 0f ae e8 48 8b 44 24 60 <48> 89 43 08 e8 a8 76 95 ff 48 8b 04 24 48 8b 4c 24 68 48 89 08 e8
RSP: 0018:ffffc90005aff6f8 EFLAGS: 00050206
RAX: 0000000000000000 RBX: 00000000200022c0 RCX: 0000000000000000
RDX: ffff88801f510000 RSI: 00000000200022c0 RDI: 00007fffffffefe8
RBP: 00007fffffffefe8 R08: ffffffff81f66420 R09: 0000000000000004
R10: 0000000000000003 R11: ffff88801f510000 R12: ffffffff8b076a40
R13: dffffc0000000000 R14: 0000000000000001 R15: ffffc90005affe70
 dir_emit_dot include/linux/fs.h:3568 [inline]
 dir_emit_dots include/linux/fs.h:3579 [inline]
 exfat_iterate+0x2e4/0x34c0 fs/exfat/dir.c:229
 iterate_dir+0x257/0x5f0
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64+0x1db/0x4c0 fs/readdir.c:354
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb9bfdcf5f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb9b716e208 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007fb9bfe54558 RCX: 00007fb9bfdcf5f9
RDX: 0000000000000018 RSI: 00000000200022c0 RDI: 0000000000000004
RBP: 00007fb9bfe54550 R08: 00007fb9b716e700 R09: 0000000000000000
R10: 00007fb9b716e700 R11: 0000000000000246 R12: 00007fb9bfe5455c
R13: 00007ffd016b68ff R14: 00007fb9b716e300 R15: 0000000000022000
 </TASK>
----------------
Code disassembly (best guess):
   0:	5c                   	pop    %rsp
   1:	24 20                	and    $0x20,%al
   3:	48 89 de             	mov    %rbx,%rsi
   6:	e8 10 79 95 ff       	callq  0xff95791b
   b:	83 7c 24 18 00       	cmpl   $0x0,0x18(%rsp)
  10:	0f 88 4b 02 00 00    	js     0x261
  16:	48 39 dd             	cmp    %rbx,%rbp
  19:	0f 82 42 02 00 00    	jb     0x261
  1f:	0f 01 cb             	stac
  22:	0f ae e8             	lfence
  25:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
* 2a:	48 89 43 08          	mov    %rax,0x8(%rbx) <-- trapping instruction
  2e:	e8 a8 76 95 ff       	callq  0xff9576db
  33:	48 8b 04 24          	mov    (%rsp),%rax
  37:	48 8b 4c 24 68       	mov    0x68(%rsp),%rcx
  3c:	48 89 08             	mov    %rcx,(%rax)
  3f:	e8                   	.byte 0xe8

