Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D458FD1BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 00:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfKNXyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 18:54:23 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:53101 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726997AbfKNXyX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 18:54:23 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B5E8E3A2425;
        Fri, 15 Nov 2019 10:54:16 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iVOwJ-0004bn-3b; Fri, 15 Nov 2019 10:54:15 +1100
Date:   Fri, 15 Nov 2019 10:54:15 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191114235415.GL4614@dread.disaster.area>
References: <20191114113153.GB4213@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114113153.GB4213@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=7-415B0cAAAA:8 a=20KFwNOVAAAA:8 a=uXJwwJn_uWDXfiQlzYkA:9
        a=CP6GjIOWf8w4HsH5:21 a=4A_K39oNH4pl_DS6:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 07:31:53PM +0800, Ming Lei wrote:
> Hi Guys,
> 
> It is found that single AIO thread is migrated crazely by scheduler, and
> the migrate period can be < 10ms. Follows the test a):
> 
> 	- run single job fio[1] for 30 seconds:
> 	./xfs_complete 512
> 	
> 	- observe fio io thread migration via bcc trace[2], and the migration
> 	times can reach 5k ~ 10K in above test. In this test, CPU utilization
> 	is 30~40% on the CPU running fio IO thread.

Using the default scheduler tunings:

kernel.sched_wakeup_granularity_ns = 4000000
kernel.sched_min_granularity_ns = 3000000

I'm not seeing any migrations at all on a 16p x86-64 box. Even with
the tunings you suggest:

	sysctl kernel.sched_min_granularity_ns=10000000
	sysctl kernel.sched_wakeup_granularity_ns=15000000

There are no migrations at all.

During the overwrite phase of the test, I'm seeing 66% fio usage,
28% system time and of that, only 3% of the CPU time is in the IO
completion workqueue time. It's all running on the one CPU, and it's
running at about 15,000 context switches per second.. I'm not seeing
any CPU migrations at all, despite the workload being completely CPU
bound on a single CPU.

This is the typical output from top:

Tasks: 262 total,   2 running, 260 sleeping,   0 stopped,   0 zombie
%Cpu0  :  0.0 us,  0.3 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu1  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu2  :  0.0 us,  0.3 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu3  : 66.2 us, 27.8 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi,  6.0 si,  0.0 st
%Cpu4  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu5  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu6  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu7  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu8  :  0.0 us,  0.0 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.3 si,  0.0 st
%Cpu9  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu10 :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu11 :  0.0 us,  0.3 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu12 :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu13 :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu14 :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu15 :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :  16005.3 total,   8737.7 free,   6762.5 used,    505.2 buff/cache
MiB Swap:    486.3 total,    486.3 free,      0.0 used.   8640.3 avail Mem 

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
   5554 root      20   0  672064  15356   1392 R  97.0   0.1   0:17.85 fio
   1388 root      20   0       0      0      0 I   3.0   0.0   0:01.39 kworker/3:1-dio/sdb
   5552 root      20   0  661364 275380 271992 S   0.7   1.7   0:15.88 fio
   4891 dave      20   0   15572   5876   4600 S   0.3   0.0   0:00.56 sshd
   4933 dave      20   0   11732   4276   3296 R   0.3   0.0   0:01.30 top

i.e. it runs entirely on CPU 3 for the whole 30s measurement period.

And the number of migrate task events:

$ sudo trace-cmd start -e sched_migrate_task
$ sudo ./run_test.sh
.....
$ sudo trace-cmd show |grep fio
     kworker/1:1-1252  [001] d..2  2002.792659: sched_migrate_task: comm=fio pid=5689 prio=120 orig_cpu=5 dest_cpu=1
     rcu_preempt-11    [011] d..2  2004.202624: sched_migrate_task: comm=fio pid=5689 prio=120 orig_cpu=1 dest_cpu=11
     rcu_preempt-11    [006] d..2  2008.364481: sched_migrate_task: comm=fio pid=5689 prio=120 orig_cpu=11 dest_cpu=6
          <idle>-0     [007] dNs2  2009.209480: sched_migrate_task: comm=fio pid=5689 prio=120 orig_cpu=6 dest_cpu=7
