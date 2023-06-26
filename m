Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4737073EF46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 01:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjFZX1L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 19:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFZX1K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:27:10 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2D21991
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 16:27:06 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77ac4aa24eeso246577539f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 16:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687822026; x=1690414026;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FE7eOQ6/74oeIZdvdqPkRhpVUDYHXsfCQvi1FOCjECA=;
        b=JkpCX2WOYJrmNjLLrESgkm4UNs1eJ+QV846AWYHMsqpKRjuf7u6IIdXfnPxtz5dhjf
         8OKZIe1f2XQM4wbEL6BsIPUugUSHqDUo9RrzHBQbtiD1/1PtyH9wWx55c47jX8tOZ4fF
         itAidV9b2EfNraUJMYjxf7MnGbfvc/ZnhSuWnoX4AYPYTX+O1JL5GCW4AY75EV39+bXP
         xqal7uoZjIWMphy6b68JX8kFhWgfxZz3VFMDJWkn/Nl7IJgEI2mlM4/xQeU7/kAQ/3/e
         WbeoFLH8e7RyLpj3uiZfKNbAZBtkEgEih2Ki68gZuGZsJNnNy/TUbqA8HpYs1r9JDimb
         l9Ww==
X-Gm-Message-State: AC+VfDwb4paqQ1mRxCn0gkgsc14s3FEJ03V4Sl8XzgED7KTtJAmfR/QT
        yRHPQfuVGMDs88D3E1mnGAN8UDCR3nf9vzC9lNLexEpsJGoU
X-Google-Smtp-Source: ACHHUZ6JrAjQDx4qiIL3rLrDj+Z73qW/RR9V0K4OLtDfOm6xDOb40yJul7sxqoOdfKBhTFBOCiDEyPRxuKr7VUzdQkH6Ua6aiSNu
MIME-Version: 1.0
X-Received: by 2002:a02:2ac7:0:b0:41a:c455:f4c8 with SMTP id
 w190-20020a022ac7000000b0041ac455f4c8mr10603429jaw.3.1687822026138; Mon, 26
 Jun 2023 16:27:06 -0700 (PDT)
Date:   Mon, 26 Jun 2023 16:27:06 -0700
In-Reply-To: <000000000000d0021505f0522813@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fea4805ff10b0a5@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in page_cache_ra_unbounded
From:   syzbot <syzbot+47c7e14e1bd09234d0ad@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    c0a572d9d32f Merge tag 'v6.5/vfs.mount' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11d54c0b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4df35260418daa6
dashboard link: https://syzkaller.appspot.com/bug?extid=47c7e14e1bd09234d0ad
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c01f00a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145add7b280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1855f91c7ed0/disk-c0a572d9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fbbea26cfe51/vmlinux-c0a572d9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5c9ca7f2d7aa/bzImage-c0a572d9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d0602a911ff3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47c7e14e1bd09234d0ad@syzkaller.appspotmail.com

REISERFS (device loop0): Using r5 hash to sort names
REISERFS (device loop0): using 3.5.x disk format
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.4.0-syzkaller-00082-gc0a572d9d32f #0 Not tainted
------------------------------------------------------
syz-executor281/5085 is trying to acquire lock:
ffff88807d74e090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock_nested+0x69/0xe0 fs/reiserfs/lock.c:78

