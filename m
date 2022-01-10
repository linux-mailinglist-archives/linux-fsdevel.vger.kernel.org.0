Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F97448A3C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 00:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345371AbiAJXhw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 18:37:52 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:38478 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241114AbiAJXhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:37:52 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 3197A10C09D6;
        Tue, 11 Jan 2022 10:37:48 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n74EU-00Dmyb-My; Tue, 11 Jan 2022 10:37:46 +1100
Date:   Tue, 11 Jan 2022 10:37:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <20220110233746.GB945095@dread.disaster.area>
References: <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
 <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <0996c40657b5873dda5119344bf74556491e27b9.camel@hammerspace.com>
 <c9d9b7850c6086b123b4add4de7b1992cb62f6ad.camel@hammerspace.com>
 <20220105224829.GO945095@dread.disaster.area>
 <28e975e8235a41c529bccb2bc0e73b4bb2d1e45e.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28e975e8235a41c529bccb2bc0e73b4bb2d1e45e.camel@hammerspace.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=61dcc34e
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=7-415B0cAAAA:8 a=20KFwNOVAAAA:8
        a=sCBR8LINyD7_5w85xHsA:9 a=CjuIK1q_8ugA:10 a=DiKeHqHhRZ4A:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 06, 2022 at 06:36:52PM +0000, Trond Myklebust wrote:
> On Thu, 2022-01-06 at 09:48 +1100, Dave Chinner wrote:
> > On Wed, Jan 05, 2022 at 08:45:05PM +0000, Trond Myklebust wrote:
> > > On Tue, 2022-01-04 at 21:09 -0500, Trond Myklebust wrote:
> > > > On Tue, 2022-01-04 at 12:22 +1100, Dave Chinner wrote:
> > > > > On Tue, Jan 04, 2022 at 12:04:23AM +0000, Trond Myklebust
> > > > > wrote:
> > > > > > We have different reproducers. The common feature appears to
> > > > > > be
> > > > > > the
> > > > > > need for a decently fast box with fairly large memory (128GB
> > > > > > in
> > > > > > one
> > > > > > case, 400GB in the other). It has been reproduced with HDs,
> > > > > > SSDs
> > > > > > and
> > > > > > NVME systems.
> > > > > > 
> > > > > > On the 128GB box, we had it set up with 10+ disks in a JBOD
> > > > > > configuration and were running the AJA system tests.
> > > > > > 
> > > > > > On the 400GB box, we were just serially creating large (>
> > > > > > 6GB)
> > > > > > files
> > > > > > using fio and that was occasionally triggering the issue.
> > > > > > However
> > > > > > doing
> > > > > > an strace of that workload to disk reproduced the problem
> > > > > > faster
> > > > > > :-
> > > > > > ).
> > > > > 
> > > > > Ok, that matches up with the "lots of logically sequential
> > > > > dirty
> > > > > data on a single inode in cache" vector that is required to
> > > > > create
> > > > > really long bio chains on individual ioends.
> > > > > 
> > > > > Can you try the patch below and see if addresses the issue?
> > > > > 
> > > > 
> > > > That patch does seem to fix the soft lockups.
> > > > 
> > > 
> > > Oops... Strike that, apparently our tests just hit the following
> > > when
> > > running on AWS with that patch.
> > 
> > OK, so there are also large contiguous physical extents being
> > allocated in some cases here.
> > 
> > > So it was harder to hit, but we still did eventually.
> > 
> > Yup, that's what I wanted to know - it indicates that both the
> > filesystem completion processing and the iomap page processing play
> > a role in the CPU usage. More complex patch for you to try below...
> > 
> > Cheers,
> > 
> > Dave.
> 
> Hi Dave,
> 
> This patch got further than the previous one. However it too failed on
> the same AWS setup after we started creating larger (in this case 52GB)
> files. The previous patch failed at 15GB.
> 
> NR_06-18:00:17 pm-46088DSX1 /mnt/data-portal/data $ ls -lh
> total 59G
> -rw-r----- 1 root root  52G Jan  6 18:20 100g
> -rw-r----- 1 root root 9.8G Jan  6 17:38 10g
> -rw-r----- 1 root root   29 Jan  6 17:36 file
> NR_06-18:20:10 pm-46088DSX1 /mnt/data-portal/data $
> Message from syslogd@pm-46088DSX1 at Jan  6 18:22:44 ...
>  kernel:[ 5548.082987] watchdog: BUG: soft lockup - CPU#10 stuck for
> 24s! [kworker/10:0:18995]

