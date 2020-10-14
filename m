Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC1528E4C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 18:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388238AbgJNQrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 12:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbgJNQrb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:47:31 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B47DC214D8;
        Wed, 14 Oct 2020 16:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602694050;
        bh=qQcbXQWCCAd7m2Lti1WPtkd5kda8Yy9gyEeggiebHmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXYn3s9uEfz94tVD2BODD8ynlMifbwOGmH+hE/wJTeN1DUTrEgmOqjPU9XFhaz9yQ
         22OyKfZasWpZpy3ryu/t4ffiJbKBU7b+HB1iH/eY4XkdrFcUSY4vaBfWIyVIcLa2S7
         oSmoGJnGdtgaR4HDRTIeNbWzBaOrqYmgVGeEMorc=
Date:   Wed, 14 Oct 2020 09:47:28 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        syzbot <syzbot+b8ff83b095e45f39e27e@syzkaller.appspotmail.com>
Subject: Re: WARNING in __writeback_inodes_sb_nr
Message-ID: <20201014164728.GA2545693@gmail.com>
References: <0000000000004ffb3205b1a04abe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004ffb3205b1a04abe@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+linux-btrfs, for btrfs calling writeback_inodes_sb() from
btrfs_start_delalloc_flush() without holding super_block::s_umount.

On Wed, Oct 14, 2020 at 05:01:23AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    bbf5c979 Linux 5.9
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1664b377900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3d8333c88fe898d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=b8ff83b095e45f39e27e
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13127ef0500000
> 
> Bisection is inconclusive: the issue happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14878558500000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16878558500000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12878558500000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b8ff83b095e45f39e27e@syzkaller.appspotmail.com
> 
> BTRFS info (device loop0): disk space caching is enabled
> BTRFS info (device loop0): has skinny extents
> BTRFS info (device loop0): enabling ssd optimizations
> BTRFS info (device loop0): checking UUID tree
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 7118 at fs/fs-writeback.c:2469 __writeback_inodes_sb_nr+0x229/0x280 fs/fs-writeback.c:2469
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 7118 Comm: syz-executor.0 Not tainted 5.9.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x198/0x1fd lib/dump_stack.c:118
>  panic+0x382/0x7fb kernel/panic.c:231
>  __warn.cold+0x20/0x4b kernel/panic.c:600
>  report_bug+0x1bd/0x210 lib/bug.c:198
>  handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
>  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
> RIP: 0010:__writeback_inodes_sb_nr+0x229/0x280 fs/fs-writeback.c:2469
> Code: 48 8b 84 24 c0 00 00 00 65 48 2b 04 25 28 00 00 00 75 38 48 81 c4 c8 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 f7 75 a7 ff <0f> 0b e9 69 ff ff ff 4c 89 f7 e8 a8 4e e8 ff e9 ea fe ff ff 4c 89
> RSP: 0018:ffffc900064076e0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 1ffff92000c80edd RCX: ffffffff81cec880
> RDX: ffff888099db2200 RSI: ffffffff81cec919 RDI: 0000000000000007
> RBP: ffff8880994ec000 R08: 0000000000000000 R09: ffff8880994ec077
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffc90006407708 R14: 0000000000006400 R15: ffff8880994ec158
>  btrfs_start_delalloc_flush fs/btrfs/transaction.c:1970 [inline]
>  btrfs_commit_transaction+0x8ea/0x2830 fs/btrfs/transaction.c:2150
>  btrfs_sync_file+0x821/0xd80 fs/btrfs/file.c:2279
>  vfs_fsync_range+0x13a/0x220 fs/sync.c:200
>  generic_write_sync include/linux/fs.h:2747 [inline]
>  btrfs_file_write_iter+0x1101/0x14a9 fs/btrfs/file.c:2049
>  call_write_iter include/linux/fs.h:1882 [inline]
>  do_iter_readv_writev+0x532/0x7b0 fs/read_write.c:721
>  do_iter_write+0x188/0x670 fs/read_write.c:1026
>  vfs_writev+0x1aa/0x2e0 fs/read_write.c:1099
>  do_pwritev fs/read_write.c:1196 [inline]
>  __do_sys_pwritev fs/read_write.c:1243 [inline]
>  __se_sys_pwritev fs/read_write.c:1238 [inline]
>  __x64_sys_pwritev+0x231/0x310 fs/read_write.c:1238
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x45de59
> Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f098f185c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000128
> RAX: ffffffffffffffda RBX: 0000000000026400 RCX: 000000000045de59
> RDX: 0000000000000001 RSI: 00000000200014c0 RDI: 0000000000000003
> RBP: 000000000118bf70 R08: 0000000000000020 R09: 0000000000000000
> R10: 0000000000000002 R11: 0000000000000246 R12: 000000000118bf2c
> R13: 00007ffe7dd36ddf R14: 00007f098f1869c0 R15: 000000000118bf2c
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
