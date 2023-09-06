Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D397944F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 23:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244666AbjIFVKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 17:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjIFVKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:10:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F96110E9;
        Wed,  6 Sep 2023 14:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4gA/etLrTZoq9cKPZGvMa6mc+IZPHR3kwciERc0pMbQ=; b=EBMpPWgFauBGwfxMT20Yu843ok
        B7zpLsd1xCs7oLL6x+f3W6xeoRcSiAt+MGOUFXU6DkcedHet5/IsmiEJOfJuYNKI6Ez+c4ri7C/A0
        IrFgipMid7rH52jc0yBDmFgFBeLAyA9wU8qLeEfbgsllbC5zUcsqH9+3kfq4hiua6HCWDDqwlefuh
        mj+gZwfKtIrBRhgeQnShRaZB27m4y/NTkJ61NhlIzgxD+iJ/E6z5rLn1f47XdZDWQxjC24oK8kdBv
        +wH4W6MJGyko2SgFW155m958KN8EZnRZ2VTjCcBIlhCbFYbXf8RRNiWC8SpXR1FqJxj/Sxa4WRIpS
        q83VryFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdzn7-005Zlg-86; Wed, 06 Sep 2023 21:10:25 +0000
Date:   Wed, 6 Sep 2023 22:10:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add inode lockdep assertions
Message-ID: <ZPjqwUq+lUOhYOEa@casper.infradead.org>
References: <20230831151414.2714750-1-mjguzik@gmail.com>
 <ZPiYp+t6JTUscc81@casper.infradead.org>
 <b0434328-01f9-dc5c-fe25-4a249130a81d@fastmail.fm>
 <20230906152948.GE28160@frogsfrogsfrogs>
 <ZPiiDj1T3lGp2w2c@casper.infradead.org>
 <20230906170724.GI28202@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906170724.GI28202@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 10:07:24AM -0700, Darrick J. Wong wrote:
> You'd be better off converting this to:
> 
> 	return __xfs_rwsem_islocked(&ip->i_lock.mr_lock,
> 				(lock_flags & XFS_ILOCK_SHARED));
> 
> And then fixing __xfs_rwsem_islocked to do:
> 
> static inline bool
> __xfs_rwsem_islocked(
> 	struct rw_semaphore	*rwsem,
> 	bool			shared)
> {
> 	if (!debug_locks) {
> 		if (!shared)
> 			return rwsem_is_write_locked(rwsem);
> 		return rwsem_is_locked(rwsem);
> 	}
> 
> 	...
> }

so ... I did that.  And then many isilocked() calls started failing.
generic/017 was the first one:

00030 XFS: Assertion failed: xfs_isilocked(ip, XFS_ILOCK_EXCL), file: fs/xfs/libxfs/xfs_trans_inode.c, line: 93
00030 ------------[ cut here ]------------
00030 WARNING: CPU: 5 PID: 77 at fs/xfs/xfs_message.c:104 assfail+0x2c/0x40
00030 Modules linked in:
00030 CPU: 5 PID: 77 Comm: kworker/5:1 Kdump: loaded Not tainted 6.5.0-00006-g88a61c17df8f-dirty #14
00030 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
00030 Workqueue: xfsalloc xfs_btree_split_worker
00030 RIP: 0010:assfail+0x2c/0x40
00030 Code: 89 d0 41 89 c9 48 c7 c2 80 70 0f 82 48 89 f1 48 89 e5 48 89 fe 48 c7
 c7 08 4f 07 82 e8 fd fd ff ff 80 3d 26 cc ed 00 00 75 04 <0f> 0b 5d c3 0f 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 55 48
00030 RSP: 0018:ffff888003f0bc28 EFLAGS: 00010246
00030 RAX: 00000000ffffffea RBX: ffff88800d9a0000 RCX: 000000007fffffff
00030 RDX: 0000000000000021 RSI: 0000000000000000 RDI: ffffffff82074f08
00030 RBP: ffff888003f0bc28 R08: 0000000000000000 R09: 000000000000000a
00030 R10: 000000000000000a R11: 0fffffffffffffff R12: ffff888009ff6000
00030 R13: ffff88800ac8a000 R14: 0000000000000001 R15: ffff88800af0a000
00030 FS:  0000000000000000(0000) GS:ffff88807d940000(0000) knlGS:0000000000000000
00030 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
00030 CR2: 00007ff177b05d58 CR3: 0000000007aa2002 CR4: 0000000000770ea0
00030 PKRU: 55555554
00030 Call Trace:
00030  <TASK>
00030  ? show_regs+0x5c/0x70
00030  ? __warn+0x84/0x180
00030  ? assfail+0x2c/0x40
00030  ? report_bug+0x18e/0x1c0
00030  ? handle_bug+0x3e/0x70
00030  ? exc_invalid_op+0x18/0x70
00030  ? asm_exc_invalid_op+0x1b/0x20
00030  ? assfail+0x2c/0x40
00030  ? assfail+0x23/0x40
00030  xfs_trans_log_inode+0xf9/0x120
00030  xfs_bmbt_alloc_block+0xf0/0x1c0
00030  __xfs_btree_split+0xf8/0x6c0
00030  ? __this_cpu_preempt_check+0x13/0x20
00030  ? lock_acquire+0xc8/0x280
00030  xfs_btree_split_worker+0x8a/0x110
00030  process_one_work+0x23f/0x510
00030  worker_thread+0x4d/0x3b0
00030  ? process_one_work+0x510/0x510
00030  kthread+0x106/0x140
00030  ? kthread_complete_and_exit+0x20/0x20
00030  ret_from_fork+0x31/0x50
00030  ? kthread_complete_and_exit+0x20/0x20
00030  ret_from_fork_asm+0x11/0x20
00030  </TASK>
00030 irq event stamp: 2901
00030 hardirqs last  enabled at (2909): [<ffffffff810e4d83>] __up_console_sem+0x53/0x60
00030 hardirqs last disabled at (2916): [<ffffffff810e4d68>] __up_console_sem+0x38/0x60
00030 softirqs last  enabled at (0): [<ffffffff81067bd0>] copy_process+0x830/0x1c10
00030 softirqs last disabled at (0): [<0000000000000000>] 0x0
00030 ---[ end trace 0000000000000000 ]---

but here's the thing, I have lockdep enabled.  So it's not testing my
new rwsem_is_write_locked() code, it's testing the current lockdep
stuff.

So I have a feeling that we're not telling lockdep that we've acquired
the i_lock.  Or something?  Seems unlikely that this is a real bug;
surely we'd've noticed before now.

Code here:
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/mrlock

ie git clone git://git.infradead.org/users/willy/pagecache.git mrlock

You don't need the top commit.  754fb6a68dae is enough to provoke it,
as long as you have CONFIG_LOCKDEP enabled.

