Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39476C111C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 12:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCTLq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 07:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjCTLqy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:46:54 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B781C331
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 04:46:38 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id y195-20020a6bc8cc000000b007537a59961dso5354834iof.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 04:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679312798;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mslEE5rWUccfioYtuxOsHWzuisRr/hUjmrFi31WQruw=;
        b=VOzlCKjNcBzGLTAgUFEHhAmS75ZUDjxrNszqvjs19V4WPaGF9RMwYPREwFt6ygiF8w
         Af5s7ZNb5cZHj1cUIEcO3vn3nzXclNr09q5Ho7AhkGzolNtBom9QvIEuCT93wxCZOQoy
         NenUAzb040EJheX+WE1jrrXNSARw7vJ/tOXQkdQXfyWxulF5Rll99qSB9xyvy5Ft7NqL
         MGOAkiO1/1etx7E07moXgnnt7H9HNjA2FprJC88Rj7xyfMd6EBXGABR2PE1GdZqWdlDS
         iZSI1XOVhYNqM63qPnRPipBWpLjZqTYDQSE4ahVXhkL2Q0V5RqlXw3OeQ7aImgVG61IP
         BEFA==
X-Gm-Message-State: AO0yUKUqhewHpuCz3CmGpk2xsFwK04YDBbj1kluijCdcfgo+t+o3ENkp
        tdAFJ+PzEHEiEluSRdMSHdBgoFyPECBxZ5a/d/W4rmujHxqs
X-Google-Smtp-Source: AK7set/0rQVUEZGLzjwXaJ/Y2YqwXX0xjuD8uMYi9+wp98yMWccuj7RPHLcQnE9ueCWVteXu2kd+XmEcuWmOvcDLpo5ypj6Zcafg
MIME-Version: 1.0
X-Received: by 2002:a02:85a8:0:b0:406:5e9b:87bd with SMTP id
 d37-20020a0285a8000000b004065e9b87bdmr1959196jai.2.1679312797786; Mon, 20 Mar
 2023 04:46:37 -0700 (PDT)
Date:   Mon, 20 Mar 2023 04:46:37 -0700
In-Reply-To: <000000000000cd489f05f42f3c52@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c76c5405f7537ae4@google.com>
Subject: Re: [syzbot] [fat?] possible deadlock in exc_page_fault
From:   syzbot <syzbot+6d274a5dc4fa0974d4ad@syzkaller.appspotmail.com>
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

HEAD commit:    e8d018dd0257 Linux 6.3-rc3
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13c23186c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d40f6d44826f6cf7
dashboard link: https://syzkaller.appspot.com/bug?extid=6d274a5dc4fa0974d4ad
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16713fbec80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132c7281c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/36c3f1b07e1e/disk-e8d018dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b45f2ee6f521/vmlinux-e8d018dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f03104e87ec4/bzImage-e8d018dd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2573dec3d16b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d274a5dc4fa0974d4ad@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc3-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor377/6548 is trying to acquire lock:
ffff8880766bc998 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
ffff8880766bc998 (&mm->mmap_lock){++++}-{3:3}, at: do_user_addr_fault arch/x86/mm/fault.c:1358 [inline]
ffff8880766bc998 (&mm->mmap_lock){++++}-{3:3}, at: handle_page_fault arch/x86/mm/fault.c:1498 [inline]
ffff8880766bc998 (&mm->mmap_lock){++++}-{3:3}, at: exc_page_fault+0x486/0x7c0 arch/x86/mm/fault.c:1554