but task is already holding lock:
ffff888070c6e7e0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:833 [inline]
ffff888070c6e7e0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x153/0x5e0 mm/readahead.c:226

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (mapping.invalidate_lock#3){.+.+}-{3:3}:
       down_read+0x9c/0x480 kernel/locking/rwsem.c:1520
       filemap_invalidate_lock_shared include/linux/fs.h:833 [inline]
       page_cache_ra_unbounded+0x153/0x5e0 mm/readahead.c:226
       do_page_cache_ra mm/readahead.c:300 [inline]
       page_cache_ra_order+0x6ec/0xa00 mm/readahead.c:560
       do_sync_mmap_readahead mm/filemap.c:3193 [inline]
       filemap_fault+0x1572/0x24c0 mm/filemap.c:3285
       __do_fault+0x107/0x600 mm/memory.c:4176
       do_shared_fault mm/memory.c:4585 [inline]
       do_fault mm/memory.c:4663 [inline]
       do_pte_missing mm/memory.c:3647 [inline]
       handle_pte_fault mm/memory.c:4947 [inline]
       __handle_mm_fault+0x24c9/0x41c0 mm/memory.c:5089
       handle_mm_fault+0x2a7/0x9e0 mm/memory.c:5243
       do_user_addr_fault+0x51a/0x1210 arch/x86/mm/fault.c:1440
       handle_page_fault arch/x86/mm/fault.c:1534 [inline]
       exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1590
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
       __put_user_4+0x11/0x20 arch/x86/lib/putuser.S:89
       reiserfs_ioctl+0x20d/0x330 fs/reiserfs/ioctl.c:96
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x19d/0x210 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&sbi->lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3113 [inline]
       check_prevs_add kernel/locking/lockdep.c:3232 [inline]
       validate_chain kernel/locking/lockdep.c:3847 [inline]
       __lock_acquire+0x2fcd/0x5f30 kernel/locking/lockdep.c:5088
       lock_acquire kernel/locking/lockdep.c:5705 [inline]
       lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
       reiserfs_write_lock_nested+0x69/0xe0 fs/reiserfs/lock.c:78
       reiserfs_cond_resched fs/reiserfs/reiserfs.h:849 [inline]
       reiserfs_cond_resched fs/reiserfs/reiserfs.h:842 [inline]
       search_by_key+0x2452/0x3b60 fs/reiserfs/stree.c:712
       search_for_position_by_key+0xcf/0x1180 fs/reiserfs/stree.c:874
       _get_block_create_0+0x23f/0x1a70 fs/reiserfs/inode.c:305
       reiserfs_get_block+0x244f/0x4100 fs/reiserfs/inode.c:695
       do_mpage_readpage+0x768/0x1960 fs/mpage.c:234
       mpage_readahead+0x344/0x580 fs/mpage.c:382
       read_pages+0x1a2/0xd40 mm/readahead.c:161
       page_cache_ra_unbounded+0x477/0x5e0 mm/readahead.c:270
       do_page_cache_ra mm/readahead.c:300 [inline]
       page_cache_ra_order+0x6ec/0xa00 mm/readahead.c:560
       do_sync_mmap_readahead mm/filemap.c:3193 [inline]
       filemap_fault+0x1572/0x24c0 mm/filemap.c:3285
       __do_fault+0x107/0x600 mm/memory.c:4176
       do_shared_fault mm/memory.c:4585 [inline]
       do_fault mm/memory.c:4663 [inline]
       do_pte_missing mm/memory.c:3647 [inline]
       handle_pte_fault mm/memory.c:4947 [inline]
       __handle_mm_fault+0x24c9/0x41c0 mm/memory.c:5089
       handle_mm_fault+0x2a7/0x9e0 mm/memory.c:5243
       do_user_addr_fault+0x51a/0x1210 arch/x86/mm/fault.c:1440
       handle_page_fault arch/x86/mm/fault.c:1534 [inline]
       exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1590
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
       __put_user_4+0x11/0x20 arch/x86/lib/putuser.S:89
       reiserfs_ioctl+0x20d/0x330 fs/reiserfs/ioctl.c:96
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x19d/0x210 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(mapping.invalidate_lock#3);
                               lock(&sbi->lock);
                               lock(mapping.invalidate_lock#3);
  lock(&sbi->lock);

 *** DEADLOCK ***

1 lock held by syz-executor281/5085:
 #0: ffff888070c6e7e0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:833 [inline]
 #0: ffff888070c6e7e0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x153/0x5e0 mm/readahead.c:226

stack backtrace:
CPU: 1 PID: 5085 Comm: syz-executor281 Not tainted 6.4.0-syzkaller-00082-gc0a572d9d32f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
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
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
 reiserfs_write_lock_nested+0x69/0xe0 fs/reiserfs/lock.c:78
 reiserfs_cond_resched fs/reiserfs/reiserfs.h:849 [inline]
 reiserfs_cond_resched fs/reiserfs/reiserfs.h:842 [inline]
 search_by_key+0x2452/0x3b60 fs/reiserfs/stree.c:712
 search_for_position_by_key+0xcf/0x1180 fs/reiserfs/stree.c:874
 _get_block_create_0+0x23f/0x1a70 fs/reiserfs/inode.c:305
 reiserfs_get_block+0x244f/0x4100 fs/reiserfs/inode.c:695
 do_mpage_readpage+0x768/0x1960 fs/mpage.c:234
 mpage_readahead+0x344/0x580 fs/mpage.c:382
 read_pages+0x1a2/0xd40 mm/readahead.c:161
 page_cache_ra_unbounded+0x477/0x5e0 mm/readahead.c:270
 do_page_cache_ra mm/readahead.c:300 [inline]
 page_cache_ra_order+0x6ec/0xa00 mm/readahead.c:560
 do_sync_mmap_readahead mm/filemap.c:3193 [inline]
 filemap_fault+0x1572/0x24c0 mm/filemap.c:3285
 __do_fault+0x107/0x600 mm/memory.c:4176
 do_shared_fault mm/memory.c:4585 [inline]
 do_fault mm/memory.c:4663 [inline]
 do_pte_missing mm/memory.c:3647 [inline]
 handle_pte_fault mm/memory.c:4947 [inline]
 __handle_mm_fault+0x24c9/0x41c0 mm/memory.c:5089
 handle_mm_fault+0x2a7/0x9e0 mm/memory.c:5243
 do_user_addr_fault+0x51a/0x1210 arch/x86/mm/fault.c:1440
 handle_page_fault arch/x86/mm/fault.c:1534 [inline]
 exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1590
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:__put_user_4+0x11/0x20 arch/x86/lib/putuser.S:91
Code: fa 0f 01 cb 66 89 01 31 c9 0f 01 ca c3 66 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 cb 48 c1 fb 3f 48 09 d9 0f 01 cb <89> 01 31 c9 0f 01 ca c3 0f 1f 80 00 00 00 00 f3 0f 1e fa f3 0f 1e
RSP: 0018:ffffc90004217ec0 EFLAGS: 00050206
RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000020000000
RDX: 1ffff1100e18dd2b RSI: ffffffff82245cf8 RDI: ffff888070c6e958
RBP: ffffc90004217ef8 R08: 0000000000000001 R09: ffffffff8e7a9657
R10: fffffbfff1cf52ca R11: 0000000000000001 R12: ffff888070c6e4f0
R13: 0000000020000000 R14: ffff888070c6e518 R15: ffff88807bc6ec80
 reiserfs_ioctl+0x20d/0x330 fs/reiserfs/ioctl.c:96
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x19d/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f934c6b1649
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3f7edce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000cee5 RCX: 00007f934c6b1649
RDX: 0000000020000000 RSI: 0000000080087601 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe3f7edd1c
R13: 00007ffe3f7edd50 R14: 00007ffe3f7edd30 R15: 000000000000002a
 </TASK>
----------------
Code disassembly (best guess):
   0:	fa                   	cli
   1:	0f 01 cb             	stac
   4:	66 89 01             	mov    %ax,(%rcx)
   7:	31 c9                	xor    %ecx,%ecx
   9:	0f 01 ca             	clac
   c:	c3                   	retq
   d:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  14:	00 00 00 00
  18:	90                   	nop
  19:	f3 0f 1e fa          	endbr64
  1d:	48 89 cb             	mov    %rcx,%rbx
  20:	48 c1 fb 3f          	sar    $0x3f,%rbx
  24:	48 09 d9             	or     %rbx,%rcx
  27:	0f 01 cb             	stac
* 2a:	89 01                	mov    %eax,(%rcx) <-- trapping instruction
  2c:	31 c9                	xor    %ecx,%ecx
  2e:	0f 01 ca             	clac
  31:	c3                   	retq
  32:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  39:	f3 0f 1e fa          	endbr64
  3d:	f3                   	repz
  3e:	0f                   	.byte 0xf
  3f:	1e                   	(bad)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
