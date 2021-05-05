Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7972F373A34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 14:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhEEMIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 08:08:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:38984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233034AbhEEMHk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 08:07:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52E96AE46;
        Wed,  5 May 2021 12:06:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B2CEC1F2B59; Wed,  5 May 2021 14:06:40 +0200 (CEST)
Date:   Wed, 5 May 2021 14:06:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Ye Bin <yebin10@huawei.com>
Subject: Re: [BUG RERPORT] BUG_ON(!list_empty(&inode->i_wb_list))
Message-ID: <20210505120640.GC29867@quack2.suse.cz>
References: <27fd4b04-8b25-1c41-ea4c-0de45138e73d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27fd4b04-8b25-1c41-ea4c-0de45138e73d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-05-21 17:07:33, yangerkun wrote:
> Our syzkaller test trigger this BUG_ON in clear_inode:
> 
> [   95.235069] Killed process 7637 (syz-executor) total-vm:37044kB,
> anon-rss:76kB, file-rss:632kB, shmem-rss:0kB
> [   95.238504] Memory cgroup out of memory: Kill process 284 (syz-executor)
> score 187000 or sacrifice child
> [   95.240419] Killed process 284 (syz-executor) total-vm:37044kB,
> anon-rss:76kB, file-rss:632kB, shmem-rss:0kB
> [   95.263244] Injecting memory failure for pfn 0x3a5876 at process virtual
> address 0x20ffd000
> [   95.282421] Memory failure: 0x3a5876: recovery action for dirty LRU page:
> Recovered
> [   95.283992] Injecting memory failure for pfn 0x3a6005 at process virtual
> address 0x20ffe000
> [   95.379135] Memory failure: 0x3a6005: recovery action for dirty LRU page:
> Recovered
> [   95.380853] Injecting memory failure for pfn 0x3a7048 at process virtual
> address 0x20fff000
> [   95.422596] Memory failure: 0x3a7048: recovery action for dirty LRU page:
> Recovered
> [   95.596571] JBD2: Detected IO errors while flushing file data on vda-8
> [   95.858655] device bridge_slave_0 left promiscuous mode
> [   95.870838] bridge0: port 1(bridge_slave_0) entered disabled state
> [   96.039754] ------------[ cut here ]------------
> [   96.041176] kernel BUG at fs/inode.c:519!

So this is BUG_ON(!list_empty(&inode->i_wb_list)) I assume?

> [   96.042424] Internal error: Oops - BUG: 0 [#1] SMP
> [   96.043892] Dumping ftrace buffer:
> [   96.044956]    (ftrace buffer empty)
> [   96.046068] Modules linked in:
> [   96.047104] Process syz-executor (pid: 7811, stack limit =
> 0x000000009f3892d3)
> [   96.049217] CPU: 1 PID: 7811 Comm: syz-executor Not tainted 4.19.95 #9
> [   96.051144] Hardware name: linux,dummy-virt (DT)
> [   96.052570] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [   96.054065] pc : clear_inode+0x280/0x2a8
> [   96.055317] lr : clear_inode+0x280/0x2a8
> [   96.056548] sp : ffff800352797950
> [   96.057604] x29: ffff800352797950 x28: 0000000000000000
> [   96.059295] x27: ffff800358854c00 x26: ffff800358854b70
> [   96.060982] x25: ffff80036af01100 x24: ffff800369e48aa8
> [   96.062673] x23: ffff80036af02600 x22: 0000000000047f3d
> [   96.064358] x21: 0000000000000000 x20: ffff800358854c98
> [   96.066025] x19: ffff800358854b70 x18: 0000000000000000
> [   96.067703] x17: 0000000000000000 x16: 0000000000000000
> [   96.069370] x15: 0000000000000000 x14: 0000000000000000
> [   96.071049] x13: 0000000000000000 x12: 0000000000000000
> [   96.072738] x11: 1ffff0006cfc1faf x10: 0000000000000ba0
> [   96.074418] x9 : ffff8003527976a0 x8 : ffff800359511c00
> [   96.076102] x7 : 1ffff0006cfc1f50 x6 : dfff200000000000
> [   96.077783] x5 : 00000000f2f2f200 x4 : ffff800358854c98
> [   96.079469] x3 : ffff200008000000 x2 : ffff200009867000
> [   96.081145] x1 : ffff800359511000 x0 : 0000000000000000
> [   96.082835] Call trace:
> [   96.083725]  clear_inode+0x280/0x2a8
> [   96.084886]  ext4_clear_inode+0x38/0xe8
> [   96.086113]  ext4_free_inode+0x130/0xc68
> [   96.087371]  ext4_evict_inode+0xb20/0xcb8
> [   96.088648]  evict+0x1a8/0x3c0
> [   96.089655]  iput+0x344/0x460
> [   96.090639]  do_unlinkat+0x260/0x410
> [   96.091802]  __arm64_sys_unlinkat+0x6c/0xc0
> [   96.093143]  el0_svc_common+0xdc/0x3b0
> [   96.094349]  el0_svc_handler+0xf8/0x160
> [   96.095583]  el0_svc+0x10/0x218
> [   96.096609] Code: 9413f4a9 d503201f f90017b6 97f4d5b1 (d4210000)
> [   96.098542] ---[ end trace 93e81128c9262960 ]---
> 
> The vmcore show that's a ext4 inode with order journal mode. The "Injecting
> memory failure" will call me_pagecache_dirty and then trigger the "JBD2:
> Detected IO" since it inject the EIO for this page.
> 
> We have a guess show as latter(just guess...). memory_failure will decrease
> nrpages to 0, then ext4_evict_inode won't use mapping->i_pages, so
> list_del_init that end_page_writeback has did won't been seen since there is
> no barrier can ensure that, and then trigger the BUG_ON.
> 
> We have add some debug info the check this guess. But since it really hard
> to trigger this again. So, does there anyone can help to recheck the guess,
> or can help to give advise for this problem?

Hmm, I don't think what you propose can happen since clear_inode() cycles
through i_pages lock and by the time clear_inode() is called,
end_page_writeback() must be holding this lock in order to clear
PageWriteback bit. So there must be something else going on but so far I
have no idea what it could be.

								Honza

> end_page_writeback
>   test_clear_page_writeback
>     xa_lock_irqsave(&mapping->i_pages, flags)
> 	TestClearPageWriteback(page)
> 	sb_clear_inode_writeback
> 	  list_del_init(&inode->i_wb_list)
> 	xa_unlock_irqrestore(&mapping->i_pages, flags)
> 
> memory_failure
>   lock_page(p)
>   wait_on_page_writeback(p)
>   identify_page_state
>     page_action
> 	  me_pagecache_dirty
> 	  mapping_set_error(mapping, -EIO)
> 	  me_pagecache_clean(p, pfn)
> 	    generic_error_remove_page
> 		  truncate_inode_page(mapping, page)
> 		    delete_from_page_cache
> 			  xa_lock_irqsave(&mapping->i_pages, flags)
> 			  __delete_from_page_cache(page, NULL)
> 			    page_cache_tree_delete
> 				  mapping->nrpages -= nr --> will decrease nrpages to 0
> 			  xa_unlock_irqrestore(&mapping->i_pages, flags)
> 
> 
> ext4_evict_inode
>   truncate_inode_pages_final
>     truncate_inode_pages
> 	  truncate_inode_pages_range
> 	     if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
> 		   goto out; --> won't lock mapping->i_pages, so no barrier can ensure we
> see list_del_init
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
