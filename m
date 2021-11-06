Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F45446BFD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Nov 2021 03:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhKFCHl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Nov 2021 22:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbhKFCHk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Nov 2021 22:07:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDCB36108B;
        Sat,  6 Nov 2021 02:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636164300;
        bh=udtQy0yP6Y3MJL34Gk4eb5HwUbF+N1OWD9p36VtaM4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TiAKJRpdTC5hp4dGqZUhTGvsF/y8GQScz4MIO49Z8MKlK0RjAd+IBM95nMqMBv5vW
         kRGz1UhrO5HVVfAplk2il42P0v8qk8kNMA1x9ugniTwnAEuSEjdkQB87QnOenk12co
         6+WcIPQOgoH3mLRztJaXPN9UdPcOJ4L0lG4QcdYyMjCDmPEBytEYoYTCJR9Ci3fekN
         d/wCbUYWuUbvvO+9uwMELy8G70dXTj/IxQ0V9NRlfujmUrA1O5LS3M+sHZYCFbfFg6
         3S/SHsPqz2hsxlKKoUbzNm1Dv7jXgIkmXotuLYCxSodRjGR/cfJc90t/L53HymUPov
         SN4NjzZ/Hg2zw==
Date:   Fri, 5 Nov 2021 19:04:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, dan.j.williams@intel.com, hch@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dax,pmem: Implement pmem based dax data recovery
Message-ID: <20211106020459.GL2237511@magnolia>
References: <20211106011638.2613039-1-jane.chu@oracle.com>
 <20211106011638.2613039-3-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106011638.2613039-3-jane.chu@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 05, 2021 at 07:16:38PM -0600, Jane Chu wrote:
> For /dev/pmem based dax, enable DAX_OP_RECOVERY mode for
> dax_direct_access to translate 'kaddr' over a range that
> may contain poison(s); and enable dax_copy_to_iter to
> read as much data as possible up till a poisoned page is
> encountered; and enable dax_copy_from_iter to clear poison
> among a page-aligned range, and then write the good data over.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  drivers/md/dm.c       |  2 ++
>  drivers/nvdimm/pmem.c | 75 ++++++++++++++++++++++++++++++++++++++++---
>  fs/dax.c              | 24 +++++++++++---
>  3 files changed, 92 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index dc354db22ef9..9b3dac916f22 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1043,6 +1043,7 @@ static size_t dm_dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
>  	if (!ti)
>  		goto out;
>  	if (!ti->type->dax_copy_from_iter) {
> +		WARN_ON(mode == DAX_OP_RECOVERY);
>  		ret = copy_from_iter(addr, bytes, i);
>  		goto out;
>  	}
> @@ -1067,6 +1068,7 @@ static size_t dm_dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
>  	if (!ti)
>  		goto out;
>  	if (!ti->type->dax_copy_to_iter) {
> +		WARN_ON(mode == DAX_OP_RECOVERY);

Maybe just return -EOPNOTSUPP here?

Warnings are kinda loud.

>  		ret = copy_to_iter(addr, bytes, i);
>  		goto out;
>  	}
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 3dc99e0bf633..8ae6aa678c51 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -260,7 +260,7 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
>  	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
>  
>  	if (unlikely(is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512,
> -					PFN_PHYS(nr_pages))))
> +				 PFN_PHYS(nr_pages)) && mode == DAX_OP_NORMAL))
>  		return -EIO;
>  
>  	if (kaddr)
> @@ -303,20 +303,85 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
>  }
>  
>  /*
> - * Use the 'no check' versions of copy_from_iter_flushcache() and
> - * copy_mc_to_iter() to bypass HARDENED_USERCOPY overhead. Bounds
> - * checking, both file offset and device offset, is handled by
> - * dax_iomap_actor()
> + * Even though the 'no check' versions of copy_from_iter_flushcache()
> + * and copy_mc_to_iter() are used to bypass HARDENED_USERCOPY overhead,
> + * 'read'/'write' aren't always safe when poison is consumed. They happen
> + * to be safe because the 'read'/'write' range has been guaranteed
> + * be free of poison(s) by a prior call to dax_direct_access() on the
> + * caller stack.
> + * But on a data recovery code path, the 'read'/'write' range is expected
> + * to contain poison(s), and so poison(s) is explicit checked, such that
> + * 'read' can fetch data from clean page(s) up till the first poison is
> + * encountered, and 'write' requires the range be page aligned in order
> + * to restore the poisoned page's memory type back to "rw" after clearing
> + * the poison(s).
> + * In the event of poison related failure, (size_t) -EIO is returned and
> + * caller may check the return value after casting it to (ssize_t).
> + *
> + * TODO: add support for CPUs that support MOVDIR64B instruction for
> + * faster poison clearing, and possibly smaller error blast radius.

I get that it's still early days yet for whatever pmem stuff is going on
for 5.17, but I feel like this ought to be a separate function called by
pmem_copy_from_iter, with this huge comment attached to that recovery
function.

>   */
>  static size_t pmem_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
>  		void *addr, size_t bytes, struct iov_iter *i, int mode)
>  {
> +	phys_addr_t pmem_off;
> +	size_t len, lead_off;
> +	struct pmem_device *pmem = dax_get_private(dax_dev);
> +	struct device *dev = pmem->bb.dev;
> +
> +	if (unlikely(mode == DAX_OP_RECOVERY)) {
> +		lead_off = (unsigned long)addr & ~PAGE_MASK;
> +		len = PFN_PHYS(PFN_UP(lead_off + bytes));
> +		if (is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512, len)) {
> +			if (lead_off || !(PAGE_ALIGNED(bytes))) {
> +				dev_warn(dev, "Found poison, but addr(%p) and/or bytes(%#lx) not page aligned\n",
> +					addr, bytes);
> +				return (size_t) -EIO;
> +			}
> +			pmem_off = PFN_PHYS(pgoff) + pmem->data_offset;
> +			if (pmem_clear_poison(pmem, pmem_off, bytes) !=
> +						BLK_STS_OK)
> +				return (size_t) -EIO;

Looks reasonable enough to me, though you might want to restructure this
to reduce the amount of indent.

FWIW I dislike how is_bad_pmem mixes units (sector_t vs. bytes), that
was seriously confusing.  But I guess that's a weird quirk of the
badblocks API and .... ugh.

(I dunno, can we at least clean up the nvdimm parts and some day replace
the badblocks backend with something that can handle more than 16
records?  interval_tree is more than up to that task, I know, I use it
for xfs online fsck...)

> +		}
> +	}
> +
>  	return _copy_from_iter_flushcache(addr, bytes, i);
>  }
>  
>  static size_t pmem_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
>  		void *addr, size_t bytes, struct iov_iter *i, int mode)
>  {
> +	int num_bad;
> +	size_t len, lead_off;
> +	unsigned long bad_pfn;
> +	bool bad_pmem = false;
> +	size_t adj_len = bytes;
> +	sector_t sector, first_bad;
> +	struct pmem_device *pmem = dax_get_private(dax_dev);
> +	struct device *dev = pmem->bb.dev;
> +
> +	if (unlikely(mode == DAX_OP_RECOVERY)) {
> +		sector = PFN_PHYS(pgoff) / 512;
> +		lead_off = (unsigned long)addr & ~PAGE_MASK;
> +		len = PFN_PHYS(PFN_UP(lead_off + bytes));
> +		if (pmem->bb.count)
> +			bad_pmem = !!badblocks_check(&pmem->bb, sector,
> +					len / 512, &first_bad, &num_bad);
> +		if (bad_pmem) {
> +			bad_pfn = PHYS_PFN(first_bad * 512);
> +			if (bad_pfn == pgoff) {
> +				dev_warn(dev, "Found poison in page: pgoff(%#lx)\n",
> +					pgoff);
> +				return -EIO;
> +			}
> +			adj_len = PFN_PHYS(bad_pfn - pgoff) - lead_off;
> +			dev_WARN_ONCE(dev, (adj_len > bytes),
> +					"out-of-range first_bad?");
> +		}
> +		if (adj_len == 0)
> +			return (size_t) -EIO;

Uh, are we supposed to adjust bytes here or something?

--D

> +	}
> +
>  	return _copy_mc_to_iter(addr, bytes, i);
>  }
>  
> diff --git a/fs/dax.c b/fs/dax.c
> index bea6df1498c3..7640be6b6a97 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1219,6 +1219,8 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  		unsigned offset = pos & (PAGE_SIZE - 1);
>  		const size_t size = ALIGN(length + offset, PAGE_SIZE);
>  		const sector_t sector = dax_iomap_sector(iomap, pos);
> +		long nr_page = PHYS_PFN(size);
> +		int dax_mode = DAX_OP_NORMAL;
>  		ssize_t map_len;
>  		pgoff_t pgoff;
>  		void *kaddr;
> @@ -1232,8 +1234,13 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  		if (ret)
>  			break;
>  
> -		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
> -					    DAX_OP_NORMAL, &kaddr, NULL);
> +		map_len = dax_direct_access(dax_dev, pgoff, nr_page, dax_mode,
> +					    &kaddr, NULL);
> +		if (unlikely(map_len == -EIO)) {
> +			dax_mode = DAX_OP_RECOVERY;
> +			map_len = dax_direct_access(dax_dev, pgoff, nr_page,
> +						    dax_mode, &kaddr, NULL);
> +		}
>  		if (map_len < 0) {
>  			ret = map_len;
>  			break;
> @@ -1252,11 +1259,20 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  		 */
>  		if (iov_iter_rw(iter) == WRITE)
>  			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
> -					map_len, iter, DAX_OP_NORMAL);
> +					map_len, iter, dax_mode);
>  		else
>  			xfer = dax_copy_to_iter(dax_dev, pgoff, kaddr,
> -					map_len, iter, DAX_OP_NORMAL);
> +					map_len, iter, dax_mode);
>  
> +		/*
> +		 * If dax data recovery is enacted via DAX_OP_RECOVERY,
> +		 * recovery failure would be indicated by a -EIO return
> +		 * in 'xfer' casted as (size_t).
> +		 */
> +		if ((ssize_t)xfer == -EIO) {
> +			ret = -EIO;
> +			break;
> +		}
>  		pos += xfer;
>  		length -= xfer;
>  		done += xfer;
> -- 
> 2.18.4
> 
