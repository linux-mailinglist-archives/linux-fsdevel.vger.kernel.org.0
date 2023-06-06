Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C549723B65
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 10:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbjFFIYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 04:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjFFIYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:24:19 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83BC10F2
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 01:23:59 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-778d823038bso98670239f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 01:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686039837; x=1688631837;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GmdVMGO7161AbfmKlRwkxlxyLpSP8GMCycUAfMLHZFk=;
        b=Yj81Avfl8RyO/5n+/mZHivjDfJTFp1F5AXLSpuKWSLpx++DcLaXg7IsM3SehEtyRyv
         KpiknD7Fjo/b0ICMgc0CnSj0O6L2ABMietR9KLOmXYbR47cBXTV8MX1D9cdYbYVrHhSA
         P4T/+YF3bdKFDiXoP/JfVKPewsbaT0q/PLI0l3IyAoS97+bqB/Hwtxt66cW5DrmyzLhN
         a+WGkdn5BDrm8nPiJoqDiKy/PChxMBCxD5t18zGG/F5zlxIBbmmenVyaeOeyAGjehD+I
         jOEGr+QKRjWx5Mum5wQMvJx19HqJbie4Wg3dqEIqYDEjCq1am0T94RR+zTMWKNAJDdl2
         OKFA==
X-Gm-Message-State: AC+VfDzAgi2HXK7rEjsbI9mWJtdM4UMGIBsN1End3LvJ0S2e7EL8rTLo
        b1vKDOFx7PZWV6MK5mxRIe1khveHc1Woi5q5XJqveG+XoZwK
X-Google-Smtp-Source: ACHHUZ6tM69+smUl1iYcJFJLTGcRiFtpxwRCDf1kaerrJzhwwfG3v3+P3KDpx3NDsUOInk69K0pvnIE54nTHlKtpcZxECGiS1qSy
MIME-Version: 1.0
X-Received: by 2002:a6b:e609:0:b0:766:655b:37a3 with SMTP id
 g9-20020a6be609000000b00766655b37a3mr788978ioh.4.1686039837280; Tue, 06 Jun
 2023 01:23:57 -0700 (PDT)
Date:   Tue, 06 Jun 2023 01:23:57 -0700
In-Reply-To: <00000000000069948205f7fb357f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094131605fd71bd65@google.com>
Subject: Re: [syzbot] [fat?] possible deadlock in do_user_addr_fault
From:   syzbot <syzbot+278098b0faaf0595072b@syzkaller.appspotmail.com>
To:     linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    f8dba31b0a82 Merge tag 'asym-keys-fix-for-linus-v6.4-rc5' ..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13cd961d280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
dashboard link: https://syzkaller.appspot.com/bug?extid=278098b0faaf0595072b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144ccf79280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135fab79280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0aac0833aa9d/disk-f8dba31b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06f1060b83c8/vmlinux-f8dba31b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8450975febdf/bzImage-f8dba31b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a0a6e4ccb5ba/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+278098b0faaf0595072b@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc5-syzkaller-00002-gf8dba31b0a82 #0 Not tainted
------------------------------------------------------
syz-executor181/5187 is trying to acquire lock:
ffff88807ac63768 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:142 [inline]
ffff88807ac63768 (&mm->mmap_lock){++++}-{3:3}, at: do_user_addr_fault+0xb3d/0x1210 arch/x86/mm/fault.c:1391

