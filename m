Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99222446BF5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Nov 2021 02:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhKFBxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Nov 2021 21:53:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhKFBxj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Nov 2021 21:53:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D69C60EB4;
        Sat,  6 Nov 2021 01:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636163459;
        bh=rpOcXnWSUmVKzzXLpflw50nbOFXfmJxfdC+KnPlQpyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQ5W2mRsw5LD9K80NmeUOizywzcwOOH/JFSdJ0kwNtMYgt60XTFns8LZPvx1pUdto
         DfZROIN6RFG1asW8W828qYCE26U9q/ZNaRntLuJBzcoSJDSPqG7Jrwt9VOyvHBoEqk
         V+GgnFBwOD40fvzZksUiH0hL4GjZPOG86hu8V0ILOyaN39NdiVpEKvdVn9LijfoikD
         k9Q0n/UzDUtNvWBNTmwOEX7sovgy1YGviCzJkR3K9CEg8LAHt6jwr1N2ZkX8HZuVzu
         Uo0+TKC7cEU2C0nBcUrFLyNTrXaPJ/GQvaSOuiJBrmNjwP7FtfcFKf/DtfDsTJiix2
         xijB92K3uGh+A==
Date:   Fri, 5 Nov 2021 18:50:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, dan.j.williams@intel.com, hch@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dax: Introduce normal and recovery dax operation
 modes
Message-ID: <20211106015058.GK2237511@magnolia>
References: <20211106011638.2613039-1-jane.chu@oracle.com>
 <20211106011638.2613039-2-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106011638.2613039-2-jane.chu@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 05, 2021 at 07:16:37PM -0600, Jane Chu wrote:
> Introduce DAX_OP_NORMAL and DAX_OP_RECOVERY operation modes to
> {dax_direct_access, dax_copy_from_iter, dax_copy_to_iter}.
> DAX_OP_NORMAL is the default or the existing mode, and
> DAX_OP_RECOVERY is a new mode for data recovery purpose.
> 
> When dax-FS suspects dax media error might be encountered
> on a read or write, it can enact the recovery mode read or write
> by setting DAX_OP_RECOVERY in the aforementioned APIs. A read
> in recovery mode attempts to fetch as much data as possible
> until the first poisoned page is encountered. A write in recovery
> mode attempts to clear poison(s) in a page-aligned range and
> then write the user provided data over.
> 
> DAX_OP_NORMAL should be used for all non-recovery code path.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  drivers/dax/super.c             | 15 +++++++++------
>  drivers/md/dm-linear.c          | 14 ++++++++------
>  drivers/md/dm-log-writes.c      | 19 +++++++++++--------
>  drivers/md/dm-stripe.c          | 14 ++++++++------
>  drivers/md/dm-target.c          |  2 +-
>  drivers/md/dm-writecache.c      |  8 +++++---
>  drivers/md/dm.c                 | 14 ++++++++------
>  drivers/nvdimm/pmem.c           | 11 ++++++-----
>  drivers/nvdimm/pmem.h           |  2 +-
>  drivers/s390/block/dcssblk.c    | 13 ++++++++-----
>  fs/dax.c                        | 14 ++++++++------
>  fs/fuse/dax.c                   |  4 ++--
>  fs/fuse/virtio_fs.c             | 12 ++++++++----
>  include/linux/dax.h             | 18 +++++++++++-------
>  include/linux/device-mapper.h   |  5 +++--
>  tools/testing/nvdimm/pmem-dax.c |  2 +-
>  16 files changed, 98 insertions(+), 69 deletions(-)
> 

<snip>

> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 324363b798ec..931586df2905 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -9,6 +9,10 @@
>  /* Flag for synchronous flush */
>  #define DAXDEV_F_SYNC (1UL << 0)
>  
> +/* dax operation mode dynamically set by caller */
> +#define	DAX_OP_NORMAL		0
> +#define	DAX_OP_RECOVERY		1

Mostly looks ok to me, but since this is an operation mode, should this
be an enum instead of an int?

Granted I also think six arguments is a lot... though I don't really
see any better way to do this.

(Dunno, I spent all day running internal patches through the process
gauntlet so this is the remaining 2% of my brain speaking...)

--D

> +
>  typedef unsigned long dax_entry_t;
>  
>  struct dax_device;
> @@ -22,8 +26,8 @@ struct dax_operations {
>  	 * logical-page-offset into an absolute physical pfn. Return the
>  	 * number of pages available for DAX at that pfn.
>  	 */
> -	long (*direct_access)(struct dax_device *, pgoff_t, long,
> -			void **, pfn_t *);
> +	long (*direct_access)(struct dax_device *, pgoff_t, long, int,
> +				void **, pfn_t *);
>  	/*
>  	 * Validate whether this device is usable as an fsdax backing
>  	 * device.
> @@ -32,10 +36,10 @@ struct dax_operations {
>  			sector_t, sector_t);
>  	/* copy_from_iter: required operation for fs-dax direct-i/o */
>  	size_t (*copy_from_iter)(struct dax_device *, pgoff_t, void *, size_t,
> -			struct iov_iter *);
> +			struct iov_iter *, int);
>  	/* copy_to_iter: required operation for fs-dax direct-i/o */
>  	size_t (*copy_to_iter)(struct dax_device *, pgoff_t, void *, size_t,
> -			struct iov_iter *);
> +			struct iov_iter *, int);
>  	/* zero_page_range: required operation. Zero page range   */
>  	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
>  };
> @@ -186,11 +190,11 @@ static inline void dax_read_unlock(int id)
>  bool dax_alive(struct dax_device *dax_dev);
>  void *dax_get_private(struct dax_device *dax_dev);
>  long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
> -		void **kaddr, pfn_t *pfn);
> +		int mode, void **kaddr, pfn_t *pfn);
>  size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
> -		size_t bytes, struct iov_iter *i);
> +		size_t bytes, struct iov_iter *i, int mode);
>  size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
> -		size_t bytes, struct iov_iter *i);
> +		size_t bytes, struct iov_iter *i, int mode);
>  int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>  			size_t nr_pages);
>  void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index a7df155ea49b..6596a8e0ceed 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -146,9 +146,10 @@ typedef int (*dm_busy_fn) (struct dm_target *ti);
>   * >= 0 : the number of bytes accessible at the address
>   */
>  typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
> -		long nr_pages, void **kaddr, pfn_t *pfn);
> +		long nr_pages, int mode, void **kaddr, pfn_t *pfn);
>  typedef size_t (*dm_dax_copy_iter_fn)(struct dm_target *ti, pgoff_t pgoff,
> -		void *addr, size_t bytes, struct iov_iter *i);
> +		void *addr, size_t bytes, struct iov_iter *i,
> +		int mode);
>  typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
>  		size_t nr_pages);
>  
> diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-dax.c
> index af19c85558e7..71c225630e7e 100644
> --- a/tools/testing/nvdimm/pmem-dax.c
> +++ b/tools/testing/nvdimm/pmem-dax.c
> @@ -8,7 +8,7 @@
>  #include <nd.h>
>  
>  long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
> -		long nr_pages, void **kaddr, pfn_t *pfn)
> +		long nr_pages, int mode, void **kaddr, pfn_t *pfn)
>  {
>  	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
>  
> -- 
> 2.18.4
> 
