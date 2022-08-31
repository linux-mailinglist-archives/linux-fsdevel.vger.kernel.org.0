Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36DD5A746E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 05:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiHaD03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 23:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiHaD01 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:26:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD44F7FF97;
        Tue, 30 Aug 2022 20:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I/uQ+5H8aeFHVEMH/164Zt/tTcKAYf/gtgy1PpGIymw=; b=B8sDmd6nK77z5NteQxxUTuZv82
        kATFK/youe7wLHMsp9sBxYiYiYVYFpEQpXzeOZU77ZXIkh5PvhXujXwVcNfUSwXbvXGkpLMt4yulL
        YySzBZB7P+6g8Hlm50Rr6/8zBYVFJSuDWv+wxMS21BshRQ0aVFIEnCxbhCigTJ86Jp8IW41OjjWF5
        ulM+tshuIJIu2d5+BwUn7FJJcGqJqGLaKx1sX8dsqpInJ/ORCQK/yuP1PJmW0GiJbvso7bv9bguQX
        HlxgmrId+mtbr4IIxpu+iqjTegYWkvWdWdzhLDjCqbEGaFhra9kWWm5/bIbJWof07mA8GIxK6HRU8
        pQSLstDw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTEMx-004htM-Pt; Wed, 31 Aug 2022 03:26:23 +0000
Date:   Wed, 31 Aug 2022 04:26:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+fc721e2fe15a5aac41d1@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        ntfs3@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: Re: [syzbot] WARNING in writeback_single_inode
Message-ID: <Yw7U39BnHb6iXNMo@casper.infradead.org>
References: <00000000000050d56805e77c4582@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000050d56805e77c4582@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks like an ntfs3 problem.  cc's added.

On Tue, Aug 30, 2022 at 02:43:28PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a41a877bc12d Merge branch 'for-next/fixes' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=178fc957080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea15779c42821c
> dashboard link: https://syzkaller.appspot.com/bug?extid=fc721e2fe15a5aac41d1
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fc721e2fe15a5aac41d1@syzkaller.appspotmail.com
> 
> ntfs3: loop4: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 24385 at fs/fs-writeback.c:1678 writeback_single_inode+0x374/0x388 fs/fs-writeback.c:1678
> Modules linked in:
> CPU: 0 PID: 24385 Comm: syz-executor.4 Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : writeback_single_inode+0x374/0x388 fs/fs-writeback.c:1678
> lr : writeback_single_inode+0x374/0x388 fs/fs-writeback.c:1678
> sp : ffff800020d4b9c0
> x29: ffff800020d4ba10 x28: ffff0000e4bc8000 x27: fffffc0003f22700
> x26: 0000000000000a00 x25: 0000000000000000 x24: 0000000000000001
> x23: 0000000000001000 x22: ffff800020d4ba60 x21: 0000000000000000
> x20: ffff0000fd87f7b7 x19: ffff0000fd87f840 x18: 0000000000000369
> x17: 0000000000000000 x16: ffff80000dbb8658 x15: ffff0000e1cc0000
> x14: 0000000000000130 x13: 00000000ffffffff x12: 0000000000040000
> x11: 000000000003ffff x10: ffff80001d55c000 x9 : ffff80000861f6d4
> x8 : 0000000000040000 x7 : ffff80000861f3a4 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  writeback_single_inode+0x374/0x388 fs/fs-writeback.c:1678
>  write_inode_now+0xb0/0xdc fs/fs-writeback.c:2723
>  iput_final fs/inode.c:1735 [inline]
>  iput+0x1d4/0x314 fs/inode.c:1774
>  ntfs_fill_super+0xc30/0x14a4 fs/ntfs/super.c:2994
>  get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
>  ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
>  vfs_get_tree+0x40/0x140 fs/super.c:1530
>  do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
>  path_mount+0x358/0x914 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>  el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
>  el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
>  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
>  el0t_64_sync+0x18c/0x190
> irq event stamp: 3030
> hardirqs last  enabled at (3029): [<ffff800008163d78>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
> hardirqs last  enabled at (3029): [<ffff800008163d78>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4942
> hardirqs last disabled at (3030): [<ffff80000bffe9cc>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
> softirqs last  enabled at (2780): [<ffff8000080102e4>] _stext+0x2e4/0x37c
> softirqs last disabled at (1405): [<ffff800008104658>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
> softirqs last disabled at (1405): [<ffff800008104658>] invoke_softirq+0x70/0xbc kernel/softirq.c:452
> ---[ end trace 0000000000000000 ]---
> Unable to handle kernel paging request at virtual address 000000fd87f9e147
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004
>   CM = 0, WnR = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=0000000128316000
> [000000fd87f9e147] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 96000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 24385 Comm: syz-executor.4 Tainted: G        W          6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : xa_marked include/linux/xarray.h:420 [inline]
> pc : mapping_tagged include/linux/fs.h:461 [inline]
> pc : writeback_single_inode+0x228/0x388 fs/fs-writeback.c:1703
> lr : writeback_single_inode+0x218/0x388 fs/fs-writeback.c:1702
> sp : ffff800020d4b9c0
> x29: ffff800020d4ba10 x28: ffff0000e4bc8000 x27: fffffc0003f22700
> x26: 0000000000000a00 x25: 0000000000001000 x24: 0000000000000001
> x23: 0000000000000001 x22: ffff800020d4ba60 x21: ffff0000fd87f88f
> x20: ffff0000fd87f7b7 x19: ffff0000fd87f840 x18: 0000000000000369
> x17: 0000000000000000 x16: ffff80000dbb8658 x15: ffff0000e1cc0000
> x14: 0000000000000130 x13: 00000000ffffffff x12: 0000000000040000
> x11: ff8080000861f578 x10: 0000000000000002 x9 : ffff0000e1cc0000
> x8 : ff0000fd87f9e0ff x7 : ffff80000861f3a4 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000000
> Call trace:
>  xa_marked include/linux/xarray.h:420 [inline]
>  mapping_tagged include/linux/fs.h:461 [inline]
>  writeback_single_inode+0x228/0x388 fs/fs-writeback.c:1703
>  write_inode_now+0xb0/0xdc fs/fs-writeback.c:2723
>  iput_final fs/inode.c:1735 [inline]
>  iput+0x1d4/0x314 fs/inode.c:1774
>  ntfs_fill_super+0xc30/0x14a4 fs/ntfs/super.c:2994
>  get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
>  ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
>  vfs_get_tree+0x40/0x140 fs/super.c:1530
>  do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
>  path_mount+0x358/0x914 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>  el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
>  el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
>  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
>  el0t_64_sync+0x18c/0x190
> Code: 710006ff 54000281 f9401a88 2a1f03e0 (b9404917) 
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:	710006ff 	cmp	w23, #0x1
>    4:	54000281 	b.ne	0x54  // b.any
>    8:	f9401a88 	ldr	x8, [x20, #48]
>    c:	2a1f03e0 	mov	w0, wzr
> * 10:	b9404917 	ldr	w23, [x8, #72] <-- trapping instruction
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
