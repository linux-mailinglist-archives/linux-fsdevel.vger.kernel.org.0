Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C758752D37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 00:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjGMWuO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 18:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjGMWuN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 18:50:13 -0400
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E042D2D61
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 15:50:09 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-39e94a06009so2121237b6e.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 15:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689288609; x=1691880609;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiG7QsHYS4bYE/ecIBoQBPgtKp+SZ4lcp7NGeemCj58=;
        b=fSnyQa5Yd9LBfHuYU6r1ygRPTyg65LR1Dgjnmty6WFj2UAkE+6ihJddjdaq01rIMIp
         1ilR/zWXD9HPAPhnadFOxrnLvQrb92xy5Az1T8XsagbIJvH9yNg8IKo+P9YozIN2rGoC
         vXxuJwBFUj8ck/dWcNTzP6zirrcAhntMRTO7p07A/lUD8HzOsnRMg5MvWbPk7ZduKtGg
         ok+Q2HOzMCzWiPpgdBXcRxW5jH6/YUIL6X9EDH52ilgxS36huBvAuGmpqjUm+ibO1h7F
         zNFlwbwRZNIHKPMOIGvwl0ByIuedDIP/TiXEzmp7bAvDo3JZpwtRwzgYypTAy/NPw6f9
         gI3w==
X-Gm-Message-State: ABy/qLYn9vJXp/CqbTz7W5p7th2Abiyg+O1WuMEVabKXE2rU4Z+POrYx
        kmwaSNuj6TLvJynVmnV5atow+xk6GmWw01aH+hoxCuPRc/ts
X-Google-Smtp-Source: APBJJlE0XhfdYLbBnrEKZH288NoziIdfo7puEoE2XhiCGqUo3BD5oLLpAklh578BZovdH/yokFdkGZjMXnii0ZsdxTd/LEIQgJlw
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1308:b0:3a2:4d1d:2831 with SMTP id
 y8-20020a056808130800b003a24d1d2831mr4083020oiv.3.1689288609163; Thu, 13 Jul
 2023 15:50:09 -0700 (PDT)
Date:   Thu, 13 Jul 2023 15:50:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078ee7e060066270b@google.com>
Subject: [syzbot] [fat?] possible deadlock in lock_mm_and_find_vma
From:   syzbot <syzbot+1741a5d9b79989c10bdc@syzkaller.appspotmail.com>
To:     linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    123212f53f3e Add linux-next specific files for 20230707
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1280756ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15ec80b62f588543
dashboard link: https://syzkaller.appspot.com/bug?extid=1741a5d9b79989c10bdc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11571cbca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171b7dc2a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/098f7ee2237c/disk-123212f5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88defebbfc49/vmlinux-123212f5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d5e9343ec16a/bzImage-123212f5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4d36f82ce652/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1741a5d9b79989c10bdc@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-next-20230707-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor330/5073 is trying to acquire lock:
ffff8880218527a0 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable include/linux/mmap_lock.h:151 [inline]
ffff8880218527a0 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:5293 [inline]
ffff8880218527a0 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x369/0x510 mm/memory.c:5344

