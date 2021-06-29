Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3C73B799F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 23:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbhF2VEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 17:04:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235653AbhF2VEI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 17:04:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FF9661D81;
        Tue, 29 Jun 2021 21:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625000500;
        bh=Qye8Gb01Funch/qmliE90qh5iZ17gYbzWuZoY1RVGu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PyrBMoKKXhiZFezHw7VX2gRfxyuUd41DX1ww1sKiO3r+iv459PphLPcw1F/sHcySu
         LXTlNkmzg4JXiYCvFotGtgYRQLjKPw+xNBaQ6LqMInN3cyJ13OYQ3MCtzllP2VkAB/
         9ubVQzzZSV7sCcpqR1gZbZRPyGg2JD7qn4v53cJqzwV8uwPa8zqF8vvqp1BDg2DBRW
         3HYlczsCO0jMG7EkFCe0y35uo35eAIb7x+2X9olHU+luraUmef4BRQ/c6WV4C5DCZp
         e0g0h51eyh3jbA3DxrkMO/9+ARIjHD7Kdqj5qRn41OGWwpMIPnSeOBDxE57wnjMdmz
         qo787QfM03d2A==
Date:   Tue, 29 Jun 2021 14:01:40 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v6.1 6/7] fs/xfs: Handle CoW for fsdax write() path
Message-ID: <20210629210140.GA13750@locust>
References: <OSBPR01MB2920A2BCD568364C1363AFA6F4369@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20210615072147.73852-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB2920D2D275EB0DB15C37D079F4079@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20210625221855.GG13784@locust>
 <OSBPR01MB2920922639112230407000E9F4039@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20210628050919.GL13784@locust>
 <OSBPR01MB2920EAD893B64E46C8110641F4029@OSBPR01MB2920.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB2920EAD893B64E46C8110641F4029@OSBPR01MB2920.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 11:25:37AM +0000, ruansy.fnst@fujitsu.com wrote:
