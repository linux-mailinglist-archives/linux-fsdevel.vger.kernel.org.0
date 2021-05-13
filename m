Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA68F37FA3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 17:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhEMPEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 11:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234741AbhEMPEH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 11:04:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21951613BF;
        Thu, 13 May 2021 15:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620918177;
        bh=cBiZH5cA4ZJFBtPESKx3lalIyQXwEUPv61Feaixqwv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFnkkGcTH2gdDJ1ec4mdivpiApkIDYh13BGA9uF0kntiLspoq9kyt3/6XiMt5UpeU
         +o/KEttW3Gx6ZjLTfGysichBWWcCpm483Cfu4zYyt+6uiKGSoWGr1xz5xqWlFmw1ys
         D9tUDJecP50MQYldnYtHruD6JLt59iYCK1LX+ZJgJ8tsP11aCr1iNa9yOhWjf4Knf6
         Qz3sLqshVj7rPL61GTgOQxNJ3uiE+kCWtjwDXcBn/YGINPZJgElxivFmeb4ZRWsew6
         kjPZmuwwaWJfD8fF8GIXdCCcjZ37TDsIlsVEpXsObNOs4YnAF2DEP2QSRwbJyfNCYo
         UoXFM21VxIh/w==
Date:   Thu, 13 May 2021 08:02:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
Subject: Re: [PATCH v5 1/7] fsdax: Introduce dax_iomap_cow_copy()
Message-ID: <20210513150256.GA9675@magnolia>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511030933.3080921-2-ruansy.fnst@fujitsu.com>
 <20210512010810.GR8582@magnolia>
 <OSBPR01MB292062DA13D47BDBF3E2321BF4519@OSBPR01MB2920.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB292062DA13D47BDBF3E2321BF4519@OSBPR01MB2920.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 13, 2021 at 07:57:47AM +0000, ruansy.fnst@fujitsu.com wrote:
