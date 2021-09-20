Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF5B4122ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 20:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351739AbhITSS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 14:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351730AbhITSQ5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:16:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B568E63299;
        Mon, 20 Sep 2021 17:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632158545;
        bh=bYv8C4DhmSGLK72oXRqCw8vauuhbQjCfHZmhP31ZU58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDY+FK8vvVqDW+8RvqiaTjL5ctHPZ4A6FTt6DMboBG1//20Du4724pPRZjCAqK4th
         SbaeiBul9EZEfIIJnGanztiYWdChqq6T2C4gnw8dMOWksftL2SzGwf9fJomSgZ3OoR
         1zRV135t3ex7/Xhvcg90S0S5m0fqvj6DJKlPEcmv1a0PYqqH9eoybS5OTm55fcKmAt
         qbGEG0f5fpQtjbY4QdTHHIfgMafglhGPxFcTNtwYUS1FG2YDtCnYeDMgO5PNvsOB72
         6NXJA4503VL6PEjqL9QGAXZxI9kcaXSnqsx6DD6+XWZJJsuQVzQnT/gQMAvG/BnaxK
         43+ef4eiumEqQ==
Date:   Mon, 20 Sep 2021 10:22:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     riteshh <riteshh@linux.ibm.com>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] dax: prepare pmem for use by zero-initializing
 contents and clearing poisons
Message-ID: <20210920172225.GA570615@magnolia>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192865031.417973.8372869475521627214.stgit@magnolia>
 <20210918165408.ivsue463wpiitzjw@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918165408.ivsue463wpiitzjw@riteshh-domain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 18, 2021 at 10:24:08PM +0530, riteshh wrote:
> On 21/09/17 06:30PM, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Our current "advice" to people using persistent memory and FSDAX who
> > wish to recover upon receipt of a media error (aka 'hwpoison') event
> > from ACPI is to punch-hole that part of the file and then pwrite it,
> > which will magically cause the pmem to be reinitialized and the poison
> > to be cleared.
> >
> > Punching doesn't make any sense at all -- the (re)allocation on pwrite
> > does not permit the caller to specify where to find blocks, which means
> > that we might not get the same pmem back.  This pushes the user farther
> > away from the goal of reinitializing poisoned memory and leads to
> > complaints about unnecessary file fragmentation.
> >
> > AFAICT, the only reason why the "punch and write" dance works at all is
> > that the XFS and ext4 currently call blkdev_issue_zeroout when
> > allocating pmem ahead of a write call.  Even a regular overwrite won't
> > clear the poison, because dax_direct_access is smart enough to bail out
> > on poisoned pmem, but not smart enough to clear it.  To be fair, that
> > function maps pages and has no idea what kinds of reads and writes the
> > caller might want to perform.
> >
> > Therefore, create a dax_zeroinit_range function that filesystems can to
> > reset the pmem contents to zero and clear hardware media error flags.
> > This uses the dax page zeroing helper function, which should ensure that
> > subsequent accesses will not trip over any pre-existing media errors.
> 
> Thanks Darrick for such clear explaination of the problem and your solution.
> As I see from this thread [1], it looks like we are heading in this direction,
> so I thought of why not review this RFC patch series :)
> 
> [1]: https://lore.kernel.org/all/CAPcyv4iAr_Vwwgqw+4wz0RQUXhUUJGGz7_T+p+W6tC4T+k+zNw@mail.gmail.com/
> 
> >
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/dax.c            |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/dax.h |    7 ++++
> >  2 files changed, 100 insertions(+)
> >
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 4e3e5a283a91..765b80d08605 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -1714,3 +1714,96 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
> >  	return dax_insert_pfn_mkwrite(vmf, pfn, order);
> >  }
> >  EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
> > +
> > +static loff_t
> > +dax_zeroinit_iter(struct iomap_iter *iter)
> > +{
> > +	struct iomap *iomap = &iter->iomap;
> > +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > +	const u64 start = iomap->addr + iter->pos - iomap->offset;
> > +	const u64 nr_bytes = iomap_length(iter);
> > +	u64 start_page = start >> PAGE_SHIFT;
> > +	u64 nr_pages = nr_bytes >> PAGE_SHIFT;
> > +	int ret;
> > +
> > +	if (!iomap->dax_dev)
> > +		return -ECANCELED;
> > +
> > +	/*
> > +	 * The physical extent must be page aligned because that's what the dax
> > +	 * function requires.
> > +	 */
> > +	if (!PAGE_ALIGNED(start | nr_bytes))
> > +		return -ECANCELED;
> > +
> > +	/*
> > +	 * The dax function, by using pgoff_t, is stuck with unsigned long, so
> > +	 * we must check for overflows.
> > +	 */
> > +	if (start_page >= ULONG_MAX || start_page + nr_pages > ULONG_MAX)
> > +		return -ECANCELED;
> > +
> > +	/* Must be able to zero storage directly without fs intervention. */
> > +	if (iomap->flags & IOMAP_F_SHARED)
> > +		return -ECANCELED;
> > +	if (srcmap != iomap)
> > +		return -ECANCELED;
> > +
> > +	switch (iomap->type) {
> > +	case IOMAP_MAPPED:
> > +		while (nr_pages > 0) {
> > +			/* XXX function only supports one page at a time?! */
> > +			ret = dax_zero_page_range(iomap->dax_dev, start_page,
> > +					1);
> > +			if (ret)
> > +				return ret;
> > +			start_page++;
> > +			nr_pages--;
> > +		}
> > +
> > +		fallthrough;
> > +	case IOMAP_UNWRITTEN:
> > +		return nr_bytes;
> > +	}
> > +
> > +	/* Reject holes, inline data, or delalloc extents. */
> > +	return -ECANCELED;
> 
> We reject holes here, but the other vfs plumbing patch [2] mentions
> "Holes and unwritten extents are left untouched.".
> Shouldn't we just return nr_bytes for IOMAP_HOLE case as well?

I'm not entirely sure what we should do for holes and unwritten extents,
as you can tell from the gross inconsistency between the comment and the
code. :/

On block devices, I think we rely on the behavior that writing to disk
will clear the device's error state (via LBA remapping or some other
strategy).  I think this means iomap_zeroinit can skip unwritten extents
because reads and read faults will be satisfied from the zero page and
writeback (or direct writes) will trigger the drive firmware.