> 
> 
> > -----Original Message-----
> > From: Darrick J. Wong <djwong@kernel.org>
> > Subject: Re: [PATCH v6.1 6/7] fs/xfs: Handle CoW for fsdax write() path
> > 
> > On Mon, Jun 28, 2021 at 02:55:03AM +0000, ruansy.fnst@fujitsu.com wrote:
> > > > -----Original Message-----
> > > > Subject: Re: [PATCH v6.1 6/7] fs/xfs: Handle CoW for fsdax write()
> > > > path
> > > >
> > > > On Thu, Jun 24, 2021 at 08:49:17AM +0000, ruansy.fnst@fujitsu.com wrote:
> > > > > Hi Darrick,
> > > > >
> > > > > Do you have any comment on this?
> > > >
> > > > Sorry, was on vacation.
> > > >
> > > > > Thanks,
> > > > > Ruan.
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > > > > Subject: [PATCH v6.1 6/7] fs/xfs: Handle CoW for fsdax write()
> > > > > > path
> > > > > >
> > > > > > Hi Darrick,
> > > > > >
> > > > > > Since other patches looks good, I post this RFC patch singly to
> > > > > > hot-fix the problem in xfs_dax_write_iomap_ops->iomap_end() of
> > > > > > v6 that the error code was ingored. I will split this in two
> > > > > > patches(changes in iomap and xfs
> > > > > > respectively) in next formal version if it looks ok.
> > > > > >
> > > > > > ====
> > > > > >
> > > > > > Introduce a new interface called "iomap_post_actor()" in iomap_ops.
> > > > > > And call it between ->actor() and ->iomap_end().  It is mean to
> > > > > > handle the error code returned from ->actor().  In this
> > > > > > patchset, it is used to remap or cancel the CoW extents according to the
> > error code.
> > > > > >
> > > > > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > > > > ---
> > > > > >  fs/dax.c               | 27 ++++++++++++++++++---------
> > > > > >  fs/iomap/apply.c       |  4 ++++
> > > > > >  fs/xfs/xfs_bmap_util.c |  3 +--
> > > > > >  fs/xfs/xfs_file.c      |  5 +++--
> > > > > >  fs/xfs/xfs_iomap.c     | 33 ++++++++++++++++++++++++++++++++-
> > > > > >  fs/xfs/xfs_iomap.h     | 24 ++++++++++++++++++++++++
> > > > > >  fs/xfs/xfs_iops.c      |  7 +++----
> > > > > >  fs/xfs/xfs_reflink.c   |  3 +--
> > > > > >  include/linux/iomap.h  |  8 ++++++++
> > > > > >  9 files changed, 94 insertions(+), 20 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/dax.c b/fs/dax.c index
> > > > > > 93f16210847b..0740c2610b6f 100644
> > > > > > --- a/fs/dax.c
> > > > > > +++ b/fs/dax.c
> > > > > > @@ -1537,7 +1537,7 @@ static vm_fault_t
> > > > > > dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
> > > > > >  	struct iomap iomap = { .type = IOMAP_HOLE };
> > > > > >  	struct iomap srcmap = { .type = IOMAP_HOLE };
> > > > > >  	unsigned flags = IOMAP_FAULT;
> > > > > > -	int error;
> > > > > > +	int error, copied = PAGE_SIZE;
> > > > > >  	bool write = vmf->flags & FAULT_FLAG_WRITE;
> > > > > >  	vm_fault_t ret = 0, major = 0;
> > > > > >  	void *entry;
> > > > > > @@ -1598,7 +1598,7 @@ static vm_fault_t
> > > > > > dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
> > > > > >  	ret = dax_fault_actor(vmf, pfnp, &xas, &entry, false, flags,
> > > > > >  			      &iomap, &srcmap);
> > > > > >  	if (ret == VM_FAULT_SIGBUS)
> > > > > > -		goto finish_iomap;
> > > > > > +		goto finish_iomap_actor;
> > > > > >
> > > > > >  	/* read/write MAPPED, CoW UNWRITTEN */
> > > > > >  	if (iomap.flags & IOMAP_F_NEW) { @@ -1607,10 +1607,16 @@
> > > > > > static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf,
> > > > > > pfn_t *pfnp,
> > > > > >  		major = VM_FAULT_MAJOR;
> > > > > >  	}
> > > > > >
> > > > > > + finish_iomap_actor:
> > > > > > +	if (ops->iomap_post_actor) {
> > > > > > +		if (ret & VM_FAULT_ERROR)
> > > > > > +			copied = 0;
> > > > > > +		ops->iomap_post_actor(inode, pos, PMD_SIZE, copied, flags,
> > > > > > +				      &iomap, &srcmap);
> > > > > > +	}
> > > > > > +
> > > > > >  finish_iomap:
> > > > > >  	if (ops->iomap_end) {
> > > > > > -		int copied = PAGE_SIZE;
> > > > > > -
> > > > > >  		if (ret & VM_FAULT_ERROR)
> > > > > >  			copied = 0;
> > > > > >  		/*
> > > > > > @@ -1677,7 +1683,7 @@ static vm_fault_t
> > > > > > dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
> > > > > >  	pgoff_t max_pgoff;
> > > > > >  	void *entry;
> > > > > >  	loff_t pos;
> > > > > > -	int error;
> > > > > > +	int error, copied = PMD_SIZE;
> > > > > >
> > > > > >  	/*
> > > > > >  	 * Check whether offset isn't beyond end of file now. Caller
> > > > > > is @@
> > > > > > -1736,12
> > > > > > +1742,15 @@ static vm_fault_t dax_iomap_pmd_fault(struct
> > > > > > +vm_fault *vmf,
> > > > > > pfn_t *pfnp,
> > > > > >  	ret = dax_fault_actor(vmf, pfnp, &xas, &entry, true, flags,
> > > > > >  			      &iomap, &srcmap);
> > > > > >
> > > > > > +	if (ret == VM_FAULT_FALLBACK)
> > > > > > +		copied = 0;
> > > > > > +	if (ops->iomap_post_actor) {
> > > > > > +		ops->iomap_post_actor(inode, pos, PMD_SIZE, copied, flags,
> > > > > > +				      &iomap, &srcmap);
> > > > > > +	}
> > > > > > +
> > > > > >  finish_iomap:
> > > > > >  	if (ops->iomap_end) {
> > > > > > -		int copied = PMD_SIZE;
> > > > > > -
> > > > > > -		if (ret == VM_FAULT_FALLBACK)
> > > > > > -			copied = 0;
> > > > > >  		/*
> > > > > >  		 * The fault is done by now and there's no way back (other
> > > > > >  		 * thread may be already happily using PMD we have installed).
> > > > > > diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c index
> > > > > > 0493da5286ad..26a54ded184f 100644
> > > > > > --- a/fs/iomap/apply.c
> > > > > > +++ b/fs/iomap/apply.c
> > > > > > @@ -84,6 +84,10 @@ iomap_apply(struct inode *inode, loff_t pos,
> > > > > > loff_t length, unsigned flags,
> > > > > >  	written = actor(inode, pos, length, data, &iomap,
> > > > > >  			srcmap.type != IOMAP_HOLE ? &srcmap : &iomap);
> > > > > >
> > > > > > +	if (ops->iomap_post_actor) {
> > > > > > +		written = ops->iomap_post_actor(inode, pos, length, written,
> > > > > > +						flags, &iomap, &srcmap);
> > > >
> > > > How many operations actually need an iomap_post_actor?  It's just
> > > > the dax ones, right?  Which is ... iomap_truncate_page,
> > > > iomap_zero_range, dax_iomap_fault, and dax_iomap_rw, right?  We
> > > > don't need a post_actor for other iomap functionality (like FIEMAP,
> > > > SEEK_DATA/SEEK_HOLE, etc.) so adding a new function pointer for all
> > operations feels a bit overbroad.
> > >
> > > Yes.
> > >
> > > >
> > > > I had imagined that you'd create a struct dax_iomap_ops to wrap all
> > > > the extra functionality that you need for dax operations:
> > > >
> > > > struct dax_iomap_ops {
> > > > 	struct iomap_ops	iomap_ops;
> > > >
> > > > 	int			(*end_io)(inode, pos, length...);
> > > > };
> > > >
> > > > And alter the four functions that you need to take the special
> > dax_iomap_ops.
> > > > I guess the downside is that this makes iomap_truncate_page and
> > > > iomap_zero_range more complicated, but maybe it's just time to split
> > > > those into DAX-specific versions.  Then we'd be rid of the
> > > > cross-links betwee fs/iomap/buffered-io.c and fs/dax.c.
> > >
> > > This seems to be a better solution.  I'll try in this way.  Thanks for your
> > guidance.
> > 
> > I started writing on Friday a patchset to apply this style cleanup both to the
> > directio and dax paths.  The cleanups were pretty straightforward until I
> > started reading the dax code paths again and realized that file writes still have
> > the weird behavior of mapping extents into a file, zeroing them, then issuing the
> > actual write to the extent.  IOWs, a double-write to avoid exposing stale
> > contents if crash.
> 
> The current code seems not zeroing an unwritten extent when writing in
> fsdax mode?  Just allocate unwritten extents in filesystem, and then
> write data in fsdax.

That's not what it does.  See xfs_iomap_write_direct:

	/*
	 * For DAX, we do not allocate unwritten extents, but instead we
	 * zero the block before we commit the transaction.  Ideally
	 * we'd like to do this outside the transaction context, but if
	 * we commit and then crash we may not have zeroed the blocks
	 * and this will be exposed on recovery of the allocation. Hence
	 * we must zero before commit.
	 *
	 * Further, if we are mapping unwritten extents here, we need to
	 * zero and convert them to written so that we don't need an
	 * unwritten extent callback for DAX. This also means that we
	 * need to be able to dip into the reserve block pool for bmbt
	 * block allocation if there is no space left but we need to do
	 * unwritten extent conversion.
	 */
	if (IS_DAX(VFS_I(ip))) {
		bmapi_flags = XFS_BMAPI_CONVERT | XFS_BMAPI_ZERO;
		if (imap->br_state == XFS_EXT_UNWRITTEN) {
			force = true;
			nr_exts = XFS_IEXT_WRITE_UNWRITTEN_CNT;
			dblocks = XFS_DIOSTRAT_SPACE_RES(mp, 0) << 1;
		}
	}

Originally added in:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1ca191576fc862b4766f58e41aa362b28a7c1866

Of course, that was six years ago when the mm folks were still arguing
about whether they'd have struct page or pfns or some combination of the
two for DAX.  I'm not sure if those limitations still exist, or if they
quietly disappeared and xfs/ext4/ext2 haven't noticed.  I think I see
that we store pfns in i_pages along with a lock bit, but I don't know if
that lock bit is sufficient to prevent races between page faults.

Hence my question below:
> 
> > 
> > Apparently the reason for this was that dax (at least 6 years ago) had no
> > concept paralleling the page lock, so it was necessary to do that to avoid page
> > fault handlers racing to map pfns into the file mapping?
> > That would seem to prevent us from doing the more standard behavior of
> > allocate unwritten, write data, convert mapping... but is that still the case?  Or
> > can we get rid of this bad quirk?
> 
> I am not sure about this...

Me neither.

--D

> 
> 
> --
> Thanks,
> Ruan.
> 
> > 
> > --D
> > 
> > >
> > > >
> > > > > > +	}
> > > > > >  out:
> > > > > >  	/*
> > > > > >  	 * Now the data has been copied, commit the range we've copied.
> > > > > > This diff --git a/fs/xfs/xfs_bmap_util.c
> > > > > > b/fs/xfs/xfs_bmap_util.c index
> > > > > > a5e9d7d34023..2a36dc93ff27 100644
> > > > > > --- a/fs/xfs/xfs_bmap_util.c
> > > > > > +++ b/fs/xfs/xfs_bmap_util.c
> > > > > > @@ -965,8 +965,7 @@ xfs_free_file_space(
> > > > > >  		return 0;
> > > > > >  	if (offset + len > XFS_ISIZE(ip))
> > > > > >  		len = XFS_ISIZE(ip) - offset;
> > > > > > -	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
> > > > > > -			&xfs_buffered_write_iomap_ops);
> > > > > > +	error = xfs_iomap_zero_range(ip, offset, len, NULL);
> > > > > >  	if (error)
> > > > > >  		return error;
> > > > > >
> > > > > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c index
> > > > > > 396ef36dcd0a..89406ec6741b
> > > > > > 100644
> > > > > > --- a/fs/xfs/xfs_file.c
> > > > > > +++ b/fs/xfs/xfs_file.c
> > > > > > @@ -684,11 +684,12 @@ xfs_file_dax_write(
> > > > > >  	pos = iocb->ki_pos;
> > > > > >
> > > > > >  	trace_xfs_file_dax_write(iocb, from);
> > > > > > -	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
> > > > > > +	ret = dax_iomap_rw(iocb, from, &xfs_dax_write_iomap_ops);
> > > > > >  	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
> > > > > >  		i_size_write(inode, iocb->ki_pos);
> > > > > >  		error = xfs_setfilesize(ip, pos, ret);
> > > > > >  	}
> > > > > > +
> > > > > >  out:
> > > > > >  	if (iolock)
> > > > > >  		xfs_iunlock(ip, iolock);
> > > > > > @@ -1309,7 +1310,7 @@ __xfs_filemap_fault(
> > > > > >
> > > > > >  		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
> > > > > >  				(write_fault && !vmf->cow_page) ?
> > > > > > -				 &xfs_direct_write_iomap_ops :
> > > > > > +				 &xfs_dax_write_iomap_ops :
> > > > > >  				 &xfs_read_iomap_ops);
> > > > > >  		if (ret & VM_FAULT_NEEDDSYNC)
> > > > > >  			ret = dax_finish_sync_fault(vmf, pe_size, pfn); diff --git
> > > > > > a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c index
> > > > > > d154f42e2dc6..2f322e2f8544
> > > > > > 100644
> > > > > > --- a/fs/xfs/xfs_iomap.c
> > > > > > +++ b/fs/xfs/xfs_iomap.c
> > > > > > @@ -761,7 +761,8 @@ xfs_direct_write_iomap_begin(
> > > > > >
> > > > > >  		/* may drop and re-acquire the ilock */
> > > > > >  		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> > > > > > -				&lockmode, flags & IOMAP_DIRECT);
> > > > > > +				&lockmode,
> > > > > > +				(flags & IOMAP_DIRECT) || IS_DAX(inode));
> > > > > >  		if (error)
> > > > > >  			goto out_unlock;
> > > > > >  		if (shared)
> > > > > > @@ -854,6 +855,36 @@ const struct iomap_ops
> > > > > > xfs_direct_write_iomap_ops = {
> > > > > >  	.iomap_begin		= xfs_direct_write_iomap_begin,
> > > > > >  };
> > > > > >
> > > > > > +static int
> > > > > > +xfs_dax_write_iomap_post_actor(
> > > > > > +	struct inode		*inode,
> > > > > > +	loff_t			pos,
> > > > > > +	loff_t			length,
> > > > > > +	ssize_t			written,
> > > > > > +	unsigned int		flags,
> > > > > > +	struct iomap		*iomap,
> > > > > > +	struct iomap		*srcmap)
> > > > > > +{
> > > > > > +	int			error = 0;
> > > > > > +	struct xfs_inode	*ip = XFS_I(inode);
> > > > > > +	bool			cow = xfs_is_cow_inode(ip);
> > > > > > +
> > > > > > +	if (written <= 0) {
> > > > > > +		if (cow)
> > > > > > +			xfs_reflink_cancel_cow_range(ip, pos, length, true);
> > > > > > +		return written;
> > > > > > +	}
> > > > > > +
> > > > > > +	if (cow)
> > > > > > +		error = xfs_reflink_end_cow(ip, pos, written);
> > > > > > +	return error ?: written;
> > > > > > +}
> > > >
> > > > This is pretty much the same as what xfs_dio_write_end_io does, right?
> > >
> > > It just handles the end part of CoW here.
> > > xfs_dio_write_end_io() also updates file size, which is only needed in write()
> > but not in page fault.  And the update file size work is done in
> > xfs_dax_file_write(), it's fine, no need to modify it.
> > >
> > > >
> > > > I had imagined that you'd change the function signatures to drop the
> > > > iocb so that you could reuse this code instead of creating a whole new
> > callback.
> > > >
> > > > Ah well.  Can I send you some prep patches to clean up some of the
> > > > weird iomap code as a preparation series for this?
> > >
> > > Sure.  Thanks.
> > >
> > >
> > > --
> > > Ruan.
> > >
> > > >
> > > > --D
> > > >
> > > > > > +
> > > > > > +const struct iomap_ops xfs_dax_write_iomap_ops = {
> > > > > > +	.iomap_begin		= xfs_direct_write_iomap_begin,
> > > > > > +	.iomap_post_actor	= xfs_dax_write_iomap_post_actor,
> > > > > > +};
> > > > > > +
> > > > > >  static int
> > > > > >  xfs_buffered_write_iomap_begin(
> > > > > >  	struct inode		*inode,
> > > > > > diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h index
> > > > > > 7d3703556d0e..fbacf638ab21 100644
> > > > > > --- a/fs/xfs/xfs_iomap.h
> > > > > > +++ b/fs/xfs/xfs_iomap.h
> > > > > > @@ -42,8 +42,32 @@ xfs_aligned_fsb_count(
> > > > > >
> > > > > >  extern const struct iomap_ops xfs_buffered_write_iomap_ops;
> > > > > > extern const struct iomap_ops xfs_direct_write_iomap_ops;
> > > > > > +extern const struct iomap_ops xfs_dax_write_iomap_ops;
> > > > > >  extern const struct iomap_ops xfs_read_iomap_ops;  extern const
> > > > > > struct iomap_ops xfs_seek_iomap_ops;  extern const struct
> > > > > > iomap_ops xfs_xattr_iomap_ops;
> > > > > >
> > > > > > +static inline int
> > > > > > +xfs_iomap_zero_range(
> > > > > > +	struct xfs_inode	*ip,
> > > > > > +	loff_t			offset,
> > > > > > +	loff_t			len,
> > > > > > +	bool			*did_zero)
> > > > > > +{
> > > > > > +	return iomap_zero_range(VFS_I(ip), offset, len, did_zero,
> > > > > > +			IS_DAX(VFS_I(ip)) ? &xfs_dax_write_iomap_ops
> > > > > > +					  : &xfs_buffered_write_iomap_ops); }
> > > > > > +
> > > > > > +static inline int
> > > > > > +xfs_iomap_truncate_page(
> > > > > > +	struct xfs_inode	*ip,
> > > > > > +	loff_t			pos,
> > > > > > +	bool			*did_zero)
> > > > > > +{
> > > > > > +	return iomap_truncate_page(VFS_I(ip), pos, did_zero,
> > > > > > +			IS_DAX(VFS_I(ip)) ? &xfs_dax_write_iomap_ops
> > > > > > +					  : &xfs_buffered_write_iomap_ops); }
> > > > > > +
> > > > > >  #endif /* __XFS_IOMAP_H__*/
> > > > > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c index
> > > > > > dfe24b7f26e5..6d936c3e1a6e 100644
> > > > > > --- a/fs/xfs/xfs_iops.c
> > > > > > +++ b/fs/xfs/xfs_iops.c
> > > > > > @@ -911,8 +911,8 @@ xfs_setattr_size(
> > > > > >  	 */
> > > > > >  	if (newsize > oldsize) {
> > > > > >  		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
> > > > > > -		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
> > > > > > -				&did_zeroing, &xfs_buffered_write_iomap_ops);
> > > > > > +		error = xfs_iomap_zero_range(ip, oldsize, newsize - oldsize,
> > > > > > +				&did_zeroing);
> > > > > >  	} else {
> > > > > >  		/*
> > > > > >  		 * iomap won't detect a dirty page over an unwritten block
> > > > > > (or a @@
> > > > > > -924,8 +924,7 @@ xfs_setattr_size(
> > > > > >  						     newsize);
> > > > > >  		if (error)
> > > > > >  			return error;
> > > > > > -		error = iomap_truncate_page(inode, newsize, &did_zeroing,
> > > > > > -				&xfs_buffered_write_iomap_ops);
> > > > > > +		error = xfs_iomap_truncate_page(ip, newsize, &did_zeroing);
> > > > > >  	}
> > > > > >
> > > > > >  	if (error)
> > > > > > diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c index
> > > > > > d25434f93235..9a780948dbd0 100644
> > > > > > --- a/fs/xfs/xfs_reflink.c
> > > > > > +++ b/fs/xfs/xfs_reflink.c
> > > > > > @@ -1266,8 +1266,7 @@ xfs_reflink_zero_posteof(
> > > > > >  		return 0;
> > > > > >
> > > > > >  	trace_xfs_zero_eof(ip, isize, pos - isize);
> > > > > > -	return iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL,
> > > > > > -			&xfs_buffered_write_iomap_ops);
> > > > > > +	return xfs_iomap_zero_range(ip, isize, pos - isize, NULL);
> > > > > >  }
> > > > > >
> > > > > >  /*
> > > > > > diff --git a/include/linux/iomap.h b/include/linux/iomap.h index
> > > > > > 95562f863ad0..58f2e1c78018 100644
> > > > > > --- a/include/linux/iomap.h
> > > > > > +++ b/include/linux/iomap.h
> > > > > > @@ -135,6 +135,14 @@ struct iomap_ops {
> > > > > >  			unsigned flags, struct iomap *iomap,
> > > > > >  			struct iomap *srcmap);
> > > > > >
> > > > > > +	/*
> > > > > > +	 * Handle the error code from actor(). Do the finishing jobs for extra
> > > > > > +	 * operations, such as CoW, according to whether written is negative.
> > > > > > +	 */
> > > > > > +	int (*iomap_post_actor)(struct inode *inode, loff_t pos, loff_t length,
> > > > > > +			ssize_t written, unsigned flags, struct iomap *iomap,
> > > > > > +			struct iomap *srcmap);
> > > > > > +
> > > > > >  	/*
> > > > > >  	 * Commit and/or unreserve space previous allocated using
> > > > iomap_begin.
> > > > > >  	 * Written indicates the length of the successful write
> > > > > > operation which
> > > > > > --
> > > > > > 2.31.1
> > > > >
