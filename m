Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7315148CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 14:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbiD2MI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 08:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358868AbiD2MIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:08:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889E758E74;
        Fri, 29 Apr 2022 05:05:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D616620DA;
        Fri, 29 Apr 2022 12:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D720EC385A7;
        Fri, 29 Apr 2022 12:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651233901;
        bh=51WNgMraDb0YzEABPLR2yD9CPLnar7/70JTrdoVfD90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kVOjnZP+KmrD+HEDG9rvTDfplbWvxHJ2xxGVUUA8Jgbh4X6vxHzXDUQtp7uuqdIjb
         3K3wdZZKieOGgvMhKhu6j5qSEUMgH/yn4N/dLgjJCHyBmFVBUxH7v7HUWvx7XNCKnW
         TGv0XNv5K1M6wb2pIFIqcNSpsCwzoEV7v3Pi1ii6C1jkjdTRmJ5twSPPSuC+qzBC+D
         NJaaARCPgcP1mNMGbV9IDjfTOFqP0SCUPkbbQgndvY/IC4VOpJwBpl0zrLTKIY/yDo
         VGavY2EiOfmkr4vaSP4+RK3dKRZBCPO4//VfVwvgDyWbK/7CKp7gGyDiR/Yi7j+l0n
         SFFXTX8g8Y3VQ==
Date:   Fri, 29 Apr 2022 14:04:56 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+2ee18845e89ae76342c5@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in mas_walk
Message-ID: <20220429120456.qcs7qbtv3o4hiiv6@wittgenstein>
References: <0000000000006b8dad05ddc47e92@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000006b8dad05ddc47e92@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 10:41:27PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    bdc61aad77fa Add linux-next specific files for 20220428
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15bb3dc2f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=87767e89da13a759
> dashboard link: https://syzkaller.appspot.com/bug?extid=2ee18845e89ae76342c5
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1118a5f6f00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125bd212f00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2ee18845e89ae76342c5@syzkaller.appspotmail.com
> 
> =============================
> WARNING: suspicious RCU usage
> 5.18.0-rc4-next-20220428-syzkaller #0 Not tainted
> -----------------------------
> lib/maple_tree.c:844 suspicious rcu_dereference_check() usage!

I _think_ for maple tree stuff you want to somehow ensure that
Liam Howlett <liam.howlett@oracle.com>
gets Cced.

> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 5 locks held by syz-executor842/4211:
>  #0: ffff88807f0ae460 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x127/0x250 fs/read_write.c:644
>  #1: ffff88801df04488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x28c/0x610 fs/kernfs/file.c:282
>  #2: ffff8881453b9a00 (kn->active#106){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2b0/0x610 fs/kernfs/file.c:283
>  #3: ffffffff8bedc528 (ksm_thread_mutex){+.+.}-{3:3}, at: run_store+0xd1/0xa60 mm/ksm.c:2917
>  #4: ffff88801e5e8fd8 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
>  #4: ffff88801e5e8fd8 (&mm->mmap_lock#2){++++}-{3:3}, at: unmerge_and_remove_all_rmap_items mm/ksm.c:989 [inline]
>  #4: ffff88801e5e8fd8 (&mm->mmap_lock#2){++++}-{3:3}, at: run_store+0x2a5/0xa60 mm/ksm.c:2923
> 
> stack backtrace:
> CPU: 0 PID: 4211 Comm: syz-executor842 Not tainted 5.18.0-rc4-next-20220428-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  mas_root lib/maple_tree.c:844 [inline]
>  mas_start lib/maple_tree.c:1331 [inline]
>  mas_state_walk lib/maple_tree.c:3745 [inline]
>  mas_walk+0x45e/0x670 lib/maple_tree.c:4923
>  mas_find+0x442/0xc90 lib/maple_tree.c:5861
>  vma_find include/linux/mm.h:664 [inline]
>  vma_next include/linux/mm.h:673 [inline]
>  unmerge_and_remove_all_rmap_items mm/ksm.c:990 [inline]
>  run_store+0x2ed/0xa60 mm/ksm.c:2923
>  kobj_attr_store+0x50/0x80 lib/kobject.c:824
>  sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
>  kernfs_fop_write_iter+0x3f8/0x610 fs/kernfs/file.c:291
>  call_write_iter include/linux/fs.h:2059 [inline]
>  new_sync_write+0x38a/0x560 fs/read_write.c:504
>  vfs_write+0x7c0/0xac0 fs/read_write.c:591
>  ksys_write+0x127/0x250 fs/read_write.c:644
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f6a91306e79
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffddeb8cde8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f6a91306e79
> RDX: 0000000000000002 RSI: 0000000020000000 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
> R10: 0000000020117000 R11: 0000000000000246 R12: 000000000000cf84
> R13: 00007ffddeb8cdfc R14: 00007ffddeb8ce10 R15: 00007ffddeb8ce00
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
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
