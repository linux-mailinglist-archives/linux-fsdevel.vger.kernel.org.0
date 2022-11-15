Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFD9629632
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 11:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiKOKrt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 05:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiKOKrr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:47:47 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A8620363
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 02:47:45 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id g4-20020a92cda4000000b00301ff06da14so10972415ild.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 02:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+aj7sEnxyD8T1Hj1HdidLCP7lfPYY5s0kIBRkasNpCg=;
        b=kO53e/dgfpiY4lfOtFbgN8SrjRYNE32WkmVQh5eJ8S0mnx+HMhERgYtovSi9qUsUJx
         9+Y+dNA0PXINiBn8Ylt9Pp+dodRbVllka6IqdvuBwaxXSxqf6iLh8rTRz8jhXyRZyVor
         fQstZmxjU2y/LtZ78D13K5KPxG54Q1GbWDaTb4IelRfgMdLJpkRwdY2zDYIS91FDiwGd
         8YF9r0cyeKuvR6EK3sG21MPLljsP+xv1/JKgwTnj7ZwMDNuPe/PrynGYhhzUbSLdCwkY
         hEblfqcI7ZkDPH1/f7xTMlpnr/TN79yjXNEXXm7onY3smbtImAu7Bh+HFP/0oeaqmzbu
         d9UA==
X-Gm-Message-State: ANoB5pm171QR4bE4VMzXlxuMfUFTl5uchSlU97/3H1hESex76ZmwmeHw
        K/Rn2++V0+XhWAJS5hfCD8AAInlYs+/rsYuMyHUoCbl6bDk2
X-Google-Smtp-Source: AA0mqf6gL29lopecN6Qn5wRvRHA/S2lB6Vr8RC1Ti9+zJ4sPVawvatJREZTSAlwpw5zITxjO6hUOwQhGiXvzBBwYlosi4s+o+IhG
MIME-Version: 1.0
X-Received: by 2002:a92:190f:0:b0:2f9:d6cf:6b71 with SMTP id
 15-20020a92190f000000b002f9d6cf6b71mr7633874ilz.215.1668509264579; Tue, 15
 Nov 2022 02:47:44 -0800 (PST)
Date:   Tue, 15 Nov 2022 02:47:44 -0800
In-Reply-To: <00000000000073500205eac39838@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005146605ed801621@google.com>
Subject: Re: [syzbot] possible deadlock in exfat_get_block
From:   syzbot <syzbot+247e66a2c3ea756332c7@syzkaller.appspotmail.com>
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

HEAD commit:    9e4ce762f0e7 Merge branches 'for-next/acpi', 'for-next/asm..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=142ea0e9880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20ffacc1ce1c99b5
dashboard link: https://syzkaller.appspot.com/bug?extid=247e66a2c3ea756332c7
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cb6095880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ecada5880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a70eb29add74/disk-9e4ce762.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/769d096516a8/vmlinux-9e4ce762.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9309615f51d5/Image-9e4ce762.gz.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/709895381a4a/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/b69a1a37527d/mount_3.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+247e66a2c3ea756332c7@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc5-syzkaller-32254-g9e4ce762f0e7 #0 Not tainted
------------------------------------------------------
syz-executor410/3072 is trying to acquire lock:
ffff0000cb6210e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_get_block+0x6c/0x9ec fs/exfat/inode.c:282

