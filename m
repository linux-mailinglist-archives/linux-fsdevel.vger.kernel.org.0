Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D71E33FE4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 05:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhCREpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 00:45:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhCREpR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 00:45:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F31364DFD;
        Thu, 18 Mar 2021 04:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616042716;
        bh=NZTHKERiXrJczJQILYuJif956gGdewRQMECPp1hCzj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ixgX6ve2EfTkoJ0Osc/gm/a0iFzrtFNcH+wJY1Hoj7slQUrCemgTeeJira9Odm9Wd
         pfUVZ6r2rudgdo1RNaCVibSz2iriejaRA+pp9tuR6RjgnqiWKC4TAmqMTPZoX4UqQY
         /T7tfJsxyP2DazBj9wTKoZ7Yn7szK5lXD2klcNDsSP53qrZImtUJumBCsMPvp4p6S4
         XVbRzIjRbvizBbPZ/BPjhjCJpVvI2YlnuxEXPps+SKVc5t9rYTFTzlBszq7rvQlWSg
         fyj8BCAsaBTmZfduPOkbfjosSZB5olwr2UsHnwaQVUPOVK9dUuyh5z9PfbGTBrdMTl
         lPgumWf6T7tAA==
Date:   Wed, 17 Mar 2021 21:45:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm, dax, pmem: Introduce dev_pagemap_failure()
Message-ID: <20210318044515.GC22094@magnolia>
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 09:08:23PM -0700, Dan Williams wrote:
> Jason wondered why the get_user_pages_fast() path takes references on a
> @pgmap object. The rationale was to protect against accessing a 'struct
> page' that might be in the process of being removed by the driver, but
> he rightly points out that should be solved the same way all gup-fast
> synchronization is solved which is invalidate the mapping and let the
> gup slow path do @pgmap synchronization [1].
> 
> To achieve that it means that new user mappings need to stop being
> created and all existing user mappings need to be invalidated.
> 
> For device-dax this is already the case as kill_dax() prevents future
> faults from installing a pte, and the single device-dax inode
> address_space can be trivially unmapped.
> 
> The situation is different for filesystem-dax where device pages could
> be mapped by any number of inode address_space instances. An initial
> thought was to treat the device removal event like a drop_pagecache_sb()
> event that walks superblocks and unmaps all inodes. However, Dave points
> out that it is not just the filesystem user-mappings that need to react
> to global DAX page-unmap events, it is also filesystem metadata
> (proposed DAX metadata access), and other drivers (upstream
> DM-writecache) that need to react to this event [2].
> 
> The only kernel facility that is meant to globally broadcast the loss of
> a page (via corruption or surprise remove) is memory_failure(). The
> downside of memory_failure() is that it is a pfn-at-a-time interface.
> However, the events that would trigger the need to call memory_failure()
> over a full PMEM device should be rare. Remove should always be
> coordinated by the administrator with the filesystem. If someone force
> removes a device from underneath a mounted filesystem the driver assumes
> they have a good reason, or otherwise get to keep the pieces. Since
> ->remove() callbacks can not fail the only option is to trigger the mass
> memory_failure().
> 
> The mechanism to determine whether memory_failure() triggers at
> pmem->remove() time is whether the associated dax_device has an elevated
> reference at @pgmap ->kill() time.
> 
> With this in place the get_user_pages_fast() path can drop its
> half-measure synchronization with an @pgmap reference.
> 
> Link: http://lore.kernel.org/r/20210224010017.GQ2643399@ziepe.ca [1]
> Link: http://lore.kernel.org/r/20210302075736.GJ4662@dread.disaster.area [2]
> Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/dax/super.c      |   15 +++++++++++++++
>  drivers/nvdimm/pmem.c    |   10 +++++++++-
>  drivers/nvdimm/pmem.h    |    1 +
>  include/linux/dax.h      |    5 +++++
>  include/linux/memremap.h |    5 +++++
>  include/linux/mm.h       |    3 +++
>  mm/memory-failure.c      |   11 +++++++++--
>  mm/memremap.c            |   11 +++++++++++
>  8 files changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 5fa6ae9dbc8b..5ebcedf4a68c 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -624,6 +624,21 @@ void put_dax(struct dax_device *dax_dev)
>  }
>  EXPORT_SYMBOL_GPL(put_dax);
>  
> +bool dax_is_idle(struct dax_device *dax_dev)
> +{
> +	struct inode *inode;
> +
> +	if (!dax_dev)
> +		return true;
> +
> +	WARN_ONCE(test_bit(DAXDEV_ALIVE, &dax_dev->flags),
> +		  "dax idle check on live device.\n");
> +
> +	inode = &dax_dev->inode;
> +	return atomic_read(&inode->i_count) < 2;
> +}
> +EXPORT_SYMBOL_GPL(dax_is_idle);
> +
>  /**
>   * dax_get_by_host() - temporary lookup mechanism for filesystem-dax
>   * @host: alternate name for the device registered by a dax driver
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index b8a85bfb2e95..e8822c9262ee 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -348,15 +348,21 @@ static void pmem_pagemap_kill(struct dev_pagemap *pgmap)
>  {
>  	struct request_queue *q =
>  		container_of(pgmap->ref, struct request_queue, q_usage_counter);
> +	struct pmem_device *pmem = q->queuedata;
>  
>  	blk_freeze_queue_start(q);
> +	kill_dax(pmem->dax_dev);
> +	if (!dax_is_idle(pmem->dax_dev)) {
> +		dev_warn(pmem->dev,
> +			 "DAX active at remove, trigger mass memory failure\n");
> +		dev_pagemap_failure(pgmap);
> +	}
>  }
>  
>  static void pmem_release_disk(void *__pmem)
>  {
>  	struct pmem_device *pmem = __pmem;
>  
> -	kill_dax(pmem->dax_dev);
>  	put_dax(pmem->dax_dev);
>  	del_gendisk(pmem->disk);
>  	put_disk(pmem->disk);
> @@ -406,6 +412,7 @@ static int pmem_attach_disk(struct device *dev,
>  	devm_namespace_disable(dev, ndns);
>  
>  	dev_set_drvdata(dev, pmem);
> +	pmem->dev = dev;
>  	pmem->phys_addr = res->start;
>  	pmem->size = resource_size(res);
>  	fua = nvdimm_has_flush(nd_region);
> @@ -467,6 +474,7 @@ static int pmem_attach_disk(struct device *dev,
>  	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
>  	if (pmem->pfn_flags & PFN_MAP)
>  		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
> +	q->queuedata = pmem;
>  
>  	disk = alloc_disk_node(0, nid);
>  	if (!disk)
> diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
> index 59cfe13ea8a8..1222088a569a 100644
> --- a/drivers/nvdimm/pmem.h
> +++ b/drivers/nvdimm/pmem.h
> @@ -23,6 +23,7 @@ struct pmem_device {
>  	struct badblocks	bb;
>  	struct dax_device	*dax_dev;
>  	struct gendisk		*disk;
> +	struct device		*dev;
>  	struct dev_pagemap	pgmap;
>  };
>  
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index b52f084aa643..015f1d9a8232 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -46,6 +46,7 @@ struct dax_device *alloc_dax(void *private, const char *host,
>  		const struct dax_operations *ops, unsigned long flags);
>  void put_dax(struct dax_device *dax_dev);
>  void kill_dax(struct dax_device *dax_dev);
> +bool dax_is_idle(struct dax_device *dax_dev);
>  void dax_write_cache(struct dax_device *dax_dev, bool wc);
>  bool dax_write_cache_enabled(struct dax_device *dax_dev);
>  bool __dax_synchronous(struct dax_device *dax_dev);
> @@ -92,6 +93,10 @@ static inline void put_dax(struct dax_device *dax_dev)
>  static inline void kill_dax(struct dax_device *dax_dev)
>  {
>  }
> +static inline bool dax_is_idle(struct dax_device *dax_dev)
> +{
> +	return true;
> +}
>  static inline void dax_write_cache(struct dax_device *dax_dev, bool wc)
>  {
>  }
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index f5b464daeeca..d52cdc6c5313 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -137,6 +137,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
>  void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
>  struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>  		struct dev_pagemap *pgmap);
> +void dev_pagemap_failure(struct dev_pagemap *pgmap);
>  bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
>  
>  unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
> @@ -160,6 +161,10 @@ static inline void devm_memunmap_pages(struct device *dev,
>  {
>  }
>  
> +static inline void dev_pagemap_failure(struct dev_pagemap *pgmap)
> +{
> +}
> +
>  static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>  		struct dev_pagemap *pgmap)
>  {
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 77e64e3eac80..95f79f457bab 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3002,8 +3002,11 @@ enum mf_flags {
>  	MF_ACTION_REQUIRED = 1 << 1,
>  	MF_MUST_KILL = 1 << 2,
>  	MF_SOFT_OFFLINE = 1 << 3,
> +	MF_MEM_REMOVE = 1 << 4,
>  };
>  extern int memory_failure(unsigned long pfn, int flags);
> +extern int memory_failure_dev_pagemap(unsigned long pfn, int flags,
> +				      struct dev_pagemap *pgmap);
>  extern void memory_failure_queue(unsigned long pfn, int flags);
>  extern void memory_failure_queue_kick(int cpu);
>  extern int unpoison_memory(unsigned long pfn);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 43ba4307c526..8f557beb19ee 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1296,8 +1296,8 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>  	return res;
>  }
>  
> -static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
> -		struct dev_pagemap *pgmap)
> +int memory_failure_dev_pagemap(unsigned long pfn, int flags,
> +			       struct dev_pagemap *pgmap)
>  {
>  	struct page *page = pfn_to_page(pfn);
>  	const bool unmap_success = true;
> @@ -1377,6 +1377,13 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  unlock:
>  	dax_unlock_page(page, cookie);
>  out:
> +	/*
> +	 * In the removal case, given unmap is always successful, and
> +	 * the driver is responsible for the direct map the recovery is
> +	 * always successful
> +	 */
> +	if (flags & MF_MEM_REMOVE)
> +		rc = 0;
>  	action_result(pfn, MF_MSG_DAX, rc ? MF_FAILED : MF_RECOVERED);
>  	return rc;
>  }
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 7aa7d6e80ee5..f34da1e14b52 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -165,6 +165,17 @@ static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
>  	pgmap_array_delete(range);
>  }
>  
> +void dev_pagemap_failure(struct dev_pagemap *pgmap)
> +{
> +	unsigned long pfn;
> +	int i;
> +
> +	for (i = 0; i < pgmap->nr_range; i++)
> +		for_each_device_pfn(pfn, pgmap, i)
> +			memory_failure_dev_pagemap(pfn, MF_MEM_REMOVE, pgmap);

So my 6TB memory chassis falls off the desk and we have to call
memory_failure_dev_pagemap for 1.6 billion PFNs?

Honestly if you're going offline the /entire/ device then just tell us
sb->memory_failure(dev, 0, -1ULL) and we'll just kill everything all at
once.  That was where I was trying to push Shiyang's patchset, and I had
nearly succeeded when you NAKd the whole thing.

In the meantime, I estimate that there are ~45 months worth of deferred
XFS patch review that I can make progress on, so that's where I'm going
to focus.

--D

> +}
> +EXPORT_SYMBOL_GPL(dev_pagemap_failure);
> +
>  void memunmap_pages(struct dev_pagemap *pgmap)
>  {
>  	unsigned long pfn;
> 