Ok, so coming back to this set of failures. Firstly, the patch I
sent you has a bug in it, meaning it did not merge ioends across
independent ->writepages invocations. Essentially it would merge
ioends as long as the chain of ioends are all the same size (e.g.
4096 pages long). The moment an ioend of a different size is added
to the chain (i.e. the runt at the tail of the writepages
invocation) the merging stopped.

That means the merging was limited to what writeback bandwidth
chunking broken the per-file writeback into. I'm generally seeing
that to be 100-200MB chunks per background writeback invocation,
and so nothing is merging beyond that size.

Once I fixed that bug (caused by bio->bi_iter.bi_sector being
modified by the block layer stack during submission when bios are
split so it doesn't point at the start sector at IO completion),
the only way I could get merging beyond submission chunking was
to induce a long scheduling delay in the XFS completion processing.
e.g. by adding msleep(1000) to xfs_end_io() before any of the
merging occurred.

In this case, I can't get any extra merging to occur - the
scheduling latency on IO completion is just so low and the
completion processing so fast that little to no merging occurs
at all with ioends split into 4096 page chunks.

So, let's introduce scheduling delays. The only one that matters
here is a delay running the XFS end IO work task - it will pull all
the pending ioends and process them as one loop. Hence the only way
we can get large merged ioends is to delay the processing before we
pull the completed ioends off the inode.

Worst case is that a scheduling delay will allow a single file to
dirty enough pages to hit the throttling limits in
balance_dirty_pages() while it waits for dirty pages to be cleaned.
I see this in completion:

kworker/9:1-769   [009]    35.267031: bprint: iomap_finish_ioends: pages 4096, start sector 0x400 size 10123546624 pcnt 4096
....
kworker/9:1-769   [009]    35.982461: bprint: iomap_finish_ioends: pages 164, start sector 0x12db368 size 671744 pcnt 31324

Yup, that merged into a 10GB ioend that is passed to
iomap_finish_ioends(), and it took just over 700ms to process the
entire 10GB ioend.

If writeback is running at the same time as completion, things are
a little slower:

kworker/31:2-793   [031]    51.147943: bprint: iomap_finish_ioends: pages 4096, start sector 0x132ac488 size 8019509248 pcnt 4096
kworker/u68:13-637 [025]    51.150218: bprint: iomap_do_writepage: 2. bios 4096, pages 4096, start sector 0x141a4488 bi_vcnt 5, bi_size 16777216
kworker/31:2-793   [031]    51.152237: bprint: iomap_finish_ioends: pages 4096, start sector 0x132b4488 size 16777216 pcnt 8192
kworker/u68:13-637 [025]    51.155773: bprint: iomap_do_writepage: 2. bios 4096, pages 4096, start sector 0x141ac488 bi_vcnt 5, bi_size 16777216
....
kworker/31:2-793   [031]    52.528398: bprint: iomap_finish_ioends: pages 4096, start sector 0x14194488 size 16777216 pcnt 21504

That's 8GB in 1.4s, but it's still processing over 5GB/s of
completions.

This is running with 64GB RAM and:

$ grep . /proc/sys/vm/dirty*
/proc/sys/vm/dirty_background_bytes:0
/proc/sys/vm/dirty_background_ratio:10
/proc/sys/vm/dirty_bytes:0
/proc/sys/vm/dirty_expire_centisecs:3000
/proc/sys/vm/dirty_ratio:20
/proc/sys/vm/dirtytime_expire_seconds:43200
/proc/sys/vm/dirty_writeback_centisecs:500
$

If I change the dirty ratios to 60/80:

$ grep . /proc/sys/vm/dirty*ratio
/proc/sys/vm/dirty_background_ratio:60
/proc/sys/vm/dirty_ratio:80
$

I can get up to 15GB merged ioends with a 5 second scheduling delay
for the xfs_end_io workqueue, but that still only takes about 2s
of CPU time to process the entire completion:

kworker/4:2-214   [004]   788.133242: bprint: xfs_end_io: off 0x6f85fe000, sect 0x14daf0c0 size 16777216/0x8000 end 0x14db70c0
<merges>
kworker/4:2-214   [004]   788.135393: bprint: iomap_finish_ioends: pages 4096, start sector 0x14daf0c0 size 15837691904 pcnt 4096
.....
kworker/4:2-214   [004]   790.083058: bprint: iomap_finish_ioends: pages 4096, start sector 0x16b270c0 size 16777216 pcnt 32768

Given that I broke physical extent merging completely in the patch
you were testing, there's no way you would even be getting GB sized
completions being run, even with large scheduling delays. There is
just no way completion is spending that amount of CPU time in a loop
processing page based writeback completion without triggering some
case of cond_resched() in the patch I gave you to test unless there
is something else happening on those systems.

So at this point I'm kinda at a loss to understand where the 20+
second CPU times for completion processing are coming from, even if
we're trying to process the entire 52GB of dirty pages in a single
completion.

Trond, what is the IO completion task actually spending it's CPU
time doing on your machines? Can you trace out what the conditions
are (ioend lengths, processing time, etc) when the softlockups
occur? Are there so many pending IO completions iacross different
files that the completion CPU (CPU #10) is running out of worker
threads and/or the CPU bound completion worker threads are seeing
tens of seconds of scheduling delay?  Is it something completely
external like AWS preempting the vCPU that happens to be running IO
completion for 20+ seconds at a time? Or something else entirely?

I really need to know what I'm missing here, because it isn't
obvious from my local systems and it's not obvious just from
soft-lockup stack traces....

The latest patch with page based accounting and fixed ioend merging
I'm running here, including the tracepoints I've been using
('trace-cmd record -e printk' is your friend), is below.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

[V4] xfs: limit individual ioend chain length in writeback

From: Dave Chinner <dchinner@redhat.com>

Trond Myklebust reported soft lockups in XFS IO completion such as
this:

 watchdog: BUG: soft lockup - CPU#12 stuck for 23s! [kworker/12:1:3106]
 CPU: 12 PID: 3106 Comm: kworker/12:1 Not tainted 4.18.0-305.10.2.el8_4.x86_64 #1
 Workqueue: xfs-conv/md127 xfs_end_io [xfs]
 RIP: 0010:_raw_spin_unlock_irqrestore+0x11/0x20
 Call Trace:
  wake_up_page_bit+0x8a/0x110
  iomap_finish_ioend+0xd7/0x1c0
  iomap_finish_ioends+0x7f/0xb0
  xfs_end_ioend+0x6b/0x100 [xfs]
  xfs_end_io+0xb9/0xe0 [xfs]
  process_one_work+0x1a7/0x360
  worker_thread+0x1fa/0x390
  kthread+0x116/0x130
  ret_from_fork+0x35/0x40

Ioends are processed as an atomic completion unit when all the
chained bios in the ioend have completed their IO. Logically
contiguous ioends can also be merged and completed as a single,
larger unit.  Both of these things can be problematic as both the
bio chains per ioend and the size of the merged ioends processed as
a single completion are both unbound.

If we have a large sequential dirty region in the page cache,
write_cache_pages() will keep feeding us sequential pages and we
will keep mapping them into ioends and bios until we get a dirty
page at a non-sequential file offset. These large sequential runs
can will result in bio and ioend chaining to optimise the io
patterns. The pages iunder writeback are pinned within these chains
until the submission chaining is broken, allowing the entire chain
to be completed. This can result in huge chains being processed
in IO completion context.

We get deep bio chaining if we have large contiguous physical
extents. We will keep adding pages to the current bio until it is
full, then we'll chain a new bio to keep adding pages for writeback.
Hence we can build bio chains that map millions of pages and tens of
gigabytes of RAM if the page cache contains big enough contiguous
dirty file regions. This long bio chain pins those pages until the
final bio in the chain completes and the ioend can iterate all the
chained bios and complete them.

OTOH, if we have a physically fragmented file, we end up submitting
one ioend per physical fragment that each have a small bio or bio
chain attached to them. We do not chain these at IO submission time,
but instead we chain them at completion time based on file
offset via iomap_ioend_try_merge(). Hence we can end up with unbound
ioend chains being built via completion merging.

XFS can then do COW remapping or unwritten extent conversion on that
merged chain, which involves walking an extent fragment at a time
and running a transaction to modify the physical extent information.
IOWs, we merge all the discontiguous ioends together into a
contiguous file range, only to then process them individually as
discontiguous extents.

This extent manipulation is computationally expensive and can run in
a tight loop, so merging logically contiguous but physically
discontigous ioends gains us nothing except for hiding the fact the
fact we broke the ioends up into individual physical extents at
submission and then need to loop over those individual physical
extents at completion.

Hence we need to have mechanisms to limit ioend sizes and
to break up completion processing of large merged ioend chains:

1. bio chains per ioend need to be bound in length. Pure overwrites
go straight to iomap_finish_ioend() in softirq context with the
exact bio chain attached to the ioend by submission. Hence the only
way to prevent long holdoffs here is to bound ioend submission
sizes because we can't reschedule in softirq context.

2. iomap_finish_ioends() has to handle unbound merged ioend chains
correctly. This relies on any one call to iomap_finish_ioend() being
bound in runtime so that cond_resched() can be issued regularly as
the long ioend chain is processed. i.e. this relies on mechanism #1
to limit individual ioend sizes to work correctly.

3. filesystems have to loop over the merged ioends to process
physical extent manipulations. This means they can loop internally,
and so we break merging at physical extent boundaries so the
filesystem can easily insert reschedule points between individual
extent manipulations.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
V4:
- page based accounting
- fixed merging
- tracepoints

 fs/iomap/buffered-io.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++---
 fs/xfs/xfs_aops.c      | 24 +++++++++++++-
 include/linux/iomap.h  |  2 ++
 3 files changed, 111 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 71a36ae120ee..83cde206b3c9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1028,7 +1028,7 @@ iomap_finish_page_writeback(struct inode *inode, struct page *page,
  * state, release holds on bios, and finally free up memory.  Do not use the
  * ioend after this.
  */
-static void
+static u32
 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 {
 	struct inode *inode = ioend->io_inode;
@@ -1037,6 +1037,7 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 	u64 start = bio->bi_iter.bi_sector;
 	loff_t offset = ioend->io_offset;
 	bool quiet = bio_flagged(bio, BIO_QUIET);
+	u32 page_count = 0;
 
 	for (bio = &ioend->io_inline_bio; bio; bio = next) {
 		struct bio_vec *bv;
@@ -1052,9 +1053,11 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 			next = bio->bi_private;
 
 		/* walk each page on bio, ending page IO on them */
-		bio_for_each_segment_all(bv, bio, iter_all)
+		bio_for_each_segment_all(bv, bio, iter_all) {
 			iomap_finish_page_writeback(inode, bv->bv_page, error,
 					bv->bv_len);
+			page_count++;
+		}
 		bio_put(bio);
 	}
 	/* The ioend has been freed by bio_put() */
@@ -1064,21 +1067,47 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 "%s: writeback error on inode %lu, offset %lld, sector %llu",
 			inode->i_sb->s_id, inode->i_ino, offset, start);
 	}
+	return page_count;
 }
 
+/*
+ * Ioend completion routine for merged bios. This can only be called from task
+ * contexts as merged ioends can be of unbound length. Hence we have to break up
+ * the page writeback completion into manageable chunks to avoid long scheduler
+ * holdoffs. We aim to keep scheduler holdoffs down below 10ms so that we get
+ * good batch processing throughput without creating adverse scheduler latency
+ * conditions.
+ */
 void
 iomap_finish_ioends(struct iomap_ioend *ioend, int error)
 {
 	struct list_head tmp;
+	u32 pages;
+
+	might_sleep();
 
 	list_replace_init(&ioend->io_list, &tmp);
-	iomap_finish_ioend(ioend, error);
+	pages = iomap_finish_ioend(ioend, error);
 
 	while (!list_empty(&tmp)) {
+	trace_printk("pages %u, start sector 0x%llx size %lu pcnt %u",
+		ioend->io_pages,
+		ioend->io_sector,
+		ioend->io_size,
+		pages);
+		if (pages > 32768) {
+			cond_resched();
+			pages = 0;
+		}
 		ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
 		list_del_init(&ioend->io_list);
-		iomap_finish_ioend(ioend, error);
+		pages += iomap_finish_ioend(ioend, error);
 	}
+	trace_printk("pages %u, start sector 0x%llx size %lu pcnt %u",
+		ioend->io_pages,
+		ioend->io_sector,
+		ioend->io_size,
+		pages);
 }
 EXPORT_SYMBOL_GPL(iomap_finish_ioends);
 
@@ -1088,6 +1117,15 @@ EXPORT_SYMBOL_GPL(iomap_finish_ioends);
 static bool
 iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
 {
+	trace_printk(
+"off 0x%llx, sect 0x%llx size %lu/0x%lx end 0x%llx, next off 0x%llx sect 0x%llx",
+		ioend->io_offset,
+		ioend->io_sector,
+		ioend->io_size, (ioend->io_size >> 9),
+		ioend->io_sector + (ioend->io_size >> 9),
+		next->io_offset,
+		next->io_sector);
+
 	if (ioend->io_bio->bi_status != next->io_bio->bi_status)
 		return false;
 	if ((ioend->io_flags & IOMAP_F_SHARED) ^
@@ -1098,6 +1136,15 @@ iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
 		return false;
 	if (ioend->io_offset + ioend->io_size != next->io_offset)
 		return false;
+	/*
+	 * Do not merge physically discontiguous ioends. The filesystem
+	 * completion functions will have to iterate the physical
+	 * discontiguities even if we merge the ioends at a logical level, so
+	 * we don't gain anything by merging physical discontiguities here.
+	 */
+
+	if (ioend->io_sector + (ioend->io_size >> 9) != next->io_sector)
+		return false;
 	return true;
 }
 
@@ -1199,8 +1246,10 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 	ioend->io_flags = wpc->iomap.flags;
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
+	ioend->io_pages = 0;
 	ioend->io_offset = offset;
 	ioend->io_bio = bio;
+	ioend->io_sector = sector;
 	return ioend;
 }
 
@@ -1241,6 +1290,13 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
 		return false;
 	if (sector != bio_end_sector(wpc->ioend->io_bio))
 		return false;
+	/*
+	 * Limit ioend bio chain lengths to minimise IO completion latency. This
+	 * also prevents long tight loops ending page writeback on all the pages
+	 * in the ioend.
+	 */
+	if (wpc->ioend->io_pages >= 4096)
+		return false;
 	return true;
 }
 
