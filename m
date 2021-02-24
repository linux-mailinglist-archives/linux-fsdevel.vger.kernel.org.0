Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205773242E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 18:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbhBXRFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 12:05:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:54950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235969AbhBXREh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 12:04:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F1BEADDB;
        Wed, 24 Feb 2021 17:03:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AF7841E14EE; Wed, 24 Feb 2021 18:03:50 +0100 (CET)
Date:   Wed, 24 Feb 2021 18:03:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+1b2c6989ec12e467d65c@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org
Subject: Re: possible deadlock in evict
Message-ID: <20210224170350.GC849@quack2.suse.cz>
References: <000000000000de58b305bb355903@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000de58b305bb355903@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Sat 13-02-21 02:38:18, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    c6d8570e Merge tag 'io_uring-5.11-2021-02-12' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=123a4be2d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bec717fd4ac4bf03
> dashboard link: https://syzkaller.appspot.com/bug?extid=1b2c6989ec12e467d65c
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1b2c6989ec12e467d65c@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.11.0-rc7-syzkaller #0 Not tainted
> ------------------------------------------------------
> kswapd0/2232 is trying to acquire lock:
> ffff88801f552650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x6b0 fs/inode.c:577
> 
> but task is already holding lock:
> ffffffff8be89240 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x30 mm/page_alloc.c:5195
> 
> which lock already depends on the new lock.

So this is an interesting problem. The stacktrace below shows that we can
end up with inode reclaim deleting inode. It likely happens like:

CPU1					CPU2
prune_icache_sb()
  ...
  inode_lru_isolate()
    if (inode_has_buffers(inode) || inode->i_data.nrpages) {
      __iget(inode);
      ...
					unlink(inode);
					d_delete(dentry);
      ...
      iput(inode)
        ...going to delete inode...
      
And this introduces interesting lock dependency with filesystem freezing -
fs reclaim can block on filesystem being frozen. That inherently means that
anything between freeze_super() and thaw_super() that enters fs reclaim is
a potential deadlock. But among lot of kernel code in there, there's also
userspace running inbetween those so we have no sane way to avoid entering
fs reclaim there.

So I belive the only sane way of avoiding this deadlock is to really
avoiding deleting inode from fs reclaim. And the best idea how to achieve
that I have is to simply avoid the 'inode_has_buffers(inode) ||
inode->i_data.nrpages' branch if we are running in direct reclaim. Any
better idea?

> stack backtrace:
> CPU: 3 PID: 2232 Comm: kswapd0 Not tainted 5.11.0-rc7-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x107/0x163 lib/dump_stack.c:120
>  check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2117
>  check_prev_add kernel/locking/lockdep.c:2868 [inline]
>  check_prevs_add kernel/locking/lockdep.c:2993 [inline]
>  validate_chain kernel/locking/lockdep.c:3608 [inline]
>  __lock_acquire+0x2b26/0x54f0 kernel/locking/lockdep.c:4832
>  lock_acquire kernel/locking/lockdep.c:5442 [inline]
>  lock_acquire+0x1a8/0x720 kernel/locking/lockdep.c:5407
>  percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
>  __sb_start_write include/linux/fs.h:1592 [inline]
>  sb_start_intwrite include/linux/fs.h:1709 [inline]
>  ext4_evict_inode+0xe6f/0x1940 fs/ext4/inode.c:241
>  evict+0x2ed/0x6b0 fs/inode.c:577
>  iput_final fs/inode.c:1653 [inline]
>  iput.part.0+0x57e/0x810 fs/inode.c:1679
>  iput fs/inode.c:1669 [inline]
>  inode_lru_isolate+0x301/0x4f0 fs/inode.c:778
>  __list_lru_walk_one+0x178/0x5c0 mm/list_lru.c:222
>  list_lru_walk_one+0x99/0xd0 mm/list_lru.c:266
>  list_lru_shrink_walk include/linux/list_lru.h:195 [inline]
>  prune_icache_sb+0xdc/0x140 fs/inode.c:803
>  super_cache_scan+0x38d/0x590 fs/super.c:107
>  do_shrink_slab+0x3e4/0x9f0 mm/vmscan.c:511
>  shrink_slab+0x16f/0x5d0 mm/vmscan.c:672
>  shrink_node_memcgs mm/vmscan.c:2665 [inline]
>  shrink_node+0x8cc/0x1de0 mm/vmscan.c:2780
>  kswapd_shrink_node mm/vmscan.c:3523 [inline]
>  balance_pgdat+0x745/0x1270 mm/vmscan.c:3681
>  kswapd+0x5b1/0xdb0 mm/vmscan.c:3938
>  kthread+0x3b1/0x4a0 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