On FSDAX devices, reads are fulfilled by zeroing the user buffer, and
read faults with the (dax) zero page.  Writes and write faults won't
clear the poison (unlike disks).  So I guess this means that
dax_zeroinit *does* have to act on unwritten areas.

Ok.  I'll make those changes.

As for holes -- on the one hand, one could argue that zero-initializing
a hole makes no sense and should be an error.  OTOH one could make an
equally compelling argument that it's merely a nop.  Thoughts?

--D

> [2]: "vfs: add a zero-initialization mode to fallocate"
> 
> Although I am not an expert in this area, but the rest of the patch looks
> very well crafted to me. Thanks again for such details :)
> 
> -ritesh
> 
> >
> > +}
> > +
> > +/*
> > + * Initialize storage mapped to a DAX-mode file to a known value and ensure the
> > + * media are ready to accept read and write commands.  This requires the use of
> > + * the dax layer's zero page range function to write zeroes to a pmem region
> > + * and to reset any hardware media error state.
> > + *
> > + * The physical extents must be aligned to page size.  The file must be backed
> > + * by a pmem device.  The extents returned must not require copy on write (or
> > + * any other mapping interventions from the filesystem) and must be contiguous.
> > + * @done will be set to true if the reset succeeded.
> > + *
> > + * Returns 0 if the zero initialization succeeded, -ECANCELED if the storage
> > + * mappings do not support zero initialization, -EOPNOTSUPP if the device does
> > + * not support it, or the usual negative errno.
> > + */
> > +int
> > +dax_zeroinit_range(struct inode *inode, loff_t pos, u64 len,
> > +		   const struct iomap_ops *ops)
> > +{
> > +	struct iomap_iter iter = {
> > +		.inode		= inode,
> > +		.pos		= pos,
> > +		.len		= len,
> > +		.flags		= IOMAP_REPORT,
> > +	};
> > +	int ret;
> > +
> > +	if (!IS_DAX(inode))
> > +		return -EINVAL;
> > +	if (pos + len > i_size_read(inode))
> > +		return -EINVAL;
> > +
> > +	while ((ret = iomap_iter(&iter, ops)) > 0)
> > +		iter.processed = dax_zeroinit_iter(&iter);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(dax_zeroinit_range);
> > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > index 2619d94c308d..3c873f7c35ba 100644
> > --- a/include/linux/dax.h
> > +++ b/include/linux/dax.h
> > @@ -129,6 +129,8 @@ struct page *dax_layout_busy_page(struct address_space *mapping);
> >  struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
> >  dax_entry_t dax_lock_page(struct page *page);
> >  void dax_unlock_page(struct page *page, dax_entry_t cookie);
> > +int dax_zeroinit_range(struct inode *inode, loff_t pos, u64 len,
> > +			const struct iomap_ops *ops);
> >  #else
> >  #define generic_fsdax_supported		NULL
> >
> > @@ -174,6 +176,11 @@ static inline dax_entry_t dax_lock_page(struct page *page)
> >  static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
> >  {
> >  }
> > +static inline int dax_zeroinit_range(struct inode *inode, loff_t pos, u64 len,
> > +		const struct iomap_ops *ops)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> >  #endif
> >
> >  #if IS_ENABLED(CONFIG_DAX)
> >
