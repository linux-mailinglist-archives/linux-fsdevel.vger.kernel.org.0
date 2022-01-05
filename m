Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A380485B41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 23:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbiAEWE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 17:04:28 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:33967 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244705AbiAEWE1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:04:27 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 7436B10C004C;
        Thu,  6 Jan 2022 09:04:22 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n5EOL-00BnGg-MX; Thu, 06 Jan 2022 09:04:21 +1100
Date:   Thu, 6 Jan 2022 09:04:21 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <20220105220421.GM945095@dread.disaster.area>
References: <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <YdPyhpdxykDscMtJ@infradead.org>
 <YdSNGAupnxF/ouis@casper.infradead.org>
 <YdSOgyvDnZadYpUP@infradead.org>
 <20220104192227.GA398655@magnolia>
 <20220104215227.GJ945095@dread.disaster.area>
 <20220104231230.GG31606@magnolia>
 <20220105021022.GL945095@dread.disaster.area>
 <YdWjkW7hhbTl4TQa@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdWjkW7hhbTl4TQa@bfoster>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=61d615e9
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=7-415B0cAAAA:8 a=20KFwNOVAAAA:8
        a=0Z3UcInKYyOX7bYbSYwA:9 a=CjuIK1q_8ugA:10 a=DiKeHqHhRZ4A:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 05, 2022 at 08:56:33AM -0500, Brian Foster wrote:
> On Wed, Jan 05, 2022 at 01:10:22PM +1100, Dave Chinner wrote:
> > On Tue, Jan 04, 2022 at 03:12:30PM -0800, Darrick J. Wong wrote:
> > > So looking at xfs_end_io:
> > > 
> > > /* Finish all pending io completions. */
> > > void
> > > xfs_end_io(
> > > 	struct work_struct	*work)
> > > {
> > > 	struct xfs_inode	*ip =
> > > 		container_of(work, struct xfs_inode, i_ioend_work);
> > > 	struct iomap_ioend	*ioend;
> > > 	struct list_head	tmp;
> > > 	unsigned long		flags;
> > > 
> > > 	spin_lock_irqsave(&ip->i_ioend_lock, flags);
> > > 	list_replace_init(&ip->i_ioend_list, &tmp);
> > > 	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
> > > 
> > > 	iomap_sort_ioends(&tmp);
> > > 	while ((ioend = list_first_entry_or_null(&tmp, struct iomap_ioend,
> > > 			io_list))) {
> > > 		list_del_init(&ioend->io_list);
> > > 
> > > Here we pull the first ioend off the sorted list of ioends.
> > > 
> > > 		iomap_ioend_try_merge(ioend, &tmp);
> > > 
> > > Now we've merged that first ioend with as many subsequent ioends as we
> > > could merge.  Let's say there were 200 ioends, each 100MB.  Now ioend
> > 
> > Ok, so how do we get to this completion state right now?
> > 
> > 1. an ioend is a physically contiguous extent so submission is
> >    broken down into an ioend per physical extent.
> > 2. we merge logically contiguous ioends at completion.
> > 
> > So, if we have 200 ioends of 100MB each that are logically
> > contiguous we'll currently always merge them into a single 20GB
> > ioend that gets processed as a single entity even if submission
> > broke them up because they were physically discontiguous.
> > 
> > Now, with this patch we add:
> > 
> > 3. Individual ioends are limited to 16MB.
> > 4. completion can only merge physically contiguous ioends.
> > 5. we cond_resched() between physically contiguous ioend completion.
> > 
> > Submission will break that logically contiguous 20GB dirty range
> > down into 200x6x16MB ioends.
> > 
> > Now completion will only merge ioends that are both physically and
> > logically contiguous. That results in a maximum merged ioend chain
> > size of 100MB at completion. They'll get merged one 100MB chunk at a
> > time.
> > 
> 
> I'm missing something with the reasoning here.. how does a contiguity
> check in the ioend merge code guarantee we don't construct an
> excessively large list of pages via a chain of merged ioends? Obviously
> it filters out the discontig case, but what if the extents are
> physically contiguous?

It doesn't. I keep saying there are two aspects of this problem -
one is the filesystem looping doing considerable work over multiple
physical extents (would be 200 extent conversions in a tight loop
via xfs_iomap_write_unwritten()) before we even call into
iomap_finish_ioends() to process the pages in the merged ioend
chain.

Darrick is trying to address with the cond_resched() calls in
iomap_finish_ioends(), but is missing the looping being done in
xfs_end_ioend() prior to calling iomap_finish_ioends().  Badly
fragmented merged ioend completion will loop for much longer in
xfs_iomap_write_unwritten() than they will in
iomap_finish_ioends()....

> > >  * Mark writeback finished on a chain of ioends.  Caller must not call
> > >  * this function from atomic/softirq context.
> > >  */
> > > void
> > > iomap_finish_ioends(struct iomap_ioend *ioend, int error)
> > > {
> > > 	struct list_head tmp;
> > > 
> > > 	list_replace_init(&ioend->io_list, &tmp);
> > > 	iomap_finish_ioend(ioend, error);
> > > 
> > > 	while (!list_empty(&tmp)) {
> > > 		cond_resched();
> > > 
> > > So I propose doing it ^^^ here instead.
> > > 
> > > 		ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
> > > 		list_del_init(&ioend->io_list);
> > > 		iomap_finish_ioend(ioend, error);
> > > 	}
> > > }
> 
> Hmm.. I'm not seeing how this is much different from Dave's patch, and
> I'm not totally convinced the cond_resched() in Dave's patch is
> effective without something like Darrick's earlier suggestion to limit
> the $object (page/folio/whatever) count of the entire merged mapping (to
> ensure that iomap_finish_ioend() is no longer a soft lockup vector by
> itself).

Yes, that's what I did immediately after posting the first patch for
Trond to test a couple of days ago.  The original patch was an
attempt to make a simple, easily backportable fix to mitigate the
issue without excessive cond_resched() overhead, not a "perfect
solution".

> Trond reports that the test patch mitigates his reproducer, but that
> patch also includes the ioend size cap and so the test doesn't
> necessarily isolate whether the cond_resched() is effective or whether
> the additional submission/completion overhead is enough to avoid the
> pathological conditions that enable it via the XFS merging code. I'd be
> curious to have a more tangible datapoint on that. The easiest way to
> test without getting into the weeds of looking at merging behavior is
> probably just see whether the problem returns with the cond_resched()
> removed and all of the other changes in place. Trond, is that something
> you can test?

Trond has already reported a new softlockup that indicates we still
need a cond_resched() in iomap_finish_ioends() even with the patch I
posted. So we've got the feedback we needed from Trond already, from
both the original patch (fine grained cond_resched()) and from the
patch I sent for him to test.

What this tells us is we actually need *3* layers of co-ordination
here:

1. bio chains per ioend need to be bound in length. Pure overwrites
go straight to iomap_finish_ioend() in softirq context with the
exact bio chain attached to the ioend by submission. Hence the only
way to prevent long holdoffs here is to bound ioend submission
sizes.

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

See the patch below.

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
 fs/iomap/buffered-io.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
 fs/xfs/xfs_aops.c      | 16 +++++++++++++++-
 include/linux/iomap.h  |  1 +
 3 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 71a36ae120ee..39214577bc46 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1066,17 +1066,34 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 	}
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
+	int segments;
+
+	might_sleep();
 
 	list_replace_init(&ioend->io_list, &tmp);
+	segments = ioend->io_segments;
 	iomap_finish_ioend(ioend, error);
 
 	while (!list_empty(&tmp)) {
+		if (segments > 32768) {
+			cond_resched();
+			segments = 0;
+		}
 		ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
 		list_del_init(&ioend->io_list);
+		segments += ioend->io_segments;
 		iomap_finish_ioend(ioend, error);
 	}
 }