@@ -1264,6 +1320,13 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 	}
 
 	if (bio_add_page(wpc->ioend->io_bio, page, len, poff) != len) {
+	trace_printk("bios %u, pages %u, start sector 0x%llx bi_vcnt %u, bi_size %u",
+		bio_segments(wpc->ioend->io_bio),
+		wpc->ioend->io_pages,
+		wpc->ioend->io_inline_bio.bi_iter.bi_sector,
+		wpc->ioend->io_bio->bi_vcnt,
+		wpc->ioend->io_bio->bi_iter.bi_size);
+
 		wpc->ioend->io_bio = iomap_chain_bio(wpc->ioend->io_bio);
 		__bio_add_page(wpc->ioend->io_bio, page, len, poff);
 	}
@@ -1326,6 +1389,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 				 &submit_list);
 		count++;
 	}
+	if (count)
+		wpc->ioend->io_pages++;
 
 	WARN_ON_ONCE(!wpc->ioend && !list_empty(&submit_list));
 	WARN_ON_ONCE(!PageLocked(page));
@@ -1366,6 +1431,12 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		int error2;
 
 		list_del_init(&ioend->io_list);
+	trace_printk("2. bios %u, pages %u, start sector 0x%llx bi_vcnt %u, bi_size %u",
+		bio_segments(ioend->io_bio),
+		ioend->io_pages,
+		ioend->io_inline_bio.bi_iter.bi_sector,
+		ioend->io_bio->bi_vcnt,
+		ioend->io_bio->bi_iter.bi_size);
 		error2 = iomap_submit_ioend(wpc, ioend, error);
 		if (error2 && !error)
 			error = error2;