$

And top tells me these fio processes are consuming CPU:

   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                                                                                  
   5695 root      20   0  663872   7120   1324 R  97.7   0.0   0:03.48 fio                                                                                      
   5689 root      20   0  661356 275512 272128 S   0.3   1.7   0:15.46 fio                                                                                      

So, the fio process that got migrated 4 times in 30s is the fio
process that isn't doing any of the work.

There's no migration going on here at all on a vanilla kernel on
a Debian userspace, with or without the suggested scheduler
tunings.

> 	- after applying the debug patch[3] to queue XFS completion work on
> 	other CPU(not current CPU), the above crazy fio IO thread migration
> 	can't be observed.
>
> IMO, it is normal for user to saturate aio thread, since this way may
> save context switch.
> 
> Guys, any idea on the crazy aio thread migration?

It doesn't happen on x86-64 with a current TOT vanilla kernel and
a debian userspace.

What userspace are you testing with?

> BTW, the tests are run on latest linus tree(5.4-rc7) in KVM guest, and the
> fio test is created for simulating one real performance report which is
> proved to be caused by frequent aio submission thread migration.

What is the underlying hardware? I'm running in a 16p KVM guest on a
16p/32t x86-64 using 5.4-rc7, and I don't observe any significant
CPU migration occurring at all from your test workload.

> [3] test patch for queuing xfs completetion on other CPU
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 1fc28c2da279..bdc007a57706 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -158,9 +158,14 @@ static void iomap_dio_bio_end_io(struct bio *bio)
>  			blk_wake_io_task(waiter);
>  		} else if (dio->flags & IOMAP_DIO_WRITE) {
>  			struct inode *inode = file_inode(dio->iocb->ki_filp);
> +			unsigned cpu = cpumask_next(smp_processor_id(),
> +					cpu_online_mask);
> +
> +			if (cpu >= nr_cpu_ids)
> +				cpu = 0;
>  
>  			INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
> -			queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
> +			queue_work_on(cpu, inode->i_sb->s_dio_done_wq, &dio->aio.work);
>  		} else {
>  			iomap_dio_complete_work(&dio->aio.work);
>  		}

So, can you test the patch I sent you a while back that avoided
using the completion workqueue for pure overwrites? Does that make
your whacky scheduler behaviour go away, or does it still reschedule
like crazy?

I haven't posted that patch to the list because I can't prove it
makes any difference to performance in any workload on any hardware
I've tested it on. I just tested it on your workload, and it makes
no different to behaviour or performance. It's definitely hitting
the non-workqueue completion path:

$ sudo trace-cmd show | grep overwrite |head -1
             fio-4526  [009] ..s.   180.361089: iomap_dio_bio_end_io: overwrite completion
$ sudo trace-cmd show | grep overwrite |wc -l
51295
$