> > -----Original Message-----
> > From: Darrick J. Wong <djwong@kernel.org>
> > Subject: Re: [PATCH v5 1/7] fsdax: Introduce dax_iomap_cow_copy()
> > 
> > On Tue, May 11, 2021 at 11:09:27AM +0800, Shiyang Ruan wrote:
> > > In the case where the iomap is a write operation and iomap is not
> > > equal to srcmap after iomap_begin, we consider it is a CoW operation.
> > >
> > > The destance extent which iomap indicated is new allocated extent.
> > > So, it is needed to copy the data from srcmap to new allocated extent.
> > > In theory, it is better to copy the head and tail ranges which is
> > > outside of the non-aligned area instead of copying the whole aligned
> > > range. But in dax page fault, it will always be an aligned range.  So,
> > > we have to copy the whole range in this case.
> > >
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  fs/dax.c | 86
> > > ++++++++++++++++++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 81 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/dax.c b/fs/dax.c
> > > index bf3fc8242e6c..f0249bb1d46a 100644
> > > --- a/fs/dax.c
> > > +++ b/fs/dax.c
> > > @@ -1038,6 +1038,61 @@ static int dax_iomap_direct_access(struct iomap
> > *iomap, loff_t pos, size_t size,
> > >  	return rc;
> > >  }
> > >
> > > +/**
> > > + * dax_iomap_cow_copy(): Copy the data from source to destination before
> > write.
> > > + * @pos:	address to do copy from.
> > > + * @length:	size of copy operation.
> > > + * @align_size:	aligned w.r.t align_size (either PMD_SIZE or PAGE_SIZE)
> > > + * @srcmap:	iomap srcmap
> > > + * @daddr:	destination address to copy to.
> > > + *
> > > + * This can be called from two places. Either during DAX write fault,
> > > +to copy
> > > + * the length size data to daddr. Or, while doing normal DAX write
> > > +operation,
> > > + * dax_iomap_actor() might call this to do the copy of either start
> > > +or end
> > > + * unaligned address. In this case the rest of the copy of aligned
> > > +ranges is
> > > + * taken care by dax_iomap_actor() itself.
> > > + * Also, note DAX fault will always result in aligned pos and pos + length.
> > > + */
> > > +static int dax_iomap_cow_copy(loff_t pos, loff_t length, size_t
> > > +align_size,
> > 
> > Nit: Linus has asked us not to continue the use of loff_t for file io length.  Could
> > you change this to 'uint64_t length', please?
> > (Assuming we even need the extra length bits?)
> > 
> > With that fixed up...
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > 
> > --D
> > 
> > > +		struct iomap *srcmap, void *daddr)
> > > +{
> > > +	loff_t head_off = pos & (align_size - 1);
> > 
> > Other nit: head_off = round_down(pos, align_size); ?
> 
> We need the offset within a page here, either PTE or PMD.  So I think round_down() is not suitable here.

Oops, yeah.  /me wonders if any of Matthew's folio cleanups will reduce
the amount of opencoding around this...

--D

> 
> 
> --
> Thanks,
> Ruan Shiyang.
> 
> > 
> > > +	size_t size = ALIGN(head_off + length, align_size);
> > > +	loff_t end = pos + length;
> > > +	loff_t pg_end = round_up(end, align_size);
> > > +	bool copy_all = head_off == 0 && end == pg_end;
> > > +	void *saddr = 0;
> > > +	int ret = 0;
> > > +
> > > +	ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (copy_all) {
> > > +		ret = copy_mc_to_kernel(daddr, saddr, length);
> > > +		return ret ? -EIO : 0;
> > > +	}
> > > +
> > > +	/* Copy the head part of the range.  Note: we pass offset as length. */
> > > +	if (head_off) {
> > > +		ret = copy_mc_to_kernel(daddr, saddr, head_off);
> > > +		if (ret)
> > > +			return -EIO;
> > > +	}
> > > +
> > > +	/* Copy the tail part of the range */
> > > +	if (end < pg_end) {
> > > +		loff_t tail_off = head_off + length;
> > > +		loff_t tail_len = pg_end - end;
> > > +
> > > +		ret = copy_mc_to_kernel(daddr + tail_off, saddr + tail_off,
> > > +					tail_len);
> > > +		if (ret)
> > > +			return -EIO;
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > >  /*
> > >   * The user has performed a load from a hole in the file.  Allocating a new
> > >   * page in the file would cause excessive storage usage for workloads
> > > with @@ -1167,11 +1222,12 @@ dax_iomap_actor(struct inode *inode,
> > loff_t pos, loff_t length, void *data,
> > >  	struct dax_device *dax_dev = iomap->dax_dev;
> > >  	struct iov_iter *iter = data;
> > >  	loff_t end = pos + length, done = 0;
> > > +	bool write = iov_iter_rw(iter) == WRITE;
> > >  	ssize_t ret = 0;
> > >  	size_t xfer;
> > >  	int id;
> > >
> > > -	if (iov_iter_rw(iter) == READ) {
> > > +	if (!write) {
> > >  		end = min(end, i_size_read(inode));
> > >  		if (pos >= end)
> > >  			return 0;
> > > @@ -1180,7 +1236,12 @@ dax_iomap_actor(struct inode *inode, loff_t pos,
> > loff_t length, void *data,
> > >  			return iov_iter_zero(min(length, end - pos), iter);
> > >  	}
> > >
> > > -	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED))
> > > +	/*
> > > +	 * In DAX mode, we allow either pure overwrites of written extents, or
> > > +	 * writes to unwritten extents as part of a copy-on-write operation.
> > > +	 */
> > > +	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED &&
> > > +			!(iomap->flags & IOMAP_F_SHARED)))
> > >  		return -EIO;
> > >
> > >  	/*
> > > @@ -1219,6 +1280,13 @@ dax_iomap_actor(struct inode *inode, loff_t pos,
> > loff_t length, void *data,
> > >  			break;
> > >  		}
> > >
> > > +		if (write && srcmap->addr != iomap->addr) {
> > > +			ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
> > > +						 kaddr);
> > > +			if (ret)
> > > +				break;
> > > +		}
> > > +
> > >  		map_len = PFN_PHYS(map_len);
> > >  		kaddr += offset;
> > >  		map_len -= offset;
> > > @@ -1230,7 +1298,7 @@ dax_iomap_actor(struct inode *inode, loff_t pos,
> > loff_t length, void *data,
> > >  		 * validated via access_ok() in either vfs_read() or
> > >  		 * vfs_write(), depending on which operation we are doing.
> > >  		 */
> > > -		if (iov_iter_rw(iter) == WRITE)
> > > +		if (write)
> > >  			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
> > >  					map_len, iter);
> > >  		else
> > > @@ -1382,6 +1450,7 @@ static vm_fault_t dax_fault_actor(struct vm_fault
> > *vmf, pfn_t *pfnp,
> > >  	unsigned long entry_flags = pmd ? DAX_PMD : 0;
> > >  	int err = 0;
> > >  	pfn_t pfn;
> > > +	void *kaddr;
> > >
> > >  	/* if we are reading UNWRITTEN and HOLE, return a hole. */
> > >  	if (!write &&
> > > @@ -1392,18 +1461,25 @@ static vm_fault_t dax_fault_actor(struct
> > vm_fault *vmf, pfn_t *pfnp,
> > >  			return dax_pmd_load_hole(xas, vmf, iomap, entry);
> > >  	}
> > >
> > > -	if (iomap->type != IOMAP_MAPPED) {
> > > +	if (iomap->type != IOMAP_MAPPED && !(iomap->flags &
> > IOMAP_F_SHARED))
> > > +{
> > >  		WARN_ON_ONCE(1);
> > >  		return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
> > >  	}
> > >
> > > -	err = dax_iomap_direct_access(iomap, pos, size, NULL, &pfn);
> > > +	err = dax_iomap_direct_access(iomap, pos, size, &kaddr, &pfn);
> > >  	if (err)
> > >  		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
> > >
> > >  	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn, entry_flags,
> > >  				  write && !sync);
> > >
> > > +	if (write &&
> > > +	    srcmap->addr != IOMAP_HOLE && srcmap->addr != iomap->addr) {
> > > +		err = dax_iomap_cow_copy(pos, size, size, srcmap, kaddr);
> > > +		if (err)
> > > +			return dax_fault_return(err);
> > > +	}
> > > +
> > >  	if (sync)
> > >  		return dax_fault_synchronous_pfnp(pfnp, pfn);
> > >
> > > --
> > > 2.31.1
> > >
> > >
> > >