@@ -1499,6 +1570,11 @@ iomap_writepage(struct page *page, struct writeback_control *wbc,
 	ret = iomap_do_writepage(page, wbc, wpc);
 	if (!wpc->ioend)
 		return ret;
+	trace_printk("bios %u, pages %u, bi_vcnt %u, bi_size %u",
+		bio_segments(wpc->ioend->io_bio),
+		wpc->ioend->io_pages,
+		wpc->ioend->io_bio->bi_vcnt,
+		wpc->ioend->io_bio->bi_iter.bi_size);
 	return iomap_submit_ioend(wpc, wpc->ioend, ret);
 }
 EXPORT_SYMBOL_GPL(iomap_writepage);
@@ -1514,6 +1590,12 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 	ret = write_cache_pages(mapping, wbc, iomap_do_writepage, wpc);
 	if (!wpc->ioend)
 		return ret;
+	trace_printk("3. bios %u, pages %u, start sector 0x%llx bi_vcnt %u, bi_size %u",
+		bio_segments(wpc->ioend->io_bio),
+		wpc->ioend->io_pages,
+		wpc->ioend->io_inline_bio.bi_iter.bi_sector,
+		wpc->ioend->io_bio->bi_vcnt,
+		wpc->ioend->io_bio->bi_iter.bi_size);
 	return iomap_submit_ioend(wpc, wpc->ioend, ret);
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index c8c15c3c3147..82515d1ad4e0 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -136,7 +136,20 @@ xfs_end_ioend(
 	memalloc_nofs_restore(nofs_flag);
 }
 
