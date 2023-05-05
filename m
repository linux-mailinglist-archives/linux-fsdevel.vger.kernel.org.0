Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1776F8A9B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 23:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjEEVTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 17:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjEEVTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 17:19:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE5A59DE;
        Fri,  5 May 2023 14:19:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4CA4640A5;
        Fri,  5 May 2023 21:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36370C433EF;
        Fri,  5 May 2023 21:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683321569;
        bh=ngEtc1i1H7a0tm+Un5FqmjeMh1stzyITNIVhJLyViJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJv/jPu75dACDCDRWfbZ5lcShxOGUhnnlGCMS+ydDiFOFoE6SW6kr4nCe4UNPIEpn
         jekeiibG5vr2knMyrjtIwo5fAF6XL1ogsEd8UUqdyo7YoeRkn6f7kx2fw/klYeer/O
         VYqQTEhWE26aBW/eztKIAB8j2VQMtfZY98VCtz3uyDH94a6fzq8hW5cRtCrdydH5gq
         w2c/GgXRG9EtOANMlyU+42KKuLrsVlpdV5T2dFT/kWiDIxZHF0ePlqPSdn5oYkulZL
         lkWFxNaXJcxDRgZcRbX6vYbVwWYJDTRDoK9vMyIY2v/nj1z1KDv+9LBFTU66iu2Uef
         iEV404M+X8sKA==
Date:   Fri, 5 May 2023 14:19:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Subject: Re: [PATCH RFC 11/16] fs: iomap: Atomic write support
Message-ID: <20230505211928.GB15376@frogsfrogsfrogs>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-12-john.g.garry@oracle.com>
 <20230504050006.GH3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504050006.GH3223426@dread.disaster.area>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 04, 2023 at 03:00:06PM +1000, Dave Chinner wrote:
> On Wed, May 03, 2023 at 06:38:16PM +0000, John Garry wrote:
> > Add support to create bio's whose bi_sector and bi_size are aligned to and
> > multiple of atomic_write_unit, respectively.
> > 
> > When we call iomap_dio_bio_iter() -> bio_iov_iter_get_pages() ->
> > __bio_iov_iter_get_pages(), we trim the bio to a multiple of
> > atomic_write_unit.
> > 
> > As such, we expect the iomi start and length to have same size and
> > alignment requirements per iomap_dio_bio_iter() call.
> > 
> > In iomap_dio_bio_iter(), ensure that for a non-dsync iocb that the mapping
> > is not dirty nor unmapped.
> > 
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > ---
> >  fs/iomap/direct-io.c | 72 ++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 70 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index f771001574d0..37c3c926dfd8 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -36,6 +36,8 @@ struct iomap_dio {
> >  	size_t			done_before;
> >  	bool			wait_for_completion;
> >  
> > +	unsigned int atomic_write_unit;
> > +
> >  	union {
> >  		/* used during submission and for synchronous completion: */
> >  		struct {
> > @@ -229,9 +231,21 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> >  	return opflags;
> >  }
> >  
> > +
> > +/*
> > + * Note: For atomic writes, each bio which we create when we iter should have
> > + *	 bi_sector aligned to atomic_write_unit and also its bi_size should be
> > + *	 a multiple of atomic_write_unit.
> > + *	 The call to bio_iov_iter_get_pages() -> __bio_iov_iter_get_pages()
> > + *	 should trim the length to a multiple of atomic_write_unit for us.
> > + *	 This allows us to split each bio later in the block layer to fit
> > + *	 request_queue limit.
> > + */
> >  static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> >  		struct iomap_dio *dio)
> >  {
> > +	bool atomic_write = (dio->iocb->ki_flags & IOCB_ATOMIC) &&
> > +			    (dio->flags & IOMAP_DIO_WRITE);
> >  	const struct iomap *iomap = &iter->iomap;
> >  	struct inode *inode = iter->inode;
> >  	unsigned int fs_block_size = i_blocksize(inode), pad;
> > @@ -249,6 +263,14 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> >  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> >  		return -EINVAL;
> >  
> > +
> > +	if (atomic_write && !iocb_is_dsync(dio->iocb)) {
> > +		if (iomap->flags & IOMAP_F_DIRTY)
> > +			return -EIO;
> > +		if (iomap->type != IOMAP_MAPPED)
> > +			return -EIO;
> > +	}
> 
> IDGI. If the iomap had space allocated for this dio iteration,
> then IOMAP_F_DIRTY will be set and it is likely (guaranteed for XFS)
> that the iomap type will be IOMAP_UNWRITTEN. Indeed, if we are doing
> a write into preallocated space (i.e. from fallocate()) then this
> will cause -EIO on all RWF_ATOMIC IO to that file unless RWF_DSYNC
> is also used.
> 
> "For a power fail, for each individual application block, all or
> none of the data to be written."
> 
> Ok, does this means RWF_ATOMIC still needs fdatasync() to guarantee
> that the data makes it to stable storage? And the result is
> undefined until fdatasync() is run, but the device will guarantee
> that either all or none of the data will be on stable storage
> prior to the next device cache flush completing?
> 
> i.e. does REQ_ATOMIC imply REQ_FUA, or does it require a separate
> device cache flush to commit the atomic IO to stable storage?

From the SCSI and NVME device information that I've been presented, it
sounds like an explicit cache flush or FUA is required to persist the
data.

> What about ordering - do the devices guarantee strict ordering of
> REQ_ATOMIC writes? i.e. if atomic write N is seen on disk, then all
> the previous atomic writes up to N will also be seen on disk? If
> not, how does the application and filesystem guarantee persistence
> of completed atomic writes?

I /think/ the applications have to ensure ordering themselves.  If Y
cannot appear before X is persisted, then the application must wait for
the ack for X, flush the cache, and only then send Y.

> i.e. If we still need a post-IO device cache flush to guarantee
> persistence and/or ordering of RWF_ATOMIC IOs, then the above code
> makes no sense - we'll still need fdatasync() to provide persistence
> checkpoints and that means we ensure metadata is also up to date
> at those checkpoints.

I'll let the block layer developers weigh in on this, but I /think/ this
means that we require RWF_DSYNC for atomic block writes to written
mappings, and RWF_SYNC if iomap_begin gives us an unwritten/hole/dirty
mapping.

> I need someone to put down in writing exactly what the data
> integrity, ordering and persistence semantics of REQ_ATOMIC are
> before I can really comment any further. From my perspective as a
> filesystem developer, this is the single most important set of
> behaviours that need to be documented, as this determines how
> everything else interacts with atomic writes....
> 
> >  	if (iomap->type == IOMAP_UNWRITTEN) {
> >  		dio->flags |= IOMAP_DIO_UNWRITTEN;
> >  		need_zeroout = true;
> > @@ -318,6 +340,10 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> >  					  GFP_KERNEL);
> >  		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
> >  		bio->bi_ioprio = dio->iocb->ki_ioprio;
> > +		if (atomic_write) {
> > +			bio->bi_opf |= REQ_ATOMIC;
> > +			bio->atomic_write_unit = dio->atomic_write_unit;
> > +		}
> >  		bio->bi_private = dio;
> >  		bio->bi_end_io = iomap_dio_bio_end_io;
> >  
> > @@ -492,6 +518,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  		is_sync_kiocb(iocb) || (dio_flags & IOMAP_DIO_FORCE_WAIT);
> >  	struct blk_plug plug;
> >  	struct iomap_dio *dio;
> > +	bool is_read = iov_iter_rw(iter) == READ;
> > +	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
> >  
> >  	if (!iomi.len)
> >  		return NULL;
> > @@ -500,6 +528,20 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  	if (!dio)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > +	if (atomic_write) {
> > +		/*
> > +		 * Note: This lookup is not proper for a multi-device scenario,
> > +		 *	 however for current iomap users, the bdev per iter
> > +		 *	 will be fixed, so "works" for now.
> > +		 */
> > +		struct super_block *i_sb = inode->i_sb;
> > +		struct block_device *bdev = i_sb->s_bdev;
> > +
> > +		dio->atomic_write_unit =
> > +			bdev_find_max_atomic_write_alignment(bdev,
> > +					iomi.pos, iomi.len);
> > +	}
> 
> This will break atomic IO to XFS realtime devices. The device we are
> doing IO to is iomap->bdev, we should never be using sb->s_bdev in
> the iomap code.  Of course, at this point in __iomap_dio_rw() we
> don't have an iomap so this "alignment constraint" can't be done
> correctly at this point in the IO path.

(Agreed.)

> However, even ignoring the bdev source, I think this is completely
> wrong. Passing a *file* offset to the underlying block device so the
> block device can return a device alignment constraint for IO is not
> valid. We don't know how that file offset/length is going to be
> mapped to the underlying block device until we ask the filesystem
> for an iomap covering the file range, so we can't possibly know what
> the device IO alignment of the user request will be until we have an
> iomap for it.

(Agreed.)

> At which point, the "which block device should we ask for alignment
> constraints" question is moot, because we now have an iomap and can
> use iomap->bdev....
> 
> > @@ -592,6 +634,32 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  
> >  	blk_start_plug(&plug);
> >  	while ((ret = iomap_iter(&iomi, ops)) > 0) {
> > +		if (atomic_write) {
> > +			const struct iomap *_iomap = &iomi.iomap;
> > +			loff_t iomi_length = iomap_length(&iomi);
> > +
> > +			/*
> > +			 * Ensure length and start address is a multiple of
> > +			 * atomic_write_unit - this is critical. If the length
> > +			 * is not a multiple of atomic_write_unit, then we
> > +			 * cannot create a set of bio's in iomap_dio_bio_iter()
> > +			 * who are each a length which is a multiple of
> > +			 * atomic_write_unit.
> > +			 *
> > +			 * Note: It may be more appropiate to have this check
> > +			 *	 in iomap_dio_bio_iter()
> > +			 */
> > +			if ((iomap_sector(_iomap, iomi.pos) << SECTOR_SHIFT) %

The file offset (and by extension the position) are not important for
deciding if we can issue an atomic write.  Only the mapped LBA space on
the underlying device is important.

IOWs, if we have a disk that can write a 64k aligned block atomically,
iomap only has to check that iomap->addr is aligned to a 64k boundary.
If that space happens to be mapped to file offset 57k, then it is indeed
possible to perform a 64k atomic write to the file starting at offset
57k and ending at offset 121k, right?

Now, obviously, nobody will ever do that, but my point is that no
changes to iomap_dio_rw are necessary -- only the alignment of the
mapping returned by ->iomap_begin requires checking.

> > +			    dio->atomic_write_unit) {
> > +				ret = -EIO;
> > +				break;
> > +			}
> > +
> > +			if (iomi_length % dio->atomic_write_unit) {
> > +				ret = -EIO;
> > +				break;
> > +			}
> 
> This looks wrong - the length of the mapped extent could be shorter
> than the max atomic write size returned by
> bdev_find_max_atomic_write_alignment() but the iomap could still be aligned
> to the minimum atomic write unit supported. At this point, we reject
> the IO with -EIO, even though it could have been done as an atomic
> write, just a shorter one than the user requested.
> 
> That said, I don't think we can call a user IO that is being
> sliced and diced into multiple individual IOs "atomic". "Atomic"
> implies all-or-none behaviour - slicing up a large DIO into smaller
> individual bios means the bios can be submitted and completed out of
> order. If we then we get a power failure, the application's "atomic"
> IO can appear on disk as only being partially complete - it violates
> the "all or none" semantics of "atomic IO".

This "you can write multiple atomic units but you can't know which ones
completed" behavior is the part I dislike the most about the entire
feature.

> Hence I think that we should be rejecting RWF_ATOMIC IOs that are
> larger than the maximum atomic write unit or cannot be dispatched in
> a single IO e.g. filesystem has allocated multiple minimum aligned
> extents and so a max len atomic write IO over that range must be
> broken up into multiple smaller IOs.
> 
> We should be doing max atomic write size rejection high up in the IO
> path (e.g. filesystem ->write_iter() method) before we get anywhere
> near the DIO path, and we should be rejecting atomic write IOs in
> the DIO path during the ->iomap_begin() mapping callback if we can't
> map the entire atomic IO to a single aligned filesystem extent.
> 
> i.e. the alignment checks and constraints need to be applied by the
> filesystem mapping code, not the layer that packs the pages into the
> bio as directed by the filesystem mapping....

Hmm.  I think I see what you're saying here -- iomap should communicate
to ->iomap_begin that we want to perform an atomic write, and there had
better be either (a) a properly aligned mapping all ready to go; or (b)
the fs must perform an aligned allocation and map that in, or return no
mapping so the write fails.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