but task is already holding lock:
ffff88807c2640e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_iterate+0x171/0x3370 fs/exfat/dir.c:232

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->s_lock){+.+.}-{3:3}:
       lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
       __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
       exfat_get_block+0x1e5/0x2050 fs/exfat/inode.c:280
       do_mpage_readpage+0x911/0x1fa0 fs/mpage.c:208
       mpage_readahead+0x454/0x930 fs/mpage.c:356
       read_pages+0x183/0x830 mm/readahead.c:161
       page_cache_ra_unbounded+0x697/0x7c0 mm/readahead.c:270
       page_cache_sync_readahead include/linux/pagemap.h:1214 [inline]
       filemap_get_pages+0x49c/0x20c0 mm/filemap.c:2598
       filemap_read+0x45a/0x1170 mm/filemap.c:2693
       __kernel_read+0x422/0x8a0 fs/read_write.c:428
       integrity_kernel_read+0xb0/0xf0 security/integrity/iint.c:199
       ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
       ima_calc_file_hash+0xa5b/0x1c00 security/integrity/ima/ima_crypto.c:573
       ima_collect_measurement+0x3a7/0x880 security/integrity/ima/ima_api.c:293
       process_measurement+0xfdb/0x1ce0 security/integrity/ima/ima_main.c:341
       ima_file_check+0xf1/0x170 security/integrity/ima/ima_main.c:539
       do_open fs/namei.c:3562 [inline]
       path_openat+0x280a/0x3170 fs/namei.c:3715
       do_filp_open+0x234/0x490 fs/namei.c:3742
       do_sys_openat2+0x13f/0x500 fs/open.c:1348
       do_sys_open fs/open.c:1364 [inline]
       __do_sys_openat fs/open.c:1380 [inline]
       __se_sys_openat fs/open.c:1375 [inline]
       __x64_sys_openat+0x247/0x290 fs/open.c:1375
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (mapping.invalidate_lock#3){.+.+}-{3:3}:
       lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
       down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
       filemap_invalidate_lock_shared include/linux/fs.h:813 [inline]
       filemap_fault+0x644/0x1800 mm/filemap.c:3274
       __do_fault+0x136/0x500 mm/memory.c:4141
       do_read_fault mm/memory.c:4492 [inline]
       do_fault mm/memory.c:4621 [inline]
       handle_pte_fault mm/memory.c:4909 [inline]
       __handle_mm_fault mm/memory.c:5051 [inline]
       handle_mm_fault+0x3357/0x51c0 mm/memory.c:5197
       faultin_page mm/gup.c:925 [inline]
       __get_user_pages+0x512/0x1180 mm/gup.c:1147
       __get_user_pages_locked mm/gup.c:1381 [inline]
       __gup_longterm_locked+0x208c/0x2aa0 mm/gup.c:2079
       pin_user_pages_remote+0x136/0x200 mm/gup.c:3122
       process_vm_rw_single_vec mm/process_vm_access.c:105 [inline]
       process_vm_rw_core mm/process_vm_access.c:215 [inline]
       process_vm_rw+0x72b/0xcd0 mm/process_vm_access.c:283
       __do_sys_process_vm_readv mm/process_vm_access.c:295 [inline]
       __se_sys_process_vm_readv mm/process_vm_access.c:291 [inline]
       __x64_sys_process_vm_readv+0xe0/0xf0 mm/process_vm_access.c:291
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3832
       __lock_acquire+0x125b/0x1f80 kernel/locking/lockdep.c:5056
       lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
       down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
       mmap_read_lock include/linux/mmap_lock.h:117 [inline]
       do_user_addr_fault arch/x86/mm/fault.c:1358 [inline]
       handle_page_fault arch/x86/mm/fault.c:1498 [inline]
       exc_page_fault+0x486/0x7c0 arch/x86/mm/fault.c:1554
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
       filldir64+0x30b/0x720 fs/readdir.c:331
       dir_emit_dot include/linux/fs.h:3144 [inline]
       dir_emit_dots include/linux/fs.h:3155 [inline]
       exfat_iterate+0x2b8/0x3370 fs/exfat/dir.c:235
       iterate_dir+0x228/0x570
       __do_sys_getdents64 fs/readdir.c:369 [inline]
       __se_sys_getdents64+0x20d/0x4f0 fs/readdir.c:354
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
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

3 locks held by syz-executor377/6548:
 #0: ffff88802778c368 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x254/0x2f0 fs/file.c:1047
 #1: ffff8880747e1cb0 (&sb->s_type->i_mutex_key#14){++++}-{3:3}, at: iterate_dir+0x135/0x570 fs/readdir.c:57
 #2: ffff88807c2640e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_iterate+0x171/0x3370 fs/exfat/dir.c:232

stack backtrace:
CPU: 0 PID: 6548 Comm: syz-executor377 Not tainted 6.3.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x2fe/0x3b0 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3098 [inline]
 check_prevs_add kernel/locking/lockdep.c:3217 [inline]
 validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3832
 __lock_acquire+0x125b/0x1f80 kernel/locking/lockdep.c:5056
 lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
 down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
 mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 do_user_addr_fault arch/x86/mm/fault.c:1358 [inline]
 handle_page_fault arch/x86/mm/fault.c:1498 [inline]
 exc_page_fault+0x486/0x7c0 arch/x86/mm/fault.c:1554
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:filldir64+0x30b/0x720 fs/readdir.c:335
Code: 48 29 eb 48 89 df 4c 89 e6 e8 11 86 95 ff 85 ed 0f 88 48 02 00 00 4c 39 e3 0f 82 3f 02 00 00 0f 01 cb 0f ae e8 48 8b 44 24 58 <49> 89 44 24 08 48 8b 4c 24 10 48 8b 44 24 50 48 89 01 48 8b 44 24
RSP: 0018:ffffc9000543f6c8 EFLAGS: 00050206
RAX: 0000000000000000 RBX: 00007fffffffefe8 RCX: ffff8880275dba80
RDX: ffff8880275dba80 RSI: 0000000000000000 RDI: 00007fffffffefe8
RBP: 0000000000000018 R08: ffffffff81f4e91f R09: 0000000000000004
R10: 0000000000000003 R11: ffff8880275dba80 R12: 0000000000000000
R13: ffffc9000543fe70 R14: 0000000000000001 R15: ffffffff8afed560
 dir_emit_dot include/linux/fs.h:3144 [inline]
 dir_emit_dots include/linux/fs.h:3155 [inline]
 exfat_iterate+0x2b8/0x3370 fs/exfat/dir.c:235
 iterate_dir+0x228/0x570
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64+0x20d/0x4f0 fs/readdir.c:354
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f265ea7dab9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2656628208 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f265eb037b8 RCX: 00007f265ea7dab9
RDX: 0000000000008008 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007f265eb037b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f265eb037bc
R13: 00007ffc20585adf R14: 00007f2656628300 R15: 0000000000022000
 </TASK>
----------------
Code disassembly (best guess):
   0:	48 29 eb             	sub    %rbp,%rbx
   3:	48 89 df             	mov    %rbx,%rdi
   6:	4c 89 e6             	mov    %r12,%rsi
   9:	e8 11 86 95 ff       	callq  0xff95861f
   e:	85 ed                	test   %ebp,%ebp
  10:	0f 88 48 02 00 00    	js     0x25e
  16:	4c 39 e3             	cmp    %r12,%rbx
  19:	0f 82 3f 02 00 00    	jb     0x25e
  1f:	0f 01 cb             	stac
  22:	0f ae e8             	lfence
  25:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
* 2a:	49 89 44 24 08       	mov    %rax,0x8(%r12) <-- trapping instruction
  2f:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
  34:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  39:	48 89 01             	mov    %rax,(%rcx)
  3c:	48                   	rex.W
  3d:	8b                   	.byte 0x8b
  3e:	44                   	rex.R
  3f:	24                   	.byte 0x24