@@ -1098,6 +1115,15 @@ iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
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
 
@@ -1175,6 +1201,7 @@ iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
 		return error;
 	}
 
+	ioend->io_segments += bio_segments(ioend->io_bio);
 	submit_bio(ioend->io_bio);
 	return 0;
 }
@@ -1199,6 +1226,7 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 	ioend->io_flags = wpc->iomap.flags;
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
+	ioend->io_segments = 0;
 	ioend->io_offset = offset;
 	ioend->io_bio = bio;
 	return ioend;
@@ -1211,11 +1239,14 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
  * so that the bi_private linkage is set up in the right direction for the
  * traversal in iomap_finish_ioend().
  */
-static struct bio *
-iomap_chain_bio(struct bio *prev)
+static void
+iomap_chain_bio(struct iomap_ioend *ioend)
 {
+	struct bio *prev = ioend->io_bio;
 	struct bio *new;
 
+	ioend->io_segments += bio_segments(prev);
+
 	new = bio_alloc(GFP_NOFS, BIO_MAX_VECS);
 	bio_copy_dev(new, prev);/* also copies over blkcg information */
 	new->bi_iter.bi_sector = bio_end_sector(prev);
@@ -1225,7 +1256,8 @@ iomap_chain_bio(struct bio *prev)
 	bio_chain(prev, new);
 	bio_get(prev);		/* for iomap_finish_ioend */
 	submit_bio(prev);
-	return new;
+
+	ioend->io_bio = new;
 }
 
 static bool
@@ -1241,6 +1273,13 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
 		return false;
 	if (sector != bio_end_sector(wpc->ioend->io_bio))
 		return false;
+	/*
+	 * Limit ioend bio chain lengths to minimise IO completion latency. This
+	 * also prevents long tight loops ending page writeback on all the pages
+	 * in the ioend.
+	 */
+	if (wpc->ioend->io_segments >= 4096)
+		return false;
 	return true;
 }
 
@@ -1264,7 +1303,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 	}
 
 	if (bio_add_page(wpc->ioend->io_bio, page, len, poff) != len) {
-		wpc->ioend->io_bio = iomap_chain_bio(wpc->ioend->io_bio);
+		iomap_chain_bio(wpc->ioend);
 		__bio_add_page(wpc->ioend->io_bio, page, len, poff);
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
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6d1b08d0ae93..bfdba72f4e30 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -257,6 +257,7 @@ struct iomap_ioend {
 	struct list_head	io_list;	/* next ioend in chain */
 	u16			io_type;
 	u16			io_flags;	/* IOMAP_F_* */
+	u32			io_segments;
 	struct inode		*io_inode;	/* file being written to */
 	size_t			io_size;	/* size of the extent */
 	loff_t			io_offset;	/* offset in the file */
