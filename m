Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFAE10F1F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 22:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfLBVKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 16:10:44 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:54587 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbfLBVKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:10:44 -0500
Received: from dread.disaster.area (pa49-179-150-192.pa.nsw.optusnet.com.au [49.179.150.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 0327A7E9FD1;
        Tue,  3 Dec 2019 08:10:38 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ibsxp-00062Y-1P; Tue, 03 Dec 2019 08:10:37 +1100
Date:   Tue, 3 Dec 2019 08:10:37 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     syzbot <syzbot+bea68382bae9490e7dd6@syzkaller.appspotmail.com>
Cc:     darrick.wong@oracle.com, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-ext4@vger.kernel.org
Subject: Re: KASAN: use-after-free Read in iov_iter_alignment
Message-ID: <20191202211037.GF2695@dread.disaster.area>
References: <000000000000ad9f910598bbb867@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ad9f910598bbb867@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=ZXpxJgW8/q3NVgupyyvOCQ==:117 a=ZXpxJgW8/q3NVgupyyvOCQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=VwQbUJbxAAAA:8 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=7-415B0cAAAA:8
        a=GgU9mlvPnS_d5YxFlCIA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[cc linux-ext4@vger.kernel.org - this is reported from the new ext4
dio->iomap code]

On Mon, Dec 02, 2019 at 09:15:08AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=135a8d7ae00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e464ae414aee8c
> dashboard link: https://syzkaller.appspot.com/bug?extid=bea68382bae9490e7dd6
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1135cb36e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e90abce00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+bea68382bae9490e7dd6@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in iov_iter_alignment+0x6a1/0x7b0
> lib/iov_iter.c:1225
> Read of size 4 at addr ffff888098d40f54 by task loop0/8203
> 
> CPU: 0 PID: 8203 Comm: loop0 Not tainted 5.4.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1fb/0x318 lib/dump_stack.c:118
>  print_address_description+0x75/0x5c0 mm/kasan/report.c:374
>  __kasan_report+0x14b/0x1c0 mm/kasan/report.c:506
>  kasan_report+0x26/0x50 mm/kasan/common.c:634
>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/generic_report.c:131
>  iov_iter_alignment+0x6a1/0x7b0 lib/iov_iter.c:1225
>  iomap_dio_bio_actor+0x1a7/0x11e0 fs/iomap/direct-io.c:203
>  iomap_dio_actor+0x2b4/0x4a0 fs/iomap/direct-io.c:375
>  iomap_apply+0x370/0x490 fs/iomap/apply.c:80
>  iomap_dio_rw+0x8ad/0x1010 fs/iomap/direct-io.c:493
>  ext4_dio_read_iter fs/ext4/file.c:77 [inline]
>  ext4_file_read_iter+0x834/0xc20 fs/ext4/file.c:128
>  lo_rw_aio+0xcbb/0xea0 include/linux/fs.h:1889

loopback -> ext4 direct IO, bad access on iov passed to iomap DIO
code.

>  do_req_filebacked drivers/block/loop.c:616 [inline]
>  loop_handle_cmd drivers/block/loop.c:1952 [inline]
>  loop_queue_work+0x13ab/0x2590 drivers/block/loop.c:1966
>  kthread_worker_fn+0x449/0x700 kernel/kthread.c:671
>  loop_kthread_worker_fn+0x40/0x60 drivers/block/loop.c:901
>  kthread+0x332/0x350 kernel/kthread.c:255
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> Allocated by task 4198:
>  save_stack mm/kasan/common.c:69 [inline]
>  set_track mm/kasan/common.c:77 [inline]
>  __kasan_kmalloc+0x11c/0x1b0 mm/kasan/common.c:510
>  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:518
>  slab_post_alloc_hook mm/slab.h:584 [inline]
>  slab_alloc mm/slab.c:3319 [inline]
>  kmem_cache_alloc+0x1f5/0x2e0 mm/slab.c:3483
>  mempool_alloc_slab+0x4d/0x70 mm/mempool.c:513
>  mempool_alloc+0x104/0x5e0 mm/mempool.c:393
>  bio_alloc_bioset+0x1b0/0x5f0 block/bio.c:477
>  bio_alloc include/linux/bio.h:400 [inline]
>  mpage_alloc fs/mpage.c:79 [inline]
>  do_mpage_readpage+0x1685/0x1d10 fs/mpage.c:306
>  mpage_readpages+0x2a9/0x440 fs/mpage.c:404
>  blkdev_readpages+0x2c/0x40 fs/block_dev.c:620
>  read_pages+0xad/0x4d0 mm/readahead.c:126
>  __do_page_cache_readahead+0x480/0x530 mm/readahead.c:212
>  force_page_cache_readahead mm/readahead.c:243 [inline]
>  page_cache_sync_readahead+0x329/0x3b0 mm/readahead.c:522
>  generic_file_buffered_read+0x41d/0x2570 mm/filemap.c:2051
>  generic_file_read_iter+0xa9/0x450 mm/filemap.c:2324
>  blkdev_read_iter+0x12e/0x140 fs/block_dev.c:2039
>  call_read_iter include/linux/fs.h:1889 [inline]
>  new_sync_read fs/read_write.c:414 [inline]
>  __vfs_read+0x59e/0x730 fs/read_write.c:427
>  vfs_read+0x1dd/0x420 fs/read_write.c:461
>  ksys_read+0x117/0x220 fs/read_write.c:587
>  __do_sys_read fs/read_write.c:597 [inline]
>  __se_sys_read fs/read_write.c:595 [inline]
>  __x64_sys_read+0x7b/0x90 fs/read_write.c:595
>  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 4205:
>  save_stack mm/kasan/common.c:69 [inline]
>  set_track mm/kasan/common.c:77 [inline]
>  kasan_set_free_info mm/kasan/common.c:332 [inline]
>  __kasan_slab_free+0x12a/0x1e0 mm/kasan/common.c:471
>  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
>  __cache_free mm/slab.c:3425 [inline]
>  kmem_cache_free+0x81/0xf0 mm/slab.c:3693
>  mempool_free_slab+0x1d/0x30 mm/mempool.c:520
>  mempool_free+0xd5/0x350 mm/mempool.c:502
>  bio_put+0x38b/0x460 block/bio.c:255
>  mpage_end_io+0x2f5/0x330 fs/mpage.c:58
>  bio_endio+0x4ff/0x570 block/bio.c:1818
>  req_bio_endio block/blk-core.c:245 [inline]
>  blk_update_request+0x438/0x10d0 block/blk-core.c:1464
>  scsi_end_request+0x8c/0xa20 drivers/scsi/scsi_lib.c:579
>  scsi_io_completion+0x17c/0x1b80 drivers/scsi/scsi_lib.c:963
>  scsi_finish_command+0x3b3/0x560 drivers/scsi/scsi.c:228
>  scsi_softirq_done+0x289/0x310 drivers/scsi/scsi_lib.c:1477
>  blk_done_softirq+0x312/0x370 block/blk-softirq.c:37
>  __do_softirq+0x333/0x7c4 arch/x86/include/asm/paravirt.h:762

Looks like buffered read IO on a loopback device on an ext4 image
file, and something is being tripped over in the new ext4 direct IO
path.  Might be an iomap issue, might be an ext4 issue, but it looks
like the buffered read bio completion is running while the iov is
still being submitted...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