but task is already holding lock:
ffff888019f760e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_iterate+0x117/0xb50 fs/exfat/dir.c:232

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->s_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
       exfat_get_block+0x18d/0x16e0 fs/exfat/inode.c:280
       do_mpage_readpage+0x768/0x1960 fs/mpage.c:234
       mpage_readahead+0x344/0x580 fs/mpage.c:382
       read_pages+0x1a2/0xd40 mm/readahead.c:160
       page_cache_ra_unbounded+0x477/0x5e0 mm/readahead.c:269
       do_page_cache_ra mm/readahead.c:299 [inline]
       page_cache_ra_order+0x6ec/0xa00 mm/readahead.c:559
       ondemand_readahead+0x6b3/0x1080 mm/readahead.c:681
       page_cache_sync_ra+0x1c0/0x1f0 mm/readahead.c:708
       page_cache_sync_readahead include/linux/pagemap.h:1230 [inline]
       filemap_get_pages+0x28d/0x1660 mm/filemap.c:2564
       filemap_read+0x365/0xc40 mm/filemap.c:2660
       generic_file_read_iter+0x34c/0x450 mm/filemap.c:2839
       __kernel_read+0x2ca/0x870 fs/read_write.c:428
       integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:195
       ima_calc_file_hash_tfm+0x2b9/0x3c0 security/integrity/ima/ima_crypto.c:485
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
       ima_calc_file_hash+0x198/0x4b0 security/integrity/ima/ima_crypto.c:573
       ima_collect_measurement+0x5a8/0x6b0 security/integrity/ima/ima_api.c:289
       process_measurement+0xd32/0x1940 security/integrity/ima/ima_main.c:345
       ima_file_check+0xba/0x100 security/integrity/ima/ima_main.c:543
       do_open fs/namei.c:3638 [inline]
       path_openat+0x1588/0x2710 fs/namei.c:3793
       do_filp_open+0x1ba/0x410 fs/namei.c:3820
       do_sys_openat2+0x160/0x1c0 fs/open.c:1407
       do_sys_open fs/open.c:1422 [inline]
       __do_sys_openat fs/open.c:1438 [inline]
       __se_sys_openat fs/open.c:1433 [inline]
       __x64_sys_openat+0x143/0x1f0 fs/open.c:1433
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (mapping.invalidate_lock#3){.+.+}-{3:3}:
       down_read+0x9c/0x480 kernel/locking/rwsem.c:1520
       filemap_invalidate_lock_shared include/linux/fs.h:826 [inline]
       filemap_fault+0xba8/0x2490 mm/filemap.c:3291
       __do_fault+0x107/0x600 mm/memory.c:4208
       do_read_fault mm/memory.c:4557 [inline]
       do_fault mm/memory.c:4680 [inline]
       do_pte_missing mm/memory.c:3673 [inline]
       handle_pte_fault mm/memory.c:4949 [inline]
       __handle_mm_fault+0x2ac5/0x3dd0 mm/memory.c:5089
       handle_mm_fault+0x2a1/0x9e0 mm/memory.c:5254
       faultin_page mm/gup.c:952 [inline]
       __get_user_pages+0x4d3/0x10e0 mm/gup.c:1235
       __get_user_pages_locked mm/gup.c:1500 [inline]
       __gup_longterm_locked+0x6f9/0x23e0 mm/gup.c:2194
       pin_user_pages_remote+0xee/0x140 mm/gup.c:3335
       process_vm_rw_single_vec mm/process_vm_access.c:105 [inline]
       process_vm_rw_core.constprop.0+0x437/0x980 mm/process_vm_access.c:215
       process_vm_rw+0x29c/0x300 mm/process_vm_access.c:283
       __do_sys_process_vm_readv mm/process_vm_access.c:295 [inline]
       __se_sys_process_vm_readv mm/process_vm_access.c:291 [inline]
       __x64_sys_process_vm_readv+0xe3/0x1b0 mm/process_vm_access.c:291
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3142 [inline]
       check_prevs_add kernel/locking/lockdep.c:3261 [inline]
       validate_chain kernel/locking/lockdep.c:3876 [inline]
       __lock_acquire+0x2e9d/0x5e20 kernel/locking/lockdep.c:5144
       lock_acquire kernel/locking/lockdep.c:5761 [inline]
       lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
       down_read_killable+0x9f/0x4f0 kernel/locking/rwsem.c:1543
       mmap_read_lock_killable include/linux/mmap_lock.h:151 [inline]
       get_mmap_lock_carefully mm/memory.c:5293 [inline]
       lock_mm_and_find_vma+0x369/0x510 mm/memory.c:5344
       do_user_addr_fault+0x2c6/0x10a0 arch/x86/mm/fault.c:1387
       handle_page_fault arch/x86/mm/fault.c:1509 [inline]
       exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1565
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
       filldir64+0x291/0x5d0 fs/readdir.c:335
       dir_emit_dot include/linux/fs.h:3198 [inline]
       dir_emit_dots include/linux/fs.h:3209 [inline]
       exfat_iterate+0x577/0xb50 fs/exfat/dir.c:235
       iterate_dir+0x20c/0x750 fs/readdir.c:67
       __do_sys_getdents64 fs/readdir.c:369 [inline]
       __se_sys_getdents64 fs/readdir.c:354 [inline]
       __x64_sys_getdents64+0x13e/0x2c0 fs/readdir.c:354
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
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
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

3 locks held by syz-executor330/5073:
 #0: ffff88807a9d6ac8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xd7/0xf0 fs/file.c:1047
 #1: ffff888075236f90 (&sb->s_type->i_mutex_key#15){++++}-{3:3}, at: iterate_dir+0x545/0x750 fs/readdir.c:57
 #2: ffff888019f760e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_iterate+0x117/0xb50 fs/exfat/dir.c:232

stack backtrace:
CPU: 1 PID: 5073 Comm: syz-executor330 Not tainted 6.4.0-next-20230707-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x2df/0x3b0 kernel/locking/lockdep.c:2195
 check_prev_add kernel/locking/lockdep.c:3142 [inline]
 check_prevs_add kernel/locking/lockdep.c:3261 [inline]
 validate_chain kernel/locking/lockdep.c:3876 [inline]
 __lock_acquire+0x2e9d/0x5e20 kernel/locking/lockdep.c:5144
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
 down_read_killable+0x9f/0x4f0 kernel/locking/rwsem.c:1543
 mmap_read_lock_killable include/linux/mmap_lock.h:151 [inline]
 get_mmap_lock_carefully mm/memory.c:5293 [inline]
 lock_mm_and_find_vma+0x369/0x510 mm/memory.c:5344
 do_user_addr_fault+0x2c6/0x10a0 arch/x86/mm/fault.c:1387
 handle_page_fault arch/x86/mm/fault.c:1509 [inline]
 exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1565
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:filldir64+0x291/0x5d0 fs/readdir.c:335
Code: 02 41 83 e7 01 44 89 fe e8 6c 61 99 ff 45 84 ff 0f 84 9a fe ff ff e9 40 ff ff ff e8 f9 64 99 ff 0f 01 cb 0f ae e8 48 8b 04 24 <49> 89 47 08 e8 e6 64 99 ff 4c 8b 7c 24 28 48 8b 7c 24 10 49 89 3f
RSP: 0018:ffffc90003b0fbf8 EFLAGS: 00050293
RAX: 0000000000000000 RBX: ffffc90003b0fe98 RCX: 0000000000000000
RDX: ffff888021549dc0 RSI: ffffffff81eb8397 RDI: 0000000000000006
RBP: 0000000000000018 R08: 0000000000000006 R09: 0000000000000000
R10: 0000000000000018 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000018 R14: ffffffff8a865cc0 R15: 0000000000000000
 dir_emit_dot include/linux/fs.h:3198 [inline]
 dir_emit_dots include/linux/fs.h:3209 [inline]
 exfat_iterate+0x577/0xb50 fs/exfat/dir.c:235
 iterate_dir+0x20c/0x750 fs/readdir.c:67
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64 fs/readdir.c:354 [inline]
 __x64_sys_getdents64+0x13e/0x2c0 fs/readdir.c:354
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff0c3b4cab9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff0bb6f7208 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007ff0c3bd27b8 RCX: 00007ff0c3b4cab9
RDX: 0000000000008008 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007ff0c3bd27b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff0c3bd27bc
R13: 00007ffe85f2080f R14: 00007ff0bb6f7300 R15: 0000000000022000
 </TASK>
----------------
Code disassembly (best guess):
   0:	02 41 83             	add    -0x7d(%rcx),%al
   3:	e7 01                	out    %eax,$0x1
   5:	44 89 fe             	mov    %r15d,%esi
   8:	e8 6c 61 99 ff       	callq  0xff996179
   d:	45 84 ff             	test   %r15b,%r15b
  10:	0f 84 9a fe ff ff    	je     0xfffffeb0
  16:	e9 40 ff ff ff       	jmpq   0xffffff5b
  1b:	e8 f9 64 99 ff       	callq  0xff996519
  20:	0f 01 cb             	stac
  23:	0f ae e8             	lfence
  26:	48 8b 04 24          	mov    (%rsp),%rax
* 2a:	49 89 47 08          	mov    %rax,0x8(%r15) <-- trapping instruction
  2e:	e8 e6 64 99 ff       	callq  0xff996519
  33:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
  38:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  3d:	49 89 3f             	mov    %rdi,(%r15)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
