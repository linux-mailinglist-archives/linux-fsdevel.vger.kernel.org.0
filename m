Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01FD54019C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 16:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245703AbiFGOkg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 10:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244561AbiFGOkf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:40:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9F129350;
        Tue,  7 Jun 2022 07:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DqhUPNqPqyZw8ImGoA3Lje37HJW9u7YTTYnkSSKpLPA=; b=X3/PZchuCR0debqSS6DBVa/lY2
        VDTL4fSQzZowwrqlDKPWRF65ifo1JXGa2OtShPKgy8a4mE2SioeN5agFI7zgHcN7tiIMsyjswsosu
        KEredvIZccs05CPO1ZRBunCT+stDRPc8ZVHilbNxwFkX/WoA6ugd10SG0nwEbxO5v3icuyppc1Trn
        p0EKW/b3tqspQ7w058LTjGHyTaQtvrtog+Fg4Wqsaryi1pwfyl3lD5ZPqRzeQlJx2GCicRwsx2V0G
        hjurILEmo19AB/22r28lkfWRhpUy6+DvvrHZhsry2hkP2s9FOX9kPivoT4tgdIZENhjmnPHQkgOia
        sTvxvdhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyaNi-00BiJP-0S; Tue, 07 Jun 2022 14:40:30 +0000
Date:   Tue, 7 Jun 2022 15:40:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+2c93b863a7698df84bad@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, ntfs3@lists.linux.dev
Subject: Re: [syzbot] WARNING: locking bug in truncate_inode_pages_final
Message-ID: <Yp9jXahFS8WyQDYt@casper.infradead.org>
References: <0000000000000cf8be05e0d65e09@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000cf8be05e0d65e09@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 12:16:29AM -0700, syzbot wrote:
> HEAD commit:    d1dc87763f40 assoc_array: Fix BUG_ON during garbage collect
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14979947f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c51cd24814bb5665
> dashboard link: https://syzkaller.appspot.com/bug?extid=2c93b863a7698df84bad
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2c93b863a7698df84bad@syzkaller.appspotmail.com
> 
> ntfs3: loop3: Different NTFS' sector size (2048) and media sector size (512)
> ntfs3: loop3: Different NTFS' sector size (2048) and media sector size (512)
> ------------[ cut here ]------------
> releasing a pinned lock

This has to be a memory corruption.  The lock being released here is
the mapping->i_pages xa_lock.  That lock is never pinned.  So somebody
has corrupted lockdep's data structures.

The only locks which are pinned are:
drivers/gpu/drm/i915/gt/intel_context.c:        rq->cookie = lockdep_pin_lock(&ce->timeline->mutex);
drivers/gpu/drm/i915/gt/selftest_timeline.c:            to->cookie = lockdep_pin_lock(&to->context->timeline->mutex);
drivers/gpu/drm/i915/i915_request.c:    rq->cookie = lockdep_pin_lock(&tl->mutex);
kernel/sched/deadline.c:                rf.cookie = lockdep_pin_lock(__rq_lockp(rq));
kernel/sched/sched.h:   rf->cookie = lockdep_pin_lock(__rq_lockp(rq));

> WARNING: CPU: 2 PID: 21856 at kernel/locking/lockdep.c:5349 __lock_release kernel/locking/lockdep.c:5349 [inline]
> WARNING: CPU: 2 PID: 21856 at kernel/locking/lockdep.c:5349 lock_release+0x6a9/0x780 kernel/locking/lockdep.c:5685
> Modules linked in:
> CPU: 2 PID: 21856 Comm: syz-executor.3 Not tainted 5.18.0-syzkaller-11972-gd1dc87763f40 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> RIP: 0010:__lock_release kernel/locking/lockdep.c:5349 [inline]
> RIP: 0010:lock_release+0x6a9/0x780 kernel/locking/lockdep.c:5685
> Code: 68 00 e9 5a fa ff ff 4c 89 f7 e8 f2 3d 68 00 e9 36 fc ff ff e8 78 3d 68 00 e9 f5 fb ff ff 48 c7 c7 e0 9a cc 89 e8 d1 84 d3 07 <0f> 0b e9 87 fb ff ff e8 3b b3 18 08 48 c7 c7 4c 44 bb 8d e8 4f 3d
> RSP: 0018:ffffc90003497a00 EFLAGS: 00010082
> RAX: 0000000000000000 RBX: ffff88801e742c48 RCX: 0000000000000000
> RDX: 0000000000040000 RSI: ffffffff81601908 RDI: fffff52000692f32
> RBP: 1ffff92000692f42 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000080000001 R11: 0000000000000001 R12: ffff88804fb22498
> R13: 0000000000000002 R14: ffff88801e742c18 R15: ffff88801e7421c0
> FS:  00007f64be4cb700(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f64be4cc000 CR3: 00000000669a7000 CR4: 0000000000150ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 000000000000003b DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:157 [inline]
>  _raw_spin_unlock_irq+0x12/0x40 kernel/locking/spinlock.c:202
>  spin_unlock_irq include/linux/spinlock.h:399 [inline]
>  truncate_inode_pages_final+0x5f/0x80 mm/truncate.c:484
>  ntfs_evict_inode+0x16/0xa0 fs/ntfs3/inode.c:1750
>  evict+0x2ed/0x6b0 fs/inode.c:664
>  iput_final fs/inode.c:1744 [inline]
>  iput.part.0+0x562/0x820 fs/inode.c:1770
>  iput+0x58/0x70 fs/inode.c:1760
>  ntfs_fill_super+0x2d66/0x3730 fs/ntfs3/super.c:1180
>  get_tree_bdev+0x440/0x760 fs/super.c:1292
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1497
>  do_new_mount fs/namespace.c:3040 [inline]
>  path_mount+0x1320/0x1fa0 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f64bd28a63a
> Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f64be4caf88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f64bd28a63a
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f64be4cafe0
> RBP: 00007f64be4cb020 R08: 00007f64be4cb020 R09: 0000000020000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
> R13: 0000000020000100 R14: 00007f64be4cafe0 R15: 000000002007a980
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
