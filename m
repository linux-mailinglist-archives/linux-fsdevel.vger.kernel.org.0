Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A28163C25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 05:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgBSEwi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 23:52:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36514 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgBSEwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 23:52:38 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4HLY-00F4Ft-Q9; Wed, 19 Feb 2020 04:52:28 +0000
Date:   Wed, 19 Feb 2020 04:52:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@lca.pw>
Cc:     hch@infradead.org, darrick.wong@oracle.com, elver@google.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix a data race in i_size_write/i_size_read
Message-ID: <20200219045228.GO23230@ZenIV.linux.org.uk>
References: <20200219040426.1140-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219040426.1140-1-cai@lca.pw>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 11:04:26PM -0500, Qian Cai wrote:
> inode::i_size could be accessed concurently as noticed by KCSAN,
> 
>  BUG: KCSAN: data-race in iomap_do_writepage / iomap_write_end
> 
>  write to 0xffff8bf68fc0cac0 of 8 bytes by task 7484 on cpu 71:
>   iomap_write_end+0xea/0x530
>   i_size_write at include/linux/fs.h:888
>   (inlined by) iomap_write_end at fs/iomap/buffered-io.c:782
>   iomap_write_actor+0x132/0x200
>   iomap_apply+0x245/0x8a5
>   iomap_file_buffered_write+0xbd/0xf0
>   xfs_file_buffered_aio_write+0x1c2/0x790 [xfs]
>   xfs_file_write_iter+0x232/0x2d0 [xfs]
>   new_sync_write+0x29c/0x3b0
>   __vfs_write+0x92/0xa0
>   vfs_write+0x103/0x260
>   ksys_write+0x9d/0x130
>   __x64_sys_write+0x4c/0x60
>   do_syscall_64+0x91/0xb05
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>  read to 0xffff8bf68fc0cac0 of 8 bytes by task 5901 on cpu 70:
>   iomap_do_writepage+0xf4/0x450
>   i_size_read at include/linux/fs.h:866
>   (inlined by) iomap_do_writepage at fs/iomap/buffered-io.c:1558
>   write_cache_pages+0x523/0xb20
>   iomap_writepages+0x47/0x80
>   xfs_vm_writepages+0xc7/0x100 [xfs]
>   do_writepages+0x5e/0x130
>   __writeback_single_inode+0xd5/0xb20
>   writeback_sb_inodes+0x429/0x910
>   __writeback_inodes_wb+0xc4/0x150
>   wb_writeback+0x47b/0x830
>   wb_workfn+0x688/0x930
>   process_one_work+0x54f/0xb90
>   worker_thread+0x80/0x5f0
>   kthread+0x1cd/0x1f0
>   ret_from_fork+0x27/0x50
> 
>  Reported by Kernel Concurrency Sanitizer on:
>  CPU: 70 PID: 5901 Comm: kworker/u257:2 Tainted: G             L    5.6.0-rc2-next-20200218+ #2
>  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
>  Workqueue: writeback wb_workfn (flush-254:0)
> 
> The write is protected by exclusive inode::i_rwsem (in
> xfs_file_buffered_aio_write()) but the read is not. A shattered value
> could introduce a logic bug. Fixed it using a pair of WRITE/READ_ONCE().

If aligned 64bit stores on 64bit host (note the BITS_PER_LONG ifdefs) end up
being split, the kernel is FUBAR anyway.  Details, please - how could that
end up happening?
