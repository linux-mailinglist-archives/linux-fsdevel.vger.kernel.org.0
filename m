Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EE46DCF0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 03:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjDKBRE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Apr 2023 21:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDKBQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:16:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D2E2707;
        Mon, 10 Apr 2023 18:15:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C7A06202F;
        Tue, 11 Apr 2023 01:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE79C433EF;
        Tue, 11 Apr 2023 01:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681175757;
        bh=AMUpPu1f7XsDozqRVGBMjaBYs1JPqJq6AvNpn3+jE+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SfN2oi7BgvSCRZrNsckL6exTZrYu3QUQ8JgqRf36Tm17f3XHjIds6l13p2BIHFaFZ
         hqACR0Vh9m+27XuFMIodLSTWcI8mrz2zaHnvq6Lci7ZBjxn9AHVP6WI4IoK2a+CEI7
         vWmlJt7ZeENqfJ0D2d4dd7UkjITi8yVK+Nfv75vy3//TCpwoZDpCpIiuLPKhHcebhX
         Kkfm6d0o3zyCvQcxnhCzqZp4LwZKbyYR0PzIkftby5pzk7Ng/2N2wfyT95TjnDy3C7
         sHri+qd8jqdTjT/GCHQW8BmqhiRPNrkmzAd86oNC5RBZFFl1UaA64dw4KIwMARyh4C
         E/VPIkSOV1h7Q==
Date:   Mon, 10 Apr 2023 18:15:57 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+5ed016962f5137a09c7c@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING in __queue_delayed_work
Message-ID: <20230411011557.GA360895@frogsfrogsfrogs>
References: <000000000000e5f10505f8c205bc@google.com>
 <20230410122022.1697-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410122022.1697-1-hdanton@sina.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 10, 2023 at 08:20:22PM +0800, Hillf Danton wrote:
> On 07 Apr 2023 10:04:49 -0700
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    7e364e56293b Linux 6.3-rc5
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13241195c80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=e3b9dc6616d797bb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5ed016962f5137a09c7c
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: i386
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+5ed016962f5137a09c7c@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 102 at kernel/workqueue.c:1445 __queue_work+0xd44/0x1120 kernel/workqueue.c:1444
> > Modules linked in:
> > CPU: 1 PID: 102 Comm: kswapd0 Not tainted 6.3.0-rc5-syzkaller #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> > RIP: 0010:__queue_work+0xd44/0x1120 kernel/workqueue.c:1444

Gross.  I just got one of these splats too, in:

__queue_work+0x3a2/0x4a0
call_timer_fn+0x24/0x120
__run_timers.part.0+0x170/0x280
run_timer_softirq+0x31/0x60
__do_softirq+0xf6/0x2fd
irq_exit_rcu+0xc5/0x110
sysvec_apic_timer_interrupt+0x8e/0xc0

I guess someone might have done:

Thread 0: xfs_inodegc_queue_all(mp);

Thread 1: <add inodegc work>
Thread 1: mod_delayed_work_on(cpu, mp->m_inodegc_wq, &gc->work, <nonzero>);

Thread 0: drain_workqueue(mp->m_inodegc_wq);

<Timer fires, splats, everyone halts>

But I can't really tell, the VM froze.  Any suggestions on how to fix this?

--D

> > Code: e0 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 74 0c 81 00 8b 5b 2c 31 ff 83 e3 20 89 de e8 c5 fb 2f 00 85 db 75 42 e8 6c ff 2f 00 <0f> 0b e9 3c f9 ff ff e8 60 ff 2f 00 0f 0b e9 ce f8 ff ff e8 54 ff
> > RSP: 0000:ffffc90000ce7638 EFLAGS: 00010093
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > RDX: ffff888015f73a80 RSI: ffffffff8152d854 RDI: 0000000000000005
> > RBP: 0000000000000002 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: ffffe8ffffb03348
> > R13: ffff888078462000 R14: ffffe8ffffb03390 R15: ffff888078462000
> > FS:  0000000000000000(0000) GS:ffff88802ca80000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000cfa5bb CR3: 0000000025fde000 CR4: 0000000000150ee0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  __queue_delayed_work+0x1c8/0x270 kernel/workqueue.c:1672
> >  mod_delayed_work_on+0xe1/0x220 kernel/workqueue.c:1746
> >  xfs_inodegc_shrinker_scan fs/xfs/xfs_icache.c:2212 [inline]
> >  xfs_inodegc_shrinker_scan+0x250/0x4f0 fs/xfs/xfs_icache.c:2191
> >  do_shrink_slab+0x428/0xaa0 mm/vmscan.c:853
> >  shrink_slab+0x175/0x660 mm/vmscan.c:1013
> >  shrink_one+0x502/0x810 mm/vmscan.c:5343
> >  shrink_many mm/vmscan.c:5394 [inline]
> >  lru_gen_shrink_node mm/vmscan.c:5511 [inline]
> >  shrink_node+0x2064/0x35f0 mm/vmscan.c:6459
> >  kswapd_shrink_node mm/vmscan.c:7262 [inline]
> >  balance_pgdat+0xa02/0x1ac0 mm/vmscan.c:7452
> >  kswapd+0x677/0xd60 mm/vmscan.c:7712
> >  kthread+0x2e8/0x3a0 kernel/kthread.c:376
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> >  </TASK>
> 
> Looks like a valid race.
> 
> 	xfs_inodegc_shrinker_scan()		xfs_inodegc_stop()
> 	---					---
> 	if (!xfs_is_inodegc_enabled(mp))
> 		return SHRINK_STOP;
> 						if (!xfs_clear_inodegc_enabled(mp))
> 							return;
> 						xfs_inodegc_queue_all(mp);
> 						drain_workqueue(mp->m_inodegc_wq);
> 							wq->flags |= __WQ_DRAINING;
> 	mod_delayed_work_on()
