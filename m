Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D5E2720D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 12:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgIUKZp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 06:25:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:34222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgIUKZk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:25:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12CE2AE37;
        Mon, 21 Sep 2020 10:26:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 82FBA1E12E1; Mon, 21 Sep 2020 12:25:38 +0200 (CEST)
Date:   Mon, 21 Sep 2020 12:25:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        lihaotian9@huawei.com, lutianxiong@huawei.com, jack@suse.cz,
        linfeilong@huawei.com
Subject: Re: [PATCH RESEND] fs: fix race condition oops between destroy_inode
 and writeback_sb_inodes
Message-ID: <20200921102538.GF5862@quack2.suse.cz>
References: <20200919093923.19016-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919093923.19016-1-luoshijie1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 19-09-20 05:39:23, Shijie Luo wrote:
> We tested an oops problem in Linux 4.18. The Call Trace message is
>  followed below.
> 
> [255946.665989] Oops: 0000 [#1] SMP PTI
> [255946.674811] Workqueue: writeback wb_workfn (flush-253:6)
> [255946.676443] RIP: 0010:locked_inode_to_wb_and_lock_list+0x20/0x120
> [255946.683916] RSP: 0018:ffffbb0e44727c00 EFLAGS: 00010286
> [255946.685518] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [255946.687699] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9ef282be5398
> [255946.689866] RBP: ffff9ef282be5398 R08: ffffbb0e44727cd8 R09: ffff9ef3064f306e
> [255946.692037] R10: 0000000000000000 R11: 0000000000000010 R12: ffff9ef282be5420
> [255946.694208] R13: ffff9ef3351cc800 R14: 0000000000000000 R15: ffff9ef3352e2058
> [255946.696378] FS:  0000000000000000(0000) GS:ffff9ef33ad80000(0000) knlGS:0000000000000000
> [255946.698835] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [255946.700604] CR2: 0000000000000000 CR3: 000000000760a005 CR4: 00000000003606e0
> [255946.702787] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [255946.704955] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [255946.707123] Call Trace:
> [255946.707918]  writeback_sb_inodes+0x1fe/0x460
> [255946.709244]  __writeback_inodes_wb+0x5d/0xb0
> [255946.710575]  wb_writeback+0x265/0x2f0
> [255946.711728]  ? wb_workfn+0x3cf/0x4d0
> [255946.712850]  wb_workfn+0x3cf/0x4d0
> [255946.713923]  process_one_work+0x195/0x390
> [255946.715173]  worker_thread+0x30/0x390
> [255946.716319]  ? process_one_work+0x390/0x390
> [255946.717625]  kthread+0x10d/0x130
> [255946.718789]  ? kthread_flush_work_fn+0x10/0x10
> [255946.720170]  ret_from_fork+0x35/0x40

So 4.18 is rather old and we had several fixes in this area for crashes
similar to the one you show above. The list was likely:

68f23b89067 ("memcg: fix a crash in wb_workfn when a device disappears")

but there were multiple changes before that to bdi logic to fix lifetime
issues when devices are hot-removed.

> There is a race condition between destroy_inode and writeback_sb_inodes,
> thread-1                                    thread-2
> wb_workfn
>   writeback_inodes_wb
>     __writeback_inodes_wb
>       writeback_sb_inodes
>         wbc_attach_and_unlock_inode
> 					iget_locked
>                                           destroy_inode
>                                             inode_detach_wb
>                                               inode->i_wb = NULL;

So thread-1 looks sensible but I don't see how what is in thread-2 can ever
happen. We can call destroy_inode() from iget_locked() only for inodes that
were never added to inode hash (and so they couldn't ever be dirty of even
be handled by the flusher thread). Active inodes must (and AFAIK always do)
pass through fs/inode.c:evict() which takes care of waiting for the running
flusher thread (through inode_wait_for_writeback()).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