so it's pretty clear that whatever is going on is not obviously a
problem with workqueues or the way iomap does completions. Patch is
attached below for you to test. You will need to pull commit
7684e2c4384d ("iomap: iomap that extends beyond EOF should be marked
dirty") from the iomap for-next branch to ensure this patch
functions correctly.

Cheers,

-Dave.
-- 
Dave Chinner
david@fromorbit.com

iomap: don't defer completion of pure AIO+DIO overwrites

From: Dave Chinner <dchinner@redhat.com>

We have a workload issuing 4k sequential AIO+DIOs in batches (yeah,
really silly thing to do when you could just emit a single large
IO) that is showing some interesting performance anomalies. i.e.
massive performance regressions that go away when the workload is
straced because it changes AIO completion scheduling and submission
batch sizes....

Older kernels that don't have the iomap DIO code don't show the same
regression, and they complete the AIO-DIO in the the bio completion
context rather than deferring it to a workqueue like iomap does.

Hence, for pure overwrites that don't require any metadata updates
on IO completion, including file size, call the IO completion
directly rather than deferring it to the completion workqueue. THe
IOMAP_DIO_OVERWRITE flag is added to tell ->end_io implementations
that they are running in bio completion context and that they should
not have any update work to do. This leverages the iomap FUA
optimisations that allow FUA writes to be issued when no metadata
updates are required to be synced to disk during IO completion.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/iomap/direct-io.c  | 26 ++++++++++++++++++++------
 fs/xfs/xfs_file.c     |  3 +++
 include/linux/iomap.h |  8 ++++++++
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 49bf9780e3ed..a89b29306794 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -159,8 +159,14 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 		} else if (dio->flags & IOMAP_DIO_WRITE) {
 			struct inode *inode = file_inode(dio->iocb->ki_filp);
 
-			INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
-			queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
+			if ((dio->flags & IOMAP_DIO_OVERWRITE) &&
+			     !inode->i_mapping->nrpages) {
+				trace_printk("overwrite completion\n");
+				iomap_dio_complete_work(&dio->aio.work);
+			} else {
+				INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
+				queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
+			}
 		} else {
 			iomap_dio_complete_work(&dio->aio.work);
 		}
@@ -229,10 +235,12 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		 * the underlying device supports FUA. This allows us to avoid
 		 * cache flushes on IO completion.
 		 */
-		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
-		    (dio->flags & IOMAP_DIO_WRITE_FUA) &&
-		    blk_queue_fua(bdev_get_queue(iomap->bdev)))
-			use_fua = true;
+		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY))) {
+			dio->flags |= IOMAP_DIO_OVERWRITE;
+			if ((dio->flags & IOMAP_DIO_WRITE_FUA) &&
+			    blk_queue_fua(bdev_get_queue(iomap->bdev)))
+				use_fua = true;
+		}
 	}
 
 	/*
@@ -511,9 +519,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	/*
 	 * If all the writes we issued were FUA, we don't need to flush the
 	 * cache on IO completion. Clear the sync flag for this case.
+	 *
+	 * If we are doing an overwrite and need to sync and FUA cannot be used,
+	 * clear the overwrite flag to ensure the completion is run via the
+	 * workqueue rather than directly.
 	 */
 	if (dio->flags & IOMAP_DIO_WRITE_FUA)
 		dio->flags &= ~IOMAP_DIO_NEED_SYNC;
+	if (dio->flags & IOMAP_DIO_NEED_SYNC)
+		dio->flags &= ~IOMAP_DIO_OVERWRITE;
 
 	WRITE_ONCE(iocb->ki_cookie, dio->submit.cookie);
 	WRITE_ONCE(iocb->private, dio->submit.last_queue);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 525b29b99116..794dea2f1dc3 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -395,6 +395,9 @@ xfs_dio_write_end_io(
 	 */
 	XFS_STATS_ADD(ip->i_mount, xs_write_bytes, size);
 
+	if (flags & IOMAP_DIO_OVERWRITE)
+		return 0;
+
 	/*
 	 * We can allocate memory here while doing writeback on behalf of
 	 * memory reclaim.  To avoid memory allocation deadlocks set the
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b09463dae0d..009c5969a2ef 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -249,6 +249,14 @@ int iomap_writepages(struct address_space *mapping,
 #define IOMAP_DIO_UNWRITTEN	(1 << 0)	/* covers unwritten extent(s) */
 #define IOMAP_DIO_COW		(1 << 1)	/* covers COW extent(s) */
 
+/*
+ * IOMAP_DIO_OVERWRITE indicates a pure overwrite that requires no metadata
+ * updates on completion. It also indicates that the completion is running in
+ * the hardware IO completion context (e.g. softirq) rather than on a schedules
+ * workqueue.
+ */
+#define IOMAP_DIO_OVERWRITE	(1 << 2)
+
 struct iomap_dio_ops {
 	int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
 		      unsigned flags);