but task is already holding lock:
ffff88801e4a00e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_iterate+0x111/0xb40 fs/exfat/dir.c:232

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->s_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
       exfat_get_block+0x18d/0x16e0 fs/exfat/inode.c:280
       do_mpage_readpage+0x768/0x1960 fs/mpage.c:234
       mpage_readahead+0x344/0x580 fs/mpage.c:382
       read_pages+0x1a2/0xd40 mm/readahead.c:161
       page_cache_ra_unbounded+0x477/0x5e0 mm/readahead.c:270
       do_page_cache_ra mm/readahead.c:300 [inline]
       page_cache_ra_order+0x6ec/0xa00 mm/readahead.c:560
       ondemand_readahead+0x6b3/0x1080 mm/readahead.c:682
       page_cache_sync_ra+0x1c9/0x200 mm/readahead.c:709
       page_cache_sync_readahead include/linux/pagemap.h:1211 [inline]
       filemap_get_pages+0x28d/0x1620 mm/filemap.c:2595
       filemap_read+0x35e/0xc70 mm/filemap.c:2690
       generic_file_read_iter+0x3ad/0x5b0 mm/filemap.c:2837
       __kernel_read+0x2ca/0x830 fs/read_write.c:428
       integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:192
       ima_calc_file_hash_tfm+0x2b3/0x3c0 security/integrity/ima/ima_crypto.c:485
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
       ima_calc_file_hash+0x195/0x4a0 security/integrity/ima/ima_crypto.c:573
       ima_collect_measurement+0x55b/0x670 security/integrity/ima/ima_api.c:293
       process_measurement+0xd2f/0x1930 security/integrity/ima/ima_main.c:341
       ima_file_check+0xba/0x100 security/integrity/ima/ima_main.c:539
       do_open fs/namei.c:3638 [inline]
       path_openat+0x15d3/0x2750 fs/namei.c:3791
       do_filp_open+0x1ba/0x410 fs/namei.c:3818
       do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x143/0x1f0 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (mapping.invalidate_lock#3){.+.+}-{3:3}:
       down_read+0x9c/0x480 kernel/locking/rwsem.c:1520
       filemap_invalidate_lock_shared include/linux/fs.h:830 [inline]
       filemap_fault+0xbba/0x24c0 mm/filemap.c:3271
       __do_fault+0x107/0x600 mm/memory.c:4176
       do_read_fault mm/memory.c:4530 [inline]
       do_fault mm/memory.c:4659 [inline]
       do_pte_missing mm/memory.c:3647 [inline]
       handle_pte_fault mm/memory.c:4947 [inline]
       __handle_mm_fault+0x28bc/0x41c0 mm/memory.c:5089
       handle_mm_fault+0x2af/0x9f0 mm/memory.c:5243
       faultin_page mm/gup.c:925 [inline]
       __get_user_pages+0x60a/0x10e0 mm/gup.c:1147
       __get_user_pages_locked mm/gup.c:1381 [inline]
       __gup_longterm_locked+0x720/0x2420 mm/gup.c:2079
       pin_user_pages_remote+0x101/0x160 mm/gup.c:3124
       process_vm_rw_single_vec mm/process_vm_access.c:105 [inline]
       process_vm_rw_core.constprop.0+0x43b/0x990 mm/process_vm_access.c:215
       process_vm_rw+0x29c/0x300 mm/process_vm_access.c:283
       __do_sys_process_vm_readv mm/process_vm_access.c:295 [inline]
       __se_sys_process_vm_readv mm/process_vm_access.c:291 [inline]
       __x64_sys_process_vm_readv+0xe3/0x1b0 mm/process_vm_access.c:291
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3113 [inline]
       check_prevs_add kernel/locking/lockdep.c:3232 [inline]
       validate_chain kernel/locking/lockdep.c:3847 [inline]
       __lock_acquire+0x2fcd/0x5f30 kernel/locking/lockdep.c:5088
       lock_acquire kernel/locking/lockdep.c:5705 [inline]
       lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
       down_read+0x9c/0x480 kernel/locking/rwsem.c:1520
       mmap_read_lock include/linux/mmap_lock.h:142 [inline]
       do_user_addr_fault+0xb3d/0x1210 arch/x86/mm/fault.c:1391
       handle_page_fault arch/x86/mm/fault.c:1534 [inline]
       exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1590
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
       filldir64+0x291/0x5d0 fs/readdir.c:335
       dir_emit_dot include/linux/fs.h:3163 [inline]
       dir_emit_dots include/linux/fs.h:3174 [inline]
       exfat_iterate+0x56b/0xb40 fs/exfat/dir.c:235
       iterate_dir+0x1fd/0x6f0 fs/readdir.c:67
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

3 locks held by syz-executor181/5187:
 #0: ffff88802aa4c868 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe7/0x100 fs/file.c:1047
 #1: ffff8880700077b0 (&sb->s_type->i_mutex_key#15){++++}-{3:3}, at: iterate_dir+0x504/0x6f0 fs/readdir.c:57
 #2: ffff88801e4a00e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_iterate+0x111/0xb40 fs/exfat/dir.c:232

stack backtrace:
CPU: 0 PID: 5187 Comm: syz-executor181 Not tainted 6.4.0-rc5-syzkaller-00002-gf8dba31b0a82 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3113 [inline]
 check_prevs_add kernel/locking/lockdep.c:3232 [inline]
 validate_chain kernel/locking/lockdep.c:3847 [inline]
 __lock_acquire+0x2fcd/0x5f30 kernel/locking/lockdep.c:5088
 lock_acquire kernel/locking/lockdep.c:5705 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
 down_read+0x9c/0x480 kernel/locking/rwsem.c:1520
 mmap_read_lock include/linux/mmap_lock.h:142 [inline]
 do_user_addr_fault+0xb3d/0x1210 arch/x86/mm/fault.c:1391
 handle_page_fault arch/x86/mm/fault.c:1534 [inline]
 exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1590
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:filldir64+0x291/0x5d0 fs/readdir.c:335
Code: 02 41 83 e7 01 44 89 fe e8 9c c2 98 ff 45 84 ff 0f 84 9a fe ff ff e9 40 ff ff ff e8 a9 c6 98 ff 0f 01 cb 0f ae e8 48 8b 04 24 <49> 89 47 08 e8 96 c6 98 ff 4c 8b 7c 24 28 48 8b 7c 24 10 49 89 3f
RSP: 0018:ffffc90003c5fbf8 EFLAGS: 00050293
RAX: 0000000000000000 RBX: ffffc90003c5fe98 RCX: 0000000000000000
RDX: ffff88801fa55940 RSI: ffffffff81eb7f97 RDI: 0000000000000006
RBP: 0000000000000018 R08: 0000000000000006 R09: 0000000000000000
R10: 0000000000000018 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000018 R14: ffffffff8a662e00 R15: 0000000000000000
 dir_emit_dot include/linux/fs.h:3163 [inline]
 dir_emit_dots include/linux/fs.h:3174 [inline]
 exfat_iterate+0x56b/0xb40 fs/exfat/dir.c:235
 iterate_dir+0x1fd/0x6f0 fs/readdir.c:67
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64 fs/readdir.c:354 [inline]
 __x64_sys_getdents64+0x13e/0x2c0 fs/readdir.c:354
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f804978aab9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8041335208 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f80498107b8 RCX: 00007f804978aab9
RDX: 0000000000008008 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007f80498107b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f80498107bc
R13: 00007fff6d2c4cff R14: 00007f8041335300 R15: 0000000000022000
 </TASK>
----------------
Code disassembly (best guess):
   0:	02 41 83             	add    -0x7d(%rcx),%al
   3:	e7 01                	out    %eax,$0x1
   5:	44 89 fe             	mov    %r15d,%esi
   8:	e8 9c c2 98 ff       	callq  0xff98c2a9
   d:	45 84 ff             	test   %r15b,%r15b
  10:	0f 84 9a fe ff ff    	je     0xfffffeb0
  16:	e9 40 ff ff ff       	jmpq   0xffffff5b
  1b:	e8 a9 c6 98 ff       	callq  0xff98c6c9
  20:	0f 01 cb             	stac
  23:	0f ae e8             	lfence
  26:	48 8b 04 24          	mov    (%rsp),%rax
* 2a:	49 89 47 08          	mov    %rax,0x8(%r15) <-- trapping instruction
  2e:	e8 96 c6 98 ff       	callq  0xff98c6c9
  33:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
  38:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  3d:	49 89 3f             	mov    %rdi,(%r15)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
