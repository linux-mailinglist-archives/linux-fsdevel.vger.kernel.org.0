Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4546F8CEA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 01:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjEEX4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 19:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjEEX4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 19:56:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7855FE0
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 16:56:18 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-51452556acdso1545250a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 May 2023 16:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683330977; x=1685922977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CemAWNMR8bXthiAKC/+una4gxSePkb3IueLhq9mQmls=;
        b=gHPP7rPplI3y0mo0qtJ/LN1w+3i8RZceqZ1LO1ZCKhhMbabBzl7A4lQdBO+JX2jkDm
         TRPNESDK35rRqscidy9M21sxamJxHrnWASy6zhdPPypqGaBgXaGs59kSsQiHZQA0bbWG
         8pFp/BgjxSrqt2N/vh9qN4vWLK6GzPe5hr6S/g7TL2BI/WRp8aeNJJt9x4pIk133u0FV
         NCec18QyfgEGSNrDfb+eJdiTGkv/8LXfoY4UhwIWHYu+I/anHCJijdw0ujXic2KAzVCv
         DEzxnaLvVhERRUy/ePoGYhd+g/lH45JwcP6N4BypaG2U75P5I+5R1+tYNUfTxcgeXZ4D
         G7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683330977; x=1685922977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CemAWNMR8bXthiAKC/+una4gxSePkb3IueLhq9mQmls=;
        b=a+1FXcMr+d4VNG21ZY/XYiB8aAMf5kc8OvAeYpLSFX09rXHHBvJ3hev6dBPrrZ3NNK
         3a813GydJrEe5llGJNVNkMD+AWqihDPqENpQH73kQmyHo54lipT5nSZ1CGau81sYXgED
         kqj3NzBT5YnQzIYZNLHaYaORxAlvPjvdF0C/Q+WXNeOqC7zsYVL1ZuBtKFeHhUjZNQ4L
         3GobOsDLmlIpsDxbVKgi6SniXJTKWTnC0gTIqOnxGJZdMZAWTuO6Z4fET0b/WP1DGvbV
         hysBljBVyabjBzr0BEtXLQ68MdkdKe+YEw/r9voUIvPVYAfeYUYC+XoLGg0R/3GiJHTv
         jlHQ==
X-Gm-Message-State: AC+VfDwYyKhn0VzIuBZ807VjxKfJ3up70aiT6tU0+PANltGNST+4BZR4
        /6n71C0kZKSuQFMsHRZlpy3pyQ==
X-Google-Smtp-Source: ACHHUZ49/EMlr/fo3TPgAtcAPHwADu83PUd5hP54TSC62hQHziSYPPBDDQ1sfg7GYYfxCeypGD2++Q==
X-Received: by 2002:a17:903:41c8:b0:1aa:e0c3:1e64 with SMTP id u8-20020a17090341c800b001aae0c31e64mr3356286ple.38.1683330977491;
        Fri, 05 May 2023 16:56:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902744300b001ac4d3d3f72sm451008plt.296.2023.05.05.16.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 16:56:16 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pv5HZ-00BpiL-4I; Sat, 06 May 2023 09:56:13 +1000
Date:   Sat, 6 May 2023 09:56:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
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
Message-ID: <20230505235613.GP3223426@dread.disaster.area>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-12-john.g.garry@oracle.com>
 <20230504050006.GH3223426@dread.disaster.area>
 <20230505211928.GB15376@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505211928.GB15376@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 02:19:28PM -0700, Darrick J. Wong wrote:
> On Thu, May 04, 2023 at 03:00:06PM +1000, Dave Chinner wrote:
> > On Wed, May 03, 2023 at 06:38:16PM +0000, John Garry wrote:
> > > Add support to create bio's whose bi_sector and bi_size are aligned to and
> > > multiple of atomic_write_unit, respectively.
> > > 
> > > When we call iomap_dio_bio_iter() -> bio_iov_iter_get_pages() ->
> > > __bio_iov_iter_get_pages(), we trim the bio to a multiple of
> > > atomic_write_unit.
> > > 
> > > As such, we expect the iomi start and length to have same size and
> > > alignment requirements per iomap_dio_bio_iter() call.
> > > 
> > > In iomap_dio_bio_iter(), ensure that for a non-dsync iocb that the mapping
> > > is not dirty nor unmapped.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >  fs/iomap/direct-io.c | 72 ++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 70 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index f771001574d0..37c3c926dfd8 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -36,6 +36,8 @@ struct iomap_dio {
> > >  	size_t			done_before;
> > >  	bool			wait_for_completion;
> > >  
> > > +	unsigned int atomic_write_unit;
> > > +
> > >  	union {
> > >  		/* used during submission and for synchronous completion: */
> > >  		struct {
> > > @@ -229,9 +231,21 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> > >  	return opflags;
> > >  }
> > >  
> > > +
> > > +/*
> > > + * Note: For atomic writes, each bio which we create when we iter should have
> > > + *	 bi_sector aligned to atomic_write_unit and also its bi_size should be
> > > + *	 a multiple of atomic_write_unit.
> > > + *	 The call to bio_iov_iter_get_pages() -> __bio_iov_iter_get_pages()
> > > + *	 should trim the length to a multiple of atomic_write_unit for us.
> > > + *	 This allows us to split each bio later in the block layer to fit
> > > + *	 request_queue limit.
> > > + */
> > >  static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >  		struct iomap_dio *dio)
> > >  {
> > > +	bool atomic_write = (dio->iocb->ki_flags & IOCB_ATOMIC) &&
> > > +			    (dio->flags & IOMAP_DIO_WRITE);
> > >  	const struct iomap *iomap = &iter->iomap;
> > >  	struct inode *inode = iter->inode;
> > >  	unsigned int fs_block_size = i_blocksize(inode), pad;
> > > @@ -249,6 +263,14 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> > >  		return -EINVAL;
> > >  
> > > +
> > > +	if (atomic_write && !iocb_is_dsync(dio->iocb)) {
> > > +		if (iomap->flags & IOMAP_F_DIRTY)
> > > +			return -EIO;
> > > +		if (iomap->type != IOMAP_MAPPED)
> > > +			return -EIO;
> > > +	}
> > 
> > IDGI. If the iomap had space allocated for this dio iteration,
> > then IOMAP_F_DIRTY will be set and it is likely (guaranteed for XFS)
> > that the iomap type will be IOMAP_UNWRITTEN. Indeed, if we are doing
> > a write into preallocated space (i.e. from fallocate()) then this
> > will cause -EIO on all RWF_ATOMIC IO to that file unless RWF_DSYNC
> > is also used.
> > 
> > "For a power fail, for each individual application block, all or
> > none of the data to be written."
> > 
> > Ok, does this means RWF_ATOMIC still needs fdatasync() to guarantee
> > that the data makes it to stable storage? And the result is
> > undefined until fdatasync() is run, but the device will guarantee
> > that either all or none of the data will be on stable storage
> > prior to the next device cache flush completing?
> > 
> > i.e. does REQ_ATOMIC imply REQ_FUA, or does it require a separate
> > device cache flush to commit the atomic IO to stable storage?
> 
> From the SCSI and NVME device information that I've been presented, it
> sounds like an explicit cache flush or FUA is required to persist the
> data.

Ok, that makes it sound like RWF_ATOMIC has the same data integrity
semantics as normal DIO submission. i.e. the application has to
specify data integrity requirements and/or provide integrity
checkpoints itself.

> > What about ordering - do the devices guarantee strict ordering of
> > REQ_ATOMIC writes? i.e. if atomic write N is seen on disk, then all
> > the previous atomic writes up to N will also be seen on disk? If
> > not, how does the application and filesystem guarantee persistence
> > of completed atomic writes?
> 
> I /think/ the applications have to ensure ordering themselves.  If Y
> cannot appear before X is persisted, then the application must wait for
> the ack for X, flush the cache, and only then send Y.

RIght, I'd expect that completion-to-submission ordering is required
with RWF_ATOMIC the same way it is required for normal DIO, but I've
been around long enough to know that we can't make assumptions about
data integrity semantics...

> > i.e. If we still need a post-IO device cache flush to guarantee
> > persistence and/or ordering of RWF_ATOMIC IOs, then the above code
> > makes no sense - we'll still need fdatasync() to provide persistence
> > checkpoints and that means we ensure metadata is also up to date
> > at those checkpoints.
> 
> I'll let the block layer developers weigh in on this, but I /think/ this
> means that we require RWF_DSYNC for atomic block writes to written
> mappings, and RWF_SYNC if iomap_begin gives us an unwritten/hole/dirty
> mapping.

RWF_DSYNC is functionally the same as RWF_OSYNC. The only difference
is that RWF_OSYNC considers timestamps as dirty metadata, whilst
RWF_DSYNC doesn't. Hence I don't think there's any functional
difference w.r.t. data integrity by using OSYNC vs DSYNC...

> > > @@ -592,6 +634,32 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > >  
> > >  	blk_start_plug(&plug);
> > >  	while ((ret = iomap_iter(&iomi, ops)) > 0) {
> > > +		if (atomic_write) {
> > > +			const struct iomap *_iomap = &iomi.iomap;
> > > +			loff_t iomi_length = iomap_length(&iomi);
> > > +
> > > +			/*
> > > +			 * Ensure length and start address is a multiple of
> > > +			 * atomic_write_unit - this is critical. If the length
> > > +			 * is not a multiple of atomic_write_unit, then we
> > > +			 * cannot create a set of bio's in iomap_dio_bio_iter()
> > > +			 * who are each a length which is a multiple of
> > > +			 * atomic_write_unit.
> > > +			 *
> > > +			 * Note: It may be more appropiate to have this check
> > > +			 *	 in iomap_dio_bio_iter()
> > > +			 */
> > > +			if ((iomap_sector(_iomap, iomi.pos) << SECTOR_SHIFT) %
> 
> The file offset (and by extension the position) are not important for
> deciding if we can issue an atomic write.  Only the mapped LBA space on
> the underlying device is important.
> 
> IOWs, if we have a disk that can write a 64k aligned block atomically,
> iomap only has to check that iomap->addr is aligned to a 64k boundary.
> If that space happens to be mapped to file offset 57k, then it is indeed
> possible to perform a 64k atomic write to the file starting at offset
> 57k and ending at offset 121k, right?

Yup, that was kinda what I was implying in pointing out that file
offset does not reflect device IO alignment...

> > Hence I think that we should be rejecting RWF_ATOMIC IOs that are
> > larger than the maximum atomic write unit or cannot be dispatched in
> > a single IO e.g. filesystem has allocated multiple minimum aligned
> > extents and so a max len atomic write IO over that range must be
> > broken up into multiple smaller IOs.
> > 
> > We should be doing max atomic write size rejection high up in the IO
> > path (e.g. filesystem ->write_iter() method) before we get anywhere
> > near the DIO path, and we should be rejecting atomic write IOs in
> > the DIO path during the ->iomap_begin() mapping callback if we can't
> > map the entire atomic IO to a single aligned filesystem extent.
> > 
> > i.e. the alignment checks and constraints need to be applied by the
> > filesystem mapping code, not the layer that packs the pages into the
> > bio as directed by the filesystem mapping....
> 
> Hmm.  I think I see what you're saying here -- iomap should communicate
> to ->iomap_begin that we want to perform an atomic write, and there had
> better be either (a) a properly aligned mapping all ready to go; or (b)
> the fs must perform an aligned allocation and map that in, or return no
> mapping so the write fails.

Exactly. This is how IOCB_NOWAIT works, too - we can reject it high
up in the IO path if we can't get locks, and then if we have to do
allocation in ->iomap_begin because there is no mapping available we
reject the IO there.

Hence I think we should use the same constraint checking model for
RWF_ATOMIC - the constraints are slightly different, but the layers
at which we can first resolve the various constraints are exactly
the same...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