but task is already holding lock:
ffff0000ca589060 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
ffff0000ca589060 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x5c/0x400 mm/readahead.c:226

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (mapping.invalidate_lock#3){.+.+}-{3:3}:
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1509
       filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
       filemap_fault+0x104/0x7fc mm/filemap.c:3127
       __do_fault+0x60/0x358 mm/memory.c:4203
       do_read_fault mm/memory.c:4554 [inline]
       do_fault+0x338/0x550 mm/memory.c:4683
       handle_pte_fault mm/memory.c:4955 [inline]
       __handle_mm_fault mm/memory.c:5097 [inline]
       handle_mm_fault+0x78c/0xa48 mm/memory.c:5218
       __do_page_fault arch/arm64/mm/fault.c:506 [inline]
       do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:606
       do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:689
       do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:825
       el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:367
       el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:427
       el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:579
       do_strncpy_from_user lib/strncpy_from_user.c:41 [inline]
       strncpy_from_user+0x1a8/0x3d8 lib/strncpy_from_user.c:139
       getname_flags+0x84/0x278 fs/namei.c:150
       getname+0x28/0x38 fs/namei.c:218
       do_sys_openat2+0x78/0x22c fs/open.c:1304
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_openat fs/open.c:1342 [inline]
       __se_sys_openat fs/open.c:1337 [inline]
       __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       __might_fault+0x7c/0xb4 mm/memory.c:5646
       filldir64+0x1e8/0x574 fs/readdir.c:335
       dir_emit_dot include/linux/fs.h:3561 [inline]
       dir_emit_dots include/linux/fs.h:3572 [inline]
       exfat_iterate+0xd4/0xcb4 fs/exfat/dir.c:231
       iterate_dir+0x114/0x28c
       __do_sys_getdents64 fs/readdir.c:369 [inline]
       __se_sys_getdents64 fs/readdir.c:354 [inline]
       __arm64_sys_getdents64+0x80/0x204 fs/readdir.c:354
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #0 (&sbi->s_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
       exfat_get_block+0x6c/0x9ec fs/exfat/inode.c:282
       do_mpage_readpage+0x474/0xd38 fs/mpage.c:208
       mpage_readahead+0xf0/0x1b8 fs/mpage.c:361
       exfat_readahead+0x28/0x38 fs/exfat/inode.c:345
       read_pages+0x8c/0x4f0 mm/readahead.c:161
       page_cache_ra_unbounded+0x374/0x400 mm/readahead.c:270
       do_page_cache_ra mm/readahead.c:300 [inline]
       page_cache_ra_order+0x348/0x380 mm/readahead.c:560
       ondemand_readahead+0x340/0x720 mm/readahead.c:682
       page_cache_sync_ra+0xc4/0xdc mm/readahead.c:709
       page_cache_sync_readahead include/linux/pagemap.h:1213 [inline]
       filemap_get_pages+0x118/0x598 mm/filemap.c:2581
       filemap_read+0x14c/0x6f4 mm/filemap.c:2675
       generic_file_read_iter+0x6c/0x25c mm/filemap.c:2821
       call_read_iter include/linux/fs.h:2185 [inline]
       new_sync_read fs/read_write.c:389 [inline]
       vfs_read+0x2d4/0x448 fs/read_write.c:470
       ksys_read+0xb4/0x160 fs/read_write.c:613
       __do_sys_read fs/read_write.c:623 [inline]
       __se_sys_read fs/read_write.c:621 [inline]
       __arm64_sys_read+0x24/0x34 fs/read_write.c:621
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

other info that might help us debug this:

Chain exists of:
  &sbi->s_lock --> &mm->mmap_lock --> mapping.invalidate_lock#3

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(mapping.invalidate_lock#3);
                               lock(&mm->mmap_lock);
                               lock(mapping.invalidate_lock#3);
  lock(&sbi->s_lock);

 *** DEADLOCK ***

1 lock held by syz-executor410/3072:
 #0: ffff0000ca589060 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
 #0: ffff0000ca589060 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x5c/0x400 mm/readahead.c:226

stack backtrace:
CPU: 0 PID: 3072 Comm: syz-executor410 Not tainted 6.1.0-rc5-syzkaller-32254-g9e4ce762f0e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2055
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 exfat_get_block+0x6c/0x9ec fs/exfat/inode.c:282
 do_mpage_readpage+0x474/0xd38 fs/mpage.c:208
 mpage_readahead+0xf0/0x1b8 fs/mpage.c:361
 exfat_readahead+0x28/0x38 fs/exfat/inode.c:345
 read_pages+0x8c/0x4f0 mm/readahead.c:161
 page_cache_ra_unbounded+0x374/0x400 mm/readahead.c:270
 do_page_cache_ra mm/readahead.c:300 [inline]
 page_cache_ra_order+0x348/0x380 mm/readahead.c:560
 ondemand_readahead+0x340/0x720 mm/readahead.c:682
 page_cache_sync_ra+0xc4/0xdc mm/readahead.c:709
 page_cache_sync_readahead include/linux/pagemap.h:1213 [inline]
 filemap_get_pages+0x118/0x598 mm/filemap.c:2581
 filemap_read+0x14c/0x6f4 mm/filemap.c:2675
 generic_file_read_iter+0x6c/0x25c mm/filemap.c:2821
 call_read_iter include/linux/fs.h:2185 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x2d4/0x448 fs/read_write.c:470
 ksys_read+0xb4/0x160 fs/read_write.c:613
 __do_sys_read fs/read_write.c:623 [inline]
 __se_sys_read fs/read_write.c:621 [inline]
 __arm64_sys_read+0x24/0x34 fs/read_write.c:621
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

