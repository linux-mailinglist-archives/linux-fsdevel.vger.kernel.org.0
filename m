Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F361644AE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 19:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLFSKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 13:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiLFSKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:10:42 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9043B9F0
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Dec 2022 10:10:40 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id l16-20020a056e02067000b0030325bbd570so14829175ilt.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Dec 2022 10:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkJUDsie/P6JAxGB6b7qaxygEnxK9HqNfSQWvebmG7Y=;
        b=2NpOK0WejCzQPlZGUZN0fcX8bAhgeitfjf8OT+eNzr84Un5DFMEQuk5E38Cz6iYM5O
         Amn/Es/4JsU0GTviY6TktzpW8q44D2seRBPmV0QjNu7teD7wxF+FWcSq/gIQWGmlSpla
         STHh1A8G/V1nPpon8ZOJFJw65ctWR59V5MZHQKxUBeGW0QHFdZV0yliiCvsv7qe8GOic
         SyIc1dyl0lgtHNI7I1Yp9NHBfENXGTljRrvfvUwOsUa48IdhOPes8pn0yW1Dx8nBDHG3
         2UjrEcdCR9qDngdx3CGgwfpfHumYo6EzAt9lpQJ9taksX1FOWrXhFs2q9HA4UcXRHHjy
         QCsQ==
X-Gm-Message-State: ANoB5pmChqLaCPNlJDeXUBJKb10GVE8d78M/lS5zM/bX95zwV7VSPTAg
        yKYEs18AbKCAd+5wd3WFaYdXGS4dDKc3NWpI4AdU7gldH2TQ
X-Google-Smtp-Source: AA0mqf5xvvr32K/g3UTvlTV+UkuuIePkaR0zG9UCa5rHMDy73cwemMEDORh26OiZXE4F1Q5t2EaPrG3Ps9NnbsfJ1O+lWwcPde+q
MIME-Version: 1.0
X-Received: by 2002:a05:6602:234a:b0:6df:f7fd:52bc with SMTP id
 r10-20020a056602234a00b006dff7fd52bcmr6690862iot.90.1670350239865; Tue, 06
 Dec 2022 10:10:39 -0800 (PST)
Date:   Tue, 06 Dec 2022 10:10:39 -0800
In-Reply-To: <0000000000008aa01105ec98487b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2a41005ef2cb89f@google.com>
Subject: Re: [syzbot] possible deadlock in filemap_fault
From:   syzbot <syzbot+7736960b837908f3a81d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=176e216b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17289a2f880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15215fc3880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e6f9575381c5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7736960b837908f3a81d@syzkaller.appspotmail.com

exfat: Deprecated parameter 'utf8'
exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0x207d53fc, utbl_chksum : 0xe619d30d)
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0 Not tainted
------------------------------------------------------
syz-executor581/3072 is trying to acquire lock:
ffff0000caee1060 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
ffff0000caee1060 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_fault+0x104/0x7fc mm/filemap.c:3127

but task is already holding lock:
ffff0000c02520c8 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
ffff0000c02520c8 (&mm->mmap_lock){++++}-{3:3}, at: do_page_fault+0x1ec/0x79c arch/arm64/mm/fault.c:589

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&mm->mmap_lock){++++}-{3:3}:
       __might_fault+0x7c/0xb4 mm/memory.c:5645
       filldir64+0x1e8/0x574 fs/readdir.c:335
       dir_emit_dot include/linux/fs.h:3569 [inline]
       dir_emit_dots include/linux/fs.h:3580 [inline]
       exfat_iterate+0xd4/0xcb4 fs/exfat/dir.c:231
       iterate_dir+0x114/0x28c
       __do_sys_getdents64 fs/readdir.c:369 [inline]
       __se_sys_getdents64 fs/readdir.c:354 [inline]
       __arm64_sys_getdents64+0x80/0x204 fs/readdir.c:354
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #1 (&sbi->s_lock){+.+.}-{3:3}:
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
       call_read_iter include/linux/fs.h:2193 [inline]
       aio_read+0x170/0x254 fs/aio.c:1560
       __io_submit_one+0x218/0x5e4
       io_submit_one+0x2c4/0x4bc fs/aio.c:2019
       __do_sys_io_submit+0x16c/0x2ac fs/aio.c:2078
       __se_sys_io_submit fs/aio.c:2048 [inline]
       __arm64_sys_io_submit+0x24/0x34 fs/aio.c:2048
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #0 (mapping.invalidate_lock#3){.+.+}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1509
       filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
       filemap_fault+0x104/0x7fc mm/filemap.c:3127
       __do_fault+0x60/0x358 mm/memory.c:4202
       do_read_fault mm/memory.c:4553 [inline]
       do_fault+0x338/0x550 mm/memory.c:4682
       handle_pte_fault mm/memory.c:4954 [inline]
       __handle_mm_fault mm/memory.c:5096 [inline]
       handle_mm_fault+0x78c/0xa48 mm/memory.c:5217
       __do_page_fault arch/arm64/mm/fault.c:508 [inline]
       do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:608
       do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:691
       do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:827
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
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

other info that might help us debug this:

Chain exists of:
  mapping.invalidate_lock#3 --> &sbi->s_lock --> &mm->mmap_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock);
                               lock(&sbi->s_lock);
                               lock(&mm->mmap_lock);
  lock(mapping.invalidate_lock#3);

 *** DEADLOCK ***

1 lock held by syz-executor581/3072:
 #0: ffff0000c02520c8 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
 #0: ffff0000c02520c8 (&mm->mmap_lock){++++}-{3:3}, at: do_page_fault+0x1ec/0x79c arch/arm64/mm/fault.c:589

stack backtrace:
CPU: 0 PID: 3072 Comm: syz-executor581 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
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
 down_read+0x5c/0x78 kernel/locking/rwsem.c:1509
 filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
 filemap_fault+0x104/0x7fc mm/filemap.c:3127
 __do_fault+0x60/0x358 mm/memory.c:4202
 do_read_fault mm/memory.c:4553 [inline]
 do_fault+0x338/0x550 mm/memory.c:4682
 handle_pte_fault mm/memory.c:4954 [inline]
 __handle_mm_fault mm/memory.c:5096 [inline]
 handle_mm_fault+0x78c/0xa48 mm/memory.c:5217
 __do_page_fault arch/arm64/mm/fault.c:508 [inline]
 do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:608
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:691
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:827
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
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