-/* Finish all pending io completions. */
+/*
+ * Finish all pending IO completions that require transactional modifications.
+ *
+ * We try to merge physical and logically contiguous ioends before completion to
+ * minimise the number of transactions we need to perform during IO completion.
+ * Both unwritten extent conversion and COW remapping need to iterate and modify
+ * one physical extent at a time, so we gain nothing by merging physically
+ * discontiguous extents here.
+ *
+ * The ioend chain length that we can be processing here is largely unbound in
+ * length and we may have to perform significant amounts of work on each ioend
+ * to complete it. Hence we have to be careful about holding the CPU for too
+ * long in this loop.
+ */
 void
 xfs_end_io(
 	struct work_struct	*work)
@@ -147,6 +160,7 @@ xfs_end_io(
 	struct list_head	tmp;
 	unsigned long		flags;
 
+	msleep(5000);
 	spin_lock_irqsave(&ip->i_ioend_lock, flags);
 	list_replace_init(&ip->i_ioend_list, &tmp);
 	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
@@ -155,8 +169,16 @@ xfs_end_io(
 	while ((ioend = list_first_entry_or_null(&tmp, struct iomap_ioend,
 			io_list))) {
 		list_del_init(&ioend->io_list);
+	trace_printk(
+"off 0x%llx, sect 0x%llx size %lu/0x%lx end 0x%llx",
+		ioend->io_offset,
+		ioend->io_sector,
+		ioend->io_size, (ioend->io_size >> 9),
+		ioend->io_sector + (ioend->io_size >> 9));
+
 		iomap_ioend_try_merge(ioend, &tmp);
 		xfs_end_ioend(ioend);
+		cond_resched();
 	}
 }
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6d1b08d0ae93..378bfc4010c2 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -257,9 +257,11 @@ struct iomap_ioend {
 	struct list_head	io_list;	/* next ioend in chain */
 	u16			io_type;
 	u16			io_flags;	/* IOMAP_F_* */
+	u32			io_pages;
 	struct inode		*io_inode;	/* file being written to */
 	size_t			io_size;	/* size of the extent */
 	loff_t			io_offset;	/* offset in the file */
+	sector_t		io_sector;	/* start sector of ioend */
 	struct bio		*io_bio;	/* bio being built */
 	struct bio		io_inline_bio;	/* MUST BE LAST! */
 };
