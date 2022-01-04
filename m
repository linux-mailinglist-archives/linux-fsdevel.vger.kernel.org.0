Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B6E4839BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 02:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiADBWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 20:22:20 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:55191 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230227AbiADBWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 20:22:20 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0574210A806E;
        Tue,  4 Jan 2022 12:22:16 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n4YWl-00B3Rq-Rr; Tue, 04 Jan 2022 12:22:15 +1100
Date:   Tue, 4 Jan 2022 12:22:15 +1100
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
Message-ID: <20220104012215.GH945095@dread.disaster.area>
References: <20211230193522.55520-1-trondmy@kernel.org>
 <Yc5f/C1I+N8MPHcd@casper.infradead.org>
 <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
 <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=61d3a14a
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=7-415B0cAAAA:8 a=20KFwNOVAAAA:8
        a=Pg6NTAlpwK2RErHD_QMA:9 a=CjuIK1q_8ugA:10 a=DiKeHqHhRZ4A:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 12:04:23AM +0000, Trond Myklebust wrote:
> On Tue, 2022-01-04 at 09:03 +1100, Dave Chinner wrote:
> > On Sat, Jan 01, 2022 at 05:39:45PM +0000, Trond Myklebust wrote:
> > > On Sat, 2022-01-01 at 14:55 +1100, Dave Chinner wrote:
> > > > As it is, if you are getting soft lockups in this location,
> > > > that's
> > > > an indication that the ioend chain that is being built by XFS is
> > > > way, way too long. IOWs, the completion latency problem is caused
> > > > by
> > > > a lack of submit side ioend chain length bounding in combination
> > > > with unbound completion side merging in xfs_end_bio - it's not a
> > > > problem with the generic iomap code....
> > > > 
> > > > Let's try to address this in the XFS code, rather than hack
> > > > unnecessary band-aids over the problem in the generic code...
> > > > 
> > > > Cheers,
> > > > 
> > > > Dave.
> > > 
> > > Fair enough. As long as someone is working on a solution, then I'm
> > > happy. Just a couple of things:
> > > 
> > > Firstly, we've verified that the cond_resched() in the bio loop
> > > does
> > > suffice to resolve the issue with XFS, which would tend to confirm
> > > what
> > > you're saying above about the underlying issue being the ioend
> > > chain
> > > length.
> > > 
> > > Secondly, note that we've tested this issue with a variety of older
> > > kernels, including 4.18.x, 5.1.x and 5.15.x, so please bear in mind
> > > that it would be useful for any fix to be backward portable through
> > > the
> > > stable mechanism.
> > 
> > The infrastructure hasn't changed that much, so whatever the result
> > is it should be backportable.
> > 
> > As it is, is there a specific workload that triggers this issue? Or
> > a specific machine config (e.g. large memory, slow storage). Are
> > there large fragmented files in use (e.g. randomly written VM image
> > files)? There are a few factors that can exacerbate the ioend chain
> > lengths, so it would be handy to have some idea of what is actually
> > triggering this behaviour...
> > 
> > Cheers,
> > 
> > Dave.
> 
> We have different reproducers. The common feature appears to be the
> need for a decently fast box with fairly large memory (128GB in one
> case, 400GB in the other). It has been reproduced with HDs, SSDs and
> NVME systems.
> 
> On the 128GB box, we had it set up with 10+ disks in a JBOD
> configuration and were running the AJA system tests.
> 
> On the 400GB box, we were just serially creating large (> 6GB) files
> using fio and that was occasionally triggering the issue. However doing
> an strace of that workload to disk reproduced the problem faster :-).

Ok, that matches up with the "lots of logically sequential dirty
data on a single inode in cache" vector that is required to create
really long bio chains on individual ioends.

Can you try the patch below and see if addresses the issue?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com


xfs: limit individual ioend chain length in writeback

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

Hence we need to have two mechanisms to limit ioend sizes -
one on the submission side to limit bio chain lengths, and one on
the completion side to avoid merging physically discontiguous
ioends. This then allows us to add a cond_resched() between
processing individual ioends to limit the amount of CPU time we
consume without releasing the CPU to the scheduler in IO
completion.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/iomap/buffered-io.c | 16 ++++++++++++++++
 fs/xfs/xfs_aops.c      | 16 +++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 71a36ae120ee..ee681ff20994 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1098,6 +1098,15 @@ iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
 		return false;
 	if (ioend->io_offset + ioend->io_size != next->io_offset)
 		return false;
+	/*
+	 * Do not merge physically discontiguous ioends. The filesystem
+	 * completion functions will have to iterate the physical
+	 * discontiguities even if we merge the ioends at a logical level, so
+	 * we don't gain anything by merging physical discontiguities here.
+	 */
+	if (ioend->io_inline_bio.bi_iter.bi_sector + (ioend->io_size >> 9) !=
+	    next->io_inline_bio.bi_iter.bi_sector)
+		return false;
 	return true;
 }
 
@@ -1241,6 +1250,13 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
 		return false;
 	if (sector != bio_end_sector(wpc->ioend->io_bio))
 		return false;
+	/*
+	 * Limit ioend bio chain lengths to minimise IO completion latency. This
+	 * also prevents long tight loops ending page writeback on all the pages
+	 * in the ioend.
+	 */
+	if (wpc->ioend->io_size >= 4096 * PAGE_SIZE)
+		return false;
 	return true;
 }
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index c8c15c3c3147..148a8fce7029 100644
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
@@ -157,6 +170,7 @@ xfs_end_io(
 		list_del_init(&ioend->io_list);
 		iomap_ioend_try_merge(ioend, &tmp);
 		xfs_end_ioend(ioend);
+		cond_resched();
 	}
 }
 
