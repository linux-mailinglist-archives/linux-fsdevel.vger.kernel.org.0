Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3149A86575
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 17:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbfHHPRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 11:17:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730678AbfHHPRM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:17:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7005330A00DE;
        Thu,  8 Aug 2019 15:17:11 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A280E5EE1D;
        Thu,  8 Aug 2019 15:17:02 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x78FH2gH019766;
        Thu, 8 Aug 2019 11:17:02 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x78FH1f4019762;
        Thu, 8 Aug 2019 11:17:02 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 8 Aug 2019 11:17:01 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Mike Snitzer <msnitzer@redhat.com>, junxiao.bi@oracle.com,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        honglei.wang@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH] loop: set PF_MEMALLOC_NOIO for the worker thread
In-Reply-To: <20190808135329.GG5482@bombadil.infradead.org>
Message-ID: <alpine.LRH.2.02.1908081113540.18950@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1908080540240.15519@file01.intranet.prod.int.rdu2.redhat.com> <20190808135329.GG5482@bombadil.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 08 Aug 2019 15:17:11 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A deadlock with this stacktrace was observed.

The loop thread does a GFP_KERNEL allocation, it calls into dm-bufio
shrinker and the shrinker depends on I/O completion in the dm-bufio
subsystem.

In order to fix the deadlock (and other similar ones), we set the flag
PF_MEMALLOC_NOIO at loop thread entry.

PID: 474    TASK: ffff8813e11f4600  CPU: 10  COMMAND: "kswapd0"
   #0 [ffff8813dedfb938] __schedule at ffffffff8173f405
   #1 [ffff8813dedfb990] schedule at ffffffff8173fa27
   #2 [ffff8813dedfb9b0] schedule_timeout at ffffffff81742fec
   #3 [ffff8813dedfba60] io_schedule_timeout at ffffffff8173f186
   #4 [ffff8813dedfbaa0] bit_wait_io at ffffffff8174034f
   #5 [ffff8813dedfbac0] __wait_on_bit at ffffffff8173fec8
   #6 [ffff8813dedfbb10] out_of_line_wait_on_bit at ffffffff8173ff81
   #7 [ffff8813dedfbb90] __make_buffer_clean at ffffffffa038736f [dm_bufio]
   #8 [ffff8813dedfbbb0] __try_evict_buffer at ffffffffa0387bb8 [dm_bufio]
   #9 [ffff8813dedfbbd0] dm_bufio_shrink_scan at ffffffffa0387cc3 [dm_bufio]
  #10 [ffff8813dedfbc40] shrink_slab at ffffffff811a87ce
  #11 [ffff8813dedfbd30] shrink_zone at ffffffff811ad778
  #12 [ffff8813dedfbdc0] kswapd at ffffffff811ae92f
  #13 [ffff8813dedfbec0] kthread at ffffffff810a8428
  #14 [ffff8813dedfbf50] ret_from_fork at ffffffff81745242

  PID: 14127  TASK: ffff881455749c00  CPU: 11  COMMAND: "loop1"
   #0 [ffff88272f5af228] __schedule at ffffffff8173f405
   #1 [ffff88272f5af280] schedule at ffffffff8173fa27
   #2 [ffff88272f5af2a0] schedule_preempt_disabled at ffffffff8173fd5e
   #3 [ffff88272f5af2b0] __mutex_lock_slowpath at ffffffff81741fb5
   #4 [ffff88272f5af330] mutex_lock at ffffffff81742133
   #5 [ffff88272f5af350] dm_bufio_shrink_count at ffffffffa03865f9 [dm_bufio]
   #6 [ffff88272f5af380] shrink_slab at ffffffff811a86bd
   #7 [ffff88272f5af470] shrink_zone at ffffffff811ad778
   #8 [ffff88272f5af500] do_try_to_free_pages at ffffffff811adb34
   #9 [ffff88272f5af590] try_to_free_pages at ffffffff811adef8
  #10 [ffff88272f5af610] __alloc_pages_nodemask at ffffffff811a09c3
  #11 [ffff88272f5af710] alloc_pages_current at ffffffff811e8b71
  #12 [ffff88272f5af760] new_slab at ffffffff811f4523
  #13 [ffff88272f5af7b0] __slab_alloc at ffffffff8173a1b5
  #14 [ffff88272f5af880] kmem_cache_alloc at ffffffff811f484b
  #15 [ffff88272f5af8d0] do_blockdev_direct_IO at ffffffff812535b3
  #16 [ffff88272f5afb00] __blockdev_direct_IO at ffffffff81255dc3
  #17 [ffff88272f5afb30] xfs_vm_direct_IO at ffffffffa01fe3fc [xfs]
  #18 [ffff88272f5afb90] generic_file_read_iter at ffffffff81198994
  #19 [ffff88272f5afc50] __dta_xfs_file_read_iter_2398 at ffffffffa020c970 [xfs]
  #20 [ffff88272f5afcc0] lo_rw_aio at ffffffffa0377042 [loop]
  #21 [ffff88272f5afd70] loop_queue_work at ffffffffa0377c3b [loop]
  #22 [ffff88272f5afe60] kthread_worker_fn at ffffffff810a8a0c
  #23 [ffff88272f5afec0] kthread at ffffffff810a8428
  #24 [ffff88272f5aff50] ret_from_fork at ffffffff81745242

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/block/loop.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/block/loop.c
===================================================================
--- linux-2.6.orig/drivers/block/loop.c	2019-08-08 17:02:50.000000000 +0200
+++ linux-2.6/drivers/block/loop.c	2019-08-08 17:08:14.000000000 +0200
@@ -885,7 +885,7 @@ static void loop_unprepare_queue(struct
 
 static int loop_kthread_worker_fn(void *worker_ptr)
 {
-	current->flags |= PF_LESS_THROTTLE;
+	current->flags |= PF_LESS_THROTTLE | PF_MEMALLOC_NOIO;
 	return kthread_worker_fn(worker_ptr);
 }
 

