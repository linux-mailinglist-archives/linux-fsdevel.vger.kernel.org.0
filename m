Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D44311F727
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2019 11:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfLOKYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Dec 2019 05:24:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35678 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfLOKYi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Dec 2019 05:24:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so1993097pgk.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2019 02:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K/TKHTmFxJ8YdG3sUPcrGwBNTxenqC4Aj/U0QSaMIbY=;
        b=zOyf3Bwf+7Y/DitdVsQrhzKPj0M+ug6+s7ghDLXkd1tYz3NjBMxegPzIyTNoaf25ZS
         2NKbiOOirVwh/ZiY1J1xcp8W9YY2FwISMUQ8WV6a1T/DRXjUDIMvmiCTsTfDY1PrjMkE
         IK9XbelO9sb2bYI+8FZen7lShNhahmdJQRukfT4FoSNOxBsupjcRJq0tc3+eH542ztnU
         6sR8M2X7TGN/pBducUDkVuZ38iSKebtG1mqnCeRH+cuzM11Wi7DFcnwL97cgbShzcZ+6
         0RP5J2op1jbDzsrJb/nJu0XlpZp8FHMM3u6sh6atF+sftcgJ9N+iq4HU5PbONx2Xkn+n
         CxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K/TKHTmFxJ8YdG3sUPcrGwBNTxenqC4Aj/U0QSaMIbY=;
        b=RI+6gstrh1i9aL4MQRvN9exzvMCO7ffOPLkZokAGFsEUu63hoXDollUALfdqQW0J/3
         g5kNITZRjQg31Q5dsVZIzmdIJbLvj5hlA85NdMgpTO9SbGjYNZIr3OORzDd2kRX6qMif
         BpjRGLqDleTUQ3Q/0BAEvDVIBF0oosFzlUtHpxEzSuuxwR6vCmoFkNRPqtpIyZ5i/iT/
         XKo6T1R2gpqbT4qND+i8BfcbRz0o4YbY9gRu3eom8CP+c95yFXtwQ8h72ZrcmXCDw9RH
         JlVsl2uexRUFoKw0lNXWeURdCKOrnimeIk7NgzUHE4FpcQH9346MlCYcDBN35htm9QN1
         RqHw==
X-Gm-Message-State: APjAAAUTYYDZAfjnwz5RS9G/L59twb/zJNgg3wXCzveBoNSHN6kzxfSb
        foeEsxYT1N86J3KHoXQIK74v
X-Google-Smtp-Source: APXvYqxPwJuxJjnCWXIacyxzHwzOXHvU/cuyY2c40rTRORCWnto0ZGz8TH0sl1HNALnGYqRjCtxwEA==
X-Received: by 2002:a62:ed19:: with SMTP id u25mr10415002pfh.173.1576405471875;
        Sun, 15 Dec 2019 02:24:31 -0800 (PST)
Received: from morpheus.bobrowski.net (d114-75-67-234.sbr1.nsw.optusnet.com.au. [114.75.67.234])
        by smtp.gmail.com with ESMTPSA id i9sm18211213pfk.24.2019.12.15.02.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 02:24:31 -0800 (PST)
Date:   Sun, 15 Dec 2019 21:24:24 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        syzbot <syzbot+bea68382bae9490e7dd6@syzkaller.appspotmail.com>,
        darrick.wong@oracle.com, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-ext4@vger.kernel.org
Subject: Re: KASAN: use-after-free Read in iov_iter_alignment
Message-ID: <20191215102422.GA3967@morpheus.bobrowski.net>
References: <000000000000ad9f910598bbb867@google.com>
 <20191202211037.GF2695@dread.disaster.area>
 <20191202231118.GA7527@bobrowski.net>
 <20191213113030.GE15474@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213113030.GE15474@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 13, 2019 at 12:30:30PM +0100, Jan Kara wrote:
> On Tue 03-12-19 10:11:20, Matthew Bobrowski wrote:
> > On Tue, Dec 03, 2019 at 08:10:37AM +1100, Dave Chinner wrote:
> > > [cc linux-ext4@vger.kernel.org - this is reported from the new ext4
> > > dio->iomap code]
> > > 
> > > On Mon, Dec 02, 2019 at 09:15:08AM -0800, syzbot wrote:
> > > > Hello,
> > > > 
> > > > syzbot found the following crash on:
> > > > 
> > > > HEAD commit:    b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=135a8d7ae00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e464ae414aee8c
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=bea68382bae9490e7dd6
> > > > compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> > > > 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1135cb36e00000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e90abce00000
> > > > 
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+bea68382bae9490e7dd6@syzkaller.appspotmail.com
> > > > 
> > > > ==================================================================
> > > > BUG: KASAN: use-after-free in iov_iter_alignment+0x6a1/0x7b0
> > > > lib/iov_iter.c:1225
> > > > Read of size 4 at addr ffff888098d40f54 by task loop0/8203
> > > > 
> > > > CPU: 0 PID: 8203 Comm: loop0 Not tainted 5.4.0-syzkaller #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > Google 01/01/2011
> > > > Call Trace:
> > > >  __dump_stack lib/dump_stack.c:77 [inline]
> > > >  dump_stack+0x1fb/0x318 lib/dump_stack.c:118
> > > >  print_address_description+0x75/0x5c0 mm/kasan/report.c:374
> > > >  __kasan_report+0x14b/0x1c0 mm/kasan/report.c:506
> > > >  kasan_report+0x26/0x50 mm/kasan/common.c:634
> > > >  __asan_report_load4_noabort+0x14/0x20 mm/kasan/generic_report.c:131
> > > >  iov_iter_alignment+0x6a1/0x7b0 lib/iov_iter.c:1225
> > > >  iomap_dio_bio_actor+0x1a7/0x11e0 fs/iomap/direct-io.c:203
> > > >  iomap_dio_actor+0x2b4/0x4a0 fs/iomap/direct-io.c:375
> > > >  iomap_apply+0x370/0x490 fs/iomap/apply.c:80
> > > >  iomap_dio_rw+0x8ad/0x1010 fs/iomap/direct-io.c:493
> > > >  ext4_dio_read_iter fs/ext4/file.c:77 [inline]
> > > >  ext4_file_read_iter+0x834/0xc20 fs/ext4/file.c:128
> > > >  lo_rw_aio+0xcbb/0xea0 include/linux/fs.h:1889
> > > 
> > > loopback -> ext4 direct IO, bad access on iov passed to iomap DIO
> > > code.
> > > 
> > > >  do_req_filebacked drivers/block/loop.c:616 [inline]
> > > >  loop_handle_cmd drivers/block/loop.c:1952 [inline]
> > > >  loop_queue_work+0x13ab/0x2590 drivers/block/loop.c:1966
> > > >  kthread_worker_fn+0x449/0x700 kernel/kthread.c:671
> > > >  loop_kthread_worker_fn+0x40/0x60 drivers/block/loop.c:901
> > > >  kthread+0x332/0x350 kernel/kthread.c:255
> > > >  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> > > > 
> > > > Allocated by task 4198:
> > > >  save_stack mm/kasan/common.c:69 [inline]
> > > >  set_track mm/kasan/common.c:77 [inline]
> > > >  __kasan_kmalloc+0x11c/0x1b0 mm/kasan/common.c:510
> > > >  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:518
> > > >  slab_post_alloc_hook mm/slab.h:584 [inline]
> > > >  slab_alloc mm/slab.c:3319 [inline]
> > > >  kmem_cache_alloc+0x1f5/0x2e0 mm/slab.c:3483
> > > >  mempool_alloc_slab+0x4d/0x70 mm/mempool.c:513
> > > >  mempool_alloc+0x104/0x5e0 mm/mempool.c:393
> > > >  bio_alloc_bioset+0x1b0/0x5f0 block/bio.c:477
> > > >  bio_alloc include/linux/bio.h:400 [inline]
> > > >  mpage_alloc fs/mpage.c:79 [inline]
> > > >  do_mpage_readpage+0x1685/0x1d10 fs/mpage.c:306
> > > >  mpage_readpages+0x2a9/0x440 fs/mpage.c:404
> > > >  blkdev_readpages+0x2c/0x40 fs/block_dev.c:620
> > > >  read_pages+0xad/0x4d0 mm/readahead.c:126
> > > >  __do_page_cache_readahead+0x480/0x530 mm/readahead.c:212
> > > >  force_page_cache_readahead mm/readahead.c:243 [inline]
> > > >  page_cache_sync_readahead+0x329/0x3b0 mm/readahead.c:522
> > > >  generic_file_buffered_read+0x41d/0x2570 mm/filemap.c:2051
> > > >  generic_file_read_iter+0xa9/0x450 mm/filemap.c:2324
> > > >  blkdev_read_iter+0x12e/0x140 fs/block_dev.c:2039
> > > >  call_read_iter include/linux/fs.h:1889 [inline]
> > > >  new_sync_read fs/read_write.c:414 [inline]
> > > >  __vfs_read+0x59e/0x730 fs/read_write.c:427
> > > >  vfs_read+0x1dd/0x420 fs/read_write.c:461
> > > >  ksys_read+0x117/0x220 fs/read_write.c:587
> > > >  __do_sys_read fs/read_write.c:597 [inline]
> > > >  __se_sys_read fs/read_write.c:595 [inline]
> > > >  __x64_sys_read+0x7b/0x90 fs/read_write.c:595
> > > >  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
> > > >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > > 
> > > > Freed by task 4205:
> > > >  save_stack mm/kasan/common.c:69 [inline]
> > > >  set_track mm/kasan/common.c:77 [inline]
> > > >  kasan_set_free_info mm/kasan/common.c:332 [inline]
> > > >  __kasan_slab_free+0x12a/0x1e0 mm/kasan/common.c:471
> > > >  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
> > > >  __cache_free mm/slab.c:3425 [inline]
> > > >  kmem_cache_free+0x81/0xf0 mm/slab.c:3693
> > > >  mempool_free_slab+0x1d/0x30 mm/mempool.c:520
> > > >  mempool_free+0xd5/0x350 mm/mempool.c:502
> > > >  bio_put+0x38b/0x460 block/bio.c:255
> > > >  mpage_end_io+0x2f5/0x330 fs/mpage.c:58
> > > >  bio_endio+0x4ff/0x570 block/bio.c:1818
> > > >  req_bio_endio block/blk-core.c:245 [inline]
> > > >  blk_update_request+0x438/0x10d0 block/blk-core.c:1464
> > > >  scsi_end_request+0x8c/0xa20 drivers/scsi/scsi_lib.c:579
> > > >  scsi_io_completion+0x17c/0x1b80 drivers/scsi/scsi_lib.c:963
> > > >  scsi_finish_command+0x3b3/0x560 drivers/scsi/scsi.c:228
> > > >  scsi_softirq_done+0x289/0x310 drivers/scsi/scsi_lib.c:1477
> > > >  blk_done_softirq+0x312/0x370 block/blk-softirq.c:37
> > > >  __do_softirq+0x333/0x7c4 arch/x86/include/asm/paravirt.h:762
> > > 
> > > Looks like buffered read IO on a loopback device on an ext4 image
> > > file, and something is being tripped over in the new ext4 direct IO
> > > path.  Might be an iomap issue, might be an ext4 issue, but it looks
> > > like the buffered read bio completion is running while the iov is
> > > still being submitted...
> > 
> > Thanks Dave.
> > 
> > I will take a look at this when I get home this evening and see
> > whether I can pinpoint what's going on here...
> 
> Any luck in diagnosing this Matthew?

No, not yet. I just purchased my first home and I'm not far out from
my wedding day, so I've had my hands tied behind by back doing all
that crap. I will try get to it sometime this week.

/M

